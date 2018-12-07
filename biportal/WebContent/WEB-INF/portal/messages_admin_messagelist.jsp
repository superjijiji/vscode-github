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
<title>BI@IBM | Manage messages</title>
<style type="text/css">
</style>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br />
	<div>
		<div style="width: 95%; align: center; margin-left: auto; margin-right: auto;">
			<div>
				<div>
					<h1 class="ibm-h1 ibm-light">Manage messages</h1>
				</div>
			</div>
				<form id='messageListForm' class="ibm-column-form" method="post">
					<div>
						<input type="button" id="id_messagelist_addmessage_button" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="editMessage('0','new')" value="Add message"/>
						<input type="button" id="id_messagelist_deleteselectedmessage_button" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="deleteSelectedMessage()" value="Delete selected messages"/>
						<input type="button" id="id_messagelist_deleteexpiredmessage_button" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="deleteExpiredMessage()" value="Delete expired messages"/>
					</div>
					<div>
						<table style="width: 100%;">
							<tr>
								<td>
									<select id="id_messagelist_category_select" class="ibm-styled" title="category" style="width: 200px;"></select>
									<select id="id_messagelist_type_select" class="ibm-styled" title="category" style="width: 200px;"></select>
									<input type="button" id="id_messagelist_filter_button" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="filterMessage()" value="Go"/>
								</td>
								<td align='right'>
									<input type="button" id="id_messagelist_messagecategory_button" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="manageMessageCategory()" value="Manage categories"/>
									<input type="button" id="id_messagelist_messagetype_button" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="manageMessageType()" value="Manage types"/>
									<input type="button" id="id_messagelist_messagerolegroup_button" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="manageMessageRoleGroup()" value="Manage role groups"/>
								</td>
							</tr>
						</table>
					</div>
					<div id="messageListDiv">
					</div>
				</form>
			<div>
			</div>
		</div>
	</div>
	<div id="confirmation_deleteselectedmessage" class="ibm-common-overlay ibm-overlay-alt" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center"><span class="ibm-h3 ibm-center" id="selectedMessageCount">0</span> messages are selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected messages should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedMessageOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedMessageCancel();">Cancel</button>  	
 		</p>
 	</div>
 	<div id="confirmation_deleteselectedcategory" class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center"><span class="ibm-h3 ibm-center" id="selectedCategoryCount">0</span> categories are selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected categories should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedCategoryOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedCategoryCancel();">Cancel</button>  	
 		</p>
 	</div>
 	<div id="confirmation_deleteselectedtype" class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center"><span class="ibm-h3 ibm-center" id="selectedTypeCount">0</span> types are selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected types should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedTypeOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedTypeCancel();">Cancel</button>  	
 		</p>
 	</div>
 	<div id="confirmation_deleteselectedrolegroup" class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert">
 		<h3 class="ibm-h3 ibm-center"><span class="ibm-h3 ibm-center" id="selectedRolegroupCount">0</span> groups are selected.</h3>
 		<p class="ibm-center">Click on OK to confirm that the selected groups should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedRolegroupOk();">OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="deleteSelectedRolegroupCancel();">Cancel</button>  	
 		</p>
 	</div>
 	<div id="id_messageedit_page_overlay_main"></div>
 	<div id="id_categorylist_page_overlay_main"></div>
 	<div id="id_categoryedit_page_overlay_main"></div>
 	<div id="id_typelist_page_overlay_main"></div>
 	<div id="id_typeedit_page_overlay_main"></div>
 	<div id="id_rolegrouplist_page_overlay_main"></div>
 	<div id="id_rolegroupedit_page_overlay_main"></div>
	<br />
	<script type="text/javascript">
var localContextPath = "<%=request.getContextPath()%>";
var localCwaid = "${cwa_id}"; 
var localUid = "${uid}";
var localMessageList_CurrentCategory;
var localMessageList_CurrentType;
var messagelinksubstrlength=20;
var selectedMessageIdList;

jQuery(document).ready(function() {
	initMessageList();
})

