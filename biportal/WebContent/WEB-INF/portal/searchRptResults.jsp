<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>Cognitive BI@IBM</title>
</head>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<style type="text/css">
td.details-control {
	background: url('<%=path%>/images/details_open.png') no-repeat center
		center;
	cursor: pointer;
}

tr.shown td.details-control {
	background: url('<%=path%>/images/details_close.png') no-repeat center
		center;
}
</style>

<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>  -->

<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>

	<script type="text/javascript" src="<%=path%>/javascript/reportmodel.js"></script>

	<script type="text/javascript">
	   //=============================================tbsListMessage* 
        function mytbsMessage(message) {
            IBMCore.common.widget.overlay.hide('mytbs_batch_form', true); 
            var myOverlay = IBMCore.common.widget.overlay.createOverlay({
                contentHtml: '<p>' + message + '</p>',
                classes: 'ibm-common-overlay ibm-overlay-alt'
            });
            myOverlay.init();
            myOverlay.show();
        }
        
        function mytbsMessageError(message) {
             IBMCore.common.widget.overlay.hide('mytbs_batch_form', true); 
            var myOverlay = IBMCore.common.widget.overlay.createOverlay({
                contentHtml: '<p class="ibm-textcolor-red-50 ibm-bold ibm-center">' + message + '</p>',
                classes: 'ibm-common-overlay ibm-overlay-alt-three'
            });
            myOverlay.init();
            myOverlay.show();
        }

	
	function mytbsPageByDeckCancel(){
			//var theOverlayId = IBMCore.common.widget.overlay.getWidget("mytbs_bydeck").getId();
			IBMCore.common.widget.overlay.hide('mytbs_batch_form', true); 	
        } 
        
        function mytbsPageByDeckOk(){      
			//---check the selection 
 			var nSelected=jQuery('input[name="chkbox_report"]:checked').size();
			if (nSelected < 1) {
				mytbsMessage("Please at select one report.");
				return null; 
			}
			
			
			//---save ids on the page
			var listOfReportPKs;
listOfReportPKs=new Array();

var nSelected=jQuery('input[name="chkbox_report"]:checked').size();
console.log(nSelected);
jQuery('input[name="chkbox_report"]:checked').each(function(){ 
console.log(jQuery(this).val());
listOfReportPKs.push(jQuery(this).val());
});

var postData=new Object();
postData.action=action;
postData.listOfReportPKs=listOfReportPKs;
var input_val=jQuery('#cwa_'+action).val();
input_val=jQuery.trim(input_val);
if(input_val!=''){
if(!checkEmail(input_val)){
mytbsMessageError("Please input a valid intranet ID.");

}

}

postData.value=input_val;
			
 			
			//---close the popup 
			
			IBMCore.common.widget.overlay.hide('mytbs_batch_form', true); 
				var jsondata =JSON.stringify(postData);
console.log(jsondata);
			handleSaveSettingCallback(jsondata);
			console.log(postData);
			//---redraw the page 
			//mytbsPageAjax();
        } 
	
		jQuery("#ibm-com").css("backgroundColor", "white");	
	 var action="";
		var path = '<%=request.getContextPath()%>';
		var cwa_id = '${requestScope.cwa_id}';
		var searchType = '${requestScope.searchType}';
		var domains = '${requestScope.domains}';
		var fields = '${requestScope.fields}';
		var keywords = decodeURIComponent('<%=URLEncoder.encode(request.getAttribute("keywords").toString(),"utf-8")%>').replace(/\+/g,' ');
		var page = '${requestScope.page}';
		var page_row = '${requestScope.page_row}';
		var domainList = ${requestScope.domainList};
		var reportbeanList = new ReportbeanList('reportbeanList');
     	//
     	function assginProfiles(){
     	  var nSelected=jQuery('input[name="chkbox_report"]:checked').size();
     	  if(nSelected!=1){
     	  alert("You can only pick one report to assgin profiles");
     	  
     	  }else{
     	  jQuery('input[name="chkbox_report"]:checked').each(function(){ 
console.log(jQuery(this).val());
      var rptPK1=jQuery(this).val();
      //TODO
      var url=path+'/action/portal/cognitive/assignReportProfile?cwa_id='+cwa_id+'&rpid='+rptPK1;
      var newWin = window.open(url, '_blank', 'resizable=yes,toolbar=yes,menubar=yes,scrollbars=yes');
      
});
     	  
     	  }
     	
     	}
		jQuery(document).ready(function() {
		jQuery("a[id^='button_']").click( function () {
    	    var nSelected=jQuery('input[name="chkbox_report"]:checked').size();
	jQuery("#mytbs_batch_num_selected").text(	nSelected+" reports(s) are selected.");
           var button_prex="button_"
           var subFrom=button_prex.length;

    	   var full_id=jQuery(this).attr('id');
    	   //alert(full_id);
    	  action=full_id.substring(subFrom);
//jQuery("input[name='mytbs_batch_operation']").hide();
//jQuery('#div_backup').show();
              

              IBMCore.common.widget.overlay.show("mytbs_batch_form");
		    		//jQuery("#mytbs_batch_num_selected").text(				postData.length+" schedule(s) are selected."); 
		    		//changereportauthor
		    		//changereportowner
		    		//changebackupowner
		    		jQuery("div[name='mytbs_batch_operation']").hide();
                    jQuery('#div_'+action).show();

    	     } );
    	    
			var status = '${requestScope.status}';
			jQuery('#id_search_keywords').val(keywords);
			if(status=='failed'){
				alert("Failed to search report, please try again later.");
				return;
			}
			var jsonData = ${requestScope.results};
			reportbeanList.empty();
			//
			jQuery("#center_col").empty();
			jQuery("#status").empty();
			var jsonSize = jsonData.length;
			if(jsonSize<1){
				jQuery("#center_col").empty();
				jQuery("#status").empty();
				jQuery("#page_control").empty();
				jQuery("#status").html("<span><Strong>Retrun JSON Array length is incorrect. Please try again later.</Strong></span>");
				return;
			}
			for(var j=0;j<jsonSize;j++){
				var resultSize = jsonData[j].matching_results;
				console.log(resultSize);
				var data = jsonData[j].results;
				if (data.length > 0) {					
					for (var i = 0; i < data.length; i++) {
						var domain = getDomain(data[i].domainKey);
						var rptbean = new ReportBean(data[i],domain);
						reportbeanList.addReport(rptbean);
	
					}
					jQuery("#center_col").append(reportbeanList.toHtmlView());
	
					jQuery('#search_result_table_id tbody')
							.on(
									'click',
									'td.details-control',
									function() {
										var id = jQuery(this).attr("id");
										var tr_id = "#tr_" + id;
										var hidden_id = "#desc_" + id;
										var status = jQuery(hidden_id).attr("hidden");
										if (status == "hidden") {
											jQuery(hidden_id).removeAttr("hidden");
											jQuery(tr_id).addClass('shown');
										} else {
											jQuery(hidden_id).attr("hidden", true);
											jQuery(tr_id).removeClass('shown');
										}
									});
					/*page control process */
					pageControlProcess(fields, keywords, page, page_row, searchType, resultSize);
					
					
			
jQuery("#search_result_table_id").tablesrowselector();		
					
            jQuery("#checkall_checkbox").click(function(){   
    if(jQuery("#checkall_checkbox").is(":checked")){  
         jQuery('input[name="chkbox_report"]').each(function(){  
             jQuery(this).prop("checked", true);  
         });  
    }else{  
        jQuery('input[name="chkbox_report"]').each(function(){  
             jQuery(this).removeAttr("checked");  
         });  
    }  
});
					
					
					
					
					
				} else {
					jQuery("#center_col").empty();
					jQuery("#status").empty();
					jQuery("#status").html("<span><Strong>No contents</Strong></span>");
				}
			}
			
			
			
			
			
			
			
		});
		
     	
     	function getDomain(domainKey){
     		for(var i=0;i<domainList.length;i++){
     			if(domainList[i].DOMAIN_KEY==domainKey){
     				return domainList[i];
     			}
     		}
     		return null;
     	}
     	
		function search(){
			var searchType = jQuery("#id_search_searchType").val();
			var domains = jQuery("#id_search_domains").val();
			var fields = jQuery("#id_search_fields").val();
			var keywords = jQuery("#id_search_keywords").val();
			var page = jQuery("#id_search_page").val();
			var page_row = jQuery("#id_search_page_row").val();
			if(keywords==null||jQuery.trim(keywords)==''){
				return false;
			}
			//biportal/action/cognitive
			var href=path+'/action/admin/cognitive/search?domains='+domains+'&fields='+fields+'&keywords='+encodeURI(keywords)+'&page=1&page_row='+page_row;
			if(searchType=='basic'){
				href+='&searchType=advanced';
				window.location.href=href;
			}else if(searchType=='advanced'){
				href+='&searchType=advanced';
				window.location.href=href;
			}else{
				href+='&searchType=advanced';
				window.open(href);
			}
		}
        function callBackChangeinfo(){
        
        var colPosition=0;
        if(action=='changereportauthor'){
         colPosition=3;
        }else if (action=='changereportowner'){
        colPosition=4;
        }else if(action=='changebackupowner') {
        
          colPosition=5;
        
        
        }
       jQuery('input[name="chkbox_report"]:checked').each(function(){ 
    var trRow=jQuery(this).closest('tr');
    var input_val=jQuery('#cwa_'+action).val();
input_val=jQuery.trim(input_val);
   jQuery(trRow).children('td').eq(colPosition).html(input_val);
        }); 
        
        
        
        }
		function pageControlProcess(fields, keywords, current_page, page_row, searchType, resultSize) {
			jQuery("#page_control").empty();
			
			var pageCount = Math.ceil(resultSize/page_row);
			
			if(pageCount>1){
				var page_control_html = '';				
				var first_href = path+'/action/admin/cognitive/search?fields='+fields+'&keywords='+keywords+'&page=1&page_row='+page_row;
				var last_href = path+'/action/admin/cognitive/search?fields='+fields+'&keywords='+keywords+'&page='+pageCount+'&page_row='+page_row;
				//
				var show=0;
				for(var i=1;i<pageCount+1;i++){
					var href=path+'/action/admin/cognitive/search?fields='+fields+'&keywords='+keywords+'&page='+i+'&page_row='+page_row;
					if(i==current_page) {
						page_control_html += '<span style="display: inline-block;margin: 0;padding-left: 2.1em;position: relative">'+i+'</span>';
						show++;
					} else {
						if( (i > current_page - 5 || i > pageCount - 10) ){
							page_control_html += '<a href="'+href+'">'+i+'</a>';
							show++;
							if(show>=10){
								break;
							}
						}
					}
				}
				
				if(current_page - 5 > 0 && pageCount>10){
					page_control_html = '<a href="'+first_href+'">first<</a>' + page_control_html;
				}
				if(current_page + 5 < pageCount){
					page_control_html += '<a href="'+last_href+'">>last</a>';
				}

				page_control_html = '<p class="ibm-ind-link">'+page_control_html+'</p>';
				//
				jQuery("#page_control").html(page_control_html);
			}

		}
		
		function setPreference(){
			var href="<%=request.getContextPath()%>/action/cognitive/preferences";
			var keywords = jQuery("#id_search_keywords").val();
			href +="?keywords="+encodeURI(keywords);
			window.location.href=href;
		}
		function checkEmail(email){ //allow dot, underscore, characters, numbers, then after that it is @ibm.com or @**.ibm.com
			if (email.match(/^([_,\-,\.,\w])+@([\.,\w])*ibm.com$/) === null)  {
				return false; 
			} else {
 				return true;
			}     
        }
        
