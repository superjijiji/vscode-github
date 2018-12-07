
<% String path = request.getContextPath(); %>
<div class="ibm-card">

	<div class="ibm-card__content">
		<div class="ibm-rule ibm-alternate-1 ibm-blue-60"></div>
		<!-- dataload status protal by leo-->
		<strong class="ibm-h4">Data load status</strong>

		<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
			<hr>
		</div>
		<!-- TABS -->
		<div class="ibm-text-tabs"
			style="margin: 0; min-height: 0; margin-bottom: 8px;">
			<!-- Tabs here: -->
			<div class="ibm-tab-section">
				<ul id="dl_tab" class="ibm-tabs" role="tablist">

				</ul>
			</div>
		</div>
		<!-- tab content -->
		<div id="dl_tab_box" class="ibm-container-body"
			style="height: 150px; overflow-y: scroll; padding: 0"></div>

		<!-- tab footer -->

		<div align="right" style="float: right">
			<a
				href="<%=request.getContextPath()%>/action/portal/dataload/getTabPage">
				> Show/hide tabs </a>
		</div>
		<div align="right" style="float: right">
			<a
				href="<%=request.getContextPath()%>/action/portal/dataload/getSubscribePage">>
				Subscribe to notifications</a>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<br>



	</div>
</div>



