<div class="ibm-card">
	<div class="ibm-card__content">
		<div class="ibm-rule ibm-alternate-1 ibm-blue-60"></div>
		<div>
			<strong class="ibm-h4">Messages</strong>
		</div>
		<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
			<hr>
		</div>
		<div class="ibm-text-tabs" id="messages_dyntabs"
			style="margin: 0; min-height: 0;">
			<div class="ibm-tab-section">
				<ul class="ibm-tabs" role="tablist" id="messages_dyntabs_head">

				</ul>
			</div>
		</div>

		<div class="ibm-container-body" id="messages_dyntabs_body"
			style="padding-top: 8px;"></div>

		<div align="right">
			<a
				href="<%=request.getContextPath()%>/action/portal/messages/getMessageSubsbPage">&gt;&nbsp;Subscribe
				to notifications</a>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="<%=request.getContextPath()%>/action/portal/messages/getMessageMaxPage">&gt;&nbsp;View
				all messages</a>
		</div>
	</div>
</div>

<script type="text/javascript">
var messages_currentcategoryid;

//initialize messages. 
jQuery(document).ready(
	function() {
		var timeid = (new Date()).valueOf();
		jQuery.ajax({type:'GET',
			url:'<%= request.getContextPath()%>/action/portal/messages/getMessageAll?timeid=' + timeid,
			success : function(data) {
				jQuery.each(data, function(categorykey, messagelist){
					
					if (categorykey != null && categorykey !="" && messagelist != null && messagelist.length > 0) {
						
						// analyze and get category id and description.
						var categoryid = categorykey.substring(0, categorykey.indexOf("_"));
						var categorydesc = categorykey.substring(categorykey.indexOf("_")+1);
						
						// create empty table, and add it into dyntabs body.
						var emptytablestr = "<div id='messages_dyntabs_body_div_"+categoryid+"' class='ibm-tabs-content' style='height: 150px; overflow-y: scroll; padding-top: 0px;'>";
						emptytablestr += "<table id='messages_dyntabs_body_div_table_"+categoryid+"' class='ibm-data-table ibm-altrows dataTable' data-widget='datatable' data-ordering='true' cellspacing='0' cellpadding='0' border='0' style='padding-top: 0px; table-layout: fixed;'>";
			    		emptytablestr += "<thead><tr><th scope='col' style='width: 25%;'>Source</th><th scope='col' style='width: 75%;'>Message</th><th scope='col' style='width: 85px;'>Date/Time</th></tr></thead>"
			    		emptytablestr += "<tbody>";
			    		emptytablestr += "</tbody>";
    					emptytablestr += "</table>";
						emptytablestr += "</div>";
						jQuery("#messages_dyntabs_body").append(jQuery(emptytablestr));
						
						// add navigator tab into dyntabs. 
						var emptynavstr = "<li><a role='tab' id='messages_dyntabs_head_nav_"+categoryid+"' href='#messages_dyntabs_body_div_"+categoryid+"' onmouseup='messages_mouseup(\""+categoryid+"\", event)' onkeydown='messages_keydown(\""+categoryid+"\", event)'>"+categorydesc+"</a></li>";
						jQuery("#messages_dyntabs_head").append(jQuery(emptynavstr));
						
						var newmessagecount = 0;
						
						// add each row data
						for (var i = 0; i < messagelist.length; i++) {
						
							var trobject;
							var tdstring2;
							var tdobject1;
							var tdobject2;
							var tdobject3;
							
							trobject = jQuery("<tr id='messages_msgid_"+messagelist[i].msgId+"'></tr>");
								
							tdobject1 = jQuery("<td align='left'>"+messagelist[i].msgTypeDesc+"</td>");
							
							tdstring2 = "<td align='left'>"+messagelist[i].messageText;
							if (messagelist[i].link != null && messagelist[i].link != "") {
				    			tdstring2 += "<br><a href='"+messagelist[i].link+"' target='blank'>More...</a>";
				    		}
				    		tdstring2 += "</td>";
				    		tdobject2 = jQuery(tdstring2);
				    		
				    		tdobject3 = jQuery("<td align='left'>"+messagelist[i].startDateFormatOutput+"</td>");
				    		
				    		trobject.append(tdobject1);
				    		trobject.append(tdobject2);
				    		trobject.append(tdobject3);
							
							if (messagelist[i].isNew == "Y") {
							
								newmessagecount ++;
								
								// all 3 columns are BOLB for new messages.
								tdobject1.css('fontWeight', 'bold');
					    		tdobject2.css('fontWeight', 'bold');
					    		tdobject3.css('fontWeight', 'bold');
								
								// add this message into data table as first child. 
					    		jQuery("#messages_dyntabs_body_div_table_"+categoryid).children("tbody").prepend(trobject);
							} else {
								
								// only the 2nd column is set to BOLB for urgent message. 
								if (messagelist[i].urgent == "Y") {
									tdobject2.css('fontWeight', 'bold');
								}
								
								// add this message into table as the last child. 
								jQuery("#messages_dyntabs_body_div_table_"+categoryid).children("tbody").append(trobject);
							}
						}
						
						// resolved tab title and add count when this tab has new message. 
						if (newmessagecount > 0) {
							jQuery("#messages_dyntabs_head_nav_"+categoryid).text(categorydesc + "(" + newmessagecount + ")");
						}
						
						// initialize data table, set the 3rd columns(Date/Time) as default order, and it's desc. The newest message should be the first one. 
						jQuery("#messages_dyntabs_body_div_table_"+categoryid).DataTable({paging:false, searching:false, info:false, order:[[2, "desc"]]});
					}
				});
				
				// initialize dyntabs. 
				jQuery("#messages_dyntabs").attr("data-widget", "dyntabs");
				jQuery("#messages_dyntabs").dyntabs();
				
				// save current acttived tab id. 
				messages_saveactiveid();
				
				// set current active tab title as BOLD. 
				jQuery("#messages_dyntabs_head_nav_"+messages_currentcategoryid).css('fontWeight', 'bold');
				jQuery("#messages_dyntabs_head_nav_"+messages_currentcategoryid).parent().css("backgroundColor", "#ffffff");
			}
		});
	}
);

