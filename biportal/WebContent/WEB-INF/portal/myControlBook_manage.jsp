<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<meta contentType="text/html; charset=UTF-8">
<title>My Managed control books</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<script type="text/javascript" src="<%=path%>/javascript/bictrlbook.js"></script>

<script type="text/javascript">
    var myManagedCtrlbooks;
    var cwa_id = '${requestScope.cwa_id}';
    var uid = '${requestScope.uid}';
    var error = '${requestScope.error}';
    var biGeos = new BIgeos();
    var biBusinesses = new BIbusinesses();
    var dashboardTemplates = new DashboardTemplates();
    var domains = new ReportDomains();
    var cbIds_selected = '';
    var cbIds_un_selected = '';
    //Load Geography Select list
    function listGeos(){
	    
	    var timeid = (new Date()).valueOf();
	    jQuery.ajax({
	        type: 'GET', url: '<%=path%>/action/portal/controlbook/getGeoList/' + cwa_id + '/' + uid + "?timeid=" + timeid,
	        success: function (data) {
	            if (data.length > 0) {
	                var biGeo;
	                for (var i = 0; i < data.length; i++) {
	                    biGeo = new BIgeo(data[i]);
	                    biGeos.addGeo(biGeo);
	                }
	            }	            
	        }
	    });
    }
    //Load Business Select list
    function listBusinesses(){
	    
	    var timeid = (new Date()).valueOf();
	    jQuery.ajax({
	        type: 'GET', url: '<%=path%>/action/portal/controlbook/getBusinessList/' + cwa_id + '/' + uid + "?timeid=" + timeid,
	        success: function (data) {
	            if (data.length > 0) {
	                var biBusiness;
	                for (var i = 0; i < data.length; i++) {
	                    biBusiness = new BIbusiness(data[i]);
	                    biBusinesses.addBusiness(biBusiness);
	                }
	            }
	            
	        }
	    });
    }
    //
    function listDashboardTemplates(){
	    var timeid = (new Date()).valueOf();
	    jQuery.ajax({
	        type: 'GET', url: '<%=path%>/action/portal/controlbook/listDashboardTemplpates/' + cwa_id + '/' + uid + "?timeid=" + timeid,
	        success: function (data) {
	            if (data.length > 0) {
	                var template;
	                for (var i = 0; i < data.length; i++) {
	                		template = new DashboardTemplate(data[i]);
	                		dashboardTemplates.addTemplate(template);
	                }
	            }
	        }
	    });
    }
    //
    function listDomains(){
	    var timeid = (new Date()).valueOf();
	    jQuery.ajax({
	    		type: 'GET', url: '<%=path%>/action/portal/search/getDomains/' + cwa_id + '/' + uid+'?timeid='+timeid,
	        success: function (data) {
	            if (data.length > 0) {
	                var domain;
	                for (var i = 0; i < data.length; i++) {
	                		domain = new ReportDomain(data[i]);
	                		domains.addDomain(domain);
	                }
	            }
	        }
	    });
    }
    // Refresh selected control book list
    function listMyManagedCB() {
    		if(error!="undefined"&&error!=""){
    			jQuery("#div_message_id").html(error+'<br/>');
    			jQuery("#div_message_id").css('display','inline');
    			return ;
    		}
        myManagedCtrlbooks = new BIctrlbooks('myManagedCtrlbooks');
        jQuery("#div_cb_id").empty();
        jQuery("#div_cb_id").append("<img id='myreportLoading' src='<%=path%>/images/ajax-loader.gif' />");

		var timeid = (new Date()).valueOf();
        jQuery.ajax({
            type: 'GET', url: '<%=path%>/action/portal/controlbook/listMyManagedCB?cwa_id=' + cwa_id + '&uid=' + uid + '&timeid=' + timeid,
            success: function (data) {
            	jQuery("#div_cb_id").empty();
                if (data.length > 0) {
                    var selectedBICtrlbook;
                    for (var i = 0; i < data.length; i++) {
                        selectedBICtrlbook = new BIctrlbook(data[i], 'cb_myManaged');
                        myManagedCtrlbooks.addCtrlbook(selectedBICtrlbook);
                    }
                }
                jQuery("#div_cb_id").html(myManagedCtrlbooks.createMyMangedCBPanel());               
            },
            error: function (data) {
                jQuery("#div_cb_id").empty();
                alert(data);
            }
        });
    }
    
    function removeCtrlbook(confirmed){
        var cbids = new Array();
        var cbid= '';
		var selectedCBids = jQuery("[name='name_cb_myManaged']");

		for (var i = 0; i < selectedCBids.length; i++) {
			if (selectedCBids[i].checked) {
				cbid = jQuery(selectedCBids[i]).attr("id");
				cbids.push(cbid);
			}
		}
		
		if(cbids.length>0){
			if(confirmed){
				jQuery('#showConfirmMessagePanel_yes_id').attr('disabled',true);
				jQuery('#showConfirmMessagePanel_cancel_id').attr('disabled',true);
				for(var i=0;i<cbids.length;i++) {
					var cbid = cbids[i];
					var success = false;
					var done = false;
					//
					jQuery('#showConfirmMessagePanel_text_id').empty();
					jQuery('#showConfirmMessagePanel_text_id').text('removing control book:'+cbid);
					//
					jQuery.ajax({
			            type: 'DELETE', url: '<%=path%>/action/portal/controlbook?cbid='+cbid+'&cwa_id=' + cwa_id + '&uid=' + uid,
			            async: false,
			            success: function (data) {
		            			jQuery('#showConfirmMessagePanel_text_id').text('removed control book:'+cbid +' succesfully.');
		            			myManagedCtrlbooks.removeCtrlBook(cbid);
		            			success = true;
		            			done = true;
			            },
			            error: function (data) {
			            		alert('Faild to remove control book:'+cbid+' ,reason:'+data.responseText);
			            		success = false;
			            		done = true;
			            }
			        });
					if(success==false){
						break;
					}
				}
				IBMCore.common.widget.overlay.hide('showConfirmMessagePanel_id',true);
				jQuery("#div_cb_id").html(myManagedCtrlbooks.createMyMangedCBPanel()); 
			}else{
				if(cbids.length==1){
					jQuery('#showConfirmMessagePanel_text_id').text('Are you sure to remove this control book?');
				}else{
					jQuery('#showConfirmMessagePanel_text_id').text('Are you sure to remove these selected control books ('+cbids.length+')?');
				}
				jQuery('#showConfirmMessagePanel_yes_id').attr('disabled',false);
				jQuery('#showConfirmMessagePanel_cancel_id').attr('disabled',false);
				IBMCore.common.widget.overlay.show('showConfirmMessagePanel_id');
			}
		}else{
			alert('please select a control book first.');
		}
		
    }
    
    jQuery(document).ready(function () {
    		listGeos();
    		listBusinesses();
    		listDashboardTemplates();
    		listDomains();
        listMyManagedCB();

    });


