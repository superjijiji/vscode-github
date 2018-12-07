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
<title>My control books</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>
<script type="text/javascript" src="<%=path%>/javascript/bictrlbook.js"></script>

<script type="text/javascript">
    var selectedBICtrlbooks;
    var unSelectedBICtrlbooks;
    var biGeos = new BIgeos();
    var biBusinesses = new BIbusinesses();
    var cbIds_selected;
    var cbIds_un_selected;
    var selectedGeoVal = "all";
    var selectedBusinessVal = "all";

    jQuery(document).ready(function () {

        var cwa_id = '${requestScope.cwa_id}';
        var uid = '${requestScope.uid}';

        // Load Geography Select list
        jQuery("#selectGeography").empty();
        var timeid = (new Date()).valueOf();
        jQuery.ajax({
            type: 'GET', url: '<%=path%>/action/portal/controlbook/getGeoList/' + cwa_id + '/' + uid + "?timeid=" + timeid,
            success: function (data) {
                if (data.length > 0) {
                    var biGeo;
                    for (var i = 0; i < data.length; i++) {
                        biGeo = new BIgeo(data[i]);
                        biGeos.addGeo(biGeo);
                    }
                }
                jQuery("#selectGeography").append(biGeos.toString());
            }
        });

        // Load Business Select list
        jQuery("#selectBusiness").empty();
        var timeid = (new Date()).valueOf();
        jQuery.ajax({
            type: 'GET', url: '<%=path%>/action/portal/controlbook/getBusinessList/' + cwa_id + '/' + uid + "?timeid=" + timeid,
            success: function (data) {
                if (data.length > 0) {
                    var biBusiness;
                    for (var i = 0; i < data.length; i++) {
                        biBusiness = new BIbusiness(data[i]);
                        biBusinesses.addBusiness(biBusiness);
                    }
                }
                jQuery("#selectBusiness").append(biBusinesses.toString());
            }
        });
        // Refresh selected control book list
        function refreshSelected() {
            selectedBICtrlbooks = new BIctrlbooks();
            jQuery("#div_selected_cb_id").empty();
            jQuery("#div_selected_cb_id").append("<img id='myreportLoading' src='<%=path%>/images/ajax-loader.gif' />");

			var timeid = (new Date()).valueOf();
            jQuery.ajax({
                type: 'GET', url: '<%=path%>/action/portal/controlbook/getSelectedCBlist/' + cwa_id + '/' + uid + "?timeid=" + timeid,
                success: function (data) {
                	jQuery("#div_selected_cb_id").empty();
                    if (data.length > 0) {
                        var selectedBICtrlbook;
                        for (var i = 0; i < data.length; i++) {
                            selectedBICtrlbook = new BIctrlbook(data[i], 'cb_selected');
                            selectedBICtrlbooks.addCtrlbook(selectedBICtrlbook);
                        }
                    }
                    jQuery("#div_selected_cb_id").html(selectedBICtrlbooks.toString());
                    jQuery("[disabled='disabled']").attr("title", "This control book has been shared with you by the Control book Administrator and that you should apply to the contact in the Control book help to be removed if you no longer need access.");
                },
                error: function (data) {
                    jQuery("#div_selected_cb_id").empty();
                }
            });
        }

        jQuery("INPUT#removeCtrlbook").click(function () {
            checkboxChange('cb_selected');
            if (cbIds_selected == "" | typeof(cbIds_selected) == "undefined") {
                alert("Please choose at least one Control book to remove.");
                return;
            }
            jQuery("#removingcb").css("visibility", "visible");
            jQuery("input[type='button']").attr("disabled", true);
            var timeid = (new Date()).valueOf();
            jQuery.ajax({
                type: 'DELETE',
                url: '<%=path%>/action/portal/controlbook/removeCBUser/' + cwa_id + '/' + uid + '/' + cbIds_selected + "?timeid=" + timeid,
                success: function (data) {
                    jQuery("#removingcb").css("visibility", "hidden");
                    jQuery("input[type='button']").attr("disabled", false);
                    alert('Remove successfully.');
                    refreshBoth();
                },
                error: function (data) {
                    jQuery("#removingcb").css("visibility", "hidden");
                    jQuery("input[type='button']").attr("disabled", false);
                    alert('Remove failed.');
                }
            });

        });

        // Refresh unSelected control book list
        function refreshUnSelected() {
            unSelectedBICtrlbooks = new BIctrlbooks();
            jQuery("#div_un_selected_cb_id").empty();
            jQuery("#div_un_selected_cb_id").append("<img id='myreportLoading' src='<%=path%>/images/ajax-loader.gif' />");
            var timeid = (new Date()).valueOf();
            jQuery.ajax({
                type: 'GET',
                url: '<%=path%>/action/portal/controlbook/getUnSelectedCBlist/' + cwa_id + '/' + uid + '/' + selectedGeoVal + '/' + selectedBusinessVal + "?timeid=" + timeid,
                success: function (data) {
                	jQuery("#div_un_selected_cb_id").empty();
                    if (data.length > 0) {
                        var unSelectedBICtrlbook;
                        for (var i = 0; i < data.length; i++) {
                            unSelectedBICtrlbook = new BIctrlbook(data[i], 'cb_un_selected');
                            unSelectedBICtrlbooks.addCtrlbook(unSelectedBICtrlbook);
                        }
                    }
                    jQuery("#div_un_selected_cb_id").html(unSelectedBICtrlbooks.toString());
                },
                error: function (data) {
                    jQuery("#div_un_selected_cb_id").empty();
                }
            });
        }

        jQuery("INPUT#addCtrlbook").click(function () {
            checkboxChange('cb_un_selected');
            if (cbIds_un_selected == "" | typeof(cbIds_un_selected) == "undefined") {
                alert("Please choose at least one Control book to add.");
                return;
            }
            jQuery("#addingcb").css("visibility", "visible");
            jQuery("input[type='button']").attr("disabled", true);
            var timeid = (new Date()).valueOf();
            jQuery.ajax({
                type: 'GET',
                url: '<%=path%>/action/portal/controlbook/addCBUser/' + cwa_id + '/' + uid + '/' + cbIds_un_selected + "?timeid=" + timeid,
                success: function (data) {
                    jQuery("#addingcb").css("visibility", "hidden");
                    jQuery("input[type='button']").attr("disabled", false);
                    alert('Add successfully.');
                    refreshBoth();
                },
                error: function (data) {
                    jQuery("#addingcb").css("visibility", "hidden");
                    jQuery("input[type='button']").attr("disabled", false);
                    alert('Control book(s) is(are) added failed.');
                }
            });
        });


        function refreshBoth() {
            refreshSelected();
            refreshUnSelected();
        }


        jQuery("#selectGeography").change(function () {
            selectedGeoVal = jQuery(this).val();
            refreshUnSelected();
        });

        jQuery("#selectBusiness").change(function () {
            selectedBusinessVal = jQuery(this).val();
            refreshUnSelected();
        });

        refreshBoth();


    });