// dyntabs can be operated by keyboard, so add this function. 
function messages_keydown(newcategoryid, event)
{
	// only click Enter key can change active tab. 
	if (event.which == 13) {
		
		messages_mouseup(newcategoryid);
		//messages_currentcategoryid = newcategoryid;		
	}
}

//function messages_mousedown(newcategoryid)
//{
	//messages_saveactiveid();
//}

// resolved fontWeight and tab title when actived tab is changed. 
function messages_mouseup(newcategoryid)
{
	//alert(messages_currentcategoryid);
	
	// when tab changed. 
	if (messages_currentcategoryid != null && messages_currentcategoryid != newcategoryid) {
		
		// change tab title fontWeight to normal. 
		//var navigatortitle = jQuery("#messages_dyntabs_head_nav_"+messages_currentcategoryid).text();
		var navigatortitle = jQuery("#messages_dyntabs_head_nav_"+messages_currentcategoryid).css("fontWeight", "normal").text();
		jQuery("#messages_dyntabs_head_nav_"+messages_currentcategoryid).parent().css("backgroundColor", "#ececec");
		
		// resolve tab title when there is (1)
		if (navigatortitle.indexOf("(") == -1) {
			// nothing to do
			//alert("nothing to do");
		} else {
			//alert("title");
			jQuery("#messages_dyntabs_head_nav_"+messages_currentcategoryid).text(navigatortitle.substring(0, navigatortitle.indexOf("(")));
		}
		
		// change all messages in this tab into fontWeight to normal. 
		jQuery("#messages_dyntabs_body_div_table_"+messages_currentcategoryid).children("tbody").children("tr").children("td").css("fontWeight", "normal");
		
		// change current actived tab title to BOLD. 
		jQuery("#messages_dyntabs_head_nav_"+newcategoryid).css("fontWeight", "bold");
		jQuery("#messages_dyntabs_head_nav_"+newcategoryid).parent().css("backgroundColor", "#ffffff");
		
		// save current active tab id. 
		messages_currentcategoryid = newcategoryid;
		
	} else {
		//alert("Tab NOT is changed");
	}
}

