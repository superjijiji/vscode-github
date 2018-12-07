

//get reqeust data

var userRequestsNotReadyList=new Array();
var userRequestsReadyList=new Array();
function addNotReadyList(){
var requestRows=jQuery('#selected_requests_id tr');

   jQuery.each(requestRows, function(index, item) {
   	var checkboxEl= jQuery("input[type=checkbox]",item);
   	console.log(checkboxEl[0]);
var isChecked=jQuery(checkboxEl[0]).prop('checked');
 if(isChecked){

var output_status= jQuery("td:eq(10)",item).html();
if(output_status=='Ready'){


    	var reportNameRowPos=1;
   
  var num=item.rowIndex-1
    	    var rid= jQuery("td:eq(8)",item).html();
  if(jQuery(rid).attr("href")!=undefined){
	  rid=jQuery(rid).text();

     }
    	    
    	    
//var rtype;
  //       var type_desc= jQuery("td:eq(9)",item).html();



           var output_status= jQuery("td:eq(10)",item).html();
//if(type_desc='Cognos Schedule Request'){
//rtype='1';
//}else{
//rtype='2';
//}


var output_status= jQuery("td:eq(10)",item).html("Not Ready");
userRequestsNotReadyList.push(rid);
if(jQuery.inArray(rid,userRequestsReadyList)!=-1){

	userRequestsReadyList.splice(jQuery.inArray(rid,userRequestsReadyList),1);
}
console.log("after:")
console.log("ready"+userRequestsReadyList);
console.log("not ready:"+userRequestsNotReadyList);      
}else{
	if(output_status=='Not Ready'){
		

    	var reportNameRowPos=1;
   
  var num=item.rowIndex-1
    	    var rid= jQuery("td:eq(8)",item).html();

    	    
    	    
//var rtype;
  //       var type_desc= jQuery("td:eq(9)",item).html();



           var output_status= jQuery("td:eq(10)",item).html();
//if(type_desc='Cognos Schedule Request'){
//rtype='1';
//}else{
//rtype='2';
//}


var output_status= jQuery("td:eq(10)",item).html("Ready");
userRequestsReadyList.push(rid);
if(jQuery.inArray(rid,userRequestsNotReadyList)!=-1){

	userRequestsNotReadyList.splice(jQuery.inArray(rid,userRequestsNotReadyList),1);
}		
		
		
	}
	
}
}
        });
}







