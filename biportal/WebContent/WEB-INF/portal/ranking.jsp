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
<title>Report's Ranking and Comments</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<!-- Latest compiled and minified CSS -->
<script type="text/javascript">window.$ = window.jQuery; </script>

<link href="<%=request.getContextPath() + "/css/jquery.rateyo.min.css" %>" rel="stylesheet">

<!-- Latest compiled and minified JavaScript -->

<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath() + "/javascript/jquery.rateyo.min.js" %>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath() + "/javascript/jquery.lineProgressbar.js" %>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath() + "/javascript/reportrank.js" %>" ></script>
<script type="text/javascript">

	 jQuery(function(){ 
jQuery('.ibm-edit-link').click( function (){
		jQuery("#submit_form").slideToggle();
	  
		});
}); 

	  var hostPath='<%=path%>';
	  var cwa_id='${requestScope.cwa_id}';;
//encode('${requestScope.rpt_path}');
//var rpt_path="/content/folder[@name='BI@IBM-COE']/folder[@name='SRCoE-PROD']/folder[@name='Business Solution Reports']/folder[@name='Roadmap']/folder[@name='Roadmap (Daily Snapshots) and F&P Actuals and Budgets']/report[@name='SMS8989_02 Daily version of Roadmap Summary for Cloud and Security']";
var rpt_path="${requestScope.rpt_path}";
var rankMenu;
loadRankingData(hostPath,cwa_id,rpt_path);
loadReportData(hostPath,cwa_id,rpt_path);
function submitRank(val){
rankMenu.save();

  }
  function click_sumbit_comment(){
  
  saveReportComment();
  
  
  return false;
  }
    function cancel_sumbit_comment(){
  
 
  
  jQuery("#submit_form").slideToggle();
    return false;
  }
  
  
  
  function openHelp(){
	 //var url = jQuery("#core_site_id").val()+"/help/helpIndex.jsp?page=pageHelp_cognosschedpanel.jsp";
	 var url = "/transform/biportal/action/portal/pagehelp?pageKey=ReportRanking&pageName=Report+Comments+and+Ranking";
	// setCookie("reportName","Autodeck Edit Panel");
	 RIWin = window.open(url,"RptInfo","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=580,height=450,screenX=10,screenY=10");
	 RIWin.document.close();
}
</script>
<style>
	.container{
		width: 1000px;
	}
	.commentbox{
		width: 900px;
		margin: 20px auto;
	}
	.mytextarea {
	    width: 100%;
	    overflow: auto;
	    word-break: break-all;
	    height: 100px;
	    color: #000;
	    font-size: 1em;
	    resize: none;
	}
	.comment-list{
		width: 900px;
		margin: 20px auto;
		clear: both;
		padding-top: 20px;
	}
	.comment-list .comment-info{
		position: relative;
		margin-bottom: 20px;
		margin-bottom: 20px;
		border-bottom: 1px solid #ccc;
	}
	.comment-list .comment-info header{
		width: 10%;
		position: absolute;
	}
	.comment-list .comment-info header img{
		width: 100%;
		border-radius: 50%;
		padding: 5px;
	}
	.comment-list .comment-info .comment-right{
		padding:5px 0px 5px 11%; 
	}
	.comment-list .comment-info .comment-right h3{
		margin: 5px 0px;
	}
	.comment-list .comment-info .comment-right .comment-content-header{
		height: 25px;
	}
	.comment-list .comment-info .comment-right .comment-content-header span,.comment-list .comment-info .comment-right .comment-content-footer span{
		padding-right: 2em;
		color: #aaa;
	}
	.comment-list .comment-info .comment-right .comment-content-header span,.comment-list .comment-info .comment-right .comment-content-footer span.reply-btn,.send,.reply-list-btn{
		cursor: pointer;
	}
	.comment-list .comment-info .comment-right .reply-list {
		border-left: 3px solid #ccc;
		padding-left: 7px;
	}
	.comment-list .comment-info .comment-right .reply-list .reply{
		border-bottom: 1px dashed #ccc;
	}
	.comment-list .comment-info .comment-right .reply-list .reply div span{
		padding-left: 10px;
	}
	.comment-list .comment-info .comment-right .reply-list .reply p span{
		padding-right: 2em;
		color: #aaa;
	}
	.progressbar {
    width: 100%;
	margin-top: 5px;
	margin-bottom: 35px;
	position: relative;
	background-color: #EEEEEE;
	box-shadow: inset 0px 1px 1px rgba(0,0,0,.1);
}

.proggress{
	height: 8px;
	width: 10px;
	background-color: #3498db;
}

.percentCount{
	float:right;
	margin-top: 10px;
	clear: both;
	font-weight: bold;
	font-family: Arial
}
</style>

