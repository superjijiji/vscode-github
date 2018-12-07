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
<title>BI@IBM | Unsubscribe panel</title>
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
<script type="text/javascript"
	src="<%=path%>/javascript/auto_unsubscribe.js"></script>


<script type="text/javascript">
	var cwa_id = '${requestScope.cwa_id}';
	var uid = '${requestScope.uid}';
	var request_id = '${requestScope.request_id}';
	var report_type = '${requestScope.report_type}';

	var unsubscribeSettings = {
		colReorder : false, // true | false (default)   // Let the user reorder columns (not persistent) 
		info : false, // true | false (default)   // Shows "Showing 1-10" texts 
		ordering : true, // true | false (default)   // Enables sorting 
		paging : false, // true | false (default)   // Enables pagination 
		scrollaxis : true, // x   // Allows horizontal scroll 
		searching : false
	//true | false (default)   // Enables text filtering	
	};

	var unsubscribe_selected_str = '';
	var unsubscribe_selected_list;
	var unsubscribeList = new UnsubscribeUsers();

	function callUnsubscribeList() {
		var timeid = (new Date()).valueOf();
		jQuery("#unsubmanager_root_checkbox").removeAttr("checked");
		var table_content = jQuery("#unsub_manager_root_table").DataTable();

		unsubscribeList.empty();
		jQuery("#unsubscribe_manager_tbody").empty();
		jQuery("#unsubscribe_manager_tbody")
				.html(
						"<tr><td colspan=\"6\"><span><Strong>loading...</Strong></span></td></tr>");
		jQuery.ajax({
			type: 'GET',
            url: '<%=path%>/action/portal/autodeck/unsubmanage/getUnsubscribeList/'
							+ cwa_id
							+ '/'
							+ uid
							+ '/'
							+ request_id
							+ '/'
							+ report_type + '?timeid=' + timeid,
					timeout : 30000,
					success : function(data) {
						table_content.rows().remove();
						if (data.length > 0) {
							console.log(data);
							for (var i = 0; i < data.length; i++) {
								var unsubscribe = new Unsubscribe(data[i]);
								unsubscribeList.addUnsubscribe(unsubscribe);
								var input_col_0 = '';
								input_col_0 += "<input id='unsubscribe_manage_" + i + "_checkbox' unsubscribeID='" + i + "' type='checkbox' name='unsubscribe_checkbox' class='ibm-styled-checkbox admanager_unsub_checkbox'>";
								input_col_0 += "<label for='unsubscribe_manage_" + i + "_checkbox'>";
								input_col_0 += "<span class='ibm-access'>Select one</span></label>";
								input_col_0 += "</input>";

								var input_col_1 = "<label id='labelForCwaId_"+i+"'>"+unsubscribe.cwaId+"</label>";
								var input_col_2 = unsubscribe.date;

								var dataSet = [ input_col_0, input_col_1,
										input_col_2 ]
								table_content.row.add(dataSet).draw();
								jQuery(table_content.row(i).node()).attr('id','id_' + i);

							}
							jQuery(".admanager_unsub_checkbox").click(
									function() {

										var thisID = jQuery(this).attr(
												"unsubscribeID");

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
							jQuery("#unsubscribe_manager_tbody").empty();
							jQuery("#unsubscribe_manager_tbody")
									.html(
											"<tr><td colspan=\"6\"><span><Strong>No contents</Strong></span></td></tr>");
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						table_content.rows().remove();
						jQuery("#unsubscribe_manager_tbody").empty();
						jQuery("#unsubscribe_manager_tbody")
								.html(
										"<tr><td colspan=\"6\"><span><Strong>An error has occurred. Please try again later.</strong></span></td></tr>");
					}
				});
	}

	// ============== NoticeAction ======
	function writeNotice() {
		console.log(report_type);
		var notice;
		if (report_type == "C") {
			notice = "Unsubscribed list for Cognos schedule: " + request_id;
			console.log(notice);
			jQuery("#p_notice_Id").text(notice);
		} else {
			notice = "Unsubscribed list for Autodeck schedule: " + request_id;
			console.log(notice);
			jQuery("#p_notice_Id").text(notice);
		}
	}

	// ============== verifyAction ======
	function verifyAction() {
	
		if(request_id == null){
			alert("No request id provided to remove!");
			return false;
		}
		if(report_type == null){
			alert("No report type provided to remove!");
			return false;
		}else if(report_type!="A"&&report_type!="C"){
			alert("The report type must be A or C. The provided reportType is: "+report_type);
			return false;
		}
		
		var unsubCheckboxList = jQuery("[name='unsubscribe_checkbox']");
		unsubscribe_selected_str = "";
		unsubscribe_selected_list = new Array();

		if (unsubCheckboxList.length == 0) {
			alert("Please select at least one entry for this action");
			return false;
		}
		for (var ii = 0; ii < unsubCheckboxList.length; ii++) {
			if (jQuery(unsubCheckboxList[ii]).is(":checked")) {
				if (ii > 0) {
					unsubscribe_selected_str += ",";
				}
				unsubscribe_selected_str += jQuery(unsubCheckboxList[ii]).attr(
						"unsubscribeID");
				unsubscribe_selected_list.push(jQuery(unsubCheckboxList[ii])
						.attr("unsubscribeID"));
			}
		}

		if (unsubscribe_selected_list.length == 0
				|| unsubscribe_selected_str == "") {
			alert("Please select at least one entry for this action");
			return false;
		}
		
		return true;
	}
	// ============== delAction ======
	function removeUnsub() {
		if (!confirm("Click on \"OK\" to confirm that the selected unsubscribe should be deleted.")) {
			return false;
		}
		if (!verifyAction()) {
			return;
		}
		
		var selectIndex = null;
		var selectCwaId = null;
		if (unsubscribe_selected_list.length > 0) {
			console.log(unsubscribe_selected_list.length);
			jsonData = new Array();
			for (var num = 0; num < unsubscribe_selected_list.length; num++) {
				
				selectIndex = unsubscribe_selected_list[num];
				selectCwaId = jQuery("#labelForCwaId_"+selectIndex).text();
				console.log(selectCwaId);
				console.log(num);
				var unsubItem = {};
				unsubItem["selectedcwaId"] = selectCwaId;
				unsubItem["cwa_id"]=cwa_id;
				unsubItem["uid"]=uid;
				unsubItem["report_type"]=report_type;
				unsubItem["request_id"]=request_id;
				jsonData.push(unsubItem);
			}
			
			jQuery.ajax({
                        type: 'DELETE',
                        url: '<%=path%>/action/portal/autodeck/unsubmanage/delUnsubscribeList',
						data : JSON.stringify(jsonData),
						contentType : "application/json",
						dataType : "json",
						success : function(data) {
							callUnsubscribeList();
						},
						error : function(XMLHttpRequest, textStatus,
								errorThrown) {
							console.log("XMLHttpRequest: " + XMLHttpRequest);
							console.log("textStatus: " + textStatus);
							console.log("errorThrown: " + errorThrown);
							alert('Delete failed');
						}
					});

		}
	}

	jQuery(document)
			.ready(
					function() {

						writeNotice();

						jQuery("#unsubmanager_root_checkbox")
								.click(
										function() {
											jQuery(
													"[name=unsubscribe_checkbox]:checkbox")
													.prop("checked",
															this.checked);
											if (this.checked) { // 
												jQuery(".odd").css(
														"background-color",
														"#c0e6ff");
												jQuery(".even").css(
														"background-color",
														"#c0e6ff");
											} else {
												jQuery(".odd").css(
														"background-color",
														"#ececec");
												jQuery(".even").css(
														"background-color",
														"#fff");
											}
										});
						callUnsubscribeList();

					});
</script>

</head>

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div>
		<div class="ibm-fluid" style="">
			<div id="domain_id" style="float: left;">
				<h1 class="ibm-h1 ibm-light" style="padding: 0px;">Unsubscribe
					panel</h1>
			</div>

		</div>


		<!-- =================== unsubscribe - START =================== -->
		<div class="ibm-col-12-10 ibm-col-medium-12-9">
			<div>
				<p id="p_notice_Id"></p>
			</div>
			<div id="unsub_root_button_div" class="ibm-btn-row ibm-right">
				<a class='ibm-btn-pri ibm-btn-small ibm-btn-blue-50'
					id='unsub_manage_btn_delete' onClick="removeUnsub();return 0;">
					Re-subscribe </a> <br />
			</div>

			<!-- =================== unsubscribe List - START =================== -->
			<div style="width: 100%;" data-widget="showhide" data-type="panel"
				class="ibm-show-hide ibm-widget-processed">
				<table id="unsub_manager_root_table" data-widget="datatable"
					data-info="true" data-ordering="true" data-paging="false"
					data-searching="true"
					class="ibm-data-table ibm-altrows dataTable no-footer"
					data-order='[[1,"desc"]]'>

					<thead>
						<tr>
							<th style="width: 0%;" class="selectallcolumn"><input
								id="unsubmanager_root_checkbox" type="checkbox"
								class="ibm-styled-checkbox" /> <label
								for="unsubmanager_root_checkbox"> <span
									class="ibm-access">Select all</span>
							</label></th>
							<th scope="col" style="width: 30%;">Unsubscribers</th>
							<th scope="col" style="width: 30%;">Date</th>

						</tr>
					</thead>
					<tbody id='unsubscribe_manager_tbody'>
					</tbody>
					</tbody>
				</table>
			</div>
		</div>

		<!-- =================== unsubscribe List - END =================== -->

	</div>


	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>

</html>