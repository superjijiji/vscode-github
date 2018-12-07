<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
String path = request.getContextPath(); 
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<title>BI@IBM | My subscriptions</title>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br />
	<div>
		<div
			style="width: 1024px; align: center; margin-left: auto; margin-right: auto;">
			<div>
				<div style="float: left;">
					<h1 class="ibm-h1 ibm-light">My subscriptions</h1>
				</div>
				<div>
					<p class="ibm-ind-link ibm-icononly ibm-inlinelink">
						<a class="ibm-information-link" target="_blank"
							href="<%=path%>/action/portal/pagehelp?pageKey=MySubscriptions&pageName=My+subscriptions"
							title="Help for My subscriptions"> Help for My subscriptions
						</a>
					</p>
				</div>
			</div>
			<div>
				<h1 class="ibm-h4 ibm-light">My subscriptions lets you manage
					the set of Report Library reports for which you will receive e-mail
					update notification when they are published.</h1>
				<div id="showMySubDiv"></div>
			</div>
		</div>
	</div>
	<br />
	<script type="text/javascript">
var mySubContextPath = "<%=request.getContextPath()%>";
var mySubCwaid = "${cwa_id}"; 
var mySubUid = "${uid}";
var mySubBlobReports;

jQuery(document).ready(function () {
	refreshMySubscriptionPanel();
})

function refreshMySubscriptionPanel() {
	jQuery("#showMySubDiv").empty().append("<img src='"+mySubContextPath+"/images/ajax-loader.gif' />");
	jQuery.get(
		mySubContextPath+"/action/portal/mysubscription/loadSubBlobReport/"+mySubCwaid+"/"+mySubUid+"?timeid="+(new Date()).valueOf()
	)
	.done(function(data) {
		if (data == "" || data.length == 0) {
			jQuery("#showMySubDiv").empty().append("<p>You do not have any subscribed reports. </p>");
		} else {
			var allSubs = data;
			var totalCount = allSubs.length;
			mySubBlobReports = new BIReports("mySubBlobReports", "sub");
			
			for (var i = 0; i < totalCount; i++) {
				var currentSubRow = new BIReport("mySubBlobReports", "sub", allSubs[i]);
				mySubBlobReports.addReport(currentSubRow);
			}
			jQuery("#showMySubDiv").empty().append(mySubBlobReports.toString());
		}
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#showMySubDiv").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}
</script>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>