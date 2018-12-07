<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String domains = (String)request.getAttribute("domains");	
	String fields = (String)request.getAttribute("fields");
	String page_row = (String)request.getAttribute("page_row");
	String keywords = (String)request.getAttribute("keywords");
	net.sf.json.JSONArray domainList = (net.sf.json.JSONArray)request.getAttribute("domainList");
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>Search settings</title>
</head>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<style type="text/css">
td.details-control {
	background: url('<%=path%>/images/details_open.png') no-repeat center
		center;
	cursor: pointer;
}

tr.shown td.details-control {
	background: url('<%=path%>/images/details_close.png') no-repeat center
		center;
}
</style>

<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>  -->

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>

	<script type="text/javascript" src="<%=path%>/javascript/reportmodel.js"></script>
	
	<script type="text/javascript">
	var domainList = ${requestScope.domainList};
	var path = '<%=request.getContextPath()%>';
	var keywords = decodeURIComponent('<%=URLEncoder.encode(request.getAttribute("keywords").toString(),"utf-8")%>').replace(/\+/g,' ');
	//
	function cancel(){
		search();
	}
	
	function savePreference(){
		var domains = '';
		jQuery('input[name="search_domains"]:checked').each(
				function(){
					domains += jQuery(this).val()+',';					
				}
		
		);
		if(domains==''||domains==undefined){
			alert('please choose at least one domain to search report');
			domains='ALL';
			return false;			
		}
		setCookie("domains",domains,365);
		var fields = jQuery('#id_fields').val();
		setCookie("fields",fields,365);
		var page_row = jQuery('#id_page_row').val();
		setCookie("page_row",page_row,365);
		//
		search();
		//
	}
	//
	function setCookie(name,value,expirationDays){
		var edate = new Date();
		edate.setDate(edate.getDate()+expirationDays);
		document.cookie=name+"="+escape(value)+";expires="+edate.toGMTString();	
	}
	//
	function search(){
		//var keywords = jQuery("#id_keywords").val();
		var searchType = 'basic';
		if(keywords==null||keywords==undefined||keywords==""){
			searchType = 'basic';
		} else {
			searchType = 'advanced';
		}
		var href=path+'/action/admin/cognitive/search?keywords='+encodeURI(keywords)+'&page=1&searchType='+searchType;
		window.location.href=href;
	}
	</script>
	
	
	<form id="searchPreferenceForm" class="ibm-form" >
	<div class="ibm-fluid ibm-seamless ibm-flex ibm-flex--wrap">

		<div class="ibm-col-12-3 ibm-right">
			<label for="id_domains"><span class="ibm-h3 ibm-padding-top-2">Search domains:&nbsp</span></label>
		</div>
		<div class="ibm-col-12-3 ibm-left" id="id_domains">
			<br/><hr>
			<table id="id_domains_table">
			<thead>
			
			<tr>
			<th>
			Domain Name
			</th>
			<th>
			Search
			</th>			
			</tr>			
			</thead>
			
			<tbody>
			<% 
			
			if(domainList.size()>0){
			%>
			<%="<tr><td colspan=\"2\"><hr></td></tr>" %>
			<%
				for (int i=0;i<domainList.size();i++) {
					JSONObject jsonObject = domainList.getJSONObject(i);					
					String domainKey = jsonObject.getString("DOMAIN_KEY");
					String domainName = jsonObject.getString("DISPLAY_NAME");
					//
					boolean check = false;					
					if("ALL".equals(domains)){
						check = true;
					}else{
						if(domains.indexOf(domainKey+",")>-1){
							check = true;
						}else{
							check = false;
						}
					}
					//
					String tr = "<tr>";
					tr +="<td>"+domainName+"&nbsp&nbsp&nbsp&nbsp</td>";
					tr +="<td><span class=\"ibm-checkbox-wrapper\">";
					tr +="<input class=\"ibm-styled-checkbox\" id=\"id_search_"+domainKey+"\" name=\"search_domains\" type=\"checkbox\" value=\""+domainKey+"\" "+(check?"checked":"")+" />";
					tr +="<label for=\"id_search_"+domainKey+"\" class=\"ibm-field-label\"></label>";
					tr +="</td>";
					tr += "</tr>";
			%>
			<%=tr %>
			<%
				}
			}
			
			%>
			</tbody>
			</table>
			<br/><hr>
		</div>
		<div class="ibm-col-12-6 ibm-left">
			<input type="button" value="Save" class="ibm-btn-pri ibm-btn-blue-50" onClick="savePreference();return false;"/>
			<input type="button" value="Cancel" class="ibm-btn-pri ibm-btn-blue-50" onClick="cancel();return false;"/>
		</div>	
		<div class="ibm-col-12-3 ibm-right">
			<label for="id_fields"><span class="ibm-h3 ibm-padding-top-2">Search fields:&nbsp</span></label>
		</div>
		<div class="ibm-col-12-9 ibm-left">
			<select name="fields" id="id_fields" value="${requestScope.fields}">
			<option value="reportName" <%=(fields.equals("reportName")?"selected":"") %>>Name</option>
			<option value="reportDescription" <%=(fields.equals("reportDescription")?"selected":"") %>>Description</option>
			<option value="reportPackage" <%=(fields.equals("reportPackage")?"selected":"") %>>Package</option>			
			<option value="searchPath" <%=(fields.equals("searchPath")?"selected":"") %>>Path</option>
			<option value="triggers" <%=(fields.equals("triggers")?"selected":"") %>>Trigger</option>
			<option value="tbsEnabled" <%=(fields.equals("tbsEnabled")?"selected":"") %>>Schedule</option>
			</select>
		</div>
	
		<div class="ibm-col-12-3 ibm-right">
			<label for="id_page_row"><span class="ibm-h3 ibm-padding-top-2">Results per page:&nbsp<span></label>
		</div>
		<div class="ibm-col-12-9 ibm-left">
			<select name="page_row" id="id_page_row" value="${requestScope.page_row}">
			<option value="10" <%=(page_row.equals("10")?"selected":"") %>>10</option>
			<option value="20" <%=(page_row.equals("20")?"selected":"") %>>20</option>
			<option value="50" <%=(page_row.equals("50")?"selected":"") %>>50</option>
			<option value="100" <%=(page_row.equals("100")?"selected":"") %>>100</option>
			</select>		
		</div>
		<!-- 
		<div class="ibm-col-12-3 ibm-right">
			<label for="id_search_history"><span class="ibm-h3 ibm-padding-top-2">Search history:&nbsp<span></label>
		</div>
		<div class="ibm-col-12-9 ibm-left" id="id_search_history">
			<select name="history_show" value="${requestScope.page_row}">
			<option value="5" <%=(page_row.equals("5")?"selected":"") %>>5</option>
			<option value="10" <%=(page_row.equals("10")?"selected":"") %>>10</option>
			<option value="20" <%=(page_row.equals("20")?"selected":"") %>>20</option>
			</select>
		</div>
 		-->
	</div>
	</form>
	<!-- =================== report search results List - END =================== -->

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>

</body>
</html>
