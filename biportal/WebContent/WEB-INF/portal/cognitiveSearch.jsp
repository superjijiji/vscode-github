<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>Cognitive BI@IBM</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
</head>

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>

	<script type="text/javascript">
		jQuery("#ibm-com").css("backgroundColor", "white");

		var path = '<%=request.getContextPath()%>';
		//
		var cwa_id = '${requestScope.cwa_id}';
		var searchType = '${requestScope.searchType}';
		var domains = '${requestScope.domains}';
		var fields = '${requestScope.fields}';
		var keywords = decodeURIComponent('<%=URLEncoder.encode(request.getAttribute("keywords").toString(),"utf-8")%>').replace(/\+/g,' ');
		var page = '${requestScope.page}';
		var page_row = '${requestScope.page_row}';
		var domainList = '${requestScope.domainList}';
		function search(){
			var searchType = jQuery("#id_search_searchType").val();
			var domains = jQuery("#id_search_domains").val();
			var fields = jQuery("#id_search_fields").val();
			var keywords = jQuery("#id_search_keywords").val();
			var page = jQuery("#id_search_page").val();
			var page_row = jQuery("#id_search_page_row").val();
			if(keywords==null||jQuery.trim(keywords)==''){
				return false;
			}
			//keywords = encodeURI(kerwords);
			//alert(keywords);
			var href=path+'/action/admin/cognitive/search?domains='+domains+'&fields='+fields+'&keywords='+encodeURI(keywords)+'&page=1&page_row='+page_row;
			if(searchType=='basic'){
				href+='&searchType=advanced';
				window.location.href=href;
			}else if(searchType=='advanced'){
				href+='&searchType=advanced';
				window.location.href=href;
			}else{
				href+='&searchType=advanced';
				window.open(href);
			}
		}
		function setPreference(){
			var href="<%=request.getContextPath()%>/action/cognitive/preferences";
			var keywords = jQuery("#id_search_keywords").val();
			href +="?keywords="+encodeURI(keywords);
			window.location.href=href;
		}
	</script>
	<div class="ibm-columns">
		<div class="ibm-col-1-1 ibm-right">
			<a href="#" onClick="setPreference();return false;" style="color: black; text-align: right">Search settings</a>
		</div>
		<div class="ibm-col-1-1 ibm-center">
		
			<h1 class="ibm-h1 ibm-padding-top-2" id="ibm-pagetitle-h1">Please find the reports and update...</h1>
			<h2 class="ibm-space-small ibm-padding-top-1">To browse matching reports please enter your search terms below and then Click 'Go'</h2>

			<form id="searchForm" class="ibm-form" onSubmit="search();return false;">
				<input id="id_search_cwa_id" name="cwa_id" value='${requestScope.cwa_id}' type="hidden" />
				<input id="id_search_searchType" name="searchType" value='${requestScope.searchType}' type="hidden" />
				<input id="id_search_domains" name="domains" value='${requestScope.domains}' type="hidden" />
				<input id="id_search_fields" name="fields" value='${requestScope.fields}' type="hidden" />
				<input id="id_search_page" name="page" value='${requestScope.page}' type="hidden" />
				<input id="id_search_page_row" name="page_row" value='${requestScope.page_row}' type="hidden"/>
				<div>
					<input id="id_search_keywords" style="width: 40%; height: 32px" type="text" name="keywords" size="300" maxlength="300" value="" placeholder="Please input report name..." /> 
					<input id="id_search_button" class="ibm-btn-pri ibm-btn-blue-50" type="button" onclick="search(); return false;" value="GO" />					
				</div>

			</form>
		</div>
	</div>

	<br>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>

</body>
</html>