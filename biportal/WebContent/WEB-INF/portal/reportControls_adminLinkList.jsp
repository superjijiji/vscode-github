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
    <title>BI@IBM | Manage portal links</title>
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
            margin-bottom: 20px;
        }        
    </style>
    <script type="text/javascript">
        window.$ = window.jQuery;
        var myContext = "<%=request.getContextPath()%>";
        var myCwa = "${cwa_id}";
        var myUid = "${uid}";
        var myBase= "${baseUrl}";         
	</script>
    <!-- ================================================================= custom page JS and CSS end -->
</head>

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>

	<!-- ================================================================= page starts -->
	<div class="ibm-columns">
		<div class="ibm-col-6-6">
			<h1  id="ibm-pagetitle-h1" class="ibm-h1 ibm-light">Manage portal links</h1>
			<div id="my_err"></div>
		</div>
		<div class="ibm-col-6-6">
	            <div class="ibm-btn-row ibm-right">
	            		<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="myCreate();"> Add a link </a>  
					<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="myUpdate();"> Edit a link </a>   	            		
					<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="IBMCore.common.widget.overlay.show('my_confirmation_delete');"> Delete a link </a>    
					<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" href="<%=path%>${baseUrl}${folderUrl}?backUrl=<%=path%>${baseUrl}${listUrl}"> Manage folders </a> 				             
	            </div>         
		</div>
		<div class="ibm-col-6-6">
			<table id="my_table" class="ibm-data-table ibm-altrows">
				<thead id="my_thead">
				</thead>
				<tbody id="my_tbody" >
				</tbody>
			</table>
	    </div>    
    </div>
    <!-- ================================================================= page ends -->
    
	<!-- ================================================================= form starts -->   
  	<div id="my_form" class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert">
		<div style="display:flex; justify-content:center; align-items:center;"><table><tbody>
				<tr>
			        <td><label for="__REPLACE_ME_0__">Id:</label></td>
			        <td>&nbsp;&nbsp;</td> 
			        <td><span id="my_form_id"></span></td> 
				</tr>
			    <tr>
			        <td><label for="my_form_name">Name:<span class="ibm-required">*</span></label></td>
			        <td> </td> 
			        <td><span>
			            <input id="my_form_name" type="text" value="" size="80" name="my_form_input">
			        </span></td>
			    </tr>
			    <tr>
			        <td><label for="my_form_role">Role:<span class="ibm-required">*</span></label></td>
			        <td> </td> 
			        <td><span>
			            <input id="my_form_role" type="text" value="" size="80" name="my_form_input">
			        </span></td>
			    </tr>		
			    <tr>
			        <td><label for="my_form_tip">Tip:<span class="ibm-required">*</span></label></td>
			        <td> </td> 
			        <td><span>
			            <input id="my_form_tip"  type="text" value="" size="80" name="my_form_input">
			        </span></td>
			    </tr>	
			    <tr>
			        <td><label for="my_form_url">URL:<span class="ibm-required">*</span></label></td>
			        <td> </td> 
			        <td><span>
			            <input id="my_form_url"  type="text" value="" size="80" name="my_form_input">
			        </span></td>
			    </tr>	
			    <tr>
			        <td><label for="my_form_module">Module:<span class="ibm-required">*</span></label></td>
			        <td> </td> 
			        <td><span>
			            <input id="my_form_module" type="text" value="" size="80" name="my_form_input">
			        </span></td>
			    </tr>
			    <tr>
			        <td><label for="my_form_buttongroup1">Button&nbsp;bluegroup&nbsp;1:</label></td>
			        <td> </td> 
			        <td><span>
			            <input id="my_form_buttongroup1" type="text" value="" size="80" maxlength="128" name="my_form_input">
			        </span></td>
			    </tr>
			    <tr>
			        <td><label for="my_form_buttongroup2">Button&nbsp;bluegroup&nbsp;2:</label></td>
			        <td> </td> 
			        <td><span>
			            <input id="my_form_buttongroup2" type="text" value="" size="80" maxlength="128" name="my_form_input">
			        </span></td>
			    </tr>
			    <tr>
			        <td><label for="my_form_buttongroup3">Button&nbsp;bluegroup&nbsp;3:</label></td>
			        <td> </td> 
			        <td><span>
			            <input id="my_form_buttongroup3" type="text" value="" size="80" maxlength="128" name="my_form_input">
			        </span></td>
			    </tr>
			    <tr>
			        <td><label for="my_form_buttongroup4">Button&nbsp;bluegroup&nbsp;4:</label></td>
			        <td> </td> 
			        <td><span>
			            <input id="my_form_buttongroup4" type="text" value="" size="80" maxlength="128" name="my_form_input">
			        </span></td>
			    </tr>	    			    			    	    
		</tbody></table></div>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="myFormOk();"		>OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="myFormCancel();"	>Cancel</button>  	
 		</p>
 	</div>   
 	
 	<div id="my_confirmation_delete" class="ibm-common-overlay ibm-overlay-alt" data-widget="overlay" data-type="alert">
 		<p class="ibm-center">Click on OK to confirm that the selected should be removed.</p>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="myDeleteOk();"	>OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="myDeleteCancel();"	>Cancel</button>  	
 		</p>
 	</div>   	
    <!-- ================================================================= form ends --> 
    <jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
    <!-- ================================================================= custom JavaScript codes start -->
    <script type="text/javascript">
        //=============================================myMessage* 
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
        //=============================================myCRUD
        function myFormOk() {
			var myId  =jQuery("#my_form_id"    ).text(); 
			var myName=jQuery("#my_form_name"  ).val().trim();
			var myRole=jQuery("#my_form_role"  ).val().trim();
			var myTip =jQuery("#my_form_tip"   ).val().trim();
			var myUrl =jQuery("#my_form_url"   ).val().trim();
			var myMod =jQuery("#my_form_module").val().trim();
			var myLink={}; 
			//--------validation 			
			if (myId === "NEW") {
				//it's to create a new one, don't set id in the obj
			} else {
				//the span is controlled by our codes, it's always valid. 
				myLink["id"]=myId; 
			}
			if (myName == "") {
				myMessageError("name cannot be empty"); 
				return false; 
			} else {
				if (myName.length > 255) {
					myMessageError("name cannot be longer than 255 characters."); 
					return false; 
				} else {
					myLink["name"]=myName; 
				}
			}
			if (myRole == "") {
				myMessageError("role cannot be empty"); 
				return false; 
			} else {
				if (myRole.length > 30) {
					myMessageError("role cannot be longer than 30 characters."); 
					return false; 
				} else {
					myLink["role"]=myRole; 
				}
			}	
			if (myTip == "") {
				myMessageError("tip cannot be empty"); 
				return false; 
			} else {
				if (myName.length > 255) {
					myMessageError("tip cannot be longer than 255 characters."); 
					return false; 
				} else {
					myLink["tip"]=myTip; 
				}
			}
			if (myUrl == "") {
				myMessageError("url cannot be empty"); 
				return false; 
			} else {
				if (myUrl.length > 255) {
					myMessageError("url cannot be longer than 255 characters."); 
					return false; 
				} else {
					myLink["url"]=myUrl; 
				}
			}	
			if (myMod == "") {
				myMessageError("module cannot be empty"); 
				return false; 
			} else {
				if (myMod.length > 10) {
					myMessageError("module cannot be longer than 10 characters."); 
					return false; 
				} else {
					myLink["module"]=myMod; 
				}
			}			
			myLink["buttonGroup1"] =jQuery("#my_form_buttongroup1").val().trim();
			myLink["buttonGroup2"] =jQuery("#my_form_buttongroup2").val().trim();
			myLink["buttonGroup3"] =jQuery("#my_form_buttongroup3").val().trim();
			myLink["buttonGroup4"] =jQuery("#my_form_buttongroup4").val().trim();
			var links = jQuery("#my_table").DataTable().rows().nodes().to$();  
			var row; 
			var err=""; 
			jQuery.each(links, function(index,element) {  
				row = jQuery(element); 
				if (escape(myName) === row.attr("data-eod-name") ) { //currently this is a unique key in EOD.LINK
					if (      myId === row.attr("data-eod-id"  ) +"" ) {
						//it is itself 
					} else {
						err="name cannot be the same, we already have a '"+myName+"', id is "+row.attr("data-eod-id") ; 
						return false; //quit the each loop
					}
				}				
			}); 
			if (err !="") {
				myMessageError(err); 
				return false; 
			}
			//--------ajax
			myFormCancel(); //close the form
			myMessage("submitted for processing ... <img src='" + myContext + "/images/ajax-loader.gif' />");
			var myUrl = ""; 
			if (myId === "NEW") {
				myUrl = myContext + myBase              + "?timeid=" + (new Date()).valueOf(); 
			} else {
				myUrl = myContext + myBase + "/" + myId + "?timeid=" + (new Date()).valueOf(); 
			}	
            jQuery.ajax({
                url: myUrl, 
                type: 'POST',
                data: JSON.stringify(myLink),
                dataType: "json",
                contentType: "application/json; charset=utf-8"                
            })
            .done(function (data) {
				if (data.msg === "success") {
					jQuery('#my_table').DataTable().destroy();
					
					if (myId === "NEW") { 
						myMessage("the link is created."); 
						myPageDrawRow(data.link); 		
					} else {
						myMessage("the link is updated."); 
						jQuery("#my_tr_"+myId).remove(); 
						myPageDrawRow(data.link); 
					}
					
					myPageDrawTableInit(); 
					jQuery("#my_table_filter").find("input[type='search']").val(data.link.name).keyup(); 
				} else {
					myMessageError(data.msg);  
				}
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
				console.log("ajax error in loading...jqXHR..." 		+ JSON.stringify(jqXHR));
				console.log("ajax error in loading...textStatus..." 	+ textStatus);
				console.log("ajax error in loading...errorThrown..." 	+ errorThrown);  
				myMessageError("ajax error in loading..." 			+ errorThrown);  
				return false;       
            })				
        }        
        
        function myFormCancel() {
			var theOverlayId = IBMCore.common.widget.overlay.getWidget("my_form").getId();
			IBMCore.common.widget.overlay.hide(theOverlayId, true);    
        }         
        
        function myCreate() {
			jQuery("#my_form_id").text("NEW"); 
			jQuery("input[name='my_form_input']").val(""); 
			IBMCore.common.widget.overlay.show("my_form");     
        }         
       	function myRetrieveAll() {
            jQuery("#my_err"  ).empty();
            jQuery("#my_tbody").empty();
            jQuery("#my_tbody").append("<img src='" + myContext + "/images/ajax-loader.gif' />");    
            jQuery.get(
            		myContext + myBase + "?timeid=" + (new Date()).valueOf() 
			).done(function (data) {
				if (data.msg === "success") {
					myPageDraw(data.links);
				} else {
					myMessageError(data.msg);  
				}				
			}).fail(function (jqXHR, textStatus, errorThrown) {
                    console.log("ajax error in loading...jqXHR..."       + JSON.stringify(jqXHR));
                    console.log("ajax error in loading...textStatus..."  + textStatus);
                    console.log("ajax error in loading...errorThrown..." + errorThrown);
                    myMessageError(           "ajax error in loading..." + errorThrown);
                    jQuery("#my_err").empty();
                    jQuery("#my_err").append( "ajax error in loading..." + errorThrown);
			})
		}     
        function myUpdate() {
			var selected = jQuery("input[name='my_radio']:checked"); 
			if (selected.length != 1) { myMessage("please select a link to edit."); return false; }
			var selectedLinkId  = jQuery(selected.get(0)).val(); 
			
			var selectedLinkRow = jQuery("#my_tr_"+selectedLinkId); 
			jQuery("#my_form_id"    ).text(selectedLinkId); 
			jQuery("#my_form_name"  ).val( unescape( selectedLinkRow.attr("data-eod-name")   )); 
			jQuery("#my_form_role"  ).val( unescape( selectedLinkRow.attr("data-eod-role")   )); 
			jQuery("#my_form_tip"   ).val( unescape( selectedLinkRow.attr("data-eod-tip" )   )); 
			jQuery("#my_form_url"   ).val( unescape( selectedLinkRow.attr("data-eod-url" )   )); 
			jQuery("#my_form_module").val( unescape( selectedLinkRow.attr("data-eod-module") ));
			jQuery("#my_form_buttongroup1").val( unescape( selectedLinkRow.attr("data-eod-buttongroup1") ));
			jQuery("#my_form_buttongroup2").val( unescape( selectedLinkRow.attr("data-eod-buttongroup2") ));
			jQuery("#my_form_buttongroup3").val( unescape( selectedLinkRow.attr("data-eod-buttongroup3") ));
			jQuery("#my_form_buttongroup4").val( unescape( selectedLinkRow.attr("data-eod-buttongroup4") )); 
			IBMCore.common.widget.overlay.show("my_form"); 
        }     
        function myDeleteCancel() {
			var theOverlayId = IBMCore.common.widget.overlay.getWidget("my_confirmation_delete").getId();
			IBMCore.common.widget.overlay.hide(theOverlayId, true);       	
        }
        function myDeleteOk() {
			var selected = jQuery("input[name='my_radio']:checked"); 
			if (selected.length != 1) { myMessageError("please select a link to DELETE!"); return false; }
			var selectedLinkId = jQuery(selected.get(0)).val(); 
			
			
			myDeleteCancel();
			myMessage("submitted for processing ... <img src='" + myContext + "/images/ajax-loader.gif' />");
			
            jQuery.ajax({
                url: myContext + myBase + "/" + selectedLinkId + "?timeid=" + (new Date()).valueOf(), 
                type: 'DELETE',
            })
            .done(function (data) {
				if (data.msg === "success") {
					jQuery('#my_table').DataTable().destroy();
					myMessage("the link is deleted.");  
					jQuery("#my_tr_"+selectedLinkId).remove(); 
					myPageDrawTableInit(); 
				} else {
					myMessageError(data.msg);  
				}
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
				console.log("ajax error in loading...jqXHR..." 		+ JSON.stringify(jqXHR));
				console.log("ajax error in loading...textStatus..." 	+ textStatus);
				console.log("ajax error in loading...errorThrown..." 	+ errorThrown);  
				myMessageError("ajax error in loading..." 			+ errorThrown);  
				return false;       
            })			
        }          	
		//=============================================myPageDraw
       	function myPageDraw(nodeData) {
            var nodes = eval(nodeData);
			var length = nodes.length;
			jQuery("#my_tbody").empty();
			jQuery("#my_thead").empty();
			jQuery("#my_thead").append("<tr><th>&nbsp;</th><th>Id</th><th>Name</th><th>Url</th><th>Tip</th><th>Role</th><th>Module</th></tr>"); 
			for (var i = 0; i < length; i++) myPageDrawRow(nodes[i]); 
			myPageDrawTableInit(); 
       	}
       	function myPageDrawTableInit() {
            var myDtSettings = {
        			destroy: true, 		// allow re-initiate the table
                    colReorder: false, 	// true | false (default)	// Let the user reorder columns (not persistent) 
                    info: true,			// true | false (default)	// Shows "Showing 1-10" texts 
                    ordering: true, 		// true | false (default)	// Enables sorting 
                    paging: true, 		// true | false (default)	// Enables pagination 
                    scrollaxis: true, 	// x 						// Allows horizontal scroll 
                    searching: true 		// true | false (default)	// Enables text filtering	
                };  
			var myOrderableFalse = '{"targets": [0], "orderable": false}'; 
			myDtSettings.columnDefs 	= [JSON.parse(myOrderableFalse)];      
			myDtSettings.order		= eval("[[1,'asc']]"); 
			jQuery("#my_table").DataTable(myDtSettings);				
       	}
        function myPageDrawRow(node) {
            var tmp = "";
            for (var item in node) {
            	if (node[item] == null) {
            		tmp = tmp + " data-eod-" + item + "='' ";
            	} else {
            		tmp = tmp + " data-eod-" + item + "='" + escape(node[item]) + "' ";
            	}
            }
            jQuery("#my_tbody").append(
				"<tr name='my_link_row' id='my_tr_"+node["id"]+"' " + tmp + " >" + 
				"<td> <span class='ibm-radio-wrapper'>" + 
					"<input class='ibm-styled-radio' id='my_radio_"+node["id"]+"' type='radio' value="+node["id"]+" name='my_radio' >" + 
					"<label class='ibm-field-label' for='my_radio_"+node["id"]+"' ></label>" +
				"</span></td>" + 
				"<td>"+node["id"]+"</td><td>"+myFormatUrlSample( node["name"], node["url"] )+"</td><td>"+myFormatUrlText( node["url"] )+"</td><td>"+node["tip"]+"</td><td>"+node["role"]+"</td><td>"+node["module"]+"</td>" + 
				"</tr>"
            );
        }    
        function myFormatUrlText(url) {
        		var tmp = unescape(url); 
			return (tmp.length > 77) ? tmp.substring(0,77)+"..." : tmp; 
        }
        function myFormatUrlSample(name, url) {
	    		var tmp = unescape(url); 
			var linkStr = "<a href='"+ tmp + "' title='"+ tmp + "' target='_blank'>" 
						+ name; 
						+"</a>"; 
			return linkStr; 
    		}        
        //=============================================init 
        jQuery(document).ready(function () {
        		myRetrieveAll();
        })

    </script>
    <!-- ================================================================= custom JavaScript codes end -->
</body>

</html>