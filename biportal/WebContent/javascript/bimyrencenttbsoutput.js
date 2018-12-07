try {

	/*
	 * BIMyTBSoutputs
	 */
	function BIMyTBSoutputs() {
		this.myTBSoutputs = null;
	}
	
	/*
	 * BIMyTBSoutput
	 */
	
	function BIMyTBSoutput(data) {
		this.running_id = data.running_id;
		this.rpt_name = data.rpt_name;
		this.e_mail_subject = data.e_mail_subject;
		this.datamart = data.datamart;
		this.comments = data.comments;
		if(null == data.run_time){
			this.run_time = "";
		}else{
			this.run_time = data.run_time;
		}
		
		this.domain_key = data.domain_key;
		this.cwa_id = data.cwa_id;
		this.sched_freq = data.sched_freq;
		if("D" == data.sched_freq){
			this.sched_freq = "Daily";
		}else if ("M" == data.sched_freq){
			this.sched_freq = "Monthly";
		}else if ("B" == data.sched_freq){
			this.sched_freq = "Business";
		}else if ("W" == data.sched_freq){
			this.sched_freq = "Weekly";
		}else if ("N" == data.sched_freq){
			this.sched_freq = "NRT";
		}else  {
			this.sched_freq = data.sched_freq;
		}	
		if(null == this.running_id || "" == this.running_id){
     		this.dl_link = 'Not Available';
     	}else{
     		this.dl_link = '<a id="downloadThisReport" font="12px Arial" onClick="downLoadSignleTBSOutput(\''+this.running_id+'\');return false;" href="#" style="cursor: pointer"  name="downloadThisReport">Download</a>';
     	}
	}
	
//	BIMyTBSoutputs.prototype.addoutput = function(output) {
//		if (this.myTBSoutputs == null) {
//			this.myTBSoutputs = new Array();
//		}
//		this.myTBSoutputs.push(output);
//	}

	
//	BIMyTBSoutputs.prototype.toString = function() {
//		
//		var tables = "";
//		tables += '<table name="myrecenttbsoutputs" id="myrecenttbsoutputs" data-tablerowselector="enable"  class="ibm-data-table">';
//		tables += '<thead><TR>';
//		tables += ' <th scope="col">';
//		tables += '<span class="ibm-checkbox-wrapper">';
//		tables += '<input id="allcheckID" type="checkbox" class="ibm-styled-checkbox"/>';
//		tables += '<label for="allcheckID"><span class="ibm-access">Select row</span></label>';
//		tables += '</span>';
//		tables += '</th>';
//		
//		tables += '<th scope="col">Report Name</th>';
//		tables += '<th scope="col">e-Mail Subject</th>';
//		tables += '<th scope="col">Frequency</th>';
//		tables += '<th scope="col">Datamart / Data Load</th>';
//		tables += '<th scope="col">Comments</th>';
//		tables += '<th scope="col">Last Run Date</th>';
//		tables += '<th scope="col">Domain</th>';
//		tables += '<th scope="col">Owner</th>';
//		tables += '<th scope="col">Action</th>';
//		
//		tables += '</TR></thead>';
//		tables += '<TBODY>';
//		if (this.myTBSoutputs == null || this.myTBSoutputs.length == 0) {
//			 tables += '<tr> You do not have any Cognos report schedules. </tr>';
//			 
//		} else{
//			for (var int = 0; int < this.myTBSoutputs.length; int++) {
//				
//				tables += this.myTBSoutputs[int].toString(int);
//			}
//		}
//		
//		tables += '</TBODY></TABLE>';
//		return tables;
//	}

	



//		BIMyTBSoutput.prototype.toString = function(int) {
//		var str = "";
//		str += '<tr>';
//		str += '<td scope="row">';
//		str += '<span class="ibm-checkbox-wrapper">';
//		str += '<input id="checkbox_'+int+'" type="checkbox" class="ibm-styled-checkbox" value="'+this.running_id+'"/>';
//		str += '<label for="checkbox_'+int+'"><span class="ibm-access">Select row</span></label>';
//		str += '</span>';
//		str += '</td>';
//		str += '<TD>' + this.rpt_name + '</TD>'
//		str += '<TD>' + this.e_mail_subject + '</TD>'
//		str += '<TD>' + this.sched_freq + '</TD>'	
//		str += '<TD>' + this.datamart + '</TD>';
//		str += '<TD>' + this.comments + '</TD>';
//		str += '<TD>' + this.run_time + '</TD>';
//		str += '<TD>' + this.domain_key + '</TD>';
//		str += '<TD>' + this.cwa_id + '</TD>';
//     	if(null == this.running_id || "" == this.running_id){
//     		str += '<TD>Not Available </TD>';
//     	}else{
//     		var running_id ="'"+ this.running_id+"'";
//     		str += '<TD><a id="downloadThisReport" font="12px Arial" onClick="downLoadSignleTBSOutput('+running_id+');return false;" href="#" style="cursor: pointer"  name="downloadThisReport">Download</a></TD>';
//     	}
//     	
//		str += '</TR>';
//
//		return str;
//	}
	
} catch (oException) {
	alert(oException);
}