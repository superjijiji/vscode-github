<!-- Author Meng Min -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.net.*"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM | My Autodeck schedules - Create an Autodeck</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<style type="text/css">
table.dataTable thead .sorting, table.dataTable thead .sorting_asc,
	table.dataTable thead .sorting_desc {
	background-repeat: no-repeat;
	background-position: center right
}

table.dataTable thead .selectallcolumn {
	background-repeat: no-repeat;
	background-position: 1000px;
	width: 1px;
}

table.dataTable thead .sorting {
	background: none
}

.dataTable{
	text-align: left; 
}

</style>
</head>

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-fluid" style="padding-left: 20px;">
		<div id="domain_id" style="float: left;">
			<h1 class="ibm-h1 ibm-light" style="padding: 0px;">My Autodeck
				schedules - Create an Autodeck&nbsp;</h1>
		</div>
		<div class="tbs_list_page_title">
			<p class="ibm-ind-link ibm-icononly ibm-inlinelink"
				style="padding-bottom: 0px;">
				<a class="ibm-information-link" target="_blank"
					href="<%=path%>/action/portal/pagehelp?pageKey=MyAutodeckCreate&pageName=My+Autodeck+schedules+-+Create+an+Autodeck"
					title="Help for My Autodeck schedules - Create an Autodeck">
					Help for My Autodeck schedules </a>
			</p>
		</div>
	</div>
	<div class="ibm-fluid">
		<div class="ibm-col-12-2 ibm-col-medium-12-3 ibm-hidden-small">
			<jsp:include page="/WEB-INF/portal/autodeck_navigator.jsp"></jsp:include>
		</div>
		<div id="autodeck_loading_id"
			style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 998; width: 100%; height: 100%; _padding: 0 20px 0 0; background: #f6f4f5; display: none;"></div>
		<div id="autodeck_ajax_loding_id"
			style="position: fixed; top: 0; left: 50%; z-index: 9999; opacity: 0; filter: alpha(opacity = 0); margin-left: -80px;">
			<div>
				<img src='<%=request.getContextPath()%>/images/ajax-loader.gif' />
			</div>
		</div>
		<div class="ibm-col-12-10 ibm-col-medium-12-9">

			<p class="ibm-h5 ibm-light ibm-padding-top-1">Use this page to
				specify your required presentation deck content and delivery
				information</p>
			<br />

			<form action="__REPLACE_ME__" class="ibm-column-form"
				id="adp_form_id" method="post">
				<p class="ibm-form-elem-grp">
					<label><strong>Select required output file type:</strong><span
						class="ibm-required"><strong>*</strong></span><span
						class="ibm-item-note">(e.g., xls.ppt.)</span></label> <span> <select
						id="UPDATE_Salutation_id1" name="targetFileTypeCd"
						data-width="20%" onchange="checkDisplayTemplate()">
							<option selected="selected" value="">Select one</option>
							<option value="2">ppt</option>
							<option value="1">xls</option>
							<option value="3">xlsx</option>
					</select>
					</span>
				</p>
				<br />

				<p id="is_outline_group1" style="display: none;">
					<label id="is_outline_group"><strong>Outline
							images?</strong></label> <span class="ibm-input-group"> <span
						class="ibm-checkbox-wrapper"> <input
							class="ibm-styled-checkbox" id="is_outline" name="isOutline"
							type="checkbox" value="Yes" /> <label for="is_outline"
							class="ibm-field-label">Yes</label>
					</span>

					</span> <br />
				</p>

				<p id="UPDATE-grp-lbl-id61" style="display: none;"></p>

				<p id="UPDATE-grp-lbl-id071" style="display: none;"></p>

				<p>
					<label for="UPDATE_First_name_id"><strong>Specify
							presentation deck file name:</strong><span class="ibm-required"><strong>*</strong></span></label>
					<span> <input id="UPDATE_First_name_id"
						name="targetFileName" size="20" type="text" value="" />
					</span>
				</p>
				<br />

				<p>
					<label id="UPDATE-grp-lbl-id7"><strong>Send the
							generated file as:</strong></label> <span class="ibm-input-group"> <span
						class="ibm-radio-wrapper"> <input data-init="false"
							class="ibm-styled-radio" id="send_option_link_id"
							name="sendOption" type="radio" onclick="displayZipout(this);"
							value="LINK" /> <label for="send_option_link_id"
							class="ibm-field-label">link</label>
					</span> <span class="ibm-radio-wrapper"> <input data-init="false"
							class="ibm-styled-radio" id="send_option_att_id"
							name="sendOption" checked='checked' type="radio"
							onclick="displayZipout(this);" value="ATTACHMENT" /> <label
							for="send_option_att_id" class="ibm-field-label">attachment</label>
					</span>
					</span>
				</p>
				<br />

				<p id="UPDATE-grp-lbl-zipoutputP">
					<label id="UPDATE-grp-lbl-zipoutput"><strong>Zip
							output:</strong></label> <span class="ibm-input-group"> <span
						class="ibm-radio-wrapper"> <input data-init="false"
							class="ibm-styled-radio" id="zip_output_NO_id" name="zipOutput"
							checked='checked' type="radio" onclick="SelectZipNo();" value="N" />
							<label for="zip_output_NO_id" class="ibm-field-label">No</label>
					</span> <span class="ibm-radio-wrapper"> <input data-init="false"
							class="ibm-styled-radio" id="zip_output_YES_id" name="zipOutput"
							type="radio" onclick="SelectZipYes();" value="Y" /> <label
							for="zip_output_YES_id" class="ibm-field-label">Yes</label>
					</span>
					</span> <br />
				</p>

				<p>
					<label id="UPDATE-grp-lbl-_appanddate"><strong>Append
							date to output:</strong></label> <span class="ibm-input-group"> <span
						class="ibm-radio-wrapper"> <input data-init="false"
							class="ibm-styled-radio" id="appanddate_NO_id" name="appendDate"
							checked='checked' type="radio" onclick="displayDateFormat(this);"
							value="N" /> <label for="appanddate_NO_id"
							class="ibm-field-label">No</label>
					</span> <span class="ibm-radio-wrapper"> <input data-init="false"
							class="ibm-styled-radio" id="appanddate_YES_id" name="appendDate"
							type="radio" onclick="displayDateFormat(this);" value="Y" /> <label
							for="appanddate_YES_id" class="ibm-field-label">Yes</label>
					</span>
					</span>
				</p>
				<br />

				<p id="UPDATE-grp-lbl-id601" style="display: none;"></p>
				<br />


				<!-- OVERLAY LINK START -->

				<input type="hidden" name="SelectedRequestsNew" value=""
					id="id_SelectedRequestsNew" /> <input type="hidden" name="cwaid"
					value=cwa_id id="cwaidnew" /> <input type="hidden" name="function"
					value="savenew" id="functionsave" />

				<div class="ibm-common-overlay full-width seamless"
					data-widget="overlay" id="dialogOne">
					<h2>
						<strong>Click the 'Add' operation link to select your
							desired inputs from the lists of content available to you on each
							of the tabs. Use the Move Up / down links to adjust the order of
							your selected content before closing the window to return to the
							Create an Autodeck page</strong>
					</h2>

					<table summary="table layout display" class="ibm-results-table">
						<thead>
							<tr>
								<th scope="col" style="display: none;">col1</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Your selected requests:
									<hr /> <!-- =====================table_1===================== -->
									<!--<table id="table_backup" data-widget="datatable" data-info="true" data-ordering="false" data-paging="false" data-searching="false" class="ibm-data-table ibm-altrows dataTable no-footer">
		                            <thead>
		                                <tr>
		                                	<th style="width: 2%; height: 16px;" scope="col"/>
		                                    <th>Report/File Name</th>
								            <th>e-Mail Subject/Desciption</th>
								            <th>Frequency</th>
								            <th>Datamart/Data Load</th>
								            <th>Expiration Date</th>
								            <th>Domain Key</th>
								            <th>Status</th>
								            <th>Comments</th>
								            <th>Request ID</th>
								            <th>Type</th>
		                                </tr>
		                            </thead>
		                            <tbody id='tbody_table_1'></tbody>
		                        </table>--> <!-- =====================table_1===================== -->
									<table id="table_1" data-widget="datatable" data-scrollaxis="x"
										class="ibm-data-table" cellspacing="0" cellpadding="0"
										border="0">
										<thead>
											<tr>
												<th style="width: 2%; height: 16px;" scope="col" />
												<th scope="col"><span>Report/File Name</span></th>
												<th scope="col"><span>e-Mail Subject/Desciption</span></th>
												<th scope="col"><span>Frequency</span></th>
												<th class="ibm-date" scope="col"><span>Datamart/Data
														Load</span></th>
												<th scope="col"><span>Expiration Date</span></th>
												<th scope="col"><span>Domain Key</span></th>
												<th scope="col"><span>Status</span></th>
												<th scope="col"><span>Comments</span></th>
												<th scope="col"><span>Request ID</span></th>
												<th scope="col"><span>Type</span></th>
												<th scope="col"><span>Output Status</span></th>
              									<th scope="col"><span>Last Ready Time</span></th>
											</tr>
										</thead>
										<tbody id='tbody_table_1'></tbody>
									</table>
						</tbody>

					</table>


					<p id="requests_operation" class="ibm-ind-link">
						<a id="autodeck_href_showa1" name="autodeck_href_showa1"
							class="ibm-anchor-up-link" style="font-weight: normal" href="#t1">Move
							up</a> |<a id="autodeck_href_showa2" name="autodeck_request_down"
							class="ibm-anchor-down-link" style="font-weight: normal"
							href="#t1">Move down</a> |<a id="autodeck_href_showa4"
							name="autodeck_href_delete" class="ibm-delete-link"
							onClick="delTable1()" href="#t1">Delete</a>
					</p>

					<div class="ibm-rule">
						<hr>
					</div>


					<!-- Tabs here: -->
					<div id="autodeck_tab_id" data-widget="dyntabs"
						class="ibm-graphic-tabs">
						<div class="ibm-tab-section">
							<ul class="ibm-tabs" role="tablist">
								<li><a aria-selected="true" role="tab"
									href="#tab_request_cognos">Cognos schedule request</a></li>
								<li><a role="tab" href="#tab_request_upload">Uploaded
										files</a></li>

							</ul>
						</div>

						<!-- prompts tab content -->
						<div id="tab_request_cognos" class="ibm-tabs-content">

							<div id='select-display'>
								<p class="ibm-show-hide-controls">
									<a href="#" onclick="javascript:displayAllRequest()">All
										requests</a> | <a href="#" onclick="javascript:displayOwn()">Owned
										by me</a> | <a class="ibm-active"
										onclick="javascript:displayOther()" href="#">Owned by
										others</a>

								</p>
							</div>
							<div id='tabtext'>
								<span id='tabspantext'>All requests</span>
							</div>
							<div id='tabtext1'>
								<span id='tabspantext1'></span>
							</div>

							<table id="table_2" data-widget="datatable" data-info="false"
								data-ordering="true" data-paging="false" data-searching="true"
								class="ibm-data-table ibm-altrows dataTable no-footer"
								data-order='[[1,"asc"]]'>
								<thead>
									<tr>
										<th>Report Name</th>
										<th>e-Mail Subject</th>
										<th>Frequency</th>
										<th>Datamart/Data Load</th>
										<th>Expiration Date</th>
										<th>Domain Key</th>
										<th>Status</th>
										<th>Comments</th>
										<th>Operation</th>
									</tr>
								</thead>
								<tbody id='tbody_table_2'></tbody>
							</table>


						</div>

						<!-- output format tab content -->
						<div id="tab_request_upload" class="ibm-tabs-content">
							<table id="table_3" data-widget="datatable" data-info="false"
								data-ordering="true" data-paging="false" data-searching="false"
								class="ibm-data-table ibm-altrows dataTable no-footer"
								data-order='[[1,"asc"]]'>
								<thead>
									<tr>
										<th>File Name</th>
										<th>File Desciption</th>
										<th>Expiration Date</th>
										<th>Status</th>
										<th>Operation</th>
									</tr>
								</thead>
								<tbody id='tbody_table_3'></tbody>
							</table>

						</div>
						<!-- Tabs contents divs: -->
					</div>
				</div>
				<!-- OVERLAY LINK END -->


				<!--<p id="requests_operation" class="ibm-ind-link">
					<label for="ibm-popup-link">
						<strong>Click the 'Autodeck inputs' link to specify your required content:</strong><span class="ibm-required"><strong>*</strong></span>
					</label>
					<a id="autodeck_input_href_id" name="autodeck_input_href" class="ibm-popup-link" href="#dialogOne" onclick="bishow('dialogOne',this);return false;">Autodeck inputs</a>
					
				</p>-->

				<p class="ibm-ind-link">
					<label> <strong>Click the 'Autodeck inputs' link
							to specify your required content:</strong><span class="ibm-required"><strong>*</strong></span>
					</label> <a href="#" class="ibm-forward-link"
						onclick="IBMCore.common.widget.overlay.show('dialogOne'); return false;">Autodeck
						inputs</a>
				</p>
				<div class="ibm-common-overlay full-width seamless"
					data-widget="overlay" id="overlayExampleXl">
					<p>Overlay content can include standard text or links/buttons.
						The overlay closes if a user clicks off of the overlay window or
						clicks the "X" button.</p>
				</div>


				<table cellspacing="0" cellpadding="0" border="0" width="100%"
					class="" summary="table layout display">
					<thead>
						<tr>
							<th scope="col" style="display: none;">col1</th>
							<th scope="col" style="display: none;">col2</th>
							<th scope="col" style="display: none;">col3</th>
							<th scope="col" style="display: none;">col4</th>
						</tr>
					</thead>
					<tbody id="ad_create_body_id">

						<!-- <tr valign="top">
							<td style="width: 15px; height: 1px;"></td>
							<td style="vertical-align: top; width: 30%;">
								<label for="ibm-popup-link"><b>Click the 'Autodeck inputs' link to specify your required content:</b><span class="ibm-required"><b>*</b></span> 
								</label></td>
							
							<td style="vertical-align: top; width: 10%;">
							<a class="ibm-popup-link" href="javascript:;" target="" title="">ibm-popup-link</a>
							</td>
							<td style="vertical-align: top; width: 50%;">&nbsp;&nbsp;
	
							</td>
						</tr>-->

						<tr>
							<td style="height: 15px;"></td>
						</tr>

						<tr valign="top">
							<td style="width: 15px; height: 1px;"></td>
							<td style="vertical-align: top; width: 30%;"><label
								for="UPDATE_E_mail_address_id"><strong>e-Mail
										address:</strong><span class="ibm-required"><strong>*</strong></span> <span
									class="ibm-item-note">(Enter up to 12 e-Mail addresses
										separated by spaces.) (i.e. jdoe@us.ibm.com mydistlist)</span></label></td>

							<td style="vertical-align: top; width: 10%;"><textarea
									id="UPDATE_E_mail_address_id" rows="4" cols="60"
									name="emailAddress"></textarea></td>
							<td style="vertical-align: top; width: 50%;">&nbsp;&nbsp;</td>
						</tr>

						<tr>
							<td style="height: 7px;"></td>
						</tr>

						<tr valign="top">
							<td style="height: 1px;"></td>
							<td><label for="UPDATE_Subject_id"><strong>e-Mail
										subject:</strong><span class="ibm-required"><strong>*</strong></span></label></td>
							<td><input type="text" id="UPDATE_Subject_id"
								onkeypress="if ( event.keyCode == 13 ) return false; else if ( event.which == 13 ) return false; else return true;"
								maxlength="90" size="60" name="emailSubject" /></td>
							<td></td>
						</tr>

						<tr>
							<td style="height: 10px;"></td>
						</tr>

						<tr valign="top">
							<td style="height: 1px;">&nbsp;</td>
							<td><label for="UPDATE_Message_id"><strong>Specify
										e-Mail content:</strong></label></td>
							<td style="vertical-align: top;"><textarea
									id="UPDATE_Message_id" rows="4" cols="60" name="emailComments"></textarea>
							</td>
							<td></td>
						</tr>

						<tr>
							<td style="height: 5px;"></td>
						</tr>

						<tr valign="top">
							<td style="height: 1px;"></td>
							<td><label for="UPDATE_E_mail_backup_cwa_id"><strong>Backup:</strong></label></td>
							<td><input type="text" id="UPDATE_E_mail_backup_cwa_id"
								maxlength="128" size="60" name="backupOwner" value="">
							</td>
							<td></td>
						</tr>

						<tr>
							<td style="height: 15px;"></td>
						</tr>

						<tr valign="top">
							<td style="height: 1px;"></td>
							<td><label for="UPDATE_Subject_id"><strong>Final
										deck Synchronisation:</strong><span class="ibm-required"><strong>*</strong></span><br />
								<br /> Your 'Final' deck will be sent out as soon as all the
									required content has been updated.</label></td>

							<td style='vertical-align: top;''>
								<fieldset style='border: 1px solid #DDD;'>
									<legend>
										Final deck Synchronisation:<span class='ibm-required'>*</span>
									</legend>
									<table cellspacing='0' cellpadding='0' border='0' width='100%'
										class='' summary='table layout display'>
										<input type='hidden' id='csp_hidden_sched_freq_detail_id'
											value='"+ data.schedFreqDetail +"' name='schedFreqDetail'>
										<thead>
											<tr>
												<th scope='col' style='display: none;'>col1</th>
											</tr>
										</thead>
										<tbody>
											<tr></tr>
											<tr>
												<td style='vertical-align: top;'>Day / Time (recommended for Weekly decks) - all required content to be updated again after the chosen time of day:</td>
											</tr>
											<br />
											<tr>
												<td style='vertical-align: top;'>&nbsp;&nbsp;<input
													data-init="false" type='radio' class='ibm-styled-radio'
													id='id_radio_sun' value='Sun' onclick='SelectWeekNoSun();'
													name='finalDeckWeekNo'></input> <label for='id_radio_sun'>Sunday</label>
												</td>
											</tr>

											<tr>
												<td style='vertical-align: top;'>&nbsp;&nbsp;<input
													data-init="false" type='radio' class='ibm-styled-radio'
													id='id_radio_mon' value='Mon' onclick='SelectWeekNoMon();'
													name='finalDeckWeekNo' /> <label for='id_radio_mon'>Monday</label>
												</td>
											</tr>

											<tr>
												<td style='vertical-align: top;'>&nbsp;&nbsp;<input
													data-init="false" type='radio' class='ibm-styled-radio'
													id='id_radio_tue' value='Tue' onclick='SelectWeekNoTue();'
													name='finalDeckWeekNo' /> <label for='id_radio_tue'>Tuesday</label>
												</td>
											</tr>

											<tr>
												<td style='vertical-align: top;'>&nbsp;&nbsp;<input
													data-init="false" checked='checked' type='radio' class='ibm-styled-radio'
													id='id_radio_wed' value='Wed' onclick='SelectWeekNoWed();'
													name='finalDeckWeekNo' /> <label for='id_radio_wed'>Wednesday</label>
												</td>
											</tr>

											<tr>
												<td style='vertical-align: top;'>&nbsp;&nbsp;<input
													data-init="false" type='radio' class='ibm-styled-radio'
													id='id_radio_thu' value='Thu' onclick='SelectWeekNoThu();'
													name='finalDeckWeekNo' /> <label for='id_radio_thu'>Thursday</label>
												</td>
											</tr>

											<tr>
												<td style='vertical-align: top;'>&nbsp;&nbsp;<input
													data-init="false" type='radio' class='ibm-styled-radio'
													id='id_radio_fri' value='Fri' onclick='SelectWeekNoFri();'
													name='finalDeckWeekNo' /> <label for='id_radio_fri'>Friday</label>
												</td>
											</tr>

											<tr>
												<td style='vertical-align: top;'>&nbsp;&nbsp;<input
													data-init="false" type='radio' class='ibm-styled-radio'
													id='id_radio_sat' value='Sat' onclick='SelectWeekNoSat();'
													name='finalDeckWeekNo' /> <label for='id_radio_sat'>Saturday</label>
												</td>
											</tr>

											<tr>
												<td style='vertical-align: top;'>
													<p class="ibm-form-elem-grp">
														<label></label> <select name="finalDeckTime"
															id="final_deck_time_id">
															<option value="0">GMT 00:00</option>
															<option value="1">GMT 01:00</option>
															<option value="2">GMT 02:00</option>
															<option value="3">GMT 03:00</option>
															<option value="4">GMT 04:00</option>
															<option value="5">GMT 05:00</option>
															<option value="6">GMT 06:00</option>
															<option value="7">GMT 07:00</option>
															<option value="8">GMT 08:00</option>
															<option value="9">GMT 09:00</option>
															<option value="10">GMT 10:00</option>
															<option value="11">GMT 11:00</option>
															<option value="12" selected = "selected" >GMT 12:00</option>
															<option value="13">GMT 13:00</option>
															<option value="14">GMT 14:00</option>
															<option value="15">GMT 15:00</option>
															<option value="16">GMT 16:00</option>
															<option value="17">GMT 17:00</option>
															<option value="18">GMT 18:00</option>
															<option value="19">GMT 19:00</option>
															<option value="20">GMT 20:00</option>
															<option value="21">GMT 21:00</option>
															<option value="22">GMT 22:00</option>
															<option value="23">GMT 23:00</option>
														</select>

													</p>
												</td>
											</tr>

											<tr>
												<td style='vertical-align: top;'>&nbsp;&nbsp;<input
													data-init="false" type='radio'
													class='ibm-styled-radio' id='id_radio_default' value='Ato'
													onclick='SelectWeekNoAto();' name='finalDeckWeekNo' /> <label
													for='id_radio_default'>When Ready (recommended for Daily decks) - when the Output Status for all required TBS Inputs shows as 'Ready'.</label>
												</td>
											</tr>

										</tbody>
									</table>
								</fieldset>
							</td>
							<td></td>
						</tr>
						<tr>
							<td style="height: 15px;"></td>
						</tr>
