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
    <title>BI@IBM | Transfer owner of Cognos schedules, Autodeck schedules, and XLS inputs</title>
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
            margin-bottom: 20px;
        }
        /* ====================== only for this page */
        
    </style>   
    <script type="text/javascript">
        window.$ = window.jQuery;
        var myContext = "<%=request.getContextPath()%>";
        var myCwa = "${cwa_id}";
        var myUid = "${uid}";    
	</script>
    <!-- ================================================================= custom page JS and CSS end -->
</head>

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>

	<!-- ================================================================= page starts -->
	<div class="ibm-columns">
		<div class="ibm-col-6-6">
			<h1  id="ibm-pagetitle-h1" class="ibm-h1 ibm-light">Transfer owner of Cognos schedules, Autodeck schedules, and XLS inputs</h1>
		</div>
		<div class="ibm-col-6-6">
			<ul data-widget="twisty" class="ibm-twisty">
			    <li>
			        <span class="ibm-twisty-head">
			            <strong>Key notes</strong>
			        </span>
			        <div class="ibm-twisty-body">
			            <p>(*) in the end user UI, schedule owners can do ownership maintenance by themselves now, so we shouldn't be using this panel a lot.  </p>
			            <p>(*) there are some rare situations that the owners leave without transferring the schedules to corresponding colleagues, <strong>for such scenarios we can use this panel</strong>.  </p>
			            <p>(*) this action will transfer ownership of all schedules, to the found intranet id in our system, according to the input from uid.  </p>
			            <p>(*) this action will send a mail to the new owner copying the admin who takes this action.  </p>
			            <p>(*) this action will set previous owner as the backup owner just in case.  </p>
			        </div>
			    </li>
			</ul>				
		</div>
		<div class="ibm-col-6-6">
			<form class="ibm-column-form" >
			    <div class="ibm-columns">
			            <p>
							<label for="my_from_uid">&nbsp;&nbsp;&nbsp;&nbsp;From UID:<span class="ibm-required">*</span></label>
							<span><input type="text" value="" size="15" id="my_from_uid" name="my_uid_text" ></span>
			            </p>
			            <p>
							<label for="my_to_uid"  >&nbsp;&nbsp;&nbsp;&nbsp;To UID:  <span class="ibm-required">*</span></label>
							<span><input type="text" value="" size="15" id="my_to_uid"   name="my_uid_text" ></span>
			            </p>
			            <p>
			            		<br>
			            		&nbsp;&nbsp;&nbsp;&nbsp;
							<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="myTransfer();"> Transfer </a>
			            </p>		        
			    </div>
			</form>   
			<br>
			<br>   
		</div>
		
    </div>
    <!-- ================================================================= page ends -->
    
	<!-- ================================================================= form starts -->   
 	<div id="my_form" class="ibm-common-overlay ibm-overlay-alt" data-widget="overlay" data-type="alert">
 		<p>
 			<p id="my_msg"></p>
 			<br>
 			<table class="dataTable">
 				 <thead>
		 			<tr> <th colspan="2">new owner</th>  </tr>		
	 			</thead>
	 			<tbody>
		 			<tr> <td>To UID:</td> <td><span id="my_toUid" name="my_show_text" ></span></td> </tr>
		 			<tr> <td>To CWA:</td> <td><span id="my_toCwa" name="my_show_text" ></span></td> </tr> 			
	 			</tbody>
 			</table>
 			<br>
 			<table class="dataTable">
 			 	<thead>
		 			<tr> <th colspan="2">current owner</th>  </tr>		
	 			</thead>
 			<tbody>			
	 			<tr><td>From UID:</td>                     <td><span id="my_fromUid"    name="my_show_text" ></span></td> </tr>
	 			<tr><td>From CWA:</td>                     <td><span id="my_fromCwa"    name="my_show_text" ></span></td> </tr>
	 			<tr><td>Count of Cognos schedules:</td>    <td><span id="my_countOfCsr" name="my_show_text" ></span></td> </tr>
	 			<tr><td>Count of Autodeck schedules: </td> <td><span id="my_countOfAsr" name="my_show_text" ></span></td> </tr>
	 			<tr><td>Count of XLS inputs:</td>          <td><span id="my_countOfXls" name="my_show_text" ></span></td> </tr>
 			</tbody></table> 	
 			<br>		
		</p>
 		
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" id="myFormOk"     onclick="myFormOk();"     >OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" id="myFormCancel" onclick="myFormCancel();"	>Cancel</button>  	
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
        	function myTransfer(){
        		var myFromUid =jQuery("#my_from_uid").val().trim();
        		var myToUid   =jQuery("#my_to_uid"  ).val().trim();

    			if (myFromUid == "") {
    				myMessageError("From UID cannot be empty. "); 
    				return false; 
    			}
    			if (myToUid == "") {
    				myMessageError("To UID cannot be empty. "); 
    				return false; 
    			}    	
    			if (myToUid == myFromUid) {
    				myMessageError("To UID and from UID cannot be the same. "); 
    				return false; 
    			}       			
    			myMessage("submitted for processing ... <img src='" + myContext + "/images/ajax-loader.gif' />");
        	
			jQuery.get(
				myContext + "/action/admin/csrOwnTran/getSummary?timeid="+(new Date()).valueOf()+"&fromUid="+myFromUid+"&toUid="+myToUid 
    			).done(function (data) {
    				
    				IBMCore.common.widget.overlay.hideAllOverlays();
    				if (data["msg"] === "success") {
    					jQuery("#my_fromUid"   ).text(data["fromUid"]); 
    					jQuery("#my_fromCwa"   ).text(data["fromCwa"]); 
    					jQuery("#my_toUid"     ).text(data["toUid"]); 
    					jQuery("#my_toCwa"     ).text(data["toCwa"]); 
    					jQuery("#my_countOfCsr").text(data["countOfCsr"]); 
    					jQuery("#my_countOfAsr").text(data["countOfAsr"]); 
    					jQuery("#my_countOfXls").text(data["countOfXls"]); 
    					
    					jQuery("#my_msg"  ).text("Please click OK button to go on with the transferring."); 
    					jQuery("#my_msg"  ).removeClass();
    					jQuery("#my_msg"  ).addClass("ibm-textcolor-default ibm-h2 ibm-center"); 
    					jQuery("#myFormOk").show(); 
    				} else {
    					jQuery("#my_form").find("span[name='my_show_text']").text(""); 
    					
    					jQuery("#my_msg"  ).text(data["msg"]); 
    					jQuery("#my_msg"  ).removeClass();
    					jQuery("#my_msg"  ).addClass("ibm-textcolor-red-60 ibm-h2 ibm-center"); 
    					jQuery("#myFormOk").hide(); 
    				}	
    				IBMCore.common.widget.overlay.show("my_form");
    				
    			}).fail(function (jqXHR, textStatus, errorThrown) {
				console.log("ajax error in loading...jqXHR..."       + JSON.stringify(jqXHR));
				console.log("ajax error in loading...textStatus..."  + textStatus);
				console.log("ajax error in loading...errorThrown..." + errorThrown);
				myMessageError(           "ajax error in loading..." + errorThrown);
    			})
        	
        }
        function myFormOk() {
	    		var myData = {}; 
	    		myData["fromUid"]=jQuery("#my_fromUid").text().trim();
	    		myData["fromCwa"]=jQuery("#my_fromCwa").text().trim();
	    		myData["toUid"]  =jQuery("#my_toUid"  ).text().trim();
	    		myData["toCwa"]  =jQuery("#my_toCwa"  ).text().trim();
	    		
	    		myFormCancel(); 
	    		myMessage("submitted for processing ... <img src='" + myContext + "/images/ajax-loader.gif' />");
	    		
			jQuery.ajax({
	                url: myContext + "/action/admin/csrOwnTran/submitTransfer?timeid="+(new Date()).valueOf(), 
	                type: 'POST',
	                data: JSON.stringify(myData),
	                dataType: "json",
	                contentType: "application/json; charset=utf-8"                
			})
			.done(function (data) {
					if (data.msg === "success") {
						IBMCore.common.widget.overlay.hideAllOverlays();
						
	    					jQuery("#my_fromUid"   ).text(data["fromUid"]); 
	    					jQuery("#my_fromCwa"   ).text(data["fromCwa"]); 
	    					jQuery("#my_toUid"     ).text(data["toUid"]); 
	    					jQuery("#my_toCwa"     ).text(data["toCwa"]); 
	    					jQuery("#my_countOfCsr").text(data["countOfCsr"]); 
	    					jQuery("#my_countOfAsr").text(data["countOfAsr"]); 
	    					jQuery("#my_countOfXls").text(data["countOfXls"]); 
	    					
	    					jQuery("#my_msg"  ).text("owner transferring is done successfully"); 
	    					jQuery("#my_msg"  ).removeClass();
	    					jQuery("#my_msg"  ).addClass("ibm-textcolor-blue-60 ibm-h2 ibm-center"); 
	    					jQuery("#myFormOk").hide(); 
	    					
	    					IBMCore.common.widget.overlay.show("my_form");
					} else {
						myMessage(data["msg"]);
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

    </script>
    <!-- ================================================================= custom JavaScript codes end -->
</body>

</html>