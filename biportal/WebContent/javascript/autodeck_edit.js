var maxPPtSlideNo ='100';
function getRequestSatusMessage(statusCode){
	var statusMssage="Unknown";
	switch (statusCode)
	{
		case 'A': 
			statusMssage="Active";
			break;
		case 'D':
			statusMssage="Disabled";
			break;
		case 'E':
			statusMssage="Active";
			break;
		case 'I':
			statusMssage="Inactive";
			break;
		case 'S':
			statusMssage="Suspend";
			break;
	}
	
	return statusMssage;
}
function getMaxSlide(){
	var rowRequest1=document.getElementById('config_ppt_table').rows;
	var maxSlide=2;
	for(var i=1;i<rowRequest1.length;i++){
	 var inputElement=jQuery(":text",rowRequest1[i]);
	     //jquery('input[type=text]',rowRequest1[i]);
	  var cslide=jQuery.trim(inputElement[0].value);

	 
	  if(IsInteger(cslide)){
	     if(parseInt(cslide)>parseInt(maxSlide))
	    maxSlide=parseInt(cslide);
	  }
	  }
	  
	return parseInt(maxSlide); 
	}
function editValue(loadValue,currentValue){
this.dbValue=loadValue;	//from db
this.currentValue=currentValue;//from page
//is 
	
}
var isEditValue;;

function isHeight( str,l,d ){

if(isIntegerWidth(str)) {
   if(str>=0&&str<=409)
   return true;
   
}

var re = /^(\d+)[\.]{0,1}(\d+)$/;
if (re.test(str)) {
if(str>=0&&str<409)
    return true;
    }
return false;
}



function displayInfo(){
    var icolPos = 1;
    var tabletmp1 = document.getElementById('selected_requests_id');
    var disRequestArray = new Array();
    var l = tabletmp1.rows.length;
    output_type=autodeckPanel.output_type;
    if (output_type == 2) {
        icolPos = 2;
        var dispalyrequest1 = new Object();
        dispalyrequest1.id = '00000000';
        dispalyrequest1.title = "blank slide";
        dispalyrequest1.name = "blank slide";
        disRequestArray.push(dispalyrequest1);

    }
    for (var i = 1; i < l; i++) {
        var nrows = tabletmp1.rows[i];
        var reportname = tabletmp1.rows[i].cells[1].innerHTML;
        var title = jQuery('a', tabletmp1.rows[i].cells[1])[0];
        title = jQuery(title).text();
        var requesid1 = tabletmp1.rows[i].cells[8].innerHTML;
        if(jQuery(requesid1).attr("href")!=undefined){
            requesid1=jQuery(requesid1).text();

           }
        var dispalyrequest = new Object();
        dispalyrequest.name = reportname;
        dispalyrequest.id = jQuery.trim(requesid1);
        dispalyrequest.title = jQuery.trim(title);
       
        var rStatus = tabletmp1.rows[i].cells[6].innerHTML;
        //alert(rStatus);
        if(rStatus=='Disabled'){
        	 dispalyrequest.title = "Not valid request, request status is Disabled.";
        	 dispalyrequest.name = "Not valid request, request status is Disabled.";;
        }
        disRequestArray.push(dispalyrequest);


    }
console.log(disRequestArray);
    var tbl;
    if (output_type != 2) {
        tbl = document.getElementById('xls_confit_table');
    } else {
        tbl = document.getElementById('config_ppt_table');
    }
    var trows = tbl.rows;
    var l = tbl.rows.length;


    for (var i = 1; i < l; i++) {
        var input1 = jQuery('input[type=text]', trows[i].cells[icolPos]);
     
        var span1 = jQuery('span', trows[i].cells[icolPos]);
      if(span1.length==0){
       jQuery(input1).after('<span><font color="blue">Loading..</font></span>');
        span1 = jQuery('span', trows[i].cells[icolPos]);
      }else{
        jQuery(span1).html('<font color="blue">Loading..</font>');
      }
     
        input1[0].setAttribute("title", "Not valid");
        for (var k = 0; k < disRequestArray.length; k++) {

            if (disRequestArray[k].id == jQuery.trim(input1[0].value)) {


                input1[0].setAttribute("title", disRequestArray[k].title);
                jQuery(span1).html(disRequestArray[k].name);
            }
        }
        jQuery(span1).show();
    }
    var tbl;
    if (output_type != 2) {
        tbl = document.getElementById('xls_confit_table');
    } else {
        tbl = document.getElementById('config_ppt_table');
    }
    var trows = tbl.rows;
    var l = tbl.rows.length;


    for (var i = 1; i < l; i++) {
        var input1 = jQuery('input[type=text]', trows[i].cells[icolPos]);

        var span1 = jQuery('span', trows[i].cells[icolPos]);
       if(span1.length==0){
       jQuery(input1).after('<span><font color="red">Not valid id</font></span>');
        span1 = jQuery('span', trows[i].cells[icolPos]);
      }else{
        jQuery(span1).html('<font color="red">Not valid id</font>');
      }
        
        input1[0].setAttribute("title", "Not valid");
        for (var k = 0; k < disRequestArray.length; k++) {

            if (disRequestArray[k].id == jQuery.trim(input1[0].value)) {


                input1[0].setAttribute("title", disRequestArray[k].title);
               jQuery(span1).html(disRequestArray[k].name);
            }
        }
         jQuery(span1).show();
    }

//    var ntbl;
//    if (output_type != 2) {
//        ntbl = document.getElementById('init_config_xls_table');
//    } else {
//        ntbl = document.getElementById('init_config_ppt_table');
//    }
//    var ntrows = ntbl.rows;
//    var nl = ntbl.rows.length;
//
//
//    for (var i = 1; i < nl; i++) {
//        console.log(i);
//        var ninput1 = jQuery(ntrows[i].cells[icolPos]).html();
//
//        var nspan1 = jQuery('span', ntrows[i].cells[icolPos]);
//        if(nspan1.length==0){
//            jQuery(input1).after('<span><font color="blue">Loading..</font></span>');
//            nspan1 = jQuery('span', trows[i].cells[icolPos]);
//          
//        jQuery(nspan1).html('<font color="red">Not valid</font>');
//       // ninput1[0].setAttribute("title", "Not valid");
//        for (var k = 0; k < disRequestArray.length; k++) {
//
//            if (disRequestArray[k].id == jQuery.trim(ninput1[0].value)) {
//
//
//                ninput1[0].setAttribute("title", disRequestArray[k].title);
//                jQuery(nspan1).html(disRequestArray[k].name);
//            }
//        }
//        jQuery(nspan1).show();
//        }
//    }

}




function IsInteger(fData)
{
  

    if ((isNaN(fData)) || (fData.indexOf(".")!=-1) || (fData.indexOf("-")!=-1))
        return false ;   
    if(fData<2)
     return false;
    return true ;   
}

function convertForProxyN(inputStr){

inputStr=inputStr.replace(/%/g, "%25");
return inputStr;
}
function isIntegerWidth( str ){
var regu = /^[-]{0,1}[0-9]{1,}$/;
return regu.test(str);
}



function isWidth( str,l,d ){

if(isIntegerWidth(str)) {
   if(str>=0&&str<=255)
   return true;
   
}
var re = /^(\d+)[\.]{0,1}(\d+)$/;
if (re.test(str)) {
if(str>=0&&str<255)
    return true;
    }
return false;
}
function isConfigDefaultMode(){
	//
	var isdefaultPage =jQuery("#id-set-default").attr("disabled"); 
	if(isdefaultPage=="disabled"){
	 return true;
	}else{
	return false;
	//edit mode
	  
	}
	 
	

}
function showPreview(obj){
	if( isConfigDefaultMode()){
		//default value==y
		alert("Create preview/Show Preview only be avaiable when you edit template.");
		
		return false;
	}
	var action="showpreview";
	actionPreview(obj,action);
	
}
function createPreview(obj) {
	if( isConfigDefaultMode()){
		//default value==y
		alert("Create preview/Show Preview only be avaiable when you edit template.");
		
		return false;
	}
	var action="createpreview";
//	if(  isEditValue=='Y'){
//		//default value==y
//		alert("create preview only be avaiable when you edit template.");
//		
//		return false;
//	}
	actionPreview(obj,action)
	
	
	
}
function actionPreview(obj,acton) {
	var output_type=jQuery("input[name='radiogrptype']:checked").val();
	var as;
	if(output_type=='2'){
		as=createPptPreview(obj);
	}else{
		
		as=createXLSPreview(obj);
		
	}
	if(as==false){
		
	}else{
	  handlePreviewCallback(as,acton);
	}
		
}




function copyBaseConfig() {
	if(isConfigDefaultMode()){
		
	alert("You only can copy when you edit template");	
		return false;
		
	}
	
	
	var output_type=jQuery("input[name='radiogrptype']:checked").val();
	if(output_type=='2'){
		copyToPptConfig();
	}else{
		
		copyToXslConfig();
		
	}
	
	autodeckPanel.setEditConfig();
	
	
	
}
function copyToPptConfig(){
	



var rowRequest=document.getElementById('init_config_ppt_table').rows;
var rowRequest1=document.getElementById('config_ppt_table').rows;
var totoalCopyNum=0;
var copyNum=0;
for(var i=1;i<rowRequest.length;i++){

var checkboxEL=jQuery('input',rowRequest[i].cells[0])[0];
if(checkboxEL.checked){
totoalCopyNum++;
}
}
if(totoalCopyNum==0){
alert('Please select at least one configuration entry to copy!');
return false;
} 



var slideNumber=getMaxSlide();
for(var i=1;i<rowRequest.length;i++){

var checkboxEL=jQuery('input',rowRequest[i].cells[0])[0];
if(checkboxEL.checked){

var1='1000';;
var2=rowRequest[i].cells[1].innerHTML;
var3=rowRequest[i].cells[2].innerHTML;
var4=rowRequest[i].cells[3].innerHTML;
var5=rowRequest[i].cells[4].innerHTML;;
var6=rowRequest[i].cells[5].innerHTML;;
var7=rowRequest[i].cells[6].innerHTML;

var var8=rowRequest[i].cells[7].innerHTML;
var var9="N";
var var10="N";
var var11="";
var var12="";
var var13="";
var var14="N";
addPPtConfigcol(var1,var2,var3,var4,var5,var6,var7,var8,var9,var10,var11,var12,var13,var14);
copyNum++;

}

}
if(copyNum==0){
	alert('Please select at least one configuration entry to copy!');
	return false;
	}else if(copyNum==1){
	alert('One configuration entry is copied successfully!');
	}else{

	alert(copyNum +" configuration entries are copied sucessfully!");
	}
}
function copyToXslConfig(){

	var rowRequest=document.getElementById('init_config_xls_table').rows;
	var copyNum=0;
	for(var i=1;i<rowRequest.length;i++){

	var checkboxEL=jQuery('input',rowRequest[i].cells[0])[0];
	if(checkboxEL.checked){

	var1='1000';;
	var2=rowRequest[i].cells[1].innerHTML;
	var3=rowRequest[i].cells[2].innerHTML;
	var4=rowRequest[i].cells[3].innerHTML;
	var5=rowRequest[i].cells[4].innerHTML;;
	var6=rowRequest[i].cells[5].innerHTML;;
	var7=rowRequest[i].cells[6].innerHTML;

	var var8='N';
	var var9='N';
	var var10="";
	var var11="";
	var var12="";
	var var13="N";

	add5col(var1,var2,var3,var4,var5,var6,var7,var8,var9,var10,var11,var12,var13);
	copyNum++;
	 



	}

	}

	if(copyNum==0){
	alert('Please select at least one configuration entry to copy!');
	return false;
	}else if(copyNum==1){
	alert('One configuration entrry is copied sucessfully!');
	}else{

	alert(copyNum +" configuration entries are copied sucessfully!");
	}

	}
