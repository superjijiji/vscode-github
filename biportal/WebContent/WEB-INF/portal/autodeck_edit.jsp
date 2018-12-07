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
<title>BI@IBM | Autodeck edit panel</title>
<jsp:include page="/WEB-INF/include/v18include_min.jsp"></jsp:include>
<link href="//1.www.s81c.com/common/v18/css/forms.css" rel="stylesheet">
<style type="text/css"> 
table.dataTable thead .sorting {
    background: rgba(0, 0, 0, 0);
}
table.dataTable tbody tr.selected {
    background-color:white;
}
</style>
<script src="//1.www.s81c.com/common/v18/js/forms.js"></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath() + "/javascript/autodeck_edit.form.js" %>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath() + "/javascript/ctable.js" %>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath() + "/javascript/autodeck_edit.js" %>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath() + "/javascript/autodeck_edit.save.js" %>" ></script>
<script type="text/javascript" src="<%=path%>/javascript/jquery.form.js"></script>
<script type="text/javascript">

var myTbsContext = "<%=request.getContextPath()%>";
var preview_url = "<%=request.getContextPath()%>";
	var backup_id = "${cwa_id}";
	
	 var selectedCSR;
    var uploadedRequestsList;
    function openRDP(url){
	window.open(url,'_blank','resizable=yes,toolbar=no,menubar=no,scrollbars=yes'+",ScreenX=0,ScreenY=0,top=0,left=0,width=" + screen.availWidth + ",height="+screen.availHeight);
		
	}
	  function openUnsubAutodeck(){
	  //http://localhost:9080/transform/biportal/action/portal/autodeck/unsubmanage/unsubscribePanel/2017052917035100086314986412/A
	  var deckid=deck_id;
	  var urlUnsDeck='/transform/biportal/action/portal/autodeck/unsubmanage/unsubscribePanel/'+deckid+'/A';
	window.open(urlUnsDeck,'_blank','resizable=yes,toolbar=no,menubar=no,scrollbars=yes'+",ScreenX=0,ScreenY=0,top=0,left=0,width=" + screen.availWidth + ",height="+screen.availHeight);
		
	}
	function showLoading() {
  	jQuery("#csp_loading_id").css({ 'display': 'block', 'opacity': '0.8' });                
    jQuery("#csp_ajax_loding_id").css({ 'display':'block','opacity':'0'});
  	jQuery("#csp_ajax_loding_id").animate({ 'margin-top': '300px', 'opacity': '1' }, 200);  
}
function  importshow(){
IBMCore.common.widget.overlay.show('show_import_config_panel');
}
function hiddLoading() {                 
	jQuery("#csp_loading_id").css({ 'display':'none'}); 
	jQuery("#csp_ajax_loding_id").css({ 'display':'none','opacity':'0'});            
}
var calledRequest=false;
function MergeScheduleDateM(obj){
//clear value of the daily when click M
jQuery('#id_D_sched_freq_detail').val("").trigger("change");

}
function MergeScheduleDateD(obj){
//clear value of the Monhly when click D
	jQuery('#id_M_sched_freq_detail').val("").trigger("change");

}
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
				table_2_content.row.add(dataSet);
				
		
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
				table_2_content.row.add(dataSet).draw();
				
				
        	}

        }
        table_2_content.draw();
    }
 function getUploads() {
		  var table_3_content = jQuery("#table_3").DataTable();
		  timeid = (new Date()).valueOf();
		  
			jQuery.ajax({
		        type: 'GET', url: '<%=path%>/action/portal/autodeck/getAutofileUploads/' + cwa_id + '/' + uid + '?timeid=' + timeid,async:true,
		        success: function (data) {
		        console.log("get data from rest api getAutofileUploads()");
		        
		        uploadedRequestsList = data;
		        
		         for (var i = 0; i < data.length; i++) {
		        	 var uploadedRequest = data[i];
		        	 
		        	 var upload_col_0 = "<a href=" + myTbsContext + "/action/portal/autodeck/xlsmanage/getXLSManagePage/"
									+ " target='_blank'>"
									+ uploadedRequest.fileName;
									+ "</a>";
					
					var upload_col_1 = uploadedRequest.fileDesc;
					var upload_col_2 = uploadListFormatDate(uploadedRequest.expirationDate);
					var upload_col_3 = uploadedRequest.status;
					var upload_col_4 = "<a href=\"javascript:void(0)\" onclick=\"addToSelect(this,'"+uploadedRequest.requestId+"','u')\">Add</a>";
					
					var dataSet = [upload_col_0, upload_col_1, upload_col_2, upload_col_3, upload_col_4]
					table_3_content.row.add(dataSet).draw();
					jQuery(table_3_content.row(i).node()).attr('id', 'id_uploadedRequest_' + uploadedRequest.requestId);
		         }

	      	  	},
		        error: function (data) {
		            alert('getAutofileUploads - ajax return error!!!')
		        }
		    });
	  }
  function getScheduledRequestsList() {
		  //new
		  showLoading();
		  var table_2_content = jQuery("#table_2").DataTable();
		  timeid = (new Date()).valueOf();

			jQuery.ajax({
		        type: 'GET', url: '<%=path%>/action/portal/autodeck/loadScheduledRequestsList/' + cwa_id + '/' + backup_id + '/' + uid + '?timeid=' + timeid,async:true,
		        success: function (data) {
		        	table_2_content.rows().remove();
		        console.log("get data from rest api loadScheduledRequestsList()");
		        
		        selectedCSR = data.selectedCSR;
		        
			         for (var i = 0; i < selectedCSR.length; i++) {
			        	 
			        	var selectedRequest = selectedCSR[i];
			        	
			        	var input_col_0 = "<a href=" + myTbsContext + "/action/portal/schedulePanel/openCognosSchedulePanel/"
	        							+ selectedRequest.requestId + "/" + selectedRequest.tbsDomainKey
	        							+ " target='_blank'>"
	        							+ selectedRequest.rptName;
	        							+ "</a>";
			        	var input_col_1 = selectedRequest.emailSubject;
			        	var freq = selectedRequest.schedFreq;
	    		var freqDtl = selectedRequest.freqDetail;

				var triggerType =selectedRequest.triggerType;
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
					var flag=freqDtl.indexOf(',') ;
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
                        var input_col_7 = selectedRequest.comments;;
                        var input_col_8 = "<a href=\"javascript:void(0)\" onclick=\"addToSelect(this,'"+selectedRequest.requestId+"'),'c'\">Add</a>";

                        var dataSet = [input_col_0, input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7, input_col_8]
                        table_2_content.row.add(dataSet);
                        
                       // jQuery(table_2_content.row(i).node()).attr('id', 'id_selectedCSR_' + selectedRequest.requestId);
	
			        }
			      table_2_content.draw();    
hiddLoading();

	      	  	},
		        error: function (data) {
		            alert('getScheduledRequestsList - ajax return error!!!');
		            hiddLoading();
		        }
		    });

		  }
	  
	var cwa_id = '${requestScope.cwa_id}';
	var uid = '${requestScope.uid}';
    var deck_id = '${requestScope.deck_id}';
  
     var autodeckPanel = new AutodeckPanel();
     
     var deck_app_url='<%=path%>/action/portal/autodeck/edit/';
       function loadDeckbyId(deck_id) {
   
            var timeid = (new Date()).valueOf();
            jQuery("#auodeck_main").empty();
            jQuery.ajax({
                type: 'GET', url: '<%=path%>/action/portal/autodeck/edit/loaddeck/' + cwa_id + '/' + uid + '/' + deck_id + '?timeid=' + timeid,async:true,
                success: function (data) {
                console.log("Weclome to BIIBM autodeck panel");
                console.log(data);
                    if(data.errorMessage!=null){
                    alert(data.errorMessage);
                    
                    }else{
                    if( autodeckPanel.loadDeck(data)){
                    hiddLoading();
                      
                          autodeckPanel.loadDeck(data);
                          autodeckPanel.displayIntro();
                          autodeckPanel.loadTabs();
                   }else{
                   
                    alert("Sorry，you might not have the permission to access this deck");
                   
                   }       
                  }        
                    
                  //  jQuery("#auodeck_main").html(autodeckPanel);
                },
                error: function (data) {
                    alert('Load deck - ajax return error!!!')
                }
            });
        }
	jQuery(document).ready(function() {
      showLoading();
      loadDeckbyId(deck_id);

	});