// refresh messages. get newest messages, and set them as BOLD. 
function getMessageNew()
{
	var timeid = (new Date()).valueOf();
	//var dyntabsrefreshflag = 0;
	jQuery.ajax({type:'GET',
		url:'<%= request.getContextPath()%>/action/portal/messages/getMessageNew?timeid=' + timeid,
		success : function(data) {
			jQuery.each(data, function(categorykey, messagelist){
				
				if (categorykey != null && categorykey !="") {
					
					var categoryid = categorykey.substring(0, categorykey.indexOf("_"));
					var categorydesc = categorykey.substring(categorykey.indexOf("_")+1);
					
					var currentNav = jQuery("#messages_dyntabs_head_nav_"+categoryid);
					
					if (currentNav.length == 0) {
						// new tab comming. current solution is nothing to do. End user need to press F5 to refresh portal by himself, then new tab can be loaded. 
					} else {
						if (messagelist != null && messagelist.length > 0) {
							
							var navigatortitlecount = 0;
							
							// destroy this data table before add new data rows. 
							jQuery("#messages_dyntabs_body_div_table_"+categoryid).dataTable().fnDestroy();
							
							for (var i = 0; i < messagelist.length; i++) {
							
								// analyze if the new message already existed. 
								var messagenewtr = jQuery('#messages_msgid_'+messagelist[i].msgId);
								
								if (messagenewtr.length == 0) {
									
									//add new message
									
									// flag to confirm if dyntabs is needed to re-initialzie. 
									//dyntabsrefreshflag ++;
									
									// flag to count how many new messages are added. 
									navigatortitlecount ++;
									
									var trobject;
									var tdstring2;
									var tdobject1;
									var tdobject2;
									var tdobject3;
									
									trobject = jQuery("<tr id='messages_msgid_"+messagelist[i].msgId+"'></tr>");
										
									tdobject1 = jQuery("<td align='left'>"+messagelist[i].msgTypeDesc+"</td>");
									
									tdstring2 = "<td align='left'>"+messagelist[i].messageText;
									if (messagelist[i].link != null && messagelist[i].link != "") {
						    			tdstring2 += "<br><a href='"+messagelist[i].link+"' target='blank'>More...</a>";
						    		}
						    		tdstring2 += "</td>";
						    		tdobject2 = jQuery(tdstring2);
						    		
						    		tdobject3 = jQuery("<td align='left'>"+messagelist[i].startDateFormatOutput+"</td>");
						    		
						    		trobject.append(tdobject1);
						    		trobject.append(tdobject2);
						    		trobject.append(tdobject3);
						    		
						    		tdobject1.css('fontWeight', 'bold');
						    		tdobject2.css('fontWeight', 'bold');
						    		tdobject3.css('fontWeight', 'bold');
						    		
						    		// add this message into data table as first child. 
									jQuery("#messages_dyntabs_body_div_table_"+categoryid).children("tbody").prepend(trobject);
								} else {
									
									//updated existed message
									
									var updatedtrobject = jQuery('#messages_msgid_'+messagelist[i].msgId);
									var updatedtd1 = updatedtrobject.children("td").first();
									var updatedtd2 = updatedtrobject.children("td").first().next();
									var updatedtd3 = updatedtrobject.children("td").last();
									
									updatedtd1.text(messagelist[i].msgTypeDesc);
									
									updatedtd2.text(messagelist[i].messageText);
									if (messagelist[i].link != null && messagelist[i].link != "") {
						    			updatedtd2.append("<br><a href='"+messagelist[i].link+"' target='blank'>More...</a>");
						    		}
						    		
									updatedtd3.text(messagelist[i].startDateFormatOutput);
								}
							}
							
							if (navigatortitlecount > 0) {
								
								// change nav tab description, for example, (1) or from (1) to (2)
								var navigatortitle = jQuery("#messages_dyntabs_head_nav_"+categoryid).text();
								
								if (navigatortitle.indexOf("(") == -1) {
									jQuery("#messages_dyntabs_head_nav_"+categoryid).text(categorydesc + "(" + navigatortitlecount + ")");
								} else {
									var oldtitlecount = navigatortitle.substring(navigatortitle.indexOf("(") + 1, navigatortitle.indexOf(")"));
									var newtitlecount = Number(navigatortitlecount) + Number(oldtitlecount);
									jQuery("#messages_dyntabs_head_nav_"+categoryid).text(categorydesc + "(" + newtitlecount + ")");
								}
							}
							
							//jQuery("#messages_dyntabs_body_div_table_"+categoryid).dataTable().fnDestroy();
							jQuery("#messages_dyntabs_body_div_table_"+categoryid).DataTable({paging:false, searching:false, info:false, order:[[2, "desc"]]});

						} else {
							//alert("no new message for this cagegory");
						}
					}
				}
			})
			
			//alert("final dyntabsrefreshflag=" + dyntabsrefreshflag);
			
			//if (dyntabsrefreshflag > 0) {
			//	jQuery("#messages_dyntabs").attr("data-widget", "dyntabs");
			//	jQuery("#messages_dyntabs").dyntabs();
			//	
			//	messages_saveactiveid();
			//}
		}
	})
}

// saved current active tab id. 
function messages_saveactiveid()
{
	var activeid = jQuery("#messages_dyntabs").data("widget").activeTabId();
	
	if (activeid != null) {
		messages_currentcategoryid = activeid.substring(activeid.lastIndexOf("_")+1);
	}
}

// open a new window to show messages only
//function getMessageMaxPage()
//{
//	var tmpUrl = '<%= request.getContextPath()%>/action/portal/messages/getMessageMaxPage';
//	var tmpWindowWidth = screen.availWidth;
//	var tmpWindowHeight = screen.availHeight;
//	var tmpStyle = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0,width=" + tmpWindowWidth + ",height=" + tmpWindowHeight;
//	window.open(tmpUrl, "messages_max", tmpStyle);
//}

//current set its in 10 minutes.
window.setInterval("getMessageNew()", 600000);
</script>