function saveDeck(){
var output_type=autodeckPanel.output_type;
var formdata=new Object();
var deckid1=autodeckPanel.deck_id ;
var cwaid1=autodeckPanel.owner;
formdata.cwaid=cwaid1;
formdata.deckid=deckid1;



var myRequest=new Array();
var myRequestID=new Array();
var isAnyD=false;
jQuery('#selected_requests_id tbody tr').each(function () {
	    
	    	var reportNameRowPos=1;
       
      var num=this.rowIndex-1
	    	    var rid= jQuery("td:eq(8)",this).html();
      if(jQuery(rid).attr("href")!=undefined){
    	  rid=jQuery(rid).text();


         }
      
      
  var rtype;
             var type_desc= jQuery("td:eq(9)",this).html();
  if(type_desc=='Cognos schedule'){
    rtype='1';
  }else{
    rtype='2';
  }
  var reqeust=new Object();
  reqeust.id=rid;
  reqeust.type=rtype;
  myRequest[num]=reqeust;
  myRequestID[num]=rid;
  var reportStatus = jQuery("td:eq(6)",this).html();;
  
  if(reportStatus=='Disabled'){

 alert('Request ID is ' +rid+' is not a valid request; its status is Disabled. Please remove it before submitting.');
 jQuery("td:eq(8)",this).css({ color: "red" });
 isAnyD=true;
  }
 
	    	   });
if(isAnyD){
	
	return false;
	
}
//myRequest[0].id='201401270632350005490329016231672';
//myRequest[0].type='2';
formdata.requests=myRequest;
if(myRequest.length==0){
alert('Please select at least one request.');

return false;
}

if(myRequest.length==1){
	if(myRequest[0].id==undefined){
	alert('Please select at least one request.');
	//TODO
	return false;
	}
	}
//get template;
var div_template=jQuery('#div_template');

var  radioboxtmp2=jQuery('input[type=radio]',div_template);
var  radioboxtmp3=jQuery('input[type=radio]',jQuery('#div_pastetype'));


//get output info
var filename1=jQuery.trim(jQuery('#deck_name_id').val());

if(filename1==''){
alert('Please provide the requested file name.');

return false;
}
if(filename1.length>33){
alert('Please input file name no more than 33 characters.');

return false;
}
var reg1 = /^((\w)+( )*)*$/;
if(!reg1.test(filename1)){
alert('Please input the correct format for the file name,like output_1');
return false;
}

formdata.filename=filename1;

var choosetype="";
choosetype=jQuery("input[name='radiogrptype']:checked").val();
formdata.filetype=choosetype;


var sendoption=jQuery("input[name='sendoption']:checked").val();
formdata.sendoption=sendoption;
//IC4.3 AutoDeck zip begian get zip radio value
//var  radioboxzipoutput=dojo.query('input[name=zipoutput]');
var zipoutput=jQuery("input[name='zipoutput']:checked").val();

formdata.zipoutput=zipoutput;
//IC4.3 end
//R9.1 AutoDeck appand date


var isAppendDate="N";

isAppendDate=jQuery("input[name='appandDate']:checked").val();





var appanddate="";
if(isAppendDate=='N'){
appanddate=isAppendDate;
}else{
	appanddate=jQuery("input[name='dateType']:checked").val();
}
if(appanddate==''){

alert("Please select one of  the date format if you want to appand date to the output.");
return ;
}
formdata.appanddate=appanddate;
//R9.1 end
//add by leo


var weekNo=jQuery("input[name='final_weekly']:checked").val();;

formdata.final_weekly=weekNo;

var final_deck_time=jQuery('#final_deck_time_id').select2().val();;
formdata.final_deck_time=final_deck_time;

if(choosetype==''){

alert('Please choose a format for the output file type.');
return false;
}
var template_cd="-1";
var paste_type_cd="-1";
if(choosetype=='2'){
//template_cd
template_cd=jQuery("input[name='template_cd']:checked").val();

if(template_cd==undefined){
alert('Please choose one template for the ppt output.');
return false;
}


//paste_type_cd=jQuery("input[name='pasteType']:checked").val();;
paste_type_cd=1;
//2018.01 only enhance image
//if(paste_type_cd==undefined){
//alert('Please choose one paste type for the ppt output.');
//return false;
//}



}
formdata.template_cd=template_cd;
formdata.paste_type_cd=paste_type_cd;




var email=jQuery.trim(jQuery('#autodeck_textarea_e_mail_address_id').val());
var comments=jQuery.trim(jQuery('#autodeck_email_comments_id').val());

var subject=jQuery.trim(jQuery('#autodeck_text_e_mail_subject_id').val());
if (email==''){
alert('Please add at least one e-Mail address.');
return false;
}
if(email.length>240){
alert("The maximum length for the e-Mail address field is 240!");
return false;
}
if (subject==''){
alert('Please input e-Mail subject.');
return false;
}
if(subject.length>60){
alert("The maximum length for the e-Mail subject field is 60!");
return false;
}
if(comments.length>240){
alert("The maximum length for the e-Mail content field is 240!");
return false;
}
formdata.email=email
formdata.comments=comments;
formdata.subject=subject;




var tmpUPDATE_E_mail_backup_cwa_id=jQuery.trim(jQuery('#autodeck_text_backup_owner_id').val());
	if(tmpUPDATE_E_mail_backup_cwa_id.length>128){

		alert("The maximum length for the Backup field is 128!");
		return false;
	}

	if(tmpUPDATE_E_mail_backup_cwa_id != "") {
		var reg1_backup_cwaid = /^([a-zA-Z0-9]*[_|\_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]*[_|\_|\-|\.]?)*([a-zA-Z0-9]+\.)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		if(!reg1_backup_cwaid.test(tmpUPDATE_E_mail_backup_cwa_id)){
			alert("please use the correct format for the Backup owner like jdoe@us.ibm.com, \nNote you can only have one Backup e-Mail address.");
			return false;
		}
	}
	
	if(tmpUPDATE_E_mail_backup_cwa_id == cwaid1) {
		alert("The Backup cannot be the same as the Owner e-Mail address for this Autodeck");
		return false;
	}

formdata.emailBackupCwaid = tmpUPDATE_E_mail_backup_cwa_id;

var provisinal=jQuery('#is_provisional').select2().val();;

var frqtype=jQuery("input[name='sched_freq']:checked").val();;
//TODO
var freDetail="";
if(provisinal!='N')	{
if(frqtype==''){
	
	alert('Please select schedule type for the schedule frequncy.');
return false;	
	
}else{
	
	if(frqtype=='D'){
		 freDetail=jQuery('#id_D_sched_freq_detail').val();
		if(freDetail==null){
			alert('Please select schedule detail for the schedule frequncy.');
			return false;
			
		}else{
		 freDetail=jQuery('#id_D_sched_freq_detail').val().toString();
		}
	}else{
		//m
		freDetail=jQuery('#id_M_sched_freq_detail').val();
		if(freDetail==null){
			alert('Please select schedule detail for the schedule frequncy.');
			return false;
			
		}else{
		freDetail=jQuery('#id_M_sched_freq_detail').val().toString();
		}
	}
	
	
	
}
if(freDetail==''){
	//

	alert('Please select at least one day for the schedule frequncy.');

	return false;

	}
}
formdata.frq=frqtype;

//var frqde=dojo.byId('id_hidden_sched_freq_detail').value;
formdata.frqde= freDetail;



//if(jQuery('#is_provisional').prop('checked')){
//provisinal='Y';
//}
formdata.provisinal=provisinal;
//jQuery('#DropDownTimezone').select2().val();;
var gmt_time=jQuery('#DropDownTimezone').select2().val();
formdata.gmt_time=gmt_time;
var expdate=jQuery.trim(jQuery('#id_expiration_date').val());
if(expdate==''){

alert('Please input expiration date.');
return false;
}

var reg2 = /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/;

if(!reg2.test(expdate)){
alert('Please input the correct format for the expiration date,like 2018-12-31');
return false;
}



formdata.expdate=expdate;
var is_outline="N";
//get the tablef
formdata.setdefault='Y';
formdata.myconfig="";
if(choosetype==2){
	//jQuery('#is_outline').prop('checked')
if(jQuery('#is_outline').prop('checked')){
is_outline='Y';
}
}
var isSetDefault="N";
if(isConfigDefaultMode()){
	isSetDefault="Y";
	
	
}
formdata.setdefault=isSetDefault;
var linkStr=output_type+choosetype;
if(choosetype!=output_type){
if((linkStr=='13')||(linkStr=='31')||(linkStr==4)){
// do nothing so far
}else{


formdata.setdefault='Y';
}
}


if(formdata.setdefault=='N'){
//begin for load ppt config
if(choosetype=='2'){
//loadConfig();
var configTable=document.getElementById('config_ppt_table');
var myConfig=new Array();
var rowCount= configTable.rows;
var checkValidate=true;
var specialblankId="00000000";
for(var i=1;i<rowCount.length;i++){
checkValidate=true;

var configdata=new Object();
var inputElement=jQuery('input[type=text]',rowCount[i]);
 var selectElement=jQuery('select',rowCount[i]);
var autofit_rows=selectElement[0].value;
var autofit_cols=selectElement[1].value;
var display_grid=selectElement[2].value;
configdata.autofit_rows=autofit_rows;
configdata.autofit_cols=autofit_cols;
configdata.display_grid=display_grid;

var cid=jQuery.trim(inputElement[1].value);
//add by zero
var header_text=jQuery.trim(inputElement[6].value);
//fix a bug add prefix "Header text"

var header_text_content=jQuery.trim(inputElement[6].value);
var cslide=jQuery.trim(inputElement[0].value);
if(header_text==''){
	header_text = 'Header text is blank,';
}else{
	header_text = 'Header text ' + header_text + ',';
}
if(header_text.length>128){
	if(cslide !=''){
		
		
		alert('For Slide No. ' + cslide + ' and ' + header_text + ' '+'sorry,the size of header text in the template cannot be more than 128.');
		return ;
	}else{
		alert('For Slide No. is blank and ' + header_text + ' ' +'sorry,the size of header text in the template cannot be more than 128.');
	}
}

if(cslide!=''){
	if(IsInteger(cslide)==false){
		if(cslide==1){
			
			alert("For Slide No. " +  cslide + " and " + header_text + " "  +"Slide No. starts from 2,slide 1 is the default cover.");

		}else{
			alert("For Slide No. " +  cslide + " and " + header_text + " "  +cslide+" is not a valid Slide No.");
			return false;
		}
		return false;
	}else{

 		if(parseInt(cslide)>parseInt(maxPPtSlideNo)){
			alert("For Slide No. " +  cslide + " and " + header_text + " "  +"Slide No. cannot be larger than "+maxPPtSlideNo+".");
			return false;
		}

	}

}else {

	alert('For Slide No. is blank ' + cslide + ' and ' + header_text + ' ' + 'please input Slide No.');
	return false;
}

if(specialblankId==cid){
//for balnk specail sheet,not check validate
checkValidate=false;

}
//add by zero to give customer friendly tips
if(jQuery.inArray(cid,myRequestID)==-1){
	if(cid==''){
		alert('For Slide No. ' + cslide + ' and ' + header_text + ' '+ 'you need input request id in the template.');
		return false;
	}else{
	if(checkValidate){
		alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + cid +' is not a valid request id in the template.');
		return false;
		}
	}

}

var cworksheet=jQuery.trim(inputElement[2].value);


if(cworksheet==''&&checkValidate){

	alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'please input work sheet name');
	return false;
}


     var txt=cworksheet;
  // worksheet name
       var myRegSheet=/:|\\|\/|\?|\*|\[|\]/;
        var strNewColLength=txt.length;
       //alert(strLength)
     
  		if (myRegSheet.test(txt))
  		{
		alert("For " +  cslide + "," + header_text + " " +txt+" is not valid,you input  \\ / ? * [ ] illegal characters in  worksheet name!");
		return false;
		}
	   
		
		if(txt.substring(0,1)=="'"||txt.substring(strNewColLength-1)=="'"){
		
		alert("For Slide No. " +  cslide + "," + header_text + " " +txt+" is not valid, ' cannot be the first or the last one in worksheet name!");
		return false;
		}



//addon for fix the bug of the proxy server.
cworksheet=cworksheet.replace(/%/g, "%25");

if(cworksheet.length>128){
	alert('For Slide No. ' + cslide + ',' + header_text + ' '  +'the size of worksheet in the template cannot be more than 128.');
	return false;
}

var custom_col_width=jQuery.trim(inputElement[7].value);
var custom_row_height=jQuery.trim(inputElement[8].value);
var wrap_text_rows=jQuery.trim(inputElement[9].value);
var crange=jQuery.trim(inputElement[3].value);

var hide_rows=jQuery.trim(inputElement[4].value);








configdata.wrap_text_rows=wrap_text_rows;
configdata.custom_col_width=custom_col_width;
configdata.custom_row_height=custom_row_height;
configdata.cid=cid;
configdata.sheet=cworksheet;
configdata.slide=cslide;
configdata.range=crange;
//check format for the wrap text column
var wrap_rows_array=wrap_text_rows.split(",");
//var regRow1 = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;
var regRow1 = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;
var isValid1=true;
if(wrap_text_rows.length>256){
	alert("For " +  cslide + "," + header_text + " " +"the input size of the wrap text in rows cannot be larger than 256.");
	return false;
}
if(wrap_text_rows!=''&&checkValidate){
	jQuery.each(wrap_rows_array,function(index,item){

	if(!regRow1.test(item)){

		isValid1=false;
		alert('For Slide No. ' + cslide + ' and ' + header_text + ' '+ wrap_text_rows +' is not correct format for the wrap text in rows of the template, please input like 1,33,555');
		return false;
	}else {
		return true;

	}


});
}
if(isValid1==false){

return false;
}

//row custom heigt

if(custom_row_height.length>256){
	alert("For Slide No. " +  cslide + " and " + header_text + " "  +"the input size of the custom row format cannot be larger than 256.");
	return false;
}

var custom_row_array=custom_row_height.split(";");//get rows
//var regcol2 = /^([A-Z]|[A-H][A-Z]|I[A-V])$/;  //validate rows
var regRowHeight = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;
var isValidRows=true;


if(custom_row_height!=''&&checkValidate){
	jQuery.each(custom_row_array,function(index,item){

		var var_array=item.split(",");


		if(!regRowHeight.test(var_array[0])){

			isValidRows=false;
			alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom row format is not correct ('+ custom_row_height +'). Please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T' );
			return false;
		}else {

			if(var_array[2]==undefined){
				if(isHeight(var_array[1]) || (var_array[1]=='B'||var_array[1]=='T'||var_array[1]=='M'||var_array[1]=='t'||var_array[1]=='m'||var_array[1]=='b')){

					return true;
				}else{
					isValidRows=false;
					alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom row format is not correct ('+ custom_row_height +'), row format must be between 0 and 409 characters, please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
					return false;

				}
			} else {
		
				if(isHeight(var_array[1])){

					if(var_array[2]=='B'||var_array[2]=='T'||var_array[2]=='M'||var_array[2]=='t'||var_array[2]=='m'||var_array[2]=='b'){
							return true;
					}else{
						isValidRows=false;
						alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom row format is not correct ('+ custom_row_height +'). Please input like 1,4.29;200,3 or 1:100,4.29;200,409\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
						return false;
					}
				}else{
					isValidRows=false;
					alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom row format is not correct ('+ custom_row_height +'), row format must be between 0 and 409 characters, please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
					return false;

				}
		}

	}


});
}
if(isValidRows==false){

return false;
}






//check format for the custom column format

var custom_col_array=custom_col_width.split(";");
//var regcol2 = /^([A-Z]|[A-H][A-Z]|I[A-V])$/;
var regcol2 = /^([A-Z]|[A-H][A-Z]|I[A-V])(:([A-Z]|[A-H][A-Z]|I[A-V]))?$/;
var isValid2=true;

if(custom_col_width.length>256){
alert("For Slide No. " +  cslide + " and " + header_text + " "  + "the input size of the custom column format cannot be larger than 256.");
return false;
}
if(custom_col_width!=''&&checkValidate){
jQuery.each(custom_col_array,function(index,item){

var var_array=item.split(",");


	if(!regcol2.test(var_array[0])){

		isValid2=false;
		alert('For Slide No. ' + cslide + ' and ' + header_text + ' '+  'the Custom column format is not correct ('+ custom_col_width + '). Please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
		return false;
	}else {

		if(var_array[2]==undefined){

			if(isWidth(var_array[1]) || (var_array[1]=='L'||var_array[1]=='C'||var_array[1]=='R'||var_array[1]=='l'||var_array[1]=='c'||var_array[1]=='r')){
				return true;
			}else{
				isValid2=false;
				alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' +  'the Custom column format is not correct ('+ custom_col_width + '). Column format must be between 0 and 255 characters, please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
				return false;

			}


		} else {
			if(isWidth(var_array[1])){
				if(var_array[2]=='L'||var_array[2]=='C'||var_array[2]=='R'||var_array[2]=='l'||var_array[2]=='c'||var_array[2]=='r'){
					return true;
				}else{
					isValid2=false;
					alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' +  'the Custom column format is not correct ('+ custom_col_width + '). Please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
					return false;
				}
			}else{
				isValid2=false;
				alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' +  'the Custom column format is not correct ('+ custom_col_width + '). Column format must be between 0 and 255 characters, please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
				return false;

			}
		}



	}


});
}
if(isValid2==false){

return false;
}


var regu2 = /^([A-Z]|[A-H][A-Z]|I[A-V])([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]):([A-Z]|[A-H][A-Z]|I[A-V])([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;

var regu1=/^(CHART:)/;
var spread_range=crange;
if(checkValidate){
	if(spread_range!=''){
		if(!regu1.test(spread_range)){
			if(!regu2.test(spread_range)){

				alert('For Slide No. ' + cslide + ' and ' + header_text + ' '+ spread_range +' is not correct format for the range of the template, please input  like A1:H2 or CHART:CHART1');
				return false;
			}

		}
	}else{
		alert('For Slide No. ' + cslide + ' and ' + header_text + ' '+ 'please input the range for the each slide of the template');
		return false;
	}

}
configdata.hide_rows=hide_rows;
var hide_rows_array=hide_rows.split(",");
//var regRow = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;
var regRow = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;
var isValid=true;
if(hide_rows.length>256){
	alert("For Slide No. " +  cslide + " and " + header_text + " "  + "the input size of hide rows cannot be larger than 256. ");
	return false;
}
if(hide_rows!=''&&checkValidate){
	jQuery.each(hide_rows_array,function(index,item){

	if(!regRow.test(item)){

		isValid=false;
		alert('For Slide No. ' + cslide + ' and ' + header_text + ' '+ hide_rows +' is not correct format for the hide rows of the template, please input like 1,33,555');
		return false;
	}else {
		return true;

	}


});
}
if(isValid==false){

return false;
}

var hide_columns=jQuery.trim(inputElement[5].value);
if(hide_columns.length>256){
	alert("For Slide No. " +  cslide + " and " + header_text + " "  + "the input size of hide columns in the template cannot be larger than 256. ");
	return false;
}
configdata.hide_columns=hide_columns;
//var regCol = /^([A-Z]|[A-H][A-Z]|I[A-V])$/;
var regCol = /^([A-Z]|[A-H][A-Z]|I[A-V])(:([A-Z]|[A-H][A-Z]|I[A-V]))?$/;
var hide_columns_array=hide_columns.split(",");
if(hide_columns!=''&&checkValidate){
	jQuery.each(hide_columns_array,function(index,item){

	if(! regCol.test(item)){
		isValid=false;

		alert('For Slide No. ' + cslide + ' and ' + header_text + ' '+ hide_columns +' is not correct format for the hide colomns of the template, please input like A,EF,VA');
		return false;
	}else{

		return true;
	}


});
}
if(isValid==false){

return false;
}

header_text_content=header_text_content.replace(/%/g, "%25");
configdata.header_text=header_text_content;
myConfig[i-1]=configdata;
}

formdata.myconfig=myConfig;

}

//end load ppt conif

//xls config begin
if(output_type!='2'){
//loadConfig();
var configTable=document.getElementById('xls_confit_table');
var myConfig=new Array();
var rowCount= configTable.rows;
for(var i=1;i<rowCount.length;i++){
var configdata=new Object();
var inputElement=jQuery('input[type=text]',rowCount[i]);
 var selectElement=jQuery('select',rowCount[i]);
var autofit_rows=selectElement[0].value;
var autofit_cols=selectElement[1].value;
var display_grid=selectElement[2].value;
configdata.autofit_rows=autofit_rows;
configdata.autofit_cols=autofit_cols;
configdata.display_grid=display_grid;



var cid=jQuery.trim(inputElement[0].value);
//add by zero
var cworksheet=jQuery.trim(inputElement[1].value);
var newsheet=jQuery.trim(inputElement[2].value);
//if newsheet is blank than tipStr is cworksheet
var tipStr = '';
if(newsheet!=''){
	tipStr = 'New worksheet name ' + newsheet;	
}else {
	tipStr = 'Worksheet is blank';
	if(cworksheet!=''){
		tipStr = 'Worksheet ' + cworksheet;
	}
	
}
tipStr = tipStr + ',';
if(jQuery.inArray(cid,myRequestID)==-1){
	if(cid==''){
		alert('For ' + tipStr +' '+ 'you need input request id in the template.');
		return false;	
	}else{
		alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + cid +' is not a valid request id in the template.');
		return false;
	}

}



var crange=jQuery.trim(inputElement[3].value);	
var hide_rows=jQuery.trim(inputElement[4].value);
var hide_columns=jQuery.trim(inputElement[5].value);
var custom_col_width=jQuery.trim(inputElement[6].value);
var custom_row_height=jQuery.trim(inputElement[7].value);
var wrap_text_rows=jQuery.trim(inputElement[8].value);


var cslide=jQuery.trim(inputElement[8].value);

if(cworksheet==''){

	alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'please input work sheet name');
	return false;
}


     var txt=cworksheet;
  // worksheet name
       var myRegSheet=/:|\\|\/|\?|\*|\[|\]/;
        var strNewColLength=txt.length;
       //alert(strLength)
      
  		if (myRegSheet.test(txt))
  		{
			alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + "sorry, "+txt+" is not valid,you input  \\ / ? * [ ] illegal characters in worksheet name!");
			return false;
		}
	   
		
		if(txt.substring(0,1)=="'"||txt.substring(strNewColLength-1)=="'"){
		
			alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + "sorry, "+txt+" is not valid, ' cannot be the first or the last one in worksheet name!");
			return false;
		}







//addon for fix the bug of the proxy server.
cworksheet=cworksheet.replace(/%/g, "%25");
txt="";
       if(newsheet!=''){
       txt=newsheet;
       }
newsheet=newsheet.replace(/%/g, "%25");

if(cworksheet.length>128){
	alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'sorry, the size of worksheet in the template cannot be more than 128.');
	return false;
}





