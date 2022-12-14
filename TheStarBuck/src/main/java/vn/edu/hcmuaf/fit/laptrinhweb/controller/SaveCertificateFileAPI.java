package vn.edu.hcmuaf.fit.laptrinhweb.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.bouncycastle.asn1.x509.SubjectPublicKeyInfo;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.openssl.PEMException;
import org.bouncycastle.openssl.PEMParser;
import org.bouncycastle.openssl.jcajce.JcaPEMKeyConverter;
import org.bouncycastle.pkcs.PKCS10CertificationRequest;
import vn.edu.hcmuaf.fit.laptrinhweb.model.Account;
import vn.edu.hcmuaf.fit.laptrinhweb.model.GenderKeyStore;
import vn.edu.hcmuaf.fit.laptrinhweb.model.MyCertificate;
import vn.edu.hcmuaf.fit.laptrinhweb.model.MyPairKey;
import vn.edu.hcmuaf.fit.laptrinhweb.service.impl.PublicKeyService;

import java.io.*;
import java.nio.file.Paths;
import java.security.PublicKey;
import java.security.Security;
import java.sql.Timestamp;
import java.util.Base64;


@WebServlet(name = "SaveCertificateFileAPI",urlPatterns = {"/save-certificate"})
@MultipartConfig(maxFileSize = 16177215)
public class SaveCertificateFileAPI extends HttpServlet {
    PublicKeyService publicKeyService = PublicKeyService.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BouncyCastleProvider provider = new BouncyCastleProvider();
        Security.addProvider(provider);
        HttpSession httpSession = req.getSession();
        Account acc = (Account) httpSession.getAttribute("account");
        if (acc != null) {
            InputStream inputStream = null; // input stream of the upload file
            // obtains the upload file part in this multipart request
            Part filePart = req.getPart("data-certificate");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (filePart != null) {
                // obtains input stream of the upload file
                inputStream = filePart.getInputStream();
                InputStream imageStream = filePart.getInputStream();
                byte[] resultBuff = new byte[0];
                byte[] buff = new byte[1024];
                int k = -1;
                while ((k = imageStream.read(buff, 0, buff.length)) > -1) {
                    byte[] tbuff = new byte[resultBuff.length + k]; // temp buffer size
                    System.arraycopy(resultBuff, 0, tbuff, 0, resultBuff.length); // copy
                    System.arraycopy(buff, 0, tbuff, resultBuff.length, k); // copy
                    resultBuff = tbuff; // call the temp buffer as your result buff
                }
                inputStream = new ByteArrayInputStream(resultBuff);
            }
            MyPairKey myPairKey = new MyPairKey();
            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                MyCertificate myCertificate = new MyCertificate();
                myCertificate.setKeyID("");
                myCertificate.setAccountID(acc.getId());
                Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                myCertificate.setStartDate(timestamp.getTime());
                myCertificate.setEndDate(0l);
                myCertificate.setData(inputStream);
                if(publicKeyService.getCertificateByStatus(acc.getId(),MyCertificate.SELECTED).size()==0){
                    myCertificate.setStatus(MyCertificate.SELECTED);
                }else
                myCertificate.setStatus(MyCertificate.AVAILABLE);
                publicKeyService.create(myCertificate);

                if (myPairKey != null) {
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("utf-8");
                    String json = new Gson().toJson("Save to database is succcessful");
                    PrintWriter out = resp.getWriter();
                    try {
                        out.println(json);
                    } finally {
                        out.close();
                    }
                } else
                    System.err.println("ERROR!");
            }
        }
    }
}
