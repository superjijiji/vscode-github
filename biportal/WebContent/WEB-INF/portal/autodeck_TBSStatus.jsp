<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM | Autodeck TBS Status Panel</title>
<jsp:include page="/WEB-INF/include/v18include_min.jsp"></jsp:include>
<link href="//1.www.s81c.com/common/v18/css/forms.css" rel="stylesheet">
<script src="//1.www.s81c.com/common/v18/js/forms.js"></script>

<script type="text/javascript">

	var myTbsContext = "<%=request.getContextPath()%>";
	var tbsList;
	var setFianlFlag ="Y";

	function showLoading() {
	  	jQuery("#csp_loading_id").css({ 'display': 'block', 'opacity': '0.8' });                
	    jQuery("#csp_ajax_loding_id").css({ 'display':'block','opacity':'0'});
	  	jQuery("#csp_ajax_loding_id").animate({ 'margin-top': '300px', 'opacity': '1' }, 200);  
	}

	function hiddLoading() {                 
		jQuery("#csp_loading_id").css({ 'display':'none'}); 
		jQuery("#csp_ajax_loding_id").css({ 'display':'none','opacity':'0'});            
	}

	var cwa_id = "${cwa_id}";
	var uid = "${uid}"; 
	var deck_id = "${deck_id}"; 
  
       function loadTBS(deck_id) {
    	   var table_2_content = jQuery("#table-2").DataTable();
    	   var timeid = (new Date()).valueOf();
    	   
			jQuery.ajax({
		        type: 'GET', url: '<%=path%>/action/portal/autodeck/loadTBSList/' + cwa_id
					+ '/' + uid + '/' + deck_id + '?timeid=' + timeid,
				async : false,
				success : function(data) {
				table_2_content.rows().remove();
				//console.log("get data from rest api loadTBSList()");

				jQuery("#autodeck_intro_id").append(deck_id);
				jQuery("#autodeck_intro_name").append(data.final_deck_time);

				tbsList = data.tbsList;
				var output_url = data.tbs_output_url;

				for (var i = 0; i < tbsList.length; i++) {

					var selectedTBS = tbsList[i];
					
					var input_col_0 = '';
					if(selectedTBS.running_id=="NONE"){
						input_col_0 = "<a href=\"javascript:void(0)\" onClick=\"alert('There is no available output file for this Cognos Schedule, Please run it first.')\">" + selectedTBS.rptName + "</a>";
					}else{
						input_col_0 = "<a href=" + myTbsContext + "/action/portal/tbsoutputs/downLoadSignleTBSOutput/" 
										+ cwa_id + "/" + uid + "/" + selectedTBS.running_id
									 	+ " target='_blank'>"
										+ selectedTBS.rptName + "</a>";
					}

					var input_col_1 = selectedTBS.emailSubject;
					var input_col_2 = selectedTBS.freqDetail;
					var input_col_3 = "";
					if (selectedTBS.requesStatus == "R") {
						input_col_3 = "<font color='green'>Ready</font>";
					} else if (selectedTBS.requesStatus == "N") {
						input_col_3 = "<font color=''>Not Ready</font>";
					} else if (selectedTBS.requesStatus == "F") {
						setFianlFlag = "N";
						input_col_3 = "<font color='Red'>Failed</font>";
					} else if (selectedTBS.requesStatus == "I") {
						setFianlFlag = "N";
						input_col_3 = "<font color='Red'>Inactive</font>";
					} else if (selectedTBS.requesStatus == "U") {
						setFianlFlag = "N";
						input_col_3 = "<font color='Red'>Unavailable</font>";
					} else if (selectedTBS.requesStatus == "E") {
						setFianlFlag = "N";
						input_col_3 = "<font color='Red'>Error</font>";
					} else if (selectedTBS.requesStatus == "D") {
						setFianlFlag = "N";
						input_col_3 = "<font color='Red'>Deleted</font>";
					} else if (selectedTBS.requesStatus == "S") {
						setFianlFlag = "N";
						input_col_3 = "<font color='Red'>Suspended</font>";
					} else if (selectedTBS.requesStatus == "V") {
						setFianlFlag = "N";
						input_col_3 = "<font color='Red'>Validating</font>";
					}

					var input_col_4 = selectedTBS.excutionStatus;
					var input_col_5 = selectedTBS.comments;
					var input_col_6 = selectedTBS.readyTime;
					var input_col_7 = selectedTBS.requestId;

					var dataSet = [ input_col_0, input_col_1, input_col_2,input_col_3, input_col_4, input_col_5, input_col_6,input_col_7 ];
					table_2_content.row.add(dataSet).draw();

					//jQuery(table_2_content.row(i).node()).attr('id', 'id_selectedCSR_' + selectedRequest.requestId);

				}
				
				if(data.submitAction=="yes"){
					jQuery('#adTBSStatus_buttondiv').show();
				}
				
				if(data.warning!=null && !data.warning==""){
					jQuery('#warning_message').append("NOTE: " + data.warning);
					jQuery('#adTBSStatus_warning').show();
				}
 
			},
			error : function(data) {
				alert('loadTBS - ajax return error!!!')
			}
		});
	}

	jQuery(document).ready(function() {

		//showLoading();
		jQuery("#tbody_table_2").empty();
		loadTBS(deck_id);

	});
	
	function validateSetFinal(){
		
		var table_2_content = jQuery("#table-2").DataTable();
 	    var timeid = (new Date()).valueOf();
 	    
		jQuery.ajax({
	        type: 'GET', url: '<%=path%>/action/portal/autodeck/loadTBSSetAsFinalList/' + cwa_id
				+ '/' + uid + '/' + deck_id + '?timeid=' + timeid,
			async : false,
			success : function(data) {
			table_2_content.rows().remove();
			//console.log("get data from rest api loadTBSSetAsFinalList()");

			tbsList = data.tbsList;
			var output_url = data.tbs_output_url;

			for (var i = 0; i < tbsList.length; i++) {

				var selectedTBS = tbsList[i];

				var input_col_0 = '';
				if(selectedTBS.running_id=="NONE"){
					input_col_0 = "<a href=\"javascript:void(0)\" onClick=\"alert('There is no available output file for this Cognos Schedule, Please run it first.')\">" + selectedTBS.rptName + "</a>";
				}else{
					input_col_0 = "<a href=" + myTbsContext + "/action/portal/tbsoutputs/downLoadSignleTBSOutput/" 
									+ cwa_id + "/" + uid + "/" + selectedTBS.running_id
				 					+ " target='_blank'>"
									+ selectedTBS.rptName + "</a>";
				}

				var input_col_1 = selectedTBS.emailSubject;
				var input_col_2 = selectedTBS.freqDetail;
				var input_col_3 = "";
				if (selectedTBS.requesStatus == "R") {
					input_col_3 = "<font color='green'>Ready</font>";
				} else if (selectedTBS.requesStatus == "N") {
					input_col_3 = "<font color=''>Not Ready</font>";
				} else if (selectedTBS.requesStatus == "F") {
					setFianlFlag = "N";
					input_col_3 = "<font color='Red'>Failed</font>";
				} else if (selectedTBS.requesStatus == "I") {
					setFianlFlag = "N";
					input_col_3 = "<font color='Red'>Inactive</font>";
				} else if (selectedTBS.requesStatus == "U") {
					setFianlFlag = "N";
					input_col_3 = "<font color='Red'>Unavailable</font>";
				} else if (selectedTBS.requesStatus == "E") {
					setFianlFlag = "N";
					input_col_3 = "<font color='Red'>Error</font>";
				} else if (selectedTBS.requesStatus == "D") {
					setFianlFlag = "N";
					input_col_3 = "<font color='Red'>Deleted</font>";
				} else if (selectedTBS.requesStatus == "S") {
					setFianlFlag = "N";
					input_col_3 = "<font color='Red'>Suspended</font>";
				} else if (selectedTBS.requesStatus == "V") {
					setFianlFlag = "N";
					input_col_3 = "<font color='Red'>Validating</font>";
				}

				var input_col_4 = selectedTBS.excutionStatus;
				var input_col_5 = selectedTBS.comments;
				var input_col_6 = selectedTBS.readyTime;
				var input_col_7 = selectedTBS.requestId;

				var dataSet = [ input_col_0, input_col_1, input_col_2,
						input_col_3, input_col_4, input_col_5, input_col_6,
						input_col_7 ];
				table_2_content.row.add(dataSet).draw();

				//jQuery(table_2_content.row(i).node()).attr('id', 'id_selectedCSR_' + selectedRequest.requestId);

			}
			
			if(data.submitAction=="yes"){
				jQuery('#adTBSStatus_buttondiv').show();
			}
			
			if(data.warning!=null && !data.warning==""){
				jQuery('#warning_message').append("NOTE: " + data.warning);
				jQuery('#adTBSStatus_warning').show();
			}

		},
		error : function(data) {
			alert('loadTBSSetAsFinalList - ajax return error!!!')
		}
	});
		
		if(setFianlFlag=='Y'){
			alert('Deck Set As Final successfully - you will receive the final deck later.');return;
		}else{
			alert('Some Cognos Schedule(s) are failed or are still being validated and could not be set to Final.');return;
		}
		
	}
