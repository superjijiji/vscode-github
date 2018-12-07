<!-- Author mengmin -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<meta contentType="text/html; charset=UTF-8">
<title>BI@IBM | Report profiles list</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>

</head>
<body id="ibm-com" class="ibm-type" style="align: center">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
    <!-- =================== Loading div - START =================== -->
    <div id="csp_loading_id" style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 998; width: 100%; height: 100%; _padding: 0 20px 0 0; background: #f6f4f5; display: none;"></div>
    <div id="csp_ajax_loding_id" style="position: fixed; top: 0; left: 50%; z-index: 9999; opacity: 0; filter: alpha(opacity = 0); margin-left: -80px;">
        <div>
            <span>Loading report profiles ... </span><img src='<%=request.getContextPath()%>/images/ajax-loader.gif' />
        </div>
    </div>
    <!-- =================== Loading div - END =================== -->
	<div>
		<div>
			<div>
				<div style="float: left;">
					<h1 class="ibm-h1 ibm-light">   Report profiles assignment</h1>
				</div>
				
			</div>
		</div>

		<div style="width: 95%; align: center; margin-left: auto; margin-right: auto;">
			<table width="100%" border="0" role="presentation">
				<tbody>
					<tr>
						<td>
						<div id="mtmanager_buttondiv" class="ibm-btn-row ibm-left">
				            <a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="submitAssignment()" name="userprofile_btn" id="userprofile_btn_add"> Submit </a>
				            <a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"  onclick="window.close()" name="userprofile_btn" id="userprofile_btn_add"> Cancel </a>
				        </div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div id="div_mt_id" style="width: 95%; align: center; margin-left: auto; margin-right: auto;">
			<table id="table_userprofile" data-widget="datatable" data-ordering="true" data-paging="false" class="ibm-data-table ibm-altrows dataTable no-footer">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">Profile name</th>
							<th scope="col">Geography Scope</th>
                            <th scope="col">Business Unit</th>
                            <th scope="col">Description</th>
                            <th scope="col">Status</th>
                            <th scope="col">Create time</th>
                            <th scope="col">Modify time</th>
                            <th scope="col">Created By</th>
                        </tr>
                    </thead>
                    <tbody id='tbody_userprofile'></tbody>
            </table>
		</div>

	</div>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
	<script type="text/javascript">
	var mtContext = "<%=request.getContextPath()%>";
    var mailTemplates;
    var cwa_id = '${requestScope.cwa_id}';
     var rpid = '${requestScope.rpid}';
    var userprofiles_selected_str;
    var userprofiles_selected_list;

    var cbIds_selected = '';
    var cbIds_un_selected = '';
     
    // Refresh selected mail template list
    var returnData;
    var allReportProfileList;
    var buList;
    var geoList;
    
    function listUserProfiles() {
    	//showLoading();
    	table_content = jQuery("#table_userprofile").DataTable();
        timeid = (new Date()).valueOf();
        jQuery.ajax({
            type: 'GET',
           url: '<%=path%>/action/portal/cognitive/getReprtProfile?cwa_id=' + cwa_id + '&reportPk='+rpid+'&timeid=' + timeid,
            success: function(data) {
     
                 console.log(data);
                 
        
            	var gsOptionArray = null;
            	var buOptionArray = null;
            	allReportProfileList=data;
                if (allReportProfileList.length == 0) {
                   alert("There is no report profile so far.");
                   return;
                } else {
                    table_content.rows().remove();

                 

                        for (var i = 0; i < allReportProfileList.length; i++) {
                            var userprofile = new UserProfile(allReportProfileList[i]);

                            var input_col_0 = '';
                            if(allReportProfileList[i].assigned==true){
                            input_col_0 += "<input id='userprofile_" + userprofile.pid + "_checkbox'" + " profilePid='" + userprofile.pid + "' type='checkbox' name='userprofile_checkbox' class='ibm-styled-checkbox user_profile_checkbox' checked>";
                            }else{
                            input_col_0 += "<input id='userprofile_" + userprofile.pid + "_checkbox'" + " profilePid='" + userprofile.pid + "' type='checkbox' name='userprofile_checkbox' class='ibm-styled-checkbox user_profile_checkbox'>";
                            }
                            input_col_0 += "<label for='userprofile_" + userprofile.pid + "_checkbox'>";
                            input_col_0 += "<span class='ibm-access'>Select one</span>";
                            input_col_0 += "</input>";

                            var input_col_1 = '<a href="' + userprofile.editPath + '">' + userprofile.profileName + '</a>';
                            
							var input_col_2 = userprofile.geoscopeKey;
							var input_col_3 = userprofile.busiunitKey;
                            var input_col_4 = userprofile.description;
                            var input_col_5 = userprofile.active;
                            var input_col_6 = userprofile.createTime;
                            var input_col_7 = userprofile.modifyTime;
 var input_col_8 = userprofile.cwaid;
                            var dataSet = [input_col_0, input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7,input_col_8]
                            table_content.row.add(dataSet).draw();

                            jQuery(table_content.row(i).node()).attr('id', 'id_' + userprofile.pid);

                        }
                    

                    // ============== Single Checkbox ============== 

                    jQuery(".user_profile_checkbox").click(function() {

                        var thisID = jQuery(this).attr("profilePid");

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
                tbsPopupMessage("User Profile exception: " + textStatus + " - " + errorThrown);
            }
        });

    }
    
    
    // ============== Action 1 - Delete ============== 
    jQuery("#userprofile_btn_delete").click(function() {
        if (!verifyAction()) {
            return;
        }

        if (!confirm("Are you sure to delete this(these) " + userprofiles_selected_list.length + "  report profile(s)?")) {
            return;
        }

        tbsPopupMessage(userprofiles_selected_list.length + " selected reportt profile(s) is(are) submitted for processing ... <img src='" + mtContext + "/images/ajax-loader.gif' />");
        timeid = (new Date()).valueOf();

        jQuery.ajax({
            url: '<%=path%>/action/portal/reportprofile/deleteReportProfile' + "?timeid=" + timeid,
            type: 'POST',
            data: JSON.stringify(userprofiles_selected_list),
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                jQuery(table_content.row(0).node()).remove();
                listUserProfiles();
                tbsPopupMessage("processing is done on the selected report profiles.");
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

                tbsPopupMessage("Delete Failed!!");
            }
        });

    });
    
    
    // ============== Action 2 - Activate ============== 
    jQuery("#userprofile_btn_activate").click(function() {
    	if (!verifyAction()) {
            return;
        }
    	
    	tbsPopupMessage(userprofiles_selected_list.length + " selected report profile is submitted for processing ... <img src='" + mtContext + "/images/ajax-loader.gif' />");
        timeid = (new Date()).valueOf();
        //showLoading();
    	jQuery.ajax({
            url: '<%=path%>/action/portal/reportprofile/activeProfiles' + "?timeid=" + timeid,
            type: 'POST',
            data: JSON.stringify(userprofiles_selected_list),
            contentType: "application/json; charset=utf-8",
            success: function(data) {
            
						//hiddLoading();
						listUserProfiles();
						tbsPopupMessage("Processing is done succesfully on the selected report profiles.");
				
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

                tbsPopupMessage("Activate/Inactivated Failed!!");
            }
        });
    });
    
    // ============== Action 3 - Inactivate ============== 
    jQuery("#userprofile_btn_inactivate").click(function() {
    	if (!verifyAction()) {
            return;
        }
    	
    	tbsPopupMessage(userprofiles_selected_list.length + " selected report profile is submitted for processing ... <img src='" + mtContext + "/images/ajax-loader.gif' />");
        timeid = (new Date()).valueOf();
        //showLoading();
    	jQuery.ajax({
            url: '<%=path%>/action/portal/userprofile/inactiveUserProfile' + "?timeid=" + timeid,
            type: 'POST',
            data: JSON.stringify(userprofiles_selected_list),
            contentType: "application/json; charset=utf-8",
            success: function(data) {
            	if(data!="success"){
						//hiddLoading();
						alert(data);
						return false;
					}else{
						//hiddLoading();
						listUserProfiles();
						tbsPopupMessage("processing is done on the selected report profiles.");
					}
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

                tbsPopupMessage("Inactivate Failed!!");
            }
        });
    });
    ///===============submit ============
    function submitAssignment(){
     userprofiles_selected_str = "";
        userprofiles_selected_list = new Array();
     var userprofileCheckboxList = jQuery("[name='userprofile_checkbox']");
   
        for (var i = 0; i < userprofileCheckboxList.length; i++) {
        
            if (jQuery(userprofileCheckboxList[i]).is(":checked")) {
            	userprofiles_selected_str += jQuery(userprofileCheckboxList[i]).attr("profilePid") + ",";
            	userprofiles_selected_list.push(jQuery(userprofileCheckboxList[i]).attr("profilePid"));
            }
        }
    
    	jQuery.ajax({
            url: '<%=path%>/action/portal/cognitive/assignReprtProfile/'+rpid + "?timeid=" + timeid,
            type: 'POST',
            data: JSON.stringify(userprofiles_selected_list),
            contentType: "application/json; charset=utf-8",
            success: function(data) {
            
						tbsPopupMessage("Processing is done on the selected report profiles.");
				
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

                tbsPopupMessage("Failed!!");
            }
      
    });
    
    }
    
    // ============ Verification of actions =============
    function verifyAction() {
        var userprofileCheckboxList = jQuery("[name='userprofile_checkbox']");
        userprofiles_selected_str = "";
        userprofiles_selected_list = new Array();
        for (var i = 0; i < userprofileCheckboxList.length; i++) {
            if (jQuery(userprofileCheckboxList[i]).is(":checked")) {
            	userprofiles_selected_str += jQuery(userprofileCheckboxList[i]).attr("profilePid") + ",";
            	userprofiles_selected_list.push(jQuery(userprofileCheckboxList[i]).attr("profilePid"));
            }
        }

        if (userprofiles_selected_list.length == 0 || userprofiles_selected_str == "") {
            tbsPopupMessage("Please select at least one entry for this action");
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
    
    function ToDate(timestamp3){
  	    var newDate = new Date();
  	    newDate.setTime(timestamp3);

  	    return newDate.toGMTString();
  	}

    /* UserProfile Module */
    function UserProfile(userprofile) {
    	
    	var gsOptionArray = null;
    	var buOptionArray = null;
    	this.geoscopeKey = ""; 
    	this.busiunitKey = "";
    	
    	this.pid = userprofile.pid;
        this.profileName = userprofile.profileName;
        
        //-----list geoscope options 
		if(userprofile.geoselectedList != null){
			gsOptionArray = userprofile.geoselectedList;
			for(var i=0;i<gsOptionArray.length;i++) {
				this.geoscopeKey += gsOptionArray[i].ctrlbookFilterTypeDesc;
				if(i < gsOptionArray.length-1){
					this.geoscopeKey += ", ";
				}
				
			}
		}
		//-----list busiunit options 
		if(userprofile.buselectedList != null){
			buOptionArray = userprofile.buselectedList;
			for(var i=0;i<buOptionArray.length;i++) {
				this.busiunitKey += buOptionArray[i].ctrlbookFilterDesc;
				if(i < buOptionArray.length-1){
					this.busiunitKey += ", ";
				}
			}
		}
        
        if(userprofile.description){
			this.description = userprofile.description;
		}else{
			this.description = "";
		}
        this.active = userprofile.status;
        if(userprofile.createTime != null){
        	this.createTime = ToDate(userprofile.createTime);
        }else{
        	this.createTime = "N/A";
        }
        if(userprofile.modifyTime != null){
        	this.modifyTime = ToDate(userprofile.modifyTime);
        }else{
        	this.modifyTime = "N/A";
        }
		this.cwaid=userprofile.cwaId;
		this.editPath = mtContext + '/action/portal/edit/getReportProfile?cwa_id=' + cwa_id + '&pid=' + this.pid;

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
      function loadReportPropile(reportPk) {
    	//showLoading();
    //reportPk
        timeid = (new Date()).valueOf();
        jQuery.ajax({
            type: 'GET',
            url: '<%=path%>/action/portal/cognitive/getReprtProfile?cwa_id=' + cwa_id + '&reportPk='+reportPk+'&timeid=' + timeid,
            success: function(data) {
            returnData=data;
                gsOptionArray=data;
                
			for(var i=0;i<gsOptionArray.length;i++) {
				var reportKey = gsOptionArray[i].pid.toString();
				if(gsOptionArray[i].assigned==true){
					jQuery('input[profilepid="'+reportKey+'"]').each(function(){  
             jQuery(this).prop("checked", true);  
         }); 
				}
				
			}
                 
                hiddLoading();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                hiddLoading();
                tbsPopupMessage("User Profile exception: " + textStatus + " - " + errorThrown);
            }
        });

    }
    jQuery(document).ready(function () {
		jQuery("#tbody_userprofile").empty();
		showLoading();
		
		listUserProfiles();
		loadReportPropile(rpid);
		//rpid
		
		

	});
    
	</script>
</body>
</html>