</script>


</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
<%
/////////////////////////////////////////////////////////////////
String Request_ID_Mouseover = "Unique identifier for the Cognos Schedule Request to be used. Note that '00000000' will cause a blank slide to be produced in a PowerPoint Autodeck.";
String Request_ID_Mouseover_xls = "Unique identifier for the Cognos Schedule Request to be used.";
String Worksheet_Mouseover = "Name of the worksheet to be used as input from the specfied Cognos Schedule Request output file.";
String Range_Mouseover = "Selected range of data to be used from the specfied worksheet.";
String Hide_rows_Mouseover = "Individual rows (comma separated) or ranges of rows (start #:end #) to be excluded in the generated Autodeck page.";
String Hide_columns_Mouseover = "Individual columns (comma separated) or ranges of columns (start column:end column) to be excluded in the generated Autodeck page.";
String Hide_text_Mouseover = "Use this field (max 128 characters) to add a chart title (i.e. headline) to your chosen slide.";
String AutoSize_rows_Mouseover = "Specify 'YES' to set rows to their maximum height.";
String AutoSize_columns_Mouseover = "Specify 'YES' to set columns to their maximum width.";
String Custom_column_width_Mouseover = "Specify the column identifier, its requested width and horizontal cell alignment in this field using the format 'identifier (or range), width, alignment', separating each set of parameters with a semicolon.  The alignment parameter (L - Left, C- Central, R -Right) is optional and, if not specified, will use the default alignment setting (e.g. A:D,5.2,L;G,19.3,R;H,20).";
String Custom_row_height_Mouseover = "Specify the row identifier, its requested height and vertical cell alignment in the field, using the format 'identifier (or range), height, alignment', separating each set of parameters with a semicolon. The alignment parameter (T - Top, M - Middle, B - Bottom) is optional and , if not specified, will use the default alignment setting (e.g. 1:5,5.2,T;10,19.3,B;12,14).";
String Wrap_text_in_rows_Mouseover = "Use this field to request that the corresponding content spans multiple rows in the generated Autodeck. Select the candidate rows by entering the row numbers separated by commas or in range format (e.g. 1,5,7,9:15).";
String Display_gridline_Mouseover = "Show table gridlines on your output by setting this field to YES.";
String Slide_No_Mouseover = "Specify the number of the slide this content is to appear on in the generated Autodeck.  Using the same slide number for multiple Request ID ranges will cause those outputs to be appended to the same slide.";
String New_Worksheet_Mouseover = "The name of the worksheet to be used for this content in an Excel format Autodeck. Using the same 'New Worksheet' name for multiple Request ID ranges will cause those outputs to be appended to the same worksheet.";

%>
<div class="ibm-columns">
			<div class="ibm-card">
				
	
				<div id="to_hide" class="ibm-card__content">
					<strong class="ibm-h4">Autodeck edit panel</strong>
					<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
						<hr>
					</div>
					<div class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" id="show_import_config_panel">
					     <form id="autodeck_upload_form" class="ibm-row-form" method="post" action="" enctype="multipart/form-data">
                                <input type="hidden" id="output_type" name="output_type" value="2" />
                               
                               
                                            <span>								
								<input id="inputXLSFileId" type="file"  name="file" accept="application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />																	
							</span>
                              
                                            <p class="ibm-btn-row ibm-button-link">
                                                <input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="uploadButtonId" value="Submit" onClick="uploadFile();return 0;" />
                                                <span class="ibm-sep">&nbsp;</span>
                                                <input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="reset" name="Cancel" value="Reset" />
                                            </p>
                                 
                            </form> 
					</div>
						
					<table id="autodeck_intro_general" cellspacing="0" cellpadding="0" border="0" width="100%">
						<tbody>
							<tr>
								<td style="width: 85%;">
									<strong id="autodeck_intro_id" class="ibm-h4">Deck Id : <span id="deck_id"></span></strong>
									<br/><br/>
									
					<strong id="autodeck_intro_name" class="ibm-h4"><span id="deck_name"></span></strong> 				
						<strong id="autodeck_intro_owner" class="ibm-h4">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Owner : <span id="deck_owner"></span></strong>			
									
						
					</div>
					<br/>
					<br/>
					<br/>
									<strong class="ibm-h4">Step by step instructions for scheduling an Autodeck</strong>
									<br/><br/>
								</td>
								<td rowspan="2">
									
									<p class="ibm-ind-link" style="margin:0px; padding:0px;" >
									<a class="ibm-popup-link" style="margin-bottom: 1px;margin-bottom: 1px;padding-bottom: 1px;padding-top: 1px;"  onkeypress="openHelp(); return false;" onclick="openHelp(); return false;" href="#">
									Help for this page
									</a>
									</p>
									<span id="autodeck_span_addFav_id">

									</span>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div id="csp_loading_id" style="position:fixed;top:0;right:0;bottom:0;left:0;z-index:998;width:100%;height:100%;_padding:0 20px 0 0;background:#f6f4f5;display:none;"></div>
					<div id="csp_ajax_loding_id" style="position:fixed;top:0;left:50%;z-index:9999;opacity:0;filter:alpha(opacity=0);margin-left:-80px;">
 				<!-- 	<p class="ibm-h2"><span class="ibm-spinner"></span>Loading deck data...</p> -->
 				<div ><span>processing...</span><img src='<%=request.getContextPath()%>/images/ajax-loader.gif' /></div> 
					</div>
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
			</div>			
						<div id="autodeck_content_id">
							<p style="padding-top: 0px;">Note that all required fields are marked with an asterisk (<span class="ibm-required">*</span>).   </p>
							
							<table id="autodeck_1stline_id">
								<tr id="autodeck_1stline_tr_id">
									<td style="padding:10px"><input type="button" id="autodeck_savebutton" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick=" submitForm()" value="Submit" /></td>									
									<td style="padding:10px"></td>
								</tr>
							</table>
							
						</div>
							

						<div id ="autodeck_tab_id" data-widget="dyntabs" class="ibm-graphic-tabs">
							<!-- Tabs here: -->
						    <div class="ibm-tab-section">
						        <ul class="ibm-tabs" role="tablist">
						            <li><a aria-selected="true" role="tab"  id="deck_tab_request" href="#autodeck_requests_id">Edit requests</a></li>
						            <li><a role="tab" id="deck_tab_output"  href="#autodeck_outputformat_id">Output format</a></li>
						            <li><a role="tab" id="deck_tab_email"  href="#autodeck_emailinformation_id">e-Mail information</a></li>
						            <li><a role="tab" id="deck_tab_schedule" href="#autodeck_schedule_id">Schedule</a></li>
						              <li id="li_config"><a role="tab" id="deck_tab_config" href="#autodeck_config_temp_id">Configuration template</a></li>
						                <li id="li_init_config"><a role="tab" id="deck_tab_init_config" href="#autodeck_config_base_id">Base configuration</a></li>
						                 <li id="li_log"><a role="tab" id="deck_tab_log" href="#autodeck_schedule_history_id">Schedule history</a></li>
						          
						        </ul>
						    </div>
						    
						    
						    <!-- Tabs contents divs: -->
						    
						    <!-- prompts tab content -->
						    <div id="autodeck_requests_id" class="ibm-tabs-content">
						    
						    
						  <div class="ibm-common-overlay ibm-overlay-alt-three" data-widget="overlay" id="dialogOne">
						 <jsp:include page="/WEB-INF/portal/autodeck_request.jsp"></jsp:include>
						  </div>  
						    
						    
						    
						    
						    
						    
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
            
            <th scope="col">Request Status</th>
            <th scope="col">Comments</th>
            <th scope="col">Request ID</th>
            <th scope="col">Type</th>
             <th scope="col">Output Status</th>
              <th scope="col">Last Ready Time
