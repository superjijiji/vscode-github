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
<script type="text/javascript" src="<%=path%>/javascript/buttonaccess.js"></script>
<script type="text/javascript" src="<%=path%>/javascript/js.cookie-2.1.4.js"></script>
<title>BI@IBM | Manage triggers</title>
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
					<h1 class="ibm-h1 ibm-light">Manage triggers</h1>
				</div>
			</div>
			<div>
				<form id="id_triggerlistform" class="ibm-column-form" method="post">
					<div id="id_triggerlistbuttondiv"></div>
					<div id="id_triggerlistdatadiv"></div>
				</form>
			</div>
		</div>
	</div>
	<div id="id_confirmation_deleteselectedtriggerid" class="ibm-common-overlay ibm-overlay-alt" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center">Trigger <span class="ibm-h3 ibm-center" id="id_confirmation_selectedTriggerid"></span> is selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected trigger should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedTriggeridOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedTriggeridCancel();">Cancel</button>  	
 		</p>
 	</div>
	<div id="id_confirmation_deleteselecteddataloadtab" class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center">Data load tab <span class="ibm-h3 ibm-center" id="id_confirmation_selecteddataloadtab"></span> is selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected data load tab should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedDataloadtabOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedDataloadtabCancel();">Cancel</button>  	
 		</p>
 	</div>
 	<div id="id_confirmation_deleteselectedapplication" class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center">Application <span class="ibm-h3 ibm-center" id="id_confirmation_selectedApplication"></span> is selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected application should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedApplicationOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedApplicationCancel();">Cancel</button>  	
 		</p>
 	</div>
 	<div id="id_confirmation_deleteselectedfederatedtriggers" class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center">Federated trigger <span class="ibm-h3 ibm-center" id="id_confirmation_selectedfederatedtriggers"></span> is selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected federated trigger should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedFederatedTriggersOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedFederatedTriggersCancel();">Cancel</button>  	
 		</p>
 	</div>
 	<div id="id_confirmation_federatedtriggers_edit" class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center">Relation is going to be changed to <span class="ibm-h3 ibm-center" id="id_confirmation_federatedtriggers_edit_text0"></span> for federated trigger <span class="ibm-h3 ibm-center" id="id_confirmation_federatedtriggers_edit_text1"></span>, and other records which Trigger code are <span class="ibm-h3 ibm-center" id="id_confirmation_federatedtriggers_edit_text2"></span> will be changed relation to <span class="ibm-h3 ibm-center" id="id_confirmation_federatedtriggers_edit_text3"></span> as well.</h3>
 		<p class="ibm-center">Click on OK to confirm to submit.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="editFederatedTriggersOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="editFederatedTriggersCancel();">Cancel</button>  	
 		</p>
 	</div>
	<div id="id_triggeridedit_page_overlay_main"></div>
	<div id="id_triggeridupdatetriggertime_page_overlay_main"></div>
	<div id="id_dataloadtablist_page_overlay_main"></div>
	<div id="id_dataloadtabedit_page_overlay_main"></div>
	<div id="id_applicationlist_page_overlay_main"></div>
	<div id="id_applicationedit_page_overlay_main"></div>
	<div id="id_federatedtriggerslist_page_overlay_main"></div>
	<div id="id_federatedtriggersedit_page_overlay_main"></div>
	<br />
	<script type="text/javascript">
var localContextPath = "<%=request.getContextPath()%>";
var localCwaid = "${cwa_id}"; 
var localUid = "${uid}";
var localTriggeridList_selectedTriggerCd;
var localTriggeridList_searchText;
var localTriggeridEdit_triggerCd;
var localTriggeridEdit_action;

jQuery(document).ready(function() {
	
	var myTriggerListTableSorting = Cookies.get("myTriggerListTableColSort");
    if (myTriggerListTableSorting === undefined) { 
        myTriggerListTableSorting = '[[2, "asc"]]';
        Cookies.set("myTriggerListTableColSort", myTriggerListTableSorting, {expires: 999});
        console.log("myTriggerListTableColSort initializing column sorting in cookie " + myTriggerListTableSorting);
    }
    
	initTriggeridList("init");
})