function initMessageList() {
	jQuery.get(
		localContextPath+"/action/portal/messages/getAdmimMessageAll/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
	)
	.done(function(data) {
		
		var adminAllMessageList = data.adminAllMessageList;
		var allCategoryList = data.allCategoryList;
		var allTypeList = data.allTypeList;
		initMessageListDiv(adminAllMessageList, allCategoryList, allTypeList, "init");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#messageListDiv").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function filterMessage() {

	var selectedCategory = jQuery("#id_messagelist_category_select").val();
	var selectedType     = jQuery("#id_messagelist_type_select").val();
	jQuery("#id_messagelist_filter_button").attr("disabled", "true");
	
	jQuery.get(
		localContextPath+"/action/portal/messages/getAdmimMessageAll/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
	)
	.done(function(data) {
		localMessageList_CurrentCategory = selectedCategory;
		localMessageList_CurrentType = selectedType;
		var adminAllMessageList = data.adminAllMessageList;
		var allCategoryList = data.allCategoryList;
		var allTypeList = data.allTypeList;
		jQuery("#id_messagelist_filter_button").removeAttr("disabled");
		initMessageListDiv(adminAllMessageList, allCategoryList, allTypeList, "filter");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#messageListDiv").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function initCategoryAndTypeDropdownlist(allCategoryList, allTypeList) {

	var allCategoryListLength = allCategoryList.length;
	var allTypeListLength = allTypeList.length;
	
	var categoryOptionStr = "<option value='all'>All categories</option>";
	for (var i = 0; i < allCategoryListLength; i++) {
		var currCategory = allCategoryList[i];
		categoryOptionStr += "<option value='" + currCategory.msgCategoryId + "'>" + currCategory.msgCtgryDesc + "</option>";
	}
	jQuery("#id_messagelist_category_select").empty().append(categoryOptionStr);
	IBMCore.common.widget.selectlist.init("#id_messagelist_category_select");
	
	var typeOptionStr = "<option value='all'>All types</option>";
	for (var i = 0; i < allTypeListLength; i++) {
		var currType = allTypeList[i];
		typeOptionStr += "<option value='" + currType.msgTypeId + "'>" + currType.msgTypeDesc + "</option>";
	}
	jQuery("#id_messagelist_type_select").empty().append(typeOptionStr);
	IBMCore.common.widget.selectlist.init("#id_messagelist_type_select");
}

function initMessageListDiv(adminAllMessageList, allCategoryList, allTypeList, action) {
	
	jQuery("#messageListDiv").empty();
		
	if(allCategoryList == null || allCategoryList.length == 0 || allTypeList == null || allTypeList.length == 0) {
		jQuery("#messageListDiv").append("Error, there is not any message category or type.");
	} else {
		var adminAllMessageListLength = adminAllMessageList.length;
		var allCategoryListLength = allCategoryList.length;
		var allTypeListLength = allTypeList.length;
		
		if (action == "init") {
			initCategoryAndTypeDropdownlist(allCategoryList, allTypeList);
			localMessageList_CurrentCategory = "all";
			localMessageList_CurrentType = "all";
		}
		
		var filterMessageList = new Array();
		
		if (localMessageList_CurrentCategory == "all" && localMessageList_CurrentType == "all") {
			filterMessageList = adminAllMessageList;
		} else {
			for (var i = 0; i < adminAllMessageListLength; i++) {
		
				var currentMessage = adminAllMessageList[i];
				
				if (localMessageList_CurrentCategory == "all") {
					if (localMessageList_CurrentType == "all") {
						// show all messages
						// nothing to do here
					} else {
						// filter by type
						if (localMessageList_CurrentType == currentMessage.msgTypeId) {
							filterMessageList.push(currentMessage);
						}
					}
				} else {
					if (localMessageList_CurrentType == "all") {
						// filter by category
						if (localMessageList_CurrentCategory == currentMessage.msgCategoryId) {
							filterMessageList.push(currentMessage);
						}
					} else {
						// filter by category and type
						if (localMessageList_CurrentCategory == currentMessage.msgCategoryId && localMessageList_CurrentType == currentMessage.msgTypeId) {
							filterMessageList.push(currentMessage);
						}
					}
				}
			}
		}
		
		var tableStr = "<div>";
		
		if (filterMessageList == null || filterMessageList.length == 0) {
			tableStr += "<div>There is not any message for selected category and type.</div>"
			tableStr += "</div>"
			jQuery("#messageListDiv").append(tableStr);
		} else {
			
			tableStr += "<table id='id_messagelist_table' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='false'>";
			tableStr += "<thead><tr>";
			tableStr += "<th scope='col'></th>";
			tableStr += "<th scope='col'>Message ID</th>";
			tableStr += "<th scope='col'>Message category</th>";
			tableStr += "<th scope='col'>Message type</th>";
			tableStr += "<th scope='col'>Message</th>";
			tableStr += "<th scope='col'>More ...</th>";
			tableStr += "<th scope='col'>Security type</th>";
			tableStr += "<th scope='col'>Show once</th>";
			tableStr += "<th scope='col'>Originator</th>";
			//tableStr += "<th scope='col'>Date Time posted</th>";
			tableStr += "<th scope='col' style='width: 80px;'>DateTime to show</th>";
			tableStr += "<th scope='col' style='width: 80px;'>Expires</th>";
			tableStr += "<th scope='col'>EmailSubject Suffix</th>";
			tableStr += "</tr></thead>";
			tableStr += "<tbody>";
			
			var filterMessageListLength = filterMessageList.length;
				
			for (var i = 0; i < filterMessageListLength; i++) {
				
				var message = filterMessageList[i];
				
				tableStr += "<tr>";
				tableStr += "<td scope='row'><span class='ibm-checkbox-wrapper'><input id='id_messagelist_tr_" + message.msgId + "' name='message_checkbox_name' value='" + message.msgId + "' type='checkbox' class='ibm-styled-checkbox'></input>";
				tableStr += "<label for='id_messagelist_tr_" + message.msgId + "'><span class='ibm-access'>Select One</span></label></span></td>";
				tableStr += "<td><a onclick='editMessage(\""+message.msgId+"\",\"update\")' style='cursor: pointer'>" + message.msgId + "</a></td>";
				tableStr += "<td>" + message.msgCtgryDesc + "</td>";
				tableStr += "<td>" + message.msgTypeDesc + "</td>";
				//tableStr += "<td><a href='" + localContextPath + "/action/portal/messages/messages_admin_messageedit/update/" + message.msgId + "' target='_blank'>" + message.messageText + "</a></td>";
				tableStr += "<td>" + message.messageText + "</td>";
				if (message.link == null) {
					tableStr += "<td></td>";
				} else {
					if (message.link.length <= messagelinksubstrlength) {
						tableStr += "<td>" + message.link + "</td>";
					} else {
						tableStr += "<td>" + message.link.substr(0, messagelinksubstrlength) + " ..." + "</td>";
					}
				}
				tableStr += "<td>" + message.securityType + "</td>";
				tableStr += "<td>" + message.showOnce + "</td>";
				tableStr += "<td>" + message.originator + "</td>";
				//tableStr += "<td>" + message.dateTimeCreatedStr + "</td>";
				tableStr += "<td>" + message.startDateStr + "</td>";
				if (message.expDate == null) {
					tableStr += "<td></td>";
				} else {
					tableStr += "<td>" + message.expDateStr + "</td>";
				}
				tableStr += "<td>" + message.emailSuffix + "</td>";
				tableStr += "</tr>";
			}
			
			tableStr += "</tbody>";
			tableStr += "</table>";
			tableStr += "</div>";
			
			jQuery("#messageListDiv").append(tableStr);
			jQuery("#id_messagelist_table").DataTable({paging:false, searching:false, info:false});
			jQuery("#id_messagelist_table").tablesrowselector();
		}
	}
}

function deleteSelectedMessage() {
	//var allSelectedMessages = jQuery("#messageListForm").serialize();
	//alert(allSelectedMessages);
	
	var allMessageCheckboxes = jQuery("[name='message_checkbox_name']");
	var allMessageCheckboxesLength = allMessageCheckboxes.length;
	var selectedIds = new Array();
	
	for (var i = 0; i < allMessageCheckboxesLength; i++) {
		var currBox = allMessageCheckboxes[i];
		if (currBox.checked) {
			var selectedId = jQuery(currBox).attr("value");
			selectedIds.push(selectedId);
		}
	}
	
	//alert(selectedIds.length);
	
	if (selectedIds.length > 0) {
		selectedMessageIdList = selectedIds;
		IBMCore.common.widget.overlay.show("confirmation_deleteselectedmessage");
		jQuery("#selectedMessageCount").text(selectedIds.length);
	} else {
		alert("please select one message to delete.");
	}
}

function deleteSelectedMessageOk() {
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("confirmation_deleteselectedmessage").getId(), true);
	
	jQuery("#id_messagelist_deleteselectedmessage_button").attr("disabled", "true");
	
	var obj = jQuery.parseJSON('[]');
	
	for (var i = 0; i < selectedMessageIdList.length; i++) {
		obj.push(jQuery.parseJSON('{"msgId":"' + selectedMessageIdList[i] + '"}'));
	}
	
	//alert(JSON.stringify(obj));
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/portal/messages/deleteSelectedMessages?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var adminAllMessageList = data.adminAllMessageList;
		var allCategoryList = data.allCategoryList;
		var allTypeList = data.allTypeList;
		var text = data.text;
		alert(text);
		jQuery("#id_messagelist_deleteselectedmessage_button").removeAttr("disabled");
		initMessageListDiv(adminAllMessageList, allCategoryList, allTypeList, "delete");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#messageListDiv").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedMessageCancel() {

	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("confirmation_deleteselectedmessage").getId(), true);
	//alert("deleteSelectedMessageCancel()");
}

function deleteExpiredMessage() {
	
	jQuery("#id_messagelist_deleteexpiredmessage_button").attr("disabled", "true");
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/portal/messages/deleteExpiredMessages?timeid="+(new Date()).valueOf(),
	})
	.done(function(data) {
		var adminAllMessageList = data.adminAllMessageList;
		var allCategoryList = data.allCategoryList;
		var allTypeList = data.allTypeList;
		var text = data.text;
		alert(text);
		jQuery("#id_messagelist_deleteexpiredmessage_button").removeAttr("disabled");
		initMessageListDiv(adminAllMessageList, allCategoryList, allTypeList, "delete");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#messageListDiv").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

/* function addMessage() {
	var url = localContextPath + "/action/portal/messages/messages_admin_messageedit/new/0";
	window.open(url,'_blank');
} */

var localMessageEdit_MsgId;
var localMessageEdit_Action;

function initMessageEditPageOverlay() {
	
	var overlayStr = "<div id='id_messageedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt-three' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_messageedit_page_overlay_main").append(overlayStr);
	jQuery("#id_messageedit_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_messageedit_page_overlay");
}

function initMessageEditPage() {
	
	var overlayStr = "<form id='messageEditForm' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='messageEditDiv'>";
	overlayStr += "<table>";
	overlayStr += "<tr><td>Message ID:</td><td><input type='text' id='id_messageedit_id' name='messageedit_id' size='12' readonly disabled></input></td><td align='right' colspan='2'>";
	overlayStr += "<input type='button' id='id_messageedit_savemessage_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='messageedit_saveMessage()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_messageedit_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_messageedit_page_overlay\")' value='Close'/>";
	overlayStr += "</td></tr>";
	overlayStr += "<tr><td>Date/Time posted:</td><td><input type='text' id='id_messageedit_datetimeposted' size='30' readonly disabled></input></td>";
	overlayStr += "<td>Date/Time to show:</td><td><input type='text' id='id_messageedit_datetimetoshow' size='30'></input>Format yyyy-mm-dd hh:mm:ss</td></tr>";
	overlayStr += "<tr><td>Message Category:<span class='ibm-required'>*</span></td><td><select id='id_messageedit_category' class='ibm-styled' title='category' style='width: 200px;'></select></td>";
	overlayStr += "<td>Message Type:<span class='ibm-required'>*</span></td><td><select id='id_messageedit_type' class='ibm-styled' title='category' style='width: 200px;'></select></td></tr>";
	overlayStr += "<tr><td>Message Template:<span class='ibm-required'>*</span></td><td><select id='id_messageedit_template' class='ibm-styled' title='template' style='width: 200px;'></select></td></tr>";
	overlayStr += "<tr><td>Email Subject:</td><td colspan='3'><input type='text' id='id_messageedit_emailsubjectsuffix' size='100' maxlength='80'></input></td></tr>";
	overlayStr += "<tr><td>Title:<span class='ibm-required'>*</span></td><td><input type='text' id='id_messageedit_title' class='ibm-styled' title='title' style='width: 200px;'></input></td>";
	overlayStr += "<td>Sub Title:<span class='ibm-required'>*</span></td><td><input type='text' id='id_messageedit_subtitle' class='ibm-styled' title='subtitle' style='width: 200px;'></input></td></tr>";
	overlayStr += "<tr><td style='vertical-align:top;'>Message Text:<span class='ibm-required'>*</span></td><td colspan='3'><span><textarea id='id_messageedit_messagetext' cols='100' rows='5' required placeholder='<ol><li>Coffee</li><li>Milk</li></ol>'></textarea></span><span name='values' id='id_egForMessageText' class='ibm-item-note'> List should follow below pattern,code has shows in the textarea:<br><ol><li>Coffee</li><li>Milk</li></ol></span></td></tr>";
// 	overlayStr += "<tr><td style='vertical-align:top;'></td><td colspan='3'>if you need a list please follow this pattern:<br/><ol><li>Coffee</li><li>Milk</li></ol></td></tr>";
	overlayStr += "<tr><td>More Link:</td><td colspan='3'><input type='text' id='id_messageedit_morelink' size='100' maxlength='256'></input></td></tr>";
	overlayStr += "<tr><td>Expiration Date:<span class='ibm-required'>*</span></td><td colspan='2'><input type='text' id='id_messageedit_expirationdate' size='20'></input>Format yyyy-mm-dd</td>";
	overlayStr += "<td><span class='ibm-checkbox-wrapper'><input class='ibm-styled-checkbox' id='id_messageedit_showonce' type='checkbox'/><label for='id_messageedit_showonce' class='ibm-field-label'>Show Once</label></span></td></tr>";
	overlayStr += "<tr><td>Security Type:<span class='ibm-required'>*</span></td><td colspan='3'><div id='id_messageedit_securitytype'></div></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "</div>";
	overlayStr += "</form>";

	jQuery("#id_messageedit_page_overlay").empty().append(overlayStr);
	
	var sectStr = "<fieldset style='border:1px solid #DDD;'>";
// 	sectStr += "<legend>Security Type:<span class='ibm-required'>*</span></legend>";
	sectStr += "<table>";
	sectStr += "<tr>";
	sectStr += "<td>";
	sectStr += "<input type='radio' class='ibm-styled-radio' id='id_messageedit_security_allusers_radio' value='A' name='id_messageedit_security'></input>";
	sectStr += "<label for='id_messageedit_security_allusers_radio'>All users</label>";
	sectStr += "</td>";
	sectStr += "<td>";
	sectStr += "</td>";
	sectStr += "</tr>";
	
	sectStr += "<tr>";
	sectStr += "<td style='vertical-align:top;'>";
	sectStr += "<input type='radio' class='ibm-styled-radio' id='id_messageedit_security_group_radio' value='G' name='id_messageedit_security'></input>";
	sectStr += "<label for='id_messageedit_security_group_radio'>Group</label>";
	sectStr += "</td>";
	sectStr += "<td>";
	sectStr += "<select multiple='multiple' id='id_messageedit_security_group_select' name='messageedit_security_group_select'>";
	sectStr += "</select>";
	sectStr += "</td>";
	sectStr += "</tr>";
	
	sectStr += "<tr>";
	sectStr += "<td style='vertical-align:top;'>";
	sectStr += "<input type='radio' class='ibm-styled-radio' id='id_messageedit_security_role_radio' value='R' name='id_messageedit_security'></input>";
	sectStr += "<label for='id_messageedit_security_role_radio'>Role</label>";
	sectStr += "</td>";
	sectStr += "<td>";
	sectStr += "<select multiple='multiple' id='id_messageedit_security_role_select' name='security_role_select'>";
	sectStr += "</select>";
	sectStr += "</td>";
	sectStr += "</tr>";
	
	sectStr += "<tr>";
	sectStr += "<td style='vertical-align:top;'>";
	sectStr += "<input type='radio' class='ibm-styled-radio' id='id_messageedit_security_userid_radio' value='U' name='id_messageedit_security'></input>";
	sectStr += "<label for='id_messageedit_security_userid_radio'>User ID</label>";
	sectStr += "</td>";
	sectStr += "<td>";
	sectStr += "<textarea id='id_messageedit_security_userid_textarea' cols='60' rows='3'>";
	sectStr += "</textarea><br>Enter intranet email addresses, separated by commas.";
	sectStr += "</td>";
	sectStr += "</tr>";
	sectStr += "</table>";
	sectStr += "</fieldset>";
	
	jQuery("#id_messageedit_securitytype").append(sectStr);
}

function editMessage(msgId, action) {
	
	localMessageEdit_MsgId = msgId;
	localMessageEdit_Action = action;
	
	initMessageEditPageOverlay();
	
	if (action == "new") {
		jQuery.get(
			localContextPath+"/action/portal/messages/getAdminMessageInit/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
	
			initMessageEditPage();
	
			var categoryList = data.categoryList;
			var typeList = data.typeList;
			var groupList = data.groupList;
			var roleList = data.roleList;
			var templateList = data.templateList;
			
			var categoryListLength = categoryList.length;
			var cateOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < categoryListLength; i++) {
				var currCategory = categoryList[i];
				cateOptionStr += "<option value='" + currCategory.msgCategoryId + "'>" + currCategory.msgCtgryDesc + "</option>";
			}
			jQuery("#id_messageedit_category").empty().append(cateOptionStr);
			IBMCore.common.widget.selectlist.init("#id_messageedit_category");
			
			var typeListLength = typeList.length;
			var typeOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < typeListLength; i++) {
				var currType = typeList[i];
				typeOptionStr += "<option value='" + currType.msgTypeId + "'>" + currType.msgTypeDesc + "</option>";
			}
			jQuery("#id_messageedit_type").empty().append(typeOptionStr);
			IBMCore.common.widget.selectlist.init("#id_messageedit_type");
			
			var templateListLength = templateList.length;
			var templateOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < templateListLength; i++) {
				var currTemplate = templateList[i]; 
				templateOptionStr += "<option value='" + currTemplate.templateId + "'>" + currTemplate.templateName + "</option>";
			}
			jQuery("#id_messageedit_template").empty().append(templateOptionStr);
			IBMCore.common.widget.selectlist.init("#id_messageedit_template");
			
			
			
			var securityGroupSelectStr = "";
			var groupListLength = groupList.length;
			for (var i = 0; i < groupListLength; i++) {
				var currGroup = groupList[i];
				securityGroupSelectStr += "<option value='" + currGroup.msgGroupId + "'>" + currGroup.msgGroupDesc + "</option>";
			}
			jQuery("#id_messageedit_security_group_select").append(securityGroupSelectStr);
			
			var securityRoleSelectStr = "";
			var roleListLength = roleList.length;
			for (var i = 0; i < roleListLength; i++) {
				var currRole = roleList[i];
				securityRoleSelectStr += "<option value='" + currRole.roleName + "'>" + currRole.roleName + "</option>";
			}
			jQuery("#id_messageedit_security_role_select").append(securityRoleSelectStr);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_messageedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else if (action == "update") {
		jQuery.get(
			localContextPath+"/action/portal/messages/getAdminMessageOne/"+localCwaid+"/"+localUid+"/"+localMessageEdit_MsgId+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
		
			initMessageEditPage();
			
			var message = data.message;
			var securityList = data.securityList;
			var categoryList = data.categoryList;
			var typeList = data.typeList;
			var groupList = data.groupList;
			var roleList = data.roleList;
			var templateList = data.templateList;
			jQuery("#id_messageedit_title").val(message.title);
			jQuery("#id_messageedit_subtitle").val(message.subTitle);
			
			jQuery("#id_messageedit_id").val(message.msgId);
			
			jQuery("#id_messageedit_datetimeposted").val(message.dateTimeCreatedStr);
			
			jQuery("#id_messageedit_datetimetoshow").val(message.startDateStr);
			
			if (message.expDate != null) {
				jQuery("#id_messageedit_expirationdate").val(message.expDateStr);
			}
			
			jQuery("#id_messageedit_emailsubjectsuffix").val(message.emailSuffix);
			
			var categoryListLength = categoryList.length;
			var cateOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < categoryListLength; i++) {
				var currCategory = categoryList[i];
				if (currCategory.msgCategoryId == message.msgCategoryId) {
					cateOptionStr += "<option value='" + currCategory.msgCategoryId + "' selected>" + currCategory.msgCtgryDesc + "</option>";
				} else {
					cateOptionStr += "<option value='" + currCategory.msgCategoryId + "'>" + currCategory.msgCtgryDesc + "</option>";
				}
			}
			jQuery("#id_messageedit_category").empty().append(cateOptionStr);
			IBMCore.common.widget.selectlist.init("#id_messageedit_category");
			
			var typeListLength = typeList.length;
			var typeOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < typeListLength; i++) {
				var currType = typeList[i];
				if (currType.msgTypeId == message.msgTypeId) {
					typeOptionStr += "<option value='" + currType.msgTypeId + "' selected>" + currType.msgTypeDesc + "</option>";
				} else {
					typeOptionStr += "<option value='" + currType.msgTypeId + "'>" + currType.msgTypeDesc + "</option>";
				}
			}
			jQuery("#id_messageedit_type").empty().append(typeOptionStr);
			IBMCore.common.widget.selectlist.init("#id_messageedit_type");
			
			var templateListLength = templateList.length;
			var templateOptionStr = "<option value='none'>Please select one</option>";
			for (var i = 0; i < templateListLength; i++) {
				var currTemplate = templateList[i];
				if (currTemplate.templateId == message.templateId) {
					templateOptionStr += "<option value='" + currTemplate.templateId + "' selected>" + currTemplate.templateName + "</option>";
				} else {
					templateOptionStr += "<option value='" + currTemplate.templateId + "'>" + currTemplate.templateName + "</option>";
				}
			}
			jQuery("#id_messageedit_template").empty().append(templateOptionStr);
			IBMCore.common.widget.selectlist.init("#id_messageedit_template");
			
			if (message.showOnce == "Y") {
				jQuery("#id_messageedit_showonce").prop("checked", true);
			} else {
				jQuery("#id_messageedit_showonce").prop("checked", false);
			}
			
			jQuery("#id_messageedit_messagetext").val(message.messageText);
			jQuery("#id_messageedit_morelink").val(message.link);
			
			var securityIsAllUsers = securityList != null && securityList.length > 0 && securityList[0].securityType == "A";
			var securityIsGroup    = securityList != null && securityList.length > 0 && securityList[0].securityType == "G";
			var securityIsRole     = securityList != null && securityList.length > 0 && securityList[0].securityType == "R";
			var securityIsUserId   = securityList != null && securityList.length > 0 && securityList[0].securityType == "U";
			
			if (securityIsAllUsers) {
				jQuery("#id_messageedit_security_allusers_radio").attr("checked", true);
			} else if (securityIsGroup) {
				jQuery("#id_messageedit_security_group_radio").attr("checked", true);
			} else if (securityIsRole) {
				jQuery("#id_messageedit_security_role_radio").attr("checked", true);
			} else if (securityIsUserId) {
				jQuery("#id_messageedit_security_userid_radio").attr("checked", true);
			}
			
			var securityGroupSelectStr = "";
			var groupListLength = groupList.length;
			if (securityIsGroup) {
				for (var i = 0; i < groupListLength; i++) {
					var currGroup = groupList[i];
					var j = 0;
					var securityListLength = securityList.length;
					for (; j < securityListLength; j++) {
						var currSecurity = securityList[j];
						if (currGroup.msgGroupId == currSecurity.msgSecurityId) {
							securityGroupSelectStr += "<option value='" + currGroup.msgGroupId + "' selected>" + currGroup.msgGroupDesc + "</option>";
							break;
						}
					}
					
					if (j == securityList.length) {
						securityGroupSelectStr += "<option value='" + currGroup.msgGroupId + "'>" + currGroup.msgGroupDesc + "</option>";
					}
				}
			} else {
				for (var i = 0; i < groupListLength; i++) {
					var currGroup = groupList[i];
					securityGroupSelectStr += "<option value='" + currGroup.msgGroupId + "'>" + currGroup.msgGroupDesc + "</option>";
				}
			}
			jQuery("#id_messageedit_security_group_select").append(securityGroupSelectStr);
			
			var securityRoleSelectStr = "";
			var roleListLength = roleList.length;
			if(securityIsRole) {
				for (var i = 0; i < roleListLength; i++) {
					var currRole = roleList[i];
					var j = 0;
					var securityListLength = securityList.length;
					for (; j < securityListLength; j++) {
						var currSecurity = securityList[j];
						if (currRole.roleName == currSecurity.msgSecurityId) {
							securityRoleSelectStr += "<option value='" + currRole.roleName + "' selected>" + currRole.roleName + "</option>";
							break;
						}
					}
					
					if (j == securityList.length) {
						securityRoleSelectStr += "<option value='" + currRole.roleName + "'>" + currRole.roleName + "</option>";
					}
				}
			} else {
				for (var i = 0; i < roleListLength; i++) {
					var currRole = roleList[i];
					securityRoleSelectStr += "<option value='" + currRole.roleName + "'>" + currRole.roleName + "</option>";
				}
			}
			jQuery("#id_messageedit_security_role_select").append(securityRoleSelectStr);
			
			if (securityIsUserId) {
				var securityUserIdSelectStr = "";
				var securityListLengthShort = securityList.length - 1;
				for (var i = 0; i < securityListLengthShort; i++) {
					securityUserIdSelectStr += securityList[i].msgSecurityId + ",";
				}
				securityUserIdSelectStr += securityList[securityListLengthShort].msgSecurityId;
				jQuery("#id_messageedit_security_userid_textarea").append(securityUserIdSelectStr);
			}
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_messageedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
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

function messageedit_saveMessage() {
	
	var tmpDateTimeToShow = jQuery("#id_messageedit_datetimetoshow").val();
	var tmpDateTimeToShowErrorMessage = "Date/Time to show field was not entered in correct format. Please verify this field.";
	if (tmpDateTimeToShow == null || tmpDateTimeToShow.length == 0) {
		// nothing to do since it can be empty. It's re-setup to CURRENT TIMESTAMP when this field is empty.
	} else if (tmpDateTimeToShow.length != 19) {
		alert(tmpDateTimeToShowErrorMessage);
		return;
	} else if (tmpDateTimeToShow.charAt(10) != " ") {
		alert(tmpDateTimeToShowErrorMessage);
		return;
	} else {
		if (checkDateInput(tmpDateTimeToShow.substring(0, 10), tmpDateTimeToShowErrorMessage)) {
			if (checkTimeInput(tmpDateTimeToShow.substring(11, 19), tmpDateTimeToShowErrorMessage)) {
				// nothing to do since it's a valid Date and Time.
			} else {
				return;
			}
		} else {
			return;
		}
	}
	
	var tmpCategory = jQuery("#id_messageedit_category").val();
	if (tmpCategory == null || tmpCategory == "none") {
		alert("you must select one in Message Category field");
		return;
	}
	
	var tmpType = jQuery("#id_messageedit_type").val();
	if (tmpType == null || tmpType == "none") {
		alert("you must select one in Message Type field");
		return;
	}
	
	var tmpTemplate = jQuery("#id_messageedit_template").val();
	if (tmpTemplate == null || tmpTemplate == "none") {
		alert("you must select one in Message Template field");
		return;
	}
	
	var tmpMessageText = jQuery("#id_messageedit_messagetext").val();
	if (tmpMessageText == null || tmpMessageText.length == 0) {
		alert("Message Text field is empty. Please enter text.");
		return;
	} else if (tmpMessageText.length > 512) {
		alert("Message Text exceeds the allowable character limit (512 chars).");
		return;
	}
	
	var tmpTitle = jQuery("#id_messageedit_title").val();
	if (tmpTitle == null || tmpTitle.length == 0) {
		alert("Title field is empty. Please enter text.");
		return;
	} 
	
	var tmpSubTitle = jQuery("#id_messageedit_subtitle").val();
	if (tmpSubTitle == null || tmpSubTitle.length == 0) {
		alert("Sub Title field is empty. Please enter text.");
		return;
	} 
	
	var tmpLink = jQuery("#id_messageedit_morelink").val();
	
	var tmpEmailSuffix = jQuery("#id_messageedit_emailsubjectsuffix").val();
	
	var tmpShowOnce;
	var tmpShowOnceChecked = jQuery("#id_messageedit_showonce").prop("checked");
	if (tmpShowOnceChecked) {
		tmpShowOnce = "Y";
	} else {
		tmpShowOnce = "N";
	}
	
	var tmpExpDate = jQuery("#id_messageedit_expirationdate").val();
	var expErrorMessage1 = "The date entered for Expiration Date is older than the current date. Please verify this field.";
	var expErrorMessage2 = "Expiration Date field was not entered in correct format. Please verify this field."
	if (tmpExpDate == null || tmpExpDate == "") {
		alert("Expiration Date field can not empty. Please input valid value.");
		return;
	} else if (checkDateInput(tmpExpDate, expErrorMessage2)) {
		// nothing to do since it's a valid date
	} else {
		return;
	}
	
	var newMessageObj = new Object();
	newMessageObj.msgId = localMessageEdit_MsgId;
	newMessageObj.startDateStr = tmpDateTimeToShow;
	newMessageObj.msgCategoryId = tmpCategory;
	newMessageObj.msgTypeId = tmpType;
	newMessageObj.expDateStr = tmpExpDate;
	newMessageObj.emailSuffix = tmpEmailSuffix;
	newMessageObj.showOnce = tmpShowOnce;
	newMessageObj.messageText = tmpMessageText;
	newMessageObj.link = tmpLink;
	newMessageObj.title = tmpTitle;
	newMessageObj.subTitle = tmpSubTitle;
	newMessageObj.templateId = tmpTemplate;
	
	
	var newSecurityList = new Array();
	
	var selectedRadioValue = jQuery("input[name='id_messageedit_security']:checked").val();
	if (selectedRadioValue == "A") {
		var newSecurityObject = new Object();
		newSecurityObject.msgId = localMessageEdit_MsgId;
		newSecurityObject.securityType = "A";
		newSecurityObject.msgSecurityId = "allusers";
		newSecurityList.push(newSecurityObject);
	} else if (selectedRadioValue == "G") {
		var groupOptions = jQuery("#id_messageedit_security_group_select").val();
		if (groupOptions == null || groupOptions.length == 0) {
			alert("you must select at least one in Group options");
			return;
		} else {
			for (var i = 0; i < groupOptions.length; i++) {
				var newSecurityObject = new Object();
				newSecurityObject.msgId = localMessageEdit_MsgId;
				newSecurityObject.securityType = "G";
				newSecurityObject.msgSecurityId = groupOptions[i];
				newSecurityList.push(newSecurityObject);
			}
		}
	} else if (selectedRadioValue == "R") {
		var roleOptions = jQuery("#id_messageedit_security_role_select").val();
		if (roleOptions == null || roleOptions.length == 0) {
			alert("you must select at least one in Role options");
			return;
		} else {
			for (var i = 0; i < roleOptions.length; i++) {
				var newSecurityObject = new Object();
				newSecurityObject.msgId = localMessageEdit_MsgId;
				newSecurityObject.securityType = "R";
				newSecurityObject.msgSecurityId = roleOptions[i];
				newSecurityList.push(newSecurityObject);
			}
		}
	} else if (selectedRadioValue == "U") {
		var userIdString = jQuery("#id_messageedit_security_userid_textarea").val();
		if (userIdString == null || userIdString.length == 0) {
			alert("please enter values for User ID.");
			return;
		} else {
			var userIdOptions = userIdString.split(",");
			if (userIdOptions == null || userIdOptions.length == 0) {
				alert("please enter values for User ID.");
				return;
			} else {
				var hasValidUser = false;
				for (var i = 0; i < userIdOptions.length; i++) {
					var currUserId = userIdOptions[i];
					if (currUserId == null || currUserId == "") {
						// nothing to do, ignore this invalid user
					} else {
						if (currUserId.length > 254) {
							alert("User ID: " + currUserId + " is longer than 254 characters. Please shorten.");
							return;
						} else {
							hasValidUser = true;
							var newSecurityObject = new Object();
							newSecurityObject.msgId = localMessageEdit_MsgId;
							newSecurityObject.securityType = "U";
							newSecurityObject.msgSecurityId = currUserId;
							newSecurityList.push(newSecurityObject);
						}
					}
				}
				
				if (!hasValidUser) {
					alert("please enter values for User ID.");
					return;
				}
			}
		}
	} else {
		alert("you must select 1 security type");
		return;
	}
	
	var updateObject = new Object();
	updateObject.message = newMessageObj;
	updateObject.securityList = newSecurityList;
	//alert("updateObject: " + JSON.stringify(updateObject));
	
	jQuery("#id_messageedit_savemessage_button").attr("disabled", "true");
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath+"/action/portal/messages/updateAdminMessage/"+localMessageEdit_Action+"?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(updateObject),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
	
		var flag = data.flag;
		var text = data.text;
		alert(text);
		
		if (flag == "1") {
		
			var message = data.message;
			var securityList = data.securityList;
		
			if (localMessageEdit_Action == "new") {
				localMessageEdit_Action = "update";
				localMessageEdit_MsgId = message.msgId;
				jQuery("#id_messageedit_id").val(message.msgId);
				jQuery("#id_messageedit_datetimeposted").val(message.dateTimeCreatedStr);
			}
			jQuery("#id_messageedit_datetimetoshow").val(message.startDateStr);
		}
		
		jQuery("#id_messageedit_savemessage_button").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_messageedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

/* function manageMessageCategory() {
	var url = localContextPath + "/action/portal/messages/messages_admin_categorylist";
	window.open(url,'_blank');
} */

var localCategoryEdit_MsgCategoryId;
var localCategoryEdit_Action;
var localCategoryEdit_SaveSuccess;
var selectedCategoryIdList;

function initCategoryListPageOverlay() {
	
	var overlayStr = "<div id='id_categorylist_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_categorylist_page_overlay_main").append(overlayStr);
	jQuery("#id_categorylist_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_categorylist_page_overlay");
}

function manageMessageCategory() {
	
	initCategoryListPageOverlay();
	initCategoryListPage();
}

function initCategoryListPage() {
	
	jQuery.get(
		localContextPath+"/action/portal/messages/getMessageAllCatogoryOrderByID/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
	)
	.done(function(data) {
		
		var overlayStr = "<div style='width: 95%; align: center; margin-left: auto; margin-right: auto;'>";
		overlayStr += "<div>";
		/* overlayStr += "<div>";
		overlayStr += "<h1 class='ibm-h1 ibm-light'>Manage categories</h1>";
		overlayStr += "</div>"; */
		overlayStr += "</div>";
		overlayStr += "<form id='categoryListForm' class='ibm-column-form' method='post'>";
		overlayStr += "<div>";
		overlayStr += "<input type='button' id='id_categorylist_addcategory_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='editCategory(\"newId\",\"new\")' value='Add category'/>&nbsp;";
		overlayStr += "<input type='button' id='id_categorylist_deletecategory_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='deleteCategory()' value='Delete categories'/>&nbsp;";
		overlayStr += "<input type='button' id='id_categorylist_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_categorylist_page_overlay\")' value='Close'/>";
		overlayStr += "</div>";
		overlayStr += "<div id='categoryListDiv'>";
		overlayStr += "</div>";
		overlayStr += "</form>";
		overlayStr += "<div>";
		overlayStr += "</div>";
		overlayStr += "</div>";
	
		jQuery("#id_categorylist_page_overlay").empty().append(overlayStr);
		
		var allCategoryList = data;
		initCategoryListDiv(allCategoryList);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_categorylist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function initCategoryListDiv(allCategoryList) {
	
	jQuery("#categoryListDiv").empty();
		
	if(allCategoryList == null || allCategoryList.length == 0) {
		jQuery("#categoryListDiv").append("Currently, there is not any message category.");
	} else {

		var allCategoryListLength = allCategoryList.length;
		var tableStr = "<div>";
		tableStr += "<table id='categoryTable' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='false'>";
		tableStr += "<thead><tr>";
		tableStr += "<th scope='col'></th>";
		tableStr += "<th scope='col'>Category ID</th>";
		tableStr += "<th scope='col'>Category description</th>";
		tableStr += "</tr></thead>";
		tableStr += "<tbody>";
		
		for (var i = 0; i < allCategoryListLength; i++) {

			var currentCategory = allCategoryList[i];

			tableStr += "<tr>";
			tableStr += "<td scope='row'><span class='ibm-checkbox-wrapper'><input id='id_categorylist_tr_" + currentCategory.msgCategoryId + "' name='category_checkbox_name' value='" + currentCategory.msgCategoryId + "' type='checkbox' class='ibm-styled-checkbox'></input>";
			tableStr += "<label for='id_categorylist_tr_" + currentCategory.msgCategoryId + "'><span class='ibm-access'>Select One</span></label></span></td>";
			tableStr += "<td><a onclick='editCategory(\""+currentCategory.msgCategoryId+"\",\"update\")' style='cursor: pointer'>" + currentCategory.msgCategoryId + "</a></td>";
			tableStr += "<td>" + currentCategory.msgCtgryDesc + "</td>";
			tableStr += "</tr>";
		}
		
		tableStr += "</tbody>";
		tableStr += "</table>";
		tableStr += "</div>";
		
		jQuery("#categoryListDiv").append(tableStr);
		jQuery("#categoryTable").DataTable({paging:false, searching:false, info:false});
		jQuery("#categoryTable").tablesrowselector();
	}
}

function deleteCategory() {
	
	var allCategoryCheckboxes = jQuery("[name='category_checkbox_name']");
	var allCategoryCheckboxesLength = allCategoryCheckboxes.length;
	var selectedIds = new Array();
	
	for (var i = 0; i < allCategoryCheckboxesLength; i++) {
		var currBox = allCategoryCheckboxes[i];
		if (currBox.checked) {
			var selectedId = jQuery(currBox).attr("value");
			selectedIds.push(selectedId);
		}
	}
	
	if (selectedIds.length > 0) {
		selectedCategoryIdList = selectedIds;
		IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_categorylist_page_overlay").getId(), true);
		IBMCore.common.widget.overlay.show("confirmation_deleteselectedcategory");
		jQuery("#selectedCategoryCount").text(selectedIds.length);
	} else {
		alert("please select one category to delete.");
	}
}

function deleteSelectedCategoryOk() {
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("confirmation_deleteselectedcategory").getId(), true);
	IBMCore.common.widget.overlay.show("id_categorylist_page_overlay");
	
	jQuery("#id_categorylist_deletecategory_button").attr("disabled", "true");
	
	var obj = jQuery.parseJSON('[]');
	
	for (var i = 0; i < selectedCategoryIdList.length; i++) {
		obj.push(jQuery.parseJSON('{"msgCategoryId":"' + selectedCategoryIdList[i] + '"}'));
	}
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/portal/messages/deleteMessageCategories?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var allCategoryList = data.allCategoryList;
		var text = data.text;
		alert(text);
		jQuery("#id_categorylist_deletecategory_button").removeAttr("disabled");
		initCategoryListDiv(allCategoryList)
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_categorylist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedCategoryCancel() {
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("confirmation_deleteselectedcategory").getId(), true);
	IBMCore.common.widget.overlay.show("id_categorylist_page_overlay");
}

function initCategoryEditPageOverlay() {
	
	var overlayStr = "<div id='id_categoryedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_categoryedit_page_overlay_main").append(overlayStr);
	jQuery("#id_categoryedit_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_categoryedit_page_overlay");
}

function editCategory(msgCategoryId, action) {

	localCategoryEdit_MsgCategoryId = msgCategoryId;
	localCategoryEdit_Action = action;
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_categorylist_page_overlay").getId(), true);

	initCategoryEditPageOverlay();
	
	var overlayStr = "<form id='categoryEditForm' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='categoryEditDiv'>";
	overlayStr += "<table>";
	overlayStr += "<tr><td>Category ID:<span class='ibm-required'>*</span></td><td><input type='text' id='id_categoryedit_categoryid' maxlength='2' size='8' readonly disabled></td></tr>";
	overlayStr += "<tr><td>Category description:<span class='ibm-required'>*</span></td><td><input type='text' id='id_categoryedit_categorydesc' maxlength='30' size='55'></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_categoryedit_savecategory_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='categoryedit_saveCategory()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_categoryedit_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='categoryedit_closeOverlay(\"id_categoryedit_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";
	
	if (localCategoryEdit_Action == "new") {
		
		jQuery("#id_categoryedit_page_overlay").empty().append(overlayStr);
		jQuery("#id_categoryedit_categoryid").removeAttr("disabled").removeAttr("readonly");
		
	} else if (localCategoryEdit_Action == "update") {
		jQuery.get(
			localContextPath+"/action/portal/messages/getAdminMessageCategoryOne/"+localCwaid+"/"+localUid+"/"+localCategoryEdit_MsgCategoryId+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			
			jQuery("#id_categoryedit_page_overlay").empty().append(overlayStr);
			
			var currentCategoryId = data.msgCategoryId;
			var currentCategoryDesc = data.msgCtgryDesc;
			
			jQuery("#id_categoryedit_categoryid").val(currentCategoryId);
			jQuery("#id_categoryedit_categorydesc").val(currentCategoryDesc);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_categoryedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		// nothing to do
	}
}

function categoryedit_saveCategory() {
	
	var newObject = new Object();
	
	if (localCategoryEdit_Action == "new") {
		var newId = jQuery("#id_categoryedit_categoryid").val();
		if (newId == null || newId.length < 1) {
			alert("Category ID cannot be empty. Please enter a value.");
			return;
		}
	
		var newDescription = jQuery("#id_categoryedit_categorydesc").val();
		if (newDescription == null || newDescription.length < 1) {
			alert("Category description cannot be empty. Please enter a value.");
			return;
		}
		
		newObject.msgCategoryId = newId;
		newObject.msgCtgryDesc = newDescription;
		
	} else if (localCategoryEdit_Action == "update") {
		var newDescription = jQuery("#id_categoryedit_categorydesc").val();
		if (newDescription == null || newDescription.length < 1) {
			alert("Category description cannot be empty. Please enter a value.");
			return;
		}
		
		newObject.msgCategoryId = localCategoryEdit_MsgCategoryId;
		newObject.msgCtgryDesc = newDescription;
		
	} else {
		// nothing to do
	}
	
	//alert("newObject: " + JSON.stringify(newObject));
	
	jQuery("#id_categoryedit_savecategory_button").attr("disabled", "true");
	if (localCategoryEdit_Action == "new") {
		jQuery("#id_categoryedit_categoryid").attr("disabled", true).attr("readonly", true);
	}
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath+"/action/portal/messages/updateAdminMessageCategory/"+localCategoryEdit_Action+"?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(newObject),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		
		var flag = data.flag;
		var text = data.text;
		
		if (localCategoryEdit_Action == "new") {
			if (flag == "1") {
				localCategoryEdit_Action = "update";
				localCategoryEdit_MsgCategoryId = newObject.msgCategoryId;
				localCategoryEdit_SaveSuccess = "Y";
			} else if (flag == "0") {
				jQuery("#id_categoryedit_categoryid").removeAttr("disabled").removeAttr("readonly");
			}
			alert(text);
		} else if (localCategoryEdit_Action == "update") {
			if (flag == "1") {
				localCategoryEdit_SaveSuccess = "Y";
			}
			alert(text);
		} else {
			// nothing to do
		}
		
		jQuery("#id_categoryedit_savecategory_button").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_categoryedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function categoryedit_closeOverlay(myOverId) {
	closeOverlay(myOverId);
	IBMCore.common.widget.overlay.show("id_categorylist_page_overlay");
	if (localCategoryEdit_SaveSuccess == "Y") {
		jQuery("#id_categorylist_page_overlay").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
		initCategoryListPage();
		localCategoryEdit_SaveSuccess = "N";
	}
}

/* function manageMessageType() {
	var url = localContextPath + "/action/portal/messages/messages_admin_typelist";
	window.open(url,'_blank');
} */

var localTypeEdit_MsgTypeId;
var localTypeEdit_Action;
var localTypeEdit_SaveSuccess;
var selectedTypeIdList;

function initTypeListPageOverlay() {
	
	var overlayStr = "<div id='id_typelist_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_typelist_page_overlay_main").append(overlayStr);
	jQuery("#id_typelist_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_typelist_page_overlay");
}

function manageMessageType() {
	
	initTypeListPageOverlay();
	initTypeListPage();
}

function initTypeListPage() {
	
	jQuery.get(
		localContextPath+"/action/portal/messages/getMessageAllTypeOrderByID/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
	)
	.done(function(data) {
		
		var overlayStr = "<form id='typeListForm' class='ibm-column-form' method='post'>";
		overlayStr += "<div>";
		overlayStr += "<input type='button' id='id_typelist_addtype_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='editType(\"newId\",\"new\")' value='Add type'/>&nbsp;";
		overlayStr += "<input type='button' id='id_typelist_deletetype_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='deleteType()' value='Delete types'/>&nbsp;";
		overlayStr += "<input type='button' id='id_typelist_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_typelist_page_overlay\")' value='Close'/>";
		overlayStr += "</div>";
		overlayStr += "<div id='typeListDiv'>";
		overlayStr += "</div>";
		overlayStr += "</form>";
		
		jQuery("#id_typelist_page_overlay").empty().append(overlayStr);

		var allTypeList = data;
		
		initTypeListDiv(allTypeList);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_typelist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function initTypeListDiv(allTypeList) {
	
	jQuery("#typeListDiv").empty();
		
	if(allTypeList == null || allTypeList.length == 0) {
		jQuery("#typeListDiv").append("Currently, there is not any message type.");
	} else {

		var allTypeListLength = allTypeList.length;
		var tableStr = "<div>";
		tableStr += "<table id='typeTable' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='false'>";
		tableStr += "<thead><tr>";
		tableStr += "<th scope='col'></th>";
		tableStr += "<th scope='col'>Type ID</th>";
		tableStr += "<th scope='col'>Type description</th>";
		tableStr += "<th scope='col'>Urgent</th>";
		tableStr += "</tr></thead>";
		tableStr += "<tbody>";
		
		for (var i = 0; i < allTypeListLength; i++) {

			var currentType = allTypeList[i];
			//alert(currentType.msgTypeId);

			tableStr += "<tr>";
			tableStr += "<td scope='row'><span class='ibm-checkbox-wrapper'><input id='id_typelist_tr_" + currentType.msgTypeId + "' name='type_checkbox_name' value='" + currentType.msgTypeId + "' type='checkbox' class='ibm-styled-checkbox'></input>";
			tableStr += "<label for='id_typelist_tr_" + currentType.msgTypeId + "'><span class='ibm-access'>Select One</span></label></span></td>";
			tableStr += "<td><a onclick='editType(\""+currentType.msgTypeId+"\",\"update\")' style='cursor: pointer'>" + currentType.msgTypeId + "</a></td>";
			tableStr += "<td>" + currentType.msgTypeDesc + "</td>";
			tableStr += "<td>" + currentType.urgent + "</td>";
			tableStr += "</tr>";
		}
		
		tableStr += "</tbody>";
		tableStr += "</table>";
		tableStr += "</div>";
		
		jQuery("#typeListDiv").append(tableStr);
		jQuery("#typeTable").DataTable({paging:false, searching:false, info:false});
		jQuery("#typeTable").tablesrowselector();
	}
}

function deleteType() {
	
	var allTypeCheckboxes = jQuery("[name='type_checkbox_name']");
	var allTypeCheckboxesLength = allTypeCheckboxes.length;
	var selectedIds = new Array();
	
	for (var i = 0; i < allTypeCheckboxesLength; i++) {
		var currBox = allTypeCheckboxes[i];
		if (currBox.checked) {
			var selectedId = jQuery(currBox).attr("value");
			selectedIds.push(selectedId);
		}
	}
	
	if (selectedIds.length > 0) {
		selectedTypeIdList = selectedIds;
		IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_typelist_page_overlay").getId(), true);
		IBMCore.common.widget.overlay.show("confirmation_deleteselectedtype");
		jQuery("#selectedTypeCount").text(selectedIds.length);
	} else {
		alert("please select one type to delete.");
	}
}

function deleteSelectedTypeOk() {
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("confirmation_deleteselectedtype").getId(), true);
	IBMCore.common.widget.overlay.show("id_typelist_page_overlay");
	
	jQuery("#id_typelist_deletetype_button").attr("disabled", "true");
	
	var obj = jQuery.parseJSON('[]');
	
	for (var i = 0; i < selectedTypeIdList.length; i++) {
		obj.push(jQuery.parseJSON('{"msgTypeId":"' + selectedTypeIdList[i] + '"}'));
	}
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/portal/messages/deleteMessageTypes?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var allTypeList = data.allTypeList;
		var text = data.text;
		alert(text);
		jQuery("#id_typelist_deletetype_button").removeAttr("disabled");
		initTypeListDiv(allTypeList)
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_typelist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedTypeCancel() {
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("confirmation_deleteselectedtype").getId(), true);
	IBMCore.common.widget.overlay.show("id_typelist_page_overlay");
}

function initTypeEditPageOverlay() {
	
	var overlayStr = "<div id='id_typeedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_typeedit_page_overlay_main").append(overlayStr);
	jQuery("#id_typeedit_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_typeedit_page_overlay");
}

function editType(msgTypeId, action) {

	localTypeEdit_MsgTypeId = msgTypeId;
	localTypeEdit_Action = action;
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_typelist_page_overlay").getId(), true);

	initTypeEditPageOverlay();
	
	var overlayStr = "<form id='typeEditForm' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='typeEditDiv'>";
	overlayStr += "<table>";
	overlayStr += "<tr><td>Type ID:<span class='ibm-required'>*</span></td><td><input type='text' id='id_typeedit_typeid' maxlength='2' size='8' readonly disabled></td></tr>";
	overlayStr += "<tr><td>Type description:<span class='ibm-required'>*</span></td><td><input type='text' id='id_typeedit_typedesc' maxlength='30' size='55'></td></tr>";
	overlayStr += "<tr><td>Urgent:</td>";
	overlayStr += "<td>";
	overlayStr += "<span class='ibm-checkbox-wrapper'>";
	overlayStr += "<input class='ibm-styled-checkbox' id='id_typeedit_urgent' type='checkbox'/><label for='id_typeedit_urgent' class='ibm-field-label'></label>";
	overlayStr += "</span>";
	overlayStr += "</td>";
	overlayStr += "</tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_typeeidt_savetype_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='typeedit_saveType()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_typeeidt_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='typeedit_closeOverlay(\"id_typeedit_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";
	
	if (localTypeEdit_Action == "new") {
		jQuery("#id_typeedit_page_overlay").empty().append(overlayStr);
		jQuery("#id_typeedit_typeid").removeAttr("disabled").removeAttr("readonly");
	} else if (localTypeEdit_Action == "update") {
		jQuery.get(
			localContextPath+"/action/portal/messages/getAdminMessageTypeOne/"+localCwaid+"/"+localUid+"/"+localTypeEdit_MsgTypeId+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			
			jQuery("#id_typeedit_page_overlay").empty().append(overlayStr);
			
			var currentTypeId = data.msgTypeId;
			var currentTypeDesc = data.msgTypeDesc;
			var currentUrgent = data.urgent;
			
			jQuery("#id_typeedit_typeid").val(currentTypeId);
			jQuery("#id_typeedit_typedesc").val(currentTypeDesc);
			
			if (currentUrgent == "Y") {
				jQuery("#id_typeedit_urgent").prop("checked", true);
			} else {
				jQuery("#id_typeedit_urgent").prop("checked", false);
			}
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_typeedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		// nothing to do
	}
}

function typeedit_saveType() {
	
	var newObject = new Object();
	
	if (localTypeEdit_Action == "new") {
		var newId = jQuery("#id_typeedit_typeid").val();
		if (newId == null || newId.length < 1) {
			alert("Type ID cannot be empty. Please enter a value.");
			return;
		}
	
		var newDescription = jQuery("#id_typeedit_typedesc").val();
		if (newDescription == null || newDescription.length < 1) {
			alert("Type description cannot be empty. Please enter a value.");
			return;
		}
		
		newObject.msgTypeId = newId;
		newObject.msgTypeDesc = newDescription;
		
		var newUrgentChecked = jQuery("#id_typeedit_urgent").prop("checked");
		if (newUrgentChecked) {
			newObject.urgent = "Y";
		} else {
			newObject.urgent = "N";
		}
	} else if (localTypeEdit_Action == "update") {
		var newDescription = jQuery("#id_typeedit_typedesc").val();
		if (newDescription == null || newDescription.length < 1) {
			alert("Type description cannot be empty. Please enter a value.");
			return;
		}
		
		newObject.msgTypeId = localTypeEdit_MsgTypeId;
		newObject.msgTypeDesc = newDescription;
		
		var newUrgentChecked = jQuery("#id_typeedit_urgent").prop("checked");
		if (newUrgentChecked) {
			newObject.urgent = "Y";
		} else {
			newObject.urgent = "N";
		}
	} else {
		// nothing to do
	}
	
	//alert("newObject: " + JSON.stringify(newObject));
	
	jQuery("#id_typeeidt_savetype_button").attr("disabled", "true");
	if (localTypeEdit_Action == "new") {
		jQuery("#id_typeedit_typeid").attr("disabled", true).attr("readonly", true);
	}
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath+"/action/portal/messages/updateAdminMessageType/"+localTypeEdit_Action+"?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(newObject),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		
		var flag = data.flag;
		var text = data.text;
		
		if (localTypeEdit_Action == "new") {
			if (flag == "1") {
				localTypeEdit_Action = "update";
				localTypeEdit_MsgTypeId = newObject.msgTypeId;
				localTypeEdit_SaveSuccess = "Y";
			} else if (flag == "0") {
				jQuery("#id_typeedit_typeid").removeAttr("disabled").removeAttr("readonly");
			}
			alert(text);
		} else if (localTypeEdit_Action == "update") {
			if (flag == "1") {
				localTypeEdit_SaveSuccess = "Y";
			}
			alert(text);
		} else {
			// nothing to do
		}
		
		jQuery("#id_typeeidt_savetype_button").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_typeedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function typeedit_closeOverlay(myOverId) {
	closeOverlay(myOverId);
	IBMCore.common.widget.overlay.show("id_typelist_page_overlay");
	if (localTypeEdit_SaveSuccess == "Y") {
		jQuery("#id_typelist_page_overlay").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
		initTypeListPage();
		localTypeEdit_SaveSuccess = "N";
	}
}

/* function manageMessageRoleGroup() {
	var url = localContextPath + "/action/portal/messages/messages_admin_rolegrouplist";
	window.open(url,'_blank');
} */

var localRolegroupEdit_MsgGroupId;
var localRolegroupEdit_Action;
var localRolegroupEdit_SaveSuccess;
var selectedRolegroupIdList;

function initRolegroupListPageOverlay() {
	
	var overlayStr = "<div id='id_rolegrouplist_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_rolegrouplist_page_overlay_main").append(overlayStr);
	jQuery("#id_rolegrouplist_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_rolegrouplist_page_overlay");
}

function manageMessageRoleGroup() {
	
	initRolegroupListPageOverlay();
	initRolegroupListPage();
}

function initRolegroupListPage() {

	jQuery.get(
		localContextPath+"/action/portal/messages/getMessageAllGroupOrderByID/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
	)
	.done(function(data) {
	
		var overlayStr = "<form id='rolegroupListForm' class='ibm-column-form' method='post'>";
		overlayStr += "<div>";
		overlayStr += "<input type='button' id='id_rolegrouplist_addrolegroup_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='editRolegroup(\"newId\",\"new\")' value='Add group'/>&nbsp;";
		overlayStr += "<input type='button' id='id_rolegrouplist_deleterolegroup_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='deleteRolegroup()' value='Delete groups'/>&nbsp;";
		overlayStr += "<input type='button' id='id_rolegrouplist_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='closeOverlay(\"id_rolegrouplist_page_overlay\")' value='Close'/>";
		overlayStr += "</div>";
		overlayStr += "<div id='rolegroupListDiv'>";
		overlayStr += "</div>";
		overlayStr += "</form>";
		
		jQuery("#id_rolegrouplist_page_overlay").empty().append(overlayStr);
		
		var allRolegroupList = data;
		initRolegroupListDiv(allRolegroupList);
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_rolegrouplist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function initRolegroupListDiv(allRolegroupList) {
	
	jQuery("#rolegroupListDiv").empty();
		
	if(allRolegroupList == null || allRolegroupList.length == 0) {
		jQuery("#rolegroupListDiv").append("Currently, there is not any message role group.");
	} else {

		var allRolegroupListLength = allRolegroupList.length;
		var tableStr = "<div>";
		tableStr += "<table id='rolegroupTable' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='false'>";
		tableStr += "<thead><tr>";
		tableStr += "<th scope='col'></th>";
		tableStr += "<th scope='col'>Group ID</th>";
		tableStr += "<th scope='col'>Group description</th>";
		tableStr += "</tr></thead>";
		tableStr += "<tbody>";
		
		for (var i = 0; i < allRolegroupListLength; i++) {

			var currentRolegroup = allRolegroupList[i];

			tableStr += "<tr>";
			tableStr += "<td scope='row'><span class='ibm-checkbox-wrapper'><input id='id_rolegrouplist_tr_" + currentRolegroup.msgGroupId + "' name='rolegroup_checkbox_name' value='" + currentRolegroup.msgGroupId + "' type='checkbox' class='ibm-styled-checkbox'></input>";
			tableStr += "<label for='id_rolegrouplist_tr_" + currentRolegroup.msgGroupId + "'><span class='ibm-access'>Select One</span></label></span></td>";
			tableStr += "<td><a onclick='editRolegroup(\""+currentRolegroup.msgGroupId+"\",\"update\")' style='cursor: pointer'>" + currentRolegroup.msgGroupId + "</a></td>";
			tableStr += "<td>" + currentRolegroup.msgGroupDesc + "</td>";
			tableStr += "</tr>";
		}
		
		tableStr += "</tbody>";
		tableStr += "</table>";
		tableStr += "</div>";
		
		jQuery("#rolegroupListDiv").append(tableStr);
		jQuery("#rolegroupTable").DataTable({paging:false, searching:false, info:false});
		jQuery("#rolegroupTable").tablesrowselector();
	}
}

function deleteRolegroup() {
	
	var allRolegroupCheckboxes = jQuery("[name='rolegroup_checkbox_name']");
	var allRolegroupCheckboxesLength = allRolegroupCheckboxes.length;
	var selectedIds = new Array();
	
	for (var i = 0; i < allRolegroupCheckboxesLength; i++) {
		var currBox = allRolegroupCheckboxes[i];
		if (currBox.checked) {
			var selectedId = jQuery(currBox).attr("value");
			selectedIds.push(selectedId);
		}
	}
	
	if (selectedIds.length > 0) {
		selectedRolegroupIdList = selectedIds;
		IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_rolegrouplist_page_overlay").getId(), true);
		IBMCore.common.widget.overlay.show("confirmation_deleteselectedrolegroup");
		jQuery("#selectedRolegroupCount").text(selectedIds.length);
	} else {
		alert("please select one role group to delete.");
	}
}

function deleteSelectedRolegroupOk() {
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("confirmation_deleteselectedrolegroup").getId(), true);
	IBMCore.common.widget.overlay.show("id_rolegrouplist_page_overlay");
	
	jQuery("#id_rolegrouplist_deleterolegroup_button").attr("disabled", "true");
	
	var obj = jQuery.parseJSON('[]');
	
	for (var i = 0; i < selectedRolegroupIdList.length; i++) {
		obj.push(jQuery.parseJSON('{"msgGroupId":"' + selectedRolegroupIdList[i] + '"}'));
	}
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath + "/action/portal/messages/deleteMessageGroups?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		var allRolegroupList = data.allRolegroupList;
		var text = data.text;
		alert(text);
		jQuery("#id_rolegrouplist_deleterolegroup_button").removeAttr("disabled");
		initRolegroupListDiv(allRolegroupList)
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_rolegrouplist_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function deleteSelectedRolegroupCancel() {
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("confirmation_deleteselectedrolegroup").getId(), true);
	IBMCore.common.widget.overlay.show("id_rolegrouplist_page_overlay");
}

function initRolegroupEditPageOverlay() {
	
	var overlayStr = "<div id='id_rolegroupedit_page_overlay' class='ibm-common-overlay ibm-overlay-alt-two' data-widget='overlay' data-type='alert'>";
	overlayStr += "<img src='"+localContextPath+"/images/ajax-loader.gif' />";
	overlayStr += "</div>";

	jQuery("#id_rolegroupedit_page_overlay_main").append(overlayStr);
	jQuery("#id_rolegroupedit_page_overlay").overlay();
	IBMCore.common.widget.overlay.show("id_rolegroupedit_page_overlay");
}

function editRolegroup(msgGroupId, action) {

	localRolegroupEdit_MsgGroupId = msgGroupId;
	localRolegroupEdit_Action = action;
	
	IBMCore.common.widget.overlay.hide(IBMCore.common.widget.overlay.getWidget("id_rolegrouplist_page_overlay").getId(), true);

	initRolegroupEditPageOverlay();
	
	var overlayStr = "<form id='rolegroupEditForm' class='ibm-column-form' method='post'>";
	overlayStr += "<div id='rolegroupEditDiv'>";
	overlayStr += "<table>";
	overlayStr += "<tr><td>Group ID:<span class='ibm-required'>*</span></td><td><input type='text' id='id_rolegroupedit_rolegroupid' maxlength='10' size='20' readonly disabled></td></tr>";
	overlayStr += "<tr><td>Group description:<span class='ibm-required'>*</span></td><td><input type='text' id='id_rolegroupedit_rolegroupdesc' maxlength='254' size='80'></td></tr>";
	overlayStr += "<tr><td style='vertical-align:top;'>Group roles:<span class='ibm-required'>*</span></td><td><div id='id_rolegroupedit_role'></div></td></tr>";
	overlayStr += "</table>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<div></div>";
	overlayStr += "<input type='button' id='id_rolegroupedit_saverolegroup_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='rolegroupedit_saveRolegroup()' value='Submit'/>&nbsp;";
	overlayStr += "<input type='button' id='id_rolegroupedit_close_button' class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50' onclick='rolegroupedit_closeOverlay(\"id_rolegroupedit_page_overlay\")' value='Close'/>";
	overlayStr += "</div>";
	overlayStr += "</form>";
	
	if (localRolegroupEdit_Action == "new") {
		
		jQuery.get(
			localContextPath+"/action/portal/messages/getAdminMessageAllSectroles/"+localCwaid+"/"+localUid+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			
			jQuery("#id_rolegroupedit_page_overlay").empty().append(overlayStr);
			jQuery("#id_rolegroupedit_rolegroupid").removeAttr("disabled").removeAttr("readonly");
			
			var allRoleList = data;
			
			var sectStr = "<select multiple='multiple' id='id_rolegroupedit_role_select' name='rolegroupedit_role_select' size='12'>";
			var allRoleListLength = allRoleList.length;
			for (var i = 0; i < allRoleListLength; i++) {
				var currRole = allRoleList[i];
				sectStr += "<option value='" + currRole.roleName + "'>" + currRole.roleName + "</option>";
			}
			sectStr += "</select>";
			
			jQuery("#id_rolegroupedit_role").append(sectStr);
			
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_rolegroupedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else if (localRolegroupEdit_Action == "update") {
		
		jQuery.get(
			localContextPath+"/action/portal/messages/getAdminMessageRolegroupOne/"+localCwaid+"/"+localUid+"/"+localRolegroupEdit_MsgGroupId+"?timeid="+(new Date()).valueOf()
		)
		.done(function(data) {
			
			jQuery("#id_rolegroupedit_page_overlay").empty().append(overlayStr);
			
			var group = data.group;
			var groupRoles = data.groupRoles;
			var allRoleList = data.allRoleList;
		
			jQuery("#id_rolegroupedit_rolegroupid").val(group.msgGroupId);
			jQuery("#id_rolegroupedit_rolegroupdesc").val(group.msgGroupDesc);
			
			var sectStr = "<select multiple='multiple' id='id_rolegroupedit_role_select' name='rolegroupedit_role_select' size='12'>";
			var allRoleListLength = allRoleList.length;
			var groupRolesLength = groupRoles.length;
			for (var i = 0; i < allRoleListLength; i++) {
				var currRole = allRoleList[i];
				var j = 0;
				for (; j < groupRolesLength; j++) {
					var currGroupRole = groupRoles[j];
					if (currRole.roleName == currGroupRole.msgRoleName) {
						sectStr += "<option value='" + currRole.roleName + "' selected>" + currRole.roleName + "</option>";
						break;
					}
				}
				
				if (j == groupRolesLength) {
					sectStr += "<option value='" + currRole.roleName + "'>" + currRole.roleName + "</option>";
				}
			}
			sectStr += "</select>";
			
			jQuery("#id_rolegroupedit_role").append(sectStr);
		})
		.fail(function(jqXHR, textStatus, errorThrown) {
			jQuery("#id_rolegroupedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
			console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
			console.log(		"ajax error in loading...textStatus..."	+textStatus); 
			console.log(		"ajax error in loading...errorThrown..."+errorThrown);
		})
	} else {
		// nothing to do
	}
}

function rolegroupedit_saveRolegroup() {
	
	var newObject = new Object();
	
	if (localRolegroupEdit_Action == "new") {
		var newId = jQuery("#id_rolegroupedit_rolegroupid").val();
		if (newId == null || newId.length < 1) {
			alert("Group ID cannot be empty. Please enter a value.");
			return;
		}
	
		var newDescription = jQuery("#id_rolegroupedit_rolegroupdesc").val();
		if (newDescription == null || newDescription.length < 1) {
			alert("Group description cannot be empty. Please enter a value.");
			return;
		}
		
		var newGrouproleList = new Array();
		var roleOptions = jQuery("#id_rolegroupedit_role_select").val();
		if (roleOptions == null || roleOptions.length == 0) {
			alert("you must select at least one in Group roles options");
			return;
		} else {
			for (var i = 0; i < roleOptions.length; i++) {
				var newGrouprole = new Object();
				newGrouprole.cuuid = 0;
				newGrouprole.msgGroupId = newId;
				newGrouprole.msgRoleName = roleOptions[i];
				newGrouproleList.push(newGrouprole);
			}
		}
		
		newObject.msgGroupId = newId;
		newObject.msgGroupDesc = newDescription;
		
	} else if (localRolegroupEdit_Action == "update") {
		var newDescription = jQuery("#id_rolegroupedit_rolegroupdesc").val();
		if (newDescription == null || newDescription.length < 1) {
			alert("Group description cannot be empty. Please enter a value.");
			return;
		}
		
		var newGrouproleList = new Array();
		var roleOptions = jQuery("#id_rolegroupedit_role_select").val();
		if (roleOptions == null || roleOptions.length == 0) {
			alert("you must select at least one in Group roles options");
			return;
		} else {
			for (var i = 0; i < roleOptions.length; i++) {
				var newGrouprole = new Object();
				newGrouprole.cuuid = 0;
				newGrouprole.msgGroupId = localRolegroupEdit_MsgGroupId;
				newGrouprole.msgRoleName = roleOptions[i];
				newGrouproleList.push(newGrouprole);
			}
		}
		
		newObject.msgGroupId = localRolegroupEdit_MsgGroupId;
		newObject.msgGroupDesc = newDescription;
		
	} else {
		// nothing to do
	}
	
	var updateObject = new Object();
	updateObject.group = newObject;
	updateObject.groupRoles = newGrouproleList;
	//alert("updateObject: " + JSON.stringify(updateObject));
	
	jQuery("#id_rolegroupedit_saverolegroup_button").attr("disabled", "true");
	if (localRolegroupEdit_Action == "new") {
		jQuery("#id_rolegroupedit_rolegroupid").attr("disabled", true).attr("readonly", true);
	}
	
	jQuery.ajax({
		type : "POST",
		url : localContextPath+"/action/portal/messages/updateAdminMessageRolegroup/"+localRolegroupEdit_Action+"?timeid="+(new Date()).valueOf(),
		data : JSON.stringify(updateObject),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(data) {
		
		var flag = data.flag;
		var text = data.text;
		
		if (localRolegroupEdit_Action == "new") {
			if (flag == "1") {
				localRolegroupEdit_Action = "update";
				localRolegroupEdit_MsgGroupId = newObject.msgGroupId;
				localRolegroupEdit_SaveSuccess = "Y";
			} else if (flag == "0") {
				jQuery("#id_rolegroupedit_rolegroupid").removeAttr("disabled").removeAttr("readonly");
			}
			alert(text);
		} else if (localRolegroupEdit_Action == "update") {
			if (flag == "1") {
				localRolegroupEdit_SaveSuccess = "Y";
			}
			alert(text);
		} else {
			// nothing to do
		}
		
		jQuery("#id_rolegroupedit_saverolegroup_button").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown) {
		jQuery("#id_rolegroupedit_page_overlay").empty().append("<p>Failed to load, please try later. </p>");
		console.log(		"ajax error in loading...jqXHR..."		+JSON.stringify(jqXHR)); 
		console.log(		"ajax error in loading...textStatus..."	+textStatus); 
		console.log(		"ajax error in loading...errorThrown..."+errorThrown);
	})
}

function rolegroupedit_closeOverlay(myOverId) {
	closeOverlay(myOverId);
	IBMCore.common.widget.overlay.show("id_rolegrouplist_page_overlay");
	if (localRolegroupEdit_SaveSuccess == "Y") {
		jQuery("#id_rolegrouplist_page_overlay").empty().append("<img src='"+localContextPath+"/images/ajax-loader.gif' />");
		initRolegroupListPage();
		localRolegroupEdit_SaveSuccess = "N";
	}
}

function showResponseMessage(message) {
    var myOverlay = IBMCore.common.widget.overlay.createOverlay({
        contentHtml: '<p>' + message + '</p>',
        classes: 'ibm-common-overlay ibm-overlay-alt'
    });
    myOverlay.init();
    myOverlay.show();
}

</script>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>