function createPptPreview(obj) {
    
	var deckid1 = jQuery('#deck_id').text();
    var configdata = new Object();
    configdata.deckid = deckid1;
    var data=jQuery('#selected_requests_id').DataTable().rows().data();
  
    var myRequest = new Array();
        var myRequestID = new Array();
      for (var i = 0; i < data.length; i++) {
        
        var tr=data[i];
        var td_request=tr[8];
        if(jQuery(td_request).attr("href")!=undefined){
      	  td_request=jQuery(td_request).text();


           }
         myRequestID[i] = td_request;
      }
    var trobj1 = obj.parentNode.parentNode;

    var checkValidate = true;
    var specialblankId = "00000000";

    checkValidate = true;
    var selectElement = jQuery('select', trobj1);
    var inputElement = jQuery(":text",trobj1);
  
    var autofit_rows = selectElement[0].value;
    var autofit_cols = selectElement[1].value;
    var display_grid = selectElement[2].value;
    configdata.autofit_rows = autofit_rows;
    configdata.autofit_cols = autofit_cols;
    configdata.display_grid = display_grid;

    var cid = jQuery.trim(inputElement[1].value);
    //add by zero
    var header_text = jQuery.trim(inputElement[6].value);
    //fix a bug add prefix "Header text"

    var header_text_content = jQuery.trim(inputElement[6].value);
    var cslide = jQuery.trim(inputElement[0].value);
    if (header_text == '') {
        header_text = 'Header text is blank,';
    } else {
        header_text = 'Header text ' + header_text + ',';
    }
    if (header_text.length > 128) {
        if (cslide != '') {


            alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'sorry,the size of header text in the template cannot be more than 128.');
            return false;
        } else {
            alert('For Slide No. is blank and ' + header_text + ' ' + 'sorry,the size of header text in the template cannot be more than 128.');
        }
    }

    if (cslide != '') {
        if (IsInteger(cslide) == false) {
            if (cslide == 1) {

                alert("For Slide No. " + cslide + " and " + header_text + " " + "Slide No. starts from 2,slide 1 is the default cover.");

            } else {
                alert("For Slide No. " + cslide + " and " + header_text + " " + cslide + " is not a valid Slide No.");
                return false;
            }
            return false;
        } else {

            if (parseInt(cslide) > parseInt(maxPPtSlideNo)) {
                alert("For Slide No. " + cslide + " and " + header_text + " " + "Slide No. cannot be larger than " + maxPPtSlideNo + ".");
                return false;
            }

        }

    } else {

        alert('For Slide No. is blank ' + cslide + ' and ' + header_text + ' ' + 'please input Slide No.');
        return false;
    }

    if (specialblankId == cid) {
        //for balnk specail sheet,not check validate
        checkValidate = false;

    }
    //add by zero to give customer friendly tips
    if (jQuery.inArray(cid, myRequestID ) == -1) {
        if (cid == '') {
            alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'you need input request id in the template.');
            return false;
        } else {
            if (checkValidate) {
                alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + cid + ' is not a valid request id in the template.');
                return false;
            }
        }

    }

    var cworksheet = jQuery.trim(inputElement[2].value);


    if (cworksheet == '' && checkValidate) {

        alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'please input work sheet name');
        return false;
    }


    var txt = cworksheet;
    // worksheet name
    var myRegSheet = /:|\\|\/|\?|\*|\[|\]/;
    var strNewColLength = txt.length;
    //alert(strLength)

    if (myRegSheet.test(txt)) {
        alert("For Slide No. " + cslide + "," + header_text + " " + txt + " is not valid,you input  \\ / ? * [ ] illegal characters in  worksheet name!");
        return false;
    }


    if (txt.substring(0, 1) == "'" || txt.substring(strNewColLength - 1) == "'") {

        alert("For Slide No. " + cslide + "," + header_text + " " + txt + " is not valid, ' cannot be the first or the last one in worksheet name!");
        return false;
    }



    //addon for fix the bug of the proxy server.
    //cworksheet = cworksheet.replace(/%/g, "%25");

    if (cworksheet.length > 128) {
        alert('For Slide No. ' + cslide + ',' + header_text + ' ' + 'the size of worksheet in the template cannot be more than 128.');
        return false;
    }

    var custom_col_width = jQuery.trim(inputElement[7].value);
    var custom_row_height = jQuery.trim(inputElement[8].value);
    var wrap_text_rows = jQuery.trim(inputElement[9].value);
    var crange = jQuery.trim(inputElement[3].value);

    var hide_rows = jQuery.trim(inputElement[4].value);








    configdata.wrap_text_rows = wrap_text_rows;
    configdata.custom_col_width = custom_col_width;
    configdata.custom_row_height = custom_row_height;
    configdata.cid = cid;
    configdata.sheet = cworksheet;
    configdata.slide = cslide;
    configdata.range = crange;
    //check format for the wrap text column
    var wrap_rows_array = wrap_text_rows.split(",");
    //var regRow1 = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;
    var regRow1 = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;
    var isValid1 = true;
    if (wrap_text_rows.length > 256) {
        alert("For Slide No. " + cslide + "," + header_text + " " + "the input size of the wrap text in rows cannot be larger than 256.");
        return false;











    }
    if (wrap_text_rows != '' && checkValidate) {
        jQuery.each(wrap_rows_array, function(index, item) {

            if (!regRow1.test(item)) {

                isValid1 = false;
                alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + wrap_text_rows + ' is not correct format for the wrap text in rows of the template, please input like 1,33,555');
                return false;
            } else {
                return true;

            }


        });
    }
    if (isValid1 == false) {

        return false;
    }

    //row custom heigt

    if (custom_row_height.length > 256) {
        alert("For Slide No. " + cslide + " and " + header_text + " " + "the input size of the custom row format cannot be larger than 256.");
        return false;
    }

    var custom_row_array = custom_row_height.split(";"); //get rows
    //var regcol2 = /^([A-Z]|[A-H][A-Z]|I[A-V])$/;  //validate rows
    var regRowHeight = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;
    var isValidRows = true;


    if (custom_row_height != '' && checkValidate) {
        jQuery.each(custom_row_array, function(index, item) {

            var var_array = item.split(",");


            if (!regRowHeight.test(var_array[0])) {

                isValidRows = false;
                alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom row format is not correct (' + custom_row_height + '). Please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
                return false;
            } else {

                if (var_array[2] == undefined) {
                    if (isHeight(var_array[1]) || (var_array[1] == 'B' || var_array[1] == 'T' || var_array[1] == 'M' || var_array[1] == 't' || var_array[1] == 'm' || var_array[1] == 'b')) {

                        return true;
                    } else {
                        isValidRows = false;
                        alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom row format is not correct (' + custom_row_height + '), row format must be between 0 and 409 characters, please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
                        return false;

                    }
                } else {

                    if (isHeight(var_array[1])) {

                        if (var_array[2] == 'B' || var_array[2] == 'T' || var_array[2] == 'M' || var_array[2] == 't' || var_array[2] == 'm' || var_array[2] == 'b') {
                            return true;
                        } else {
                            isValidRows = false;
                            alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom row format is not correct (' + custom_row_height + '). Please input like 1,4.29;200,3 or 1:100,4.29;200,409\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
                            return false;
                        }
                    } else {
                        isValidRows = false;
                        alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom row format is not correct (' + custom_row_height + '), row format must be between 0 and 409 characters, please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
                        return false;

                    }
                }

            }


        });
    }
    if (isValidRows == false) {

        return false;
    }






    //check format for the custom column format

    var custom_col_array = custom_col_width.split(";");
    //var regcol2 = /^([A-Z]|[A-H][A-Z]|I[A-V])$/;
    var regcol2 = /^([A-Z]|[A-H][A-Z]|I[A-V])(:([A-Z]|[A-H][A-Z]|I[A-V]))?$/;
    var isValid2 = true;

    if (custom_col_width.length > 256) {
        alert("For Slide No. " + cslide + " and " + header_text + " " + "the input size of the custom column format cannot be larger than 256.");
        return false;
    }
    if (custom_col_width != '' && checkValidate) {
        jQuery.each(custom_col_array, function(index,item) {

            var var_array = item.split(",");


            if (!regcol2.test(var_array[0])) {

                isValid2 = false;
                alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom column format is not correct (' + custom_col_width + '). Please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
                return false;
            } else {

                if (var_array[2] == undefined) {

                    if (isWidth(var_array[1]) || (var_array[1] == 'L' || var_array[1] == 'C' || var_array[1] == 'R' || var_array[1] == 'l' || var_array[1] == 'c' || var_array[1] == 'r')) {
                        return true;
                    } else {
                        isValid2 = false;
                        alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom column format is not correct (' + custom_col_width + '). Column format must be between 0 and 255 characters, please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
                        return false;

                    }


                } else {
                    if (isWidth(var_array[1])) {
                        if (var_array[2] == 'L' || var_array[2] == 'C' || var_array[2] == 'R' || var_array[2] == 'l' || var_array[2] == 'c' || var_array[2] == 'r') {
                            return true;
                        } else {
                            isValid2 = false;
                            alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom column format is not correct (' + custom_col_width + '). Please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
                            return false;
                        }
                    } else {
                        isValid2 = false;
                        alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'the Custom column format is not correct (' + custom_col_width + '). Column format must be between 0 and 255 characters, please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
                        return false;

                    }
                }



            }


        });
    }
    if (isValid2 == false) {

        return false;
    }


    var regu2 = /^([A-Z]|[A-H][A-Z]|I[A-V])([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]):([A-Z]|[A-H][A-Z]|I[A-V])([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;

    var regu1 = /^(CHART:)/;
    var spread_range = crange;
    if (checkValidate) {
        if (spread_range != '') {
            if (!regu1.test(spread_range)) {
                if (!regu2.test(spread_range)) {

                    alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + spread_range + ' is not correct format for the range of the template, please input  like A1:H2 or CHART:CHART1');
                    return false;
                }

            }
        } else {
            alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + 'please input the range for the each slide of the template');
            return false;
        }

    }
    configdata.hide_rows = hide_rows;
    var hide_rows_array = hide_rows.split(",");
    //var regRow = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;
    var regRow = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;
    var isValid = true;
    if (hide_rows.length > 256) {
        alert("For Slide No. " + cslide + " and " + header_text + " " + "the input size of hide rows cannot be larger than 256. ");
        return false;
    }
    if (hide_rows != '' && checkValidate) {
        dojo.every(hide_rows_array, function(item, index) {

            if (!regRow.test(item)) {

                isValid = false;
                alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + hide_rows + ' is not correct format for the hide rows of the template, please input like 1,33,555');
                return false;
            } else {
                return true;

            }


        });
    }
    if (isValid == false) {

        return false;
    }

    var hide_columns = jQuery.trim(inputElement[5].value);
    if (hide_columns.length > 256) {
        alert("For Slide No. " + cslide + " and " + header_text + " " + "the input size of hide columns in the template cannot be larger than 256. ");
        return false;
    }
    configdata.hide_columns = hide_columns;
    //var regCol = /^([A-Z]|[A-H][A-Z]|I[A-V])$/;
    var regCol = /^([A-Z]|[A-H][A-Z]|I[A-V])(:([A-Z]|[A-H][A-Z]|I[A-V]))?$/;
    var hide_columns_array = hide_columns.split(",");
    if (hide_columns != '' && checkValidate) {
        dojo.every(hide_columns_array, function(item, index) {

            if (!regCol.test(item)) {
                isValid = false;

                alert('For Slide No. ' + cslide + ' and ' + header_text + ' ' + hide_columns + ' is not correct format for the hide colomns of the template, please input like A,EF,VA');
                return false;
            } else {

                return true;
            }


        });
    }
    if (isValid == false) {

        return false;
    }

    var preview=new Object();
    preview.autofitColumns=configdata.autofit_cols;
    preview.autofitRows=configdata.autofit_rows;
    preview.convertId=configdata.deckid;
    preview.customColumnWidth=configdata.custom_col_width;
    preview.customRowHeight=configdata.custom_row_height;
    preview.disGridline=configdata.display_grid;
    preview.hideColumns=configdata.hide_columns;
    preview.hideRows=configdata.hide_rows;
    preview.messages="";

    preview.range=configdata.range;
    preview.requestId=configdata.cid;
    preview.sheet=configdata.sheet;
    preview.wrapTextRows=configdata.wrap_text_rows;
    var as=JSON.stringify(preview);
    //console.log(preview);

    //console.log(as);

   return as;


}
function openPreviewWindow(previewId)
{
OpenWindow=window.open("", "newwin", "height=800, width=800,resizable=yes,toolbar=no,scrollbars=yes,location=no,menubar=no");
OpenWindow.document.write("<TITLE>Popup: BI@IBM Autodeck preview</TITLE>");
OpenWindow.document.write("<BODY>");
OpenWindow.document.write("<h1>BI@IBM Autodeck preview:</h1>");
OpenWindow.document.write("<img  alt=\"loading the preview image...\" src=\""+preview_url+"/autofile_preview/"+previewId+".png\"/>");;
OpenWindow.document.write("<br /><br />");
//TODO
OpenWindow.document.write("<a href='javascript:window.close();'>Close this window.</a>");
OpenWindow.document.write("</BODY>");
OpenWindow.document.write("</HTML>");
OpenWindow.document.close();
//self.name="main";
}

