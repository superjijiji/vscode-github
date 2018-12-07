<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM Portal Message Subscription Service</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-columns">
		<div class="ibm-card">
			<div class="ibm-card__content">
				<strong class="ibm-h4">Messages</strong>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				<b>BI@IBM Portal Message Subscription Service</b><br>
				<p>
					In order to use this feature you must be a registered user of the
					BI@IBM application. Please click <a
						href="http://w3-03.ibm.com/transform/worksmart/docs/Applying+for+access.html"
						target="_blank"><b>here</b></a> for information on how to request
					access if you are not already registered.<br> This service
					sends an e-mail notification when new Messages are posted to the
					BI@IBM Portal. A note will be sent to the Lotus Notes e-mail
					address that matches your internet user id.<br> To subscribe,
					use the checkboxes to select items to be mailed. Select any
					combination of BI@IBM portal report application(s) (the left
					column) and message tabs (across the top). To select all messages
					for a report application, click the check box to the left of it.
					When done, click the Update subscriptions button at the bottom to
					save them and then on the Back to BI@IBM home link or the Restore
					option in the Portlet menu.<br> When you return to this page,
					your current subscriptions will be shown.<br> Note that the
					Reset button will restore your subscription selections to their
					last saved state.
				</p>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				<form id="messages_subscribesform" class="ibm-column-form"
					method="post"></form>
				<br>
				<button id="messages_subscribes_savebutton"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="messages_subscribes_save()">Update subscriptions</button>
				<button id="messages_subscribes_checkall"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="messages_subscribes_checkall()">Check all</button>
				<button id="messages_subscribes_uncheckall"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="messages_subscribes_uncheckall()">Uncheck all</button>
				<button id="messages_subscribes_reset"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="messages_subscribes_reset()">Reset</button>
				<br> <br>
				<a href="<%=request.getContextPath()%>/">&lt;&nbsp;Back to
					BI@IBM home</a>
			</div>
		</div>
	</div>

	<!-- Alert success or fail message -->
	<div class="lpinvite-con ibm-access" id="messages_subscribes_alertdiv">
		<div class="lpinvite-close">
			<button onclick="messages_subscribes_hidealert()" aria-label="Close">X</button>
		</div>
		<p class="lpinvite-heading">Alert</p>
		<p id="messages_subscribes_alert"></p>
	</div>
	<script type="text/javascript">
// saved all messages cetegory list
var messages_subscribes_categories;
// saved all messages types. 
var messages_subscribes_typelist;
// saved user subscriptions. 
var messages_subscribes_subscribeslist;

