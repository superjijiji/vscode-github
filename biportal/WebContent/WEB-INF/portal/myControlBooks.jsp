<script type="text/javascript">
<% String path = request.getContextPath(); %>
var cwa_id = '${requestScope.cwa_id}';
var uid = '${requestScope.uid}';
var controlbook_cblist;
var cb_lastAccess = null;
var controlbook_rplist;
var controlbook_Bireports = null;
var controlbook_dashboard;	
var cb_link_path  = "<%=request.getContextPath()%>";
var cb_currentCB = null;
var cb_help = '';
var cb_navigatorTab = '';
var cb_rptlistTab = '';

jQuery(document).ready(function() {
		cb_refresh();
});

function cb_refresh() {
	jQuery("#controlbook_refresh_id").attr('onClick','');
	jQuery("#controlbook_cblist").empty();
	jQuery("#cb_dyntabs_head").empty();
	jQuery("#cb_dyntabs_body").empty();
	jQuery("#cb_dyntabs_body").append("<img id=\"mycontrolbookLoading\" src='"+cb_link_path+"/images/ajax-loader.gif' />");
	controlbook_getlastAccessCB(cwa_id, uid);
	controlbook_getControlbooklist(cwa_id, uid);
	jQuery("#controlbook_refresh_id").attr('onClick','cb_refresh();return false;');

}

function controlbook_getlastAccessCB(cwa_id, uid) {
    var timeid=(new Date()).valueOf();
	jQuery.ajax({
			type : 'GET',
			async : false,
			url : '<%=request.getContextPath()%>/action/portal/usage/lastAccessCB/' + cwa_id + '/' +uid + '?timeid=' + timeid,
	  	success : function(data) {
		 cb_lastAccess = data;
	   },
	   error : function(error){
	   	cb_lastAccess = null;
	   }
   });
}

function controlbook_getControlbooklist(cwa_id, uid) {
	var allControlBooks = '';
	cb_currentCB = null;
	var timeid=(new Date()).valueOf();
	jQuery.ajax({
		type:'GET',url:'<%=request.getContextPath()%>/action/portal/controlbook/getControlbooklist/' + cwa_id + '/' + uid + '?timeid=' + timeid,
		success : function(data) {
			controlbook_cblist = data;
			if(controlbook_cblist!=null&&controlbook_cblist.length>0) {
			    var selected = false;
				for(var i=0;i<controlbook_cblist.length;i++){
				    if (cb_lastAccess != null && cb_lastAccess.ctrlbookId != null && cb_lastAccess.ctrlbookId == controlbook_cblist[i].ctrlbookId){
				        allControlBooks +="<option value='"+controlbook_cblist[i].ctrlbookId+"' selected=\"selected\">"+controlbook_cblist[i].ctrlbookName+"</option>";
				        selected = true;
				        cb_currentCB = controlbook_cblist[i];
				    } else {
				    	allControlBooks +="<option value='"+controlbook_cblist[i].ctrlbookId+"'>"+controlbook_cblist[i].ctrlbookName+"</option>";
				    }
				}
				if(selected==false){
					allControlBooks = "<option value=\"-1\" selected >Select one </option>" +  allControlBooks;
				}
			} else {
			    allControlBooks = "<option value=\"-1\" selected >Select one </option>";			    
			}
			//
			if (cb_currentCB != null) {
				cb_help = cb_currentCB.ctrlbookId;
				// add navigator tab
				cb_navigatorTab = "<li><a role='tab' id='cb_dyntabs_head_nav_report' href='#cb_dyntabs_body_div_report' onClick='controlbook_drawReportListTab(true);return false;' aria-selected=\"false\" >Report list</a></li>";
				if (cb_currentCB.hasdashboard == 'Y') {
					cb_navigatorTab += "<li><a role='tab' id='cb_dyntabs_head_nav_dashboard' href='#cb_dyntabs_body_div_dashboard'  onClick='controlbook_drawDashBoardTab(true);return false;'  aria-selected=\"false\"'>Dashboard</a></li>";
				}
				//
				controlbook_getControlBookReports(cb_currentCB.ctrlbookId);
				//controlbook_getDashboard(cb_currentCB.ctrlbookId);
				//
				jQuery("#controlbook_cblist").html(allControlBooks);
				jQuery("#cb_dyntabs_head").empty();
				jQuery("#cb_dyntabs_head").append(jQuery(cb_navigatorTab));		
				//if(cb_currentCB.hasdashboard == 'Y' && cb_lastAccess.cbview == 'D'){
				//	controlbook_drawDashBoardTab(false);
				//} else {
				//	controlbook_drawReportListTab(false);
				//}
			} else {
				jQuery("#controlbook_cblist").html(allControlBooks);
				jQuery("#cb_dyntabs_head").empty();
				jQuery("#cb_dyntabs_body").empty();				
			}			
		},
		error : function(error){
			allControlBooks = "<option value=\"-1\" selected >Select one </option>";
			jQuery("#controlbook_cblist").html(allControlBooks);
		}
	});
}

