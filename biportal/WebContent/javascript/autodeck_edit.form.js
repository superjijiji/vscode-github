var newOutputType="";


function openHelp(){
	 //var url = jQuery("#core_site_id").val()+"/help/helpIndex.jsp?page=pageHelp_cognosschedpanel.jsp";
	 var url = "/transform/biportal/action/portal/pagehelp?pageKey=MyAutodeckEdit&pageName=Autodeck+Edit+panel";
	// setCookie("reportName","Autodeck Edit Panel");
	 RIWin = window.open(url,"RptInfo","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=580,height=450,screenX=10,screenY=10");
	 RIWin.document.close();
}
Date.prototype.format = function(format) {
    var date = {
           "M+": this.getMonth() + 1,
           "d+": this.getDate(),
           "h+": this.getHours()
           
          
    };
    if (/(y+)/i.test(format)) {
           format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
           if (new RegExp("(" + k + ")").test(format)) {
                  format = format.replace(RegExp.$1, RegExp.$1.length == 1
                         ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
           }
    }
    return format;
}
function uploadListFormatDate(timestamp){
	var myNewDate = new Date();
	myNewDate.setTime(timestamp); 
	return myNewDate.getFullYear()+"-"+(myNewDate.getMonth()+1)+"-"+myNewDate.getDate(); 
}
function isIntheSelRequest(rid){
	var isIn=true;
	var myRequest=new Array();
	var myRequestID=new Array();
	jQuery('#selected_requests_id tbody tr').each(function () {
	    
    	var reportNameRowPos=1;
   
  var num=this.rowIndex-1
    	    var rid= jQuery("td:eq(8)",this).html();
  
  if(jQuery(rid).attr("href")!=undefined){
      requesid1=jQuery(rid).text();

     }
var rtype;
         var type_desc= jQuery("td:eq(9)",this).html();
if(type_desc='Cognos Schedule Request'){
rtype='1';
}else{
rtype='2';
}
var reqeust=new Object();
reqeust.id=rid;
reqeust.type=rtype;
myRequest[num]=reqeust;
myRequestID[num]=rid;


    	   });
	
	if(jQuery.inArray(rid,myRequestID)==-1){
		
		isIn=false;
	}
return isIn;	
}

function loadInitTemplates(){
	
	autodeckPanel.restoreConfig();                 

	autodeckPanel.setEdit=false;
	 autodeckPanel.setEditConfig();

	
	
}
function exportTemplate()
{	
	
	var convert_id=autodeckPanel.deck_id ;
    var outputtype=autodeckPanel.output_type;
    	
	var configurl = resturl + "/autodeck/exportconfig?deckid=" + convert_id+"&typeCD="+outputtype;
	javascript:window.open(configurl,'_blank','location=no,resizable=yes,toolbar=no,menubar=no,scrollbars=yes'+ getWindowSize());
} 
function getWindowSize()

{
windowWidth = screen.availWidth;
  windowHeight = screen.availHeight;
  
  return ",ScreenX=0,ScreenY=0,top=0,left=0,width=" + windowWidth/2 + ",height="+windowHeight/2;

}
function addToSelect(_a,convertId1,type){
	
	
	
	var table_1_content = jQuery("#selected_requests_id").DataTable();
	if(isIntheSelRequest(convertId1)){
		
		alert("This request already added!");
		return;
		
	}
	
		
		
		
		
	for (var i = 0; i < uploadedRequestsList.length; i++) {
		if(uploadedRequestsList[i].requestId == convertId1){
			
			
			var r_type="_2";
			var upload_col_0 = '';
				upload_col_0 += "<input id='adcreate_" + uploadedRequestsList[i].requestId + "_checkbox' requestID='" + uploadedRequestsList[i].requestId + "' r_type='_2'"+    " type='checkbox' name='request_checkbox' class='ibm-styled-checkbox adcreate_request_checkbox'>";
				upload_col_0 += "<label for='adcreate_" + uploadedRequestsList[i].requestId + "_checkbox'>";
				upload_col_0 += "<span class='ibm-access'>Select one</span>";
				upload_col_0 += "</input>";
				
			var upload_col_1 = "<a href=" + myTbsContext + "/action/portal/autodeck/xlsmanage/getXLSManagePage/"
							+ " target='_blank'>"
							+ uploadedRequestsList[i].fileName;
							+ "</a>";
			var upload_col_2 = uploadedRequestsList[i].fileDesc;
			var upload_col_3 = '';
			var upload_col_4 = '';
			var upload_col_5 = uploadListFormatDate(uploadedRequestsList[i].expirationDate);
			var upload_col_6 = '';
			var upload_col_7 = getRequestSatusMessage(uploadedRequestsList[i].status);
			var upload_col_8 = '';
			var upload_col_9 = uploadedRequestsList[i].requestId;
			var upload_col_10 = 'Uploaded file';
			var upload_col_11 = "N/A";
			var upload_col_12 = "N/A";
//	    0
			var dataSet = ['0', upload_col_1, upload_col_2, upload_col_3, upload_col_4, upload_col_5, upload_col_7, upload_col_8, upload_col_9, upload_col_10,upload_col_11,upload_col_12]
               table_1_content.row.add(dataSet).draw();
			
		
		}
		
	}
	
	for (var i = 0; i < selectedCSR.length; i++) {
		
		if(selectedCSR[i].requestId == convertId1){
			
			
			
			var input_col_0 = '';			
			var input_col_1 = "<a href=" + myTbsContext + "/action/portal/schedulePanel/openCognosSchedulePanel/"
							+ selectedCSR[i].requestId + "/" + selectedCSR[i].tbsDomainKey
							+ " target='_blank'>"
							+ selectedCSR[i].rptName;
							+ "</a>";				
			var input_col_2 = selectedCSR[i].emailSubject;
			var freq = selectedCSR[i].schedFreq;
    		var freqDtl = selectedCSR[i].freqDetail;

			var triggerType = selectedCSR[i].triggerType;
			if ((triggerType=='W') && (freq=='D'))
				freq='W';
			if ((triggerType=='D') && !(freq=='M'))
				freq='D';
			if (triggerType=='N')
				freq='N';

			var t = "";
			if (freq=='M') {
				t = "Monthly";
			}else if (freq == 'B') {
				t = "Business";
			}else if (freq == 'D') {
				t = "Daily";
			}else if (freq == 'W') {
				t = "Weekly";
				if (freqDtl == "M,Tu,W,Th,F,Sa,Su")
					freqDtl="";
				else{
					var flag=freqDtl.indexOf(',');
					if(flag >= 0)
						freqDtl =freqDtl.substring(0,flag);
				}
			}else if (freq=='N') {
				t = "NRT";
				freqDtl="";
			}

            var input_col_3 = t + "<br />" + freqDtl;
			
			
             //  var input_col_3 = selectedCSR[i].schedFreq;
               var input_col_4 = selectedCSR[i].dataMart;
               var input_col_5 = selectedCSR[i].expirationDate;
               var input_col_6 = selectedCSR[i].tbsDomainKey;
               
               if(selectedCSR[i].requestStatus!= undefined){
               	
               	input_col_0 += "<input id='adcreate_" + selectedCSR[i].requestId + "_checkbox' requestID='" + selectedCSR[i].requestId + "' r_type='_1'"+    " type='checkbox' name='request_checkbox' class='ibm-styled-checkbox adcreate_request_checkbox'>";
                   input_col_0 += "<label for='adcreate_" + selectedCSR[i].requestId + "_checkbox'>";
                   input_col_0 += "<span class='ibm-access'>Select one</span>";
                   input_col_0 += "</input>";
               	
               	var input_col_7 = getRequestSatusMessage(selectedCSR[i].requestStatus);
               	var input_col_8 =  selectedCSR[i].comments;
                   var input_col_9 = selectedCSR[i].requestId;
                   var input_col_10 = "Cognos schedule";
                   var tmp_lasttStatus=selectedCSR[i].lastStatus;
                   var lastStatusMsg="Unavailable"
                   	
                   	
                   	
                   	
                   if(tmp_lasttStatus=='100'||tmp_lasttStatus=='101'){
                   	lastStatusMsg="Ready";
                   	input_col_9="<a href=" + myTbsContext + "/action/portal/tbsoutputs/downLoadTBSOutput/"
          			+ cwa_id+ "/" + uid+"/"+ selectedCSR[i].requestId  +"/"+selectedCSR[i].requestId +" target='_blank' >"+selectedCSR[i].requestId  +"</a>";	
                    	
                	
                   }
//                   else if(tmp_lasttStatus=='300'){
//                   	
//                   	lastStatusMsg="Running";
//                   	
//                   	
//                   }else if(tmp_lasttStatus=='200'||tmp_lasttStatus=='400'){
//                   	lastStatusMsg="Failed";
//                   }
                   
                   var input_col_11=lastStatusMsg;
                   //“Last Ready Time
                   var input_col_12=ToDate(selectedCSR[i].readyTime);

                   r_type="_1";
               }
               
               var dataSet = ['0', input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_7, input_col_8, input_col_9, input_col_10,input_col_11,input_col_12]
               table_1_content.row.add(dataSet).draw();
              
               
               //selectedRequestsNew += selectedCSRTable1[i].requestId + r_type + '_' + count;
               //selectedRequestsNew += ',';
               
		}
		
	}
	

		

}
function openDeckScheduleRequests(){
	if(autodeckPanel.autodeck.convertStatus=='A') {
		var deckid=autodeckPanel.deck_id;
		openRDP('/transform/biportal/action/portal/autodeck/autodeckTBSStatus/'+deckid);
		return false;
		} else{
			alert('TBS Autodeck inputs status is only available for Active Autodecks');
			return false;}
	
	
	
	
	
}


function controlTemplateByType(outPutValue)
{
   


		
		if (outPutValue=='2'){
//alert('ppt');
document.getElementById('div_template').style.display="";
//document.getElementById('div_pastetype').style.display="";
document.getElementById('div_outline').style.display="";

}else if ((outPutValue=='1')||(outPutValue=='3')){
document.getElementById('div_template').style.display="none";
//document.getElementById('div_pastetype').style.display="none";
document.getElementById('div_outline').style.display="none";
//alert('xls');
}
		
;
}
function displaySchedule(){
//acording to the input display or hide tr	
	var provisinal=jQuery('#is_provisional').select2().val();
	
	if(provisinal=='N'){
	//hide	
		document.getElementById('tr_id_schedule_fre').style.display="none";
		//document.getElementById('div_pastetype').style.display="";
		document.getElementById('tr_id_timezone').style.display="none";	
		
	}else{
	//display	
	//tr_id_schedule_fre	
	//tr_id_timezone
		document.getElementById('tr_id_schedule_fre').style.display="";
		//document.getElementById('div_pastetype').style.display="";
		document.getElementById('tr_id_timezone').style.display="";
		
	}
}
function displayTemplate(src)
{
    if ( src==null )
    {
        alert('error occured loading data');
        return -1;
    }

var outPutValue="";
	var srcRadio  = null;

	if ( src.type=='RADIO' || src.type=='radio' ) {
		srcRadio = src;
		 outPutValue=srcRadio.value;
		 var temstr1="";
		 var temstr2="";
		 if(newOutputType==""){
		 
		 newOutputType=autodeckPanel.output_type;
		 }
		 
		 if(newOutputType==2){
		temstr1="powerpoint";
		temstr2="excel";
		 } else{
		 temstr1="excel";
		 	temstr2="powerpoint";
		 } 
		if(newOutputType!=outPutValue){
		var linkStr=newOutputType+outPutValue;
		if((linkStr=='13')||(linkStr=='31')||(linkStr==4)){
		  //do nothing since xls to xlsx or reversing,we do not change anything just value so far.
		  }else{
		alert("The output type has been changed since your last submission.The current configuration template for "+temstr1+" will be removed,and the new default configuration template for "+temstr2+" will be regenerated for you after you resubmit. ");
		}
		}
		
		
		
		if (outPutValue=='2'){
//alert('ppt');
document.getElementById('div_template').style.display="";
//document.getElementById('div_pastetype').style.display="";
document.getElementById('div_outline').style.display="";

}else if ((outPutValue=='1')||(outPutValue=='3')){
document.getElementById('div_template').style.display="none";
//document.getElementById('div_pastetype').style.display="none";
document.getElementById('div_outline').style.display="none";
//alert('xls');
}else{
 alert('error occured loading data');
        return -1;


}
		
	} 
	//setMaxExpDate(srcRadio);
}


//IC4.3 radio show js function or not 
function checkLinkOrAttachment(src)
{
  if ( src==null )
  {
      //alert('error occured loading data');
      return -1;
  }

	var outPutValue="";
	var srcRadio  = null;

	if ( src.type=='RADIO' || src.type=='radio' ) {
		srcRadio = src;
		outPutValue=srcRadio.value;

		if (outPutValue=='LINK'){
			
			document.getElementById('div_zipoutput').style.display="none";
		}else if (outPutValue=='ATTACHMENT'){
		    
			document.getElementById('div_zipoutput').style.display="";
		} else {
			alert('error occured for generated file as 1');
		}
	} 
}
function controlZipByLinkOrAttachment(sendOption){

	var outPutValue=sendOption;


	

		if (outPutValue=='LINK'){
			
			document.getElementById('div_zipoutput').style.display="none";
		}else if (outPutValue=='ATTACHMENT'){
		    
			document.getElementById('div_zipoutput').style.display="";
		} else {
			alert('error occured for generated file as 2');
		}
	 
}


function checkIfAppandDate(src)
{
  if ( src==null )
  {
      //alert('error occured loading data');
      return -1;
  }

	var outPutValue="";
	var srcRadio  = null;

	if ( src.type=='RADIO' || src.type=='radio' ) {
		srcRadio = src;
		outPutValue=srcRadio.value;

		if (outPutValue=='N'){
			
			document.getElementById('div_appanddate').style.display="none";
		}else if (outPutValue=='Y'){
		    
			document.getElementById('div_appanddate').style.display="";
		} else {
			alert('error occured for generated file as 3');
		}
	} 
}
function controlAppandDateBy(ifAppend)
{
	var outPutValue=ifAppend;
  

	

		if (outPutValue=='N'){
			
			document.getElementById('div_appanddate').style.display="none";
		}else {
		    
			document.getElementById('div_appanddate').style.display="";
		} 
	 
}
function openRDP(url){
	window.open(url,'_blank','resizable=yes,toolbar=no,menubar=no,scrollbars=yes'+",ScreenX=0,ScreenY=0,top=0,left=0,width=" + screen.availWidth + ",height="+screen.availHeight);
		
	}