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
<title>All Reports (Report Library)</title>


<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<script type="text/javascript"
	src="<%=path%>/javascript/allreportsblob.js"></script>

<script type="text/javascript">
    var navigBars;
    var blobBIReports;
    var blobBIFolders;
 
   jQuery(document).ready(function () {
 
    var cwa_id = '${requestScope.cwa_id}';
    var uid = '${requestScope.uid}';
    var folder_id = '${requestScope.folder_id}';

        function refreshBar(folder_id) {
            navigBars = new NavigBars();
            var timeid = (new Date()).valueOf();
            jQuery("#allrpts_blob_list_div").empty();
            jQuery.ajax({
                type: 'GET', url: '<%=path%>/action/portal/allreports/getBlobNavigBar/' + cwa_id + '/' + uid + '/' + folder_id + '?timeid=' + timeid,async:false,
                success: function (data) {
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var navigBar = new NavigBar(data[i]);
                            navigBars.addBar(navigBar);
                        }
                    }
                    jQuery("#allrpts_blob_list_div").html(navigBars.toString());
                },
                error: function (data) {
                    alert('NavigBars - ajax return error!!!')
                }
            });
        }
 
        function refreshFolders(folder_id) {
             blobBIFolders = new Blobfolders();
             var timeid = (new Date()).valueOf();
             jQuery.ajax({
                type: 'GET', url: '<%=path%>/action/portal/allreports/getBlobFolders/' + cwa_id + '/' + uid + '/' + folder_id + '?timeid=' + timeid,async:false,
                success: function (data) {
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var allfld_blob_folder = new Blobfolder(data[i]);
                            blobBIFolders.addBlobfolder(allfld_blob_folder);
                        }
                    }
                },
                error: function (data) {
                    alert('blobBIFolders - ajax return error!!!')
                }
            });
        }

        function refreshReports(folder_id) {
            blobBIReports = new BIReports('blobBIReports', 'arblob');

            // all blob reports
            var timeid = (new Date()).valueOf();
            jQuery.ajax({
                type: 'GET', url: '<%=path%>/action/portal/allreports/getBlobReports/' + cwa_id + '/' + uid + '/' + folder_id + '?timeid=' + timeid,async:false,
                success: function (data) {
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var blobBIReport = new BIReport('blobBIReports', 'arblob', data[i]);
                            blobBIReports.addReport(blobBIReport);
                        }
                    }
                },
                error: function (data) {
                    alert('blobBIReports - all blob reports return error!!!')
                }
            });

            // all links reports
            var timeid = (new Date()).valueOf();
            jQuery.ajax({
                type: 'GET', url: '<%=path%>/action/portal/allreports/getLinksReports/' + cwa_id + '/' + uid + '/' + folder_id + '?timeid=' + timeid,async:false,
                success: function (data) {
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var blobBIReport = new BIReport('blobBIReports', 'arblob', data[i]);
                            blobBIReports.addReport(blobBIReport);
                        }
                    }
                },
                error: function (data) {
                    alert('blobBIReports - all links reports return error!!!')
                }
            });
        }
        
        function refreshAll(folder_id) {
            jQuery("#allrpts_blob_list_div").html("Loading...");
            var htmls = ''
            htmls += '<table width="1024" role="presentation" class="ibm-data-table ibm-padding-small ibm-altrows"  style="width: 100%; table-layout: fixed; -ms-word-wrap: break-word;" border="0" cellspacing="1" cellpadding="1" summary="Report actions">';
            htmls += '<tbody>';
            htmls += '<thead class="blobthead"><tr><th style="width:2%;" scope="col"></th><th style="width: 43%;" scope="col">Name</th><th style="width: 27%;" scope="col">Last Modified Time</th><th style="width: 28%;" scope="col">Action</th></tr></thead>';
 
            refreshBar(folder_id);
            htmls += navigBars.toString();

            refreshFolders(folder_id);
            htmls += blobBIFolders.toString();

            refreshReports(folder_id);
            htmls += blobBIReports.toString();

            htmls += '</tbody>';
            htmls += '</table>';
 
            jQuery("#allrpts_blob_list_div").html(htmls);

        }

        

        refreshAll(folder_id);

    });





</script>

</head>
<body id="ibm-com" class="ibm-type" style="height: 100%;">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>

	<div class="ibm-fluid" id="reportSearch_Results_div">


		<div
			style="width: 1024px; align: center; margin-left: auto; margin-right: auto;">
			<span style="font-size: 1.85em;"><strong
				style="font-size: 1em;">All Reports (Report Library)</strong></span><br>


			<table class="ibm-data-table ibm-padding-small ibm-altrows"
				width="100%" border="0" cellspacing="0" cellpadding="0"
				summary="Data table example">

			</table>
			<div id="allrpts_blob_list_div" style="margin: 2px 0 2px 0"></div>
		</div>

	</div>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>