configdata.wrap_text_rows=wrap_text_rows;
configdata.custom_col_width=custom_col_width;
configdata.cid=cid;
configdata.sheet=cworksheet;
configdata.newsheet=newsheet;
configdata.slide=cslide;
configdata.range=crange;
configdata.custom_row_height=custom_row_height;




       //new worksheet name
        myRegSheet=/:|\\|\/|\?|\*|\[|\]/;
        strNewColLength=txt.length;
       //alert(strLength)
       if(strNewColLength>31){
       	alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'sorry, '+txt+' is not valid.The new worksheet name length cannot be larger than 31'); 
       	return false;
       }
  		if (myRegSheet.test(txt))
  		{
			alert("For Request ID "+ cid + " and " + tipStr + " " + "sorry, "+txt+" is not valid,you input  \\ / ? * [ ] illegal characters in new worksheet name!");
			return false;
		}
	   
		
		if(txt.substring(0,1)=="'"||txt.substring(strNewColLength-1)=="'"){
		
			alert("For Request ID "+ cid + " and " + tipStr + " " + "sorry, "+txt+" is not valid, ' cannot be the first or the last one in new worksheet name!");
			return false;
		}




//check format for the wrap text column
var wrap_rows_array=wrap_text_rows.split(",");
//var regRow1 = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;
var regRow1 = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;
var isValid1=true;
if(wrap_text_rows.length>256){
	alert("For Request ID "+ cid + " and " + tipStr + " " + "the input size of the wrap text in rows cannot be larger than 256.");
	return false;
}
if(wrap_text_rows!=''){
jQuery.each(wrap_rows_array,function(index,item){

if(!regRow1.test(item)){

	isValid1=false;
	alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + wrap_text_rows +' is not correct format for the wrap text in rows of the template, please input like 1,33,555');
	return false;
}else {
	return true;

}


});
}
if(isValid1==false){

return false;
}



