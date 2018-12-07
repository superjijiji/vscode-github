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
<title>BI@IBM | Manage folders</title>
<style type="text/css">
/* ====================== overriding v18 */
a[class*="ibm-btn-"][class*="-pri"][class*="blue-50"], a[class*="ibm-btn-"][class*="-sec"][class*="blue-50"],
	.ibm-btn-pri.ibm-btn-small, .ibm-btn-sec.ibm-btn-small {
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
.tree_mngt_page_title {
	padding-right: 10px;
	float: left;
}

.tree_mngt_full_width {
	width: 100%;
}

.tree_mngt_popup_center {
	text-align: center;
	margin: 0 auto;
}
</style>
<script type="text/javascript">
		window.$ = window.jQuery;
	</script>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/default/style.min.css" />
<script type="text/javascript"
	src="<%=path%>/javascript/jstree-3.3.1.js"></script>
<!-- ================================================================= custom page JS and CSS end -->
</head>

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<!-- ================================================================= custom page contents start -->
	<div id="eod-menubar-after-ibm-sitenav" class="tree_mngt_full_width">
		<div class="ibm-columns">
			<!-- ================================================================= -->
			<div class="ibm-col-4-4">
				<div class="tree_mngt_page_title">
					<h1 id="tree_page_title" class="ibm-h1 ibm-light">Manage
						folders</h1>
				</div>
				<div class="tree_mngt_page_title">
					<p class="ibm-ind-link ibm-icononly ibm-inlinelink">
						<a class="ibm-information-link" id="tree_page_help"
							target="_blank" href="#" title="Help for folder management">
							Help for folder management </a>
					</p>
				</div>
			</div>
			<!-- ================================================================= -->
			<div class="ibm-col-4-1">
				<div class="ibm-center">
					<label for="tree_fname">Folder:&ensp;&ensp;</label> <input
						type="text" value="" placeholder="pls input folder name here"
						size="25" id="tree_fname">
				</div>
			</div>
			<div class="ibm-col-4-3">
				<div class="ibm-btn-row">
					<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="tree2edit_createFolder()">Create folder</a> <a
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="tree2edit_renameFolder()">Rename folder</a> <a
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="tree2edit_deleteFolder()">Delete folder</a> <a
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="tree2edit_moveSelectedPopup()">Move selected</a> <a
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="tree2edit_toggleSelection()">Check / Uncheck all</a> <a
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="jQuery('#tree_show').jstree(true).open_all('#',500); ">Expand
						all</a> <a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="jQuery('#tree_show').jstree(true).close_all('#',500); ">Collapse
						all</a>
				</div>
			</div>
			<!-- ================================================================= -->
			<div class="ibm-col-4-1">
				<div class="ibm-center">
					<label for="tree_filter">Search:&ensp;</label> <input type="text"
						value="" placeholder="pls input search text here" size="25"
						id="tree_filter">
				</div>
			</div>
			<div class="ibm-col-4-3">
				<div class="ibm-btn-row">
					<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onclick="tree2edit_saveTree(tree_context, tree_module, tree_cwa, tree_uid)">Save
						changes</a>
				</div>
			</div>
			<!-- ================================================================= -->
		</div>
	</div>


	<div class="ibm-columns">
		<div class="ibm-col-4-4">
			<div id="tree_show"></div>
			<div id="tree_message">${err_from_backend}</div>
			<div id="tree_backUrl">
				<a href="${backUrl}"> &lt;&nbsp;Back</a>
			</div>
		</div>
	</div>
	<!-- ================================================================= custom page contents end -->
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
	<!-- ================================================================= custom page doc ready JavaScript codes start -->
	<script type="text/javascript">
		var tree_module = "${module}";
		var tree_cwa = "${cwa_id}";
		var tree_uid = "${uid}";
		var tree_context = "<%=request.getContextPath()%>";
		var tree_ep_nodes = "${ep_nodes}";
		var tree_ep_entries = "${ep_entries}";
		var tree_joinString = "${joinString}";
		var tree_joinedKeys = tree_joinString.split("-");
		var tree_getString = "${getKeys}";
		var tree_getKeys = tree_getString.split("-");

		jQuery(document).ready(function () {
			//--------page title 
			var treePageName = "${moduleName} - Manage folders";
			jQuery("#tree_page_title").text(treePageName);
			jQuery("#tree_page_help").attr("href", encodeURI(tree_context + "/action/portal/pagehelp?pageKey=${moduleHelpKey}&pageName=" + treePageName));
			jQuery("title").html("BI@IBM | " + treePageName);

			//--------floating menu 
			treeMenuFixed("eod-menubar-after-ibm-sitenav");

			//--------load the tree
			tree2edit_displayTree(tree_context, tree_ep_nodes, tree_ep_entries, tree_joinedKeys, tree_getKeys, "tree_fname", tree_module);

			//--------search creation after loading the tree. 
			var to = false;
			jQuery('#tree_filter').keyup(function () {
				if (to) {
					clearTimeout(to);
				}
				to = setTimeout(
					function () {
						var v = jQuery('#tree_filter').val();
						jQuery('#tree_show').jstree(true).search(v);
					},
					250
				);
			});
		});
		//==================================================
		function treeMenuFixed(id) {
			var obj = document.getElementById(id);
			var _getHeight = obj.offsetTop;
			window.onscroll = function () {
				treeMenuChangePosition(id, _getHeight);
			}
		}

		function treeMenuChangePosition(id, height) {
			var obj = document.getElementById(id);
			var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
			obj.style.backgroundColor = '#fff';
			obj.style.zIndex = '815'; //the same as ibm-sitenav-menu-container 
			if (scrollTop < height) {
				obj.style.position = 'relative';
				obj.style.top = 'auto';
			} else {
				obj.style.position = 'fixed';
				obj.style.top = '50px'; //the fixed px which we see on ibm-sitenav-menu-container, so that we set this menubar to be below that ibm-sitenav-menu-container 
			}
		}
		//==================================================
		function tree2edit_moveSelectedPopup() {
			var theTree = jQuery('#tree_show').jstree(true);
			var theSelectedNodes = theTree.get_bottom_checked(); // we have a simple 2 level structure here, so the bottom level nodes means the link type nodes. 
			var theSelectedNodesLength = theSelectedNodes.length; 
			if (theSelectedNodesLength < 1) {
				tree2edit_showMsg(" you have to select something to move into a folder. ");
				return false;
			}


			var popupHeader = "<h2 class='ibm-bold'>Available folders</h2>";
			var popupGuide = "<p class='ibm-center'>You have selected "+theSelectedNodesLength+" to move.";
			if ( theSelectedNodesLength > 20 ){
				popupGuide = popupGuide + " It may take some seconds to finish moving. ";
			}
			popupGuide = popupGuide + "</p>";
			var popupButton = "<p class='ibm-btn-row ibm-center'>" +
				"<button class='ibm-btn-pri ibm-btn-blue-50 ibm-btn-small' onclick='tree2edit_moveSelectedOk();'		>OK</button>" +
				"<button class='ibm-btn-sec ibm-btn-blue-50 ibm-btn-small' onclick='tree2edit_moveSelectedCancel();'	>Cancel</button>" +
				"</p>";
			var popupRadios = '<table class="tree_mngt_popup_center"><tbody class="ibm-left">' +
				'<tr><td><input id="_REPLACE_ME_root" name="tree_folder_radio" type="radio" class="ibm-styled-radio" value="#" checked/> <label for="_REPLACE_ME_root">Root folder</label></td></tr>' +
				'';
			var theTree = jQuery('#tree_show').jstree(true);
			var children = theTree.get_node('#').children; //only loop through root's children to look for folders, as we only allow 2 levels on this page. 
			var child = {};
			for (var i = 0; i < children.length; i++) {
				child = theTree.get_node(children[i]);
				if (child.type === 'folder') {
					popupRadios = popupRadios + '<tr><td><input id="_REPLACE_ME_' + child.id +
						'" name="tree_folder_radio" type="radio" class="ibm-styled-radio" value="' + child.id +
						'" /> <label for="_REPLACE_ME_' + child.id + '">' + child.text + '</label></td></tr>';
				}
			}
			popupRadios = popupRadios + '</tbody></table>';


			var myOverlay = IBMCore.common.widget.overlay.createOverlay({
				contentHtml: '<div id="tree_move_to_selected_folder">' + popupHeader + '<br />' + popupGuide + '<br />' +  popupRadios + '<br />' +
					popupButton + '</div>',
				classes: 'ibm-common-overlay ibm-overlay-alt',
				type: 'alert'
			});
			myOverlay.init();
			myOverlay.show();
		}
		//==================================================
		function tree2edit_moveSelectedOk() {
			var theTree = jQuery('#tree_show').jstree(true);
			var theSelectedNodes = theTree.get_bottom_checked(); //the link type nodes. 
			if (theSelectedNodes.length < 1) {
				tree2edit_showMsg(" you have to select something to move into a folder.");
				return false;
			}
			if (jQuery("[name='tree_folder_radio']:checked").length < 1) {
				tree2edit_showMsg(" you have to select a folder before moving ");
				return false;
			}
			var theIdForCheckedFolder = jQuery(jQuery("[name='tree_folder_radio']:checked").get(0)).val(); // get the folder id before anything else 


			jQuery("#tree_move_to_selected_folder").text("moving the selected ... "); // when moving nodes, the browser is too busy, not seeing this msg actually. 
			var theCheckedFolder = theTree.get_node(theIdForCheckedFolder);
			var toBeMovedNodes = [];
			var child = null;
			for (var i = 0; i < theSelectedNodes.length; i++) {
				child = theTree.get_node(theSelectedNodes[i]);
				if (child.type === 'link') { // one more checking to make sure the link type nodes 
					if (theTree.is_hidden(child)) {
						//when using text search in the page, some selected nodes could be hidden, we ONLY want to move the showed selected nodes 
					} else {
						toBeMovedNodes.push(child);
					}

				}
			}
			theTree.move_node(toBeMovedNodes, theCheckedFolder); //time consuming 
			jQuery('#tree_filter').keyup();
			tree2edit_moveSelectedCancel();
		}
		//==================================================
		function tree2edit_moveSelectedCancel() {
			var theOverlayId = IBMCore.common.widget.overlay.getWidget("tree_move_to_selected_folder").getId();
			IBMCore.common.widget.overlay.hide(theOverlayId, true);
			IBMCore.common.widget.overlay.destroy(theOverlayId);
			//2017 Sep 5, don't know why v18 is failing of removing the div, so add this to make sure 
			var found = jQuery("#tree_move_to_selected_folder"); 
			if (found.length > 0) found.remove(); 				
		}
		//==================================================
		function tree2edit_toggleSelection() {
			var theTree = jQuery('#tree_show').jstree(true);
			var child = null;

			var theSelectedIds = theTree.get_selected();
			for (var i = 0; i < theSelectedIds.length; i++) {
				child = theTree.get_node(theSelectedIds[i]);
				if (theTree.is_hidden(child)) {
					//do nothing 
				} else {
					theTree.uncheck_all(); // if there is one showed link(get_bottom_checked) is checked, we un-check all nodes, then exit  
					return false;
				}
			}

			var searchText = jQuery('#tree_filter').val();
			if (searchText === "") {
				theTree.check_all(); 
			} else {
				//clear first
				theTree.uncheck_all(); 
				//then select the showed ones
				var toBeCheckedNodes = [];
				var allNodes = theTree.get_node("#").children_d;			
				for (var i = 0; i < allNodes.length; i++) {
					child = theTree.get_node(allNodes[i]);
					if (theTree.is_hidden(child)) {
						//do nothing 
					} else {
						toBeCheckedNodes.push(child);
					}
				}
				theTree.check_node(toBeCheckedNodes);			
			}
		}
		//==================================================
		function tree2edit_createFolder() {
			if (jQuery('#tree_fname').val().trim() === '') {
				tree2edit_showMsg('folder name cannot be empty');
				return false;
			}
			jQuery('#tree_show').jstree(true).create_node(
				'#', {
					text: jQuery('#tree_fname').val().trim(),
					type: 'folder',
					reference: '#'
				},
				'first',
				function (newNode) {
					console.log(newNode.id + ' is created...done for creating folder!')
				},
				true
			);
		}
		//==================================================
		function tree2edit_renameFolder() {
			var theTree = jQuery('#tree_show').jstree(true);
			var theSelected = theTree.get_top_selected();
			if (theSelected.length === 0) {
				tree2edit_showMsg('none is selected');
				return false;
			}
			if (theSelected.length > 1) {
				tree2edit_showMsg('please select only one folder');
				return false;
			}
			
			var theNode = theTree.get_node(theSelected[0]);
			if (theNode.type !== 'folder') {
				tree2edit_showMsg('the selected is NOT a folder...node text: ' + theNode.text);
				return false;
			}
			if (jQuery('#tree_fname').val().trim() === '') {
				tree2edit_showMsg('folder name cannot be empty');
				return false;
			}
			theNode.original.text = jQuery('#tree_fname').val().trim();//just to make sure
			theTree.rename_node(theNode, theNode.original.text);
			theTree.deselect_node(theNode);
			theTree.select_node(theNode);
		}
		//==================================================
		function tree2edit_deleteFolder() {
			var theTree = jQuery('#tree_show').jstree(true);
			var theSelected = theTree.get_top_selected(); //only IDs will be returned, get an array of all top level selected nodes (ignoring children of selected nodes)
			if (theSelected.length === 0) {
				tree2edit_showMsg('none is selected');
				return false;
			}
			if (theSelected.length > 1) {
				tree2edit_showMsg('please select only one folder');
				return false;
			}
			
			var theNode = theTree.get_node(theSelected[0]);
			if (theNode.type !== 'folder') {
				tree2edit_showMsg('the selected is NOT a folder...node text: ' + theNode.text);
				return false;
			}
			theTree.open_node(theNode); //make sure it is opened, so we move children before deleting parent folder. is this really neccessary?!
			
			var children = [];
			for (var i = 0; i < theNode.children.length; i++) {
				children.push(theTree.get_node(theNode.children[i]));
			}
			theTree.move_node(children, "#"); 
			if (theTree.delete_node(theNode)) console.log("deletting folder is done.")
			else tree2edit_showMsg('error in deleting folder, please refresh page, then start over. folder=' + theNode.text); //we shall not reach this.
		
		}
		//==================================================
		function tree2edit_saveTree(context, module, cwa, uid) {
			var tree_timeid = (new Date()).valueOf();
			var myTime = (new Date()).getHours() + ":" + (new Date()).getMinutes() + ":" + (new Date()).getSeconds();
			tree2edit_showMsg("data submitted for processing ... <img src='" + context + "/images/ajax-loader.gif' />");
			//get tree JSON arrays
			var nodes = [];
			var theTree = jQuery('#tree_show').jstree(true);
			var rootNode = theTree.get_node('#'); //notice in this way this # root is NOT pushed into the nodes array, and this is correct for jstree
			tree2edit_getChildren(theTree, rootNode.children, nodes);			
			//update backend 	 	
			jQuery.ajax({
					url: context + "/action/portal/tree/" + cwa + "/" + uid + "/" + module + "?timeid=" + tree_timeid,
					type: 'POST',
					data: JSON.stringify({
						"uid": uid,
						"module": module,
						"content": JSON.stringify(nodes)
					}),
					dataType: "json",
					contentType: "application/json; charset=utf-8"
				})
				.done(function () {
					tree2edit_showMsg('Your requested folder changes have been saved.');
					jQuery("#tree_message").empty();
				})
				.fail(function (jqXHR, textStatus, errorThrown) {
					tree2edit_showMsg(textStatus + ' in saving  ... ' + myTime);
					jQuery("#tree_message").empty();
				});

		}
		//==================================================
		function tree2edit_showMsg(message) { //the message should be only a simple string
			var myCurrent = IBMCore.common.widget.overlay.hideAllOverlays();
			var myOverlay = IBMCore.common.widget.overlay.createOverlay({
				contentHtml: '<p>' + message + '</p>',
				classes: 'ibm-common-overlay ibm-overlay-alt'
			});
			myOverlay.init();
			myOverlay.show();
		}
		//==================================================
		function tree2edit_getChildren(theTree, childrenIdArr, nodes) {
			var child = {};
			for (var i = 0; i < childrenIdArr.length; i++) {
				child = theTree.get_node(childrenIdArr[i]);
				if (child.type === 'link') {
					nodes.push({
						id: child.id,
						parent: child.parent,
						text: child.text.substring(0, 9), //save some space, we will get new display name every time
						type: child.type,
						reference: child.original.reference
					});
				} else { // assuming 'folder' because we only allow link and folder on this page. 
					nodes.push({
						id: child.id,
						parent: child.parent,
						text: child.text,
						type: child.type,
						reference: child.original.reference
					});
				}
				//recursively call 
				if (child.children.length > 0) tree2edit_getChildren(theTree, child.children, nodes);
			}
		}		
		//==================================================
		function tree2edit_displayTree(context, ep_nodes, ep_entries, joinKeys, getKeys, folder_name_id, module) {
			if (typeof (joinKeys) == "undefined") {
				tree2edit_showMsg("no joined keys passed in, undefined!");
				return false;
			}

			if (joinKeys.length < 1) {
				tree2edit_showMsg("no joined keys passed in, error!");
				return false;
			}

			if (typeof (getKeys) == "undefined") {
				tree2edit_showMsg("no get keys passed in, undefined!");
				return false;
			}

			var tree_timeid = (new Date()).valueOf();
			jQuery("#tree_message").empty();
			jQuery("#tree_show").empty();
			jQuery("#tree_show").append("<img src='" + context + "/images/ajax-loader.gif' />");
			jQuery.when(
					jQuery.get(context + ep_nodes + "?timeid=" + tree_timeid),
					jQuery.get(context + ep_entries + "?timeid=" + tree_timeid)
				)
				.fail(function (jqXHR, textStatus, errorThrown) { //first failure 
					tree2edit_showMsg("ajax error in tree loading..." + errorThrown);
					console.log("tree_error4loading...jqXHR..." + JSON.stringify(jqXHR));
					console.log("tree_error4loading...textStatus..." + textStatus);
					console.log("tree_error4loading...errorThrown..." + errorThrown);
				})
				.done(function (a1, a2) {
					//--------------------------get returned data
					var nodes = [];
					var nodeTextStatus = a1[1];
					var nodeJqXHR = a1[2];
					var links = [];
					var linkTextStatus = a2[1];
					var linkJqXHR = a2[2];

					//--------------------------checking returned status 
					if (nodeTextStatus === 'success') {
						if (a1[0].content === undefined) {
							nodes = [];
						} else {
							nodes = eval(a1[0].content); //convert the saved string into an array 
						}
					} else {
						tree2edit_showMsg('tree ajax error...node...' + nodeTextStatus);
						console.log("AJAX error...a1..." + JSON.stringify(a1));
						return false;
					}
					if (linkTextStatus === 'success') {
						if (a2[0] === undefined) {
							links = [];
						} else {
							links = a2[0];
						}
					} else {
						tree2edit_showMsg('tree ajax error...link...' + linkTextStatus);
						console.log("AJAX error...a2..." + JSON.stringify(a2));
						return false;
					}

					//--------------------------compare the saved tree and the newly got links
					var flag = 0;
					var joinString = "";
					var joinTmp = [];
					for (var i = 0; i < nodes.length; i++) {
						if (nodes[i].type === 'link') { //find the matched link 
							flag = 0;
							for (var j = 0; j < links.length; j++) {
								//----get the join string
								if (joinKeys.length == 1) {
									joinString = jQuery.trim(links[j][joinKeys[0]]);
								} else {
									joinTmp = [];
									for (var k = 0; k < joinKeys.length; k++) {
										joinTmp[k] = jQuery.trim(links[j][joinKeys[k]]);
									}
									joinString = joinTmp.join("-");
								}
								//----join them 
								if (joinString === nodes[i].reference + "") {
									//get new name all the time //nodes[i].text = links[j][getKey]; 
									joinTmp = [];
									for (var m = 0; m < getKeys.length; m++) {
										joinTmp[m] = jQuery.trim(links[j][getKeys[m]]);
									}
									nodes[i].text = joinTmp.join(" | ");
									//this is done, remove it
									links.splice(j, 1);
									flag = 1;
									break;
								}
							}
							if (flag === 0) {
								nodes.splice(i, 1); //not matched, this node is NOT needed any more. 
								i--; //because of splicing the array, we need this to avoid jumping over the next item we should check
							}
						}
					}
					//--------------------------create the tree
					tree2edit_initTreeArea(nodes, links, joinKeys, getKeys, folder_name_id);
					console.log('we have done loading ..' + (new Date()).getHours() + ":" + (new Date()).getMinutes() + ":" + (new Date())
						.getSeconds());
				});
		}
		//==================================================
		function tree2edit_initTreeArea(nodes, links, joinKeys, getKeys, folder_name_id) {
			jQuery('#tree_show').jstree("destroy");
			jQuery('#tree_show')
				.jstree({
					'core': {
						'data': nodes,
						'check_callback': true,
						"multiple": true,
						"animation": 0
					},
					'force_text': true,
					'plugins': ['dnd', 'wholerow', 'types', 'search', 'checkbox'],
					"types": {
						"#": {
							"max_depth": 2,
							"valid_children": ["folder", "link"]
						},
						"folder": {
							"valid_children": ["link"]
						},
						"link": {
							'icon': 'jstree-file',
							"valid_children": []
						}
					},
					'search': {
						'show_only_matches': true
					},
					'checkbox': {
						'keep_selected_style': true
					}
				})
				.on('move_node.jstree', function (e, data) {
					//console.log("move...we get id:" + data.node.id);
					//console.log("move...we get new parent:" + data.parent);
				})
				.on('ready.jstree', function (e, data) {
					if (links.length > 0) {
						tree2edit_showMsg("Loading data - please wait");
						var joinTmp = [];
						var joinString = "";
						var textString = "";
						jQuery.each(links, function (index, item) {
							//----reference
							joinTmp = [];
							for (var k = 0; k < joinKeys.length; k++) {
								joinTmp[k] = jQuery.trim(item[joinKeys[k]]);
							}
							joinString = joinTmp.join("-");
							//----text to show 
							joinTmp = [];
							for (var m = 0; m < getKeys.length; m++) {
								joinTmp[m] = jQuery.trim(item[getKeys[m]]);
							}
							textString = joinTmp.join(" | ");
							//----show the new node
							data.instance.create_node(
								'#', {
									text: textString,
									type: 'link',
									reference: joinString
								},
								'last',
								function (newNode) {
									console.log(newNode.id + ' : ' + newNode.text + ' is created!')
								}
							);
						});
						IBMCore.common.widget.overlay.hideAllOverlays();
					};
										
				})
				.on('changed.jstree', function (e, data) {
					// 		if(data && data.selected && data.selected.length) {
					// 			var tmp = data.instance.get_node(data.node.id).original; 
					// 			jQuery('#'+folder_name_id).val(tmp.text);			
					// 			jQuery.each(tmp, 		function(name, value){ console.log('monitoring...original.......'+name+':'+value) });
					// 			jQuery.each(data.node, 	function(name, value){ console.log('monitoring...node...........'+name+':'+value) });
					// 		}
				});
		}
	</script>
	<!-- ================================================================= custom page doc ready JavaScript codes end -->
</body>

</html>