<script type="text/javascript">
var dlCount; 
var preTabCD;

	jQuery(function() {
		var timeid = (new Date()).valueOf();
		jQuery
				.ajax({
					type : "GET",
					url : "<%=request.getContextPath()%>/action/portal/dataload/getAllDataload/full?timeid=" + timeid ,
					dataType : "json",
					success : function(data) {
						jQuery
								.each(
										data,
										function(tab, trigger) {
											dlCount=0;
											var tabDesc = tab.substring(tab
													.indexOf('_') + 1, tab
													.lastIndexOf('_'));
											var tabCD = tab.substring(0, tab
													.indexOf('_'));
											var jQueryli = "<li id ='dl_"+ tabCD +"_tab' role='presentation'><a onclick='displayData(\""+ tabCD + "\")' role='tab' href='####''>testing</a></li>";

											jQuery("#dl_tab").append(jQueryli);

											var tableStr = "<table style='padding:0;table-layout: fixed;' id ='dl_" + tabCD + "_table' class='ibm-data-table ibm-altrows dataTable' cellspacing='0' cellpadding='0' border='0'>";

											tableStr += "<thead><tr><th scope='col' style='width: 30%;';>Status</th><th scope='col' style='width: 70%;'>Dataload</th><th scope='col' style='width: 85px;'>Last update</th></tr></thead>"
											tableStr += "<tbody>";
											for (var i = 0; i < trigger.length; i++) {
												
												
												if(trigger[i].isUpdate=="Y"){
													dlCount ++;
													
													if(trigger[i].applStatus=="OK"){
														tableStr += "<tr id='dl_"+trigger[i].triggerCD+"_tr' style='font-weight:bold'><td align='center'>";
														tableStr+="<img src='<%=path%>/images/sys_up.gif' /></td>";
														
													}else{
														tableStr += "<tr id='dl_"+trigger[i].triggerCD+"_tr' style='font-weight:bold'><td align='center'>"
														tableStr+="<img src='<%=path%>/images/sys_down.gif' /></td>";
													}
												

													tableStr += "<td align='left'>"
													+ trigger[i].triggerDesc
													+ "</td>";

													tableStr += "</td><td align='left'>"
													+ trigger[i].formatTriggerTime
													+ "</td></tr>";
													
												}else{
													
													if(trigger[i].applStatus=="OK"){
														tableStr += "<tr id='dl_"+trigger[i].triggerCD+"_tr' ><td align='center'>";
														tableStr +="<span style='display: none;'>OK</span>";
														tableStr +="<img src='<%=path%>/images/sys_up.gif' alt='OK' /></td>";
														
													}else{
														tableStr += "<tr id='dl_"+trigger[i].triggerCD+"_tr'><td align='center'>"
														tableStr +="<span style='display: none;'>NO</span>";
														tableStr+="<img src='<%=path%>/images/sys_down.gif' alt='NO' /></td>";
													}

													tableStr += "<td align='left'>"
													+ trigger[i].triggerDesc
													+ "</td>";

													tableStr += "</td><td align='left'>"
													+ trigger[i].formatTriggerTime
													+ "</td></tr>";
												}
												
											
											}
											tableStr += "</tbody>";
											tableStr += "</table>";
											
											jQuery("#dl_tab_box").append(jQuery(tableStr));
											jQuery("#dl_"+tabCD+"_table").DataTable({paging: false,searching:false, info:false});
											
											if(dlCount ==0){
												jQuery("#dl_"+tabCD+"_tab a").text(tabDesc);
											}else{
												jQuery("#dl_"+tabCD+"_tab a").text(tabDesc + "("+dlCount+")");
											}
											

										});
						//default - 1st tab display
						jQuery("#dl_tab_box div").hide();
						jQuery('#dl_tab li:first-child a').attr("aria-selected",true);
						jQuery('#dl_tab li:first-child a').css("fontWeight","bold").parent().css("backgroundColor", "#ffffff");
						jQuery('#dl_tab_box div:first-child').css("padding","0");
						jQuery('#dl_tab_box div:first-child').show();
						//default previous tabCD 
						preTabCD = jQuery('#dl_tab li:first-child').attr("id");
						preTabCD = preTabCD.substring(preTabCD.indexOf('_')+1,preTabCD.lastIndexOf('_'));
					
						
					}
				});

	}

	);

	function displayData(tabCD) {
		jQuery('#dl_' + tabCD + '_table_wrapper').css("padding","0");
		jQuery('#dl_' + tabCD + '_table_wrapper').show();
		jQuery('#dl_' + tabCD + '_table_wrapper').siblings("div").hide();
		jQuery("#dl_tab li a").attr("aria-selected",false);
		jQuery("#dl_" + tabCD + "_tab a" ).attr("aria-selected",true);
		jQuery("#dl_" + tabCD + "_tab a" ).css("fontWeight","bold").parent().css("backgroundColor", "#ffffff");
		//display normal font for trigger and hide update count in tab when clicking other tab
		if(tabCD !=preTabCD){
			jQuery("#dl_"+preTabCD+"_table tr").css("fontWeight","normal");
			jQuery("#dl_"+preTabCD+"_tab a").css("fontWeight","normal");
			var tabDesc = jQuery("#dl_"+preTabCD+"_tab a").text();
			jQuery("#dl_"+preTabCD+"_tab a").parent().css("backgroundColor", "#ececec")
			if(tabDesc.indexOf('(')!=-1){
				tabDesc=tabDesc.substring(0, tabDesc.indexOf('('));
				jQuery("#dl_"+preTabCD+"_tab a").text(tabDesc);
			}
			preTabCD=tabCD;
		}
		
		
	}
	
	
	function getNewDataload() {
		var timeid = (new Date()).valueOf();
		jQuery
		.ajax({
			type : "GET",
			url : "<%=request.getContextPath()%>/action/portal/dataload/getAllDataload/delta?timeid=" + timeid ,
			dataType : "json",
			success : function(data) {
				jQuery
						.each(data,function(tab, trigger) {
									var newdlCount=0;
									var olddlCount=0;
									var tabCD = tab.substring(0, tab.indexOf('_'));
									var tabDesc = tab.substring(tab
											.indexOf('_') + 1, tab
											.lastIndexOf('_'));
									
									for (var i = 0; i < trigger.length; i++) {
										if(trigger[i].isUpdate=="Y"){
											var jQuerycheckFont = jQuery("#dl_"+trigger[i].triggerCD+"_tr").css("fontWeight");
											if (jQuerycheckFont !="bold")
												newdlCount++;
											
										   jQuery("#dl_"+trigger[i].triggerCD+"_tr").css("fontWeight","bold");	
										   //bugfix for update time text and status image
										   jQuery("#dl_"+trigger[i].triggerCD+"_tr td:last-child").text("text",trigger[i].triggerTime);
										   if(trigger[i].applStatus=="OK"){
												jQuery("#dl_"+trigger[i].triggerCD+"_tr td:first-child img").attr("src","<%=path%>/images/sys_up.gif");
											}else{
												jQuery("#dl_"+trigger[i].triggerCD+"_tr td:first-child img").attr("src","<%=path%>/images/sys_down.gif");
												
											}
										}
									}
									
									if(newdlCount !=0){
										var oldTabDesc = jQuery("#dl_"+tabCD+"_tab a").text();
										if(oldTabDesc.indexOf('(')!=-1){
											olddlCount=oldTabDesc.substring(oldTabDesc.indexOf('(')+1, oldTabDesc.indexOf(')'));
											newdlCount = parseInt(newdlCount)+parseInt(olddlCount);
											 jQuery("#dl_"+tabCD+"_tab a").text(tabDesc + "(" + newdlCount +")");
										}else{
											jQuery("#dl_"+tabCD+"_tab a").text(tabDesc + "(" +newdlCount + ")");
										}
									}
									
									});
								}
		});
	}
	
	
	//refresh dataload every 10 minutes
	window.setInterval("getNewDataload()",600*1000); 
</script>