// initialize messages subscriptions. 
jQuery(document).ready(
	function() {
		var timeid = (new Date()).valueOf();
		jQuery.ajax({type:"GET",
			url:"<%= request.getContextPath()%>/action/portal/messages/getMessageSubscribes?timeid=" + timeid,
			success : function(data) {
				//alert("hello, message subscribes!");
				
				// get category/type/subscription from data MAP. 
				messages_subscribes_categorylist = data["MSGCTGRY"];
				messages_subscribes_typelist = data["MSGTYPE"];
				messages_subscribes_subscribeslist = data["SUBSUCTS"];
				
				//alert("messages_subscribes_categorylist.length=" + messages_subscribes_categorylist.length);
				//alert("messages_subscribes_typelist.length=" + messages_subscribes_typelist.length);
				//alert("messages_subscribes_subscribeslist.length=" + messages_subscribes_subscribeslist.length);
				
				// nothing to do when there is not any category or type. 
				if (messages_subscribes_categorylist != null && messages_subscribes_categorylist.length > 0 && messages_subscribes_typelist != null && messages_subscribes_typelist.length > 0) {
				
					// create checkbox table. 
					var tablestr = "<table class='ibm-data-table ibm-padding-small' style='width: 90%'>";
					tablestr += "<thead>";
					tablestr += "<tr>";
					tablestr += "<th scope='col'></th>";
					
					// create checkbox table head - list all categories. 
					for (var i = 0; i < messages_subscribes_categorylist.length; i++) {
						
						tablestr += "<th scope='col'>" + messages_subscribes_categorylist[i].msgCtgryDesc + "</th>";
					}
					
					tablestr += "</tr>";
					tablestr += "</thead>";
					tablestr += "<tbody>";
					
					for (var j = 0; j < messages_subscribes_typelist.length; j++) {
						
						tablestr += "<tr>";
						// create checkbox for select current row all. 
						tablestr += "<td scope='row'><input type='checkbox' data-init='false' class='ibm-styled-checkbox' name='messages_subscribesrows' id='messages_subscribes_row_typeid_" + messages_subscribes_typelist[j].msgTypeId + "' value='" + messages_subscribes_typelist[j].msgTypeId + "'/>";
						tablestr += "<label for='messages_subscribes_row_typeid_" + messages_subscribes_typelist[j].msgTypeId + "'>" + messages_subscribes_typelist[j].msgTypeDesc + "</label></td>";
						
						// create category checkbox for current type row. 
						for (var k = 0; k < messages_subscribes_categorylist.length; k++) {
							
							tablestr += "<td><input type='checkbox' data-init='false' class='ibm-styled-checkbox' name='messages_subscribescheckboxes' id='messages_subscribescheckbox_" + messages_subscribes_categorylist[k].msgCategoryId + "_" + messages_subscribes_typelist[j].msgTypeId + "' value='" + messages_subscribes_categorylist[k].msgCategoryId + "*" + messages_subscribes_typelist[j].msgTypeId + "'/>";
							tablestr += "<label style='padding-left: 0px; padding-right: 0px;' for='messages_subscribescheckbox_" + messages_subscribes_categorylist[k].msgCategoryId + "_" + messages_subscribes_typelist[j].msgTypeId + "'></label></td>";
						}
						
						tablestr += "</tr>";
					}
					
					tablestr += "</tbody>";
					tablestr += "</table>";
					
					// add all message categories and types checkbox into form. 
					jQuery("#messages_subscribesform").append(jQuery(tablestr));
					
					// add function for type checkbox in each row. Select all for current row. 
					for (var m = 0; m < messages_subscribes_typelist.length; m++) {
						
						jQuery("#messages_subscribes_row_typeid_" + messages_subscribes_typelist[m].msgTypeId).on("change", function () {
			            	messages_type_rowselectall(jQuery(this).attr("value"), jQuery(this).prop("checked"));
			        	});
					}
					
					// add user current subscriptions into each checkbox. 
					initselectcheckboxes();
				}
			}
		})
	}
)

// select all for current row.
function messages_type_rowselectall(rowtypeid, ckd)
{
	jQuery("#messages_subscribes_row_typeid_" + rowtypeid).parent().siblings().children(".ibm-styled-checkbox").prop("checked", ckd);
	
	/*
	if (messages_subscribes_categorylist != null && messages_subscribes_categorylist.length > 0 && messages_subscribes_typelist != null && messages_subscribes_typelist.length > 0) {
	
		for (var i = 0; i < messages_subscribes_categorylist.length; i++) {
			jQuery("#messages_subscribescheckbox_" + messages_subscribes_categorylist[i].msgCategoryId + "_" + rowtypeid).prop("checked", ckd);
		}
	}
	*/
}

// add user current subscriptions into each checkbox.
function initselectcheckboxes()
{
	if (messages_subscribes_subscribeslist != null && messages_subscribes_subscribeslist.length > 0) {
		
		if (messages_subscribes_subscribeslist[0].categoryId == null || messages_subscribes_subscribeslist[0].categoryId == "") {
			// nothing to do, does not need to insert any subscribes data since user do not select any checkbox. subscribes[0] is an empty object, it's only used as a flag.
		} else {
			
			for (var n = 0; n < messages_subscribes_subscribeslist.length; n++) {
				
				var selectedCheckbox = jQuery("#messages_subscribescheckbox_" + messages_subscribes_subscribeslist[n].categoryId + "_" + messages_subscribes_subscribeslist[n].typeId);
				
				if (selectedCheckbox.length == 0) {
					// nothing to do since this checkbox doesn't exist. 
				} else {
					selectedCheckbox.prop("checked", true);
				}
			}
		}
	}
}

