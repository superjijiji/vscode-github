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
<title>Autodeck Edit Panel</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<link href="//1.www.s81c.com/common/v18/css/forms.css" rel="stylesheet">
<script src="//1.www.s81c.com/common/v18/js/forms.js"></script>


<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath() + "/javascript/autodeck_edit.js" %>" ></script>
<script type="text/javascript">
	var cwa_id = '${requestScope.cwa_id}';
	var uid = '${requestScope.uid}';
    var deck_id = '${requestScope.deck_id}';
     var autodeckPanel = new AutodeckPanel();
       function loadDeckbyId(deck_id) {
        
            var timeid = (new Date()).valueOf();
            jQuery("#auodeck_main").empty();
            jQuery.ajax({
                type: 'GET', url: '<%=path%>/action/portal/autodeck/edit/loaddeck/' + cwa_id + '/' + uid + '/' + deck_id + '?timeid=' + timeid,async:false,
                success: function (data) {
                console.log("Weclome to BIIBM autodeck panel");
                console.log(data);
                    
                      
                          autodeckPanel.loadDeck(data);
                          autodeckPanel.displayIntro();
                          autodeckPanel.loadTabs();
                          
                    
                  //  jQuery("#auodeck_main").html(autodeckPanel);
                },
                error: function (data) {
                    alert('Load deck - ajax return error!!!')
                }
            });
        }
	jQuery(document).ready(function() {

      loadDeckbyId(deck_id);

	});
</script>


</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>

<div class="ibm-columns">
			<div class="ibm-card">
				<div class="ibm-card__content">
					<strong class="ibm-h4">Autodeck edit panel</strong>
					<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
						<hr>
					</div>
					
					
						
					<table id="autodeck_intro_general" cellspacing="0" cellpadding="0" border="0" width="100%">
						<tbody>
							<tr>
								<td style="width: 85%;">
									<strong id="autodeck_intro_id" class="ibm-h4">Deck Id : <span id="deck_id">100000</span></strong>
									<br/><br/>
									
					<strong id="autodeck_intro_name" class="ibm-h4">Deck Name : <span id="deck_name">my deck abc</span></strong> 				
						<strong id="autodeck_intro_owner" class="ibm-h4">Owner : <span id="deck_owner">Wuyang@cn.ibm.com</span></strong>			
									<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
						<hr>
					</div>
									<strong class="ibm-h4">Step by step instructions for scheduling an Autodeck</strong>
									<br/><br/>
								</td>
								<td rowspan="2">
									
									<p class="ibm-ind-link" style="margin:0px; padding:0px;" >
									<a class="ibm-popup-link" style="margin-bottom: 1px;margin-bottom: 1px;padding-bottom: 1px;padding-top: 1px;"  onkeypress="openHelp2(); return false;" onclick="openHelp2(); return false;" href="#">
									Help for this page
									</a>
									</p>
									<span id="autodeck_span_addFav_id">

									</span>
								</td>
							</tr>
						</tbody>
					</table>
					
					
					<div id="autodeck_intro_desc" data-widget="showhide" class="ibm-simple-show-hide">
					    <div class="ibm-container-body">
					        <p class="ibm-show-hide-controls"><a href="#show" class="">Show descriptions</a> | <a href="#hide" class="ibm-active">Hide descriptions</a></p>
					        <div class="ibm-hideable">
					            <p>Use this edit panel to change the content and delivery information for this presentation deck.</p>
	<p>
		</p><ol>
			<li>Use the 'Edit requests' tab to select and sequence your desired content; use the 'Select more' link to add additional pages.</li>
			<li>Use the 'Output format' tab to select the desired format for your presentation deck.</li>
			<li>Click on the 'e-Mail information' tab to add appropriate recipients, e-Mail subject and introductory text.</li>
			<li>Click on the 'Schedule' tab to control the timing of status information updates and the creation of any Provisional Autodeck.</li>
			<li>After the Autodeck has been created for the first time, the 'Configuration template' tab will appear.  Use this tab to adjust the specific worksheet ranges you want to appear in your final presentation deck.</li>
			<li>Once your Autodeck request has processed an additional tab showing recent 'Schedule history' will appear</li>			
		</ol>
	<p></p>
					        </div>
					     
						</div>
						
						<div id="autodeck_content_id">
							<p style="padding-top: 0px;">Note that all required fields are marked with an asterisk (<span class="ibm-required">*</span>).   </p>
							
							<table id="autodeck_1stline_id">
								<tr id="autodeck_1stline_tr_id">
									<td style="padding:10px"><input type="button" id="autodeck_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="saveSchedule()" value="Submit" /></td>									
									<td style="padding:10px"></td>
								</tr>
							</table>
							
						</div>
							
						
						<div id ="autodeck_tab_id" data-widget="dyntabs" class="ibm-graphic-tabs">
							<!-- Tabs here: -->
						    <div class="ibm-tab-section">
						        <ul class="ibm-tabs" role="tablist">
						            <li><a aria-selected="true" role="tab" href="#autodeck_requests_id">Edit requests</a></li>
						            <li><a role="tab" href="#autodeck_outputformat_id">Output format</a></li>
						            <li><a role="tab" href="#autodeck_emailinformation_id">e-Mail information</a></li>
						            <li><a role="tab" href="#autodeck_schedule_id">Schedule</a></li>
						              <li><a role="tab" href="#autodeck_config_temp_id">Configuration template</a></li>
						                <li><a role="tab" href="#autodeck_config_base_id">Base configuration</a></li>
						                 <li><a role="tab" href="#autodeck_schedule_history_id">Schedule history</a></li>
						          
						        </ul>
						    </div>
						    
						    
						    <!-- Tabs contents divs: -->
						    
						    <!-- prompts tab content -->
						    <div id="autodeck_requests_id" class="ibm-tabs-content">
						    <p class="ibm-callout">Select/Edit report request</p><br/>

							<label for="autodeck_label_select_id">Your Selected requests:</label><BR>
			        		<br/>
			        		<table id="selected_requests_id" 	 class="display" cellspacing="0" cellpadding="0" border="0" summary="request_table">
    <caption class="ibm-access">This is the table caption.</caption>
    <thead>
        <tr>
             <th></th>
            <th scope="col">Report Name/File Name</th>
            <th scope="col">e-Mail Subject/File description</th>
            <th scope="col">Frequency</th>
            <th scope="col">Datamart/Data Load</th>
            <th scope="col">Expiration Date</th>
            <th scope="col">Domain Key</th>
            <th scope="col">State</th>
            <th scope="col">Comments</th>
            <th scope="col">Request ID</th>
             <th scope="col">Type</th>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
     <tfoot>
      <tr>
         <th></th>
            <th >Report Name/File Name</th>
            <th >e-Mail Subject/File description</th>
            <th >Frequency</th>
            <th >Datamart/Data Load</th>
            <th >Expiration Date</th>
            <th >Domain Key</th>
            <th>State</th>
            <th >Comments</th>
            <th >Request ID</th>
             <th scope="col">Type</th>
      </tr>
   </tfoot>