</th>
        </tr>
    </thead>
    <tbody>
    
    </tbody>

</table>
<p id="requests_operation" class="ibm-ind-link">
<a class="ibm-anchor-up-link" id="autodeck_href_showa1" name="autodeck_href_showa1" href="#t1"  style="font-weight:normal">Move up</a>
|<a id="autodeck_href_showa2" name="autodeck_request_down" class="ibm-anchor-down-link" style="font-weight:normal"  href="#t1">Move down</a>
|<a id="autodeck_href_showa3" name="autodeck_href_more" class="ibm-popup-link"  href="#t1">Select more</a>
|<a id="autodeck_href_showa4" name="autodeck_href_delete" class="ibm-delete-link" href="#t1">Delete</a>
|<a id="autodeck_href_showa5" name="autodeck_href_notready" class="ibm-reset-link"  href="#t1">Reset Output Status</a>
|<a id="autodeck_href_showa6" name="autodeck_href_tbslist" class="ibm-forward-link" href="<%=request.getContextPath()+"/action/portal/mycognosschedulelist?deckId="%>${requestScope.deck_id}">Work with associated Schedule Requests</a>
</p>
<div class="ibm-common-overlay full-width seamless" data-widget="overlay" id="overlayExampleXl">
					<p>
						Overlay content can include standard text or links/buttons. The overlay closes if a user clicks off of the overlay window or clicks the "X" button.</p>
				</div> 
						    </div>
						    
						    <!-- output format tab content -->
						    <div id="autodeck_outputformat_id" class="ibm-tabs-content">
							    <p class="ibm-callout">Select an output format and file name</p><br/>
	<table class="ibm-results-table" border="0" cellpadding="2" cellspacing="0" width="100%">
	<thead><tr><th scope="col" style="display:none;">col1</th>
			<th scope="col" style="display:none;">col2</th>
	</tr></thead>
	<tbody>
		<tr>
			<td width="27%">
				<label for="filename">Specify presentation deck file name:<span class="ibm-required">*</span></label>
			</td>
			<td>
				<input aria-required="true" name="filename" id="deck_name_id" size="20" value="" type="text">
			</td>
		</tr>
		<tr>
			<td style="height: 15px;"></td>
		</tr>
		<tr>
			<td>
				<label id="UPDATE-grp-lbl-id7" class="ibm-form-grp-lbl">Send the generated file as</label>
			</td>
			<td>
				<span class="ibm-input-group">
					<input id="send_option_link_id" class="ibm-styled-radio" name="sendoption" value="LINK" onclick="checkLinkOrAttachment(this);" type="radio"><label for="send_option_link_id">link</label>
					<input id="send_option_att_id" class="ibm-styled-radio" name="sendoption" value="ATTACHMENT"  onclick="checkLinkOrAttachment(this);" type="radio"><label for="send_option_att_id">attachment</label>
				</span>
			</td>
		</tr>
		<tr id="div_zipoutput" style="">
			<td>
				<label id="UPDATE-grp-lbl-id7" class="ibm-form-grp-lbl">Zip output</label>
			</td>
			<td>
				<span class="ibm-input-group">
					<input id="zip_output_NO_id" class="ibm-styled-radio"  name="zipoutput" value="N" checked="" type="radio"><label for="zip_output_NO_id">No</label>
					<input id="zip_output_YES_id" class="ibm-styled-radio"  name="zipoutput" value="Y" type="radio"><label for="zip_output_YES_id">Yes</label>
				</span>
			</td>
		</tr>
		
		
		
			<tr>
			<td>
				<label id="UPDATE-grp-lbl-id017" class="ibm-form-grp-lbl">Append date to output</label>
			</td>
			<td>
				<span class="ibm-input-group">
					<input id="appandDate_N_id" class="ibm-styled-radio" name="appandDate" value="N" checked="" onclick="checkIfAppandDate(this);" type="radio"><label for="appandDate_N_id">No</label>
					<input id="appandDate_Y_id" class="ibm-styled-radio" name="appandDate" value="Y" onclick="checkIfAppandDate(this);" type="radio"><label for="appandDate_Y_id">Yes</label>
				</span>
			</td>
		</tr>
		<tr id="div_appanddate" style="display:none">
			<td>
				<label id="UPDATE-grp-lbl-id018" class="ibm-form-grp-lbl">Select the date format:</label>
			</td>
				<td >
							<fieldset  style="border:1px solid #DDD;width:30%;" ><legend>Format:</legend>
							<table class="ibm-results-table" id="radiotype_append1" border="0" cellpadding="0" cellspacing="0" width="50%">
								<thead>
			<tr><th scope="col" style="display:none;">col1</th>
			<th scope="col" style="display:none;">col2</th>
			<th scope="col" style="display:none;">col3</th>
		</tr></thead>
								<tbody>
								
									<tr>
										<td  style="white-space: nowrap;">
										<span id="span-datatype-id">
										</td>
									</span>
									</tr>
									
									
								</tbody>
							</table>
						
						</fieldset>	
			</td>
		</tr>
		
		
		
		
		
		
		
		
		<tr>
			<td style="height: 15px;"></td>
		</tr>
		<tr>
			<td>
				Select required output file type:<span class="ibm-required">*</span>
			</td>
			<td>
				<table  id="radiotype1" border="0" cellpadding="0" cellspacing="0" width="30%"> 
					<thead>
			<tr><th scope="col" style="display:none;">col1</th>
			</tr></thead>
					<tbody><tr>
						<td>
							<fieldset style="border:1px solid #DDD;"><legend>Format:</legend>
							<table  id="radiotype" border="0" cellpadding="0" cellspacing="0" width="50%">
							
								<tbody>
									
									<tr>
										<td>
										<span id="span_output_file_type_id" class="ibm-input-group">
										
										</span>
										</td>
									
									</tr>
									
									
								</tbody>
							</table>
						</fieldset>
					</td>
				</tr>
			</tbody></table>
			</td>
		</tr>
		<tr>
			<td style="height: 15px;"></td>
		</tr>
		
		<tr id="div_outline">
		
			<td><label class="ibm-form-grp-lbl">Outline images?  </label></td>
			<td>
			<span class="ibm-input-group"><input class="ibm-styled-checkbox" value="Y" id="is_outline" name="is_outline" type="checkbox"><label for="is_outline">Yes</label></span>
			</td>
			
		</tr>
		<tr>
			<td style="height: 15px;"></td>
		</tr>
		<tr id="div_template">
			<td>
				<label id="UPDATE-grp-lbl-id6" class="ibm-form-grp-lbl">Select the desired template for the ppt output:<span class="ibm-required">*</span></label>
			</td>
			<td>
				<span  id="span-template-radio" class="ibm-input-group">
				
			
				
				</span>
			</td>
		</tr>
		
			<tr id="div_pastetype" style="display:none;">
			<td>
				<label id="UPDATE-grp-lbl-id6ppttype" class="ibm-form-grp-lbl">Select the image paste type for the ppt output:<span class="ibm-required">*</span></label>
			</td>
			<td>
				<span id="span_pasteTypeid" class="ibm-input-group">
				
				
							
				</span>
			</td>
		</tr>	
