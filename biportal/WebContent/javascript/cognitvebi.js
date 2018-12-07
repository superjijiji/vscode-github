/**
 * William 2016/9/19
 */
try {
	var biportal_context = location.pathname.split("/action",2)[0];
	if(biportal_context.substring(biportal_context.length - 1,biportal_context.length) == '/'){
		biportal_context = biportal_context.substring(0,biportal_context.length - 1);		
	}
	if(biportal_context.substring(0,1) != '/'){
		biportal_context = '/'+biportal_context;
	}
	/**
	 * type: 'mr' is for my report, 'cb' is for control book,'rs' is for report search
	 * search,'rc' is for recent reports, 'rca' is for All recent reports, 'sub' is for My subscriptions panel.
	 * 
	 * @param type
	 */
	function BIDomains(name, type) {
		this.name = name;
		this.type = type;
		this.domains = null;
	}

	BIDomains.prototype.addReplaceDomain = function(bidomain) {
		if (this.name == null || this.name == '') {
			alert('BIDomains name is not defined');
			return false;
		}
		if (this.type == null || this.type == '') {
			alert('BIDomains type is not defined');
			return false;
		}
		if (this.name != bidomain.name) {
			alert('Can not add this domain into this domains due to different name');
			return false;
		}
		if (this.type != bidomain.type) {
			alert('Can not add this domain into this domains due to different type');
			return false;
		}
		if (this.domains == null) {
			this.domains = new Array();
		}
		var replace = false;
		for (var i = 0; i < this.domains.length; i++) {
			if (this.domains[i].json_domain.domainKey == bidomain.json_domain.domainKey) {
				this.domains[i] = bidomain;
				replace = true;
			}
		}
		if (replace == false) {
			this.domains.push(bidomain);
		}
	}

	BIDomains.prototype.getReport = function(domain_key, report_id) {
		if (this.domains == null) {
			return null;
		}
		for (var i = 0; i < this.domains.length; i++) {
			if (this.domains[i].json_domain.domainKey == domain_key) {
				return this.domains[i].getReport(domain_key, report_id);
			}
		}
		return null;
	}
	
	BIDomains.prototype.removeReport = function(domain_key, report_id) {
		if (this.domains == null) {
			return ;
		}
		for (var i = 0; i < this.domains.length; i++) {
			if (this.domains[i].json_domain.domainKey == domain_key) {
				this.domains[i].removeReport(domain_key, report_id);
				return;
			}
		}
	}

	function BIDomain(name, type, json_domain) {
		this.name = name;
		this.type = type;
		this.json_domain = json_domain;
		this.reports = null;
		if (this.json_domain.reports != null && this.json_domain.reports.length > 0) {
			this.reports = new Array();
			for (var i = 0; i < this.json_domain.reports.length; i++) {
				this.reports.push(new BIReport(this.name, this.type, this.json_domain.reports[i]));
			}
		}
	}

	BIDomain.prototype.getDomain = function() {
		return this.json_domain;
	}

	BIDomain.prototype.getReport = function(domain_key, report_id) {
		if (this.json_domain == null) {
			return null;
		}
		if (this.json_domain.reports == null || this.json_domain.reports.length == 0) {
			return null;
		}
		if (this.json_domain.domainKey == domain_key) {
			for (var i=0;i<this.json_domain.reports.length;i++) {
				var bireport = this.reports[i];
				if (bireport.report.domain_Key == domain_key && bireport.report.rptObjID == report_id) {
					return bireport;
				}
			}
		} else {
			return null;
		}
		return null;
	}
	
	BIDomain.prototype.removeReport = function(domain_key, report_id) {
		if (this.json_domain == null) {
			return ;
		}
		if (this.json_domain.reports == null || this.json_domain.reports.length == 0) {
			return ;
		}
		if (this.json_domain.domainKey == domain_key) {
			for (var i=0;i<this.json_domain.reports.length;i++) {
				var bireport = this.reports[i];
				if (bireport.report.domain_Key == domain_key && bireport.report.rptObjID == report_id) {
					this.reports.splice(i,1);
					return;
				}
			}
		} 
	}

	BIDomain.prototype.toString = function() {
		if (this.json_domain == null) {
			return "";
		}
		if (this.type == 'rs') {
			var str_domain = "";
			var domain_key = this.json_domain.domainKey;
			var display_name = this.json_domain.displayName;
			str_domain += '<span><strong>' + display_name + '</strong></span></br>';
			str_domain += '<table class="ibm-data-table ibm-padding-small ibm-altrows" width="80%" border="0" cellspacing="0" cellpadding="0" summary="Data table example">';
			str_domain += '<thead><tr>';
			str_domain += '<th width="2%" scope="col"></th>';   
			str_domain += '<th width="50%" scope="col">Name</th>';
			str_domain += '<th width="30%" scope="col">Last Modified Time</th>';
			str_domain += '<th width="18%" scope="col">Actions</th>';
			str_domain += '</tr></thead>';
			str_domain += '<tbody>';
			
			if (this.reports != null && this.reports.length > 0) {
				for (var i = 0; i < this.reports.length; i++) {
					var bireport = this.reports[i];
					str_domain += bireport.toString();
				}
			}
			str_domain += '</tbody>';
			str_domain += '</table>';
			return str_domain;
		}
		
	}

	/**
	 * type: 'mr' is for my favorite report, 'cb' is for control book,'rs' is
	 * for report search,'rc' is for recent reports, 'rca' is for All recent reports,
	 * 'arblob' for All reports - blob.
	 *
	 *simon add ca,for cognos all report
	 *ludi add cm for cognos my report
	 * @param type
	 */
	function BIReports(name, type) {
		this.name = name;
		this.type = type;
		this.reports = null;
	}

	BIReports.prototype.addReport = function(biReport) {
		if (this.name != biReport.name) {
			alert('sorry, you can not add this report with name:' + biReport.name + ' into this report list:' + this.name);
			return false;
		}
		if (this.type != biReport.type) {
			alert('sorry, you can not add this report with type:' + biReport.type + ' into this report list with type:' + this.type);
			return false;
		}
		if (this.reports == null) {
			this.reports = new Array();
		}
		this.reports.push(biReport);
	}

	BIReports.prototype.getReport = function(domain_key, report_id) {
 
		if (this.reports == null) {
			return null;
		}
		for (var i=0;i<this.reports.length;i++) {
			var bireport = this.reports[i];
			if (bireport.report.domain_Key == domain_key && bireport.report.rptObjID == report_id) {
				return bireport;
			}

		}
		return null;
	}
	
	BIReports.prototype.removeReport = function(domain_key, report_id) {
		if (this.reports == null) {
			return ;
		}
		for (var i=0;i<this.reports.length;i++) {
			var bireport = this.reports[i];
			if (bireport.report.domain_Key == domain_key && bireport.report.rptObjID == report_id) {
				this.reports.splice(i,1);
				return;
			}
		}
	}

	/**
	 * type: 'mr' is for my report, 'cb' is for control book,'rs' is for report,'rc' is for recent reports, 'rca' is for All recent reports, 'arblob' is for All reports - blob,
	 * search
	 * 
	 * @param type
	 */
	BIReports.prototype.toString = function() {

		if (this.reports == null || this.reports.length == 0) {
			return "";
		}
		var tables = "";
		if (this.type == 'mr') {
			tables += '<table class="ibm-data-table ibm-padding-small ibm-altrows" style="width: 100%; table-layout: fixed; -ms-word-wrap: break-word;" border="0" cellspacing="1" cellpadding="1" summary="Report actions">';
			tables += '<tbody>';
			for (i in this.reports) {
				tables += this.reports[i].toString();
			}
			tables += '</tbody>';
			tables += '</table>';
		}
		if (this.type == 'ca') {
			var str_domain = "";
			//var domain_key = this.json_domain.domainKey;
			//var display_name = this.json_domain.displayName;
			str_domain += '<span><strong>' + 'Cognos all reports' + '</strong></span></br>';
			str_domain += '<table width="1024" role="presentation" class="ibm-data-table ibm-padding-small ibm-altrows"  style="width: 100%; table-layout: fixed; -ms-word-wrap: break-word;" border="0" cellspacing="1" cellpadding="1" summary="Report actions">';
			str_domain += '<thead><tr>';
			str_domain += '<th width="2%" scope="col"></th>';   
			str_domain += '<th width="43%" scope="col">Name</th>';
			str_domain += '<th width="27%" scope="col">Last Modified Time</th>';
			str_domain += '<th width="28%" scope="col">Actions</th>';
			str_domain += '</tr></thead>';
			str_domain += '<tbody>';
			
			if (this.reports != null && this.reports.length > 0) {
				for (var i = 0; i < this.reports.length; i++) {
					var bireport = this.reports[i];
					str_domain += bireport.toString();
				}
			}
			str_domain += '</tbody>';
			str_domain += '</table>';
			return str_domain;
		}
		if (this.type == 'cm') {
			var str_domain = "";
			//var domain_key = this.json_domain.domainKey;
			//var display_name = this.json_domain.displayName;
			str_domain += '<span><strong>' + 'Cognos my reports' + '</strong></span></br>';
			str_domain += '<table class="ibm-data-table ibm-padding-small ibm-altrows" width="100%" border="0" cellspacing="0" cellpadding="0" summary="Data table example">';
			str_domain += '<thead><tr>';
			str_domain += '<th width="2%" scope="col"></th>';   
			str_domain += '<th width="43%" scope="col">Name</th>';
			str_domain += '<th width="27%" scope="col">Last Modified Time</th>';
			str_domain += '<th width="28%" scope="col">Actions</th>';
			str_domain += '</tr></thead>';
			str_domain += '<tbody>';
			
			if (this.reports != null && this.reports.length > 0) {
				for (var i = 0; i < this.reports.length; i++) {
					var bireport = this.reports[i];
					str_domain += bireport.toString();
				}
			}
			str_domain += '</tbody>';
			str_domain += '</table>';
			return str_domain;
		}
		if (this.type == 'cb') {
			tables += '<table class="ibm-data-table ibm-padding-small ibm-altrows" style="width: 100%; table-layout: fixed; -ms-word-wrap: break-word;" border="0" cellspacing="1" cellpadding="1" summary="Controlbook actions">';
			tables += '<tbody>';
//			tables += '<tr>';
//			tables += '<th style="width:4%;"></th><th style="width:70%;" scope="col"></th><th style="width:26%;" scope="col"></th>';
//			tables += '</tr>';
			for (var i=0;i<this.reports.length;i++) {
				tables += this.reports[i].toString();
			}
			tables += '</tbody>';
			tables += '</table>';
			
		}
		if (this.type == 'rs') {
		
		}
		if (this.type == 'rc' || this.type == 'rca') {
			tables += '<table class="ibm-data-table ibm-padding-small ibm-altrows" style="width: 100%; table-layout: fixed; -ms-word-wrap: break-word;" border="0" cellspacing="1" cellpadding="1" summary="Report actions">';
			tables += '<tbody>';
			if (this.type == 'rc') {
				tables += '<thead><tr><th style="width:4%;" scope="col"></th><th style="width: 69%;" scope="col">Name / Last run</th><th style="width: 27%;" scope="col">Actions</th></tr></thead>';
			} else {
				tables += '<thead><tr><th style="width:2%;" scope="col"></th><th style="width: 43%;" scope="col">Name / Last run</th><th style="width: 27%;" scope="col">Report #</th><th style="width: 28%;" scope="col">Actions</th></tr></thead>';
			}
			for (i in this.reports) {
				tables += this.reports[i].toString();
				// at most 5 records to be displayed in main portal page
				if (this.type == 'rc' && i == 4) {  
					break; 
				}
			}
			tables += '</tbody>';
			tables += '</table>';
		}
		if (this.type == 'arblob') {
			for (i in this.reports) {
				tables += this.reports[i].toString();
			}
		}
		// yhqin add this if to draw table for My subscription panel
		if (this.type == 'sub') {
			tables += '<table width="1024" role="presentation" class="ibm-data-table ibm-padding-small ibm-altrows" style="width: 100%; table-layout: fixed; -ms-word-wrap: break-word;" border="0" cellspacing="1" cellpadding="1" summary="Report actions">';
			tables += '<tbody>';
			tables += '<thead>';
			tables += '<tr><th style="width:2%;" scope="col"></th><th style="width: 43%;" scope="col">Name</th><th style="width: 27%;" scope="col">Last Modified Time</th><th style="width: 28%;" scope="col">Actions</th></tr>';
			tables += '</thead>';
			for (i in this.reports) {
				tables += this.reports[i].toString();
			}
			tables += '</tbody>';
			tables += '</table>';
		}
		return tables;
	}

	function BIReport(name, type, report) {
		this.name = name;
		this.type = type;
		this.report = report;
		this.id = this.type+'_'+this.name+"_"+this.report.domain_Key+"_"+this.report.rptObjID.trim();
		this.icon_class = "bireport_Report_Type_" + this.report.reportType.trim();
		if (this.report.objectClass != null && this.report.objectClass.trim().length != 0) {
			this.icon_class += "_" + this.report.objectClass.trim();
		}
		if (report.favorite) {
			this.icon_class += "_sel";
		}		
		this.action_button = new ActionButton(name,type,this);
	}

	BIReport.prototype.toString = function() {
		
		if (this.report == null) {
			return "";
		}

		var str_report = "";

		if (this.type == 'rs') {
			str_report += '<tr id="'+this.id+'" >';
			str_report += '<td  style="vertical-align: top;padding-top: 6px;padding-bottom: 2px;" ><div id="'+this.id+'_image" class="'+this.icon_class+'"/></td>';
			str_report += '<td  style="vertical-align: top;padding-top: 2px;padding-bottom: 2px;" >';
			str_report += '<a title="' + (this.report.reportType == 'cognos' ? decodeURIComponent(this.report.searchPath) : this.report.rptDesc) + '" href="#" ';
			str_report += 'onclick="' + this.name + '.getReport(\'' + this.report.domain_Key + '\',\'' + this.report.rptObjID + '\').openReport(); return false;">'+ decodeURIComponent(this.report.rptName) + '</a></td>';
			str_report += '<td  style="vertical-align: top;padding-top: 2px;padding-bottom: 2px;" >' + (this.report.rptDate==null?"":this.report.rptDate) + '</td>';
			str_report += '<td style="vertical-align: top;padding-top: 2px;padding-bottom: 2px;vertical-align: top;">';
			var actionButton = new ActionButton(this.name,this.type,this);
			str_report += actionButton.toString();
			str_report += '</td>';
			str_report += '</tr>';
		}
		if (this.type == 'ca') {
			str_report += '<tr id="'+this.id+'" >';
			str_report += '<td  style="vertical-align: top;padding-top: 12px" ><div id="'+this.id+'_image" class="'+this.icon_class+'"/></td>';
			
			
			if (this.report.reportType == 'cognos' ) {
			
			str_report += '<td style="vertical-align: top;padding-top: 10px;">';
			str_report += '<a title="' + (this.report.reportType == 'cognos' ? decodeURIComponent(this.report.searchPath) : this.report.rptDesc) + '" href="#" ';
			str_report += 'onclick="' + this.name + '.getReport(\'' + this.report.domain_Key + '\',\'' + this.report.rptObjID + '\').openReport(); return false;">'+ decodeURIComponent(this.report.rptName) + '</a></td>';
			
			}else{
				str_report += '<td style="vertical-align: top;padding-top: 10px;">';
				str_report += '<a title="' + (this.report.reportType == 'cognos' ? decodeURIComponent(this.report.searchPath) : this.report.rptDesc) + '" href="#" ';
				str_report += 'onclick=" openPublicCognos(\'' + this.report.domain_Key + '\',\'' + this.report.rptObjID + '\'); return false;">'+ decodeURIComponent(this.report.rptName) + '</a></td>';
				
			}
			
			
			str_report += '<td  style="vertical-align: top;padding-top: 10px;" >' + (this.report.rptDate==null?"":this.report.rptDate) + '</td>';
			str_report += '<td style="vertical-align: top;padding-top: 10px;vertical-align: top;">';
			if(this.report.reportType=='cognos'){
				//not folder		

		
			var actionButton = new ActionButton(this.name,this.type,this);
			str_report += actionButton.toString();
			}	
			str_report += '</td>';
			str_report += '</tr>';
		}
		
		if (this.type == 'cm') {
			str_report += '<tr id="'+this.id+'" >';
			str_report += '<td  style="vertical-align: top;top;padding-top: 12px;" ><div id="'+this.id+'_image" class="'+this.icon_class+'"/></td>';
			
			
			if (this.report.reportType == 'cognos' ) {
			
			str_report += '<td  style="vertical-align: top;padding-top: 10px;" >';
			str_report += '<a title="' + (this.report.reportType == 'cognos' ? decodeURIComponent(this.report.searchPath) : this.report.rptDesc) + '" href="#" ';
			str_report += 'onclick="' + this.name + '.getReport(\'' + this.report.domain_Key + '\',\'' + this.report.rptObjID + '\').openReport(); return false;">'+ decodeURIComponent(this.report.rptName) + '</a></td>';
			
			}else{
				str_report += '<td  style="vertical-align: top;top;padding-top: 10px;" >';
				str_report += '<a title="' + (this.report.reportType == 'cognos' ? decodeURIComponent(this.report.searchPath) : this.report.rptDesc) + '" href="#" ';
				str_report += 'onclick=" openMyCognos(\'' + this.report.domain_Key + '\',\'' + this.report.rptObjID + '\'); return false;">'+ decodeURIComponent(this.report.rptName) + '</a></td>';
				
			}
			
			
			str_report += '<td  style="vertical-align: top;top;padding-top: 10px;" >' + (this.report.rptDate==null?"":this.report.rptDate) + '</td>';
			str_report += '<td style="vertical-align: top;top;padding-top: 10px;">';
			if(this.report.reportType=='cognos'){
				//not folder		

		
			var actionButton = new ActionButton(this.name,this.type,this);
			str_report += actionButton.toString();
			}	
			str_report += '</td>';
			str_report += '</tr>';
		}
		
		
		
		if (this.type == 'mr') {					
			str_report += '<tr id="' + this.id + '" role="link" onmouseover="this.className=\'hiliteBG\';" onmouseout="this.className = \'\'" >';
			str_report += '<td scope="col" style="width:4%;vertical-align: top;padding-top: 10px;"><div id="'+this.id+'_image" class="'+this.icon_class+'"/></td>';
			str_report += '<td scope="col" style="width:69%;overflow: hidden; -ms-word-break: break-all; word-warp: break-word;padding-top: 10px;">';
			str_report += '<a id="' + this.id + '-anchor2" onclick="' + this.name + '.getReport(\'' + this.report.domain_Key + '\',\'' + this.report.rptObjID+ '\').openReport(); return false;" href="#" style="margin-left: 6px;"><span title="' + this.report.domain_Key + ' | ' + this.report.rptDesc + '" class="word-wrap">'	+ this.report.rptName + '</span></a>';
			str_report += '<br><span class="word-wrap" style="margin-left: 6px;">' + (this.report.reportTypeCD==13?this.report.rptDate:"") + '</span>';
			str_report += '</td>';
			str_report += '<td scope="col" style="width:27%;vertical-align: top;">';
			var actionButton = new ActionButton(this.name,this.type,this);
			str_report += actionButton.toString();
			str_report += '</td>';
			str_report += '</tr>';
		}
		if (this.type == 'cb') {
			str_report += '<tr id="' + this.id + '" role="link" onmouseover="this.className=\'hiliteBG\';" onmouseout="this.className = \'\'" >';
			str_report += '<td style="width:4%; vertical-align: top;padding-top: 10px;"><div id="'+this.id+'_image" class="'+this.icon_class+'"/></td>';
			str_report += '<td style="width:70%; overflow: hidden; -ms-word-break: break-all; word-warp: break-word;padding-top: 10px;">';
			if(this.report.accessible!=null&&this.report.accessible=='Y'){
				str_report += '<a id="' + this.id + '-anchor2" onclick="' + this.name + '.getReport(\'' + this.report.domain_Key + '\',\'' + this.report.rptObjID+ '\').openReport(); return false;" href="#" style="margin-left: 6px;"><span title="' + this.report.domain_Key + ' | ' + this.report.rptDesc + '" class="word-wrap">'	+ this.report.rptName + '</span></a>';	
			}else{
				str_report += '<a id="' + this.id + '-anchor2" onclick="alert(\'Sorry, You do not have access to this report.\'); return false;" href="#" style="margin-left: 6px;"><span title="' + this.report.domain_Key + ' | ' + this.report.rptDesc + '" class="word-wrap" style="color:red;">'	+ this.report.rptName + '</span></a>';				
			}
			str_report += '</td>';
			str_report += '<td style="width:26%; vertical-align: top;">';
			var actionButton = new ActionButton(this.name,this.type,this);
			str_report += actionButton.toString();
			str_report += '</td>';
			str_report += '</tr>';
		}
		if (this.type == 'rc' || this.type == 'rca') {
			str_report += '<tr id="' + this.id + '" role="link" onmouseover="this.className=\'hiliteBG\';" onmouseout="this.className = \'\'" >';
			str_report += '<td style="vertical-align: top;padding-top: 10px;"><div id="'+this.id+'_image" class="'+this.icon_class+'"/></td>';
			str_report += '<td style="overflow: hidden; -ms-word-break: break-all; word-warp: break-word;padding-top: 10px;">';
			str_report += '<a id="' + this.id + '-anchor2" onclick="' + this.name + '.getReport(\'' + this.report.domain_Key + '\',\'' + this.report.rptObjID + '\').openReport(); return false;" href="#" style="margin-left: 6px;"><span title="' + this.report.domain_Key + ' | ' + this.report.rptDesc + '" class="word-wrap" >' + this.report.rptName + '</span></a>';
			str_report += '<br><span class="word-wrap" style="fone-size:12px;margin-left: 6px;">' + (this.report.reportTypeCD==13?this.report.rptDate:"") + '</span>';
			str_report += '</td>';
			// type == 'rca': is used for "View all recent reports" page, another column "Report #" is needed.
			if (this.type == 'rca') {
				str_report += '<td>' + (this.report.reportTypeCD==13?this.report.rptObjID:"") + '</td>';
			}
			str_report += '<td style="vertical-align: top;">';
			var actionButton = new ActionButton(this.name,this.type,this);
			str_report += actionButton.toString();
			str_report += '</td>';
			str_report += '</tr>';
		}
		// yhqin add this.type == 'sub' to draw tr for My subscription panel, so the panel looks like the same with Blob show all panel.
		if (this.type == 'arblob' || this.type == 'sub') {
			str_report += '<tr id="' + this.id + '" role="link" onmouseover="this.className=\'hiliteBG\';" onmouseout="this.className = \'\'" >';
			str_report += '<td style="vertical-align: top;padding-top: 10px;"><div id="'+this.id+'_image" class="'+this.icon_class+'"/></td>';
			str_report += '<td style="overflow: hidden; -ms-word-break: break-all; word-warp: break-word;padding-top: 10px;">';
			str_report += '<a id="' + this.id + '-anchor2" onclick="' + this.name + '.getReport(\'' + this.report.domain_Key + '\',\'' + this.report.rptObjID + '\').openReport(); return false;" href="#"><span title="' + this.report.domain_Key + ' | ' + this.report.rptDesc + '" class="word-wrap" >' + this.report.rptName + '</span></a>';
			str_report += '</td>';
			str_report += '<td>' + this.report.rptDate + '</td>';
			str_report += '<td style="vertical-align: top;">';
			var actionButton = new ActionButton(this.name,this.type,this);
			str_report += actionButton.toString();
			str_report += '</td>';
			str_report += '</tr>';
		}
		return str_report;
	}

	BIReport.prototype.isAccessible = function() {
		if(this.type=='cb'){
			if(this.report.accessible!=null&&this.report.accessible=="Y"){
				return true;
			}else{
				return false;
			}
		}		
		return true;
	}
	
	BIReport.prototype.getReportType = function() {
		return this.report.reportType;		
	}

	BIReport.prototype.addToMyFavorite = function(menu_id) {
		
		if(this.isAccessible()==false){
			alert('Sorry, You do not have access to this report.');
			return false;
		}
		var timeid = (new Date()).valueOf();
		var url = biportal_context+'/action/portal/myrpts/addMyfavRpt?timeid='+timeid;
		
		var bireport = this;
		if(bireport.report.favorite == true){
			alert('This report has been added to My favorites.');
			return;
		}
		
		jQuery.ajax({
			type : "post",
			url : url,
			//async : false,
			data : JSON.stringify(this.report),
			contentType: "application/json",
			datatype : "json",// "xml", "html", "script", "json", "jsonp",
								// "text".
			beforeSend : function() {
				window.status = 'adding report ...';
			},
			success : function(data) {
				window.status = 'successful';
				bireport.report.favorite = true;
				if(bireport.action_button && bireport.action_button.action_button_menus){
					for(var i=0;i<bireport.action_button.action_button_menus.length;i++){
						var menu_item = bireport.action_button.action_button_menus[i];
						if(menu_item.id==menu_id){
							menu_item.icon_class = menu_item.icon_class+'_sel';
							menu_item.menu_label = 'This report has been added to My favorites';
							menu_item.onclick = 'none';
							break;
						}
					}					
				}
				bireport.icon_class = bireport.icon_class+'_sel';
				jQuery("#"+bireport.id+'_image').attr('class',bireport.icon_class);
				alert('Added to your favorite list successfully.')
			},
			error : function(error) {
				alert('failed to add this report to your favorite reports, error reason:' + error.responseText);
			}
		});
		this.addUsage('MR');
	}
	
	BIReport.prototype.removeFromMyFavorite = function(menu_id){
		var timeid = (new Date()).valueOf();
		var url = biportal_context+'/action/portal/myrpts/removeMyreport?timeid='+timeid;
		var bireport = this;
		jQuery.ajax({
			type : "post",
			url : url,
			async : false,
			data : JSON.stringify(this.report),
			contentType: "application/json",
			datatype : "json",// "xml", "html", "script", "json", "jsonp",
								// "text".
			beforeSend : function() {
				window.status = 'removing report ...';
			},
			success : function(data) {
				window.status = 'removed';
				eval(bireport.name+".removeReport('"+bireport.report.domain_Key+"','"+bireport.report.rptObjID+"')");
				//call function in myreports to refresh my favorites page
				folder_loadWithGroups();
			},
			error : function(error) {
				alert('failed to remove this report from your favorite reports, error reason:' + error.responseText);
			}
		});
	}
	
	BIReport.prototype.openReport = function(menu_id){
		
		if(this.isAccessible()==false){
			alert('Sorry, You do not have access to this report.');
			return false;
		}
		
		var rpt_type = this.getReportType();
		if(rpt_type=='cognos'){
			if(this.report.objectClass=='URL'){
				this.openReportUrl();
			}else{
				this.forwardToCognos(null,this.report.combobutton.onclick+','+this.report.combobutton.param);	
			}			
		}
		if(rpt_type=='links'){
			this.openReportUrl();
		}
		if(rpt_type=='IR'){
			var timeid = (new Date()).valueOf();
			var url = "/transform/biportal/action/portal/report/openIRReport?timeid="+timeid;
			var newWin = window.open('', '_blank', 'resizable=yes,toolbar=no,menubar=no,scrollbars=yes');
			jQuery.ajax({
				type : "POST",
				url : url,
				//async : false,
				data : JSON.stringify(this.report),
				contentType: "application/json",
				datatype : "json",
				beforeSend : function() {
					window.status = 'opening IR report ...';
				},
				success : function(data) {
					var url = data.viewName.replace('redirect:','');
					//window.open(url, '_blank','resizable=yes,toolbar=no,menubar=no,scrollbars=yes'+",ScreenX=0,ScreenY=0,top=0,left=0,width=" + screen.availWidth + ",height="+screen.availHeight);
					newWin.location = url;
				},
				error : function(error) {					
					alert('failed to subscribe this report, error reason:' + error.responseText);
				}
			});
			this.addUsage('DL');
 
		}
	}
	
	BIReport.prototype.openDashBoardReport = function(menu_id){
		this.openReport(menu_id);
	}
	
	BIReport.prototype.openReportUrl = function(menu_id){
		
		if(this.isAccessible()==false){
			alert('Sorry, You do not have access to this report.');
			return false;
		}
		
		if(this.report.rptUrl==null||this.report.rptUrl==''){
			alert('Wrong report definition, it does not contain any url to open!');
			return;
		}
		window.open(this.report.rptUrl,'_blank','resizable=yes,toolbar=no,menubar=no,scrollbars=yes'+",ScreenX=0,ScreenY=0,top=0,left=0,width=" + screen.availWidth + ",height="+screen.availHeight);
		this.addRecent();
		this.addUsage('SH');
	}
	
	BIReport.prototype.forwardToCognos = function(menu_id,action_param){
		
		if(this.isAccessible()==false){
			alert('Sorry, You do not have access to this report.');
			return false;
		}
		
		if(action_param==null||action_param==''){
			alert('Wrong parameters to forward request to cognos');
			return;
		}
		var operations = action_param.split(",",2);
		var url = biportal_context+'/action/portal/report/cognosRequest';
		url +='/'+this.report.cwaid;
		url +='/'+this.report.uid;
		url +='/'+this.report.domain_Key;
		url +='/'+this.report.rptObjID;
		url +='/'+this.report.rptName.replace(/\//g," ");
		url +='/'+this.report.reportType;
		url +='/'+this.report.objectClass;
		url +='/'+this.report.refer_Objectid;
		url +='/'+this.report.refer_ObjectClass;
		url +='/'+operations[0];
		url +='/'+operations[1];
		windowWidth = screen.availWidth;
		windowHeight = screen.availHeight;
		style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0,width=" + windowWidth + ",height="+windowHeight;
		window.open(url,'_blank', style);		
		this.addRecent();
		this.addUsage(operations[0]);
	}
	
	BIReport.prototype.helpReport = function(menu_id){
		window.open(this.report.helpDoc,"RptInfo","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=580,height=450,screenX=10,screenY=10");
	}
	
	BIReport.prototype.addRecent = function(){
		var timeid = (new Date()).valueOf();
		var url = biportal_context+'/action/portal/myrpts/addRecentRpt?timeid='+timeid;
		jQuery.ajax({
			type : "post",
			url : url,
			data : JSON.stringify(this.report),
			contentType: "application/json",
			datatype : "json",// "xml", "html", "script", "json", "jsonp",
								// "text".
			beforeSend : function() {
				//window.status = 'adding recent ...';
			},
			success : function(data) {
				//window.status = 'successful';
			},
			error : function(error) {				
				//alert('failed to add this report to your recent list, error reason:' + error.responseText);
			}
		});
	}

	BIReport.prototype.addUsage = function(action_cd){
		var timeid = (new Date()).valueOf();
		var url = biportal_context+'/action/portal/usage/saveReportUsage/'+action_cd+'?timeid='+timeid;
		jQuery.ajax({
			type : "post",
			url : url,
			data : JSON.stringify(this.report),
			contentType: "application/json",
			datatype : "json",// "xml", "html", "script", "json", "jsonp",
								// "text".
			beforeSend : function() {
				//window.status = 'adding recent ...';
			},
			success : function(data) {
				//window.status = 'successful';
			},
			error : function(error) {
				//alert('failed to save usage data, error reason:' + error.responseText);
			}
		});
	}
	

	BIReport.prototype.subscribeReport = function(menu_id) {
		
		if(this.isAccessible()==false){
			alert('Sorry, You do not have access to this report.');
			return false;
		}
		
		var bireport = this;
		if(bireport.report.subscribe==true){
			alert('This report has been subscribed.');
			return;
		}
		if (this.report.reportType == 'IR') {
			var timeid = (new Date()).valueOf();
			var url = biportal_context+'/action/portal/myrpts/subscribeRpt?timeid='+timeid;			
			jQuery.ajax({
				type : "post",
				url : url,
				//async : false,
				data : JSON.stringify(this.report),
				contentType: "application/json",
				datatype : "json",
				beforeSend : function() {
					window.status = 'Subscribing report ...';
				},
				success : function(data) {
					window.status = 'subscribed';
					bireport.report.subscribe = true;
					if(bireport.action_button && bireport.action_button.action_button_menus){
						for(var i=0;i<bireport.action_button.action_button_menus.length;i++){
							var menu_item = bireport.action_button.action_button_menus[i];
							if(menu_item.id==menu_id){
								menu_item.icon_class = menu_item.icon_class+'_sel';
								menu_item.menu_label = 'You have subscribed to this report';
								menu_item.onclick = 'none';
								break;
							}
						}
					}
					alert('Subscribed this report successfully');
				},
				error : function(error) {
					window.status = 'failed to subscribe this report ';
					alert('failed to subscribe this report, error reason:' + error.responseText);
				}
			});
		}
		this.addRecent();		
	}
	
	// yhqin add this menu function to remove Blob report from My subscriptions panel.
	BIReport.prototype.removeFromMySubscription = function(menu_id) {
		var timeid = (new Date()).valueOf();
		var url = biportal_context+'/action/portal/mysubscription/deleteSubBlobReport?timeid='+timeid;
		var bireport = this;
		jQuery.ajax({
			type : "post",
			url : url,
			async : false,
			data : JSON.stringify(this.report),
			contentType: "application/json",
			datatype : "json",// "xml", "html", "script", "json", "jsonp",
								// "text".
			beforeSend : function() {
				window.status = 'removing report ...';
			},
			success : function(data) {
				window.status = 'removed';
				eval(bireport.name+".removeReport('"+bireport.report.domain_Key+"','"+bireport.report.rptObjID+"')");
				//call function in mysubscription to refresh my subscription page
				refreshMySubscriptionPanel();
			},
			error : function(error) {
				alert('failed to remove subscription for this report, error reason:' + error.responseText);
			}
		});
	}
	
	BIReport.prototype.mailReport = function(menu_id){
		
		if(this.isAccessible()==false){
			alert('Sorry, You do not have access to this report.');
			return false;
		}
		
		if(this.report.reportType=='IR'){
			var timeid = (new Date()).valueOf();
			var url = "/transform/biportal/action/portal/report/mailIRReport?timeid="+timeid;
			var newWin = window.open('', '_blank', 'resizable=yes,toolbar=no,menubar=no,scrollbars=yes');
			jQuery.ajax({
				type : "POST",
				url : url,
				//async : false,
				data : JSON.stringify(this.report),
				contentType: "application/json",
				datatype : "json",
				beforeSend : function() {
					window.status = 'mail IR report ...';
				},
				success : function(data) {
					var url = data.viewName.replace('redirect:','');
					//window.open(url, '_blank', 'resizable=yes,toolbar=no,menubar=no,scrollbars=yes');
					newWin.location = url;
				},
				error : function(error) {					
					alert('failed to subscribe this report, error reason:' + error.responseText);
				}
			});
			
		}
		//this.addRecent();
	}
	
	// ==========================================================================
	// BI Portal action Button
	// ==========================================================================	
	
	function ActionButton(name,type,report) {
		this.name=name;
		this.type=type;
		this.report=report;
		this.id = report.id+"_button_id";
		this.action_button_menus = null;
	}
	
	ActionButton.prototype.initialMenu = function() {
		var icon_class_pre = 'action_menu_' + this.getReportType() + '_';
		if (this.getReportType() == 'links') {
			this.addMenuItem('runRpt', icon_class_pre + 'runRpt', 'Run this generic report', 'openReport', 1);			
			if(this.type=='mr') {
				this.addMenuItem('removeFav', 'action_menu_removeFav', 'Remove from my favorites', 'removeFromMyFavorite', 2);
			} else {
				if (this.report.report.favorite != null && this.report.report.favorite == true) {
					this.addMenuItem('addFav', 'action_menu_addFav_sel', 'This report has been added to My favorites', 'none', 2);
				} else {
					this.addMenuItem('addFav', 'action_menu_addFav', 'Add this report to My favorites', 'addToMyFavorite', 2);
				}
			}
			this.addMenuItem('helpRpt', icon_class_pre + 'helpRpt', 'Information about this report', 'helpReport', 3);
		} else if (this.getReportType() == 'IR') {
			this.addMenuItem('runRpt', icon_class_pre + 'runRpt', 'Run this IR report', 'openReport', 1);
			// yhqin add if (this.type == 'sub') for remove from My subscription
			if (this.type == 'sub') { 
				this.addMenuItem('subsRpt', icon_class_pre + 'subsRpt_del', 'Remove from My subscriptions', 'removeFromMySubscription', 2);
			} else {
				if (this.report.report.subscribe != null && this.report.report.subscribe == true) {
					this.addMenuItem('subsRpt', icon_class_pre + 'subsRpt_sel', 'You have subscribed to this report', 'none', 2);
				} else {
					this.addMenuItem('subsRpt', icon_class_pre + 'subsRpt', 'Subscribe to this report', 'subscribeReport', 2);
				}
			}
			this.addMenuItem('mailRpt', icon_class_pre + 'mailRpt', 'Mail this report', 'mailReport', 3);
			if(this.type=='mr'){
				this.addMenuItem('removeFav', 'action_menu_removeFav', 'Remove from my favorites', 'removeFromMyFavorite', 4);
			} else {
				if (this.report.report.favorite != null && this.report.report.favorite == true) {
					this.addMenuItem('addFav', 'action_menu_addFav_sel', 'This report has been added to My favorites', 'none', 4);
				} else {
					this.addMenuItem('addFav', 'action_menu_addFav', 'Add this report to My favorites', 'addToMyFavorite', 4);
				}
			}
			this.addMenuItem('helpRpt', icon_class_pre + 'helpRpt', 'Information about this report', 'helpReport', 5);
		} else if (this.getReportType() == 'cognos') {
			var timeid = (new Date()).valueOf();
			var url = biportal_context+'/action/portal/myrpts/getCognosActionMenu?timeid='+timeid;
			var actionButton = this;
			jQuery.ajax({
				type : "post",
				url : url,
				//async : false,
				data : JSON.stringify(this.report.report),
				contentType: "application/json",
				datatype : "json",// "xml", "html", "script", "json", "jsonp", "text".
				beforeSend : function() {
					actionButton.addMenuItem('loading_menu', 'loading', 'loading action menu...', 'none', 1);
				},
				success : function(data) {
					actionButton.initialCognosActionMenu(data);
				},
				error : function(error) {
					actionButton.action_button_menus = [];
					alert('failed to get your report action menu, error reason:' + error.responseText);
				}
			});
		} else {
			alert('Error, BI Portal does not support this type of report:' + this.getReportType());
			return false;
		}
		return true;
	}
	
	ActionButton.prototype.initialCognosActionMenu = function(action_menu){
		var icon_class_pre = 'action_menu_' + this.getReportType() + '_';
		this.action_button_menus = [];
		for (var i = 0; i < action_menu.length; i++) {
			/**
			 * onlclick 
			 * edit_with_AS edit_with_QS edit_with_RS help mr open_ds open_page
			 * open_url run_with_option schedule view_output
			 */
			if (action_menu[i].hasPrivilege == true) {
				if(action_menu[i].param==null||action_menu[i].param==''){
					action_menu[i].param='none';
				}
				if (action_menu[i].onclick == 'mr') {
					if (this.type == 'mr') {
						this.addMenuItem('removeFav', 'action_menu_removeFav', 'Remove from my favorites', 'removeFromMyFavorite', action_menu[i].sequence);
					} else {
						if (this.report.report.favorite != null && this.report.report.favorite == true) {
							this.addMenuItem('addFav', 'action_menu_addFav_sel', 'This report has been added to My favorites', 'none', action_menu[i].sequence);
						} else {
							this.addMenuItem('addFav', 'action_menu_addFav', 'Add this report to My favorites', 'addToMyFavorite', action_menu[i].sequence);
						}
					}
				} else if (action_menu[i].onclick == 'help') {
					this.addMenuItem('helpRpt', icon_class_pre + 'helpRpt', 'Information about this report', 'helpReport', action_menu[i].sequence);
				} else if (action_menu[i].onclick == 'open_url') {
					this.addMenuItem(action_menu[i].id.menuItemName, 'cognos_open_URL', action_menu[i].menuItemLabel, 'openReportUrl', action_menu[i].sequence);
				} else if (action_menu[i].onclick == 'edit_with_AS') {
					this.addMenuItem(action_menu[i].id.menuItemName, action_menu[i].iconClass, action_menu[i].menuItemLabel, 'forwardToCognos', action_menu[i].sequence,action_menu[i].onclick+','+action_menu[i].param);
				} else if (action_menu[i].onclick == 'edit_with_QS') {
					this.addMenuItem(action_menu[i].id.menuItemName, action_menu[i].iconClass, action_menu[i].menuItemLabel, 'forwardToCognos', action_menu[i].sequence,action_menu[i].onclick+','+action_menu[i].param);
				} else if (action_menu[i].onclick == 'edit_with_RS') {
					this.addMenuItem(action_menu[i].id.menuItemName, action_menu[i].iconClass, action_menu[i].menuItemLabel, 'forwardToCognos', action_menu[i].sequence,action_menu[i].onclick+','+action_menu[i].param);
				} else if (action_menu[i].onclick == 'open_ds') {
					this.addMenuItem(action_menu[i].id.menuItemName, action_menu[i].iconClass, action_menu[i].menuItemLabel, 'forwardToCognos', action_menu[i].sequence,action_menu[i].onclick+','+action_menu[i].param);
				} else if (action_menu[i].onclick == 'open_page') {
					this.addMenuItem(action_menu[i].id.menuItemName, action_menu[i].iconClass, action_menu[i].menuItemLabel, 'forwardToCognos', action_menu[i].sequence,action_menu[i].onclick+','+action_menu[i].param);
				} else if (action_menu[i].onclick == 'run_with_option') {
					this.addMenuItem(action_menu[i].id.menuItemName, action_menu[i].iconClass, action_menu[i].menuItemLabel, 'forwardToCognos', action_menu[i].sequence,action_menu[i].onclick+','+action_menu[i].param);
				} else if (action_menu[i].onclick == 'schedule') {
					this.addMenuItem(action_menu[i].id.menuItemName, action_menu[i].iconClass, action_menu[i].menuItemLabel, 'forwardToCognos', action_menu[i].sequence,action_menu[i].onclick+','+action_menu[i].param);
				} else if (action_menu[i].onclick == 'view_output') {
					this.addMenuItem(action_menu[i].id.menuItemName, action_menu[i].iconClass, action_menu[i].menuItemLabel, 'forwardToCognos', action_menu[i].sequence,action_menu[i].onclick+','+action_menu[i].param);
				} else {
					this.addMenuItem(action_menu[i].id.menuItemName, action_menu[i].iconClass, action_menu[i].menuItemLabel, 'none', action_menu[i].sequence,action_menu[i].param);
				}
			}
		}
		if(this.action_button_menus.length==0) {
				this.addMenuItem('helpRpt', icon_class_pre + 'helpRpt', 'Information about this report', 'helpReport', 1);
		}
		this.action_button_menus.sort(menuItemSort);
		if(this.action_button_menus.length>0){
			var e = window.event || arguments.callee.caller.arguments[0];
			this.openMenu(e);
		}
	}
	
	ActionButton.prototype.addMenuItem = function(menu_name,icon_class,menu_label,onclick,sequence,action_param){
		if (this.action_button_menus == null) {
			this.action_button_menus = new Array();
		}
		var menuItem = new ActionButtonMenu(this.name,this.type,this,menu_name,icon_class,menu_label,onclick,sequence,action_param);
		this.action_button_menus.push(menuItem);	
	}
	
	ActionButton.prototype.removeMenuItem = function(menu_id){
		if(this.action_button_menus != null && this.action_button_menus.length>0){
			for(var i=0;i<this.action_button_menus.length;i++){
				var menuitem = this.action_button_menus[i];
				if(menuitem.id==menu_id){
					this.action_button_menus.splice(i,1);
					return;
				}
			}
		}
	}

	ActionButton.prototype.toString = function() {
		var str_click = this.name+".getReport('"+this.report.report.domain_Key+"','"+this.report.report.rptObjID+"')";
		var str_openMenu = this.name+".getReport('"+this.report.report.domain_Key+"','"+this.report.report.rptObjID+"').action_button.openMenu(event);return false;";
		var str_button = "";
		
		str_button +='<p class="ibm-icononly" id="'+this.id+'" style="height:8px">';
		
		var rpt_type=this.getReportType();
		if (rpt_type == 'cognos') {
			if(this.isEnabledSchedule()==true){
				str_button +='<a id="'+this.id+'_schedule" class="ibm-popup-link" style="margin-bottom: 1px;margin-bottom: 1px;padding-bottom: 1px;padding-top: 1px;" href="#" title="Schedule report" onClick="'+str_click+'.forwardToCognos(null,\'schedule,none\');return false;">Schedule report</a>';
			}
		}
		if (rpt_type == 'links') {
			str_button +='<a class="ibm-external-link" style="margin-bottom: 1px;margin-bottom: 1px;padding-bottom: 1px;padding-top: 1px;" href="#" title="open links" onClick="'+str_click+'.openReport();return false;">open links</a>';
		}
		if (rpt_type == 'IR') {
			
			//if (this.report.report.subscribe == null || this.report.report.subscribe == false) {
				//str_button +='<a id="'+this.id+'_subscribeReport" class="ibm-attachment-link" style="margin-bottom: 1px;margin-bottom: 1px;padding-bottom: 1px;padding-top: 1px;" href="#" onClick="'+str_click+'.subscribeReport();return false;">subscribe report</a>';
			//}			
			str_button +='<a id="'+this.id+'_mailReport" class="ibm-email-link" style="margin-bottom: 1px;margin-bottom: 1px;padding-bottom: 1px;padding-top: 1px;" title="mail this report" href="#" onClick="'+str_click+'.mailReport();return false;">mail this report</a>';
			
		}
		if(this.type=='mr'){
			str_button +='<a id="'+this.id+'_removeFromMyFavorite" class="ibm-remove-link" style="margin-bottom: 1px;margin-bottom: 1px;padding-bottom: 1px;padding-top: 1px;" href="#" title="remove from my favorite" onClick="'+str_click+'.removeFromMyFavorite(\'none\');return false;">remove from my favorite</a>';				
		} else {
			if(this.report.report!=null&&this.report.report.favorite==false){
				str_button +='<a id="'+this.id+'_addToMyFavorite" class="ibm-add-link" style="margin-bottom: 1px;margin-bottom: 1px;padding-bottom: 1px;padding-top: 1px;" href="#" title="add to favorite" onClick="'+str_click+'.addToMyFavorite(\'none\');return false;">add to favorite</a>';				
			}
		}
		str_button +='<a class="ibm-forward-link" style="margin-bottom: 1px;margin-bottom: 1px;padding-bottom: 1px;padding-top: 1px;" href="#" title="more actions" onClick="'+str_openMenu+'">Open Menu</a>';
		str_button +='</p>';
		return str_button;
	}

	ActionButton.prototype.getReportType = function() {
		if (this.report.report.reportType == null) {
			alert('Error to get report type');
			return null;
		}
		return this.report.report.reportType.trim();
	}

	ActionButton.prototype.getReportClass = function() {
		if (this.report.report.objectClass == null) {
			return this.getReportType();
		}
		return this.report.report.objectClass;
	}
	
	ActionButton.prototype.isEnabledSchedule = function() {
		if(this.report.report.combobutton){
			if(this.report.report.combobutton.menuItems){
				for(var i=0;i<this.report.report.combobutton.menuItems.length;i++){
					if(this.report.report.combobutton.menuItems[i].onclick=='schedule'&&this.report.report.combobutton.menuItems[i].ctlCapability=='all'){
						return true;
					}
				}
			}
		}
		return false;
	}
	
	ActionButton.prototype.openMenu = function(event) {
		
		if(this.report.isAccessible()==false){
			alert('Sorry, You do not have access to this report.');
			return false;
		}
		
		var e = event || window.event;
		var x = e.pageX, y = e.pageY;
		var str_menu = '';
		var menutable_id = 'biprotal_drop_menu_div';
		if (this.action_button_menus == null||this.action_button_menus.length == 0) {
			if(this.initialMenu()==false){
				return false;
			}
			this.action_button_menus.sort(menuItemSort);
		}
		for(var i=0;i<this.action_button_menus.length;i++){
			str_menu += this.action_button_menus[i].toString();
		}
		if (jQuery("#" + menutable_id).length < 1) {
			str_menu = '<table id="'+menutable_id+'" class="dropdown_menu" onblur="" onClick="  jQuery(\'#' + menutable_id +'\').css({\'display\':\'none\'});       ">' + str_menu + '</table>';
			jQuery('body').append(str_menu);
			jQuery("#" + menutable_id ).css({"left":+x,"top":+y,"position": "absolute","display":"block"});
			jQuery("#" + menutable_id ).mouseleave(function(){jQuery("#" + menutable_id ).css({"display":"none"});});
		} else {
			jQuery("#" + menutable_id ).css({"left":+x,"top":+y,"position": "absolute","display":"block"});
			jQuery("#" + menutable_id ).html(str_menu);
		}
		
	}
	
	function ActionButtonMenu(name, type, action_button, menu_name, icon_class, menu_label, onclick, sequence,action_param) {
		this.name = name;
		this.type = type;
		this.action_button = action_button;
		this.menu_name = menu_name;
		this.id = action_button.id + "_" + menu_name + "_id";
		this.icon_class = icon_class;
		this.menu_label = menu_label;
		this.onclick = onclick;
		this.sequence = sequence;
		this.action_param = action_param;
	}
	
	ActionButtonMenu.prototype.toString = function() {
		//
		if (this.action_button.report.report.favorite == true) {
			if (this.icon_class.indexOf('_sel') < 0 && this.onclick=='addToMyFavorite') {
				this.icon_class = this.icon_class + '_sel';
				this.onclick = 'none';
			}
		}
		var str_menu = '';
		if(this.onclick==null||this.onclick=='none'){
			str_menu += '<tr id="' + this.id + '">';
		}else{
			if(this.action_param==null||this.action_param==''){
				str_menu += '<tr id="' + this.id + '" onClick="' + this.name + '.getReport(\''+this.action_button.report.report.domain_Key+'\',\''+this.action_button.report.report.rptObjID+'\').'+this.onclick+'(\''+this.id+'\');">';				
			}else{
				str_menu += '<tr id="' + this.id + '" onClick="' + this.name + '.getReport(\''+this.action_button.report.report.domain_Key+'\',\''+this.action_button.report.report.rptObjID+'\').'+this.onclick+'(\''+this.id+'\',\''+this.action_param+'\');">';	
			}
		}
		str_menu += '<td class="icon"><div class="' + this.icon_class + '"/></td>';   
		str_menu += '<td class="menu">' + this.menu_label + '</td>';   
		str_menu += '</tr>';
		return str_menu;
	}
	
	function menuItemSort(menuitem1, menuitem2) {
		return menuitem1.sequence - menuitem2.sequence;
	}
	
	function setCookie(name, value){
			cookie_path = " path=/;"
			document.cookie = name + '=' + value +';'+cookie_path
	}
	
	function centerWindow(width, height){
	    var startX = (window.screen.width - width) / 2;
	    var startY = (window.screen.height - height) / 2;
	    return ',ScreenX=' + startX + ',ScreenY=' + startY + ',top=' + startY + ',left=' + startX + ',width=' + width + ',height=' + height;
	}
	
	function encode(str) {
		var len = str.length;
		if (len == 0) {
			return '';
		}
		str = str.replace(/\%/g, "%25");
		str = str.replace(/\&/g, "%26");
		str = str.replace(/\?/g, "%3F");
		str = str.replace(/\#/g, "%23");
		str = str.replace(/\'/g, "%27");
		str = str.replace(/\"/g, "%22");
		str = str.replace(/\;/g, "%3B");
		str = str.replace(/\`/g, "%60");
		return str;
	}	
} catch (oException) {
	alert(oException);
}