function handlePreviewCallback(jsonData,previewAction){
	
	
	
	  jQuery.ajax({
	        
	        type:"POST",
	       
	       // url:deck_app_url+'createpreview',
	        url:deck_app_url+previewAction,
	        data:jsonData,
	        contentType:"application/json",
	      
	        datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".

	       
	       
	        success:function(resObject){
	        	//var resObject = dojo.fromJson(resObject);
	            var indicator = resObject.indicator;
	            if (indicator == "A") {

	                alert("Your request has been added sucessfully, please click \"Show preview\" link after 3 ~ 5 minutes");

	            } else if (indicator == "F") {


	                alert("Error occured:" + resObject.message);


	            } else if (indicator == "Y") {

	                var previewid = resObject.preview_id;
	                isReadyPopup = "Y";
	                tmpPreviewid = previewid;
	                openPreviewWindow(previewid);
	            } else if (indicator == "B") {

	                alert("The request is in process, please wait and try again later!");
	            } else if(indicator=="N"){
	                
	                alert("There is no request for this preview in process, please click \"Generate preview\" link to add one.");
	                 }else{
	                	 
	                	 
	                	 alert("unknow indicator,"+indicator);
	                 }         
	        
	        
	        }   ,
	       
	        complete: function(XMLHttpRequest, textStatus){
	          // alert(XMLHttpRequest.responseText);
	         //  alert(textStatus);
	            //HideLoading();
	        },
	        
	        error: function(XMLHttpRequest, textStatus, errorThrown){
	         alert("Sorry,error occured,please try again later.details:"+XMLHttpRequest.responseText);
	         
	        }         
	     });
}

function createXLSPreview(obj) {
var deckid1 = jQuery('#deck_id').text();
    var configdata = new Object();
    configdata.deckid = deckid1;

var data=jQuery('#selected_requests_id').DataTable().rows().data();

var myRequest = new Array();
    var myRequestID = new Array();
  for (var i = 0; i < data.length; i++) {
    
    var tr=data[i];
    var td_request=tr[8];
    if(jQuery(td_request).attr("href")!=undefined){
  	  td_request=jQuery(td_request).text();


       }
     myRequestID[i] = td_request;
  }
//console.log(myRequestID);
  console.log(obj);
   var trobj1 = obj.parentNode.parentNode;
//console.log(trobj1);
   var selectElement = jQuery('select', trobj1);
 var inputElement = jQuery(":text",trobj1);
   
   var autofit_rows = selectElement[0].value;
   var autofit_cols = selectElement[1].value;
   var display_grid = selectElement[2].value;
   configdata.autofit_rows =autofit_rows ;
   configdata.autofit_cols =autofit_cols ;
   configdata.display_grid =display_grid ;
   var cid = jQuery.trim(inputElement[0].value);
   //add by zero
   var cworksheet = jQuery.trim(inputElement[1].value);
   var newsheet = jQuery.trim(inputElement[2].value);
   //if newsheet is blank than tipStr is cworksheet
   var tipStr = '';
   var cslide = 0;
var tipStr = '';
if (newsheet != '') {
    tipStr = 'New worksheet name ' + newsheet;
} else {
    tipStr = 'Worksheet is blank';
    if (cworksheet != '') {
        tipStr = 'Worksheet ' + cworksheet;
    }

}

if (jQuery.inArray(cid, myRequestID ) == -1) {
    if (cid == '') {
        alert('For ' + tipStr + ' ' + 'you need input request id in the template.');
        return false;
    } else {
        alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + cid + ' is not a valid request id in the template.');
        return false;
    }

}
var crange = jQuery.trim(inputElement[3].value);
var hide_rows = jQuery.trim(inputElement[4].value);
var hide_columns = jQuery.trim(inputElement[5].value);
var custom_col_width = jQuery.trim(inputElement[6].value);
var custom_row_height = jQuery.trim(inputElement[7].value);
var wrap_text_rows = jQuery.trim(inputElement[8].value);

if (cworksheet == '') {

    alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'please input work sheet name');
    return false;
}


var txt = cworksheet;
// worksheet name
var myRegSheet = /:|\\|\/|\?|\*|\[|\]/;
var strNewColLength = txt.length;
//alert(strLength)

if (myRegSheet.test(txt)) {
    alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + "sorry, " + txt + " is not valid,you input  \\ / ? * [ ] illegal characters in worksheet name!");
    return false;
}


if (txt.substring(0, 1) == "'" || txt.substring(strNewColLength - 1) == "'") {

    alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + "sorry, " + txt + " is not valid, ' cannot be the first or the last one in worksheet name!");
    return false;
}







//addon for fix the bug of the proxy server.
//cworksheet = cworksheet.replace(/%/g, "%25");
txt = "";
if (newsheet != '') {
    txt = newsheet;
}
newsheet = newsheet.replace(/%/g, "%25");

if (cworksheet.length > 128) {
    alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'sorry, the size of worksheet in the template cannot be more than 128.');
    return false;
}




var cslide='n/a';
configdata.wrap_text_rows = wrap_text_rows;
configdata.custom_col_width = custom_col_width;
configdata.cid = cid;
configdata.sheet = cworksheet;
configdata.newsheet = newsheet;
configdata.slide = cslide;
configdata.range = crange;
configdata.custom_row_height = custom_row_height;




//new worksheet name
myRegSheet = /:|\\|\/|\?|\*|\[|\]/;
strNewColLength = txt.length;
//alert(strLength)
if (strNewColLength > 31) {
    alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'sorry, ' + txt + ' is not valid.The new worksheet name length cannot be larger than 31');
    return false;
}
if (myRegSheet.test(txt)) {
    alert("For Request ID " + cid + " and " + tipStr + " " + "sorry, " + txt + " is not valid,you input  \\ / ? * [ ] illegal characters in new worksheet name!");
    return false;
}


if (txt.substring(0, 1) == "'" || txt.substring(strNewColLength - 1) == "'") {

    alert("For Request ID " + cid + " and " + tipStr + " " + "sorry, " + txt + " is not valid, ' cannot be the first or the last one in new worksheet name!");
    return false;
}




//check format for the wrap text column
var wrap_rows_array = wrap_text_rows.split(",");
//var regRow1 = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;
var regRow1 = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;
var isValid1 = true;
if (wrap_text_rows.length > 256) {
    alert("For Request ID " + cid + " and " + tipStr + " " + "the input size of the wrap text in rows cannot be larger than 256.");
    return false;
}
if (wrap_text_rows != '') {
    jQuery(wrap_rows_array).each( function( index,item) {

        if (!regRow1.test(item)) {

            isValid1 = false;
            alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + wrap_text_rows + ' is not correct format for the wrap text in rows of the template, please input like 1,33,555');
            return false;
        } else {
            return true;

        }


    });
}
if (isValid1 == false) {

    return false;
}


//check custom row format
if (custom_row_height.length > 256) {
    alert("For Request ID " + cid + " and " + tipStr + " " + "the input size of the custom row format cannot be larger than 256.");
    return false;
}

var custom_row_array = custom_row_height.split(";"); //get rows

var regRowHeight = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;

var isValidRows = true;


if (custom_row_height != '') {
    jQuery.each(custom_row_array, function(index,item) {

        var var_array = item.split(",");


        if (!regRowHeight.test(var_array[0])) {

            isValidRows = false;
            alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'the Custom row format is not correct (' + custom_row_height + '). Please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
            return false;
        } else {

            if (var_array[2] == undefined) {
                if (isHeight(var_array[1]) || (var_array[1] == 'B' || var_array[1] == 'T' || var_array[1] == 'M' || var_array[1] == 't' || var_array[1] == 'm' || var_array[1] == 'b')) {

                    return true;
                } else {
                    isValidRows = false;
                    alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'the Custom row format is not correct (' + custom_row_height + '), row format must be between 0 and 409 characters, please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
                    return false;

                }
            } else {

                if (isHeight(var_array[1])) {

                    if (var_array[2] == 'B' || var_array[2] == 'T' || var_array[2] == 'M' || var_array[2] == 't' || var_array[2] == 'm' || var_array[2] == 'b') {
                        return true;
                    } else {
                        isValidRows = false;
                        alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'the Custom row format is not correct (' + custom_row_height + '). Please input like 1,4.29;200,3 or 1:100,4.29;200,409\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
                        return false;
                    }
                } else {
                    isValidRows = false;
                    alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'the Custom row format is not correct (' + custom_row_height + '), row format must be between 0 and 409 characters, please input like 1,4.29;200,3 or 1:100,4.29;200,5\nIf you add cell alignment vertical value, please input like 1:100,4.29,B;200,5,M;300,5,T;10,T');
                    return false;

                }
            }

        }


    });
}
if (isValidRows == false) {

    return false;
}





//check format for the custom column format

var custom_col_array = custom_col_width.split(";");
//var regcol2 = /^([A-Z]|[A-H][A-Z]|I[A-V])$/;
var regcol2 = /^([A-Z]|[A-H][A-Z]|I[A-V])(:([A-Z]|[A-H][A-Z]|I[A-V]))?$/;
var isValid2 = true;
if (custom_col_width.length > 256) {
    alert("For Request ID " + cid + " and " + tipStr + " " + "the input size of the custom column format cannot be larger than 256.");
    return false;
}


if (custom_col_width != '') {
    jQuery.each(custom_col_array, function( index,item) {

        var var_array = item.split(",");


        if (!regcol2.test(var_array[0])) {

            isValid2 = false;
            alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'the Custom column format is not correct (' + custom_col_width + '). Please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
            return false;
        } else {

            if (var_array[2] == undefined) {
                if (isWidth(var_array[1]) || (var_array[1] == 'L' || var_array[1] == 'C' || var_array[1] == 'R' || var_array[1] == 'l' || var_array[1] == 'c' || var_array[1] == 'r')) {
                    return true;
                } else {
                    isValid2 = false;
                    alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'the Custom column format is not correct (' + custom_col_width + '),column format must be between 0 and 255 characters, please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
                    return false;

                }


            } else {
                if (isWidth(var_array[1])) {
                    if (var_array[2] == 'L' || var_array[2] == 'C' || var_array[2] == 'R' || var_array[2] == 'l' || var_array[2] == 'c' || var_array[2] == 'r') {
                        return true;
                    } else {
                        isValid2 = false;
                        alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'the Custom column format is not correct (' + custom_col_width + '). Please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
                        return false;
                    }
                } else {
                    isValid2 = false;
                    alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'the Custom column format is not correct (' + custom_col_width + '),column format must be between 0 and 255 characters, please input like A,4.29;B,3\nIf you add cell alignment horizonal value please input like A,4.29,L;B,3,R;C,5,C;G,R');
                    return false;

                }
            }

        }


    });
}
if (isValid2 == false) {

    return false;
}

var regu2 = /^([A-Z]|[A-H][A-Z]|I[A-V])([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]):([A-Z]|[A-H][A-Z]|I[A-V])([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;

var regu1 = /^(CHART:)/;
var spread_range = crange;

if (spread_range != '') {
    if (!regu1.test(spread_range)) {
        if (!regu2.test(spread_range)) {

            alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + spread_range + ' is not correct format for the range of the template, please input like A1:H2 or CHART:CHART1');
            return false;
        }

    }
} else {
    alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + 'please input the range for the each slide of the template');
    return false;
}
configdata.hide_rows = hide_rows;
var hide_rows_array = hide_rows.split(",");
//var regRow = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])$/;
var regRow = /^([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9])(:([1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-6]|[1-9]\d{1,3}|[1-9]))?$/;
var isValid = true;
if (hide_rows.length > 256) {
    alert("For Request ID " + cid + " and " + tipStr + " " + "the input size of hide rows cannot be larger than 256. ");
    return false;
}
if (hide_rows != '') {
    jQuery.each(hide_rows_array, function( index,item) {

        if (!regRow.test(item)) {

            isValid = false;
            alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + hide_rows + ' is not correct format for the hide rows of the template, please input like 1,33,555');
            return false;
        } else {
            return true;

        }


    });
}
if (isValid == false) {

    return false;
}