function controlbook_getControlBook(cbId) {
	if (controlbook_cblist == null || controlbook_cblist.length == 0) {
		return null;
	}
	for (var i = 0; i < controlbook_cblist.length; i++) {
		if (controlbook_cblist[i].ctrlbookId == cbId) {
			return controlbook_cblist[i];
		}
	}
	return null;
}


function controlbook_SwitchCB(){
	jQuery("#cb_dyntabs_head").empty();
	jQuery("#cb_dyntabs_body").empty();
	jQuery("#cb_dyntabs_body").append("<img id=\"mycontrolbookLoading\" src='"+cb_link_path+"/images/ajax-loader.gif' />");
	var cbId=jQuery("#controlbook_cblist").find("option:selected").val();
	if(cbId == -1){
		jQuery("#cb_dyntabs_head").empty();
		jQuery("#cb_dyntabs_body").empty();	
		return false;
	}
	cb_currentCB = controlbook_getControlBook(cbId);
   	if(cb_currentCB == null){
   		alert('System error, can not find controlbook, please try again.');
   		return false;
   	}
   	//
   	if(cb_lastAccess != null){
   		cb_lastAccess.ctrlbookId=cbId;
   		cb_lastAccess.cbview='L';
   		cb_lastAccess.cuuid=0;
   	}
   	//
   	controlbook_getControlBookReports(cbId);

  	cb_help = cb_currentCB.ctrlbookId; 
	// add navigator tab
	cb_navigatorTab = "<li><a role='tab' id='cb_dyntabs_head_nav_report' href='#cb_dyntabs_body_div_report' onClick='controlbook_drawReportListTab(true);return false;' aria-selected=\"false\" >Report list</a></li>";
	if (cb_currentCB.hasdashboard == 'Y') {
		cb_navigatorTab += "<li><a role='tab' id='cb_dyntabs_head_nav_dashboard' href='#cb_dyntabs_body_div_dashboard'  onClick='controlbook_drawDashBoardTab(true);return false;'  aria-selected=\"false\"'>Dashboard</a></li>";
	}
	jQuery("#cb_dyntabs_head").append(jQuery(cb_navigatorTab));

}

function controlbook_getControlBookReports(cbId) {
	controlbook_Bireports = new BIReports('controlbook_Bireports','cb');
	if (cbId == -1) {
		return false;
	}
	var timeid=(new Date()).valueOf();
	jQuery.ajax({
		type : 'GET',
		async : true,
		url : '<%=request.getContextPath()%>/action/portal/controlbook/getCBReportList/' + cwa_id + '/' + uid + '/' + cbId + '?timeid=' + timeid,
		success : function(data) {
			controlbook_rplist = data;
			if (controlbook_rplist != null && controlbook_rplist.length > 0) {
				 for (var i = 0; i < controlbook_rplist.length; i++) {
					var cb_report = new BIReport('controlbook_Bireports','cb',controlbook_rplist[i]);
					controlbook_Bireports.addReport(cb_report);
				 }
			} else {
				//controlbook_rplist = [];
			}
			//
		   	if(cb_currentCB.hasdashboard == 'Y'){
		   		controlbook_getDashboard(cbId);   	
		   	}
		   	//
		   	if(cb_lastAccess!=null&&cb_lastAccess.cuuid>0 && cb_currentCB.ctrlbookId==cb_lastAccess.ctrlbookId){
		   		if(cb_currentCB.hasdashboard == 'Y'  && cb_lastAccess.cbview=='D'){
		   			controlbook_drawDashBoardTab(false);
		   		}else{
		   			controlbook_drawReportListTab(false);		   		
		   		}		   	
		   	} else {
		   		controlbook_drawReportListTab(true);
		   	}
		   	//
		},
		error : function(error) {
			//controlbook_rplist = [];
			controlbook_drawReportListTab(false);
		}
	});		
}

function controlbook_drawReportListTab(saveUsage){
	jQuery("#cb_dyntabs_body").empty();                
	cb_rptlistTab = "<div id=\"cb_report_content\">";
	cb_rptlistTab += "<div><strong>" + jQuery("#controlbook_cblist").find("option:selected").text().trim();  
	cb_rptlistTab += "&nbsp;<a id='controlbook_help_id' target='_blank' title='help' ><img src='<%=path%>/images/rpt_help.gif' style='padding:0px;' alt='help'>"; 
	cb_rptlistTab += "</a></strong></div>"; 
	cb_rptlistTab += controlbook_Bireports.toString();
	cb_rptlistTab +="</div>";
	jQuery("#cb_dyntabs_body").append(jQuery(cb_rptlistTab));
	jQuery('#controlbook_help_id').attr('href', '<%=path%>/action/portal/controlbook/help?id='+cb_help);
	
	//default - 1st tab display
	jQuery("#cb_dyntabs_head_nav_dashboard").attr("aria-selected", false);
	jQuery("#cb_dyntabs_head_nav_dashboard").css("fontWeight", "normal");
	jQuery("#cb_dyntabs_head_nav_dashboard").parent().css("backgroundColor", "#ececec");
	jQuery("#cb_dyntabs_head_nav_report").attr("aria-selected", true);
	jQuery("#cb_dyntabs_head_nav_report").css("fontWeight", "bold");
	jQuery("#cb_dyntabs_head_nav_report").parent().css("backgroundColor", "#ffffff");
		
	//jQuery('#cb_dyntabs_head_nav_report').show();
	if(cb_currentCB!=null&&saveUsage==true){
		controlbook_savelastAccessCB(cb_currentCB.ctrlbookId,'L');
	}	
}