</table>
<p id="requests_operation" class="ibm-ind-link">
<a class="ibm-anchor-up-link" id="autodeck_href_showa1" name="autodeck_href_showa1"  style="font-weight:normal">Move up</a>
|<a id="autodeck_href_showa2" name="autodeck_request_down" class="ibm-anchor-down-link" style="font-weight:normal"  href="#t1">Move down</a>
|<a id="autodeck_href_showa3" name="autodeck_href_more" class="ibm-popup-link" href="#dialogOne">Select more</a>
|<a id="autodeck_href_showa4" name="autodeck_href_delete" class="ibm-delete-link" href="#t1">Delete</a>
</p>
						    </div>
						    
						    <!-- output format tab content -->
						    <div id="autodeck_outputformat_id" class="ibm-tabs-content">
							    <p class="ibm-callout">Select an output format and file name</p><br/>
							    <div class="ibm-col-medium-6-4 ibm-left-block">
				   <form id="autodeck_outputformat_form_id" class="ibm-column-form" method="post" action="#">
    <p>
        <label for="deck_name">Specify presentation deck file name:<span class="ibm-required">*</span></label>
        <span>
            <input type="text" value="" size="40" id="deck_name_id" name="deck_name_name">
            <a class="ibm-information-link" href="#" onclick="alert('Some custom popup or tooltip goes here.');return false;" title="Information link">Information</a>
        </span>
    </p>
    <p class="ibm-form-elem-grp">
        <label>Send the generated file as:</label>
        <span>
            <select id="target_file_type_id">
               
                <option value="LINK">link</option>
                <option value="ATTACHMENT">attachment</option>
               
            </select>
        </span>
    </p>

    <p class="ibm-form-elem-grp">
        <label class="ibm-form-grp-lbl" id="labe_id_output">Append date to output:</label>
        <span class="ibm-input-group ibm-radio-group">
            <input id="append_data_id_n" name="radiogrp2" type="radio" value="N" /> <label for="append_data_id_n">No</label>
            <br /><input id="append_data_id_y" name="radiogrp2" type="radio" value="Y" /> <label for="append_data_id_y">Yes</label>

     <br />
        </span>
    </p>
    
     <p class="ibm-form-elem-grp">
        <label class="ibm-form-grp-lbl" id="labe_id_output_type_id">Select required output file type::</label>
        <span class="ibm-input-group ibm-radio-group">
            <input id="targettype_id_ppt" name="radiogrp2" type="radio" value="2" /> <label for="targettype_id_ppt">ppt</label>
            <br /><input id="targettype_id_xls" name="radiogrp2" type="radio" value="1" /> <label for="targettype_id_xls">xls</label>
  <br /><input id="targettype_id_xlsx" name="radiogrp2" type="radio" value="3" /> <label for="targettype_id_xlsx">xlsx</label>
     <br />
        </span>
    </p>
  