</script>

</head>
<body id="ibm-com" class="ibm-type" style="align: center">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>

	<div
		>
		<div
			>
			<div>
				<div style="float: left;">
					<h1 class="ibm-h1 ibm-light">&nbsp;&nbsp;&nbsp;My control books</h1>
				</div>
				<div>
					<p class="ibm-ind-link ibm-icononly ibm-inlinelink">
						<a class="ibm-information-link" target="_blank"
							href="<%=path%>/action/portal/pagehelp?pageKey=MyControlBookAddRemove&pageName=My+control+books"
							title="Help for My control books"> Help for My control books
						</a>
					</p>
				</div>
			</div>
		</div>

		<div style="width: 1024px; align: center; margin-left: auto; margin-right: auto;">
			<TABLE width="1024" border="0" role="presentation">
				<TBODY>
					<TR>
						<TD style="align: center" colspan="4"><strong
							style="font-size: 1.25em;"><br> Selected control
								books</strong></TD>
					</TR>
					<TR>
						<TD colspan="4"><br>The following control books have
							already been selected to appear in your <em>My reports</em> list.
							Click on the checkbox to remove any you no longer require and
							then press Remove.<br /> Please note that any control book that
							has been selected for you by the Control Book Administrator
							cannot be removed by this process. Please contact the support
							contact identified in the control book help document to request
							removal if you no longer have need of these reports.</TD>
					</TR>
					<TR>
						<TD colspan="4"><br>
							<div id="div_message_id"
								style="display: none; color: #4477BB; font-weight: bold;">This
								is message div</div></TD>
					</TR>
					<TR>
						<TD colspan="4">
							<div id="div_warning_id"
								style="display: none; color: #4477BB; font-weight: bold;">This
								is warning div</div> <br>
						</TD>
					</TR>

				</TBODY>
			</TABLE>

			<div id="div_selected_cb_id" style="width: 1024px;"></div>
			<br /> <SPAN class="button-blue"> <INPUT
				class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button"
				id="removeCtrlbook" value="Remove" aria-invalid="true">&nbsp;&nbsp;
				<span id="removingcb" style="visibility: hidden;"> <img
					src='<%=path%>/images/ajax-loader.gif' style="padding-bottom: 0px">
					&nbsp; The Control book(s) you selected is(are) being removed ...
			</span>
			</SPAN> <br /> <br /> <br />
			<TABLE border="0" width="1024" role="presentation">
				<TBODY>
					<TR>
						<TD colspan="2"><strong style="font-size: 1.25em;"><br>Add
								control books</strong></TD>
					</TR>
					<TR>
						<TD colspan="2"><br />Use the filters <span>bel</span>ow to
							limit the display of the available of the Control books. Please
							refer to the Control Book help for additional details and for
							information on how to gain access to the reports contained within
							your chosen portfolio. Click on the checkbox to select any
							Control Book you wish to appear in your <em>My Reports</em> list
							and then press <strong>Submit</strong>.<br /> <br /></TD>
					</TR>
					<TR>
						<TD colspan="2"></TD>
					</TR>


					<TR>
						<TD>Filter By Geography:
							<div id="divGeography">
								<SELECT name="geography" class="ibm-styled" id="selectGeography"
									title="geography" style="width: 300px;">

								</SELECT>
							</div>
						</TD>
						<TD>Filter By Business:
							<div id="divBusiness">
								<SELECT name="business" class="ibm-styled" id="selectBusiness"
									title="business" style="width: 300px;">

								</SELECT>
							</div>
						</TD>
					</TR>

				</TBODY>
			</TABLE>
			<div id="div_un_selected_cb_id" style="width: 1024px;"></div>
			<br> <SPAN class="button-blue"> <INPUT
				class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button"
				id="addCtrlbook" value="Add" aria-invalid="true">&nbsp;&nbsp;
				<span id="addingcb" style="visibility: hidden;"> <img
					src='<%=path%>/images/ajax-loader.gif' style="padding-bottom: 0px">
					&nbsp; The Control book(s) you selected is(are) being added ...
			</span>
			</SPAN> <br /> <br /> <br /> <br />
		</div>






	</div>

	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
</body>
</html>