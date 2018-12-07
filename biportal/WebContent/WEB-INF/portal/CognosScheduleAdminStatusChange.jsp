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
    <title>BI@IBM | Change status of Cognos schedules</title>
    <style type="text/css">
		/* ====================== restoring v18 sorting icon (background) */
		table.dataTable thead th {
			padding-right:  20px;  
    			padding-left:   20px;
			padding-top:    5px;  
    			padding-bottom: 5px;    			
		}     		   
		table.dataTable thead .sorting, 
		table.dataTable thead .sorting_asc,  
		table.dataTable thead .sorting_desc  {
			background-position-x: 0;
		    background-position-y: 50%;
		}	    
        /* ====================== overriding v18 */
        .dataTables_wrapper .dataTables_filter,
        .dataTables_wrapper .dataTables_length {
            height: 25px;
            margin-bottom: 0px
        }
        
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
        
    </style>   
    <script type="text/javascript">
        window.$ = window.jQuery;
        var myContext = "<%=request.getContextPath()%>";
        var myCwa = "${cwa_id}";
        var myUid = "${uid}";    
        
        var myHiddenRows = []; //page stored variable

		var myWordExpansionStatus = {
				"A":"Active", 
				"I":"Inactive", 
				"E":"Expired", 
				"S":"Suspended", 
				"D":"Disabled"
			}
		var myWordExpansionOffpeak = {
				"N":"Peak", 
				"Y":"Off-peak", 
				"A":"Off-peak by admin"
			}	
   
	</script>
    <!-- ================================================================= custom page JS and CSS end -->
