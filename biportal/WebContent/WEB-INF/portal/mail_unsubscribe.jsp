<!-- Author Leo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM | Unsubscribe panel</title>

<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<link href="//1.www.s81c.com/common/v18/css/forms.css" rel="stylesheet">
<script src="//1.www.s81c.com/common/v18/js/forms.js"></script>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div style="margin: 5px; display: table;">

		<h1 id="ibm-pagetitle-h1" style="padding-left: 10px; float: left;"
			class="ibm-h1 ibm-light">Unsubscribe panel</h1>
		
	</div>

	<div class="ibm-columns">

		<div class="ibm-card">
			<div class="ibm-card__content">

				<div id="job_status_loading_id"
					style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 998; width: 100%; height: 100%; _padding: 0 20px 0 0; background: #f6f4f5; display: none;"></div>
				<div id="job_status_ajax_loding_id"
					style="position: fixed; top: 0; left: 50%; z-index: 9999; opacity: 0; filter: alpha(opacity = 0); margin-left: -80px;">
					<div>
						<img src='<%=request.getContextPath()%>/images/ajax-loader.gif' />
					</div>
				</div>

				<div class="ibm-rule">
					<hr>
				</div>
				<input type="hidden" id="unsubscribe_request_id" name="request_id" value="${request_id}" /> 
				<input type="hidden" id="unsubscribe_report_type" name="report_type" value="${report_type}" />
				<div id='unsubscribe_message' align="center" style="font-size:15px" ></div>
			</div>
		</div>
	</div>




	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
	<script type="text/javascript">
	jQuery(function() {
	var timeid = (new Date()).valueOf();
	var request_id = jQuery("#unsubscribe_request_id").val();
	var report_type = jQuery("#unsubscribe_report_type").val();
	var str ="";
	
	showLoading();  
	jQuery
			.ajax({
				type : "GET",
				url : "<%=request.getContextPath()%>/action/portal/mail/doUnsubscribe/" + request_id + "/" + report_type +"?timeid=" + timeid ,
				dataType : "json",
				success : function(data) {
					hideLoading(); 
					jQuery("#unsubscribe_message").append(data);
				}
			})
			.fail(function(jqXHR, textStatus, errorThrown){	
				hideLoading(); 
				alert("ERROR, please try again later or contact BI@IBM helpdeck.");	
			})	

}

);


function showLoading() {
  	jQuery("#job_status_loading_id").css({ 'display': 'block', 'opacity': '0.8' });                
    jQuery("#job_status_ajax_loding_id").css({ 'display':'block','opacity':'0'});
  	jQuery("#job_status_ajax_loding_id").animate({ 'margin-top': '300px', 'opacity': '1' }, 200);  
}

function hideLoading() {                 
	jQuery("#job_status_loading_id").css({ 'display':'none'}); 
	jQuery("#job_status_ajax_loding_id").css({ 'display':'none','opacity':'0'});            
}

</script>
</body>
</html>