//check custom row format
if(custom_row_height.length>256){
	alert("For Request ID "+ cid + " and " + tipStr + " " + "the input size of the custom row format cannot be larger than 256.");
	return false;
}

var custom_row_array=custom_row_height.split(";");//get rows

var regRowHeight = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;

var isValidRows=true;


if(custom_row_height!=''){
jQuery.each(custom_row_array,function(index,item){

var var_array=item.split(",");


	if(!regRowHeight.test(var_array[0])){

		isValidRows=false;
		alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'the Custom row format is not correct ('+ custom_row_height +'). Please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T' );
		return false;
	}else {

		if(var_array[2]==undefined){
			if(isHeight(var_array[1]) || (var_array[1]=='B'||var_array[1]=='T'||var_array[1]=='M'||var_array[1]=='t'||var_array[1]=='m'||var_array[1]=='b')){

				return true;
			}else{
				isValidRows=false;
				alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'the Custom row format is not correct ('+ custom_row_height +'), row format must be between 0 and 409 characters, please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
				return false;

			}
		} else {
		
			if(isHeight(var_array[1])){

				if(var_array[2]=='B'||var_array[2]=='T'||var_array[2]=='M'||var_array[2]=='t'||var_array[2]=='m'||var_array[2]=='b'){
					return true;
				}else{
					isValidRows=false;
					alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'the Custom row format is not correct ('+ custom_row_height +'). Please input like 1,4.29;200,3 or 1:100,4.29;200,409\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
					return false;
				}
			}else{
				isValidRows=false;
				alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'the Custom row format is not correct ('+ custom_row_height +'), row format must be between 0 and 409 characters, please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
				return false;

			}
		}

	}


});
}
if(isValidRows==false){

return false;
}








