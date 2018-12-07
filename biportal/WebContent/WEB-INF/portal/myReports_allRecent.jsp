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
<title>All recent reports</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>

<script type="text/javascript">
    var myrcrpt_reports;
    jQuery(document).ready(function () {

        var cwa_id = '${requestScope.cwa_id}';
        var uid = '${requestScope.uid}';
		
        function recentRefresh() {
            myrcrpt_reports = new BIReports('myrcrpt_reports', 'rca');
            var timeid = (new Date()).valueOf();
            jQuery("#myrcrpt_list_div").empty();
            jQuery("#myrcrpt_list_div").append("<img id='myreportLoading' src='<%=path%>/images/ajax-loader.gif' />");
            jQuery.ajax({
                type: 'GET', url: '<%=path%>/action/portal/myrpts/getRecentRpts/' + cwa_id + '/' + uid + '?timeid=' + timeid,
                success: function (data) {
                	jQuery("#myrcrpt_list_div").empty();
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var myrcrpt_report = new BIReport('myrcrpt_reports', 'rca', data[i]);
                            myrcrpt_reports.addReport(myrcrpt_report);
                        }
                        myrcrpt_showReport(myrcrpt_reports);
                    }
                },
                error: function (data) {
                    jQuery("#myrcrpt_list_div").empty();
                }
            });
        }

        jQuery("#myreport_refresh_id").click(function () {
            recentRefresh();
        });


        function myrcrpt_showReport(myrcrpt_reports) {
            var html = "";
            html = myrcrpt_reports.toString();
            jQuery("#myrcrpt_list_div").html(html);
        }

        recentRefresh();
    });

</script>

</head>
<body id="ibm-com" class="ibm-type">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>

	<div class="ibm-fluid" id="reportSearch_Results_div">

		<div id="EOD_results" class="ibm-col-12-12">

			<div style="float: left;">
				<strong class="ibm-h4">All recent reports</strong>
			</div>
			<div style="float: right;">
				<a id="myreport_refresh_id" name="myreport_refresh_name"
					title="Refresh" style="cursor: pointer"> <img
					src="<%=path%>/images/refresh.gif" alt="refresh" />
				</a>
			</div>


			<table class="ibm-data-table ibm-padding-small ibm-altrows"
				width="100%" border="0" cellspacing="0" cellpadding="0"
				summary="Data table example">

			</table>
			<div id="myrcrpt_list_div" style="margin: 2px 0 2px 0"></div>
		</div>

	</div>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>