<!-- report search -->
<div id="div_report_search" class="ibm-card">
	<div class="ibm-card__content">
		<div class="ibm-rule ibm-alternate-1 ibm-blue-60"></div>
		<div style="float: left; padding-bottom: 9px;">
			<strong class="ibm-h4">Report search</strong>
		</div>
		<div id="reportsearch_loading_status" class="loading"
			style="float: right; cursor: pointer;" onClick="" title="Refresh"></div>
		<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
			<hr>
		</div>
		<p>To browse reports, select a Domain and click Show all. For more
			specific searches enter keywords in the Report name field and click
			Go</p>

		<form id="searchForm" class="ibm-row-form" method="post" action=""
			onsubmit="reportsearch_searchDomains();return false;" target="_blank">
			<input id="reportsearch_cwa_id" name="reportsearch_cwa_id"
				value='${requestScope.cwa_id}' type="hidden" /> <input
				id="reportsearch_uid" name="reportsearch_uid"
				value='${requestScope.uid}' type="hidden" /> <input
				id="reportsearch_function" name="reportsearch_function"
				value="search" type="hidden">
			<table>
				<tr>
					<td colspan="2" style="float: left;">Domain:
					<td>
				</tr>
				<tr>
					<td style="width: 100%; min-width: 120px; padding-right: 4px;">
						<select id="reportsearch_Domains" name="reportsearch_Domains"
						style="width: 100%; height: 32px;"
						onChange="reportsearch_enableShowAll(this);">
							<option value="loading">loading...</option>
					</select>
					</td>
					<td style="width: 85px;"><input
						style="min-width: 85px; width: 85px; padding-bottom: 5px; padding-top: 4px;"
						type="button" id="reportsearch_button_showall" disabled
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						onClick="reportsearch_showAll();return false;" value="Show all">
					</td>
				</tr>
				<tr>
					<td colspan="2" style="float: left;">Report Name:
					<td>
				</tr>
				<tr>
					<td style="width: 100%; min-width: 120px; padding-right: 4px;">
						<input type="text" value="" id="reportsearch_keywords"
						name="reportsearch_keywords"
						onkeyup="reportsearch_enableGo();return false;"
						style="width: 100%; height: 32px;" placeholder="keywords" />
					</td>
					<td style="width: 85px;"><input
						style="min-width: 85px; width: 85px;" type="button"
						class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50"
						id="reportsearch_button_go"
						onClick="reportsearch_searchDomains();return false;" value="Go">
					</td>
				</tr>
			</table>


			<p class="ibm-form-elem-grp">
				<label>Limit results (per domain) to:</label> <span
					class="ibm-input-group ibm-radio-group"> <input type="radio"
					name="reportsearch_page_row" value="20"
					id="reportsearch_page_row_radio1" title="20" checked> <label
					for="reportsearch_page_row_radio1">20</label>&nbsp; <input
					type="radio" name="reportsearch_page_row" value="50"
					id="reportsearch_page_row_radio2" title="50"> <label
					for="reportsearch_page_row_radio2">50</label>&nbsp; <input
					type="radio" name="reportsearch_page_row" value="100"
					id="reportsearch_page_row_radio3" title="100"> <label
					for="reportsearch_page_row_radio3">100</label>
				</span>
			</p>
			<p>
				<strong>My recent searches</strong><br>(click link to run
				search)
			</p>
			<ul id="search_history_ul_id" class="ibm-plain-list"
				style="padding-top: 1px; padding-right: 1px; padding-bottom: 1px; padding-left: 1px; line-height: 0.625rem;">
			</ul>
		</form>

		<script type="text/javascript">
			var reportsearch_domains;
			var reportsearch_domain_key;
			var reportsearch_histories;
			jQuery(document)
					.ready(
							function() {
								var cwa_id = document.getElementById("reportsearch_cwa_id").value;
								var uid = document.getElementById("reportsearch_uid").value;
								reportsearch_getDomains(cwa_id, uid);
								reportsearch_getSearchHistory(cwa_id, uid);
								jQuery('#reportsearch_Domains').next().width('100%');
								jQuery("#reportsearch_button_go").attr('disabled', true);
							}
					);
			//
			function reportsearch_refresh() {
				jQuery("#reportsearch_loading_status").attr('class','loading');
				jQuery("#reportsearch_loading_status").attr('onClick','');
				jQuery("#reportsearch_button_showall").attr('disabled', true);
				jQuery("#reportsearch_button_go").attr('disabled', true);
				jQuery("#reportsearch_keywords").val('');
				//
				var html_select = '<option value="loading">loading...</option>';
				jQuery("#reportsearch_Domains").html(html_select);
				jQuery("#search_history_ul_id").html('');
				var cwa_id = document.getElementById("reportsearch_cwa_id").value;
				var uid = document.getElementById("reportsearch_uid").value;
				reportsearch_getDomains(cwa_id, uid);
				reportsearch_getSearchHistory(cwa_id, uid);
			}
			//
			function reportsearch_getDomains(cwa_id, uid) {
				var timeid = (new Date()).valueOf();
				jQuery.ajax({
					type:'GET',url:'<%= request.getContextPath()%>/action/portal/search/getDomains/' + cwa_id + '/' + uid+'?timeid='+timeid,
					success : function(data) {
						reportsearch_domains = data;
						if(reportsearch_domains!=null&&reportsearch_domains.length>0){
							allDomains="";
							otherDomains="";
							for(var i=0;i<reportsearch_domains.length;i++){
								if(typeof reportsearch_domains[i].domainKey===undefined|| reportsearch_domains[i].domainKey==null){
									alert('System error, Can not get correct value.')
									return;
								}
								if(i>0){
									allDomains +="|";
								}
								allDomains +=reportsearch_domains[i].domainKey+","+reportsearch_domains[i].report_types;
								otherDomains +="<option value='"+reportsearch_domains[i].domainKey+","+reportsearch_domains[i].report_types+"'>"+reportsearch_domains[i].displayName+"</option>";
							}
							if (reportsearch_domains.length > 1) {
								otherDomains = "<option value='"+allDomains+"' selected=ture>All</option>" + otherDomains;
							} else if (reportsearch_domains.length == 1) {
								reportsearch_domain_key = reportsearch_domains[0].domainKey;
								if(reportsearch_domains[0].allreportsUrl!=null||reportsearch_domains[0].allreportsUrl!=''){
									jQuery("#reportsearch_button_showall").attr('disabled', false);
								}
							} else {
								reportsearch_domain_key='None';
								otherDomains = "<option value='None' selected=ture>None</option>"
							}
							jQuery("#reportsearch_Domains").html(otherDomains);
							jQuery("#reportsearch_loading_status").attr('class','refresh');
							jQuery("#reportsearch_loading_status").attr('onClick','reportsearch_refresh();');
						}else{
							jQuery("#reportsearch_Domains").html('<option value="loading">No Domain</option>');
							jQuery("#reportsearch_loading_status").attr('class','refresh');
							jQuery("#reportsearch_loading_status").attr('onClick','reportsearch_refresh();'); 														
						}
					},
					error : function(error){
						jQuery("#reportsearch_Domains").html('<option value="loading">Failed</option>');
						jQuery("#reportsearch_loading_status").attr('class','refresh');
						jQuery("#reportsearch_loading_status").attr('onClick','reportsearch_refresh();'); 												
					}
				});
			}

			function reportsearch_getSearchHistory(cwa_id, uid) {
				var timeid = (new Date()).valueOf();
				jQuery.ajax({					
					type:'GET',url:'<%= request.getContextPath()%>/action/portal/search/getSearchHistory/' + cwa_id + '/' + uid+'?timeid='+timeid,
					success : function(data) {
						reportsearch_histories=data;
						reportsearch_showHistory();
					}
				});
			}
			

			function reportsearch_showHistory() {
				if(reportsearch_histories==null){
					return;
				}
				var html = '';
				for (var i = 0; i < reportsearch_histories.length; i++) {
					var searchHistory = reportsearch_histories[i];
					if(typeof searchHistory.searchName===undefined||searchHistory.searchName==null){
						return;
					}
					html += '<li style="font-size:10px;width:100%;max-width:280px;">';
					html += '<a style="width:96%;white-space:nowrap;overflow:hidden;text-overflow:ellipsis; display:block;" name="" href="#" onClick="reportsearch_historySearch(\'' + searchHistory.url + '\'); return false;" target="_blank">';
					html += '> ' + searchHistory.searchName + '(' + searchHistory.domainName + ')';
					html += '</a>';
					html += '</li>';
				}
				jQuery("#search_history_ul_id").html(html);
			}
			
			function reportsearch_refreshHistory(history){
				if(reportsearch_histories==null){
					reportsearch_histories = new Array();
				}
				
				reportsearch_histories.unshift(history);
				
				if(reportsearch_histories.length>5){
					reportsearch_histories.pop();
				}
				
				reportsearch_showHistory();			
			}

			function reportsearch_saveSearchHistory(cwa_id, uid, keywords, domain_name, report_types, page_row) {
				var search_name = keywords;
				var domain_name = domain_name;
				var timeid = (new Date()).valueOf();
				var search_url = '';				
				search_url += 'function=search&cwaid=' + cwa_id + '&ReportSrchPortlet_ReportName=' + keywords + '&ReportSrchPortlet_LimitTo=' + page_row
						+ '&ReportSrchPortlet_ReportType=' + report_types + '&uid=' + uid;
				
				if(reportsearch_histories!=null){
					for (var i = 0; i < reportsearch_histories.length; i++) {
						var searchHistory = reportsearch_histories[i];
						if(searchHistory.url==search_url) return;
					}
				}
				
				var js_str='{"cwaId" : "'+cwa_id+'","uid" : "'+uid+'","searchName" : "'+search_name+'","domainName" : "'+domain_name+'","url" : "'+search_url+'"}';		
				var history = jQuery.parseJSON(js_str);
				var timeid = (new Date()).valueOf();		
				jQuery.ajax({
					type : "POST",
					url : '<%= request.getContextPath()%>/action/portal/search/saveSearchHistory?timeid='+timeid,
					async : true,
					data : JSON.stringify(history),
					contentType : "application/json",
					datatype : "json",// "xml", "html", "script", "json", "jsonp", "text".
					beforeSend : function() {
						
					},
					success : function(data) {
						reportsearch_refreshHistory(history);						
					},
					error : function(error) {
						alert('failed to add search history, error reason:' + error.responseText);
					}
				}

				);

			}

			function reportsearch_getDomain(domain_key) {
				if (reportsearch_domains != null && reportsearch_domains.length > 0) {
					for (var i = 0; i < reportsearch_domains.length; i++) {
						if (reportsearch_domains[i].domainKey == domain_key) {
							return reportsearch_domains[i];
						}
					}
				}
				return null;
			}

			function reportsearch_showAll() {
				domain = reportsearch_getDomain(reportsearch_domain_key);
				if (domain == null) {
					alert('Error, can not get domain:' + reportsearch_domain_key);
				} else {
					if (domain.allreportsUrl != null || domain.allreportsUrl != '') {
						windowWidth = screen.availWidth;
						windowHeight = screen.availHeight;
						style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0,width=" + windowWidth + ",height="
								+ windowHeight;
						window.open(domain.allreportsUrl, 'AllReportsPanel', style);
					} else {
						alert('Error, This Domain does not have All reports panel');
					}
				}
			}

			function reportsearch_historySearch(history_url) {
				var words = history_url.split('&');
				var cwa_id = '';
				var uid = '';
				var domain_keys = '';
				var keywords = '';
				var page_row = 20;
				var page = 1;
				for (var i = 0; i < words.length; i++) {
					if (words[i].indexOf('cwaid=') == 0) {
						cwa_id = words[i].substring(6);
					}
					if (words[i].indexOf('ReportSrchPortlet_ReportName=') == 0) {
						keywords = words[i].substring(29);
					}
					if (words[i].indexOf('ReportSrchPortlet_LimitTo=') == 0) {
						page_row = words[i].substring(26);
					}
					if (words[i].indexOf('ReportSrchPortlet_ReportType=') == 0) {
						domain_keys = unescape(words[i].substring(29));
					}
					if (words[i].indexOf('uid=') == 0) {
						uid = words[i].substring(4);
					}
				}
				var url = '<%=request.getContextPath()%>/action/portal/search/openSearchView/' + cwa_id + '/' + uid + '/' + domain_keys + '/' + keywords + '/' + page + '/' + page_row;
				windowWidth = screen.availWidth;
				windowHeight = screen.availHeight;
				style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0,width=" + windowWidth + ",height="+windowHeight;
				window.open(url,'SearchResultsPanel', style);				
			}

			function reportsearch_searchDomains() {
				var cwa_id=jQuery("#reportsearch_cwa_id").val();
				if(cwa_id==null||cwa_id==""){
					alert("Can not get user id");
					return false;
				}
				var uid=jQuery("#reportsearch_uid").val();
				if(uid==null||uid==""){
					alert("Can not get user id");
					return false;
				}
				var domain_keys=jQuery("#reportsearch_Domains").val();
				if(domain_keys==null||domain_keys==""){
					alert("Can not get searching domain");
					return false;
				}
				var keywords = jQuery.trim(jQuery("#reportsearch_keywords").val());
				if(keywords==null||keywords==""){
					alert("Please input keyword to search!");
					return false;
				}
				keywords = keywords.replace(/\//g, " ");
				keywords = keywords.replace(/\\/g, " ");
				var page=1;
				var page_row=jQuery('input[name="reportsearch_page_row"]:checked').val();
				if(page_row==null||page_row==""){
					alert("Can not get page row");
					return false;
				}
				var url = '<%=request.getContextPath()%>/action/portal/search/openSearchView/' + cwa_id + '/' + uid + '/' + domain_keys + '/' + keywords + '/' + page + '/' + page_row;
				windowWidth = screen.availWidth;
				windowHeight = screen.availHeight;
				style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0,width=" + windowWidth + ",height="+windowHeight;
				window.open(url,'SearchResultsPanel', style);
				var domain_name=jQuery("#reportsearch_Domains").find("option:selected").text(); 
				reportsearch_saveSearchHistory(cwa_id, uid, keywords, domain_name, domain_keys, page_row);
				
			}

			function reportsearch_findDomainKey(domains_rpt_types) {
				var strs = new Array();
				strs = domains_rpt_types.split(',');
				return strs[0];
			}

			function reportsearch_enableShowAll(select) {
				for (var i = 0; i < select.length; i++) {
					if (select.options[i].selected) {
						if (select.options[i].text == 'All') {
							jQuery("#reportsearch_button_showall").attr('disabled', true);
							reportsearch_domain_key = 'All';
						} else {
							reportsearch_domain_key = reportsearch_findDomainKey(select.value);
							domain = reportsearch_getDomain(reportsearch_domain_key);
							if (domain == null) {
								alert('Error, can not get domain:' + reportsearch_domain_key);
							} else {
								if (domain.allreportsUrl != null || domain.allreportsUrl != '') {
									jQuery("#reportsearch_button_showall").attr('disabled', false);
								} else {
									jQuery("#reportsearch_button_showall").attr('disabled', true);
								}
							}
						}
					}
				}
			}
			
			function reportsearch_enableGo(){
				var keywords = jQuery.trim(jQuery("#reportsearch_keywords").val());
				if(keywords==null||keywords==""){
					jQuery("#reportsearch_button_go").attr('disabled', true);
				}else{
					jQuery("#reportsearch_button_go").attr('disabled', false);
				}
			}
	 
		</script>
	</div>
</div>
<!-- report search -->