//check format for the custom column format

var custom_col_array=custom_col_width.split(";");
//var regcol2 = /^([A-Z]|[A-H][A-Z]|I[A-V])$/;
var regcol2 = /^([A-Z]|[A-H][A-Z]|I[A-V])(:([A-Z]|[A-H][A-Z]|I[A-V]))?$/;
var isValid2=true;
if(custom_col_width.length>256){
	alert("For Request ID "+ cid + " and " + tipStr + " " + "the input size of the custom column format cannot be larger than 256.");
	return false;
}
if(custom_col_width!=''){
	jQuery.each(custom_col_array,function(index,item){

	var var_array=item.split(",");


	if(!regcol2.test(var_array[0])){

		isValid2=false;
		alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'the Custom column format is not correct ('+ custom_col_width +'). Please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
		return false;
	}else {

		if(var_array[2]==undefined){
			if(isWidth(var_array[1]) || (var_array[1]=='L'||var_array[1]=='C'||var_array[1]=='R'||var_array[1]=='l'||var_array[1]=='c'||var_array[1]=='r')){
				return true;
			}else{
				isValid2=false;
				alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'the Custom column format is not correct ('+ custom_col_width +'),column format must be between 0 and 255 characters, please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
				return false;

			}
			
			
		} else {
			if(isWidth(var_array[1])){
				if(var_array[2]=='L'||var_array[2]=='C'||var_array[2]=='R'||var_array[2]=='l'||var_array[2]=='c'||var_array[2]=='r'){
					return true;
				}else{
					isValid2=false;
					alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'the Custom column format is not correct ('+ custom_col_width +'). Please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
					return false;
				}
			}else{
				isValid2=false;
				alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'the Custom column format is not correct ('+ custom_col_width +'),column format must be between 0 and 255 characters, please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
				return false;

			}
		}

	}


});
}
if(isValid2==false){

return false;
}