</form>
							    
							 
						    	 
						    </div>
</div>						    
						    <!-- email tab content -->
						    
						    <div id="autodeck_emailinformation_id" class="ibm-tabs-content">
						    <p class="ibm-callout">Enter your e-Mail information for e-Mails and schedules</p><br/>
						    Enter your chosen recipients. The e-Mail itself can be customized by modifying the subject and adding your own comments to the note.
						    <br/><br/>
						    
						    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="" summary="table layout display">
								<thead>
									<tr>
										<th scope="col" style="display:none;">col1</th>
										<th scope="col" style="display:none;">col2</th>
										<th scope="col" style="display:none;">col3</th>
										<th scope="col" style="display:none;">col4</th>
									</tr>
								</thead>
								<tbody>
									<tr valign="top">
										<td style="width: 15px; height: 1px;"></td>
										<td style="width: 25%;"><label for="id_textarea_e_mail_address">Enter your e-Mail address and/or <a id="myDistribution" name="myDistribution" href="/transform/edge/EODMain.wss?component=distList">distribution list(s)</a>:<span class="ibm-required">*</span></label></td>
										<td style="width: 20%;vertical-align: top;">
										<textarea  id="csp_textarea_e_mail_address_id" rows="4" cols="60" name="eMailAddress"></textarea>
										</td>
										<td style="width: 55%; text-align: left; vertical-align: top;">&nbsp;&nbsp;(Enter up to 12 e-Mail addresses separated by spaces.)
										<br>
										<br>
										<span class="ibm-item-note">&nbsp;&nbsp;(e.g. jdoe@us.ibm.com mydistlist)</span>
										<br>
										<br>
										
									    <a id="csp_cognosUnsubscribepage_id" class="ibm-feature-link"  href="#" name="id_cognosUnsubscribepage">&nbsp;Show unsubscribe list</a>
									</tr>
									
									<tr>
										<td style="height: 15px;"></td>
									</tr>
									
									<tr valign="top">
										<td style="height: 1px;"></td>
										<td><label for="csp_text_e_mail_subject_id">e-Mail subject:<span class="ibm-required">*</span></label></td>
										<td>
										<input type="text" id="csp_text_e_mail_subject_id" onkeypress="if ( event.keyCode == 13 ) return false; else if ( event.which == 13 ) return false; else return true;"	maxlength="90" size="60" name="eMailSubject"  />
										</td>
										<td>(Text for subject line of e-Mail)</td>
									</tr>
																		
									<tr>
										<td style="height: 15px;"></td>
									</tr>
									
									<tr valign="top">
										<td style="height: 1px;">&nbsp;</td>
										<td><label for="id_email_comments">Enter your e-Mail comments:</label></td>
										<td style="vertical-align: top;"><textarea id="csp_email_comments_id" rows="4" cols="60" name="eMailComments" ></textarea>
										</td>
										<td>&nbsp;&nbsp;(will be included in the e-Mail body)</td>
									</tr>
									
									<tr valign="top">
										<td style="height: 1px;"></td>
										<td><label for="id_text_backup_owner">Backup:</label></td>
										<td>
										<input type="text" id="csp_text_backup_owner_id" maxlength="128" size="60" name="backupOwner" value="" >
										</td>
										<td><span class="ibm-item-note">(e.g. jdoe@us.ibm.com) Please make sure the backup has proper access to your TBS</span></td>
									</tr>
									
									<tr>
										<td style="height: 15px;"></td>
									</tr>
									
									<tr valign="top">
										<td style="height: 1px;"></td>
										<td>&nbsp;</td>
										<td>
											<fieldset style="width:100%;border:1px solid #DDD;">
												
												<legend>Mail options:</legend>
												
												 	<label>Send mail? </label>
													<span class="ibm-input-group">
														<span class="ibm-radio-wrapper">
														<input class="ibm-styled-radio" type="radio" id="csp_checkbox_send_mail1_id" onclick="displayTemplate(this);" value="Y" name="sendMail"/>
														<label  class="ibm-field-label" for="csp_checkbox_send_mail1_id">Yes</label>
														</span>
														<span class="ibm-radio-wrapper">
														<input class="ibm-styled-radio" type="radio" id="csp_checkbox_send_mail1_2id"  onclick="displayTemplate(this);" value="N" name="sendMail" />
														<label  class="ibm-field-label" for="csp_checkbox_send_mail1_2id">No</label>
														</span>
													</span>
													<br /><br />
													
													<div id='csp_send_mailopton_id'>
														Mail type:
														
														<select id="csp_select_mail_option_id"  onChange="displayCompress()" name="mailOption"  >
															<option value="F" >Output file</option>
															<option value="L" >Url for downloading</option>
															<option value="B" >Output file and Url</option>
														</select>
														
														<br /><br />
											
														<div id='csp_compress_id'>
															<span>Compressed(zip) file:</span>
															<span class="ibm-input-group">
																<span class="ibm-radio-wrapper">
																<input class="ibm-styled-radio" type="radio" id="csp_radio_compress_result1_id"  value="Y" name="compressResult"/>
																<label class="ibm-field-label" for="csp_radio_compress_result1_id">Yes</label>
																</span>
																<span class="ibm-radio-wrapper">
																<input class="ibm-styled-radio" type="radio" id="csp_radio_compress_result2_id"  value="N" name="compressResult"/>
																<label class="ibm-field-label" for="csp_radio_compress_result2_id">No</label>
																</span>
															</span>
														</div>
												
														<!-- dispaly creator info from mail subject -->
														<br />
														<div id='csp_hide_creator_id' >
														<span>Show SMS SOM Support Team info?</span>
														<span class="ibm-input-group">
															<span class="ibm-radio-wrapper">
															<input class="ibm-styled-radio" type="radio" id="csp_radio_hide_creator_result1_id" value="Y" name="hideCreator" />
															<label class="ibm-field-label" for="csp_radio_hide_creator_result1_id">Yes</label>
															</span>
															<span class="ibm-radio-wrapper">
															<input class="ibm-styled-radio" type="radio" id="csp_radio_hide_creator_result2_id"  value="N" name="hideCreator" />
															<label class="ibm-field-label"  for="csp_radio_hide_creator_result2_id">No</label>
															</span>
														</span>
														</div>
											
													</div>
													
													<br />
													
													</fieldset>
													
													<td style="vertical-align: bottom">
														<span  class="ibm-item-note" style="font-size:12px">&nbsp;&nbsp;(Changes "Requested by" information in e-Mail subject and adds link to SMS SOM Support Team)</span>
													</td>
													</td>
													<td></td>
												</tr>
												
												<tr valign="top">
													<td style="height: 1px;"></td>
													<td>&nbsp;</td>
													<td>
													<fieldset style="width:100%;border:1px solid #DDD;">
														<legend>Notify errors?</legend>
														<span class="ibm-input-group">
														<span class="ibm-radio-wrapper">
														<input class="ibm-styled-radio" type="radio" id="csp_checkbox_err_notify1_id" value="Y" name="errNotify" />
														<label class="ibm-field-label"  for="csp_checkbox_err_notify1_id">Yes</label>
														</span>
														<span class="ibm-radio-wrapper">
														<input class="ibm-styled-radio" type="radio" id="csp_checkbox_err_notify2_id" value="N" name="errNotify" />
														<label class="ibm-field-label"  for="csp_checkbox_err_notify2_id">No</label>
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
																    
																    
												<!-- config tab -->				    
												<div id="autodeck_config_temp_id" class="ibm-tabs-content">
													 <p class="ibm-callout">Set the schedule timing for scheduled reports</p><br/>	
													 <p id="csp_instruction_id"></p><br/>		
												

												<table cellspacing="0" cellpadding="0" border="0" width="80%" class="" summary="table layout display">
													<thead>
														<tr>
															<th scope="col" style="display:none;">col1</th>
															<th scope="col" style="display:none;">col2</th>
															<th scope="col" style="display:none;">col3</th>
															<th scope="col" style="display:none;">col4</th>
														</tr>
													</thead>
													<tbody id="csp_schedule_body_id">
														
														
													</tbody>
												</table>
												

												
												</div>
													<!-- base config tab content -->				    
												<div id="autodeck_config_base_id" class="ibm-tabs-content">
													 <p class="ibm-callout">Set the schedule timing for scheduled reports</p><br/>	
													 <p id="csp_instruction_id"></p><br/>		
												

												<table cellspacing="0" cellpadding="0" border="0" width="80%" class="" summary="table layout display">
													<thead>
														<tr>
															<th scope="col" style="display:none;">col1</th>
															<th scope="col" style="display:none;">col2</th>
															<th scope="col" style="display:none;">col3</th>
															<th scope="col" style="display:none;">col4</th>
														</tr>
													</thead>
													<tbody id="csp_schedule_body_id">
														
														
													</tbody>
												</table>
												

												
												</div>
					
												<!-- running log tab content -->				    
												<div id="autodeck_schedule_history_id" class="ibm-tabs-content">
													<table class="ibm-data-table" cellspacing="0" cellpadding="0" border="0" summary="table layout display">
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
					

			<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
				</div>
		    </div>
		  
		   </div>
		   </div>
		   
	    </div>
</body>
</html>