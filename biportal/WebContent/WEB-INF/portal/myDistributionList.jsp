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
<title>BI@IBM | My distribution lists</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<style type="text/css">
table.dataTable thead .sorting, table.dataTable thead .sorting_asc,
	table.dataTable thead .sorting_desc {
	background-repeat: no-repeat;
	background-position: center right
}

table.dataTable thead .selectallcolumn {
	background-repeat: no-repeat;
	background-position: 1000px;
	width: 1px;
}

table.dataTable thead .sorting {
	background: none
}
</style>
<script type="text/javascript" src="<%=path%>/javascript/mydistbean.js"></script>


<script type="text/javascript">
                    var cwa_id = '${requestScope.cwa_id}';
                    var uid = '${requestScope.uid}';

                    var myDistSettings = {
                        colReorder: false, // true | false (default)   // Let the user reorder columns (not persistent) 
                        info: false, // true | false (default)   // Shows "Showing 1-10" texts 
                        ordering: true, // true | false (default)   // Enables sorting 
                        paging: false, // true | false (default)   // Enables pagination 
                        scrollaxis: true, // x   // Allows horizontal scroll 
                        searching: false //true | false (default)   // Enables text filtering	
                    };

                    var dist_selected_str = '';
                    var dist_selected_list;
                    var dist_name_list = new DistbeanList();
                    
                    function callMyDistList() {
                        var timeid = (new Date()).valueOf();
                        jQuery("#distmanager_root_checkbox").removeAttr("checked");
                        var table_content = jQuery("#dist_manager_root_table").DataTable();

                        dist_name_list.empty();
                        jQuery("#dist_manager_tbody").empty();
                        jQuery("#dist_manager_tbody").html("<tr><td colspan=\"6\"><span><Strong>loading...</Strong></span></td></tr>");
                        jQuery.ajax({
                            type: 'GET',
                            url: '<%=path%>/action/portal/mydistlist/getMyDistList/'
							+ cwa_id + '/' + uid + '?timeid=' + timeid,
						timeout : 30000,
						success : function(data) {
						table_content.rows().remove();
						if (data.length > 0) {
							for (var i = 0; i < data.length; i++) {
								var distbean = new DistBean(data[i]);
								dist_name_list.addDistBean(distbean);
								var input_col_0 = '';
								input_col_0 += "<input id='dist_manage_" + distbean.distName + "_checkbox' distID='" + distbean.distName + "' type='checkbox' name='dist_checkbox' class='ibm-styled-checkbox manager_dist_checkbox'>";
								input_col_0 += "<label for='dist_manage_" + distbean.distName + "_checkbox'>";
								input_col_0 += "<span class='ibm-access'>Select one</span></label>";
								input_col_0 += "</input>";

								var input_col_1 = "<A href=\"#\" id='labelForDist_"+i+"' onClick=\"loadDist('"
										+ distbean.distName
										+ "'); return 0;\">"
										+ distbean.distName + "</A>";

								var input_col_2 = distbean.inUse;
								//
								var dataSet = [ input_col_0, input_col_1,
										input_col_2 ]
								table_content.row.add(dataSet).draw();
								jQuery(table_content.row(i).node()).attr('id',
										'id_' + distbean.distName);
							}

							jQuery(".manager_dist_checkbox").click(
									function() {

										var thisID = jQuery(this)
												.attr("distID");

										if (jQuery(this).prop("checked")) {
											jQuery("#id_" + thisID).css(
													"background-color",
													"#c0e6ff");
										} else {
											if (jQuery("#id_" + thisID).prop(
													"class") == "odd") {
												jQuery("#id_" + thisID).css(
														"background-color",
														"#fff");
											} else {
												jQuery("#id_" + thisID).css(
														"background-color",
														"#ececec");
											}
										}

									});

						} else {
							table_content.rows().remove();
							jQuery("#dist_manager_tbody").empty();
							jQuery("#dist_manager_tbody")
									.html(
											"<tr><td colspan=\"6\"><span><Strong>No contents</Strong></span></td></tr>");
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						table_content.rows().remove();
						jQuery("#dist_manager_tbody").empty();
						jQuery("#dist_manager_tbody")
								.html(
										"<tr><td colspan=\"6\"><span><Strong>An error has occurred. Please try again later.</strong></span></td></tr>");
						jQuery("#createButtonId").val('Create a List');
						jQuery("#createButtonId").removeAttr('disabled');
					}
				});
	}

	// ============== create dist Action ======
	function createDist()
	{
		// after verification above, then could create dist
		 if (!verifyAction()) {
         	return;
		}
		
		var newDistName = jQuery("#id_input_dist_name").val();
		var newEmailAddrStr = jQuery("#id_email_ids").val();
		var isCreate = true;
		
		var jsonData = {};
		var formToJson = jQuery("#my_dist_form").serializeArray();
        for (var i = 0; i < formToJson.length; i++) {
        	jsonData[formToJson[i].name] = formToJson[i].value || '';
		}
        console.log(jsonData);
        
        var buttonValue = jQuery("#createButtonId").val();
        if(buttonValue=='Update'){
        	isCreate = false;
        	console.log("The button is for updating now.");
        }
        if(isCreate){
	        jQuery("#createButtonId").attr('disabled', true);
	        jQuery("#createButtonId").val('Submitting...');                    
			jQuery.ajax({
				type: 'POST',
				url: '<%=path%>/action/portal/mydistlist/createMyDistList',
				data : JSON.stringify(jsonData),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					alert(data);
					var returnStr = data;
					if(returnStr.indexOf("Failed")!=-1){
						jQuery("#createButtonId").val('Create a List');
						jQuery("#createButtonId").removeAttr('disabled');
					}else{
						restForm();
						callMyDistList();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert("Failed to create dist:" + XMLHttpRequest.status
							+ ",error message:" + textStatus);
					jQuery("#createButtonId").val('Create a List');
					jQuery("#createButtonId").removeAttr('disabled');
				}
			});
		}else{
			jQuery("#createButtonId").attr('disabled', true);
	        jQuery("#createButtonId").val('Updating...');                    
			jQuery.ajax({
				type: 'POST',
				url: '<%=path%>/action/portal/mydistlist/updateMyDistList',
				data : JSON.stringify(jsonData),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					alert(data);
					var returnStr = data;
					if(returnStr.indexOf("Failed")!=-1){
						jQuery("#createButtonId").val('Update');
						jQuery("#createButtonId").removeAttr('disabled');
					}else{
						restForm();
						callMyDistList();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert("Failed to update dist:" + XMLHttpRequest.status
							+ ",error message:" + textStatus);
					jQuery("#createButtonId").val('Create a List');
					jQuery("#createButtonId").removeAttr('disabled');
					jQuery("#id_input_dist_name").removeAttr('readonly');
				}
			});
		}

	}

	function restForm() {

		jQuery("#my_dist_form")[0].reset();
		jQuery("#createButtonId").val('Create a List');
		jQuery("#createButtonId").removeAttr('disabled');
		jQuery("#id_input_dist_name").removeAttr('readonly');

	}

	// ============== verifyAction for create dist list ======
	function verifyAction() {
		var newDistName = jQuery("#id_input_dist_name").val();
		var newEmailAddrStr = jQuery("#id_email_ids").val();

		// == verify input dist name ==
		if (newDistName == null || newDistName == "") {
			alert("Please enter a distribution list name.");
			return false;
		}
		if (newDistName.indexOf(" ") != -1 || newDistName.indexOf("@") != -1
				|| newDistName.indexOf(",") != -1
				|| newDistName.indexOf(";") != -1) {
			alert("The distribution list name should not include spaces or '@' or ',' or ';'.");
			return false;
		}
		if (newDistName.length >= 50) {
			alert("The length of the distribution list name should not exceed 50.");
			return false;
		}

		var size = dist_name_list.length;
		for (var num = 0; num < size; num++) {
			console.log("dist_name_list[" + num + "].distName= "
					+ dist_name_list[num].distName);
			if (newDistName == dist_name_list[num].distName) {
				alert("Please do not use your existing distribution name.");
				return false;
			}
		}

		if (newEmailAddrStr == null || newEmailAddrStr == "") {
			alert("Please enter email address value.");
			return false;
		}

		// == verify input email address ids ==
		newEmailAddrStr = newEmailAddrStr.replace(/^ +/g, '').replace(/ +$/g,
				''); //trim()
		if (newEmailAddrStr.length < 1) {
			alert("Please enter valid Intranet e_Mail ID(s).");
			return false;
		}
		
		newEmailAddrStr=newEmailAddrStr.replace('\r', '');
		newEmailAddrStr=newEmailAddrStr.replace('\n', '');
		newEmailAddrStr = newEmailAddrStr.trim();
		console.log("newEmailAddrStr after replace and trim: " + newEmailAddrStr);

		var mailArry = newEmailAddrStr.split(',');
		var mailStr = '';
		for (var loop = 0; loop < mailArry.length; loop++) {
			mailStr = mailArry[loop];
			if (mailStr == '') {
				continue;
			} 
			mailStr = mailStr.trim();
			if (mailStr.indexOf('@') < 0 || mailStr.indexOf(' ') >= 0) {
				alert("Please enter valid Intranet e_Mail ID(s).");
				return false;
			}
		}

		return true;
	}

	// ============== verifyDelAction for create dist list ======
	function verifyDelAction() {

		var distCheckboxList = jQuery("[name='dist_checkbox']");
		dist_selected_str = "";
		dist_selected_list = new Array();

		if (distCheckboxList.length == 0) {
			alert("Please select at least one entry for this action");
			return false;
		}
		for (var ii = 0; ii < distCheckboxList.length; ii++) {
			if (jQuery(distCheckboxList[ii]).is(":checked")) {
				if (ii > 0) {
					dist_selected_str += ",";
				}
				dist_selected_str += jQuery(distCheckboxList[ii]).attr("distID");
				dist_selected_list.push(jQuery(distCheckboxList[ii])
						.attr("distID"));
			}
		}

		if (dist_selected_list.length == 0 || dist_selected_str == "") {
			alert("Please select at least one entry for this action");
			return false;
		}

		return true;

	}
	function removeDist() {
	
		if (!verifyDelAction()) {
        	return;
        }
        
		if (!confirm("Click on \"OK\" to confirm that the selected dist(s) should be deleted.")) {
			return false;
		}

		var selectDist = null;
		if (dist_selected_list.length > 0) {
			console.log(dist_selected_list.length);
			jsonData = new Array();
			for (var num = 0; num < dist_selected_list.length; num++) {
			
				console.log(num);
				selectDist = dist_selected_list[num];
				console.log(selectDist);
				var distItem = {};
				distItem["selectedDistName"] = selectDist;
				distItem["cwa_id"]=cwa_id;
				distItem["uid"]=uid;

				jsonData.push(distItem);
			}
			console.log(jsonData);
			jQuery.ajax({
                        type: 'DELETE',
                        url: '<%=path%>/action/portal/mydistlist/deleteMyDistList',
				data : JSON.stringify(jsonData),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					callMyDistList();
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					console.log("XMLHttpRequest: " + XMLHttpRequest);
					console.log("textStatus: " + textStatus);
					console.log("errorThrown: " + errorThrown);
					alert('Delete failed');
				}
			});
		}

	}

	function loadDist(distName) {

		var selectedDist = dist_name_list.getDistBean(distName);
		if (selectedDist == null) {
			alert('can not get selected dist');
			return;
		}
		restForm();
		jQuery("#id_input_dist_name").val(selectedDist.distName);
		jQuery("#id_input_dist_name").attr('readonly', true);
		jQuery("#id_email_ids").val(selectedDist.emailStr);
		jQuery("#createButtonId").val('Update');

	}

	jQuery(document).ready(
			function() {

				jQuery("#manageDistInputs").attr("aria-selected", "true");
				jQuery("#id_cwa_id").val(cwa_id);
				jQuery("#id_uid").val(uid);

				jQuery("#distmanager_root_checkbox")
						.click(
								function() {
									jQuery("[name=dist_checkbox]:checkbox")
											.prop("checked", this.checked);
									if (this.checked) { // 
										jQuery(".odd").css("background-color",
												"#c0e6ff");
										jQuery(".even").css("background-color",
												"#c0e6ff");
									} else {
										jQuery(".odd").css("background-color",
												"#ececec");
										jQuery(".even").css("background-color",
												"#fff");
									}
								});

				callMyDistList();

			});
