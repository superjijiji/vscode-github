<!-- 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<% String path = request.getContextPath(); %> 
-->
<!DOCTYPE html>
<html lang="en-US">

<head>
    <jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
    <!-- ================================================================= custom page JS and CSS start -->
    <title>BI@IBM | My Cognos schedules</title>
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
            /* change sort icon position */
            background-repeat: no-repeat;
            background-position: center right
        }

        table.dataTable thead .sorting {
            /* change sort icon */
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
        a.mytbs_disabled {
            pointer-events: none;
            color: #e0e0e0;
            opacity: 0.5;
        }

        .mytbs_green {
            color: #008000;
            font-weight:bold;
        }

        .mytbs_red {
            color: #FF0000;
            font-weight:bold;
        }

        div.mytbs_fullwidth {
            width: 100%;
        }

        div.mytbs_table {
            margin: 5px;
            display: table;
        }

        div.mytbs_tablerow {
            margin: 5px;
            display: table-row;
        }

        div.mytbs_tablecell {
            margin: 5px;
            display: table-cell;
        }

        div.mytbs_tablecell4leftnav {
            margin: 5px;
            display: table-cell;
            width: 200px;
            vertical-align: top;
        }

        div.mytbs_page_title {
            padding-left: 10px;
            float: left;
        }

        td.mytbs_freq_1st_col {
            width: 350px;
            vertical-align: top;
            padding: 7px;
        }

        td.mytbs_freq_2nd_col {
            width: 120px;
            padding: 10px;
        }

        fieldset.mytbs_fieldset_box {
            border: 1px solid #DDD;
        }

        div.mytbs_freq_notes {
            margin-left: 33px;
        }

        select.mytbs_freq_options {
            width: 100px;
        }
    </style>
    <script type="text/javascript">
        //=============================================alias
        window.$ = window.jQuery;
        
        //=============================================page stored variable 
        var myTbsHiddenRows = []; 

        //=============================================global variables, please do NOT change after init this page
        var myTbsContext = "<%=request.getContextPath()%>";
        var myTbsCwa = "${cwa_id}";
        var myTbsUid = "${uid}";
        var myTbsCookieSettings = {
            expires: 999
        };
        var myTbsFolderItsCsr = null;    //to be loaded once ONLY when the page is created, folder and its schedules
        var myTbsByDeckDeckId = ""; 
        var myTbsByDeckCsrIds = ""; 
        var myTbsByDeckFirstTimeLoadedFromUrl = false; 
		var myTbsWordExpansionStatus = {
			"A":"Active", 
			"I":"Inactive", 
			"E":"Expired", 
			"S":"Suspended", 
			"D":"Disabled"
		}
		var myTbsWordExpansionPriority = {
			"H":"High", 
			"M":"Medium", 
			"L":"Low", 
			"Y":"Off-peak", 
			"A":"Off-peak by admin"
		}	
		var myTbsWordExpansionRunStatus = {
				"100":"Report ran successfully.", 
				"101":"Report ran and sent out mail successfully.", 
				"111":"Report ran successfully but the report output is no longer available for download.", 
				"200":"Report failed to run successfully.", 
				"300":"Report is running.", 
				"400":"Timeout"
		}		
		var myTbsTableHeaders=new Array("Checkbox","Report Name","e-Mail Subject","e-Mail Address", "Comments", "Frequency", "Data Load", "Expiration Date", "Status", "Send Mail", "Priority", "Owner", "Run Status", "Run Date"); 		
    </script>
    <script type="text/javascript" src="<%=path%>/javascript/js.cookie-2.1.4.js"></script>
    <!-- ================================================================= custom page JS and CSS end -->
</head>

<body id="ibm-com" class="ibm-type">
    <jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>

    <!-- ================================================================= eod nav starts -->
    <div id="eod-menubar-after-ibm-sitenav" class="mytbs_fullwidth">
        <div class="mytbs_table">
            <div class="mytbs_page_title">
                <h1 id="ibm-pagetitle-h1" class="ibm-h1 ibm-light">My Cognos schedules</h1>
            </div>
            <div class="mytbs_page_title">
                <p class="ibm-ind-link ibm-icononly ibm-inlinelink">
                    <a class="ibm-information-link" target="_blank" href="<%=path%>/action/portal/pagehelp?pageKey=MyCognosSchedules&pageName=My+Cognos+schedules"
                        title="Help for My Cognos schedules"> Help for My Cognos schedules </a>
                </p>
            </div>
        </div>

        <div class="mytbs_table mytbs_fullwidth">
            <div id="mytbs_root_buttondiv" class="ibm-btn-row ibm-right">
            		<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mytbs_button_showhidecol"> Show/Hide columns </a>  
				<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mytbs_button_showhidenav"> Show/Hide links </a>    
				<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="mytbs_button_showhideunselected"> Show selected/all </a> 				            
				<a class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' id='mytbs_button_runnow'> Run now </a>                
<!-- 				<a class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' id='mytbs_button_activate'> Activate/inactivate </a>   -->
<!-- 				<a class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' id='mytbs_button_extend'> Extend date </a>                -->       
				<a class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' id='mytbs_button_batch' > Bulk update </a>      
				<a class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' id='mytbs_button_download'> Download outputs </a> 
				<a class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' href='<%=path%>/action/portal/tree/editFolders/mytbs?backUrl=<%=path%>/action/portal/mycognosschedulelist' id='mytbs_manage_folder'> Manage folders </a> 
				<a class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' id='mytbs_button_delete'> Delete </a>    
            </div>         
        </div>
    </div>
    <!-- ================================================================= oed nav ends -->

    <!-- ================================================================= custom page contents start -->
    <div class="mytbs_fullwidth">
        <div class="mytbs_table">
            <div class="mytbs_tablerow">
                &nbsp;
                <div id="mytbs_left_col" class="mytbs_tablecell4leftnav">
                    <nav role="navigation" aria-label="Navigation for my cognos schedules">
                        <div class="ibm-parent" id="ibm-navigation">
                            <ul id="ibm-primary-links" role="tree" aria-labelledby="ibm-pagetitle-h1">
                                <li role="presentation"><a role="treeitem" href="<%=path%>/action/portal/autodeck" target="_blank" tabindex="1">My Autodeck schedules</a></li>
                                <li role="presentation"><a role="treeitem" href="<%=path%>/action/portal/mydistlist/distmanage/getMyDistListPage" target="_blank" tabindex="2">My distribution lists</a></li>
                                <li role="presentation"><a role="treeitem" href="<%=path%>/action/portal/TBSJobStatus/openTBSJobStatusPage" target="_blank" tabindex="4">TBS execution status</a></li>
                                <c:if test="${isUserInPublishGroups}">
                                    <li role="presentation"><a role="treeitem" href="https://b01pasp088.pok.ibm.com/transform/edge/admin/EODAdminMain.wss?component=SetupCognosScheduledRequest&type=fromTbs" target="_blank" tabindex="5">TBS publication</a></li>
                                </c:if>
                                <li role="presentation"><a role="treeitem" tabindex="6" href="#" id="mytbs_folder_bydeck" data-eod-nodeid="bydeck" >By Autodeck</a></li>
                                <li role="presentation"><a role="treeitem" tabindex="-1" href="#" name="eod-folder" data-eod-nodeid="root" id="mytbs_root_folder" onclick="mytbsNavSelectFolder(this);">All my schedules</a>
                                    <ul id="mytbs_userFolders">
                                        <li role="presentation"><a role="treeitem" href="#" tabindex="1">folder dummy</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
                &nbsp;
                <div id="mytbs_right_col" class="mytbs_tablecell">
                    <div id="mytbs_list2show"></div>
                    <br>
                    <div id="mytbs_error2show"></div>
                    <br>
                </div>
                &nbsp;
            </div>
        </div>
    </div>
    <!-- ================================================================= custom page contents end -->
    <!-- ================================================================= batch form start -->
    
    <div id="mytbs_batch_form" class="ibm-common-overlay ibm-overlay-alt" data-widget="overlay" data-type="alert">
    		<h3 id="mytbs_batch_num_selected" class="ibm-h3">0 schedules are selected.</h3>
	    <p class="ibm-form-elem-grp">
	        <label>Available options:&nbsp;</label>
	        <span>
				<select id="mytbs_batch_options" onchange="mytbsBatchSelect(this.value);">
					<!-- sort manually here in alphabetic order --> 
		            <option value="activate_or_inactivate" 	>Activate/inactivate</option>
					<option value="prompts_comments" 		>Change comments</option>
					<option value="email_list"  				>Change e-Mail addresses</option>
	                <option value="email_comments" 			>Change e-Mail comments</option>
	                <option value="error_notification" 		>Change error notifications</option>
	                <option value="dataload"		 			>Change data load timing</option>
	                <option value="frequency"  				>Change frequencies</option>	    
	            		<option value="mail_options" 			>Change mail options</option>	   
					<option value="format"  					>Change output formats</option>	            	                         
	            		<option value="copy"  					>Copy selected schedules</option>	
	            		<option value="extend_date" 				>Extend dates</option>                
					<option value="backup"  					>Manage back-ups</option>
	                <option value="priority"  				>Manage priorities</option>	
		            	<option value="run_now" 					>Run now</option>	                   
	                <option value="take_owner"  				>Take ownership</option>	
	                <option value="toggle_backup"  			>Toggle back-up</option>	           
				</select>
	        </span>
	    </p>  
		<br />
		
	    	<div name="mytbs_batch_operation" id="mytbs_batch_run_now" >
	    		<p>Please be sure about your changes on your selected Cognos schedules. </p>
	    		<p>This will mark the selected Cognos schedules for backend job in the nearest run. </p>
	    	</div>	    	
	    	<div name="mytbs_batch_operation" id="mytbs_batch_activate_or_inactivate" >
	    		<p>Please be sure about your changes on your selected Cognos schedules. </p>
	    		<p>This will toggle the status of selected Cognos schedules, make inactive become active, and also change active to inactive. </p>
	    	</div>	
	    	<div name="mytbs_batch_operation" id="mytbs_batch_extend_date" >
	    		<p>Please be sure about your changes on your selected Cognos schedules. </p>
	    		<p>This will extend the expiration date. </p>
	    	</div>		
		
    	<div name="mytbs_batch_operation" id="mytbs_batch_same_report_warning" >
    		<p>For this operation, we need to apply the change to schedules which are based on <strong>the same report</strong>. </p>
    	</div>				  
    	<div name="mytbs_batch_operation" id="mytbs_batch_mail_options" >
    		<fieldset class="mytbs_fieldset_box"> <legend>Mail options:</legend>
    			&nbsp;&nbsp;
    			<span>Send mail?</span> 
    			<span class="ibm-input-group">
					<span class="ibm-radio-wrapper"> 
						<input class="ibm-styled-radio" type="radio" id="mytbs_batch_mail_options_send_yes" onclick="jQuery('#mytbs_batch_mail_options_block').show(100);" value="Y" name="mytbs_batch_mail_options_send" checked> 
						<label class="ibm-field-label" for="mytbs_batch_mail_options_send_yes">Yes</label>
					</span> 
					<span class="ibm-radio-wrapper"> 
						<input class="ibm-styled-radio" type="radio" id="mytbs_batch_mail_options_send_no" onclick="jQuery('#mytbs_batch_mail_options_block').hide(100);" value="N" name="mytbs_batch_mail_options_send"> 
						<label class="ibm-field-label" for="mytbs_batch_mail_options_send_no">No</label>
					</span>
				</span> 
				<br />
				<div id="mytbs_batch_mail_options_block" style="display: block;">
					&nbsp;&nbsp;
					<span>Mail type:</span> 
					<select id="mytbs_batch_mail_options_option" >
						<option value="F" selected>Output file</option>
						<option value="L">Url for downloading</option>
						<option value="B">Output file and Url</option>
					</select>
					<br />
					&nbsp;&nbsp;
					<span>Compressed(zip) file:</span> 
					<span class="ibm-input-group"> 
						<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mytbs_batch_mail_options_compress_yes" value="Y" name="mytbs_batch_mail_options_compress"> <label class="ibm-field-label" for="mytbs_batch_mail_options_compress_yes">Yes</label> </span> 
						<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mytbs_batch_mail_options_compress_no" value="N" name="mytbs_batch_mail_options_compress" checked> <label class="ibm-field-label" for="mytbs_batch_mail_options_compress_no">No</label> </span>
					</span>
					<br />	
					&nbsp;&nbsp;
					<span>Show SMS SOM Support Team info?</span> 
					<span class="ibm-input-group"> 
						<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mytbs_batch_mail_options_creator_yes" value="Y" name="mytbs_batch_mail_options_creator"> <label class="ibm-field-label" for="mytbs_batch_mail_options_creator_yes">Yes</label></span> 
						<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mytbs_batch_mail_options_creator_no" value="N" name="mytbs_batch_mail_options_creator" checked> <label class="ibm-field-label" for="mytbs_batch_mail_options_creator_no">No</label></span>
					</span>												
				</div>
			</fieldset>	
    	</div>
    	<div name="mytbs_batch_operation" id="mytbs_batch_copy" >
    		<p>Please specify the desired recipient by entering their intranet ID (e.g. joe@us.ibm.com). When the copy is complete, both you and the target recipient will receive a confirmation email notification.</p>
    		<p><label for="mytbs_batch_copy_cwa">The intranet ID:&nbsp;</label><span><input id="mytbs_batch_copy_cwa" size="30" value="${cwa_id}" type="text" placeholder="jdoe@us.ibm.com" /></span></p>
    	</div>			
    	<div name="mytbs_batch_operation" id="mytbs_batch_backup" >
    		<p>Please specify the desired back-up owner for your selected CSRs by entering their intranet ID (e.g.jdoe@us.ibm.com) or leave blank to delete the existing entry.</p>
    		<p><label for="mytbs_batch_backup_cwa">The intranet ID:&nbsp;</label><span><input id="mytbs_batch_backup_cwa" size="30" value="${cwa_id}" type="text" placeholder="jdoe@us.ibm.com" /></span></p>
    	</div>
    	<div name="mytbs_batch_operation" id="mytbs_batch_priority" >
    		<p>Please specify the priority level you want. </p>
    		<p>If the schedule is already set <strong>off-peak by admin</strong>, it will not be updated.</p>
    		<br />
    		<fieldset class="mytbs_fieldset_box"> <legend>Available priorities: </legend>
				<span class="ibm-input-group"> 
					&nbsp;&nbsp;
					<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mytbs_batch_priority_H" value="H" name="mytbs_batch_priority_options"> <label class="ibm-field-label" for="mytbs_batch_priority_H">High</label></span> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mytbs_batch_priority_M" value="M" name="mytbs_batch_priority_options"> <label class="ibm-field-label" for="mytbs_batch_priority_M">Medium</label></span>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mytbs_batch_priority_L" value="L" name="mytbs_batch_priority_options"> <label class="ibm-field-label" for="mytbs_batch_priority_L">Low</label></span>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="ibm-radio-wrapper"> <input class="ibm-styled-radio" type="radio" id="mytbs_batch_priority_O" value="O" name="mytbs_batch_priority_options" checked> <label class="ibm-field-label" for="mytbs_batch_priority_O">Off-peak</label></span>
				</span>	  
			</fieldset>		
    	</div>
    	<div name="mytbs_batch_operation" id="mytbs_batch_frequency" >
    		<p>For this operation, we need to apply the change to schedules which are based on <strong>the same data load</strong>. </p>
    		<p><strong>NRT</strong> report schedules are NOT eligible for frequency selection. </p>
    		<p>Select the timing upon which you want your scheduled report to run using the Schedule frequency section below. Note that schedules are triggered to run upon the completion of the specified data load for the day(s) requested.</p>
    		<br />
    		<div id="mytbs_batch_frequency_options"></div>
    	</div>  
    	<div name="mytbs_batch_operation" id="mytbs_batch_format" >
    		<p>Please select the desired report output format. </p>
 			<br />
    		<div id="mytbs_batch_format_box"></div>
    	</div>    	      
    	<div name="mytbs_batch_operation" id="mytbs_batch_email_list" >
    		<p>Please enter your e-Mail address and distribution list, separated by spaces.</p>
    		<textarea id="mytbs_batch_email_list_input" rows="6" cols="60" placeholder="jdoe@us.ibm.com mydistlist" ></textarea>
    	</div>     		
    	<div name="mytbs_batch_operation" id="mytbs_batch_email_comments" >
    		<p>Please enter your e-Mail comments. </p>
    		<textarea id="mytbs_batch_email_comments_text" rows="6" cols="60" placeholder="some text here please" ></textarea>
    	</div>   
     	<div name="mytbs_batch_operation" id="mytbs_batch_error_notification" >
    		<fieldset class="mytbs_fieldset_box"> <legend>Notify errors?</legend>
				<span class="ibm-input-group">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="ibm-radio-wrapper"> 
						<input class="ibm-styled-radio" type="radio" value="Y" id="mytbs_batch_error_notification_Y" name="errNotify" checked> 
						<label class="ibm-field-label" for="mytbs_batch_error_notification_Y">Yes</label>
					</span> 
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="ibm-radio-wrapper"> 
						<input class="ibm-styled-radio" type="radio" value="N" id="mytbs_batch_error_notification_N" name="errNotify"> 
						<label class="ibm-field-label" for="mytbs_batch_error_notification_N">No</label>
					</span>
				</span>
			</fieldset> 
    	</div>    	
    	<div name="mytbs_batch_operation" id="mytbs_batch_dataload" >
    		<p>Please select the appropriate data load to trigger your schedule to run. </p>
    		<div id="mytbs_batch_dataload_select"></div>
    	</div>   
    	<div name="mytbs_batch_operation" id="mytbs_batch_take_owner" >
    		<p>This function will make you become the owner for selected schedule requests. </p>
    		<p>Please notice you should be the backup of the selected schedule requests to do so. </p> 
    		<p>Your ID will be removed from the backup field as part of this process. </p>
    	</div>   
     	<div name="mytbs_batch_operation" id="mytbs_batch_toggle_backup" >
    		<p>This function will set the owner as new backup, and set the backup as new owner for selected schedule requests. </p>
    		<p>Please notice both the owner and the backup can request to do so. </p> 
    	</div>  
    	<div name="mytbs_batch_operation" id="mytbs_batch_prompts_comments" >
    		<p>Please enter your comments for <b>Edit prompts</b> tab. </p>
    		<textarea id="mytbs_batch_prompts_comments_text" rows="6" cols="60" placeholder="some text here please" ></textarea>
    	</div>     	  	  		
    	<br />
		<p class='ibm-btn-row ibm-center'>
			<button class='ibm-btn-pri ibm-btn-blue-50 ibm-btn-small' onclick='mytbsBatchOk(jQuery("#mytbs_batch_options").val());'	>OK</button> 
			<button class='ibm-btn-sec ibm-btn-blue-50 ibm-btn-small' onclick='mytbsBatchCancel();'									>Cancel</button> 
		</p>
    </div>
 	<div id="mytbs_confirmation_delete" class="ibm-common-overlay ibm-overlay-alt" data-widget="overlay" data-type="alert">
 		<h3 id="mytbs_confirmation_delete_num_selected" class="ibm-h3 ibm-center">0 schedules are selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected Cognos Schedule Requests should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="mytbsBatchDeleteOk();"		>OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="mytbsBatchDeleteCancel();"	>Cancel</button>  	
 		</p>
 	</div>

 	<div id="mytbs_showhide_columns" class="ibm-common-overlay" data-widget="overlay" data-type="alert">
 		<br>
  		<p>Please specify your settings here.</p>
 		<br>
 		<table id="mytbs_showhide_columns_table" class="ibm-data-table ibm-altcols">
 		</table> 
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="mytbsPageColumnsOk();"		>OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="mytbsPageColumnsCancel();"	>Cancel</button>  	
 		</p>
 	</div>

 	<div id="mytbs_bydeck" class="ibm-common-overlay ibm-overlay-alt-three" data-widget="overlay" data-type="alert">
 		<br>
  		<p>This is a special filter using Autodecks that you own.</p>
 		<br>	
		<table id="mytbs_bydeck_table" class="ibm-data-table ibm-altrows"></table> 	
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="mytbsPageByDeckOk();"		>OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="mytbsPageByDeckCancel();"	>Cancel</button>  	
 		</p>
 	</div>

    <!-- ================================================================= batch form end   -->
    <jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
    <!-- ================================================================= custom page doc ready JavaScript codes start -->
    <script type="text/javascript">
        //=============================================tbsListMessage* 
        function mytbsMessage(message) {
            IBMCore.common.widget.overlay.hideAllOverlays();
            var myOverlay = IBMCore.common.widget.overlay.createOverlay({
                contentHtml: '<p>' + message + '</p>',
                classes: 'ibm-common-overlay ibm-overlay-alt'
            });
            myOverlay.init();
            myOverlay.show();
        }
        
        function mytbsMessageError(message) {
            IBMCore.common.widget.overlay.hideAllOverlays();
            var myOverlay = IBMCore.common.widget.overlay.createOverlay({
                contentHtml: '<p class="ibm-textcolor-red-50 ibm-bold ibm-center">' + message + '</p>',
                classes: 'ibm-common-overlay ibm-overlay-alt-three'
            });
            myOverlay.init();
            myOverlay.show();
        }

     	//=============================================mytbsFormat*  
        function mytbsFormatScheduleFrequency(sch) { //this is from old ScheduleCognosComponent.java
            var tmp = "";
            var freqType = jQuery.trim(sch["tbsSchedFreq"]);
            var freqDetail = jQuery.trim(sch["tbsSchedFreqDetail"]);
            var trigType = jQuery.trim(sch["triggerTriggerType"]);
            //-------------checking 1
            if (trigType === "W" && freqType !== "M" && freqType !== "B") {
                freqType = "W";
            }
            if (trigType === "D" && freqType !== "M" && freqType !== "B") {
                freqType = "D";
            }
            if (trigType === "N") {
                freqType = "N";
            }
            //-------------checking 2
            switch (freqType) {
                case "W":
                    tmp = "Weekly";
                    if (freqDetail === "M,Tu,W,Th,F,Sa,Su") {
                        freqDetail = "";
                    } else {
                        var pos = freqDetail.indexOf(",");
                        if (pos != -1) {
                            freqDetail = freqDetail.substring(0, pos);
                        }
                    }
                    break;
                case "M":
                    tmp = "Monthly";
                    break;
                case "B":
                    tmp = "Business";
                    break;
                case "D":
                    tmp = "Daily";
                    break;
                case "N":
                    tmp = "NRT";
                    freqDetail = "";
                    break;
                default:
                    tmp = freqType;
                    console.log('logging...error in matching this SchedFreq type...' + JSON.stringify(sch));
                    break;
            }
            return tmp + "<br />" + freqDetail;
        }

        function mytbsFormatDate(timestamp) {
            var myNewDate = new Date();
            myNewDate.setTime(timestamp);
            return myNewDate.getFullYear() + "-" + (myNewDate.getMonth() + 1) + "-" + myNewDate.getDate();
        }

        function mytbsFormatOwner(sch) {
            var tmp = jQuery.trim(sch["tbsCwaId"]);
            if (tmp === "${cwa_id}") {
                tmp = "Owner";
            } else {
                tmp = "Backup";
            }
            return tmp;
        }

        function mytbsFormatTrigger(sch) {
            var tmp = jQuery.trim(sch["triggerSchedStatus"]);
            if (tmp === "OK") {
                tmp = "<span class='mytbs_green'>" + tmp + "</span>";
            } else {
                tmp = "<span class='mytbs_red'>"   + tmp + "</span>"; //supposedly this is 'NO', if not, I think we need to highlight it too
            }
            return sch["triggerTriggerDesc"] + " / " + tmp;
        }

        function mytbsFormatReqStatus(sch) {
            var theStatus = jQuery.trim(sch["tbsRequestStatus"]);
            var isChild = jQuery.trim(sch["tbsChildTbs"]);
            var formattedStr = "";
            if (isChild === "Y") {
            	formattedStr="(C)";
            }
            formattedStr = (myTbsWordExpansionStatus[theStatus] === undefined) ? theStatus+formattedStr : myTbsWordExpansionStatus[theStatus]+formattedStr; 
            if ((theStatus === "D") || (theStatus === "S")) {
				formattedStr = "<span class='mytbs_red'>" + formattedStr + "</span>";
            }             
            return formattedStr;
        }

        function mytbsFormatRunStatus(sch) {
            var theStatus = sch["tbsLastStatus"];
            var count = sch["tbsTotalCount"];
            var formattedStr = "";

            if (count === null) {
                formattedStr = "";
            } else if (count + "" === "") {
                formattedStr = "";
            } else if (count < 1) {
                formattedStr = "";
            } else {
                theStatus = jQuery.trim(theStatus);
                
                if (theStatus === "101" || theStatus === "100") {
                		//Success----we have download-able outputs 
					formattedStr = "<span class='mytbs_green' title='"+myTbsWordExpansionRunStatus[theStatus]+"'>" + theStatus + "</span>";
                } else if ( theStatus === "111" || theStatus === "200" || theStatus === "400" ) { 
                		//Failure----we don't have files to download 
					formattedStr = "<span class='mytbs_red'   title='"+myTbsWordExpansionRunStatus[theStatus]+"'>"  + theStatus + "</span>";
                } else if (theStatus === "300") { 
                		//Running 
                    formattedStr = "Running";
                } else {
                		//Warning?
                		//currently only 6 status codes from help page and they are stored in myTbsWordExpansionRunStatus, delt with in the above branches 
                		//so new status codes will fall into this category 
                    formattedStr = theStatus;
                }
            }

            return formattedStr;
        }

        function mytbsFormatRunTime(sch) {
            var theTime = sch["tbsLastRunTime"];
            var count = sch["tbsTotalCount"];
            var formattedStr = "";

            if (count === null) {
                formattedStr = "";
            } else if (count + "" === "") {
                formattedStr = "";
            } else if (count < 1) {
                formattedStr = "";
            } else {
                // changed Run Date to have link to download output
                var tmpTbsLastStatus = sch["tbsLastStatus"];
                if (tmpTbsLastStatus == "100" || tmpTbsLastStatus == "101") {
                    formattedStr = (theTime === null) ? "" : '<a href=' + myTbsContext +
                        '/action/portal/tbsoutputs/downLoadTBSOutput/' + myTbsCwa + '/' + myTbsUid + '/N/' + sch["tbsRequestId"] +
                        ' target="_blank" onclick="mytbsDownloadSaveUsage(\'' + sch["tbsDomainKey"] + '\', \'' + sch["tbsRptAccessId"] +
                        '\', \'' + sch["tbsRptName"] + '\');return 1;">' + mytbsFormatDate(theTime) + '</a>';
                } else {
                    formattedStr = (theTime === null) ? "" : mytbsFormatDate(theTime);
                }
            }

            return formattedStr;
        }

        function mytbsFormatPriority(sch) {
            var priOffPeak = (sch["tbsOffpeak"] === null) ? "N" : jQuery.trim(sch["tbsOffpeak"]);
            var priLevel   =  sch["tbsPriorityLevel"] ;
            var formattedStr = (priOffPeak === "N") ? priLevel : priOffPeak ; 
            formattedStr = (myTbsWordExpansionPriority[formattedStr] === undefined) ? formattedStr : myTbsWordExpansionPriority[formattedStr]; 
            return formattedStr;
        }
        
        //=============================================mytbsDownload* 
        function mytbsDownloadSaveUsage(domainkey, rptaccessid, rptname) {// this function is used for save downloading usage when click Run Date link or click Download outputs button.

            var report = {};
            report["uid"] = myTbsUid;
            report["cwaid"] = myTbsCwa;
            report["domain_Key"] = domainkey;
            report["rptObjID"] = rptaccessid;
            report["rptName"] = rptname;
            report["reportType"] = "Cognos";

            var timeid = (new Date()).valueOf();
            var url = myTbsContext + '/action/portal/usage/saveReportUsage/DL?timeid=' + timeid;
            jQuery.ajax({
                type: "post",
                url: url,
                data: JSON.stringify(report),
                contentType: "application/json",
                datatype: "json", // "xml", "html", "script", "json", "jsonp", "text".
                beforeSend: function () {
                    //window.status = 'adding recent ...';
                },
                success: function (data) {
                    //window.status = 'successful';
                },
                error: function (error) {
                    //alert('failed to save usage data, error reason:' + error.responseText);
                }
            });
        }

        function mytbsDownloadPopup() { // popup a dialogue to let end user to confirm he/she selected TBS and how many TBS outputs can be downloaded. 
            var postData = [];

            jQuery("tr.ibm-row-selected").each(function (index, item) {
                var itemObj = jQuery(item);
                postData.push({
                    "tbsLastStatus": itemObj.attr("data-eod-tbsLastStatus"),
                    "tbsTotalCount": itemObj.attr("data-eod-tbsTotalCount")
                });
            });

            if (postData.length < 1) {
                mytbsMessage("please select at least 1 schedule which Run Status is 100 or 101");
                return false;
            } else {
                var postDataLength = postData.length;
                var canDownloadCount = 0;

                for (var i = 0; i < postDataLength; i++) {
                    var tmpData = postData[i];
                    var tmpTbsTotalCount = tmpData["tbsTotalCount"];

                    if (tmpTbsTotalCount === null || tmpTbsTotalCount + "" === "" || tmpTbsTotalCount < 1) {
                        continue;
                    } else {
                        var tmpTbsLastStatus = tmpData["tbsLastStatus"];
                        if (tmpTbsLastStatus == "100" || tmpTbsLastStatus == "101") {
                            canDownloadCount++;
                        } else {
                            continue;
                        }
                    }
                }

                if (canDownloadCount == 0) {
                    mytbsMessage("please select at least 1 schedule which Run Status is 100 or 101");
                    return false;
                } 

				var tbsPopupHeader = "";
 				var tbsPopupGuide = "<p class='ibm-left'>" + postDataLength + " selected schedules - " + canDownloadCount +
                        " of them have outputs available (i.e. Run Status is 100 or 101). Click on OK to download these " + canDownloadCount + " files.</p>";
 				var tbsPopupcheckbox = "<p class='ibm-btn-row ibm-left'><input type='checkbox' class='ibm-styled-checkbox' name='zip_donwload' id='id_zip_download' />"
                    	+"<label for='id_zip_download' class='ibm-field-label'>Compress selected output files and download&nbsp</label></p>";
				var tbsPopupButton = "<p class='ibm-btn-row ibm-center'><button class='ibm-btn-pri ibm-btn-blue-50 ibm-btn-small' onclick='mytbsDownloadOK(\""+canDownloadCount+"\");'>OK</button> "
                    	+"<button class='ibm-btn-sec ibm-btn-blue-50 ibm-btn-small' onclick='mytbsDownloadCancel();'>Cancel</button></p>";

				var myOverlay = IBMCore.common.widget.overlay.createOverlay({
                        	contentHtml: '<div id="mytbs_download_popup_confirmation">' + tbsPopupHeader + '<br />' + tbsPopupGuide + '<br />' + tbsPopupcheckbox + '<br />' + tbsPopupButton + '</div>',
                        	classes: 'ibm-common-overlay ibm-overlay-alt',
                        	type: 'alert'
                    	});
   				myOverlay.init();
 				myOverlay.show();
            }
        }
        
		function mytbsDownloadCancel() {
			var theOverlayId = IBMCore.common.widget.overlay.getWidget("mytbs_download_popup_confirmation").getId();
			IBMCore.common.widget.overlay.hide(		theOverlayId, true);
			IBMCore.common.widget.overlay.destroy(	theOverlayId);
			//2017 Sep 5, don't know why v18 is failing of removing the div, so add this to make sure 
			var found = jQuery("#mytbs_download_popup_confirmation"); 
			if (found.length > 0) found.remove(); 
		}

        function mytbsDownloadOK(canDownloadCount) {// after click OK in download confirm dialogue, it is going to download outputs. 
        	var zip_download = jQuery("#id_zip_download").prop("checked");
        	
        	mytbsDownloadCancel(); 

            if (canDownloadCount < 1) {
                return;
            } else {

                var postData = [];

                jQuery("tr.ibm-row-selected").each(function (index, item) {
                    var itemObj = jQuery(item);
                    postData.push({
                        "tbsRequestId": itemObj.attr("data-eod-tbsRequestId"),
                        "tbsLastStatus": itemObj.attr("data-eod-tbsLastStatus"),
                        "tbsTotalCount": itemObj.attr("data-eod-tbsTotalCount"),
                        "tbsDomainKey": itemObj.attr("data-eod-tbsDomainKey"),
                        "tbsRptAccessId": itemObj.attr("data-eod-tbsRptAccessId"),
                        "tbsRptName": itemObj.attr("data-eod-tbsRptName")
                    });
                });

                var postDataLength = postData.length;
                if (zip_download) {
                    var url = myTbsContext + "/action/portal/zipdeck";
                    var zipdeck = new Array();
                    for (var i = 0; i < postDataLength; i++) {
                        var tmpData = postData[i];
                        var tmpTbsTotalCount = tmpData["tbsTotalCount"];

                        if (tmpTbsTotalCount === null || tmpTbsTotalCount + "" === "" || tmpTbsTotalCount < 1) {
                            continue;
                        } else {
                            var tmpTbsLastStatus = tmpData["tbsLastStatus"];
                            if (tmpTbsLastStatus == "100" || tmpTbsLastStatus == "101") {
                                var deck = {};
                                deck["cwa_id"] = myTbsCwa;
                                deck["uid"] = myTbsUid;
                                deck["deck_type"] = "O";
                                deck["deck_format"] = "zip";
                                deck["request_id"] = tmpData["tbsRequestId"];
                                zipdeck.push(deck);
                            } else {
                                continue;
                            }
                        }
                    }

                    if (zipdeck.length > 0) {
                        var submit_form = document.getElementById("id_zipdeck_submit_form");
                        if (submit_form == null || submit_form == undefined) {
                            submit_form = document.createElement("form");
                        }
                        submit_form.id = "id_zipdeck_submit_form";
                        document.body.appendChild(submit_form);
                        submit_form.action = url;
                        submit_form.target = "_blank";
                        submit_form.method = "post";

                        var opt = document.createElement("input");
                        opt.type = 'hidden';
                        opt.name = "cwa_id";
                        opt.value = zipdeck[0].cwa_id;
                        submit_form.appendChild(opt);
                      
                        var opt1 = document.createElement("input");
                        opt1.type = 'hidden';
                        opt1.name = "uid";
                        opt1.value = zipdeck[0].uid;
                        submit_form.appendChild(opt1);

                        var opt2 = document.createElement("input");
                        opt2.type = 'hidden';
                        opt2.name = "deck_type";
                        opt2.value = zipdeck[0].deck_type;
                        submit_form.appendChild(opt2);

                        var opt3 = document.createElement("input");
                        opt3.type = 'hidden';
                        opt3.name = "deck_format";
                        opt3.value = zipdeck[0].deck_format;
                        submit_form.appendChild(opt3);

                        for (var i = 0; i < zipdeck.length; i++) {
                            var opt4 = document.createElement("input");
                            opt4.type = 'hidden';
                            opt4.name = "request_id";
                            opt4.value = zipdeck[i].request_id;
                            submit_form.appendChild(opt4);
                        }
                        
                        submit_form.submit();
                        document.body.removeChild(submit_form);
                    }

                } else {
                    var url = myTbsContext + "/action/portal/tbsoutputs/downLoadTBSOutput/" + myTbsCwa + "/" + myTbsUid + "/Y/";

                    for (var i = 0; i < postDataLength; i++) {
                        var tmpData = postData[i];
                        var tmpTbsTotalCount = tmpData["tbsTotalCount"];

                        if (tmpTbsTotalCount === null || tmpTbsTotalCount + "" === "" || tmpTbsTotalCount < 1) {
                            continue;
                        } else {
                            var tmpTbsLastStatus = tmpData["tbsLastStatus"];
                            if (tmpTbsLastStatus == "100" || tmpTbsLastStatus == "101") {
                                window.open(url + tmpData["tbsRequestId"]);
                                mytbsDownloadSaveUsage(tmpData["tbsDomainKey"], tmpData["tbsRptAccessId"], tmpData["tbsRptName"]);
                            } else {
                                continue;
                            }
                        }
                    }
                }
            }
        }

        //=============================================mytbsNav* 
        function mytbsNavLoadFolders() {
            jQuery("#mytbs_userFolders").empty();
            jQuery("#mytbs_userFolders").append("<img src='" + myTbsContext + "/images/ajax-loader.gif' />");
            jQuery.get(myTbsContext + "/action/portal/tree/" + myTbsCwa + "/" + myTbsUid + "/mytbs?timeid=" + (new Date()).valueOf())
                .fail(function (jqXHR, textStatus, errorThrown) {
                    mytbsMessage("ajax error in loading..." + errorThrown);
                    console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
                    console.log("ajax error in loading...textStatus..." + textStatus);
                    console.log("ajax error in loading...errorThrown..." + errorThrown);
                })
                .done(function (data) {
                    jQuery("#mytbs_userFolders").empty();
                    var nodes = (data.content === undefined) ? [] : JSON.parse(data.content); //new users could have no record at all, otherwise assuming valid array of nodes
                    var arrFolderNames = {};	//key is folder id, value is folder name 
                    var arrFolderSchedules = {};//key is folder id, value is array, an array of link references
                    var arrFolderIds = []; 		//array of folder ids, the loop below doesn't include root in this array. 
                    var k = 0; 					//number of folders

                    //----go through nodes now 
                    if (nodes.length < 1) console.log("we have nodes from backend, length = " + nodes.length);
                    arrFolderNames["#"] = "root";
                    arrFolderSchedules["#"] = [];
                    for (var i = 0; i < nodes.length; i++) {
                        if (nodes[i].type === "folder") {
                            arrFolderNames[nodes[i].id] = nodes[i].text;//remember folder name 
                            arrFolderSchedules[nodes[i].id] = []; 		//create folder array to hold children links 
                            arrFolderIds[k] = nodes[i].id; 				//remeber folder id 
                            k = k + 1; 									//how many folders 
                        } else if (nodes[i].type === "link") {
                            arrFolderSchedules[nodes[i].parent].push(nodes[i].reference);
                        } else {
                            console.log("error...we don't know what to do with this node, " + nodes[i].id + ":" + nodes[i].text);
                        }
                    }
                    
                    //---assign to global var for later access, console.log(JSON.stringify(arrFolderSchedules)); 
					myTbsFolderItsCsr = arrFolderSchedules; 
					
                    //----create list of folders in left nav 
                    for (var j = 0; j < k; j++) {
                        jQuery("#mytbs_userFolders").append("<li role='presentation'><a role='treeitem' href='#' tabindex='-1' name='eod-folder' data-eod-nodeid='" 
                        	+ arrFolderIds[j] + "' onclick='mytbsNavSelectFolder(this);' >" + arrFolderNames[arrFolderIds[j]] + "</a></li>");
                    }

                })
        }

        function mytbsNavSelectFolder(obj) {
        		jQuery("#mytbs_folder_bydeck").removeAttr("aria-selected");
            jQuery("a[name='eod-folder']").removeAttr("aria-selected");
            jQuery(obj).attr("aria-selected", "true"); 
            myTbsHiddenRows = []; //clear the count of hidden rows -- same when select folder/deck
			mytbsPageAjax(); 
        }

        //=============================================mytbsMenu*  
        function mytbsMenuFixed(id) {
            var obj = document.getElementById(id);
            var _getHeight = obj.offsetTop;
            window.onscroll = function () { mytbsMenuChangePosition(id, _getHeight) }
        }

        function mytbsMenuToggleLeftNav() {
            if (jQuery("#ibm-primary-links").css("display") === "none") {
                jQuery("#mytbs_right_col").width(window.innerWidth - 200);
                jQuery("#mytbs_left_col").width(200);
                jQuery("#ibm-primary-links").show(500);
            } else {
                jQuery("#ibm-primary-links").hide(500);
                jQuery("#mytbs_left_col").width(0);
                jQuery("#mytbs_right_col").width(window.innerWidth);
            }
        }

        function mytbsMenuMakesureLeftNav() {
            if (jQuery("#ibm-primary-links").css("display") === "none") {
                jQuery("#mytbs_right_col").width(window.innerWidth);
                jQuery("#mytbs_left_col").width(0);
            } else {
                jQuery("#mytbs_right_col").width(window.innerWidth - 200);
                jQuery("#mytbs_left_col").width(200);
            }	 
        }
        
        function mytbsMenuChangePosition(id, height) {
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

        function mytbsMenuButtonBinding() {  
        		jQuery("#mytbs_folder_bydeck").on(				'click', function (e) { mytbsPageByDeckPopup() });
        		jQuery("#mytbs_button_showhideunselected").on(	'click', function (e) { mytbsPageShowHideUnSelected() });
        		jQuery("#mytbs_button_showhidecol").on(			'click', function (e) { mytbsPageColumnsPopup() });
            jQuery("#mytbs_button_showhidenav").on(			'click', function (e) { mytbsMenuToggleLeftNav() });
            jQuery("#mytbs_button_runnow").on(				'click', function (e) { mytbsBatchPopup("run_now") });
//             jQuery("#mytbs_button_activate").on(	'click', function (e) { mytbsBatchPopup("activate_or_inactivate") });
//             jQuery("#mytbs_button_extend").on(		'click', function (e) { mytbsBatchPopup("extend_date") });
            jQuery("#mytbs_button_delete").on(				'click', function (e) { mytbsBatchPopup("delete") });
            jQuery("#mytbs_button_download").on(				'click', function (e) { mytbsDownloadPopup() });
            jQuery("#mytbs_button_batch").on(				'click', function (e) { mytbsBatchPopup() });
        }
        
        //=============================================mytbsBatch*           
        //select schedules, click delete button     --> mytbsBatchPopup --> user confirm    --> mytbsBatchDeleteOk --> mytbsBatchAjax
        //select schedules, click update Bulk       --> mytbsBatchPopup --> user input      --> mytbsBatchOk       --> mytbsBatchAjax        
        function mytbsBatchPopup(operation){
            var postData = [];
			//------------get last time selection 
            if ( operation === undefined || operation === "") { 
	            operation = Cookies.get('eodTbsListBulkUpdateSelect');
            }
          	//------------looping 
            jQuery("tr.ibm-row-selected").each(function (index, item) {
                postData.push({
                    "tbsRequestId": 	jQuery(item).attr("data-eod-tbsRequestId"),
                    "tbsRptName": 		jQuery(item).attr("data-eod-tbsRptName"),
                    "tbsEmailSubject": 	jQuery(item).attr("data-eod-tbsEmailSubject")
                });
            });
            if (postData.length < 1) {
                mytbsMessage("please select at least 1 schedule");
                return false;
            }
            //------------next
			if (operation === "delete") { 
	        		//confirmation overlay is unique 
	        		IBMCore.common.widget.overlay.show("mytbs_confirmation_delete");
	        		jQuery("#mytbs_confirmation_delete_num_selected").text(	postData.length+" schedule(s) are selected.");
	        	} else {
	        		//confirmation overlay is a universal one for all
		    		IBMCore.common.widget.overlay.show("mytbs_batch_form");
		    		jQuery("#mytbs_batch_num_selected").text(				postData.length+" schedule(s) are selected."); 
				mytbsBatchSelect(operation); 
	        	}          
        }
        
        function mytbsBatchSelect(operation){ //the on change event, dynamic contents 
        	//----remember in cookies 
        	Cookies.set('eodTbsListBulkUpdateSelect', operation, myTbsCookieSettings);
        	
        	//----general selection to show fields 
        	jQuery("div[name='mytbs_batch_operation']").hide();
        	jQuery("#mytbs_batch_options").val(operation); 
        	var selected = jQuery("#mytbs_batch_"+operation); 
        	if (selected.length > 0) selected.show(); 
        	
        	//----special for the same 
        	if ( operation === "format" || operation === "dataload" ) {
        		jQuery("#mytbs_batch_same_report_warning").show(); 
        	}
        	
        	//----dynamic for dataload
		if ( operation === "dataload" ) {
          			jQuery("#mytbs_batch_dataload_select").empty(); 
	                jQuery("#mytbs_batch_dataload_select").append("<img src='" + myTbsContext + "/images/ajax-loader.gif' />");
	                
	           		var tbsSearchPath 	= jQuery(jQuery("tr.ibm-row-selected").get(0)).attr("data-eod-tbsSearchPath");
					var tbsDomainKey 	= jQuery(jQuery("tr.ibm-row-selected").get(0)).attr("data-eod-tbsDomainKey");

	                jQuery.get(myTbsContext + "/action/portal/mycognosschedulelist/getAvailableTriggers/"+myTbsCwa+"/"+myTbsUid+"?timeid=" + (new Date()).valueOf()+"&domainKey="+tbsDomainKey+"&searchPath="+tbsSearchPath )
	                    .done(function (data) {
	                    	var selectList = "&nbsp;&nbsp;&nbsp;&nbsp;<select name='triggerCode' size='6'>"; 
	                        for (var i = 0; i < data.length; i++) {
								selectList += "<option value='"+data[i].id.triggerCD+"'>"+ data[i].triggerDesc +"</option>"
	                        }
	                        selectList += "</select>";
	                        selectList = "<fieldset class='mytbs_fieldset_box'> <legend>Available data loads:</legend>"+selectList+"</fieldset>";
	                        jQuery("#mytbs_batch_dataload_select").empty(); 
	                        jQuery("#mytbs_batch_dataload_select").append(selectList); 
	                    })
	                    .fail(function (jqXHR, textStatus, errorThrown) {
	                        console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
	                        console.log("ajax error in loading...textStatus..." + textStatus);
	                        console.log("ajax error in loading...errorThrown..." + errorThrown);
	                        mytbsMessageError("ajax error in loading..." + errorThrown);
	                    })  
	        }        	
	        //----dynamic for format
          	if ( operation === "format" ) {
          			jQuery("#mytbs_batch_format_box").empty(); 
	                jQuery("#mytbs_batch_format_box").append("<img src='" + myTbsContext + "/images/ajax-loader.gif' />");
	                
	           		var tbsDomainKey 	= jQuery(jQuery("tr.ibm-row-selected").get(0)).attr("data-eod-tbsDomainKey");
	            	var tbsRptType 		= jQuery(jQuery("tr.ibm-row-selected").get(0)).attr("data-eod-tbsRptType");
     	
	                jQuery.get(myTbsContext + "/action/portal/mycognosschedulelist/getAvailableOutputFormats/"+myTbsCwa+"/"+myTbsUid+"?timeid=" + (new Date()).valueOf()+"&domainKey="+tbsDomainKey+"&rptType="+tbsRptType )
	                    .done(function (data) {
	                    	jQuery("#mytbs_batch_format_box").empty(); 
	                    	jQuery("#mytbs_batch_format_box").append("<fieldset id='mytbs_batch_format_fieldset' class='mytbs_fieldset_box'> <legend>Format options:</legend><span class='ibm-input-group'></span></fieldset>"); 
	                     	var runOptionArray = null; 
	                        var tmp = ""; 
	                        var tmpOptions = ""; 
	                        for (var i = 0; i < data.length; i++) {
	                        	tmp = ""; 
	                        	tmpOptions = ""; 
	                        	//-----start
	                        	tmp += '<span class="ibm-radio-wrapper">&nbsp;&nbsp;<input class="ibm-styled-radio" type="radio" id="mytbs_batch_format_'+i+'_id" value="'+data[i].id.outputType+'" name="mytbs_batch_format_options" />';  
								tmp += "<label for='mytbs_batch_format_"+i+"_id'>"+data[i].typeDescription+"</label>";
								//-----list item options 
								if(data[i].runOptions != null){
									tmpOptions += "&nbsp;&nbsp;<label>Run Option:</label>&nbsp;&nbsp;";
									tmpOptions += "<span><select name='mytbs_batch_format_runoption' style='width:100px'>";
									runOptionArray = data[i].runOptionsMapping;
									for(var j=0;j<runOptionArray.length;j++) {
									    tmpOptions += "<option value='"+runOptionArray[j][0]+"'>"+runOptionArray[j][1]+"</option>"
									}
									tmpOptions += "</select></span>";
								}
								//-----end 
								tmp += tmpOptions + "</span><br />"; 
								jQuery("#mytbs_batch_format_fieldset").append(tmp);
	                        }
	                        //-----default selection 
	                        var myfirst = jQuery("#mytbs_batch_format_fieldset").find("input[name='mytbs_batch_format_options'][value='spreadsheetML']").get(0);   
	                        if ( myfirst === undefined) {
	                        	myfirst = jQuery("#mytbs_batch_format_fieldset").find("input[name='mytbs_batch_format_options']").get(0);
	                        	if ( myfirst === undefined) {
	                        		//we couldn't do anything
	                        	} else {			
	                        		jQuery(myfirst).click();  
	                        	}
	                        } else {
	                        	jQuery(myfirst).click(); 
	                        }
	                        
	                    })
	                    .fail(function (jqXHR, textStatus, errorThrown) {
	                        console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
	                        console.log("ajax error in loading...textStatus..." + textStatus);
	                        console.log("ajax error in loading...errorThrown..." + errorThrown);
	                        mytbsMessageError("ajax error in loading..." + errorThrown);
	                    })          	
          	}       	
			//----dynamic for frequency 
         	if ( operation === "frequency" ) {
	            var tbsTriggerCd 		= jQuery(jQuery("tr.ibm-row-selected").get(0)).attr("data-eod-triggerTriggerCd");
	            var tbsTriggerType 		= jQuery(jQuery("tr.ibm-row-selected").get(0)).attr("data-eod-triggerTriggerType");
	            var tbsTriggerApplCd 	= jQuery(jQuery("tr.ibm-row-selected").get(0)).attr("data-eod-triggerApplCd");
	            jQuery("#mytbs_batch_frequency_options").empty();
	            
	            //---------the options 
	            var tbsPopupSelectBusiness = "<tr>" +
	                "<td class='mytbs_freq_1st_col'>" +
	                "<span class='ibm-radio-wrapper'>" +
	                "<input type='radio' class='ibm-styled-radio' id='id_sch_freq_B' value='B' name='sch_freq'>" +
	                "<label class='ibm-column-field-label' for='id_sch_freq_B'>Business event</label>" +
	                "</span>" +
	                "<br />" +
	                "<div class='ibm-item-note mytbs_freq_notes'>will run on the selected week(s) using the available weekly close of business data.</div>" +
	                "</td>" +
	                "<td class='mytbs_freq_2nd_col'>" +
	                "<select class='mytbs_freq_options' multiple='multiple' id='id_sch_freq_detail_B' title='Business event' size='4' name='sch_freq_detail'>" +
	                "<option value='placeholder_shall_NOT_visible'>Week 01</option>" +
	                "</select>" +
	                "</td>" +
	                "</tr>";
	            var tbsPopupSelectDaily = "<tr>" +
	                "<td class='mytbs_freq_1st_col'>" +
	                "<span class='ibm-radio-wrapper'>" +
	                "<input type='radio' class='ibm-styled-radio' id='id_sch_freq_D' value='D' name='sch_freq'>" +
	                "<label class='ibm-column-field-label' for='id_sch_freq_D'>Daily</label>" +
	                "</span>" +
	                "<br />" +
	                "<div class='ibm-item-note mytbs_freq_notes'>will run using close of business data from the selected day(s).</div>" +
	                "</td>" +
	                "<td class='mytbs_freq_2nd_col'>" +
	                "<select class='mytbs_freq_options' multiple='multiple' id='id_sch_freq_detail_D' title='Daily' size='4' name='sch_freq_detail'>" +
	                "<option value='M'>Monday</option>" +
	                "<option value='Tu'>Tuesday</option>" +
	                "<option value='W'>Wednesday</option>" +
	                "<option value='Th'>Thursday</option>" +
	                "<option value='F'>Friday</option>" +
	                "<option value='Sa'>Saturday</option>" +
	                "<option value='Su'>Sunday</option>" +
	                "</select>" +
	                "</td>" +
	                "</tr>";
	            var tbsPopupSelectWeekly = "<tr>" +
	                "<td class='mytbs_freq_1st_col'>" +
	                "<span class='ibm-radio-wrapper'>" +
	                "<input type='radio' class='ibm-styled-radio' id='id_sch_freq_W' value='W' name='sch_freq'>" +
	                "<label class='ibm-column-field-label' for='id_sch_freq_W'>Weekly</label>" +
	                "</span>" +
	                "<br />" +
	                "<div class='ibm-item-note mytbs_freq_notes'>will run after selected data load trigger is set.</div>" +
	                "</td>" +
	                "<td class='mytbs_freq_2nd_col'>&nbsp;&nbsp;" +
	                "</td>" +
	                "</tr>";
	            var tbsPopupSelectDayOfWeek = "<tr>" +
	                "<td class='mytbs_freq_1st_col'>" +
	                "<span class='ibm-radio-wrapper'>" +
	                "<input type='radio' class='ibm-styled-radio' id='id_sch_freq_DOW' value='DOW' name='sch_freq'>" +
	                "<label class='ibm-column-field-label' for='id_sch_freq_DOW'>Selected day of the week</label>" +
	                "</span>" +
	                "<br />" +
	                "<div class='ibm-item-note mytbs_freq_notes'>will run on selected day assuming the data is available; if data is delayed will run once trigger is set.</div>" +
	                "</td>" +
	                "<td class='mytbs_freq_2nd_col'>" +
	                "<select class='mytbs_freq_options' id='id_sch_freq_detail_DOW' title='Selected day of the week' size='4' name='sch_freq_detail'>" //single selction here
	                +
	                "<option value='M'>Monday</option>" +
	                "<option value='Tu'>Tuesday</option>" +
	                "<option value='W'>Wednesday</option>" +
	                "<option value='Th'>Thursday</option>" +
	                "<option value='F'>Friday</option>" +
	                "<option value='Sa'>Saturday</option>" +
	                "<option value='Su'>Sunday</option>" +
	                "</select>" +
	                "</td>" +
	                "</tr>";
	            var tbsPopupSelectMonthly = "<tr>" +
	                "<td class='mytbs_freq_1st_col'>" +
	                "<span class='ibm-radio-wrapper'>" +
	                "<input type='radio' class='ibm-styled-radio' id='id_sch_freq_M' value='M' name='sch_freq'>" +
	                "<label class='ibm-column-field-label' for='id_sch_freq_M'>Monthly</label>" +
	                "</span>" +
	                "<br />" +
	                "<div class='ibm-item-note mytbs_freq_notes'>will run on the selected date(s) using the available weekly close of business data.</div>" +
	                "</td>" +
	                "<td class='mytbs_freq_2nd_col'>" +
	                "<select class='mytbs_freq_options' multiple='multiple' id='id_sch_freq_detail_M' title='Monthly' size='4' name='sch_freq_detail'>" +
	                "<option value='FM'>1st Mon</option>" +
	                "<option value='FTu'>1st Tue</option>" +
	                "<option value='FW'>1st Wed</option>" +
	                "<option value='FTh'>1st Thu</option>" +
	                "<option value='FF'>1st Fri</option>" +
	                "<option value='FSa'>1st Sat</option>" +
	                "<option value='FSu'>1st Sun</option>" +
	                "<option value='N1'>1st</option>" +
	                "<option value='N2'>2nd</option>" +
	                "<option value='N3'>3rd</option>" +
	                "<option value='N4'>4th</option>" +
	                "<option value='N5'>5th</option>" +
	                "<option value='N6'>6th</option>" +
	                "<option value='N7'>7th</option>" +
	                "<option value='N8'>8th</option>" +
	                "<option value='N9'>9th</option>" +
	                "<option value='N10'>10th</option>" +
	                "<option value='N11'>11th</option>" +
	                "<option value='N12'>12th</option>" +
	                "<option value='N13'>13th</option>" +
	                "<option value='N14'>14th</option>" +
	                "<option value='N15'>15th</option>" +
	                "<option value='N16'>16th</option>" +
	                "<option value='N17'>17th</option>" +
	                "<option value='N18'>18th</option>" +
	                "<option value='N19'>19th</option>" +
	                "<option value='N20'>20th</option>" +
	                "<option value='N21'>21th</option>" +
	                "<option value='N22'>22th</option>" +
	                "<option value='N23'>23th</option>" +
	                "<option value='N24'>24th</option>" +
	                "<option value='N20'>25th</option>" +
	                "<option value='N26'>26th</option>" +
	                "<option value='N27'>27th</option>" +
	                "<option value='N28'>28th</option>" +
	                "<option value='N29'>29th</option>" +
	                "<option value='N30'>30th</option>" +
	                "<option value='N31'>31th</option>" +
	                "<option value='LM'>Last Mon</option>" +
	                "<option value='LTu'>Last Tue</option>" +
	                "<option value='LW'>Last Wed</option>" +
	                "<option value='LTh'>Last Thu</option>" +
	                "<option value='LF'>Last Fri</option>" +
	                "<option value='LSa'>Last Sat</option>" +
	                "<option value='LSu'>Last Sun</option>" +
	                "</select>" +
	                "</td>" +
	                "</tr>";
	            var tbsFrequencyList4Selection = "";
	            switch (tbsTriggerType) {
	                case "B":
	                    tbsFrequencyList4Selection = tbsPopupSelectBusiness;
	                    break;
	                case "D":
	                    tbsFrequencyList4Selection = tbsPopupSelectDaily + tbsPopupSelectMonthly;
	                    break;
	                case "N":
						tbsFrequencyList4Selection = "";
	                    break;
	                case "W":
	                    tbsFrequencyList4Selection = tbsPopupSelectWeekly + tbsPopupSelectDayOfWeek + tbsPopupSelectMonthly + tbsPopupSelectBusiness;
	                    break;
	                default:
	                    tbsFrequencyList4Selection = "cannot deal with this new trigger type=" + tbsTriggerType;
	                    break;
	            }
	            //---------show the options
	            jQuery("#mytbs_batch_frequency_options").append(
	                "<fieldset class='mytbs_fieldset_box'> <legend>Frequency options: </legend> <table><tbody>" +
	                tbsFrequencyList4Selection +
	                "</tbody></table></fieldset>" 	            
	            );
	            //---------set first one to be selected by default 
	            jQuery("#mytbs_batch_frequency_options").find("input[name='sch_freq']").get(0).checked = true;
	
	            //---------set event listner to select options, so when it is clicked, we move the corresponding radio selection 
	            jQuery("select[name='sch_freq_detail']").on('click', function (e) {
	                var targetId = jQuery(this).attr('id').replace("_detail", "");
	                jQuery("#" + targetId).click();
	            });
	
	            //---------loading business events 
	            if (tbsTriggerType === "B" || tbsTriggerType === "W") {
	                jQuery("#id_sch_freq_detail_B").replaceWith("<img id='id_sch_freq_detail_B' src='" + myTbsContext + "/images/ajax-loader.gif' />");
	
	                jQuery.get(myTbsContext + "/action/portal/schedulebusinessevents/" +
	                        myTbsCwa + "/" +
	                        myTbsUid + "/" +
	                        tbsTriggerApplCd + "?" +
	                        "timeid=" + (new Date()).valueOf()
	                    )
	                    .done(function (data) {
	                        jQuery("#id_sch_freq_detail_B").replaceWith(
	                            "<select class='mytbs_freq_options' multiple='multiple' id='id_sch_freq_detail_B' title='Business event' size='4' name='sch_freq_detail'></select>"
	                        );
	                        var freq_events = data;
	                        var freq_detail = jQuery("#id_sch_freq_detail_B");
	                        for (var i = 0; i < freq_events.length; i++) {
	                            jQuery("#id_sch_freq_detail_B").append("<option value='" + freq_events[i].eventCD +
	                                "'>" + freq_events[i].eventDesc +
	                                "</option>");
	                        }
	                        //---------set event listner to select options, so when it is clicked, we move the corresponding radio selection 
	                        freq_detail.on('click', function (e) {
	                            jQuery("#id_sch_freq_B").click();
	                        });
	                    })
	                    .fail(function (jqXHR, textStatus, errorThrown) {
	                        console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
	                        console.log("ajax error in loading...textStatus..." + textStatus);
	                        console.log("ajax error in loading...errorThrown..." + errorThrown);
	                        mytbsMessageError("ajax error in loading..." + errorThrown);
	                    })
	            }

        	}       	
        }        
   
        function mytbsBatchOk(operation){
			if (operation === undefined || operation === "") {
                mytbsMessageError("Please select one operation to proceed."); //normally we shall not reach this 
                return false;
            }
            var postData = [];
            var tmp = null; 
            var errMsg = ""; 
            var newParam = "";    
            
            //------------first 
            var domFirst 			= jQuery(jQuery("tr.ibm-row-selected").get(0)); 
            var domFirstReportId 	= domFirst.attr("data-eod-tbsRptAccessId"); 
            var domFirstSchedFreq 	= domFirst.attr("data-eod-tbsSchedFreq"); 
            var domFirstTriggerCd 	= domFirst.attr("data-eod-triggerTriggerCd");
            var domFirstTriggerType = domFirst.attr("data-eod-triggerTriggerType");
  
            //------------checking on each operation 
            switch (operation) {       
	            case "run_now": {
					//none 
	            		break;}   
	            case "activate_or_inactivate": {
					//none 
	            		break;}  
	            case "extend_date": {
					//none 
            			break;}  
                case "mail_options": {
	                	var ynOption	= jQuery( "#mytbs_batch_mail_options_option").val(); 
	                	var ynSend 		= jQuery( jQuery("#mytbs_batch_mail_options").find("input[name=mytbs_batch_mail_options_send]:checked"		).get(0)  ).val(); 
	                	var ynCompress	= jQuery( jQuery("#mytbs_batch_mail_options").find("input[name=mytbs_batch_mail_options_compress]:checked"	).get(0)  ).val(); 
	                	var ynCreator 	= jQuery( jQuery("#mytbs_batch_mail_options").find("input[name=mytbs_batch_mail_options_creator]:checked"	).get(0)  ).val(); 
	                	newParam = "&send="+ynSend+"&option="+ynOption+"&compress="+ynCompress+"&creator="+ynCreator; 
	                	break; } 
                case "copy": {
	                	tmp = jQuery("#mytbs_batch_copy_cwa").val().trim();
	                	if ( tmp === "" ) {
	                		errMsg = "Please input a valid intranet ID."; 
	                	} else {
	     					if ( mytbsBatchCheckEmail(tmp)  ) {
	     						newParam = "&copyToCwa="+tmp; 
							} else {
								errMsg="Please input a valid intranet ID.";
							}          	
	                	}
                    break; }               	                        
                case "backup":
                	tmp = jQuery("#mytbs_batch_backup_cwa").val().trim();
                	if ( tmp === "" ) {
                		newParam = "&backupCwa="; 
                	} else {
     					if ( mytbsBatchCheckEmail(tmp)  ) {
     						newParam = "&backupCwa="+tmp; 
						} else {
							errMsg="Please a valid intranet ID.";
						}          	
                	}
                    break;
                case "priority":   	
                	var newPriority = jQuery( jQuery("#mytbs_batch_priority").find("input[name=mytbs_batch_priority_options]:checked").get(0) ).val(); 
                	if ( newPriority === "H") newParam="&ui=H&level=H&offpeak=N"; 
                	if ( newPriority === "M") newParam="&ui=M&level=M&offpeak=N";
                	if ( newPriority === "L") newParam="&ui=L&level=L&offpeak=N";
                	if ( newPriority === "O") newParam="&ui=O&level=L&offpeak=Y";
                	break; 
                case "frequency": 
	                if (domFirstTriggerType === "N") { //below we have a loop to make sure the same trigger, so here we only need to check the first. 
	                    errMsg = "NRT report schedules are NOT eligible for frequency selection.";		
	                    break; 
	                }
	                var selectedFreqType = jQuery("#mytbs_batch_frequency_options").find("input[name='sch_freq']:checked"); 
		            if ( selectedFreqType.length !== 1 ) {
		                errMsg = "you must select 1 frequency type"; //we shall not reach this, in the previous step, we set a default selected one
		                break; 
		            }
	                //----transform data 
		            var freqType = jQuery(selectedFreqType.get(0)).val();
		            var freqDetail = "";
		            var freqOptions = null;
		            switch (freqType) {
		                case "D":
		                    freqDetail = "id_sch_freq_detail_D";
		                    break;
		                case "DOW":
		                    freqDetail = "id_sch_freq_detail_DOW"; //-------------backend will calculate, both this UI and one schedule edit page, will show ONLY one value that end user selects
		                    freqType = "D"; //------------------------------------for the backend processing, changed to D
		                    break;
		                case "W":
		                	freqDetail = "M,Tu,W,Th,F,Sa,Su"; //------------------for the backend processing, also with it we skip the UI value pick-up below
		                	freqType = "D";
		                    break;
		                case "M":
		                    freqDetail = "id_sch_freq_detail_M";
		                    break;
		                case "B":
		                    freqDetail = "id_sch_freq_detail_B";
		                    break;
		                default:
		                    mytbsMessageError("don't know what to do with this, " + freqType); //basically shall not reach this
		                    return false; //exit the function 
		                    break;
		            }
		            //----pick up user selected values
		            if ( freqDetail.indexOf("id_sch_freq_detail") != -1 ){ 
		                var tmpSelected = [];
		                freqOptions = jQuery("#" + freqDetail).find("option:selected");
		                if (freqOptions.length < 1) {
		                    errMsg="you must select at least one in the options"; 
		                    break; //exit the switch
		                }
		                freqOptions.each(function (index, item) {
		                    tmpSelected.push(item.value);
		                });
		                freqDetail = tmpSelected.join(",");
		            }		
		            //----join param 
		            newParam= "&triggerCd=" + domFirstTriggerCd + "&triggerType=" + domFirstTriggerType + "&schedFreq=" + freqType + "&schedFreqDetail=" + freqDetail            
                	break; 
               	case "format":
               		var myselectionObj = jQuery("#mytbs_batch_format_fieldset").find("input[name='mytbs_batch_format_options']:checked").get(0);   
               		var myoptionsObj = null; 
	                if ( myselectionObj === undefined) {
	                	errMsg="Please select one output type.";
	                } else {
	                	myoptionsObj = jQuery(myselectionObj).parent().find("select[name='mytbs_batch_format_runoption']").get(0); 
	                	newParam="&fmtType="+jQuery(myselectionObj).val()+"&fmtOptions="+encodeURIComponent(jQuery(myoptionsObj).val()); 
	                }
                	break; 
                case "email_list":
                	tmp = jQuery("#mytbs_batch_email_list_input").val().trim();
                	if (tmp.length > 250 ) errMsg="The input is too long! Please make it within 250 characters. ";	
		            if ( tmp === "" ) {
						errMsg="Please input email addresses.";
					} else {
	                	var myInput = tmp.split(" "); 
	                	for (var i=0; i < myInput.length; i++) {
	                		if ( myInput[i] !== "") newParam += myInput[i]+" "; 
	                	}		
                		newParam = jQuery.trim(newParam); 
                		jQuery("#mytbs_batch_email_list_input").val(newParam); 
                		newParam = "&addressList="+newParam; 	                				
					}                  	
                	break; 
                case "email_comments":
					tmp = jQuery("#mytbs_batch_email_comments_text").val().trim();
					if (tmp.length > 500 ) errMsg="The input email comments are too long! Please make it within 500 characters. ";			
					if (tmp === "")        errMsg="Please input some text.";
					else                   newParam = "&emailComments="+tmp; 
                    break; 
                case "error_notification": 
                	tmp = jQuery("#mytbs_batch_error_notification").find("input[name='errNotify']:checked");
                	if (tmp.length === 1) 	newParam = "&errNotify="+jQuery(tmp.get(0)).val();
                	else  					errMsg = "Please select whether notify error or not. "; 
                	break;  
                case "dataload": 
                	tmp = jQuery(jQuery("#mytbs_batch_dataload").find("select[name='triggerCode']").get(0)).val();
                	if ( tmp === null) 	errMsg = "Please select a data load.";  
	                else 				newParam = "&triggerCode="+tmp;
                	break;    
                case "take_owner": 
					newParam = "";//no actual user input
                	break;  
                case "toggle_backup": 
					newParam = "";//no actual user input
                	break;    
                case "prompts_comments":
					tmp = jQuery("#mytbs_batch_prompts_comments_text").val().trim();
					if (tmp.length > 500 ) errMsg="The input comments are too long! Please make it within 500 characters. ";			
					if (tmp === "")        errMsg="Please input some text.";
					else                   newParam = "&promptsComments="+tmp; 
                    break;                 	              	               	                        
                default:
                    errMsg="We cannot proceed with this operation="+operation;
                    break;
            }
            if (errMsg !== "") {
                mytbsMessageError(errMsg);
                return false;
            }            
                             
            //------------checking in the looping 
            jQuery("tr.ibm-row-selected").each(function (index, item) {
            	//----data
                postData.push({
                    "tbsRequestId": 	jQuery(item).attr("data-eod-tbsRequestId"),
                    "tbsRptName": 		jQuery(item).attr("data-eod-tbsRptName"),
                    "tbsEmailSubject": 	jQuery(item).attr("data-eod-tbsEmailSubject")
                });
                
                //----the same report
 				if ( operation === "format" || operation === "dataload" ) {
	            	if (domFirstReportId !== jQuery(item).attr("data-eod-tbsRptAccessId")) {
	            		errMsg="This operation is required to perform on the schedules based on the same report.";
	            		return false; 
	            	}
				}
				
				//----the same dataload
 				if ( operation === "frequency" ) {
	            	if (domFirstTriggerCd !== jQuery(item).attr("data-eod-triggerTriggerCd")) {
	            		errMsg="This operation is required to perform on the schedules based on the same data load.";
	            		return false; 
	            	}
				}	
							
                //----status validation
                errMsg = mytbsBatchCheckInLoop(operation, item); 
	            if (errMsg !== "")  return false;    
	                        
                //----owner cannot be backup
                if ( operation === "backup" ) {
					if (jQuery("#mytbs_batch_backup_cwa").val().trim() === jQuery(item).attr("data-eod-tbsCwaId").trim()) {
	                    errMsg = "We cannot set owner as backup owner on email subject (" + decodeURIComponent(jQuery(item).attr("data-eod-tbsEmailSubject"))+").";
	                    return false;
	                }   
                }
                
                //----already set offpeak by admin, so we skip this, it is warned in the UI. --- this is NOT like other throwing err msg
                if ( operation === "priority" ) {
	                if ("A" === jQuery(item).attr("data-eod-tbsOffpeak").trim()) {
	                	postData.pop(); 
	                }                  
                }
                
                //----check if you are the backup
				if ( operation === "take_owner" ) {
	                if (myTbsCwa !== jQuery(item).attr("data-eod-tbsBackupOwner").trim()) {
	                	errMsg="You need to be the schedule backup owner to do so.";
	            		return false; 
	                }                  
                }
                
                //----check we must have a backup so that we can toggle backup and owner 
				if ( operation === "toggle_backup" ) {
					tmp = jQuery(item).attr("data-eod-tbsBackupOwner").trim(); 
	                if ( tmp == undefined || tmp == null || tmp === "" || tmp === "null" ) {
	                	errMsg="this schedule doesn't have a backup owner to toggle with...email subject="+decodeURIComponent(jQuery(item).attr("data-eod-tbsemailsubject"))+"...comments="+decodeURIComponent(jQuery(item).attr("data-eod-promptscomments"));
	            		return false; 
	                }                  
                }                
 
            });
            if (postData.length < 1) { // normally we shall not reach this, this is a defensive checking 
                errMsg="no valid schedules to be sent for processing. ";
                if ( operation === "priority" ) { //currently we only have this possible situation to pop out all elements of the postData.
                	//msg here is per Ian's request.
                	errMsg="None of the selected schedules can be updated because they have been set to off-peak by the BI@IBM System Administrator.";
                }
            }        
            if (errMsg !== "") {
                mytbsMessageError(errMsg);
                return false;
            }
            //------------send the request 
            mytbsBatchCancel(); 
            mytbsBatchAjax(postData, operation, newParam); 
        }
        
        function mytbsBatchCancel(){
			var theOverlayId = IBMCore.common.widget.overlay.getWidget("mytbs_batch_form").getId();
			IBMCore.common.widget.overlay.hide(theOverlayId, true);      
        }      
 
        function mytbsBatchDeleteCancel(){
			var theOverlayId = IBMCore.common.widget.overlay.getWidget("mytbs_confirmation_delete").getId();
			IBMCore.common.widget.overlay.hide(theOverlayId, true);      
        } 
        
        function mytbsBatchDeleteOk(){
        	var postData = [];
            jQuery("tr.ibm-row-selected").each(function (index, item) {
                postData.push({
                    "tbsRequestId": 	jQuery(item).attr("data-eod-tbsRequestId"),
                    "tbsRptName": 		jQuery(item).attr("data-eod-tbsRptName"),
                    "tbsEmailSubject": 	jQuery(item).attr("data-eod-tbsEmailSubject")
                });
            });     	
        	//----done
			mytbsBatchDeleteCancel();  
            mytbsBatchAjax(postData, "delete", "");      
        }        
                    
        function mytbsBatchAjax(postData, operation, newParam){
        	var searchText = jQuery("#mytbs_sch_table_filter").find("input[type='search']").val();   
        	
            jQuery("#mytbs_list2show").empty();
            jQuery("#mytbs_error2show").empty();
            jQuery("#mytbs_list2show").append("<img src='" + myTbsContext + "/images/ajax-loader.gif' />");       	
        
			mytbsMessage(postData.length + " selected schedules, submitted for processing ... <img src='" + myTbsContext + "/images/ajax-loader.gif' />");

            jQuery.ajax({
					headers: { Accept: "application/json; charset=utf-8" },
                    url: myTbsContext + "/action/portal/mycognosschedulelist/batch/"+myTbsCwa+"/"+myTbsUid+"?operation="+operation+newParam+"&timeid="+(new Date()).valueOf(),
                    type: 'POST',
                    data: JSON.stringify(postData),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8"
                })
                .done(function (data) {
					if (data.flag === "success") {
						mytbsMessage("processing is done on the selected schedules. ");					
						mytbsPageDraw(postData, data.schedules, searchText);
						return true; 
					} else { 
						mytbsMessageError(data.msg);  
						if (data.schedules.length > 0) { //---client side issue 
							mytbsPageDraw(postData, data.schedules, searchText);
						} else { //---------------------------server side issue 
							jQuery("#mytbs_list2show").empty();
							jQuery("#mytbs_list2show").append(data.msg);    
						}
						return false; 
					}
                })
                .fail(function (jqXHR, textStatus, errorThrown) {
                    console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
                    console.log("ajax error in loading...textStatus..." + textStatus);
                    console.log("ajax error in loading...errorThrown..." + errorThrown);  
                    mytbsMessageError("ajax error in loading..." + errorThrown);  
              		return false;       
                })
                .always(function () {});
        }  

		function mytbsBatchCheckEmail(email){ //allow dot, underscore, characters, numbers, then after that it is @ibm.com or @**.ibm.com
			if (email.match(/^([_,\-,\.,\w])+@([\.,\w])*ibm.com$/) === null) {
				return false; 
			} else {
 				return true;
			}     
        }    
        
        function mytbsBatchCheckInLoop(operation, item){        	
        		//status checking --- A/I/E is considered normal, we allow updates	
        		//status checking --- S is NOT, end user can select prompts, then submit, then status is A, then we allow updates
        		//status checking --- D is NOT, no single edit, no batch update
                if (operation == "delete" || operation == "backup" ) {
                	//we are good here, delete and backup are NOT real updates to any schedule.  
                	return "";
                } else {
                    var tmp = jQuery(item).attr("data-eod-tbsrequeststatus") + "";
                    if (tmp === "A" || tmp === "I" || tmp === "E") {
                        //we are good here, types of normal status 
                        return "";
                    } else {
                        return "Failed to perform this operation as status of some selected schedules is not valid. ("+tmp+") ";
                    }
                }  
                //default, this item pass the validations
        		return "";   
        }
        
		//=============================================mytbsPage*
       	function mytbsPageAjax() {
            jQuery("#mytbs_list2show").empty();
            jQuery("#mytbs_error2show").empty();
            jQuery("#mytbs_list2show").append("<img src='" + myTbsContext + "/images/ajax-loader.gif' />");
            
            jQuery.get(myTbsContext + "/" +
                    "action/portal/mycognosschedulelist/getAllMyCognosSchedules/" +
                    myTbsCwa + "/" +
                    myTbsUid + "?" +
                    "timeid=" + (new Date()).valueOf() 
			).done(function (data) {
                    mytbsPageDraw(false, data, "");
			}).fail(function (jqXHR, textStatus, errorThrown) {
                    console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
                    console.log("ajax error in loading...textStatus..." + textStatus);
                    console.log("ajax error in loading...errorThrown..." + errorThrown);
                    mytbsMessage("ajax error in loading..." + errorThrown);
                    jQuery("#mytbs_list2show").empty();
                    jQuery("#mytbs_list2show").append("ajax error in loading..." + errorThrown);
			})
		}		
        
		//mytbsNavSelectFolder()                       --> mytbsPageAjax() --> mytbsPageDraw()
		//mytbsPageByDeckPopup() --> mytbsPageByDeckOk --> mytbsPageAjax() --> mytbsPageDraw()
		//mytbsPageByDeckLoadFromUrl()                 --> mytbsPageAjax() --> mytbsPageDraw()
        function mytbsPageDraw(postData, nodeData, searchText) {
            var nodes = eval(nodeData);
			var length = nodes.length;
            var folderId = jQuery("a[role='treeitem'][aria-selected='true']").attr("data-eod-nodeid");
			var scheduleIds = null; //works as a flag below, 'not null' means we need to filter the returned nodes to show only some 
			var newNodes = []; 
			
			//--------filters		
            if (folderId !== "root" && folderId !== "bydeck") {//when not root and not bydeck, it is a folder 
	            	scheduleIds = myTbsFolderItsCsr[""+folderId+""];  
            }
            if (folderId === "bydeck") {//by deck, added in 2018 Jan
            		if (myTbsByDeckDeckId === "") {
            			scheduleIds = []; //probably a wrong deck passed in, after the ajax query, not found, so its schedules should be none too. 
            		} else {
            			scheduleIds = eval(myTbsByDeckCsrIds); //in some particularly situation, returned deck id is valid, but its input schedules could be none, thus an empty array here after eval. 
            		}
            }
	        	if ( scheduleIds !== null ) { // get the provided ids
	        		if (scheduleIds.length > 0 ) {
		            	for (var current in scheduleIds) {
		            		for (var i=0; i < length; i++) {
		            			if (nodes[i]["tbsRequestId"] === scheduleIds[current]) newNodes.push(nodes[i]); 
		            		}
		            	}	        			
	        		}
	        		nodes = newNodes; //if length is 0 here, then nodes is assigned to [], so nothing is displayed
	        	}   
	        	
            //--------create the page
            if (length > 0) {
                mytbsPageDrawTableContainer();
                for (var i = 0; i < nodes.length; i++) mytbsPageDrawTableRow(nodes[i]);
	            mytbsPageDrawTableInit();         
	            mytbsPageDrawTableHideHiddenRows(); 
            } else {
                jQuery("#mytbs_error2show").empty();
                jQuery("#mytbs_list2show").empty();
                jQuery("#mytbs_list2show").append("<p>You do not have any Cognos report schedules in this folder. </p>");
            }
            
            //--------show the remembered 
            if ( Object.prototype.toString.call(postData) === '[object Array]' ) {
            	//1st----restore search----this changes the DOM
 				if (searchText !== "")  		jQuery("#mytbs_sch_table_filter").find("input[type='search']").val(searchText).keyup();            
            	//2nd----restore selection 
            	for (var selected in postData) 	jQuery("#mytbs_"+postData[selected]["tbsRequestId"]+"_checkbox").click(); 
            }
        }
        
        function mytbsPageDrawTableRow(sch) {
            var tmp = "";
            for (var item in sch) {
                tmp = tmp + " data-eod-" + item + "='" + escape(sch[item]) + "' ";
            }
            jQuery("#mytbs_sch_tbody").append(
                "<tr id='mytbs_" + sch["tbsRequestId"] + "' " + tmp + " >" +
                "<td scope='row'> <span class='ibm-checkbox-wrapper'>  <input id='mytbs_" + sch["tbsRequestId"] +
                "_checkbox' type='checkbox' class='ibm-styled-checkbox'/> <label for='mytbs_" + sch["tbsRequestId"] +
                "_checkbox' ><span class='ibm-access'>Select One</span></label> </span> </td>" +
                "<td><a href=" + myTbsContext + "/action/portal/schedulePanel/openCognosSchedulePanel/" + sch["tbsRequestId"] +"/" + sch["tbsDomainKey"] 
                	+ " target='_blank' "
                	+ " >" 
                	+ sch["tbsRptName"] 
                	+ "</a></td>" +
                "<td>" + sch["tbsEmailSubject"] + "</td>" +
                "<td>" + sch["tbsEmailAddress"] + "</td>" +                
                "<td>" + sch["promptsComments"] + "</td>" +
                "<td>" + mytbsFormatScheduleFrequency(sch) + "</td>" +
                "<td>" + mytbsFormatTrigger(sch) + "</td>" +
                "<td>" + sch["tbsExpirationDate"] + "</td>" +
                "<td>" + mytbsFormatReqStatus(sch) + "</td>" +
                "<td>" + sch["tbsSendMail"] + "</td>" +
                "<td>" + mytbsFormatPriority(sch) + "</td>" +
                "<td>" + mytbsFormatOwner(sch) + "</td>" +
                "<td>" + mytbsFormatRunStatus(sch) + "</td>" +
                "<td>" + mytbsFormatRunTime(sch) + "</td>" +
                "</tr>"
            );
        }

        function mytbsPageDrawTableContainer() {
            jQuery("#mytbs_error2show").empty();
            jQuery("#mytbs_list2show").empty();
			//---table
            jQuery("#mytbs_list2show").append("<table class='ibm-data-table ibm-altrows ibm-small' id='mytbs_sch_table'></table>");
            //---thead
            var tmp ="<thead><tr>";
            var tmp = tmp + "<th scope='col' class='eod-tbs-nosort' ><span class='ibm-checkbox-wrapper'><input id='mytbs_sch_checkbox' type='checkbox' class='ibm-styled-checkbox'/><label for='mytbs_sch_checkbox' ><span class='ibm-access'>Select all</span></label></span> </th>";
            for (var i=1; i<myTbsTableHeaders.length; i++)  tmp = tmp + "<th scope='col'>"+myTbsTableHeaders[i]+"</th>";
            tmp = tmp + "</tr></thead>";
            jQuery("#mytbs_sch_table").append(tmp); 
			//---tbody 
            jQuery("#mytbs_sch_table").append("<tbody id='mytbs_sch_tbody'></tbody>");
        }

        function mytbsPageDrawTableInit() {
        		//---set defaults 
	        var myTbsDtSettings = {
	        		destroy: true, 		// allow re-initiate the table
	            colReorder: false, 	// true | false (default)	// Let the user reorder columns (not persistent) 
	            info: false,			// true | false (default)	// Shows "Showing 1-10" texts 
	            ordering: true, 		// true | false (default)	// Enables sorting 
	            paging: false, 		// true | false (default)	// Enables pagination 
	            scrollaxis: true, 	// x 						// Allows horizontal scroll 
	            searching: true 		// true | false (default)	// Enables text filtering	
	        };        	
        	myTbsDtSettings.order		= eval(Cookies.get('eodTbsListColSort'));        
        	var myOrderableFalse  		= '{"targets": [0], "orderable": false}';  
        	var myVisibleFalse   		= '{"targets": '+Cookies.get('eodTbsListColHidden')+', 	"visible": 		false}';
        	var mySearchableFalse  		= '{"targets": '+Cookies.get('eodTbsListColHidden')+', 	"searchable": 	false}';
        	var myVisibleTrue   		= '{"targets": "_all", 	"visible": 		true}'; //make sure the rest shows up
        	var mySearchableTrue  		= '{"targets": "_all", 	"searchable": 	true}';        	
        	myTbsDtSettings.columnDefs 	= [JSON.parse(myOrderableFalse), JSON.parse(myVisibleFalse), JSON.parse(mySearchableFalse), JSON.parse(myVisibleTrue), JSON.parse(mySearchableTrue)];      	
        	//---init table          
        	mytbsMenuMakesureLeftNav(); //TODO right now this is what we have to do too. 
			var table = jQuery("#mytbs_sch_table").DataTable(myTbsDtSettings);
			jQuery("#mytbs_sch_table").tablesrowselector();
            jQuery('#mytbs_sch_table').on('order.dt', function () {
                var order = JSON.stringify(table.order());
                Cookies.set('eodTbsListColSort', order, myTbsCookieSettings);
            });
        }

        function mytbsPageDrawTableHideHiddenRows() {
            if ( Object.prototype.toString.call(myTbsHiddenRows) === '[object Array]' ) {
	    			jQuery.each(myTbsHiddenRows, function(index,element) {
	    				jQuery("#mytbs_"+element).hide(); 
	    			});  
            }
        }
        
        function mytbsPageShowHideUnSelected() {
			if (jQuery("#mytbs_sch_table").length === 1 && jQuery("#mytbs_sch_tbody").length === 1 ) {	
				var domRows  = jQuery("#mytbs_sch_table").DataTable().rows().nodes().to$();   
				//=====================================================toggle 
				var rowSelected  = jQuery("#mytbs_sch_tbody > tr.ibm-row-selected:visible");	
				var rowShowed    = jQuery("#mytbs_sch_tbody > tr:visible");
				if (rowSelected.length < 1 || rowSelected.length === rowShowed.length) {
					//-----------If ammong showed ZERO selected,  then show every single row
					//-----------If all showed are selected,      then show every single row					
					jQuery.each(domRows, function(index,element) {   jQuery(element).show();   }); 	
					myTbsHiddenRows = []; //clear the count of hidden rows -- same when select folder/deck
				} else {
					//----------If there are un-selected, hide the un-selected
					rowShowed.each(function(){    
						if (!jQuery(this).hasClass("ibm-row-selected")) {  
							jQuery(this).hide();  
							myTbsHiddenRows.push(jQuery(this).attr("data-eod-tbsRequestId")); //save the hidden rows
						}    
					}) 
				}
				jQuery("#mytbs_sch_table_filter").find("input[type='search']").click(); 
				//=====================================================popup info 
				var domTrHiddenNum  = 0;  
				var domTrVisibleNum = 0;  	
				jQuery.each(domRows, function(index,element) {
					if (jQuery(element).css('display')==='none') domTrHiddenNum  += 1; 
					else                                         domTrVisibleNum += 1; 
				}); 
				var domTrShowedNum   = jQuery("#mytbs_sch_tbody > tr:visible").length;
				var domTrSelectedNum = jQuery("#mytbs_sch_tbody > tr.ibm-row-selected:visible").length;		
				var domSearchText = jQuery("#mytbs_sch_table_filter").find("input[type='search']").val(); 
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
				console.log(message); //to console for now, mytbsMessage(message);
			} else {
				console.log("no rows to work on");
			}
        }

        function mytbsPageColumnsCancel(){
			var theOverlayId = IBMCore.common.widget.overlay.getWidget("mytbs_showhide_columns").getId();
			IBMCore.common.widget.overlay.hide(theOverlayId, true);      
        } 
        
        function mytbsPageColumnsOk(){      
			//---save into cookies
			var toBeSaved = jQuery("#mytbs_showhide_columns_table").find("input[data-eod-colsetup='hide']:checked"); 
			var tmp = "[";
			for (var i=0; i<toBeSaved.length; i++) {
				tmp += jQuery(toBeSaved[i]).attr("data-eod-colnum")+","; 
			}
			if (toBeSaved.length >0)           tmp = tmp.substring(0,tmp.length-1) + "]"; 
			else                               tmp = "[]";
			Cookies.set('eodTbsListColHidden', tmp, myTbsCookieSettings);		
			//---redo current page & close the popup
			var searchText = jQuery("#mytbs_sch_table_filter").find("input[type='search']").val();  
			jQuery('#mytbs_sch_table').DataTable().destroy(); 
			mytbsPageDrawTableInit(); 
			mytbsPageColumnsCancel();  
			if (searchText !== "")  jQuery("#mytbs_sch_table_filter").find("input[type='search']").val(searchText).keyup();     
        }  
        
        function mytbsPageColumnsPopup(){
       		//-------draw table
       		jQuery("#mytbs_showhide_columns_table").empty(); 
        		jQuery("#mytbs_showhide_columns_table").append("<thead><tr><th>#</th><th>name</th><th>visible</th></tr></thead>"); 
        		jQuery("#mytbs_showhide_columns_table").append("<tbody id='mytbs_showhide_columns_tbody'></tbody>"); 
        		var temp=""; 
        		for (var i=0; i<myTbsTableHeaders.length; i++) {
	        		//---reset  
	        		temp ="<tr>"; 
	        		//---1st td
	        		temp+="<td>"+i+"&nbsp;&nbsp;&nbsp;&nbsp;</td>";
	        		//---2nd td
	        		temp+="<td>"+myTbsTableHeaders[i]+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>"; 
	        		//---3rd td
	        		temp+='<td><span class="ibm-input-group">';
					temp+='<span class="ibm-radio-wrapper">';
					temp+='<input class="ibm-styled-radio" type="radio" value="Y" id="mytbs_view_columns_'+i+'_Y" name="mytbs_view_columns_'+i+'" data-eod-colsetup="show" checked> ';
					temp+='<label class="ibm-field-label" for="mytbs_view_columns_'+i+'_Y">Yes</label>';
					temp+='</span>&nbsp;&nbsp;&nbsp;&nbsp;';
					temp+='<span class="ibm-radio-wrapper">';
					temp+='<input class="ibm-styled-radio" type="radio" value="N" id="mytbs_view_columns_'+i+'_N" name="mytbs_view_columns_'+i+'" data-eod-colsetup="hide" data-eod-colnum='+i+' >'; 
					temp+='<label class="ibm-field-label" for="mytbs_view_columns_'+i+'_N">No</label>';
					temp+='</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
					temp+='</span></td>';
	        		//---end
	        		temp+="</tr>";
	        		//---add into table 
	        		jQuery("#mytbs_showhide_columns_tbody").append(temp); 
	        	}
	        	//-------special format
	        	jQuery("#mytbs_showhide_columns_table").find("th").css({"padding":"0px"});
	        	jQuery("#mytbs_showhide_columns_table").find("td").css({"padding":"0px"});
	        	//-------disable
	        	jQuery("#mytbs_view_columns_0_Y").click();
	        	jQuery("#mytbs_view_columns_0_Y").prop("disabled",true);
	        	jQuery("#mytbs_view_columns_0_N").prop("disabled",true);
	        	jQuery("#mytbs_view_columns_1_Y").click();
	        	jQuery("#mytbs_view_columns_1_Y").prop("disabled",true);
	        	jQuery("#mytbs_view_columns_1_N").prop("disabled",true);       	  	
	        	jQuery("#mytbs_view_columns_12_Y").click();
	        	jQuery("#mytbs_view_columns_12_Y").prop("disabled",true);
	        	jQuery("#mytbs_view_columns_12_N").prop("disabled",true);
	        	jQuery("#mytbs_view_columns_13_Y").click();
	        	jQuery("#mytbs_view_columns_13_Y").prop("disabled",true);
	        	jQuery("#mytbs_view_columns_13_N").prop("disabled",true);
	        	//-------read from cookie 
	        	var hiddenColumns = eval( Cookies.get('eodTbsListColHidden') ); 
	        	for (var i=0; i<hiddenColumns.length; i++) {
	        		jQuery("#mytbs_view_columns_"+hiddenColumns[i]+"_N").click(); 
	        	}
	        	//-------finally show it 
	        	IBMCore.common.widget.overlay.show("mytbs_showhide_columns");       	    	
        }       
        
        function mytbsPageByDeckPopup(){
        		jQuery("#mytbs_folder_bydeck").attr("aria-selected","false"); //it's just a click, after click OK button, we switch to this link, as page is refreshed then 
	        var myTbsDtSettings = {
					destroy: true, 		// Allow re-initiate the table
		            colReorder: false, 	// Let the user reorder columns (not persistent) 
		            info: true,			// Shows "Showing 1-10" texts 
		            ordering: true, 		// Enables sorting 
		            paging: true, 		// Enables pagination 
		            scrollaxis: true, 	// Allows horizontal scroll 
		            searching: true 		// Enables text filtering	
		        };        	       
	        var myOrderableFalse  		= '{"targets": [0], "orderable": false}'; 
	        	myTbsDtSettings.columnDefs 	= [JSON.parse(myOrderableFalse)]; 
	        	myTbsDtSettings.order 		= [[ 1, "desc" ]]; 
        		//-------empty table
			jQuery("#mytbs_bydeck_table").empty(); 
			jQuery("#mytbs_bydeck_table").append("<img src='" + myTbsContext + "/images/ajax-loader.gif' />");
			//-------get the list
            jQuery.get(myTbsContext + "/action/portal/autodecklist/getAutodeckListAndAssociatedSchedules/"+myTbsCwa+"/"+myTbsUid+"?timeid=" + (new Date()).valueOf() )
            .done(function (data) {
            		var csrIds = []; 
           		var selectList = "<thead><tr><th> </th><th>Deck ID</th><th>e-Mail Subject</th><th>e-Mail Comments</th><th>Frequency</th><th>Expiry</th><th>Status</th><th>Type</th><th>Owner</th></tr></thead>"; 
           		selectList += "<tbody id='mytbs_bydeck_tbody'>";              	
				for (var i = 0; i < data.length; i++) {
					//----get csr ids 
					csrIds = [] ; 
					jQuery.each(data[i].inputRequests, function(index, value) {
						csrIds.push(value.id.requestId); 
					});
					//----create deck row HTMl 
					selectList += "<tr>"; 
					selectList += "<td><span class='ibm-radio-wrapper'> <input class='ibm-styled-radio' type='radio' id='mytbs_deck_" + data[i].autodeck.convertId + "' value='"+ data[i].autodeck.convertId +"' data-eod-csr='"+JSON.stringify(csrIds)+"' name='mytbs_bydeck_ids'>  <label class='ibm-field-label' for='mytbs_deck_" + data[i].autodeck.convertId + "'></label> </span> </td>"; 
					selectList += "<td>" + data[i].autodeck.convertId + " </td>"; 
					selectList += "<td>" + data[i].autodeck.emailSubject + " </td>"; 
					selectList += "<td>" + data[i].autodeck.emailComments + " </td>"; 
					selectList += "<td>" + data[i].schedFreqAndDetail + " </td>"; 
					selectList += "<td>" + data[i].expirationDate_Str + " </td>"; 
					selectList += "<td>" + myTbsWordExpansionStatus[data[i].autodeck.convertStatus] + " </td>"; 
					selectList += "<td>" + data[i].typeName + " </td>"; 
					selectList += "<td>" + data[i].ownerOrBackup + " </td>"; 
					selectList += "</tr>"; 
				}
				selectList += "</tbody>"; 
				jQuery("#mytbs_bydeck_table").empty(); 
                jQuery("#mytbs_bydeck_table").append(selectList); 
                jQuery("#mytbs_bydeck_table").DataTable(myTbsDtSettings);
                
                if (myTbsByDeckDeckId !== "") {
                		var selected = jQuery("#mytbs_deck_"+myTbsByDeckDeckId); 
                		if (selected.length > 0) {
                			selected.click(); //select the previously checked deck 
                			if (myTbsByDeckFirstTimeLoadedFromUrl === true) { //if the deck id is passed in from URL for the 1st time, we highlight it for end users 
                				jQuery("#mytbs_bydeck_table_filter").find("input[type='search']").val(myTbsByDeckDeckId).keyup();
                				myTbsByDeckFirstTimeLoadedFromUrl = false; //not going to do this for the 2nd time
                			}
                		}
                }
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
                console.log("ajax error in loading...textStatus..." + textStatus);
                console.log("ajax error in loading...errorThrown..." + errorThrown);
                mytbsMessageError("ajax error in loading..." + errorThrown);
            })  
			//-------show the overlay
            IBMCore.common.widget.overlay.show("mytbs_bydeck");  
        }

        function mytbsPageByDeckCancel(){
			var theOverlayId = IBMCore.common.widget.overlay.getWidget("mytbs_bydeck").getId();
			IBMCore.common.widget.overlay.hide(theOverlayId, true); 	
        } 
        
        function mytbsPageByDeckOk(){      
			//---check the selection 
 			var selected=jQuery("#mytbs_bydeck").find("input[type=radio][name=mytbs_bydeck_ids]:checked"); 
			if (selected.length !== 1) {
				mytbsMessage("Please select 1 deck.");
				return null; 
			}
			//---save ids on the page
			var checked = jQuery(selected.get(0));
 			myTbsByDeckDeckId=checked.attr("value"); 
 			myTbsByDeckCsrIds=checked.attr("data-eod-csr");
            jQuery("a[name='eod-folder']").removeAttr("aria-selected");
            jQuery("#mytbs_folder_bydeck").attr("aria-selected", "true");  			
 			myTbsHiddenRows = []; //clear the count of hidden rows -- same when select folder/deck
			//---close the popup 
			var theOverlayId = IBMCore.common.widget.overlay.getWidget("mytbs_bydeck").getId();
			IBMCore.common.widget.overlay.hide(theOverlayId, true); 
			//---redraw the page 
			mytbsPageAjax();
        } 
        
        function mytbsPageByDeckLoadFromUrl(deckId){  
            jQuery("#mytbs_list2show").empty();
            jQuery("#mytbs_list2show").append("<img src='" + myTbsContext + "/images/ajax-loader.gif' />");
            
        		if (typeof(deckId) == "undefined" || jQuery.trim(deckId) == "") {
        			mytbsNavSelectFolder(jQuery("#mytbs_root_folder"));//show the default page
        		} else {
	                jQuery.get(myTbsContext + "/action/portal/autodecklist/getThedeckAndItsSchedules/"+myTbsCwa+"/"+myTbsUid+"?timeid=" + (new Date()).valueOf()+"&deckId="+deckId )
                    .done(function (data) {
                        if (data.messages === "NotFound") { //this API it always has a MESSAGES property 
							myTbsByDeckDeckId=""; 
							myTbsByDeckCsrIds="";   
							myTbsByDeckFirstTimeLoadedFromUrl = false; 
                        } else {
		    					var csrIds = [] ; 
		    					jQuery.each(data.inputRequests, function(index, value) {
		    						csrIds.push(value.id.requestId); 
		    					});
							myTbsByDeckDeckId=data.autodeck.convertId; 
							myTbsByDeckCsrIds=JSON.stringify(csrIds);
							myTbsByDeckFirstTimeLoadedFromUrl = true; 
                        }

                        jQuery("#mytbs_folder_bydeck").attr("aria-selected", "true"); 
            				mytbsPageAjax(); 
                    })
                    .fail(function (jqXHR, textStatus, errorThrown) {
                        console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
                        console.log("ajax error in loading...textStatus..." + textStatus);
                        console.log("ajax error in loading...errorThrown..." + errorThrown);
                        mytbsMessageError("ajax error in loading..." + errorThrown);
                    })          			
        		}
        		
        }
        //=============================================init 
        jQuery(document).ready(function () {
        	//------set defaults 
            var myTbs_table_sorting = Cookies.get('eodTbsListColSort');
            if (myTbs_table_sorting === undefined) { 
                myTbs_table_sorting = '[[1,"asc"]]';
                Cookies.set('eodTbsListColSort', myTbs_table_sorting, myTbsCookieSettings);
                console.log("initializing column sorting in cookie " + myTbs_table_sorting);
            } 
			var operation = Cookies.get('eodTbsListBulkUpdateSelect');
			if (operation === undefined) {  
				operation = "backup";
				Cookies.set('eodTbsListBulkUpdateSelect', operation, myTbsCookieSettings);
				console.log("initializing bulk update selection in cookie " + operation);
			} 
			var myColVisible = Cookies.get('eodTbsListColHidden');
			if (myColVisible === undefined) {  
				myColVisible = "[]";  
				Cookies.set('eodTbsListColHidden', myColVisible, myTbsCookieSettings);
				console.log("initializing column hidden in cookie " + myColVisible);
			} 			
					
			//------normal work to do
			mytbsNavLoadFolders();
            mytbsMenuFixed("eod-menubar-after-ibm-sitenav");
            mytbsMenuButtonBinding();
            var params = (window.location.search.split('?')[1] || '').split('&');
            if (params[0].length > 7 && params[0].slice(0,7) === ("deckId=") ) {
				mytbsPageByDeckLoadFromUrl(params[0].slice(7,params[0].length)); 
            } else {
            		mytbsNavSelectFolder(jQuery("#mytbs_root_folder"));//show the default page
            }
            
        });
    </script>
    <!-- ================================================================= custom page doc ready JavaScript codes end -->
</body>

</html>