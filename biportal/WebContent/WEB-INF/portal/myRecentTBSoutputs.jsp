<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<jsp:include page="/WEB-INF/include/v18include.jsp">
</jsp:include>
<title>BI@IBM - My recent TBS outputs</title>

<style type="text/css">
/**
*Remove sorting arrows
*/
table.dataTable thead .sorting, table.dataTable thead .sorting_asc,
	table.dataTable thead .sorting_desc {
	background: none;
}
</style>
<script type="text/javascript">window.$ = window.jQuery; </script>
<script type="text/javascript"
	src="<%=path%>/javascript/jstree-3.3.1.js">  </script>
<script type="text/javascript"
	src="<%=path%>/javascript/bimyrencenttbsoutput.js"></script>
<script type="text/javascript">  
	var cwa_id = "${cwa_id}"; 
    var uid = "${uid}"; 
    var myTBSoutputs  ;
    	
    var myTbsDtSettings = {
		colReorder:false,  // true | false (default)   // Let the user reorder columns (not persistent) 
		info:true, // true | false (default)   // Shows "Showing 1-10" texts 
		ordering:true, // true | false (default)   // Enables sorting 
		paging:true, // true | false (default)   // Enables pagination 
		scrollaxis:true, // x   // Allows horizontal scroll 
		searching:true //true | false (default)   // Enables text filtering	
	}; 

     jQuery(document).ready(function() {
		        var mytbstable = $('#myrecenttbsoutputs').DataTable();
				refresh();
	});
		
		

    function refresh(){
    	getTBSoutputpage();
    };

function getTBSoutputpage(){
    	var timeid = (new Date()).valueOf();
    	myTBSoutputs = new BIMyTBSoutputs();
    	console.log("in");
    	
        jQuery.ajax({
            type: 'GET', url: '<%=path%>/action/portal/tbsoutputs/getTBSOutputs/' + cwa_id + '/' + cwa_id + '/' + uid + "?timeid=" + timeid,
            success: function (data) {
                if (data.length > 0) {
                    var biMyTBSoutput;
                    var checkbox;
                    var tb_mytbs = $('#myrecenttbsoutputs').DataTable();
                    console.log("in2");
                    for (var i = 0; i < data.length; i++) {
                        biMyTBSoutput = new BIMyTBSoutput(data[i]);
                        //myTBSoutputs.addoutput(biMyTBSoutput);
                        checkbox = '<span class="ibm-checkbox-wrapper">';
						checkbox += '<input id="checkbox'+i+'" type="checkbox" class="ibm-styled-checkbox" '+ (null == biMyTBSoutput.running_id || "" == biMyTBSoutput.running_id  ? "disabled" : "")+'  value="'+biMyTBSoutput.running_id+'"/>';
						checkbox += '<label for="checkbox'+i+'"><span class="ibm-access">Select row</span></label>';
						checkbox += '</span>';
                        tb_mytbs.row.add( [
							checkbox,
							biMyTBSoutput.rpt_name,
							biMyTBSoutput.e_mail_subject,
							biMyTBSoutput.sched_freq,
							biMyTBSoutput.datamart,
							biMyTBSoutput.comments,
							biMyTBSoutput.run_time,
							biMyTBSoutput.domain_key,
							biMyTBSoutput.cwa_id,
							biMyTBSoutput.dl_link
        				] )
                    }
                    tb_mytbs.draw();
                    
                }
            }
        });
    }


function downLoadSignleTBSOutput(runing_id){
		console.log('runing_id= '+runing_id)
        var cwa_id = "${cwa_id}";      
	    var url = '<%=request.getContextPath()%>/action/portal/tbsoutputs/downLoadSignleTBSOutput/' + cwa_id +'/'+uid+ '/' +runing_id ;
	    console.log('url= '+url)
	    var a = document.createElement('A');
    	a.href = url;
    	a.download = url;
    	document.body.appendChild(a);
    	a.click();
    	document.body.removeChild(a);
	    return; 
}

     function downloadAllSelectedReports(){	
      
    	var runningIDs = [];
		var i=0;
    	$.each( $("input[id^='checkbox']:checkbox:checked"), function () {
    	     var  runing_id = $(this).val();    	      
    	    if(runing_id != "null" && runing_id != null && runing_id != ""){
    	    	runningIDs.push($(this).val());
    	    	console.log("checkbox="+(i++)+" "+runing_id);    	    	     
			    var url = '<%=request.getContextPath()%>/action/portal/tbsoutputs/downLoadSignleTBSOutput/' + cwa_id +'/'+uid+ '/' +runing_id ;
			    console.log('url= '+url)
			    var a = document.createElement('A');
		    	a.href = url;
		    	a.download = url;
		    	document.body.appendChild(a);
		    	a.click();
		    	document.body.removeChild(a);
    	    }    		

    	});
    	if(runningIDs.length==0){
    		alert("No Schedule selected!");
    	}
    	return;
    }
