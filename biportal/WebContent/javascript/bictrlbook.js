try {

	/*
	 * BIctrlbooks
	 */
	function BIctrlbooks(name) {
		this.ctrlbooks = new Array();
		if(name){
			this.name=name;
		}
	}

	BIctrlbooks.prototype.addCtrlbook = function(ctrlbook) {
		if (this.ctrlbooks == null) {
			this.ctrlbooks = new Array();
		}
		if(this.name){
			ctrlbook.parent=this.name;
		}
		this.ctrlbooks.push(ctrlbook);
	}
	
	BIctrlbooks.prototype.refreshCtrlbook = function(ctrlbook) {
		if(this.name){
			ctrlbook.parent=this.name;
		}
		var ff = false;
		for(i=0;i<this.ctrlbooks.length;i++){
			if(this.ctrlbooks[i].id==ctrlbook.id){
				this.ctrlbooks[i] = ctrlbook;
				ff=true;
			}
		}
		if(!ff){
			this.addCtrlbook(ctrlbook);
		}
	}
	
	BIctrlbooks.prototype.removeCtrlBook = function(cbid){
		for(i=0;i<this.ctrlbooks.length;i++){
			if(this.ctrlbooks[i].id==cbid){
				this.ctrlbooks.splice(i, 1);
			}
		}
	}
	
	BIctrlbooks.prototype.getCtrlbookById = function(cbId){
		if(this.ctrlbooks == null){
			return null;
		}
		
		for(var i=0;i<this.ctrlbooks.length;i++){
			if(this.ctrlbooks[i].id==cbId){
				return this.ctrlbooks[i];
			}
		}
		return null;
	}

	BIctrlbooks.prototype.toString = function() {
		if (this.ctrlbooks == null || this.ctrlbooks.length == 0) {
			return "";
		}
		var tables = "";
		tables += '<TABLE class="ibm-data-table ibm-padding-small ibm-altrows" width="1024" border="0">';
		tables += '<TBODY><thead><TR>';
		tables += '<TH scope="col" style="width: 36px"></TH>';
		tables += '<TH scope="col" style="width: 308px">Name</TH>';
		tables += '<TH scope="col" style="width: 80px">Geo</strong></TH>';
		tables += '<TH scope="col" style="width: 80px">Business</strong></TH>';
		tables += '<TH scope="col" style="width: 401px">Description</strong></TH>';
		tables += '<TH scope="col" style="width: 55px"></TH>';
		tables += '</TR></thead>';

		for (var int = 0; int < this.ctrlbooks.length; int++) {
			tables += this.ctrlbooks[int].toString();
		}
		tables += '</TBODY></TABLE>';
		return tables;
	}
	
	BIctrlbooks.prototype.createMyMangedCBPanel = function() {
		if (this.ctrlbooks == null || this.ctrlbooks.length == 0) {
			return "";
		}
		var tables = "";
		tables += '<TABLE class="ibm-data-table ibm-padding-small ibm-altrows" width="100%" border="0" id="id_myManagedCBDataTable">';
		tables += '<TBODY><thead><TR>';
		tables += '<TH scope="col">&nbsp;&nbsp;&nbsp;</TH>';
		tables += '<TH scope="col">Name</TH>';
		tables += '<TH scope="col">Geo</strong></TH>';
		tables += '<TH scope="col">Business</strong></TH>';
		tables += '<TH scope="col">Description</strong></TH>';
		//
		tables += '<TH scope="col">Type</strong></TH>';
		tables += '<TH scope="col">Status</strong></TH>';
		tables += '<TH scope="col">Expiration Date</strong></TH>';
		//
		tables += '<TH scope="col">Target Audience</strong></TH>';
		tables += '<TH scope="col">Supports</strong></TH>';
		tables += '<TH scope="col">Has Dashboard</strong></TH>';
		tables += '<TH scope="col"></TH>';
		tables += '</TR></thead>';

		for (var int = 0; int < this.ctrlbooks.length; int++) {
			tables += this.ctrlbooks[int].toMyManagedCBPanel();
		}
		tables += '</TBODY></TABLE>';
		return tables;
	}
	
	

	/*
	 * BIctrlbook
	 */
	
	function BIctrlbook(ctrlbookDetail, selectedType) {
		this.parent=null;
		this.id = ctrlbookDetail.ctrlbook_id;
		this.name = ctrlbookDetail.ctrlbook_name;
		this.desc = ctrlbookDetail.ctrlbook_desc;
		this.help = ctrlbookDetail.ctrlbook_help;
		this.geo = ctrlbookDetail.ctrlbook_filter_type_name;
		this.business = ctrlbookDetail.ctrlbook_filter_name;
		this.removable = ctrlbookDetail.removable;
		this.selectedType = selectedType;
		//
		if(ctrlbookDetail.hasdashboard){
			this.hasdashboard = ctrlbookDetail.hasdashboard;
		}else{
			this.hasdashboard = "N";
		}

		if(ctrlbookDetail.support_contact){
			this.support_contact = ctrlbookDetail.support_contact;
		}else{
			this.support_contact = "";
		}	
		
		if(ctrlbookDetail.ctrlbook_filter_type_id){
			this.ctrlbook_filter_type_id = ctrlbookDetail.ctrlbook_filter_type_id;
		}else{
			this.ctrlbook_filter_type_id = "none";
		}	
		if(ctrlbookDetail.ctrlbook_filter_id){
			this.ctrlbook_filter_id = ctrlbookDetail.ctrlbook_filter_id;
		}else{
			this.ctrlbook_filter_id = "none";
		}	
		if(ctrlbookDetail.ctrlbook_backup){
			this.ctrlbook_backup = ctrlbookDetail.ctrlbook_backup;
		}else{
			this.ctrlbook_backup = "";
		}	
		if(ctrlbookDetail.ctrlbook_owner){
			this.ctrlbook_owner = ctrlbookDetail.ctrlbook_owner;
		}else{
			this.ctrlbook_owner = "";
		}	
		if(ctrlbookDetail.target_aud){
			this.target_aud = ctrlbookDetail.target_aud;
		}else{
			this.target_aud = "";
		}	
		if(ctrlbookDetail.purpose){
			this.purpose = ctrlbookDetail.purpose;
		}else{
			this.purpose = "";
		}	
		if(ctrlbookDetail.request_access){
			this.request_access = ctrlbookDetail.request_access;
		}else{
			this.request_access = "";
		}
		if(ctrlbookDetail.isupdate){
			this.isupdate = ctrlbookDetail.isupdate;
		}else{
			this.isupdate = "N";
		}
		if(ctrlbookDetail.xls_rpt_def_id){
			this.xls_rpt_def_id = ctrlbookDetail.xls_rpt_def_id;
		}else{
			this.xls_rpt_def_id = "none";
		}
		//
		if(ctrlbookDetail.ctrlbook_type){
			this.ctrlbook_type = ctrlbookDetail.ctrlbook_type;
		}else{
			this.ctrlbook_type = "public";
		}
		if(ctrlbookDetail.ctrlbook_status){
			this.ctrlbook_status = ctrlbookDetail.ctrlbook_status;
		}else{
			this.ctrlbook_status = "A";
		}
		if(ctrlbookDetail.ctrlbook_expiry){
			this.ctrlbook_expiry = new Date(ctrlbookDetail.ctrlbook_expiry).getTime();
		}else{
			var now = new Date();
			this.ctrlbook_expiry = now.setFullYear(now.getFullYear() + 1,now.getMonth(),now.getDate());
		}
		if(ctrlbookDetail.create_time){
			this.create_time = new Date(ctrlbookDetail.create_time).getTime();
		}else{
			var now = new Date();
			this.create_time = now.setFullYear(now.getFullYear() + 1,now.getMonth(),now.getDate());
		}
	}

	BIctrlbook.prototype.toString = function() {
		var str = "";
		str = '<TR>';
		if (this.removable == "N") {
			str += '<TD><INPUT type="checkbox" data-init="false" class="ibm-styled-checkbox" id="' + this.id + '" name="name_' + this.selectedType + '" disabled="disabled"><label id="' + this.id + '" style="padding-left: 0px; padding-right: 0px;" for="iiiddd" disabled="disabled"></label></TD>'
		} else {
			str += '<TD><INPUT type="checkbox" data-init="false" class="ibm-styled-checkbox" id="' + this.id + '" name="name_' + this.selectedType + '" onchange="checkboxChange(\'' + this.selectedType + '\');"  ><label id="' + this.id + '" style="padding-left: 0px; padding-right: 0px;" for="' + this.id + '"></label></TD>'
		}
		str += '<TD>' + this.name + '</TD>'
		str += '<TD>' + this.geo + '</TD>'
		str += '<TD>' + this.business + '</TD>'
		str += '<TD>' + this.desc + '</TD>'
		str += '<TD><p class="ibm-ind-link"><a class="ibm-information-link" style="cursor: pointer"';
		str += 'onclick="openCBHelp(\'' + this.help + '\')" >';
		str += '<span style="display: none;">help icon</span><br/>';
		str += '</a></p></TD>'
		str += '</TR>'
	
		return str;
	}
	
	BIctrlbook.prototype.toMyManagedCBPanel = function(){
		var str = "";
		str = '<TR>';
		str += '<TD style="align:center;"><INPUT type="checkbox" data-init="false" class="ibm-styled-checkbox" id="' + this.id + '" name="name_' + this.selectedType + '" ><label id="' + this.id + '" style="padding-left: 0px; padding-right: 0px;" for="' + this.id + '"></label></TD>'
		str += '<TD><a herf="#" target="_blank" onclick="openEditCtrlbookPanel('+this.parent+'.getCtrlbookById('+this.id+'),\'edit\');" style="cursor: pointer">' + this.name + '</a></TD>'
		str += '<TD>' + this.geo + '</TD>'
		str += '<TD>' + this.business + '</TD>'
		str += '<TD>' + this.desc + '</TD>'
		//
		str += '<TD>' + this.ctrlbook_type + '</TD>'
		if(this.ctrlbook_status=='A'){
			str += '<TD>Active</TD>'	
		}else if(this.ctrlbook_status=='I'){
			str += '<TD>Inactive</TD>'	
		}else if(this.ctrlbook_status=='D'){
			str += '<TD>Disabled</TD>'	
		}else{
			str += '<TD>Unknown</TD>'	
		}
		str += '<TD>' + new Date(this.ctrlbook_expiry).toUTCString() + '</TD>'
		//
		str += '<TD>' + this.target_aud + '</TD>'
		str += '<TD>' + this.support_contact + '</TD>'
		str += '<TD>' + this.hasdashboard + '</TD>'
		
		str += '<TD><p class="ibm-ind-link"><a class="ibm-information-link" style="cursor: pointer"';
		str += 'onclick="openCBHelp(\'' + this.help + '\')" >';
		str += '<span style="display: none;">help icon</span><br/>';
		str += '</a></p></TD>'
		str += '</TR>'
	
		return str;		
	}
 
	function checkboxChange(selectedType){

        var cbIds = "";
		var selectedCBids = jQuery("[name='name_" + selectedType + "'][disabled!='disabled']").children().prevObject;

		for (var int = 0; int < selectedCBids.length; int++) {
			if (selectedCBids[int].checked) {
				cbIds += jQuery(selectedCBids[int]).attr("id") + ",";
			}
		}	

		if (selectedType=="cb_selected") {
			cbIds_selected = cbIds;
		}else if (selectedType=="cb_un_selected") {
			cbIds_un_selected = cbIds;
		}

	}
	
	function openCBHelp(url) {
		window.open(url,"RptInfo","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=580,height=450,screenX=10,screenY=10");
	}

	/*
	 * Geography
	 */
 
	function BIgeos(){
		this.biGeos = new Array();
	}
	BIgeos.prototype.addGeo = function(biGeo){
		if (this.biGeos == null) {
			this.biGeos = new Array();
		}
		this.biGeos.push(biGeo);
	}
	BIgeos.prototype.toString = function(selectedGeo){
		var tables = "";
		if(selectedGeo){
			if(selectedGeo==''||selectedGeo=='none'){
				tables += '<OPTION value="none" selected="selected">Please select one</OPTION>';	
			}else{
				tables += '<OPTION value="none">Please select one</OPTION>';
			}
			for (var int = 0; int < this.biGeos.length; int++) {
				tables += this.biGeos[int].toString(selectedGeo);
			}
		}else{
			tables += '<option value="all" selected="selected">All</option>'
			for (var int = 0; int < this.biGeos.length; int++) {
				tables += this.biGeos[int].toString(selectedGeo);
			}
		}
		return tables;
	}

	function BIgeo(ctrlfltp){
		this.id = ctrlfltp.ctrlbookFilterTypeId;
		this.desc = ctrlfltp.ctrlbookFilterTypeDesc;
		this.name = ctrlfltp.ctrlbookFilterTypeName;
		this.seq = ctrlfltp.ctrlbookFilterTypeSeq;
	}
 
	BIgeo.prototype.toString = function(selectedGeo){
		if(selectedGeo){
			if(this.id==selectedGeo){
				return '<option value='+this.id+' selected >'+ this.name +'</option>';
			}
		}
		var str = '<option value='+this.id+'>'+ this.name +'</option>'
		return str;
	}

	/*
	 * Business
	 */

	function BIbusinesses(){
		this.biBusinesses = new Array();
	}
	BIbusinesses.prototype.addBusiness = function(biBusiness){
		if (this.biBusinesses == null) {
			this.biBusinesses = new Array();
		}
		this.biBusinesses.push(biBusiness);
	}
	BIbusinesses.prototype.toString = function(selectedBus){
		var tables = "";
		if(selectedBus){
			if(selectedBus==''||selectedBus=='none'){
				tables += '<OPTION value="none" selected="selected">Please select one</OPTION>';	
			}else{
				tables += '<OPTION value="none">Please select one</OPTION>';
			}
			for (var int = 0; int < this.biBusinesses.length; int++) {
				tables += this.biBusinesses[int].toString(selectedBus);
			}
		}else{
			tables += '<OPTION value="all" selected="selected">All</OPTION>'
				for (var int = 0; int < this.biBusinesses.length; int++) {
					tables += this.biBusinesses[int].toString();
			}
		}

		return tables;		
	}

	function BIbusiness(ctrlfltp){
		this.id = ctrlfltp.ctrlbookFilterId;
		this.desc = ctrlfltp.ctrlbookFilterDesc;
		this.name = ctrlfltp.ctrlbookFilterName;
		this.seq = ctrlfltp.ctrlbookFilterSeq;
	}
 
	
	BIbusiness.prototype.toString = function(selectedBus){
		if(selectedBus){
			if(this.id==selectedBus){
				return '<OPTION value='+this.id+' selected >'+ this.name +'</OPTION>';
			}
		}
		var str = '<OPTION value='+this.id+'>'+ this.name +'</OPTION>'
		return str;
	}
	/*
	 * DashboardTemplate
	 */
	function DashboardTemplate(cbBlobconf){
		this.rptAccessId = cbBlobconf.rptAccessId;
		this.reportName = cbBlobconf.reportName;
		this.reportDesc = cbBlobconf.reportDesc;
	}
	
	DashboardTemplate.prototype.toString = function(selectedTemp){
		if(selectedTemp){
			if(this.rptAccessId==selectedTemp){
				return '<OPTION value='+this.rptAccessId+' selected >'+ this.reportName +'</OPTION>';
			}
		}
		var str = '<OPTION value='+this.rptAccessId+'>'+ this.reportName +'</OPTION>'
		return str;
	}
	//
	function DashboardTemplates(){
		this.dashboardTemplates = new Array();
	}
	DashboardTemplates.prototype.addTemplate = function(dashboardTemplate){
		if (this.dashboardTemplates == null) {
			this.dashboardTemplates = new Array();
		}
		this.dashboardTemplates.push(dashboardTemplate);
	}
	DashboardTemplates.prototype.toString = function(selectedTemplate){
		var tables = "";
		if(selectedTemplate){
			if(selectedTemplate==''||selectedTemplate=='none'){
				tables += '<OPTION value="none" selected="selected">Please select one</OPTION>';	
			}else{
				tables += '<OPTION value="none">Please select one</OPTION>';
			}			
			for (var int = 0; int < this.dashboardTemplates.length; int++) {
				tables += this.dashboardTemplates[int].toString(selectedTemplate);
			}
		}else{
			tables += '<OPTION value="all" selected="selected">All</OPTION>'
				for (var int = 0; int < this.dashboardTemplates.length; int++) {
					tables += this.dashboardTemplates[int].toString();
			}
		}

		return tables;		
	}
	/*
	 * report Domain
	 * 
	 */
	function ReportDomain(domain){
		this.domainKey='';
		this.allreportsUrl='';
		this.cognosCd='';
		this.displayName='';
		this.displaySequence='';
		this.isdefault='';
		this.serviceEndpoint='';
		this.subDisplayName='';
		this.visible='';
		this.checkRest='';
		this.searchRest='';
		this.report_types='';
		if(domain.domainKey){
			this.domainKey=domain.domainKey;
		}
		if(domain.allreportsUrl){
			this.allreportsUrl=domain.allreportsUrl;
		}
		if(domain.cognosCd){
			this.cognosCd=domain.cognosCd;
		}
		if(domain.displayName){
			this.displayName=domain.displayName;
		}
		if(domain.displaySequence){
			this.displaySequence=domain.displaySequence;
		}
		if(domain.isdefault){
			this.isdefault=domain.isdefault;
		}
		if(domain.serviceEndpoint){
			this.serviceEndpoint=domain.serviceEndpoint;
		}
		if(domain.subDisplayName){
			this.subDisplayName=domain.subDisplayName;
		}
		if(domain.visible){
			this.visible=domain.visible;
		}
		if(domain.checkRest){
			this.checkRest=domain.checkRest;
		}
		if(domain.searchRest){
			this.searchRest=domain.searchRest;
		}
		if(domain.report_types){
			this.report_types=domain.report_types;
		}
	}
	ReportDomain.prototype.toString =function(selected){
		if(selected){
			if(this.domainKey==selected){
				return '<OPTION value="'+this.domainKey+','+this.report_types+'" selected >'+ this.displayName +'</OPTION>';
			}
		}
		var str = '<OPTION value="'+this.domainKey+','+this.report_types+'">'+ this.displayName +'</OPTION>'
		return str;
	}
	//
	//ReportDomains
	function ReportDomains(){
		this.reportDomains = new Array();
	}
	ReportDomains.prototype.addDomain = function(domain){
		if (this.reportDomains == null) {
			this.reportDomains = new Array();
		}
		this.reportDomains.push(domain);
	}
	ReportDomains.prototype.toString = function(selected){
		var options = "";
		if(selected){
			if(selected==''||selected=='none'){
				options += '<OPTION value="none" selected="selected">Please select one</OPTION>';	
			}else{
				options += '<OPTION value="none">Please select one</OPTION>';
			}			
			for (var int = 0; int < this.reportDomains.length; int++) {
				options += this.reportDomains[int].toString(selected);
			}
		}else{
			options += '<OPTION value="all" selected="selected">All</OPTION>'
				for (var int = 0; int < this.reportDomains.length; int++) {
					options += this.reportDomains[int].toString();
			}
		}

		return options;		
	}
	/*
	 * BI Report
	 * 
	 */
	function BISearchReport(report){
		this.parent='';
		this.rptName=report.rptName;
		this.rptDesc=report.rptDesc;
		this.rptDate=report.rptDate;
		this.rptPath=report.rptPath;
		this.rptObjID=report.rptObjID;
		this.helpDoc=report.helpDoc;
		this.favorite=report.favorite;
		this.subscribe=report.subscribe;
		this.reportType=report.reportType;
		this.reportTypeCD=report.reportTypeCD;
		this.rptUrl=report.rptUrl;
		this.uid=report.uid;
		this.cwaid=report.cwaid;
		this.showOrder=report.showOrder;
		this.parentID=report.parentID;
		this.objectClass=report.objectClass;
		this.refer_Objectid=report.refer_Objectid;
		this.refer_ObjectClass=report.refer_ObjectClass;
		this.searchPath=report.searchPath;
		this.domain_Key=report.domain_Key;
		this.domain_name=report.domain_name;
		this.viewOutput=report.viewOutput;
		this.outputFmt=report.outputFmt;
		this.lastAccess=report.lastAccess;
		this.parent_folder_id=report.parent_folder_id;
		this.userCapabilites=report.userCapabilites;
		this.combobutton=report.combobutton;
		this.accessible=report.accessible;
		this.ctrlbookId=report.ctrlbookId;
		this.ctrlbookName=report.ctrlbookName;
		this.userRptName=report.userRptName;
		this.displayText=report.displayText;
		this.displayName=report.displayName;
	}
	BISearchReport.prototype.toString = function(){
		var tr='<tr>';
		tr +='<td title="'+this.objectClass+'<->'+decodeURIComponent(this.rptPath).replace(/\+/g,' ')+'" >'+this.rptName+'</td>';
		tr +='<td style="vertical-align:middle;text-align:center;"><p class="ibm-icononly">';
		tr +='<a href="#" class="ibm-add-link" style="margin-bottom:0px;margin-left:0px;margin-right:0px;margin-top:0px;height:22px;" title="add this report" onclick="addCBReport('+this.parent+'.getReport(\''+this.domain_Key+'\',\''+this.rptObjID+'\')'+');return false;" style="cursor:hand;">add</a>';
		tr +='</p></td></tr>';
		return tr;	
	}
	//
	//SearchResult
	function SearchResult(name,domain_key,page,page_row,nextPage,cwa_id,uid,keywords,search_report_types){
		this.reports = new Array();
		this.name = name;
		this.domain_key = domain_key;
		this.page=page;
		this.page_row=page_row;
		this.nextPage=nextPage;
		this.cwa_id=cwa_id;
		this.uid=uid;
		this.keywords=keywords;
		this.search_report_types=search_report_types;
	}
	
	SearchResult.prototype.addReport = function(report){
		if (this.reports == null) {
			this.reports = new Array();
		}
		report.parent = this.name;
		this.reports.push(report);
	}
	
	SearchResult.prototype.getReport = function(domain_key,rpt_id){
		for(var i=0;i<this.reports.length;i++){
			if(this.reports[i].domain_Key==domain_key&&this.reports[i].rptObjID==rpt_id){
				return this.reports[i];
			}
		}
		return null;
	}
	
	SearchResult.prototype.toHtmlView = function(){
		var table='<table border="1" class="ibm-data-table ibm-padding-small ibm-altrows" style="width:100%;">';
		table +='<tr><th style="width:100%;vertical-align:middle;text-align:center;">Report Name</th><th style="vertical-align:middle;text-align:center;">Action</th><tr>'
		if(this.reports&&this.reports.length>0){
			for(var i=0;i<this.reports.length;i++){
				table +=this.reports[i].toString();
			}
		}
		table +='</table>';		
		return table;	
	}
	/*
	 * Controlbook report
	 * 
	 */
	function CBReport(cbReport){
		this.parent='';
		this.id = {};
		if(cbReport){
			this.status='saved';//saved,new,changed,deleted
			this.id.rptTypeCd=cbReport.id.rptTypeCd;
			this.id.rptAccessId=cbReport.id.rptAccessId;
			this.id.ctrlbookId=cbReport.id.ctrlbookId;
			this.cognosRptType=cbReport.cognosRptType;
			this.displayText=cbReport.displayText;
			this.domainKey=cbReport.domainKey;
			this.helpFileName=cbReport.helpFileName;
			this.mailTime=cbReport.mailTime;
			this.orderNo=0;
			this.parentFolderId=cbReport.parentFolderId;
			this.referObjectclass=cbReport.referObjectclass;
			this.referObjectid=cbReport.referObjectid;
			this.rptDesc=cbReport.rptDesc;
			this.rptName=cbReport.rptName;
			this.searchPath=cbReport.searchPath;
		}else{
			this.status='new';//saved,new,changed,deleted
			this.id.rptTypeCd='';
			this.id.rptAccessId='';
			this.id.ctrlbookId=0;
			this.cognosRptType='';
			this.displayText='';
			this.domainKey='';
			this.helpFileName='';
			this.mailTime=null;
			this.orderNo=0;
			this.parentFolderId='';
			this.referObjectclass='';
			this.referObjectid='';
			this.rptDesc='';
			this.rptName='';
			this.searchPath='';
		}
	}
	
	CBReport.prototype.toHtml = function(){
		if(this.status=='deleted'){
			return '';
		}
		// style="margin-bottom:1px;margin-left:1px;padding-right:1px;padding-top:1px;width:60px;height:24px;"
		//
		var tr='<tr>';
		tr +='<td style="vertical-align:middle;text-align:center;height:25px;">'+this.orderNo+'</td>';
		tr +='<td style="vertical-align:middle;height:25px;" title="'+this.cognosRptType+'<->'+this.searchPath+'">'+this.rptName+'</td>';
		tr +='<td style="vertical-align:middle;text-align:center;height:25px;">'+this.domainKey+'</td>';
		tr +='<td style="vertical-align:middle;text-align:center;height:25px;width:70px;"><p class="ibm-icononly" style="margin-bottom:0px;margin-left:0px;margin-right:0px;margin-top:0px;height:22px;width:65px;">';
		tr +='<a href="#" class="ibm-delete-link" style="margin-bottom:0px;margin-left:0px;margin-right:0px;margin-top:0px;height:22px;width:33%;" title="remove this report" onclick="'+this.parent+'.remove('+this.orderNo+');"></a>';
		if(this.orderNo>1){
			tr +='<a href="#" class="ibm-anchor-up-link" style="margin-bottom:0px;margin-left:0px;margin-right:0px;margin-top:0px;height:22px;width:33%;" title="move up" onclick="'+this.parent+'.moveup('+this.orderNo+');"></a>';
		}
		if(this.orderNo<eval(this.parent+'.getNextOrderNo()') - 1){
			tr +='<a href="#" class="ibm-anchor-down-link" style="margin-bottom:0px;margin-left:0px;margin-right:0px;margin-top:0px;height:22px;width:34%;" title="move down" onclick="'+this.parent+'.movedown('+this.orderNo+');"></a>';
		}		
		tr +='</p></td>';
		tr +='</tr>';
		return tr;
	}
	
	function CBReports(name){
		this.cbReports = new Array();
		this.name=name;
	}
	
	CBReports.prototype.addReport = function(cbreport){
		if(this.cbReports==null){
			this.cbReports = new Array();
		}
		cbreport.parent=this.name;
		cbreport.orderNo=this.getNextOrderNo();
		this.cbReports.push(cbreport);
	}
	
	CBReports.prototype.getReport = function(cbid,rpt_id,rpt_type){
		for(var i=0;i<this.cbReports.length;i++){
			if(this.cbReports[i].id.ctrlbookId==cbid&&this.id.cbReports[i].rptAccessId==rpt_id&&this.cbReports[i].id.rptTypeCd==rpt_type){
				return this.cbReports[i];
			}
		}
		return null;
	}
	
	CBReports.prototype.empty = function(){
		this.cbReports.splice(0,this.cbReports.length);
	}
	
	CBReports.prototype.getNextOrderNo = function(){
		var orderNo=0;
		for(var i=0;i<this.cbReports.length;i++){
			if(this.cbReports[i].status!='deleted'){
				orderNo++;
			}
		}
		return orderNo+1;
	}
	
	CBReports.prototype.updateReport = function(cbreport){
		for(var i=0;i<this.cbReports.length;i++){
			if(this.cbReports[i].id.rptTypeCd==cbreport.id.rptTypeCd&&this.cbReports[i].id.rptAccessId==cbreport.id.rptAccessId&&this.cbReports[i].id.ctrlbookId==cbreport.id.ctrlbookId){
				//cbreport.orderNo = this.getNextOrderNo();
				this.cbReports[i]=cbreport;
				return true;
			}
		}
		return false;
	}
	
	CBReports.prototype.remove = function(order){
		for(var i=0;i<this.cbReports.length;i++){
			if(this.cbReports[i].orderNo==order){
				if(this.cbReports[i].status=='saved'||this.cbReports[i].status=='changed'){
					this.cbReports[i].status='deleted';
					this.cbReports[i].orderNo=-1;
				}
				
				if(this.cbReports[i].status=='new'){
					this.cbReports.splice(i,1);
				}
			}
		}
		this.resetOrder();
		this.sort();
        jQuery('#id_CBReports_panel').empty();
        jQuery('#id_CBReports_panel').append(this.toHtmlView());
	}
	
	CBReports.prototype.moveup = function(order){
		for(var i=0;i<this.cbReports.length;i++){
			if(this.cbReports[i].orderNo==order - 1){
				this.cbReports[i].orderNo=order;
				if(this.cbReports[i].status=='saved'){
					this.cbReports[i].status='changed';	
				}
				continue;
			}
			if(this.cbReports[i].orderNo==order){
				this.cbReports[i].orderNo=order - 1;
				if(this.cbReports[i].status=='saved'){
					this.cbReports[i].status='changed';	
				}
				continue;
			}
		}
		this.sort();
        jQuery('#id_CBReports_panel').empty();
        jQuery('#id_CBReports_panel').append(this.toHtmlView());
	}
	
	CBReports.prototype.movedown = function(order){
		for(var i=0;i<this.cbReports.length;i++){
			if(this.cbReports[i].orderNo==order){
				this.cbReports[i].orderNo=order + 1;
				if(this.cbReports[i].status=='saved'){
					this.cbReports[i].status='changed';	
				}
				continue;
			}
			if(this.cbReports[i].orderNo==order + 1){
				this.cbReports[i].orderNo=order;
				if(this.cbReports[i].status=='saved'){
					this.cbReports[i].status='changed';	
				}
				continue;
			}
		}
		this.sort();
        jQuery('#id_CBReports_panel').empty();
        jQuery('#id_CBReports_panel').append(this.toHtmlView());
	}
	
	CBReports.prototype.resetOrder = function(){
		var order = 0;
		for(var i=0;i<this.cbReports.length;i++){
			if(this.cbReports[i].status!='deleted'){
				order++;
				if(this.cbReports[i].orderNo!=order){
					this.cbReports[i].orderNo=order;
					if(this.cbReports[i].status=='saved'){
						this.cbReports[i].status='changed';
					}
				}
			}
		}
	}
	
	CBReports.prototype.sort = function(){
		this.cbReports.sort(sortCB);
	}
	
	CBReports.prototype.addNewReport = function(cbreport){
		if(this.cbReports==null){
			this.cbReports = new Array();
		}
		cbreport.status='new';
		cbreport.parent=this.name;
		this.cbReports.push(cbreport);
	}
	
	CBReports.prototype.getReport = function(cbid,rptType,rptID){
		for(var i=0;i<this.cbReports.length;i++){
			if(this.cbReports[i].id.rptTypeCd==rptType&&this.cbReports[i].id.rptAccessId==rptID&&this.cbReports[i].id.ctrlbookId==cbid){
				return this.cbReports[i];
			}
		}
		return null;
	}
	
	CBReports.prototype.toHtmlView = function(){
		var table='<table id="id_CBReports_table" border="1" class="ibm-data-table ibm-padding-small ibm-altrows" style="width:100%;">';
		table +='<tr><th style="vertical-align:middle;text-align:center;">Seq.</th><th style="vertical-align:middle;text-align:center;">Report Name</th><th style="vertical-align:middle;text-align:center;">Domain</th><th style="vertical-align:middle;text-align:center;">Action</th></tr>';
		for(var i=0;i<this.cbReports.length;i++){
			table +=this.cbReports[i].toHtml();
		}
		table +='</table>';
		return table;
	}
	
	function sortCB(cbr1,cbr2){
		return cbr1.orderNo - cbr2.orderNo;
	}
	
	function CBPermission(cbid,id,permission){
		this.parent='';
		this.id = id;
		this.cbid=cbid;
		this.permission_type = permission.permission_type;
		this.permission_name = permission.permission_name;
		if(permission.permission_mail){
			this.permission_mail = permission.permission_mail;
		}else{
			this.permission_mail = '';
		}
		
	}
	
	CBPermission.prototype.toHtml = function(){
		var tr = '<TR>';
		tr += '<TD><INPUT type="checkbox" data-init="false" class="ibm-styled-checkbox" value="'+this.id+'" id="cbPermission_checkbox_'+this.permission_type+'_'+this.id + '_'+this.parent+'" name="cbPermission_checkbox_'+this.parent+'_children" /><label id="cbPermission_checkbox_'+this.permission_type+'_'+this.id + '_'+this.parent+'_label" for="cbPermission_checkbox_'+this.permission_type+'_'+this.id + '_'+this.parent+'" style="padding-left: 0px; padding-right: 0px;"></label></TD>';
		if(this.permission_type=='G'){
			tr += '<TD>Group</TD>';
			if(this.permission_mail&&this.permission_mail!=''){
				tr += '<TD>'+this.permission_name+' / '+this.permission_mail+'</TD>';
			}else{
				tr += '<TD>'+this.permission_name+'</TD>';
			}
			
		}else{
			tr += '<TD>User</TD>';
			if(this.permission_name&&this.permission_name!=''){
				tr += '<TD>'+this.permission_name+' / '+this.permission_mail+'</TD>';
			}else{
				tr += '<TD>'+this.permission_mail+'</TD>';
			}
		}		
		tr += '</TR>';
		return tr;
	}
	
	function CBPermissions(name){
		this.name = name;
		this.permissions = new Array();
	}
	
	CBPermissions.prototype.addPermission = function(cbPermission){
		cbPermission.parent = this.name;
		cbPermission.id = this.permissions.length;
		this.permissions.push(cbPermission);
	}
	
	CBPermissions.prototype.refreshPermission = function(cbPermission){		
		var f = false;
		for(var i=0;i<this.permissions.length;i++){
			if(this.permissions[i].permission_type==cbPermission.permission_type){
				if(cbPermission.permission_type=='U'){
					if(this.permissions[i].permission_mail==cbPermission.permission_mail){
						f = true;
					}
				}
				if(cbPermission.permission_type=='G'){
					if(this.permissions[i].permission_name==cbPermission.permission_name){
						f = true;
					}
				}
			}
		}
		if(f==false){
			cbPermission.parent = this.name;
			cbPermission.id = this.permissions.length;
			this.permissions.push(cbPermission);
		}
	}
	
	CBPermissions.prototype.getPermission = function(id){
		for(var i=0;i<this.permissions.length;i++){
			if(this.permissions[i].id==id){
				return this.permissions[i];
			}
		}
		return null;
	}
	
	CBPermissions.prototype.removePermission = function(cbPermission){
		
		for(var i=0;i<this.permissions.length;i++){
			if(this.permissions[i].id==cbPermission.id){
				this.permissions.splice(i,1);
			}
		}
		
	}
	
	CBPermissions.prototype.resetOrder = function(){
		for(var i=0;i<this.permissions.length;i++){
			this.permissions[i].id = i;
		}		
	}
	
	CBPermissions.prototype.toHtmlView = function(){
		var table='<table id="id_CBPermission_table_'+this.name+'" border="1" class="ibm-data-table ibm-padding-small ibm-altrows" style="width:100%;">';
		table +='<tr><th style="width:15%;">';
		table += '<INPUT type="checkbox" data-init="false" class="ibm-styled-checkbox" id="id_cbPermission_checkbox_'+this.name+'" name="cbPermission_checkbox_'+this.name+'" onchange="'+this.name+'.toggleCheckAll();return false;"/><label id="id_cbPermission_checkbox_'+this.name+'_label" for="id_cbPermission_checkbox_'+this.name+'" style="padding-left: 0px; padding-right: 0px;"></label>';
		table +='</th><th style="vertical-align:middle;text-align:center;width:15%;">Type</th><th style="vertical-align:middle;text-align:center;">Name/Mail</th></tr>';
		for(var i=0;i<this.permissions.length;i++){
			table +=this.permissions[i].toHtml();
		}
		table +='</table>';
		return table;
	}
	
	CBPermissions.prototype.empty = function(){
		this.permissions.splice(0,this.permissions.length);
	}
	
	CBPermissions.prototype.toggleCheckAll = function(){
		var checked = jQuery('#id_cbPermission_checkbox_'+this.name).prop('checked');		
		jQuery("[name='cbPermission_checkbox_"+this.name+"_children']").prop('checked',checked);
	}
	
} catch (oException) {
	alert(oException);
}