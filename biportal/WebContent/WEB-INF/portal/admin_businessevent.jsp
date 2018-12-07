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
<script type="text/javascript" src="<%=path%>/javascript/biadminmessage.js"></script>
<script type="text/javascript" src="<%=path%>/javascript/buttonaccess.js"></script>
<script type="text/javascript" src="<%=path%>/javascript/js.cookie-2.1.4.js"></script>
<title>BI@IBM | Manage business events</title>
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
					<h1 class="ibm-h1 ibm-light">Manage business events</h1>
				</div>
			</div>
				<form id='id_businesseventlistform' class="ibm-column-form" method="post">
					<div id="id_businesseventlistbuttondiv"></div>
					<div id="id_businesseventlistdatadiv"></div>
				</form>
			<div>
			</div>
		</div>
	</div>
	<div id="id_confirmation_deleteselectedbusinessevent" class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center">Business event Application&&EventCode: <span class="ibm-h3 ibm-center" id="id_confirmation_selectedbusinessevent"></span> is selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected business event should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedBusinessEventOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedBusinessEventCancel();">Cancel</button>  	
 		</p>
 	</div>
	<div id="id_businesseventedit_page_overlay_main"></div>
	<br />
	<script type="text/javascript">
var localContextPath = "<%=request.getContextPath()%>";
var localCwaid = "${cwa_id}";
var localUid = "${uid}";
var localBusinessEventList_searchText;

jQuery(document).ready(function() {
	
	var myBusinessEventListTableSorting = Cookies.get("myBusinessEventListTableColSort");
    if (myBusinessEventListTableSorting === undefined) { 
        myBusinessEventListTableSorting = '[[3, "asc"]]';
        Cookies.set("myBusinessEventListTableColSort", myBusinessEventListTableSorting, {expires: 999});
        console.log("myBusinessEventListTableColSort initializing column sorting in cookie " + myBusinessEventListTableSorting);
    } 
    
	initBusinessEventList("init");
})

