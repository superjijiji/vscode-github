
<% String path = request.getContextPath(); %>

<script type="text/javascript">

    var cwa_id = '${requestScope.cwa_id}';
    var uid = '${requestScope.uid}';
    var my_report_html = "";
    var myfavrpt_reports = new Array();
    var myfavrpt_reports_nofolder;

    // ============================================= My favorites ====================================================

    function folder_loadWithGroups() {
        jQuery("#favreport2show").empty();
        jQuery("#myfavrpt_list_div").empty();
        jQuery("#favreport2show").append("<img id='myreportLoading' src='<%=path%>/images/ajax-loader.gif' />");
        jQuery("#myfavrpt_list_div").append("<img id='myreportLoading' src='<%=path%>/images/ajax-loader.gif' />");
        var timeid = (new Date()).valueOf();
        jQuery.when(
                jQuery.get("<%=path%>/action/portal/tree/" + cwa_id + "/" + uid + "/myreport" + "?timeid=" + timeid),
                jQuery.get("<%=path%>/action/portal/myrpts/getMyfavRpts/" + cwa_id + "/" + uid + "?timeid=" + timeid)
                )
                .fail(function (jqXHR, textStatus, errorThrown) { //first failure 
                    jQuery("#myreportLoading").remove();
                    jQuery("#link_error2show").html("error(" + errorThrown + ") in loading ... " + link_myTime);
                    console.log("link_error4loading...jqXHR..." + JSON.stringify(jqXHR));
                    console.log("link_error4loading...textStatus..." + textStatus);
                    console.log("link_error4loading...errorThrown..." + errorThrown);
                })
                .done(function (a1, a2) {
                    jQuery("#favreport2show").empty();
                    jQuery("#myfavrpt_list_div").empty();
                    //--------------------------get returned data
                    var data = a2[0];
                    var data1 = data.slice(0);
                    var nodes = [];
                    var nodeTextStatus = a1[1];
                    var nodeJqXHR = a1[2];
                    var links = [];
                    var linkTextStatus = a2[1];
                    var linkJqXHR = a2[2];
                    //--------------------------checking returned status
                    if (nodeTextStatus === 'success') {
                        if (a1[0].content === undefined) {
                            nodes = [];
                        } else {
                            nodes = eval(a1[0].content); //convert the saved string into an array 
                        }
                    } else {
                        //jQuery("#link_error2show").html('ajax error...node...'+nodeTextStatus); 
                        return false;
                    }
                    if (linkTextStatus === 'success') {
                        links = a2[0];
                    } else {
                        //jQuery("#link_error2show").html('ajax error...link...'+linkTextStatus); 
                        return false;
                    }
                    //--------nodes
                    var flag = 0;
                    var folder = [];
                    var my_report = [];
                    var folder_report;
                    for (var i = 0; i < nodes.length; i++) {
                        switch (nodes[i].type) {
                            case "folder":
                                if (nodes[i].id != '#') {
                                    folder.push(nodes[i]);
                                }
                                break;
                            case "link":
                                my_report.push(nodes[i]);
                                break;
                            default:
                                console.log("link_error4loading...this node..." + JSON.stringify(nodes[i]));
                                break;
                        }
                    }

                    console.log(folder);
                    console.log(my_report);
                    var folder_id = '-1';
                    var folder_name = '';
                    myfavrpt_reports_nofolder = new BIReports('myfavrpt_reports_nofolder', 'mr');
                    var inFolder = false;
                    for (var i = 0; i < folder.length; i++) {
                        folder_id = folder[i].id;
                        folder_name = folder[i].text;
                        myfavrpt_reports[i] = new BIReports('myfavrpt_reports[' + i + ']', 'mr');
                        for (var j = 0; j < my_report.length; j++) {
                            if (folder_id == my_report[j].parent) {
                                if (data.length > 0) {
                                    for (var o = 0; o < data.length; o++) {
                                        var key1 = data[o].domain_Key + "-" + data[o].rptObjID;
                                        var key2 = my_report[j].reference;
                                        if (key1 == key2) {
                                            var myfavrpt_report = new BIReport('myfavrpt_reports[' + i + ']', 'mr', data[o]);
                                            myfavrpt_reports[i].addReport(myfavrpt_report);
                                            inFolder = true;
                                            data1.splice(o, 1, null);
                                        }
                                    }
                                }
                            }
                        }

                        if (inFolder) {
                            my_report_html = myfavrpt_reports[i].toString();
                            jQuery("#favreport2show").append("<h2 id='mr_folder_" + folder_id + "_h2'><strong>" + folder_name + "</strong></h2> <div id='Mr_folder_" + folder_id + "_div' class='ibm-container-body'> " + my_report_html + "</div>");
                            my_report_html = "";
                        }

                        inFolder = false;
                    }

                    jQuery("#favreport2show").showhide();
                    jQuery("a[data-folder='EOD-myfolde']").tooltip();
                    if (data.length > 0) {
                        for (var i = 0; i < data1.length; i++) {
                            if (data1[i] != null) {
                                var myfavrpt_report = new BIReport('myfavrpt_reports_nofolder', 'mr', data1[i]);
                                myfavrpt_reports_nofolder.addReport(myfavrpt_report);
                            }
                        }
                        myfav_showReport(myfavrpt_reports_nofolder);
                    }
                });
    }

    function myfav_showReport(myrfav_reports) {
        var html = "";
        html = myrfav_reports.toString();
        jQuery("#myfavrpt_list_div").html(html);
    }

    // ============================================ My recent reports ================================================

    function recentRefresh() {
        jQuery("#myrcrpt_list_div").empty();
        jQuery("#view_all_recent_id").css({"visibility":"hidden"});
        jQuery("#no_recent_rpt_info").css({"visibility":"hidden"});
        jQuery("#myrcrpt_list_div").append("<img src='<%=path%>/images/ajax-loader.gif' />");
        myrcrpt_reports = new BIReports('myrcrpt_reports', 'rc');
        var timeid = (new Date()).valueOf();
        jQuery.ajax({
            type: 'GET', url: '<%=path%>/action/portal/myrpts/getRecentRpts/' + cwa_id + '/' + uid + "?timeid=" + timeid,
            success: function (data) {
            	jQuery("#myrcrpt_list_div").empty();
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        var myrcrpt_report = new BIReport('myrcrpt_reports', 'rc', data[i]);
                        myrcrpt_reports.addReport(myrcrpt_report);
                    }
                    myrcrpt_showReport(myrcrpt_reports);
                    jQuery("#view_all_recent_id").css({"visibility":"visible"});
                    jQuery("#no_recent_rpt_info").css({"visibility":"hidden"});
                } else {
                	jQuery("#view_all_recent_id").css({"visibility":"hidden"});
                	jQuery("#no_recent_rpt_info").css({"visibility":"visible"});
                }
            }
        });
    }
 
	

    function myrcrpt_showReport(myrcrpt_reports) {
        var html = "";
        html = myrcrpt_reports.toString();
        jQuery("#myrcrpt_list_div").html(html);
    }

    function myreports_load_both() {
        folder_loadWithGroups();
        recentRefresh();
    }

    // ========================================= jQuery().ready =====================================================

    jQuery(document).ready(function () {

        jQuery("#myreport_refresh_id").click(function () {
            myreports_load_both();
        });

        jQuery("#view_all_recent_id").click(function () {

            var url = '<%=path%>/action/portal/myrpts/getAllRecentRpts/' + cwa_id + '/' + uid;
            windowWidth = screen.availWidth;
            windowHeight = screen.availHeight;
            style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0,width=" + windowWidth + ",height=" + windowHeight;
            window.open(url, "view_all_recent_reports", style);
        });

        jQuery("#fav_add_edit_folder_id").click(function () {
            var url = '<%=path%>/action/portal/tree/editFolders/myreport'
            windowWidth = screen.availWidth;
            windowHeight = screen.availHeight;
            style = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,ScreenX=0,ScreenY=0,top=0,left=0,width=" + windowWidth + ",height=" + windowHeight;
            window.open(url, "fav_add_edit_folder", style);
        });

        myreports_load_both();
    });