</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>

	<div class="ibm-fluid" id="reportSearch_Results_div">

		<div id="EOD_results">

		<table id="autodeck_intro_general" cellspacing="0" cellpadding="0" border="0" width="100%">
						<tbody>
							<tr>
								<td style="width: 85%;">
									<strong id="autodeck_intro_id" class="ibm-h4">Report information : <span id="deck_id"></span></strong>
									<br/><br/>
									
					<strong id="autodeck_intro_name" class="ibm-h4">Report Name: : <span id="deck_name">Loading...</span></strong> 				
						<strong id="autodeck_intro_owner" class="ibm-h4">  &nbsp       &nbsp     &nbspOwner : <span id="deck_owner">Loading...</span></strong>
						<strong id="autodeck_intro_author" class="ibm-h4">  &nbsp       &nbsp     &nbsp Author : <span id="deck_author">Loading...</span></strong>			
					<strong id="autodeck_intro_bkowner" class="ibm-h4">  &nbsp       &nbsp     &nbsp Backup : <span id="backupOwner">Loading...</span></strong>	
								</td>
								<td rowspan="2">
									
									<p class="ibm-ind-link" style="margin:0px; padding:0px;" >
									<a class="ibm-popup-link" style="margin-bottom: 1px;margin-bottom: 1px;padding-bottom: 1px;padding-top: 1px;"  onkeypress="openHelp(); return false;" onclick="openHelp(); return false;" href="#">
									Help for this page
									</a>
									</p>
									<span id="autodeck_span_addFav_id">

									</span>
								</td>
							</tr>
						</tbody>
					</table>		



<div width="80%" >
<table id="report_dummy" width="80%"   data-scrollaxis="x" class="ibm-data-table" cellspacing="0" cellpadding="0" border="0">
   

</table>

</div>
<br/>
<br/>
<br/>
<div   style="width:auto;height:auto;margin-left:auto;margin-left:auto;">
<div style="display: inline-block; vertical-align: top; padding-left: 80px; border-top-width: 50px; padding-top: 10px; padding-bottom: 0px;">
 Select a star to add a rating:
             <br>
           
          <div id="rpt_ranking_div_id" ></div>
          <div>
             <div style="display:inline-block;width:190px;vertical-align: top;">  
           <div id="progressbar2"></div>
           </div>
          <div id="now_span" style="width:50px;display:inline-block;vertical-align: top;padding-top: 10px;"><span id="span_submit" style="display: none;"><p class="ibm-icon-nolink ibm-confirm-link ibm-textcolor-green-50"><span id="display_submit" onclick="submitRank(this)" class="ibm-textcolor-default"><a style="cursor: pointer;" id='rate_now'>Rate Now</a></span></p></span>
         </div>
          
           </div>
          </div>
         


<div   style="width:200px;display:inline-block; vertical-align:top;"></div>
<div style="display:inline-block;vertical-align:top;margin:0px 20px ,2px,2px;">
<table  width="80%" id="report_info_table"  data-scrollaxis="x" class="ibm-data-table" cellspacing="0" cellpadding="0" border="0">
    <caption>
        <em>Statistics</em>
    </caption>
   
    <tbody>
        <tr>
           
            <td><strong>Total comments:</strong><span id="commentsCount"></span></td>
           <td><strong>Score:</strong><span id="rankScore"></span></td>
           
        </tr>
          <tr>
           
            <td><strong>Users:</strong><span id="userCount"></span>  </td><td>         <strong>TBS:</strong><span id="tbsCount"></span></td>
       <td><strong>Access:</strong><span id="accessCount"></span></td>
    </tbody>
</table>
<div>
</br>

<p class="ibm-icon-nolink ibm-share-mono-link ibm-textcolor-green-50 "><span class="ibm-textcolor-default">Share your thoughts with others</span></p>
	

<p class="ibm-btn-row"> &nbsp;&nbsp;&nbsp;&nbsp;<button id="submit_ran_add" class="ibm-btn-sec  ibm-edit-link	">Add Comment</button></p>
          
</div>
</div>
</div>

<br/>

            <div class="col-xs-12 comment-form">
              <form id="submit_form" class="add-comment-form" style="display: none; margin-left: 80px;">
                <div class="comment-message"></div>
                <textarea  id="comments_input" maxlength="500" cols="90" rows="5" class="form-control" placeholder="Place your public comment here."></textarea>
                <p>Note that only one comment per user is permitted.</p>
                <p class="remaining">  <span id="remaining-characters"></span></p>
                <div class="comment-buttons">

<p class="ibm-btn-row" style="padding-left: 400px;"><button id="submit_rank"  onclick="click_sumbit_comment();return false;"  class="ibm-btn-pri">Submit</button> <button onclick="cancel_sumbit_comment();return false;" class="ibm-btn-sec">Cancel</button></p>
                </div>
              </form>
            </div>




		
		



</form>

<div class="ibm-rule"><hr></div>
<table  width="80%" id="report_comment_table"  data-scrollaxis="x" class="ibm-data-table" cellspacing="0" cellpadding="0" border="0">
    <caption>
        <em>User's comments</em>
    </caption>
   
    <tbody>
        <tr>
           
          
        </tr>
        
    </tbody>
</table>

<div class="container">

	<div id='report_comment1111' class="comment-list">

	
	
		
		
	</div>
</div>

			


	</div>







</div>



	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>