var regu2 = /^([A-Z]|[A-H][A-Z]|I[A-V])([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]):([A-Z]|[A-H][A-Z]|I[A-V])([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;

var regu1=/^(CHART:)/;
var spread_range=crange;

if(spread_range!=''){
	if(!regu1.test(spread_range)){
		if(!regu2.test(spread_range)){

			alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + spread_range +' is not correct format for the range of the template, please input like A1:H2 or CHART:CHART1');
			return false;
		}

	}
}else{
	alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + 'please input the range for the each slide of the template');
	return false;
}
configdata.hide_rows=hide_rows;
var hide_rows_array=hide_rows.split(",");
//var regRow = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;
var regRow = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;
var isValid=true;
if(hide_rows.length>256){
	alert("For Request ID "+ cid + " and " + tipStr + " " + "the input size of hide rows cannot be larger than 256. ");
	return false;
}
if(hide_rows!=''){
	jQuery.each(hide_rows_array,function(index,item){

	if(!regRow.test(item)){

		isValid=false;
		alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + hide_rows +' is not correct format for the hide rows of the template, please input like 1,33,555');
		return false;
	}else {
		return true;

	}


});
}
if(isValid==false){

return false;
}


if(hide_columns.length>256){
	alert("For Request ID "+ cid + " and " + tipStr + " " + "the input size of hide columns in the template cannot be larger than 256. ");
	return false;
}
configdata.hide_columns=hide_columns;
//var regCol = /^([A-Z]|[A-H][A-Z]|I[A-V])$/;
var regCol = /^([A-Z]|[A-H][A-Z]|I[A-V])(:([A-Z]|[A-H][A-Z]|I[A-V]))?$/;
var hide_columns_array=hide_columns.split(",");
if(hide_columns!=''){
	jQuery.each(hide_columns_array,function(index,item){

	if(! regCol.test(item)){
		isValid=false;

		alert('For Request ID '+ cid + ' and ' + tipStr + ' ' + hide_columns +' is not correct format for the hide colomns of the template, please input like A,EF,VA');
		return false;
	}else{

		return true;
	}


});
}
if(isValid==false){

return false;
}

