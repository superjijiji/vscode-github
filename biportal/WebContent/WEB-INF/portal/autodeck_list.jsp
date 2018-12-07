<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en-US">

<head>
	<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
	<!-- ================================================================= custom page JS and CSS start -->
    <title>BI@IBM | My Autodeck schedules - Existing Autodecks</title>
    <style type="text/css">
        /* ====================== overriding v18 */
        .dataTables_wrapper .dataTables_filter,
        .dataTables_wrapper .dataTables_length {
            height: 25px;
            margin-bottom: 0px
        }

        table.dataTable thead .sorting,
        table.dataTable thead .sorting_asc,
        table.dataTable thead .sorting_desc {
            background-repeat: no-repeat;
            background-position: center right
        }
        table.dataTable thead .sorting {
            background: none
        }

        a[class*="ibm-btn-"][class*="-pri"][class*="blue-50"],
        a[class*="ibm-btn-"][class*="-sec"][class*="blue-50"],
        .ibm-btn-pri.ibm-btn-small,
        .ibm-btn-sec.ibm-btn-small {
            padding-top: 5px;
            padding-bottom: 5px;
            padding-left: 12px;
            padding-right: 12px;
            font-size: 12px;
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 20px;
            margin-bottom: 20px;
        }
        /* ====================== only for this page */
        div.mydeck_page_title {
            padding-left: 10px;
            float: left;
        }  
        div.mydeck_fullwidth {
            width: 100%;
        }  
        div.mydeck_leftnavwidth {
            width: 214px;
            vertical-align: top;
        }               
        div.mydeck_table {
            margin: 5px;
            display: table;
        }      
        div.mydeck_table {
            margin: 5px;
            display: table;
        }
        div.mydeck_tablerow {
            margin: 5px;
            display: table-row;
        }
        div.mydeck_tablecell {
            margin: 5px;
            display: table-cell;
        }    
        fieldset.mydeck_fieldset_box {
            border: 1px solid #DDD;
        }           
                
    </style>
    <script type="text/javascript">
		//=============================================alias
	    window.$ = window.jQuery;
        //=============================================page stored variable 
        var mydeckHiddenRows = [];
		//=============================================global variables, please do NOT change after init this page
	    var mydeckContext = "<%=request.getContextPath()%>";
	    var mydeckCwa = "${cwa_id}";
	    var mydeckUid = "${uid}";
	    var mydeckCookieSettings = { expires: 999 };
		var mydeckWordExpansionStatus = {
			"A":"Active", 
			"I":"Inactive", 
			"E":"Expired", 
			"S":"Suspended", 
			"D":"Disabled"
		}
		var mydeckTableHeaders=new Array("Checkbox","Deck ID","e-Mail Subject","e-Mail Address", "Comments", "Frequency", "Expiry", "Status", "Type", "Owner", "Execution Status", "Last Run Date(GMT)"); 	
    </script>
    <script type="text/javascript" src="<%=path%>/javascript/js.cookie-2.1.4.js"></script>
    <!-- ================================================================= custom page JS and CSS end -->
</head>

