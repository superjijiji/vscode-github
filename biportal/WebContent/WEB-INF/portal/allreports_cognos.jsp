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
<title>All Reports (Cognos)</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>

<script type="text/javascript">

	/*
	 * Navigation Bars
	 */
	 function NavigBar(fid,fname){
		this.folderId = fid;
		this.folderName = fname;
	}
	 
	function NavigBars(){
		this.navigBars = null;
	}
	NavigBars.prototype.addBar = function(navigBar){
		if (this.navigBars == null) {
			this.navigBars = new Array();
		}
		this.navigBars.push(navigBar);
	}
	NavigBars.prototype.toString = function(){
		if (this.navigBars == null || this.navigBars.length == 0){
			return "";
		}
		var htmls = "";
		var navigBar; 
		var naviBarsRe = this.navigBars.reverse();
		for (var int = naviBarsRe.length - 1; int >=0;) {
			navigBar = naviBarsRe[int];
			if (int == 0) {
				htmls += navigBar.folderName
			} else {
				htmls += '<a onclick="openNaviCognos(\'' + navigBar.folderId + '\')"' + ' style="cursor: pointer">'+navigBar.folderName+'</a>';
				htmls += ' > ';
			};
			int--;
		}
 
		return htmls;		
	}

	NavigBars.prototype.toMyString = function(){
		if (this.navigBars == null || this.navigBars.length == 0){
			return "";
		}
		var htmls = "";
		var navigBar; 
		var naviBarsRe = this.navigBars.reverse();
		for (var int = naviBarsRe.length - 1; int >=0;) {
			navigBar = naviBarsRe[int];
			if (int == 0) {
				htmls += navigBar.folderName
			} else {
				htmls += '<a onclick="openMyNaviCognos(\'' + navigBar.folderId + '\')"' + ' style="cursor: pointer">'+navigBar.folderName+'</a>';
				htmls += ' > ';
			};
			int--;
		}
 
		return htmls;		
	}



	var cwa_id = '${requestScope.cwa_id}';
	var uid = '${requestScope.uid}';
	var domain_key = '${requestScope.domain_key}';
	
	
	
    jQuery(document).ready(function () {

        initCognosAllRpt();
        initCognosMyRpt();
        
    });
	function initCognosAllRpt() {
     //init cognos all report,read data from rest api
		// parameter uid,cwaid and domain_key ,folder_id default for root
		callCognosAll("root");
	}
	  var navigBars;
	var cognosAllRpts = new BIReports('cognosAllRpts','ca');
	      function callCognosAll(folder_id) {
			jQuery("#allrpts_cognos_list_div").empty();
	        document.getElementById('allrpts_cognos_list_div').innerHTML="Loading...";
	
        jQuery("#allrpts_cognos_list_div").append("<img src='<%=path%>/images/ajax-loader.gif' />");
        
           navigBars = new NavigBars();
             var timeid = (new Date()).valueOf();
             jQuery.ajax({
              
                type: 'GET', url: '<%=path%>/action/portal/allreports/getCognosPublicRestAPI/' + cwa_id + '/' + uid + '/' + domain_key+'/'+folder_id + '?timeid=' + timeid,
                 timeout : 30000,
                
                
                success: function (data) {
                
                
                    if (data.length > 0) {
                       for (var i = 0; i < data.length; i++) {
                       
                       
                       
                       if(data[i].reportType=='navi'){
						 var navigBar = new NavigBar(data[i].rptObjID,data[i].rptName);
                            navigBars.addBar(navigBar);
						}else if(data[i].reportType=='domain'){
						
						setDomainName(data[i].rptName);
						
						}else{
						
					
						
						var cognos_report = new BIReport('cognosAllRpts', 'ca', data[i]);
                                            cognosAllRpts.addReport(cognos_report);
						}
						
							
						}
						jQuery("#allrpts_cognos_list_div1").html(navigBars.toString());
						var contents =cognosAllRpts.toString()
						 cognosAll_showReport(contents);
                    }else{
                    
                    jQuery("#allrpts_cognos_list_div").html("No content.");
                    
                    
                    }
                },
                error: function (data) {
                    alert('callCognosAll - ajax return error!!!');
                    jQuery("#allrpts_cognos_list_div").html("An error has occurred. Please try again later。");
                }
            });
        }
	
	function setDomainName(domainName){
	//
	var title='All Reports ('+domainName+')';
	var str11='<strong class="ibm-h4">'+title+'</strong>';
	 jQuery(document).attr("title",title);
	
	jQuery("#domain_id").html(str11);
	
	
	}
	 function cognosAll_showReport(cognos_reports) {
	 jQuery("#allrpts_cognos_list_div").empty();;
        var html = "";
        html = cognos_reports;
        if((html==null)||(html=='')){
        
        html="No content."
        }
        jQuery("#allrpts_cognos_list_div").html(html);
    }
	
	
	function openPublicCognos(domainkey1,objectid){
	
	 cognosAllRpts=null;
	 cognosAllRpts=new BIReports('cognosAllRpts','ca');
	callCognosAll(objectid);
	
	
	}
		
	
	function openNaviCognos(objectid){

	 cognosAllRpts=null;
	 navigBars=null;
	 cognosAllRpts=new BIReports('cognosAllRpts','ca');
	callCognosAll(objectid);
	
	
	}
	
