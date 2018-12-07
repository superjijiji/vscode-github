<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en-US">
<body>
<head>
<meta charset="UTF-8">
<title>${title}</title>
<script language="JavaScript" type="text/javascript"
	src="<%=request.getContextPath()%>/javascript/cognoslaunch.js"></script>
</head>
<body>
	<c:set var="contentType" value="${contentType}"></c:set>
	<c:if test="${contentType=='script'}">
		<script language="JavaScript" type="text/javascript">${script}</script>
	</c:if>
	<c:if test="${contentType=='text'}">
		<div>${content}</div>
	</c:if>
</body>
</html>
