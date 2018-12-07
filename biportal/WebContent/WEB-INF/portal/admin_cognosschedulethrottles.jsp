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
<title>BI@IBM | Manage Cognos schedule throttles</title>
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
					<h1 class="ibm-h1 ibm-light">Manage Cognos schedule throttles</h1>
				</div>
			</div>
				<form id='id_throttlelistform' class="ibm-column-form" method="post">
					<div id="id_throttlelistbuttondiv"></div>
					<div id="id_throttlelistsearchdiv"></div>
					<div id="id_throttlelistdatadiv"></div>
				</form>
			<div>
			</div>
		</div>
	</div>
	<div id="id_confirmation_deleteselectedthrottle" class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center">Cognos schedule throttle <span class="ibm-h3 ibm-center" id="id_confirmation_selectedThrottle"></span> is selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected Cognos schedule throttle should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedThrottleOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedThrottleCancel();">Cancel</button>  	
 		</p>
 	</div>
	<div id="id_throttleedit_page_overlay_main"></div>
	<div id="id_updatemaxthrottle_page_overlay_main"></div>
	<br />
	<script type="text/javascript">
var localContextPath = "<%=request.getContextPath()%>";
var localCwaid = "${cwa_id}";
var localUid = "${uid}";
var localThrottleList_selectedCognosCd;
var localThrottleList_selectedTriggerCd;
var localThrottleList_searchText;

jQuery(document).ready(function() {
	
	var myThrottleListTableSorting = Cookies.get("myThrottleListTableColSort");
    if (myThrottleListTableSorting === undefined) { 
        myThrottleListTableSorting = '[[3, "asc"]]';
        Cookies.set("myThrottleListTableColSort", myThrottleListTableSorting, {expires: 999});
        console.log("myThrottleListTableColSort initializing column sorting in cookie " + myThrottleListTableSorting);
    } 
    
	initThrottleList("init");
})