</script>


</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-columns">
		<div class="ibm-card">

			<div id="to_hide" class="ibm-card__content">
				<strong class="ibm-h4">Cognos Schedule Status</strong>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>

				<table id="table-1" cellspacing="0" cellpadding="0" border="0"
					width="100%">
					<tbody>
						<tr>
							<td style="width: 85%;"><strong id="autodeck_intro_id"
								class="ibm-h4">All Cognos Autodeck inputs for deck: </strong> <br />
								<br /> <strong id="autodeck_intro_name" class="ibm-h4">Final
									Deck previous completed time(GMT): </strong>

								<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
									<hr>
								</div></td>
							<td rowspan="2">

								<p class="ibm-ind-link" style="margin: 0px; padding: 0px;">
									<a class="ibm-popup-link"
										style="margin-bottom: 1px; margin-bottom: 1px; padding-bottom: 1px; padding-top: 1px;"
										href="<%=path%>/action/portal/pagehelp?pageKey=MyAutodeckCSRStatus&pageName=Cognos+Schedule+Status"
										target="_blank"> Help for this page</a>
								</p>
							</td>
						</tr>
					</tbody>
				</table>

				<table id="table-2" data-widget="datatable" data-info="false"
					data-ordering="true" data-paging="false" data-searching="false"
					class="ibm-data-table ibm-altrows dataTable no-footer"
					data-order='[[1,"asc"]]'>
					<thead>
						<tr>
							<th>Report Name/File Name</th>
							<th>e-Mail Subject</th>
							<th>Frequency</th>
							<th>Ready for Final Deck</th>
							<th>Execution Status</th>
							<th>Comments</th>
							<th>Last Update Time</th>
							<th>Request ID</th>
						</tr>
					</thead>
					<tbody id='tbody_table_2'></tbody>
				</table>
				<br />

				<div id="adTBSStatus_buttondiv" style="display: none;">
					<input type="button" id="adTBSStatus_btn_submit"
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="validateSetFinal()" value="Confirm as Final" />
				</div>

				<div id="adTBSStatus_warning" style="display: none;">
					<b><font color="red" id="warning_message"></font></b>
				</div>
			</div>

			<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
		</div>
	</div>

</body>
</html>