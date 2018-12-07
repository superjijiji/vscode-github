<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM | Mail IR link</title>
<jsp:include page="/WEB-INF/include/v18include_min.jsp"></jsp:include>
<link href="//1.www.s81c.com/common/v18/css/forms.css" rel="stylesheet">
<script src="//1.www.s81c.com/common/v18/js/forms.js"></script>

<script type="text/javascript">

	var cwa_id = "${cwa_id}";
	var domain_key = "${domain_key}";
	var report_def_id = "${report_def_id}";
	var rpt_name = "${rpt_name}";
	var rpt_type = "${rpt_type}";
	var helpDoc = "${helpDoc}";
	var rpt_desc = "${rpt_desc}";

	jQuery(document).ready(function() {
		
		jQuery("#idEmailAddress").val(' ' + cwa_id);

		
	});
	
	function submitForm(){
		
		var timeid = (new Date()).valueOf();
		
		var paramMailIRReport = {};
		var emailAddress = jQuery("#idEmailAddress").val();
		var emailComments = jQuery("#idEmailComments").val();

		paramMailIRReport["emailAddress"] = emailAddress;
		paramMailIRReport["emailComments"] = emailComments;
		
		urlStr = "<%=request.getContextPath()%>/action/portal/irhelp/emailIRReport?timeid="
			+ timeid 
			+ "&cwa_id=" + cwa_id
			+ "&domain_key=" + domain_key 
			+ "&report_def_id=" + report_def_id
			+ "&rpt_name=" + rpt_name
			+ "&rpt_type=" + rpt_type
			+ "&helpDoc=" + helpDoc 
			+ "&rpt_desc=" + rpt_desc;
		
		jQuery.ajax({
			type : "POST",
			url : urlStr, 
			data: JSON.stringify(paramMailIRReport),
			contentType: "application/json",
			datatype: "json", // "xml", "html", "script", "json", "jsonp",
			success : function(data) {
				//console.log("emailIRReport successfully");
				jQuery('#idEmailHead').hide();
				jQuery('#idEmailInfo').hide();
				jQuery('#emailLink_buttondiv').hide();
				jQuery('#idEmailSuccess').show();
				//alert(data.mailBody);
			}
		})
		.done(function(){
			//alert("Link was e-mailed successfully.");
			console.log("emailIRReport successfully");
			
		})
		.fail(function(jqXHR, textStatus, errorThrown){
			//alert("ERROR: Unable to mail report.");
			console.log("unable to emailIRReport.");
		})
		

	}
	

</script>


</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-columns">
		<div class="ibm-card">

			<div id="to_hide" class="ibm-card__content">
				<strong class="ibm-h4">Mail a link to this report</strong>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				
				<div id="idEmailHead" width="100%" style="min-height: 30px;">
					Use this form to mail a link to a library report.
				</div>
				
				<div id="idEmailSuccess" width="100%" style="min-height: 30px; display: none;">
					Link was e-Mailed successfully.
				</div>
					
				<div id="idEmailInfo">
                	<label for="idEmailAddress">Enter your e-Mail address:</label><br/>
					<textarea id="idEmailAddress" name="emailAddress" readonly align="left" style= "overflow:none;background:transparent;" rows="4" cols="45">
					</textarea>
					<BR><br>
                	<label for="idEmailComments">Enter your e-Mail comments:</label><br/>
                	<textarea id="idEmailComments" name="emailComments" align="left" style= "overflow:none;background:transparent;" rows="4" cols="45"></textarea>
            	</div>
            	
            	<br>
            	<div id="emailLink_buttondiv">
					<input type="button" id="emailLink_btn_submit"
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="submitForm()" value="e-Mail this link" />
						
					<input type="button" id="emailLink_btn_cancel"
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick= "top.window.close();" value="Cancel" />

				</div>
            	
			</div>

			<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
		</div>
	</div>

</body>
</html>