<%@ page import="vn.edu.hcmuaf.fit.laptrinhweb.controller.web.Asset" %>
<%@include file="/common/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
	<link rel="stylesheet" href="<%= Asset.url("/template/web/css/profileAccount.css")%>" />
	<!-- Custom StyleSheet -->
	<title>Invoice</title>
	<style>
		.container-popup{
			background-color: white;
			width: 70%;
			height: 50%;
			margin: 150px auto auto;
			padding: 28px;
		}

		.container-popup h2 {
			text-align: center;
			font-size: 28px;
		}

		.publicKeyBlock {
			padding: 15px 0;
		}

		.width100 {
			flex: 0 0 100%;
			max-width: 100%;
		}

		.buttonBottom {
			margin-top: 42px;
			display: flex;
			justify-content: space-between;
		}

		.buttonBottom > * {
			padding: 5px 10px;
			border-radius: 5px !important;
			color: #0e784d;
			border-color: #0e784d;
			background-color: transparent;
			border: 2px solid #0e784d;
		}

		.buttonBottom > *:hover {
			background-color: #0e784d;
			color: white;
		}
		.modal-import {
			display: block;
			position: fixed;
			max-width: 100%;
			width: 100%;
			z-index: 1050;
			background-color: rgba(0, 0, 0, 0.4);
			margin: auto;
			padding-top: 6%;
			overflow: auto;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			outline: 0;
		}
	</style>
</head>

<body>
<div class="container modal-import">
	<div class="container-popup">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<h2>Import Your Public Key</h2>
			</div>
			<div class="col-md-6 col-sm-6 col-xs-12 width100">
				<form role="form" class="ng-pristine ng-valid">
					<div class="form-group publicKeyBlock">
						<textarea id="publicKey" class="form-control input-lg ng-pristine ng-valid ng-touched" rows="5" placeholder="Public key will appear here." name="publicKey"></textarea>
						<button type="button" onclick="importPublicKey()">Import</button>
					</div>
				</form>
			</div>
		</div>
		<%--		upload file pdf--%>
		<form method="post" action="${pageContext.request.contextPath}/upload-invoice" enctype="multipart/form-data">
			<div class="buttonBottom">
				<button type="button" onclick="closeInvoicePopup()">Close</button>
				<button type="button" onclick="saveKey()">Save Public Key</button>
			</div>
		</form>
	</div>
</div>

<script>
	let isImportPublicKey = false;

	function importPublicKey(){
		isImportPublicKey = true;
	}
	function saveKey(){
		let check = confirm("YOU MUST DOWNLOAD PRIVATE KEY! SYSTEM IS NOT PERMISSION SAVE YOUR PRIVATE KEY!");
		if(check){
			//save key
		}
	}

	function closeInvoicePopup(){
		document.querySelectorAll(".modal-import").forEach(a=>a.style.display = "none");
	}
	async function screenLoader_Global() {
		$('<div class="loader-mask"><div class="loader"></div></div>').appendTo('body');
	}

	async function remove_screenLoader_Global() {
		$('.loader-mask').remove();
	}

</script>
</body>
</html>
