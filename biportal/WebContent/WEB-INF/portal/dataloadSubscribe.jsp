<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>BI@IBM Dataload Subscription</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-columns">
		<div class="ibm-card">
			<div class="ibm-card__content">
				<strong class="ibm-h4">Dataload Status Subscription</strong>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				<b>BI@IBM Dataload Subscription Service</b><br>
				<p>
					In order to use this feature you must be a registered user of the
					BI@IBM application. Please <a
						href="http://w3-03.ibm.com/transform/worksmart/docs/Applying+for+access.html"
						target="_blank">click here</a> for information on how to request
					access if you are not already registered. This service sends an
					e-mail notification when the selected data load comes available. A
					note will be sent to the Lotus Notes e-mail address that matches
					your internet user id. To subscribe, use the checkboxes to select
					your required data load notifications. To select all data loads for
					a given IW, click the "select all entries..." check box immediately
					to the right of the IW tab name. To request notification for all
					BI@IBM data loads, use the "Check all" option at the bottom of the
					page. When done, click the "Update subscriptions" button at the
					bottom to save them and then on the "Back to BI@IBM home" link or
					the Restore option in the Portlet menu. When you return to this
					page, your current subscriptions will be shown. To remove a
					subscription, remove the checkmarks from it, then click the "Update
					subscriptions" button to save. Note that the "Reset" button will
					restore your subscription selections to their last saved state.
				</p>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>

				<form id="dl_subscribesform" class="ibm-column-form" method="post">

				</form>

				<br>
				<button id="dataload_subscribes_savebutton"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="dataload_subscribes_save()">Update subscriptions</button>
				<button id="dataload_subscribes_checkall"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="dataload_subscribes_checkall()">Check all</button>
				<button id="dataload_subscribes_uncheckall"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="dataload_subscribes_uncheckall()">Uncheck all</button>
				<button id="dataload_subscribes_reset"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="dataload_subscribes_reset()">Reset</button>
				<br> <br>
				<a href="<%=request.getContextPath()%>/"> < Back to BI@IBM home</a>
				<br />
				<br />



				<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
				<script type="text/javascript">
var space ="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

jQuery(function() {
	var timeid = (new Date()).valueOf();
	jQuery
			.ajax({
				type : "GET",
				url : "<%=request.getContextPath()%>/action/portal/dataload/getAllDataload/subs?timeid=" + timeid ,
				dataType : "json",
				success : function(data) {
					jQuery
							.each(
									data,
									function(tab, trigger) {
										var tabDesc = tab.substring(tab
												.indexOf('_') + 1, tab
												.lastIndexOf('_'));
										var tabCD = tab.substring(0, tab
												.indexOf('_'));
										var jQueryspan = "<span id='dl_subs_span_" +tabCD+ "' class='ibm-input-group'>"; 
										jQueryspan +="<lable style='display:inline-block;width:140px'>"+tabDesc+"</lable>";
										
										jQueryspan+="<input align='left' class='ibm-styled-checkbox' selectallflag='N' id='dl_subs_tab_"+tabCD+"' name='dl_subs_tab_"+tabCD+"' type='checkbox' value='"+tabCD+"' onclick='tabSelect(\""+ tabCD + "\")' /> <label for='dl_subs_tab_"+tabCD+"'>select all entries for this tab</label><br/>"
										for (var i = 0; i < trigger.length; i++) {
																						
											if(trigger[i].isSubs=="Y"){
												jQueryspan +=space+"<input class='ibm-styled-checkbox' selectedflag='Y' id='dl_subs_trigger_"+ trigger[i].triggerCD+ "' name='dl_subs_trigger_"+trigger[i].triggerCD+"' type='checkbox' value='"+trigger[i].triggerCD+"'checked /> <label for='dl_subs_trigger_"+trigger[i].triggerCD+"'>"+trigger[i].triggerDesc+"</label><br/>";
											}else{
												jQueryspan +=space+"<input class='ibm-styled-checkbox' selectedflag='N' id='dl_subs_trigger_"+ trigger[i].triggerCD+ "' name='dl_subs_trigger_"+trigger[i].triggerCD+"'  type='checkbox' value='"+trigger[i].triggerCD+"'/> <label for='dl_subs_trigger_"+trigger[i].triggerCD+"'>"+trigger[i].triggerDesc+"</label><br/>";
											}
											
										
										}
									jQueryspan +="</span><br/>"
									jQuery("#dl_subscribesform").append(jQueryspan);
										

									});
					
				

				}
			});

}

);

function dataload_subscribes_checkall()
{
	jQuery(".ibm-styled-checkbox").prop("checked", true);
	jQuery("input[selectallflag]").attr("selectallflag","Y");
}

function dataload_subscribes_uncheckall()
{
	jQuery(".ibm-styled-checkbox").prop("checked", false);
	jQuery("input[selectallflag]").attr("selectallflag","N");
}

function dataload_subscribes_reset()
{
	jQuery(".ibm-styled-checkbox").prop("checked", false);
	jQuery("input[selectedflag='Y']").prop("checked",true);
	jQuery("input[selectallflag]").attr("selectallflag","N");
}

function tabSelect(tabCD){
//	jQuery("#dl_subs_tab_"+tabCD).toggle(function(){alert('a')}, function(){jQuery("#dl_subs_tab_"+tabCD +" input").prop("checked",false)});
if(jQuery("#dl_subs_tab_"+tabCD).attr("selectallflag")=="N"){
	jQuery("#dl_subs_span_"+tabCD +" input").prop("checked",true);
	jQuery("#dl_subs_tab_"+tabCD).attr("selectallflag","Y");
}else{
	jQuery("#dl_subs_span_"+tabCD +" input").prop("checked",false);
	jQuery("#dl_subs_tab_"+tabCD).attr("selectallflag","N");
}
		
	
}

function dataload_subscribes_save(){
	jQuery("input[selectedflag]").attr("selectedflag","N");
	var substriggercd="";
	var subsarray=jQuery("#dl_subscribesform").serializeArray();
	for(var i=0;i<subsarray.length;i++){
		var nameStr = subsarray[i].name;
		if(nameStr.indexOf("dl_subs_tab_")==-1){
			substriggercd+=subsarray[i].value;
			substriggercd+=","
			jQuery("#"+nameStr).attr("selectedflag","Y");
		}
		
	}
	substriggercd=substriggercd.substring(0,substriggercd.length-1);
	substriggercd="triggerCD="+substriggercd;
	var timeid = (new Date()).valueOf();
	jQuery.ajax({
		type : "POST",
		url : "<%=request.getContextPath()%>/action/portal/dataload/saveDataloadSubscribes?timeid=" + timeid ,
		data : substriggercd,
		dataType : "text",
	})
	.done(function(){
		alert("Updated subscriptions successfully!");
	})
	.fail(function(jqXHR, textStatus, errorThrown){
		
		alert("Updated subscriptions failed!");		
	})	

}
</script>
</body>
</html>