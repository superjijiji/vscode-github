<script type="text/javascript">
var link_myTime= (new Date()).getHours()+"-"+(new Date()).getMinutes()+"-"+(new Date()).getSeconds(); 
var link_cwaid = "${requestScope.cwa_id}";
var link_uid   = "${requestScope.uid}";
var link_path  = "<%=request.getContextPath()%>"; // jQuery('#link_path').val();	

//==================================================
function link_loadWithGroups(){
		
		var link_timeid = (new Date()).valueOf(); 

		jQuery("#link_error2show").empty(); 
		jQuery("#link_list2show").empty(); 
		jQuery("#link_list2show").append("<img src='"+link_path+"/images/ajax-loader.gif' />"); 
		jQuery.when(
			jQuery.get(link_path+"/action/portal/tree/fakecwa/syslink/link?timeid="+link_timeid),
			jQuery.get(link_path+"/action/portal/link/"+link_cwaid+"/"+link_uid+"?timeid="+link_timeid)
		)
		.fail(function(jqXHR, textStatus, errorThrown){ //first failure 
			jQuery("#link_error2show").html("error("+errorThrown+") in loading ... "); 
			console.log("link_error4loading...jqXHR..."			+JSON.stringify(jqXHR)); 
			console.log("link_error4loading...textStatus..."	+textStatus); 
			console.log("link_error4loading...errorThrown..."	+errorThrown); 
		})	
		.done(function (a1, a2){	
			//--------------------------get returned data
			var nodes=[]; 		
			var nodeTextStatus=a1[1];
			var nodeJqXHR=a1[2]; 
			var links=[]; 
			var linkTextStatus=a2[1];
			var linkJqXHR=a2[2]; 	
			//--------------------------checking returned status
			if (nodeTextStatus === 'success') {
				if (a1[0].content === undefined ) {
					nodes=[]; 
				} else {
					nodes=eval(a1[0].content); //convert the saved string into an array 
				}
			} else {
				jQuery("#link_error2show").html('ajax error...node...'+nodeTextStatus); 
				return false; 
			}
			if (linkTextStatus === 'success') {
				links=a2[0];
			} else {
				jQuery("#link_error2show").html('ajax error...link...'+linkTextStatus); 
				return false; 
			}			
			//--------nodes
			var flag = 0; 
			for(var i=0; i<nodes.length; i++) { 
				switch(nodes[i].type){
					case "folder":
						break;//do noting
					case "link":
						flag = 0; 
						for (var j=0; j<links.length; j++) {
							if (links[j].id === nodes[i].reference-0) {
								nodes[i].text 	= links[j].name;//get new name, in case it changes 
								nodes[i].url 	= links[j].url;
								nodes[i].tip 	= links[j].tip;
								links.splice(j,1);//this is done, remove it
								flag = 1; 
								break;
							}
						}		
						if (flag === 0) {
							nodes.splice(i, 1); //not matched, this node is NOT needed any more
							i--; //because of splicing the array, we need this to avoid jumping over the next item we should check
						}					
						break;
					default:
						console.log("link_error4loading...this node..."+JSON.stringify(nodes[i]));
						break; 
				}
			}	
			//--------new links 
			if (links.length >0){
				var newNode = {}; 
				jQuery.each(links, function(index, item){ 
					newNode = {id:"link_new"+index, parent:"#", text:item.name, type:"link", url:item.url, tip:item.tip}; 
					nodes.push(newNode);
				});					
			}
			//--------create it 
			link_showInGroups(nodes);
		}); 
}
//==================================================
function link_showInGroups(nodes){
	//----clean
	jQuery("#link_list2show").empty(); 
	//----create the folders of links
	var link_objFolders = {};
	jQuery("#link_list2show").append("<p id='link_root_p'><ul id='link_root' data-link='link_folder' class='ibm-plain-list'></ul></p>"); 
	link_objFolders["#"]=jQuery("#link_root"); 
	jQuery.each(nodes,function(index, node) { 
		switch(node.type){
			case "folder":
				//we don't support more than 1 layer of folders now...in the future maybe, if not root, then jQuery("#link_"+node.parent+"_div").append();
				jQuery("#link_list2show").append("<h2 id='link_"+node.id+"_h2'><strong>"+node.text+"</strong></h2> <div id='link_"+node.id+"_div' class='ibm-container-body'><p id='link_"+node.id+"_p'><ul id='link_"+node.id+"' data-link='link_folder' class='ibm-plain-list'></ul></p></div>");
				link_objFolders[node.id]=jQuery("#link_"+node.id); 
				break;
			case "link":	
				link_objFolders[node.parent].append("<li><a id='link_"+node.id+"' data-link='link_link' data-widget='tooltip' title='"+ node.tip +"' target='_blank' href='"+node.url+"'>> "+node.text+"</a></li>"	);
				break; 
			default:
				console.log("link_error4UI...this node..."+JSON.stringify(node));
				break; 
		}
	});
	//----get the folders 
	var link_folders = jQuery("ul[data-link='link_folder']"); 
	jQuery.each(link_folders, function(index,node){
		if (jQuery("#"+node.id).children().length === 0){ //remove the empty folders
			jQuery("#"+node.id+"_h2").remove();
			jQuery("#"+node.id+"_div").remove(); 
		} else {//special look controlling requested by Ian....this style is from 'My recent searches' part, copied from there to here
			jQuery("#"+node.id).attr("style","padding-top:1px;padding-right:1px;padding-bottom:1px;padding-left:1px;line-height:0.625rem;");
		}
	});  
	//----v18 stuff, make the showhide and tool tips working
	jQuery("#link_list2show").showhide();
	jQuery("a[data-link='link_link']").tooltip();
}
//==================================================
jQuery(document).ready(function () {
	link_loadWithGroups();
});
</script>


<div class="ibm-card">
	<div class="ibm-card__content">
		<div class="ibm-rule ibm-alternate-1 ibm-blue-60"></div>
		<div style="float: left;">
			<strong class="ibm-h4">BI@IBM controls</strong>
		</div>
		<div style="float: right;">
			<a onclick="link_loadWithGroups()" title="Refresh"
				style="cursor: pointer"> <img
				src="<%=request.getContextPath() +"/images/refresh.gif" %>"
				alt="refresh" />
			</a>
		</div>
		<div class="ibm-rule">
			<hr>
		</div>
		<div id="link_error2show"></div>
		<div id="link_list2show" data-widget="showhide" data-type="panel"
			class="ibm-show-hide"></div>
	</div>
</div>