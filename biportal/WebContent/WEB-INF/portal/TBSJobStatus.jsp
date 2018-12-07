<!-- Author Leo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>BI@IBM | TBS execution status</title>

<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<link href="//1.www.s81c.com/common/v18/css/forms.css" rel="stylesheet">
<script src="//1.www.s81c.com/common/v18/js/forms.js"></script>
<script type="text/javascript">
//
var domains = new Array();
var group_status = new Array();
var selectedDomain_key = "";
//
jQuery(function () {
	retrieveAllStatusData();
});

function retrieveAllStatusData() {
	var timeid = (new Date()).valueOf();	
	var i = 0;
	jQuery("#tbs_job_status_loading_status_id").attr('src',"<%=request.getContextPath()%>/images/ajax-loader.gif");
	jQuery("#tbs_job_status_loading_status_id").attr('onClick',"");
	jQuery("#tbs_job_status_domains_id").attr("disabled",true);
	var html_select = '<option value="no_domain_key">loading...</option>';
	jQuery("#tbs_job_status_domains_id").html(html_select);	
	domains.length=0;
	group_status.length=0;
	jQuery.ajax({
				type : "GET",
				url : "<%=request.getContextPath()%>/action/portal/TBSJobStatus/loadTBSJobStatus?timeid=" + timeid ,
				dataType : "json",
				success : function(data) {
					jQuery.each(
							data,
							function(i, jobStatusBean) {
								var domainKey = jobStatusBean.domain_key;
								var domain = getDomain(domainKey);
								if(domain==null){
									domain = {};
									domain["domain_key"]=jobStatusBean.domain_key;
									domain["display_name"]=jobStatusBean.display_name;
									domain["sub_display_name"]=jobStatusBean.sub_display_name;
									domain["status_beans"] = new Array();
									domains.push(domain);
								}
								domain.status_beans.push(jobStatusBean);
								//
								var gs = getGroupStatus(domainKey,jobStatusBean.trigger_cd);
								if(gs==null){
									gs = {};
									gs["domain_key"] = jobStatusBean.domain_key;
									gs["trigger_cd"] = jobStatusBean.trigger_cd;
									gs["status"] = jobStatusBean.status;
									group_status.push(gs);
								}
								if(gs.status.indexOf(jobStatusBean.status)<0){
									gs.status += ","+jobStatusBean.status;
								}
								//
							});
					drawDomainList(selectedDomain_key);
				}
			})
			.fail(function(jqXHR, textStatus, errorThrown){	
				jQuery("#tbs_job_stauts_id").empty();
				jQuery("#tbs_job_status_loading_status_id").attr('src',"<%=request.getContextPath()%>/images/refresh.gif");
				jQuery("#tbs_job_status_loading_status_id").attr('onClick',"retrieveAllStatusData();");
				var html_select = '<option value="no_domain_key">failed</option>';
				jQuery("#tbs_job_status_domains_id").html(html_select);				
				alert("ERROR, please try again later or contact BI@IBM helpdesk.");	
			})
}

function getDomain(domain_key){
	var len = domains.length;
	for(var i=0;i<len;i++){
		if(domains[i].domain_key==domain_key){
			return domains[i];
		}
	}
	return null;
}

function getGroupStatus(domain_key,trigger_cd){
	var len = group_status.length;
	for(var i=0;i<len;i++){
		if(group_status[i].domain_key==domain_key&&group_status[i].trigger_cd==trigger_cd){
			return group_status[i];
		}
	}
	return null;
}

function drawDomainList(selectedDomain_key){
	var str="";
	var len = domains.length;
	var haveSelected = false;
	for(var i=0;i<len;i++){
		if(selectedDomain_key==domains[i].domain_key){
			str +="<option value='"+domains[i].domain_key+"' selected>"+domains[i].display_name+"</option>";
			haveSelected = true;
		}else{
			str +="<option value='"+domains[i].domain_key+"'>"+domains[i].display_name+"</option>";
		}
		
	}
	jQuery("#tbs_job_status_domains_id").html(str);
	drawTable(haveSelected?selectedDomain_key:domains[0].domain_key);
	jQuery("#tbs_job_status_loading_status_id").attr('src',"<%=request.getContextPath()%>/images/refresh.gif");
	jQuery("#tbs_job_status_loading_status_id").attr('onClick',"retrieveAllStatusData();");
	jQuery("#tbs_job_status_domains_id").attr("disabled",false);
}

