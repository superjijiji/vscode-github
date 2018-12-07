<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<!-- ================================================================= custom page JS and CSS start -->
<title>BI@IBM | Help for control book ${controlBookName} </title>
<!-- ================================================================= custom page JS and CSS end -->
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<div class="ibm-columns">
		<div class="ibm-col-1-1">
			<!-- ================================================================= custom page contents start -->
			<h1 id="ibm-pagetitle-h1" class="ibm-h1 ibm-padding-top-0 ibm-light">Help for control book ${controlBookName}</h1>
			<p> 
				${controlBook.ctrlbookDesc} <br/>
				<ul>
					<li><span style="font-weight: bold;">Target Audience: </span>${controlBook.targetAud}</li>
					<li><span style="font-weight: bold;">Purpose: </span>${controlBook.purpose}</li>
					<li><span style="font-weight: bold;">How to request access: </span>${controlBook.requestAccess}</li>
					<li><span style="font-weight: bold;">Support Contact: </span>${controlBook.supportContact}</li>
				</ul>
			</p>
			<!-- ================================================================= custom page contents end -->
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>