<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="transform.edgeportal.bi.pojo.*" %>
<jsp:useBean id="tbscsSettings" class="transform.edgeportal.bi.pojo.TBSConfigSettings" scope="request" />

<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <title>BI@IBM | TBS configuration settings</title>
    <jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
    <style type="text/css">
    table.dataTable thead .sorting,
    table.dataTable thead .sorting_asc,
    table.dataTable thead .sorting_desc {
        background-repeat: no-repeat;
        background-position: center right
    }
    
    table.dataTable thead .selectallcolumn {
        background-repeat: no-repeat;
        background-position: 1000px;
        width: 1px;
    }
    
    table.dataTable thead .sorting {
        background: none
    }
    
    div#ibm-footer-module-links {
        width: 1200px;
    }
    </style>
</head>

<body id="ibm-com" class="ibm-type">
    <jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
    <div style="width: 88%; margin: auto;">
        <!-- =================== Loading div - START =================== -->
        <div id="csp_loading_id" style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 998; width: 100%; height: 100%; _padding: 0 20px 0 0; background: #f6f4f5; display: none;"></div>
        <div id="csp_ajax_loding_id" style="position: fixed; top: 0; left: 50%; z-index: 9999; opacity: 0; filter: alpha(opacity = 0); margin-left: -80px;">
            <div>
                <span>Loading TBS configuration settings ... </span><img src='<%=request.getContextPath()%>/images/ajax-loader.gif' />
            </div>
        </div>
        <!-- =================== Loading div - END =================== -->
        <div class="ibm-fluid" style="padding: 0px;">
            <br>
            <div id="domain_id" style="float: left;">
                <h1 class="ibm-h1 ibm-light" style="padding: 0px;">TBS configuration settings&nbsp;</h1>
            </div>
            <div class="tbs_list_page_title">
                <p class="ibm-ind-link ibm-icononly ibm-inlinelink" style="padding-bottom: 0px;">
                    <a class="ibm-information-link" target="_blank" href="<%=path%>/action/portal/pagehelp?pageKey=TBSConfigSettings&pageName=TBS+configuration+settings" title="Help for TBS configuration settings">
                        Help for TBS configuration settings </a>
                </p>
            </div>
        </div>
        <div data-widget="showhide" class="ibm-simple-show-hide" style="padding:0px;">
            <div class="ibm-container-body">
                <p class="ibm-show-hide-controls">
                    <a href="#show" class="">Show instructions</a> | <a href="#hide" class="ibm-active">Hide instructions</a>
                </p>
                <div class="ibm-hideable">
                    <p>BI@IBM provides four system configuration options to improve Trigger-Based Schedule operations:</p>
                    <ul class="ibm-bullet-list" style="list-style: inherit; padding-left: 30px; padding-top: 0;">
                        <li class="ibm-no-links" style="padding:0;">Report chaining - automated schedule creation for linked reports</li>
                        <li class="ibm-no-links" style="padding:0;">Off-peak execution - schedules will only be run outside periods of peak loading</li>
                        <li class="ibm-no-links" style="padding:0;">Suspended schedule requests - prompt selections must be updated before schedule will be run again</li>
                        <li class="ibm-no-links" style="padding:0;">Disabled schedule requests - underlying reports are being removed and the schedule request must be deleted</li>
                    </ul>
                    <p>Please refer to the respective page tabs for up-to-date information regarding the current configuration settings for these options.</p>
                </div>
            </div>
        </div>
        <div data-widget="dyntabs" class="ibm-graphic-tabs">
            <div class="ibm-tab-section">
                <ul class="ibm-tabs" role="tablist">
                    <li><a aria-selected="true" role="tab" href="#tbscs-tab1">Report Chaining</a></li>
                    <li><a role="tab" href="#tbscs-tab2">Off-peak</a></li>
                    <li><a role="tab" href="#tbscs-tab3">Suspended</a></li>
                    <li><a role="tab" href="#tbscs-tab4">Disabled</a></li>
                </ul>
            </div>
            <!-- Tab 1: Report Chaining -->
            <div id="tbscs-tab1" class="ibm-tabs-content">
                <p><strong>Report Chaining - automated schedule creation for linked reports</strong></p>
                <br>
                <p>The BI@IBM <strong>TBS Chaining</strong> function is designed to reduce the workload associated with the creation of Cognos Schedule Requests for linked reports. Whenever a CSR is created for one of the <em>parent</em> reports shown in the table below, a matching 'system generated' schedule request will be created for the corresponding <em>child</em> report. Changes to the execution parameters of the <em>parent</em> CSR will be mirrored in those of the <em>child</em> unless you set the latter to <strong>Inactive</strong> using the function provided in the My Cognos schedules panel.
                </p>
                <br>
                <p>The two reports will execute separately and will be delivered as two separate output files but these can be combined into a consolidated output using the BI@IBM Autodeck function if required.
                </p>
                <div class="ibm-rule">
                    <hr />
                </div>
                <table id="table_tbscs_tab1"  class="ibm-data-table ibm-altrows dataTable no-footer">
                    <thead>
                        <tr>
                            <th style="padding-top: 8px; padding-bottom: 8px; background-color: #ffffff;">Parent Report</th>
                            <th style="padding-top: 8px; padding-bottom: 8px; background-color: #ffffff;">Child Report</th>
                        </tr>
                    </thead>
                </table>
            </div>
            <!-- Tab 2: Off-peak -->
            <div id="tbscs-tab2" class="ibm-tabs-content">
                <p><strong>Off-peak Execution - schedules will only be run outside periods of peak loading</strong></p>
                <br>
                <p>As-part of the effort to maintain service levels for the delivery of BI@IBM Trigger-Based Schedules, all reports that are known to suffer performance problems during periods of high load will be set to run <em>Off-Peak</em> by the system administrator. All existing and any new schedule requests for such reports will be restricted to this priority setting and will only be run when system resources allow.
                </p>
                <br>
                <p>The current portfolio of reports that is restricted to Off-peak execution is:</p>
                <div class="ibm-rule">
                    <hr />
                </div>
                <table id="table_tbscs_tab2"  class="ibm-data-table ibm-altrows dataTable no-footer">
                    <thead>
                        <tr>
                            <th style="background-color: #ffffff;"></th>
                        </tr>
                    </thead>
                </table>
            </div>
            <!-- Tab 3: Suspended -->
            <div id="tbscs-tab3" class="ibm-tabs-content">
                <p><strong>Suspended schedule requests</strong></p>
                <br>
                <p>Schedule requests may be temporarily Suspended from TBS execution because of report design changes that require prompts to be re-selected. Once the prompts are updated, the Cognos Schedule Request may be set to Active again.
                </p>
                <br>
                <p>The following table shows all reports that still have asscociated CSRs in Suspended status:</p>
                <div class="ibm-rule">
                    <hr />
                </div>
                <table id="table_tbscs_tab3"  class="ibm-data-table ibm-altrows dataTable no-footer">
                    <thead>
                        <tr>
                            <th style="background-color: #ffffff;"></th>
                        </tr>
                    </thead>
                </table>
            </div>
            <!-- Tab 4: Disabled -->
            <div id="tbscs-tab4" class="ibm-tabs-content">
                <p><strong>Disabled schedule requests</strong></p>
                <br>
                <p>Cognos Schedule Requests may be set to Disabled status because the associated reports are no longer available on the system. All such CSRs must be removed by the users by using the <strong>Delete</strong> function available on the My Cognos schedules page.
                </p>
                <br>
                <p>The following table shows all reports that still have associated CSRs in Disabled status:</p>
                <div class="ibm-rule">
                    <hr />
                </div>
                <table id="table_tbscs_tab4"  class="ibm-data-table ibm-altrows dataTable no-footer">
                    <thead>
                        <tr>
                            <th style="background-color: #ffffff;"></th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
    <script type="text/javascript">
    var cwa_id = "${cwa_id}";
    var uid = "${uid}";
    var timeid;
    var table_content_tab1;
    var table_content_tab2;
    var table_content_tab3;
    var table_content_tab4;
    var chainRptList;
    var tbsOffPeakList;
    var tbsSuspendedList;
    var tbsDisabledList;
    var tbscsDtSettings_order = {
                info: true,             
                ordering: true,         
                paging: true,             
                searching: true, 
                stateSave: true,       
                lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']]
            };
    var tbscsDtSettings_no_order = {
                info: true,             
                ordering: false,         
                paging: true,             
                searching: true, 
                stateSave: true,       
                lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']]
            };
 
    function showLoading() {
        jQuery("#csp_loading_id").css({
            'display': 'block',
            'opacity': '0.8'
        });
        jQuery("#csp_ajax_loding_id").css({
            'display': 'block',
            'opacity': '0'
        });
        jQuery("#csp_ajax_loding_id").animate({
            'margin-top': '300px',
            'opacity': '1'
        }, 200);
    }

    function hiddLoading() {
        jQuery("#csp_loading_id").css({
            'display': 'none'
        });
        jQuery("#csp_ajax_loding_id").css({
            'display': 'none',
            'opacity': '0'
        });
    }


    function tbscs_refresh() {
        showLoading();
        table_content_tab1 = jQuery("#table_tbscs_tab1").DataTable(tbscsDtSettings_order);
        table_content_tab2 = jQuery("#table_tbscs_tab2").DataTable(tbscsDtSettings_no_order);
        table_content_tab3 = jQuery("#table_tbscs_tab3").DataTable(tbscsDtSettings_no_order);
        table_content_tab4 = jQuery("#table_tbscs_tab4").DataTable(tbscsDtSettings_no_order);
        timeid = (new Date()).valueOf();
        jQuery.ajax({
            type: 'GET',
            url: '<%=path%>/action/portal/tbsconfigsettings/service/' + cwa_id + '/' + uid + "?timeid=" + timeid,
            success: function(data) {
                if (data.errorMessage != null) {
                    alert(data.errorMessage);
                } else {

                    chainRptList = data.chainRptList;
                    tbsOffPeakList = data.tbsOffPeakList;
                    tbsSuspendedList = data.tbsSuspendedList;
                    tbsDisabledList = data.tbsDisabledList;

                    if (chainRptList.length > 0) {
                        for (var i = 0; i < chainRptList.length; i++) {
                            var input_col_0 = '<div style="padding-top: 8px; padding-bottom: 8px;">' + chainRptList[i][0] + '</div>';
                            var input_col_1 = '<div style="padding-top: 8px; padding-bottom: 8px;">' + chainRptList[i][1] + '</div>';
                            var dataSet = [input_col_0, input_col_1]
                            table_content_tab1.row.add(dataSet);
                        }
                        table_content_tab1.draw();
                    }

                    if (tbsOffPeakList.length > 0) {
                        for (var i = 0; i < tbsOffPeakList.length; i++) {
                            var input_col_0 = '<div style="padding-top: 8px; padding-bottom: 8px;">' + tbsOffPeakList[i] + '</div>';
                            var dataSet = [input_col_0]
                            table_content_tab2.row.add(dataSet);
                        }
                        table_content_tab2.draw();
                    }

                    if (tbsSuspendedList.length > 0) {
                        for (var i = 0; i < tbsSuspendedList.length; i++) {
                            var input_col_0 = '<div style="padding-top: 8px; padding-bottom: 8px;">' + tbsSuspendedList[i] + '</div>';
                            var dataSet = [input_col_0]
                            table_content_tab3.row.add(dataSet);
                        }
                        table_content_tab3.draw();
                    }

                    if (tbsDisabledList.length > 0) {
                        for (var i = 0; i < tbsDisabledList.length; i++) {
                            var input_col_0 = '<div style="padding-top: 8px; padding-bottom: 8px;">' + tbsDisabledList[i] + '</div>';
                            var dataSet = [input_col_0]
                            table_content_tab4.row.add(dataSet);
                        }
                        table_content_tab4.draw();
                    }
                }

                jQuery(".dataTables_length").css("margin", "0");
                jQuery(".dataTables_length").css("padding", "0");
                jQuery(".dataTables_filter").css("margin", "0");
                jQuery(".dataTables_filter").css("padding", "0");
                hiddLoading();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                hiddLoading();
                tbsPopupMessage("TBS configuration settings exception: " + textStatus + " - " + errorThrown);
            }
        });


    }

    // ========== popup message =============
    function tbsPopupMessage(message) {
        IBMCore.common.widget.overlay.hideAllOverlays();
        var myOverlay = IBMCore.common.widget.overlay.createOverlay({
            contentHtml: '<p>' + message + '</p>',
            classes: 'ibm-common-overlay ibm-overlay-alt'
        });
        myOverlay.init();
        myOverlay.show();
    }



    jQuery(document).ready(function() {
        tbscs_refresh();
    });
    </script>
</body>

</html>


