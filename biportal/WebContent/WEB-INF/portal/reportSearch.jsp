<header role="presentation" aria-label="BI@IBM report search"
	id="header-search">
	<div class="ibm-alternate" id="ibm-leadspace-head"
		style="background: url(images/cognitive-bg-1600x900-2.jpg) no-repeat 0 center/cover #fff;">
		<div id="ibm-leadspace-body" class="ibm-alternate-background">
			<div class="ibm-columns">
				<div class="ibm-col-1-1 ibm-center">
					<h1 class="ibm-h1 ibm-padding-top-2" id="ibm-pagetitle-h1">BI@IBM
						Report Search</h1>
					<h2 class="ibm-space-small ibm-padding-top-1">To browse
						reports for more specific searches enter keywords in the Report
						name field and click Go</h2>
					<form id="searchForm" class="ibm-form" method="post" action=""
						target="_blank">
						<input name="cwa_id" value='${requestScope.cwa_id}' type="hidden" />
						<input name="uid" value='${requestScope.uid}' type="hidden" /> <input
							name="function" value="search" type="hidden" /> <input
							name="ReportSrchPortlet_LimitTo" value="20" type="hidden" /> <input
							name="ReportSrchPortlet_ReportType"
							value='"EOD,analytic,links|BACCPROD10,cognos|SWGCS,cognos|ARDE,IR|COGNOS10,cognos"'
							type="hidden" /> <input style="width: 40%" type="text"
							name="ReportSrchPortlet_ReportName" size="300" maxlength="300"
							value="" placeholder="Please input report name..." name="q"
							id="q" aria-label="Search" autocomplete="off" role="combobox"
							aria-autocomplete="list" aria-expanded="true"
							aria-owns="ibm-search-typeahead-container" /> <input
							class="ibm-btn-pri" type="submit" value="GO" />
					</form>
				</div>
			</div>
		</div>
	</div>
</header>