/* for my reports */
	
	function initCognosMyRpt() {
     //init cognos my report,read data from rest api
		// parameter uid,cwaid and domain_key ,folder_id default for null
		callCognosMy("null")
	}
	  var myNavigBars;
	  
	var cognosMyRpts = new BIReports('cognosMyRpts','cm');
	      function callCognosMy(folder_id) {
			 jQuery("#myrpts_cognos_list_div").empty();
		     document.getElementById('myrpts_cognos_list_div').innerHTML="Loading...";
	         jQuery("#myrpts_cognos_list_div").append("<img src='<%=path%>/images/ajax-loader.gif' />");
			 
			 
			 myNavigBars = new NavigBars();
             var timeid = (new Date()).valueOf();
             jQuery.ajax({
                type: 'GET', url: '<%=path%>/action/portal/allreports/getCognosMyRestAPI/' + cwa_id + '/' + folder_id  + '/' + uid +'/'+ domain_key + '?timeid=' + timeid,
                timeout : 30000,
                success: function (mydata) {
                
                console.log(mydata);
                    if (mydata.length > 0) {
                       cognosMyRpts = null;
					   cognosMyRpts = new BIReports('cognosMyRpts','cm');
                       for (var i = 0; i < mydata.length; i++) {
 
					    if(mydata[i].reportType=='navi'){
                    	   var myNavigBar = new NavigBar(mydata[i].rptObjID,mydata[i].rptName);
                    	   myNavigBars.addBar(myNavigBar);
						}else if(mydata[i].reportType=='domain'){
							
							setDomainName(mydata[i].rptName);
							
							}else{
								
								var my_cognos_report = new BIReport('cognosMyRpts', 'cm', mydata[i]);
								cognosMyRpts.addReport(my_cognos_report);
						}
						
						}
						jQuery("#myrpts_cognos_list_div1").html(myNavigBars.toMyString());
						console.log(myNavigBars.toMyString());
						var myContents =cognosMyRpts.toString()
						 cognosMy_showReport(myContents);
                    }else{
                        jQuery("#myrpts_cognos_list_div").html("No content.");
                        }
                },
                error: function (mydata) {
                    alert('callCognosMy - ajax return error!!!')
                    jQuery("#myrpts_cognos_list_div").html("An error has occurred. Please try again later。");
                }
            });
             
	}

	function cognosMy_showReport(cognos_reports) {
		jQuery("#myrpts_cognos_list_div").empty();;
		var html = "";
		html = cognos_reports;
		if((html==null)||(html=='')){
	        
	        html="No content."
	        }
	   jQuery("#myrpts_cognos_list_div").html(html);
	}

	function openMyCognos(domainkey1, objectid) {
		jQuery("#myrpts_cognos_list_div").html("Loading...");
		;
		cognosMyRpts = null;
		cognosMyRpts = new BIReports('cognosMyRpts', 'cm');
		callCognosMy(objectid);

	}

	function openMyNaviCognos(objectid) {

		cognosMyRpts = null;
		myNavigBars = null;
		cognosMyRpts = new BIReports('cognosMyRpts', 'cm');
		callCognosMy(objectid);

	}
</script>


</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>

	<div class="ibm-fluid" id="reportSearch_Results_div">

		<div id="EOD_results" class="ibm-col-12-12">

			<div id="domain_id" style="float: left;">
				<strong class="ibm-h4">All Reports</strong>
			</div>


			<table class="ibm-data-table ibm-padding-small ibm-altrows"
				width="100%" border="0" cellspacing="0" cellpadding="0"
				summary="Data table example">

			</table>


			<div data-widget="dyntabs" class="ibm-graphic-tabs">
				    
				<!-- Tabs here: -->
				    
				<div class="ibm-tab-section">
					        
					<ul class="ibm-tabs" role="tablist">
						<li><a aria-selected="true" role="tab" href="#example2-tab1">Public
								Folders</a></li>
						<li><a role="tab" href="#example2-tab2">My Folders</a></li>
					</ul>
					    
				</div>
				    
				<!-- Tabs contents divs: -->
				    
				<div id="example2-tab1" class="ibm-tabs-content">

					<div id="allrpts_cognos_list_div1" style="margin: 2px 0 2px 0"></div>
					<div id="allrpts_cognos_list_div" style="margin: 2px 0 2px 0"></div>
				</div>
				    
				<div id="example2-tab2" class="ibm-tabs-content">

					<div id="myrpts_cognos_list_div1" style="margin: 2px 0 2px 0"></div>
					<div id="myrpts_cognos_list_div" style="margin: 2px 0 2px 0"></div>
				</div>
				   
			</div>


		</div>

	</div>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>