<!-- Author Leo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.net.*"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>Existing Cognos schedules</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-columns">
		<div class="ibm-card">
			<div class="ibm-card__content">
				<strong class="ibm-h4">Existing Cognos schedules</strong>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				<p>
					<strong>Existing Cognos schedules allows you to view and
						modify any schedules you have set up for this report.</strong>
				</p>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				<form>
					<div id="mytbs_root_buttondiv" class="ibm-btn-row ibm-right">
						<input id="csp_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="openCognosSchedule();" value="Open this schedule" type="button" /> 
						<input id="csp_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="deleteCognosSchedule()" value="Delete" type="button" />
						<input id="csp_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="extendDateCognosSchedule()" value="Extend date" type="button" /> 
						<input id="csp_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="updateActiveInactive();" value="Activate/inactivate" type="button" />
					</div>

					<input type="hidden" id="csp_rptAccessID" name="rptAccessID" value="${rptAccessID}" /> 
					<input type="hidden" id="csp_domainKey" name="domainKey" value="${domainKey}" /> 
					<input type="hidden" id="csp_requestID" name="requestID" value="${requestID}" />

					<div id="existing_cs_loading_id"
						style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 998; width: 100%; height: 100%; _padding: 0 20px 0 0; background: #f6f4f5; display: none;"></div>
					<div id="existing_cs_ajax_loding_id"
						style="position: fixed; top: 0; left: 50%; z-index: 9999; opacity: 0; filter: alpha(opacity = 0); margin-left: -80px;">
						<div>
							<img src='<%=request.getContextPath()%>/images/ajax-loader.gif' />
						</div>
					</div>
					<table id="csp_existing_table_id" cellspacing="0" cellpadding="0"
						border="0" width="100%"
						class='ibm-data-table ibm-altrows ibm-small'
						summary="table layout display">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col">Report Name</th>
								<th scope="col">e-Mail Subject</th>
								<th scope="col">Frequency</th>
								<th scope="col">Datamart / Data Load</th>
								<th scope="col">Expiration Date</th>
								<th scope="col">Status</th>
								<th scope="col">Comments</th>
							</tr>
						</thead>

						<tbody>

						</tbody>
					</table>
					<br />
					<div id="mytbs_root_buttondiv" class="ibm-btn-row ibm-right">
						<input id="csp_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="openCognosSchedule();" value="Open this schedule" type="button" /> 
						<input id="csp_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="deleteCognosSchedule()" value="Delete" type="button" />
						<input id="csp_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="extendDateCognosSchedule()" value="Extend date" type="button" /> 
						<input id="csp_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="updateActiveInactive();" value="Activate/inactivate" type="button" />
					</div>
				</form>
				<br>

			</div>
		</div>
	</div>



	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
	<script type="text/javascript">
jQuery(function() {
	var timeid = (new Date()).valueOf();
	var str ="";
	var rptAccessID = jQuery("#csp_rptAccessID").val();
	var domainKey = jQuery("#csp_domainKey").val();
	var requestID = jQuery("#csp_requestID").val();
	showLoading();
	jQuery
			.ajax({
				type : "GET",
				url : "<%=request.getContextPath()%>/action/portal/schedulePanel/loadExistingSchedule/"+rptAccessID+"/"+domainKey+"?timeid=" + timeid ,
				dataType : "json",
				success : function(data) {
					
					jQuery.each(
							data,
							function(i, existingCS) {
								str +="<tr id='"+existingCS.tbsRequestId+"_tr_id'>";
								str +="<td>";
								if(existingCS.tbsRequestId==requestID) {
									str+="<input id='cs_"+existingCS.tbsRequestId+"' type='radio'  class='ibm-styled-radio' data-init='false' name='selectedCS' value='"+existingCS.tbsRequestId+';'+existingCS.tbsRequestStatus+"' checked=true />";
								} else {
									str +="<input id='cs_"+existingCS.tbsRequestId+"' type='radio'  class='ibm-styled-radio' data-init='false' name='selectedCS' value='"+existingCS.tbsRequestId+';'+existingCS.tbsRequestStatus+"'/>";
								}
								str +="<label for='cs_"+existingCS.tbsRequestId+"'></label>";
								str +="</td>";
								
								str +="<td>";
								str +=existingCS.tbsRptName;
								str +="</td>";
								
								str +="<td>";
								str +=existingCS.tbsEmailSubject
								str +="</td>";
								
								str +="<td>";
								str +=existingCS.freqDetails;
								str +="</td>";
								
								str +="<td>";
								str +=existingCS.triggerTriggerDesc;
								str +="</td>";
								
								str +="<td id='"+existingCS.tbsRequestId+"_extend_id'>";
								str +=existingCS.tbsExpirationDate;
								str +="</td>";
								
								str +="<td id='"+existingCS.tbsRequestId+"_status_id'>";
								if(existingCS.tbsChildTbs=="Y"){
									str +=existingCS.tbsRequestStatus+"(C)";
								}else
									str +=existingCS.tbsRequestStatus;
								str +="</td>";
								
								str +="<td>";
								str +=existingCS.promptsComments;
								str +="</td>";
								
								str +="</tr>";
								
							});

					jQuery("#csp_existing_table_id").append(str);
				}
			})
			.done(function(){
				hiddLoading();		
			})
			.fail(function(jqXHR, textStatus, errorThrown){
				hiddLoading();
				alert("loading exsiting Cognos Schedule Failed!");		
			})	

}

);