</tbody>
</table>
   
 
 
  

</form>
<!-- 	    <form>
	<label    id="labe_id_output_type_id">Select required output file type:</label>
                <span id="span_output_file_type_id">
                   <input id="radiogrptype_id_1" name="radiogrptype" type="radio" class="ibm-styled-radio"  value="2" /> 
                   <label for="radiogrptype_id_1">ppt</label>
                    <br />
                    <input id="radiogrptype_id_2" name="radiogrptype" type="radio" class="ibm-styled-radio" value="1" /> 
                    <label for="radiogrptype_id_2">xls</label>
                    <br />
                    <input id="radiogrptype_id_3" name="radiogrptype" type="radio" class="ibm-styled-radio" value="3" /> <label for="radiogrptype_id_3">xlsx</label>
          
           </span>     
     
  

</form>		 -->				 
						    	 
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
										<td style="width: 25%;"><label for="id_textarea_e_mail_address">Enter your e-Mail address and/or <a id="myDistribution" name="myDistribution" target="_blank" href="/transform/biportal/action/portal/mydistlist/distmanage/getMyDistListPage">distribution list(s)</a>:<span class="ibm-required">*</span></label></td>
										<td style="width: 20%;vertical-align: top;">
										<textarea  id="autodeck_textarea_e_mail_address_id" rows="4" cols="60" name="eMailAddress"></textarea>
										</td>
										<td style="width: 55%; text-align: left; vertical-align: top;">&nbsp;&nbsp;(Enter up to 12 e-Mail addresses separated by spaces.)
										<br>
										<br>
										<span class="ibm-item-note">&nbsp;&nbsp;(e.g. jdoe@us.ibm.com mydistlist)</span>
										<br>
										<br>
										
									    <a id="autodeck_cognosUnsubscribepage_id" class="ibm-feature-link" href="#t1"  onclick="openUnsubAutodeck();"  name="id_cognosUnsubscribepage">&nbsp;Show unsubscribe list</a>
									</tr>
									
									<tr>
										<td style="height: 15px;"></td>
									</tr>
									
									<tr valign="top">
										<td style="height: 1px;"></td>
										<td><label for="autodeck_text_e_mail_subject_id">e-Mail subject:<span class="ibm-required">*</span></label></td>
										<td>
										<input type="text" id="autodeck_text_e_mail_subject_id" onkeypress="if ( event.keyCode == 13 ) return false; else if ( event.which == 13 ) return false; else return true;"	maxlength="90" size="60" name="eMailSubject"  />
										</td>
										<td>(Text for subject line of e-Mail)</td>
									</tr>
																		
									<tr>
										<td style="height: 15px;"></td>
									</tr>
									
									<tr valign="top">
										<td style="height: 1px;">&nbsp;</td>
										<td><label for="autodeck_email_comments_id">Enter your e-Mail comments:</label></td>
										<td style="vertical-align: top;"><textarea id="autodeck_email_comments_id" rows="4" cols="60" name="eMailComments" ></textarea>
										</td>
										<td>&nbsp;&nbsp;(will be included in the e-Mail body)</td>
									</tr>
									<tr>
										<td style="height: 15px;"></td>
									</tr>
									<tr valign="top">
										<td style="height: 1px;"></td>
										<td><label for="id_text_backup_owner">Backup:</label></td>
										<td>
										<input type="text" id="autodeck_text_backup_owner_id" maxlength="128" size="60" name="backupOwner" value="" >
										</td>
										<td><span class="ibm-item-note">(e.g. jdoe@us.ibm.com)</span></td>
									</tr>
									
									<tr>
										<td style="height: 15px;"></td>
									</tr>
									
									<tr valign="top">
										<td style="height: 1px;"></td>
										<td>&nbsp;</td>
									
												
										
															</tr>
															
															
												    	</tbody>
												    </table>
													</div>			    
		<!--  email tab end-->
		
				    
						    <!-- schedule tab content -->
						    
						   <div id="autodeck_schedule_id" class="ibm-tabs-content">
		 <p class="ibm-callout">Set the schedule timing for scheduled deck</p><br/>	
			<p>
													</p>
				<table width="80%" cellspacing="0" cellpadding="0" border="0" summary="table layout display" class="ibm-results-table">
			<thead>
				<tr>
					<th scope="col" style="display:none;">col1</th>
					<th scope="col" style="display:none;">col2</th>
					<th scope="col" style="display:none;">col3</th>
					<th scope="col" style="display:none;">col4</th>
				</tr>
			</thead>
	<tbody>
		<tr>
			
			<td style="vertical-align: top; width: 27%;"><b>Final deck Synchronisation:</b><span class="ibm-required">*<span class="ibm-access">required</span></span>
			<br>
			<br>
		Your 'Final' deck will be sent out as soon as all the required content has been updated.
	<br>
			</td>
			<td width="3%">
						</td>
			<td style="vertical-align: top; width: 50%;">
			<fieldset style="border: 1px solid rgb(221, 221, 221);"><legend>Final deck Synchronisation:<span class="ibm-required">*<span class="ibm-access">required</span></span></legend>

				<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ibm-results-table">
				
					<thead>
						<tr>
							<th scope="col" style="display:none;">col1</th>
							<th scope="col" style="display:none;">col2</th>
							<th scope="col" style="display:none;">col3</th>
							<th scope="col" style="display:none;">col4</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="ExpnDate_td1_rm_obsoleted_lang"/>
							<td class="ExpnDate_td2_rm_obsoleted_lang">
								<tr></tr>
								<br/>
								<tr>Day / Time (recommended for Weekly decks) - all required content to be updated again after the chosen time of day.</tr><br/>
								<tr>
								<span class="ibm-input-group">
								<input type="radio" name="final_weekly"  class="ibm-styled-radio" value="Sun" id="id_radio_sun"  />
								<label for="id_radio_sun">Sunday</label>
								
								</tr>
								<br/>
								<br/>
								<tr>
								
								<input type="radio" class="ibm-styled-radio" name="final_weekly" value="Mon" id="id_radio_mon"   />
								<label for="id_radio_mon">Monday</label>
