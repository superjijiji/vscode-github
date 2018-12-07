<%@ page language="java" contentType="text/html;charset=UTF-8"
	isErrorPage="true" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays"%>
<%response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);%>
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
		<strong class="ibm-h4">Sorry we can't open <%=request.getAttribute("javax.servlet.forward.request_uri") %></strong>
		<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
			<hr>
		</div>
		Opps!<br>
		<%= Arrays.toString(exception.getStackTrace()).replaceAll(",", "<br>")  %>
	</div>
	<br>
	<br>
	<br>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>