function initThrottleList(action) {
	
	var searchValueForCognosDomain = null;
	var searchValueForTrigger = null;
	var searchValueForCurrentThrottle = null;
	var searchValueForMaxThrottle = null;
	
	if (action == "init") {
		jQuery("#id_throttlelistbuttondiv").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
	} else if (action == "refresh") {
		saveThrottleListTableSearchText();
		jQuery("#id_throttlelistsearchdiv").empty();
		jQuery("#id_throttlelistdatadiv").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
	} else if (action == "search") {
		saveThrottleListTableSearchText();
		searchValueForCognosDomain    = jQuery("#id_throttlelist_searchcognosdomain").val();
		searchValueForTrigger         = jQuery("#id_throttlelist_searchtrigger").val();
		searchValueForCurrentThrottle = jQuery("#id_throttlelist_searchcurrentthrottle").val();
		searchValueForMaxThrottle     = jQuery("#id_throttlelist_searchmaxthrottle").val();
		jQuery("#id_throttlelistdatadiv").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
	}
	
	if (action == "init") {
		jQuery.get(
			localContextPath+"/action/admin/throttle/getCognosScheduleThrottlesInit/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var throttleList = data.throttleList;
			var cognosDomaimList = data.cognosDomaimList;
			var triggerList = data.triggerList;
			var buttonAccessList = data.buttonAccessList;
			initThrottleListButtonDiv(buttonAccessList);
			initThrottleListSearchDiv(cognosDomaimList, triggerList);
			initThrottleListDataDiv(throttleList, action, searchValueForCognosDomain, searchValueForTrigger, searchValueForCurrentThrottle, searchValueForMaxThrottle);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_throttlelistdatadiv").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else if (action == "search") {
		jQuery.get(
			localContextPath+"/action/admin/throttle/getCognosScheduleThrottlesList/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var throttleList = data;
			initThrottleListDataDiv(throttleList, action, searchValueForCognosDomain, searchValueForTrigger, searchValueForCurrentThrottle, searchValueForMaxThrottle);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_throttlelistdatadiv").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		jQuery.get(
			localContextPath+"/action/admin/throttle/getCognosScheduleThrottlesAll/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var throttleList = data.throttleList;
			if (action == "refresh") {
				var cognosDomaimList = data.cognosDomaimList;
				var triggerList = data.triggerList;
				initThrottleListSearchDiv(cognosDomaimList, triggerList);
			}
			initThrottleListDataDiv(throttleList, action, searchValueForCognosDomain, searchValueForTrigger, searchValueForCurrentThrottle, searchValueForMaxThrottle);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_throttlelistdatadiv").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	}
}

function initThrottleListButtonDiv(buttonAccessList) {
	
	var accessFlagList = checkPanelButtonAccessFlag(buttonAccessList);
	var accessFlag1 = accessFlagList[0];
	var accessFlag2 = accessFlagList[1];
	var accessFlag3 = accessFlagList[2];
	var accessFlag4 = accessFlagList[3];
	
	var buttonStr = "<table style='width: 100%;'>";
	buttonStr += "<tr>";
	buttonStr += "<td>";
	buttonStr += "<input type='button' id='id_throttlelist_refresh_button'           onclick='initThrottleList(\"refresh\")' value='Refresh'             class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	if (accessFlag1 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_throttlelist_add_button'               onclick='editThrottle(\"new\")'      value='Add throttle'        class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	if (accessFlag2 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_throttlelist_update_button'            onclick='editThrottle(\"update\")'   value='Edit throttle'       class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	if (accessFlag1 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_throttlelist_delete_button'            onclick='deleteThrottle()'         value='Delete throttle'     class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	if (accessFlag3 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_throttlelist_updatemaxthrottle_button' onclick='updateMaxThrottle()'      value='Update max throttle' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	buttonStr += "</td>";
	buttonStr += "</tr>";
	buttonStr += "</table>";
	
	jQuery("#id_throttlelistbuttondiv").empty().append(buttonStr);
}

function initThrottleListSearchDiv(cognosDomaimList, triggerList) {

	var searchStr = "<table style='width: 100%;'>";
	searchStr += "<tr>";
	searchStr += "<td>";
	searchStr += "<select id='id_throttlelist_searchcognosdomain' class='ibm-styled' title='searchcognosdomain' style='width: 300px;'></select>";
	searchStr += "&nbsp;<select id='id_throttlelist_searchtrigger' class='ibm-styled' title='searchtrigger' style='width: 300px;'></select>";
	searchStr += "&nbsp;<select id='id_throttlelist_searchcurrentthrottle' class='ibm-styled' title='searchcurrentthrottle' style='width: 120px;'></select>";
	searchStr += "&nbsp;<select id='id_throttlelist_searchmaxthrottle' class='ibm-styled' title='searchmaxthrottle' style='width: 120px;'></select>";
	searchStr += "&nbsp;<input type='button' id='id_throttlelist_search_button' onclick='initThrottleList(\"search\")' value='Go' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	searchStr += "</td>";
	searchStr += "</tr>";
	searchStr += "</table>";
	jQuery("#id_throttlelistsearchdiv").empty().append(searchStr);
	
	var cognosDomainOptionStr = "<option value='none'>Cognos domains:</option>";
	for (var i = 0; i < cognosDomaimList.length; i++) {
		var currDomain = cognosDomaimList[i];
		cognosDomainOptionStr += "<option value='" + currDomain.domainKey + "'>" + currDomain.domainKey + " --> " + currDomain.displayName + "</option>";
	}
	jQuery("#id_throttlelist_searchcognosdomain").empty().append(cognosDomainOptionStr);
	IBMCore.common.widget.selectlist.init("#id_throttlelist_searchcognosdomain");
	
	var triggerOptionStr = "<option value='none'>Triggers:</option>";
	for (var i = 0; i < triggerList.length; i++) {
		var currTrigger = triggerList[i];
		triggerOptionStr += "<option value='" + currTrigger.triggerCd + "'>" + currTrigger.triggerCd + " --> " + currTrigger.triggerDesc + "</option>";
	}
	jQuery("#id_throttlelist_searchtrigger").empty().append(triggerOptionStr);
	IBMCore.common.widget.selectlist.init("#id_throttlelist_searchtrigger");
	
	var currentThrottleOptionStr = "<option value='none'>Current throttle:</option>";
	currentThrottleOptionStr += "<option value='0'>Current==0</option>";
	currentThrottleOptionStr += "<option value='1'>Current<>0</option>";
	jQuery("#id_throttlelist_searchcurrentthrottle").empty().append(currentThrottleOptionStr);
	IBMCore.common.widget.selectlist.init("#id_throttlelist_searchcurrentthrottle");
	
	var maxThrottleOptionStr = "<option value='none'>Max throttle:</option>";
	maxThrottleOptionStr += "<option value='0'>Max==0</option>";
	maxThrottleOptionStr += "<option value='1'>Max<>0</option>";
	jQuery("#id_throttlelist_searchmaxthrottle").empty().append(maxThrottleOptionStr);
	IBMCore.common.widget.selectlist.init("#id_throttlelist_searchmaxthrottle");
}

function initThrottleListDataDiv(throttleList, action, searchValueForCognosDomain, searchValueForTrigger, searchValueForCurrentThrottle, searchValueForMaxThrottle) {

	if (action == "delete") {
		saveThrottleListTableSearchText();
	}

	if (throttleList == null || throttleList.length == 0) {
		jQuery("#id_throttlelistdatadiv").empty().append("Error, there is not any Cognos schedule throttle.");
	} else {
		var tableStr = "<div>";
		tableStr += "<table id='id_throttlelist_table' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='true'>";
		tableStr += "<thead><tr>";
		tableStr += "<th scope='col'><span class='ibm-checkbox-wrapper'><input id='id_throttlelist_table_selectall' type='checkbox' class='ibm-styled-checkbox'/><label for='id_throttlelist_table_selectall'><span class='ibm-access'>Select all</span></label></span></th>";
		tableStr += "<th scope='col'>Cognos domain key</th>";
		tableStr += "<th scope='col'>Cognos domain name</th>";
		tableStr += "<th scope='col'>Trigger code</th>";
		tableStr += "<th scope='col'>Trigger description</th>";
		tableStr += "<th scope='col'>Current throttle</th>";
		tableStr += "<th scope='col'>Max throttle</th>";
		tableStr += "<th scope='col'>Datamart code</th>";
		tableStr += "<th scope='col'>Off-peak threshold</th>";
		tableStr += "<th scope='col'>Initial run</th>";
		tableStr += "<th scope='col'>Long run domain</th>";
		tableStr += "<th scope='col'>Short run domain</th>";
		tableStr += "<th scope='col'>Runtime threshold</th>";
		tableStr += "<th scope='col'>Job running id</th>";
		tableStr += "</tr></thead>";
		tableStr += "<tbody>";
		
		var throttleListLength = throttleList.length;
		var showThrottleCount = 0;
			
		for (var i = 0; i < throttleListLength; i++) {
			
			var throttle = throttleList[i];
			
			var showThisThrottle = false;
			
			if (action == "search") {
				var showItForCognosDomain = false;
				if (searchValueForCognosDomain == null || searchValueForCognosDomain == "none") {
					showItForCognosDomain = true;
				} else {
					if (searchValueForCognosDomain == throttle.id.cognosCd) {
						showItForCognosDomain = true;
					}
				}
				
				var showItForTrigger = false;
				if (searchValueForTrigger == null || searchValueForTrigger == "none") {
					showItForTrigger = true;
				} else {
					if (searchValueForTrigger == throttle.id.triggerCd) {
						showItForTrigger = true;
					}
				}
				
				var showItForCurrentThrottle = false;
				if (searchValueForCurrentThrottle == null || searchValueForCurrentThrottle == "none") {
					showItForCurrentThrottle = true;
				} else {
					if (searchValueForCurrentThrottle == "0") {
						if (throttle.currentThrottle == 0) {
							showItForCurrentThrottle = true;
						}
					} else {
						if (throttle.currentThrottle > 0) {
							showItForCurrentThrottle = true;
						}
					}
				}
				
				var showItForMaxThrottle = false;
				if (searchValueForMaxThrottle == null || searchValueForMaxThrottle == "none") {
					showItForMaxThrottle = true;
				} else {
					if (searchValueForMaxThrottle == "0") {
						if (throttle.maxThrottle == 0) {
							showItForMaxThrottle = true;
						}
					} else {
						if (throttle.maxThrottle > 0) {
							showItForMaxThrottle = true;
						}
					}
				}
				
				showThisThrottle = showItForCognosDomain && showItForTrigger && showItForCurrentThrottle && showItForMaxThrottle;
			} else {
				showThisThrottle = true;
			}
			
			if (showThisThrottle) {
				
				showThrottleCount += 1;
				
				tableStr += "<tr>";
				tableStr += "<td scope='row'><span class='ibm-checkbox-wrapper'><input id='id_throttlelist_tr_" + throttle.id.cognosCd + "__biibmsplit__" + throttle.id.triggerCd + "' name='name_throttlelist_table_checkbox' value='" + throttle.id.cognosCd + "__biibmsplit__" + throttle.id.triggerCd + "' myCognosCd='" + throttle.id.cognosCd + "' myTriggerCd='" + throttle.id.triggerCd + "' type='checkbox' class='ibm-styled-checkbox'></input><label for='id_throttlelist_tr_" + throttle.id.cognosCd + "__biibmsplit__" + throttle.id.triggerCd + "'><span class='ibm-access'>Select one</span></label></span></td>";
				tableStr += "<td>" + throttle.id.cognosCd + "</td>";
				if (throttle.displayName == null) {
					tableStr += "<td>N/A</td>";
				} else {
					tableStr += "<td>" + throttle.displayName + "</td>";
				}
				tableStr += "<td>" + throttle.id.triggerCd + "</td>";
				if (throttle.triggerDesc == null) {
					tableStr += "<td>N/A</td>";
				} else {
					tableStr += "<td>" + throttle.triggerDesc + "</td>";
				}
				tableStr += "<td>" + throttle.currentThrottle + "</td>";
				tableStr += "<td>" + throttle.maxThrottle + "</td>";
				tableStr += "<td>" + throttle.datamartCd + "</td>";
				tableStr += "<td>" + throttle.offpeakThreshold + "</td>";
				tableStr += "<td>" + throttle.initialRun + "</td>";
				if (throttle.lrDomainKey == null) {
					tableStr += "<td></td>";
				} else {
					tableStr += "<td>" + throttle.lrDomainKey + "</td>";
				}
				if (throttle.srDomainKey == null) {
					tableStr += "<td></td>";
				} else {
					tableStr += "<td>" + throttle.srDomainKey + "</td>";
				}
				tableStr += "<td>" + throttle.rtThreshold + "</td>";
				if (throttle.jobRunningId == null) {
					tableStr += "<td></td>";
				} else {
					tableStr += "<td>" + throttle.jobRunningId + "</td>";
				}
				tableStr += "</tr>";
			}
		}
		
		tableStr += "</tbody>";
		tableStr += "</table>";
		tableStr += "</div>";
		
		if (showThrottleCount == 0) {
			jQuery("#id_throttlelistdatadiv").empty().append("There is not any Cognos schedule throttle based on current filters.");
		} else {
			jQuery("#id_throttlelistdatadiv").empty().append(tableStr);
			//jQuery("#id_throttlelist_table").DataTable({paging:false, searching:true, info:true, order:[[2, "asc"]], columnDefs: [{targets: [0], orderable: false}]});
			
			var myThrottleListTableSetting = {info: true, paging: false, searching: true};
			myThrottleListTableSetting.order = eval(Cookies.get("myThrottleListTableColSort"));
			myThrottleListTableSetting.columnDefs = [JSON.parse('{"targets": [0], "orderable": false}')];
			var table = jQuery("#id_throttlelist_table").DataTable(myThrottleListTableSetting);
			jQuery("#id_throttlelist_table").tablesrowselector();
			jQuery("#id_throttlelist_table").on("order.dt", function () {
				var order = JSON.stringify(table.order());
				Cookies.set("myThrottleListTableColSort", order, {expires: 999});
	        });
			if (localThrottleList_searchText != "") {
				jQuery("#id_throttlelist_table_filter").find("input[type='search']").val(localThrottleList_searchText).keyup();
			}
		}
	}
}

function saveThrottleListTableSearchText() {
	localThrottleList_searchText = "";
	var currTable = jQuery("#id_throttlelist_table");
	if (currTable.length > 0) {
		localThrottleList_searchText = jQuery("#id_throttlelist_table_filter").find("input[type='search']").val();
	}
}

///////////////////////////////////////////////////////////////////////
var localThrottleEdit_cognosCd;
var localThrottleEdit_triggerCd;
var localThrottleEdit_action;

function initThrottleEditDiv(action) {
	
	var overlayStr = "<form id='id_throttleeditform' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='id_throttleEditDiv'>";
	overlayStr += "<table>";
	if (action == "new") {
		overlayStr += "<tr><td>Cognos domain:<span class='ibm-required'>*</span></td><td><select id='id_throttleedit_cognosdomainkey' class='ibm-styled' title='cognosdomainkey' style='width: 300px;'></select></td></tr>";
		overlayStr += "<tr><td>Trigger:<span class='ibm-required'>*</span></td><td><select id='id_throttleedit_triggercd' class='ibm-styled' title='triggercd' style='width: 300px;'></select></td></tr>";
	} else if (action == "update") {
		overlayStr += "<tr><td>Cognos domain:<span class='ibm-required'>*</span></td><td><input type='text' id='id_throttleedit_cognosdomainkey' name='throttleedit_cognosdomainkey' size='50' readonly disabled></input></td></tr>";
		overlayStr += "<tr><td>Trigger:<span class='ibm-required'>*</span></td><td><input type='text' id='id_throttleedit_triggercd' name='throttleedit_triggercd' size='50' readonly disabled></td></tr>";
	}
	//overlayStr += "<tr><td>Current throttle:</td><td><input type='text' id='id_throttleedit_currentthrottle' name='throttleedit_currentthrottle' size='10'></input></td></tr>";
	overlayStr += "<tr><td>Max throttle:<span class='ibm-required'>*</span></td><td><input type='text' id='id_throttleedit_maxthrottle' name='throttleedit_maxthrottle' size='20' maxlength='8'></input></td></tr>";
	overlayStr += "<tr><td>Datamart code:</td><td><input type='text' id='id_throttleedit_datamartcd' name='throttleedit_datamartcd' size='40' maxlength='20'></input></td></tr>";
	overlayStr += "<tr><td>Off-peak&nbsp;threshold:<span class='ibm-required'>*</span></td><td><input type='text' id='id_throttleedit_offpeakthreshold' name='throttleedit_offpeakthreshold' size='20' maxlength='8'></input></td></tr>";
	//overlayStr += "<tr><td>Initial run:</td><td><select id='id_throttleedit_initialrun' class='ibm-styled' title='initialrun' style='width: 50px;'></select></td></tr>";
	overlayStr += "<tr><td>Long run domain:</td><td><select id='id_throttleedit_longrundomainkey' class='ibm-styled' title='longrundomainkey' style='width: 300px;'></select></td></tr>";
	overlayStr += "<tr><td>Short run domain:</td><td><select id='id_throttleedit_shortrundomainkey' class='ibm-styled' title='shortrundomainkey' style='width: 300px;'></select></td></tr>";
	overlayStr += "<tr><td>Runtime threshold:<span class='ibm-required'>*</span></td><td><input type='text' id='id_throttleedit_runtimethreshold' name='throttleedit_runtimethreshold' size='20' maxlength='8'></input></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_throttleedit_save_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='throttleedit_save()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_throttleedit_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_throttleedit_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";

	jQuery("#id_throttleedit_page_overlay").empty().append(overlayStr);
}

function throttleedit_save() {

	if (localThrottleEdit_action == "new" || localThrottleEdit_action == "update") {
	
		var tmpCognosDomainKey;
		var tmpTriggerCd;
		if (localThrottleEdit_action == "new") {
			tmpCognosDomainKey = jQuery("#id_throttleedit_cognosdomainkey").val();
			if (tmpCognosDomainKey == null || tmpCognosDomainKey == "none") {
				alert("you must select one in Cognos domain field");
				return;
			}
			
			tmpTriggerCd = jQuery("#id_throttleedit_triggercd").val();
			if (tmpTriggerCd == null || tmpTriggerCd == "none") {
				alert("you must select one in Trigger field");
				return;
			}
		} else {
			tmpCognosDomainKey = localThrottleEdit_cognosCd;
			tmpTriggerCd = localThrottleEdit_triggerCd;
		}
		
		var tmpMaxThrottle = jQuery("#id_throttleedit_maxthrottle").val();
		if (tmpMaxThrottle == null || tmpMaxThrottle.length == 0 || isNaN(tmpMaxThrottle) || tmpMaxThrottle <= 0 || !(/(^[1-9]\d*$)/.test(tmpMaxThrottle))) {
			alert("Please enter a positive integer(starts from 1) in Max throttle field");
			return;
		}
		
		var tmpDatamartCd = jQuery("#id_throttleedit_datamartcd").val();
		if (tmpDatamartCd == null || tmpDatamartCd == "") {
			tmpDatamartCd = "NONE";
		}
		
		var tmpOffpeakThreshold = jQuery("#id_throttleedit_offpeakthreshold").val();
		if (tmpOffpeakThreshold == null || tmpOffpeakThreshold.length == 0 || isNaN(tmpOffpeakThreshold) || tmpOffpeakThreshold <= 0 || !(/(^[1-9]\d*$)/.test(tmpOffpeakThreshold))) {
			alert("Please enter a positive integer(starts from 1) in Off-peak threshold");
			return;
		}

		//var tmpInitialRun = jQuery("#id_throttleedit_initialrun").val();
		
		var tmpLrDomainKey = jQuery("#id_throttleedit_longrundomainkey").val();
		if (tmpLrDomainKey == null || tmpLrDomainKey == "none") {
			tmpLrDomainKey = "";
		}
		
		var tmpSrDomainKey = jQuery("#id_throttleedit_shortrundomainkey").val();
		if (tmpSrDomainKey == null || tmpSrDomainKey == "none") {
			tmpSrDomainKey = "";
		}
		
		var tmpRuntimeThreshold = jQuery("#id_throttleedit_runtimethreshold").val();
		if (tmpRuntimeThreshold == null || tmpRuntimeThreshold.length == 0 || isNaN(tmpRuntimeThreshold) || tmpRuntimeThreshold <= 0 || !(/(^[1-9]\d*$)/.test(tmpRuntimeThreshold))) {
			alert("Please enter a positive integer(starts from 1) in Runtime threshold field");
			return;
		}
		
		var id = new Object();
		id.cognosCd = tmpCognosDomainKey;
		id.triggerCd = tmpTriggerCd;
		
		var obj = new Object();
		obj.id = id;
		obj.maxThrottle = tmpMaxThrottle;
		obj.datamartCd = tmpDatamartCd;
		obj.offpeakThreshold = tmpOffpeakThreshold;
		//obj.initialRun = tmpInitialRun;
		obj.lrDomainKey = tmpLrDomainKey;
		obj.srDomainKey = tmpSrDomainKey;
		obj.rtThreshold = tmpRuntimeThreshold;
		
		//alert(JSON.stringify(obj));
		
		if (localThrottleEdit_action == "new") {
			jQuery("#id_throttleedit_cognosdomainkey").attr("disabled", "true");
			jQuery("#id_throttleedit_triggercd").attr("disabled", "true");
		}
		jQuery("#id_throttleedit_save_button").attr("disabled", "true");
		
		jQuery.ajax({
			type : "POST",
			url : localContextPath+"/action/admin/throttle/updateCognosScheduleThrottle/"+localThrottleEdit_action+"?timeid="+(new Date()).valueOf(),
			data : JSON.stringify(obj),
			contentType : "application/json",
			dataType : "json",
		})
		.done(function(data) {
		
			var flag = data.flag;
			var text = data.text;
			alert(text);
			
			if (localThrottleEdit_action == "new") {
				if (flag == "1") {
					localThrottleEdit_action = "update";
					localThrottleEdit_cognosCd = tmpCognosDomainKey;
					localThrottleEdit_triggerCd = tmpTriggerCd;
				} else {
					jQuery("#id_throttleedit_cognosdomainkey").removeAttr("disabled");
					jQuery("#id_throttleedit_triggercd").removeAttr("disabled");
				}
			}
			
			jQuery("#id_throttleedit_save_button").removeAttr("disabled");
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_throttleedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		alert("Error, it's an unknown action.");
	}
}

function editThrottle(action) {
	
	localThrottleEdit_action = action;
	
	if (localThrottleEdit_action == "new") {
		
		localThrottleEdit_cognosCd = "";
		localThrottleEdit_triggerCd = "";
		initThrottleEditPageOverlay();
		
		jQuery.get(
			localContextPath+"/action/admin/throttle/getCognosScheduleThrottleNew/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var cognosDomaimList = data.cognosDomaimList;
			var triggerList = data.triggerList;

			initThrottleEditDiv(localThrottleEdit_action);
			
			var cognosDomaimListLength = cognosDomaimList.length;
			var cognosDomainOptionStr = "<option value='none'>Please select one</option>";
			var longRunDomainOptionStr = "<option value='none'>Please select one</option>";
			var shortRunDomainOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < cognosDomaimListLength; i++) {
				var currDomain = cognosDomaimList[i];
				cognosDomainOptionStr += "<option value='" + currDomain.domainKey + "'>" + currDomain.domainKey + " --> " + currDomain.displayName + "</option>";
				longRunDomainOptionStr += "<option value='" + currDomain.domainKey + "'>" + currDomain.domainKey + " --> " + currDomain.displayName + "</option>";
				shortRunDomainOptionStr += "<option value='" + currDomain.domainKey + "'>" + currDomain.domainKey + " --> " + currDomain.displayName + "</option>";
			}
			jQuery("#id_throttleedit_cognosdomainkey").empty().append(cognosDomainOptionStr);
			IBMCore.common.widget.selectlist.init("#id_throttleedit_cognosdomainkey");
			jQuery("#id_throttleedit_longrundomainkey").empty().append(longRunDomainOptionStr);
			IBMCore.common.widget.selectlist.init("#id_throttleedit_longrundomainkey");
			jQuery("#id_throttleedit_shortrundomainkey").empty().append(shortRunDomainOptionStr);
			IBMCore.common.widget.selectlist.init("#id_throttleedit_shortrundomainkey");
			
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
			jQuery("#id_throttleedit_triggercd").empty().append(triggerOptionStr);
			IBMCore.common.widget.selectlist.init("#id_throttleedit_triggercd");
			
			/* var initRunOptionStr = "";
			initRunOptionStr += "<option value='Y'>Yes</option>";
			initRunOptionStr += "<option value='N' selected>No</option>";
			jQuery("#id_throttleedit_initialrun").empty().append(initRunOptionStr);
			IBMCore.common.widget.selectlist.init("#id_throttleedit_initialrun"); */
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_throttleedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else if (localThrottleEdit_action == "update") {
	
		var selectedThrottles = jQuery("input[name='name_throttlelist_table_checkbox']:checked");
	
		if (selectedThrottles.length == 1) {
		
			initThrottleEditPageOverlay();
			
			var selectOne = jQuery(selectedThrottles.get(0));
			
			localThrottleEdit_cognosCd = selectOne.attr("myCognosCd");
			localThrottleEdit_triggerCd = selectOne.attr("myTriggerCd");
			
			//alert(localThrottleEdit_cognosCd + "   " + localThrottleEdit_triggerCd);
			
			var obj = new Object();
			obj.cognosCd = localThrottleEdit_cognosCd;
			obj.triggerCd = localThrottleEdit_triggerCd;
			
			jQuery.ajax({
				type : "POST",
				url : localContextPath+"/action/admin/throttle/getCognosScheduleThrottleEdit?timeid="+(new Date()).valueOf(),
				data : JSON.stringify(obj),
				contentType : "application/json",
				dataType : "json",
			})
			.done(function(data) {
				var throttle = data.throttle;
				var throttleCognosCd = throttle.id.cognosCd;
				var throttleTriggerCd = throttle.id.triggerCd;
				var cognosDomaimList = data.cognosDomaimList;
				var triggerList = data.triggerList;
				
				initThrottleEditDiv(localThrottleEdit_action);
				
				var cognosDomainKeyExisted = false;
				var cognosDomainKeyExistedValue = "";
				var cognosDomaimListLength = cognosDomaimList.length;
				var longRunDomainOptionStr = "<option value='none'>Please select one</option>";
				var shortRunDomainOptionStr = "<option value='none'>Please select one</option>";
				for (var i = 0; i < cognosDomaimListLength; i++) {
					var currDomain = cognosDomaimList[i];
					if (!cognosDomainKeyExisted && currDomain.domainKey == throttleCognosCd) {
						cognosDomainKeyExisted = true;
						cognosDomainKeyExistedValue = currDomain.domainKey + " --> " + currDomain.displayName;
					}
					if (currDomain.domainKey == throttle.lrDomainKey) {
						longRunDomainOptionStr += "<option value='" + currDomain.domainKey + "' selected>" + currDomain.domainKey + " --> " + currDomain.displayName + "</option>";
					} else {
						longRunDomainOptionStr += "<option value='" + currDomain.domainKey + "'>" + currDomain.domainKey + " --> " + currDomain.displayName + "</option>";
					}
					if (currDomain.domainKey == throttle.srDomainKey) {
						shortRunDomainOptionStr += "<option value='" + currDomain.domainKey + "' selected>" + currDomain.domainKey + " --> " + currDomain.displayName + "</option>";
					} else {
						shortRunDomainOptionStr += "<option value='" + currDomain.domainKey + "'>" + currDomain.domainKey + " --> " + currDomain.displayName + "</option>";
					}
				}
				if (cognosDomainKeyExisted) {
					jQuery("#id_throttleedit_cognosdomainkey").val(cognosDomainKeyExistedValue);
				} else {
					jQuery("#id_throttleedit_cognosdomainkey").val(throttleCognosCd + " --> N/A");
				}
				jQuery("#id_throttleedit_longrundomainkey").empty().append(longRunDomainOptionStr);
				IBMCore.common.widget.selectlist.init("#id_throttleedit_longrundomainkey");
				jQuery("#id_throttleedit_shortrundomainkey").empty().append(shortRunDomainOptionStr);
				IBMCore.common.widget.selectlist.init("#id_throttleedit_shortrundomainkey");
				
				var triggerCdExisted = false;
				var triggerCdExistedValue = "";
				var triggerListLength = triggerList.length;
				for (var i = 0; i < triggerListLength; i++) {
					var currTrigger = triggerList[i];
					if (currTrigger.triggerCd == throttleTriggerCd) {
						triggerCdExisted = true;
						if (currTrigger.triggerDesc == null || currTrigger.triggerDesc == "") {
							triggerCdExistedValue = currTrigger.triggerCd;
						} else {
							triggerCdExistedValue = currTrigger.triggerCd + " --> " + currTrigger.triggerDesc;
						}
						break;
					}
				}
				if (triggerCdExisted) {
					jQuery("#id_throttleedit_triggercd").val(triggerCdExistedValue);
				} else {
					jQuery("#id_throttleedit_triggercd").val(throttleTriggerCd + " --> N/A");
				}
				
				//jQuery("#id_throttleedit_currentthrottle").val(throttle.currentThrottle);
				jQuery("#id_throttleedit_maxthrottle").val(throttle.maxThrottle);
				jQuery("#id_throttleedit_offpeakthreshold").val(throttle.offpeakThreshold);
				jQuery("#id_throttleedit_runtimethreshold").val(throttle.rtThreshold);
				jQuery("#id_throttleedit_datamartcd").val(throttle.datamartCd);
				
				/* var initRunOptionStr = "";
				if (throttle.initialRun == "Y") {
					initRunOptionStr += "<option value='Y' selected>Yes</option>";
					initRunOptionStr += "<option value='N'>No</option>";
				} else {
					initRunOptionStr += "<option value='Y'>Yes</option>";
					initRunOptionStr += "<option value='N' selected>No</option>";
				}
				jQuery("#id_throttleedit_initialrun").empty().append(initRunOptionStr);
				IBMCore.common.widget.selectlist.init("#id_throttleedit_initialrun"); */
			})
			.fail(function(jqXHR, textStatus, errorThrown) {
				jQuery("#id_throttleedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
				console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
				console.log(		"ajax error in loading...textStatus..."	+textStatus); 
				console.log(		"ajax error in loading...errorThrown..."+errorThrown);
			})
		} else {
			alert("please select one throttle to edit.");
			return;
		}
	}
}

function initThrottleEditPageOverlay() {
	
	var overlayStr = "<div id='id_throttleedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_throttleedit_page_overlay_main").append(overlayStr);
	jQuery("#id_throttleedit_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_throttleedit_page_overlay");
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

///////////////////////////////////////////////////////////////////////
var localUpdateMaxThrottle_cognosCd;
var localUpdateMaxThrottle_triggerCd;
var localUpdateMaxThrottle_idList;

function updatemaxthrottle_save() {
	
	var tmpMaxThrottle = jQuery("#id_updatemaxthrottle_maxthrottle").val();
	if (tmpMaxThrottle == null || tmpMaxThrottle.length == 0 || isNaN(tmpMaxThrottle) || tmpMaxThrottle <= 0 || !(/(^[1-9]\d*$)/.test(tmpMaxThrottle))) {
		alert("Please enter a positive integer(starts from 1) in Max throttle field");
		return;
	}
	
	//alert(JSON.stringify(localUpdateMaxThrottle_idList));
	
	var throttleList = new Array();
	for (var i = 0; i < localUpdateMaxThrottle_idList.length; i++) {
		var throttle = new Object();
		throttle.id = localUpdateMaxThrottle_idList[i];
		throttle.maxThrottle = tmpMaxThrottle;
		throttleList.push(throttle);
	}
	
	//alert(JSON.stringify(throttleList));
	
	jQuery("#id_updatemaxthrottle_save_button").attr("disabled", "true");
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath+"/action/admin/throttle/updateCognosScheduleThrottleMaxThrottle?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(throttleList),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var text = data.text;
		alert(text);
		jQuery("#id_updatemaxthrottle_save_button").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_updatemaxthrottle_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
	
	/* var id = new Object();
	id.cognosCd = localUpdateMaxThrottle_cognosCd;
	id.triggerCd = localUpdateMaxThrottle_triggerCd;
	
	var obj = new Object();
	obj.id = id;
	obj.maxThrottle = tmpMaxThrottle;
		
	//alert(JSON.stringify(obj));
	
	jQuery("#id_updatemaxthrottle_save_button").attr("disabled", "true");
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath+"/action/admin/throttle/updateCognosScheduleThrottle/maxthrottle?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
	
		var flag = data.flag;
		var text = data.text;
		alert(text);
		jQuery("#id_updatemaxthrottle_save_button").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_updatemaxthrottle_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	}) */
}

function initUpdateMaxThrottlePageOverlay() {
	
	var overlayStr = "<div id='id_updatemaxthrottle_page_overlay' class='ibm-common-overlay ibm-overlay-alt' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_updatemaxthrottle_page_overlay_main").append(overlayStr);
	jQuery("#id_updatemaxthrottle_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_updatemaxthrottle_page_overlay");
}

function initUpdateMaxThrottleDiv() {
	
	var overlayStr = "<form id='id_updatemaxthrottleform' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='id_updateMaxThrottleDiv'>";
	overlayStr += "<table>";
	overlayStr += "<tr><td style='vertical-align:top;'>Cognos&nbsp;domain&&Trigger:</td><td><select id='id_updatemaxthrottle_cognosdomainkeyandtriggercd' class='ibm-styled' title='cognosdomainandtrigger' style='width: 300px;' size='20' disabled readonly></select></td></tr>";
	/* overlayStr += "<tr><td>Cognos&nbsp;domain:<span class='ibm-required'>*</span></td><td><input type='text' id='id_updatemaxthrottle_cognosdomainkey' name='updatemaxthrottle_cognosdomainkey' size='50' readonly disabled></input></td></tr>";
	overlayStr += "<tr><td>Trigger:<span class='ibm-required'>*</span></td><td><input type='text' id='id_updatemaxthrottle_triggercd' name='updatemaxthrottle_triggercd' size='50' readonly disabled></td></tr>";
	 */
	overlayStr += "<tr><td>Max throttle:<span class='ibm-required'>*</span></td><td><input type='text' id='id_updatemaxthrottle_maxthrottle' name='updatemaxthrottle_maxthrottle' size='20' maxlength='8'></input></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_updatemaxthrottle_save_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='updatemaxthrottle_save()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_updatemaxthrottle_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_updatemaxthrottle_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";

	jQuery("#id_updatemaxthrottle_page_overlay").empty().append(overlayStr);
}

function updateMaxThrottle() {

	var selectedThrottles = jQuery("input[name='name_throttlelist_table_checkbox']:checked");
	
	if (selectedThrottles.length == 0) {
		alert("please select throttles to update max throttle.");
		return;
	} else {
		localUpdateMaxThrottle_idList = new Array();
		var idTexts = new Array();
		for (var i = 0; i < selectedThrottles.length; i++) {
			var selectOne = jQuery(selectedThrottles.get(i));
			var id = new Object();
			id.cognosCd = selectOne.attr("myCognosCd");;
			id.triggerCd = selectOne.attr("myTriggerCd");
			idTexts.push("[" + id.cognosCd + ", " + id.triggerCd + "]");
			localUpdateMaxThrottle_idList.push(id);
		}
		idTexts.sort();
		var domainAndTriggerStr = "<option value='" + idTexts.length + "'>--- Totally " + idTexts.length + " Cognos throttles are selected ---</option>";
		for (var i = 0; i < idTexts.length; i++) {
			var idText = idTexts[i];
			domainAndTriggerStr += "<option value='" + idText + "'>" + idText + "</option>";
		}
		initUpdateMaxThrottlePageOverlay();
		initUpdateMaxThrottleDiv();
		jQuery("#id_updatemaxthrottle_cognosdomainkeyandtriggercd").empty().append(domainAndTriggerStr);
	}
	
	/* if (selectedThrottles.length == 1) {
	
		initUpdateMaxThrottlePageOverlay();
		
		var selectOne = jQuery(selectedThrottles.get(0));
		
		localUpdateMaxThrottle_cognosCd = selectOne.attr("myCognosCd");
		localUpdateMaxThrottle_triggerCd = selectOne.attr("myTriggerCd");
		
		//alert(localUpdateMaxThrottle_cognosCd + "   " + localUpdateMaxThrottle_triggerCd);
		
		var obj = new Object();
		obj.cognosCd = localUpdateMaxThrottle_cognosCd;
		obj.triggerCd = localUpdateMaxThrottle_triggerCd;
		
		jQuery.ajax({
			type : "POST",
			url : localContextPath+"/action/admin/throttle/getCognosScheduleThrottleEdit?timeid="+(new Date()).valueOf(),
			data : JSON.stringify(obj),
			contentType : "application/json",
			dataType : "json",
		})
		.done(function(data) {
			var throttle = data.throttle;
			var throttleCognosCd = throttle.id.cognosCd;
			var throttleTriggerCd = throttle.id.triggerCd;
			var cognosDomaimList = data.cognosDomaimList;
			var triggerList = data.triggerList;
			
			initUpdateMaxThrottleDiv();
			
			var cognosDomainKeyExisted = false;
			var cognosDomainKeyExistedValue = "";
			var cognosDomaimListLength = cognosDomaimList.length;
			for (var i = 0; i < cognosDomaimListLength; i++) {
				var currDomain = cognosDomaimList[i];
				if (currDomain.domainKey == throttleCognosCd) {
					cognosDomainKeyExisted = true;
					cognosDomainKeyExistedValue = currDomain.domainKey + " --> " + currDomain.displayName;
					break;
				}
			}
			if (cognosDomainKeyExisted) {
				jQuery("#id_updatemaxthrottle_cognosdomainkey").val(cognosDomainKeyExistedValue);
			} else {
				jQuery("#id_updatemaxthrottle_cognosdomainkey").val(throttleCognosCd + " --> N/A");
			}
			
			var triggerCdExisted = false;
			var triggerCdExistedValue = "";
			var triggerListLength = triggerList.length;
			for (var i = 0; i < triggerListLength; i++) {
				var currTrigger = triggerList[i];
				if (currTrigger.triggerCd == throttleTriggerCd) {
					triggerCdExisted = true;
					if (currTrigger.triggerDesc == null || currTrigger.triggerDesc == "") {
						triggerCdExistedValue = currTrigger.triggerCd;
					} else {
						triggerCdExistedValue = currTrigger.triggerCd + " --> " + currTrigger.triggerDesc;
					}
					break;
				}
			}
			if (triggerCdExisted) {
				jQuery("#id_updatemaxthrottle_triggercd").val(triggerCdExistedValue);
			} else {
				jQuery("#id_updatemaxthrottle_triggercd").val(throttleTriggerCd + " --> N/A");
			}
			
			jQuery("#id_updatemaxthrottle_maxthrottle").val(throttle.maxThrottle);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_updatemaxthrottle_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		alert("please select one throttle to update max throttle.");
		return;
	} */
}

///////////////////////////////////////////////////////////////////////
var localThrottleDelete_cognosCd;
var localThrottleDelete_triggerCd;

function deleteThrottle() {
	
	var selectedThrottles = jQuery("input[name='name_throttlelist_table_checkbox']:checked");
	
	if (selectedThrottles.length == 1) {
		var selectOne = jQuery(selectedThrottles.get(0));
		localThrottleDelete_cognosCd = selectOne.attr("myCognosCd");
		localThrottleDelete_triggerCd = selectOne.attr("myTriggerCd");
		//alert(localThrottleDelete_cognosCd + "   " + localThrottleDelete_triggerCd);

		IBMCore.common.widget.overlay.show("id_confirmation_deleteselectedthrottle");
		jQuery("#id_confirmation_selectedThrottle").text("[" + localThrottleDelete_cognosCd + ", " + localThrottleDelete_triggerCd + "]");
	} else {
		alert("please select one Cognos schedule throttle to delete.");
		return;
	}
}

function deleteSelectedThrottleOk() {
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedthrottle").getId(), true);
	jQuery("#id_throttlelist_delete_button").attr("disabled", "true");
	
	var obj = new Object();
	obj.cognosCd = localThrottleDelete_cognosCd;
	obj.triggerCd = localThrottleDelete_triggerCd;
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/admin/throttle/deleteCognosScheduleThrottle?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var throttleList = data.throttleList;
		var text = data.text;
		alert(text);
		jQuery("#id_throttlelist_delete_button").removeAttr("disabled");
		initThrottleListDataDiv(throttleList, "delete", null, null, null, null);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_throttlelistdatadiv").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedThrottleCancel() {
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedthrottle").getId(), true);
}

	</script>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>