<!-- 						<tr>
							<td style="height: 1px;"></td>
							<td colspan="3"><strong><span
									style="font-size: 14px">Set the timing for status
										updates and 'Provisional' Autodeck creation: </span></strong></td>
						</tr> -->

						<tr>
							<td style="height: 15px;"></td>
						</tr>
						
						<tr valign="top">
							<td style="width: 15px; height: 1px;"></td>
							<td style="vertical-align: top; width: 30%;"><label id="is_provisional_group"><strong>Do you require a Status Message or Provisional deck to be sent to you in the event 
that some of the required Autodeck inputs are unavailable at a specified day and time?</strong></label></td> 
							<td style="vertical-align: top;"><span class="ibm-input-group"> <span> 
							<select id="is_provisional" name="provisional" data-width="55%" onchange="checkScheduleFrequency()">
									<option value="N">Not needed</option>
									<option value="W" selected="selected">Status Message only</option>
									<option value="Y">Provisional Deck with Status Message</option>
							</select>
							</span></td>
							<td></td>
						</tr>
						
						<tr>
							<td style="height: 15px;"></td>
						</tr>
						
						</form>
						<tr valign="top" id='tr_id_ScheduleFrequency'>
							<td style="height: 1px;"></td>
							<td><label for="UPDATE_Subject_id">Schedule
									frequency:<span class="ibm-required">*</span><br />
								<br /> Select the required day(s) for your status update<br />
							</label></td>

							<td style='vertical-align: top;''>
								<fieldset style='width: 60%; border: 1px solid #DDD;'>
									<legend>
										Schedule frequency:<span class='ibm-required'>*</span>
									</legend>
									<table cellspacing='0' cellpadding='0' border='0' width='100%'
										class='' summary='table layout display'>
										<input type="hidden" name="schedFreqDetail"
											value="M,Tu,W,Th,F,Sa,Su" id="id_hidden_sched_freq_detail" />
										<thead>
											<tr>
												<th scope='col' style='display: none;'>col1</th>
												<th scope='col' style='display: none;'>col2</th>
												<th scope='col' style='display: none;'>col3</th>
												<th scope='col' style='display: none;'>col4</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td></td>
												<td style='vertical-align: top;'>&nbsp;&nbsp;<input
													type='radio' class='ibm-styled-radio' checked
													onclick='MergeScheduleDate();' id='id_radio_sched_freq'
													value='D' name='schedFreq' /> <label
													for='id_radio_sched_freq'>Daily/weekly</label>
												</td>
												<td><select multiple='multiple'
													onchange='MergeScheduleDate();' id='id_D_sched_freq_detail'
													title='Daily or Weekly' size='4' name='D_sched_freq_detail'
													style="width: 115px;" class="ibm-widget-processed">
														<option selected value='M'>Monday</option>
														<option selected value='Tu'>Tuesday</option>
														<option selected value='W'>Wednesday</option>
														<option selected value='Th'>Thursday</option>
														<option selected value='F'>Friday</option>
														<option selected value='Sa'>Saturday</option>
														<option selected value='Su'>Sunday</option>
												</select></td>
												<td></td>
											</tr>
											<tr>
												<td colspan='4'>&nbsp;</td>
											</tr>
											<tr>
												<td></td>
												<td style='vertical-align: top;'>&nbsp;&nbsp;<input
													type='radio' class='ibm-styled-radio'
													onclick='MergeScheduleDateM();' id='id_sched_freq_M'
													value='M' name='schedFreq' /> <label for='id_sched_freq_M'>Monthly</label>
													<div class='ibm-item-note'
														style='width: 230px; text-indent: 30px'></div>
												</td>
												<td><select multiple='multiple'
													onchange='MergeScheduleDateM();'
													id='id_M_sched_freq_detail' title='Monthly' size='4'
													name='M_sched_freq_detail' style="width: 115px;"
													class="ibm-widget-processed">
														<option value="FM">1st Mon</option>
														<option value="FTu">1st Tue</option>
														<option value="FW">1st Wed</option>
														<option value="FTh">1st Thu</option>
														<option value="FF">1st Fri</option>
														<option value="FSa">1st Sat</option>

														<option value="FSu">1st Sun</option>
														<option value="N1">1st</option>
														<option value="N2">2nd</option>
														<option value="N3">3rd</option>
														<option value="N4">4th</option>
														<option value="N5">5th</option>

														<option value="N6">6th</option>
														<option value="N7">7th</option>
														<option value="N8">8th</option>
														<option value="N9">9th</option>
														<option value="N10">10th</option>
														<option value="N11">11th</option>

														<option value="N12">12th</option>
														<option value="N13">13th</option>
														<option value="N14">14th</option>
														<option value="N15">15th</option>
														<option value="N16">16th</option>
														<option value="N17">17th</option>

														<option value="N18">18th</option>
														<option value="N19">19th</option>
														<option value="N20">20th</option>
														<option value="N21">21st</option>
														<option value="N22">22nd</option>
														<option value="N23">23rd</option>

														<option value="N24">24th</option>
														<option value="N25">25th</option>
														<option value="N26">26th</option>
														<option value="N27">27th</option>
														<option value="N28">28th</option>
														<option value="N29">29th</option>

														<option value="N30">30th</option>
														<option value="N31">31st</option>
														<option value="LM">Last Mon</option>
														<option value="LTu">Last Tue</option>
														<option value="LW">Last Wed</option>
														<option value="LTh">Last Thu</option>

														<option value="LF">Last Fri</option>
														<option value="LSa">Last Sat</option>
														<option value="LSu">Last Sun</option>
												</select></td>
												<td><div class='ibm-item-note'
														style='width: 100px; text-indent: 30px'></div></td>
											</tr>
										</tbody>
									</table>
								</fieldset>
							</td>
							<td></td>

						</tr>

						<tr id='tr_id_blankrow'>
							<td style="height: 15px;"></td>
						</tr>

					</tbody>
				</table>
				<br />

				<p class="ibm-form-elem-grp" id='tr_id_DropDownTimezone'>
					<label id="idDropDownTimezone" for="DropDownTimezone"><strong>Select
							desired time for status e-Mails and any Provisional deck creation
							(GMT):</strong><span class="ibm-required"><strong>*</strong></span></label> <span>
						<select name="gmtTime" id="DropDownTimezone" data-width="20%">

							<option value="0">GMT 00:00</option>
							<option value="1">GMT 01:00</option>
							<option value="2">GMT 02:00</option>
							<option value="3">GMT 03:00</option>
							<option value="4">GMT 04:00</option>
							<option value="5">GMT 05:00</option>
							<option value="6">GMT 06:00</option>
							<option value="7">GMT 07:00</option>
							<option value="8">GMT 08:00</option>
							<option value="9">GMT 09:00</option>
							<option value="10">GMT 10:00</option>
							<option value="11">GMT 11:00</option>
							<option value="12">GMT 12:00</option>
							<option value="13">GMT 13:00</option>
							<option value="14">GMT 14:00</option>
							<option value="15">GMT 15:00</option>
							<option value="16">GMT 16:00</option>
							<option value="17">GMT 17:00</option>
							<option value="18">GMT 18:00</option>
							<option value="19">GMT 19:00</option>
							<option value="20">GMT 20:00</option>
							<option value="21">GMT 21:00</option>
							<option value="22">GMT 22:00</option>
							<option value="23">GMT 23:00</option>
					</select>
					</span>
					<br />
				</p>
				

				<p>
					<label for="datepicker"><strong>Expiration date:</strong><span
						class="ibm-required"><strong>*</strong></span> </label> <span> <input
						data-widget="datepicker" type="text" value="" size="20"
						data-min="-0" data-format="yyyy-mm-dd" data-max="180"
						id="datepicker" name="expirationDate" />
					</span>
				</p>

				<div class="ibm-rule">
					<hr />
				</div>

				<div id="adcreate_buttondiv">
					<input type="button" id="adcreate_btn_submit"
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="submitFormNew()" value="Submit" />

				</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>