<br/>
								
								</tr>
								<br/>
								<tr>
							
								<input type="radio" class="ibm-styled-radio" name="final_weekly" value="Tue" id="id_radio_tue"   />
								
									<label for="id_radio_tue">Tuesday</label>
								<br/>
								</tr>
								<br/>
								<tr>
								
								<input type="radio" class="ibm-styled-radio" name="final_weekly" value="Wed" id="id_radio_wed"   />
								<label for="id_radio_wed">Wednesday</label>
								<br/>
								</tr>
								<br/>
								<tr>
							
								<input type="radio" class="ibm-styled-radio" name="final_weekly" value="Thu" id="id_radio_thu"   />
								<label for="id_radio_thu">Thursday</label>
							<br/>
								</tr>
								<br/>
								<tr>
							
								<input type="radio" class="ibm-styled-radio" name="final_weekly" value="Fri" id="id_radio_fri"   />
								<label for="id_radio_fri">Friday</label>
								<br/>
								</tr>
								<br/>
								<tr>
								
								<input type="radio" class="ibm-styled-radio" name="final_weekly" value="Sat" id="id_radio_sat"   />
								<label for="id_radio_sat">Saturday</label>
								<br/>
								</tr>
								<br/>
									<tr>&nbsp&nbsp&nbsp&nbsp
									<span>  </span><select name="final_deck_time" id="final_deck_time_id" style="width:150px">
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
								</tr>
								
								<tr></tr><br/><br/>
								<tr>
								
								<input  type="radio" name="final_weekly" class="ibm-styled-radio" value="Ato" id="id_radio_default"/>
								<label for="id_radio_default">When Ready (recommended for Daily decks) - when the Output Status for all required TBS Inputs shows as 'Ready'.
								</label>
								</span>
								</tr>
								
							</td>
							
							<td class="ExpnDate_td3_rm_obsoleted_lang"/>
						</tr>
					</tbody>
				</table>

				</fieldset>
			</td>
			<td style="width: 100%;"></td>
		</tr>

	</tbody>
</table><br />
	
	
	


<!-- <h3 style="margin-left: 0px;">Note that your 'Final' deck will be sent out as soon as all the required content has been updated.</h3> -->
<br/>
<br/>
<table class="ibm-results-table" cellspacing="0" cellpadding="0" border="0" width="80%" >
	 <thead>
			<th scope="col" style="display:none;">col1</th>
			<th scope="col" style="display:none;">col2</th>
			<th scope="col" style="display:none;">col3</th>
				
	
	</thead>
	<tbody>
		<tr>
			<td style="vertical-align: top; width: 15px;"></td>
			<td style="vertical-align: top; width: 45%;"><label>Do you require a Status Message or Provisional deck to be sent to you in the event that
			some of the required Autodeck inputs are unavailable at a specified day and time? </label></td>
			<td style="vertical-align: top;">
			
			
			<span> 
			
<select name="is_provisional" id="is_provisional"  onchange="displaySchedule()">
        

							<option  value="N">Not needed</option>
							<option  value="W">Status Message only</option>
							<option  value="Y">Provisional Deck with Status Message</option>
							</select>
			</td>
			
		</tr>
		<tr id="tr_id_schedule_fre">
			<td style="vertical-align: top; width: 15px;"></td>
			<td style="vertical-align: top; width: 45%;">Schedule frequency:<span class="ibm-required">*</span>
			<br/>
			<br/>
Select the required day(s) for your status update
			</td>
			<td style="vertical-align: top;">
			<fieldset style="border:1px solid #DDD;"><legend>Schedule frequency:<span class="ibm-required">*</span></legend>
			<table  class="ibm-results-table" cellspacing="0" cellpadding="0" border="0" width="100%" >
			 <thead>
			<th scope="col" style="display:none;">col1</th>
			<th scope="col" style="display:none;">col2</th>
			<th scope="col" style="display:none;">col3</th>
				
	
	</thead>
				<input type="hidden" id="id_hidden_sched_freq_detail" value="M,Tu,W,Th,F,Sa,Su" name="sched_freq_detail" >
				
				 <thead>
			<th scope="col" style="display:none;">col1</th>
			<th scope="col" style="display:none;">col2</th>
			<th scope="col" style="display:none;">col3</th>
				<th scope="col" style="display:none;">col4</th>
		</thead>
				<tbody>
					<tr>
						<td class="ExpnDate_td1_rm_obsoleted_lang"></td>
						<td class="ExpnDate_td2_rm_obsoleted_lang">
							<input type="radio" class="ibm-styled-radio"  onclick="MergeScheduleDateD(this);" id="id_radio_sched_freq" value="D" name="sched_freq"> 
							<label for="id_radio_sched_freq">Daily/weekly</label>
						</td>
						<td style="vertical-align : bottom" class="ExpnDate_td3_rm_obsoleted_lang">
						<select multiple="multiple" class="ibm-widget-processed" id="id_D_sched_freq_detail" title="Daily or Weekly" size="4" name="D_sched_freq_detail">
							<option value="M">Monday</option>
							<option  value="Tu">Tuesday</option>
							<option value="W">Wednesday</option>
							<option  value="Th">Thursday</option>
							<option  value="F">Friday</option>
							<option  value="Sa">Saturday</option>
							<option  value="Su">Sunday</option>
						</select></td>
						<td class="ExpnDate_td3_rm_obsoleted_lang"></td>
					</tr>
					<tr>
						<td colspan="4">&nbsp;</td>
					</tr>
					<tr>
						<td class="ExpnDate_td1_rm_obsoleted_lang"></td>
						<td class="ExpnDate_td2_rm_obsoleted_lang">
						<input type="radio"  class="ibm-styled-radio" onclick="MergeScheduleDateM(this);" id="id_sched_freq_M" value="M" name="sched_freq"> 
						<label for="id_sched_freq_M">Monthly</label>
						</td>
						<td style="vertical-align : bottom" class="ExpnDate_td3_rm_obsoleted_lang">
						<select multiple="multiple" id="id_M_sched_freq_detail" title="Monthly"  class="ibm-widget-processed" size="4" name="M_sched_freq_detail">
							<option  value="FM">1st Mon</option>
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
						</select></td>
						<td class="ExpnDate_td3_rm_obsoleted_lang"></td>
					</tr>
					<tr>
						<td colspan="4">&nbsp;</td>
					</tr>
					<tr>
					
					</tr>
					
					<input type="hidden" id="id_curDate" value="2017-05-26" name="curDate">

					<input type="hidden" id="id_maxDaily" value="2017-11-22" name="maxDaily">

					<input type="hidden" id="id_maxMonthly" value="2018-05-26" name="maxMonthly">

					<input type="hidden" id="id_maxBusiness" value="2018-05-26" name="maxBusiness">

					<tr>
						<td colspan="4">&nbsp;</td>
					</tr>
				</tbody>
			</table>
			</fieldset>
			</td>
			<td style="width: 100%;"></td>
		</tr>
		<tr>
			<td style="height: 15px;"></td>
		</tr>
		<tr id='tr_id_timezone'>
			<td style="vertical-align: top; width: 15px;"></td>
			<td style="vertical-align: top; width: 45%;"><label for="idDropDownTimezone">Select the desired time for your status update:<span class="ibm-required">*</span> <span class="ibm-item-note"></span></label><span class="ibm-required"></span></td>
			<td style="vertical-align: top;">
			<span>Time 
