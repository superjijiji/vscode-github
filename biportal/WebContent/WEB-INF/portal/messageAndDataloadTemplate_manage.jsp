<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<meta contentType="text/html; charset=UTF-8">
<title>Message And Dataload Template</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>

</head>
<body id="ibm-com" class="ibm-type" style="align: center">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
    <!-- =================== Loading div - START =================== -->
    <div id="csp_loading_id" style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 998; width: 100%; height: 100%; _padding: 0 20px 0 0; background: #f6f4f5; display: none;"></div>
    <div id="csp_ajax_loding_id" style="position: fixed; top: 0; left: 50%; z-index: 9999; opacity: 0; filter: alpha(opacity = 0); margin-left: -80px;">
        <div>
            <span>Loading mail templates ... </span><img src='<%=request.getContextPath()%>/images/ajax-loader.gif' />
        </div>
    </div>
    <!-- =================== Loading div - END =================== -->
	<div>
		<div>
			<div>
				<div style="float: left;">
					<h1 class="ibm-h1 ibm-light">&nbsp;&nbsp;&nbsp;Message And Dataload Template</h1>
				</div>
			</div>
		</div>

		<div style="width: 95%; align: center; margin-left: auto; margin-right: auto;">
			<table width="100%" border="0" role="presentation">
				<tbody>
					<tr>
						<td>
						<div id="mtmanager_buttondiv" class="ibm-btn-row ibm-left">
				            <a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" href='<%=path%>/action/admin/mailTmpl/addMailTemplate' name="eod_mtmanager_btn" id="mtmanager_btn_add"> Add </a> 
				            <a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" name="eod_mtmanager_btn" id="mtmanager_btn_delete"> Delete </a> 
				            <a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" name="eod_mtmanager_btn" id="mtmanager_btn_setasdefault"> SetAsDefault </a> 
				        </div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div id="div_mt_id" style="width: 95%; align: center; margin-left: auto; margin-right: auto;">
			<table id="table_mailtemplate_manager" data-widget="datatable" data-ordering="true" data-paging="false" class="ibm-data-table ibm-altrows dataTable no-footer">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">Template name</th>
                            <th scope="col">Template author</th>
                            <th scope="col">Mail subject</th>
                            <th scope="col" width="30%">Mail body</th>
                            <th scope="col">Comments</th>
                            <th scope="col" width="6%">If default</th>
                            <th scope="col">Template type</th>
                            <th scope="col">Template create time</th>
                        </tr>
                    </thead>
                    <tbody id='tbody_mailtemplate_manager'></tbody>
            </table>
		</div>

	</div>

	
	
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
	<script type="text/javascript">
	var mtContext = "<%=request.getContextPath()%>";
    var mailTemplates;
    var cwa_id = '${requestScope.cwa_id}';
    var uid = '${requestScope.uid}';
    var error = '${requestScope.error}';
    var templates_selected_str;
    var templates_selected_list;

    var cbIds_selected = '';
    var cbIds_un_selected = '';
     
    // Refresh selected mail template list
    function listMailTemplates() {
    	//showLoading();
    	table_content = jQuery("#table_mailtemplate_manager").DataTable();
        timeid = (new Date()).valueOf();
        jQuery.ajax({
            type: 'GET',
            url: '<%=path%>/action/portal/mailtemplate/listMailTemplates/' + cwa_id + '/' + uid + '?timeid=' + timeid,
            success: function(data) {

                if (data.errorMessage != null) {
                    tbsPopupMessage(data.errorMessage);
                } else {
                    table_content.rows().remove();

                    if (data.length > 0) {

                        for (var i = 0; i < data.length; i++) {
                            var mailtemplate = new Template(data[i]);

                            var input_col_0 = '';
                            input_col_0 += "<input id='mtmanager_" + mailtemplate.templateName + "_checkbox'" + " templateName='" + mailtemplate.templateName + "' type='checkbox' name='template_checkbox' class='ibm-styled-checkbox mtmanager_template_checkbox'>";
                            input_col_0 += "<label for='mtmanager_" + mailtemplate.templateName + "_checkbox'>";
                            input_col_0 += "<span class='ibm-access'>Select one</span>";
                            input_col_0 += "</input>";

                            var input_col_1 = '<a href="' + mailtemplate.editPath + '">' + mailtemplate.templateName + '</a>';
                            var input_col_2 = mailtemplate.templateCreater;
                            var input_col_3 = mailtemplate.mailSubject;
                            var input_col_4 = mailtemplate.mailBody;
                            var input_col_5 = mailtemplate.comments;
                            var input_col_6 = mailtemplate.ifDefault;
                            var input_col_7 = mailtemplate.typeName;
                            var input_col_8 = mailtemplate.creatTime;

                            var dataSet = [input_col_0, input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7, input_col_8]
                            table_content.row.add(dataSet).draw();

                            jQuery(table_content.row(i).node()).attr('id', 'id_' + mailtemplate.templateName);

                        }
                    }

                    // ============== Single Checkbox ============== 

                    jQuery(".mtmanager_template_checkbox").click(function() {

                        var thisID = jQuery(this).attr("templateName");

                        if (jQuery(this).prop("checked")) {
                            jQuery("tr #id_" + thisID).css("background-color", "#c0e6ff");
                        } else {
                            if (jQuery("tr #id_" + thisID).prop("class") == "odd") {
                                jQuery("tr #id_" + thisID).css("background-color", "#fff");
                            } else {
                                jQuery("tr #id_" + thisID).css("background-color", "#ececec");
                            }
                        }
                    });



                }
                hiddLoading();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                hiddLoading();
                tbsPopupMessage("Message and Dataload Template exception: " + textStatus + " - " + errorThrown);
            }
        });

    }
    
    // ============== Action 1 - Delete ============== 
    jQuery("#mtmanager_btn_delete").click(function() {
    	var action = 'delete';
        if (!verifyAction(action)) {
            return;
        }

        if (!confirm("Are you sure to delete this(these) " + templates_selected_list.length + " template(s)?")) {
            return;
        }

        tbsPopupMessage(templates_selected_list.length + " selected template(s) is(are) submitted for processing ... <img src='" + mtContext + "/images/ajax-loader.gif' />");
        timeid = (new Date()).valueOf();

        jQuery.ajax({
            url: '<%=path%>/action/portal/mailtemplate/deleteMailTemplate' + "?timeid=" + timeid,
            type: 'POST',
            data: JSON.stringify(templates_selected_list),
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                jQuery(table_content.row(0).node()).remove();
                listMailTemplates();
                tbsPopupMessage("Mail template(s) is(are) Deleted successfully.");
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

                tbsPopupMessage("Delete Failed!!");
            }
        });


    });
    
    // ============== Action 2 - SetAsDefault ============== 
    jQuery("#mtmanager_btn_setasdefault").click(function() {
    	var action = 'setasdefault';
    	if (!verifyAction(action)) {
            return;
        }
    	
    	tbsPopupMessage(templates_selected_list.length + " selected template is submitted for processing ... <img src='" + mtContext + "/images/ajax-loader.gif' />");
        timeid = (new Date()).valueOf();
        //showLoading();
    	jQuery.ajax({
            url: '<%=path%>/action/portal/mailtemplate/setAsDefaultMailTemplate' + "?timeid=" + timeid,
            type: 'POST',
            data: JSON.stringify(templates_selected_list),
            contentType: "application/json; charset=utf-8",
            success: function(data) {
            	if(data!="success"){
						//hiddLoading();
						alert(data);
						return false;
					}else{
						//hiddLoading();
						listMailTemplates();
						tbsPopupMessage("Set as default successfully.");
					}
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

                tbsPopupMessage("Delete Failed!!");
            }
        });
    });
    
    // ============ Verification of actions =============
    function verifyAction(action) {
        var templateCheckboxList = jQuery("[name='template_checkbox']");
        templates_selected_str = "";
        templates_selected_list = new Array();
        for (var int = 0; int < templateCheckboxList.length; int++) {
            if (jQuery(templateCheckboxList[int]).is(":checked")) {
            	templates_selected_str += jQuery(templateCheckboxList[int]).attr("templateName") + ",";
            	templates_selected_list.push(jQuery(templateCheckboxList[int]).attr("templateName"));
            }
        }

        if (action == 'delete' && (templates_selected_list.length == 0 || templates_selected_str == "")) {
            tbsPopupMessage("Please select at least one entry for this action");
            return false;
        } else if(action == 'setasdefault' && (templates_selected_str == "" || templates_selected_list.length == 0 || templates_selected_list.length > 1)){
        	tbsPopupMessage("Please select one entry for this action");
            return false;
        }

        return true;
    }
    
    // ========== popup message =============
    function tbsPopupMessage(message) {
        IBMCore.common.widget.overlay.hideAllOverlays();
        var myOverlay = IBMCore.common.widget.overlay.createOverlay({
            contentHtml: '<p>' + message + '</p>',
            classes: 'ibm-common-overlay ibm-overlay-alt'
        });
        myOverlay.init();
        myOverlay.show();
    }

    /* Template Module */
    function Template(mailtemplate) {
    	
        this.templateName = mailtemplate.templateName;
        if(mailtemplate.comments){
			this.comments = mailtemplate.comments;
		}else{
			this.comments = "";
		}
        this.creatTime = mailtemplate.creatTime;
		if(mailtemplate.ifDefault == ("Y")){
			this.ifDefault = "YES"
		}else{
			this.ifDefault = "NO";
		}
		this.mailBody = mailtemplate.mailBody;
		this.mailSubject = mailtemplate.mailSubject;
		this.templateCreater = mailtemplate.templateCreater;
		this.templateId = mailtemplate.templateId;
		this.typeName = mailtemplate.typeName;
		this.editPath = mtContext + '/action/admin/mailTmpl/editMailTemplate/' + this.templateName;
    }
    
    function showLoading() {
        jQuery("#csp_loading_id").css({
            'display': 'block',
            'opacity': '0.8'
        });
        jQuery("#csp_ajax_loding_id").css({
            'display': 'block',
            'opacity': '0'
        });
        jQuery("#csp_ajax_loding_id").animate({
            'margin-top': '300px',
            'opacity': '1'
        }, 200);
    }

    function hiddLoading() {
        jQuery("#csp_loading_id").css({
            'display': 'none'
        });
        jQuery("#csp_ajax_loding_id").css({
            'display': 'none',
            'opacity': '0'
        });
    }
    
    jQuery(document).ready(function () {
		jQuery("#tbody_mailtemplate_manager").empty();
		showLoading();
		listMailTemplates();

	});
    
	</script>
</body>
</html>