<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>BI@IBM Report Profile</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<style type="text/css">
.zuo {
    float: left;
    
}
</style>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
    <!-- =================== Loading div - START =================== -->
    <div id="up_loading_id" style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 998; width: 100%; height: 100%; _padding: 0 20px 0 0; background: #f6f4f5; display: none;"></div>
    <div id="up_ajax_loading_id" style="position: fixed; top: 0; left: 50%; z-index: 9999; opacity: 0; filter: alpha(opacity = 0); margin-left: -80px;">
        <div>
            <span>Updating report profile ... </span><img src='<%=request.getContextPath()%>/images/ajax-loader.gif' />
        </div>
    </div>
        <div id="add_ajax_loading_id" style="position: fixed; top: 0; left: 50%; z-index: 9999; opacity: 0; filter: alpha(opacity = 0); margin-left: -80px;">
        <div>
            <span>Adding report profile ... </span><img src='<%=request.getContextPath()%>/images/ajax-loader.gif' />
        </div>
    </div>
    <!-- =================== Loading div - END =================== -->
	<br>
	<div class="ibm-columns">
		<div class="ibm-card">
			<div class="ibm-card__content">
				<strong id="id_title" class="ibm-h4">Report Profile ${requestScope.action}</strong>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				<b>BI@IBM Portal report Profile Create Service</b><br>
				<p>
					The service is to add the Business unit info and the Geography scope info <br>
					When done, click the Create profile button at the bottom to save them and then click "Back to the main page" link. to the reprot profiles list page<br>
					When you return to the Report Profile page, your current profile will be shown.<br>
					Note that the Reset button will restore your Business unit and Geography scope selections to their last saved state.
					
				</p>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				
					<div class="ibm-columns">
						<div class="ibm-col-6-2">
				            <p>
				                <label for="id_profileName"><strong>Profile Name:</strong><span class="ibm-required"><strong>*</strong></span></label>
						        <span>
						            <input type="text" value="" size="48" id="id_profileName" name="profile_name">
						        </span>
				            </p>
				        </div>
				        
				        <div class="ibm-col-6-4">
				            <p>
				                <label for="id_profileDescription"><strong>Profile Description:</strong><span class="ibm-required"><strong>*</strong></span></label>
						        <span>
						            <input type="text" value="" size="70" id="id_profileDescription" name="profile_description">
						        </span>
				            </p>
				            <br />
				        </div>
				        <br />
		        		<br />
		        		<br />
			        </div>
				
				<form id="userprofile_edit_form" class="ibm-column-form" method="post">
				</form>
				
				<br>
				<button id="userprofile_savebutton"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="userprofile_save()">Create profile</button>
				
				<button id="userprofile_reset" style="display:none;"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="userprofile_reset()">Reset</button>
				<br> <br>
				<a href="<%=request.getContextPath()%>/action/portal/admin/profile/reportprofilelist">--><b>Back to the main page</b></a>
				<br />
				<br />