if (hide_columns.length > 256) {
    alert("For Request ID " + cid + " and " + tipStr + " " + "the input size of hide columns in the template cannot be larger than 256. ");
    return false;
}
configdata.hide_columns = hide_columns;
//var regCol = /^([A-Z]|[A-H][A-Z]|I[A-V])$/;
var regCol = /^([A-Z]|[A-H][A-Z]|I[A-V])(:([A-Z]|[A-H][A-Z]|I[A-V]))?$/;
var hide_columns_array = hide_columns.split(",");
if (hide_columns != '') {
    jQuery.each(hide_columns_array, function( index,item) {

        if (!regCol.test(item)) {
            isValid = false;

            alert('For Request ID ' + cid + ' and ' + tipStr + ' ' + hide_columns + ' is not correct format for the hide colomns of the template, please input like A,EF,VA');
            return false;
        } else {

            return true;
        }


    });
}
if (isValid == false) {

    return false;
}

var preview=new Object();
preview.autofitColumns=configdata.autofit_cols;
preview.autofitRows=configdata.autofit_rows;
preview.convertId=configdata.deckid;
preview.customColumnWidth=configdata.custom_col_width;
preview.customRowHeight=configdata.custom_row_height;
preview.disGridline=configdata.display_grid;
preview.hideColumns=configdata.hide_columns;
preview.hideRows=configdata.hide_rows;
preview.messages="";

preview.range=configdata.range;
preview.requestId=configdata.cid;
preview.sheet=configdata.sheet;
preview.wrapTextRows=configdata.wrap_text_rows;
var as=JSON.stringify(preview);


return as;


}












function ToDate(timestamp3){
  

  var newDate = new Date();
  newDate.setTime(timestamp3);

  return newDate.toGMTString();
  
}
function addRadio(id,name,value,txt){

    var put=jQuery("<input type='radio'>");

         var lab=jQuery("<label>");
         

         jQuery(put).attr('id',id);
         jQuery(put).attr('name',name);
         jQuery(put).attr('value',value);
          jQuery(put).addClass('ibm-styled-radio');
      
              jQuery(lab).attr('for',id);
               jQuery(lab).text(txt);

  //var result=jQuery(put).append(lab);
  // console.log(result);
 return put;
 }
    
 function addLabel(id,name,value,txt){

    var put=jQuery("<input type='radio'>");

         var lab=jQuery("<label>");
         

         jQuery(put).attr('id',id);
         jQuery(put).attr('name',name);
          jQuery(put).addClass('ibm-styled-radio');
      
              jQuery(lab).attr('for',id);
               jQuery(lab).text(txt);

  //var result=jQuery(put).append(lab);
   //console.log(result);
 return lab;
 }

function AutodeckPanel(deck_id, deck_name, owner, backup_owner, sel_requests, cog_requests, upload_requests, output_format_Tab, email_tab, schedule_tab, config_tab, base_config_tab, schedule_tab) {
    this.deck_id = deck_id;
    this.deck_name = deck_name;
    this.owner = owner;
    this.backup_owner = backup_owner;
    this.sel_requests = sel_requests;
    this.cog_requests = cog_requests;
    this.upload_requests = upload_requests;
    this.output_format_Tab = output_format_Tab;
    this.email_tab = email_tab;
    this.schedule_tab = schedule_tab;
    this.config_tab = config_tab;
    this.base_config_tab = base_config_tab;
    this.schedule_tab = schedule_tab;
    this.output_type="1";
    this.clickTabs=new Array();
    // type cd for output file
 // 1 xls
 // 2 ppt
 // 3 xlsx
   isDefault="N";
}


//fix the bug for datatable,because of datatable the hidden tab,the layout might be ugerly,
//so adjust the datatable  when click the tab first time,and 
AutodeckPanel.prototype.setClickToEachTab = function() {
	var self =this;
	
	
	
	//select request table 

	jQuery('#deck_tab_request').click( function (){
		  if(self.clickTabs[deck_tab_request]!=1){
		
		  jQuery('#autodeck_requests_id').show();
		  var table = jQuery('#selected_requests_id').DataTable();
		  table.columns.adjust().draw();
		 
		  //console.log("bind");
		  self.clickTabs[deck_tab_config]=1
		  
		  }
	  
		})//tab 5


if(self.output_type!='2'){
		  //xls
		  //console.log("xls");
		  //tab 5 template config
	jQuery('#deck_tab_config').click( function (){
		if(self.clickTabs[deck_tab_config]!=1){
		  jQuery('#autodeck_config_temp_id').show();
		  var table = jQuery('#xls_confit_table').DataTable();
		  table.columns.adjust().draw();
		 
		  //console.log("bind");
		  self.clickTabs[deck_tab_config]=1
		}
	  
		})//tab 5
	
		
		  //tab 6 template  base config
	jQuery('#deck_tab_init_config').click( function (){
		  if(self.clickTabs[deck_tab_init_config]!=1){
		  jQuery('#autodeck_config_base_id').show();
		  var table = jQuery('#init_config_xls_table').DataTable();
		  table.columns.adjust().draw();
		
		  
		  self.clickTabs[deck_tab_config]=1
		  
		  }
	  
		})//tab 6
		
		
		
		
	  }else{
		//ppt  
		  //tab 5 template config
			jQuery('#deck_tab_config').click( function (){
				 if(self.clickTabs[deck_tab_config]!=1){
			
		  jQuery('#autodeck_config_temp_id').show();
		  var table = jQuery('#config_ppt_table').DataTable();
		  table.columns.adjust().draw();
		  self.clickTabs[deck_tab_config]=1;
				 }
	
	  
		})//tab 5	  
		 
			
		  //tab 6 template  base config
	jQuery('#deck_tab_init_config').click( function (){
		  if(self.clickTabs[deck_tab_init_config]!=1){
		  jQuery('#autodeck_config_base_id').show();
		  var table = jQuery('#init_config_ppt_table').DataTable();
		  table.columns.adjust().draw();
		
		  
		  self.clickTabs[deck_tab_init_config]=1
		  
		  }
	  
		})//tab 6  
	  }
	
}

AutodeckPanel.prototype.getIsDefault = function() {
	
	return this.isDefault;

	}

AutodeckPanel.prototype.setIsDefault_fromPage = function(newValue) {
	
	this.isDefault_change	=newValule;

	}
AutodeckPanel.prototype.ifSetDefaultValueChange= function() {
	
	return(this.isDefault_change!=thisisDefault_change);

	}

AutodeckPanel.prototype.isActive = function() {
	
	if(this.status=='A'){
		
		
		return true;
	}else{
		return false;
	}
	
}
AutodeckPanel.prototype.loadDeck = function(deck) {

	console.log(deck);
    this.jsonDeck = deck;
    

    this.status=deck.convertStatus;
    this.autodeckTpcds=deck.autodeckTpcd;
    this.autodeck = deck.autodeck;
    this.deck_id = this.autodeck.convertId;
    var subject=deck.autodeck.emailSubject;
    this.output_type = deck.target.targetFileTypeCd;
    this.owner = this.autodeck.convertOwner;
   this.isDefault=this.autodeck.setDefault;
   isEditValue= this.isDefault;
   this.isDefault_change=this.autodeck.setDefault;
   this.setEdit=false;
    this.backup_owner = this.autodeck.backupOwner;
    this.deck_name = subject+"("+deck.target.targetFileName + "." + deck.autodeckTpcd[this.output_type - 1].autoFileTypeName+")";
    this.extName= deck.autodeckTpcd[this.output_type - 1].autoFileTypeName;
    ////console.log("deck name:" + this.deck_name);
    this.errorMessage = deck.errorMessage;
    if (this.errorMessage != null) {

        this.showErrorMsg(this.errorMessage);

    }
    return this.checkSecurity();
       
    




}
AutodeckPanel.prototype.displayIntro = function() {

    deckInfo = this;
 
    jQuery("#deck_id").html(deckInfo.deck_id);
    jQuery("#deck_name").html(deckInfo.deck_name);
    jQuery("#deck_owner").html(deckInfo.owner);

}
AutodeckPanel.prototype.showErrorMsg = function(msg) {

    alert("Error ocured," + msg);
    ////console.log("Error ocured," + msg);
}
AutodeckPanel.prototype.checkSecurity = function() {
    //TODO
    //alert("Error ocured,"+msg);   
    //check if the cwaid is owner or backup
    var isValid = false;
    if (cwa_id == this.backup_owner || cwa_id == this.owner) {


        isValid = true;
    }
    //TODO add alter message
    ////console.log("check security--" + isValid);
    return isValid;
}

AutodeckPanel.prototype.loadTabs = function() {
        this.loadTab1();
        this.loadTab2();
         this.loadTab3();
         this.loadTab4();
         this.loadTab5();
         this.loadTab6();
        this.loadTab7();
        this.hideDislayTemplate(this.isDefault);
        this.setClickToEachTab();
    }
    //selected request
