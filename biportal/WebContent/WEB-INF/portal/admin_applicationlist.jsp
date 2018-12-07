<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
String path = request.getContextPath(); 
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<title>BI@IBM | Manage applications</title>
<style type="text/css">
	.dataTables_wrapper .dataTables_filter,
	.dataTables_wrapper .dataTables_length {
	    margin-bottom: 0px
	}
	
	table.dataTable thead .sorting,
    table.dataTable thead .sorting_asc,
    table.dataTable thead .sorting_desc {
        /* change sort icon position */
        background-repeat: no-repeat;
        background-position: center right
    }
</style>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br />
	<div>
		<div style="width: 95%; align: center; margin-left: auto; margin-right: auto;">
			<div>
				<div>
					<h1 class="ibm-h1 ibm-light">Manage applications</h1>
				</div>
			</div>
				<form id='id_applicationlistform' class="ibm-column-form" method="post">
					<div>
						<table style="width: 100%;">
							<tr>
								<td>
									<input type="button" id="id_applicationlist_add_button"          onclick="editApplication('new')"    value="Add application"           class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"/>
									<input type="button" id="id_applicationlist_edit_button"         onclick="editApplication('update')" value="Edit application"          class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"/>
									<!-- <input type="button" id="id_applicationlist_changestatus_button" onclick="changeStatus()"             value="Change status" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"/> -->
									<input type="button" id="id_applicationlist_delete_button"       onclick="deleteApplication()"       value="Delete application"        class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"/>
								</td>
							</tr>
						</table>
					</div>
					<div id="id_applicationlistdiv">
					</div>
				</form>
			<div>
			</div>
		</div>
	</div>
	<div id="id_confirmation_deleteselectedapplication" class="ibm-common-overlay ibm-overlay-alt" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center">Application <span class="ibm-h3 ibm-center" id="id_confirmation_selectedApplication"></span> is selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected application should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedApplicationOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedApplicationCancel();">Cancel</button>  	
 		</p>
 	</div>
	<div id="id_applicationedit_page_overlay_main"></div>
	<!-- <div id="id_applicationchangestatus_page_overlay_main"></div> -->
	<br />
	<script type="text/javascript">
var localContextPath = "<%=request.getContextPath()%>";
var localCwaid = "${cwa_id}"; 
var localUid = "${uid}";
var localApplicationList_selectedApplCd;

jQuery(document).ready(function() {
	initApplicationList();
})

