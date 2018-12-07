<!-- 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<% String path = request.getContextPath(); %> 
-->
<!DOCTYPE html>
<html lang="en-US">

<head>
    <jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
    <!-- ================================================================= custom page JS and CSS start -->
    <title>BI@IBM | Publication details</title>
    <style type="text/css">  
        /* ====================== overriding v18 */
        a[class*="ibm-btn-"][class*="-pri"][class*="blue-50"],
        a[class*="ibm-btn-"][class*="-sec"][class*="blue-50"],
        .ibm-btn-pri.ibm-btn-small,
        .ibm-btn-sec.ibm-btn-small {
            padding-top: 5px;
            padding-bottom: 5px;
            padding-left: 12px;
            padding-right: 12px;
            font-size: 12px;
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 20px;
            margin-bottom: 5px;
        }
        /* ====================== only for this page */
        .my-read-only {
        		color: rgb(153, 153, 153);
        		background-color: rgb(236, 236, 236);
        }
        
    </style>   
    <script type="text/javascript">
        window.$ = window.jQuery;
        var myContext = "<%=request.getContextPath()%>";
        var myCwa     = "${cwa_id}";
        var myUid     = "${uid}";    
        var myBlobId  = "${blobId}"; 
        var myCsrTriggerId = "${csrTriggerCd}"; 
	</script>
    <!-- ================================================================= custom page JS and CSS end -->
