<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM | Zip Deck Panel</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<script type="text/javascript">
	var zipDeck = {};
	var status = '${statusCode}';
	var error = '';
	if (status == 'CREATED') {
		zipDeck["deckId"] = '${zipDeckMap.deckId}';
		zipDeck["cwaId"] = '${zipDeckMap.cwaId}';
		zipDeck["deckOutputFormat"] = '${zipDeckMap.deckOutputFormat}';
		zipDeck["uid"] = '${zipDeckMap.uid}';
		zipDeck["deckStatus"] = '${zipDeckMap.deckStatus}';
		zipDeck["deckType"] = '${zipDeckMap.deckType}';
		zipDeck["lastRunningId"] = '${zipDeckMap.lastRunningId}';
		zipDeck["lastStatus"] = '${zipDeckMap.lastStatus}';
		zipDeck["lastSubmit"] = '${zipDeckMap.lastSubmit}';
		zipDeck["createTime"] = formateDateToGMT(${zipDeckMap.createTime});
		zipDeck["log_fileSize"] = '0';
		zipDeck["log_running_id"] = '';
		zipDeck["log_comments"] = '';
		zipDeck["log_status"] = 'submitted';
	} else {
		error = '${error}';
	}

	function submitToZip(zipDeck){
		var url = '<%=path%>/action/portal/zipdeck/zip';
		var zip = {};
		zip["zipDeck_id"] = zipDeck["deckId"];
		zip["cwa_id"] = zipDeck["cwaId"];
		zip["uid"] = zipDeck["uid"];
		jQuery
				.ajax({
					type : "post",
					url : url,
					data : JSON.stringify(zip),
					contentType : "application/json",
					datatype : "json",
					beforeSend : function() {
					},
					success : function(data) {
						zipDeck["log_status"] = 'Running';
						zipDeck["lastRunningId"] = data.Running;
						zipDeck["log_running_id"] = data.Running;
						//alert(zipDeck["log_running_id"]);
						getDetailLog(zipDeck);
					},
					error : function(error) {
						//statusCode = error.status;
						zipDeck["log_status"] = 'Error';
						//responseText = error.responseText;
						zipDeck["log_comments"] = (error.responseText==''?error.statusText:error.responseText);
						refreshTable(zipDeck);
						//alert('failed to send zip request, reason:'
						//		+ error.responseText + ', status code:'
						//		+ error.status);
					}
				});
	}
	
	function getDetailLog(zipDeck){
		jQuery("#id_zipdeck_loading_status_"+zipDeck.deckId).attr('class','loading');
		jQuery("#id_zipdeck_loading_status_"+zipDeck.deckId).attr('onClick','');		
		timeid = (new Date()).valueOf();
		var url = '<%=path%>/action/portal/zipdeck/log/'+zipDeck.cwaId+'/'+zipDeck.uid+'/'+zipDeck.log_running_id+'?timeid='+timeid;
		jQuery
				.ajax({
					type : "get",
					url : url,
					beforeSend : function() {
					},
					success : function(data) {
						if(data==null||data==undefined||data==''){
							zipDeck["log_status"] = 'Running';
							zipDeck["log_fileSize"] = 0;
							zipDeck["log_comments"] = 'please refresh later';							
						}else{
							zipDeck["log_status"] = 'Running';
							if(data.status==300){
								zipDeck["log_status"] = 'Running';
							}
							if(data.status==200){
								zipDeck["log_status"] = 'Error';
							}
							if(data.status==100||data.status==101){
								zipDeck["log_status"] = 'Done';
							}
							zipDeck["log_fileSize"] = bytesToSize(data.fileSize);
							zipDeck["log_comments"] = data.messages;							
						}
						refreshTable(zipDeck);
						jQuery("#id_zipdeck_loading_status_"+zipDeck.deckId).attr('class','refresh');
						jQuery("#id_zipdeck_loading_status_"+zipDeck.deckId).css({'padding': '0px'});
						jQuery("#id_zipdeck_loading_status_"+zipDeck.deckId).attr('onClick','refresh(\''+zipDeck.deckId+'\');'); 						
					},
					error : function(error) {
						//statusCode = error.status;
						zipDeck["log_status"] = 'Error';
						//responseText = error.responseText;
						zipDeck["log_comments"] = (error.responseText==''?error.statusText:error.responseText);
						refreshTable(zipDeck);
						//alert('failed to send zip request, reason:'
						//		+ error.responseText + ', status code:'
						//		+ error.status);
						jQuery("#id_zipdeck_loading_status_"+zipDeck.deckId).attr('class','refresh');
						jQuery("#id_zipdeck_loading_status_"+zipDeck.deckId).css({'padding': '0px'});
						jQuery("#id_zipdeck_loading_status_"+zipDeck.deckId).attr('onClick','refresh(\''+zipDeck.deckId+'\');');
					}
				});
			
	}
	
	function refresh(deckId){
		//var zipDeck = getDeck(deckId);
		if(zipDeck.log_status!='Running'){
			return;
		}
		//
		getDetailLog(zipDeck);
		//
	}
	
	function refreshTable(zipDeck){
		table_content = jQuery("#table_zipdeck_manager").DataTable();
		table_content.rows().remove();
		var col1 = '<div id="id_zipdeck_loading_status_'+zipDeck.deckId+'" class="refresh" style="float:center;cursor:pointer;" onClick="refresh(\''+zipDeck.deckId+'\');" title="Refresh" ></div>';
		var col3 = '';
		if(zipDeck["log_status"]=='Done'){
			col3 = '<A href="<%=path%>/action/portal/zipdeck/download/'+zipDeck.cwaId+'/'+zipDeck.uid+'/'+zipDeck.deckId+'/'+zipDeck.log_running_id+'" target="_blank">'+zipDeck["log_status"]+'</A>';
		}else{
			col3 = zipDeck["log_status"];
		}
        var dataSet = [col1,zipDeck["createTime"],col3 , zipDeck["log_fileSize"], zipDeck["log_comments"]]
        table_content.row.add(dataSet).draw();

        jQuery(table_content.row(0).node()).attr('id', 'id_' + zipDeck.deckId);
	}
	

	function formateDateToGMT(myTimeStamp){
		var myNewDate = new Date();
		myNewDate.setTime(myTimeStamp); 
		return myNewDate.toGMTString();
	}

	function bytesToSize(bytes) {
		try{
   			if (bytes === 0) return '0 B';
    		var k = 1024;
        	sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
        	i = Math.floor(Math.log(bytes) / Math.log(k));
  			return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
  		} catch(e){
  			alert(e);
  			return '0 B';
  		}
	}

	jQuery(document).ready(function() {
		if (status == 'CREATED') {
			submitToZip(zipDeck);
		} else {
			alert('Failed to create zip deck for you, error:'+error);
		}
		
	});
