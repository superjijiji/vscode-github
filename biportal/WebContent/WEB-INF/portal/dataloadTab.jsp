<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>BI@IBM Dataload Show or Hide Tabs Setting</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-columns">
		<div class="ibm-card">
			<div class="ibm-card__content">
				<strong class="ibm-h4">Dataload Show or Hide Tabs Setting</strong>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>
				<b>Dataload Show or Hide Tabs Setting</b><br>
				<p>This setting allows the users to set which tabs to show or
					hide on the Dataload Status portlet. Note that initially by default
					all tabs will show unless you indicate here that you want to hide
					certain tabs. To set, use the checkboxes to select your desired tab
					selections. To show all tabs, click the "Check all". To show a
					certian tab, click the check box immediately under the tab name. To
					hide a certain tab, uncheck the check box immediately under the tab
					name. When done, click the "Submit" button at the bottom to save
					them and then on the "Back to BI@IBM home" link or the Restore
					option in the Portlet menu. Note that the "Reset" button will
					restore your selections to their last saved state.</p>
				<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
					<hr>
				</div>

				<form id="dl_tab_form" class="ibm-column-form" method="post">
				</form>

				<br>
				<button id="dataload_tab_savebutton"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="dataload_tab_save()">Update Tab Status</button>
				<button id="dataload_tab_checkall"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="dataload_tab_checkall()">Check all</button>
				<button id="dataload_tab_uncheckall"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="dataload_tab_uncheckall()">Uncheck all</button>
				<button id="dataload_tab_reset"
					class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
					onclick="dataload_tab_reset()">Reset</button>
				<br> <br>
				<a href="<%=request.getContextPath()%>/"> < Back to BI@IBM home</a>
				<br />
				<br />



				<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
				<script type="text/javascript">
var space ="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

jQuery(function() {
	var timeid = (new Date()).valueOf();
	var tableStr = "<table id ='dl_tab_table' class='ibm-data-table ibm-altrows' cellspacing='0' cellpadding='0' border='0'> <thead><tr>";
	var tabRow ="<tr>";
	jQuery
			.ajax({
				type : "GET",
				url : "<%=request.getContextPath()%>/action/portal/dataload/getTab?timeid=" + timeid ,
				dataType : "json",
				success : function(data) {
					jQuery
							.each(
									data,
									function(i, tab) {
										var tabDesc = tab.tabDesc;
										tableStr+="<th scope='col'>"+tabDesc+"</th>";
										tabRow +="<td align='center'>";
										if(tab.isChecked=="Y")
											tabRow +="<input id='dl_tab_"+ tab.tabCD +"' name='dl_tab_"+ tab.tabCD +"' value='"+ tab.tabCD +"' class='ibm-styled-checkbox' type='checkbox' selectedflag='Y' checked/> <label  style='margin:0; padding:0' for='dl_tab_"+tab.tabCD+"'></label>"
										else
											tabRow +="<input id='dl_tab_"+ tab.tabCD +"' name='dl_tab_"+ tab.tabCD +"' value='"+ tab.tabCD +"' class='ibm-styled-checkbox' type='checkbox' selectedflag='N'/> <label  style='margin:0; padding:0' for='dl_tab_"+tab.tabCD+"'></label>"	
										tabRow +="</td>"
									});
					tableStr+="</tr></thead><tbody>";
					tabRow+="</tr>";
					tableStr+=tabRow;
					tableStr+="</tbody></table>";
					jQuery("#dl_tab_form").append(jQuery(tableStr));
				

				}
			});

}

);

function dataload_tab_checkall()
{
	jQuery(".ibm-styled-checkbox").prop("checked", true);
}

function dataload_tab_uncheckall()
{
	jQuery(".ibm-styled-checkbox").prop("checked", false);
}

function dataload_tab_reset()
{
	jQuery(".ibm-styled-checkbox").prop("checked", false);
	jQuery("input[selectedflag='Y']").prop("checked",true);
}


function dataload_tab_save(){
	
	var tabCD="";
	var checkedCount =0;
	var checkedBox = jQuery("#dl_tab_table input[type='checkbox']:checked");
	checkedBox.each(function(i){
		checkedCount++;
	});
	if(checkedCount==0){
		alert("Please select at least one tab to show before click Submit button!");
		return;
	}
	
	jQuery("input[selectedflag]").attr("selectedflag","Y");
	var notChecked = jQuery("#dl_tab_table input[type='checkbox']").not("input:checked") ;
	notChecked.each(function(i){ 
		tabCD+=jQuery(this).val();
		tabCD+=",";
		jQuery("#dl_tab_"+jQuery(this).val()).attr("selectedflag","N");
	});


	
	tabCD=tabCD.substring(0,tabCD.length-1);
	tabCD="tabCD="+tabCD;
	var timeid = (new Date()).valueOf();
	jQuery.ajax({
		type : "POST",
		url : "<%=request.getContextPath()%>/action/portal/dataload/saveDataloadTab?timeid=" + timeid ,
		data : tabCD,
		dataType : "text",
	})
	.done(function(){
		alert("Updated Tab Status successfully!");
	})
	.fail(function(jqXHR, textStatus, errorThrown){
		
		alert("Updated Tab Status failed!");		
	})	

}
</script>
</body>
</html>