function openCognosSchedule(){
	var requestID=jQuery("input:radio:checked").val();
	var domainKey=jQuery("#csp_domainKey").val();
	if(requestID==undefined || requestID == '' || requestID == null){
		alert('Please choose a schedule first.');
		return false;
	}
	var ii = requestID.indexOf(';');
	var status = requestID.substring(ii + 1);
	requestID = requestID.substring(0,ii);
	if(status=='D'){
		alert('This schedule has been disabled, please remove it.');
		return false;
	}
	var urlStr = "<%=request.getContextPath()%>/action/portal/schedulePanel/openCognosSchedulePanel/" + requestID + "/" + domainKey ;
	window.location.href=urlStr;
}

function updateActiveInactive(){
	var timeid = (new Date()).valueOf();
	var requestID=jQuery("input:radio:checked").val();
	if(requestID==undefined || requestID == '' || requestID == null){
		alert('Please choose a schedule first.');
		return false;
	}
	var ii = requestID.indexOf(';');
	var status = requestID.substring(ii + 1);
	requestID = requestID.substring(0,ii);
	if(status=='D'){
		alert('This schedule has been disabled, please remove it.');
		return false;
	}	
	showLoading();
	jQuery.ajax({
		type : "POST",
		url : "<%=request.getContextPath()%>/action/portal/schedulePanel/updateActiveInactive?timeid=" + timeid ,
		data : {"requestID":requestID}, 
		dataType : "json",
		success : function(data) {
			
			jQuery.each(
					data,
					function(request, updateData) {
						if(jQuery("#"+request+"_status_id").text().indexOf("(C)")!=-1)
							jQuery("#"+request+"_status_id").text(updateData+"(C)");
						else
							jQuery("#"+request+"_status_id").text(updateData);						
					});
		}
	})
	.done(function(){
		hiddLoading();		
		alert("The schedule is activated/inactivated successfully!");
	})
	.fail(function(jqXHR, textStatus, errorThrown){
		hiddLoading();
		alert("activated/inactivated Failed!");		
	})	
}

function deleteCognosSchedule(){
	var timeid = (new Date()).valueOf();
	var requestID=jQuery("input:radio:checked").val();
	if(requestID==undefined || requestID == '' || requestID == null){
		alert('Please choose a schedule first.');
		return false;
	}
	showLoading();
	jQuery.ajax({
		type : "POST",
		url : "<%=request.getContextPath()%>/action/portal/schedulePanel/deleteCognosSchedule?timeid=" + timeid ,
		data : {"requestID":requestID}, 
		dataType : "json",
		success : function(data) {
			
			jQuery.each(
					data,
					function(request, updateData) {
						jQuery("#"+request+"_tr_id").remove();					
					});
		}
	})
	.done(function(){
		hiddLoading();		
		alert("The schedule is deleted successfully!");
	})
	.fail(function(jqXHR, textStatus, errorThrown){
		hiddLoading();
		alert("delete Failed!");		
	})	
}

function extendDateCognosSchedule(){
	var timeid = (new Date()).valueOf();
	var requestID=jQuery("input:radio:checked").val();
	if(requestID==undefined || requestID == '' || requestID == null){
		alert('Please choose a schedule first.');
		return false;
	}
	var ii = requestID.indexOf(';');
	var status = requestID.substring(ii + 1);
	requestID = requestID.substring(0,ii);
	if(status=='D'){
		alert('This schedule has been disabled, please remove it.');
		return false;
	}	
	showLoading();
	jQuery.ajax({
		type : "POST",
		url : "<%=request.getContextPath()%>/action/portal/schedulePanel/extendDateCognosSchedule?timeid=" + timeid ,
		data : {"requestID":requestID}, 
		dataType : "json",
		success : function(data) {
			
			jQuery.each(
					data,
					function(request, updateData) {
						jQuery("#"+request+"_extend_id").text(updateData);						
					});
		}
	})
	.done(function(){
		hiddLoading();		
		alert("The schedule's date is extended successfully!");
	})
	.fail(function(jqXHR, textStatus, errorThrown){
		hiddLoading();
		alert("extended Failed!");		
	})	
}

function showLoading() {
  	jQuery("#existing_cs_loading_id").css({ 'display': 'block', 'opacity': '0.8' });                
    jQuery("#existing_cs_ajax_loding_id").css({ 'display':'block','opacity':'0'});
  	jQuery("#existing_cs_ajax_loding_id").animate({ 'margin-top': '300px', 'opacity': '1' }, 200);  
}

function hiddLoading() {                 
	jQuery("#existing_cs_loading_id").css({ 'display':'none'}); 
	jQuery("#existing_cs_ajax_loding_id").css({ 'display':'none','opacity':'0'});            
}
</script>

</body>
</html>