</div>
</div>
</div>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
	<script type="text/javascript">
	    var business_selected_str;
	    var business_selected_list;
	    var geo_selected_str;
	    var geo_selected_list;
	    var cwa_id = '${requestScope.cwa_id}';
	    var uid = '${requestScope.uid}';
	    var pid = '${requestScope.pid}';
	    var error = '${requestScope.error}';
	    var profileName = '';
	    var description = '';
		var returnData;
    var allReportProfileList;
    var buList;
    var buKeyArray=new Array();
    var geoKeyArray=new Array();
    var geoList;
    var reportProfile;
	    function showLoading() {
	        jQuery("#up_loading_id").css({
	            'display': 'block',
	            'opacity': '0.8'
	        });
	        jQuery("#up_ajax_loading_id").css({
	            'display': 'block',
	            'opacity': '0'
	        });
	        jQuery("#up_ajax_loading_id").animate({
	            'margin-top': '300px',
	            'opacity': '1'
	        }, 200);
	    }
	
	    function hiddLoading() {
	        jQuery("#up_loading_id").css({
	            'display': 'none'
	        });
	        jQuery("#up_ajax_loading_id").css({
	            'display': 'none',
	            'opacity': '0'
	        });
	    }

	    function showAddLoading() {
	        jQuery("#up_loading_id").css({
	            'display': 'block',
	            'opacity': '0.8'
	        });
	        jQuery("#add_ajax_loading_id").css({
	            'display': 'block',
	            'opacity': '0'
	        });
	        jQuery("#add_ajax_loading_id").animate({
	            'margin-top': '300px',
	            'opacity': '1'
	        }, 200);
	    }
	
	    function hiddAddLoading() {
	        jQuery("#up_loading_id").css({
	            'display': 'none'
	        });
	        jQuery("#add_ajax_loading_id").css({
	            'display': 'none',
	            'opacity': '0'
	        });
	    }
	    
		function getUPBusinessList(buData) {
			//showLoading();
			timeid = (new Date()).valueOf();
			
var data=buData;
		        	
					if (data != null && data.length > 0) {
						var colCount = 5;
						var rowCount = Math.ceil(data.length/5);
						var currentPos;
						
						// create checkbox table. 
						var tablestr = "<table class='ibm-data-table ibm-padding-small' style='width: 100%;'>";
						tablestr += "<thead>";
						tablestr += "<tr>";
						tablestr += "<th><span class='ibm-checkbox-wrapper'><input id='checkall_checkbox_bu' type='checkbox' class='ibm-styled-checkbox'/><label for='checkall_checkbox_bu' ><span class='ibm-access'>Select all</span></label></span>Business Unit</th>";

						// create checkbox table head
						for (var i = 0; i < colCount; i++) {
							tablestr += "<th>" + "</th>";
						}
						
						tablestr += "</tr>";
						tablestr += "</thead>";
						tablestr += "<tbody>";
						
						// create checkbox table bpcy
						for (var row = 0; row < rowCount; row++) {
							tablestr += "<tr style='border:0; background-color:transparent;'>";
							for (var col = 0; col < colCount; col++) {
								currentPos = col+row*colCount;
								if(currentPos < data.length){
									if(jQuery.inArray(data[currentPos].ctrlbookFilterId,buKeyArray)!=-1){
										tablestr += "<td><input type='checkbox' class='ibm-styled-checkbox' name='business_checkbox' selectedflag='Y' id='id_" + data[currentPos].ctrlbookFilterId + "_bucheckbox'" + " ctrlbookFilterId='" + data[currentPos].ctrlbookFilterId + "' ctrlbookFilterDesc='" + data[currentPos].ctrlbookFilterDesc + "' ctrlbookFilterName='" + data[currentPos].ctrlbookFilterName + "' ctrlbookFilterSeq='" + data[currentPos].ctrlbookFilterSeq + "' checked/>";
										tablestr += "<label for='id_" + data[currentPos].ctrlbookFilterId + "_bucheckbox'>" + data[currentPos].ctrlbookFilterDesc + "</label></td>";
									}else{
										tablestr += "<td><input type='checkbox' class='ibm-styled-checkbox' name='business_checkbox' selectedflag='N' id='id_" + data[currentPos].ctrlbookFilterId + "_bucheckbox'" + " ctrlbookFilterId='" + data[currentPos].ctrlbookFilterId + "' ctrlbookFilterDesc='" + data[currentPos].ctrlbookFilterDesc + "' ctrlbookFilterName='" + data[currentPos].ctrlbookFilterName + "' ctrlbookFilterSeq='" + data[currentPos].ctrlbookFilterSeq + "'/>";
										tablestr += "<label for='id_" + data[currentPos].ctrlbookFilterId + "_bucheckbox'>" + data[currentPos].ctrlbookFilterDesc + "</label></td>";
									}
								}
							}
							tablestr += "</tr>";
						}
						tablestr += "</tbody>";
						tablestr += "</table>";
					}
		        
				jQuery("#userprofile_edit_form").append(tablestr).append("<br/>");
				
		  	  	
			//hiddLoading();
		}
		
		function getGeoList() {
			
			timeid = (new Date()).valueOf();
			
		var data=geoList;
		        	
					if (data != null && data.length > 0) {
						var colCount = 5;
						var rowCount = Math.ceil(data.length/5);
						var currentPos;
						
						// create checkbox table. 
						var tablestr = "<table class='ibm-data-table ibm-padding-small' style='width: 100%;'>";
						tablestr += "<thead>";
						tablestr += "<tr>";
						tablestr += "<th><span class='ibm-checkbox-wrapper'><input id='checkall_checkbox_geo' type='checkbox' class='ibm-styled-checkbox'/><label for='checkall_checkbox_geo' ><span class='ibm-access'>Select all</span></label></span>Geography Scope</th>";

						// create checkbox table head
						for (var i = 0; i < colCount; i++) {
							tablestr += "<th style='background-color:transparent;'>" + "</th>";
						}
						
						tablestr += "</tr>";
						tablestr += "</thead>";
						tablestr += "<tbody>";
						
						// create checkbox table bpcy
						for (var row = 0; row < rowCount; row++) {
							tablestr += "<tr style='border:0; background-color:transparent;'>";
							for (var col = 0; col < colCount; col++) {
								currentPos = col+row*colCount;
								if(currentPos < data.length){
									if(jQuery.inArray(data[currentPos].ctrlbookFilterTypeId,geoKeyArray)!=-1){
										tablestr += "<td><input type='checkbox' data-init='false' class='ibm-styled-checkbox' name='geo_checkbox' selectedflag='Y' id='id_" + data[currentPos].ctrlbookFilterTypeId + "_geocheckbox'" + " ctrlbookFilterTypeId='" + data[currentPos].ctrlbookFilterTypeId + "' ctrlbookFilterTypeDesc='" + data[currentPos].ctrlbookFilterTypeDesc + "' ctrlbookFilterTypeName='" + data[currentPos].ctrlbookFilterTypeName + "' ctrlbookFilterTypeSeq='" + data[currentPos].ctrlbookFilterTypeSeq + "' checked/>";
										tablestr += "<label for='id_" + data[currentPos].ctrlbookFilterTypeId + "_geocheckbox'>" + data[currentPos].ctrlbookFilterTypeDesc + "</label></td>";
									}else{
										tablestr += "<td><input type='checkbox' data-init='false' class='ibm-styled-checkbox' name='geo_checkbox' selectedflag='N' id='id_" + data[currentPos].ctrlbookFilterTypeId + "_geocheckbox'" + " ctrlbookFilterTypeId='" + data[currentPos].ctrlbookFilterTypeId + "' ctrlbookFilterTypeDesc='" + data[currentPos].ctrlbookFilterTypeDesc + "' ctrlbookFilterTypeName='" + data[currentPos].ctrlbookFilterTypeName + "' ctrlbookFilterTypeSeq='" + data[currentPos].ctrlbookFilterTypeSeq + "'/>";
										tablestr += "<label for='id_" + data[currentPos].ctrlbookFilterTypeId + "_geocheckbox'>" + data[currentPos].ctrlbookFilterTypeDesc + "</label></td>";
									}
								}
							}
							tablestr += "</tr>";
						}
						tablestr += "</tbody>";
						tablestr += "</table>";
					}
		        
				jQuery("#userprofile_edit_form").append(tablestr);
				
		  	  
			//hiddLoading();
		}
		
		function userprofile_checkall()
		{
			jQuery(".ibm-styled-checkbox").prop("checked", true);
			//jQuery("input[selectallflag]").attr("selectallflag","Y");
		}

		function userprofile_uncheckall()
		{
			jQuery(".ibm-styled-checkbox").prop("checked", false);
			//jQuery("input[selectallflag]").attr("selectallflag","N");
		}

		function userprofile_reset()
		{
			jQuery(".ibm-styled-checkbox").prop("checked", false);
			jQuery("input[selectedflag='Y']").prop("checked",true);
			//jQuery("input[selectallflag]").attr("selectallflag","N");
		}
		
		function userprofile_save(){
			timeid = (new Date()).valueOf();
			var buSelectedList = [];
			var geoSelectedList = [];
			var buSelected = {};
			var geoSelected = {};
			var userprofile = {};
			var rptProfile=new Object();
			//
			rptProfile.pid=pid;
			rptProfile.cwaId=cwa_id
		  
			
			//
			var newProfileName = jQuery("#id_profileName").val().trim();
			if(newProfileName==null||newProfileName==""){
				alert('please enter Profile name');
				return false;
			}
			  rptProfile.profileName=newProfileName;
		/* 	else{
				var reg = /^[_0-9a-zA-Z]+$/;
				if(!reg.test(newProfileName)){
					alert('profile name is made up of letters, Numbers, and underscores');
					return false;
				}
			} */
			
			
			//
			var newProfileDescription = jQuery("#id_profileDescription").val();
			if(newProfileDescription==null||newProfileDescription==""){
				alert('please enter Profile description');
				return false;
			}
			  rptProfile.description = newProfileDescription;
			rptProfile.status='A';
			//
	        var businessCheckboxList = jQuery("[name='business_checkbox']");
	        var countBUSelected = 0;
	        for (var i = 0; i < businessCheckboxList.length; i++) {
	            if (jQuery(businessCheckboxList[i]).is(":checked")) {
	            	buSelectedList.push({ctrlbookFilterId:jQuery(businessCheckboxList[i]).attr("ctrlbookFilterId"),
	            		ctrlbookFilterDesc:jQuery(businessCheckboxList[i]).attr("ctrlbookFilterDesc"),
	            		ctrlbookFilterName:jQuery(businessCheckboxList[i]).attr("ctrlbookFilterName"),
	            		ctrlbookFilterSeq:jQuery(businessCheckboxList[i]).attr("ctrlbookFilterSeq"),
	            		isSelected:"Y"});
	            }
	        }
	        if (buSelectedList.length == 0 || buSelectedList == "") {
	            tbsPopupMessage("Please select at least one entry for this action");
	            return false;
	        }
	         rptProfile.buselectedList  = buSelectedList;
	        
	        //
	        var geoCheckboxList = jQuery("[name='geo_checkbox']");
	        for (var i = 0; i < geoCheckboxList.length; i++) {
	            if (jQuery(geoCheckboxList[i]).is(":checked")) {
	            	/* geoSelected["ctrlbookFilterTypeId"] = jQuery(geoCheckboxList[i]).attr("ctrlbookFilterTypeId");
	            	geoSelected["ctrlbookFilterTypeDesc"] = jQuery(geoCheckboxList[i]).attr("ctrlbookFilterTypeDesc");
	            	geoSelected["ctrlbookFilterTypeName"] = jQuery(geoCheckboxList[i]).attr("ctrlbookFilterTypeName");
	            	geoSelected["ctrlbookFilterTypeSeq"] = jQuery(geoCheckboxList[i]).attr("ctrlbookFilterTypeSeq"); */
	            	geoSelectedList.push({ctrlbookFilterTypeId:jQuery(geoCheckboxList[i]).attr("ctrlbookFilterTypeId"),
	            		ctrlbookFilterTypeDesc:jQuery(geoCheckboxList[i]).attr("ctrlbookFilterTypeDesc"),
	            		ctrlbookFilterTypeName:jQuery(geoCheckboxList[i]).attr("ctrlbookFilterTypeName"),
	            		ctrlbookFilterTypeSeq:jQuery(geoCheckboxList[i]).attr("ctrlbookFilterTypeSeq"),
	            		isSelected:"Y"});
	            }
	        }
	        if (geoSelectedList.length == 0 || geoSelectedList == "") {
	            tbsPopupMessage("Please select at least one entry for this action");
	            return false;
	        }
	        rptProfile.geoselectedList= geoSelectedList;
             console.log(rptProfile);
			//showLoading();
			if(pid==null||pid==""){
				showAddLoading();
	 			jQuery.ajax({
	 				type : 'POST',
	 				url : '<%=path%>/action/portal/reportprofile/saveReportProfile/' + '?timeid=' + timeid ,
	 				data : JSON.stringify(rptProfile),
	 				contentType : "application/json",
	 				dataType : "json",
	 				
	 			})
	 			.done(function(){
	 				alert("Create report profile successfully!");
					hiddAddLoading();
					window.location.href=document.referrer;
	 			})
	 			.fail(function(jqXHR, textStatus, errorThrown){		
	 				//alert("Create user profile failed!");
					hiddAddLoading();
					if (confirm("Unable to create report profile - click \'OK\' to return to the current page and try again or \'Cancel\' to return to Existing Profiles page.")) {
						var urlStr = "<%=request.getContextPath()%>/action/portal/security/addReportProfile/";
						window.location.href=urlStr;
					} else{
						window.location.href=document.referrer;
					}
	 			})
			}else{
			reportProfile.profileName=rptProfile.profileName;
			reportProfile.description=rptProfile.description;
			reportProfile.buselectedList=rptProfile.buselectedList;
			reportProfile.geoselectedList=rptProfile.geoselectedList;
				showLoading();
				userprofile["pid"] = pid;
				jQuery.ajax({
					type : "POST",
					url : "<%=path%>/action/portal/reportprofile/saveReportProfile/?timeid=" + timeid ,
					data : JSON.stringify(reportProfile),
					contentType : "application/json",
	 				dataType : "json",
				})
				.done(function(){
					alert("Updated report profile successfully!");
					hiddLoading();
				})
				.fail(function(jqXHR, textStatus, errorThrown){
					alert("Updated report profile failed!");
					hiddLoading();
				})
			}
			

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
	      function  LoadReportProfile() {
	         timeid = (new Date()).valueOf();
        jQuery.ajax({
            type: 'GET',
            url: '<%=path%>/action/portal/reportprofile/listProfiles?cwa_id=' + cwa_id + '&timeid=' + timeid,
            success: function(data) {
            returnData=data;
                 console.log(data);
                 
             allReportProfileList= data.allReportProfileList; 
                 buList=data.buList;
                 geoList=data.geoList;
            	var gsOptionArray = null;
            	var buOptionArray = null;
                   buList=data.buList;
                  geoList=data.geoList;

            
	    	//alert(pid);
 for (var i = 0; i < allReportProfileList.length; i++) {
    if(allReportProfileList[i].pid==pid){
    reportProfile=allReportProfileList[i];
    break;
    
    
    }
        
        } 
        if(pid==null||pid==""){
	    		jQuery("#userprofile_savebutton").html("Create profile");
	    		jQuery("#userprofile_reset").hide();
	    		 profileName="";
               profileDescription="";
	    	}else{
	    		jQuery("#userprofile_savebutton").html("Update profile");
	    		jQuery("#userprofile_reset").show();
	    	      profileName=reportProfile.profileName;
               profileDescription=reportProfile.description;	
              if(reportProfile.geoselectedList != null){
			var gsOptionArray = reportProfile.geoselectedList;
			for(var i=0;i<gsOptionArray.length;i++) {
				geoKeyArray.push(gsOptionArray[i].ctrlbookFilterTypeId);
				
				
			}
		}
		//-----list busiunit options 
		if(reportProfile.buselectedList != null){
			var buOptionArray =reportProfile.buselectedList;
			for(var i=0;i<buOptionArray.length;i++) {
				buKeyArray.push(buOptionArray[i].ctrlbookFilterId);
				
			}
		} 
               
               
               
               
	    	}
       
        jQuery("#id_profileName").val(profileName);
	    	jQuery("#id_profileDescription").val(profileDescription);
                getUPBusinessList(buList); 
                getGeoList() 
                




       jQuery("#checkall_checkbox_geo").click(function(){   
    if(jQuery("#checkall_checkbox_geo").is(":checked")){  
         jQuery('input[name="geo_checkbox"]').each(function(){  
             jQuery(this).prop("checked", true);  
         });  
    }else{  
        jQuery('input[name="geo_checkbox"]').each(function(){  
             jQuery(this).removeAttr("checked");  
         });  
    }  
});







       jQuery("#checkall_checkbox_bu").click(function(){   
    if(jQuery("#checkall_checkbox_bu").is(":checked")){  
         jQuery('input[name="business_checkbox"]').each(function(){  
             jQuery(this).prop("checked", true);  
         });  
    }else{  
        jQuery('input[name="business_checkbox"]').each(function(){  
             jQuery(this).removeAttr("checked");  
         });  
    }  
}); 

                hiddLoading();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                hiddLoading();
                tbsPopupMessage("User Profile exception: " + textStatus + " - " + errorThrown);
            }
        });
	    }

	 	// ========== ready() =============
	    jQuery(document).ready(function () {
	    	
	    	
	    	
	    	LoadReportProfile();
	    	reportProfile=new Object();
	    	reportProfile.id=pid
 	    	//getUPBusinessList();
	    	//getGeoList();
	    	
		});
	</script>
</body>
</html>