// reset button. selected checkbox are reset as user subscriptions. 
function messages_subscribes_reset()
{
	messages_subscribes_uncheckall();
	initselectcheckboxes();
}

// checkall button. all checkbox are checked. 
function messages_subscribes_checkall()
{
	//alert("Checkall");
	jQuery(".ibm-styled-checkbox").prop("checked", true);
}

// uncheckall button. all checkbox are un-checked. 
function messages_subscribes_uncheckall()
{
	//alert("Uncheckall");
	jQuery(".ibm-styled-checkbox").prop("checked", false);
}

// saved user selected subscriptions. 
function messages_subscribes_save()
{
	messages_subscribes_hidealert();
	
	// disabled Update subscriptions button, so user won't click button twice to submit again before saved into db. 
	jQuery("#messages_subscribes_savebutton").attr("disabled", "true");
	
	var allformdata = jQuery("#messages_subscribesform").serialize();
	//alert(allformdata);
	
	var selectedlist = jQuery.parseJSON('[]');
	
	// created a json object to save all selected checkbox information. 
	if (allformdata == null || allformdata == "") {
		
		// need to delete all data in db in table eod.subsucts for this uid.
		selectedlist.push(jQuery.parseJSON('{"categoryId":"","typeId":""}'));
		
	} else {
	
		var datalist = allformdata.split("&");
		
		var validcheckboxcount = 0;
		
		for (var i = 0; i < datalist.length; i++) {
			
			var currentCheckbox = datalist[i];
			
			if (currentCheckbox.indexOf("*") == -1) {
				//nothing to do since it's the first column checkbox for select all checkbox in this row. 
			} else {
				validcheckboxcount ++;
				var categoryId = currentCheckbox.substring(currentCheckbox.indexOf("=") + 1, currentCheckbox.indexOf("*"));
				var typeId = currentCheckbox.substring(currentCheckbox.indexOf("*") + 1);
				selectedlist.push(jQuery.parseJSON('{"categoryId":"' + categoryId + '","typeId":"' + typeId + '"}'));
			}
		}
		
		if (validcheckboxcount == 0) {
			selectedlist.push(jQuery.parseJSON('{"categoryId":"","typeId":""}'));
		}
	}
	
	var timeid = (new Date()).valueOf();
	
	jQuery.ajax({
		type : "POST",
		url : "<%=request.getContextPath()%>/action/portal/messages/saveMessageSubscribes?timeid=" + timeid,
		data : JSON.stringify(selectedlist),
		contentType : "application/json",
		dataType : "json",
	})
	.done(function(){
		//alert("message subscribe success");
		jQuery("#messages_subscribes_alert").text("Subscription is updated successfully.");
		messages_subscribes_showalert();
		// saved current selected checkbox for reset function. 
		messages_subscribes_subscribeslist = selectedlist;
		// enabled Updated subscriptions button after data is saved into DB successfully. 
		jQuery("#messages_subscribes_savebutton").removeAttr("disabled");
	})
	.fail(function(jqXHR, textStatus, errorThrown){
		jQuery("#messages_subscribes_alert").text("Failed to update subscriptions, please re-submit, or try it later.");
		jQuery("#messages_subscribes_savebutton").removeAttr("disabled");
		console.log("link_error4loading...jqXHR..."			+JSON.stringify(jqXHR)); 
		console.log("link_error4loading...textStatus..."	+textStatus); 
		console.log("link_error4loading...errorThrown..."	+errorThrown);
	})
}

// hidden alert message. 
function messages_subscribes_hidealert()
{
	jQuery("#messages_subscribes_alertdiv").addClass("ibm-access");
}

// show alert message. 
function messages_subscribes_showalert()
{
	jQuery("#messages_subscribes_alertdiv").removeClass("ibm-access");
}
</script>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>