AutodeckPanel.prototype.loadTab1 = function() {

    this.selectedRequests = this.jsonDeck.selectedInput;
    var reqeustData = this.selectedRequests;
    var table_Request = jQuery('#selected_requests_id').DataTable({
        "bSort": false , //no sort needed
        "searching": false,//filter disable
        "bAutoWidth": true,//
        "sScrollX": "100%",
        "bPaginate": false,
        "sScrollXInner": "110%",
        "bScrollCollapse": true,
        "bInfo": true,     
        'columnDefs': [
                       {
                          'targets': 0,
                          'render': function(data, type, row, meta) {
                              return '<input type="checkbox" name="checklist" value="' + row.id + '" />'
                          }
                       }
                    ]
    });
    
    
    
    
    
    
    
    
    
    
    
    
    

    for (var i = 0; i < reqeustData.length; i++) {
        var inputRequest = reqeustData[i];
        if (inputRequest.requestType == '1') {
        	
            //cognos schedule request
           // var input_col_1 = inputRequest.rptName;
            var input_col_1 = "<a href=" + myTbsContext + "/action/portal/schedulePanel/openCognosSchedulePanel/"
			+ inputRequest.requestId + "/" + inputRequest.tbsDomainKey
			+ " target='_blank'>"
			+ inputRequest.rptName;
			+ "</a>";
			if(inputRequest.rptName==null||inputRequest.rptName=='null'||inputRequest.rptName==''){
				
				input_col_1='N/A';
				
			}
            var input_col_2 = inputRequest.emailSubject;
         
           var freq = inputRequest.schedFreq
;
    		var freqDtl = inputRequest.freqDetail;

			var triggerType = inputRequest.triggerType;
			//console.log(triggerType);
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
     if(freqDtl==null||freqDtl=='null'){
    	 freqDtl="N/A";
     }
            var input_col_3 = t + "<br />" + freqDtl; 
            
         
            
            
           // var input_col_3 = freq + inputRequest.freqDetail;

            var input_col_4 = inputRequest.dataMart;
            var input_col_5 = inputRequest.expirationDate;
            var input_col_6 = inputRequest.tbsDomainKey;
          
            var input_col_7 = getRequestSatusMessage(inputRequest.requestStatus);
            var input_col_8 = inputRequest.comments;
            //var input_col_9 = inputRequest.requestId;
            var input_col_10="Cognos schedule";
            //Output Status
        //200 /400 Failed  
      
           // 300 Running  
          
            //100/101 Ready 
            var tmp_lasttStatus=inputRequest.lastStatus;
            var lastStatusMsg="Unavailable"
            	var input_col_9_request_id = inputRequest.requestId;	
                	
            	
            	
            	
            if(tmp_lasttStatus=='R'){
            	lastStatusMsg="Ready";
            	input_col_9_request_id = "<a href=" + myTbsContext + "/action/portal/tbsoutputs/downLoadTBSOutput/"
      			+ cwa_id+ "/" + uid+"/"+ inputRequest.requestId +"/"+inputRequest.requestId+" target='_blank' >"+inputRequest.requestId +"</a>";	
                	
            	
            	
            }else if(tmp_lasttStatus=='F'){
            	
            	lastStatusMsg="Failed";
            	
            	
            }else if(tmp_lasttStatus=='N'){
            	lastStatusMsg="Not Ready";
             	input_col_9_request_id = "<a href=" + myTbsContext + "/action/portal/tbsoutputs/downLoadTBSOutput/"
      			+ cwa_id+ "/" + uid+"/"+ inputRequest.requestId +"/"+inputRequest.requestId+" target='_blank' >"+inputRequest.requestId +"</a>";	
                	
            	
            }
            
            var input_col_11=lastStatusMsg;
            //“Last Ready Time
            var input_col_12='';
            //added by IT08-02,if the stauts is not ready (r),then the time set to N/A
            
             if(tmp_lasttStatus!='R'){
            	 input_col_12='N/A';
            }else{
            	input_col_12=ToDate(inputRequest.readyTime);
            }
         ///portal/tbsoutputs/downLoadTBSOutput/{cwa_id}/{uid}/{with_request}/{requestID}
            	 
          
            var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5,  input_col_7, input_col_8,input_col_9_request_id,input_col_10,input_col_11,input_col_12]

            table_Request.row.add(dataSet);
        } else {
            //upload reqeust
           // var input_col_1 = inputRequest.rptName;
        	var input_col_1 = "<a href=" + myTbsContext + "/action/portal/autodeck/xlsmanage/getXLSManagePage/"
			+ " target='_blank'>"
			+ inputRequest.rptName;
			+ "</a>";
if(inputRequest.rptName==null||inputRequest.rptName=='null'||inputRequest.rptName==''){
				
				input_col_1='N/A';
				
			}
            var input_col_2 = inputRequest.emailSubject;
            var freq = "";
            ////console.log(inputRequest.triggerType);
           
            var input_col_3 = freq + inputRequest.freqDetail;

            var input_col_4 = inputRequest.dataMart;
            var input_col_5 = inputRequest.expirationDate;
            var input_col_6 = inputRequest.tbsDomainKey;
            var input_col_7 = getRequestSatusMessage(inputRequest.requestStatus);
            var statusCheck=inputRequest.requestStatus;
           
            var input_col_8 = inputRequest.comments;
            var input_col_9 = inputRequest.requestId;
            var input_col_10="Uploaded file";
            //Output Status

            var input_col_11="N/A";
            //“Last Ready Time
            var input_col_12="N/A";
            var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_7, input_col_8, input_col_9,input_col_10,input_col_11,input_col_12]

            table_Request.row.add(dataSet);

        }
    }
    table_Request.draw();
    
    var table = jQuery('#selected_requests_id').DataTable();

    jQuery('#selected_requests_id tbody').on( 'click', 'tr', function () {
     ////console.log(this);
     var row=this;
         jQuery(row).toggleClass('selected');
     var checkbox1=jQuery("input:checkbox",row)[0];
     var checkbox1=jQuery(checkbox1);
  var clname=jQuery(row).attr('class');
  var isChecked=false;
  if(clname.indexOf("selected") >= 0 )
  {
   isChecked=true;
   } 
     //if(checkbox1.is(':checked')){
  if(!isChecked){
        checkbox1.prop("checked",false);
      
         ////console.log(checkbox1);
        ////console.log("remove");
      }else{
        checkbox1.prop("checked",true);
        ////console.log("add");
        ////console.log(checkbox1);
        
      }
     
     ////console.log(checkbox1);
     } );



 jQuery('#autodeck_href_showa1').click( function () {
     ////console.log("deck up");
         //alert( table.rows('.selected').data().length +' row(s) selected' );
     var mytable=   new CTable("selected_requests_id");
     mytable.up();
     } );

  jQuery('#autodeck_href_showa2').click( function () {
     ////console.log("deck down");
     var mytable1=   new CTable("selected_requests_id");
     mytable1.down();
         //alert( table.rows('.selected').data().length +' row(s) selected' );
     } );
 jQuery('#autodeck_href_showa3').click( function () {
     ////console.log("deck select more");
	 IBMCore.common.widget.overlay.show('dialogOne');
if(calledRequest==false){
	getUploads();
	getScheduledRequestsList(); 
	calledRequest=true;
	console.log("call service");
}
	 
     } );

   jQuery('#autodeck_href_showa4').click( function () {
     ////console.log("deck delete");
     table.rows('.selected').remove().draw( false );
     //    alert( table.rows('.selected').data().length +' row(s) selected' );
     } );
   jQuery('#autodeck_href_showa5').click( function () {
	     ////console.log("deck delete");
	   addNotReadyList();
	     //    alert( table.rows('.selected').data().length +' row(s) selected' );
	     } );
    
  // this.setLinkForRequest();
   
   
  //load all requests;
   

}

AutodeckPanel.prototype.setLinkForRequest = function() {
	
	jQuery('#selected_requests_id tbody tr').each(function () {
	    
	    	var reportNameRowPos=1;
       
      
	    	     jQuery("td:eq(1)",this).each(function(){
	    	        ////console.log(this);
	    	       
	    	       var jqob=jQuery(this);
	    	       var txt=jqob.text();
              var put;;
                       
                    
	    	                   var put=jQuery("<a class='deck-request'>");
                              //console.log(txt);
	    	                   put.text(txt);
                          
	    	                   jqob.html(put);
	    	       
	    	       
	    	      // //console.log(jQuery(this));
	    	       
	    	     });
	    	        
	    	   });
	//TODO add more handle thing if needed
jQuery(".deck-request").click( function (){
var tr=jQuery(this).closest("tr");
var requestId=jQuery("td:eq(8)",tr).text();
var rtype=jQuery("td:eq(9)",tr).text();
//console.log("id:"+requestId+",rtype:"+rtype);
})
	
	
}

//output tab
AutodeckPanel.prototype.loadTab2 = function() {
	var target= this.jsonDeck.target;
	var filename=target.targetFileName;
	var type=this.output_type;
	var appendDate=target.appendDate;
	var autofileTemplate=target.autofileTemplate;
	var sendOption=target.sendOption;
	var zipOutput=target.zipOutput;
		jQuery("#deck_name_id").val(filename);	
		jQuery("#target_file_type_id").val(sendOption);
		
		var autodeckcds=this.autodeckTpcds;

		console.log(autodeckcds)
		    for (var i = 0; i < autodeckcds.length; i++) {
		      var cd=autodeckcds[i].autoFileTypeCd;
		      var name=autodeckcds[i].autoFileTypeName;
		      var radio1=addRadio('radiogrptype_id_'+i,'radiogrptype',cd,name);  
		      var label1=addLabel('radiogrptype_id_'+i,'radiogrptype',cd,name);
		      jQuery('#span_output_file_type_id').append(radio1).append(label1).append("<br/><br/>");
		    }
		
		 
		jQuery("input[name='radiogrptype']").each(function(index,domEle){
		   
		  if(jQuery(this).val()==type){
		  jQuery(this).attr('checked','true');
		    
		  }
		});
      //output type
   	 jQuery("input[name='radiogrptype']").click( function () {
   	     ////console.log("deck up");
   	         //alert( table.rows('.selected').data().length +' row(s) selected' );
   		displayTemplate(this);
   	     } );
//   	 jQuery("input[name='is_provisional']").click( function () {
//   	     ////console.log("deck up");
//   	         //alert( table.rows('.selected').data().length +' row(s) selected' );
//   		displaySchedule(this);
//   	     } );
   	 
   	 //link,attachment file type //sendoption

		jQuery("input[name='sendoption']").each(function(index,domEle){
			   
			  if(jQuery(this).val()==target.sendOption){
			  jQuery(this).prop('checked',true);
			    
			  }
			});
   	 
   	 //zipoutput
   	 
		jQuery("input[name='zipoutput']").each(function(index,domEle){
			   
			  if(jQuery(this).val()==target.zipOutput){
			  jQuery(this).prop('checked',true);
			    
			  }
			});
		
		
		
		
		
		
		
		
		
		
	//	appandDate
		
		var ifAppendDate=target.appendDate;
		if(ifAppendDate!='N'){
			
			ifAppendDate='Y';
			
		}
		jQuery("input[name='appandDate']").each(function(index,domEle){
			   
			  if(jQuery(this).val()==ifAppendDate){
			  jQuery(this).prop('checked',true);
			    
			  }
			});	
		
//date type
		
//span-datatype-id appendfileCd appendfileCd		
		
		var deckAppendTypes=this.jsonDeck.appendfiles;

		
		    for (var i = 0; i < deckAppendTypes.length; i++) {
		      var cd=deckAppendTypes[i].appendfileCd;
		      var name=deckAppendTypes[i].appendfileDesc;
		      var radio1=addRadio('dateTypeid_'+i,'dateType',cd,name);  
		      var label1=addLabel('dateTypeid_'+i,'dateType',cd,name);
		      jQuery('#span-datatype-id').append(radio1).append(label1).append("<br/><br/>");
		    }
		
	//	appandDate
		
		jQuery("input[name='dateType']").each(function(index,domEle){
			   
			  if(jQuery(this).val()==target.appendDate){
			  jQuery(this).prop('checked',true);
			    
			  }
			});	
			
	//outline
		
		if (target.isOutline=='Y'){
			
			 jQuery('#is_outline').prop('checked',true);
		}
		//
		 //template for the ppt output:templates,templateCd,templateName
		
		var deckTemplates=this.jsonDeck.templates;

		
	    for (var i = 0; i < deckTemplates.length; i++) {
	      var cd=deckTemplates[i].templateCd;
	      var name=deckTemplates[i].templateName;
	      var radio1=addRadio('templateid_'+i,'template_cd',cd,name);  
	      var label1=addLabel('templateid_'+i,'template_cd',cd,name);
	      jQuery('#span-template-radio').append(radio1).append(label1).append(" ");
	    }
		jQuery("input[name='template_cd']").each(function(index,domEle){
			   
			  if(jQuery(this).val()==target.autofileTemplate){
			  jQuery(this).prop('checked',true);
			    
			  }
			});
		
		//paste type for the ppt output

		var pastTypes=this.jsonDeck.pptPastetypes;
	    for (var i = 0; i < pastTypes.length; i++) {
	      var cd=pastTypes[i].typeId;
	      var name=pastTypes[i].typeName;
	      var radio1=addRadio('pasteTypeid_'+i,'pasteType',cd,name);  
	      var label1=addLabel('pasteTypeid_'+i,'pasteType',cd,name);
	      jQuery('#span_pasteTypeid').append(radio1).append(label1).append(" ");
	    }
		jQuery("input[name='pasteType']").each(function(index,domEle){
			   //code change always select 1 enhance bitmap 2018.01
			  if(jQuery(this).val()=='1'){
			  jQuery(this).prop('checked',true);
			    
			  }
			});	
		controlTemplateByType(this.output_type);
		controlAppandDateBy(target.appendDate);
		controlZipByLinkOrAttachment(target.sendOption);
		document.getElementById('div_pastetype').style.display="none";
}