<body id="ibm-com" class="ibm-type">
	<!-- ================================================================= section 1: page head -->
    <jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
    
    
    <!-- ================================================================= section 2: floating bar -->
    <div id="eod-menubar-after-ibm-sitenav" class="mydeck_fullwidth">
        <div class="mydeck_table mydeck_fullwidth">
            <div class="mydeck_page_title">
                <h1 class="ibm-h1 ibm-light">My Autodeck schedules - Existing Autodecks</h1>
            </div>
            <div class="mydeck_page_title">
                <p class="ibm-ind-link ibm-icononly ibm-inlinelink" >
                    <a class="ibm-information-link" target="_blank" 
                    href="<%=path%>/action/portal/pagehelp?pageKey=MyAutodeckSchedules&pageName=My+Autodeck+schedules+-+Existing+Autodecks" 
                    title="Help for My Autodeck schedules - Existing Autodecks"> Help for My Autodeck schedules </a>
                </p>
            </div>
        </div>
        <div class="mydeck_table mydeck_fullwidth">
        		<div class="ibm-btn-row ibm-right">
        			<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mydeck_btn_showhidecol"> Show/Hide columns </a>
        			<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mydeck_btn_showhidenav"> Show/Hide links </a>
        			<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mydeck_btn_showhideunselected"> Show selected/all </a>
				<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mydeck_btn_runnow"> Submit now </a> 
				<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mydeck_btn_activate"> Activate/inactivate </a> 
				<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mydeck_btn_extend"> Extend date </a> 
				<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mydeck_btn_batch"> Bulk update </a>
				<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mydeck_btn_delete"> Delete </a>				
			</div>
        </div>
    </div>


    <!-- ================================================================= section 3: left nav & deck table -->
    <div class="mydeck_fullwidth">
        <div class="mydeck_table">
            <div class="mydeck_tablerow">
                &nbsp;
                <div id="mydeck_left_col"  class="mydeck_tablecell mydeck_leftnavwidth">
					<jsp:include page="/WEB-INF/portal/autodeck_navigator.jsp"></jsp:include>
                </div>
                &nbsp;
                <div id="mydeck_right_col" class="mydeck_tablecell">
                    <div id="mydeck_list2show"></div>
                </div>
                &nbsp;
            </div>
        </div>
    </div>       

    <!-- ================================================================= section 4: hidden overlays -->
 	<div id="mydeck_showhide_columns" class="ibm-common-overlay" data-widget="overlay" data-type="alert">
 		<br>
  		<p>Please specify your settings here.</p>
 		<br>
 		<table id="mydeck_showhide_columns_table" class="ibm-data-table ibm-altcols">
 		</table> 
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="mydeckPageColumnsOk();"	>OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="mydeckPageColumnsCancel();"	>Cancel</button>  	
 		</p>
 	</div>    
 	
 	<div id="mydeck_confirmation_delete" class="ibm-common-overlay ibm-overlay-alt" data-widget="overlay" data-type="alert">
 		<h3 id="mydeck_confirmation_delete_num_selected" class="ibm-h3 ibm-center">0 schedules are selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected Autodeck schedules should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="mydeckBatchDeleteOk();"	>OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="mydeckBatchDeleteCancel();"	>Cancel</button>  	
 		</p>
 	</div>    
 	
    <div id="mydeck_batch_form" class="ibm-common-overlay ibm-overlay-alt" data-widget="overlay" data-type="alert">
    		<h3 id="mydeck_batch_num_selected" class="ibm-h3" >0 schedules are selected.</h3>
	    <p class="ibm-form-elem-grp">
	        <label>Available options:&nbsp;</label>
	        <span>
	            <select id="mydeck_batch_options" onchange="mydeckBatchSelect(this.value);">    
					<option value="activate_or_inactivate"  	>Activate/inactivate </option>		                    	                         
					<option value="copy"  					>Copy selected Autodeck schedules</option>	
					<option value="run_now"  				>Submit now </option>	    
	                <option value="take_owner"  				>Take ownership</option>	
	                <option value="toggle_backup"  			>Toggle back-up</option>					        
	            		<option value="email_backup"  			>e-Mail information - Change backup </option> 	            
	            		<option value="email_list"  				>e-Mail information - Change e-Mail addresses </option>	
	            		<option value="email_comments"  			>e-Mail information - Change e-Mail comments </option> 
	            		<option value="output_date_or_not"  		>Output format - Append date options </option>
					<option value="output_file_name"  		>Output format - Change deck file name </option>						
					<option value="output_link_or_not"  		>Output format - Choose link or attachment </option>		
					<option value="sch_final_sync"  			>Schedule - Change final deck synchronisation</option>	
					<option value="sch_config_msg"  			>Schedule - Change message settings </option>						
					<option value="sch_extend_date"  		>Schedule - Extend date </option>	                        
	            </select>
	        </span>
	    </p>  
	    <br>
	    	<div name="mydeck_batch_operation" id="mydeck_batch_copy" >
	    		<p>Please specify the desired recipient by entering their intranet ID (e.g. joe@us.ibm.com). </p>
	    		<p><label for="mydeck_batch_copy_cwa">The intranet ID:&nbsp;</label><span><input id="mydeck_batch_copy_cwa" size="30" value="${cwa_id}" type="text" placeholder="jdoe@us.ibm.com" /></span></p>
	    	</div>	
	    	<div name="mydeck_batch_operation" id="mydeck_batch_run_now" >
	    		<p>Please be sure about your changes on your selected Autodeck schedules. </p>
	    	</div>	    	
	    	<div name="mydeck_batch_operation" id="mydeck_batch_activate_or_inactivate" >
	    		<p>Please be sure about your changes on your selected Autodeck schedules. </p>
	    		<p>This will toggle the status of selected Autodeck schedules, make inactive become active, and also change active to inactive. </p>
	    	</div>	
	    	<div name="mydeck_batch_operation" id="mydeck_batch_sch_final_sync" >
	    		<fieldset class="mydeck_fieldset_box">
				<legend>Recommended for weekly decks: </legend>
				<p>All required content to be updated again after the chosen time of day.</p>
				<table><tbody>
					<tr><td><span class="ibm-radio-wrapper">
							<input type="radio" class="ibm-styled-radio" id="mydeck_final_weekly_Sun" value="Sun" name="final_weekly">
							<label class="ibm-column-field-label" for="mydeck_final_weekly_Sun">Sunday</label>
					</span></td></tr>
					<tr><td><span class="ibm-radio-wrapper">
							<input type="radio" class="ibm-styled-radio" id="mydeck_final_weekly_Mon" value="Mon" name="final_weekly">
							<label class="ibm-column-field-label" for="mydeck_final_weekly_Mon">Monday</label>
					</span></td></tr>	
					<tr><td><span class="ibm-radio-wrapper">
							<input type="radio" class="ibm-styled-radio" id="mydeck_final_weekly_Tue" value="Tue" name="final_weekly">
							<label class="ibm-column-field-label" for="mydeck_final_weekly_Tue">Tuesday</label>
					</span></td></tr>	
					<tr>
						<td><span class="ibm-radio-wrapper">
							<input type="radio" class="ibm-styled-radio" id="mydeck_final_weekly_Wed" value="Wed" name="final_weekly" checked>
							<label class="ibm-column-field-label" for="mydeck_final_weekly_Wed">Wednesday</label>
						</span></td>
						<td rowspan="7"> 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select name="mydeck_final_weekly_time" id="mydeck_final_weekly_time_id">
									<option value="0"  >GMT 00:00</option>
									<option value="1"  >GMT 01:00</option>
									<option value="2"  >GMT 02:00</option>
									<option value="3"  >GMT 03:00</option>
									<option value="4"  >GMT 04:00</option>
									<option value="5"  >GMT 05:00</option>
									<option value="6"  >GMT 06:00</option>
									<option value="7"  >GMT 07:00</option>
									<option value="8"  >GMT 08:00</option>
									<option value="9"  >GMT 09:00</option>
									<option value="10"  >GMT 10:00</option>
									<option value="11"  >GMT 11:00</option>
									<option value="12"  selected >GMT 12:00</option>   
									<option value="13"  >GMT 13:00</option>      
									<option value="14"  >GMT 14:00</option>
									<option value="15"  >GMT 15:00</option>
									<option value="16"  >GMT 16:00</option>
									<option value="17"  >GMT 17:00</option>
									<option value="18"  >GMT 18:00</option>
									<option value="19"  >GMT 19:00</option>
									<option value="20"  >GMT 20:00</option>
									<option value="21"  >GMT 21:00</option>
									<option value="22"  >GMT 22:00</option>
									<option value="23"  >GMT 23:00</option>
								</select>
						</td>					
					</tr>	
					<tr><td><span class="ibm-radio-wrapper">
							<input type="radio" class="ibm-styled-radio" id="mydeck_final_weekly_Thu" value="Thu" name="final_weekly">
							<label class="ibm-column-field-label" for="mydeck_final_weekly_Thu">Thursday</label>
					</span></td></tr>	
					<tr><td><span class="ibm-radio-wrapper">
							<input type="radio" class="ibm-styled-radio" id="mydeck_final_weekly_Fri" value="Fri" name="final_weekly">
							<label class="ibm-column-field-label" for="mydeck_final_weekly_Fri">Friday</label>
					</span></td></tr>	
					<tr><td><span class="ibm-radio-wrapper">
							<input type="radio" class="ibm-styled-radio" id="mydeck_final_weekly_Sat" value="Sat" name="final_weekly">
							<label class="ibm-column-field-label" for="mydeck_final_weekly_Sat">Saturday</label>
					</span></td></tr>																														
				</tbody></table>
			</fieldset>
	    		<fieldset class="mydeck_fieldset_box">
				<legend>Recommended for daily decks: </legend>	
				<p>When the output status for all required TBS inputs shows as 'Ready'.</p>	
				<span class="ibm-radio-wrapper">
					<input type="radio" class="ibm-styled-radio" id="mydeck_final_weekly_Ato" value="Ato" name="final_weekly">
					<label class="ibm-column-field-label" for="mydeck_final_weekly_Ato">When Ready</label>
				</span>
			</fieldset>
	    	</div>		    	
	    	<div name="mydeck_batch_operation" id="mydeck_batch_sch_config_msg" >
	    		<p>Do you require a status message or provisional deck to be sent to you in the event that some of the required inputs are unavailable at a specified day and time? </p>
			<form><select id="mydeck_is_provisional" >
				<option  value="N" selected >Not needed</option>
				<option  value="W"          >Status Message only</option>
				<option  value="Y"          >Provisional Deck with Status Message</option>
			</select></form>
			<br>
	    		<fieldset class="mydeck_fieldset_box">
				<legend>Schedule frequency:<span class="ibm-required">*</span></legend>	
				<table>
				<thead><tr><th>Schedule type</th><th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th><th>Schedule day</th><th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th><th>Schedule time</th></tr></thead>
				<tbody>
					<tr>
						<td style="vertical-align:middle !important;">
							<span class="ibm-radio-wrapper">
								<input type="radio" class="ibm-styled-radio" id="mydeck_sched_freq_D" value="D" name="sched_freq" checked>
								<label class="ibm-column-field-label" for="mydeck_sched_freq_D">Daily/weekly</label>
							</span>	
						</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td>				
							<select multiple="multiple" class="ibm-widget-processed" id="mydeck_sched_freq_detail_D" title="Daily or Weekly" size="7" name="sched_freq_detail_D" onclick="jQuery('#mydeck_sched_freq_D').click();">
								<option value="M" selected >Monday</option>
								<option value="Tu">Tuesday</option>
								<option value="W">Wednesday</option>
								<option value="Th">Thursday</option>
								<option value="F">Friday</option>
								<option value="Sa">Saturday</option>
								<option value="Su">Sunday</option>
							</select>							
						</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td rowspan="2"> 
								<select name="mydeck_sched_freq_time" id="mydeck_sched_freq_time_id">
									<option value="0" selected >GMT 00:00</option>
									<option value="1"  >GMT 01:00</option>
									<option value="2"  >GMT 02:00</option>
									<option value="3"  >GMT 03:00</option>
									<option value="4"  >GMT 04:00</option>
									<option value="5"  >GMT 05:00</option>
									<option value="6"  >GMT 06:00</option>
									<option value="7"  >GMT 07:00</option>
									<option value="8"  >GMT 08:00</option>
									<option value="9"  >GMT 09:00</option>
									<option value="10"  >GMT 10:00</option>
									<option value="11"  >GMT 11:00</option>
									<option value="12"  >GMT 12:00</option>   
									<option value="13"  >GMT 13:00</option>      
									<option value="14"  >GMT 14:00</option>
									<option value="15"  >GMT 15:00</option>
									<option value="16"  >GMT 16:00</option>
									<option value="17"  >GMT 17:00</option>
									<option value="18"  >GMT 18:00</option>
									<option value="19"  >GMT 19:00</option>
									<option value="20"  >GMT 20:00</option>
									<option value="21"  >GMT 21:00</option>
									<option value="22"  >GMT 22:00</option>
									<option value="23"  >GMT 23:00</option>
								</select>
						</td>						
					</tr>	
					<tr>
						<td style="vertical-align:middle !important;">
							<span class="ibm-radio-wrapper">
								<input type="radio" class="ibm-styled-radio" id="mydeck_sched_freq_M" value="M" name="sched_freq" >
								<label class="ibm-column-field-label" for="mydeck_sched_freq_M">Monthly</label>
							</span>	
						</td>	
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td>				
							<select multiple="multiple" class="ibm-widget-processed" id="mydeck_sched_freq_detail_M" title="Monthly" size="7" name="mydeck_sched_freq_detail_M" onclick="jQuery('#mydeck_sched_freq_M').click();">
								<option  value="FM" selected>1st Mon</option>
								<option  value="FTu">1st Tue</option>
								<option  value="FW">1st Wed</option>
								<option  value="FTh">1st Thu</option>
								<option  value="FF">1st Fri</option>
								<option  value="FSa">1st Sat</option>
								<option  value="FSu">1st Sun</option>
								<option  value="N1">1st</option>
								<option  value="N2">2nd</option>
								<option  value="N3">3rd</option>
								<option  value="N4">4th</option>
								<option  value="N5">5th</option>
								<option  value="N6">6th</option>
								<option  value="N7">7th</option>
								<option  value="N8">8th</option>
								<option  value="N9">9th</option>
								<option  value="N10">10th</option>
								<option  value="N11">11th</option>
								<option  value="N12">12th</option>
								<option  value="N13">13th</option>
								<option  value="N14">14th</option>
								<option  value="N15">15th</option>
								<option  value="N16">16th</option>
								<option  value="N17">17th</option>
								<option  value="N18">18th</option>
								<option  value="N19">19th</option>
								<option  value="N20">20th</option>
								<option  value="N21">21st</option>
								<option  value="N22">22nd</option>
								<option  value="N23">23rd</option>
								<option  value="N24">24th</option>
								<option  value="N25">25th</option>
								<option  value="N26">26th</option>
								<option  value="N27">27th</option>
								<option  value="N28">28th</option>
								<option  value="N29">29th</option>
								<option  value="N30">30th</option>
								<option  value="N31">31st</option>
								<option  value="LM">Last Mon</option>
								<option  value="LTu">Last Tue</option>
								<option  value="LW">Last Wed</option>
								<option  value="LTh">Last Thu</option>
								<option  value="LF">Last Fri</option>
								<option  value="LSa">Last Sat</option>
								<option  value="LSu">Last Sun</option>
							</select>					
						</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
				</tbody></table>
			</fieldset>			
			
	    	</div>		    	
	    	<div name="mydeck_batch_operation" id="mydeck_batch_sch_extend_date" >
	    		<p>Please be sure about your changes on your selected Autodeck schedules. </p>
	    		<p>This will extend the expiration date. </p>
	    	</div>	
	    	<div name="mydeck_batch_operation" id="mydeck_batch_output_file_name" >
	    		<label for="mydeck_batch_file_name">Specify presentation deck file name:<span class="ibm-required">*</span></label>
	    		<input id="mydeck_batch_file_name" size="20" value="" type="text" placeholder="some text here please">
	    	</div>		
	    	<div name="mydeck_batch_operation" id="mydeck_batch_output_date_or_not" >
			<span>Append date to output:&nbsp;</span>
			<span class="ibm-input-group"> 
				<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mydeck_batch_output_date_no"  value="N" name="mydeck_batch_output_date" checked=""> <label class="ibm-field-label" for="mydeck_batch_output_date_no" >No</label>  </span>
				<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mydeck_batch_output_date_yes" value="Y" name="mydeck_batch_output_date">            <label class="ibm-field-label" for="mydeck_batch_output_date_yes">Yes</label> </span> 
			</span>
			<br>
			<fieldset class="mydeck_fieldset_box"> <legend>Formats:</legend>
				<div id="mydeck_batch_output_date_or_not_options"></div>
			</fieldset>	
	    	</div>		
	    	<div name="mydeck_batch_operation" id="mydeck_batch_output_link_or_not" >
			<span>Send the generated file as:&nbsp;</span>
			<span class="ibm-input-group"> 
				<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mydeck_batch_output_link_yes"  value="LINK"       name="mydeck_batch_output_link" checked=""> <label class="ibm-field-label" for="mydeck_batch_output_link_yes" >link</label>       </span>
				<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mydeck_batch_output_link_no"   value="ATTACHMENT" name="mydeck_batch_output_link">            <label class="ibm-field-label" for="mydeck_batch_output_link_no"  >attachment</label> </span> 
			</span>
			<br>
			<span>Zip output:&nbsp;</span>
			<span class="ibm-input-group"> 
				<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mydeck_batch_output_zip_no"  value="N" name="mydeck_batch_output_zip" checked=""> <label class="ibm-field-label" for="mydeck_batch_output_zip_no" >No</label>  </span>
				<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mydeck_batch_output_zip_yes" value="Y" name="mydeck_batch_output_zip">            <label class="ibm-field-label" for="mydeck_batch_output_zip_yes">Yes</label> </span> 
			</span>			
	    	</div>		
	    	<div name="mydeck_batch_operation" id="mydeck_batch_email_list" >
	    		<p>Please enter your e-Mail address and distribution list, separated by spaces.</p>
	    		<textarea id="mydeck_batch_email_list_input" rows="6" cols="60" placeholder="jdoe@us.ibm.com mydistlist" ></textarea>
	    	</div>     		
	    	<div name="mydeck_batch_operation" id="mydeck_batch_email_comments" >
	    		<p>Please enter your e-Mail comments. </p>
	    		<textarea id="mydeck_batch_email_comments_text" rows="6" cols="60" placeholder="some text here please" ></textarea>
	    	</div>  	   
	    	<div name="mydeck_batch_operation" id="mydeck_batch_email_backup" >
	    		<p>Please specify the desired backup owner for your selected schedules by entering their intranet ID (e.g.jdoe@us.ibm.com) or leave blank to delete the existing backup.</p>
	    		<p><label for="mydeck_batch_email_backup_cwa">The intranet ID:&nbsp;</label><span><input id="mydeck_batch_email_backup_cwa" size="30" value="${cwa_id}" type="text" placeholder="jdoe@us.ibm.com" /></span></p>
	    	</div>	
	    	<div name="mydeck_batch_operation" id="mydeck_batch_take_owner" >
	    		<p>This function will make you become the owner for selected Autodeck schedules. </p>
	    		<p>Please notice you should be the backup of the selected schedule requests to do so. </p> 
	    		<p>Your ID will be removed from the backup field as part of this process. </p>
	    		<p>Please notice this <b>ONLY</b> changes the owner of selected Autodeck schedules, neither Cognos schedules, nor uploaded xls inputs. </p>
	    	</div>   
	     <div name="mydeck_batch_operation" id="mydeck_batch_toggle_backup" >
	    		<p>This function will set the owner as new backup, and set the backup as new owner for selected schedule requests. </p>
	    		<p>Please notice both the owner and the backup can request to do so. </p> 
	    		<p>Please notice this <b>ONLY</b> changes the owner of selected Autodeck schedules, neither Cognos schedules, nor uploaded xls inputs. </p>
	    	</div>	    	    	 	    	    	    		    		    			 
     	<br />
		<p class='ibm-btn-row ibm-center'>
			<button class='ibm-btn-pri ibm-btn-blue-50 ibm-btn-small' onclick='mydeckBatchOk(jQuery("#mydeck_batch_options").val());'	>OK</button> 
			<button class='ibm-btn-sec ibm-btn-blue-50 ibm-btn-small' onclick='mydeckBatchCancel();'									>Cancel</button> 
		</p>
    </div>   
 	<!-- ================================================================= section 5: page footer -->
    <jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
    
    
    <script type="text/javascript">
    //=================================================================   
    function mydeckMessage(message) {
        IBMCore.common.widget.overlay.hideAllOverlays();
        var myOverlay = IBMCore.common.widget.overlay.createOverlay({
            contentHtml: '<p>' + message + '</p>',
            classes: 'ibm-common-overlay ibm-overlay-alt'
        });
        myOverlay.init();
        myOverlay.show();
    }
    
    function mydeckMessageError(message) {
        IBMCore.common.widget.overlay.hideAllOverlays();
        var myOverlay = IBMCore.common.widget.overlay.createOverlay({
            contentHtml: '<p class="ibm-textcolor-red-50 ibm-bold ibm-center">' + message + '</p>',
            classes: 'ibm-common-overlay ibm-overlay-alt-three'
        });
        myOverlay.init();
        myOverlay.show();
    }   
    
    //=================================================================  
    function mydeckMenuFixed(id) {
        var obj = document.getElementById(id);
        var _getHeight = obj.offsetTop;
        window.onscroll = function () { mydeckMenuChangePosition(id, _getHeight) }
    }    

    function mydeckMenuChangePosition(id, height) {
        var obj = document.getElementById(id);
        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        obj.style.backgroundColor = '#fff';
        obj.style.zIndex = '815'; //the same as ibm-sitenav-menu-container 
        if (scrollTop < height) {
            obj.style.position = 'relative';
            obj.style.top = 'auto';
        } else {
            obj.style.position = 'fixed';
            obj.style.top = '50px'; //the fixed px which we see on ibm-sitenav-menu-container, so that we set this menubar to be below that ibm-sitenav-menu-container 
        }
    }
    
    function mydeckMenuButtonBinding() {  
        jQuery("#mydeck_btn_showhideunselected").on('click', function (e) { mydeckPageShowHideUnSelected() });
    		jQuery("#mydeck_btn_showhidecol"	      ).on('click', function (e) { mydeckPageColumnsPopup() });
	    jQuery("#mydeck_btn_showhidenav"	      ).on('click', function (e) { mydeckMenuToggleLeftNav() });
	    jQuery("#mydeck_btn_runnow"		      ).on('click', function (e) { mydeckBatchPopup("run_now") });
	    jQuery("#mydeck_btn_activate"	      ).on('click', function (e) { mydeckBatchPopup("activate_or_inactivate") });
	    jQuery("#mydeck_btn_extend"		      ).on('click', function (e) { mydeckBatchPopup("sch_extend_date") });
	    jQuery("#mydeck_btn_delete"	          ).on('click', function (e) { mydeckBatchPopup("delete") });
	    jQuery("#mydeck_btn_batch"             ).on('click', function (e) { mydeckBatchPopup() });
	}
    
    function mydeckMenuToggleLeftNav() {
        if (jQuery("#ibm-primary-links").css("display") === "none") {
            jQuery("#mydeck_right_col").width(window.innerWidth - 214);
            jQuery("#mydeck_left_col").width(214);
            jQuery("#ibm-primary-links").show(500);
        } else {
            jQuery("#ibm-primary-links").hide(500);
            jQuery("#mydeck_left_col").width(0);
            jQuery("#mydeck_right_col").width(window.innerWidth);
        }
    }    
    
    function mydeckMenuMakesureLeftNav() {
        if (jQuery("#ibm-primary-links").css("display") === "none") {
            jQuery("#mydeck_right_col").width(window.innerWidth);
            jQuery("#mydeck_left_col").width(0);
        } else {
            jQuery("#mydeck_right_col").width(window.innerWidth - 214);
            jQuery("#mydeck_left_col").width(214);
        }	 
    }    
    //================================================================= 
	function mydeckBatchPopup(operation){
            var postData = [];
            var errMsg = ""; 
            if ( operation === undefined || operation === "") { //get last time selection 
	            operation = Cookies.get('eodDeckListBulkUpdateSelect');
            }
          	//------------looping 
            jQuery("tr.ibm-row-selected").each(function (index, item) {
                postData.push(jQuery(item).attr("data-eod-autodeck-convertId"));
            });
            if (postData.length < 1) {
                mydeckMessage("please select at least 1 schedule");
                return false;
            }
            //------------next
	        	if (operation === "delete") { 
	        		//confirmation overlay is unique --- status checking is NOT needed 
	        		IBMCore.common.widget.overlay.show("mydeck_confirmation_delete");
	        		jQuery("#mydeck_confirmation_delete_num_selected").text(	postData.length+" schedule(s) are selected.");
	        	} else {
	        		//confirmation overlay is needed --- status checking is done later
		    		IBMCore.common.widget.overlay.show("mydeck_batch_form");
		    		jQuery("#mydeck_batch_num_selected").text(				postData.length+" schedule(s) are selected."); 
				mydeckBatchSelect(operation); 
	        	}          
	}
    
    function mydeckBatchSelect(operation){ //the on change event, dynamic contents 
	    	//----remember in cookies 
	    	Cookies.set('eodDeckListBulkUpdateSelect', operation, mydeckCookieSettings);
	    	
	    	//----general selection to show fields 
	    	jQuery("div[name='mydeck_batch_operation']").hide();
	    	jQuery("#mydeck_batch_options").val(operation); 
	    	var selected = jQuery("#mydeck_batch_"+operation); 
	    	if (selected.length > 0) selected.show(); 
	    	
	    	//----special for ??
	    	if ( operation === "sch_config_msg" ) {
	    		jQuery("#mydeck_sched_freq_time_id").val(new Date().getUTCHours()).trigger("change");
	    	}

    }     
    
    function mydeckBatchOk(operation){
		if (operation === undefined || operation === "") {
            mydeckMessageError("Please select one operation to proceed."); //normally we shall not reach this 
            return false;
        }
        var postData = [];
        var tmp = null; 
        var errMsg = ""; 
        var newParam = "";    
        
        //------------first 
        var domFirst 			= jQuery(jQuery("tr.ibm-row-selected").get(0)); 
        var domFirstTypeName 	= domFirst.attr("data-eod-typeName"); 

        //------------checking on each operation 
        switch (operation) {          
            case "copy":
	            	tmp = jQuery("#mydeck_batch_copy_cwa").val().trim();
	            	if ( tmp === "" ) {
	            		errMsg = "Please input a valid intranet ID."; 
	            	} else {
	 					if ( mydeckBatchCheckEmail(tmp)  ) {
	 						newParam = "&copyToCwa="+tmp; 
						} else {
							errMsg="Please input a valid intranet ID.";
						}          	
	            	}
                break;        
            case "run_now":
				//none 
            		break;       
            case "activate_or_inactivate":
				//none 
            		break;  
            case "take_owner": 
            		//none 
            		break;  
            case "toggle_backup": 
            		//none 
            		break;  				
            case "sch_extend_date":
				//none 
            		break;  		
            case "sch_config_msg":
        			tmp=jQuery("#mydeck_is_provisional").val();;
        			newParam = "&schProv="+tmp; 
    				tmp=jQuery("#mydeck_sched_freq_time_id").val();
    				newParam = newParam+"&schProvTime="+tmp;         
    				tmp=jQuery("input[name='sched_freq']:checked").val();
    				newParam = newParam+"&schProvFreq="+tmp;  
        			tmp=jQuery('#mydeck_sched_freq_detail_'+tmp).val();
        			if(tmp == null){
        				errMsg='Please select schedule detail for the schedule frequncy.';
        			}else{
        				newParam=newParam+"&schProvFreqDetail="+tmp.toString();
        			}        			
            		break;  	
            case "sch_final_sync":
            		tmp=jQuery("input[name='final_weekly']:checked").val();
            		newParam = "&schFinalDeckWeekNo="+tmp; 
				tmp=jQuery("#mydeck_final_weekly_time_id").val();
				newParam = newParam+"&schFinalDeckTime="+tmp; 
            		break;  					
            case "output_file_name":
				tmp = jQuery("#mydeck_batch_file_name").val().trim();
				var reg1 = /^((\w)+( )*)*$/;
				if(tmp=='') 				errMsg='Please provide the requested file name.';
				if(tmp.length>33) 	    errMsg='Please input file name no more than 33 characters.';
				if(!reg1.test(tmp))		errMsg='Please input the correct format for the file name, like output_1. ';
				else 					newParam = "&file_name="+tmp; 				
            		break; 	
            case "output_date_or_not":
            		tmp = jQuery( jQuery("#mydeck_batch_output_date_or_not").find("input[name=mydeck_batch_output_date]:checked").get(0) ).val();
            		if (tmp === "Y") tmp = jQuery( jQuery("#mydeck_batch_output_date_or_not").find("input[name=mydeck_batch_output_date_or_not_options_list]:checked").get(0) ).val();
            		newParam = "&append_date="+tmp; 
            		break; 
            case "output_link_or_not":
	        		tmp = jQuery( jQuery("#mydeck_batch_output_link_or_not").find("input[name=mydeck_batch_output_link]:checked").get(0) ).val();
	        		newParam = "&link="+tmp; 
	        		tmp = jQuery( jQuery("#mydeck_batch_output_link_or_not").find("input[name=mydeck_batch_output_zip]:checked").get(0)  ).val();
	        		newParam = newParam + "&zip="+tmp; 	        		
	        		break;       
            case "email_backup":
	            	tmp = jQuery("#mydeck_batch_email_backup_cwa").val().trim();
	            	if ( tmp === "" ) {
	            		newParam = "&emailBackup="; 
	            	} else {
	 					if ( mydeckBatchCheckEmail(tmp)  ) {
	 						newParam = "&emailBackup="+tmp; 
						} else {
							errMsg="Please a valid intranet ID.";
						}          	
	            	}
                break;	   
            case "email_list":
	            	tmp = jQuery("#mydeck_batch_email_list_input").val().trim();
	            	if (tmp.length > 250 ) errMsg="The input is too long! Please make it within 250 characters. ";	
				if ( tmp === "" ) {
					errMsg="Please input email addresses.";
				} else {
	                	var myInput = tmp.split(" "); 
	                	for (var i=0; i < myInput.length; i++) {
	                		if ( myInput[i] !== "") newParam += myInput[i]+" "; 
					}		
					newParam = jQuery.trim(newParam); 
	            		jQuery("#mydeck_batch_email_list_input").val(newParam); 
	            		newParam = "&emailList="+newParam; 	                				
				}                  	
	            	break; 
            case "email_comments":
				tmp = encodeURIComponent( jQuery("#mydeck_batch_email_comments_text").val().trim() );
				if (tmp.length > 300 ) errMsg="The input email comments are too long! Please make it within 300 characters. ";			
				if (tmp === "")        errMsg="Please input some text.";
				else                   newParam = "&emailComments="+tmp; 
                break;                 
            default:
                errMsg="We cannot proceed with this operation="+operation;
                break;
        }
        if (errMsg !== "") {
            mydeckMessageError(errMsg);
            return false;
        }            
                         
        //------------checking in the looping 
        jQuery("tr.ibm-row-selected").each(function (index, item) {
        		//----data
            postData.push( jQuery(item).attr("data-eod-autodeck-convertId"));
            
            //----domFirst?
						
            //----status validation
            errMsg = mydeckBatchCheckInLoop(operation, item); 
            if (errMsg !== "")  return false;    
                        
            //----owner cannot be backup
            if ( operation === "email_backup" ) {
				if (jQuery("#mydeck_batch_email_backup_cwa").val().trim() === jQuery(item).attr("data-eod-autodeck-convertowner").trim()) {
                    errMsg = "We cannot set owner as backup owner on email subject (" + decodeURIComponent(jQuery(item).attr("data-eod-autodeck-emailSubject"))+").";
                    return false;
                }   
            }
            
            //----check if you are the backup
			if ( operation === "take_owner" ) {
                if (mydeckCwa !== jQuery(item).attr("data-eod-autodeck-backupowner").trim()) {
                	errMsg="You need to be the schedule backup owner to do so.";
            		return false; 
                }                  
            }
            
            //----check we must have a backup so that we can toggle backup and owner 
			if ( operation === "toggle_backup" ) {
				tmp = jQuery(item).attr("data-eod-autodeck-backupowner").trim(); 
                if ( tmp == undefined || tmp == null || tmp === "" || tmp === "null" ) {
                	errMsg="this schedule doesn't have a backup owner to toggle with...email subject="+decodeURIComponent(jQuery(item).attr("data-eod-autodeck-emailSubject"))+"...comments="+decodeURIComponent(jQuery(item).attr("data-eod-autodeck-emailComments"));
            		return false; 
                }                  
            }              

        });
        
        if (postData.length < 1) { // normally we shall not reach this, this is a defensive checking 
            errMsg="no valid schedules to be sent for processing. we shall not reach here! ";
        }        
        if (errMsg !== "") {
            mydeckMessageError(errMsg);
            return false;
        }
        //------------send the request 
        mydeckBatchCancel(); 
        mydeckBatchAjax(postData, operation, newParam); 
    }
    
    function mydeckBatchCancel(){
		var theOverlayId = IBMCore.common.widget.overlay.getWidget("mydeck_batch_form").getId();
		IBMCore.common.widget.overlay.hide(theOverlayId, true);      
    }       
    
    function mydeckBatchAjax(postData, operation, newParam){
			var searchText = jQuery("#mydeck_sch_table_filter").find("input[type='search']").val();   
	    	
	        jQuery("#mydeck_list2show").empty();
	        jQuery("#mydeck_list2show").append("<img src='" + mydeckContext + "/images/ajax-loader.gif' />");       	
    
			mydeckMessage(postData.length + " selected autodecks, submitted for processing ... <img src='" + mydeckContext + "/images/ajax-loader.gif' />");

			jQuery.ajax({
				headers: { Accept: "application/json; charset=utf-8" },
                url: mydeckContext + "/action/portal/autodecklist/batch/"+mydeckCwa+"/"+mydeckUid+"?operation="+operation+newParam+"&timeid="+(new Date()).valueOf(),
                type: 'POST',
                data: JSON.stringify(postData),
                dataType: "json",
                contentType: "application/json; charset=utf-8"
            })
            .done(function (data) {
				if (data[0].errorMessage === "success") {
					mydeckMessage("processing is done on the selected schedules. ");					
					mydeckPageDraw(postData, data, searchText);
					return true; 
				} else { 
					mydeckMessageError(data[0].errorMessage);  
					if (data[0].autodeck !== null ) {//---client side issue 
						mydeckPageDraw(postData, data, searchText);
					} else { //---------------------------server side issue 
						jQuery("#mydeck_list2show").empty();
						jQuery("#mydeck_list2show").append(data[0].errorMessage);    
					}
					return false; 
				}
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
                console.log("ajax error in loading...textStatus..." + textStatus);
                console.log("ajax error in loading...errorThrown..." + errorThrown);  
                mydeckMessageError("ajax error in loading..." + errorThrown);  
          		return false;       
            });
    }      
    function mydeckBatchDeleteCancel(){
		var theOverlayId = IBMCore.common.widget.overlay.getWidget("mydeck_confirmation_delete").getId();
		IBMCore.common.widget.overlay.hide(theOverlayId, true);      
    } 
    
    function mydeckBatchDeleteOk(){
    		var postData = [];
        jQuery("tr.ibm-row-selected").each(function (index, item) {
            postData.push(jQuery(item).attr("data-eod-autodeck-convertId"));
        });     	
    		//----done
		mydeckBatchDeleteCancel();  
        mydeckBatchAjax(postData, "delete", "");      
    }   
    
    function mydeckBatchCheckInLoop(operation, item){        	
        if (operation == "delete" || operation == "backup" ) {
        		return "";//we are good here, delete and backup are NOT real updates to any schedule.
        } else {
            var tmp = jQuery(item).attr("data-eod-autodeck-convertStatus");
            if (tmp === "A" || tmp === "I" || tmp === "E") {
                return "";//we are good here, types of normal status 
            } else {
                return "Failed to perform this operation as status of some selected schedules is not valid. ("+tmp+") ";
            }
        }  
		return "";   //default, this item pass the validations
	}

	function mydeckBatchCheckEmail(email){ //allow dot, underscore, characters, numbers, then after that it is @ibm.com or @**.ibm.com
		//allow "-" by leo
		if (email.match(/^([_,\-,\.,\w])+@([\.,\w])*ibm.com$/) === null)  {
			return false; 
		} else {
			return true;
		}     
    }   
	
	//=================================================================
    function mydeckFormatStatus(sch) {
    		var tmp = sch.executionStatus; 
    		if (tmp === undefined || tmp === null) {
    			tmp = ""; 
    		} else {
        		if (tmp.indexOf("Success") === 0) {
        			tmp = "<div title='" + sch.messages + "'><strong style='color:green;'>" + sch.executionStatus + "</strong></div>"; 
        		} else if (tmp.indexOf("Failed") === 0) {
        			tmp = "<div title='" + sch.messages + "'><strong style='color:red;'  >" + sch.executionStatus + "</strong></div>"; 
        		} else {
        			tmp = "<div title='" + sch.messages + "'>" + sch.executionStatus + "</div>"; 
        		}    			
    		}
        return tmp;
    }	
	
    function mydeckFormatLastRunDate(sch) {
    		var tmp_status = sch.executionStatus; 
    		if (tmp_status === undefined || tmp_status === null) {
    			tmp_status = ""; 
    		}    		
    		
    		var tmp = sch.lastRunTime;
    		if (tmp === undefined || tmp === null) {
    			tmp = ""; 
    		} else {	
        		if (tmp_status.indexOf("Success") === 0) {
        			tmp = "<a href='" + mydeckContext + "/action/portal/autodeck/downloadDeckByLink/" 
        			+ sch.autodeck["convertId"]
        			+ "/" 
        			+ sch.autodeck["lastRunningID"] 
        			+ "/"
        			+ sch.typeName    
        			+ "' target='_blank'>" + sch.lastRunTime 
        			+ "</a>"
        		} 		
    		}
    		
        return tmp;   		
    }
	
	//================================================================= 
   	function mydeckPageAjax() {
        jQuery("#mydeck_list2show").empty();
        jQuery("#mydeck_list2show").append("<img src='" + mydeckContext + "/images/ajax-loader.gif' />");
        
        jQuery.get(mydeckContext + "/" +
                "action/portal/autodecklist/getAutodeckList/" +
                mydeckCwa + "/" +
                mydeckUid + "?" +
                "timeid=" + (new Date()).valueOf() 
		).done(function (data) {
                mydeckPageDraw(false, data, "");
		}).fail(function (jqXHR, textStatus, errorThrown) {
                console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
                console.log("ajax error in loading...textStatus..." + textStatus);
                console.log("ajax error in loading...errorThrown..." + errorThrown);
                mydeckMessage("ajax error in loading..." + errorThrown);
                jQuery("#mydeck_list2show").empty();
                jQuery("#mydeck_list2show").append("ajax error in loading..." + errorThrown);
		})
	}	   
  
    function mydeckPageDraw(postData, nodeData, searchText) {
        var nodes = eval(nodeData);
		var length = nodes.length;
        //--------create the page
        if (length > 0) {
            mydeckPageDrawTableContainer();
            for (var i = 0; i < nodes.length; i++) mydeckPageDrawTableRow(nodes[i]);
            mydeckPageDrawTableInit();         
            mydeckPageDrawTableHideHiddenRows(); 
            mydeckPageDrawAppendDateFormatOptions(nodes[0].appendfiles); //this is set up specially for the 1st returned deck.  
        } else {
            jQuery("#mydeck_list2show").empty();
            jQuery("#mydeck_list2show").append("<p>You do not have any Cognos report schedules in this folder. </p>");
        }
        //--------show the remembered 
        if ( Object.prototype.toString.call(postData) === '[object Array]' ) {
			if (searchText !== "")  			jQuery("#mydeck_sch_table_filter").find("input[type='search']").val(searchText).keyup();            
        		for (var selected in postData) 	jQuery("#mydeck_"+postData[selected]+"_checkbox").click(); 
        }
    }  

    function mydeckPageDrawTableRow(sch) {
        var tmp = "";
        for (var item in sch) {
            tmp = tmp + " data-eod-" + item + "='" + escape(sch[item]) + "' ";
        }
        for (var item in sch.autodeck) {
            tmp = tmp + " data-eod-autodeck-" + item + "='" + escape(sch.autodeck[item]) + "' ";
        }
        jQuery("#mydeck_sch_tbody").append(
            "<tr id='mydeck_" + sch.autodeck["convertId"] + "' " + tmp + " >" +
            "<td scope='row'> <span class='ibm-checkbox-wrapper'>  <input id='mydeck_" + sch.autodeck["convertId"] +
            "_checkbox' type='checkbox' class='ibm-styled-checkbox'/> <label for='mydeck_" + sch.autodeck["convertId"] +
            "_checkbox' ><span class='ibm-access'>Select One</span></label> </span> </td>" +
            "<td><a href=" + mydeckContext + "/action/portal/autodeck/edit/getAutodeck/" + sch.autodeck["convertId"]  
            	+ " target='_blank' "
            	+ " >" 
            	+ sch.autodeck["convertId"]
            	+ "</a></td>" +
            "<td>" + sch.autodeck["emailSubject"] + "</td>" +
            "<td>" + sch.autodeck["emailAddress"] + "</td>" +                
            "<td>" + sch.autodeck["emailComments"] + "</td>" +
            "<td>" + sch.schedFreqAndDetail + "</td>" +
            "<td>" + sch.expirationDate_Str + "</td>" +
            "<td>" + mydeckWordExpansionStatus[sch.autodeck.convertStatus] + "</td>" +
            "<td>" + sch.typeName + "</td>" +
            "<td>" + sch.ownerOrBackup + "</td>" +
            "<td>" + mydeckFormatStatus(sch) + "</td>" +
            "<td>" + mydeckFormatLastRunDate(sch) + "</td>" +
            "</tr>"
        );
    }

    function mydeckPageDrawTableContainer() {
		//---table
		jQuery("#mydeck_list2show").empty();
        jQuery("#mydeck_list2show").append("<table class='ibm-data-table ibm-altrows ibm-small' id='mydeck_sch_table'></table>");
        //---thead
        var tmp ="<thead><tr>";
        var tmp = tmp + "<th scope='col' ><span class='ibm-checkbox-wrapper'><input id='mydeck_sch_checkbox' type='checkbox' class='ibm-styled-checkbox'/><label for='mydeck_sch_checkbox' ><span class='ibm-access'>Select all</span></label></span> </th>";
        for (var i=1; i<mydeckTableHeaders.length; i++)  tmp = tmp + "<th scope='col'>"+mydeckTableHeaders[i]+"</th>";
        tmp = tmp + "</tr></thead>";
        jQuery("#mydeck_sch_table").append(tmp); 
		//---tbody 
        jQuery("#mydeck_sch_table").append("<tbody id='mydeck_sch_tbody'></tbody>");
    }

    function mydeckPageDrawTableInit() {
		//------------set defaults 
        var mydeckDtSettings = {
        		destroy: true, 		// allow re-initiate the table
            colReorder: false, 	// Let the user reorder columns (not persistent) 
            info: false,			// Shows "Showing 1-10" texts 
            ordering: true, 		// Enables sorting 
            paging: false, 		// Enables pagination 
            scrollaxis: true, 	// Allows horizontal scroll 
            searching: true 		// Enables text filtering	
        };        	
	    	mydeckDtSettings.order		= eval(Cookies.get('eodDeckListColSort'));        
	    	var myOrderableFalse  		= '{"targets": [0], "orderable": false}';  
	    	var myVisibleFalse   		= '{"targets": '+Cookies.get('eodDeckListColHidden')+', 	"visible": 		false}';
	    	var mySearchableFalse  		= '{"targets": '+Cookies.get('eodDeckListColHidden')+', 	"searchable": 	false}';
	    	var myVisibleTrue   			= '{"targets": "_all", 	"visible": 		true}'; //make sure the rest shows up
	    	var mySearchableTrue  		= '{"targets": "_all", 	"searchable": 	true}';        	
	    	mydeckDtSettings.columnDefs 	= [JSON.parse(myOrderableFalse), JSON.parse(myVisibleFalse), JSON.parse(mySearchableFalse), JSON.parse(myVisibleTrue), JSON.parse(mySearchableTrue)];      	
	    	//------------init table          
	    	mydeckMenuMakesureLeftNav(); //TODO right now this is what we have to do too. 
		var table = jQuery("#mydeck_sch_table").DataTable(mydeckDtSettings);
		jQuery("#mydeck_sch_table").tablesrowselector();
		jQuery('#mydeck_sch_table').on('order.dt', function () {
	            var order = JSON.stringify(table.order());
	            Cookies.set('eodDeckListColSort', order, mydeckCookieSettings);
		});
    }
    
    function mydeckPageDrawTableHideHiddenRows() {
        if ( Object.prototype.toString.call(mydeckHiddenRows) === '[object Array]' ) {
    			jQuery.each(mydeckHiddenRows, function(index,element) {
    				jQuery("#mydeck_"+element).hide(); 
    			});  
        }
    }   
    
    function mydeckPageDrawAppendDateFormatOptions(formats) {
        if ( Object.prototype.toString.call(formats) === '[object Array]' ) {
			if (formats.length > 0) {
				var newHtml = "<span class='ibm-input-group'>";  
				jQuery.each(formats, function(index,element) {
					newHtml += '<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mydeck_batch_output_date_or_not_options_'+element.appendfileCd+'"  value="'+element.appendfileCd+'" name="mydeck_batch_output_date_or_not_options_list" > <label class="ibm-field-label" for="mydeck_batch_output_date_or_not_options_'+element.appendfileCd+'" >'+element.appendfileDesc+'</label>  </span><br>'; 
				});  	
				newHtml += "</span>";  
				jQuery("#mydeck_batch_output_date_or_not_options").replaceWith(newHtml); 
				jQuery("#mydeck_batch_output_date_or_not_options_1").click(); 
			} else {
				jQuery("#mydeck_batch_output_date_or_not_options").replaceWith("error with no rows."); 
			}
        } else {
        		jQuery("#mydeck_batch_output_date_or_not_options").replaceWith("error in loading."); 
        }

    }       

    function mydeckPageShowHideUnSelected(){
		if (jQuery("#mydeck_sch_table").length === 1 && jQuery("#mydeck_sch_tbody").length === 1 ) {	
			var domRows  = jQuery("#mydeck_sch_table").DataTable().rows().nodes().to$();   
			//=====================================================toggle 
			var rowSelected  = jQuery("#mydeck_sch_tbody > tr.ibm-row-selected:visible");	
			var rowShowed    = jQuery("#mydeck_sch_tbody > tr:visible");
			if (rowSelected.length < 1 || rowSelected.length === rowShowed.length) {
				//-----------If ammong showed ZERO selected,  then show every single row
				//-----------If all showed are selected,      then show every single row					
				jQuery.each(domRows, function(index,element) {   jQuery(element).show();   }); 	
				mydeckHiddenRows = []; //clear the count of hidden rows  
			} else {
				//----------If there are un-selected, hide the un-selected
				rowShowed.each(function(){    
					if (!jQuery(this).hasClass("ibm-row-selected")) {  
						jQuery(this).hide();  
						mydeckHiddenRows.push(jQuery(this).attr("data-eod-autodeck-convertId")); //save the hidden rows
					}    
				}) 
			}
			
			jQuery("#mydeck_sch_table_filter").find("input[type='search']").click(); 
			
			//mydeckMenuMakesureLeftNav(); why it is moving, 3 or 5 pixels? TODO
			
			//=====================================================popup info 
			var domTrHiddenNum  = 0;  
			var domTrVisibleNum = 0;  	
			jQuery.each(domRows, function(index,element) {
				if (jQuery(element).css('display')==='none') domTrHiddenNum  += 1; 
				else                                         domTrVisibleNum += 1; 
			}); 
			var domTrShowedNum   = jQuery("#mydeck_sch_tbody > tr:visible").length;
			var domTrSelectedNum = jQuery("#mydeck_sch_tbody > tr.ibm-row-selected:visible").length;		
			var domSearchText = jQuery("#mydeck_sch_table_filter").find("input[type='search']").val(); 
			//-----------popup message 
			var message = "There are " + (domTrHiddenNum+domTrVisibleNum) + " schedules. "; 
			message += domTrHiddenNum   +" hidden. "; 
			message += domTrVisibleNum  +" visible. <br>"; 
			message += "Among visible ones, "; 
			if (domSearchText === "") message += "no search keywords, "; 
			else                      message += "search words are <span style='text-decoration:underline;'>"+domSearchText+"</span>, "; 
			message += domTrShowedNum   +" showed, "; 
			message += domTrSelectedNum +" selected. <br>"; 				
			//-----------popup action 
			console.log(message);  
		} else {
			console.log("no rows to work on");
		}    	
    }
    
    function mydeckPageColumnsCancel(){
		var theOverlayId = IBMCore.common.widget.overlay.getWidget("mydeck_showhide_columns").getId();
		IBMCore.common.widget.overlay.hide(theOverlayId, true);      
    } 
    
    function mydeckPageColumnsOk(){      
		//---save into cookies
		var toBeSaved = jQuery("#mydeck_showhide_columns_table").find("input[data-eod-colsetup='hide']:checked"); 
		var tmp = "[";
		for (var i=0; i<toBeSaved.length; i++) {
			tmp += jQuery(toBeSaved[i]).attr("data-eod-colnum")+","; 
		}
		if (toBeSaved.length >0)           tmp = tmp.substring(0,tmp.length-1) + "]"; 
		else                               tmp = "[]";
		Cookies.set('eodDeckListColHidden', tmp, mydeckCookieSettings);		
		//---redo current page & close the popup
		var searchText = jQuery("#mydeck_sch_table_filter").find("input[type='search']").val();  
		jQuery('#mydeck_sch_table').DataTable().destroy(); 
		mydeckPageDrawTableInit(); 
		mydeckPageColumnsCancel();  
		if (searchText !== "")  jQuery("#mydeck_sch_table_filter").find("input[type='search']").val(searchText).keyup();     
    }  
    
    function mydeckPageColumnsPopup(){
   		//-------draw table
   		jQuery("#mydeck_showhide_columns_table").empty(); 
    		jQuery("#mydeck_showhide_columns_table").append("<thead><tr><th>#</th><th>name</th><th>visible</th></tr></thead>"); 
    		jQuery("#mydeck_showhide_columns_table").append("<tbody id='mydeck_showhide_columns_tbody'></tbody>"); 
    		var temp=""; 
    		for (var i=0; i<mydeckTableHeaders.length; i++) {
        		//---reset  
        		temp ="<tr>"; 
        		//---1st td
        		temp+="<td>"+i+"&nbsp;&nbsp;&nbsp;&nbsp;</td>";
        		//---2nd td
        		temp+="<td>"+mydeckTableHeaders[i]+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>"; 
        		//---3rd td
        		temp+='<td><span class="ibm-input-group">';
				temp+='<span class="ibm-radio-wrapper">';
				temp+='<input class="ibm-styled-radio" type="radio" value="Y" id="mydeck_view_columns_'+i+'_Y" name="mydeck_view_columns_'+i+'" data-eod-colsetup="show" checked> ';
				temp+='<label class="ibm-field-label" for="mydeck_view_columns_'+i+'_Y">Yes</label>';
				temp+='</span>&nbsp;&nbsp;&nbsp;&nbsp;';
				temp+='<span class="ibm-radio-wrapper">';
				temp+='<input class="ibm-styled-radio" type="radio" value="N" id="mydeck_view_columns_'+i+'_N" name="mydeck_view_columns_'+i+'" data-eod-colsetup="hide" data-eod-colnum='+i+' >'; 
				temp+='<label class="ibm-field-label" for="mydeck_view_columns_'+i+'_N">No</label>';
				temp+='</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
				temp+='</span></td>';
        		//---end
        		temp+="</tr>";
        		//---add into table 
        		jQuery("#mydeck_showhide_columns_tbody").append(temp); 
        	}
        	//-------special format
        	jQuery("#mydeck_showhide_columns_table").find("th").css({"padding":"0px"});
        	jQuery("#mydeck_showhide_columns_table").find("td").css({"padding":"0px"});
        	//-------disable checkbox and deckid 
        	jQuery("#mydeck_view_columns_0_Y").click();
        	jQuery("#mydeck_view_columns_0_Y").prop("disabled",true);
        	jQuery("#mydeck_view_columns_0_N").prop("disabled",true);
        	jQuery("#mydeck_view_columns_1_Y").click();
        	jQuery("#mydeck_view_columns_1_Y").prop("disabled",true);
        	jQuery("#mydeck_view_columns_1_N").prop("disabled",true);   
        	//-------disable last status and last rundate 
        	jQuery("#mydeck_view_columns_10_Y").click();
        	jQuery("#mydeck_view_columns_10_Y").prop("disabled",true);
        	jQuery("#mydeck_view_columns_10_N").prop("disabled",true);
        	jQuery("#mydeck_view_columns_11_Y").click();
        	jQuery("#mydeck_view_columns_11_Y").prop("disabled",true);
        	jQuery("#mydeck_view_columns_11_N").prop("disabled",true);           	
        	//-------read from cookie 
        	var hiddenColumns = eval( Cookies.get('eodDeckListColHidden') ); 
        	for (var i=0; i<hiddenColumns.length; i++) {
        		jQuery("#mydeck_view_columns_"+hiddenColumns[i]+"_N").click(); 
        	}
        	//-------finally show it 
        	IBMCore.common.widget.overlay.show("mydeck_showhide_columns");       	    	
    }   
    
    //=================================================================
    jQuery(document).ready(function() {
    		//------set defaults 
        var mydeck_table_sorting = Cookies.get('eodDeckListColSort');
        if (mydeck_table_sorting === undefined) { 
            mydeck_table_sorting = '[[1,"asc"]]';
            Cookies.set('eodDeckListColSort', mydeck_table_sorting, mydeckCookieSettings);
            console.log("initializing column sorting in cookie " + mydeck_table_sorting);
        } 
		var operation = Cookies.get('eodDeckListBulkUpdateSelect');
		if (operation === undefined) {  
			operation = "email_backup";
			Cookies.set('eodDeckListBulkUpdateSelect', operation, mydeckCookieSettings);
			console.log("initializing bulk update selection in cookie " + operation);
		} 
		var myColVisible = Cookies.get('eodDeckListColHidden');
		if (myColVisible === undefined) {  
			myColVisible = "[]";  
			Cookies.set('eodDeckListColHidden', myColVisible, mydeckCookieSettings);
			console.log("initializing column hidden in cookie " + myColVisible);
		} 	
		
		//------normal work to do
		jQuery("#existingAutodecks").attr("aria-selected", "true"); 
		mydeckMenuFixed("eod-menubar-after-ibm-sitenav");
		mydeckMenuButtonBinding();
		mydeckPageAjax(); 

    });
    </script>
</body>

</html>
