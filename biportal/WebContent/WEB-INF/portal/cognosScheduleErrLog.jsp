<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Schedule Error Message</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-columns">
		<div class="ibm-card">
			<div class="ibm-card__content">
				<strong class="ibm-h4">Schedule Error Message</strong>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				<p>
					<strong> Schedule Error Message allows you to see what's
						wrong with your failed schedule'.</strong>
				</p>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				<strong>Error message</strong> <input type="hidden"
					id="csp_running_id" name="requestID" value="${running_id}" />
				<table id="csp_err_table_id" cellspacing="0" cellpadding="0"
					border="0" width="100%" class="ibm-data-table"
					summary="table layout display">

					<tbody>

					</tbody>
				</table>

				<br>




				<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
				<script type="text/javascript">
jQuery(function() {
	var timeid = (new Date()).valueOf();
	var running_id= jQuery("#csp_running_id").val();
	var str ="";
	jQuery
			.ajax({
				type : "GET",
				url : "<%=request.getContextPath()%>/action/portal/schedulePanel/loadRunningErrlog/"+running_id+"?timeid=" + timeid ,
				dataType : "json",
				success : function(data) {
					
					jQuery.each(
							data,
							function(i, errLog) {
								str+="<tr><td style='width:15%;'>Running ID:</td>";
								str+="<td>";
								str+= errLog.runningID;
								str+="</td></tr>"
								
								str+="<tr><td style='width:15%;'>Error Message:</td>";
								str+="<td> <span onclick='seeDetailMsg("+i+")' style='text-decoration: underline;color: blue;cursor: pointer;'>";
								str+= errLog.errorShortMsg;
								str+="</span><br/>";
								str+="<div id='error_detail_" + i +"' class='ibm-altering' style='display:none;'>";
								str+="<br /><hr />";
								str+="<xmp>";
						 		str+=errLog.errorMsg;
						 		str+="</xmp>";
						 		str+="</div>";
								
								str+="</td></tr>";
							});
					
					jQuery("#csp_err_table_id").append(str);
				}
			});

}

);
function seeDetailMsg(i){
	if(jQuery("#error_detail_"+i).is(":hidden")){

		jQuery("#error_detail_"+i).show();
	}
	else{
		jQuery("#error_detail_"+i).hide();
	}
		
}
</script>
</body>
</html>