//email tab
AutodeckPanel.prototype.loadTab3 = function() {

    var deck =this.autodeck;

    var email = deck.emailAddress;
   
    var backup=deck.backupOwner;
    var comments=deck.emailComments;
    var subject=deck.emailSubject;
    //var table = jQuery('#table_running_log_id').DataTable();
jQuery('#autodeck_textarea_e_mail_address_id').val(email);
jQuery('#autodeck_text_e_mail_subject_id').val(subject);
jQuery('#autodeck_text_backup_owner_id').val(backup);
jQuery('#autodeck_email_comments_id').val(comments);
//console.log("tab3 loaded;");


}
//config tab
AutodeckPanel.prototype.restoreConfig= function() {
	  // type cd for output file
	  // 1  xls
	  // 2  ppt
	  // 3  xlsx
	  var self =this;

	  if(self.output_type=='2'){
	//handle ppt config and hide xls 
		 // jQuery('#xlssource_template').hide();
		  
		  
		  var configs=self.jsonDeck.configs;
	    var table_config= jQuery('#config_ppt_table').DataTable();
	    table_config.rows().remove().draw(false)
	    for (var i = 0; i < configs.length; i++) {
	        var config= configs[i];	  	            
	            var input_col_1 = config.slide;
	            
	            var input_col_2 = config.id.requestId;
	         
	          
	            var input_col_3 = config.sheet;;

	            var input_col_4 = config.range;
	            var input_col_5 = config.hideRows;
	            var input_col_6 = config.hideColumns;
	            var input_col_7 = config.headerText;
	            var input_col_8 = config.autofitRows;
	            var input_col_9 = config.autofitColumns;
	            var input_col_10 = config.customColumnWidth;
	            var input_col_11 = config.customRowHeight;
	            var input_col_12= config.wrapTextRows;
	            var input_col_13= config.disGridline;
	            var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7,input_col_8,input_col_9,input_col_10,input_col_11,input_col_12,input_col_13]

	            table_config.row.add(dataSet);
	    }

	    table_config.draw();
	  }//end ppt
	  else{
	//handle excel config xls_confit_table 
		  //jQuery('#config_ppt_div').hide();
		  
		  var configs=self.jsonDeck.configXLSs;
		  
		  var table_config= jQuery('#xls_confit_table').DataTable();
		  table_config.rows().remove().draw(false);
		    for (var i = 0; i < configs.length; i++) {
		        var config= configs[i];
	            
		            var input_col_1 = config.id.requestId;
		         
		          
		            var input_col_2 = config.sheet;;

		            var input_col_3 = config.newSheetName;
		            var input_col_4 = config.range;
		            var input_col_5 = config.hideRows;
		            var input_col_6 = config.hideColumns;
		          
		            var input_col_7 = config.autofitRows;
		            
		            var input_col_8 = config.autofitColumns;
		            var input_col_9 = config.customColumnWidth;
		            var input_col_10 = config.customRowHeight;
		            var input_col_11 = config.wrapTextRows;
		            var input_col_12= config.disGridline;
		         
		            var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7,input_col_8,input_col_9,input_col_10,input_col_11,input_col_12]

		            table_config.row.add(dataSet).draw();
		            //console.log("add one");


	  }
		    table_config.draw();
	  }

	  var isEditable=false;
	  //console.log("isdefault:"+this.isDefault);
	    if(this.isDefault=="N"){
	//if it is not default,then the user can edit the templatef
	     var isEditable=true;
	    }
	     if(isEditable){
	  	   

	  	   this.setEditConfig(); 
	  	   
	  	   
	  	   
	     }
	   
	    //var table = jQuery('#table_running_log_id').DataTable();

	//console.log("tab5 loaded;");


	}


//schedule tab
AutodeckPanel.prototype.loadTab4 = function() {
	var deckInfo=this.autodeck;
	//'Final' deck update
	//finalDeckWeekNo final_weekly
	
	jQuery("input[name='final_weekly']").each(function(index,domEle){
		   
		  if(jQuery(this).val()==deckInfo.finalDeckWeekNo){
		  jQuery(this).prop('checked',true);
		    
		  }
		});	
	
	
	//time  final_deck_time_id
	
	
	 jQuery("#final_deck_time_id").val(deckInfo.finalDeckTime).trigger("change");
	
	//TBS input
	
	
	//schedule frq  schedFreq sched_freq
		
		jQuery("input[name='sched_freq']").each(function(index,domEle){
			   
			  if(jQuery(this).val()==deckInfo.schedFreq){
			  jQuery(this).prop('checked',true);
			    
			  }
			});	
		 
	//daily
		if(deckInfo.schedFreqDetail!=""){
		var strDetailList = deckInfo.schedFreqDetail.split(","); 
		jQuery('#id_D_sched_freq_detail').val(strDetailList).trigger("change");
		
		
	//monthly
	
		jQuery('#id_M_sched_freq_detail').val(strDetailList).trigger("change");
	//gmt DropDownTimezone
		}
		jQuery("#DropDownTimezone").val(deckInfo.gmtTime).trigger("change");
	//provisional deck
	//is_provisional
//		if(deckInfo.provisional=='Y'){
//		 jQuery('#is_provisional').prop('checked',true);
//		}
		
		jQuery("#is_provisional").val(deckInfo.provisional).trigger("change");
		displaySchedule();
		//expire date
	var expDate=this.autodeck.expirationDate;
	
	var newDate = new Date();

	newDate.setTime(expDate);
	//newDate.format('yyyy-MM-dd');
	//newDate.format('yyyy/MM/dd')
	jQuery('#id_expiration_date').val(newDate.format('yyyy-MM-dd'));
	
	
	
}



	//config tab
AutodeckPanel.prototype.loadTab5 = function() {
  // type cd for output file
  // 1  xls
  // 2  ppt
  // 3  xlsx
  var self =this;
  var displayTab=false;
  var linksForPreview='<a  href="#t1" onclick="javascript:createPreview(this)" name="autodeck_href_id14">Generate preview</a>|<a   href="#t1" onclick="javascript:showPreview(this);" name="autodeck_href_id15">Show preview</a>';
  if(self.output_type=='2'){
//handle ppt config and hide xls 
	  jQuery('#xlssource_template').hide();
	  
	
	  var configs=self.jsonDeck.configs;
    var table_config= jQuery('#config_ppt_table').DataTable({
        "bSort": false , //no sort needed
        "searching": false,//filter disable
        "bAutoWidth": true,//
        "sScrollX": "100%",
        "bPaginate": false,
        "sScrollXInner": "110%",
        "bScrollCollapse": true,
        "bInfo": true,     
        'columnDefs': [
                       {
                          'targets': 0,
                          'render': function(data, type, row, meta) {
                              return '<input type="checkbox" name="checklist" value="' + row.id + '" />'
                          }
                       },
                       {
	                          'targets': -1,
	                          'render': function(data, type, row, meta) {
	                              return linksForPreview;
	                          },
	                          
	                       }
                    ]
    });

    for (var i = 0; i < configs.length; i++) {
        var config= configs[i];
  
            
            var input_col_1 = config.slide;
            
            var input_col_2 = config.id.requestId;
         
          
            var input_col_3 = config.sheet;;

            var input_col_4 = config.range;
            var input_col_5 = config.hideRows;
            var input_col_6 = config.hideColumns;
            var input_col_7 = config.headerText;
            var input_col_8 = config.autofitRows;
            var input_col_9 = config.autofitColumns;
            var input_col_10 = config.customColumnWidth;
            var input_col_11 = config.customRowHeight;
            var input_col_12= config.wrapTextRows;
            var input_col_13= config.disGridline;
            var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7,input_col_8,input_col_9,input_col_10,input_col_11,input_col_12,input_col_13]

            table_config.row.add(dataSet);
    }
    table_config.draw();
if (configs.length>0){
	displayTab=true;
	
	
}
  }//end ppt
  else{
//handle excel config xls_confit_table 
	  jQuery('#config_ppt_div').hide();
	  
	  var configs=self.jsonDeck.configXLSs;
	 
	  var table_config= jQuery('#xls_confit_table').DataTable({
	        "bSort": false , //no sort needed
	        "searching": false,//filter disable
	        "bAutoWidth": true,//
	        "sScrollX": "100%",
	        "bPaginate": false,
	        "sScrollXInner": "110%",
	        "bScrollCollapse": true,
	        "bInfo": false,     
	        'columnDefs': [
	                       {
	                          'targets': 0,
	                          'render': function(data, type, row, meta) {
	                              return '<input type="checkbox" name="checklist" value="' + row.id + '" />'
	                          },
	                          
	                       },
	                       {
		                          'targets': -1,
		                          'render': function(data, type, row, meta) {
		                              return linksForPreview;
		                          },
		                          
		                       }
	                    ]
	    });

	    for (var i = 0; i < configs.length; i++) {
	        var config= configs[i];
	  
	            
	        
	            
	            var input_col_1 = config.id.requestId;
	         
	          
	            var input_col_2 = config.sheet;;

	            var input_col_3 = config.newSheetName;
	            var input_col_4 = config.range;
	            var input_col_5 = config.hideRows;
	            var input_col_6 = config.hideColumns;
	          
	            var input_col_7 = config.autofitRows;
	            
	            var input_col_8 = config.autofitColumns;
	            var input_col_9 = config.customColumnWidth;
	            var input_col_10 = config.customRowHeight;
	            var input_col_11 = config.wrapTextRows;
	            var input_col_12= config.disGridline;
	         
	            var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7,input_col_8,input_col_9,input_col_10,input_col_11,input_col_12]

	            table_config.row.add(dataSet);
	            //console.log("add one");


  }   table_config.draw();
	    
	    
	    if (configs.length>0){
	    	displayTab=true;
	    	
	    	
	    }
  }

  var isEditable=false;
  //console.log("isdefault:"+this.isDefault);
    if(this.isDefault=="N"){
//if it is not default,then the user can edit the templatef
     var isEditable=true;
    }
     if(isEditable){
  	   

  	   this.setEditConfig(); 
  	   
  	   
  	   
     }
   
    //var table = jQuery('#table_running_log_id').DataTable();

//console.log("tab5 loaded;");
     controlConfigButton(this.isDefault);

     if(!displayTab){
	//hide the tab
	jQuery('#li_config').hide();
	jQuery('#autodeck_config_temp_id').hide();

     } 
}

 function controlConfigButton(newValue) {
	//request rest,edit template.export .import
	if(newValue	=="Y"){
		//system default generated
		
		jQuery("#id-set-default").attr("disabled",true);;
		jQuery("#id-set-edit").attr("disabled",false);;

		
		jQuery("#id-import").attr("disabled",true);;
		jQuery("#id-export").attr("disabled",true);;
		jQuery('#load_default_id').hide();
	}else{
	//user edit mode	
		
		jQuery("#id-set-default").attr("disabled",false);;
		jQuery("#id-set-edit").attr("disabled",true);;

		
		jQuery("#id-import").attr("disabled",false);;
		jQuery("#id-export").attr("disabled",false);;
		
		jQuery('#load_default_id').show();
	}
	
	
	
	

	}
 
 var alreadyEdit=false;
 function setEdit() {
	    var isSetDefault="N";

	controlConfigButton(isSetDefault);
	var output_type=jQuery("input[name='radiogrptype']:checked").val();
	
if(autodeckPanel.isDefault=="N"){
	//set pptable to display or edit base on the last tab
//orighinal is edit mode,so just dsialy
	jQuery('#reset_notice').hide();
	}else{
		
	if(alreadyEdit){
		//just display
		
		
	}else{
		autodeckPanel.bindClickToPPTConfigOperation();
		autodeckPanel.bindClickToXLSConfigOperation();
		autodeckPanel.setEditConfig();
		alreadyEdit=true;
		
	}	
		
		
		
	}
jQuery('#reset_notice').hide();
autodeckPanel.controlDsiplayDefaultEdit(isSetDefault);
	}
	function setXlsEdit() {
	//set xlsto display or edit base on the last tab
	}
	function setDefault() {
	    var isSetDefault="Y";

	controlConfigButton(isSetDefault);
	var output_type=jQuery("input[name='radiogrptype']:checked").val();
	

	//set pptable to display or edit base on the last tab

	jQuery('#reset_notice').show();
	autodeckPanel.controlDsiplayDefaultEdit(isSetDefault);
	}
	function setXlsDefault() {
	//set xlsto display or edit base on the last tab
	}
//config tab