<select name="DropDownTimezone" id="DropDownTimezone">
        
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
      <option value="12"  >GMT 12:00c</option>   
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
</span>
			</td>
		</tr>
		<tr>
			<td style="height: 15px;"></td>
		</tr>

		
		

	</tbody>
</table>
<form id="" class="ibm-column-form" method="post" action="">
   
    <p>
        <label  style="vertical-align: top; width: 28%;"for="id_expiration_date">Expiration date:<span class="ibm-required">*</span></label>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <span id="s_exp_date_id">
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input data-widget="datepicker" type="text" value="" size="20"  data-min="-0" data-format="yyyy-mm-dd" data-max="180" id="id_expiration_date"" name="id_expiration">
        </span>
    </p>
	
</form>			
			
			
			
			
								</div>									    
																    
												<!-- config tab -->	
												
															    
												<div id="autodeck_config_temp_id" class="ibm-tabs-content">
													 <p class="ibm-callout"><span>Step by step instructions to refine your Autodeck layout</span></p><br/>	
<div id="autodeck_intro_desc" data-widget="showhide" class="ibm-simple-show-hide">
					    <div class="ibm-container-body">
					        <p class="ibm-show-hide-controls"><a href="#show" class="">Show descriptions</a> | <a href="#hide" class="ibm-active">Hide descriptions</a></p>
					        <div class="ibm-hideable">
	

<p>A default template is generated by the system when your Autodeck is first created. You may update this template to fine-tune how your individual slides or worksheets appear but please take care that your changes do not cause the job to fail.  
 </p>

<p>To adjust the template:<ol>
									<li>Click on the 'Edit template' button.</li>
									<li>Use the checkbox to select pages that you wish to 'Move up', 'Move down' or to 'Delete.</li>
									<li>Update the Range information to select different content from the source Excel file. (Note that only a single range is allowed for each input)</li>
									<li>Use the 'Hide rows' or 'Hide columns' fields to remove unwanted content (e.g. 2:6,9,11 or A,C,J:M).</li>							
																
																<li>Use the 'AutoSize', 'Custom column format', 'Custom row format', 'Wrap text' and 'Display gridline' controls to make detailed adjustments to each page of your presentation deck (refer to the 'Help for this page' for more details on allowed formats).</li><li>Click on the 'Add one' link to add additional content to your deck. (Please take care with all keyed information as invalid information may cause the job to fail).</li><li>Merge content onto a single slide or worksheet by using the same 'Slide number' (PowerPoint) or 'New worksheet name' (Excel) for the different inputs.</li><li><strong>PPT only:</strong> use the 'Header text' field to add a title to the designated slide (max 128 characters).</li><li><strong>PPT only:</strong> click on the 'Renumber slides' link to reset the slide numbers to a sequential order.</li>
																	</ol>
							</p>
							<br />Click on the <strong>Submit</strong> button to save your requested changes.
							<p><strong>Note:</strong> Once you have edited the template, your changes will override any system-generated configuration settings; new report content will be ignored unless you manually add it or click on the <strong>'Request reset'</strong> button to recreate the template when the Autodeck is next produced. Alternatively, you may restore the last set of system settings by clicking on the 'Restore Template' link. In both cases you must also press <strong>Submit</strong> to confirm your changes or close the window to cancel. Please be aware that once the <strong>Submit</strong> button is pressed, all of your previous template edits will be lost.</p>
							<br />

					        </div>
					     
						</div>
			</div>	

<div class="ibm-rule"><hr></div>

							<p class='ibm-btn-row'>
						 	
					
						<input class="ibm-btn-arrow-sec" id="id-set-default" name="set-to-default" onclick="setDefault();" value="Request reset" type="button"> 
<input  class="ibm-btn-arrow-sec" name="set-to-edit" id="id-set-edit" value="Edit template " onclick="setEdit();" type="button"> 

<!-- add by leo -->
<input class="ibm-btn-arrow-sec" name="export" id="id-export" value="Export template " onclick="exportTemplate('2017052309220200051385220320');" type="button"> 							
<input class="ibm-btn-arrow-sec" name="import" id="id-import" value="Import template " onclick="importshow('importDialog',this);return false;" type="button"> 							


</p>
<div id="importDialog" style="display:none">
	<br>
      
           
    <input name="convert_id" value="2017052309220200051385220320" type="hidden">
       Select Configuration Template File:<br>
       &nbsp; &nbsp;<input class="ibm-btn-arrow-sec" name="myfile" id="myfile" type="file">  &nbsp; &nbsp;
       <input class="ibm-btn-arrow-sec" id="uploadButton" value="Submit Template" onclick="if(!importTemplate()) return;"> 
       &nbsp; &nbsp;
       <div id="hiddenSubmitbuttonInForm1" style="display:none;">
<input class="ibm-btn-arrow-sec" onclick="return false;" value="Dummybutton" name="dummy button1" id="id_button_dummy_submit1" type="submit">

</div>

    <br/>
</div>
<div class="ibm-rule"><hr></div>	
 <br/>	
 <!-- restore section -->
 <div id="load_default_id">
							<p><span>Click on the <a id="autodeck_href_name_restore" name="autodeck_href_id_restore"  onClick="javascript:loadInitTemplates()" href="#t1">Restore Template</a> link to recover the last set of system generated configuration settings.<span></span></p>
							</div>
 
 										