function drawTable(domain_key){
	var group_trigger_desc = "";

	domain = getDomain(domain_key);
	if(domain==null){
		alert('Error, can not find domain information');
		return;
	}
	selectedDomain_key = domain_key;
	var str ="";
	str+="<br/><strong>Domain:"+domain.display_name+domain.sub_display_name+"</strong>";
	str+="<div class='ibm-rule'><hr></div>"	
	str+="<table id='data_table_id' data-widget='datatable' data-info='true' data-ordering='false' data-paging='true' data-searching='true' class='ibm-data-table ibm-altrows dataTable no-footer row-border'>";
	str+="<thead>";
	str+="<tr>";
	str+="<th scope='col'>Run Date (GMT)</th>";
	str+="<th scope='col'>Trigger</th>";
	str+="<th scope='col'>TBS Run</th>";
	str+="<th scope='col'>Start Time (GMT)</th>";
	str+="<th scope='col'>End Time (GMT)</th>";
	str+="<th scope='col'>Run Duration (HH:MM)</th>";
	str+="<th scope='col'>Success</th>";
	str+="<th scope='col'>Avg Run Time (MM:SS)</th>";
	str+="<th scope='col'>Active</th>";
	str+="<th scope='col'>To Go</th>";
	str+="<th scope='col'>Fail</th>";
	str+="<th scope='col'>Off-peak Included</th>";
	str+="<th scope='col'>Status</th>";
	str+="<th scope='col'>Trigger Desc</th>";
	str+="<th scope='col'>Group Status</th>";
	str+="</tr>";
	str+="</thead>";
	str+="<tbody>";
	var beans = domain.status_beans;
	var len = beans.length;
	for(var i=0;i<len;i++){
		jobStatusBean = beans[i];
		if(jobStatusBean.trigger_desc!=""){
			group_trigger_desc = jobStatusBean.trigger_desc;
		}
		var gs = getGroupStatus(jobStatusBean.domain_key,jobStatusBean.trigger_cd);
		if(gs==null){
			alert("Error, can not find group status");
			return;
		}
		//
		str+="<tr id='job_status_id_"+jobStatusBean.job_running_id+"' style='"+ jobStatusBean.styleBG+"' class='group_id_"+jobStatusBean.domain_key+jobStatusBean.trigger_cd+"'>";
		str+="<td>"+jobStatusBean.runDateStr+"</td>";
		str+="<td>"+jobStatusBean.trigger_desc+"</td>";
		str+="<td>"+jobStatusBean.job_no+"</td>";
		str+="<td>"+jobStatusBean.runTimeStr+"</td>";
		str+="<td>"+jobStatusBean.doneTimeStr+"</td>";
		str+="<td>"+jobStatusBean.durationStr+"</td>";
		str+="<td>"+jobStatusBean.success_count+"</td>";
		str+="<td>"+jobStatusBean.avgRunTimeStr+"</td>";
		str+="<td>"+jobStatusBean.running_count+"</td>";
		str+="<td>"+jobStatusBean.togoStr+"</td>";
		str+="<td>"+jobStatusBean.failed_count+"</td>";
		str+="<td align='center'>"+jobStatusBean.off_peak+"</td>";
		
		var status = jobStatusBean.status;
		if(status=="In Progress"){
			str+="<td id='job_status_id_refresh_link_"+jobStatusBean.job_running_id+"' style='white-space: nowrap'><a style='cursor:pointer;valign:middle' onclick=refreshStatus('" + jobStatusBean.job_running_id + "') ><strong>"+jobStatusBean.status+"</strong></a></td>";
		}else{
			str+="<td style='white-space: nowrap'>"+jobStatusBean.status+"</td>";
		}
		
		str+="<td>"+group_trigger_desc+"</td>";
		str+="<td>"+gs.status+"</td>";
		str+="</tr>";
	}
	if(str!=""){
		str+="</tbody>"
		str+="</table></div>";						
	}
	jQuery("#tbs_job_stauts_id").empty();
	jQuery("#tbs_job_stauts_id").append(str);
	var table_content_tab1 = jQuery("#data_table_id").DataTable(
			{"stateSave": true,
			"lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
			"columnDefs":[
			              {"targets": [ 13 ],"visible": false,"searchable": true},
			              {"targets": [ 14 ],"visible": false,"searchable": true}
			             ]
			});
	table_content_tab1.draw();	
}

function refreshStatus(job_running_id){
	var timeid = (new Date()).valueOf();
	
	showLoading(job_running_id);  
	jQuery
			.ajax({
				type : "GET",
				url : "<%=request.getContextPath()%>/action/portal/TBSJobStatus/refreshSingleTBSJobStatus/"+job_running_id+"?timeid=" + timeid ,
				dataType : "json",
				success : function(data) {
					updateDataInPage(data);
					hideLoading(job_running_id); 
					jQuery("#job_status_id_"+job_running_id).attr("style",data.styleBG);
					jQuery("#job_status_id_"+job_running_id  +" td:nth-child(4)").text(data.runTimeStr);
					jQuery("#job_status_id_"+job_running_id  +" td:nth-child(5)").text(data.doneTimeStr);
					jQuery("#job_status_id_"+job_running_id  +" td:nth-child(6)").text(data.durationStr);
					jQuery("#job_status_id_"+job_running_id  +" td:nth-child(7)").text(data.success_count);
					jQuery("#job_status_id_"+job_running_id  +" td:nth-child(8)").text(data.avgRunTimeStr);
					jQuery("#job_status_id_"+job_running_id  +" td:nth-child(9)").text(data.running_count);
					jQuery("#job_status_id_"+job_running_id  +" td:nth-child(10)").text(data.togoStr);
					jQuery("#job_status_id_"+job_running_id  +" td:nth-child(11)").text(data.failed_count);
					jQuery("#job_status_id_"+job_running_id  +" td:nth-child(12)").text(data.off_peak);
					if(data.status=="In Progress"){
						jQuery("#job_status_id_"+job_running_id  +" td:nth-child(13)").html("<a style='cursor:pointer;valign:middle' onclick=refreshStatus('" + data.job_running_id + "') ><strong>"+data.status+"</strong></a>");								
					}else{
						jQuery("#job_status_id_"+job_running_id  +" td:nth-child(13)").text(data.status);						
					}
					var gs = getGroupStatus(data.domain_key,data.trigger_cd);
					jQuery("#job_status_id_"+job_running_id  +" td:nth-child(14)").text(gs.status);
				}
			})
			.fail(function(jqXHR, textStatus, errorThrown){	
				hideLoading(job_running_id); 
				alert("ERROR, please try again later or contact BI@IBM helpdesk.");	
			})		
}