function initApplicationList() {
	
	jQuery.get(
		localContextPath+"/action/admin/trigger/getApplicationAll/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
	)
	.done(function(data) {
		var applicationList = data;
		initApplicationListDiv(applicationList);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_applicationlistdiv").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function initApplicationListDiv(applicationList) {

	var searchText = "";
	
	var currTable = jQuery("#id_applicationlist_table");
	if (currTable.length > 0) {
		searchText = jQuery("#id_applicationlist_table_filter").find("input[type='search']").val();
	}
	
	jQuery("#id_applicationlistdiv").empty();
	
	if (applicationList == null || applicationList.length == 0) {
		jQuery("#id_applicationlistdiv").append("Error, there is not any application.");
	} else {
		var tableStr = "<div>";
		tableStr += "<table id='id_applicationlist_table' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='true'>";
		tableStr += "<thead><tr>";
		tableStr += "<th scope='col'></th>";
		tableStr += "<th scope='col'>Application code</th>";
		tableStr += "<th scope='col'>Application description</th>";
		tableStr += "<th scope='col'>Application sequence No.</th>";
		tableStr += "<th scope='col'>Tab code</th>";
		tableStr += "</tr></thead>";
		tableStr += "<tbody>";
		
		var applicationListLength = applicationList.length;
			
		for (var i = 0; i < applicationListLength; i++) {
			
			var appl = applicationList[i];
			
			tableStr += "<tr>";
			tableStr += "<td scope='row'><span class='ibm-radio-wrapper'><input id='id_applicationlist_tr_" + appl.applCd + "' name='name_applicationlist_table_radio' value='" + appl.applCd + "' type='radio' class='ibm-styled-radio'></input><label class='ibm-field-label' for='id_applicationlist_tr_" + appl.applCd + "'></label></span></td>";
			tableStr += "<td>" + appl.applCd + "</td>";
			tableStr += "<td>" + appl.applDesc + "</td>";
			tableStr += "<td>" + appl.applSeqNo + "</td>";
			tableStr += "<td>" + appl.tabCd + "</td>";
			tableStr += "</tr>";
		}
		
		tableStr += "</tbody>";
		tableStr += "</table>";
		tableStr += "</div>";
		
		jQuery("#id_applicationlistdiv").append(tableStr);
		jQuery("#id_applicationlist_table").DataTable({paging:false, searching:true, info:true, order:[[1, "asc"]], columnDefs: [{targets: [0], orderable: false}]});
		if (searchText != "") {
			jQuery("#id_applicationlist_table_filter").find("input[type='search']").val(searchText).keyup();
		}
	}
}

function deleteApplication() {
	
	var selectedAppl = jQuery("input[name='name_applicationlist_table_radio']:checked");
	
	if (selectedAppl.length == 1) {
		localApplicationList_selectedApplCd = jQuery(selectedAppl.get(0)).val();
		IBMCore.common.widget.overlay.show("id_confirmation_deleteselectedapplication");
		jQuery("#id_confirmation_selectedApplication").text(localApplicationList_selectedApplCd);
	} else {
		alert("please select one application to delete.");
		return;
	}
}

function deleteSelectedApplicationOk() {

	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedapplication").getId(), true);
	jQuery("#id_applicationlist_delete_button").attr("disabled", "true");
	
	var obj = new Object();
	obj.applCd = localApplicationList_selectedApplCd;
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/admin/trigger/deleteApplication?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var applicationList = data.applicationList;
		var text = data.text;
		alert(text);
		jQuery("#id_applicationlist_delete_button").removeAttr("disabled");
		initApplicationListDiv(applicationList);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_applicationlistdiv").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedApplicationCancel() {

	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedapplication").getId(), true);
}

var localApplicationEdit_applCd;
var localApplicationEdit_action;

function initApplicationEditPageOverlay() {
	
	var overlayStr = "<div id='id_applicationedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_applicationedit_page_overlay_main").append(overlayStr);
	jQuery("#id_applicationedit_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_applicationedit_page_overlay");
}

function editApplication(action) {
	
	localApplicationEdit_action = action;
	
	if (action == "new") {
		
		localApplicationEdit_applCd = "";
		initApplicationEditPageOverlay();
		
		jQuery.get(
			localContextPath+"/action/admin/trigger/getApplicationNew/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var dataloadtabList = data;
			initApplicationEditPage();
			
			var dataloadtabListLength = dataloadtabList.length;
			var tabOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < dataloadtabListLength; i++) {
				var currTab = dataloadtabList[i];
				tabOptionStr += "<option value='" + currTab.tabCd + "'>" + currTab.tabCd + "</option>";
			}
			jQuery("#id_applicationedit_dataloadtab").empty().append(tabOptionStr);
			IBMCore.common.widget.selectlist.init("#id_applicationedit_dataloadtab");
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_applicationedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else if (action == "update") {
		
		var selectedAppl = jQuery("input[name='name_applicationlist_table_radio']:checked");
		
		if (selectedAppl.length == 1) {
			
			localApplicationEdit_applCd = jQuery(selectedAppl.get(0)).val();
			initApplicationEditPageOverlay();
			
			var editObject = new Object();
			editObject.applCd = localApplicationEdit_applCd;
			
			jQuery.ajax({
				type : "POST",
				url : localContextPath+"/action/admin/trigger/getApplicationEdit?timeid="+(new Date()).valueOf(),
				data : JSON.stringify(editObject),
				contentType : "application/json",
				dataType : "json",
			})
			.done(function(data) {
				var application = data.application;
				var dataloadtabList = data.dataloadtabList;
				initApplicationEditPage();
				jQuery("#id_applicationedit_applcd").attr("disabled", "true");
				jQuery("#id_applicationedit_applcd").val(application.applCd);
				
				jQuery("#id_applicationedit_description").val(application.applDesc);
				jQuery("#id_applicationedit_sequencenumber").val(application.applSeqNo);
				
				var dataloadtabListLength = dataloadtabList.length;
				var tabOptionStr = "<option value='none'>Please select one</option>";
				for (var i = 0; i < dataloadtabListLength; i++) {
					var currTab = dataloadtabList[i];
					if (currTab.tabCd == application.tabCd) {
						tabOptionStr += "<option value='" + currTab.tabCd + "' selected>" + currTab.tabCd + "</option>";
					} else {
						tabOptionStr += "<option value='" + currTab.tabCd + "'>" + currTab.tabCd + "</option>";
					}
				}
				jQuery("#id_applicationedit_dataloadtab").empty().append(tabOptionStr);
				IBMCore.common.widget.selectlist.init("#id_applicationedit_dataloadtab");
			})
			.fail(function(jqXHR, textStatus, errorThrown) {
				jQuery("#id_applicationedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
				console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
				console.log(		"ajax error in loading...textStatus..."	+textStatus); 
				console.log(		"ajax error in loading...errorThrown..."+errorThrown);
			})
		} else {
			alert("please select one application to edit.");
			return;
		}
	}
}

function initApplicationEditPage() {
	
	var overlayStr = "<form id='id_applicationeditform' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='id_applicationEditDiv'>";
	overlayStr += "<table>";
	overlayStr += "<tr><td>Application code:<span class='ibm-required'>*</span></td><td><input type='text' id='id_applicationedit_applcd' name='applicationedit_applcd' size='20' maxlength='8'></input></td></tr>";
	overlayStr += "<tr><td>Application description:<span class='ibm-required'>*</span></td><td><input type='text' id='id_applicationedit_description' name='applicationedit_applicationdescription' size='20' maxlength='8'></input></td></tr>";
	overlayStr += "<tr><td>Application&nbsp;sequence&nbsp;No.:<span class='ibm-required'>*</span></td><td><input type='text' id='id_applicationedit_sequencenumber' name='applicationedit_sequencenumber' size='8'></input></td></tr>";
	overlayStr += "<tr><td>Data load tab code:</td><td><select id='id_applicationedit_dataloadtab' class='ibm-styled' title='dataloadtab' style='width: 150px;'></select></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_applicationedit_saveapplication_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='applicationedit_saveApplication()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_applicationedit_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_applicationedit_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";

	jQuery("#id_applicationedit_page_overlay").empty().append(overlayStr);
}

function applicationedit_saveApplication() {
	
	if (localApplicationEdit_action == "new" || localApplicationEdit_action == "update") {
		
		var tmpApplCd;
		if (localApplicationEdit_action == "new") {
			tmpApplCd = jQuery("#id_applicationedit_applcd").val();
			if (tmpApplCd == null || tmpApplCd.length == 0) {
				alert("Application code field is empty. Please enter a application code.");
				return;
			}
			
		} else if (localApplicationEdit_action == "update") {
			tmpApplCd = localApplicationEdit_applCd;
		}
		
		var tmpDescription = jQuery("#id_applicationedit_description").val();
		if (tmpDescription == null || tmpDescription.length == 0) {
			alert("Application description field is empty. Please enter a application description.");
			return;
		}
		
		var tmpApplSeqNo = jQuery("#id_applicationedit_sequencenumber").val();
		if (tmpApplSeqNo == null || tmpApplSeqNo.length == 0 || isNaN(tmpApplSeqNo) || (tmpApplSeqNo < 0)) {
			alert("Application sequence No. must be a valid number.");
			return;
		}
		
		var tmpTabCd = jQuery("#id_applicationedit_dataloadtab").val();
		if (tmpTabCd == null || tmpTabCd == "none") {
			tmpTabCd = "";
		}
		
		var newApplicationObj = new Object();
		newApplicationObj.applCd = tmpApplCd;
		newApplicationObj.applDesc = tmpDescription;
		newApplicationObj.applSeqNo = tmpApplSeqNo;
		newApplicationObj.tabCd = tmpTabCd;
		
		//alert(JSON.stringify(newApplicationObj));
		
		if (localApplicationEdit_action == "new") {
			jQuery("#id_applicationedit_applcd").attr("disabled", "true");
		}
		jQuery("#id_applicationedit_saveapplication_button").attr("disabled", "true");
		
		jQuery.ajax({
			type : "POST",
			url : localContextPath+"/action/admin/trigger/updateApplication/"+localApplicationEdit_action+"?timeid="+(new Date()).valueOf(),
			data : JSON.stringify(newApplicationObj),
			contentType : "application/json",
			dataType : "json",
		})
		.done(function(data) {
		
			var flag = data.flag;
			var text = data.text;
			alert(text);
			
			if (localApplicationEdit_action == "new") {
				if (flag == "1") {
					localApplicationEdit_action = "update";
					localApplicationEdit_applCd = tmpApplCd;
				} else {
					jQuery("#id_applicationedit_applcd").removeAttr("disabled");
				}
			}
			
			jQuery("#id_applicationedit_saveapplication_button").removeAttr("disabled");
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_applicationedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		alert("Error, it's an unknown action.");
	}
}

function closeOverlay(myOverId) {
	var theOverlayId = IBMCore.common.widget.overlay.getWidget(myOverId).getId();
	IBMCore.common.widget.overlay.hide(theOverlayId, true);
	IBMCore.common.widget.overlay.destroy(theOverlayId);
	var found = jQuery("#"+myOverId);
	if (found.length > 0) {
		found.remove();
	}
}

/* var localApplicationChangeStatus_applCd;

function initApplicationChangeStatusPageOverlay() {

	var overlayStr = "<div id='id_applicationchangestatus_page_overlay' class='ibm-common-overlay ibm-overlay-alt' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_applicationchangestatus_page_overlay_main").append(overlayStr);
	jQuery("#id_applicationchangestatus_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_applicationchangestatus_page_overlay");
}

function changeStatus() {

	var selectedAppl = jQuery("input[name='name_applicationlist_table_radio']:checked");
	
	if (selectedAppl.length == 1) {

		initApplicationChangeStatusPageOverlay();
		localApplicationChangeStatus_applCd = jQuery(selectedAppl.get(0)).val();
		
		var obj = new Object();
		obj.applCd = localApplicationChangeStatus_applCd;
		jQuery.ajax({
			type : "POST",
			url : localContextPath+"/action/admin/trigger/getTriggerApplStatus?timeid="+(new Date()).valueOf(),
			data : JSON.stringify(obj),
			contentType : "application/json",
			dataType : "json",
		})
		.done(function(data) {
			var flag = data.flag;
			if (flag == "1") {
				var overlayStr = "<form id='id_applicationchangestatusform' class='ibm-column-form' method='post'>";
				overlayStr += "<div id='id_applicationChangeStatusDiv'>";
				overlayStr += "<table>";
				overlayStr += "<tr><td>Application code:</td><td><input type='text' id='id_applicationchangestatus_applcd' name='name_applicationchangestatus_applcd' size='20' maxlength='8' readonly disabled></input></td></tr>";
				overlayStr += "<tr><td>Application&nbsp;description:</td><td><input type='text' id='id_applicationchangestatus_appldesc' name='name_applicationchangestatus_appldesc' size='20' maxlength='8' readonly disabled></input></td></tr>";
				overlayStr += "<tr><td>Application status:</td><td><select id='id_applicationchangestatus_applstatus' class='ibm-styled' title='applstatus' style='width: 50px;'></select></td></tr>";
				overlayStr += "</table>";
				overlayStr += "<div></div>";
				overlayStr += "<div></div>";
				overlayStr += "<div></div>";
				overlayStr += "<div></div>";
				overlayStr += "<div></div>";
				overlayStr += "<input type='button' id='id_applicationchangestatus_savestatus_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='applicationchangestatus_savestatus()' value='Submit'/>&nbsp;";
				overlayStr += "<input type='button' id='id_applicationchangestatus_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_applicationchangestatus_page_overlay\")' value='Close'/>";
				overlayStr += "</div>";
				overlayStr += "</form>";
				jQuery("#id_applicationchangestatus_page_overlay").empty().append(overlayStr);
				
				var applicationStatus = data.applicationStatus;
				jQuery("#id_applicationchangestatus_applcd").val(applicationStatus.id.applCd);
				jQuery("#id_applicationchangestatus_appldesc").val(applicationStatus.applDesc);
				
				var statusOptionStr = "";
				if (applicationStatus.id.applStatus == "OK") {
					statusOptionStr += "<option value='OK' selected>OK</option>";
					statusOptionStr += "<option value='NO'>NO</option>";
				} else {
					statusOptionStr += "<option value='OK'>OK</option>";
					statusOptionStr += "<option value='NO' selected>NO</option>";
				}
				jQuery("#id_applicationchangestatus_applstatus").empty().append(statusOptionStr);
				IBMCore.common.widget.selectlist.init("#id_applicationchangestatus_applstatus");
			} else {
				jQuery("#id_applicationchangestatus_page_overlay").empty().append(data.text).append("<div/><div/><div/><input type='button' id='id_applicationchangestatus_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_applicationchangestatus_page_overlay\")' value='Close'/>");
			}
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_applicationchangestatus_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		alert("please select one application to change status.");
		return;
	}
}

function applicationchangestatus_savestatus() {

	var statusId = new Object();
	statusId.applCd = localApplicationChangeStatus_applCd;
	statusId.applStatus = jQuery("#id_applicationchangestatus_applstatus").val();
	
	var obj = new Object();
	obj.id = statusId;
	
	//alert(JSON.stringify(obj));
	
	jQuery("#id_applicationchangestatus_savestatus_button").attr("disabled", "true");
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath+"/action/admin/trigger/updateTriggerApplStatus?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var text = data;
		alert(text);
		jQuery("#id_applicationchangestatus_savestatus_button").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_applicationchangestatus_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
} */

	</script>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>