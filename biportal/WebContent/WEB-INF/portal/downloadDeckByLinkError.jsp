<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<jsp:include page="/WEB-INF/include/v18include.jsp">
</jsp:include>
<title>BI@IBM - AutoDeck Downloading Error</title>

</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>

	<br>
	<div class="ibm-card__content" align="left">
	Error Message: <br/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${errorMSG}
	</div>
	
	<br>
	<br>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>







