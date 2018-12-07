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
                <title>BI@IBM | My Autodeck schedules - Manage xls inputs</title>
                <jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
                <style type="text/css">
                    table.dataTable thead .sorting,
                    table.dataTable thead .sorting_asc,
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
                <script type="text/javascript" src="<%=path%>/javascript/uploadfile.js"></script>
                <script type="text/javascript" src="<%=path%>/javascript/jquery.form.js"></script>


                <script type="text/javascript">
                    var cwa_id = '${requestScope.cwa_id}';
                    var uid = '${requestScope.uid}';

                    var myXLSSettings = {
                        colReorder: false, // true | false (default)   // Let the user reorder columns (not persistent) 
                        info: false, // true | false (default)   // Shows "Showing 1-10" texts 
                        ordering: true, // true | false (default)   // Enables sorting 
                        paging: false, // true | false (default)   // Enables pagination 
                        scrollaxis: true, // x   // Allows horizontal scroll 
                        searching: false //true | false (default)   // Enables text filtering	
                    };

                    var xls_selected_st = '';
                    var xls_selected_list;
                    var uploadFiles = new Autouploads();
                    //
                    function restForm() {
                        jQuery("#uploadButtonId").removeAttr('disabled');
                        jQuery("#autodeck_upload_form")[0].reset();
                        jQuery("#inputXLSFileId").val('');
                        jQuery("#uploadButtonId").val('Upload');
                    }
                    //
                    function uploadFile() {
                        var inputFilePath = jQuery("#inputXLSFileId").val();
                        var description = jQuery("#id_fileDescription").val().trim();
                        var request_id = jQuery("#id_requestid").val();
                        var if_uploadFile = true;
                        if (request_id == 'new' && (inputFilePath == null || inputFilePath == '')) {
                            alert("Please provide a upload file");
                            return;
                        }
                        if (inputFilePath == null || inputFilePath == '') {
                            if_uploadFile = false;
                        }
                        // begin == add for check if the input file is .xls or .xlsx file for firefox browser.
                        if (inputFilePath != null && inputFilePath != '') {
                            var position = inputFilePath.lastIndexOf(".");
                            var suffix = inputFilePath.substring(position);
                            if (suffix != ".xls" && suffix != ".xlsx") {
                                alert("Please upload .xls or .xlsx file");
                                return;
                            }
                        }
                        // end == add for check if the input file is .xls or .xlsx file for firefox browser.

                        // begin == verify if file name changes in update action
                        if (!(request_id === 'new')) {
                            var newFileName = jQuery("#inputXLSFileId").val();
                            console.log(newFileName);
                            if (newFileName != null && newFileName != '') {
                                var oldFileName = jQuery("#id_filename").val();
                                console.log(oldFileName);
                                newFileName = newFileName.replace(/\\/g, "\/");
                                var indexPosition = newFileName.lastIndexOf("/");
                                newFileName = newFileName.substring(indexPosition + 1);
                                console.log(newFileName);

                                if (oldFileName != newFileName) {
                                    var tipmsg = 'The updated file name (' + newFileName + ') does not match the original (' + oldFileName + ').  \n\nPlease confirm that it is OK to proceed.';
                                    if (!confirm(tipmsg)) {
                                        return false;
                                    }
                                }
                            }
                        }
                        // end == verify if file name changes in update action
                        
                        // begin == verify if the file desc is too long
                    	if(description.length>200){
                    		alert("The length of the Description should not exceed 200.");
    						return false;
                    	}
                    	
						// end == verify if the file desc is too long
						
                        jQuery("#uploadButtonId").attr('disabled', true);
                        jQuery("#uploadButtonId").val('Uploading...');
                        if (if_uploadFile) {
                            jQuery("#autodeck_upload_form").ajaxSubmit({
                                type: 'POST',
                                url: '<%=path%>/action/portal/autodeck/xlsmanage/XLSUpload/',
                                dataType: "json",
                                success: function(data) {
                                    restForm();
                                    callMyXLSList();
                                },
                                error: function(XMLHttpRequest, textStatus, errorThrown) {
                                    jQuery("#uploadButtonId").removeAttr('disabled');
                                    jQuery("#uploadButtonId").val('Upload');
                                    alert("Failed to upload file, error code:" + XMLHttpRequest.status + ",error message:" + textStatus);
                                }
                            });
                        } else {
                            var jsonData = {};
                            var formToJson = jQuery("#autodeck_upload_form").serializeArray();
                            for (var i = 0; i < formToJson.length; i++) {
                                if (formToJson[i].name != 'file') {
                                    jsonData[formToJson[i].name] = formToJson[i].value || '';
                                }
                            }
                            jQuery.ajax({
                                type: 'POST',
                                url: '<%=path%>/action/portal/autodeck/xlsmanage/XLSUploadConfigurationOnly/',
                                //async : false,
                                data: JSON.stringify(jsonData),
                                contentType: "application/json",
                                dataType: "json",
                                success: function(data) {
                                    restForm();
                                    callMyXLSList();
                                },
                                error: function(XMLHttpRequest, textStatus, errorThrown) {
                                    jQuery("#uploadButtonId").removeAttr('disabled');
                                    jQuery("#uploadButtonId").val('Upload');
                                    alert("Failed to upload file, error code:" + XMLHttpRequest.status + ",error message:" + textStatus);
                                }
                            });
                        }

                    }

                    function loadUpload(request_id) {
                        var uploadFile = uploadFiles.getUploadfile(request_id);
                        if (uploadFile == null) {
                            alert('can not get upload file');
                            return;
                        }
                        restForm();
                        jQuery("#uploadButtonId").val('Update');
                        jQuery("#id_requestid").val(uploadFile.id);
                        jQuery("#id_fileDescription").val(uploadFile.desc);
                        jQuery("#id_filename").val(uploadFile.fileName);


                    }
                    
                    function callMyXLSList() {
                        var timeid = (new Date()).valueOf();
                        jQuery("#xlsmanager_root_checkbox").removeAttr("checked");
                        var table_content = jQuery("#xls_manager_root_table").DataTable();

                        uploadFiles.empty();
                        jQuery("#xls_manager_tbody").empty();
                        jQuery("#xls_manager_tbody").html("<tr><td colspan=\"6\"><span><Strong>loading...</Strong></span></td></tr>");
                        jQuery.ajax({
                            type: 'GET',
                            url: '<%=path%>/action/portal/autodeck/xlsmanage/getXLSList/' + cwa_id + '/' + uid + '?timeid=' + timeid,
                            timeout: 30000,
                            success: function(data) {
                                table_content.rows().remove();
                                if (data.length > 0) {
                                    for (var i = 0; i < data.length; i++) {
                                        var upload_file = new Uploadfile(data[i]);
                                        uploadFiles.addUploadFile(upload_file);
                                        var input_col_0 = '';
                                        input_col_0 += "<input id='xls_manage_" + upload_file.id + "_checkbox' xlsID='" + upload_file.id + "' type='checkbox' name='xls_checkbox' class='ibm-styled-checkbox admanager_xls_checkbox'>";
                                        input_col_0 += "<label for='xls_manage_" + upload_file.id + "_checkbox'>";
                                        input_col_0 += "<span class='ibm-access'>Select one</span></label>";
                                        input_col_0 += "</input>";

                                        var input_col_1 = "<A href=\"#\" onClick=\"loadUpload('" + upload_file.id + "'); return 0;\">" + upload_file.id + "</A>";
                                        var input_col_2 = "<span style='color: #333333; font-weight: bold;'>" + upload_file.name + "</span><br>" + upload_file.actionStr + upload_file.displayTime;
                                        var input_col_3 = upload_file.desc;
                                        var input_col_4 = upload_file.expirateDate;
                                        //
                                        var dataSet = [input_col_0, input_col_1, input_col_2, input_col_3, input_col_4]
                                        table_content.row.add(dataSet).draw();
                                        jQuery(table_content.row(i).node()).attr('id', 'id_' + upload_file.id);
                                    }

                                    jQuery(".admanager_xls_checkbox").click(function() {

                                        var thisID = jQuery(this).attr("xlsID");

                                        if (jQuery(this).prop("checked")) {
                                            jQuery("#id_" + thisID).css("background-color", "#c0e6ff");
                                        } else {
                                            if (jQuery("#id_" + thisID).prop("class") == "odd") {
                                                jQuery("#id_" + thisID).css("background-color", "#fff");
                                            } else {
                                                jQuery("#id_" + thisID).css("background-color", "#ececec");
                                            }
                                        }

                                    });

                                } else {
                                    table_content.rows().remove();
                                    jQuery("#xls_manager_tbody").empty();
                                    jQuery("#xls_manager_tbody").html("<tr><td colspan=\"6\"><span><Strong>No contents</Strong></span></td></tr>");
                                }
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                table_content.rows().remove();
                                jQuery("#xls_manager_tbody").empty();
                                jQuery("#xls_manager_tbody").html("<tr><td colspan=\"6\"><span><Strong>An error has occurred. Please try again later.</strong></span></td></tr>");
                            }
                        });
                    }

                    // ============== verifyAction ======
                    function verifyAction() {
                        var xlsCheckboxList = jQuery("[name='xls_checkbox']");
                        xls_selected_str = "";
                        xls_selected_list = new Array();

                        if (xlsCheckboxList.length == 0) {
                            alert("Please select at least one entry for this action");
                            return false;
                        }
                        for (var ii = 0; ii < xlsCheckboxList.length; ii++) {
                            if (jQuery(xlsCheckboxList[ii]).is(":checked")) {
                                if (ii > 0) {
                                    xls_selected_str += ",";
                                }
                                xls_selected_str += jQuery(xlsCheckboxList[ii]).attr("xlsID");
                                xls_selected_list.push(jQuery(xlsCheckboxList[ii]).attr("xlsID"));
                            }
                        }

                        if (xls_selected_list.length == 0 || xls_selected_str == "") {
                            alert("Please select at least one entry for this action");
                            return false;
                        }

                        return true;
                    }



                    function removeFile() {
                    	if (!verifyAction()) {
                            return;
                        }
                        
                        if (!confirm("Click on \"OK\" to confirm that the selected upload xls file(s) should be deleted.")) {
                            return false;
                        }
                        
                        var timeid = (new Date()).valueOf();
                        restForm();
                        jQuery.ajax({
                            type: 'GET',
                            url: '<%=path%>/action/portal/autodeck/xlsmanage/delXLSInput/' + cwa_id + '/' + uid + '/' + xls_selected_str + "?timeid=" + timeid,
                            success: function(data) {
                            	callMyXLSList();
                                if (xls_selected_list.length == 1) {
                                    alert('The selected XLS input file is deleted successfully.');
                                } else {
                                    alert('The selected ' + xls_selected_list.length + ' XLS input files have been successfully deleted.');
                                }
                                
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert('Delete failed');
                            }
                        });

                    }

                    function extendDate() {
                     	if (!verifyAction()) {
                            return;
                        }
                        
                        var timeid = (new Date()).valueOf();
                        restForm();
                        jQuery.ajax({
                            type: 'GET',
                            url: '<%=path%>/action/portal/autodeck/xlsmanage/extXLSInput/' + cwa_id + '/' + uid + '/' + xls_selected_str + "?timeid=" + timeid,
                            success: function(data) {
                            	callMyXLSList();
                                if (xls_selected_list.length == 1) {
                                    alert('The expiration date for the selected XLS input file has been successfully extended.');
                                } else {
                                    alert('The expiration dates for the ' + xls_selected_list.length + ' XLS input files have been successfully extended.');
                                }
                                
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert('Extend date failed');
                            }
                        });

                    }

                    jQuery(document).ready(function() {

                        jQuery("#manageXlsInputs").attr("aria-selected", "true");
                        jQuery("#id_cwa_id").val(cwa_id);
                        jQuery("#id_uid").val(uid);

                        jQuery("#xlsmanager_root_checkbox").click(function() {
                            jQuery("[name=xls_checkbox]:checkbox").prop("checked", this.checked);
                            if (this.checked) { // 
                                jQuery(".odd").css("background-color", "#c0e6ff");
                                jQuery(".even").css("background-color", "#c0e6ff");
                            } else {
                                jQuery(".odd").css("background-color", "#ececec");
                                jQuery(".even").css("background-color", "#fff");
                            }
                        });

                        callMyXLSList();

                    });
                </script>

            </head>

            <body id="ibm-com" class="ibm-type">
                <jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
                <br>
                <div>
                    <div class="ibm-fluid" style="padding-left;20px">
                        <div id="domain_id" style="float: left;">
                            <h1 class="ibm-h1 ibm-light" style="padding: 0px;">&nbsp;My Autodeck schedules - Manage xls inputs&nbsp;</h1>
                        </div>
                        <div class="tbs_list_page_title">
                            <p class="ibm-ind-link ibm-icononly ibm-inlinelink" style="padding-bottom: 0px;">
                                <a class="ibm-information-link" target="_blank" href="<%=path%>/action/portal/pagehelp?pageKey=MyAutodeckXlsInputs&pageName=My+Autodeck+schedules+-+Manage+xls+inputs" title="Help for My Autodeck schedules - Manage xls inputs">
                                        Help for My Autodeck schedules
                                    </a>
                            </p>
                        </div>
                    </div>

                    <div class="ibm-fluid">
                        <div class="ibm-col-12-2 ibm-col-medium-12-3 ibm-hidden-small">
                            <jsp:include page="/WEB-INF/portal/autodeck_navigator.jsp"></jsp:include>
                        </div>

                        <!-- =================== Upload XLS file form - START =================== -->
                        <div class="ibm-col-12-10 ibm-col-medium-12-9">

                            <div data-widget="showhide" class="ibm-simple-show-hide" style="float: left;">
                                <div class="ibm-container-body">
                                    <p class="ibm-show-hide-controls">
                                        <a href="#show" class="">Show instructions</a> | <a href="#hide" class="ibm-active">Hide instructions</a>
                                    </p>
                                    <div class="ibm-hideable">
                                        Use this page to:
                                        <br>1. Upload a spreadsheet (xls or xlsx) to be used in your Autodeck content.
                                        <br>2. Replace an uploaded file.
                                        <br>3. Delete one or more uploaded files.
                                    </div>
                                </div>
                            </div>

                            <form id="autodeck_upload_form" class="ibm-row-form" method="post" action="<%=path%>/action/portal/autodeck/xlsmanage/XLSUpload" enctype="multipart/form-data">
                                <input type="hidden" id="id_cwa_id" name="cwaId" value="" />
                                <input type="hidden" id="id_uid" name="uid" value="" />
                                <table style="width:100%">
                                    <tr style="width:100%">
                                        <td style="width:10%">
                                            <label for="id_requestid"><span>Request ID:</span></label>

                                        </td>
                                        <td style="width:90%">
                                            <input id="id_requestid" name="request_id" style="width:30%" value="new" readonly/>
                                            <span>&nbsp&nbsp  File name:&nbsp&nbsp</span><input id="id_filename" style="width:50%" name="original_FN" value="" readonly/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label for="inputXLSFileId">File to be uploaded:<span class="ibm-required">*</span></label>
                                        </td>
                                        <td>
                                            <span>								
								<input id="inputXLSFileId" type="file"  name="file" accept="application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />																	
							</span>
                                        </td>
                                        <td>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td  style="vertical-align: top;"><label for="idDescription">Description: </label></td>
                                        <td><textarea name="fileDescription" id="id_fileDescription" cols="57" rows="3" style="width: 90%; height: 65px;"></textarea></td>

                                    </tr>
                                    <tr>
                                     	<td colspan="3">
                                        	<div id="mytbs_root_buttondiv" class="ibm-btn-row ibm-left">
                                                <input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="uploadButtonId" value="Upload" onClick="uploadFile();return 0;" />
                                                    <span class="ibm-sep">&nbsp;</span>
                                                <input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button"  value="Reset" onClick="restForm();return 0;"/>
                                            </div>
                                            <div class="ibm-rule"></div>
                                        </td>
                                    </tr>									
                                    <!-- <tr>                                                                
                                        <td>
                                        </td>
                                        <td>                                        
                                            <div class="ibm-btn-row ibm-right">
                                                <p class="ibm-btn-row ibm-button-link">
                                                    <input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="xls_manage_btn_delete" value="Delete" onClick="removeFile();return 0;" />
                                                    <span class="ibm-sep">&nbsp;</span>
                                                    <input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="xls_manage_btn_extend_date" value="Extend date" onClick="extendDate();return 0;"/>
                                                </p>
                                            </div>
                                        </td>
                                    </tr> -->

                                </table>
                            </form>
                            <!-- =================== Autodeck XLS file List - START =================== -->
                            <div style="width: 100%;" data-widget="showhide" data-type="panel" class="ibm-show-hide ibm-widget-processed">
                                <table id="xls_manager_root_table" data-widget="datatable" data-info="true" data-ordering="true" data-paging="false" data-searching="true" class="ibm-data-table ibm-altrows dataTable no-footer" data-order='[[1,"desc"]]'>

                                    <thead>
                                        <tr>
                                            <th style="width: 0%;" class="selectallcolumn">

                                                <input id="xlsmanager_root_checkbox" type="checkbox" class="ibm-styled-checkbox" />
                                                <label for="xlsmanager_root_checkbox"> 
														<span class="ibm-access">Select all</span>
                                                </label>

                                            </th>
                                            <th scope="col" style="width: 20%;">Request ID</th>
                                            <th scope="col" style="width: 30%;">File Name</th>
                                            <th scope="col" style="width: 25%;">Description</th>
                                            <th scope="col" style="width: 25%;">Expiration Date</th>

                                        </tr>
                                    </thead>
                                    <tbody id='xls_manager_tbody'>
                                    </tbody>
                                </table>
                            </div>
                             <div class="ibm-btn-row ibm-left">
                                                <p class="ibm-btn-row">
                                                    <input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="xls_manage_btn_delete" value="Delete" onClick="removeFile();return 0;" />
                                                    <span class="ibm-sep">&nbsp;</span>
                                                    <input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="xls_manage_btn_extend_date" value="Extend date" onClick="extendDate();return 0;"/>
                                                </p>
							</div>
                        </div>

                        <!-- =================== Autodeck XLS file List - END =================== -->

                    </div>
                </div>

                <jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
            </body>

            </html>