function controlbook_drawDashBoardTab(saveUsage){
	jQuery("#cb_dyntabs_body").empty();
	var dashboardstr = "<div id=\"cb_dashboard_content\"> ";
	dashboardstr += controlbook_dashboard;
	dashboardstr += "</div>";	
	jQuery("#cb_dyntabs_body").append(jQuery(dashboardstr));
	jQuery("#cb_dyntabs_head_nav_report").attr("aria-selected", false);
	jQuery("#cb_dyntabs_head_nav_report").css("fontWeight", "normal");
	jQuery("#cb_dyntabs_head_nav_report").parent().css("backgroundColor", "#ececec");
	jQuery("#cb_dyntabs_head_nav_dashboard").attr("aria-selected", true);
	jQuery("#cb_dyntabs_head_nav_dashboard").css("fontWeight", "bold");
	jQuery("#cb_dyntabs_head_nav_dashboard").parent().css("backgroundColor", "#ffffff");
	//jQuery('#cb_dyntabs_head_nav_dashboard').show();
	if(cb_currentCB!=null&&saveUsage==true){
		controlbook_savelastAccessCB(cb_currentCB.ctrlbookId,'D');
	}	
}

function controlbook_savelastAccessCB(cbId,type) {
	if(cbId == -1){
	   	return false;		
	} 
	var timeid=(new Date()).valueOf();
	jQuery.ajax({
		type:'GET',url:'<%=request.getContextPath()%>/action/portal/usage/lastAccessCB/' + cwa_id + '/' + uid + '/' + cbId + '/' + type + '?timeid=' + timeid,
		success : function(data) {
		
		},
		error : function(error) {
		
		}
	});
}

function controlbook_getDashboard(cbId) {
	if(cbId == -1){
	   	return false;		
	}
	var timeid=(new Date()).valueOf();
	jQuery.ajax({
			type : 'GET',
			async : false,
			url : '<%=request.getContextPath()%>/action/portal/controlbook/getDashboard/' + cwa_id + '/' + uid+'/'+cbId+'/controlbook_Bireports/cb' + '?timeid=' + timeid,					 
			success : function(data) {
				controlbook_dashboard = data;	
				//show_Dashboard_view();
			},
			error : function(error){
				controlbook_dashboard = '';
			}
	});
}

function controlbook_addRemoveCB(){
    var timeid=(new Date()).valueOf();
    var url = '<%=request.getContextPath()%>/action/portal/controlbook/showAddRemoveCB/' + cwa_id + '/' + uid + '?timeid=' + timeid;
    windowWidth = screen.availWidth;
    windowHeight = screen.availHeight;
    style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0,width=" + windowWidth + ",height=" + windowHeight;
    window.open(url, "AddRemoveCB", style);

}
 

</script>

<div class="ibm-card">
	<div class="ibm-card__content" style="height: 100%;">
		<div class="ibm-rule ibm-alternate-1 ibm-blue-60"></div>

		<input id="controlbook_cwa_id" name="controlbook_cwa_id"
			value='${requestScope.cwa_id}' type="hidden" /> <input
			id="controlbook_uid" name="controlbook_uid"
			value='${requestScope.uid}' type="hidden" />
		<div style="float: left;">
			<strong class="ibm-h4">My control books</strong>
		</div>
		<div style="float: right;">
			<a id="controlbook_refresh_id" name="controlbook_refresh_name"
				title="Refresh" style="cursor: pointer"
				onClick="cb_refresh();return false;"> <img
				src="<%=path%>/images/refresh.gif" alt="refresh">
			</a>
		</div>
		<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
			<hr>
		</div>

		<p class="ibm-form-elem-grp">
			<label><b>Control book:</b></label> <span> <select
				id="controlbook_cblist" name="controlbook_cblist" data-width="65%"
				onChange="controlbook_SwitchCB();">
					<option value=\"-1\">Select one</option>
			</select>
			</span>&nbsp;&nbsp;
		</p>

		<div class="ibm-text-tabs" style="margin: 0; min-height: 0;"
			id="cb_tabs">
			<div class="ibm-tab-section">
				<ul class="ibm-tabs" role="tablist" id="cb_dyntabs_head">

				</ul>
			</div>

		</div>
		<div class="ibm-container-body" id="cb_dyntabs_body"
			style="padding-top: 6px;"></div>
		<!-- tab footer -->
		<div align="right">
			<a id="add_remove_id" font="12px Arial"
				onClick="controlbook_addRemoveCB();return false;" href="#"
				style="cursor: pointer">> Add/remove control books</a>
		</div>

	</div>
</div>




