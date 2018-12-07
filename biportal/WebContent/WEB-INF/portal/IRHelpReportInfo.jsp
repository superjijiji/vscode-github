<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM | IR Help Report</title>
<jsp:include page="/WEB-INF/include/v18include_min.jsp"></jsp:include>
<link href="//1.www.s81c.com/common/v18/css/forms.css" rel="stylesheet">
<script src="//1.www.s81c.com/common/v18/js/forms.js"></script>

<script type="text/javascript">

	var report_def_id = "${report_def_id}";

	jQuery(document).ready(function() {

		var timeid = (new Date()).valueOf();

		urlStr = "<%=request.getContextPath()%>/action/portal/irhelp/getIRHelpReport?timeid="
				+ timeid
				+ "&report_def_id=" + report_def_id;
		
		jQuery.ajax({
	        type: 'GET', 
	        url: urlStr,
			async : false,
			success : function(data) {
				//console.log("get data from rest api getCognosReport()");
				jQuery("#idReportName").append(data.rptName);
				
				jQuery("#id_IRHelpReport_message").append("The " + data.rptName + " report is based on the content of the " + data.reportFileName + " file");
				
				if (data.ownerGroup != null && data.ownerGroup.length != 0) {
					jQuery("#id_IRHelpReport_message").append(" which is owned by " + data.ownerGroup);
		        }
				
				jQuery("#id_IRHelpReport_message").append(".  Any questions regarding the content ");
				
				if (data.reportDesc != null && data.reportDesc.length != 0) {
					jQuery("#id_IRHelpReport_message").append("(" + data.reportDesc + ") ");
		        }
				
				jQuery("#id_IRHelpReport_message").append("of this report should be addressed to the following ");
				jQuery("#id_IRHelpReport_message").append("support contacts: <br>");
				
				jQuery("#idEdcContactIds").append("<ul>");
				var strEdcContactIds = data.edcContactIds.split(",");
				for(var i=0;i<strEdcContactIds.length;i++){
					jQuery("#idEdcContactIds").append("<li>"+ strEdcContactIds[i]);
				}
				jQuery("#idEdcContactIds").append("</ul>");
				
			},
			error : function(data) {
				alert('getIRHelpReport - ajax return error!!!')
			}
		});
		
	});
	

</script>


</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-columns">
		<div class="ibm-card">

			<div id="to_hide" class="ibm-card__content">
				<strong class="ibm-h4">Information on this report</strong>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
					
				<p>
					<strong id="idReportName" class="ibm-h2"> </strong>
				</p>
				<br/>
				
				<p id="id_IRHelpReport_message">
					<ul id="idEdcContactIds">
					</ul>
				</p>
				
			</div>

			<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
		</div>
	</div>

</body>
</html>