</head>

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>

	<!-- ================================================================= page starts -->
	<div class="ibm-columns">
		<div class="ibm-col-6-6">
			<h1  id="ibm-pagetitle-h1" class="ibm-h1 ibm-light">Change status of Cognos schedules</h1>
		</div>
		<div class="ibm-col-6-6">
			<ul data-widget="twisty" class="ibm-twisty">
			    <li>
			        <span class="ibm-twisty-head">
			            <strong>Key notes</strong>
			        </span>
			        <div class="ibm-twisty-body">
			            <p>(*) <strong><i>Off-peak</i></strong> means end user can change TBS back to peak .</p>
			            <p>(*) <strong><i>Off-peak by admin</i></strong> means end user can not change it back to peak.</p>
			        </div>
			    </li>
			</ul>				
		</div>
		<div class="ibm-col-6-6">
									<label      for="my_report_name"></label>
									<span><input id="my_report_name"  type="text" value="" STYLE="width: 120px; height:22px; "  placeholder="Report Name, required"  ></span>
									<span>&nbsp;</span>
									<label      for="my_owner_cwa"></label>
									<span><input id="my_owner_cwa"    type="text" value="" STYLE="width: 120px; height:22px; "  placeholder="Owner's Intranet ID, optional" ></span>
									<span>&nbsp;</span>
									<label      for="my_trigger_code"></label>
									<span><input id="my_trigger_code" type="text" value="" STYLE="width: 120px; height:22px; "  placeholder="Trigger Code, optional" ></span>
									<span>&nbsp;</span>
									<label      for="my_request_id"></label>
									<span><input id="my_request_id"   type="text" value="" STYLE="width: 120px; height:22px; "  placeholder="Request ID, optional"   ></span>		
									<span>&nbsp;</span>
									<span>&nbsp;</span>
									<span>&nbsp;</span>
									<input type="button" id="my_button_search"        class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="myButtonSearch();"                value="Search" />
									<input type="button" id="my_button_showhide"      class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="myButtonShowhide();"              value="Show selected/all" />	
									<input type="button" id="my_button_rerun"         class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="myButtonBatch('rerun');"          value="Rerun"/>									
									<input type="button" id="my_button_changestatus"  class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="myButtonBatch('change_status');"  value="Change status"/>
									<input type="button" id="my_button_changeoffpeak" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="myButtonBatch('change_offpeak');" value="Change off-peak"/>

		</div>
    </div>
	<table id="my_table" class="ibm-data-table ibm-altrows" > </table>     
    <!-- ================================================================= page ends -->
    
	<!-- ================================================================= form starts -->   
     <div id="my_batch_form" class="ibm-common-overlay" data-widget="overlay" data-type="alert">
    		<h3 id="my_batch_num_selected" class="ibm-h3">0 schedules are selected.</h3>
    		<br />
    		<p>
    			<label class="ibm-column-field-label" for="my_batch_ops_selected">Selected action: <span class="ibm-required">*</span> &nbsp;&nbsp;</label>
    			<span> <select disabled style="color: rgb(153, 153, 153);" id="my_batch_ops_selected" >
		            <option value="change_status" >Change status</option>
		            <option value="change_offpeak">Change off-peak</option>
					<option value="rerun" 		 >Rerun</option>    		
 			</select> </span>
 		</p>
    		<p>Please be sure about the change on selected schedules.</p>
    		<br />
    		<div id="my_batch_ops_change_status" name="my_batch_operation">
    				<label class="ibm-column-field-label" for="my_select_status"> Available options:&nbsp;&nbsp;</label>
										<span><select id="my_select_status" title="category" >
								            <option value="A" >Active</option>
											<option value="I" >Inactive</option>
											<option value="E" >Expired</option>
							                <option value="S" >Suspended</option>
							                <option value="D" >Disabled</option>									
										</select> </span>
		</div>
		<div id="my_batch_ops_change_offpeak" name="my_batch_operation">
				<label class="ibm-column-field-label" for="my_select_offpeak"> Available options:&nbsp;&nbsp;</label>
										<span><select id="my_select_offpeak" title="category" >
											<option value="N" >Peak</option>
											<option value="Y" >Off-peak</option>
											<option value="A" >Off-peak by admin</option>		
										</select></span>	
		</div>										
    		<br />
    		<br />
		<p class='ibm-btn-row ibm-center'>
			<button class='ibm-btn-pri ibm-btn-blue-50 ibm-btn-small' onclick='myButtonBatchOk();'     >OK</button> 
			<button class='ibm-btn-sec ibm-btn-blue-50 ibm-btn-small' onclick='myButtonBatchCancel();' >Cancel</button> 
		</p>
 	</div>	 	
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
        	function myButtonBatch(operation){
 			var postData = []; 
  			jQuery("tr.ibm-row-selected").each(function (index, item) {
				postData.push(  { "requestId":jQuery(item).attr("data-eod-requestId") }  );
			});
			if (postData.length < 1) {
				myMessage("please select at least 1 schedule");
  				return false;
			} else {
				jQuery("#my_batch_ops_selected").val(operation); 
				jQuery("#my_batch_num_selected").text( postData.length+" schedule(s) are selected.");   
				jQuery("div[name='my_batch_operation']").hide();
				jQuery("#my_batch_ops_"+operation).show(); 
				IBMCore.common.widget.overlay.show("my_batch_form");
			}
        }
		function myButtonBatchOk(){  
            var postData  = {};
            var schedules = [];
            var errMsg    = ""; 	
			var operation = jQuery("#my_batch_ops_selected").val();
			if (operation === undefined || operation === "") {
                myMessageError("What happened?!");  
                return false;
            }
  			jQuery("tr.ibm-row-selected").each(function (index, item) {
  				schedules.push( { "requestId":jQuery(item).attr("data-eod-requestId") } );
			});
			if (schedules.length < 1) {
				myMessage("please select at least 1 schedule");
  				return false;
			}  
            switch (operation) {       
				case "change_status": {
                		var newStatus        = jQuery( jQuery("#my_select_status" ).find("option:selected").get(0) ).val(); //should be only 1
                		postData["status"]   = newStatus; 
            			break;}   
				case "change_offpeak": {
	            		var newOffpeak       = jQuery( jQuery("#my_select_offpeak").find("option:selected").get(0) ).val(); //should be only 1
	            		postData["offpeak"]  = newOffpeak; 
	        			break;}   				
				case "rerun": {
					//none 
					break;}  
                default: {
                    errMsg="We cannot proceed with this operation="+operation;
                    break; }
            }
            if (errMsg !== "") {
                myMessageError(errMsg);
                return false;
            } 
            jQuery("tr.ibm-row-selected").each(function (index, item) {
            		//------------special checking on each 
            				//we are good here, N/A right now 
            		//------------status checking 
                if (operation == "change_status") {
						//we are good here 
                } else {
                    var tmp = jQuery(item).attr("data-eod-requeststatus") + "";
                    if (tmp === "A" || tmp === "I" || tmp === "E") {
						//we are good here 
                    } else {
                    		errMsg = "Failed to perform this operation as status of some selected schedules is not valid. ("+tmp+") " ;
                    		return false;
                    }
                }  
            })
            if (errMsg !== "") {
                myMessageError(errMsg);
                return false;
            }             
            myButtonBatchCancel(); 
            postData["operation"]  =operation; 
            postData["csr"]        =schedules; 
            postData["reportName"] =jQuery("#my_report_name"  ).val().trim();
            postData["triggerCode"]=jQuery("#my_trigger_code" ).val().trim();
            postData["requestId"]  =jQuery("#my_request_id"   ).val().trim();
            postData["ownerCwa"]   =jQuery("#my_owner_cwa"    ).val().trim();
            myButtonBatchAjax(postData);             
		}
		function myButtonBatchCancel(){  
			var theOverlayId = IBMCore.common.widget.overlay.getWidget("my_batch_form").getId();
			IBMCore.common.widget.overlay.hide(theOverlayId, true); 
		}	
        function myButtonBatchAjax(postData){
        		var searchText = jQuery("#my_table_filter").find("input[type='search']").val();  
        		var orderArr   = jQuery("#my_table").DataTable().order();
        	
            jQuery("#my_table").empty();
            jQuery("#my_table").append(                                                          "<img src='" + myContext + "/images/ajax-loader.gif' />");       	
			myMessage(postData["csr"].length + " selected schedules, submitted for processing ... <img src='" + myContext + "/images/ajax-loader.gif' />");

            jQuery.ajax({
					headers: { Accept: "application/json; charset=utf-8" },
					url: myContext + "/action/admin/csrStsChg/batchUpdate?timeid="+(new Date()).valueOf(),
					type: 'POST',
					data: JSON.stringify(postData),
					dataType: "json",
					contentType: "application/json; charset=utf-8"
                })
                .done(function (data) {
					if (data.msg === "success") {
						myMessage("processing is done on the selected schedules. ");					
						myPageDraw(data.csr);
			            //--------restoring: order/search/selection/hidden 
			            jQuery("#my_table").DataTable().order( orderArr ).draw();
			            if ( Object.prototype.toString.call(postData.csr) === '[object Array]' ) {
			 				if (searchText !== "")              jQuery("#my_table_filter").find("input[type='search']").val(searchText).keyup();            
			            		for (var selected in postData.csr)  jQuery("#my_checkbox_"+postData.csr[selected]["requestId"]).click(); 
			            }
						myPageDrawTableHideHiddenRows();
						return true; 
					} else { 
						myMessageError(data.msg);  
						return false; 
					}
                })
                .fail(function (jqXHR, textStatus, errorThrown) {
                    console.log("ajax error in loading...jqXHR..." + JSON.stringify(jqXHR));
                    console.log("ajax error in loading...textStatus..." + textStatus);
                    console.log("ajax error in loading...errorThrown..." + errorThrown);  
                    myMessageError("ajax error in loading..." + errorThrown);  
              		return false;       
                })
                .always(function () {});
        } 		
		
        	function myButtonSearch(){
        		var myReportName  =jQuery("#my_report_name" ).val().trim();
        		var myOwnerCwa    =jQuery("#my_owner_cwa"   ).val().trim();
        		var myTriggerCode =jQuery("#my_trigger_code").val().trim();
        		var myRequestId   =jQuery("#my_request_id"  ).val().trim();

    			if (myReportName == "") {
    				myMessageError("report name cannot be empty. "); 
    				return false; 
    			}
     			
    			myMessage("submitted for processing ... <img src='" + myContext + "/images/ajax-loader.gif' />");
        	
			jQuery.get(
				myContext + "/action/admin/csrStsChg/search?timeid="+(new Date()).valueOf()+"&reportName="+myReportName+"&triggerCode="+myTriggerCode+"&requestId="+myRequestId+"&ownerCwa="+myOwnerCwa  
    			).done(function (data) {
    				if (data.msg === "success") {
    					myHiddenRows = []; //clear the count of hidden rows 
    					myPageDraw(data.csr);
    					IBMCore.common.widget.overlay.hideAllOverlays();
    				} else {
    					myMessageError(data.msg);  
    				}	
    			}).fail(function (jqXHR, textStatus, errorThrown) {
				console.log("ajax error in loading...jqXHR..."       + JSON.stringify(jqXHR));
				console.log("ajax error in loading...textStatus..."  + textStatus);
				console.log("ajax error in loading...errorThrown..." + errorThrown);
				myMessageError(           "ajax error in loading..." + errorThrown);
    			})
        }
 		function myButtonShowhide() {
    			if (jQuery("#my_table").length === 1 && jQuery("#my_tbody").length === 1 ) {	
    				var domRows  = jQuery("#my_table").DataTable().rows().nodes().to$();   
    				//=====================================================toggle 
    				var rowSelected  = jQuery("#my_tbody > tr.ibm-row-selected:visible");	
    				var rowShowed    = jQuery("#my_tbody > tr:visible");
    				if (rowSelected.length < 1 || rowSelected.length === rowShowed.length) {
    					//-----------If ammong showed ZERO selected,  then show every single row
    					//-----------If all showed are selected,      then show every single row					
    					jQuery.each(domRows, function(index,element) {   jQuery(element).show();   }); 	
    					myHiddenRows = []; //clear the count of hidden rows 
    				} else {
    					//----------If there are un-selected, hide the un-selected
    					rowShowed.each(function(){    
    						if (!jQuery(this).hasClass("ibm-row-selected")) {  
    							jQuery(this).hide();  
    							myHiddenRows.push(jQuery(this).attr("data-eod-requestId")); //save the hidden rows
    						}    
    					}) 
    				}
    				jQuery("#my_table_filter").find("input[type='search']").click(); 
    				//=====================================================popup info 
    				var domTrHiddenNum  = 0;  
    				var domTrVisibleNum = 0;  	
    				jQuery.each(domRows, function(index,element) {
    					if (jQuery(element).css('display')==='none') domTrHiddenNum  += 1; 
    					else                                         domTrVisibleNum += 1; 
    				}); 
    				var domTrShowedNum   = jQuery("#my_tbody > tr:visible").length;
    				var domTrSelectedNum = jQuery("#my_tbody > tr.ibm-row-selected:visible").length;		
    				var domSearchText = jQuery("#my_table_filter").find("input[type='search']").val(); 
    				//-----------popup message 
    				var message = "There are " + (domTrHiddenNum+domTrVisibleNum) + " schedules. "; 
    				message += domTrHiddenNum   +" hidden. "; 
    				message += domTrVisibleNum  +" visible. <br>"; 
    				message += "Among visible ones, "; 
    				if (domSearchText === "") message += "no search keywords, "; 
    				else                      message += "search words are <span style='text-decoration:underline;'>"+domSearchText+"</span>, "; 
    				message += domTrShowedNum   +" showed, "; 
    				message += domTrSelectedNum +" selected. <br>"; 				
    				//-----------popup action 
    				console.log(message); //to console for now
    			} else {
    				console.log("no rows to work on");
    			}
		}
       	
        	//=============================================
        function myPageDrawTableHideHiddenRows() {
            if ( Object.prototype.toString.call(myHiddenRows) === '[object Array]' ) {
	    			jQuery.each(myHiddenRows, function(index,element) {
	    				jQuery("#my_tr_"+element).hide(); 
	    			});  
            }
        }        		
       	function myPageDraw(data) {
            var nodes = eval(data);
			var length = nodes.length;
			jQuery("#my_table").empty();
			jQuery("#my_table").append("<thead id='my_thead'></thead><tbody id='my_tbody'></tbody>");
			jQuery("#my_thead").append("<tr>"+
					"<th scope='col'><span class='ibm-checkbox-wrapper'><input id='my_checkbox' type='checkbox' class='ibm-styled-checkbox'/><label for='my_checkbox' ><span class='ibm-access'>Select all</span></label></span> </th>"+
					"<th>Report Name</th><th>Trigger Code</th><th>e-Mail Subject</th><th>e-Mail Address</th><th>Status</th><th>Off-peak</th><th>XML</th><th>Last status</th><th>Last date</th><th>Last duration(S)</th>"+
					"</tr>"); 
			for (var i = 0; i < length; i++) myPageDrawRow(nodes[i]); 
			myPageDrawTableInit(); 
       	}        		
       	function myPageDrawTableInit() {
            var myDtSettings = {
					destroy: true, 		// allow re-initiate the table
					colReorder: false, 	// true | false (default)	// Let the user reorder columns (not persistent) 
					info: false,			// true | false (default)	// Shows "Showing 1-10" texts 
					ordering: true, 		// true | false (default)	// Enables sorting 
					paging: false, 		// true | false (default)	// Enables pagination 
					scrollaxis: false, 	// x 						// Allows horizontal scroll 
					searching: true 		// true | false (default)	// Enables text filtering	
                };  
			var myOrderableFalse = '{"targets": [0], "orderable": false}'; 
			myDtSettings.columnDefs 	= [JSON.parse(myOrderableFalse)];      
			myDtSettings.order		= eval("[[2,'asc']]"); 
			jQuery("#my_table").DataTable(myDtSettings);			
			jQuery("#my_table").tablesrowselector();

       	}
        function myPageDrawRow(node) {
            var tmp = "";
            for (var item in node) {
                tmp = tmp + " data-eod-" + item + "='" + escape(node[item]) + "' ";
            }
            jQuery("#my_tbody").append(
				"<tr id='my_tr_"+node["requestId"]+"' " + tmp + " >" + 
				"<td scope='row'> <span class='ibm-checkbox-wrapper'> "+
					"<input  id='my_checkbox_" + node["requestId"] +"' type='checkbox' class='ibm-styled-checkbox'/> "+
					"<label for='my_checkbox_" + node["requestId"] +"' > <span class='ibm-access'>Select One</span> </label> " +
				"</span> </td>" +
				"<td>"+node["rptName"]+"</td>" + 
				"<td>"+node["triggerCd"]+"</td>" +
				"<td>"+node["emailSubject"]+"</td>"+
				"<td>"+node["emailAddress"]+"</td>"+
				"<td>"+myWordExpansionStatus[node["requestStatus"]]+"</td>"+
				"<td>"+myWordExpansionOffpeak[node["offpeak"]]+"</td>" + 
				"<td>"+myPageFormatPrompts(node)+"</td>" + 
				myPageFormatLastRun3Columns(node) + 
				"</tr>"
            );
		}   
        
        function myPageFormatPrompts(node) {
        		return "<a target='_blank' href='"+myContext+"/action/admin/csrStsChg/getXmlFile/"+node["requestId"]+"?timeid="+(new Date()).valueOf()+"'>Download</a>";
    		}       
        function myPageFormatLastRun3Columns(node) {
            var theStatus   = node["lastStatus"];
            var theRunTime  = node["lastRunTime"];
            var theUsedTime = node["lastUsertime"];
            var count       = node["totalCount"];
            var formattedStr = "<td></td><td></td><td></td>";
            var tmp          = ""; 

            if (count === null) {
 
            } else if (count + "" === "") {
 
            } else if (count < 1) {
 
            } else {
            		//------------last status 
                theStatus = jQuery.trim(theStatus);
                if (theStatus === "101" || theStatus === "100") {
                		//Success----we have download-able outputs 
					formattedStr = "Successful";
                } else if ( theStatus === "111" || theStatus === "200" || theStatus === "400" ) { 
                		//Failure----we don't have files to download 
					formattedStr = "<a href='"+myContext+"/action/portal/schedulePanel/getErrLogPage/"+node.lastRunningId+"?timeid="+(new Date()).valueOf()+"' target='_blank' '>Failed("+theStatus+")</a>";
                } else if (theStatus === "300") { 
                		//Running 
                    formattedStr = "Running";
                } else {
                		//Warning?
                		//currently only 6 status codes from help page  
                		//so new status codes will fall into this category 
                    formattedStr = "Other("+theStatus+")";
                }
                formattedStr = "<td>"+formattedStr+"</td>"; 
				//------------last run time
				tmp = (theRunTime === null) ? "" : myPageFormatDate(theRunTime);
				formattedStr = formattedStr+"<td>"+tmp+"</td>"; 
				//------------last used time
				formattedStr = formattedStr+"<td>"+node["lastUsertime"]+"</td>"; 
            }
            return formattedStr;
    		}     
        function myPageFormatDate(timestamp) {
            var myNewDate = new Date();
            myNewDate.setTime(timestamp);
            return myNewDate.getFullYear() + "-" + (myNewDate.getMonth() + 1) + "-" + myNewDate.getDate() + " " + myNewDate.getHours() + ":" + myNewDate.getMinutes() + ":" + myNewDate.getSeconds();
        }   
    </script>
    <!-- ================================================================= custom JavaScript codes end -->
</body>

</html>