<!-- ppt config ppt table begain -->	
	<!-- ppt config table operation -->																
	
		
		
		<div id="config_ppt_div">
		<p id="ppt_conifg_operation" class="ibm-ind-link">
   <a class="ibm-anchor-up-link" href="#t1" id="ppt_up"  >Move up</a>|<a id="ppt_down" name="ppt_down" class="ibm-anchor-down-link"   href="#t1" style="font-weight:normal" >Move down</a>|<a id="ppt_add"  href="#t1" name="ppt_add" class="ibm-popup-link" >Add one</a>|<a id="ppt_remove" name="ppt_remove" href="#t1" class="ibm-delete-link"  >Delete</a>|<a id="ppt_reslide" name="ppt_reslide" class="ibm-reset-link"  onClick="javascript:regSlideNo()" href="#t1">Renumber slides</a> 
   </p>
		<table name="template_config_ppt" class="display"  cellspacing="0" cellpadding="0" border="0" summary="ppt configration template"  id="config_ppt_table"> 
				 <thead>  
				       <tr>    <th style="width: 2%; height: 16px;" scope="col"/> 
				       <th class="ibm-sort" scope="col"><a id="autodeck_href_name6" name="autodeck_href_id6" onClick="javascript:sortOrder()" href="#sort"><span title="<%=Slide_No_Mouseover%>" >Slide No.</span><span class="ibm-icon">&nbsp;</span></a></th>     
				                  <th scope="col"><span title="<%=Request_ID_Mouseover%>" >Request ID</span></th>    
				                  <th scope="col"><span title="<%=Worksheet_Mouseover%>" >Worksheet</span></th>   
				                   <th scope="col"><span title="<%=Range_Mouseover%>" >Range</span></th>   
				                    
				                     <th class="ibm-date" scope="col"><span title="<%=Hide_rows_Mouseover%>" >Hide rows</span></th>  
				                     <th class="ibm-date" scope="col"><span title="<%=Hide_columns_Mouseover%>" >Hide columns</span></th>  
                                     <th class="ibm-date" scope="col"><span title="<%=Hide_text_Mouseover%>" >Header text</span></th>
                                          <th  scope="col"><span title="<%=AutoSize_rows_Mouseover%>" >AutoSize rows</span></th>
				                      <th  scope="col"><span title="<%=AutoSize_columns_Mouseover%>" >AutoSize columns</span></th>
				                      <th  scope="col"><span title="<%=Custom_column_width_Mouseover%>" >Custom column format</span></th>
				                       <th  scope="col"><span title="<%=Custom_row_height_Mouseover%>" >Custom row format</span></th>
				                      <th  scope="col"><span title="<%=Wrap_text_in_rows_Mouseover%>" >Wrap text in rows</span></th>
				                       <th  scope="col"><span title="<%=Display_gridline_Mouseover%>" >Display gridline</span></th>
                                       <th  scope="col"><span title="Create/Show preview" >Preview</span></th> 
				                        </tr> 
				                         </thead>
                       <tbody>
               
</tbody>
</table>

</div>
<!-- ppt config table end -->	






<div id="xlssource_template" >
<p id="xls_conifg_operation" class="ibm-ind-link">
   <a class="ibm-anchor-up-link"  id="xls_moveup" href="#t1" style="font-weight:normal">Move up</a>|<a id="xls_movedown" name="autodeck_href_id2" class="ibm-anchor-down-link"  style="font-weight:normal"  href="#t1">Move down</a>|<a id="xls_add" name="xls_add"  href="#t1" class="ibm-popup-link"  >Add one</a>|<a id="xls_remove" name="xls_remove"  href="#t1" class="ibm-delete-link" >Delete</a> 
   </p>
   	 
		<table name="t0" cellspacing="0" cellpadding="0" border="0" summary="source configration template" class="display" id="xls_confit_table"> 
				 <thead>  
				       <tr>    <th style="width: 2%; height: 16px;" scope="col"/>    
				                  <th scope="col"><span title="<%=Request_ID_Mouseover_xls%>" >Request ID</span></th>    
				                  <th scope="col"><span title="<%=Worksheet_Mouseover%>" >Worksheet</span></th>  
				                    <th scope="col"><span title="<%=New_Worksheet_Mouseover%>" >New worksheet name</span></th>  
				                   <th scope="col"><span title="<%=Range_Mouseover%>" >Range</span></th>   
				                   
				                    <th  scope="col"><span title="<%=Hide_rows_Mouseover%>" >Hide rows</span></th> 
				                    <th  scope="col"><span title="<%=Hide_columns_Mouseover%>" >Hide columns</span></th>
                                     <th  scope="col"><span title="<%=AutoSize_rows_Mouseover%>" >AutoSize rows</span></th>
				                      <th  scope="col"><span title="<%=AutoSize_columns_Mouseover%>" >AutoSize columns</span></th>
				                      <th  scope="col"><span title="<%=Custom_column_width_Mouseover%>" >Custom column format</span></th>
				                        <th  scope="col"><span title="<%=Custom_row_height_Mouseover%>" >Custom row format</span></th>
				                      <th  scope="col"><span title="<%=Wrap_text_in_rows_Mouseover%>" >Wrap text in rows</span></th>
				                       <th  scope="col"><span title="<%=Display_gridline_Mouseover%>" >Display gridline</span></th>
				                      <th  scope="col"><span title="Create/show preview" >Preview</span></th>
				                        </tr> 
				                         </thead>				                         
                       <tbody>
                       </tbody>
                       </table>
                       </div>







<div style="display:none;" id="reset_notice"><p  class="ibm-callout">You just set 'request reset',the system will recreate the template when the Autodeck is next produced </p></div>										
												
												 <script type="text/javascript">
          function restForm() {
                        jQuery("#uploadButtonId").removeAttr('disabled');
                        jQuery("#autodeck_upload_form")[0].reset();
                        jQuery("#inputXLSFileId").val('');
                        jQuery("#uploadButtonId").val('Submit');
                    }
               function uploadFile() {
               
              var output_type=jQuery("input[name='radiogrptype']:checked").val();
               jQuery("#output_type").val(output_type);
                        var inputFilePath = jQuery("#inputXLSFileId").val();
                      
                        var if_uploadFile = true;
                      
                        if (inputFilePath == null || inputFilePath == '') {
                            if_uploadFile = false;
                            alert("Please provide a upload file to import");
                            return;
                        }
                        // begin == add for check if the input file is .xls or .xlsx file for firefox browser.
                        if(inputFilePath != null && inputFilePath != ''){
                        	var position = inputFilePath.lastIndexOf(".");
                        	var suffix = inputFilePath.substring(position);
                        	if(suffix != ".xls" && suffix != ".xlsx") {
                        		alert("Please upload .xls or .xlsx file");
                            	return;
                        	}
                        }
                         // end == add for check if the input file is .xls or .xlsx file for firefox browser.
                        
						 // end == verify if file name changes in update action
						 
                        jQuery("#uploadButtonId").attr('disabled', true);
                        jQuery("#uploadButtonId").val('Submitting...');
                       
                            jQuery("#autodeck_upload_form").ajaxSubmit({
                                type: 'POST',
                                url: '<%=path%>/action/portal/autodeck/edit/importtemplate/',
                                dataType: "json",
                                success: function(data) {
                                alert("sucessfully imported!")
                                    restForm();
                                    console.log(data);
                                    resObject =jQuery.parseJSON(data);;
             
               var impStatus=resObject.STATUS;
     			//var impConfigData=resObject.MSG;
     			var configs=resObject.MSG;;
     			if(output_type=='2'){
     			//ppt
     			  var table_config= jQuery('#config_ppt_table').DataTable();
     			   table_config.rows().remove().draw(false)
	    for (var i = 0; i < configs.length; i++) {
	   
	        var config= configs[i];	  	            
	            var input_col_1 = config.slide;
	            
	            var input_col_2 = config.request_id;
	         
	          
	            var input_col_3 = config.sheet;

	            var input_col_4 = config.range;
	            var input_col_5 = config.hide_rows;
	            var input_col_6 = config.hide_columns;
	            var input_col_7 = config.header_text;
	            var autofitrows="N";
	            if(config.autofit_rows=='YES'){
	             autofitrows="Y";
	            }
	            var autofit_columns="N";
	            if(config.autofit_columns=='YES'){
	             autofit_columns="Y";
	            } 
	            var display_gridline="N";
	             if(config.display_gridline=='YES'){
	             display_gridline="Y";
	            }
	            var input_col_8 = autofitrows;
	            var input_col_9 = autofit_columns;
	            var input_col_10 = config.custom_column_width;
	            var input_col_11 = config.custom_row_height;
	            var input_col_12= config.wrap_text_rows;
	            var input_col_13= display_gridline;
	            var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7,input_col_8,input_col_9,input_col_10,input_col_11,input_col_12,input_col_13]

	            table_config.row.add(dataSet).draw();
	    }
     			}else{
     			  var table_config= jQuery('#xls_confit_table').DataTable();
		         table_config.rows().remove().draw(false);
     				    for (var i = 0; i < configs.length; i++) {
		        var config= configs[i];
	            
		            var input_col_1 = config.request_id;
		         
		          
		            var input_col_2 = config.sheet;;

		            var input_col_3 = config.new_sheet_name;
		            var input_col_4 = config.range;
		            var input_col_5 = config.hide_rows;
		            var input_col_6 = config.hide_columns;
		           var autofitrows="N";
		           //autofit_rows
	            if(config.autofit_rows=='YES'){
	             autofitrows="Y";
	            }
	            var autofit_columns="N";
	            if(config.autofit_columns=='YES'){
	             autofit_columns="Y";
	            } 
	            var display_gridline="N";
	             if(config.display_gridline=='YES'){
	             display_gridline="Y";
	            }
		            var input_col_7 = autofitrows;
		            
		            var input_col_8 = autofit_columns;
		            var input_col_9 = config.custom_column_width;
		            var input_col_10 = config.custom_row_height;
		            var input_col_11 = config.wrap_text_rows;
		            var input_col_12= display_gridline;
		         
		            var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7,input_col_8,input_col_9,input_col_10,input_col_11,input_col_12]

		            table_config.row.add(dataSet).draw();
		            //console.log("add one");


	  }
     			
     			
     			}
     			
     			 autodeckPanel.setEdit=false;
                  autodeckPanel.setEditConfig(); 
                                   
                                    
                                },
                                error: function(XMLHttpRequest, textStatus, errorThrown) {
                                    jQuery("#uploadButtonId").removeAttr('disabled');
                                    jQuery("#uploadButtonId").val('Submit');
                                    alert("Failed to upload file, error code:" + XMLHttpRequest.status + ",error message:" + textStatus);
                                }
                            });
                      

                    }
       var resturl="${rest_url}";
       </script>
		

   
                       






			    
									