function handleSaveSettingCallback(jsonData){
	
	
	
	//showLoading();
	  jQuery.ajax({
	        
	        type:"POST",
	       
	       // url:deck_app_url+'createpreview',
	        url: path+'/action/portal/cognitive/updateSetting',
	        data:jsonData,
	        contentType:"application/json",
	      
	        datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".

	       
	       
	        success:function(resObject){
	        	
	        	alert("Your report data has been updated.");
	        	callBackChangeinfo();
	        	// hiddLoading();
	        	
	        }   ,
	       
	        complete: function(XMLHttpRequest, textStatus){
	          // alert(XMLHttpRequest.responseText);
	        
	        },
	        
	        error: function(XMLHttpRequest, textStatus, errorThrown){
	         alert("Sorry,error occured,please try again later.details:"+XMLHttpRequest.responseText);
	         
	        }         
	     });
}
        
	</script>

	<div class="ibm-fluid">
		<div class="ibm-col-1-1 ibm-right ibm-seamless ibm-fullwidth">
			<a href="#" onClick="setPreference();return false;" style="color: black; text-align: right">Search settings</a>
		</div>
		
		<div style="font-size: 15px; font-weight: bold;">
		<form id="searchForm" class="ibm-form" method="post" onsubmit="search();return false;">
			<input id="id_search_cwa_id" name="cwa_id" value='${requestScope.cwa_id}' type="hidden" />
			<input id="id_search_searchType" name="searchType" value='${requestScope.searchType}' type="hidden" />
			<input id="id_search_domains" name="domains" value='${requestScope.domains}' type="hidden" />
			<input id="id_search_fields" name="fields" value='${requestScope.fields}' type="hidden" />
			<input id="id_search_page" name="page" value='${requestScope.page}' type="hidden" />
			<input id="id_search_page_row" name="page_row" value='${requestScope.page_row}' type="hidden"/>
			<div id="divrptowner_root_buttondiv" class="ibm-btn-row ibm-right">
			<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" onclick="assginProfiles()" id="assign_reportProfiles">Assign report profiles </a>
			<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="button_changereportauthor">Change report author </a>
			<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="button_changereportowner">Change report owner</a>
			<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" id="button_changebackupowner">Change backup owner </a>
			</div>
			<span>Discover report(s) </span>
			<input id="id_search_keywords" style="width: 40%; height: 23px" type="text" name="keywords" size="300" maxlength="300" value="" placeholder="Please input report name..." /> 
			<input id="id_search_button" class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" value="GO" onClick="search();return false;" /> 
			
		</form>
		</div>
