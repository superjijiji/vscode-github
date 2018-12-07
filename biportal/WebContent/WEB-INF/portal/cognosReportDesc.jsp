<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM | Cognos Report Description</title>
<jsp:include page="/WEB-INF/include/v18include_min.jsp"></jsp:include>
<link href="//1.www.s81c.com/common/v18/css/forms.css" rel="stylesheet">
<script src="//1.www.s81c.com/common/v18/js/forms.js"></script>

<script type="text/javascript">

	var cwa_id = "${cwa_id}";
	var uid = "${uid}"; 
	var cognos_cd = "${cognos_cd}";
	var content_id = "${content_id}";

	jQuery(document).ready(function() {

		var timeid = (new Date()).valueOf();

		urlStr = "<%=request.getContextPath()%>/action/portal/schedulePanel/getCognosReport?timeid="
				+ timeid 
				+ "&cognos_cd=" + cognos_cd
				+ "&cwa_id=" + cwa_id 
				+ "&content_id=" + content_id;
		
		jQuery.ajax({
	        type: 'GET', 
	        url: urlStr,
			async : false,
			success : function(data) {
				//console.log("get data from rest api getCognosReport()");
				jQuery("#idReportName").append(data.rptName);
				
				jQuery("#idMessageContent").attr("rows",data.rows_num + 1);
				jQuery("#idMessageContent").attr("cols",data.cols_num + 1);
				jQuery("#idMessageContent").val(data.msg);

			},
			error : function(data) {
				alert('getCognosReport - ajax return error!!!')
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
					
				<div>
					<strong id="idReportName" class="ibm-h4"> </strong>
				</div>
				<br/>
				
				<div id="cognosReportDesc_message">
					<textarea id="idMessageContent" name="messageContent" readonly align="left" style= "overflow:none;background:transparent;border-style:none;">
					</textarea>
				</div>
			</div>

			<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
		</div>
	</div>

</body>
</html>