<script language="JavaScript" type="text/javascript"
	src="<%=request.getContextPath() + "/javascript/ctable.js" %>"></script>
<script type="text/javascript">

	//=============================================global variables, do NOT change after init this page
	var myTbsContext = "<%=request.getContextPath()%>";
	var cwa_id = "${cwa_id}";
	var backup_id = "${cwa_id}";
	var uid = "${uid}"; 
	
	//var cwa_id = "rayr@us.ibm.com"
	//var backup_id = "rayr@us.ibm.com"
	//var uid = "251538897";
	
	var timeid;
    var selectedCSR;
    var uploadedRequestsList;
    var count = 0;
    var isAdd = false;
    var requests_checked_list;
    var selectedCSRTable1=[];
    var selectedRequestsNew = "";
    var myTable;

  	function getTemplates() {
		timeid = (new Date()).valueOf();
		
		jQuery.ajax({
	        type: 'GET', url: '<%=path%>/action/portal/autodeck/getAutofileTemplates/' + cwa_id + '/' + uid + '?timeid=' + timeid,async:false,
	        success: function (data) {
	        //console.log("get data from rest api getAutofileTemplates()");
	        //console.log(data);
	        
	        var templates = "<label id='UPDATE-grp-lbl-id6'><span class='ibm-required'><strong>*</strong></span><strong>Select the desired template for the ppt output:</strong></label>";
	        templates+="<span class='ibm-input-group'>";
	        for (var i = 0; i < data.length; i++) {
         	   templates+="<span class='ibm-radio-wrapper'>";
         	   templates+="<input data-init='false' class='ibm-styled-radio' id='templateid";
         	   templates+=i+1;
         	   templates+="' name='autofileTemplate' type='radio' onclick='pptOutputTemplate";
         	   templates+=i+1;
         	   templates+="();' value='";
         	   templates+=data[i].templateCd;
         	   templates+="' ";
         	   	if(i==0){
         	    	templates+="checked='checked'";
         	    }
         	   templates+="/>";
         	   templates+="<label for='templateid";
         	   templates+=i+1;
         	   templates+="' class='ibm-field-label'>";
         	   templates+=data[i].templateName;
         	   templates+="</label>";
         	   templates+="</span>";   
      	    }
      	    templates+="</span>";
      	    templates+="<br/>";
	        
			jQuery("#UPDATE-grp-lbl-id61").append(templates);
      	  	},
	        error: function (data) {
	            alert('getAutofileTemplates - ajax return error!!!')
	        }
	    });

	  }
  	
	  function getPptPastetypes() {
			timeid = (new Date()).valueOf();
			
			jQuery.ajax({
		        type: 'GET', url: '<%=path%>/action/portal/autodeck/getAutofilePptPastetypes/' + cwa_id + '/' + uid + '?timeid=' + timeid,async:false,
		        success: function (data) {
		        //console.log("get data from rest api getAutofilePptPastetypes()");
		        //console.log(data);
		        
		        var pptPastetypes = "<label id='UPDATE-grp-lbl-id07'><span class='ibm-required'><strong>*</strong></span><strong>Select the image paste type for the ppt output:</strong></label>";
		        pptPastetypes+="<span class='ibm-input-group'>";
		        for (var i = 0; i < data.length; i++) {
	         	   pptPastetypes+="<span class='ibm-radio-wrapper'>";
	         	   pptPastetypes+="<input data-init='false' class='ibm-styled-radio' id='pasteTypeid";
	         	   pptPastetypes+=i+1;
	         	   pptPastetypes+="' name='pptPasteTypeId' type='radio' onclick='pptPastetypes";
	         	   pptPastetypes+=i+1;
	         	   pptPastetypes+="();' value='";
	         	   pptPastetypes+=data[i].typeId;
	         	   pptPastetypes+="' ";
	         	   	if(i==0){
	         	    	pptPastetypes+="checked='checked'";
	         	    }
	         	   pptPastetypes+="/>";
	         	   pptPastetypes+="<label for='pasteTypeid";
	         	   pptPastetypes+=i+1;
	         	   pptPastetypes+="' class='ibm-field-label'>";
	         	   pptPastetypes+=data[i].typeName;
	         	   pptPastetypes+="</label>";
	         	   pptPastetypes+="</span>";   
	      	    }
	      	    pptPastetypes+="</span>";
	      	    pptPastetypes+="<br/>";
		        
				jQuery("#UPDATE-grp-lbl-id071").append(pptPastetypes);
	      	  	},
		        error: function (data) {
		            alert('getPptPastetypes - ajax return error!!!')
		        }
		    });

		  }
	  
	  function getAppendfiles() {
			timeid = (new Date()).valueOf();
			
			jQuery.ajax({
		        type: 'GET', url: '<%=path%>/action/portal/autodeck/getAutofileAppendfiles/' + cwa_id + '/' + uid + '?timeid=' + timeid,async:false,
		        success: function (data) {
		        //console.log("get data from rest api getAutofileAppendfiles()");
		        
		        var appendfiles = "<label id='UPDATE-grp-lbl-id60'><span class='ibm-required'><strong>*</strong></span><strong>Select the date format:</strong></label>";
		        appendfiles+="<span class='ibm-input-group'>";
		        for (var i = 0; i < data.length; i++) {
	         	   appendfiles+="<span class='ibm-radio-wrapper'>";
	         	   appendfiles+="<input data-init='false' class='ibm-styled-radio' id='dateTypeid";
	         	   appendfiles+=i+1;
	         	   appendfiles+="' name='dateTypeCd' type='radio' onclick='appendfiles";
	         	   appendfiles+=i+1;
	         	   appendfiles+="();' value='";
	         	   appendfiles+=data[i].appendfileCd;
	         	   appendfiles+="' ";
	         	   	if(i==0){
	         	    	appendfiles+="checked='checked'";
	         	    }
	         	   appendfiles+="/>";
	         	   appendfiles+="<label for='dateTypeid";
	         	   appendfiles+=i+1;
	         	   appendfiles+="' class='ibm-field-label'>";
	         	   appendfiles+=data[i].appendfileDesc;
	         	   appendfiles+="</label>";
	         	   appendfiles+="</span>";
	      	    }
	      	    appendfiles+="</span>";
	      	    appendfiles+="<br/>";
		        
				jQuery("#UPDATE-grp-lbl-id601").append(appendfiles);
	      	  	},
		        error: function (data) {
		            alert('getAppendfiles - ajax return error!!!')
		        }
		    });

		  }
	  
	  function getUploads() {
		  var table_3_content = jQuery("#table_3").DataTable();
		  timeid = (new Date()).valueOf();
		  
			jQuery.ajax({
		        type: 'GET', url: '<%=path%>/action/portal/autodeck/getAutofileUploads/' + cwa_id + '/' + uid + '?timeid=' + timeid,async:false,
		        success: function (data) {
		        //console.log("get data from rest api getAutofileUploads()");
		        
		        uploadedRequestsList = data;
		        
		         for (var i = 0; i < data.length; i++) {
		        	 var uploadedRequest = data[i];
		        	 
		        	 var upload_col_0 = "<a href=" + myTbsContext + "/action/portal/autodeck/xlsmanage/getXLSManagePage/"
									+ " target='_blank'>"
									+ uploadedRequest.fileName
									+ "."
									+ uploadedRequest.fileType
									+ "</a>";
					
					var upload_col_1 = uploadedRequest.fileDesc;
					var upload_col_2 = uploadListFormatDate(uploadedRequest.expirationDate);
					var upload_col_3 = uploadedRequest.status;
					var upload_col_4 = "<a href=\"javascript:void(0)\" onclick=\"addToSelect(this,'"+uploadedRequest.requestId+"')\">Add</a>";
					
					var dataSet = [upload_col_0, upload_col_1, upload_col_2, upload_col_3, upload_col_4]
					//table_3_content.row.add(dataSet).draw();
					table_3_content.row.add(dataSet);
					//jQuery(table_3_content.row(i).node()).attr('id', 'id_uploadedRequest_' + uploadedRequest.requestId);
		         }
		         
		         table_3_content.draw();

	      	  	},
		        error: function (data) {
		            alert('getAutofileUploads - ajax return error!!!')
		        }
		    });
	  }
	  
	  function getScheduledRequestsList() {
		  
		  var table_2_content = jQuery("#table_2").DataTable();
		  timeid = (new Date()).valueOf();

			jQuery.ajax({
		        type: 'GET', url: '<%=path%>/action/portal/autodeck/loadScheduledRequestsList/' + cwa_id + '/' + backup_id + '/' + uid + '?timeid=' + timeid,async:true,
		        
		        success: function (data) {
		        	table_2_content.rows().remove();
		        //console.log("get data from rest api loadScheduledRequestsList()");
		        
		        selectedCSR = data.selectedCSR;
		        
			         for (var i = 0; i < selectedCSR.length; i++) {
			        	 
			        	var selectedRequest = selectedCSR[i];
			        	
			        	var input_col_0 = "<a href=" + myTbsContext + "/action/portal/schedulePanel/openCognosSchedulePanel/"
	        							+ selectedRequest.requestId + "/" + selectedRequest.tbsDomainKey
	        							+ " target='_blank'>"
	        							+ selectedRequest.rptName
	        							+ "</a>";
			        	var input_col_1 = selectedRequest.emailSubject;
			        	
			    		var freq = selectedRequest.schedFreq;
			    		var freqDtl = selectedRequest.freqDetail;
			    		
						var triggerType = selectedRequest.triggerType;
						if ((triggerType=='W') && (freq=='D'))
							freq='W';
						if ((triggerType=='D') && !(freq=='M'))
							freq='D';
						if (triggerType=='N')
							freq='N';
						
						var t = "";
						if (freq=='M') {
							t = "Monthly";
						}else if (freq == 'B') {
							t = "Business";
						}else if (freq == 'D') {
							t = "Daily";
						}else if (freq == 'W') {
							t = "Weekly";
							if (freqDtl == "M,Tu,W,Th,F,Sa,Su")
								freqDtl="";
							else{
								var flag=freqDtl.indexOf(',');
								if(flag >= 0)
									freqDtl =freqDtl.substring(0,flag);
							}
						}else if (freq=='N') {
							t = "NRT";
							freqDtl="";
						}
			        	
                        var input_col_2 = t + "<br />" + freqDtl;
                        var input_col_3 = selectedRequest.dataMart;
                        var input_col_4 = selectedRequest.expirationDate;
                        var input_col_5 = selectedRequest.tbsDomainKey;
                        var input_col_6 = selectedRequest.requestStatus;
                        var input_col_7 = selectedRequest.comments;
                        var input_col_8 = "<a href=\"javascript:void(0)\" onclick=\"addToSelect(this,'"+selectedRequest.requestId+"')\">Add</a>";

                        var dataSet = [input_col_0, input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7, input_col_8];
                        //table_2_content.row.add(dataSet).draw();
                        table_2_content.row.add(dataSet);
                        
                        //jQuery(table_2_content.row(i).node()).attr('id', 'id_selectedCSR_' + selectedRequest.requestId);
	
			        }
			         
			         table_2_content.draw();

	      	  	},
		        error: function (data) {
		            alert('getScheduledRequestsList - ajax return error!!!')
		        }
		    });

		  }

	jQuery(document).ready(function() {

        jQuery("#createAutodeck").attr("aria-selected", "true");

	    getTemplates();
	    getPptPastetypes();
	    getAppendfiles();
	  
	    jQuery("#UPDATE_E_mail_address_id").append(cwa_id);
	    jQuery("#UPDATE_E_mail_address_id").val(cwa_id);
	    
	    jQuery("#DropDownTimezone").val(new Date().getUTCHours()).trigger("change");
	  
	    jQuery("#tbody_table_2").empty();
	    jQuery("#tbody_table_3").empty();
	    getScheduledRequestsList();
	    getUploads();
	    
	    //getDropDownTimezone();
	  
	    myTable = new CTable("table_1",0);

	});
	
	
	function uploadListFormatDate(timestamp){
		var myNewDate = new Date();
		myNewDate.setTime(timestamp); 
		return myNewDate.getFullYear()+"-"+(myNewDate.getMonth()+1)+"-"+myNewDate.getDate(); 
	}
	
	function addToSelect(_a,convertId1){
		
		var table_1_content = jQuery("#table_1").DataTable();
		
		for (var i = 0; i < uploadedRequestsList.length; i++) {
			if(uploadedRequestsList[i].requestId == convertId1){
				
				for(var j=0;j<selectedCSRTable1.length;j++){
					if(selectedCSRTable1[j].requestId==convertId1){
						alert("this file already added!");
						return;
					}
				}
				
				var r_type="_2";
				var upload_col_0 = '';
					upload_col_0 += "<input id='adcreate_" + uploadedRequestsList[i].requestId + "_checkbox' requestID='" + uploadedRequestsList[i].requestId + "' r_type='_2'"+    " type='checkbox' name='request_checkbox' class='ibm-styled-checkbox adcreate_request_checkbox'>";
					upload_col_0 += "<label for='adcreate_" + uploadedRequestsList[i].requestId + "_checkbox'>";
					upload_col_0 += "<span class='ibm-access'>Select one</span>";
					upload_col_0 += "</input>";
					
				var upload_col_1 = "<a href=" + myTbsContext + "/action/portal/autodeck/xlsmanage/getXLSManagePage/"
								+ " target='_blank'>"
								+ uploadedRequestsList[i].fileName
								+ "</a>";
				var upload_col_2 = uploadedRequestsList[i].fileDesc;
				var upload_col_3 = '';
				var upload_col_4 = '';
				var upload_col_5 = uploadListFormatDate(uploadedRequestsList[i].expirationDate);
				var upload_col_6 = '';
				var upload_col_7 = uploadedRequestsList[i].status;
				var upload_col_8 = '';
				var upload_col_9 = uploadedRequestsList[i].requestId;
				var upload_col_10 = 'Uploaded file';
				
				//Output Status
	            var upload_col_11='N/A';
	            //“Last Ready Time
	            var upload_col_12='N/A';
				
				var dataSet = [upload_col_0, upload_col_1, upload_col_2, upload_col_3, upload_col_4, upload_col_5, upload_col_6, upload_col_7, upload_col_8, upload_col_9, upload_col_10, upload_col_11, upload_col_12];
                //table_1_content.row.add(dataSet).draw();
                table_1_content.row.add(dataSet);
                
				selectedCSRTable1[count] = uploadedRequestsList[i];
                count++;
			}
			
		}
		table_1_content.draw();
		
		for (var i = 0; i < selectedCSR.length; i++) {
			
			if(selectedCSR[i].requestId == convertId1){
				
				for(var j=0;j<selectedCSRTable1.length;j++){
					if(selectedCSRTable1[j].requestId==convertId1){
						alert("this request already added!");
						return;
					}
				}
				
				var input_col_0 = '';			
				var input_col_1 = "<a href=" + myTbsContext + "/action/portal/schedulePanel/openCognosSchedulePanel/"
								+ selectedCSR[i].requestId + "/" + selectedCSR[i].tbsDomainKey
								+ " target='_blank'>"
								+ selectedCSR[i].rptName
								+ "</a>";				
								
				var input_col_2 = selectedCSR[i].emailSubject;
								
				var freq = selectedCSR[i].schedFreq;
	    		var freqDtl = selectedCSR[i].freqDetail;
	    		
				var triggerType = selectedCSR[i].triggerType;
				if ((triggerType=='W') && (freq=='D'))
					freq='W';
				if ((triggerType=='D') && !(freq=='M'))
					freq='D';
				if (triggerType=='N')
					freq='N';
				
				var t = "";
				if (freq=='M') {
					t = "Monthly";
				}else if (freq == 'B') {
					t = "Business";
				}else if (freq == 'D') {
					t = "Daily";
				}else if (freq == 'W') {
					t = "Weekly";
					if (freqDtl == "M,Tu,W,Th,F,Sa,Su")
						freqDtl="";
					else{
						var flag=freqDtl.indexOf(',');
						if(flag >= 0)
							freqDtl =freqDtl.substring(0,flag);
					}
				}else if (freq=='N') {
					t = "NRT";
					freqDtl="";
				}
	        	
                var input_col_3 = t + "<br />" + freqDtl;			
                //var input_col_3 = selectedCSR[i].schedFreq;
                var input_col_4 = selectedCSR[i].dataMart;
                var input_col_5 = selectedCSR[i].expirationDate;
                var input_col_6 = selectedCSR[i].tbsDomainKey;
                
                if(selectedCSR[i].requestStatus!= undefined){
                	
                	input_col_0 += "<input id='adcreate_" + selectedCSR[i].requestId + "_checkbox' requestID='" + selectedCSR[i].requestId + "' r_type='_1'"+    " type='checkbox' name='request_checkbox' class='ibm-styled-checkbox adcreate_request_checkbox'>";
                    input_col_0 += "<label for='adcreate_" + selectedCSR[i].requestId + "_checkbox'>";
                    input_col_0 += "<span class='ibm-access'>Select one</span>";
                    input_col_0 += "</input>";
                	
                	var input_col_7 = selectedCSR[i].requestStatus;
                	var input_col_8 = selectedCSR[i].comments;
                    var input_col_9 = selectedCSR[i].requestId;
                    var input_col_10 = "Cognos schedule";
                    
                  	//Output Status
                    var tmp_lasttStatus=selectedCSR[i].lastStatus;
                    var lastStatusMsg="Unavailable"
                    //Last Ready Time
                    var input_col_12 = 'N/A';
                   	if(tmp_lasttStatus=='100'||tmp_lasttStatus=='101'){
                        lastStatusMsg="Ready";
                        input_col_12=ToDate(selectedCSR[i].readyTime);
                    }
                    var input_col_11=lastStatusMsg;
                    
                    r_type="_1";
                }

                
                var dataSet = [input_col_0, input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7, input_col_8, input_col_9, input_col_10, input_col_11, input_col_12];
                table_1_content.row.add(dataSet).draw();
                jQuery(table_1_content.row(count).node()).attr('id', 'id_selectedRequest_' + selectedCSR[i].requestId);
                
                selectedCSRTable1[count] = selectedCSR[i];
                count++;
                
                //selectedRequestsNew += selectedCSRTable1[i].requestId + r_type + '_' + count;
                //selectedRequestsNew += ',';
                
			}
			
		}
		
		if(!isAdd){

			var table3 = jQuery('#table_1').DataTable();
			
			jQuery('#autodeck_href_showa1').click( function () {
	            var mytable=   new CTable("table_1");
	            mytable.up();
	            } );
	
	         jQuery('#autodeck_href_showa2').click( function () {
	            var mytable1=   new CTable("table_1");
	            mytable1.down();
	                //alert( table.rows('.selected').data().length +' row(s) selected' );
	            } );
	
	         isAdd = true;
       
		}
			
		// ============== Single Checkbox ============== 

        jQuery(".adcreate_request_checkbox").click(function() {

            var thisID = jQuery(this).attr("requestID");
            var thisRType = jQuery(this).attr("r_type");

            if (jQuery(this).prop("checked")) {
                jQuery("tr #id_selectedRequest_" + thisID).css("background-color", "#c0e6ff");
            } else {
                if (jQuery("tr #id_selectedRequest_" + thisID).prop("class") == "odd") {
                    jQuery("tr #id_selectedRequest_" + thisID).css("background-color", "#fff");
                } else {
                    jQuery("tr #id_selectedRequest_" + thisID).css("background-color", "#ececec");
                }
            }

        });

	}
	
	//===========
	function delTable1() {
		
        var requestCheckboxList = jQuery("[name='request_checkbox']");
        var requests_ID_checked = {};
        var selectedCSRTable1Tmp = selectedCSRTable1;
        requests_checked_list = new Array();
        for (var int = 0; int < requestCheckboxList.length; int++) {
            if (jQuery(requestCheckboxList[int]).is(":checked")) {
            	
            	requests_ID_checked = jQuery(requestCheckboxList[int]).attr("requestID");
            	
            	for(var j=0;j<selectedCSRTable1.length;j++){
					if(selectedCSRTable1[j].requestId==requests_ID_checked){
						selectedCSRTable1.splice(j,1);
						count--;
					}
					
				}
            }
        }

		
		myTable.del();
		
		var table_1_content = jQuery("#table_1").DataTable().clear();
		
		for (var i = 0; i < selectedCSRTable1.length; i++) {

			if(selectedCSRTable1[i].cwaId != "" && !(selectedCSRTable1[i].cwaId == null)) {
				var input_col_0 = '';
				var input_col_1 = "<a href=" + myTbsContext + "/action/portal/schedulePanel/openCognosSchedulePanel/"
								+ selectedCSRTable1[i].requestId + "/" + selectedCSRTable1[i].tbsDomainKey
								+ " target='_blank'>"
								+ selectedCSRTable1[i].rptName;
								+ "</a>";			
				var input_col_2 = selectedCSRTable1[i].emailSubject;
				
				var freq = selectedCSRTable1[i].schedFreq;
	    		var freqDtl = selectedCSRTable1[i].freqDetail;
	    		
				var triggerType = selectedCSRTable1[i].triggerType;
				if ((triggerType=='W') && (freq=='D'))
					freq='W';
				if ((triggerType=='D') && !(freq=='M'))
					freq='D';
				if (triggerType=='N')
					freq='N';
				
				var t = "";
				if (freq=='M') {
					t = "Monthly";
				}else if (freq == 'B') {
					t = "Business";
				}else if (freq == 'D') {
					t = "Daily";
				}else if (freq == 'W') {
					t = "Weekly";
					if (freqDtl == "M,Tu,W,Th,F,Sa,Su")
						freqDtl="";
					else{
						var flag=freqDtl.indexOf(',');
						if(flag >= 0)
							freqDtl =freqDtl.substring(0,flag);
					}
				}else if (freq=='N') {
					t = "NRT";
					freqDtl="";
				}
	        	
                var input_col_3 = t + "<br />" + freqDtl;			
				
                //var input_col_3 = selectedCSRTable1[i].schedFreq;
                var input_col_4 = selectedCSRTable1[i].dataMart;
                var input_col_5 = selectedCSRTable1[i].expirationDate;
                var input_col_6 = selectedCSRTable1[i].tbsDomainKey;
                
                if(selectedCSRTable1[i].requestStatus!= undefined){
                	
                	input_col_0 += "<input id='adcreate_" + selectedCSRTable1[i].requestId + "_checkbox' requestID='" + selectedCSRTable1[i].requestId + "' r_type='_1'"+    " type='checkbox' name='request_checkbox' class='ibm-styled-checkbox adcreate_request_checkbox'>";
                    input_col_0 += "<label for='adcreate_" + selectedCSRTable1[i].requestId + "_checkbox'>";
                    input_col_0 += "<span class='ibm-access'>Select one</span>";
                    input_col_0 += "</input>";
                	
                	var input_col_7 = selectedCSRTable1[i].requestStatus;
                	var input_col_8 = selectedCSRTable1[i].comments;
                    var input_col_9 = selectedCSRTable1[i].requestId;
                    var input_col_10 = "Cognos schedule";
                    
                    //Output Status
                    var tmp_lasttStatus=selectedCSR[i].lastStatus;
                    var lastStatusMsg="Unavailable"
                    //Last Ready Time
                    var input_col_12 = 'N/A';
                   	if(tmp_lasttStatus=='100'||tmp_lasttStatus=='101'){
                        lastStatusMsg="Ready";
                        input_col_12=ToDate(selectedCSR[i].readyTime);
                    }
                    var input_col_11=lastStatusMsg;
                    
                    r_type="_1";
                }
                var dataSet = [input_col_0, input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7, input_col_8, input_col_9, input_col_10, input_col_11, input_col_12]
                table_1_content.row.add(dataSet).draw();
                jQuery(table_1_content.row(count).node()).attr('id', 'id_selectedRequest_' + selectedCSRTable1[i].requestId);
			}
			
			else {
				var upload_col_0 = '';
					upload_col_0 += "<input id='adcreate_" + selectedCSRTable1[i].requestId + "_checkbox' requestID='" + selectedCSRTable1[i].requestId + "' r_type='_2'"+    " type='checkbox' name='request_checkbox' class='ibm-styled-checkbox adcreate_request_checkbox'>";
					upload_col_0 += "<label for='adcreate_" + selectedCSRTable1[i].requestId + "_checkbox'>";
					upload_col_0 += "<span class='ibm-access'>Select one</span>";
					upload_col_0 += "</input>";
					
				var upload_col_1 = "<a href=" + myTbsContext + "/action/portal/autodeck/xlsmanage/getXLSManagePage/"
								+ " target='_blank'>"
								+ selectedCSRTable1[i].fileName
								+ "</a>";
				var upload_col_2 = selectedCSRTable1[i].fileDesc;
				var upload_col_3 = '';
				var upload_col_4 = '';
				var upload_col_5 = uploadListFormatDate(selectedCSRTable1[i].expirationDate);
				var upload_col_6 = '';
				var upload_col_7 = selectedCSRTable1[i].status;
				var upload_col_8 = '';
				var upload_col_9 = selectedCSRTable1[i].requestId;
				var upload_col_10 = 'Uploaded file';
				
				//Output Status
	            var upload_col_11='N/A';
	            //“Last Ready Time
	            var upload_col_12='N/A';
	            
				var r_type="_2";
				
				var dataSet = [upload_col_0, upload_col_1, upload_col_2, upload_col_3, upload_col_4, upload_col_5, upload_col_6, upload_col_7, upload_col_8, upload_col_9, upload_col_10, upload_col_11, upload_col_12]
                table_1_content.row.add(dataSet).draw();
                jQuery(table_1_content.row(count).node()).attr('id', 'id_selectedRequest_' + selectedCSRTable1[i].requestId);
			}


                
     
			}
			
		}

    
    // ============ Verification of actions =============
    function verifyAction() {
        var requestCheckboxList = jQuery("[name='request_checkbox']");
        requests_checked_str = "";
        requests_checked_list = new Array();
        for (var int = 0; int < requestCheckboxList.length; int++) {
            //if (jQuery(requestCheckboxList[int]).is(":checked")) {
            	requests_checked_str += jQuery(requestCheckboxList[int]).attr("requestID") + "_" + jQuery(requestCheckboxList[int]).attr("r_type") + ",";
            	requests_checked_list.push(jQuery(requestCheckboxList[int]).attr("requestID"));
            //}
        }

        if (requestCheckboxList.length == 0 || requestCheckboxList == "") {
            //alert("Please select scheduled report!");
            return false;
        }

        return requests_checked_str;
    }
    
    function pptOutputTemplate1(){
    	jQuery("#templateid2").removeAttr("checked");
    	jQuery("#templateid3").removeAttr("checked");
		
		jQuery("#templateid1").attr("checked","checked");
		jQuery("#templateid1").prop("checked", true);
    }
    
    function pptOutputTemplate2(){
    	jQuery("#templateid1").removeAttr("checked");
    	jQuery("#templateid3").removeAttr("checked");
		
		jQuery("#templateid2").attr("checked","checked");
		jQuery("#templateid2").prop("checked", true);
    }
    
    function pptOutputTemplate3(){
    	jQuery("#templateid1").removeAttr("checked");
    	jQuery("#templateid2").removeAttr("checked");
		
		jQuery("#templateid3").attr("checked","checked");
		jQuery("#templateid3").prop("checked", true);
    }
    
    
    function pptPastetypes1(){
    	jQuery("#pasteTypeid2").removeAttr("checked");
		
		jQuery("#pasteTypeid1").attr("checked","checked");
		jQuery("#pasteTypeid1").prop("checked", true);
    }
    
    function pptPastetypes2(){
    	jQuery("#pasteTypeid1").removeAttr("checked");
		
		jQuery("#pasteTypeid2").attr("checked","checked");
		jQuery("#pasteTypeid2").prop("checked", true);
    }
    
    function appendfiles1(){
    	jQuery("#dateTypeid2").removeAttr("checked");
    	jQuery("#dateTypeid3").removeAttr("checked");
		
		jQuery("#dateTypeid1").attr("checked","checked");
		jQuery("#dateTypeid1").prop("checked", true);
    }
    
    function appendfiles2(){
    	jQuery("#dateTypeid1").removeAttr("checked");
    	jQuery("#dateTypeid3").removeAttr("checked");
		
		jQuery("#dateTypeid2").attr("checked","checked");
		jQuery("#dateTypeid2").prop("checked", true);
    }
    
    function appendfiles3(){
    	jQuery("#dateTypeid1").removeAttr("checked");
    	jQuery("#dateTypeid2").removeAttr("checked");
		
		jQuery("#dateTypeid3").attr("checked","checked");
		jQuery("#dateTypeid3").prop("checked", true);
    }
    
    function SelectWeekNoSun(){
    	jQuery("#id_radio_mon").removeAttr("checked");
    	jQuery("#id_radio_tue").removeAttr("checked");
    	jQuery("#id_radio_wed").removeAttr("checked");
    	jQuery("#id_radio_fri").removeAttr("checked");
    	jQuery("#id_radio_sat").removeAttr("checked");
    	jQuery("#id_radio_default").removeAttr("checked");
		
		jQuery("#id_radio_sun").attr("checked","checked");
		jQuery("#id_radio_sun").prop("checked", true);
    }
    
    function SelectWeekNoMon(){
    	jQuery("#id_radio_sun").removeAttr("checked");
    	jQuery("#id_radio_tue").removeAttr("checked");
    	jQuery("#id_radio_wed").removeAttr("checked");
    	jQuery("#id_radio_thu").removeAttr("checked");
    	jQuery("#id_radio_fri").removeAttr("checked");
    	jQuery("#id_radio_sat").removeAttr("checked");
    	jQuery("#id_radio_default").removeAttr("checked");
		
		jQuery("#id_radio_mon").attr("checked","checked");
		jQuery("#id_radio_mon").prop("checked", true);
    }
    
    function SelectWeekNoTue(){
    	jQuery("#id_radio_mon").removeAttr("checked");
    	jQuery("#id_radio_sun").removeAttr("checked");
    	jQuery("#id_radio_wed").removeAttr("checked");
    	jQuery("#id_radio_thu").removeAttr("checked");
    	jQuery("#id_radio_fri").removeAttr("checked");
    	jQuery("#id_radio_sat").removeAttr("checked");
    	jQuery("#id_radio_default").removeAttr("checked");
		
		jQuery("#id_radio_tue").attr("checked","checked");
		jQuery("#id_radio_tue").prop("checked", true);
    }
    
    function SelectWeekNoWed(){
    	jQuery("#id_radio_mon").removeAttr("checked");
    	jQuery("#id_radio_tue").removeAttr("checked");
    	jQuery("#id_radio_sun").removeAttr("checked");
    	jQuery("#id_radio_thu").removeAttr("checked");
    	jQuery("#id_radio_fri").removeAttr("checked");
    	jQuery("#id_radio_sat").removeAttr("checked");
    	jQuery("#id_radio_default").removeAttr("checked");
		
		jQuery("#id_radio_wed").attr("checked","checked");
		jQuery("#id_radio_wed").prop("checked", true);
    }
    
    function SelectWeekNoThu(){
    	jQuery("#id_radio_mon").removeAttr("checked");
    	jQuery("#id_radio_tue").removeAttr("checked");
    	jQuery("#id_radio_wed").removeAttr("checked");
    	jQuery("#id_radio_sun").removeAttr("checked");
    	jQuery("#id_radio_fri").removeAttr("checked");
    	jQuery("#id_radio_sat").removeAttr("checked");
    	jQuery("#id_radio_default").removeAttr("checked");
		
		jQuery("#id_radio_thu").attr("checked","checked");
		jQuery("#id_radio_thu").prop("checked", true);
    }
    
    function SelectWeekNoFri(){
    	jQuery("#id_radio_mon").removeAttr("checked");
    	jQuery("#id_radio_tue").removeAttr("checked");
    	jQuery("#id_radio_wed").removeAttr("checked");
    	jQuery("#id_radio_thu").removeAttr("checked");
    	jQuery("#id_radio_sun").removeAttr("checked");
    	jQuery("#id_radio_sat").removeAttr("checked");
    	jQuery("#id_radio_default").removeAttr("checked");
		
		jQuery("#id_radio_fri").attr("checked","checked");
		jQuery("#id_radio_fri").prop("checked", true);
    }
    
    function SelectWeekNoSat(){
    	jQuery("#id_radio_mon").removeAttr("checked");
    	jQuery("#id_radio_tue").removeAttr("checked");
    	jQuery("#id_radio_wed").removeAttr("checked");
    	jQuery("#id_radio_thu").removeAttr("checked");
    	jQuery("#id_radio_fri").removeAttr("checked");
    	jQuery("#id_radio_sun").removeAttr("checked");
    	jQuery("#id_radio_default").removeAttr("checked");
		
		jQuery("#id_radio_sat").attr("checked","checked");
		jQuery("#id_radio_sat").prop("checked", true);
    }
    
    function SelectWeekNoAto(){
    	jQuery("#id_radio_mon").removeAttr("checked");
    	jQuery("#id_radio_tue").removeAttr("checked");
    	jQuery("#id_radio_wed").removeAttr("checked");
    	jQuery("#id_radio_thu").removeAttr("checked");
    	jQuery("#id_radio_fri").removeAttr("checked");
    	jQuery("#id_radio_sat").removeAttr("checked");
    	jQuery("#id_radio_sun").removeAttr("checked");
		
		jQuery("#id_radio_default").attr("checked","checked");
		jQuery("#id_radio_default").prop("checked", true);
    }
    
    function SelectZipYes(){
    	jQuery("#zip_output_NO_id").removeAttr("checked");
		
		jQuery("#zip_output_YES_id").attr("checked","checked");
		jQuery("#zip_output_YES_id").prop("checked", true);
    }
    
    function SelectZipNo(){
    	jQuery("#zip_output_YES_id").removeAttr("checked");
		
		jQuery("#zip_output_NO_id").attr("checked","checked");
		jQuery("#zip_output_NO_id").prop("checked", true);
    }
    
	
	function checkDisplayTemplate(){
	
		if(jQuery("#UPDATE_Salutation_id1").val()==2){
		
			jQuery('#is_outline_group1').show();
			jQuery('#UPDATE-grp-lbl-id61').show();
			//jQuery('#UPDATE-grp-lbl-id071').show();
			jQuery('#UPDATE-grp-lbl-id071').hide();
			
		}
		else{
			jQuery('#is_outline_group1').hide();
			jQuery('#UPDATE-grp-lbl-id61').hide();
			jQuery('#UPDATE-grp-lbl-id071').hide();
		}
	}
	
	
	function checkScheduleFrequency(){
		
		if(jQuery("#is_provisional").val()=='N'){
			jQuery('#tr_id_ScheduleFrequency').hide();
			jQuery('#tr_id_blankrow').hide();
			jQuery('#tr_id_DropDownTimezone').hide();
		}
		else if(jQuery("#is_provisional").val()=='W'){
			jQuery('#tr_id_ScheduleFrequency').show();
			jQuery('#tr_id_blankrow').show();
			jQuery('#tr_id_DropDownTimezone').show();
		}
		else if(jQuery("#is_provisional").val()=='Y'){
			jQuery('#tr_id_ScheduleFrequency').show();
			jQuery('#tr_id_blankrow').show();
			jQuery('#tr_id_DropDownTimezone').show();
		}
	}

	
	function displayDateFormat(src){
	
		if ( src==null ){
	        alert('error occured loading data');
	        return -1;
	    }
	    
	    if ( src.type=='RADIO' || src.type=='radio' ) {
			srcRadio = src;
			outPutValue=srcRadio.value;
			
			if (outPutValue=='Y'){
				//switch to Yes radio
				jQuery("#appanddate_NO_id").removeAttr("checked");
				jQuery("#appanddate_YES_id").attr("checked","checked");
				jQuery("#appanddate_YES_id").prop("checked", true);
				//display date format
				jQuery('#UPDATE-grp-lbl-id601').show();
				}else if (outPutValue=='N'){
					//switch to No radio
					jQuery("#appanddate_YES_id").removeAttr("checked");
					jQuery("#appanddate_NO_id").attr("checked","checked");
					jQuery("#appanddate_NO_id").prop("checked", true);
					//hide date format
					jQuery('#UPDATE-grp-lbl-id601').hide();
				}else{
	 				alert('error occured loading data');
	       			return -1;
				}
			
		}
	}
	
	
	function displayZipout(src){
	
		if ( src==null ){
	        alert('error occured loading data');
	        return -1;
	    }
	    
	    if ( src.type=='RADIO' || src.type=='radio' ) {
			srcRadio = src;
			outPutValue=srcRadio.value;
			
			if (outPutValue=='ATTACHMENT'){
				//display date format
				jQuery('#UPDATE-grp-lbl-zipoutputP').show();
				
				jQuery("#send_option_link_id").removeAttr("checked");
				
				jQuery("#send_option_att_id").attr("checked","checked");
				jQuery("#send_option_att_id").prop("checked", true);
				}else if (outPutValue=='LINK'){
					jQuery('#UPDATE-grp-lbl-zipoutputP').hide();
					
					jQuery("#send_option_att_id").removeAttr("checked");
					
					jQuery("#send_option_link_id").attr("checked","checked");
					jQuery("#send_option_link_id").prop("checked", true);
				}else{
	 				alert('error occured loading data');
	       			return -1;
				}
		}
	}
	
	function MergeScheduleDate(){

    	jQuery("#id_sched_freq_M").removeAttr("checked");
		
		jQuery("#id_radio_sched_freq").attr("checked","checked");
		jQuery("#id_radio_sched_freq").prop("checked", true);
		var freqDetail = jQuery("#id_D_sched_freq_detail").val();
		jQuery("#id_hidden_sched_freq_detail").val(freqDetail);
	
	}
	
	function MergeScheduleDateM(){

    	jQuery("#id_radio_sched_freq").removeAttr("checked");
		
		jQuery("#id_sched_freq_M").attr("checked","checked");
		jQuery("#id_sched_freq_M").prop("checked", true);
		var freqDetail = jQuery("#id_M_sched_freq_detail").val();
		jQuery("#id_hidden_sched_freq_detail").val(freqDetail);

	}
	
	//================ displayAllRequest() =====================
    function displayAllRequest(){

        document.getElementById('tabspantext').innerHTML='All requests';
		
    	jQuery("#tbody_table_2").empty();
		
    	var table_2_content = jQuery("#table_2").DataTable().clear();
    	
        for (var i = 0; i < selectedCSR.length; i++) {
       	 
        	var selectedRequest = selectedCSR[i];
        		
            	var input_col_0 = "<a href=" + myTbsContext + "/action/portal/schedulePanel/openCognosSchedulePanel/"
								+ selectedRequest.requestId + "/" + selectedRequest.tbsDomainKey
								+ " target='_blank'>"
								+ selectedRequest.rptName;
								+ "</a>";
				var input_col_1 = selectedRequest.emailSubject;
				var input_col_2 = selectedRequest.schedFreq;
				var input_col_3 = selectedRequest.dataMart;
				var input_col_4 = selectedRequest.expirationDate;
				var input_col_5 = selectedRequest.tbsDomainKey;
				var input_col_6 = selectedRequest.requestStatus;
				var input_col_7 = selectedRequest.emailComments;
				var input_col_8 = "<a href=\"javascript:void(0)\" onclick=\"addToSelect(this,'"+selectedCSR[i].requestId+"')\">Add</a>";
				
				var dataSet = [input_col_0, input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7, input_col_8]
				//table_2_content.row.add(dataSet).draw();
				table_2_content.row.add(dataSet);
				
				//jQuery(table_2_content.row(i).node()).attr('id', 'id_selectedCSR_' + selectedRequest.requestId);

        }
        table_2_content.draw();

    }


    
    //================ displayOwn() =====================
    function displayOwn(){

        document.getElementById('tabspantext').innerHTML='Owned by me';
    	
    	jQuery("#tbody_table_2").empty();
    	
    	var table_2_content = jQuery("#table_2").DataTable().clear();;
    	
        for (var i = 0; i < selectedCSR.length; i++) {
       	 
        	var selectedRequest = selectedCSR[i];
        	
        	if(selectedRequest.cwaId==cwa_id){
        		
            	var input_col_0 = "<a href=" + myTbsContext + "/action/portal/schedulePanel/openCognosSchedulePanel/"
								+ selectedRequest.requestId + "/" + selectedRequest.tbsDomainKey
								+ " target='_blank'>"
								+ selectedRequest.rptName;
								+ "</a>";
				var input_col_1 = selectedRequest.emailSubject;
				var input_col_2 = selectedRequest.schedFreq;
				var input_col_3 = selectedRequest.dataMart;
				var input_col_4 = selectedRequest.expirationDate;
				var input_col_5 = selectedRequest.tbsDomainKey;
				var input_col_6 = selectedRequest.requestStatus;
				var input_col_7 = selectedRequest.emailComments;
				var input_col_8 = "<a href=\"javascript:void(0)\" onclick=\"addToSelect(this,'"+selectedCSR[i].requestId+"')\">Add</a>";
				
				var dataSet = [input_col_0, input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7, input_col_8]
				//table_2_content.row.add(dataSet).draw();
				table_2_content.row.add(dataSet);
				
				//jQuery(table_2_content.row(i).node()).attr('id', 'id_selectedCSR_' + selectedRequest.requestId);
        	}

        }
        table_2_content.draw();
    }
    
    //================ displayOther() =====================
    function displayOther(){

        document.getElementById('tabspantext').innerHTML='Owned by others';
    	
    	jQuery("#tbody_table_2").empty();
    	
    	var table_2_content = jQuery("#table_2").DataTable().clear();;
    	
        for (var i = 0; i < selectedCSR.length; i++) {
       	 
        	var selectedRequest = selectedCSR[i];
        	
        	if(!(selectedRequest.cwaId==cwa_id)){
        		
            	var input_col_0 = "<a href=" + myTbsContext + "/action/portal/schedulePanel/openCognosSchedulePanel/"
								+ selectedRequest.requestId + "/" + selectedRequest.tbsDomainKey
								+ " target='_blank'>"
								+ selectedRequest.rptName;
								+ "</a>";
				var input_col_1 = selectedRequest.emailSubject;
				var input_col_2 = selectedRequest.schedFreq;
				var input_col_3 = selectedRequest.dataMart;
				var input_col_4 = selectedRequest.expirationDate;
				var input_col_5 = selectedRequest.tbsDomainKey;
				var input_col_6 = selectedRequest.requestStatus;
				var input_col_7 = selectedRequest.emailComments;
				var input_col_8 = "<a href=\"javascript:void(0)\" onclick=\"addToSelect(this,'"+selectedCSR[i].requestId+"')\">Add</a>";
				
				var dataSet = [input_col_0, input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7, input_col_8]
				//table_2_content.row.add(dataSet).draw();
				table_2_content.row.add(dataSet);
				//jQuery(table_2_content.row(i).node()).attr('id', 'id_selectedCSR_' + selectedRequest.requestId);
        	}

        }
        table_2_content.draw();
    }
	
	function submitFormNew(){
		//alert("submit!")
		timeid = (new Date()).valueOf();
		
		var paramAutoDeck = {};
		var autodeck = {};
		var target = {};
		var inputRequests = [];
		
		var id = {};
		var requestType = 0;
		var inputRequest = {};
		
		//hardcode生成id对象
		id["convertId"] = "convertId1";
		id["requestId"] = "requestId1";
		id["seq"] = 0;
		
		//hardcode生成一个inputRequest对象
		inputRequest["id"] = id;
		inputRequest["requestType"] = requestType;
		//
		inputRequests[0] = inputRequest;
		
		//var selectedRequestsNew = "abc1_1,def2_2,gh3_3";
		
		//var selectedRequestsNew = "";
		
		//showLoading();
		
		if (!verifyAction()) {
			alert('Please select scheduled report!');
			return false;
        }else{
        	var selectedRequestsNew = verifyAction();
        }
		
		//remove the last ','
		if(!(selectedRequestsNew=='')){
			
			if (selectedRequestsNew.substring(selectedRequestsNew.length-1,selectedRequestsNew.length) == ",") {
				selectedRequestsNew=selectedRequestsNew.substring(0,selectedRequestsNew.length-1);
			}
		}
		
		//targetFileName   aft.setTargetFileName(paramAutoDeck.getTarget().getTargetFileName());
		var targetFileName = jQuery("#UPDATE_First_name_id").val().trim();
		if(targetFileName==null||targetFileName==""){
			alert('Please provide the requested file name!');
			return false;
		}
		if(targetFileName.length>33){
			alert('Please input file name no more than 33 characters.');
			return false;
		}
		var reg1 = /^((\w)+( )*)*$/;
		if(!reg1.test(targetFileName)){
			alert('please input the correct format for the file name,like output_1');
			return false;
		}
		target["targetFileName"] = targetFileName;
		
		//expirationDate   af.setExpirationDate(paramAutoDeck.getAutodeck().getExpirationDate());
		var expirationDate = jQuery("#datepicker").val();
		while(expirationDate.indexOf('/') >= 0)
			expirationDate = expirationDate.replace('/','-');
		if(expirationDate==null||expirationDate==""){
			alert('Please input Expiration date!');
			return false;
		}
		var reg2 = /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/;
		if(!reg2.test(expirationDate)){
			alert('please input the correct format for the expiration date,like 2012-12-31');
			return false;
		}
		autodeck["expirationDate"] = expirationDate;
		//autodeck["expirationDate"] = "2017-05-18T12:15:11.625Z";
		
		//emailSubject   af.setEMailSubject(paramAutoDeck.getAutodeck().getEMailSubject());
		var emailSubject = jQuery("#UPDATE_Subject_id").val().trim();
		if(emailSubject==null||emailSubject==''){
			alert('Please input the e-Mail subject!');
			return false;
		}
		if(emailSubject.length>60){
			alert('The maximum length for the e-Mail subject field is 60!');
			return false;
		}
		autodeck["emailSubject"] = emailSubject;
		
		//emailAddress   af.setEMailAddress(paramAutoDeck.getAutodeck().getEMailAddress());
		var emailAddress = jQuery("#UPDATE_E_mail_address_id").val().trim();
		if(emailAddress==null||emailAddress==''){
			alert('Please add at least one e-Mail address!');
			return false;
		}
		if(emailAddress.length>240){
			alert('The maximum length for the e-Mail address field is 240!');
			return false;
		}
		autodeck["emailAddress"] = emailAddress;
		
		//targetFileTypeCd  aft.setTargetFileTypeCd(paramAutoDeck.getTarget().getTargetFileTypeCd());
		var targetFileTypeCd = jQuery("#UPDATE_Salutation_id1").val();
		if(targetFileTypeCd==null||targetFileTypeCd==""){
			alert('Please select output file type!');
			return false;
		}
		target["targetFileTypeCd"] = targetFileTypeCd;
		
		//backupOwner   af.setBackupOwner(paramAutoDeck.getAutodeck().getBackupOwner());
		var backupOwner = jQuery("#UPDATE_E_mail_backup_cwa_id").val().trim();
		if(backupOwner.length>128){
			alert("The maximum length for the Backup field is 128!");
			return false;
		}
		if(backupOwner != "") {
			var reg1_backup_cwaid = /^([a-zA-Z0-9]*[_|\_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]*[_|\_|\-|\.]?)*([a-zA-Z0-9]+\.)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
			if(!reg1_backup_cwaid.test(backupOwner)){
				alert("Please use the correct format for the Backup owner like jdoe@us.ibm.com.  \nNote that you can only have one Backup e-Mail address.");
				return false;
			}
		}
		if(backupOwner == cwa_id) {
			alert("The Backup cannot be the same as the Owner e-Mail address for this Autodeck.");
			return false;
		}
		autodeck["backupOwner"] = backupOwner;
		
		//emailComments   af.setEmailComments(paramAutoDeck.getAutodeck().getEmailComments());
		var emailComments = jQuery("#UPDATE_Message_id").val();
		if(emailComments.length>240){
			alert("The maximum length for the e-Mail content field is 240!");
			return false;
		}
		autodeck["emailComments"] = emailComments;
		
		//schedFreq, schedFreqDetail   af.setSchedFreq(paramAutoDeck.getAutodeck().getSchedFreq());
		var checkedIdRadioSchedFreq = jQuery("#id_radio_sched_freq").attr('checked');
		if(checkedIdRadioSchedFreq){
			var schedFreqD1 = jQuery("#id_D_sched_freq_detail");
			if((schedFreqD1.val()==null || schedFreqD1.val()=='') && jQuery("#is_provisional").val()!='N'){
			alert('Please at least select one day for the schedule frequency when you choose Daily/weekly frequency!');
			return false;
			}
			autodeck["schedFreq"] = jQuery("#id_radio_sched_freq").val();
			
			var schedFreqDetail = "";
			var schedFreqDetailArray = jQuery("#id_D_sched_freq_detail").val();
			if(schedFreqDetailArray != "" && !(schedFreqDetailArray == null)){
				for(var j=0; j<schedFreqDetailArray.length; j++){
					schedFreqDetail+=schedFreqDetailArray[j];
					if(j<schedFreqDetailArray.length-1){
						schedFreqDetail+=',';
					}
				}
			}
			autodeck["schedFreqDetail"] = schedFreqDetail;
		}
		
		var checkedIdRadioSchedFreqM = jQuery("#id_sched_freq_M").attr('checked');
		if(checkedIdRadioSchedFreqM){
			var schedFreqM1 = jQuery("#id_M_sched_freq_detail");
			if((schedFreqM1.val()==null || schedFreqM1.val()=='') && jQuery("#is_provisional").val()!='N'){
				alert('Please at least select one day for the schedule frequency when you choose monthly frequency!');
				return false;
			}
			autodeck["schedFreq"] = jQuery("#id_sched_freq_M").val();
			
			var schedFreqDetail = "";
			var schedFreqDetailArray = jQuery("#id_M_sched_freq_detail").val();
			if(schedFreqDetailArray != "" && !(schedFreqDetailArray == null)){
				for(var j=0; j<schedFreqDetailArray.length; j++){
					schedFreqDetail+=schedFreqDetailArray[j];
					if(j<schedFreqDetailArray.length-1){
						schedFreqDetail+=',';
					}
				}
			}
			autodeck["schedFreqDetail"] = schedFreqDetail;
		}
		
		//isOutline   String isOutLine = paramAutoDeck.getTarget().getIsOutline();
		if(jQuery("#is_outline").prop("checked")){
			target["isOutline"] = "Y";
		}
		else{
			target["isOutline"] = "N";
		}
		
		//autofileTemplate   aft.setAutofileTemplate(paramAutoDeck.getTarget().getAutofileTemplate());
		var checkedTemplateid1 = jQuery("#templateid1").attr('checked');
		if(checkedTemplateid1){
			target["autofileTemplate"] = jQuery("#templateid1").val();
		}
		
		var checkedTemplateid2 = jQuery("#templateid2").attr('checked');
		if(checkedTemplateid2){
			target["autofileTemplate"] = jQuery("#templateid2").val();
		}
		
		var checkedTemplateid3 = jQuery("#templateid3").attr('checked');
		if(checkedTemplateid3){
			target["autofileTemplate"] = jQuery("#templateid3").val();
		}
		
		//pptPasteTypeId   aft.setPptPasteTypeId(paramAutoDeck.getTarget().getPptPasteTypeId());
		var checkedPasteTypeid1 = jQuery("#pasteTypeid1").attr('checked');
		if(checkedPasteTypeid1){
			target[jQuery("#pasteTypeid1").attr('name')] = jQuery("#pasteTypeid1").val();
		}
		
		var checkedPasteTypeid2 = jQuery("#pasteTypeid2").attr('checked');
		if(checkedPasteTypeid2){
			target[jQuery("#pasteTypeid2").attr('name')] = jQuery("#pasteTypeid2").val();
		}
		
		//sendOption   aft.setSendOption(paramAutoDeck.getTarget().getSendOption());
		var checkedSendOptionLinkId = jQuery("#send_option_link_id").attr('checked');
		if(checkedSendOptionLinkId){
			target["sendOption"] = jQuery("#send_option_link_id").val();
			target["zipOutput"] = jQuery("#zip_output_NO_id").val();
		}
		
		var checkedSendOptionAttId = jQuery("#send_option_att_id").attr('checked');
		if(checkedSendOptionAttId){
			target["sendOption"] = jQuery("#send_option_att_id").val();
			
			//zipOutput   aft.setZipOutput(paramAutoDeck.getTarget().getZipOutput());
			var checkedZipOutputNoId = jQuery("#zip_output_NO_id").attr('checked');
			if(checkedZipOutputNoId){
				target["zipOutput"] = jQuery("#zip_output_NO_id").val();
			}
			var checkedZipOutputNoId = jQuery("#zip_output_YES_id").attr('checked');
			if(checkedZipOutputNoId){
				target["zipOutput"] = jQuery("#zip_output_YES_id").val();
			}
		}
		
		//appendDate   String appendDate = paramAutoDeck.getTarget().getAppendDate();
		var checkedAppanddateNoId = jQuery("#appanddate_NO_id").attr('checked');
		if(checkedAppanddateNoId){
			target[jQuery("#appanddate_NO_id").attr('name')] = jQuery("#appanddate_NO_id").val();
		}
		
		var checkedAppanddateYesId = jQuery("#appanddate_YES_id").attr('checked');
		if(checkedAppanddateYesId){
			target[jQuery("#appanddate_YES_id").attr('name')] = jQuery("#appanddate_YES_id").val();
			
			//dateTypeCd   appendDateTypeCd = paramAutoDeck.getDateTypeCd();
			var checkedDateTypeid1 = jQuery("#dateTypeid1").attr('checked');
			if(checkedDateTypeid1){
				paramAutoDeck[jQuery("#dateTypeid1").attr('name')] = jQuery("#dateTypeid1").val();
			}
			
			var checkedDateTypeid2 = jQuery("#dateTypeid2").attr('checked');
			if(checkedDateTypeid2){
				paramAutoDeck[jQuery("#dateTypeid2").attr('name')] = jQuery("#dateTypeid2").val();
			}
			
			var checkedDateTypeid3 = jQuery("#dateTypeid3").attr('checked');
			if(checkedDateTypeid3){
				paramAutoDeck[jQuery("#dateTypeid3").attr('name')] = jQuery("#dateTypeid3").val();
			}
		}
		
		//finalDeckWeekNo   String finalDeckWeekNo = paramAutoDeck.getAutodeck().getFinalDeckWeekNo();
		var checkedIdRadioSun = jQuery("#id_radio_sun").attr('checked');
		if(checkedIdRadioSun){
			autodeck["finalDeckWeekNo"] = jQuery("#id_radio_sun").val();
		}
		
		var checkedIdRadioMon = jQuery("#id_radio_mon").attr('checked');
		if(checkedIdRadioMon){
			autodeck["finalDeckWeekNo"] = jQuery("#id_radio_mon").val();
		}
		
		var checkedIdRadioTue = jQuery("#id_radio_tue").attr('checked');
		if(checkedIdRadioTue){
			autodeck["finalDeckWeekNo"] = jQuery("#id_radio_tue").val();
		}
		
		var checkedIdRadioWed = jQuery("#id_radio_wed").attr('checked');
		if(checkedIdRadioWed){
			autodeck["finalDeckWeekNo"] = jQuery("#id_radio_wed").val();
		}
		
		var checkedIdRadioThu = jQuery("#id_radio_thu").attr('checked');
		if(checkedIdRadioThu){
			autodeck["finalDeckWeekNo"] = jQuery("#id_radio_thu").val();
		}
		
		var checkedIdRadioFri = jQuery("#id_radio_fri").attr('checked');
		if(checkedIdRadioFri){
			autodeck["finalDeckWeekNo"] = jQuery("#id_radio_fri").val();
		}
		
		var checkedIdRadioSat = jQuery("#id_radio_sat").attr('checked');
		if(checkedIdRadioSat){
			autodeck["finalDeckWeekNo"] = jQuery("#id_radio_sat").val();
		}
		
		var checkedIdRadioDefault = jQuery("#id_radio_default").attr('checked');
		if(checkedIdRadioDefault){
			autodeck["finalDeckWeekNo"] = jQuery("#id_radio_default").val();
		}
		
		
		//finalDeckTime   int finalDeckTime = paramAutoDeck.getAutodeck().getFinalDeckTime();
		autodeck["finalDeckTime"] = jQuery("#final_deck_time_id").val();

		//gmtTime   af.setGmtTime(paramAutoDeck.getAutodeck().getGmtTime());
		autodeck["gmtTime"] = jQuery("#DropDownTimezone").val();
		
		//provisional   String isProvisional =paramAutoDeck.getAutodeck().getProvisional();
		autodeck["provisional"] = jQuery("#is_provisional").val();
		
		autodeck["convertOwner"] = cwa_id;
		autodeck["setDefault"] = "Y";   //hard code to 'Y'
		
		paramAutoDeck["autodeck"] = autodeck;
		paramAutoDeck["target"] = target;
		//paramAutoDeck["inputRequests"] = inputRequests;
		paramAutoDeck["selectedRequestsNew"] = selectedRequestsNew;
		
		
		//////////////////////////////////////
		showLoading();
		jQuery.ajax({
			type : "POST",
			url : "<%=request.getContextPath()%>/action/portal/autodeck/saveAutodeck?timeid=" + timeid ,
			data : JSON.stringify(paramAutoDeck),
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				//console.log("saveAutodeck successfully");
				//var dateTypeCdVal = data.dateTypeCd;
			}
		})
		.done(function(){
			hiddLoading();
			//alert("Saved your autodeck successfully, will forward to Existing Autodecks panel.");
			alert("Autodeck successfully saved - will return to Existing Autodecks page.");
			
			var urlStr = "<%=request.getContextPath()%>/action/portal/autodeck";
			window.location.href=urlStr;

		})
		.fail(function(jqXHR, textStatus, errorThrown){		
			hiddLoading();
			//alert("Saved your schedule failed, will forward to Existing Autodecks panel.");
			
			if (confirm("Unable to save your Autodeck - click \'OK\' to return to the definition and try again or \'Cancel\' to return to Existing Autodecks page.")) {
				var urlStr = "<%=request.getContextPath()%>/action/portal/autodeck/createAutodeck";
				window.location.href=urlStr;
			} else{
				var urlStr = "<%=request.getContextPath()%>/action/portal/autodeck";
				window.location.href=urlStr;
			}
			
		})
	}
	
	function showLoading() {
      	jQuery("#autodeck_loading_id").css({ 'display': 'block', 'opacity': '0.8' });                
        jQuery("#autodeck_ajax_loding_id").css({ 'display':'block','opacity':'0'});
      	jQuery("#autodeck_ajax_loding_id").animate({ 'margin-top': '300px', 'opacity': '1' }, 200);  
	}
	
	function hiddLoading() {                 
		jQuery("#autodeck_loading_id").css({ 'display':'none'}); 
		jQuery("#autodeck_ajax_loding_id").css({ 'display':'none','opacity':'0'});            
	}
	
	function ToDate(timestamp3){
		  
		  var newDate = new Date();
		  newDate.setTime(timestamp3);

		  return newDate.toGMTString();
		  
		}

</script>