//     function downLoadSignleTBSOutput(runing_id){
// 		console.log('runing_id= '+runing_id)
//         var cwa_id = "${cwa_id}";      
<%-- 	    var url = '<%=request.getContextPath()%>/action/portal/tbsoutputs/downLoadSignleTBSOutput/' + cwa_id +'/'+uid+ '/' +runing_id ; --%>
// 	    console.log('url= '+url)
// 	    $.ajax({
// 	        url: url,
// 	        type: 'GET',
// 	        success: function (data) { 
// 	           console.log('data= '+data)
		                    
// 		        alert("success");
//             },
// 	    	error: function (data) {
// 	    	     alert("error");
// 	      } });
// 	    return;
//     }
    
//   function downloadAllSelectedReports(){
	
//     	var runningIDs = [];
// 		var i=0;
//     	$.each( $("input[id^='checkbox']:checkbox:checked"), function () {
//     		runningIDs.push($(this).val());
//     		console.log("checkbox="+(i++)+" "+$(this).val());
//     		//alert( $(this).val() );
//     	});
//     	console.log("runningIDs="+runningIDs.lenght);
//     	if(runningIDs.length==0){
//     		alert("No Schedule selected!");
//     		return;
//     	}
    	
//        	var strRunningIds=runningIDs.join(",");
//        	console.log("runningIDs="+strRunningIds);

<%-- 	    var url = '<%=request.getContextPath()%>/action/portal/tbsoutputs/downLoadMultiTBSOutputs/' + cwa_id +'/'+uid+ '/Y/' + strRunningIds ; --%>
// 	    console.log('url= '+url)
// 	    $.ajax({
// 	        url: url,
// 	        type: 'GET',
// 	        success: function(data) {
	        	
// 	        	//Needs to add error check
// 	        	console.log('data='+data);
	        	
// 	        	var outputPahts = data.outputPahts;
// 	        	var outputFileNames = data.outputFileNames;
// 	        	console.log('outputPahts.length='+outputPahts.length);
	        	
// 	        	for(var i=0; i<outputPahts.length; i++){
// 	        		console.log('outputFileNames='+outputPahts[i]);
// 	        		var file_path = 'https://w3alpha-3.toronto.ca.ibm.com/transform/biportal/'+outputPahts[i];//needs to fix URL
// 	        		console.log('file_path='+file_path);
// 	        		var a = document.createElement('A');
// 		        	a.href = file_path;
// 		        	a.download = file_path+"/"+outputPahts[i];
// 		        	document.body.appendChild(a);
// 		        	a.click();
// 		        	document.body.removeChild(a);
// 	        	}
	        	
// 	        	return;	        	
	        	
// 	        },
// 	    	error: function (jqXHR, exception) {
// 	    		window.alert("Error: "+jqXHR.responseText);
// 	    	}
// 	    });
// 	    return;
       	
//     }
    
    

    

</script>

</head>
<body id="ibm-com" class="ibm-type" style="align: center">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>

	<!-- 			<div style=" align: center; display:table-cell; width:auto;">  	 -->
	<div
		style="width: 1024px; align: center; margin-left: auto; margin-right: auto;">
		<div class="help_link_color"
			style="min-height: 1px; padding-bottom: 3px;" id="edit-layout"
			role="region" aria-label="Help for this page" align="right">
			<a
				href="https://w3alpha-3.toronto.ca.ibm.com/transform/biportal/action/portal/pagehelp?pageKey=MostRecentTBS&pageName='My recent TBS outputs' ">Help
				for this page</a>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<p>
		<h1 class="ibm-h1 ibm-light">
			My recent TBS outputs <a id="myrecenttbsoutputs_refresh_id"
				name="myrecenttbsoutputs_refresh_name" title="Refresh"
				style="cursor: pointer" onclick="refresh();return false;"> <img
				src="/transform/biportal/images/refresh.gif" alt="refresh">
			</a>
		</h1>
		</p>

		<p>
			<input class="ibm-btn-sec" name="downloadAllReports"
				value="Download all Selected" onclick="downloadAllSelectedReports()"
				type="button">
		</p>

		<table name="myrecenttbsoutputs" id="myrecenttbsoutputs"
			data-tablerowselector="enable" class="ibm-data-table">
			<thead>
				<TR>
					<th scope="col"><span class="ibm-checkbox-wrapper"> <input
							id="allcheckID" type="checkbox" class="ibm-styled-checkbox" /> <label
							for="allcheckID"> <span class="ibm-access">Select
									row</span>
						</label>
					</span></th>
					<th scope="col">Report Name</th>
					<th scope="col">e-Mail Subject</th>
					<th scope="col">Frequency</th>
					<th scope="col">Datamart / Data Load</th>
					<th scope="col">Comments</th>
					<th scope="col">Last Run Date</th>
					<th scope="col">Domain</th>
					<th scope="col">Owner</th>
					<th scope="col">Action</th>
				</TR>
			</thead>
			<tbody>

			</tbody>
		</table>

	</div>


	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>