</script>

<div class="ibm-card">
	<div class="ibm-card__content" style="height: 100%;">
		<div class="ibm-rule ibm-alternate-1 ibm-blue-60"></div>
		<div style="float: left;">
			<strong class="ibm-h4">My reports</strong>
		</div>
		<div style="float: right;">
			<a id="myreport_refresh_id" name="myreport_refresh_name"
				title="Refresh" style="cursor: pointer"> <img
				src="<%=path%>/images/refresh.gif" alt="refresh" />
			</a>
		</div>

		<div id="rwd(responsivewebdesign)helpers" class="ibm-rule">
			<hr>
		</div>

		<div
			style="background: #FFFFFF; border: 1px solid #c7c7c7; padding: 8px 8px 8px;">
			<div id="bi_myrpt_recentrpt" style="float: top;">
				<strong class="ibm-h4" class="lotusHeading">My recent
					reports</strong>
				<div id="myrcrpt_list_div" style="margin: 2px 0 2px 0"></div>

			</div>
			<div align="left">
				<strong id="no_recent_rpt_info" style="visibility: hidden;">You
					currently have no recent reports.</strong>
			</div>
			<div align="right">
				<a id="view_all_recent_id" font="12px Arial" style="cursor: pointer">&gt;&nbsp;View
					all recent reports</a>
			</div>
			<div class="ibm-rule" style="margin: 7px 0 7px">
				<hr />
			</div>

			<div id="bi_myrpt_myfav">
				<strong class="ibm-h4" class="lotusHeading">My favorites</strong>
				<p id='link_root' class='ibm-ind-link'></p>
				<div id="myfavrpt_list_div" style="margin: 2px 0 2px 0"></div>
				<div id="favreport2show" data-widget="showhide" data-type="panel"
					class="ibm-show-hide"></div>
			</div>

			<div align="right">
				<a id="fav_add_edit_folder_id" font="12px Arial"
					style="cursor: pointer">&gt;&nbsp;Add/edit folders</a>
			</div>
		</div>


	</div>
</div>