
<h2>
	<strong>Click the 'Add' operation link to select your desired
		inputs from the lists of content available to you on each of the tabs.
	</strong>
</h2>



<div class="ibm-rule">
	<hr>
</div>


<!-- Tabs here: -->
<div id="autodeck_tab_id" data-widget="dyntabs" class="ibm-graphic-tabs">
	<div class="ibm-tab-section">
		<ul class="ibm-tabs" role="tablist">
			<li><a aria-selected="true" role="tab"
				href="#tab_request_cognos">Cognos schedule request</a></li>
			<li><a role="tab" href="#tab_request_upload">Uploaded files</a></li>

		</ul>
	</div>

	<!-- prompts tab content -->
	<div id="tab_request_cognos" class="ibm-tabs-content">

		<div id='select-display'>
			<p class="ibm-show-hide-controls">
				<a href="#" onclick="javascript:displayAllRequest()">All
					requests</a> | <a href="#" onclick="javascript:displayOwn()">Owned
					by me</a> | <a class="ibm-active" onclick="javascript:displayOther()"
					href="#">Owned by others</a>

			</p>
		</div>
		<div id='tabtext'>
			<span id='tabspantext'>All requests</span>
		</div>
		<div id='tabtext1'>
			<span id='tabspantext1'></span>
		</div>



		<table id="table_2" data-widget="datatable" data-info="false"
			data-ordering="true" data-paging="false" data-searching="true"
			class="ibm-data-table ibm-altrows dataTable no-footer"
			data-order='[[1,"asc"]]'>
			<thead>
				<tr>
					<th>Report Name</th>
					<th>e-Mail Subject</th>
					<th>Frequency</th>
					<th>Datamart/Data Load</th>
					<th>Expiration Date</th>
					<th>Domain Key</th>
					<th>Status</th>
					<th>Comments</th>
					<th>Operation</th>
				</tr>
			</thead>
			<tbody id='tbody_table_2'></tbody>
		</table>


	</div>

	<!-- output format tab content -->
	<div id="tab_request_upload" class="ibm-tabs-content">
		<table id="table_3" data-widget="datatable" data-info="false"
			data-ordering="true" data-paging="false" data-searching="true"
			class="ibm-data-table ibm-altrows dataTable no-footer"
			data-order='[[1,"asc"]]'>
			<thead>
				<tr>
					<th>File Name</th>
					<th>File Desciption</th>
					<th>Expiration Date</th>
					<th>Status</th>
					<th>Operation</th>
				</tr>
			</thead>
			<tbody id='tbody_table_3'></tbody>
		</table>

	</div>
	<!-- Tabs contents divs: -->
</div>