</script>
</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div class="ibm-fluid">

		<div class="ibm-col-12-2 ibm-col-medium-12-3 ibm-hidden-small">
			<nav role="navigation" aria-label="My Zip Decks">
				<div id="ibm-navigation">
					<ul id="ibm-primary-links" role="tree"
						aria-labelledby="ibm-pagetitle-h1">
						<li role="presentation" id="ibm-overview"><a role="treeitem"
							href="####">My Zip decks</a></li>
						<li role="presentation"><a aria-selected="true"
							role="treeitem" href="####">Compressed output files</a></li>
						<!-- <li role="presentation"><span class="ibm-subnav-heading">Related Links</span>
							<ul>
								<li role="presentation"><a role="treeitem" href="####">My Cognos schedules</a></li>
								<li role="presentation"><a role="treeitem" href="####">My distribution lists</a></li>
							</ul>
						</li> -->
					</ul>
				</div>
			</nav>
		</div>
		<div class="ibm-col-12-10 ibm-col-medium-12-9">
			<div id="domain_id" style="float: left;">
				<strong class="ibm-h1">My Zip decks - Compressed output
					files</strong>
			</div>
			<p class="ibm-h3 ibm-light ibm-padding-top-1"></p>
			<p class="ibm-h5 ibm-light ibm-padding-top-1"></p>
			<div class="ibm-container-body" style="padding: 0px;">
				Click on the icon <img src="../../images/refresh.gif"
					alt="<refresh icon>" style="padding: 0px;" /> to refresh the
				display. Once the process is completed successfully please click on
				the 'Done' status link to download the compressed file.
			</div>
			<!-- =================== zipdeck List - START =================== -->
			<div style="width: 100%;">
				<div id="admanager_error2show" style="width: 100%;"></div>
				<div id="admanager_list2show" style="width: 100%;"
					data-widget="showhide" data-type="panel"
					class="ibm-show-hide ibm-widget-processed">
					<p data-eod-folder-name="root" id="admanager_root_p"
						class="ibm-small">
					<table id="table_zipdeck_manager" data-widget="datatable"
						data-info="true" data-ordering="true" data-paging="false"
						data-searching="true"
						class="ibm-data-table ibm-altrows dataTable no-footer"
						data-order='[[2,"asc"]]'>
						<thead>
							<tr>
								<th></th>
								<th>Create Time</th>
								<th>Status</th>
								<th>File Size</th>
								<th width="30%">Comments</th>
							</tr>
						</thead>
						<tbody id='tbody_zipdeck_manager'></tbody>
					</table>
				</div>
			</div>
			<!-- =================== zipdeck List - END =================== -->
		</div>

	</div>


	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>



