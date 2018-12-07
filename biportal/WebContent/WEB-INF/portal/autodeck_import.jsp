<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>download</title>
 <jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
   <script type="text/javascript" src="<%=path%>/javascript/jquery.form.js"></script>
       <script type="text/javascript">
          function restForm() {
                        jQuery("#uploadButtonId").removeAttr('disabled');
                        jQuery("#autodeck_upload_form")[0].reset();
                        jQuery("#inputXLSFileId").val('');
                        jQuery("#uploadButtonId").val('Submit');
                    }
               function uploadFile() {
                        var inputFilePath = jQuery("#inputXLSFileId").val();
                      
                        var if_uploadFile = true;
                      
                        if (inputFilePath == null || inputFilePath == '') {
                            if_uploadFile = false;
                            alert("Please provide a upload file to import");
                            return;
                        }
                        // begin == add for check if the input file is .xls or .xlsx file for firefox browser.
                        if(inputFilePath != null && inputFilePath != ''){
                        	var position = inputFilePath.lastIndexOf(".");
                        	var suffix = inputFilePath.substring(position);
                        	if(suffix != ".xls" && suffix != ".xlsx") {
                        		alert("Please upload .xls or .xlsx file");
                            	return;
                        	}
                        }
                         // end == add for check if the input file is .xls or .xlsx file for firefox browser.
                        
						 // end == verify if file name changes in update action
						 
                        jQuery("#uploadButtonId").attr('disabled', true);
                        jQuery("#uploadButtonId").val('Submitting...');
                       
                            jQuery("#autodeck_upload_form").ajaxSubmit({
                                type: 'POST',
                                url: '<%=path%>/action/portal/autodeck/edit/importtemplate/',
                                dataType: "json",
                                success: function(data) {
                                    restForm();
                                    console.log(data);
                                },
                                error: function(XMLHttpRequest, textStatus, errorThrown) {
                                    jQuery("#uploadButtonId").removeAttr('disabled');
                                    jQuery("#uploadButtonId").val('Submit');
                                    alert("Failed to upload file, error code:" + XMLHttpRequest.status + ",error message:" + textStatus);
                                }
                            });
                      

                    }
       
       </script>

</head>
<body>
                
                            <form id="autodeck_upload_form" class="ibm-row-form" method="post" action="" enctype="multipart/form-data">
                                <input type="hidden" id="output_type" name="output_type" value="2" />
                               
                                <table style="width:100%">
                                 
                                    <tr>
                                        <td>
                                            <label for="inputXLSFileId"><span class="ibm-required">*</span>File to be uploaded:</label>
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
                                        <td><label for="idDescription">Description: </label></td>
                                        <td><textarea name="fileDescription" id="id_fileDescription" cols="57" rows="3" style="width: 90%; height: 65px;"></textarea></td>
                                        <td>
                                            <p class="ibm-btn-row ibm-button-link">
                                                <input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="uploadButtonId" value="Submit" onClick="uploadFile();return 0;" />
                                                <span class="ibm-sep">&nbsp;</span>
                                                <input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="reset" name="Cancel" value="Reset" />
                                            </p>
                                        </td>
                                    </tr>
                                  

                                </table>
                            </form>
</body>
</html>