</script>

</head>
<body id="ibm-com" class="ibm-type" style="align: center">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>

	<div>
		<div>
			<div>
				<div style="float: left;">
					<h1 class="ibm-h1 ibm-light">&nbsp;&nbsp;&nbsp;My Managed control books</h1>
				</div>
				<div>
					<p class="ibm-ind-link ibm-icononly ibm-inlinelink">
						<a class="ibm-information-link" target="_blank"
							href="<%=path%>/action/portal/pagehelp?pageKey=MyControlBookAddRemove&pageName=My+control+books"
							title="Help for My control books"> Help for My Managed control books
						</a>
					</p>
				</div>
			</div>
		</div>

		<div style="width: 95%; align: center; margin-left: auto; margin-right: auto;">
			<TABLE width="100%" border="0" role="presentation">
				<TBODY>
					<TR>
						<TD style="align: center" colspan="4">
							<SPAN class="button-blue"> 
								<INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_createCtrlbookButton" value="Create" onclick="openEditCtrlbookPanel(null,'new');return false;" aria-invalid="true">&nbsp;&nbsp;								
								<INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_transferCtrlbookButton" value="Transfer Owner" aria-invalid="true" disabled>&nbsp;&nbsp;
								<INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_shareCtrlbookButton" value="Share" aria-invalid="true" disabled>&nbsp;&nbsp;
								<INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_removeCtrlbookButton" value="Remove" aria-invalid="true" onclick="removeCtrlbook();return false;">&nbsp;&nbsp;
							</SPAN>
						</TD>
					</TR>
					<TR>
						<TD colspan="4"><br>You have permission to manage following control books, please be careful to edit or remove them.</TD>
					</TR>
					<TR>
						<TD colspan="4"><br>
							<div id="div_message_id"
								style="display: none; color: #4477BB; font-weight: bold;">This is message div</div>
						</TD>
					</TR>

				</TBODY>
			</TABLE>
		</div>
		<div id="div_cb_id" style="width: 95%; align: center; margin-left: auto; margin-right: auto;"></div>

	</div>
	<!-- form -->
	<form id="ctrlbook_form_id" class="ibm-column-form" method="post" >
	
	<div class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert" id="showConfirmMessagePanel_id">
	    <h2 class="ibm-bold">Are you sure?</h2>
	    <p id='showConfirmMessagePanel_text_id'>Are you sure to remove these selected control books?</p>
	    <br>
	    <p class="ibm-btn-row">
	    <button class="ibm-btn-pri" id="showConfirmMessagePanel_yes_id" onclick="removeCtrlbook(true);return false;">Yes</button> 
	    <button class="ibm-btn-sec" id="showConfirmMessagePanel_cancel_id" onclick="IBMCore.common.widget.overlay.hide('showConfirmMessagePanel_id',true);">Cancel</button>
	    </p>            
	</div>
	
	
	<!-- edit control book panel -->	
	<div class="ibm-common-overlay ibm-overlay-alt-three" data-widget="overlay" data-type="alert" id="editCtrlbookpanel_id">
		<script type="text/javascript">
		function closeOverlayWindow(id){
			IBMCore.common.widget.overlay.hide(id,true);
		}
		
		function openOverlayWindow(id){
			IBMCore.common.widget.overlay.show(id);
		}
		
		function openEditCtrlbookPanel(ctrlbook,action){
			jQuery("#id_action").val(action);
			if(action=='edit'){
				jQuery("#id_ctrlbook_id").val(ctrlbook.id);
				jQuery("#id_ctrlbook_name").val(ctrlbook.name);
				jQuery("#id_ctrlbook_desc").val(ctrlbook.desc);
				jQuery("#id_ctrlbookhelp").val(ctrlbook.help);			
				jQuery("#id_ctrlbook_owner").val(ctrlbook.ctrlbook_owner);
				jQuery("#id_ctrlbook_backup").val(ctrlbook.ctrlbook_backup);
				jQuery("#id_target_aud").val(ctrlbook.target_aud);
				jQuery("#id_purpose").val(ctrlbook.purpose);
				jQuery("#id_request_access").val(ctrlbook.request_access);
				jQuery("#id_support_contact").val(ctrlbook.support_contact);
				if(ctrlbook.hasdashboard=='Y'){
					//jQuery("#id_hasdashboard").val("Y");
					jQuery("#id_hasdashboard").prop('checked',true).trigger('change');
				}else{
					//jQuery("#id_hasdashboard").val("N");
					jQuery("#id_hasdashboard").prop('checked',false).trigger('change');
				}
				jQuery("#id_ctrlbook_filter_id").empty();
				jQuery("#id_ctrlbook_filter_id").append(biBusinesses.toString(ctrlbook.ctrlbook_filter_id));
				jQuery("#id_ctrlbook_filter_id").val(ctrlbook.ctrlbook_filter_id);
				//
				jQuery("#id_ctrlbook_filter_type_id").empty();
				jQuery("#id_ctrlbook_filter_type_id").append(biGeos.toString(ctrlbook.ctrlbook_filter_type_id));
				jQuery("#id_ctrlbook_filter_type_id").val(ctrlbook.ctrlbook_filter_type_id);
				//
				jQuery("#id_xls_rpt_def_id").empty();
				jQuery("#id_xls_rpt_def_id").append(dashboardTemplates.toString(ctrlbook.xls_rpt_def_id));
				jQuery("#id_xls_rpt_def_id").val(ctrlbook.xls_rpt_def_id);
				//
				jQuery("#id_ctrlbook_type").val(ctrlbook.ctrlbook_type);
				if(ctrlbook.ctrlbook_type=='private'){
					jQuery("#id_ctrlbook_type_private").prop('selected',true).trigger('change');
					jQuery("#id_ctrlbook_type_public").prop('selected',false).trigger('change');
				}else{
					jQuery("#id_ctrlbook_type_private").prop('selected',false).trigger('change');
					jQuery("#id_ctrlbook_type_public").prop('selected',true).trigger('change');					
				}
				jQuery("#id_ctrlbook_status").val(ctrlbook.ctrlbook_status);
				if(ctrlbook.ctrlbook_status=='A'){
					jQuery("#id_ctrlbook_status_active").prop('selected',true).trigger('change');
					jQuery("#id_ctrlbook_status_inactive").prop('selected',false).trigger('change');
					jQuery("#id_ctrlbook_status_disabled").prop('selected',false).trigger('change');
				}else if(ctrlbook.ctrlbook_status=='I'){
					jQuery("#id_ctrlbook_status_active").prop('selected',false).trigger('change');
					jQuery("#id_ctrlbook_status_inactive").prop('selected',true).trigger('change');
					jQuery("#id_ctrlbook_status_disabled").prop('selected',false).trigger('change');
				}else if(ctrlbook.ctrlbook_status=='D'){
					jQuery("#id_ctrlbook_status_active").prop('selected',false).trigger('change');
					jQuery("#id_ctrlbook_status_inactive").prop('selected',false).trigger('change');
					jQuery("#id_ctrlbook_status_disabled").prop('selected',true).trigger('change');					
				}
				jQuery("#id_ctrlbook_expiry").val(ctrlbook.ctrlbook_expiry);
				jQuery("#id_create_time").val(ctrlbook.create_time);
				//
			}
			if(action=='new'){
				jQuery("#id_ctrlbook_id").val('0');
				jQuery("#id_ctrlbook_name").val('');
				jQuery("#id_ctrlbook_desc").val('');
				jQuery("#id_ctrlbookhelp").val('none');			
				jQuery("#id_ctrlbook_owner").val(cwa_id);
				jQuery("#id_ctrlbook_backup").val('');
				jQuery("#id_target_aud").val('');
				jQuery("#id_purpose").val('');
				jQuery("#id_request_access").val('');
				jQuery("#id_support_contact").val(cwa_id);
				//jQuery("#id_hasdashboard").val("N");
				jQuery("#id_hasdashboard").prop('checked',false).trigger('change');
				//
				jQuery("#id_ctrlbook_filter_type_id").empty();
				jQuery("#id_ctrlbook_filter_id").empty();			
				jQuery("#id_ctrlbook_filter_type_id").append(biGeos.toString('none'));
				jQuery("#id_ctrlbook_filter_id").append(biBusinesses.toString('none'));
				jQuery("#id_ctrlbook_filter_type_id").val('none');
				jQuery("#id_ctrlbook_filter_id").val('none');
				//
				jQuery("#id_xls_rpt_def_id").empty();
				jQuery("#id_xls_rpt_def_id").append(dashboardTemplates.toString('none'));
				jQuery("#id_xls_rpt_def_id").val('none');
				//
				jQuery("#id_ctrlbook_type").val('public');
				jQuery("#id_ctrlbook_type_private").prop('selected',false).trigger('change');
				jQuery("#id_ctrlbook_type_public").prop('selected',true).trigger('change');					
				jQuery("#id_ctrlbook_status").val('A');
				jQuery("#id_ctrlbook_status_active").prop('selected',true).trigger('change');
				jQuery("#id_ctrlbook_status_inactive").prop('selected',false).trigger('change');
				jQuery("#id_ctrlbook_status_disabled").prop('selected',false).trigger('change');
				var now = new Date();
				jQuery("#id_ctrlbook_expiry").val(now.setFullYear(now.getFullYear() + 1,now.getMonth(),now.getDate()));
				jQuery("#id_create_time").val(now.getTime());
			}
			//
			jQuery("#id_ctrlbook_owner").attr("readonly","readonly");
			openOverlayWindow('editCtrlbookpanel_id');
			return false;
		}
		
		function saveCtrlbook(){
			
			var action = jQuery("#id_action").val();
			var cbid = jQuery("#id_ctrlbook_id").val();
			var ctrlbookDetail = {};
			var help_url='<%=path%>/action/portal/controlbook/help?id=';
			//
			if(action=='edit'){
				ctrlbookDetail['ctrlbook_id'] = cbid;
			}else{
				ctrlbookDetail['ctrlbook_id'] = '0';
			}
			//
			ctrlbookDetail['ctrlbook_name'] = jQuery("#id_ctrlbook_name").val();
			if(ctrlbookDetail['ctrlbook_name']==''){
				alert('Please give a control book name.');
				return false;
			}
			if(ctrlbookDetail['ctrlbook_name'].length>30){
				alert('control book name is too long.');
				return false;
			}
			//
			ctrlbookDetail['ctrlbook_desc'] = jQuery("#id_ctrlbook_desc").val();
			if(ctrlbookDetail['ctrlbook_desc'].length>512){
				alert('control book description is too long.');
				return false;
			}
			ctrlbookDetail['ctrlbook_owner'] = jQuery("#id_ctrlbook_owner").val();
			if(ctrlbookDetail['ctrlbook_owner']==''){
				alert('please give an owner for this control book.');
				return false;
			}
			if(ctrlbookDetail['ctrlbook_owner'].length>254){
				alert('control book owner is too long.');
				return false;
			}
			//
			ctrlbookDetail['ctrlbook_backup'] = jQuery("#id_ctrlbook_backup").val();
			//if(ctrlbookDetail['ctrlbook_backup']==''){
			//	alert('please input a control book backup.');
			//	return false;
			//}
			if(ctrlbookDetail['ctrlbook_backup'].length>254){
				alert('control book backup owner is too long.');
				return false;
			}
			//
			ctrlbookDetail['ctrlbook_filter_type_id'] = jQuery("#id_ctrlbook_filter_type_id").val();
			if(ctrlbookDetail['ctrlbook_filter_type_id']==''||ctrlbookDetail['ctrlbook_filter_type_id']=='none'){
				alert('please select an Geo filter.');
				return false;
			}

			ctrlbookDetail['ctrlbook_filter_id'] = jQuery("#id_ctrlbook_filter_id").val();
			if(ctrlbookDetail['ctrlbook_filter_id']==''||ctrlbookDetail['ctrlbook_filter_id']=='none'){
				alert('please select a Business filter.');
				return false;
			}
			//
			ctrlbookDetail['target_aud'] = jQuery("#id_target_aud").val();
			if(ctrlbookDetail['target_aud']==''){
				alert('please input some description for target audience.');
				return false;
			}
			if(ctrlbookDetail['target_aud'].length>128){
				alert('control book audience is too long.');
				return false;
			}
			ctrlbookDetail['purpose'] = jQuery("#id_purpose").val();
			if(ctrlbookDetail['purpose']==''){
				alert('please give a purpose for this control book.');
				return false;
			}
			if(ctrlbookDetail['purpose'].length>512){
				alert('control book purpose is too long.');
				return false;
			}				
			ctrlbookDetail['request_access'] = jQuery("#id_request_access").val();
			if(ctrlbookDetail['request_access']==''){
				alert('please give some description for how to request access to this control book.');
				return false;
			}
			if(ctrlbookDetail['request_access'].length>512){
				alert('description for how to request access is too long.');
				return false;
			}
			ctrlbookDetail['support_contact'] = jQuery("#id_support_contact").val();
			if(ctrlbookDetail['support_contact']==''){
				alert('please input a contact for this control book.');
				return false;
			}
			if(ctrlbookDetail['support_contact'].length>128){
				alert('control book supporting contact is too long.');
				return false;
			}
			//
			ctrlbookDetail['ctrlbook_help'] = help_url;
			if(ctrlbookDetail['ctrlbook_help'].length>110){
				alert('control book help file is too long.');
				return false;
			}
			//
			if(jQuery("#id_hasdashboard").prop('checked')){
				ctrlbookDetail['hasdashboard'] = 'Y';
			}else{
				ctrlbookDetail['hasdashboard'] = 'N';
			}
			//
			ctrlbookDetail['xls_rpt_def_id'] = jQuery("#id_xls_rpt_def_id").val();
			if(ctrlbookDetail['hasdashboard']=='Y'){
				if(ctrlbookDetail['xls_rpt_def_id']=='none'||ctrlbookDetail['xls_rpt_def_id']==''){
					alert('please set dashboard template.');
					return false;
				}
			}
			//
			ctrlbookDetail['isupdate'] = 'Y';
			ctrlbookDetail['ctrlbook_filter_type_name'] = jQuery("#id_ctrlbook_filter_type_id option:selected").text();
			ctrlbookDetail['ctrlbook_filter_name'] = jQuery("#id_ctrlbook_filter_id option:selected").text();
			//
			ctrlbookDetail['ctrlbook_type'] = jQuery('#id_ctrlbook_type').val();
			ctrlbookDetail['ctrlbook_status'] = jQuery('#id_ctrlbook_status').val();
			ctrlbookDetail['ctrlbook_expiry'] = parseInt(jQuery('#id_ctrlbook_expiry').val());
			ctrlbookDetail['create_time'] = parseInt(jQuery('#id_create_time').val());
			//
			jQuery('#id_saveCtrlbookButton').attr('disabled',true);
			jQuery('#id_saveCtrlbookButton').val('Saving...');
            jQuery.ajax({
                type: 'POST',
                url: '<%=path%>/action/portal/controlbook?cwa_id='+cwa_id+'&uid='+uid+'&action='+action,
                //async : false,
                data: JSON.stringify(ctrlbookDetail),
                contentType: "application/json",
                dataType: "json",
                success: function(data) {
	                	if(data>0){
	                		ctrlbookDetail['ctrlbook_id'] = data;
	                		ctrlbookDetail['ctrlbook_help'] = ctrlbookDetail['ctrlbook_help'] + data;
	                		jQuery("#id_ctrlbook_id").val(data);
	                		//
	                		selectedBICtrlbook = new BIctrlbook(ctrlbookDetail, 'cb_myManaged');
	                    myManagedCtrlbooks.refreshCtrlbook(selectedBICtrlbook);
	                    jQuery("#div_cb_id").empty();
	                    jQuery("#div_cb_id").html(myManagedCtrlbooks.createMyMangedCBPanel());
		        			jQuery('#id_saveCtrlbookButton').attr('disabled',false);
		        			jQuery('#id_saveCtrlbookButton').val('Save');
		        			jQuery("#id_action").val('edit');
	                		alert("saved control book successfully.");
	                	}else{
	                		alert("Failed to save control book, please try later.");
	                	}
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
	        			jQuery('#id_saveCtrlbookButton').attr('disabled',false);
	        			jQuery('#id_saveCtrlbookButton').val('Save');
                    alert("Failed to save control book, error code:" + XMLHttpRequest.status + ",error message:" + textStatus);
                }
            });
			
		}
		
		var pre_controlbook_Bireports = new BIReports('pre_controlbook_Bireports','cb');
		
		function showDashboard() {
			
			var cbid = jQuery("#id_ctrlbook_id").val();
			
			if(cbid<1){
				alert('please save this control book first.');
				return false;
			}
			
			//
			jQuery('#show_dashboard_template_id').empty();
			jQuery('#show_dashboard_template_id').html('<p class="loading"/>');
			pre_controlbook_Bireports.empty();
			openOverlayWindow('preview_dashboardPanel_id');
			//
			var timeid=(new Date()).valueOf();
			//
			jQuery.ajax({
					type : 'GET',
					//async : false,
					url : '<%=path%>/action/portal/controlbook/getCBReportList/' + cwa_id + '/' + uid + '/' + cbid + '?timeid=' + timeid,
					success : function(data) {
						if (data != null && data.length > 0) {
							 for (var i = 0; i < data.length; i++) {
								cb_report = new BIReport('pre_controlbook_Bireports','cb',data[i]);
								pre_controlbook_Bireports.addReport(cb_report);
							 }
						} else {
							alert('There are not any reports in control book.');
							return false;
						}
					},
					error : function(error) {
						alert('Failed to get report list of this control book.');
						return false;
					}
			});
			//
			jQuery.ajax({
					type : 'GET',
					//async : false,
					url : '<%=path%>/action/portal/controlbook/getDashboard/' + cwa_id + '/' + uid+'/'+cbid+'/pre_controlbook_Bireports/cb' + '?timeid=' + timeid,					 
					success : function(data) {
						jQuery('#show_dashboard_template_id').empty();
						jQuery('#show_dashboard_template_id').html(data);
					},
					error : function(error){
						alert('Failed to generate dashboard template for this control book.');
						return false;
					}
			});
		}
		//
		function setPermissionButton(){
			var ctrlbook_type = jQuery('#id_ctrlbook_type').val();
			if(ctrlbook_type=='private'){
				jQuery('#id_setPermissionButton').attr('disabled',false);
			}else{
				jQuery('#id_setPermissionButton').attr('disabled',true);
			}
		}

		</script>
	    <div align="center">
	    		
	    		<input type="hidden" id="id_action" name="ctrlbook_action" value="create"/>
	    		<input type="hidden" id="id_ctrlbookhelp" name="ctrlbookhelp" value=""/>
	    		<input type="hidden" id="id_ctrlbook_expiry" name="ctrlbook_expiry" value=""/>
	    		<input type="hidden" id="id_create_time" name="create_time" value=""/>
	    		<table border="0">
		    		<tr>
		    		<td>ID</td>
		    		<td>
		    		
		    		<input type="text" id="id_ctrlbook_id" name="ctrlbook_id" size="10" value="" readonly/>
		    		&nbsp;&nbsp;&nbsp;<label for="id_ctrlbook_type" >Type<span class="ibm-required">*</span></label>&nbsp;
		    		<select id="id_ctrlbook_type" name="ctrlbook_type" onchange="setPermissionButton(); return false;">
		    		<option value="public" id="id_ctrlbook_type_public">Public</option>
		    		<option value="private" id="id_ctrlbook_type_private">Private</option>
		    		</select>
		    		&nbsp;&nbsp;&nbsp;<label for="id_ctrlbook_status" >Status<span class="ibm-required">*</span></label>&nbsp;
		    		<select id="id_ctrlbook_status" name="ctrlbook_status">
		    		<option value="A" id="id_ctrlbook_status_active">Active</option>
		    		<option value="I" id="id_ctrlbook_status_inactive">Inactive</option>
		    		<option value="D" id="id_ctrlbook_status_disabled">Disabled</option>
		    		</select>
		    		
		    		</td>
		    		</tr>
		    		<tr>
		    		<td>Name <span class="ibm-required">*</span></td>
		    		<td><input type="text" id="id_ctrlbook_name" name="ctrlbook_name" value="" size="30"/></td>
		    		</tr>
		    		<tr>
		    		<td>Description</td>
		    		<td><textarea id="id_ctrlbook_desc" name="ctrlbook_desc" cols="60" rows="2" required ></textarea></td>
		    		</tr>
		    		<tr>
		    		<td>Owner <span class="ibm-required">*</span></td>
		    		<td><input type="text" id="id_ctrlbook_owner" name="ctrlbook_owner" value="" size="30"/></td>
		    		</tr>
		    		<tr>
		    		<td>Backup</td>
		    		<td><input type="text" id="id_ctrlbook_backup" name="ctrlbook_backup" value="" size="30"/></td>
		    		</tr>
		    		<tr>
		    		<td>GEO <span class="ibm-required">*</span></td>
		    		<td>
		    		<select name="ctrlbook_filter_type_id" id="id_ctrlbook_filter_type_id" class="ibm-styled" title="business" style="width: 300px;">
		    		
		    		</select>

		    		</td>
		    		</tr>
		    		<tr>
		    		<td>Business <span class="ibm-required">*</span></td>
		    		<td>		    		
		    		<select name="ctrlbook_filter_id" id="id_ctrlbook_filter_id" class="ibm-styled" title="geography" style="width: 300px;">
		    		
		    		</select>
		    		</td>
		    		</tr>	    		
		    		<tr>
		    		<td>Target Audience <span class="ibm-required">*</span></td>
		    		<td><textarea id="id_target_aud" name="target_aud" cols="60" rows="1" required ></textarea></td>
		    		</tr>	    		
		    		<tr>
		    		<td>Purpose <span class="ibm-required">*</span></td>
		    		<td><textarea id="id_purpose" name="purpose" cols="60" rows="2" required ></textarea></td>
		    		</tr>	    		
		    		<tr>
		    		<td>How to request access <span class="ibm-required">*</span></td>
		    		<td><textarea id="id_request_access" name="request_access" cols="60" rows="2" required ></textarea></td>
		    		</tr>	    		
		    		<tr>
		    		<td>Support contact <span class="ibm-required">*</span></td>
		    		<td><textarea id="id_support_contact" name="support_contact" cols="60" rows="1" required ></textarea></td>
		    		</tr>	    		
		    		<tr>
		    		<td><label class="ibm-column-field-label">Has dashboard?</label></td>
		    		<td>
		    			<span class="ibm-input-group">
            				<span class="ibm-checkbox-wrapper">
                				<input class="ibm-styled-checkbox" data-init="false" id="id_hasdashboard" name="hasdashboard" type="checkbox" value="Y" /> <label for="id_hasdashboard" class="ibm-field-label"></label>
            				</span>
            			
            				<span>
            				<label for="id_xls_rpt_def_id" >Dashboard template file</label>
		    					<select name="xls_rpt_def_id" id="id_xls_rpt_def_id" style="width: 200px;" title="dashboard template">
		    		
		    					</select>
		    				</span> 
            			</span>	
		    		</td>
		    		</tr>
		    		<tr>
		    		<td colspan="2" align="right">
		    		<hr>
		    			<INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_saveCtrlbookButton" value="Save" onclick="saveCtrlbook();return false;" aria-invalid="true">&nbsp;&nbsp;								
					<INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_manageCtrlbookReportsButton" value="Manage Reports" onclick="manageReports();return false;" aria-invalid="true">&nbsp;&nbsp;
					<INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_previewCtrlbookDashboardButton" value="Preview Dashboard" onclick="showDashboard();return false;" aria-invalid="true">&nbsp;&nbsp;
					<INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_setPermissionButton" value="Share" onclick="shareCtrlbook();return false;" aria-invalid="true" disabled>&nbsp;&nbsp;
					<INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_BackButton" value="Back" onclick="closeOverlayWindow('editCtrlbookpanel_id');return false;" aria-invalid="true">&nbsp;&nbsp;		    		
		    		</td>
		    		</tr>
	    		</table>
	    </div>
	    <!-- end edit control book panel -->
	    <!-- manage control book reports panel -->
	    <div class="ibm-common-overlay ibm-overlay-alt-three" style="width:100%;height:100%;border:1px solid #000" data-widget="overlay" data-type="alert" id="manageReportsPanel_id">
		    <script type="text/javascript">
		    var cbReports = new CBReports('cbReports');
		    
	    		function manageReports(){
	    			var cb_id = jQuery("#id_ctrlbook_id").val();
	    			if(cb_id=='0'){
	    				alert('please save new control book first.');
	    				return false;
	    			}
	    			//
				jQuery("#id_domain").empty();
				jQuery("#id_domain").append(domains.toString('none'));
				jQuery("#id_domain").val('none');
				//listing control book reports
				
				listCBReports(cb_id,cwa_id,uid);
				
	    			//
	    			closeOverlayWindow('editCtrlbookpanel_id');
	    			openOverlayWindow('manageReportsPanel_id');
	    			return false;
	    		}
	    		//// Refresh selected control book list
		    function listCBReports(cbid,cwa_id,uid) {
				var timeid = (new Date()).valueOf();
				cbReports.empty();
				jQuery("#id_CBReports_panel").empty();
				jQuery("#id_CBReports_panel").html('<div class="loading"></div>');
		        jQuery.ajax({
		            type: 'GET', url: '<%=path%>/action/portal/controlbook/reports?cbid='+cbid+'&cwa_id=' + cwa_id + '&uid=' + uid + '&timeid=' + timeid,
		            success: function (data) {
		                if (data.length > 0) {
		                    var cbReport;
		                    for (var i = 0; i < data.length; i++) {
		                    		cbReport = new CBReport(data[i]);
		                    		cbReports.addReport(cbReport);
		                    }
		                }
		                jQuery('#id_CBReports_panel').empty();
		                jQuery('#id_CBReports_panel').append(cbReports.toHtmlView());
		            },
	    	            error: function (XMLHttpRequest, textStatus, errorThrown) {
		    	            	jQuery('#id_CBReports_panel').empty();
		    	            	jQuery("#id_CBReports_panel").append('<P>Failed to load control book reports.');
		   	            	alert("Failed to load Control book reports, error code:" + XMLHttpRequest.status + ",error message:" + textStatus);
	   	            }
		        });
		    }
	    		//searching reports.
	    		var searchResult = null;
	    		function searchReport(){
	    			var domain_key=jQuery("#id_domain").val();
	    			if(domain_key=='none'){
	    				alert('please select one domain to search.');
	    				return;
	    			}
	    			var keyworkds=jQuery('#id_search_keywords').val();
	    			if(keyworkds==''||!keyworkds||jQuery.trim(keyworkds)==''){
	    				alert('please input keywords to search.');
	    				return;
	    			}
	    			
	    			jQuery("#id_searching_result_panel").empty();
	            jQuery("#id_searching_result_panel").append('<div class="loading"></div>');
	            jQuery("#id_searchButton").attr('disabled', true);
	    			var timeid = (new Date()).valueOf();
	    	        jQuery.ajax({
	    	            type: 'GET', url: '<%=path%>/action/portal/search/searchDomain/'+cwa_id+'/'+uid+'/'+domain_key+'/'+keyworkds+'/1/20?timeid=' + timeid,
	    	            success: function (data) {
	    	            		searchResult = new SearchResult('searchResult',domain_key,data[0].page,data[0].page_row,data[0].nextPage,data[0].cwa_id,data[0].uid,data[0].keywords,data[0].search_report_types);
	    	            		if(data[0].reports&&data[0].reports.length>0){
	    	            			for(var i=0;i<data[0].reports.length;i++){
	    	            				var report = new BISearchReport(data[0].reports[i]);
	    	            				searchResult.addReport(report);
	    	            			}
	    	            		}
	    	                jQuery("#id_searching_result_panel").empty();
	    	                jQuery("#id_searching_result_panel").append(searchResult.toHtmlView());
	    	                jQuery("#id_searchButton").attr('disabled', false);
	    	                jQuery("#id_searchButton").val('Search');
	    	            },
	    	            error: function (XMLHttpRequest, textStatus, errorThrown) {	    	                
	    	             	jQuery("#id_searchButton").attr('disabled', false);
	    	             	jQuery("#id_searchButton").val('Search');
	    	             	jQuery("#id_searching_result_panel").empty();
	    	             	jQuery("#id_searching_result_panel").append('<p>Failed to search reports.');
	    	            	 	alert("Failed to search reports, error code:" + XMLHttpRequest.status + ",error message:" + textStatus);
	    	            }
	    	        });
	    		}
	    		
	    		function addCBReport(biReport){
	    			var cb_id = jQuery("#id_ctrlbook_id").val();
	    			var cbReport = cbReports.getReport(cb_id,biReport.reportTypeCD,biReport.rptObjID);
	    			if(cbReport){
	    				if(cbReport.status=='deleted'){
	    					cbReport.orderNo=cbReports.getNextOrderNo();
	    					cbReport.status='changed';	    					
	    					cbReports.updateReport(cbReport);
	    					cbReports.sort();
	    				}else{
	    					alert('This report has been added into this control book');
	    					return false;
	    				}
	    			}else{
	    				cbReport = new CBReport();
	    				cbReport.status='new';//saved,new,changed,deleted
	    				cbReport.id.rptTypeCd=biReport.reportTypeCD;
	    				cbReport.id.rptAccessId=biReport.rptObjID;
	    				cbReport.id.ctrlbookId=cb_id;
	    				cbReport.cognosRptType=biReport.objectClass;
	    				cbReport.displayText=biReport.rptName;
	    				cbReport.domainKey=biReport.domain_Key;
	    				cbReport.helpFileName=biReport.helpDoc;
	    				//cbReport.mailTime=biReport.;
	    				cbReport.orderNo=cbReports.getNextOrderNo();
	    				cbReport.parentFolderId=biReport.parentID;
	    				cbReport.referObjectclass=biReport.refer_ObjectClass;
	    				cbReport.referObjectid=biReport.refer_Objectid;
	    				cbReport.rptDesc=biReport.rptDesc;
	    				cbReport.rptName=biReport.rptName;
	    				cbReport.searchPath=decodeURIComponent(biReport.rptPath).replace(/\+/g,' ');
	    				cbReports.addReport(cbReport);
	    			}
                jQuery('#id_CBReports_panel').empty();
                jQuery('#id_CBReports_panel').append(cbReports.toHtmlView());

	    		}
	    		
	    		function saveCBReports(){
	    			jQuery("#id_SaveButton2").attr('disabled', true);
	    			jQuery("#id_SaveButton2").val('Saving...');
	    			var cb_id = jQuery("#id_ctrlbook_id").val();
	    			jQuery.ajax({
	                    type: 'POST',
	                    url: '<%=path%>/action/portal/controlbook/reports?cbid='+cb_id+'&cwa_id='+cwa_id+'&uid='+uid,
	                    //async : false,
	                    data: JSON.stringify(cbReports.cbReports),
	                    //data: {data:JSON.stringify(cbReports.cbReports)},
	                    contentType: "application/json",
	                    dataType: "json",
	                    success: function(data) {
			    	    			jQuery("#id_SaveButton2").attr('disabled', false);
	    			    			jQuery("#id_SaveButton2").val('Save');
		    	                	if(data.length>0){
		    	                		cbReports.empty();
	    		                    var cbReport;
	    		                    for (var i = 0; i < data.length; i++) {
	    		                    		cbReport = new CBReport(data[i]);
	    		                    		cbReports.addReport(cbReport);
	    		                    }
	    			                jQuery('#id_CBReports_panel').empty();
	    			                jQuery('#id_CBReports_panel').append(cbReports.toHtmlView());	    		                    
		    	                	}
		    	                	//
			                alert("Saved control book successfully.");
	                    },
	                    error: function(XMLHttpRequest, textStatus, errorThrown) {
			    	    			jQuery("#id_SaveButton2").attr('disabled', false);
				    			jQuery("#id_SaveButton2").val('Save');
	                        alert("Failed to save control book, error code:" + XMLHttpRequest.status + ",error message:" + textStatus);
	                    }
	                });
	    		}
	    		
	    		</script>
		    
		    <table style="width:100%;height:100%;border:0px solid #F0F">
		    <tr>
		    <td style="width:45%;vertical-align:top;">
			    	<div style="height:40px;Position:relative;top:5px;border:0px solid #F00;">
				    <select name="domain" id="id_domain" value="none" class="ibm-styled" title="reports domain" style="width: 150px;">
				    </select>
				    <input type="text" name="search_keyword" id="id_search_keywords" value="" style="width:120px;" placeholder="keywords"/>
				    <INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_searchButton" value="Search" onclick="searchReport();return false;">&nbsp;&nbsp;
				    <hr>		    	
			    	</div>
		    		<div id="id_searching_result_panel" style="overflow-y:scroll;height:330px;Position:relative;top:5px;border:0px solid #F0F;">
		    		<p>please input some keywords to search reports.
		    		</div>
		    </td>
		    <td style="width:55%;vertical-align:top;">		    
			    <div id="id_CBReports_panel" style="overflow-y:scroll;Position:relative;top:5px;height:378px;border:0px solid #F00">
				  
			    </div>
		    </td>
		    </tr>
		    <tr>
		    <td colspan="2" style="height:20px;">
		    <hr/>
		    		    <INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_SaveButton2" value="Save" onclick="saveCBReports();return false;" aria-invalid="true">&nbsp;&nbsp;
		    		    <INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_BackButton2" value="Back" onclick="closeOverlayWindow('manageReportsPanel_id');openOverlayWindow('editCtrlbookpanel_id');return false;" aria-invalid="true">&nbsp;&nbsp;
		    </td>
		    </tr>
		    </table>
		    		
		    
	    </div>
	    <!-- the end of manage control book reports panel  -->
	    
	    	<!-- dashboard template preview -->
	    <div class="ibm-common-overlay ibm-overlay-alt-two" style="width:100%;height:600px;border:1px solid #000" data-widget="overlay" data-type="panel" id="preview_dashboardPanel_id">
		    <div id="show_dashboard_template_id">
		    
		    
		    
		    </div>	    
	    </div>
	    <!-- the end for dashboard template preview-->
	    
	    	<!-- share control book panel -->
	    <div class="ibm-common-overlay ibm-overlay-alt-two" style="width:100%;height:100%;border:1px solid #000" data-widget="overlay" data-type="alert" id="share_controlbook_overlay_id">
	    		<script type="text/javascript">
	    		//
	    		function shareCtrlbook(){
	    			var cb_id = jQuery("#id_ctrlbook_id").val();
	    			if(cb_id=='0'){
	    				alert('please save new control book first.');
	    				return false;
	    			}
				//listing control book reports
				listCBPermission(cb_id,cwa_id,uid);
	    			//
	    			closeOverlayWindow('editCtrlbookpanel_id');
	    			openOverlayWindow('share_controlbook_overlay_id');
	    			return false;
	    		}
	    		
	    		var cbPermissions = new CBPermissions('cbPermissions');
	    		function listCBPermission(cbid,cwa_id,uid){
				var timeid = (new Date()).valueOf();
				cbPermissions.empty();
				jQuery("#id_share_controlbook_permission_panel").empty();
				jQuery("#id_share_controlbook_permission_panel").html('<div class="loading"></div>');
		        jQuery.ajax({
		            type: 'GET', url: '<%=path%>/action/portal/controlbook/permissions?cbid='+cbid+'&cwa_id=' + cwa_id + '&uid=' + uid + '&timeid=' + timeid,
		            success: function (data) {
		                if (data.length > 0) {
		                    var cbPermission;
		                    for (var i = 0; i < data.length; i++) {
		                    		cbPermission = new CBPermission(cbid,i,data[i]);
		                    		cbPermissions.addPermission(cbPermission);
		                    }
		                }
		                jQuery('#id_share_controlbook_permission_panel').empty();
		                jQuery('#id_share_controlbook_permission_panel').append(cbPermissions.toHtmlView());
		            },
	    	            error: function (XMLHttpRequest, textStatus, errorThrown) {
		    	            	jQuery('#id_share_controlbook_permission_panel').empty();
		    	            	jQuery("#id_share_controlbook_permission_panel").append('<P>Failed to load control book permission.');
		   	            	alert("Failed to load Control book reports, error code:" + XMLHttpRequest.status + ",error message:" + textStatus);
	   	            }
		        });
	    		}
	    		
	    		var searchingPermissions = new CBPermissions('searchingPermissions');
	    		//
	    		function searchPermission(){
	    			var cbid = jQuery("#id_ctrlbook_id").val();
	    			var search_type = jQuery('#id_permission_search_type').val();
	    			var search_field = jQuery('#id_permission_search_filed').val();
	    			var search_keyword = jQuery('#id_search_permission_keyword').val();
	    			if(jQuery.trim(search_keyword)==''){
	    				alert('please input some name for searching.');
	    				return;
	    			}
	    			//
	    			var searchMap = {};
	    			searchMap.search_type = search_type;
	    			searchMap.search_field = search_field;
	    			searchMap.search_keyword = search_keyword;
	    			
				var timeid = (new Date()).valueOf();
				searchingPermissions.empty();
				jQuery('#id_permission_searchButton').attr('disabled',true);
				jQuery("#id_searching_permission_result_panel").empty();
				jQuery("#id_searching_permission_result_panel").html('<div class="loading"></div>');				
	    			jQuery.ajax({
			            type: 'POST', 
			            url: '<%=path%>/action/portal/security/searchBluepagesForCB?timeid=' + timeid,
			            data: JSON.stringify(searchMap),
	                    contentType: "application/json",
	                    dataType: "json",
			            success: function (data) {
			                if (data.length > 0) {
			                    var searchPermission;
			                    for (var i = 0; i < data.length; i++) {
			                    		searchPermission = new CBPermission(cbid,i,data[i]);
			                    		searchingPermissions.addPermission(searchPermission);
			                    }
			                }
			                jQuery('#id_searching_permission_result_panel').empty();
			                jQuery('#id_searching_permission_result_panel').append(searchingPermissions.toHtmlView());
			                jQuery('#id_permission_searchButton').attr('disabled',false);
			            },
		    	            error: function (XMLHttpRequest, textStatus, errorThrown) {		    	            	
			    	            	jQuery('#id_searching_permission_result_panel').empty();
			    	            	jQuery("#id_searching_permission_result_panel").append('<P>Failed to search bluepages.');
			    	            	jQuery('#id_permission_searchButton').attr('disabled',false);
			   	            	alert("Failed to search bluepages, error code:" + XMLHttpRequest.status + ",error message:" + XMLHttpRequest.responseText);
		   	            }
			        });
	    		}
	    		
	    		function saveCBPermission(){
	    			var cbid = jQuery("#id_ctrlbook_id").val();
    				jQuery('#id_SaveButton3').attr('disabled',true);
	    			jQuery.ajax({
			            type: 'POST',
			            url: '<%=path%>/action/portal/controlbook/permissions?cbid=' + cbid+'&cwa_id='+cwa_id+'&uid='+uid,
			            data: JSON.stringify(cbPermissions.permissions),
	                    contentType: "application/json",
	                    dataType: "json",
			            success: function (data) {
			            	alert(data);
			                jQuery('#id_SaveButton3').attr('disabled',false);
			            },
		    	            error: function (XMLHttpRequest, textStatus, errorThrown) {
			    	            	jQuery('#id_SaveButton3').attr('disabled',false);
			   	            	alert("Failed to save permission setting, error code:" + XMLHttpRequest.status + ",error message:" + XMLHttpRequest.responseText);
		   	            }
			        });
	    		}
	    		
	    		function addCBPermission(){
	    			var selectedPermissions = jQuery('[name="cbPermission_checkbox_searchingPermissions_children"]:checked');
	    			if(selectedPermissions.length<1){
	    				alert('please select one group/user first.');
	    				return;
	    			}
	    			
	    			for(var i=0;i<selectedPermissions.length;i++){
	    				var permission_id = selectedPermissions[i].value;
	    				var permission = searchingPermissions.getPermission(permission_id);
	    				if(permission!=null){
	    					cbPermissions.refreshPermission(permission);
	    					jQuery('#'+selectedPermissions[i].id).prop('checked',false);
	    				}
	    			}
                jQuery('#id_share_controlbook_permission_panel').empty();
                jQuery('#id_share_controlbook_permission_panel').append(cbPermissions.toHtmlView());
	    		}
	    		
	    		function removeCBPermission(){
	    			var selectedPermissions = jQuery('[name="cbPermission_checkbox_cbPermissions_children"]:checked');
	    			if(selectedPermissions.length<1){
	    				alert('please select one group/user first.');
	    				return;
	    			}
	    			
	    			for(var i=0;i<selectedPermissions.length;i++){
	    				var permission_id = selectedPermissions[i].value;
	    				var permission = cbPermissions.getPermission(permission_id);
	    				if(permission!=null){
	    					cbPermissions.removePermission(permission);
	    				}
	    			}
	    			cbPermissions.resetOrder();
                jQuery('#id_share_controlbook_permission_panel').empty();
                jQuery('#id_share_controlbook_permission_panel').append(cbPermissions.toHtmlView());
	    		}
	    		
	    		function setSearchField(){
	    			var search_type = jQuery('#id_permission_search_type').val();
	    			jQuery('#id_permission_search_filed').empty();
	    			if(search_type=='user'){
	    				jQuery('#id_permission_search_filed').append('<option value="user_name" selected >Name</option>');
	    				jQuery('#id_permission_search_filed').append('<option value="user_notes">Notes Mail</option>');
	    				jQuery('#id_permission_search_filed').append('<option value="user_cwa">Intranet ID</option>');
	    				jQuery('#id_permission_search_filed').append('<option value="user_uid">Serial Number</option>');
	    			}else{
	    				jQuery('#id_permission_search_filed').append('<option value="group_name" selected>Group Name</option>');
	    				jQuery('#id_permission_search_filed').append('<option value="group_owner_cwa" >Owner Intranet ID</option>');
	    				jQuery('#id_permission_search_filed').append('<option value="group_owner_uid" >Owner Serial Number</option>');
	    			}
	    		}
	    		
	    		</script>	
		    <div id="share_controlbook_panel_id">
				<table style="width:100%;height:100%;border:0px solid #F0F">
					<tr>
						<td colspan="2"> 
							<div style="height:40px;Position:relative;top:5px;border:0px solid #F00;">
							    <select name="permission_search_type" id="id_permission_search_type" value="user" class="ibm-styled" title="search domain" style="width: 60px;" onchange="setSearchField();return false;">
							    <option value="user" selected>User</option>
							    <option value="group">Group</option>
							    </select>
							    <select name="permission_search_field" id="id_permission_search_filed" value="user" class="ibm-styled" title="search field" style="width: 160px;">
								    <option value="user_name" selected>Name</option>
								    <option value="user_notes">Notes Mail</option>
								    <option value="user_cwa">Intranet ID</option>
								    <option value="user_uid">Serial Number</option>
							    </select>							    
							    <input type="text" name="search_permission_keyword" id="id_search_permission_keyword" value="" style="width:240px;" placeholder="name"/>
							    <INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_permission_searchButton" value="Search" onclick="searchPermission();return false;">&nbsp;&nbsp;
							    <hr>		    	
						    	</div>
						</td>
					</tr>
				    <tr>
					    <td style="width:50%;vertical-align:top;">
					    		<div id="id_searching_permission_result_panel" style="overflow-y:scroll;height:330px;Position:relative;top:5px;border:0px solid #F0F;">
					    		<p>please input a user/group name to search.
					    		</div>
					    </td>
					    <td style="width:50%;vertical-align:top;">		    
						    <div id="id_share_controlbook_permission_panel" style="overflow-y:scroll;Position:relative;top:5px;height:330px;border:0px solid #F00">
							  
						    </div>
					    </td>
				    </tr>
				    <tr>
					    <td colspan="2" style="height:20px;">
					    		<hr/>
				    		    <INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_add_permission_Button" value="Add" onclick="addCBPermission();return false;">&nbsp;&nbsp;
				    		    <INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_remove_permission_Button" value="Remove" onclick="removeCBPermission();return false;">&nbsp;&nbsp;
				    		    <INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_SaveButton3" value="Save" onclick="saveCBPermission();return false;" aria-invalid="true">&nbsp;&nbsp;
				    		    <INPUT class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="id_BackButton3" value="Back" onclick="closeOverlayWindow('share_controlbook_overlay_id');openOverlayWindow('editCtrlbookpanel_id');return false;" aria-invalid="true">&nbsp;&nbsp;
					    </td>
				    </tr>
			    </table>
		    </div>	    
	    </div>
	    <!-- the end for share control book panel-->
	    
	    
	    
	    </form>
	</div>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>