</div>
													<!-- base config tab content -->				    
												<div id="autodeck_config_base_id" class="ibm-tabs-content">
													 <p class="ibm-callout">Your base configuration:</p><br/>	
													 <p id="csp_instruction_id"></p><br/>		
										<div  align="right">
	<input class="ibm-btn-pri ibm-btn-blue-50" name="set-to-copy" id="button-id-copy" value="Copy configuration"  onclick="copyBaseConfig();" type="button"/> 
		</div>		
<!-- ppt  base  config table begin -->	
		<div id="ppt_config_init">
													
		<div class="tab-pageDls">
		<table name="init_template_config_ppt" class="display"  cellspacing="0" cellpadding="0" border="0" summary="ppt configration template"  id="init_config_ppt_table"> 
				 <thead>  
				       <tr>    <th style="width: 2%; height: 16px;" scope="col"/> 
				       <th class="ibm-sort" scope="col"><span title="<%=Slide_No_Mouseover%>" >Slide No.</span></th>     
				                  <th scope="col"><span title="<%=Request_ID_Mouseover%>" >Request ID</span></th>    
				                  <th scope="col"><span title="<%=Worksheet_Mouseover%>" >Worksheet</span></th>   
				                   <th scope="col"><span title="<%=Range_Mouseover%>" >Range</span></th>   
				                    
				                     <th  scope="col"><span title="<%=Hide_rows_Mouseover%>" >Hide rows</span></th>  
				                     <th scope="col"><span title="<%=Hide_columns_Mouseover%>" >Hide columns</span></th>  
                                     <th  scope="col"><span title="<%=Hide_text_Mouseover%>" >Header text</span></th>
                                   
                                        
				                        </tr> 
				                         </thead>
                       <tbody>
               
</tbody>
</table>

</div>
	
											
												</div>
												
			<!-- ppt  base  config table end -->											
												
												
												
												
			<!-- xls base  config table begin -->	
												
	<div id="xls_config_init" >
	
		<div class="tab-pageDls">
		<table name="xlscopyt6" cellspacing="0" cellpadding="0" border="0" summary="configration template" class="display" id="init_config_xls_table"> 
				 <thead>  
				       <tr>    <th style="width: 2%; height: 16px;" scope="col"/>    
				                  <th scope="col"><span title="<%=Request_ID_Mouseover_xls%>" >Request ID</span></th>    
				                  <th scope="col"><span title="<%=Worksheet_Mouseover%>" >Worksheet</span></th> 
				                  <th scope="col"><span title="<%=New_Worksheet_Mouseover%>" >New worksheet name</span></th>   
				                   <th scope="col"><span title="<%=Range_Mouseover%>" >Range</span></th>   
				                    
				                      <th class="ibm-date" scope="col"><span title="<%=Hide_rows_Mouseover%>" >Hide rows</span></th>  
				                     <th class="ibm-date" scope="col"><span title="<%=Hide_columns_Mouseover%>" >Hide columns</span></th>  
           <%--
                                          <th  scope="col"><span title="<%=AutoSize_rows_Mouseover%>" >AutoSize rows</span></th>
				                      <th  scope="col"><span title="<%=AutoSize_columns_Mouseover%>" >AutoSize columns</span></th>
				                      <th  scope="col"><span title="<%=Custom_column_width_Mouseover%>" >Custom column format</span></th>
				                        <th  scope="col"><span title="<%=Custom_row_height_Mouseover%>" >Custom row format</span></th>
				                      <th  scope="col"><span title="<%=Wrap_text_in_rows_Mouseover%>" >Wrap text in rows</span></th>
				                       <th  scope="col"><span title="<%=Display_gridline_Mouseover%>" >Display gridline</span></th> --%>
                                   
				                        </tr> 
				                         </thead>
                       <tbody>
               
</tbody>
</table>

</div>

</div>
	
<!-- xls base  config table end-->		
												
										
												
												
	</div>	

	
	
	
				
												<!-- running log tab content -->				    
												<div id="autodeck_schedule_history_id" class="ibm-tabs-content">
 <table border="0" class="display" cellpadding="0" cellspacing="0" id="table_running_log_id" summary="This is a layout table.">			
		<thead class="runid">
			<tr>
				<th scope="col">Running ID</th>
				<th scope="col">Start time</th>
				<th scope="col">Finish time</th>
				<th scope="col">Execution Status</th>
				<th scope="col">Message</th>
				<th scope="col">Send Mail</th>
				<th scope="col">Provisional</th>
			</tr>
		</thead>
	<tbody>
	</tbody>

	 </table>
												</div>
												
	</div>

	
	
	
	
	
	
	
	</div>			
</div>
			<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
				
		   
		  
		
</body>
</html>