AutodeckPanel.prototype.loadTab6 = function() {
  // type cd for output file
  // 1  xls
  // 2  ppt
  // 3  xlsx
  var self =this;
 var displayTab=false;
  if(self.output_type=='2'){
//handle ppt config
	  var configs=self.jsonDeck.initConfigs;
    var table_config_init= jQuery('#init_config_ppt_table').DataTable({
        "bSort": false , //no sort needed
        "searching": false,//filter disable
        "bAutoWidth": true,//
        "sScrollX": "100%",
        "bPaginate": false,
        "sScrollXInner": "110%",
        "bScrollCollapse": true,
        "bInfo": false,     
        'columnDefs': [
                       {
                          'targets': 0,
                          'render': function(data, type, row, meta) {
                              return '<input type="checkbox" name="checklist" value="' + row.id + '" />'
                          }
                       }
                    ]
    });

    for (var i = 0; i < configs.length; i++) {
        var config= configs[i];
  
            
            var input_col_1 = config.slide;
            
            var input_col_2 = config.id.requestId;
         
          
            var input_col_3 = config.sheet;;

            var input_col_4 = config.range;
            var input_col_5 = config.hideRows;
            var input_col_6 = config.hideColumns;
            var input_col_7 = config.headerText;
           
            var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7]

            table_config_init.row.add(dataSet);
    }
    table_config_init.draw();
  var isEditable=false;
  
  if (configs.length>0){
  	displayTab=true;
  	
  	
  }
 
  jQuery('#xls_config_init').hide();
  jQuery('#init_config_xls_table').hide();

  }else{
//handle excel config
	  jQuery('#ppt_config_init').hide();
	  var configs=self.jsonDeck.initconfigXLSs;
	//handle excel config init_config_xls_table
   
		  var table_config= jQuery('#init_config_xls_table').DataTable({
		        "bSort": false , //no sort needed
		        "searching": false,//filter disable
		        "bAutoWidth": true,//
		        "sScrollX": "100%",
		        "bPaginate": false,
		        "sScrollXInner": "110%",
		        "bScrollCollapse": true,
		        "bInfo": true,     
		        'columnDefs': [
		                       {
		                          'targets': 0,
		                          'render': function(data, type, row, meta) {
		                              return '<input type="checkbox" name="checklist" value="' + row.id + '" />'
		                          }
		                       }
		                    ]
		    });

		    for (var i = 0; i < configs.length; i++) {
		        var config= configs[i];
		  
		            
		        
		            
		            var input_col_1 = config.id.requestId;
		         
		          
		            var input_col_2 = config.sheet;;

		            var input_col_3 = config.newSheetName;
		            var input_col_4 = config.range;
		            var input_col_5 = config.hideRows;
		            var input_col_6 = config.hideColumns;
		        //    var input_col_7 = config.autofitRows;
//		            var input_col_8 = config.autofitColumns;
//		            var input_col_9 = config.customColumnWidth;
//		            var input_col_10 = config.customRowHeight;
//		            var input_col_11 = config.wrapTextRows;
//		            var input_col_12= config.disGridline;
		         
		            //var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6, input_col_7,input_col_8,input_col_9,input_col_10,input_col_11,input_col_12]
		            var dataSet = [i,input_col_1, input_col_2, input_col_3, input_col_4, input_col_5, input_col_6]

		            table_config.row.add(dataSet);
		    }
		    table_config.draw();
		    if (configs.length>0){
		    	displayTab=true;
		    	
		    	
		    }

  }
  
//	if(this.isDefault=="Y"){
//		 jQuery('#button-id-copy').hide();
//	}
   
  

