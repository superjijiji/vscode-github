<!-- Author Leo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.net.*"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM | Cognos Schedule</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<div class="ibm-columns">
		<div class="ibm-card">
			<div class="ibm-card__content">
				<strong class="ibm-h4">Cognos schedule panel</strong>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>

				<form id="csp_form_id">
					<input type="hidden" id="csp_requestID" name="requestID" value="${requestID}" /> 
					<input type="hidden" id="csp_domainKey"  name="domainKey" value="${domainKey}" /> 
					<input type="hidden" id="csp_action" name="cspAction" value="${cspAction}" /> 
					<input type="hidden" id="csp_request_status_id" name="requestStatus" value="" /> 
					<input type="hidden" id="cwa_id" name="cwaID" value="" /> 
					<input type="hidden" id="uid_id" name="uid" value="" />
					<input type="hidden" id="search_path_id" name="searchPath" value="${searchPath}" /> 
					<input type="hidden" id="rpt_access_id" name="rptAccessID" value="${rptAccessID}" /> 
					<input type="hidden" id="csp_help_rpt_id" name="helpFileName" value="" /> 
					<input type="hidden" id="core_site_id" value="" /> 
					<input type="hidden" id="csp_rds_url_id" value="" /> 
					<input type="hidden" id="csp_proxy_id" value="" /> 
					<input type="hidden" id="csp_new_schedule_id" value="N" /> 
					<input type="hidden" id="csp_rpt_type_id" name="cognosRPTTYPE" value="" /> 
					<input type="hidden" id="csp_rpt_name_id" name="rptName" value="" /> 
					<input type="hidden" id="csp_user_rpt_name_id" name="userRPTName" value="" /> 
					<input type="hidden" id="promptsChangeFlag_id" value="N" /> 
					<input type='hidden' id='csp_hidden_sched_freq_detail_id' value='' name='schedFreqDetail' />

					<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tbody>
							<tr>
								<td style="width: 85%;"><strong id="csp_report_name" class="ibm-h4">Cognos report : </strong> <br /> <br />
									<strong class="ibm-h4">Step by step instructions for scheduling a Cognos report</strong> <br /> <br />
								</td>
								<td rowspan="2">
									<p class="ibm-ind-link" style="margin: 0px; padding: 0px;">
										<a class="ibm-popup-link"
											style="margin-bottom: 1px; margin-bottom: 1px; padding-bottom: 1px; padding-top: 1px;"
											onkeypress="openHelp(); return false;" onclick="openHelp(); return false;" href="#"
										> Information on this report </a>
									</p>
									<p class="ibm-ind-link" style="margin: 0px; padding: 0px;">
										<a class="ibm-popup-link"
											style="margin-bottom: 1px; margin-bottom: 1px; padding-bottom: 1px; padding-top: 1px;"
											onkeypress="openHelp2(); return false;" onclick="openHelp2(); return false;" href="#"
										> Help for this page </a>
									</p> <span id="csp_span_addFav_id"> </span>
								</td>
							</tr>
						</tbody>
					</table>

					<div id="csp_loading_id"
						style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 998; width: 100%; height: 100%; _padding: 0 20px 0 0; background: #f6f4f5; display: none;"></div>
					<div id="csp_ajax_loding_id"
						style="position: fixed; top: 0; left: 50%; z-index: 9999; opacity: 0; filter: alpha(opacity = 0); margin-left: -80px;">
						<div>
							<img src='<%=request.getContextPath()%>/images/ajax-loader.gif' />
						</div>
					</div>

					<div data-widget="showhide" class="ibm-simple-show-hide">
						<div class="ibm-container-body">
							<p class="ibm-show-hide-controls">
								<a href="#show" class="">Show instructions</a> | <a href="#hide"
									class="ibm-active">Hide instructions</a>
							</p>
							<div class="ibm-hideable">
								<p>To create a Cognos report schedule you must:</p>
								<ol>
									<li>Choose your desired report execution prompts by clicking on <q>"Select prompts"</q> on the <q>"Edit
											prompts"</q> tab. (To modify the prompt selections for an existing schedule click on the "Change prompts"
										button.)
									</li>
									<li>Add a short description to the "Your Comments" field on the "Edit prompts" tab to help you identify
										this particular schedule when viewing "Existing Schedules" or using the "My Cognos Schedules" function in the
										"Report controls" portlet.
									</li>
									<li>Use the <q>Output format</q> tab to select the required Cognos deliverable.
									</li>
									<li>On the <q>e-Mail information</q> complete the recipient and subject information and any additional
										comments you require on the e-Mail.
									</li>
									<li>Select the required timing and data load trigger on the <q>Schedule</q> tab.
									</li>
									<li>Select the priority of this schedule request relative to others that you own.</li>
									<li>Click on the "Submit" button. to save your schedule request. You may optionally also use the 'Run now'
										check-box to request that the schedule be run immediately regardless of the timing information specified on
										the schedule tab.
									</li>
								</ol>
							</div>

						</div>

						<div id="csp_content_id">
							<p style="padding-top: 0px;">
								Note that all required fields are marked with an asterisk (<span class="ibm-required">*</span>).
							</p>

							<table id="csp_1stline_id">
								<tr id="csp_1stline_tr_id">
									<td style="padding: 10px">
										<input type="button" id="csp_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="saveSchedule()" value="Submit"/>
									</td>
									<td style="padding: 10px">
										<input class="ibm-styled-checkbox" data-init="false" id="csp_runnow_id" type="checkbox" name="runNow" value="Y"/> 
										<label for="csp_runnow_id" class="ibm-field-label">Run now</label>
									</td>
								</tr>
							</table>

						</div>

						<span id="id_span_show_message"> </span> 
						<span id="csp_warnning_messge_id"></span>
						<p id="cps_others_id">
							Note also that you can work with any 
							<a id="existingCognosSchedule_id" name="existingCognosSchedule" href="#" onkeypress="" onClick="">Existing schedules</a>, 
							<a id="newSchedule_id" name="newSchedule" href="" onkeypress="" onClick="">Create another schedule</a> or 
							<a id="copySchedule_id" name="copySchedule" href="" onkeypress="" onClick="return copyScheduleCheck();">Copy this schedule</a> by clicking on the relevant link.
						</p>


						<div id="csp_tab_id" data-widget="dyntabs" class="ibm-graphic-tabs">
							<!-- Tabs here: -->
							<div class="ibm-tab-section">
								<ul class="ibm-tabs" role="tablist">
									<li id='defaultid'><a aria-selected="true" role="tab" href="#csp_prompts_id">Edit prompts</a></li>
									<li><a role="tab" href="#csp_outputformat_id">Output format</a></li>
									<li><a role="tab" href="#csp_emailinformation_id">e-Mail information</a></li>
									<li><a role="tab" href="#csp_schedule_id">Schedule</a></li>
									<li id="csp_runninglog_tab_id" style="display: none;"><a role="tab" href="#csp_running_log_id">Schedule history</a></li>
								</ul>
							</div>


							<!-- Tabs contents divs: -->

							<!-- prompts tab content -->
							<div id="csp_prompts_id" class="ibm-tabs-content">
								<p class="ibm-callout">Select/Show report prompts</p>
								<br />
								<button id="csp_change_prompts_button" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="pickUpPrompts();return false;">Change prompts</button>

								<br /> <br />
								<div id="csp_show_xmldata_div_id" style="height: 120px; width: 80%; background: #eeeeee; border: 1px solid #DDD;"></div>

								<div id="csp_hidden_xmldata_div_id" style="display: none">
									<label for="csp_textarea_xmldata_hidden_id">Selected Prompt Values:</label><BR>
									<textArea id="csp_textarea_xmldata_hidden_id" name="xmlData" rows="5" cols="60" readonly="true"></textArea>
									<br>
								</div>

								<br /> <label for="csp_textarea_xmldata_comments_id">Your Comments:</label><BR> <br />
								<textArea style="width: 80%;" rows="4" cols="60" id="csp_textarea_xmldata_comments_id" name="comments">
			        		</textArea>
							</div>

							<!-- output format tab content -->
							<div id="csp_outputformat_id" class="ibm-tabs-content">
								<p class="ibm-callout">Select an output format</p>
								<br /> Please select the desired report output format. <br /> <br />

								<fieldset style="width: 60%; border: 1px solid #DDD;">
									<legend>Format:</legend>
									<table cellspacing="0" cellpadding="0" border="0" width="100%" class="ibm-data-table" summary="table layout display">
										<thead>
											<tr>
												<th scope="col" style="display: none;">col1</th>
												<th scope="col" style="display: none;">col2</th>
											</tr>
										</thead>
										<tbody id="csp_format_id">
										</tbody>
									</table>

								</fieldset>

							</div>

							<!-- email tab content -->

							<div id="csp_emailinformation_id" class="ibm-tabs-content">
								<p class="ibm-callout">Enter your e-Mail information for e-Mails and schedules</p>
								<br /> Enter your chosen recipients. The e-Mail itself can be customized by modifying the subject and adding your own comments to the note. <br /> <br />

								<table cellspacing="0" cellpadding="0" border="0" width="100%" class="" summary="table layout display">
									<thead>
										<tr>
											<th scope="col" style="display: none;">col1</th>
											<th scope="col" style="display: none;">col2</th>
											<th scope="col" style="display: none;">col3</th>
											<th scope="col" style="display: none;">col4</th>
										</tr>
									</thead>
									<tbody>
										<tr valign="top">
											<td style="width: 15px; height: 1px;"></td>
											<td style="width: 25%;">
											<label for="id_textarea_e_mail_address">Enter your e-Mail address and/or <a id="myDistribution" name="myDistribution"
													target="_blank" href="<%=request.getContextPath()%>/action/portal/mydistlist/distmanage/getMyDistListPage">distribution list(s)</a>:<span class="ibm-required">*</span>
											</label>
											</td>
											<td style="width: 20%; vertical-align: top;"><textarea id="csp_textarea_e_mail_address_id" rows="4" cols="60" name="eMailAddress"></textarea></td>
											<td style="width: 55%; text-align: left; vertical-align: top;">
											&nbsp;&nbsp;(Enter up to 12 e-Mail addresses separated by spaces.) <br> <br> 
											<span class="ibm-item-note">&nbsp;&nbsp;(e.g. jdoe@us.ibm.com mydistlist)</span> <br> <br> 
											<a id="csp_cognosUnsubscribepage_id" class="ibm-feature-link" href="#" name="id_cognosUnsubscribepage">&nbsp;Show unsubscribe list</a>
											</td>
										</tr>

										<tr>
											<td style="height: 15px;"></td>
										</tr>

										<tr valign="top">
											<td style="height: 1px;"></td>
											<td><label for="csp_text_e_mail_subject_id">e-Mail subject:<span class="ibm-required">*</span></label>
											</td>
											<td>
												<input type="text" id="csp_text_e_mail_subject_id" onkeypress="if ( event.keyCode == 13 ) return false; else if ( event.which == 13 ) return false; else return true;" maxlength="90" size="60" name="eMailSubject"/>
											</td>
											<td>(Text for subject line of e-Mail)</td>
										</tr>

										<tr>
											<td style="height: 15px;"></td>
										</tr>

										<tr valign="top">
											<td style="height: 1px;">&nbsp;</td>
											<td><label for="id_email_comments">Enter your e-Mail comments:</label></td>
											<td style="vertical-align: top;"><textarea id="csp_email_comments_id" rows="4" cols="60" name="eMailComments"></textarea></td>
											<td>&nbsp;&nbsp;(will be included in the e-Mail body)</td>
										</tr>

										<tr valign="top">
											<td style="height: 1px;"></td>
											<td><label for="id_text_backup_owner">Backup:</label></td>
											<td><input type="text" id="csp_text_backup_owner_id" maxlength="128" size="60" name="backupOwner" value=""></td>
											<td><span class="ibm-item-note">(e.g. jdoe@us.ibm.com) Please make sure the backup has proper access to your TBS</span></td>
										</tr>

										<tr>
											<td style="height: 15px;"></td>
										</tr>

										<tr valign="top">
											<td style="height: 1px;"></td>
											<td>&nbsp;</td>
											<td>
												<fieldset style="width: 100%; border: 1px solid #DDD;">

													<legend>Mail options:</legend>

													<label>Send mail? </label> <span class="ibm-input-group"> <span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio"
															id="csp_checkbox_send_mail1_id" onclick="displayTemplate(this);" value="Y" name="sendMail"
														/> <label class="ibm-field-label" for="csp_checkbox_send_mail1_id">Yes</label>
													</span> <span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="csp_checkbox_send_mail1_2id" onclick="displayTemplate(this);" value="N"
															name="sendMail"
														/> <label class="ibm-field-label" for="csp_checkbox_send_mail1_2id">No</label>
													</span>
													</span> <br /> <br />

													<div id='csp_send_mailopton_id'>


														<label>Mail type:</label> <span> <select id="csp_select_mail_option_id" name="mailOption" data-width="45%" onChange="displayCompress()">

														</select>
														</span> <br /> <br />

														<div id='csp_compress_id'>
															<span>Compressed(zip) file:</span> <span class="ibm-input-group"> <span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio"
																	id="csp_radio_compress_result1_id" value="Y" name="compressResult"
																/> <label class="ibm-field-label" for="csp_radio_compress_result1_id">Yes</label>
															</span> <span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="csp_radio_compress_result2_id" value="N" name="compressResult" /> <label
																	class="ibm-field-label" for="csp_radio_compress_result2_id"
																>No</label>
															</span>
															</span>
														</div>

														<!-- dispaly creator info from mail subject by Leo-->

														<div id='csp_hide_creator_id'>
															<span>Show SMS SOM Support Team info?</span> <span class="ibm-input-group"> <span class="ibm-radio-wrapper"> <input class="ibm-styled-radio"
																	type="radio" id="csp_radio_hide_creator_result1_id" value="Y" name="hideCreator"
																/> <label class="ibm-field-label" for="csp_radio_hide_creator_result1_id">Yes</label>
															</span> <span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="csp_radio_hide_creator_result2_id" value="N" name="hideCreator" /> <label
																	class="ibm-field-label" for="csp_radio_hide_creator_result2_id"
																>No</label>
															</span>
															</span>
														</div>

													</div>

													<br />

												</fieldset>
											<td style="vertical-align: bottom"><span class="ibm-item-note" style="font-size: 12px">&nbsp;&nbsp;(Changes "Requested by" information in e-Mail subject and
													adds link to SMS SOM Support Team)</span></td>
											</td>
											<td></td>
										</tr>

										<tr valign="top">
											<td style="height: 1px;"></td>
											<td>&nbsp;</td>
											<td>
												<fieldset style="width: 100%; border: 1px solid #DDD;">
													<legend>Notify errors?</legend>
													<span class="ibm-input-group"> <span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="csp_checkbox_err_notify1_id" value="Y"
															name="errNotify"
														/> <label class="ibm-field-label" for="csp_checkbox_err_notify1_id">Yes</label>
													</span> <span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="csp_checkbox_err_notify2_id" value="N" name="errNotify" /> <label
															class="ibm-field-label" for="csp_checkbox_err_notify2_id"
														>No</label>
													</span>
													</span>
												</fieldset>
											</td>
											<td></td>
										</tr>
										</fieldset>
										</td>
										</tr>


									</tbody>
								</table>
							</div>


							<!-- schedule tab content -->
							<div id="csp_schedule_id" class="ibm-tabs-content">
								<p class="ibm-callout">Set the schedule timing for scheduled
									reports</p>
								<br />
								<p id="csp_instruction_id"></p>
								<br />


								<table cellspacing="0" cellpadding="0" border="0" width="80%"
									class="" summary="table layout display">
									<thead>
										<tr>
											<th scope="col" style="display: none;">col1</th>
											<th scope="col" style="display: none;">col2</th>
											<th scope="col" style="display: none;">col3</th>
											<th scope="col" style="display: none;">col4</th>
										</tr>
									</thead>
									<tbody id="csp_schedule_body_id">


									</tbody>
								</table>



							</div>

							<!-- running log tab content -->
							<div id="csp_running_log_id" class="ibm-tabs-content">
								<table class='ibm-data-table ibm-altrows ibm-small' width="100%"
									cellspacing="0" cellpadding="0" border="0"
									summary="table layout display">
									<thead>
										<tr>
											<th scope="col">Running ID</th>
											<th scope="col">Start time</th>
											<th scope="col">Finish time</th>
											<th scope="col">Status</th>
											<th scope="col">Message</th>
											<th scope="col">Send Mail</th>
											<th scope="col">Publish</th>
											<th scope="col">Domain</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>




						</div>
					</div>
				</form>
			</div>
		</div>

	</div>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>


	<script type="text/javascript">
	//still use core existing schedules
	var cwa_id = '${requestScope.cwa_id}';
    var uid = '${requestScope.uid}';
	var core_site;
	var parameter_cwa_id;
	var parameter_uid;
	var domain_key;
	var parameter_report_id;
	var schedule_proxy_url;
	
	jQuery(document).ready(function() {
		var requestID=jQuery("#csp_requestID").val();
		var domainKey=jQuery("#csp_domainKey").val();
		var timeid = (new Date()).valueOf();

		jQuery("#promptsChangeFlag_id").val("N");
		
		//default action load cognos schedule
		var urlStr = "<%=request.getContextPath()%>/action/portal/schedulePanel/loadCognosSchedule/" + requestID + "/" + domainKey + "?timeid="+timeid;
		var action = jQuery("#csp_action").val();
		
		jQuery("#csp_new_schedule_id").val("N");
		//create new cognos schedule
		if (action == "create"){
			var domainKey = jQuery("#csp_domainKey").val();
  			var rptAccessID =jQuery("#rpt_access_id").val();
  			var searchPath = encodeURIComponent(jQuery("#search_path_id").val());
			urlStr = "<%=request.getContextPath()%>/action/portal/schedulePanel/createCognosSchedule?timeid="+timeid+"&rptAccessID=" +rptAccessID+"&domainKey="+domainKey +"&searchPath="+searchPath;
			jQuery("#csp_new_schedule_id").val("Y");
		}
		//copy cognos schedule
		if (action == "copy"){
			urlStr = "<%=request.getContextPath()%>/action/portal/schedulePanel/copyCognosSchedule/" + requestID + "?timeid="+timeid;
			jQuery("#id_span_show_message").html("Copied your schedule successfully!<br/>");
			jQuery("#id_span_show_message").css("color","#0000ff");
			jQuery("#csp_warnning_messge_id").html("Note this schedule has been suspended, please re-select its prompts by clicking the Change prompts button");
			jQuery("#csp_warnning_messge_id").css("color","red");
		}
		
		showLoading();  
		jQuery
		.ajax({
			type : "GET",
			url : urlStr,
			dataType : "json",
			success : function(data) {
				hideLoading(); 

				if(data.errMsg!==null && data.errMsg!=""){
					jQuery("#csp_tab_id").empty();
					jQuery("#csp_content_id").empty();
					jQuery("#cps_others_id").empty();
					jQuery("#cps_others_id").append(data.errMsg);
					jQuery("#csp_warnning_messge_id").empty();
					jQuery("#id_span_show_message").empty();
					return;
				}
				
				if(action!="copy" && data.childTBS=="Y"){
					jQuery("#id_span_show_message").css("color","#0000ff");
					jQuery("#csp_warnning_messge_id").html("Note: this is a chained child schedule, the changing to prompts, schedule will not work.");
					jQuery("#csp_warnning_messge_id").css("color","red");
				}

				if(data.requestStatus=="S"){
					jQuery("#csp_warnning_messge_id").html("Note this schedule has been suspended, please re-select its prompts by clicking the Change prompts button");
					jQuery("#csp_warnning_messge_id").css("color","red");
				}
				
				if(data.requestStatus=="D"){
					jQuery("#csp_warnning_messge_id").html("Note this schedule has been disabled, please remove this schedule.");
					jQuery("#csp_savebutton").attr('disabled', true);
					jQuery("#csp_warnning_messge_id").css("color","red");
				}
				
				core_site = data.cognosDownloadURL.substring("0",data.cognosDownloadURL.lastIndexOf("/"));
				parameter_cwa_id = data.cwaID;
				parameter_uid = data.uid;
				domain_key = data.domainKey;
				parameter_report_id = data.rptAccessID;	
				
				jQuery("#csp_report_name").append(data.rptName);
				//init hidden value
				jQuery("#csp_request_status_id").val(data.requestStatus);
				jQuery("#cwa_id").val(data.cwaID);
				jQuery("#uid_id").val(data.uid);
				jQuery("#search_path_id").val(data.searchPath);
				jQuery("#rpt_access_id").val(data.rptAccessID);
				jQuery("#csp_requestID").val(data.requestID);
				jQuery("#csp_domainKey").val(data.domainKey);
				jQuery("#core_site_id").val(core_site);
				jQuery("#csp_rds_url_id").val(data.rdsURL);
				jQuery("#csp_help_rpt_id").val(data.helpFileName);
				jQuery("#csp_proxy_id").val(data.proxyURL);
				jQuery("#csp_hidden_sched_freq_detail_id").val(data.schedFreqDetail);
				
				schedule_proxy_url = data.proxyURL;
				
				jQuery("#csp_rpt_type_id").val(data.cognosRPTTYPE);
				jQuery("#csp_rpt_name_id").val(data.rptName);
				jQuery("#csp_user_rpt_name_id").val(data.rptName);
				jQuery("csp_runnow_id").val(data.runNow);

				//set prompts value from DB
				jQuery("#csp_textarea_xmldata_hidden_id").val(data.xmlData);
				
				if(data.myRpt == true){
					jQuery("#csp_span_addFav_id").append("<img src='<%=request.getContextPath()%>/images/myrep_sel.gif' width='16' height='16' />This report has been added to 'My favorites'");
				}else{
					var link ="<a onclick='addFav()' onkeypress='addFav()' href='#'><img src='<%=request.getContextPath()%>/images/myrep.gif' width='16' height='16' />Add this report to 'My favorites'</a>";
					jQuery("#csp_span_addFav_id").append(link);
				}
				
	  			
	  			jQuery("#csp_requestID").val(data.requestID);
	  			requestID=jQuery("#csp_requestID").val();
	  			
				//create new cognos schedule
				var domainKey = jQuery("#csp_domainKey").val();
	  			var rptAccessID =jQuery("#rpt_access_id").val();
	  			var searchPath = encodeURIComponent(jQuery("#search_path_id").val());
	  			
	  			var referObjectid ='NULL';
	  			var create_url="<%=request.getContextPath()%>/action/portal/schedulePanel/createCognosSchedulePage?rptAccessID="+rptAccessID+"&domainKey="+domainKey +"&referObjectid="+referObjectid +"&searchPath="+searchPath;
	  			jQuery("#newSchedule_id").attr("href",create_url);
	  			
	  			if(requestID==null || requestID==""){
	  				requestID="NULL";
	  			}
	  			//existing cognos schedule for this report
	  			var existingCS_url="<%=request.getContextPath()%>/action/portal/schedulePanel/loadExistingSchedulePage/"+ rptAccessID +"/" +domainKey +"/"+requestID;
	  			jQuery("#existingCognosSchedule_id").attr("href",existingCS_url);
	  			
	  			//copy cognos schedule
	  			var copy_url="<%=request.getContextPath()%>/action/portal/schedulePanel/copyCognosSchedulePage/"+ requestID ;
	  			jQuery("#copySchedule_id").attr("href",copy_url);
				
	  			//run now
	  			if(data.runNow =="Y"){
	  				jQuery("#csp_runnow_id").attr("checked","checked");
	  			}else{
	  				jQuery("#csp_runnow_id").removeAttr("checked");
	  			}
				
				//priority
				if(data.offPeak=="A"){					
					var priority =  "<td style='padding:10px'><p class='ibm-form-elem-grp'><label>Priority  </label><span>";
					priority+="<select id='csp_priority_id' name='priorityLevel'>";
					priority+="<option value='A' selected>Off-peak by Admin</option>";
					priority+="</select></span></p></td>";
					jQuery("#csp_1stline_tr_id").append(priority);
					
				}else if (data.offPeak=="Y"){
					var priority = "<td style='padding:10px'><p class='ibm-form-elem-grp'><label>Priority  </label><span>";
					priority+="<select id='csp_priority_id' name='priorityLevel'>";
					priority+="<option value='H'>High</option>";
					priority+="<option value='M'>Medium</option>";
					priority+="<option value='L'>Low</option>";
					priority+="<option value='Y' selected>Off-peak</option>";
					priority+="</select></span></p><td>";
			        jQuery("#csp_1stline_tr_id").append(priority);
				}else{
					var priority = "<td style='padding:10px'><p class='ibm-form-elem-grp'><label>Priority  </label><span>";
					priority+="<select id='csp_priority_id' name='priorityLevel'>";
					priority+="<option value='H'>High</option>";
					priority+="<option value='M'>Medium</option>";
					priority+="<option value='L'>Low</option>";
					priority+="<option value='Y'>Off-peak</option>";
					priority+="</select></span></p><td>";
			        jQuery("#csp_1stline_tr_id").append(priority);
			        
		            if(data.priorityLevel=="H"){
		            	jQuery("#csp_priority_id option[value='H']").attr("selected", "selected"); 
		            }else if(data.priorityLevel=="M"){
		            	jQuery("#csp_priority_id option[value='M']").attr("selected", "selected");
		            }else if((data.priorityLevel=="L")){
		            	jQuery("#csp_priority_id option[value='L']").attr("selected", "selected");
		            }else{
		            	jQuery("#csp_priority_id option[value='L']").attr("selected", "selected");
		            }
				}
				
				//chain rpt setting
				if(data.isChainParentRpt=="Y"){
					var chain ="<td style='padding:10px'>Chained report controls  ";
					chain+="<select id='csp_chain_id' title='Parent' name='parentTBS'>";
					chain+="<option value='Y'>Run Parent and Child report</option>";
					chain+="<option value='N'>Do not run/create Child report</option>";
					chain+="<option value='D'>Do not run Parent report</option>";
					chain+="</select></span></p><td>";
					jQuery("#csp_1stline_tr_id").append(chain);
					if(data.parentTBS=="Y"){
		            	jQuery("#csp_chain_id option[value='Y']").attr("selected", "selected"); 
		            }else if(data.parentTBS=="N"){
		            	jQuery("#csp_chain_id option[value='N']").attr("selected", "selected");
		            }else if(data.parentTBS=="D"){
		            	jQuery("#csp_chain_id option[value='D']").attr("selected", "selected");
		            }else{
		            	jQuery("#csp_chain_id option[value='Y']").attr("selected", "selected"); 
		            }
									
				}else{
					var chain ="<td style='padding:10px;display:none'>Chained report controls  ";
					chain+="<select id='csp_chain_id' title='Parent' name='parentTBS' selected='selected'>";
					chain+="<option value='N'>Do not run/create Child report</option>";
					chain+="</select></span></p><td>";
					jQuery("#csp_1stline_tr_id").append(chain);
				}
				
				IBMCore.common.widget.selectlist.init("#csp_chain_id"); 
				IBMCore.common.widget.selectlist.init("#csp_priority_id"); 
			// cognos tab - prompts
			
			if(data.newSchedule==true){
				jQuery("#csp_change_prompts_button").text("Select prompts"); 
			}else{
				jQuery("#csp_change_prompts_button").text("Change prompts");
			}
			
			var xmlData ="";
			if(data.modifiedXmlData==null || data.modifiedXmlData=="undefined"){			
				xmlData="";
			}else{		
				xmlData=data.modifiedXmlData
			}
			var prompt_data = UrlDecode(xmlData);
			showXMLData(prompt_data);
			
			jQuery("#csp_textarea_xmldata_comments_id").text(data.comments);
			
			
			// cognos tab - outputformat
		
			jQuery
			.each(
					data.availableFormats,
					function(i, format) {
						var formats ="<tr><td>";
						if(data.outPutType==format.id.outputType){
							formats+="<input onclick='checkedOutPutType(this);' class='ibm-styled-radio' data-init='false' id='csp_format"+i+"_id' type='radio' checked=true name='outPutType' value='"+format.id.outputType+"' />";
							
						}else{
							formats+="<input onclick='checkedOutPutType(this);' class='ibm-styled-radio' data-init='false' id='csp_format"+i+"_id' type='radio' name='outPutType' value='"+format.id.outputType+"' />";
							
						}
						
						formats+="<label for='csp_format"+i+"_id'>"+format.typeDescription+"</label>";
						
						if(format.runOptions!=null && format.format!=""){
							formats+="&nbsp;&nbsp;<label style='background: none repeat scroll 0 0 #DDDDDD;color: #000000;' >Run Option:</label>&nbsp;&nbsp;";
							if(data.outPutType!=format.id.outputType){
								formats+="<span><select disabled id='csp_format_runoption_id' name='runOptions' style='width:100px'>";
							}else{
								formats+="<span><select id='csp_format_runoption_id' name='runOptions' style='width:100px'>";
							}
							
							var runOptionArray = format.runOptionsMapping;
							for(var i=0;i<runOptionArray.length;i++)
							{
								if(data.runOptions==runOptionArray[i][0])
									formats+="<option selected value='"+runOptionArray[i][0]+"'>"+runOptionArray[i][1]+"</option>";
								else	
							    	formats+="<option value='"+runOptionArray[i][0]+"'>"+runOptionArray[i][1]+"</option>"
							        
							    }
							formats+="</select></span>";
						}
						
						formats+="<td/><tr/>";
						
						jQuery("#csp_format_id").append(formats);
						
					});
			
			if (jQuery("#csp_format_id").html().indexOf("csp_format_runoption_id")>0){
				IBMCore.common.widget.selectlist.init("#csp_format_runoption_id"); 
			}
			
			
			// cognos tab - mail information
				

			var unsubscribePageLink ="<%=request.getContextPath()%>/action/portal/autodeck/unsubmanage/unsubscribePanel/" +data.requestID + "/C";
			jQuery("#csp_cognosUnsubscribepage_id").attr("onclick","openRDP('"+unsubscribePageLink+"')");
			jQuery("#csp_textarea_e_mail_address_id").append(data.eMailAddress);
			jQuery("#csp_text_e_mail_subject_id").val(data.eMailSubject);
			jQuery("#csp_email_comments_id").append(data.eMailComments);
			jQuery("#csp_text_backup_owner_id").val(data.backupOwner);
			if(data.sendMail=="N"){
				jQuery("#csp_checkbox_send_mail1_2id").attr("checked",true);
				jQuery('#csp_send_mailopton_id').hide();
			}else{
				jQuery("#csp_checkbox_send_mail1_id").attr("checked",true);
				jQuery('#csp_send_mailopton_id').show();
				jQuery('#csp_hide_creator_id').show();
				displayCompress();
			}
			
			jQuery("#csp_select_mail_option_id").empty();
			var str="";
			if(data.mailOption=="F"){
				str += "<option value='F' selected >Output file</option>";
				str += "<option value='L'  >Url for downloading</option>";
				str += "<option value='B'  >Output file and Url</option>";
				jQuery("#csp_select_mail_option_id").append(str);
			}
			else if(data.mailOption=="L"){
				str += "<option value='F'  >Output file</option>";
				str += "<option value='L' selected >Url for downloading</option>";
				str += "<option value='B'  >Output file and Url</option>";
				jQuery("#csp_select_mail_option_id").append(str);
			}
			else if(data.mailOption=="B"){
				str += "<option value='F'  >Output file</option>";
				str += "<option value='L'  >Url for downloading</option>";
				str += "<option value='B'  selected>Output file and Url</option>";
				jQuery("#csp_select_mail_option_id").append(str);
			}else{
				str += "<option value='F'  selected>Output file</option>";
				str += "<option value='L'  >Url for downloading</option>";
				str += "<option value='B'  >Output file and Url</option>";
				jQuery("#csp_select_mail_option_id").append(str);
			}
			
			if(data.compressResult=="Y"){
				jQuery("#csp_radio_compress_result1_id").attr("checked",true);
			}else{
				jQuery("#csp_radio_compress_result2_id").attr("checked",true);
			}
			
			if(data.hideCreator=="Y"){
				jQuery("#csp_radio_hide_creator_result1_id").attr("checked",true);
			}else{
				jQuery("#csp_radio_hide_creator_result2_id").attr("checked",true);
			}			
			
			if(data.errNotify=="N"){
				jQuery("#csp_checkbox_err_notify2_id").attr("checked",true);
			}else{
				jQuery("#csp_checkbox_err_notify1_id").attr("checked",true);
			}
			
			IBMCore.common.widget.selectlist.init("#csp_select_mail_option_id");
			displayCompress();
			
			// cognos tab - schedule information
			
			if(data.triggerType=="N"){
				jQuery("#csp_instruction_id").append("NRT report schedules are not eligible for automated triggering. Your Cognos Schedule Request will only be set to run when you select the 'Run now' option");
			}else{
				jQuery("#csp_instruction_id").append("Select the timing upon which you want your scheduled report to run using the Schedule frequency section <span>bel</span>ow. <br> Note that schedules are triggered to run upon the completion of the specified data load for the day(s) requested.");
			}
			
			if(data.triggerType=="W" || data.triggerType=="D" ){
				var str ="<tr>";
				str+="<td style='vertical-align: top; width: 45%;'>Schedule frequency:<span class='ibm-required'>*</span><br/><br/>";
				str+="Select the timing upon which you want your schedule to run.</td>";
				
				str+="<td style='vertical-align: top;''>";
				str+="<fieldset style='width:60%;border:1px solid #DDD;'><legend>Schedule frequency:<span class='ibm-required'>*</span></legend>";
				str+="<table cellspacing='0' cellpadding='0' border='0' width='100%' class='' summary='table layout display'>";
				//str+="<input type='hidden' id='csp_hidden_sched_freq_detail_id' value='"+ data.schedFreqDetail +"' name='schedFreqDetail' >";
				str+="<thead><tr>";
				str+="<th scope='col' style='display:none;'>col1</th><th scope='col' style='display:none;'>col2</th><th scope='col' style='display:none;'>col3</th><th scope='col' style='display:none;'>col4</th>";
				str+="</tr></thead>";
				str+="<tbody>";
				
				
				if(data.triggerType=="D"){
					str+="<tr>";
					str+="<td></td>";
					str+="<td style='vertical-align: top;'>";
					if(data.schedFreq=="D"){
						str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' checked onclick='MergeScheduleDateFreq2();' id='csp_radio_sched_freq2_id' value='D' name='schedFreq' />";
					}else{
						str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' onclick='MergeScheduleDateFreq2();' id='csp_radio_sched_freq2_id' value='D' name='schedFreq' />";
					}													
					str+="<label for='csp_radio_sched_freq2_id'>Daily</label>";
					str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>will run using close of business data from</div>";
					str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>the selected day(s).</div>"
					str+="</td>";
					
					str+="<td>";
					str+="<select multiple='multiple' onchange='MergeScheduleDateFreq2();' id='csp_D_sched_freq_detail2_id' title='Daily' size='4' name='D_sched_freq_detail'>";
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("M")!=-1){
						str+="<option selected value='M'>Monday</option>";
					}else{
						str+="<option value='M'>Monday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("Tu")!=-1){
						str+="<option selected value='Tu'>Tuesday</option>";
					}else{
						str+="<option value='Tu'>Tuesday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("W")!=-1){
						str+="<option selected value='W'>Wednesday</option>";
					}else{
						str+="<option value='W'>Wednesday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("Th")!=-1){
						str+="<option selected value='Th'>Thursday</option>";
					}else{
						str+="<option value='Th'>Thursday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("F")!=-1){
						str+="<option selected value='F'>Friday</option>";
					}else{
						str+="<option value='F'>Friday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("Sa")!=-1){
						str+="<option selected value='Sa'>Saturday</option>";
					}else{
						str+="<option value='Sa'>Saturday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("Su")!=-1){
						str+="<option selected value='Su'>Sunday</option>";
					}else{
						str+="<option value='Su'>Sunday</option>";
					}
					str+="</select>";
					str+="</td>";
					str+"<td></td>";
					str+="</tr>";
										
				}
				
				if(data.triggerType=="W"){
					str+="<tr>";
					str+="<td></td>";
					str+="<td>";
					if(data.schedFreq=="D" && data.schedFreqDetail=="M,Tu,W,Th,F,Sa,Su"){
						str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' checked onclick='MergeScheduleDateFreq();' id='csp_radio_sched_freq_id' value='D' name='schedFreq' />";
					}else{
						str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' onclick='MergeScheduleDateFreq();' id='csp_radio_sched_freq_id' value='D' name='schedFreq' />";
					}													
					str+="<label for='csp_radio_sched_freq_id'>Weekly</label>";
					str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>will run after selected data load trigger is set.</div>";
					str+="</td>";
					
					str+="<td style='display:none'>";
					str+="<select multiple='multiple' onchange='MergeScheduleDateFreq();' id='csp_D_sched_freq_detail_id' title='Daily' size='4' name='D_sched_freq_detail'>";
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("M")!=-1){
						str+="<option selected value='M'>Monday</option>";
					}else{
						str+="<option value='M'>Monday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("Tu")!=-1){
						str+="<option selected value='Tu'>Tuesday</option>";
					}else{
						str+="<option value='Tu'>Tuesday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("W")!=-1){
						str+="<option selected value='W'>Wednesday</option>";
					}else{
						str+="<option value='W'>Wednesday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("Th")!=-1){
						str+="<option selected value='Th'>Thursday</option>";
					}else{
						str+="<option value='Th'>Thursday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("F")!=-1){
						str+="<option selected value='F'>Friday</option>";
					}else{
						str+="<option value='F'>Friday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("Sa")!=-1){
						str+="<option selected value='Sa'>Saturday</option>";
					}else{
						str+="<option value='Sa'>Saturday</option>";
					}
					if(data.schedFreq=="D" && data.schedFreqDetail.indexOf("Su")!=-1){
						str+="<option selected value='Su'>Sunday</option>";
					}else{
						str+="<option value='Su'>Sunday</option>";
					}
					str+="</select>";
					str+="</td>";
					str+"<td></td>";
					str+="</tr>";
					
					str+="<tr><td colspan='4'>&nbsp;</td></tr>"
					
					str+="<tr>";
					str+="<td></td>";
					str+="<td style='vertical-align: top;'>";
					if(data.schedFreq=="D" && data.schedFreqDetail!="M,Tu,W,Th,F,Sa,Su"){
						str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' checked onclick='MergeScheduleDateFreq2();' id='csp_radio_sched_freq2_id' value='D' name='schedFreq' />";
					}else{
						str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' onclick='MergeScheduleDateFreq2();' id='csp_radio_sched_freq2_id' value='D' name='schedFreq' />";
					}
					str+="<label for='csp_radio_sched_freq2_id'>Selected day of the week</label>";
					str+="<div class='ibm-item-note' style='width:330px;text-indent:30px'>will run on the selected day(s) using the </div>";
					str+="<div class='ibm-item-note' style='width:330px;text-indent:30px'>then available weekly close of business data.</div>";
					str+="</td>";
					
					str+="<td>";
					if(data.schedFreqDetail=="M,Tu,W,Th,F,Sa,Su"){
						str+="<select  onchange='MergeScheduleDateFreq2();' id='csp_D_sched_freq_detail2_id' title='Weekly' size='4' name='D_sched_freq_detail'>";
						str+="<option value='M'>Monday</option>";
						str+="<option value='Tu'>Tuesday</option>";
						str+="<option value='W'>Wednesday</option>";
						str+="<option value='Th'>Thursday</option>";
						str+="<option value='F'>Friday</option>";
						str+="<option value='Sa'>Saturday</option>";
						str+="<option value='Su'>Sunday</option>";
						str+="</select>";
					}else{
						var selectedDay;
						if(data.schedFreqDetail.indexOf(',')==-1){
							selectedDay = data.schedFreqDetail;
						}
						else{
							selectedDay =  data.schedFreqDetail.substring(0,data.schedFreqDetail.indexOf(','));
						}
						
						jQuery("#csp_hidden_sched_freq_detail_id").val(selectedDay);
						
						str+="<select onchange='MergeScheduleDateFreq2();' id='csp_D_sched_freq_detail2_id' title='Weekly' size='4' name='D_sched_freq_detail'>";
						if(data.schedFreq=="D" && selectedDay=='M'){
							str+="<option selected value='M'>Monday</option>";
						}else{
							str+="<option value='M'>Monday</option>";
						}
						if(data.schedFreq=="D" && selectedDay=='Tu'){
							str+="<option selected value='Tu'>Tuesday</option>";
						}else{
							str+="<option value='Tu'>Tuesday</option>";
						}
						if(data.schedFreq=="D" && selectedDay=='W'){
							str+="<option selected value='W'>Wednesday</option>";
						}else{
							str+="<option value='W'>Wednesday</option>";
						}
						if(data.schedFreq=="D" && selectedDay=='Th'){
							str+="<option selected value='Th'>Thursday</option>";
						}else{
							str+="<option value='Th'>Thursday</option>";
						}
						if(data.schedFreq=="D" && selectedDay=='F'){
							str+="<option selected value='F'>Friday</option>";
						}else{
							str+="<option value='F'>Friday</option>";
						}
						if(data.schedFreq=="D" && selectedDay=='Sa'){
							str+="<option selected value='Sa'>Saturday</option>";
						}else{
							str+="<option value='Sa'>Saturday</option>";
						}
						if(data.schedFreq=="D" && selectedDay=='Su'){
							str+="<option selected value='Su'>Sunday</option>";
						}else{
							str+="<option value='Su'>Sunday</option>";
						}					
					
					}
					str+="</td>";
					str+="<td></td>";
					str+="</tr>";
					
				}
				
				//********************if(data.triggerType=="W"){"******************************
				
				if(data.triggerType=="W"){
					str+="<input type='hidden' id='csp_trigger_type_id' value='W' name='triggerType' >";
				}
				if(data.triggerType=="D"){
					str+="<input type='hidden' id='csp_trigger_type_id' value='D' name='triggerType' >";
				}
				
				
				str+="<tr><td colspan='4'>&nbsp;</td></tr>";
				
				//start month

				str+="<tr><td class=''></td>";
				str+="<td style='vertical-align: top;'>";
				if(data.schedFreq=="M"){
					str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' checked onclick='MergeScheduleDateFreqM();' id='csp_sched_freq_M_id' value='M' name='schedFreq' />";
				}else{
					str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' onclick='MergeScheduleDateFreqM();' id='csp_sched_freq_M_id' value='M' name='schedFreq' />";
				}
				str+="<label for='csp_sched_freq_M_id'>Monthly</label>";
				if(data.triggerType=="W"){
					str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>will run on the selected date(s) using the</div>";
					str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>available weekly close of business data.</div>";

				}
				if(data.triggerType=="D"){
					str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>will run using close of business data from</div>";
					str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>the selected date(s).</div>";

				}
				str+="</td>";
				
				str+="<td>";
				str+="<select multiple='multiple' onchange='MergeScheduleDateFreqM();' id='csp_M_sched_freq_detail_id' title='Monthly' size='4' name='M_sched_freq_detail'>";
				var schedFreqDetail = data.schedFreqDetail+",";
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("FM,")!=-1){
					str+="<option selected value='FM'>1st Mon</option>";
				}else{
					str+="<option value='FM'>1st Mon</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("FTu,")!=-1){
					str+="<option selected value='FTu'>1st Tue</option>";
				}else{
					str+="<option value='FTu'>1st Tue</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("FW,")!=-1){
					str+="<option selected value='FW'>1st Wed</option>";
				}else{
					str+="<option value='FW'>1st Wed</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("FTh,")!=-1){
					str+="<option selected value='FTh'>1st Thu</option>";
				}else{
					str+="<option value='FTh'>1st Thu</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("FF,")!=-1){
					str+="<option selected value='FF'>1st Fri</option>";
				}else{
					str+="<option value='FF'>1st Fri</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("FSa,")!=-1){
					str+="<option selected value='FSa'>1st Sat</option>";
				}else{
					str+="<option value='FSa'>1st Sat</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("FSu,")!=-1){
					str+="<option selected value='FSu'>1st Sun</option>";
				}else{
					str+="<option value='FSu'>1st Sun</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N1,")!=-1){
					str+="<option selected value='N1'>1st</option>";
				}else{
					str+="<option value='N1'>1st</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N2,")!=-1){
					str+="<option selected value='N2'>2nd</option>";
				}else{
					str+="<option value='N2'>2nd</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N3,")!=-1){
					str+="<option selected value='N3'>3rd</option>";
				}else{
					str+="<option value='N3'>3rd</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N4,")!=-1){
					str+="<option selected value='N4'>4th</option>";
				}else{
					str+="<option value='N4'>4th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N5,")!=-1){
					str+="<option selected value='N5'>5th</option>";
				}else{
					str+="<option value='N5'>5th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N6,")!=-1){
					str+="<option selected value='N6'>6th</option>";
				}else{
					str+="<option value='N6'>6th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N7,")!=-1){
					str+="<option selected value='N7'>7th</option>";
				}else{
					str+="<option value='N7'>7th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N8,")!=-1){
					str+="<option selected value='N8'>8th</option>";
				}else{
					str+="<option value='N8'>8th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N9,")!=-1){
					str+="<option selected value='N9'>9th</option>";
				}else{
					str+="<option value='N9'>9th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N10,")!=-1){
					str+="<option selected value='N10'>10th</option>";
				}else{
					str+="<option value='N10'>10th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N11,")!=-1){
					str+="<option selected value='N11'>11th</option>";
				}else{
					str+="<option value='N11'>11th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N12,")!=-1){
					str+="<option selected value='N12'>12th</option>";
				}else{
					str+="<option value='N12'>12th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N13,")!=-1){
					str+="<option selected value='N13'>13th</option>";
				}else{
					str+="<option value='N13'>13th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N14,")!=-1){
					str+="<option selected value='N14'>14th</option>";
				}else{
					str+="<option value='N14'>14th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N15,")!=-1){
					str+="<option selected value='N15'>15th</option>";
				}else{
					str+="<option value='N15'>15th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N16,")!=-1){
					str+="<option selected value='N16'>16th</option>";
				}else{
					str+="<option value='N16'>16th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N17,")!=-1){
					str+="<option selected value='N17'>17th</option>";
				}else{
					str+="<option value='N17'>17th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N18,")!=-1){
					str+="<option selected value='N18'>18th</option>";
				}else{
					str+="<option value='N18'>18th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N19,")!=-1){
					str+="<option selected value='N19'>19th</option>";
				}else{
					str+="<option value='N19'>19th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N20,")!=-1){
					str+="<option selected value='N20'>20th</option>";
				}else{
					str+="<option value='N20'>20th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N21,")!=-1){
					str+="<option selected value='N20'>21th</option>";
				}else{
					str+="<option value='N21'>21th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N22,")!=-1){
					str+="<option selected value='N22'>22th</option>";
				}else{
					str+="<option value='N22'>22th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N23,")!=-1){
					str+="<option selected value='N23'>23th</option>";
				}else{
					str+="<option value='N23'>23th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N24,")!=-1){
					str+="<option selected value='N24'>24th</option>";
				}else{
					str+="<option value='N24'>24th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N25,")!=-1){
					str+="<option selected value='N25'>25th</option>";
				}else{
					str+="<option value='N20'>25th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N26,")!=-1){
					str+="<option selected value='N26'>26th</option>";
				}else{
					str+="<option value='N26'>26th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N27,")!=-1){
					str+="<option selected value='N27'>27th</option>";
				}else{
					str+="<option value='N27'>27th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N28,")!=-1){
					str+="<option selected value='N28'>28th</option>";
				}else{
					str+="<option value='N28'>28th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N29,")!=-1){
					str+="<option selected value='N29'>29th</option>";
				}else{
					str+="<option value='N29'>29th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N30,")!=-1){
					str+="<option selected value='N30'>30th</option>";
				}else{
					str+="<option value='N30'>30th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("N31,")!=-1){
					str+="<option selected value='N31'>31th</option>";
				}else{
					str+="<option value='N31'>31th</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("LM,")!=-1){
					str+="<option selected value='LM'>Last Mon</option>";
				}else{
					str+="<option value='LM'>Last Mon</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("LTu,")!=-1){
					str+="<option selected value='LTu'>Last Tue</option>";
				}else{
					str+="<option value='LTu'>Last Tue</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("LW,")!=-1){
					str+="<option selected value='LW'>Last Wed</option>";
				}else{
					str+="<option value='LW'>Last Wed</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("LTh,")!=-1){
					str+="<option selected value='LTh'>Last Thu</option>";
				}else{
					str+="<option value='LTh'>Last Thu</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("LF,")!=-1){
					str+="<option selected value='LF'>Last Fri</option>";
				}else{
					str+="<option value='LF'>Last Fri</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("LSa,")!=-1){
					str+="<option selected value='LSa'>Last Sat</option>";
				}else{
					str+="<option value='LSa'>Last Sat</option>";
				}
				if(data.schedFreq=="M" && schedFreqDetail.indexOf("LSu,")!=-1){
					str+="<option selected value='LSu'>Last Sun</option>";
				}else{
					str+="<option value='LSu'>Last Sun</option>";
				}
				
				str+="</select>";
				str+="</td>";
				str+="<td></td>";
				str+="</tr>";
				// end month
				
				str+="<tr><td colspan='4'>&nbsp;</td></tr>";
				
				//business event
				if(data.triggerType=="W"){
					str+="<tr><td></td>";
					str+="<td style='vertical-align: top;'>";
					if(data.schedFreq=="B"){
						str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' checked onclick='MergeScheduleDateFreqB();' id='csp_sched_freq_B_id' value='B' name='schedFreq'>";
					}else{
						str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' onclick='MergeScheduleDateFreqB();' id='csp_sched_freq_B_id' value='B' name='schedFreq'>";
					}
					str+="<label for='csp_sched_freq_B_id'>Business event</label>";
					str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>will run on the selected week(s) using the </div>";
					str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>available weekly close of business data. </div>";
					str+="</td>";
					
					str+="<td>";
					str+="<select multiple='multiple' onchange='MergeScheduleDateFreqB();'	id='csp_B_sched_freq_detail_id' title='Business event' size='4'	name='B_sched_freq_detail'>";
					jQuery
					.each(
							data.availableEvents,
							function(i, event) {
								if(data.schedFreq=="B" && data.schedFreqDetail.indexOf(event.eventCD) !=-1){
									str+="<option selected value='"+event.eventCD+"'>"+ event.eventDesc +"</option>";
								}else{
									str+="<option value='"+event.eventCD+"'>"+ event.eventDesc +"</option>";
								}
								
									
							
							});
					str+="</select>";
					str+="</td>";
					
					str+="<td></td>";
					str+="</tr>";
				}
				
				str+="<input type='hidden' id='csp_curDate_id' value='"+data.currentDate+"' name='curDate'>";

				str+="<input type='hidden' id='csp_maxDaily_id' value='"+data.maxDaily+"' name='maxDaily'>";

				str+="<input type='hidden' id='csp_maxMonthly_id' value='"+data.maxMonthly+"' name='maxMonthly'>";

				str+="<input type='hidden' id='csp_maxBusiness_id' value='"+data.maxBusiness+"' name='maxBusiness'>";
				
				//end business event
				str+="<tr><td colspan='4'>&nbsp;</td></tr>";
				str+="</tbody>";
				str+="</table>";
				str+="</fieldset>";
				str+="</td><td style='width: 100%;'></td>";
				
				str+="</tr>";
				jQuery("#csp_schedule_body_id").append(str);
				//********************data.triggerType=="W" || data.triggerType=="D"******************************
				
			}
			
			//business event - trigger type B
			if(data.triggerType=="B"){
				var str ="<tr>";
				str+="<td style='vertical-align: top; width: 45%;'>Schedule frequency:<span class='ibm-required'>*</span><br/><br/>";
				str+="Select the timing upon which you want your schedule to run.</td>";
				
				str+="<td style='vertical-align: top;''>";
				str+="<fieldset style='width:60%;border:1px solid #DDD;'><legend>Schedule frequency:<span class='ibm-required'>*</span></legend>";
				str+="<table cellspacing='0' cellpadding='0' border='0' width='100%' class='' summary='table layout display'>";
				//str+="<input type='hidden' id='csp_hidden_sched_freq_detail_id' value='"+ data.schedFreqDetail +"' name='schedFreqDetail' >";
				str+="<thead><tr>";
				str+="<th scope='col' style='display:none;'>col1</th><th scope='col' style='display:none;'>col2</th><th scope='col' style='display:none;'>col3</th><th scope='col' style='display:none;'>col4</th>";
				str+="</tr></thead>";
				str+="<tbody>";
			
				str+="<tr><td></td>";
				str+="<td style='vertical-align: top;'>";
				if(data.schedFreq=="B"){
					str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' checked onclick='MergeScheduleDateFreqB();' id='csp_sched_freq_B_id' value='B' name='schedFreq'>";
				}else{
					str+="&nbsp;&nbsp;<input type='radio' class='ibm-styled-radio' onclick='MergeScheduleDateFreqB();' id='csp_sched_freq_B_id' value='B' name='schedFreq'>";
				}
				str+="<label for='csp_sched_freq_B_id'>Business event</label>";
				str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>will run on the selected week(s) using the </div>";
				str+="<div class='ibm-item-note' style='width:320px;text-indent:30px'>available weekly close of business data. </div>";
				str+="</td>";
				
				str+="<td>";
				str+="<select multiple='multiple' onchange='MergeScheduleDateFreqB();'	id='csp_B_sched_freq_detail_id' title='Business event' size='4'	name='B_sched_freq_detail'>";
				jQuery
				.each(
						data.availableEvents,
						function(i, event) {
							if(data.schedFreq=="B" && data.schedFreqDetail.indexOf(event.eventCD) !=-1){
								str+="<option selected value='"+event.eventCD+"'>"+ event.eventDesc +"</option>";
							}else{
								str+="<option value='"+event.eventCD+"'>"+ event.eventDesc +"</option>";
							}
							
								
						
						});
				str+="</select>";
				str+="</td>";
				
				str+="<td></td>";
				str+="</tr>";
				str+="<tr><td colspan='4'>&nbsp;</td></tr>";
				str+="</tbody>";
				str+="</table>";
				str+="</fieldset>";
				str+="</td><td style='width: 100%;'></td>";
				
				str+="</tr>";
				jQuery("#csp_schedule_body_id").append(str);
			}
			
			//trigger dataload
			var str2 ="";
			if(data.triggerType=="N"){
				str2+=" <input type='hidden' id='csp_trigger_type_id' value='N' name='triggerType' />";
			}
			 str2+="<tr><td colspan='4'>&nbsp;</td></tr>";
			if (data.triggerType!="N"){
				str2+="<tr>";
				
				str2+="<td style='vertical-align: top;'>";
				
				str2+="<label for='csp_trigger_cd_id'>Data load timing:<span class='ibm-required'>*</span>";
				str2+="<br/><br/>";
				str2+="Select the appropriate data load to trigger your schedule to run.";
				str2+="</label>";
				
				str2+="</td>";
				
				str2+="<td colspan='2' style='vertical-align: top;'>";
				
				str2+="<table width='100%' cellspacing='0' cellpadding='2' border='0' class='' summary='table layout display'>";
				str2+="<thead><tr>";
				str2+="<th scope='col' style='display:none;'>col1</th>";
				str2+="<th scope='col' style='display:none;'>col2</th>";
				str2+="<th scope='col' style='display:none;'>col3</th>";
				str2+="<th scope='col' style='display:none;'>col4</th>";
				str2+="</tr></thead>";
				str2+="<tbody>";
				str2+="<tr><td colspan='4'></td></tr>";
				
				str2+="<tr>";
				str2+="<td>";
				
				str2+="<select id='csp_trigger_cd_id' name='triggerCD' size='4'>";
				jQuery
				.each(
						data.availableTriggers,
						function(i, trigger) {
							if(data.triggerCD == trigger.id.triggerCD){
								str2+="<option selected value='"+trigger.id.triggerCD+"'>"+ trigger.triggerDesc +"</option>";
							}else{
								str2+="<option value='"+trigger.id.triggerCD+"'>"+ trigger.triggerDesc +"</option>";
							}	
						});
				str2+="</select>";
				
				str2+="</td>";
				str2+="<td></td>";
				
				str2+="</tr>";
				str2+="</tbody>";
				str2+="</table>"
				
				str2+="</td>";
				str2+="</tr>";
				
			}else{
				str2+="<select id='csp_trigger_cd_id' name='triggerCD' size='4' style='display:none'>";
				jQuery
				.each(
						data.availableTriggers,
						function(i, trigger) {
							if(data.triggerCD == trigger.id.triggerCD){
								str2+="<option selected value='"+trigger.id.triggerCD+"'>"+ trigger.triggerDesc +"</option>";
							}else{
								str2+="<option selected value='"+trigger.id.triggerCD+"'>"+ trigger.triggerDesc +"</option>";
							}	
						});
				str2+="</select>";
			}
			
			str2+="<tr><td colspan='4'>&nbsp;</td></tr>";
			str2+="<tr><td colspan='4'>&nbsp;</td></tr>";
			
			jQuery("#csp_schedule_body_id").append(str2);
			//end trigger dataload
			
			//start expiration date
			var str3="";
			
			if(data.triggerType=="W" || data.triggerType=="D" || data.triggerType=="B"){
				str3="<tr>";
				str3+="<td style='vertical-align: top;'>Expiration date:<span class='ibm-required'>*</span>";
				str3+="<br/><br/>";
				str3+="Set the expiration date for your schedule. After this date the schedule will no longer be triggered.";
				str3+="</td>";
				
				str3+="<td style='vertical-align: top; width: 20%;'>";
				str3+="<fieldset style='width:100%;border:1px solid #DDD;'><legend>Expiration date:<span class='ibm-required'>*</span></legend>";
				str3+="<table cellspacing='0' cellpadding='2' border='0' class='' summary='table layout display'>";
				str3+="<thead><tr>";
				str3+="<th scope='col' style='display:none;'>col1</th>";
				str3+="<th scope='col' style='display:none;'>col2</th>";
				str3+="<th scope='col' style='display:none;'>col3</th>";
				str3+="<th scope='col' style='display:none;'>col4</th>";
				str3+="</tr></thead>";
				str3+="<tbody>";
				str3+="<tr><td colspan='4'></td></tr>";
				
				str3+="<tr>";
				str3+="<td></td>";
				str3+="<td></td>";
				
				str3+="<td>";
				str3+="<label for='csp_ExpiringDate_Y_id'>&nbsp;&nbsp;Year&nbsp;&nbsp;</label>";
				str3+="<select id='csp_ExpiringDate_Y_id' name='ExpiringDate_Y' style='width:60px'>";
				
				for(var i=data.fromYear;i<data.toYear;i++){
					if(data.expiredYear==i){
						str3+="<option value='"+i+"' selected >"+i+"</option>";
					}else{
						str3+="<option value='"+i+"'>"+i+"</option>";
					}
					
				}
				
				str3+="</select>";
				
				
				str3+="<label for='csp_ExpiringDate_M_id'>&nbsp;&nbsp;Month&nbsp;&nbsp;</label>";
				str3+="<select  id='csp_ExpiringDate_M_id' name='ExpiringDate_M' style='width:50px'>";
				
				if(data.expiredMonth=='0'){
					str3+="<option value='01' selected >01</option>";
				}else{
					str3+="<option value='01' >01</option>";
				}
				if(data.expiredMonth=='1'){
					str3+="<option value='02' selected >02</option>";
				}else{
					str3+="<option value='02' >02</option>";
				}
				if(data.expiredMonth=='2'){
					str3+="<option value='03' selected >03</option>";
				}else{
					str3+="<option value='03' >03</option>";
				}
				if(data.expiredMonth=='3'){
					str3+="<option value='04' selected >04</option>";
				}else{
					str3+="<option value='04' >04</option>";
				}
				if(data.expiredMonth=='4'){
					str3+="<option value='05' selected >05</option>";
				}else{
					str3+="<option value='05' >05</option>";
				}
				if(data.expiredMonth=='5'){
					str3+="<option value='06' selected >06</option>";
				}else{
					str3+="<option value='06' >06</option>";
				}
				if(data.expiredMonth=='6'){
					str3+="<option value='07' selected >07</option>";
				}else{
					str3+="<option value='07' >07</option>";
				}
				if(data.expiredMonth=='7'){
					str3+="<option value='08' selected >08</option>";
				}else{
					str3+="<option value='08' >08</option>";
				}
				if(data.expiredMonth=='8'){
					str3+="<option value='09' selected >09</option>";
				}else{
					str3+="<option value='09' >09</option>";
				}
				if(data.expiredMonth=='9'){
					str3+="<option value='10' selected >10</option>";
				}else{
					str3+="<option value='10' >10</option>";
				}
				if(data.expiredMonth=='10'){
					str3+="<option value='11' selected >11</option>";
				}else{
					str3+="<option value='11' >11</option>";
				}
				if(data.expiredMonth=='11'){
					str3+="<option value='12' selected >12</option>";
				}else{
					str3+="<option value='12' >12</option>";
				}
				
				str3+="</select>";
				
				str3+="<label for='csp_ExpiringDate_D_id'>&nbsp;&nbsp;Day&nbsp;&nbsp;</label>";
				str3+="<select id='csp_ExpiringDate_D_id' name='ExpiringDate_D' style='width:50px'>";
		
				if(data.expiredDay=='1'){
					str3+="<option value='01' selected >01</option>";
				}else{
					str3+="<option value='01' >01</option>";
				}
				if(data.expiredDay=='2'){
					str3+="<option value='02' selected >02</option>";
				}else{
					str3+="<option value='02' >02</option>";
				}
				if(data.expiredDay=='3'){
					str3+="<option value='03' selected >03</option>";
				}else{
					str3+="<option value='03' >03</option>";
				}
				if(data.expiredDay=='4'){
					str3+="<option value='04' selected >04</option>";
				}else{
					str3+="<option value='04' >04</option>";
				}
				if(data.expiredDay=='5'){
					str3+="<option value='05' selected >05</option>";
				}else{
					str3+="<option value='05' >05</option>";
				}
				if(data.expiredDay=='6'){
					str3+="<option value='06' selected >06</option>";
				}else{
					str3+="<option value='06' >06</option>";
				}
				if(data.expiredDay=='7'){
					str3+="<option value='07' selected >07</option>";
				}else{
					str3+="<option value='07' >07</option>";
				}
				if(data.expiredDay=='8'){
					str3+="<option value='08' selected >08</option>";
				}else{
					str3+="<option value='08' >08</option>";
				}
				if(data.expiredDay=='9'){
					str3+="<option value='09' selected >09</option>";
				}else{
					str3+="<option value='09' >09</option>";
				}
				if(data.expiredDay=='10'){
					str3+="<option value='10' selected >10</option>";
				}else{
					str3+="<option value='10' >10</option>";
				}
				if(data.expiredDay=='11'){
					str3+="<option value='11' selected >11</option>";
				}else{
					str3+="<option value='11' >11</option>";
				}
				if(data.expiredDay=='12'){
					str3+="<option value='12' selected >12</option>";
				}else{
					str3+="<option value='12' >12</option>";
				}
				if(data.expiredDay=='13'){
					str3+="<option value='13' selected >13</option>";
				}else{
					str3+="<option value='13' >13</option>";
				}
				if(data.expiredDay=='14'){
					str3+="<option value='14' selected >14</option>";
				}else{
					str3+="<option value='14' >14</option>";
				}
				if(data.expiredDay=='15'){
					str3+="<option value='15' selected >15</option>";
				}else{
					str3+="<option value='15' >15</option>";
				}
				if(data.expiredDay=='16'){
					str3+="<option value='16' selected >16</option>";
				}else{
					str3+="<option value='16' >16</option>";
				}
				if(data.expiredDay=='17'){
					str3+="<option value='17' selected >17</option>";
				}else{
					str3+="<option value='17' >17</option>";
				}
				if(data.expiredDay=='18'){
					str3+="<option value='18' selected >18</option>";
				}else{
					str3+="<option value='18' >18</option>";
				}
				if(data.expiredDay=='19'){
					str3+="<option value='19' selected >19</option>";
				}else{
					str3+="<option value='19' >19</option>";
				}
				if(data.expiredDay=='20'){
					str3+="<option value='20' selected >20</option>";
				}else{
					str3+="<option value='20' >20</option>";
				}
				if(data.expiredDay=='21'){
					str3+="<option value='21' selected >21</option>";
				}else{
					str3+="<option value='21' >21</option>";
				}
				if(data.expiredDay=='22'){
					str3+="<option value='22' selected >22</option>";
				}else{
					str3+="<option value='22' >22</option>";
				}
				if(data.expiredDay=='23'){
					str3+="<option value='23' selected >23</option>";
				}else{
					str3+="<option value='23' >23</option>";
				}
				if(data.expiredDay=='24'){
					str3+="<option value='24' selected >24</option>";
				}else{
					str3+="<option value='24' >24</option>";
				}
				if(data.expiredDay=='25'){
					str3+="<option value='25' selected >25</option>";
				}else{
					str3+="<option value='25' >25</option>";
				}
				if(data.expiredDay=='26'){
					str3+="<option value='26' selected >26</option>";
				}else{
					str3+="<option value='26' >26</option>";
				}
				if(data.expiredDay=='27'){
					str3+="<option value='27' selected >27</option>";
				}else{
					str3+="<option value='27' >27</option>";
				}
				if(data.expiredDay=='28'){
					str3+="<option value='28' selected >28</option>";
				}else{
					str3+="<option value='28' >28</option>";
				}
				if(data.expiredDay=='29'){
					str3+="<option value='29' selected >29</option>";
				}else{
					str3+="<option value='29' >29</option>";
				}
				if(data.expiredDay=='30'){
					str3+="<option value='30' selected >30</option>";
				}else{
					str3+="<option value='30' >30</option>";
				}
				if(data.expiredDay=='31'){
					str3+="<option value='31' selected >31</option>";
				}else{
					str3+="<option value='31' >31</option>";
				}
				
				
				
				str3+="</select>";	
				
				//leoleo
				str3+="<input type='hidden' id='csp_expiration_date' value='' name='expirationDate'/>";
				str3+="</td>";
				str3+="<td></td>";
				
				str3+="</tr>";
				str3+="<tr><td colspan='4'>&nbsp;</td></tr>";
				
				str3+="</tbody>";
				str3+="</table>";
				str3+="</fieldset>";
				str3+="</td>";
				str3+="<td></td>";
				str3+="</tr>";
				
				
			}
			jQuery("#csp_schedule_body_id").append(str3);
			if(data.triggerType=="W" || data.triggerType=="D" || data.triggerType=="B"){
				IBMCore.common.widget.selectlist.init("#csp_ExpiringDate_Y_id"); 
				IBMCore.common.widget.selectlist.init("#csp_ExpiringDate_M_id"); 
				IBMCore.common.widget.selectlist.init("#csp_ExpiringDate_D_id"); 
			}

			
			//end expiration date
			// cognos tab - running history 
			var str4="";
			if(data.runningLogs !=null && data.runningLogs !="undefined" && data.runningLogs.length >0){
				jQuery("#csp_runninglog_tab_id").show();
				jQuery
				.each(
						data.runningLogs,
						function(i, log) {
							str4+="<tr>"
								
							if(log.status!=100 && log.status!=101 && log.status!=300){
								 str4+="<td class='ibm-numeric'> <a href='<%=request.getContextPath()%>/action/portal/schedulePanel/getErrLogPage/"+ log.runningId +"' target=_blank>"+log.runningId+"</a></td>";
							}else{
								//<A href="url_to_download_output %>?RUNNING_ID=csrl.getRunning_id() %>" target=_blank>csrl.getRunning_id() %></A>
								//str4+="<td class='ibm-numeric'> <a href='"+data.cognosDownloadURL+ "?RUNNING_ID=" + log.runningId + "' target=_blank>"+log.runningId+"</a></td>";
								 str4+="<td class='ibm-numeric'> <a href=<%=request.getContextPath()%>/action/portal/tbsoutputs/downLoadSignleTBSOutput/"+cwa_id+"/"+ uid +"/"+ log.runningId + " target=_blank>"+log.runningId+"</a></td>";
							}
							//format date
							var runTime = new Date(log.runTime).toGMTString();
							str4+="<td>"+runTime+"</td>";
							var doneTime = new Date(log.doneTime).toGMTString();
							str4+="<td>"+doneTime+"</td>";
							str4+="<td>"+log.status+"</td>";
							str4+="<td>"+log.messages+"</td>";
							str4+="<td>"+log.ifSendMail+"</td>";
							str4+="<td>"+log.ifPublish+"</td>";
							str4+="<td>"+log.displayName+"</td>";
							str4+="</tr>"
						});
				jQuery("#csp_running_log_id tbody").append(str4);
			}
			
			// end cognos tab - running history 
			
			
			},
			error: function (data) {
                alert('Call Ajax error !!!');
                jQuery("#csp_warnning_messge_id").html("Call Ajax error, please try again later or contact BI@IBM helpdeck.");
    			jQuery("#csp_warnning_messge_id").css("color","red");
    			hideLoading();
    			
            }
			
			
		});

	});
	
	
	function copyScheduleCheck(){
		var request_status = jQuery("#csp_request_status_id").val();
		var isNew = jQuery("#csp_new_schedule_id").val();
		if(request_status=='D'){
			alert('This schedule has been disabled, you can not copy it.');
			return false;
		}
		if(isNew=='Y'){
			alert('Please save this new schedule first.');
			return false;
		}
		return true;
	}
	
	function saveSchedule(){
		//validate
		var request_id = jQuery("#csp_requestID").val();
		if(request_id==null||request_id==""){
			alert("We are sorry for this, this schedule does not have a vaild request id, you need to close this page and try again");
			return false;
		}
		
		var xmlData = jQuery("#csp_textarea_xmldata_hidden_id").val();
		if(xmlData==null||xmlData==""){
			alert("Please choose prompt values");
			return false;
		}
		
		var output_type = jQuery("input[name='outPutType'][checked]");
		if(output_type==null||output_type=="undefined"){
			alert("Please choose output type");
			return false;
		}
	
		var email_address = jQuery("#csp_textarea_e_mail_address_id").val();
		if(email_address==null||email_address==""){
			alert("Please input e-Mail address");
			return false;
		}
		
		var email_subject = jQuery("#csp_text_e_mail_subject_id").val();
		if(email_subject==null||email_subject==""){
			alert("Please input e-Mail subject");
			return false;
		}
		
		var email_comments = jQuery("#csp_email_comments_id").val();
		if(email_comments.length>512)
		{  var overCount = email_comments.length-512;
		   alert("e-Mail comments characters over the limit(512), the current over "+ overCount + " characters");
		   return false;
		}
		
		var schedFreq = jQuery("input[name=schedFreq][checked]").val();
		var trigger_type = jQuery("#csp_trigger_type_id").val();
		if(schedFreq =='' || schedFreq == undefined){
			
			if(trigger_type !='N'){
				alert("please choose Schedule frequency");
				return false;
			}
			
		}
		
		var prompts_comments = jQuery("#csp_textarea_xmldata_comments_id").val();
		if(prompts_comments.length>512){
			var overCount = prompts_comments.length-512;
			alert("prompts comments characters over the limit(512), the current over "+ overCount + " characters");
			return false;
		}
		
		var promptsChangedFlag =jQuery("#promptsChangeFlag_id").val();
		var requestStatus = jQuery("#csp_request_status_id").val();
		if(promptsChangedFlag=="Y"){
			jQuery("#csp_request_status_id").val("A");
			jQuery("#csp_warnning_messge_id").empty();
		}
		
		//***********schedule******************
		
		var schedFreqDetail ="";
		if(schedFreq=="D" && trigger_type=="D"){
			schedFreqDetail =  jQuery("#csp_D_sched_freq_detail2_id").val();
		}
		if(schedFreq=="D" && trigger_type=="W"){
			schedFreqDetail = jQuery("#csp_hidden_sched_freq_detail_id").val();
		}
		if(schedFreq=="M"){
			schedFreqDetail =  jQuery("#csp_M_sched_freq_detail_id").val();
		}
		if(schedFreq=="B"){
			schedFreqDetail =  jQuery("#csp_B_sched_freq_detail_id").val();
		}

		
		if(schedFreqDetail=="" || schedFreqDetail==undefined){
			if(trigger_type !='N'){
				alert("please choose Schedule frequency");
				return false;
			}
		}
		
		jQuery("#csp_hidden_sched_freq_detail_id").val(schedFreqDetail);
		
		//*****************************
		
		
		var trigger_cd = jQuery("#csp_trigger_cd_id").val();
		if (trigger_type == 'W' || trigger_type == 'D'){
		
		}
		if(trigger_cd==null||trigger_cd=='undefined'){
			alert('Please choose Data load timing');
			return false;
		}
		
		
		var tmpUPDATE_E_mail_backup_cwa_id=jQuery("#csp_text_backup_owner_id").val();
		if(tmpUPDATE_E_mail_backup_cwa_id.length>128){

			alert("The maximum length for the Backup field is 128!");
			return false;
		}
		if(tmpUPDATE_E_mail_backup_cwa_id != "") {
		    var reg1_backup_cwaid = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
				if(!reg1_backup_cwaid.test(tmpUPDATE_E_mail_backup_cwa_id)){
					alert("please input the correct format for the Backup, like jdoe@us.ibm.com, \nAnd only can input one Backup e-Mail address.");
					return false;
				}
			}
		if(tmpUPDATE_E_mail_backup_cwa_id == jQuery("#cwa_id").val()) {
				alert("Input Backup should not be same as the owner e-Mail address of this TBS");
				return false;
		}
		
		if(jQuery("#csp_runnow_id").is(":checked")){
			jQuery("#csp_runnow_id").val("Y");
		}else{
			jQuery("#csp_runnow_id").val("N");
		}
		
		if(trigger_type!='N')
			MergeDate();
		var fromArr=jQuery("#csp_form_id").serializeArray();
		var obj = {};
		jQuery.each(fromArr, function() {
			if (obj[this.name] !== undefined) {
				if (!obj[this.name].push) {
					obj[this.name] = [obj[this.name]];
				}
				obj[this.name].push(this.value || '');
			} else {
				obj[this.name] = this.value || '';
			}
		}); 

		var timeid = (new Date()).valueOf();
		showLoading();
		jQuery.ajax({
			type : "POST",
			url : "<%=request.getContextPath()%>/action/portal/schedulePanel/saveCognosSchedule?timeid=" + timeid ,
			data : JSON.stringify(obj),
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				jQuery("#csp_requestID").val(data.requestID);
				var requestID = data.requestID;
				var rptAccessID = data.rptAccessID;
				var domainKey = data.domainKey;
				jQuery("#csp_runnow_id").val(data.runNow);
				var existingCS_url="<%=request.getContextPath()%>/action/portal/schedulePanel/loadExistingSchedulePage/"+ rptAccessID +"/" +domainKey +"/"+requestID;
	  			jQuery("#existingCognosSchedule_id").attr("href",existingCS_url);
	  			
	  			if(data.runNow =="Y"){
	  				jQuery("#csp_runnow_id").attr("checked","checked");
	  			}else{
	  				jQuery("#csp_runnow_id").removeAttr("checked");
	  			}
	  			jQuery("#csp_new_schedule_id").val("N");
			}
		})
		.done(function(){
			hideLoading();
			if(jQuery("#csp_runnow_id").val()=="Y"){
				document.getElementById('id_span_show_message').innerHTML='';
				document.getElementById('id_span_show_message').innerHTML='<font style="color:#0000ff">Saved your schedule successfully and has been submitted for execution!<br/></font>';
			}else{
				document.getElementById('id_span_show_message').innerHTML='';
				document.getElementById('id_span_show_message').innerHTML='<font style="color:#0000ff">Saved your schedule successfully!<br/></font>';
			}
			
			
			alert("Saved your schedule successfully!");
		})
		.fail(function(jqXHR, textStatus, errorThrown){		
			hideLoading();
			document.getElementById('id_span_show_message').innerHTML='';
			alert("Saved your schedule failed!");	
		})	
	}
	
	function MergeDate() {
		var yearValue = jQuery("#csp_ExpiringDate_Y_id").val();
		var monthValue = jQuery("#csp_ExpiringDate_M_id").val();
		var dayValue = jQuery("#csp_ExpiringDate_D_id").val();
	
		if ( !checkDate( yearValue,monthValue,dayValue) ) {
			alert( "Incorrect date" );
			jQuery("#csp_ExpiringDate_D_id option:eq(0)").attr("selected", "selected");
			return -1;
		}
		jQuery("#csp_expiration_date").val(yearValue + "-" + monthValue + "-" + dayValue);
	}
	
	function MergeScheduleDateFreq()
	{
		jQuery("#csp_radio_sched_freq2_id").removeAttr("checked");
		jQuery("#csp_sched_freq_M_id").removeAttr("checked");
		jQuery("#csp_sched_freq_B_id").removeAttr("checked");
		
		jQuery("#csp_radio_sched_freq_id").attr("checked","checked");
		jQuery("#csp_radio_sched_freq_id").prop("checked",true);
		jQuery("#csp_hidden_sched_freq_detail_id").val("M,Tu,W,Th,F,Sa,Su");
		
	
	}
	function MergeScheduleDateFreq2()
	{	
		jQuery("#csp_radio_sched_freq_id").removeAttr("checked");
		jQuery("#csp_sched_freq_M_id").removeAttr("checked");
		jQuery("#csp_sched_freq_B_id").removeAttr("checked");
		
		jQuery("#csp_radio_sched_freq2_id").attr("checked","checked");
		jQuery("#csp_radio_sched_freq2_id").prop("checked", true);
		var freqDetail = jQuery("#csp_D_sched_freq_detail2_id").val();
		jQuery("#csp_hidden_sched_freq_detail_id").val(freqDetail);

	
	}
	function MergeScheduleDateFreqM()
	{
		jQuery("#csp_radio_sched_freq_id").removeAttr("checked");
		jQuery("#csp_radio_sched_freq2_id").removeAttr("checked");
		jQuery("#csp_sched_freq_B_id").removeAttr("checked");
		
		jQuery("#csp_sched_freq_M_id").attr("checked","checked");
		jQuery("#csp_sched_freq_M_id").prop("checked",true);
		var freqDetail = jQuery("#csp_M_sched_freq_detail_id").val();
		jQuery("#csp_hidden_sched_freq_detail_id").val(freqDetail);
		
	}
	function MergeScheduleDateFreqB()
	{
		jQuery("#csp_radio_sched_freq_id").removeAttr("checked");
		jQuery("#csp_radio_sched_freq2_id").removeAttr("checked");
		jQuery("#csp_sched_freq_M_id").removeAttr("checked");
		
		jQuery("#csp_sched_freq_B_id").attr("checked","checked");
		jQuery("#csp_sched_freq_B_id").prop("checked",true);
		var freqDetail = jQuery("#csp_B_sched_freq_detail_id").val();
		jQuery("#csp_hidden_sched_freq_detail_id").val(freqDetail);	
	
	}
	
	function addFav(){
		var timeid = (new Date()).valueOf();
		var contentID = jQuery("#rpt_access_id").val();
		var domainKey = jQuery("#csp_domainKey").val();
		showLoading();
		jQuery.ajax({
			type : "POST",
			url : "<%=request.getContextPath()%>/action/portal/schedulePanel/addToMyFavorites?timeid=" + timeid ,
			data : {"contentID":contentID,"domainKey":domainKey}, 
			dataType : "json",
		})
		.done(function(){
			 hideLoading();
			jQuery("#csp_span_addFav_id").empty();
			jQuery("#csp_span_addFav_id").append("<img src='<%=request.getContextPath()%>/images/myrep_sel.gif' width='16' height='16' />This report has been added to 'My favorites'");
			alert("Add this report into My favorites successfully!");
		})
		.fail(function(jqXHR, textStatus, errorThrown){
			hideLoading();
			alert("Failed to add this report into My favorites!");		
		})	
	}
	
	function checkDate(Y, M, D) {
		 if ( D>getLastDay(M,Y) )
		   return (false);
		 if ( D<1 )
		   return (false);
		 return (true);
		}
	
	function getLastDay(M, Y) {
		 if ( M==1 ) return 31;
		 if ( M==2 ) {
		  if ( isLeapYear(Y) ) return 29;
		  else return 28;
		 }
		 if ( M==3 ) return 31;
		 if ( M==4 ) return 30;
		 if ( M==5 ) return 31;
		 if ( M==6 ) return 30;
		 if ( M==7 ) return 31;
		 if ( M==8 ) return 31;
		 if ( M==9 ) return 30;
		 if ( M==10 ) return 31;
		 if ( M==11 ) return 30;
		 if ( M==12 ) return 31;
		 //alert('*PromptServlet.WrongMonthVal*'+' '+M);
		 alert('PromptServlet_WrongMonthVal '+' '+M);
		 return 0;
		}
	function isLeapYear(Y) {
		 if ( Y%400 == 0 ) return true;
		 if ( Y%100 == 0 ) return false;
		 if ( Y%4   == 0 ) return true;
		 return (false);
		} // isLeapYear()
	function chooseOthers(){
		
	}
	
	
	function displayTemplate(src)
	{
	    if ( src==null )
	    {
	        alert('error occured loading data');
	        return -1;
	    }

		var outPutValue="";
		var srcRadio  = null;

		if ( src.type=='RADIO' || src.type=='radio' ) {
			 srcRadio = src;
			 outPutValue=srcRadio.value;

			if (outPutValue=='Y'){
				//send mail ,display options
				jQuery('#csp_send_mailopton_id').show();
				jQuery('#csp_hide_creator_id').show();
				displayCompress();
				}else if (outPutValue=='N'){
					jQuery('#csp_send_mailopton_id').hide();
				}else{
	 				alert('error occured loading data');
	       			return -1;
				}

		}
	}

	function displayCompress(){

	
	if(jQuery("#csp_select_mail_option_id").val()=='L'){

		jQuery('#csp_compress_id').hide();
	}else{
		jQuery('#csp_compress_id').show();

	}

	}
	
	
	function showXMLData(prompt_data){

		if(prompt_data==null||prompt_data==''){
			return -1;
		}
		prompt_data = prompt_data.replace(/rds:/g,'').replace(/:rds/g,'').replace(/&/g,'&amp;').replace(/&amp;amp;/g,'&amp;').replace(/&amp;lt;/g,'&lt;').replace(/&amp;gt;/g,'&gt;').replace(/&amp;apos;/g,'&apos;').replace(/&amp;quot;/g,'&quot;')
		prompt_data = prompt_data.replace(/\%26amp;/g,'&amp;').replace(/\%26lt;/g,'&lt;').replace(/\%26gt;/g,'&gt;').replace(/\%26apos;/g,'&apos;').replace(/\%26quot;/g,'&quot;');
		var xml_data = createXml(prompt_data);

		var json_bean =  xmlToJson(xml_data);
		//alert(JSON.stringify(json_bean));
		var strs = new Array();
		var ll = 0;
		if(json_bean.promptAnswers.promptValues){
			if(json_bean.promptAnswers.promptValues.length){
				for(var i=0;i<json_bean.promptAnswers.promptValues.length;i++){
					pp = generatePromptValues(json_bean.promptAnswers.promptValues[i]);
					strs[ll++] = pp;
				}
			}else{
				pp = generatePromptValues(json_bean.promptAnswers.promptValues);
				strs[ll++] = pp;
			}
		}else{
			strs[ll++]='You do not select any prompts or this report does not have any prompts.';
		}
		var inn = "<div><label style=\"display:none;\" for=\"textareaID\">accessibility</label><textArea id=\"textareaID\" readonly='true' rows=\"4\" cols=\"60\" style='overflow-y:scroll;overflow-x:hidden;height:120px;width:100%;' class='gray' >";
		inn+=strs.join("").toString()+"</textArea></div>";
	    document.getElementById('csp_show_xmldata_div_id').innerHTML = inn;
	}
	
	
	function UrlDecode(str) {
		var ret = "";
		for ( var i = 0; i < str.length; i++) {
			var chr = str.charAt(i);
			if (chr == "+") {
				ret += " ";
			} else if (chr == "%") {
				var asc = str.substring(i + 1, i + 3);
				if (parseInt("0x" + asc) > 0x7f) {
					ret += String.fromCharCode((parseInt("0x" + asc
							+ str.substring(i + 4, i + 6))));
					i += 5;
				} else {
					ret += String.fromCharCode((parseInt("0x" + asc)));
					i += 2;
				}
			} else {
				ret += chr;
			}
		}
		return ret;
	}
	
	//convert String to XML
	function createXml(str){
	  	if(document.all){
			var xmlDom=new ActiveXObject("Microsoft.XMLDOM");
			xmlDom.loadXML(str);
			return xmlDom;
		} else {
			return new DOMParser().parseFromString(str, "text/xml");
		}
	}
	
	// convert XML to JSON
	function xmlToJson(xml) {
		 // Create the return object
		 var obj = {};
		 if (xml.nodeType == 1) {
		 	// element
			// do attributes
			if (xml.attributes.length > 0) {
				obj["attributes"] = {};
				for (var j = 0; j < xml.attributes.length; j++) {
					 var attribute = xml.attributes.item(j);
					 obj["attributes"][attribute.nodeName] = attribute.nodeValue;
				}
			}
		 } else if (xml.nodeType == 3) {
		 	// text
			obj = xml.nodeValue;
		 }
		 // do children
		 if (xml.hasChildNodes()) {
			for(var i = 0; i < xml.childNodes.length; i++) {
				var item = xml.childNodes.item(i);
				var nodeName = item.nodeName;
				nodeName = nodeName.replace(/#/g,'');
				if (typeof(obj[nodeName]) == "undefined") {
					 obj[nodeName] = xmlToJson(item);
				} else {
					 if (typeof(obj[nodeName].length) == "undefined") {
						  var old = obj[nodeName];
						  obj[nodeName] = [];
						  obj[nodeName].push(old);
					 }
					 obj[nodeName].push(xmlToJson(item));
				}
			}
		 }
		 return obj;
	}
	
	function generatePromptValues(promptValue_data){
		//alert(JSON.stringify(promptValue_data));

			var pvd = new Array();
			var ss = 0;
			pvd[ss++]='-------------------------------------------------------------';
			pvd[ss++]='\n';
			pvd[ss++]="Parameter Name:";
			pvd[ss++]=promptValue_data.name.text;
			//alert(promptValue_data.name.text);
			pvd[ss++]='\n';
			//alert(promptValue_data.values.length);
			if(promptValue_data.values.item){
				if(promptValue_data.values.item.length){
					for( var n=0;n<promptValue_data.values.item.length;n++ ){
						if(promptValue_data.values.item[n].RangePValue){
							if(promptValue_data.values.item[n].RangePValue.start){
								if(promptValue_data.values.item[n].RangePValue.start.displayValue){
									pvd[ss++]=promptValue_data.values.item[n].RangePValue.start.displayValue.text;
								}else{
									pvd[ss++]=promptValue_data.values.item[n].RangePValue.start.useValue.text;
								}
							}
							if(promptValue_data.values.item[n].RangePValue.end){
								pvd[ss++]=' - ';
								if(promptValue_data.values.item[n].RangePValue.end.displayValue){
									pvd[ss++]=promptValue_data.values.item[n].RangePValue.end.displayValue.text;
								}else{
									pvd[ss++]=promptValue_data.values.item[n].RangePValue.end.useValue.text;
								}
							}
						}
						if(promptValue_data.values.item[n].SimplePValue){
							if(promptValue_data.values.item[n].SimplePValue.displayValue){
								if(promptValue_data.values.item[n].SimplePValue.displayValue.credential){
									if(promptValue_data.values.item[n].SimplePValue.displayValue.credential.dataSourceConnection){
										pvd[ss++]=promptValue_data.values.item[n].SimplePValue.displayValue.credential.dataSourceConnection.text;
									}
								}else{
									pvd[ss++]=promptValue_data.values.item[n].SimplePValue.displayValue.text;
								}
							}else{
								pvd[ss++]=promptValue_data.values.item[n].SimplePValue.useValue.text;
							}
						}
						pvd[ss++]='\n';
					}
				} else {
					if(promptValue_data.values.item.RangePValue){
						if(promptValue_data.values.item.RangePValue.start){
							if(promptValue_data.values.item.RangePValue.start.displayValue){
								pvd[ss++]=promptValue_data.values.item.RangePValue.start.displayValue.text;
							}else{
								pvd[ss++]=promptValue_data.values.item.RangePValue.start.useValue.text;
							}
						}
						if(promptValue_data.values.item.RangePValue.end){
							pvd[ss++]=' - ';
							if(promptValue_data.values.item.RangePValue.end.displayValue){
								pvd[ss++]=promptValue_data.values.item.RangePValue.end.displayValue.text;
							}else{
								pvd[ss++]=promptValue_data.values.item.RangePValue.end.useValue.text;
							}
						}
					}
					if(promptValue_data.values.item.SimplePValue){
						if(promptValue_data.values.item.SimplePValue.displayValue){
							if(promptValue_data.values.item.SimplePValue.displayValue.credential){
								if(promptValue_data.values.item.SimplePValue.displayValue.credential.dataSourceConnection){
									pvd[ss++]=promptValue_data.values.item.SimplePValue.displayValue.credential.dataSourceConnection.text;
								}
							}else{
								pvd[ss++]=promptValue_data.values.item.SimplePValue.displayValue.text;
							}
						}else{
							pvd[ss++]=promptValue_data.values.item.SimplePValue.useValue.text;
						}
					}
					pvd[ss++]='\n';
				}
			}
			pvd[ss++]='\n';
			return pvd.join("");
		}
	
	function checkedOutPutType(srcRadio){
		
		var formatValue = jQuery("#"+srcRadio.id).val();
		if(formatValue=="PDF"){
			jQuery("#csp_format_runoption_id").removeAttr("disabled");
		}else{
			jQuery("#csp_format_runoption_id").attr("disabled",true);
		}
			
	}
	
	function openRDP(url){
		window.open(url,'_blank','resizable=yes,toolbar=no,menubar=no,scrollbars=yes'+",ScreenX=0,ScreenY=0,top=0,left=0,width=" + screen.availWidth + ",height="+screen.availHeight);
		return false;
		}
	
	function pickUpPrompts(){		
		
		jQuery("#promptsChangeFlag_id").val("Y");
		var domain_key =jQuery("#csp_domainKey").val();
		var request_id =jQuery("#csp_requestID").val();
		var parameter_search_path =jQuery("#search_path_id").val();
		var parameter_rds_url = jQuery("#csp_rds_url_id").val();
		var isNew = jQuery("#csp_new_schedule_id").val();
		
		var timestamp_s=new Date().getTime();
		var getSessionRequest_url='';
		var getPromptsRequest_url='';
		var parameter_prompt_page_url = '';
		var parameter_session='';
		var error_msg = '';			
		
		document.getElementById('csp_change_prompts_button').disabled=true;
		document.getElementById('id_span_show_message').innerHTML='<font style="color:#0000ff">please wait.....<br/></font>';
		
		//first get user session for schedule proxy accessing
		window.status = "getting user session.....";
		document.getElementById('id_span_show_message').innerHTML='<font style="color:#0000ff">please wait, getting user session.....<br/></font>';
		getSessionRequest_url = "<%=request.getContextPath()%>/action/portal/schedulePanel/getSession";
		getSessionRequest_url +='?timeid='+timestamp_s+'&action=getSession&cwaid='+parameter_cwa_id+'&domain_key='+domain_key;
		
		jQuery.ajax({
			type : "GET",
			url : getSessionRequest_url,
			contentType : "application/json",
			dataType : "json",
			timeout : 0,
			async: false,
			success : function(data){
				error_msg = data['error'];
				parameter_session = data['session'];
				if(parameter_session==''||parameter_session==undefined){
					alert('Error, did not get user session id succesfully!'+error_msg);
					document.getElementById('csp_change_prompts_button').disabled=false;
					return false;
				}				
			},
			error : function(XMLHttpRequest, textStatus, errorThrown){
				alert("ERROR, please try again later or contact BI@IBM helpdesk. "+errorThrown);
				document.getElementById('csp_change_prompts_button').disabled=false;
				return false;				
			}
		
		})
		.fail(function(jqXHR, textStatus, errorThrown){	
			alert("ERROR, please try again later or contact BI@IBM helpdesk. "+errorThrown);
			document.getElementById('csp_change_prompts_button').disabled=false;
			return false;			
		})
		
		//get prompt page url
		window.status = "getting prompt page.....";
		document.getElementById('id_span_show_message').innerHTML='<font style="color:#0000ff">please wait, getting prompt page url.....<br/></font>';
		
		getPromptsRequest_url = "<%=request.getContextPath()%>/action/portal/schedulePanel/openPromptpage";
		getPromptsRequest_url +='?timeid='+timestamp_s;
		var csp = {};
		csp['cwaID'] = parameter_cwa_id;
		csp['uid'] = parameter_uid;
		csp['domainKey'] = domain_key;
		csp['rptAccessID'] = parameter_report_id;
		csp['requestID'] = request_id;
		csp['searchPath'] = parameter_search_path;
		csp['newSchedule'] = isNew=='Y'?true:false;
		jQuery.ajax({
			type : "POST",
			url : getPromptsRequest_url,
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify(csp),
			timeout : 0,
			async: true,
			success : function(data){
				
				document.getElementById('csp_change_prompts_button').disabled=false;
				
				error_msg = data['errMsg'];
				parameter_prompt_page_url = data['promptPageURL'];
				
				if(parameter_prompt_page_url==''||parameter_prompt_page_url==undefined){
					alert('Error, did not get prompt page url successfully! '+error_msg);
					return false;
				}
				
				var cam_passport = '';
				var usersessionid = '';
				var cea_ssa = '';
				var CRN = '';
				var userCapabilities = '';
				
				//getting cognos cookies
				if(schedule_proxy_url.indexOf('.jsp')>0){
					cam_passport = data['cam_passport'].replace(/&/g,'my_special_and').replace(/=/g,'my_special_equal');
					usersessionid = data['usersessionid'].replace(/&/g,'my_special_and').replace(/=/g,'my_special_equal');
					cea_ssa = data['cea_ssa'].replace(/&/g,'my_special_and').replace(/=/g,'my_special_equal');
					CRN = encodeURI(data['crn']).replace(/&/g,'my_special_and').replace(/=/g,'my_special_equal');
					userCapabilities = data['userCapabilities'].replace(/&/g,'my_special_and').replace(/=/g,'my_special_equal'); 					
				}else{
					cam_passport = encodeURI(data['cam_passport']);
					usersessionid = encodeURI(data['usersessionid']);
					cea_ssa = encodeURI(data['cea_ssa']);
					CRN = encodeURI(data['crn']);
					userCapabilities = encodeURI(data['userCapabilities']);					
				}
				//
				window.status = "opening report prompt page.....";
				document.getElementById('id_span_show_message').innerHTML='<font style="color:#0000ff">please wait, showing report prompt page.....</font>';
				var timestamp=new Date().getTime();
				
				var localhost =  window.location.protocol +'//' +window.location.host;
				var proxy_url = schedule_proxy_url + '?timeid='+timestamp+'&parameter_session='+parameter_session+'&parameter_cwa_id='+parameter_cwa_id+'&parameter_report_id='+parameter_report_id+'&parameter_rds_url='+encodeURI(parameter_rds_url);
				proxy_url += '&cognoscallbackproxy_url='+encodeURI(localhost+'/transform/biportal/action/portal/callbackproxy');
				proxy_url +='&parameter_prompt_page_url='+encodeURI(parameter_prompt_page_url);
				proxy_url +='&domain_key='+domain_key;
				proxy_url +='&cam_passport='+cam_passport;
				proxy_url +='&usersessionid='+usersessionid;
				proxy_url +='&cea_ssa='+cea_ssa;
				proxy_url +='&userCapabilities='+userCapabilities;
				proxy_url +='&CRN='+CRN;
				
				iframe = document.getElementById("id_frame_pickup_prompts");
				if(iframe == null){
					iframe = document.createElement('iframe');
					iframe.id = "id_frame_pickup_prompts";
					iframe.style.display = 'none';
					iframe.title = 'get_prompts';
					document.body.appendChild(iframe);
				}
				//iframe.src = proxy_url;
				//will not support http any more.
				//add special replacing for BACC context path bi01n
				iframe.src = proxy_url.replace(/http:/g,'https:').replace(/:80/g,':443').replace(/\/bi01n\//g,'\/bi01\/');
				document.getElementById('id_span_show_message').innerHTML='';
				document.getElementById('csp_change_prompts_button').disabled=false;				
			},
			error : function(XMLHttpRequest, textStatus, errorThrown){
				alert('Error, did not get prompt page url successfully! '+textStatus+':'+errorThrown);
				document.getElementById('csp_change_prompts_button').disabled=false;
				return false;
			}
		})
		.fail(function(jqXHR, textStatus, errorThrown){	
				alert("ERROR, please try again later or contact BI@IBM helpdesk. "+errorThrown);
				document.getElementById('csp_change_prompts_button').disabled=false;
				return false;
		})

		return false;
	}
	
	function callBackPromptSelected(responseText){
		//responseText = UrlDecode(responseText);
		responseText = decodeURI(responseText);
		responseText = responseText.replace(/rds:/g,'').replace(/:rds/g,'').replace(/&/g,'&amp;').replace(/&amp;amp;/g,'&amp;').replace(/&amp;lt;/g,'&lt;').replace(/&amp;gt;/g,'&gt;').replace(/&amp;apos;/g,'&apos;').replace(/&amp;quot;/g,'&quot;');
		responseText = responseText.replace(/\%26amp;/g,'&amp;').replace(/\%26lt;/g,'&lt;').replace(/\%26gt;/g,'&gt;').replace(/\%26apos;/g,'&apos;').replace(/\%26quot;/g,'&quot;');
		var rt = createXml(responseText);
		if(rt.childNodes==null){
			alert('You do not select any prompt values');
			return -1;
		}
		var cn = rt.childNodes;
		if(cn.length<1){
			return -1;
		}

		document.getElementById('csp_textarea_xmldata_hidden_id').value=responseText;
		prompt_data = responseText;
		showXMLData(prompt_data);

		//if prompt value is changed, the change the request status from suspend to active
		var status = document.getElementById("csp_request_status_id").value;
		if(status=='S'){
			document.getElementById("csp_request_status_id").value='A'
		}
		document.getElementById('id_span_show_message').innerHTML='<font style="color:#0000ff">Your schedule prompts value has been changed, please submit.<br/></font>';
		
		jQuery("#csp_change_prompts_button").text("Change prompts");
	}
	
	
	function openHelp(){
		  var url = jQuery("#csp_help_rpt_id").val();
		  RIWin = window.open(url,
		       "RptInfo","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=580,height=450,screenX=10,screenY=10");
		  RIWin.document.close();
		}

	function openHelp2(){
		 //var url = jQuery("#core_site_id").val()+"/help/helpIndex.jsp?page=pageHelp_cognosschedpanel.jsp";
		 var url = "<%=request.getContextPath()%>/action/portal/pagehelp?pageKey=CognosSchedulePanel&pageName=Cognos+schedule+panel";
		 setCookie("reportName","cognos schedule");
		 RIWin = window.open(url,"RptInfo","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=580,height=450,screenX=10,screenY=10");
		 RIWin.document.close();
	}
	
	function setCookie(name, value){
		cookie_path = " path=/;";
		document.cookie = name + '=' + value +';'+cookie_path;
	}
	
	function getCookie(c_name){
		if (document.cookie.length>0){
		    c_start=document.cookie.indexOf(c_name + "=");
		    if(c_start!=-1){
		        c_start=c_start + c_name.length+1;
		        c_end=document.cookie.indexOf(";",c_start);
		        if (c_end==-1){
		        	c_end=document.cookie.length;
		        }
		        //return unescape(document.cookie.substring(c_start,c_end));
		        return document.cookie.substring(c_start,c_end);
		    }
		}
		return "";
	}
	
	function showLoading() {
      	jQuery("#csp_loading_id").css({ 'display': 'block', 'opacity': '0.8' });                
        jQuery("#csp_ajax_loding_id").css({ 'display':'block','opacity':'0'});
      	jQuery("#csp_ajax_loding_id").animate({ 'margin-top': '300px', 'opacity': '1' }, 200);  
	}

	function hideLoading() {                 
		jQuery("#csp_loading_id").css({ 'display':'none'}); 
		jQuery("#csp_ajax_loding_id").css({ 'display':'none','opacity':'0'});            
	}
	
	</script>
</body>
</html>