function updateDataInPage(jobStatusBean){
	var domain_key = jobStatusBean.domain_key;
	var domain = getDomain(domain_key);
	if(domain==null){
		alert('Error, can not find domain information');
		return;
	}
	var gs = getGroupStatus(domain_key,jobStatusBean.trigger_cd);
	if(gs==null){
		alert('Error, can not find group status information');
		return;
	}
	//
	var len = domain.status_beans.length;
	var str_group_status='';
	for(var i=0;i<len;i++){
		if(domain.status_beans[i].job_running_id==jobStatusBean.job_running_id){
			domain.status_beans[i].runTimeStr = jobStatusBean.runTimeStr;
			domain.status_beans[i].doneTimeStr = jobStatusBean.doneTimeStr;
			domain.status_beans[i].durationStr = jobStatusBean.durationStr;
			domain.status_beans[i].success_count = jobStatusBean.success_count;
			domain.status_beans[i].avgRunTimeStr = jobStatusBean.avgRunTimeStr;
			domain.status_beans[i].running_count = jobStatusBean.running_count;
			domain.status_beans[i].togoStr = jobStatusBean.togoStr;
			domain.status_beans[i].failed_count = jobStatusBean.failed_count;
			domain.status_beans[i].off_peak = jobStatusBean.off_peak;
			domain.status_beans[i].styleBG = jobStatusBean.styleBG;
			domain.status_beans[i].status = jobStatusBean.status;
		}
		if(domain.status_beans[i].domain_key==jobStatusBean.domain_key&&domain.status_beans[i].trigger_cd==jobStatusBean.trigger_cd){
			if(str_group_status.indexOf(domain.status_beans[i].status)<0){
				str_group_status += (str_group_status==''?'':',') + domain.status_beans[i].status;
			}
		}
	}
	gs.status = str_group_status;
}

function showLoading(job_running_id) {
	jQuery("#job_status_id_refresh_link_"+job_running_id).html('<strong>loading...</strong>');
}

function hideLoading(job_running_id) {
	jQuery("#job_status_id_refresh_link_"+job_running_id).html("<a style='cursor:pointer;valign:middle' onclick=refreshStatus('" + job_running_id + "') ><strong>In Progress</strong></a>");
}

</script>
</head>
<body id="ibm-com" class="ibm-type" >
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
	<div style="width: 96%; margin: auto;">
		<div style="margin: 5px; display: table;">
			<h1 id="ibm-pagetitle-h1" style="padding-left: 10px; float: left;"
				class="ibm-h1 ibm-light">TBS execution status</h1>
			<div style="padding-left: 10px; float: left;">
				<p class="ibm-ind-link ibm-icononly ibm-inlinelink">
					<a class="ibm-information-link" target="_blank"
						href="<%=request.getContextPath()%>/action/portal/pagehelp?pageKey=TBSJobStatus&pageName=TBS+job+status"
						title="Help for TBS execution status"> Help for TBS execution
						status </a>
				</p>
			</div>
		</div>

		<div class="ibm-fluid" style="padding: 0px;">

				<strong>TBS execution status as of ${curTime}</strong><br />

				<div class="ibm-rule">
					<hr>
				</div>
				<div id="tbs_job_status_domain_panel"> 
					<form class="ibm-row-form" method="post" action="">
						<label for="tbs_job_status_domains_id">Domain:</label>
						<select id="tbs_job_status_domains_id" style="width:170px;" name="domain_key" onChange="drawTable(this.value);">
								<option value="no_domain_key">loading...</option>
						</select>						
						&nbsp;&nbsp;&nbsp;&nbsp;<img id="tbs_job_status_loading_status_id" style="vertical-align:middle;" src='<%=request.getContextPath()%>/images/ajax-loader.gif' onClick="" />
					</form>
				</div>
				<div id='tbs_job_stauts_id'>

				</div>
				
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>