myConfig[i-1]=configdata;
}

formdata.myconfig=myConfig;

}
//end xls config 

}




formdata.is_outline=is_outline;
formdata.from="submit";
var jsondata =JSON.stringify(formdata);
console.log(jsondata);
//var as=dojo.toJson(formdata);
//dojo.byId('id_button_submit_schedule').style.display = 'none';
//dojo.byId('loaddata1').style.display = '';
return formdata;
}


function submitForm(){
var formdata=saveDeck();
if(formdata==false){
	
	return false;
	
}
console.log(formdata);
var deck=new Object();

 var autodeck= {
     "convertId": formdata.deckid,
     "backupOwner": formdata.emailBackupCwaid,
     "convertOwner": formdata.cwaid,
     "convertStatus": "",
     "emailAddress": formdata.email,
     "emailSubject": formdata.subject,
     "emailComments": formdata.comments,
     "expirationDate": formdata.expdate,
     "finalDeckTime": formdata.final_deck_time,
     "finalDeckWeekNo": formdata.final_weekly,
     "finalTime": null,
     "gmtTime": formdata.gmt_time,
     "immediateSendOnce": null,
     "lastConvTime": null,
     "lastSubmitTime": null,
     "provisional": formdata.provisinal,
     "schedFreq": formdata.frq,
     "schedFreqDetail": formdata.frqde,
     "sendInactiveMail": "",
     "sendProvisional": "",
     "setDefault": formdata.setdefault,
     "setFinal": "",
     "validateTime": null
 };
deck.autodeck=autodeck;
var target={
             "convertId": formdata.deckid,
             "appendDate": formdata.appanddate,
             "autofileTemplate": formdata.template_cd,
             "deckDate": "",
             "isOutline": formdata.is_outline,
             "pptPasteTypeId": formdata.paste_type_cd,
             "sendOption": formdata.sendoption,
             "targetFileName": formdata.filename,
             "targetFileTypeCd": formdata.filetype,
             "zipOutput": formdata.zipoutput
         };
deck.target=target;
var requests=formdata.requests;
console.log(requests);
var inputRequests= new Array();
for(var  i=0;i<requests.length;i++){

request =requests[i];
var lastOutputSatus="";
//check if any request if set to N 'not ready
if(jQuery.inArray(request.id,userRequestsNotReadyList)!=-1){

	lastOutputSatus='N';
}
if(jQuery.inArray(request.id,userRequestsReadyList)!=-1){

	lastOutputSatus='R';
}
var inputRequest={
             "id": {
                 "convertId": formdata.deckid,
                 "requestId": request.id
                 
             },
             "seq": i,
             "requestType": request.type,
             //only store N,R for the user's selection
             "lastStatus":lastOutputSatus
         };
inputRequests[i]=inputRequest;
}
deck.inputRequests=inputRequests;



var out_pput_type;

//ppt
if(formdata.setdefault=='N'){
var myconfigs=formdata.myconfig
if(formdata.filetype=='2'){
 //ppt


	var configs= new Array();
	for(var  i=0;i<myconfigs.length;i++){
	config=myconfigs[i];
	configPpt={ "id": {
         "convertId": formdata.deckid,
         "requestId": config.cid,
         "seq":i
     },
     "autofitColumns": config.autofit_cols,
     "autofitRows": config.autofit_rows,
     "customColumnWidth": config.custom_col_width,
     "customRowHeight": config.custom_row_height,
     "disGridline": config.display_grid,
     "headerText": config.header_text,
     "hideColumns": config.hide_columns,
     "hideRows": config.hide_rows,
     "previewId": null,
     "range": config.range,
     "sheet": config.sheet,
     "slide": config.slide,
     "wrapTextRows": config.wrap_text_rows
 };

	configs[i]=configPpt;

	}

	deck.configs=configs;



}else{
//xls
var configXLSs= new Array();
for(var  i=0;i<myconfigs.length;i++){
config=myconfigs[i];
var configXLS={
             "id": {
                 "convertId": formdata.deckid,
                 "requestId": config.cid,
                 "seq": i
             },
             "autofitColumns": config.autofit_cols,
             "autofitRows": config.autofit_rows,
             "customColumnWidth": config.custom_col_width,
             "customRowHeight": config.custom_row_height,
             "disGridline": config.display_grid,
             "hideColumns": config.hide_columns,
             "hideRows": config.hide_rows,
             "newSheetName": config.newsheet,
             "previewId": config.range,
             "range": config.range,
             "sheet": config.sheet,
             "wrapTextRows": config.wrap_text_rows
         };

configXLSs[i]=configXLS;

}

deck.configXLSs=configXLSs;
}

}
console.log(deck);
var as=JSON.stringify(deck);
console.log(as);
handleSaveDeckCallback(as);
}

function handleSaveDeckCallback(jsonData){
	
	
	var action="savedeck";
	showLoading();
	  jQuery.ajax({
	        
	        type:"POST",
	       
	       // url:deck_app_url+'createpreview',
	        url:deck_app_url+action,
	        data:jsonData,
	        contentType:"application/json",
	      
	        datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".

	       
	       
	        success:function(resObject){
	        	
	        	alert("Your deck has been saved.");
	        	 hiddLoading();
	        	
	        }   ,
	       
	        complete: function(XMLHttpRequest, textStatus){
	          // alert(XMLHttpRequest.responseText);
	        
	        },
	        
	        error: function(XMLHttpRequest, textStatus, errorThrown){
	         alert("Sorry,error occured,please try again later.details:"+XMLHttpRequest.responseText);
	         
	        }         
	     });
}
