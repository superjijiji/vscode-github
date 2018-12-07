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
<title>BI@IBM - My recent TBS outputs</title>

<style type="text/css">
/**
*Remove sorting arrows
*/
table.dataTable thead .sorting, table.dataTable thead .sorting_asc,
	table.dataTable thead .sorting_desc {
	background: none;
}
</style>

</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>

	<br>
	<div class="ibm-card__content" align="left">

		<c:if test="${reportName != null && reportName !='null'}">
			<strong class="ibm-h4"> Report Name:&nbsp;&nbsp;
				${reportName} </strong>
			<br>
			<br>
		</c:if>

		<c:if test="${emailSubject != null && emailSubject !='null'}">
			<strong class="ibm-h4"> Email Subject:&nbsp;&nbsp;
				${emailSubject}</strong>
			<br>
			<br>
		</c:if>
		<strong class="ibm-h4"> Reason:&nbsp;&nbsp; ${ErrorMsg}</strong>
	</div>
	<br>
	<br>
	<br>
	<br>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>