function initTriggeridList(action) {
	
	if (action == "init") {
		jQuery("#id_triggerlistbuttondiv").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
	} else if (action == "refresh") {
		saveTriggeridListTableSearchText();
		jQuery("#id_triggerlistdatadiv").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
	}
	
	if (action == "init") {
		jQuery.get(
			localContextPath+"/action/admin/trigger/getTriggeridInit/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var triggeridList = data.triggeridList;
			var buttonAccessList = data.buttonAccessList;
			initTriggeridListButtonDiv(buttonAccessList);
			initTriggeridListDataDiv(triggeridList, action);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_triggerlistdatadiv").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		jQuery.get(
			localContextPath+"/action/admin/trigger/getTriggeridAll/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var triggeridList = data;
			initTriggeridListDataDiv(triggeridList, action);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_triggerlistdatadiv").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	}
}

function initTriggeridListButtonDiv(buttonAccessList) {
	
	var accessFlagList = checkPanelButtonAccessFlag(buttonAccessList);
	var accessFlag1 = accessFlagList[0];
	var accessFlag2 = accessFlagList[1];
	var accessFlag3 = accessFlagList[2];
	var accessFlag4 = accessFlagList[3];

	var buttonStr = "<table style='width: 100%;'>";
	buttonStr += "<tr>";
	buttonStr += "<td>";
	buttonStr += "<input type='button' id='id_triggerlist_refresh_button'           onclick='initTriggeridList(\"refresh\")' value='Refresh'                        class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	if (accessFlag1 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_triggerlist_add_button'               onclick='editTrigger(\"new\")'        value='Add trigger'                    class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	if (accessFlag2 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_triggerlist_edit_button'              onclick='editTrigger(\"update\")'     value='Edit trigger'                    class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	if (accessFlag1 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_triggerlist_delete_button'            onclick='deleteTriggerid()'           value='Delete trigger'                 class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	if (accessFlag3 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_triggerlist_updatetriggertime_button' onclick='updateTriggerTime()'         value='Update trigger status and time' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	buttonStr += "</td>";
	buttonStr += "<td align='right'>";
	if (accessFlag4 == "1") {
		buttonStr += "<input type='button' id='id_triggerlist_managedataloadtab_button' onclick='manageDataloadtab()'         value='Manage data load tabs'     class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
		buttonStr += "&nbsp;<input type='button' id='id_triggerlist_manageapplication_button' onclick='manageApplication()'         value='Manage applications'       class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
		buttonStr += "&nbsp;<input type='button' id='id_triggerlist_federatedtriggers_button' onclick='federatedTriggers()'         value='Manage federated triggers'        class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	buttonStr += "</td>";
	buttonStr += "</tr>";
	buttonStr += "</table>";
	
	jQuery("#id_triggerlistbuttondiv").empty().append(buttonStr);
}

function initTriggeridListDataDiv(triggeridList, action) {

	if (action == "delete") {
		saveTriggeridListTableSearchText();
	}

	if (triggeridList == null || triggeridList.length == 0) {
		jQuery("#id_triggerlistdatadiv").empty().append("Error, there is not any trigger.");
	} else {
		var tableStr = "<div>";
		tableStr += "<table id='id_triggeridlist_table' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='true'>";
		tableStr += "<thead><tr>";
		tableStr += "<th scope='col'></th>";
		tableStr += "<th scope='col'>Application</th>";
		tableStr += "<th scope='col'>Trigger code</th>";
		tableStr += "<th scope='col'>Trigger description</th>";
		tableStr += "<th scope='col'>Time zone Offset</th>";
		tableStr += "<th scope='col'>Datamart alias</th>";
		tableStr += "<th scope='col'>Viewable</th>";
		tableStr += "<th scope='col'>Application status</th>";
		tableStr += "<th scope='col'>Schedule status</th>";
		tableStr += "<th scope='col'>Trigger time</th>";
		tableStr += "</tr></thead>";
		tableStr += "<tbody>";
		
		var triggeridListLength = triggeridList.length;
			
		for (var i = 0; i < triggeridListLength; i++) {
			
			var trigger = triggeridList[i];
			
			tableStr += "<tr>";
			tableStr += "<td scope='row'><span class='ibm-radio-wrapper'><input id='id_triggeridlist_tr_" + trigger.triggerCd + "' name='name_triggeridlist_table_radio' value='" + trigger.triggerCd + "' type='radio' class='ibm-styled-radio'></input><label class='ibm-field-label' for='id_triggeridlist_tr_" + trigger.triggerCd + "'></label></span></td>";
			tableStr += "<td>" + trigger.applCd + "</td>";
			tableStr += "<td>" + trigger.triggerCd + "</td>";
			tableStr += "<td>" + trigger.triggerDesc + "</td>";
			tableStr += "<td>" + trigger.timeOffset + "</td>";
			tableStr += "<td>" + trigger.datamartAlias + "</td>";
			tableStr += "<td>" + trigger.viewable + "</td>";
			tableStr += "<td>" + trigger.applStatus + "</td>";
			tableStr += "<td>" + trigger.schedStatus + "</td>";
			tableStr += "<td>" + trigger.triggerTimeStr + "</td>";
			tableStr += "</tr>";
		}
		
		tableStr += "</tbody>";
		tableStr += "</table>";
		tableStr += "</div>";
		jQuery("#id_triggerlistdatadiv").empty().append(tableStr);
		
		//jQuery("#id_triggeridlist_table").DataTable({paging:false, searching:true, info:true, order:[[2, "asc"]], columnDefs: [{targets: [0], orderable: false}]});
		var myTriggerListTableSetting = {info: true, paging: false, searching: true};
		myTriggerListTableSetting.order = eval(Cookies.get("myTriggerListTableColSort"));
		myTriggerListTableSetting.columnDefs = [JSON.parse('{"targets": [0], "orderable": false}')];
		var table = jQuery("#id_triggeridlist_table").DataTable(myTriggerListTableSetting);
		jQuery("#id_triggeridlist_table").on("order.dt", function () {
			var order = JSON.stringify(table.order());
			Cookies.set("myTriggerListTableColSort", order, {expires: 999});
        });
		if (localTriggeridList_searchText != "") {
			jQuery("#id_triggeridlist_table_filter").find("input[type='search']").val(localTriggeridList_searchText).keyup();
		}
	}
}

function saveTriggeridListTableSearchText() {
	localTriggeridList_searchText = "";
	var currTable = jQuery("#id_triggeridlist_table");
	if (currTable.length > 0) {
		localTriggeridList_searchText = jQuery("#id_triggeridlist_table_filter").find("input[type='search']").val();
	}
}

function initTriggeridEditPageOverlay() {
	
	var overlayStr = "<div id='id_triggeridedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt-three' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_triggeridedit_page_overlay_main").append(overlayStr);
	jQuery("#id_triggeridedit_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_triggeridedit_page_overlay");
}

function editTrigger(action) {
	
	localTriggeridEdit_action = action;
	
	if (action == "new") {
		
		localTriggeridEdit_triggerCd = "";
		initTriggeridEditPageOverlay();
		
		jQuery.get(
			localContextPath+"/action/admin/trigger/getTriggeridNew/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var applicationList = data;
			initTriggeridEditPage();
			
			var applicationListLength = applicationList.length;
			var applOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < applicationListLength; i++) {
				var currAppl = applicationList[i];
				applOptionStr += "<option value='" + currAppl.applCd + "'>" + currAppl.applCd + "</option>";
			}
			jQuery("#id_triggeridedit_application").empty().append(applOptionStr);
			IBMCore.common.widget.selectlist.init("#id_triggeridedit_application");
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_triggeridedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else if (action == "update") {
		
		var selectedTrigger = jQuery("input[name='name_triggeridlist_table_radio']:checked");
		
		if (selectedTrigger.length == 1) {
			
			localTriggeridEdit_triggerCd = jQuery(selectedTrigger.get(0)).val();
			initTriggeridEditPageOverlay();
			
			var editObject = new Object();
			editObject.triggerCd = localTriggeridEdit_triggerCd;
			
			jQuery.ajax({
				type : "POST",
				url : localContextPath+"/action/admin/trigger/getTriggeridEdit?timeid="+(new Date()).valueOf(),
				data : JSON.stringify(editObject),
				contentType : "application/json",
				dataType : "json",
			})
			.done(function(data) {
				var trigger = data.trigger;
				var applicationList = data.applicationList;
				initTriggeridEditPage();
				jQuery("#id_triggeridedit_triggercd").attr("disabled", "true");
				
				jQuery("#id_triggeridedit_triggercd").val(trigger.triggerCd);
				
				var applicationListLength = applicationList.length;
				var applOptionStr = "<option value='none'>Please select one</option>";
				for (var i = 0; i < applicationListLength; i++) {
					var currAppl = applicationList[i];
					if (currAppl.applCd == trigger.applCd) {
						applOptionStr += "<option value='" + currAppl.applCd + "' selected>" + currAppl.applCd + "</option>";
					} else {
						applOptionStr += "<option value='" + currAppl.applCd + "'>" + currAppl.applCd + "</option>";
					}
				}
				jQuery("#id_triggeridedit_application").empty().append(applOptionStr);
				IBMCore.common.widget.selectlist.init("#id_triggeridedit_application");
				
				jQuery("#id_triggeridedit_triggerdescription").val(trigger.triggerDesc);
				jQuery("#id_triggeridedit_timezoneoffset").val(trigger.timeOffset);
				jQuery("#id_triggeridedit_datamartalias").val(trigger.datamartAlias);
				
				if (trigger.viewable == "Y") {
					jQuery("#id_triggeridedit_viewable").prop("checked", true);
				} else {
					jQuery("#id_triggeridedit_viewable").prop("checked", false);
				}
			})
			.fail(function(jqXHR, textStatus, errorThrown) {
				jQuery("#id_triggeridedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
				console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
				console.log(		"ajax error in loading...textStatus..."	+textStatus); 
				console.log(		"ajax error in loading...errorThrown..."+errorThrown);
			})
		} else {
			alert("please select one trigger to edit.");
			return;
		}
	}
}

function initTriggeridEditPage() {
	
	var overlayStr = "<form id='id_triggerideditform' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='id_triggeridEditDiv'>";
	overlayStr += "<table>";
	overlayStr += "<tr><td>Trigger code:<span class='ibm-required'>*</span></td><td><input type='text' id='id_triggeridedit_triggercd' name='triggeridedit_triggercd' size='20' maxlength='8'></input></td></tr>";
	overlayStr += "<tr><td>Application:<span class='ibm-required'>*</span></td><td><select id='id_triggeridedit_application' class='ibm-styled' title='application' style='width: 150px;'></select></td></tr>";
	overlayStr += "<tr><td>Trigger&nbsp;description:</td><td><input type='text' id='id_triggeridedit_triggerdescription' name='triggeridedit_triggerdescription' size='100' maxlength='60'></input></td></tr>";
	overlayStr += "<tr><td>Time zone Offset:<span class='ibm-required'>*</span></td><td><input type='text' id='id_triggeridedit_timezoneoffset' name='triggeridedit_timezoneoffset' size='8' maxlength='3'></input></td></tr>";
	overlayStr += "<tr><td>Datamart alias:</td><td><input type='text' id='id_triggeridedit_datamartalias' name='triggeridedit_datamartalias' size='40' maxlength='18'></input></td></tr>";
	overlayStr += "<tr><td>Viewable:</td><td><span class='ibm-checkbox-wrapper'><input class='ibm-styled-checkbox' id='id_triggeridedit_viewable' type='checkbox' checked='true'/><label for='id_triggeridedit_viewable' class='ibm-field-label'></label></span></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_triggeridedit_savetriggerid_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='triggeridedit_saveTriggerid()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_triggeridedit_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_triggeridedit_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";

	jQuery("#id_triggeridedit_page_overlay").empty().append(overlayStr);
}

function triggeridedit_saveTriggerid() {
	
	if (localTriggeridEdit_action == "new" || localTriggeridEdit_action == "update") {
		
		var tmpTriggerCd;
		if (localTriggeridEdit_action == "new") {
			tmpTriggerCd = jQuery("#id_triggeridedit_triggercd").val();
			if (tmpTriggerCd == null || tmpTriggerCd.length == 0) {
				alert("Trigger code field is empty. Please enter a trigger code.");
				return;
			}
			
		} else if (localTriggeridEdit_action == "update") {
			tmpTriggerCd = localTriggeridEdit_triggerCd;
		}
		
		var tmpApplication = jQuery("#id_triggeridedit_application").val();
		if (tmpApplication == null || tmpApplication == "none") {
			alert("you must select one in Application field");
			return;
		}
		
		var tmpTriggerDescription = jQuery("#id_triggeridedit_triggerdescription").val();
		
		var tmpTimezoneOffset = jQuery("#id_triggeridedit_timezoneoffset").val();
		if (tmpTimezoneOffset == null) {
			alert("Please enter a number from -24 to 24 in Time zone Offset field");
			return;
		} else {
			tmpTimezoneOffset = tmpTimezoneOffset.trim();
			if (tmpTimezoneOffset.length == 0 || isNaN(tmpTimezoneOffset) || (tmpTimezoneOffset < -24) || tmpTimezoneOffset > 24) {
				alert("Please enter a number from -24 to 24 in Time zone Offset field");
				return;
			}
		}
		
		var tmpDatamartAlias = jQuery("#id_triggeridedit_datamartalias").val();
		
		var tmpViewable;
		var tmpViewableChecked = jQuery("#id_triggeridedit_viewable").prop("checked");
		if (tmpViewableChecked) {
			tmpViewable = "Y";
		} else {
			tmpViewable = "N";
		}
		
		var newTriggeridObj = new Object();
		newTriggeridObj.triggerCd = tmpTriggerCd;
		newTriggeridObj.applCd = tmpApplication;
		newTriggeridObj.triggerDesc = tmpTriggerDescription;
		newTriggeridObj.timeOffset = tmpTimezoneOffset;
		newTriggeridObj.datamartAlias = tmpDatamartAlias;
		newTriggeridObj.viewable = tmpViewable;
		
		//alert(JSON.stringify(newTriggeridObj));
		
		if (localTriggeridEdit_action == "new") {
			jQuery("#id_triggeridedit_triggercd").attr("disabled", "true");
		}
		jQuery("#id_triggeridedit_savetriggerid_button").attr("disabled", "true");
		
		jQuery.ajax({
			type : "POST",
			url : localContextPath+"/action/admin/trigger/updateTriggerid/"+localTriggeridEdit_action+"?timeid="+(new Date()).valueOf(),
			data : JSON.stringify(newTriggeridObj),
			contentType : "application/json",
			dataType : "json",
		})
		.done(function(data) {
		
			var flag = data.flag;
			var text = data.text;
			alert(text);
			
			if (localTriggeridEdit_action == "new") {
				if (flag == "1") {
					localTriggeridEdit_action = "update";
					localTriggeridEdit_triggerCd = tmpTriggerCd;
				} else {
					jQuery("#id_triggeridedit_triggercd").removeAttr("disabled");
				}
			}
			
			jQuery("#id_triggeridedit_savetriggerid_button").removeAttr("disabled");
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_triggeridedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
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

var localTriggeridUpdateTriggerTime_TriggerCd;

function initTriggeridUpdateTriggerTimePageOverlay() {
	
	var overlayStr = "<div id='id_triggeridupdatetriggertime_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_triggeridupdatetriggertime_page_overlay_main").append(overlayStr);
	jQuery("#id_triggeridupdatetriggertime_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_triggeridupdatetriggertime_page_overlay");
}

function updateTriggerTime() {
	
	var selectedTrigger = jQuery("input[name='name_triggeridlist_table_radio']:checked");
	
	if (selectedTrigger.length == 1) {
	
		initTriggeridUpdateTriggerTimePageOverlay();
		localTriggeridUpdateTriggerTime_TriggerCd = jQuery(selectedTrigger.get(0)).val();
		
		var obj = new Object();
		obj.triggerCd = localTriggeridUpdateTriggerTime_TriggerCd;
		jQuery.ajax({
			type : "POST",
			url : localContextPath+"/action/admin/trigger/getTriggeridTriggerTime?timeid="+(new Date()).valueOf(),
			data : JSON.stringify(obj),
			contentType : "application/json",
			dataType : "json",
		})
		.done(function(data) {
			var trigger = data;
			initTriggeridUpdateTriggerTimePage();
			jQuery("#id_triggeridupdatetriggertime_triggercd").val(trigger.triggerCd);
			jQuery("#id_triggeridupdatetriggertime_triggerdesc").val(trigger.triggerDesc);
			if (trigger.triggerTimeStr == null || trigger.triggerTimeStr.length == 0) {
				jQuery("#id_triggeridupdatetriggertime_triggertime_indb").val("");
			} else {
				jQuery("#id_triggeridupdatetriggertime_triggertime_indb").val(trigger.triggerTimeStr);
			}
			jQuery("#id_triggeridupdatetriggertime_applcd").val(trigger.applCd);
			
			var applStatusOptionStr = "";
			if (trigger.applStatus == "OK") {
				applStatusOptionStr += "<option value='OK' selected>OK</option>";
				applStatusOptionStr += "<option value='NO'>NO</option>";
			} else {
				applStatusOptionStr += "<option value='OK'>OK</option>";
				applStatusOptionStr += "<option value='NO' selected>NO</option>";
			}
			jQuery("#id_triggeridupdatetriggertime_applstatus").empty().append(applStatusOptionStr);
			IBMCore.common.widget.selectlist.init("#id_triggeridupdatetriggertime_applstatus");
			
			var scheduleStatusOptionStr = "";
			if (trigger.applStatus == "OK") {
				scheduleStatusOptionStr += "<option value='OK' selected>OK</option>";
				scheduleStatusOptionStr += "<option value='NO'>NO</option>";
			} else {
				scheduleStatusOptionStr += "<option value='OK'>OK</option>";
				scheduleStatusOptionStr += "<option value='NO' selected>NO</option>";
			}
			jQuery("#id_triggeridupdatetriggertime_schedulestatus").empty().append(scheduleStatusOptionStr);
			IBMCore.common.widget.selectlist.init("#id_triggeridupdatetriggertime_schedulestatus");
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_triggeridupdatetriggertime_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		alert("please select one trigger to update trigger time.");
		return;
	}
}

function initTriggeridUpdateTriggerTimePage() {
	
	var overlayStr = "<form id='id_triggeridupdatetriggertimeform' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='id_triggeridUpdateTriggerTimeDiv'>";
	overlayStr += "<table>";
	overlayStr += "<tr><td>Trigger code:</td><td><input type='text' id='id_triggeridupdatetriggertime_triggercd' name='triggeridupdatetriggertime_triggercd' size='20' maxlength='8' readonly disabled></input></td></tr>";
	overlayStr += "<tr><td>Trigger&nbsp;description:</td><td><input type='text' id='id_triggeridupdatetriggertime_triggerdesc' name='triggeridupdatetriggertime_triggerdesc' size='80' maxlength='60' readonly disabled></input></td></tr>";
	overlayStr += "<tr><td>Application code:</td><td><input type='text' id='id_triggeridupdatetriggertime_applcd' name='triggeridupdatetriggertime_applcd' size='20' maxlength='8' readonly disabled></input></td></tr>";
	overlayStr += "<tr><td>Application status:</td><td><select id='id_triggeridupdatetriggertime_applstatus' class='ibm-styled' title='applstatus' style='width: 50px;'></select></td></tr>";
	overlayStr += "<tr><td>Schedule status:</td><td><select id='id_triggeridupdatetriggertime_schedulestatus' class='ibm-styled' title='schedulestatus' style='width: 50px;'></select></td></tr>";
	overlayStr += "<tr><td>Trigger time:</td><td>";
	
	overlayStr += "<fieldset style='border:1px solid #DDD;'>";
	overlayStr += "<legend><input type='text' id='id_triggeridupdatetriggertime_triggertime_indb' size='30' maxlength='19' readonly disabled></input></legend>";
	overlayStr += "<table>";
	overlayStr += "<tr>";
	overlayStr += "<td>";
	overlayStr += "<input type='radio' class='ibm-styled-radio' id='id_triggeridupdatetriggertime_triggertime_no_radio' value='NOT' name='id_triggeridupdatetriggertime_triggertime_fieldset' checked></input>";
	overlayStr += "<label for='id_triggeridupdatetriggertime_triggertime_no_radio'>Not update</label>";
	overlayStr += "</td>";
	overlayStr += "</tr>";
	overlayStr += "<tr>";
	overlayStr += "<td>";
	overlayStr += "<input type='radio' class='ibm-styled-radio' id='id_triggeridupdatetriggertime_triggertime_current_radio' value='CUR' name='id_triggeridupdatetriggertime_triggertime_fieldset'></input>";
	overlayStr += "<label for='id_triggeridupdatetriggertime_triggertime_current_radio'>Current timestamp</label>";
	overlayStr += "</td>";
	overlayStr += "</tr>";
	overlayStr += "<tr>";
	overlayStr += "<td>";
	overlayStr += "<input type='radio' class='ibm-styled-radio' id='id_triggeridupdatetriggertime_triggertime_old_radio' value='OLD' name='id_triggeridupdatetriggertime_triggertime_fieldset'></input>";
	overlayStr += "<label for='id_triggeridupdatetriggertime_triggertime_old_radio'>Current&nbsp;timestamp&nbsp;-&nbsp;<input type='text' id='id_triggeridupdatetriggertime_triggertime_old_text' name='triggeridupdatetriggertime_triggertime_old_text' size='8' maxlength='3' onclick='triggeridupdatetriggertime_focusolddays()'>&nbsp;days</input></label>";
	overlayStr += "</td>";
	overlayStr += "</tr>";
	overlayStr += "</table>";
	overlayStr += "</fieldset>";
	
	overlayStr += "</td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_triggeridupdatetriggertime_savetriggerid_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='triggeridupdatetriggertime_saveTriggerid()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_triggeridupdatetriggertime_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_triggeridupdatetriggertime_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";

	jQuery("#id_triggeridupdatetriggertime_page_overlay").empty().append(overlayStr);
}

function triggeridupdatetriggertime_focusolddays() {
	jQuery("#id_triggeridupdatetriggertime_triggertime_no_radio").removeAttr("checked");
	jQuery("#id_triggeridupdatetriggertime_triggertime_current_radio").removeAttr("checked");
	jQuery("#id_triggeridupdatetriggertime_triggertime_old_radio").attr("checked","checked");
	jQuery("#id_triggeridupdatetriggertime_triggertime_old_radio").prop("checked",true);
}

function triggeridupdatetriggertime_saveTriggerid() {
	
	/* var tmpTriggerTime = jQuery("#id_triggeridupdatetriggertime_triggertime_indb").val();
	var tmpTriggerTimeErrorMessage = "Trigger time field was not entered in correct format. Please verify this field.";
	if (tmpTriggerTime == null || tmpTriggerTime.length == 0) {
		// nothing to do since it can be blank. It's re-setup to CURRENT TIMESTAMP when this field is blank.
	} else if (tmpTriggerTime.length != 19) {
		alert(tmpTriggerTimeErrorMessage);
		return;
	} else if (tmpTriggerTime.charAt(10) != " ") {
		alert(tmpTriggerTimeErrorMessage);
		return;
	} else {
		if (checkDateInput(tmpTriggerTime.substring(0, 10), tmpTriggerTimeErrorMessage)) {
			if (checkTimeInput(tmpTriggerTime.substring(11, 19), tmpTriggerTimeErrorMessage)) {
				// nothing to do since it's a valid Date and Time.
			} else {
				return;
			}
		} else {
			return;
		}
	} */
	
	var selectedRadioValue = jQuery("input[name='id_triggeridupdatetriggertime_triggertime_fieldset']:checked").val();
	var obj = new Object();
	if (selectedRadioValue == "OLD") {
		var reduceDays = jQuery("#id_triggeridupdatetriggertime_triggertime_old_text").val();
		if (reduceDays == null) {
			alert("Please enter a number to show how many days you want to reverse time");
			return;
		} else {
			reduceDays = reduceDays.trim();
			if (reduceDays.length == 0 || isNaN(reduceDays)) {
				alert("Please enter a number to show how many days you want to reverse time");
				return;
			} else {
				obj.reductionDays = reduceDays;
			}
		}	
	}
	
	obj.triggerCd = localTriggeridUpdateTriggerTime_TriggerCd;
	obj.applStatus = jQuery("#id_triggeridupdatetriggertime_applstatus").val();
	obj.schedStatus = jQuery("#id_triggeridupdatetriggertime_schedulestatus").val();
	obj.updateTimeAction = selectedRadioValue;
	//alert(JSON.stringify(obj));
	
	jQuery("#id_triggeridupdatetriggertime_savetriggerid_button").attr("disabled", "true");
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath+"/action/admin/trigger/updateTriggeridTriggerTime?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
	
		var flag = data.flag;
		var text = data.text;
		alert(text);
		
		if (flag == "1") {
			var trigger = data.trigger;
			jQuery("#id_triggeridupdatetriggertime_triggertime_indb").val(trigger.triggerTimeStr);
		}
		
		jQuery("#id_triggeridupdatetriggertime_savetriggerid_button").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_triggeridupdatetriggertime_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteTriggerid() {
	
	var selectedTrigger = jQuery("input[name='name_triggeridlist_table_radio']:checked");
	
	if (selectedTrigger.length == 1) {
		localTriggeridList_selectedTriggerCd = jQuery(selectedTrigger.get(0)).val();
		IBMCore.common.widget.overlay.show("id_confirmation_deleteselectedtriggerid");
		jQuery("#id_confirmation_selectedTriggerid").text(localTriggeridList_selectedTriggerCd);
	} else {
		alert("please select one trigger to delete.");
		return;
	}
}

function deleteSelectedTriggeridOk() {

	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedtriggerid").getId(), true);
	jQuery("#id_triggerlist_delete_button").attr("disabled", "true");
	
	var obj = new Object();
	obj.triggerCd = localTriggeridList_selectedTriggerCd;
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/admin/trigger/deleteTriggerid?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var triggeridList = data.triggeridList;
		var text = data.text;
		alert(text);
		jQuery("#id_triggerlist_delete_button").removeAttr("disabled");
		initTriggeridListDataDiv(triggeridList, "delete");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_triggerlistdatadiv").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedTriggeridCancel() {

	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedtriggerid").getId(), true);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
var localApplicationEdit_applCd;
var localApplicationEdit_action;
var localApplicationEdit_saveSuccess;
var localApplicationList_selectedApplCd;
var localApplicationList_searchText;

function initApplicationListPageOverlay() {

	var overlayStr = "<div id='id_applicationlist_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_applicationlist_page_overlay_main").append(overlayStr);
	jQuery("#id_applicationlist_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_applicationlist_page_overlay");
}

function manageApplication() {
	initApplicationListPageOverlay();
	initApplicationListPage("init");
}

function initApplicationListPage(action) {
	
	if (action == "init") {
		localApplicationList_searchText = "";
	}
	
	var myApplicationListTableSorting = Cookies.get("myApplicationListTableColSort");
    if (myApplicationListTableSorting === undefined) { 
        myApplicationListTableSorting = '[[1, "asc"]]';
        Cookies.set("myApplicationListTableColSort", myApplicationListTableSorting, {expires: 999});
        console.log("myApplicationListTableColSort initializing column sorting in cookie " + myApplicationListTableSorting);
    }
    
	jQuery.get(
		localContextPath+"/action/admin/trigger/getApplicationAll/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
	)
	.done(function(data) {
		var overlayStr = "<div style='width: 95%; align: center; margin-left: auto; margin-right: auto;'>";
		overlayStr += "<div>";
		overlayStr += "</div>";
		overlayStr += "<form id='id_applicationlistform' class='ibm-column-form' method='post'>";
		overlayStr += "<div>";
		overlayStr += "<input type='button' id='id_applicationlist_add_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='editApplication(\"new\")' value='Add application'/>&nbsp;";
		overlayStr += "<input type='button' id='id_applicationlist_edit_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='editApplication(\"update\")' value='Edit application'/>&nbsp;";
		overlayStr += "<input type='button' id='id_applicationlist_delete_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='deleteApplication()' value='Delete application'/>&nbsp;";
		overlayStr += "<input type='button' id='id_applicationlist_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_applicationlist_page_overlay\")' value='Close'/>";
		overlayStr += "</div>";
		overlayStr += "<div id='id_applicationlistdiv'>";
		overlayStr += "</div>";
		overlayStr += "</form>";
		overlayStr += "<div>";
		overlayStr += "</div>";
		overlayStr += "</div>";
		
		jQuery("#id_applicationlist_page_overlay").empty().append(overlayStr);
		
		var applicationList = data;
		initApplicationListDiv(applicationList, action);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_applicationlist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function initApplicationListDiv(applicationList, action) {

	if (action == "delete") {
		saveApplicationListTableSearchText();
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
			if (appl.tabCd == null || appl.tabCd == "") {
				tableStr += "<td></td>";
			} else {
				if (appl.tabDesc == null) {
					tableStr += "<td>" + appl.tabCd + " - N/A</td>";
				} else {
					tableStr += "<td>" + appl.tabCd + "</td>";
				}
			}
			tableStr += "</tr>";
		}
		
		tableStr += "</tbody>";
		tableStr += "</table>";
		tableStr += "</div>";
		
		jQuery("#id_applicationlistdiv").append(tableStr);
		//jQuery("#id_applicationlist_table").DataTable({paging:false, searching:true, info:true, order:[[1, "asc"]], columnDefs: [{targets: [0], orderable: false}]});
		var myApplicationListTableSetting = {info: true, paging: false, searching: true};
		myApplicationListTableSetting.order = eval(Cookies.get("myApplicationListTableColSort"));
		myApplicationListTableSetting.columnDefs = [JSON.parse('{"targets": [0], "orderable": false}')];
		var table = jQuery("#id_applicationlist_table").DataTable(myApplicationListTableSetting);
		jQuery("#id_applicationlist_table").on("order.dt", function () {
			var order = JSON.stringify(table.order());
			Cookies.set("myApplicationListTableColSort", order, {expires: 999});
        });
		if (localApplicationList_searchText != "") {
			jQuery("#id_applicationlist_table_filter").find("input[type='search']").val(localApplicationList_searchText).keyup();
		}
	}
}

function saveApplicationListTableSearchText() {
	localApplicationList_searchText = "";
	var currTable = jQuery("#id_applicationlist_table");
	if (currTable.length > 0) {
		localApplicationList_searchText = jQuery("#id_applicationlist_table_filter").find("input[type='search']").val();
	}
}

function initApplicationEditPageOverlay() {
	
	var overlayStr = "<div id='id_applicationedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
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
		IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_applicationlist_page_overlay").getId(), true);
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
			IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_applicationlist_page_overlay").getId(), true);
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
	overlayStr += "<tr><td>Application&nbsp;sequence&nbsp;No.:<span class='ibm-required'>*</span></td><td><input type='text' id='id_applicationedit_sequencenumber' name='applicationedit_sequencenumber' size='20' maxlength='8'></input></td></tr>";
	overlayStr += "<tr><td>Data load tab code:</td><td><select id='id_applicationedit_dataloadtab' class='ibm-styled' title='dataloadtab' style='width: 150px;'></select></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_applicationedit_saveapplication_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='applicationedit_saveApplication()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_applicationedit_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='applicationedit_closeOverlay(\"id_applicationedit_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";

	jQuery("#id_applicationedit_page_overlay").empty().append(overlayStr);
}

function applicationedit_closeOverlay(myOverId) {
	
	if(localApplicationEdit_saveSuccess == "Y") {
		saveApplicationListTableSearchText();
	}	
	
	closeOverlay(myOverId);
	IBMCore.common.widget.overlay.show("id_applicationlist_page_overlay");

	if(localApplicationEdit_saveSuccess == "Y") {
		jQuery("#id_applicationlist_page_overlay").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
		initApplicationListPage("edit");
		localApplicationEdit_saveSuccess = "N";
	}
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
		if (tmpApplSeqNo == null) {
			alert("Application sequence No. must be a valid number.");
			return;
		} else {
			tmpApplSeqNo = tmpApplSeqNo.trim();
			if (tmpApplSeqNo.length == 0 || isNaN(tmpApplSeqNo) || (tmpApplSeqNo < 0)) {
				alert("Application sequence No. must be a valid number.");
				return;
			}
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
					localApplicationEdit_saveSuccess = "Y";
				} else {
					jQuery("#id_applicationedit_applcd").removeAttr("disabled");
				}
			} else if (localApplicationEdit_action == "update") {
				if (flag == "1") {
					localApplicationEdit_saveSuccess = "Y";
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

function deleteApplication() {
	
	var selectedAppl = jQuery("input[name='name_applicationlist_table_radio']:checked");
	
	if (selectedAppl.length == 1) {
		localApplicationList_selectedApplCd = jQuery(selectedAppl.get(0)).val();
		IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_applicationlist_page_overlay").getId(), true);
		IBMCore.common.widget.overlay.show("id_confirmation_deleteselectedapplication");
		jQuery("#id_confirmation_selectedApplication").text(localApplicationList_selectedApplCd);
	} else {
		alert("please select one application to delete.");
		return;
	}
}

function deleteSelectedApplicationOk() {

	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedapplication").getId(), true);
	IBMCore.common.widget.overlay.show("id_applicationlist_page_overlay");
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
		initApplicationListDiv(applicationList, "delete");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_applicationlist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedApplicationCancel() {

	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedapplication").getId(), true);
	IBMCore.common.widget.overlay.show("id_applicationlist_page_overlay");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
var localDataloadtabEdit_tabCd;
var localDataloadtabEdit_action;
var localDataloadtabEdit_saveSuccess;
var localDataloadtabList_selectedTabCd;
var localDataloadtabList_searchText;

function saveDataloadtabListTableSearchText() {
	localDataloadtabList_searchText = "";
	var currTable = jQuery("#id_dataloadtabListTable");
	if (currTable.length > 0) {
		localDataloadtabList_searchText = jQuery("#id_dataloadtabListTable_filter").find("input[type='search']").val();
	}
}

function initDataloadtabListPageOverlay() {
	
	var overlayStr = "<div id='id_dataloadtablist_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_dataloadtablist_page_overlay_main").append(overlayStr);
	jQuery("#id_dataloadtablist_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_dataloadtablist_page_overlay");
}

function manageDataloadtab() {
	initDataloadtabListPageOverlay();
	initDataloadtabListPage("init");
}

function initDataloadtabListPage(action) {

	if (action == "init") {
		localDataloadtabList_searchText = "";
	}

	var myDataloadtabListTableSorting = Cookies.get("myDataloadtabListTableColSort");
    if (myDataloadtabListTableSorting === undefined) { 
        myDataloadtabListTableSorting = '[[3, "asc"]]';
        Cookies.set("myDataloadtabListTableColSort", myDataloadtabListTableSorting, {expires: 999});
        console.log("myDataloadtabListTableColSort initializing column sorting in cookie " + myDataloadtabListTableSorting);
    }
    
	jQuery.get(
		localContextPath+"/action/admin/trigger/getDataloadtabAll/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
	)
	.done(function(data) {
		var overlayStr = "<div style='width: 95%; align: center; margin-left: auto; margin-right: auto;'>";
		overlayStr += "<div>";
		overlayStr += "</div>";
		overlayStr += "<form id='id_dataloadtabListForm' class='ibm-column-form' method='post'>";
		overlayStr += "<div>";
		overlayStr += "<input type='button' id='id_dataloadtablist_add_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='editDataloadtab(\"new\")' value='Add data load tab'/>&nbsp;";
		overlayStr += "<input type='button' id='id_dataloadtablist_edit_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='editDataloadtab(\"update\")' value='Edit data load tab'/>&nbsp;";
		overlayStr += "<input type='button' id='id_dataloadtablist_delete_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='deleteDataloadtab()' value='Delete data load tab'/>&nbsp;";
		overlayStr += "<input type='button' id='id_dataloadtablist_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_dataloadtablist_page_overlay\")' value='Close'/>";
		overlayStr += "</div>";
		overlayStr += "<div id='id_dataloadtabListDiv'>";
		overlayStr += "</div>";
		overlayStr += "</form>";
		overlayStr += "<div>";
		overlayStr += "</div>";
		overlayStr += "</div>";
	
		jQuery("#id_dataloadtablist_page_overlay").empty().append(overlayStr);
		
		var dataloadtabList = data;
		initDataloadtabListDiv(dataloadtabList, action);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_dataloadtablist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function initDataloadtabListDiv(dataloadtabList, action) {

	if (action == "delete") {
		saveDataloadtabListTableSearchText();
	}

	jQuery("#id_dataloadtabListDiv").empty();
	
	if (dataloadtabList == null || dataloadtabList.length == 0) {
		jQuery("#id_dataloadtabListDiv").append("Currently, there is not any data load tab.");
	} else {
		var dataloadtabListLength = dataloadtabList.length;
		var tableStr = "<div>";
		tableStr += "<table id='id_dataloadtabListTable' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='true'>";
		tableStr += "<thead><tr>";
		tableStr += "<th scope='col'></th>";
		tableStr += "<th scope='col'>Tab code</th>";
		tableStr += "<th scope='col'>Tab description</th>";
		tableStr += "<th scope='col'>Tab sequence No.</th>";
		tableStr += "</tr></thead>";
		tableStr += "<tbody>";
		
		for (var i = 0; i < dataloadtabListLength; i++) {

			var currTab = dataloadtabList[i];

			tableStr += "<tr>";
			tableStr += "<td scope='row'><span class='ibm-radio-wrapper'><input id='id_dataloadtablist_tr_" + currTab.tabCd + "' name='name_dataloadtablist_table_radio' value='" + currTab.tabCd + "' type='radio' class='ibm-styled-radio'></input><label class='ibm-field-label' for='id_dataloadtablist_tr_" + currTab.tabCd + "'></label></span></td>";
			tableStr += "<td>" + currTab.tabCd + "</td>";
			tableStr += "<td>" + currTab.tabDesc + "</td>";
			tableStr += "<td>" + currTab.tabSeqNo + "</td>";
			tableStr += "</tr>";
		}
		
		tableStr += "</tbody>";
		tableStr += "</table>";
		tableStr += "</div>";
		
		jQuery("#id_dataloadtabListDiv").append(tableStr);
		//jQuery("#id_dataloadtabListTable").DataTable({paging:false, searching:true, info:true, order:[[3, "asc"]], columnDefs: [{targets: [0], orderable: false}]});
		var myDataloadtabListTableSetting = {info: true, paging: false, searching: true};
		myDataloadtabListTableSetting.order = eval(Cookies.get("myDataloadtabListTableColSort"));
		myDataloadtabListTableSetting.columnDefs = [JSON.parse('{"targets": [0], "orderable": false}')];
		var table = jQuery("#id_dataloadtabListTable").DataTable(myDataloadtabListTableSetting);
		jQuery("#id_dataloadtabListTable").on("order.dt", function () {
			var order = JSON.stringify(table.order());
			Cookies.set("myDataloadtabListTableColSort", order, {expires: 999});
        });
		if (localDataloadtabList_searchText != "") {
			jQuery("#id_dataloadtabListTable_filter").find("input[type='search']").val(localDataloadtabList_searchText).keyup();
		}
	}	
}

function initDataloadtabEditPageOverlay() {
	
	var overlayStr = "<div id='id_dataloadtabedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_dataloadtabedit_page_overlay_main").append(overlayStr);
	jQuery("#id_dataloadtabedit_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_dataloadtabedit_page_overlay");
}

function editDataloadtab(action) {

	localDataloadtabEdit_action = action;
	
	var overlayStr = "<form id='id_dataloadtabEditForm' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='id_dataloadtabEditDiv'>";
	overlayStr += "<table>";
	overlayStr += "<tr><td>Data load tab code:<span class='ibm-required'>*</span></td><td><input type='text' id='id_dataloadtabedit_tabCd' maxlength='8' size='20' readonly disabled></td></tr>";
	overlayStr += "<tr><td>Data load tab description:<span class='ibm-required'>*</span></td><td><input type='text' id='id_dataloadtabedit_tabDesc' maxlength='24' size='50'></td></tr>";
	overlayStr += "<tr><td>Data load tab sequence No.:<span class='ibm-required'>*</span></td><td><input type='text' id='id_dataloadtabedit_tabSeqNo' size='20' maxlength='8'></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_dataloadtabedit_savetab_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='dataloadtabedit_saveTab()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_dataloadtabedit_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='dataloadtabedit_closeOverlay(\"id_dataloadtabedit_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";

	if (action == "new") {
	
		localDataloadtabEdit_tabCd = "";
		IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_dataloadtablist_page_overlay").getId(), true);
		initDataloadtabEditPageOverlay();
		jQuery("#id_dataloadtabedit_page_overlay").empty().append(overlayStr);
		jQuery("#id_dataloadtabedit_tabCd").removeAttr("disabled").removeAttr("readonly");
		
	} else if (action == "update") {
		
		var selectedDataloadtab = jQuery("input[name='name_dataloadtablist_table_radio']:checked");
		
		if (selectedDataloadtab.length == 1) {
			
			localDataloadtabEdit_tabCd = jQuery(selectedDataloadtab.get(0)).val();
			IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_dataloadtablist_page_overlay").getId(), true);
			initDataloadtabEditPageOverlay();
			
			var obj = new Object();
			obj.tabCd = localDataloadtabEdit_tabCd;
			
			jQuery.ajax({
				type : "POST",
				url : localContextPath+"/action/admin/trigger/getDataloadtabEdit?timeid="+(new Date()).valueOf(),
				data : JSON.stringify(obj),
				contentType : "application/json",
				dataType : "json",
			})
			.done(function(data) {
				jQuery("#id_dataloadtabedit_page_overlay").empty().append(overlayStr);
				var dataloadtab = data;
				jQuery("#id_dataloadtabedit_tabCd").val(dataloadtab.tabCd);
				jQuery("#id_dataloadtabedit_tabDesc").val(dataloadtab.tabDesc);
				jQuery("#id_dataloadtabedit_tabSeqNo").val(dataloadtab.tabSeqNo);
			})
			.fail(function(jqXHR, textStatus, errorThrown) {
				jQuery("#id_dataloadtabedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
				console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
				console.log(		"ajax error in loading...textStatus..."	+textStatus); 
				console.log(		"ajax error in loading...errorThrown..."+errorThrown);
			})
		} else {
			alert("please select one data load tab to edit.");
			return;
		}
	}
}

function dataloadtabedit_saveTab() {
	
	var newObject = new Object();
	
	if (localDataloadtabEdit_action == "new") {
		
		var newTabCd = jQuery("#id_dataloadtabedit_tabCd").val();
		if (newTabCd == null || newTabCd.length < 1) {
			alert("Data load tab code cannot be empty. Please enter a value.");
			return;
		}
	
		var newTabDescription = jQuery("#id_dataloadtabedit_tabDesc").val();
		if (newTabDescription == null || newTabDescription.length < 1) {
			alert("Data load tab description cannot be empty. Please enter a value.");
			return;
		}
	
		var newTabSeqNo = jQuery("#id_dataloadtabedit_tabSeqNo").val();
		if (newTabSeqNo == null) {
			alert("Data load tab sequence No. cannot be empty. Please enter a value.");
			return;
		} else {
			newTabSeqNo = newTabSeqNo.trim();
			if (newTabSeqNo.length < 1 || isNaN(newTabSeqNo)) {
				alert("Please enter a valid number into Data load tab sequence No. field.");
				return;
			}
		}	
		
		newObject.tabCd = newTabCd;
		newObject.tabDesc = newTabDescription;
		newObject.tabSeqNo = newTabSeqNo;
		
	} else if (localDataloadtabEdit_action == "update") {
		
		var newTabDescription = jQuery("#id_dataloadtabedit_tabDesc").val();
		if (newTabDescription == null || newTabDescription.length < 1) {
			alert("Data load tab description cannot be empty. Please enter a value.");
			return;
		}
	
		var newTabSeqNo = jQuery("#id_dataloadtabedit_tabSeqNo").val();
		if (newTabSeqNo == null) {
			alert("Data load tab sequence No. cannot be empty. Please enter a value.");
			return;
		} else {
			newTabSeqNo = newTabSeqNo.trim();
			if (newTabSeqNo.length < 1 || isNaN(newTabSeqNo)) {
				alert("Please enter a valid number into Data load tab sequence No. field.");
				return;
			}
		}
		
		newObject.tabCd = localDataloadtabEdit_tabCd;
		newObject.tabDesc = newTabDescription;
		newObject.tabSeqNo = newTabSeqNo;
	}
	
	jQuery("#id_dataloadtabedit_savetab_button").attr("disabled", "true");
	if (localDataloadtabEdit_action == "new") {
		jQuery("#id_dataloadtabedit_tabCd").attr("disabled", true).attr("readonly", true);
	}
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath+"/action/admin/trigger/updateDataloadtab/"+localDataloadtabEdit_action+"?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(newObject),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		
		var flag = data.flag;
		var text = data.text;
		
		if (localDataloadtabEdit_action == "new") {
			if (flag == "1") {
				localDataloadtabEdit_action = "update";
				localDataloadtabEdit_tabCd = newObject.tabCd;
				localDataloadtabEdit_saveSuccess = "Y";
			} else if (flag == "0") {
				jQuery("#id_dataloadtabedit_tabCd").removeAttr("disabled").removeAttr("readonly");
			}
			alert(text);
		} else if (localDataloadtabEdit_action == "update") {
			if (flag == "1") {
				localDataloadtabEdit_saveSuccess = "Y";
			}
			alert(text);
		}
		
		jQuery("#id_dataloadtabedit_savetab_button").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_dataloadtabedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function dataloadtabedit_closeOverlay(myOverId) {

	if(localDataloadtabEdit_saveSuccess == "Y") {
		saveDataloadtabListTableSearchText();
	}
	
	closeOverlay(myOverId);
	IBMCore.common.widget.overlay.show("id_dataloadtablist_page_overlay");
	
	if(localDataloadtabEdit_saveSuccess == "Y") {
		jQuery("#id_dataloadtablist_page_overlay").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
		initDataloadtabListPage("edit");
		localDataloadtabEdit_saveSuccess = "N";
	}
}

function deleteDataloadtab() {
	
	var selectedDataloadtab = jQuery("input[name='name_dataloadtablist_table_radio']:checked");
	
	if (selectedDataloadtab.length == 1) {
		localDataloadtabList_selectedTabCd = jQuery(selectedDataloadtab.get(0)).val();
		IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_dataloadtablist_page_overlay").getId(), true);
		IBMCore.common.widget.overlay.show("id_confirmation_deleteselecteddataloadtab");
		jQuery("#id_confirmation_selecteddataloadtab").text(localDataloadtabList_selectedTabCd);
	} else {
		alert("please select one data load tab to delete.");
		return;
	}
}

function deleteSelectedDataloadtabOk() {

	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselecteddataloadtab").getId(), true);
	IBMCore.common.widget.overlay.show("id_dataloadtablist_page_overlay");
	jQuery("#id_dataloadtablist_delete_button").attr("disabled", "true");
	
	var obj = new Object();
	obj.tabCd = localDataloadtabList_selectedTabCd;
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/admin/trigger/deleteDataloadtab?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var dataloadtabList = data.dataloadtabList;
		var text = data.text;
		alert(text);
		jQuery("#id_dataloadtablist_delete_button").removeAttr("disabled");
		initDataloadtabListDiv(dataloadtabList, "delete");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_dataloadtablist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedDataloadtabCancel() {

	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselecteddataloadtab").getId(), true);
	IBMCore.common.widget.overlay.show("id_dataloadtablist_page_overlay");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
var localFederatedTriggersEdit_triggerCd;
var localFederatedTriggersEdit_srcTriggerCd;
var localFederatedTriggersEdit_relation;
var localFederatedTriggersEdit_newObject;
var localFederatedTriggersEdit_action;
var localFederatedTriggersEdit_saveSuccess;
var localFederatedTriggersList_delectedTriggerCd;
var localFederatedTriggersList_delectedSrcTriggerCd;
var localFederatedTriggersList_searchText;

function federatedTriggers() {
	initFederatedTriggersListPageOverlay();
	initFederatedTriggersListPage("init");
}

function initFederatedTriggersListPageOverlay() {
	
	var overlayStr = "<div id='id_federatedtriggerslist_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_federatedtriggerslist_page_overlay_main").append(overlayStr);
	jQuery("#id_federatedtriggerslist_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_federatedtriggerslist_page_overlay");
}

function initFederatedTriggersListPage(action) {

	if (action == "init") {
		localFederatedTriggersList_searchText = "";
	}

	var myFederatedTriggersListTableSorting = Cookies.get("myFederatedTriggersListTableColSort");
    if (myFederatedTriggersListTableSorting === undefined) { 
        myFederatedTriggersListTableSorting = '[[1, "asc"]]';
        Cookies.set("myFederatedTriggersListTableColSort", myFederatedTriggersListTableSorting, {expires: 999});
        console.log("myFederatedTriggersListTableColSort initializing column sorting in cookie " + myFederatedTriggersListTableSorting);
    }
    
	jQuery.get(
		localContextPath+"/action/admin/trigger/getFederatedTriggersAll/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
	)
	.done(function(data) {
		var overlayStr = "<div style='width: 95%; align: center; margin-left: auto; margin-right: auto;'>";
		overlayStr += "<div>";
		overlayStr += "</div>";
		overlayStr += "<form id='id_federatedTriggersListForm' class='ibm-column-form' method='post'>";
		overlayStr += "<div>";
		overlayStr += "<input type='button' id='id_federatedtriggerslist_add_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='editFederatedTrigger(\"new\")' value='Add federated trigger'/>&nbsp;";
		overlayStr += "<input type='button' id='id_federatedtriggerslist_edit_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='editFederatedTrigger(\"update\")' value='Edit federated trigger'/>&nbsp;";
		overlayStr += "<input type='button' id='id_federatedtriggerslist_delete_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='deleteFederatedTrigger()' value='Delete federated trigger'/>&nbsp;";
		overlayStr += "<input type='button' id='id_federatedtriggerslist_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_federatedtriggerslist_page_overlay\")' value='Close'/>";
		overlayStr += "</div>";
		overlayStr += "<div id='id_federatedTriggersListDiv'>";
		overlayStr += "</div>";
		overlayStr += "</form>";
		overlayStr += "<div>";
		overlayStr += "</div>";
		overlayStr += "</div>";
	
		jQuery("#id_federatedtriggerslist_page_overlay").empty().append(overlayStr);
		
		var federatedTriggersList = data;
		initFederatedTriggersListDiv(federatedTriggersList, action);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_federatedtriggerslist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function initFederatedTriggersListDiv(federatedTriggersList, action) {

	if (action == "delete") {
		saveFederatedTriggersListTableSearchText();
	}

	jQuery("#id_federatedTriggersListDiv").empty();
	
	if (federatedTriggersList == null || federatedTriggersList.length == 0) {
		jQuery("#id_federatedTriggersListDiv").append("Currently, there is not any federated trigger.");
	} else {
		var federatedTriggersListLength = federatedTriggersList.length;
		var tableStr = "<div>";
		tableStr += "<table id='id_federatedTriggersListTable' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='true'>";
		tableStr += "<thead><tr>";
		tableStr += "<th scope='col'></th>";
		tableStr += "<th scope='col'>Trigger code</th>";
		tableStr += "<th scope='col'>Source trigger code</th>";
		tableStr += "<th scope='col'>Relation</th>";
		tableStr += "<th scope='col'>AI time factor(hours)</th>";
		tableStr += "</tr></thead>";
		tableStr += "<tbody>";
		
		for (var i = 0; i < federatedTriggersListLength; i++) {

			var currFederated = federatedTriggersList[i];

			tableStr += "<tr>";
			tableStr += "<td scope='row'><span class='ibm-radio-wrapper'><input id='id_federatedtriggerslist_tr_" + currFederated.id.triggerCd + "__biibmsplit__" + currFederated.id.srcTriggerCd + "' name='name_federatedtriggerslist_table_radio' value='" + currFederated.id.triggerCd + "__biibmsplit__" + currFederated.id.srcTriggerCd + "' myTriggerCd='" + currFederated.id.triggerCd + "' mySrcTriggerCd='" + currFederated.id.srcTriggerCd + "' myRelation='" + currFederated.relation + "' type='radio' class='ibm-styled-radio'></input><label class='ibm-field-label' for='id_federatedtriggerslist_tr_" + currFederated.id.triggerCd + "__biibmsplit__" + currFederated.id.srcTriggerCd + "'></label></span></td>";
			tableStr += "<td>" + currFederated.id.triggerCd + "</td>";
			tableStr += "<td>" + currFederated.id.srcTriggerCd + "</td>";
			tableStr += "<td>" + currFederated.relation + "</td>";
			tableStr += "<td>" + currFederated.aiTimeFactor + "</td>";
			tableStr += "</tr>";
		}
		
		tableStr += "</tbody>";
		tableStr += "</table>";
		tableStr += "</div>";
		
		jQuery("#id_federatedTriggersListDiv").append(tableStr);
		var myFederatedTriggersListTableSetting = {info: true, paging: false, searching: true};
		myFederatedTriggersListTableSetting.order = eval(Cookies.get("myFederatedTriggersListTableColSort"));
		myFederatedTriggersListTableSetting.columnDefs = [JSON.parse('{"targets": [0], "orderable": false}')];
		var table = jQuery("#id_federatedTriggersListTable").DataTable(myFederatedTriggersListTableSetting);
		jQuery("#id_federatedTriggersListTable").on("order.dt", function () {
			var order = JSON.stringify(table.order());
			Cookies.set("myFederatedTriggersListTableColSort", order, {expires: 999});
        });
		if (localFederatedTriggersList_searchText != "") {
			jQuery("#id_federatedTriggersListTable_filter").find("input[type='search']").val(localFederatedTriggersList_searchText).keyup();
		}
	}	
}

function saveFederatedTriggersListTableSearchText() {
	localFederatedTriggersList_searchText = "";
	var currTable = jQuery("#id_federatedTriggersListTable");
	if (currTable.length > 0) {
		localFederatedTriggersList_searchText = jQuery("#id_federatedTriggersListTable_filter").find("input[type='search']").val();
	}
}

function initFederatedTriggersEditPageOverlay() {
	
	var overlayStr = "<div id='id_federatedtriggersedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_federatedtriggersedit_page_overlay_main").append(overlayStr);
	jQuery("#id_federatedtriggersedit_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_federatedtriggersedit_page_overlay");
}

function editFederatedTrigger(action) {

	localFederatedTriggersEdit_action = action;
	
	var overlayStr = "<form id='id_federatedTriggersEditForm' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='id_federatedTriggersEditDiv'>";
	overlayStr += "<table>";
	if (action == "new") {
		overlayStr += "<tr><td>Trigger code:<span class='ibm-required'>*</span></td><td><select id='id_federatedtriggersedit_triggercd' class='ibm-styled' title='triggercd' style='width: 300px;'></select></td></tr>";
		overlayStr += "<tr><td>Source trigger code:<span class='ibm-required'>*</span></td><td><select id='id_federatedtriggersedit_srctriggercd' class='ibm-styled' title='srctriggercd' style='width: 300px;'></td></tr>";
	} else if (action == "update") {
		overlayStr += "<tr><td>Trigger code:<span class='ibm-required'>*</span></td><td><input type='text' id='id_federatedtriggersedit_triggercd' name='federatedtriggersedit_triggercd' size='60' readonly disabled></input></td></tr>";
		overlayStr += "<tr><td>Source trigger code:<span class='ibm-required'>*</span></td><td><input type='text' id='id_federatedtriggersedit_srctriggercd' name='federatedtriggersedit_srctriggercd' size='60' readonly disabled></input></td></tr>";
	}
	overlayStr += "<tr><td>Relation:<span class='ibm-required'>*</span></td><td><select id='id_federatedtriggersedit_relation' class='ibm-styled' title='relation' style='width: 120px;'></select></td></tr>";
	overlayStr += "<tr><td>AI time factor(hours):<span class='ibm-required'>*</span></td><td><input type='text' id='id_federatedtriggersedit_aitimefactor' size='8' maxlength='3'></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_federatedtriggersedit_save_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='federatedtriggersedit_saveFederatedTriggers()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_federatedtriggersedit_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='federatedtriggersedit_closeOverlay(\"id_federatedtriggersedit_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";

	if (action == "new") {
		localFederatedTriggersEdit_triggerCd = "";
		localFederatedTriggersEdit_srcTriggerCd = "";
		localFederatedTriggersEdit_relation = "";
		IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_federatedtriggerslist_page_overlay").getId(), true);
		initFederatedTriggersEditPageOverlay();
		
		jQuery.get(
			localContextPath+"/action/admin/trigger/getFederatedTriggersNew/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {

			var triggerList = data;

			jQuery("#id_federatedtriggersedit_page_overlay").empty().append(overlayStr);
			
			var triggerListLength = triggerList.length;
			var triggerOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < triggerListLength; i++) {
				var currTrigger = triggerList[i];
				if (currTrigger.triggerDesc == null || currTrigger.triggerDesc == "") {
					triggerOptionStr += "<option value='" + currTrigger.triggerCd + "'>" + currTrigger.triggerCd + "</option>";
				} else {
					triggerOptionStr += "<option value='" + currTrigger.triggerCd + "'>" + currTrigger.triggerCd + " --> " + currTrigger.triggerDesc + "</option>";
				}
			}
			jQuery("#id_federatedtriggersedit_triggercd").empty().append(triggerOptionStr);
			IBMCore.common.widget.selectlist.init("#id_federatedtriggersedit_triggercd");
			jQuery("#id_federatedtriggersedit_srctriggercd").empty().append(triggerOptionStr);
			IBMCore.common.widget.selectlist.init("#id_federatedtriggersedit_srctriggercd");
			
			var initRelationOptionStr = "<option value='none'>Please select one</option>";
			initRelationOptionStr += "<option value='AND'>AND</option>";
			initRelationOptionStr += "<option value='OR'>OR</option>";
			jQuery("#id_federatedtriggersedit_relation").empty().append(initRelationOptionStr);
			IBMCore.common.widget.selectlist.init("#id_federatedtriggersedit_relation");
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_throttleedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else if (action == "update") {
		
		var selectedFederatedTrigger = jQuery("input[name='name_federatedtriggerslist_table_radio']:checked");
		
		if (selectedFederatedTrigger.length == 1) {
			
			var selectOne = jQuery(selectedFederatedTrigger.get(0));
			
			localFederatedTriggersEdit_triggerCd = selectOne.attr("myTriggerCd");
			localFederatedTriggersEdit_srcTriggerCd = selectOne.attr("mySrcTriggerCd");
			localFederatedTriggersEdit_relation = selectOne.attr("myRelation");
			
			IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_federatedtriggerslist_page_overlay").getId(), true);
			initFederatedTriggersEditPageOverlay();
			
			var obj = new Object();
			obj.triggerCd = localFederatedTriggersEdit_triggerCd;
			obj.srcTriggerCd = localFederatedTriggersEdit_srcTriggerCd;
			
			jQuery.ajax({
				type : "POST",
				url : localContextPath+"/action/admin/trigger/getFederatedTriggersEdit?timeid="+(new Date()).valueOf(),
				data : JSON.stringify(obj),
				contentType : "application/json",
				dataType : "json",
			})
			.done(function(data) {
				jQuery("#id_federatedtriggersedit_page_overlay").empty().append(overlayStr);
				
				var federatedTrigger = data.federatedTrigger;
				var triggerList = data.triggerList;
				
				var dataTriggerCd = federatedTrigger.id.triggerCd;
				var dataSrcTriggerCd = federatedTrigger.id.srcTriggerCd;
				var triggerCdExisted = false;
				var srcTriggerCdExisted = false;
				var triggerCdExistedValue = "";
				var srcTriggerCdExistedValue = "";
				var triggerListLength = triggerList.length;
				for (var i = 0; i < triggerListLength; i++) {
					var currTrigger = triggerList[i];
					if (currTrigger.triggerCd == dataTriggerCd) {
						triggerCdExisted = true;
						if (currTrigger.triggerDesc == null || currTrigger.triggerDesc == "") {
							triggerCdExistedValue = currTrigger.triggerCd;
						} else {
							triggerCdExistedValue = currTrigger.triggerCd + " --> " + currTrigger.triggerDesc;
						}
					}
					if (currTrigger.triggerCd == dataSrcTriggerCd) {
						srcTriggerCdExisted = true;
						if (currTrigger.triggerDesc == null || currTrigger.triggerDesc == "") {
							srcTriggerCdExistedValue = currTrigger.triggerCd;
						} else {
							srcTriggerCdExistedValue = currTrigger.triggerCd + " --> " + currTrigger.triggerDesc;
						}
					}
					if (triggerCdExisted && srcTriggerCdExistedValue) {
						break;
					}
				}
				if (triggerCdExisted) {
					jQuery("#id_federatedtriggersedit_triggercd").val(triggerCdExistedValue);
				} else {
					jQuery("#id_federatedtriggersedit_triggercd").val(dataTriggerCd + " --> N/A");
				}
				if (srcTriggerCdExistedValue) {
					jQuery("#id_federatedtriggersedit_srctriggercd").val(srcTriggerCdExistedValue);
				} else {
					jQuery("#id_federatedtriggersedit_srctriggercd").val(dataSrcTriggerCd + " --> N/A");
				}
				
				localFederatedTriggersEdit_relation = federatedTrigger.relation;
				var initRelationOptionStr = "<option value='none'>Please select one</option>";
				if (federatedTrigger.relation == "AND") {
					initRelationOptionStr += "<option value='AND' selected>AND</option>";
					initRelationOptionStr += "<option value='OR'>OR</option>";
				} else {
					initRelationOptionStr += "<option value='AND'>AND</option>";
					initRelationOptionStr += "<option value='OR' selected>OR</option>";
				}
				jQuery("#id_federatedtriggersedit_relation").empty().append(initRelationOptionStr);
				IBMCore.common.widget.selectlist.init("#id_federatedtriggersedit_relation");
				
				jQuery("#id_federatedtriggersedit_aitimefactor").val(federatedTrigger.aiTimeFactor);
			})
			.fail(function(jqXHR, textStatus, errorThrown) {
				jQuery("#id_federatedtriggersedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
				console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
				console.log(		"ajax error in loading...textStatus..."	+textStatus); 
				console.log(		"ajax error in loading...errorThrown..."+errorThrown);
			})
		} else {
			alert("please select one federated trigger to edit.");
			return;
		}
	}
}

function federatedtriggersedit_saveFederatedTriggers() {
	
	var newId = new Object();
	
	if (localFederatedTriggersEdit_action == "new") {
		
		var tmpTriggerCd = jQuery("#id_federatedtriggersedit_triggercd").val();
		if (tmpTriggerCd == null || tmpTriggerCd == "none") {
			alert("you must select one in Trigger code field");
			return;
		}
		
		var tmpSrcTriggerCd = jQuery("#id_federatedtriggersedit_srctriggercd").val();
		if (tmpSrcTriggerCd == null || tmpSrcTriggerCd == "none") {
			alert("you must select one in Source trigger code field");
			return;
		}
		
		if (tmpTriggerCd == tmpSrcTriggerCd) {
			alert("Trigger code can not be the same with Source trigger code");
			return;
		}
		
		newId.triggerCd = tmpTriggerCd;
		newId.srcTriggerCd = tmpSrcTriggerCd;
	} else if (localFederatedTriggersEdit_action == "update") {
		newId.triggerCd = localFederatedTriggersEdit_triggerCd;
		newId.srcTriggerCd = localFederatedTriggersEdit_srcTriggerCd;
	}
	
	var tmpRelation = jQuery("#id_federatedtriggersedit_relation").val();
	if (tmpRelation == null || tmpRelation == "none") {
		alert("you must select one in Relation field");
		return;
	}
	
	var tmpAiTimeFactor = jQuery("#id_federatedtriggersedit_aitimefactor").val();
	if (tmpAiTimeFactor == null) {
		alert("Please enter a numeric value (0-168) for AI time factor field");
		return;
	} else {
		tmpAiTimeFactor = tmpAiTimeFactor.trim();
		if (tmpAiTimeFactor.length == 0 || isNaN(tmpAiTimeFactor) || (tmpAiTimeFactor < 0) || tmpAiTimeFactor > 168) {
			alert("Please enter a numeric value (0-168) for AI time factor field");
			return;
		}
	}
	
	var newObject = new Object();
	newObject.id = newId;
	newObject.relation = tmpRelation;
	newObject.aiTimeFactor = tmpAiTimeFactor;
	
	if (localFederatedTriggersEdit_action == "new") {
		submitEditFederatedTrigger(newObject);
	} else if (localFederatedTriggersEdit_action == "update") {
		if (localFederatedTriggersEdit_relation == newObject.relation) {
			submitEditFederatedTrigger(newObject);
		} else {
			localFederatedTriggersEdit_newObject = newObject;
			IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_federatedtriggersedit_page_overlay").getId(), true);
			IBMCore.common.widget.overlay.show("id_confirmation_federatedtriggers_edit");
			jQuery("#id_confirmation_federatedtriggers_edit_text0").text(newObject.relation);
			jQuery("#id_confirmation_federatedtriggers_edit_text1").text(newId.triggerCd + "&&" + newId.srcTriggerCd);
			jQuery("#id_confirmation_federatedtriggers_edit_text2").text(newId.triggerCd);
			jQuery("#id_confirmation_federatedtriggers_edit_text3").text(newObject.relation);
		}
	}
}

function editFederatedTriggersOk() {
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_federatedtriggers_edit").getId(), true);
	IBMCore.common.widget.overlay.show("id_federatedtriggersedit_page_overlay");
	submitEditFederatedTrigger(localFederatedTriggersEdit_newObject);
}

function editFederatedTriggersCancel() {

	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_federatedtriggers_edit").getId(), true);
	IBMCore.common.widget.overlay.show("id_federatedtriggersedit_page_overlay");
}

function submitEditFederatedTrigger(newObject) {
	
	//alert(JSON.stringify(newObject));
	
	jQuery("#id_federatedtriggersedit_save_button").attr("disabled", "true");
	if (localFederatedTriggersEdit_action == "new") {
		jQuery("#id_federatedtriggersedit_triggercd").attr("disabled", "true");
		jQuery("#id_federatedtriggersedit_srctriggercd").attr("disabled", "true");
	}
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath+"/action/admin/trigger/updateFederatedTriggers/"+localFederatedTriggersEdit_action+"?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(newObject),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		
		var flag = data.flag;
		var text = data.text;
		
		if (localFederatedTriggersEdit_action == "new") {
			if (flag == "1") {
				localFederatedTriggersEdit_action = "update";
				localFederatedTriggersEdit_triggerCd = newObject.id.triggerCd;
				localFederatedTriggersEdit_srcTriggerCd = newObject.id.srcTriggerCd;
				localFederatedTriggersEdit_relation = newObject.relation;
				localFederatedTriggersEdit_saveSuccess = "Y";
			} else if (flag == "0") {
				jQuery("#id_federatedtriggersedit_triggercd").removeAttr("disabled");
				jQuery("#id_federatedtriggersedit_srctriggercd").removeAttr("disabled");
			}
			alert(text);
		} else if (localFederatedTriggersEdit_action == "update") {
			if (flag == "1") {
				localFederatedTriggersEdit_saveSuccess = "Y";
			}
			alert(text);
		}
		
		jQuery("#id_federatedtriggersedit_save_button").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_federatedtriggersedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function federatedtriggersedit_closeOverlay(myOverId) {

	if(localFederatedTriggersEdit_saveSuccess == "Y") {
		saveFederatedTriggersListTableSearchText();
	}
	
	closeOverlay(myOverId);
	IBMCore.common.widget.overlay.show("id_federatedtriggerslist_page_overlay");
	
	if(localFederatedTriggersEdit_saveSuccess == "Y") {
		jQuery("#id_federatedtriggerslist_page_overlay").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
		initFederatedTriggersListPage("edit");
		localFederatedTriggersEdit_saveSuccess = "N";
	}
}


function deleteFederatedTrigger() {
	
	var selectedFederatedTrigger = jQuery("input[name='name_federatedtriggerslist_table_radio']:checked");
	
	if (selectedFederatedTrigger.length == 1) {
		var selectOne = jQuery(selectedFederatedTrigger.get(0));
		localFederatedTriggersList_delectedTriggerCd = selectOne.attr("myTriggerCd");
		localFederatedTriggersList_delectedSrcTriggerCd = selectOne.attr("mySrcTriggerCd");
		//alert(localFederatedTriggersList_delectedTriggerCd + " " + localFederatedTriggersList_delectedSrcTriggerCd);
		
		IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_federatedtriggerslist_page_overlay").getId(), true);
		IBMCore.common.widget.overlay.show("id_confirmation_deleteselectedfederatedtriggers");
		jQuery("#id_confirmation_selectedfederatedtriggers").text(localFederatedTriggersList_delectedTriggerCd + "&&" + localFederatedTriggersList_delectedSrcTriggerCd);
	} else {
		alert("please select one federated trigger to delete.");
		return;
	}
}

function deleteSelectedFederatedTriggersOk() {
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedfederatedtriggers").getId(), true);
	IBMCore.common.widget.overlay.show("id_federatedtriggerslist_page_overlay");
	jQuery("#id_federatedtriggerslist_delete_button").attr("disabled", "true");
	
	var id = new Object();
	id.triggerCd = localFederatedTriggersList_delectedTriggerCd;
	id.srcTriggerCd = localFederatedTriggersList_delectedSrcTriggerCd;
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/admin/trigger/deleteFederatedTrigger?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(id),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var federatedTriggersList = data.federatedTriggersList;
		var text = data.text;
		alert(text);
		jQuery("#id_federatedtriggerslist_delete_button").removeAttr("disabled");
		initFederatedTriggersListDiv(federatedTriggersList, "delete");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_federatedtriggerslist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedFederatedTriggersCancel() {
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedfederatedtriggers").getId(), true);
	IBMCore.common.widget.overlay.show("id_federatedtriggerslist_page_overlay");
}
	</script>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>