try {

	/*
	 * report model search result list
	 */
	function ReportbeanList(name) {
		this.reportbeanlist = new Array();
		this.cwa_id = cwa_id;
		this.name = name;
	}

	ReportbeanList.prototype.addReport = function(ReportBean) {
		if (this.reportbeanlist == null) {
			this.reportbeanlist = new Array();
		}
		ReportBean.parent = this.name;
		this.reportbeanlist.push(ReportBean);
	}

	ReportbeanList.prototype.getReport = function(id,collection_id) {
		for (var i = 0; i < this.reportbeanlist.length; i++) {
			if (this.reportbeanlist[i].id == id&&this.reportbeanlist[i].collectionId==collection_id) {
				return this.reportbeanlist[i];
			}
		}
		return null;
	}

	ReportbeanList.prototype.empty = function() {
		if (this.reportbeanlist != null) {
			this.reportbeanlist.length = 0;
		}
	}

	ReportbeanList.prototype.toHtmlView = function() {
		var table = '<table id="search_result_table_id" data-widget="datatable" class="ibm-data-table ibm-padding-small" data-ordering="true" data-searching="true" width="100%" border="0" cellspacing="0" cellpadding="0" summary="cognitive search results">';
		table += '<tr><th scope="col" ><span class="ibm-checkbox-wrapper"><input id="checkall_checkbox" type="checkbox" class="ibm-styled-checkbox"/><label for="checkall_checkbox" ><span class="ibm-access">Select all</span></label></span> </th><th></th><th style="vertical-align: top;padding-top: 6px;padding-bottom: 2px;">Report Name</th>';
		table += '<th style="vertical-align:middle;text-align:left;">Report author</th>';
		table += '<th style="vertical-align:middle;text-align:center;">Report owner</th>';
		table += '<th style="vertical-align:middle;text-align:center;">Report backup owner</th><tr>';
		if (this.reportbeanlist && this.reportbeanlist.length > 0) {
			for (var i = 0; i < this.reportbeanlist.length; i++) {
				table += this.reportbeanlist[i].toString();
			}
		}
		table += '</table>';
		return table;
	}

	/*
	 * report model bean
	 */

	function ReportBean(ReportBean,domain) {
		//
		this.parent='';
		this.id=ReportBean.id;
		this.collectionId = ReportBean.collection_id;
		//
		if(domain!=null&&domain!=undefined){
			this.domain = domain
		} else {
			this.domain = null;
		}
		//
		this.rptName = ReportBean.reportName;
		//
		if(ReportBean.reportDescription!=null&&ReportBean.reportDescription!=undefined){
			this.rptDesc = NewLineProcess(ReportBean.reportDescription);
		}else{
			this.rptDesc="";
		}
		//
		this.rptLastModify = ReportBean.reportLastModify;
		//		
		this.contentID = ReportBean.contentID;
		this.searchPath = ReportBean.searchPath;
		this.domainKey = ReportBean.domainKey;
		//
		this.domainName = 'No Cognos Domain';
		if(this.domain!=null){
			this.domainName = this.domain.DISPLAY_NAME;
		}
		//
		this.canTBS = ReportBean.tbsEnabled;
		this.rptID = ReportBean.id;
		this.docPK = ReportBean.documentPk;
		this.status = ReportBean.reportStatus;
		this.triggers = ReportBean.triggers;
		this.rptPack = ReportBean.reportPackage;
		this.backupOwner=ReportBean.backupOwner;
		this.reportOwner=ReportBean.reportOwner;
		this.reportAuthor=ReportBean.reportAuthor;
		//this.tbsURL = ReportBean.tbsUrl;
		if(this.domain!=null){
			if(this.canTBS == 'Y'){
				var url = this.domain.BIPORTAL_URL+'/action/portal/schedulePanel/createCognosSchedulePage?';
				url+='rptAccessID='+this.contentID;
				url+='&domainKey='+this.domainKey;
				url+='&referObjectid='+this.contentID;
				url+='&searchPath='+encodeURIComponent(this.searchPath);
				this.tbsURL = url;
			}else{
				this.tbsURL = '';
			}
		}else{
			this.tbsURL = '';
			
		}
		//this.rptURL = ReportBean.reportUrl;
		if(this.domain!=null){
			var rptUrl = this.domain.GATE_WAY
			+'?b_action=cognosViewer&ui.action=run&run.outputFormat=&run.prompt=true&ui.object='
			+encodeURIComponent(this.searchPath)
			+'&ui.name='+encodeURIComponent(this.rptName);
			this.rptURL = rptUrl;
		} else {
			this.rptURL = '';
		}
		//
		this.rankUrl = '';
		if(this.domain!=null){
			var url = this.domain.BIPORTAL_URL+'/action/portal/rank/getReportRankingPage?search_path=';
			url += encodeURIComponent(this.searchPath);
			this.rankUrl = url;
		} else {
			this.rankUrl = '';
		}
		//		
		this.bookMarkUrl = '';
		//
		if (ReportBean.highlight != null && ReportBean.highlight != "") {
			if (ReportBean.highlight.reportName != null
					&& ReportBean.highlight.reportName != "") {
				this.rptName = ReportBean.highlight.reportName;
			}
			if (ReportBean.highlight.reportDescription != null
					&& ReportBean.highlight.reportDescription != "") {
				this.rptDesc = ReportBean.highlight.reportDescription;
				
			}
		}
	}

	ReportBean.prototype.toString = function() {

		var tr = '<tr id="tr_' + this.rptID + '">';
		tr += '<td  id="td' + this.rptID + '" ><span class="ibm-checkbox-wrapper"><input class="ibm-styled-checkbox" name="chkbox_report" id="chk_'+this.rptID+'" type="checkbox" value="'+this.docPK+'" /> <label for="chk_'+this.rptID+'" class="ibm-field-label"><span class="ibm-access">Select One</span></label></span></td>';
		tr += '<td class=" details-control" id="' + this.rptID + '" ></td>';
		tr += '<td  style="vertical-align: top;padding-top: 2px;padding-bottom: 2px;" >';
		tr += '<a title="' + this.rptName + '('+this.domainName+')" href="#" ';
		tr += ' onclick="'+this.parent+'.getReport(\'' + this.id+'\',\''+this.collectionId+ '\').openReport(); return false;">' + this.rptName + '</a></td>';
		tr += '<td style="vertical-align: top;padding-top: 10px;" >' + this.reportAuthor + '</td>';
		tr += '<td style="vertical-align: top;padding-top: 10px;" >' + this.reportOwner + '</td>';
		tr += '<td style="vertical-align: top;padding-top: 10px;" >' + this.backupOwner + '</td>';
		tr += '</tr>';
		tr += '<tr hidden="hidden" id="desc_' + this.rptID + '"><td colspan="4"><p alt="Report Path and Description">';
		tr += 'Domain: ' + this.domainName + '<br>';
		tr += 'Report Path: ' + this.searchPath + '<br><hr>Report Description: ';	
		tr += this.rptDesc;
		tr += '</p></td></tr>';

		return tr;

	}
	
	ReportBean.prototype.openReport = function(){
		if(this.rptURL==''){
			alert('sorry, this report is invalid to run');
			return;
		}
		style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0";
		var win = window.open(this.rptURL, '_blank', style);
		win.focus();
	}
	
	ReportBean.prototype.scheduleReport = function(){
		if(this.tbsURL==''){
			alert('sorry, this report is invalid to schedule');
			return;
		}
		style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0";
		var win = window.open(this.tbsURL, '_blank', style);
		win.focus();
	}
	
	ReportBean.prototype.rankReport = function(){
		if(this.rankUrl==''){
			alert('sorry, this report is invalid to rank');
			return;
		}
		style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0";
		var win = window.open(this.rankUrl, '_blank', style);
		win.focus();
	}
	
	ReportBean.prototype.bookMarkReport = function(){
		
	}	
	function NewLineProcess(str) {
		var processedStr = str.replace(/\n\n/g, "<br/>");
		return processedStr;
	}

	function OpenInNewWindow(url) {
		style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0";
		var win = window.open(url, '_blank', style);
		win.focus();
	}

} catch (oException) {
	alert(oException);
}