</script>

</head>

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div>
		<div class="ibm-fluid" style="">
			<div id="domain_id" style="float: left;">
				<h1 class="ibm-h1 ibm-light" style="padding: 0px;">&nbsp;My
					distribution lists&nbsp;</h1>
			</div>
			<div class="tbs_list_page_title">
				<p class="ibm-ind-link ibm-icononly ibm-inlinelink"
					style="padding-bottom: 0px;">
					<a class="ibm-information-link" target="_blank"
						href="<%=path%>/action/portal/pagehelp?pageKey=DistList&pageName=Report+distribution+lists"
						title="Help for My Distribution List"> Help for My
						Distribution List </a>
				</p>
			</div>
		</div>

		<div class="ibm-fluid">


			<!-- =================== Upload XLS file form - START =================== -->
			<div class="ibm-col-12-10 ibm-col-medium-12-9">

				<div style="float: left;">
					<div class="ibm-container-body">
						<div class="ibm-hideable">Use this form to create, update or
							delete your distribution lists. These distribution lists can
							contain many intranet IDs and may be used alongside individual
							e-Mail IDs as recipients in your Cognos and Autodeck schedule
							requests.</div>
					</div>
				</div>

				<form id="my_dist_form" class="ibm-row-form" method="post" action="">
					<input type="hidden" id="id_cwa_id" name="cwaId" value="" /> <input
						type="hidden" id="id_uid" name="uid" value="" />
					<table style="width: 100%">
						<tr style="width: 100%">
							<td style="width: 20%"><label for="id_requestid">
									Distribution List Name:<span class="ibm-required">*</span>
							</label></td>
							<td style="width: 80%"><input id="id_input_dist_name"
								name="input_dist_name" style="width: 30%" /></td>
						</tr>
						<tr>
							<td  style="vertical-align: top;"><label for="id_email_ids">e-Mail intranet IDs:<span
									class="ibm-required">*</span> <span class="ibm-item-note">(separated
										by commas)</span></label></td>
							<td><textarea name="email_ids" id="id_email_ids" cols="57"
									rows="3" style="width: 90%; height: 65px;"></textarea></td>


						</tr>
						<tr>
							<td></td>
							<td>
								<div class="ibm-btn-row ibm-right">
									<p class="ibm-btn-row ibm-button-link">
										<input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
											type="button" id="createButtonId" value="Create a List"
											onClick="createDist();return 0;" /> <span class="ibm-sep">&nbsp;</span>
										<input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
											type="button" name="ResetButton" value="Reset"
											onClick="restForm();return 0;" />
									</p>
								</div>
							</td>
						</tr>

						<tr>
							<td colspan="3">
								<div class="ibm-rule"></div>
								<div id="mydist_root_button_div" class="ibm-btn-row ibm-left">
									<a class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'
										id='dist_manage_btn_delete' onClick="removeDist();return 0;">
										Delete Selected List </a> <br />
								</div>
							</td>
						</tr>

					</table>
				</form>
				<!-- =================== My distribution List - START =================== -->
				<div style="width: 100%;" data-widget="showhide" data-type="panel"
					class="ibm-show-hide ibm-widget-processed">
					<table id="dist_manager_root_table" data-widget="datatable"
						data-info="true" data-ordering="true" data-paging="false"
						data-searching="true"
						class="ibm-data-table ibm-altrows dataTable no-footer"
						data-order='[[1,"desc"]]'>

						<thead>
							<tr>
								<th style="width: 0%;" class="selectallcolumn"><input
									id="distmanager_root_checkbox" type="checkbox"
									class="ibm-styled-checkbox" /> <label
									for="distmanager_root_checkbox"> <span
										class="ibm-access">Select all</span>
								</label></th>
								<th scope="col" style="width: 40%;">Distribution List Name</th>
								<th scope="col" style="width: 30%;">In use?</th>
							</tr>
						</thead>
						<tbody id='dist_manager_tbody'>
						</tbody>
						</tbody>
					</table>
				</div>
			</div>

			<!-- =================== My distribution List - END =================== -->

		</div>
	</div>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>

</html>