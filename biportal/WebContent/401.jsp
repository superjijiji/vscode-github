<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-card__content">
		<strong class="ibm-h4">Sorry you are not authorized.</strong>
		<br >
		<span class="ibm-rule">  <%=request.getSession().getAttribute("errMsg") %>  </span>
	</div>
	<br>
	<br>
	<br>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>