//console.log("tab6 loaded;");
if(displayTab==false){
	
	
	jQuery('#li_init_config').hide();
	jQuery('#autodeck_config_base_id').hide();
}

}
// running log tab
    AutodeckPanel.prototype.loadTab7 = function() {

        this.runningLogs = this.jsonDeck.logs;
   
        var logs = this.runningLogs;
       
        var table_log = jQuery('#table_running_log_id').DataTable( {
            "aaSorting": [[2,'desc'], [3,'desc']]
        });
   
        //var table = jQuery('#table_running_log_id').DataTable();

    if(logs.length<1){
    	jQuery('#li_log').hide();
    	jQuery('#autodeck_schedule_history_id').hide();
    }

        for (var i = 0; i < logs.length; i++) {
            var log = logs[i];
      
                //cognos schedule request
                var input_col_1 = log.runningId;
                
                var input_col_2 = ToDate(log.runTime);
             
              
                var input_col_3 = ToDate(log.doneTime);;
                var statusCode=jQuery.trim(log.statusCode);
                var displayStatusFWCR="Failed";
               
               
                	//new codes
                	
            if (statusCode.substr(0, 2)=='C_'){
            	  input_col_1 = "<a href=" + myTbsContext + "/action/portal/autodeck/downloadDeckByLink/"
       			+ this.deck_id + "/" + log.runningId+"/"+ this.extName
       			+ " target='_blank'>"
       			+  log.runningId;
       			+ "</a>";	
       			displayStatusFWCR="Success";
            	
            	
            }else if   (statusCode.substr(0, 2)=='R_'){
            	displayStatusFWCR="Running";
            }else if   (statusCode.substr(0, 2)=='W_'){
            	displayStatusFWCR="Warning";
            }else if   (statusCode.substr(0, 2)=='F_'){
            	displayStatusFWCR="Failed";
            }
            
                	
                	
                
                var input_col_4 =displayStatusFWCR;
                var input_col_5 = log.message;
                var input_col_6 = log.ifSendMail;
                var input_col_7 = log.provisional;
               
                var dataSet = [input_col_1, input_col_2, input_col_3, input_col_4,input_col_5, input_col_6, input_col_7]

                table_log.row.add(dataSet);
        }
        table_log.draw();
        //console.log("tab7 loaded;");
}
    
    //add click to each of the buttion in  operations bar for XLS config templates
    AutodeckPanel.prototype.bindClickToXLSConfigOperation= function() {
//

    	 jQuery('#xls_moveup').click( function () {
    	     ////console.log("deck up");
    	         //alert( table.rows('.selected').data().length +' row(s) selected' );
    	     var mytable=   new CTable("xls_confit_table");
    	     mytable.up();
    	     } );

    	  jQuery('#xls_movedown').click( function () {
    	     ////console.log("deck down");
    	     var mytable1=   new CTable("xls_confit_table");
    	     mytable1.down();
    	         //alert( table.rows('.selected').data().length +' row(s) selected' );
    	     } );
    	 jQuery('#xls_add').click( function () {
    		 addXlsConfig();
    	     } );

    	   jQuery('#xls_remove').click( function () {
    	     ////console.log("deck delete");
    	     //table.rows('.selected').remove().draw( false );
    	     //    alert( table.rows('.selected').data().length +' row(s) selected' );
    		   var mytable=   new CTable("xls_confit_table");
      	     mytable.del(); 
    	     } );
    	     	
    	
      
}
    //add click to each of the buttion in  operations bar for PPT config templates
    AutodeckPanel.prototype.bindClickToPPTConfigOperation= function() {
//

    	 jQuery('#ppt_up').click( function () {
    	     ////console.log("deck up");
    	         //alert( table.rows('.selected').data().length +' row(s) selected' );
    	     var mytable=   new CTable("config_ppt_table");
    	     mytable.up();
    	     } );

    	  jQuery('#ppt_down').click( function () {
    	     ////console.log("deck down");
    	     var mytable1=   new CTable("config_ppt_table");
    	     mytable1.down();
    	         //alert( table.rows('.selected').data().length +' row(s) selected' );
    	     } );
    	 jQuery('#ppt_add').click( function () {
    	     ////console.log("deck select more");
    		 addPptConfig();
    	         //alert( table.rows('.selected').data().length +' row(s) selected' );
    	     } );

    	   jQuery('#ppt_remove').click( function () {
    	     ////console.log("deck delete");
    	     //table.rows('.selected').remove().draw( false );
    	     //    alert( table.rows('.selected').data().length +' row(s) selected' );
    		   var mytable=   new CTable("config_ppt_table");
      	     mytable.del(); 
    	     } );
    	     	
    	
      
}  
    //according to the output type and isdefault to display the templates table and operation bar
    AutodeckPanel.prototype.hideDislayTemplate = function(defaultValue) {
    	if(this.output_type=='2'){
//this.isDefault
    		jQuery('#config_ppt_div').show();
    		 if(defaultValue=="N"){
    			//if it is not default,then the user can edit the templatef
    			 jQuery('#ppt_conifg_operation').show();
    			 this.bindClickToPPTConfigOperation();
    			    }else{
    			    	//default
    		jQuery('#ppt_conifg_operation').hide();
    	            }
    		 jQuery('#config_ppt_table').show()


    		jQuery('#xlssource_template').hide();
    		
    		
    	}else{
    		//excel

    		jQuery('#config_ppt_div').hide();

    	


    		jQuery('#xlssource_template').show();
    		
    		jQuery('#xls_conifg_operation').hide();
    		
    		 if(defaultValue=="N"){
     			//if it is not default,then the user can edit the templatef
    			 jQuery('#xls_conifg_operation').show();
    			 this.bindClickToXLSConfigOperation();
     			    }else{
     			    	//default
     			    	jQuery('#xls_conifg_operation').hide();
     	            }
    		
    		jQuery('#xls_confit_table').show();
    			
    		
    		
    		
    	}
    
    	
    }
    AutodeckPanel.prototype.setEditConfig = function() {
    	
    	 //console.log("edit config;");
    	var editExcelConfig=true;
    	if(this.output_type=='2'){
    		//ppt
    		 //console.log("edit config; ");
    		editExcelConfig=false;
    		
    	}
        if(editExcelConfig){
        	jQuery('#xls_conifg_operation').show();
        	jQuery('#xls_confit_table tbody tr').each(function () {
        		if(jQuery(this).attr("edit")!='yes'){
	    	    
    	    	var autoSizeRowPos=7;
            var autoSizeColumnPos=8
            var gridDisPos=12;
            var previewDisPos=13;
            var rIdPos=1;
            var worksheetPos=2;
            var nworksheetPos=3;
    	    	     jQuery("td:gt(0)",this).each(function(){
    	    	        ////console.log(this);
    	    	       
    	    	       var jqob=jQuery(this);
    	    	       var txt=jqob.text();
                   var put;;
                   if(jqob.index()==previewDisPos){
                	   
                   }else{
                               if(jqob.index()==autoSizeRowPos||jqob.index()==autoSizeColumnPos||jqob.index()==gridDisPos){
                              // var put=jQuery("<input type='text' />");
                              // var put=jQuery("<select/>");
                               selVal=txt;
//                        jQuery("<option></option>").val('Y').text("Y").appendTo(jQuery(put));
//                        jQuery("<option></option>").val('N').text("N").appendTo(jQuery(put));
//                        jQuery(put).val(selVal);
                        var checkedY="";
                        var checkedN="";
                        if(selVal=='Y'){
                        	checkedY="selected=\"selected\"";
                        }else{
                        	checkedN="selected=\"selected\"";
                        }
                        	
                        
                        
                        var option1='<option value="N" '+checkedN+'>NO</option>';
                        var option2='<option value="Y" '+checkedY+'>YES</option>';
                       put = "<select>" + option1+option2 +"</select>";
                        console.log("put:"+put);
                        //<select><option value="Y">Y</option><option value="N">N</option></select>
                        
                        
                        
                        
                        
                               }else{
                            	   var lentghStr="";
                            	   if(jqob.index()==rIdPos){
                            		   
                            		   lentghStr="38";
                            	   }
                            	   if(jqob.index()==worksheetPos){
                            		   
                            		   lentghStr="15";
                            	   }
                            	   	if(jqob.index()==nworksheetPos){
                            		   
                            		   lentghStr="15";
                            	   }
                            	   
                            		if(jqob.index()==4){
                             		   
                             		   lentghStr="12";
                             	   }
                            		if(jqob.index()==5){
                              		   
                              		   lentghStr="10";
                              	   }
                            		if(jqob.index()==6){
                               		   
                               		   lentghStr="10";
                               	   }
                            		if(jqob.index()==9){
                               		   
                               		   lentghStr="10";
                               	   }
                            		if(jqob.index()==10){
                                		   
                                		   lentghStr="10";
                                	   }
                            		if(jqob.index()==11){
                             		   
                             		   lentghStr="6";
                             	   }
                            		 if(jqob.index()==rIdPos){
                            			 var put="<input  class='deck-input' onblur=\"displayInfo()\" size='"+lentghStr+"'   title ='"+txt+"' value='"+txt+"' type='text'/>";	 
                            			 
                            		 }else{
                            	   var put="<input  class='deck-input' size='"+lentghStr+"'   title ='"+txt+"' value='"+txt+"' type='text'/>";
                                   
                            		 }//console.log(txt);
    	    	                  // put.val(txt);
                               }
                              // console.log(jQuery(put).html());
    	    	                   jqob.html(put);
    	    	       
                   }
    	    	      // //console.log(jQuery(this));
    	    	       
    	    	     });
    	    	     jQuery(this).attr("edit","yes"); 
        		}
    	    	   });  
           	if(!this.setEdit){
           	

           	    this.setEdit=true;
           	        		
    var table = jQuery('#xls_confit_table').DataTable();
    table.columns.adjust().draw();
           	} 
        	
        }else{
        //ppt	
        	jQuery('#ppt_conifg_operation').show();

        	jQuery('#config_ppt_table tbody tr').each(function () {
        		if(jQuery(this).attr("edit")!='yes'){
    	    	var slideNoPos=1;
    	    	var requestIdPos=2;	
        			var autoSizeRowPos=8;
            var autoSizeColumnPos=9;
            var gridDisPos=13;
            previewDisPos=14;
    	    	     jQuery("td:gt(0)",this).each(function(){
    	    	        ////console.log(this);
    	    	       
    	    	       var jqob=jQuery(this);
    	    	       var txt=jqob.text();
                   var put;;
if(jqob.index()==previewDisPos){
                	   
}else{
                               if(jqob.index()==autoSizeRowPos||jqob.index()==autoSizeColumnPos||jqob.index()==gridDisPos){
//                            	   var put=jQuery("<select/>");
                                   selVal=txt;
//                            jQuery("<option></option>").val('Y').text("Y").appendTo(jQuery(put));
//                            jQuery("<option></option>").val('N').text("N").appendTo(jQuery(put));
//                            jQuery(put).val(selVal);
                                   var checkedY="";
                                   var checkedN="";
                                   if(selVal=='Y'){
                                   	checkedY="selected=\"selected\"";
                                   }else{
                                   	checkedN="selected=\"selected\"";
                                   }
                                   	
                                   var option1='<option value="N" '+checkedN+'>NO</option>';
                                   var option2='<option value="Y" '+checkedY+'>YES</option>';
                                  put = "<select>" + option1 +option2 +"</select>";
                                   
                               }else{
//    	    	                   var put=jQuery("<input type='text' value='' />");
//                                   //console.log(txt);
//    	    	                   put.val(txt);
                            	   var lentghStr="";
                            	   if(jqob.index()==1){
                            		   
                            		   lentghStr="3";
                            	   }
 if(jqob.index()==2){
                            		   
                            		   lentghStr="38";
                            	   }
 if(jqob.index()==3){
	   
	   lentghStr="15";
 }
 if(jqob.index()==4){
	   
	   lentghStr="15";
}
 if(jqob.index()==5){
	   
	   lentghStr="6";
}
 if(jqob.index()==6){
	   
	   lentghStr="6";
}
 if(jqob.index()==7){
	   
	   lentghStr="30";
}
 if(jqob.index()==10){
	   
	   lentghStr="10";
}
 if(jqob.index()==11){
	   
	   lentghStr="10";
}
 if(jqob.index()==12){
	   
	   lentghStr="10";
}
 if(jqob.index()==2){
	   
	 var put="<input class='deck-input' onblur=\"displayInfo()\"  size='"+lentghStr+"'   title ='"+txt+"' value='"+txt+"' type='text'/>";
 }else{
 var put="<input class='deck-input' size='"+lentghStr+"'   title ='"+txt+"' value='"+txt+"' type='text'/>";
 }
                               }
                              // console.log(put);
    	    	                   jqob.html(put);
    	    	       
    	    	       
    	    	      // //console.log(jQuery(this));
} 	       
    	    	     });
    	    	     jQuery(this).attr("edit","yes");	
        		
        		}	        
    	    	   }); 
        	//end each
        	if(!this.setEdit){
    var table = jQuery('#config_ppt_table').DataTable();
    table.columns.adjust().draw();

    this.setEdit=true;
        	} 	
        	
        	
        }
        AutodeckPanel.prototype.controlDsiplayDefaultEdit= function(defaultValue) {
        	if(this.output_type=='2'){
    //this.isDefault
        		
        		 if(defaultValue=="N"){
        			//if it is not default,then the user can edit the templatef
        			 
        			// this.bindClickToPPTConfigOperation();
        			 jQuery('#config_ppt_div').show();
        			 
        		 }else{
        			    
        			 jQuery('#config_ppt_div').hide();
        			 //default
        		
        	            }
        		

        		jQuery('#xlssource_template').hide();
        		
        		
        	}else{
        		//excel

        		jQuery('#config_ppt_div').hide();

        	


        		jQuery('#xlssource_template').show();
        		
        		
        		 if(defaultValue=="N"){
        			 jQuery('#xlssource_template').show();
         			    }else{
         			    	//default
         			    	jQuery('#xlssource_template').hide();
         	            }
        		
        		
        			
        		
        		
        		
        	}
        
        	
        }  
        AutodeckPanel.prototype.setEditBaseConfig = function() {
        	
        	
        	
        	
        	
        }
        
        
     
   displayInfo();     
}
    
    function addPptConfig(){
    	//create a new table


    	  
    	  
    	  
    	  var rowRequest=document.getElementById('config_ppt_table').rows;


    		if(getMaxSlide()>=maxPPtSlideNo){

    		alert("Warning:you will not be able to submit this deck until the content is within the "+maxPPtSlideNo+" slide max size!");


    		}

    		var1='1000';;
    		var2=rowRequest[1].cells[1].innerHTML;
    		var3=rowRequest[1].cells[2].innerHTML;
    		var4=rowRequest[1].cells[3].innerHTML;
    		var5=rowRequest[1].cells[4].innerHTML;;
    		var6=rowRequest[1].cells[5].innerHTML;;
    		var7=rowRequest[1].cells[6].innerHTML;

    		var var8=rowRequest[1].cells[7].innerHTML;
    		var var9=rowRequest[1].cells[8].innerHTML;
    		var var10=rowRequest[1].cells[9].innerHTML;
    		var var11=rowRequest[1].cells[10].innerHTML;
    		var var12=rowRequest[1].cells[11].innerHTML;
    		var var13=rowRequest[1].cells[12].innerHTML;
    		var var14=rowRequest[1].cells[13].innerHTML;
    		addPPtConfigcol(var1,var2,var3,var4,var5,var6,var7,var8,var9,var10,var11,var12,var13,var14);

    		var numRow=rowRequest.length-1; 


    		jQuery(':text',rowRequest[numRow].cells[1])[0].value=parseInt(getMaxSlide())+1;
    		 //loadDisplayMessage();
    		 displayInfo();	
    	}
    function regSlideNo(){
    	
    	var rowRequest=document.getElementById('config_ppt_table').rows;


    	for (var i=1;i<rowRequest.length;i++){

    	jQuery(':text',rowRequest[i].cells[1])[0].value=i+1;

    	}
    		
    		
    		
    		}
    function addPPtConfigcol(col2,col3,col4,col5,col6,col7,col8,coln1,coln2,coln3,coln4,coln5,col9,colnew){   
    	var   self=document.getElementById('config_ppt_table');;
    	var   tr   =   self.tBodies[0].insertRow(-1),td1=   tr.insertCell(-1),td2=   tr.insertCell(-1),td3=   tr.insertCell(-1),td4= tr.insertCell(-1),td5=tr.insertCell(-1),td6=tr.insertCell(-1),td7=tr.insertCell(-1);; 
    	td8=tr.insertCell(-1);
    	td9=tr.insertCell(-1);
    	td10=tr.insertCell(-1);

    	td11=tr.insertCell(-1);
    	td12=tr.insertCell(-1);
    	td13=tr.insertCell(-1);
    	tdnew=tr.insertCell(-1);
    	var   chkbox=document.createElement("INPUT"); 
    	chkbox.type="checkbox" ;
    	chkbox.id = "id_" + col2;
    	chkbox.name = "name_" + col2;
    	chkbox.value=col2;
    	chkbox.checked="checked";
    	//chkbox.onclick=self.highlight.bind(self)  
    	td1.appendChild(chkbox); 
    	td2.innerHTML=col3;
    	td3.innerHTML=col4;
    	td4.innerHTML=col5;
    	td5.innerHTML=col6;
    	td6.innerHTML=col7;
    	td7.innerHTML=col8;
    	td8.innerHTML=coln1;
    	td9.innerHTML=coln2;
    	td10.innerHTML=coln3;

    	td11.innerHTML=coln4;
    	td12.innerHTML=coln5;
    	td13.innerHTML=col9;
    	tdnew.innerHTML=colnew;

    	
    	td14=tr.insertCell(-1);

    	var linksForPreview='<a  href="#t1" onclick="javascript:createPreview(this)" name="autodeck_href_id14">Generate preview</a>|<a   href="#t1" onclick="javascript:showPreview(this);" name="autodeck_href_id15">Show preview</a>'
    	td14.innerHTML=linksForPreview;

    	
    }
    function addXlsConfig(){
    	//create a new table


    	  
    	  
    	  
    	  var rowRequest=document.getElementById('xls_confit_table').rows;


    	

    	var1='1000';;
    	var2=rowRequest[1].cells[1].innerHTML;
    	var3=rowRequest[1].cells[2].innerHTML;
    	var4=rowRequest[1].cells[3].innerHTML;
    	var5=rowRequest[1].cells[4].innerHTML;;
    	var6=rowRequest[1].cells[5].innerHTML;;
    	var7=rowRequest[1].cells[6].innerHTML;
    
    	var var8=rowRequest[1].cells[7].innerHTML;
    	var var9=rowRequest[1].cells[8].innerHTML;
    	var var10=rowRequest[1].cells[9].innerHTML;
    	var var11=rowRequest[1].cells[10].innerHTML;
    	var var12=rowRequest[1].cells[11].innerHTML;
    	var var13=rowRequest[1].cells[12].innerHTML;

    	add5col(var1,var2,var3,var4,var5,var6,var7,var8,var9,var10,var11,var12,var13);


    	 //loadDisplayMessage();
    	}

    	function add5col(col2,col3,col4,col5,col6,col7,col8,coln1,coln2,coln3,coln4,coln5,col9){     
    	var   self=document.getElementById('xls_confit_table');; 
    	var   tr   =   self.tBodies[0].insertRow(-1),td1=   tr.insertCell(-1),td2=   tr.insertCell(-1),td3=   tr.insertCell(-1),td4= tr.insertCell(-1),td5=tr.insertCell(-1),td6=tr.insertCell(-1),td7=tr.insertCell(-1);; 
    	td8=tr.insertCell(-1);
    	td9=tr.insertCell(-1);
    	td10=tr.insertCell(-1);
    	td11=tr.insertCell(-1);
    	td12=tr.insertCell(-1);
    	td13=tr.insertCell(-1);
    	var   chkbox=document.createElement("INPUT"); 
    	chkbox.type="checkbox" ;
    	chkbox.id = "id_" + col2;
    	chkbox.name = "name_" + col2;
    	chkbox.value=col2;
    	chkbox.checked="checked";
    	//chkbox.onclick=self.highlight.bind(self)
    	td1.appendChild(chkbox);
    	td2.innerHTML=col3;
    	td3.innerHTML=col4;
    	td4.innerHTML=col5;
    	td5.innerHTML=col6;
    	td6.innerHTML=col7;
    	td7.innerHTML=col8;
    	td8.innerHTML=coln1;
    	td9.innerHTML=coln2;
    	td10.innerHTML=coln3;
    	td11.innerHTML=coln4;
    	td12.innerHTML=coln5;
    	td13.innerHTML=col9;
    	  addedPreviewLinks="Y";
    	if(addedPreviewLinks=='Y'){
    	td14=tr.insertCell(-1);

    	var linksForPreview='<a  href="#t1" onclick="javascript:createPreview(this)" name="autodeck_href_id14">Generate preview</a>|<a   href="#t1" onclick="javascript:showPreview(this);" name="autodeck_href_id15">Show preview</a>'
    	td14.innerHTML=linksForPreview;

    	}

    	}
    	var sortSeq=0;
    	function sortOrder(){
    	var mystable=new CTable("config_ppt_table");
    	if(sortSeq==0){
    mystable.sort(1);
    	sortSeq=1;
    	}else{
    	mystable.sortDown(1);
    	sortSeq=0;
    	}
    	
    	
    	}