</head>

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>

	<!-- ================================================================= page starts -->
	<div class="ibm-columns">
		<div class="ibm-col-6-6">
			<h1  id="ibm-pagetitle-h1" class="ibm-h1 ibm-light">Publication details</h1>
		</div>
		<div class="ibm-col-6-6">
			<ul data-widget="twisty" class="ibm-twisty">
			    <li>
			        <span class="ibm-twisty-head">
			            <strong>Key notes</strong>
			        </span>
			        <div class="ibm-twisty-body">
			            <p>All fields are required.</p>
			        </div>
			    </li>
			</ul>				
		</div>
		<div class="ibm-col-6-6">
			<form id="my_publication_form" class="ibm-column-form">
			    <p>
			        <label for="my_csr_request_id">CSR Request ID:</label>
			        <span>
			            <input type="text" value="${csrRquestId}" size="80" id="my_csr_request_id" name="csrRequestId" class="my-read-only" readonly>
					</span>
			    </p>					    
				<p>
			        <label for="my_csr_rpt_name">CSR Cognos Report Name:</label>
			        <span>
			            <input type="text" value="${csrRptName}" size="80" id="my_csr_rpt_name" name="csrRptName"  class="my-read-only" readonly>
					</span>
			    </p>			
				<p>
			        <label for="my_csr_email_subject">CSR Email Subject:</label>
			        <span>
			            <input type="text" value="${csrEmailSubject}" size="80" id="my_csr_email_subject"  name="csrEmailSubject" class="my-read-only" readonly>
					</span>
			    </p>	
				<p>
			        <label for="my_csr_email_comments">CSR Email Comments:</label>
			        <span>
			            <input type="text" value="${csrEmailComments}" size="80" id="my_csr_email_comments"  name="csrEmailComments" class="my-read-only" readonly>
					</span>
			    </p>					
			    <p>
			        <label for="my_blob_report_name">Blob Report Name:</label>
			        <span>
			            <input type="text" value="" size="80" id="my_blob_report_name"  name="blobReportName" >
					</span>
			    </p>
			    <p>
			        <label for="my_blob_report_desc">Blob Report Description:</label>
			        <span>
			            <input type="text" value="" size="80" id="my_blob_report_desc" name="blobReportDesc" >
					</span>
			    </p>	
			    <p>
			        <label for="my_blob_keywords">Blob Report Search Terms:<br/>(separated by spaces)</label>
			        <span>
			            <input type="text" value="" size="80" id="my_blob_keywords" name="blobKeywords" >
					</span>
			    </p>		
			    <p>
			        <label for="my_blob_life_span">Blob Report Life Span:<br/>(in days)</label>				
			        <span>
			            <input type="text" value="365" size="5" maxlength="3" id="my_blob_life_span" name="blobLifeSpan">
					</span>
			    </p>				
				<p class="ibm-form-elem-grp">
			        <label class="ibm-form-grp-lbl">Please choose:</label>
			        <span class="ibm-input-group ibm-radio-group">
		            		<input id="__REPLACE_ME_31__" name="myAddParentRoles" type="radio" value="Y" />         <label for="__REPLACE_ME_31__">Add parent roles</label>
		            		<input id="__REPLACE_ME_32__" name="myAddParentRoles" type="radio" value="N" checked /> <label for="__REPLACE_ME_32__">Don't add</label>
					</span>		        
			    </p>					        		    		
				<p style="display:none;">
			        <label for="my_blob_existing_roles">Blob Report Current Roles:</label>
			        <span id="my_blob_existing_roles"></span>
			    </p>		
				<p class="ibm-form-elem-grp">
			        <label for="my_reselect_roles">Please select roles:</label>
			        <span>
					<select class="ibm-widget-processed" id="my_reselect_roles" title="roles" size="6" multiple="multiple" name="myReselectRoles">
					</select>
					</span>
			    </p>				    
				<p style="display:none;">
			        <label for="my_blob_existing_folders">Blob Report Current Folders:</label>
			        <span id="my_blob_existing_folders"></span>
			    </p>	
				<p class="ibm-form-elem-grp">
			        <label for="my_reselect_folders">Please select folders:</label>
			        <span>
					<select class="ibm-widget-processed" id="my_reselect_folders" title="folders" size="6" multiple="multiple" name="myReselectFolders">
					</select>
					</span>
			    </p>				    			    		    		    		    			            
			 </form>	
			<input type="button" id="my_button_save"   class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="myFormSave();"   value="Save" />				
		</div>
    </div>    
    <!-- ================================================================= page ends -->
    
	<!-- ================================================================= form starts -->   

    <!-- ================================================================= form ends --> 
    <jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
    <!-- ================================================================= custom JavaScript codes start -->
    <script type="text/javascript">
        //============================================= 
        function myMessage(message) {
            IBMCore.common.widget.overlay.hideAllOverlays();
            var myOverlay = IBMCore.common.widget.overlay.createOverlay({
                contentHtml: '<p>' + message + '</p>',
                classes: 'ibm-common-overlay ibm-overlay-alt'
            });
            myOverlay.init();
            myOverlay.show();
        }
        
        function myMessageError(message) {
            IBMCore.common.widget.overlay.hideAllOverlays();
            var myOverlay = IBMCore.common.widget.overlay.createOverlay({
                contentHtml: '<p class="ibm-textcolor-red-50 ibm-bold ibm-center">' + message + '</p>',
                classes: 'ibm-common-overlay ibm-overlay-alt-three'
            });
            myOverlay.init();
            myOverlay.show();
        }
		//=============================================
        function myFormSave() {
        		//----------checking
        		var myFormData = {} //new FormData(document.querySelector("#my_publication_form"));
        		myFormData["csrRequestId"]    =jQuery("#my_csr_request_id").val(); 
        		myFormData["csrRptName"]      =jQuery("#my_csr_rpt_name").val(); 
        		myFormData["csrEmailComments"]=jQuery("#my_csr_email_comments").val(); 
        		myFormData["csrEmailSubject"] =jQuery("#my_csr_email_subject").val(); 
        		myFormData["csrTriggerId"]    =myCsrTriggerId; 
        		
        		myFormData["blobReportName"] =jQuery("#my_blob_report_name").val();  
        		if (myFormData["blobReportName"] == "") {
        			myMessageError("please input blob report name");  
        			return false; 
        		}
        		myFormData["blobReportDesc"] =jQuery("#my_blob_report_desc").val();  
        		if (myFormData["blobReportDesc"] == "") {
        			myMessageError("please input blob report description");  
        			return false; 
        		}
        		myFormData["blobKeywords"] =jQuery("#my_blob_keywords").val();  
        		if (myFormData["blobKeywords"] == "") {
        			myMessageError("please input blob report search terms");  
        			return false; 
        		} 	
        		myFormData["blobLifeSpan"] =jQuery("#my_blob_life_span").val();  
        		if (myFormData["blobLifeSpan"] == "") {
        			myMessageError("please input blob report life span");  
        			return false; 
        		} 
        		if ( isNaN (myFormData["blobLifeSpan"]) ) {
        			myMessageError("please input integers for blob report life span");  
        			return false; 
        		} 
        		if ( myFormData["blobLifeSpan"] < 1) {
        			myMessageError("please input integers for blob report life span");  
        			return false; 
        		} 
        		
        		var myReselectRoles=jQuery("#my_reselect_roles").find("option:selected"); 
        		if (myReselectRoles.length < 1) {
        			myMessageError("please select at least 1 role");  
        			return false; 
        		}
        		var tmpRoles = []; 
        		myReselectRoles.each(function (index, item) { tmpRoles.push(item.value); });
        		myFormData["myReselectRoles"] = tmpRoles.join(",");
        		
        		var myReselectFolders=jQuery("#my_reselect_folders").find("option:selected"); 
        		if (myReselectFolders.length < 1) {
        			myMessageError("please select at least 1 folder");  
        			return false; 
        		}       		
        		var tmpFolders=[]; 
        		myReselectFolders.each(function (index, item) { tmpFolders.push(item.value); });
        		myFormData["myReselectFolders"] =tmpFolders.join(","); 
        		
        		var myAddParrentRole = jQuery("input[name='myAddParentRoles']:checked"); 
        		if (myAddParrentRole.length < 1) {
        			myMessageError("please choose add parent roles or not");  
        			return false; 
        		}      	
        		myFormData["myAddParentRoles"] =jQuery(myAddParrentRole.get(0)).val();  
        		
        		myFormData["blobId"] = myBlobId;  
        		
        		//----------submission 
        		jQuery("#my_button_save").attr("disabled",true);
        		myMessage("Data are submitted for processing ... <img src='" + myContext + "/images/ajax-loader.gif' />");
            jQuery.ajax({
                url: myContext + "/action/admin/csrBlobPub/detailsSaveBlob?timeid="+(new Date()).valueOf(),
                type: 'POST',
                dataType: "json", 
                contentType: "application/json; charset=utf-8",   
                data: JSON.stringify(myFormData)
            })
            .done(function (data) {
            		myMessage("Data are saved successfully."); 

            		if (myBlobId == "NEW") {
            			//data used in JS coding, a flag var will impact myFormFillFields(data)
            			myBlobId = data["blobReptConf"]["reportDefId"]; 
            			//data showed in the browser address bar 
            			if (window.history){ //wil refresh //window.location.href = window.location.href.replace("blobId=NEW", "blobId="+myBlobId);
            				history.replaceState(null,null, window.location.href.replace("blobId=NEW", "blobId="+myBlobId) ); 
            			} 
            		}
            		
            		myFormFillFields(data); 
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                console.log("ajax error in loading...jqXHR..."       + JSON.stringify(jqXHR));
                console.log("ajax error in loading...textStatus..."  + textStatus);
                console.log("ajax error in loading...errorThrown..." + errorThrown);  
                myMessageError("ajax error in loading..."            + errorThrown);  
          		return false;       
            })
            .always(function () {
            		jQuery("#my_button_save").attr("disabled",false);
            });
        }		
		
        function myFormFillFields(data) {
			if (data.msg !="success") {
				myMessageError(data.msg); 
				return false; 
			}
			//---------available 
			var avaFolders = data["availableFolders"]; 
			var avaRoles   = data["availableRoles"]; 
			var avaFoldersList = data["availableFoldersList"]; 
			var avaRolesList   = data["availableRolesList"]; 
			jQuery("#my_reselect_roles"  ).empty();
			jQuery.each(avaRolesList,function(index,item){
				jQuery("#my_reselect_roles"  ).append("<option value='"+item["roleName"]+"'>"+item["roleDesc"]  +"</option>"); 
			});      
			jQuery("#my_reselect_folders").empty();
			for(var i in avaFolders){
				jQuery("#my_reselect_folders" ).append("<option value='"+i+"'>"+avaFolders[i] +"</option>"); 
			}
			//---------NOT new 
	    		if (myBlobId !== "NEW") { 
				var blobReptConf		=data["blobReptConf"]; 
				var blobReptContent	=data["blobReptContent"]; 
				var blobReptRoles	=data["blobReptRoles"]; 
				var blobReptFolders	=data["blobReptFolders"]; 
				var blobReptKeywords	=data["blobReptKeywords"]; 
				var blobAddParentRoles = blobReptConf["checkStatus"];
				
				jQuery("input[name='myAddParentRoles'][value='"+blobAddParentRoles+"']").click(); 
				
				jQuery("#my_blob_report_name").val(blobReptConf["reportName"]); 
				
				jQuery("#my_blob_report_desc").val(blobReptConf["reportDesc"]); 
				
				var my_blob_keywords=[];
				jQuery.each(blobReptKeywords,function(index,item){
					my_blob_keywords.push(item["keyword"]); 
				}); 
				jQuery("#my_blob_keywords").val(my_blob_keywords.join(" ")); 
				
				var myXml = blobReptConf["xmlContent"].replace("\"","'"); 
				jQuery("#my_blob_life_span").val(
					myXml.substring( myXml.indexOf("<life_span>")+11, myXml.indexOf("</life_span>") )
				); 
				
				jQuery.each(blobReptRoles,function(index,item){
					jQuery("#my_blob_existing_roles"   ).append(item["roleName"]+" - "+avaRoles[item["roleName"]]+"<br />"); 
					jQuery("#my_reselect_roles").find("option[value='"+item["roleName"]+"']").attr("selected","selected");
					
				}); 
				
				jQuery.each(blobReptFolders,function(index,item){
					jQuery("#my_blob_existing_folders" ).append(item["folderId"]+" - "+avaFolders[item["folderId"]]+"<br />"); 
					jQuery("#my_reselect_folders").find("option[value='"+item["folderId"]+"']").attr("selected","selected");
				}); 
				
	    		}       	
        }
			
        //=============================================
        jQuery(document).ready(function () {
        		myMessage("Data being loaded ... <img src='" + myContext + "/images/ajax-loader.gif' />");
      			jQuery.get(
        					myContext+"/action/admin/csrBlobPub/detailsGetBlob?"+"timeid="+(new Date()).valueOf() +"&reportDefId="+myBlobId +"&triggerCd="+myCsrTriggerId 
				).fail(function(jqXHR, textStatus, errorThrown){  
            				console.log("error4loading...jqXHR..."		+JSON.stringify(jqXHR)); 
            				console.log("error4loading...textStatus..."	+textStatus); 
            				console.log("error4loading...errorThrown..."	+errorThrown); 
						myMessageError("ajax error in loading..."    +errorThrown); 
						return false; 
				}).done(function (data){
						//---------message
            				IBMCore.common.widget.overlay.hideAllOverlays();
            				myFormFillFields(data); 
				});         			
        });
  
    </script>
    <!-- ================================================================= custom JavaScript codes end -->
</body>

</html>