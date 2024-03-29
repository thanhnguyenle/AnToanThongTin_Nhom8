<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 3/1/2022
  Time: 9:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="vn.edu.hcmuaf.fit.laptrinhweb.controller.web.Asset" %>
<%@ include file="/common/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>List User</title>
    <jsp:include page="layout/css.jsp"/>
</head>

<body>

<div id="wrapper">
    <jsp:include page="layout/header.jsp"/>
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">User Tables</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Data User
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                <tr>
                                    <th>id</th>
                                    <th>username</th>
                                    <th>fullname</th>
                                    <th>active</th>
                                    <th>phone number</th>
                                    <th>email</th>
                                    <th>Operation</th>
                                </tr>
                                </thead>
                                <tbody>
                            <jsp:useBean id="accs" scope="request" type="java.util.List"/>
                            <c:forEach items="${accs}" var="item">
                                <tr class="odd gradeX">
                                    <td>${item.id}</td>
                                    <td>${item.username}</td>
                                    <td>${item.fullname}</td>
                                    <td>${item.active}</td>
                                    <td class="center">${item.phoneNumber}</td>
                                    <td class="center">${item.email}</td>
                                    <td class=" text-center">
                                        <a href="<%=request.getContextPath()%>/deleteAccount?id=${item.id}" class="btn btn-danger" data-toggle="modal"
                                           data-target="#deleteObject" >Delete</a>
<%-- //input hidden,  name = id                                       --%>
                                        <a href="<%=request.getContextPath()%>/updateAccount?id=${item.id}" target="_blank" class="btn btn-info">Edit</a>
                                    </td>
                                </tr>
                            </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <p id="commonModal"></p>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
<%--model delete--%>
<form class="modal fade" id="deleteObject" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" method="post"
      aria-hidden="true" action="${pageContext.request.contextPath}/deleteAccount">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="exampleModalLabel">Notify</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Delete</button>
            </div>
        </div>
    </div>
</form>
<%--SCRIPT--%>
<jsp:include page="layout/script.jsp"/>
<!-- Page-Level Demo Scripts - Tables - Use for reference -->
<script>
    $(document).ready(function () {
        $('#dataTables-example').dataTable();
    });
    jQuery(function (){
        url = "/api/account?action=get";
        $.ajax({
            type: "GET",
            url: url,
            data: {},
            dataType: "json",
            contentType: "application/json",
            success: function (data){
                console.log(data);
            }
        })
    })
</script>
<script src="${pageContext.request.contextPath}/template/admin/js/commonHtml.js"></script>
</body>

</html>