<div id="mytbs_batch_form" class="ibm-common-overlay ibm-overlay-alt" data-widget="overlay" data-type="alert">
<h3 id="mytbs_batch_num_selected" class="ibm-h3">0 report(s) are selected.</h3>
	 
 		<div name="mytbs_batch_operation" id="div_changebackupowner" >
    		<p>Please specify the desired back-up owner for your selected reports by entering their intranet ID (e.g.jdoe@us.ibm.com) or leave blank to delete the existing entry.</p>
    		<p><label for="cwa_changebackupowner">The intranet ID:&nbsp;</label><span><input id="cwa_changebackupowner" size="30" value="${requestScope.cwa_id}" type="text" placeholder="jdoe@us.ibm.com" /></span></p>
    	</div>
<div name="mytbs_batch_operation" id="div_changereportauthor" >
    		<p>Please specify the desired report author for your selected reports by entering their intranet ID (e.g.jdoe@us.ibm.com) or leave blank to delete the existing entry.</p>
    		<p><label for="cwa_changereportauthor">The intranet ID:&nbsp;</label><span><input id="cwa_changereportauthor" size="30" value="${requestScope.cwa_id}" type="text" placeholder="jdoe@us.ibm.com" /></span></p>
    	</div>
    	<div name="mytbs_batch_operation" id="div_changereportowner" >
    		<p>Please specify the desired report owner for your selected reports by entering their intranet ID (e.g.jdoe@us.ibm.com) or leave blank to delete the existing entry.</p>
    		<p><label for="cwa_changereportowner">The intranet ID:&nbsp;</label><span><input id="cwa_changereportowner" size="30" value="${requestScope.cwa_id}" type="text" placeholder="jdoe@us.ibm.com" /></span></p>
    	</div>
 		<br>
 		<p class="ibm-btn-row ibm-center">
 			<button class="ibm-btn-pri ibm-btn-blue-50 ibm-btn-small" onclick="mytbsPageByDeckOk();"		>OK</button> 
 			<button class="ibm-btn-sec ibm-btn-blue-50 ibm-btn-small" onclick="mytbsPageByDeckCancel();"	>Cancel</button>  	
 		</p>
 	</div>

		<div id="nav_tab"></div>

		<div id="results" class="ibm-fluid ibm-seamless ibm-fullwidth">
			<div id="status"></div>
			<div id="center_col" class="ibm-col-12-12"></div>
			<div id="page_control" class="ibm-col-12-12"></div>
		</div>

	</div>

	<!-- =================== report search results List - END =================== -->

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>

</body>
</html>
