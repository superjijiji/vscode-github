<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>

	<form>
		<input type="hidden" id="reportsearch_action"
			name="reportsearch_action" value="${reportsearch_action}" /> <input
			type="hidden" id="reportsearch_cwa_id" name="reportsearch_cwa_id"
			value="${reportsearch_cwa_id}" /> <input type="hidden"
			id="reportsearch_uid" name="reportsearch_uid"
			value="${reportsearch_uid}" /> <input type="hidden"
			id="reportsearch_domain_keys" name="reportsearch_domain_keys"
			value="${reportsearch_domain_keys}" /> <input type="hidden"
			id="reportsearch_keywords" name="reportsearch_keywords"
			value="${reportsearch_keywords}" /> <input type="hidden"
			id="reportsearch_page" name="reportsearch_page"
			value="${reportsearch_page}" /> <input type="hidden"
			id="reportsearch_page_row" name="reportsearch_page_row"
			value="${reportsearch_page_row}" />
	</form>

	<script type="text/javascript">
		//
		var reportsearch_bidomains = new BIDomains('reportsearch_bidomains','rs');
		jQuery(document).ready(function() {
			var cwa_id=jQuery("#reportsearch_cwa_id").val();
			if(cwa_id==null||cwa_id==""){
				alert("Can not get user id");
				return false;
			}
			var uid=jQuery("#reportsearch_uid").val();
			if(uid==null||uid==""){
				alert("Can not get user id");
				return false;
			}
			var domain_keys=jQuery("#reportsearch_domain_keys").val();
			if(domain_keys==null||domain_keys==""){
				alert("Can not get searching domain");
				return false;
			}
			var keywords = jQuery("#reportsearch_keywords").val();
			if(keywords==null||keywords==""){
				alert("Please input keyword to search!");
				return false;
			}
			var page=jQuery("#reportsearch_page").val();
			var page_row=jQuery("#reportsearch_page_row").val();
			if(page_row==null||page_row==""){
				alert("Can not get page row");
				return false;
			}		
			searchDomains(cwa_id,uid,domain_keys,keywords,page,page_row,false);
		});
		
		function searchDomains(cwa_id,uid,domain_keys,keywords,page,page_row,page_search){
			var domain_key='';
			if(page_search==true){
				domain_key = domain_keys.split(',',2)[0];
				console.log(domain_key);				
				jQuery("#"+domain_key+"_results").html('<p class="ibm-h3"><span class="ibm-spinner" style="padding:10px;"></span> searching... </p>');
			}
			var timeid = (new Date()).valueOf();
			var url = '<%=request.getContextPath()%>/action/portal/search/searchDomain/' + cwa_id + '/' + uid + '/' + domain_keys + '/' + keywords + '/' + page + '/' + page_row+'?timeid='+timeid;
			jQuery.ajax({
				type : 'GET',
				url : url,
				success : function(data) {
					//refresh page					
					jQuery("#reportsearch_status").html("<p><strong style=\"font-size:20px;\">System containing your results with keywords: <span style=\"font-size:16px;color:blue\">"+keywords+"</span> </strong></p>");
					var summary = "";
					if(data.length>0){
						for (var i = 0; i < data.length; i++) {
							domain = data[i];
							summary += '<li><a href="#'+domain.domainKey+'_results" id="reportsearch_'+domain.domainKey+'_status_summary">' + domain.displayName + ' ('
									+ (domain.reports.length > page_row ? page_row : domain.reports.length) + ')</a> </li>';
							var bidomain = new BIDomain('reportsearch_bidomains','rs',domain);
							reportsearch_bidomains.addReplaceDomain(bidomain);
							showReports(bidomain);
						}
					}
					if(page_search==true){
						jQuery("#reportsearch_"+domain.domainKey+'_status_summary').text(domain.displayName + ' ('+ (domain.reports.length > page_row ? page_row : domain.reports.length)+')');
					}else{
						jQuery("#reportsearch_summary").html(summary);
					}					
				},
				error : function(error) {
					//jQuery("#reportsearch_status").text("Failed to search report, errors:"+error.responseText);
					jQuery("#reportsearch_status").html(error.responseText);
				}
			});
		}

		function showReports(bidomain) {
			var reports = bidomain.toString();
			var createDev = false;
			var pre_onClick = 'searchDomains("'+bidomain.json_domain.cwa_id+'","'+bidomain.json_domain.uid+'","'+bidomain.json_domain.domainKey+','+bidomain.json_domain.search_report_types+'","'+bidomain.json_domain.keywords+'",'+(bidomain.json_domain.page - 1)+','+bidomain.json_domain.page_row+',true);return false;';
			var next_onClick = 'searchDomains("'+bidomain.json_domain.cwa_id+'","'+bidomain.json_domain.uid+'","'+bidomain.json_domain.domainKey+','+bidomain.json_domain.search_report_types+'","'+bidomain.json_domain.keywords+'",'+(bidomain.json_domain.page + 1)+','+bidomain.json_domain.page_row+',true);return false;';
			console.log(pre_onClick);
			console.log(next_onClick);
			if (jQuery("#" + bidomain.getDomain().domainKey + "_results").length < 1) {
				createDev = true;
			}
			if (createDev) {
				var new_dev = '<dev id="'+bidomain.getDomain().domainKey+'_results" class="ibm-col-12-12">';
				new_dev +=  reports ;
				new_dev += '<p class="ibm-ind-link">'
				if(bidomain.json_domain.page>1){
					new_dev += '<a class="ibm-back-link" style="font-size:16px;" onClick=\''+pre_onClick+'\' href="#">Previous Page</a> &nbsp;&nbsp;&nbsp;&nbsp;';
				}
				if(bidomain.json_domain.nextPage==true){
					new_dev += '<a class="ibm-forward-link" style="font-size:16px;" onClick=\''+next_onClick+'\' href="#">Next Page</a>';
				}
				new_dev += '</p>';
				new_dev += '</dev>';
				jQuery("#reportSearch_Results_div").append(new_dev);
			} else {
				var new_dev = reports;
				new_dev += '<p class="ibm-ind-link">'
				if(bidomain.json_domain.page>1){
					new_dev += '<a class="ibm-back-link" style="font-size:16px;" onClick=\''+pre_onClick+'\' href="#">Previous Page</a> &nbsp;&nbsp;&nbsp;&nbsp;';
				}
				if(bidomain.json_domain.nextPage==true){
					new_dev += '<a class="ibm-forward-link" style="font-size:16px;" onClick=\''+next_onClick+'\' href="#">Next Page</a>';
				}
				new_dev += '</p>';				
				jQuery("#" + bidomain.getDomain().domainKey + "_results").html(new_dev);
			}
		}
	</script>

	<!-- 1 columns -->
	<div class="ibm-fluid">
		<div class="ibm-col-12-12">
			<span id="reportsearch_status"><p class="ibm-h3">
					<span class="ibm-spinner" style="padding: 10px;"></span>
					searching...
				</p></span> <span id="reportsearch_summary"></span>
		</div>

	</div>

	<!-- 1 columns end-->
	<div class="ibm-fluid" id="reportSearch_Results_div"></div>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>