function initBusinessEventList(action) {
	
	if (action == "init") {
		jQuery("#id_businesseventlistbuttondiv").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
	} else if (action == "refresh") {
		saveBusinessEventListTableSearchText();
		jQuery("#id_businesseventlistdatadiv").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
	}
	
	if (action == "init") {
		jQuery.get(
			localContextPath+"/action/admin/busievent/getBusinessEventInit/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var businessEventList = data.businessEventList;
			var buttonAccessList = data.buttonAccessList;
			initBusinessEventListButtonDiv(buttonAccessList);
			initBusinessEventListDataDiv(businessEventList, action);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_businesseventlistdatadiv").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		jQuery.get(
			localContextPath+"/action/admin/busievent/getBusinessEventAll/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var businessEventList = data;
			initBusinessEventListDataDiv(businessEventList, action);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_businesseventlistdatadiv").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	}
}

function initBusinessEventListButtonDiv(buttonAccessList) {
	
	var accessFlagList = checkPanelButtonAccessFlag(buttonAccessList);
	var accessFlag1 = accessFlagList[0];
	var accessFlag2 = accessFlagList[1];
	var accessFlag3 = accessFlagList[2];
	var accessFlag4 = accessFlagList[3];
	
	var buttonStr = "<table style='width: 100%;'>";
	buttonStr += "<tr>";
	buttonStr += "<td>";
	buttonStr += "<input type='button' id='id_businesseventlist_refresh_button'          onclick='initBusinessEventList(\"refresh\")' value='Refresh'                   class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	if (accessFlag1 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_businesseventlist_add_button'    onclick='editBusinessEvent(\"new\")'         value='Add business event'        class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	if (accessFlag2 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_businesseventlist_update_button' onclick='editBusinessEvent(\"update\")'      value='Edit business event'       class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	if (accessFlag1 == "1") {
		buttonStr += "&nbsp;<input type='button' id='id_businesseventlist_delete_button' onclick='deleteBusinessEvent()'              value='Delete business event'     class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'/>";
	}
	buttonStr += "</td>";
	buttonStr += "</tr>";
	buttonStr += "</table>";
	
	jQuery("#id_businesseventlistbuttondiv").empty().append(buttonStr);
}

function initBusinessEventListDataDiv(businessEventList, action) {

	if (action == "delete") {
		saveBusinessEventListTableSearchText();
	}

	if (businessEventList == null || businessEventList.length == 0) {
		jQuery("#id_businesseventlistdatadiv").empty().append("Error, there is not any business event.");
	} else {
		var tableStr = "<div>";
		tableStr += "<table id='id_businesseventlist_table' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='true'>";
		tableStr += "<thead><tr>";
		tableStr += "<th scope='col'></th>";
		tableStr += "<th scope='col'>Event code</th>";
		tableStr += "<th scope='col'>Event description</th>";
		tableStr += "<th scope='col'>Application code</th>";
		tableStr += "<th scope='col'>Application description</th>";
		tableStr += "<th scope='col'>Event status</th>";
		tableStr += "</tr></thead>";
		tableStr += "<tbody>";
		
		var businessEventListLength = businessEventList.length;
			
		for (var i = 0; i < businessEventListLength; i++) {
			
			var businessEvent = businessEventList[i];
			var businessEventApplCd = businessEvent.id.applCd;
			var businessEventEventCd = businessEvent.id.eventCd;
			
			tableStr += "<tr>";
			tableStr += "<td scope='row'><span class='ibm-radio-wrapper'><input id='id_businesseventlist_tr_" + businessEventApplCd + "__biibmsplit__" + businessEventEventCd + "' name='name_businesseventlist_table_radio' value='" + businessEventApplCd + "__biibmsplit__" + businessEventEventCd + "' myApplCd='" + businessEventApplCd + "' myEventCd='" + businessEventEventCd + "' type='radio' class='ibm-styled-radio'></input><label class='ibm-field-label' for='id_businesseventlist_tr_" + businessEventApplCd + "__biibmsplit__" + businessEventEventCd + "'></label></span></td>";
			tableStr += "<td>" + businessEventEventCd + "</td>";
			tableStr += "<td>" + businessEvent.eventDesc + "</td>";
			tableStr += "<td>" + businessEventApplCd + "</td>";
			tableStr += "<td>" + businessEvent.applDesc + "</td>";
			if (businessEvent.status == "A") {
				tableStr += "<td>Active</td>";
			} else {
				tableStr += "<td>Inactive</td>";
			}
			tableStr += "</tr>";
		}
		
		tableStr += "</tbody>";
		tableStr += "</table>";
		tableStr += "</div>";
		jQuery("#id_businesseventlistdatadiv").empty().append(tableStr);
		
		var myBusinessEventListTableSetting = {info: true, paging: false, searching: true};
		myBusinessEventListTableSetting.order = eval(Cookies.get("myBusinessEventListTableColSort"));
		myBusinessEventListTableSetting.columnDefs = [JSON.parse('{"targets": [0], "orderable": false}')];
		var table = jQuery("#id_businesseventlist_table").DataTable(myBusinessEventListTableSetting);
		jQuery("#id_businesseventlist_table").on("order.dt", function () {
			var order = JSON.stringify(table.order());
			Cookies.set("myBusinessEventListTableColSort", order, {expires: 999});
        });
		if (localBusinessEventList_searchText != "") {
			jQuery("#id_businesseventlist_table_filter").find("input[type='search']").val(localBusinessEventList_searchText).keyup();
		}
	}
}

function saveBusinessEventListTableSearchText() {
	localBusinessEventList_searchText = "";
	var currTable = jQuery("#id_businesseventlist_table");
	if (currTable.length > 0) {
		localBusinessEventList_searchText = jQuery("#id_businesseventlist_table_filter").find("input[type='search']").val();
	}
}

///////////////////////////////////////////////////////////////////////
var localBusinessEventEdit_applCd;
var localBusinessEventEdit_eventCd;
var localBusinessEventEdit_action;
var localBusinessEventEdit_eventdates;

function initBusinessEventEditDiv(action) {
	
	var overlayStr = "<form id='id_businesseventeditform' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='id_businessEventEditDiv'>";
	overlayStr += "<table>";
	if (action == "new") {
		overlayStr += "<tr><td>Application:<span class='ibm-required'>*</span></td><td colspan='2'><select id='id_businesseventedit_applcd' class='ibm-styled' title='applcd' style='width: 150px;'></select></td></tr>";
		overlayStr += "<tr><td>Event code:<span class='ibm-required'>*</span></td><td colspan='2'><input type='text' id='id_businesseventedit_eventcd' name='businesseventedit_eventcd' size='20' maxlength='3'></input></td></tr>";
	} else if (action == "update") {
		overlayStr += "<tr><td>Application:<span class='ibm-required'>*</span></td><td colspan='2'><input type='text' id='id_businesseventedit_applcd' name='businesseventedit_applcd' size='20' readonly disabled></td></tr>";
		overlayStr += "<tr><td>Event code:<span class='ibm-required'>*</span></td><td colspan='2'><input type='text' id='id_businesseventedit_eventcd' name='businesseventedit_eventcd' size='20' readonly disabled></input></td></tr>";
	}
	overlayStr += "<tr><td>Event&nbsp;description:<span class='ibm-required'>*</span></td><td colspan='2'><input type='text' id='id_businesseventedit_eventdesc' name='businesseventedit_eventdesc' size='50' maxlength='30'></input></td></tr>";
	overlayStr += "<tr><td>Event status:</td><td colspan='2'><select id='id_businesseventedit_status' class='ibm-styled' title='status' style='width: 100px;'></select></td></tr>";
	overlayStr += "<tr><td>Add new date:<br/>(YYYY-MM-DD)</td><td><input type='text' id='id_businesseventedit_addnewdate' name='businesseventedit_addnewdate' size='15' maxlength='10'></input></td><td>                                                         <input type='button' id='id_businesseventedit_addnewdate_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='businesseventedit_addnewdate_function()' value='Add date'/></td></tr>";
	overlayStr += "<tr><td>Event dates:<span class='ibm-required'>*</span></td><td><select id='id_businesseventedit_eventdates' class='ibm-styled' title='applcd' style='width: 100px;' size='16'></select></td><td style='vertical-align:top;'><input type='button' id='id_businesseventedit_deletedate_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='businesseventedit_deletedate()' value='Delete date'/></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_businesseventedit_save_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='businesseventedit_save()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_businesseventedit_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_businesseventedit_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";

	jQuery("#id_businesseventedit_page_overlay").empty().append(overlayStr);
}

function businesseventedit_save() {

	if (localBusinessEventEdit_action == "new" || localBusinessEventEdit_action == "update") {
		
		var tmpApplCd;
		var tmpEventCd;
		
		if (localBusinessEventEdit_action == "new") {
			tmpApplCd = jQuery("#id_businesseventedit_applcd").val();
			if (tmpApplCd == null || tmpApplCd == "none") {
				alert("You must select one in Application field");
				return;
			}
			
			tmpEventCd = jQuery("#id_businesseventedit_eventcd").val();
			if (tmpEventCd == null) {
				alert("Event code field can not be empty");
				return;
			} else {
				tmpEventCd = tmpEventCd.trim();
				if (tmpEventCd.length < 1) {
					alert("Event code field can not be empty");
					return;
				}
			}
		} else {
			tmpApplCd = localBusinessEventEdit_applCd;
			tmpEventCd = localBusinessEventEdit_eventCd;
		}
		
		var tmpEventDesc = jQuery("#id_businesseventedit_eventdesc").val();
		if (tmpEventDesc == null || tmpEventDesc == "") {
			alert("Event description field can not be empty");
			return;
		}
		
		if (localBusinessEventEdit_eventdates == null || localBusinessEventEdit_eventdates.length == 0) {
			alert("Event dates field can not be empty. Please add new date into it.");
			return;
		}
		
		var tmpStatus = jQuery("#id_businesseventedit_status").val();
		
		var eventId = new Object();
		eventId.applCd = tmpApplCd;
		eventId.eventCd = tmpEventCd;
		
		var event = new Object();
		event.id = eventId;
		event.eventDesc = tmpEventDesc;
		
		var dateList = new Array();
		
		for (var i = 0; i < localBusinessEventEdit_eventdates.length; i++) {
			var oneDateId = new Object();
			oneDateId.applCd = tmpApplCd;
			oneDateId.eventCd = tmpEventCd;
			oneDateId.eventDateStr = localBusinessEventEdit_eventdates[i];
			
			var oneDate = new Object();
			oneDate.id = oneDateId;
			oneDate.status = tmpStatus;
			
			dateList.push(oneDate);
		}
		
		var postObj = new Object();
		postObj.event = event;
		postObj.dateList = dateList;
		
		if (localBusinessEventEdit_action == "new") {
			jQuery("#id_businesseventedit_applcd").attr("disabled", "true");
			jQuery("#id_businesseventedit_eventcd").attr("disabled", "true");
		}
		jQuery("#id_businesseventedit_save_button").attr("disabled", "true");
		
		jQuery.ajax({
			type : "POST",
			url : localContextPath+"/action/admin/busievent/updateBusinessEvent/"+localBusinessEventEdit_action+"?timeid="+(new Date()).valueOf(),
			data : JSON.stringify(postObj),
			contentType : "application/json",
			dataType : "json",
		})
		.done(function(data) {
		
			var flag = data.flag;
			var text = data.text;
			alert(text);
			
			if (localBusinessEventEdit_action == "new") {
				if (flag == "1") {
					localBusinessEventEdit_action = "update";
					localBusinessEventEdit_applCd = tmpApplCd;
					localBusinessEventEdit_eventCd = tmpEventCd;
				} else {
					jQuery("#id_businesseventedit_applcd").removeAttr("disabled");
					jQuery("#id_businesseventedit_eventcd").removeAttr("disabled");
				}
			}
			
			jQuery("#id_businesseventedit_save_button").removeAttr("disabled");
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_businesseventedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		alert("Error, it's an unknown action.");
	}
}

function editBusinessEvent(action) {
	
	localBusinessEventEdit_action = action;
	
	if (localBusinessEventEdit_action == "new") {
		
		localBusinessEventEdit_applCd = "";
		localBusinessEventEdit_eventCd = "";
		localBusinessEventEdit_eventdates = new Array();
		initBusinessEventEditPageOverlay();
		
		jQuery.get(
			localContextPath+"/action/admin/busievent/getBusinessEventNew/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			var applList = data;
			initBusinessEventEditDiv(localBusinessEventEdit_action);
			
			var applListLength = applList.length;
			var applOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < applListLength; i++) {
				var currAppl = applList[i];
				applOptionStr += "<option value='" + currAppl.applCd + "'>" + currAppl.applCd + "</option>";
			}
			jQuery("#id_businesseventedit_applcd").empty().append(applOptionStr);
			IBMCore.common.widget.selectlist.init("#id_businesseventedit_applcd");
			
			var statusOptionStr = "<option value='A' selected>Active</option>";
			statusOptionStr += "<option value='I'>Inactive</option>";
			jQuery("#id_businesseventedit_status").empty().append(statusOptionStr);
			IBMCore.common.widget.selectlist.init("#id_businesseventedit_status");
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_businesseventedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else if (localBusinessEventEdit_action == "update") {
	
		var selectedBusinessEvent = jQuery("input[name='name_businesseventlist_table_radio']:checked");
	
		if (selectedBusinessEvent.length == 1) {
		
			initBusinessEventEditPageOverlay();
			
			var selectOne = jQuery(selectedBusinessEvent.get(0));
			
			localBusinessEventEdit_applCd = selectOne.attr("myApplCd");
			localBusinessEventEdit_eventCd = selectOne.attr("myEventCd");
			
			//alert(localBusinessEventEdit_applCd + "   " + localBusinessEventEdit_eventCd);
			
			var obj = new Object();
			obj.applCd = localBusinessEventEdit_applCd;
			obj.eventCd = localBusinessEventEdit_eventCd;
			
			jQuery.ajax({
				type : "POST",
				url : localContextPath+"/action/admin/busievent/getBusinessEventEdit?timeid="+(new Date()).valueOf(),
				data : JSON.stringify(obj),
				contentType : "application/json",
				dataType : "json",
			})
			.done(function(data) {
				var event = data.event;
				var eventApplCd = event.id.applCd;
				var eventEventCd = event.id.eventCd;
				var applList = data.applList;
				var dateList = data.dateList;
				initBusinessEventEditDiv(localBusinessEventEdit_action);
				
				jQuery("#id_businesseventedit_applcd").val(eventApplCd);
				jQuery("#id_businesseventedit_eventcd").val(eventEventCd);
				jQuery("#id_businesseventedit_eventdesc").val(event.eventDesc);
				
				localBusinessEventEdit_eventdates = new Array();
				for (var i = 0; i < dateList.length; i++) {
					var eventdate = dateList[i];
					if (eventdate != null) {
						localBusinessEventEdit_eventdates.push(eventdate.id.eventDateStr);
					}
				}
				refreshEventDatesField();
				
				var statusOptionStr = "";
				if (dateList == null || dateList.length == 0) {
					statusOptionStr = "<option value='A' selected>Active</option>";
					statusOptionStr += "<option value='I'>Inactive</option>";
				} else {
					var currStatus = dateList[0].status;
					if (currStatus == "A") {
						statusOptionStr = "<option value='A' selected>Active</option>";
						statusOptionStr += "<option value='I'>Inactive</option>";
					} else {
						statusOptionStr = "<option value='A'>Active</option>";
						statusOptionStr += "<option value='I' selected>Inactive</option>";
					}
				}
				jQuery("#id_businesseventedit_status").empty().append(statusOptionStr);
				IBMCore.common.widget.selectlist.init("#id_businesseventedit_status");
			})
			.fail(function(jqXHR, textStatus, errorThrown) {
				jQuery("#id_businesseventedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
				console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
				console.log(		"ajax error in loading...textStatus..."	+textStatus); 
				console.log(		"ajax error in loading...errorThrown..."+errorThrown);
			})
		} else {
			alert("please select one business event to edit.");
			return;
		}
	}
}

function businesseventedit_addnewdate_function() {

	var tmpAddNewDate = jQuery("#id_businesseventedit_addnewdate").val();
	if (tmpAddNewDate == null || tmpAddNewDate == "") {
		alert("New date can not be empty. Please input valid date into Add new date field.");
		return;
	} else if (checkDateInput(tmpAddNewDate, "New date is not in correct format. Please verify it in Add new date field.")) {
		// it's a valid date
		var newDateExisted = false;

		for (var i = 0; i < localBusinessEventEdit_eventdates.length; i++) {
			if (localBusinessEventEdit_eventdates[i] == tmpAddNewDate) {
				newDateExisted = true;
				break;
			}
		}
		
		if (newDateExisted) {
			alert("New date " + tmpAddNewDate + " already existed.");
		} else {
			localBusinessEventEdit_eventdates.push(tmpAddNewDate);
			localBusinessEventEdit_eventdates.sort();
			refreshEventDatesField();
		}
	} else {
		return;
	}
}

function businesseventedit_deletedate() {

	var selectedDate = jQuery("#id_businesseventedit_eventdates").val();
	
	if (selectedDate == null) {
		alert("Please select one to delete in Event dates field.");
	} else {
		var newEventDates = new Array();
		
		for (var i = 0; i < localBusinessEventEdit_eventdates.length; i++) {
			var currDate = localBusinessEventEdit_eventdates[i];
			if (currDate == selectedDate) {
				// nothing to do, delete this date successfully.
			} else {
				newEventDates.push(currDate);
			}
		}
		
		localBusinessEventEdit_eventdates = newEventDates;
		refreshEventDatesField();
	}
}

function refreshEventDatesField() {
	var eventDatesOptionStr = "";
	for (var i = 0; i < localBusinessEventEdit_eventdates.length; i++) {
		var currDate = localBusinessEventEdit_eventdates[i];
		eventDatesOptionStr += "<option value='" + currDate + "'>" + currDate + "</option>";
	}
	jQuery("#id_businesseventedit_eventdates").empty().append(eventDatesOptionStr);
}

function initBusinessEventEditPageOverlay() {
	
	var overlayStr = "<div id='id_businesseventedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_businesseventedit_page_overlay_main").append(overlayStr);
	jQuery("#id_businesseventedit_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_businesseventedit_page_overlay");
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
var localBusinessEventDelete_applCd;
var localBusinessEventDelete_eventCd;

function deleteBusinessEvent() {
	
	var selectedBusinessEvent = jQuery("input[name='name_businesseventlist_table_radio']:checked");
	
	if (selectedBusinessEvent.length == 1) {
		var selectOne = jQuery(selectedBusinessEvent.get(0));
		localBusinessEventDelete_applCd = selectOne.attr("myApplCd");
		localBusinessEventDelete_eventCd = selectOne.attr("myEventCd");
		//alert(localBusinessEventDelete_applCd + "   " + localBusinessEventDelete_eventCd);

		IBMCore.common.widget.overlay.show("id_confirmation_deleteselectedbusinessevent");
		jQuery("#id_confirmation_selectedbusinessevent").text("[" + localBusinessEventDelete_applCd + ", " + localBusinessEventDelete_eventCd + "]");
	} else {
		alert("please select one business event to delete.");
		return;
	}
}

function deleteSelectedBusinessEventOk() {
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedbusinessevent").getId(), true);
	jQuery("#id_businesseventlist_delete_button").attr("disabled", "true");
	
	var obj = new Object();
	obj.applCd = localBusinessEventDelete_applCd;
	obj.eventCd = localBusinessEventDelete_eventCd;
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/admin/busievent/deleteBusinessEvent?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var businessEventList = data.businessEventList;
		var text = data.text;
		alert(text);
		jQuery("#id_businesseventlist_delete_button").removeAttr("disabled");
		initBusinessEventListDataDiv(businessEventList, "delete");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_businesseventlistdatadiv").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedBusinessEventCancel() {
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_confirmation_deleteselectedbusinessevent").getId(), true);
}

	</script>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>