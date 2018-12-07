//http://rateyo.fundoocode.ninja

function uploadListFormatDate(timestamp){
	var myNewDate = new Date();
	myNewDate.setTime(timestamp); 
	var hours = filterNum(myNewDate.getHours());
	var min = filterNum(myNewDate.getMinutes());
	var seconds = filterNum(myNewDate.getSeconds());
	return myNewDate.getFullYear()+"-"+(myNewDate.getMonth()+1)+"-"+myNewDate.getDate()+" "+hours+":"+min+":"+seconds; 
}
var rankConfig=({
        star: {
            enabled: false,
            normalFill: "#808080",
            ratedFill: "#F39C12",//default color
            numStars: 5,//five stars,maybe in the further ,get from db
            maxValue: 5,
            numStars: 1,
            precision: 1,
            starWidth: "25px",
            halfStar: true,
            fullStar: false,
            readOnly: true,
            spacing: "0px",
            rtl: false
        },
        desc: {
            enabled: true
        },
        option: {
            type: "__REPLACE_ME__"
        }
    });
function addRow(comEntry,i) {
//
//    var rowTem1 = '<tr class="tr_' + i + '">'
////   		+ '<td>'+comEntry.comments+'</br> Created Date:'
////        +uploadListFormatDate(comEntry.createTime)+'</td>'
////        + '<td> &nbsp; By &nbsp;'+comEntry.cwaId +'</br>&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;<a href="#" onclick=delRow(this) >Reply</a></td>'
////        + '</tr>';
////    
////    
////    var rowTem = '<tr class="tr_' + i + '">'
////		+ '<td><div style="width:auto;height:auto;margin-left:auto;margin-left:auto;"> <span style="display:inline-block;">'+comEntry.comments+'</br> Created Date:'
////    +uploadListFormatDate(comEntry.createTime)+''
////    + '</span ><span style="display:inline-block;float:right"> &nbsp; By &nbsp;'+comEntry.cwaId +'</br>&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;<a href="#" onclick=replyClick(this) >Reply</a></span></div></td>'
////    + '</tr>';
    
    
    //var rowTem2="<tr><td>"+crateCommentInfo(comEntry)+"</td></tr>"
   // console.log(crateCommentInfo(comEntry));
    if(i==999){
        jQuery("#report_comment1111").prepend(crateCommentFirstInfo(comEntry));;
    }else{
    jQuery("#report_comment1111").append(crateCommentInfo(comEntry));;
    }
   //var tableHtml = $("#table tbody").html();
   // tableHtml += rowTem;
     // jQuery("#report_comment_table tbody:last").append(rowTem2);
  //  $("#table tbody").html(tableHtml);

}
function addFirstRow(comEntry) {
	addRow(comEntry,999);
//    var rowTem = '<tr class="tr_9ii">'
//   		+ '<td>'+comEntry.comments+'</br> Created Date:'
//        +uploadListFormatDate(comEntry.createTime)+'</td>'
//        + '<td> &nbsp; By &nbsp;'+comEntry.cwaId +'</br>&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;<a href="#" onclick=delRow(this) >Reply</a></td>'
//        + '</tr>';
//  
//      jQuery("#report_comment_table tbody").prepend(rowTem);


}
var reportCommentEntry=({
		"commentId": 0,
		"anonymous": "N",
		"commentType": "R",
		"comments": "",
		"createTime": 1521096972138,
		"cwaId": "liyegong@cn.ibm.com",
		"hasPic": "N",
		"lastActiveTime": 1521096972138,
		"reportPk": "888",
		"status": "A",
		"replyList": null,
		"parentID": null
	});

function ReportRank(cuuid, createTime, rankKey, rankSetId, rankValue, reportPk) {
    this.cuuid = cuuid;
    this.createTime = createTime;
    this.rankKey = rankKey;
    this.rankSetId = rankSetId;
    this.rankValue = rankValue;
    this.reportPk = reportPk;
   

}
ReportRank.prototype.draw = function(idNum) {
	var str_report = "";
	str_report += '<tr>';
	str_report+=this.getDescHtml();
	str_report +=this.getrateSartDivHtml(idNum);
	
		str_report += '</tr>';
	return str_report;
}
ReportRank.prototype.getrateSartDivHtml = function(idNum) {
	var str_td='<td>'
	var rateSartDivHtml='<div class="rating-container"><div class="ratecss" id="rateYo'+idNum+'"></div><div class="counter">'+this.rankValue+'</div></div>'
	 str_td=str_td+rateSartDivHtml;
	str_td += '</td>'
	return str_td;
}
ReportRank.prototype.getDescHtml = function() {
	var str_td='<td>'
	var rateSartDivHtml='<span class="rankdesc" >'+ this.rankKey+'</span>'
	str_td=str_td+rateSartDivHtml;
	str_td+='</td>';
	return str_td;
}





var rankNums=0;
function ReportRankMenu(data) {
    this.rankingList = data;
    this.getRptRankUrl="";
    this.saveRptRankUrl="";

}
var urlSatic="";
function loadRankingData(hosturl,cwa_id,rpt_path) {
	urlSatic=hosturl;
//call ajax	to read the data according to cwaid and cognos rpt path
console.log("ajax 111call");
	var timeid = (new Date()).valueOf();
    jQuery.ajax({
     
       type: 'GET', url: hosturl+'/action/portal/rank/getReportRanking?cwa_id=' + cwa_id + '&search_path=' + rpt_path,
        timeout : 30000,
       
       
       success: function (data) {
       
       
           if (data.length > 0) {
        	   rankNums=data.length;
        	   rankMenu=new ReportRankMenu(data);
        	   console.log(rankMenu.draw());
        	   jQuery("#rpt_ranking_div_id").html(rankMenu.draw());
        	   rankMenu.initRanking();
        	   console.log(data);
        	   if(data[0].rankValue!=0){
        		   
        		   
        		   jQuery(".ratecss").rateYo("option", "readOnly", true);   
        		  
        	   }
        	   
           }else{
           
           alert("no data returned for ranking!");
           
           
           }
       },
       error: function (data) {
           alert('An error has occurred. Please try again - ajax return error!!!');
           //jQuery("#allrpts_cognos_list_div").html("An error has occurred. Please try again later。");
       }
   });	
	
	
	
}
var report;
function loadReportData(hosturl,cwa_id,rpt_path) {
	urlSatic=hosturl;
//call ajax	to read the data according to cwaid and cognos rpt path
console.log("ajax loadReportData");
	var timeid = (new Date()).valueOf();
    jQuery.ajax({
     
       type: 'GET', url: hosturl+'/action/portal/rank/getReportByPath?cwa_id=' + cwa_id + '&search_path=' + rpt_path,
        timeout : 30000,
       
       
       success: function (data) {
       //alert('returned');
        report=data;
       console.log(report.reportPk);
       if(typeof(report.reportPk) == 'undefined'||report.reportPk==''|| report.reportPk == null){
    	   
    	  alert("Sorry,no report informaton found."); 
    	   return;
       }
       loadReportInfo(report);
       loadReportComments(hosturl,cwa_id,report.reportPk)
       
        	   console.log(data);
        	   
        
       },
       error: function (data) {
           alert('An error has occurred during load the report data. Please try again - ajax return error!!!');
           //jQuery("#allrpts_cognos_list_div").html("An error has occurred. Please try again later。");
       }
   });	
	
	
	
}

function loadReportComments(hosturl,cwa_id,rpt_pk) {
	urlSatic=hosturl;
//call ajax	to read the data according to cwaid and cognos rpt path
console.log("ajax loadReportData");
	var timeid = (new Date()).valueOf();
    jQuery.ajax({
     
       type: 'GET', url: hosturl+'/action/portal/rank/getReportComments?cwa_id=' + cwa_id + '&rpt_pk=' + rpt_pk,
        timeout : 30000,
       
       
       success: function (data) {
      // alert('returned');
    	   var hasAdded='N';
    	   if (data.length > 0) {
    	          for (var i = 0; i < data.length; i++) {
    	        	  
    	        	  if(data[i].cwaId==cwa_id){
    	        		  hasAdded='Y';
    	        	  }
    	        	  addRow(data[i],i);
    	          }
    	         
    	          jQuery(".reply-btn").click(function(){
  					replyClick(this);
  				}); 
    		  }else{
    			  
    			//no comments  
    			  
    		  }
    	   if(hasAdded=='Y'){
    	   jQuery("#submit_rank").hide();
	            jQuery('#comments_input').attr("disabled","disabled");
    	   }
        	   console.log(data);
        	   
        
       },
       error: function (data) {
           alert('An error has occurred during load report comments. Please try again - ajax return error!!!');
           //jQuery("#allrpts_cognos_list_div").html("An error has occurred. Please try again later。");
       }
   });	
	
	
	
}
ReportRankMenu.prototype.save = function() {
//ajax save to return the whole data.
	
	
//first get each ratting value
var data=this.rankingList;

	
	
var saveRankinglist=new Array()
	//set the rating value from customer
	  if (data.length > 0) {
          for (var i = 0; i < data.length; i++) {
        	  
        	  //jQuery("#rateYo"+i).rateYo("option", "rating", data[i].rankValue);
        	  var rating=jQuery("#rateYo"+i).rateYo("option", "rating");
        	  data[i].rankValue=rating;
          }
	  }
	//call ajax to save the data,post the list back.
var jsonData=JSON.stringify(data);
jQuery.ajax({
    
    type:"POST",
   
   // url:deck_app_url+'createpreview',
    url:urlSatic+'/action/portal/rank/saveReportRanking',
    data:jsonData,
    contentType:"application/json",
  
    datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".

   
   
    success:function(resObject){
    	jQuery('#display_submit').html("Saved.");
    	jQuery(".ratecss").rateYo("option", "readOnly", true);
            //alert("Your ratting has been added sucessfully");

    }   ,
   
    complete: function(XMLHttpRequest, textStatus){
      // alert(XMLHttpRequest.responseText);
     //  alert(textStatus);
        //HideLoading();
    
    },
    
    error: function(XMLHttpRequest, textStatus, errorThrown){
    // alert("Sorry,error occured,please try again later.details:"+XMLHttpRequest.responseText);
    	jQuery('#display_submit').html("Failed.");
    }         
 });






}
 function showProgress() {
	//ajax save to return the whole data.
		
		
	//first get each ratting value
	
	var progress=0;
		//set the rating value from customer
		  if (rankNums<1){
			  
			  return;
		  }
	          for (var i = 0; i < rankNums; i++) {
	        	  
	        	  //jQuery("#rateYo"+i).rateYo("option", "rating", data[i].rankValue);
	        	  var rating=jQuery("#rateYo"+i).rateYo("option", "rating");
	        	 
	        	  if(rating!=0){
	        		  progress++;
	        	  }
	          }
	          if(progress==rankNums){
	        	  jQuery('#span_submit').show();  
	  
	          }else{
	        	  
	        	  jQuery('#span_submit').hide();    
	          }
	          var percg=progress/rankNums;
	          percg=percg*100;
	      	jQuery('#progressbar2').LineProgressbar({
				percentage: percg,
				fillBackgroundColor: '#1abc9c'
			});
		 //alert(progress)
		//call ajax to save the data,post the list back.
	//var jsonData=JSON.stringify(data);







	}
ReportRankMenu.prototype.initRanking = function() {
	//load the config setting for the ranking

	jQuery(".ratecss").rateYo({
      starWidth: rankConfig.star.starWidth,
      numStars:rankConfig.star.starnumStars,
      precision:rankConfig.star.precision
      
});
	
	var data=this.rankingList;

	
	

	//set the rating value from customer
	  if (data.length > 0) {
          for (var i = 0; i < data.length; i++) {
        	  jQuery("#rateYo"+i).rateYo("option", "rating", data[i].rankValue);
        	  //jQuery("#rateYo"+i).rateYo("option", "rating", 1);
          }
	  }
	
	
	
	jQuery(".ratecss").rateYo()
	              .on("rateyo.change", function (e, data) {
	 
	                var rating = data.rating;
	                jQuery(this).next().text(rating);
	
	              });
//set the star value based on the data,if there is no value,then zero is default,else set to read only

	jQuery(".ratecss").rateYo("option", "onSet", function () {
		 showProgress();
	    console.log("This is a new function");
	       })
	
	
   
	}






ReportRankMenu.prototype.draw = function() {
	var data=this.rankingList;

	var str_domain = "";
	
	str_domain += '<span><strong>' + 'Report Ranking '+ '</strong></span></br>';
	str_domain += '<table id="rank_table" width="16%" border="0" cellspacing="0" cellpadding="0" summary="Data table example">';
	str_domain += '<thead><tr>';
	str_domain += '<th width="30%" scope="col"></th>';   
	str_domain += '<th width="50%" scope="col"></th>';

	str_domain += '</tr></thead>';
	str_domain += '<tbody>';
	

	
	  if (data.length > 0) {
          for (var i = 0; i < data.length; i++) {
          
          
          
          
			 var iRank = new ReportRank(data[i].cuuid,data[i].createTime,data[i].rankKey,data[i].rankSetId,data[i].rankValue,data[i].reportPk);
			 str_domain+=iRank.draw(i);
			
}
	  }
	  str_domain += '</tbody>';
		str_domain += '</table>';
		return str_domain;
}
function loadReportInfo(info){
	var author=info.reportAuthor;
	if(author==null){
		author='N/A'
	}
	var rptOwner=info.reportOwner;
	if(rptOwner==null){
		rptOwner='N/A'
	}
	var backupOwner=info.backupOwner;
	if(backupOwner==null){
		backupOwner='N/A'
	}
	
    jQuery("#deck_name").html(info.reportName);
    jQuery("#deck_author").html(author);
    jQuery("#deck_owner").html(rptOwner);
    jQuery("#backupOwner").html(backupOwner);
    jQuery("#accessCount").html(info.accessCount);
    jQuery("#userCount").html(info.userCount);
    jQuery("#commentsCount").html(info.commentsCount);
    jQuery("#tbsCount").html(info.tbsCount);
    jQuery("#rankScore").html(info.rankScore);

	
}
function ReportComment(comment){
	
	this.comment=comment;
	
	
	
	
	
}
ReportComment.prototype.draw = function() {
if(this.comment.commentType=='C'){
	//main 
	
	
	
	
}else{
//reply type==R	
	
	
	
	
	
}	
}

function saveReportComment() {
	//if(this.comment.commentType=='C'){
	//set values
	reportCommentEntry.reportPk=report.reportPk;
	reportCommentEntry.cwaId=cwa_id
	reportCommentEntry.commentType='C';
	var inputComments=jQuery("#comments_input").val();
	if(inputComments==''){
		
		alert("Please input some comments to submit");
		return;
	}
	reportCommentEntry.comments=jQuery.trim(inputComments);
	 var timestamp = Date.parse(new Date());
     reportCommentEntry.createTime=timestamp;
	console.log(reportCommentEntry);
	
	var jsonData=JSON.stringify(reportCommentEntry);
	jQuery.ajax({
	    
	    type:"POST",
	   
	   // url:deck_app_url+'createpreview',
	    url:urlSatic+'/action/portal/rank/saveReportComment',
	    data:jsonData,
	    contentType:"application/json",
	  
	    datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".

	   
	   
	    success:function(resObject){
	    	
	          jQuery("#remaining-characters").html("<font color='green'>Your comment has been added sucessfully</font>");
	            jQuery("#submit_rank").hide();
	            jQuery('#comments_input').attr("disabled","disabled");
	           var ctObject=jQuery.parseJSON(resObject)
	            addFirstRow(ctObject);
	    }   ,
	   
	    complete: function(XMLHttpRequest, textStatus){
	      // alert(XMLHttpRequest.responseText);
	     //  alert(textStatus);
	        //HideLoading();
	    },
	    
	    error: function(XMLHttpRequest, textStatus, errorThrown){
	    // alert("Sorry,error occured,please try again later.details:"+XMLHttpRequest.responseText);
	    	   alert("failed to add commments,please try later.");
	    }         
	 });






}

function saveReportCommentReply(parentId,inputComments) {
	//if(this.comment.commentType=='C'){
	//set values
	reportCommentEntry.reportPk=report.reportPk;
	reportCommentEntry.cwaId=cwa_id;
	reportCommentEntry.commentType='R';
	reportCommentEntry.parentID=parentId;
	
	reportCommentEntry.comments=jQuery.trim(inputComments);
	if(reportCommentEntry.comments==''){
		
		alert("Please input some comments to submit.")
		
	}
	 var timestamp = Date.parse(new Date());
     reportCommentEntry.createTime=timestamp;
	console.log(reportCommentEntry);
	
	var jsonData=JSON.stringify(reportCommentEntry);
	jQuery.ajax({
	    
	    type:"POST",
	   
	   // url:deck_app_url+'createpreview',
	    url:urlSatic+'/action/portal/rank/saveReportComment',
	    data:jsonData,
	    contentType:"application/json",
	  
	    datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".

	   
	   
	    success:function(resObject){
	    	
	            //alert("Your comment&ranking has been added sucessfully");
	            //jQuery("#submit_rank").hide();
	            //jQuery('#comments_input').attr("disabled","disabled");
	           
	            //addFirstRow(reportCommentEntry);
	    }   ,
	   
	    complete: function(XMLHttpRequest, textStatus){
	      // alert(XMLHttpRequest.responseText);
	     //  alert(textStatus);
	        //HideLoading();
	    },
	    
	    error: function(XMLHttpRequest, textStatus, errorThrown){
	    // alert("Sorry,error occured,please try again later.details:"+XMLHttpRequest.responseText);
	    	   alert("failed to add commments reply,please try later.");
	    }         
	 });






}

function replyClick(el){
	if(jQuery(".replybox")!=undefined){
		jQuery(".replybox").remove();	
		
		
	}
	el=jQuery(el);
	el.parent().parent().append("<div class='replybox'><textarea  maxlength='500' cols='50' rows='20' placeholder='Add your reply to this comment here.' class='mytextarea' ></textarea><span class='send'>Send</span></div>")
	.find(".send").click(function(){
		var content = jQuery(this).prev().val();
		if(content != ""){
			var parentEl = jQuery(this).parent().parent().parent().parent();
			var obj = new Object();
			obj.replyName="anonynours";
			if(el.parent().parent().hasClass("reply")){
				console.log("1111");
				obj.beReplyName = el.parent().parent().find("a:first").text();
			}else{
				console.log("2222");
				obj.beReplyName=parentEl.find("h3").text();
			}
			obj.comments=content;
			obj.cwaId=cwa_id;
			var replyString = createReplyComment(obj);
			jQuery(".replybox").remove();
			var parantSapn=parentEl.find(".reply-btn")[0];
			console.log(jQuery(parantSapn).attr("id"));
			//send request to the backend
			parantId=jQuery(parantSapn).attr("id")
			saveReportCommentReply(parantId,content);
			
			parentEl.find(".reply-list").append(replyString);
			//.find(".reply-list-btn:last").click(function(){alert("can not reply");});
		}else{
			alert("No conent!");
		}
	});
}
function getNowDateFormat(){
	var nowDate = new Date();
	var year = nowDate.getFullYear();
	var month = filterNum(nowDate.getMonth()+1);
	var day = filterNum(nowDate.getDate());
	var hours = filterNum(nowDate.getHours());
	var min = filterNum(nowDate.getMinutes());
	var seconds = filterNum(nowDate.getSeconds());
	return year+"-"+month+"-"+day+" "+hours+":"+min+":"+seconds;
}
function createReplyComment(reply){
	if(typeof(reply.createTime) == 'undefined' || reply.createTime == "" ){
		reply.createTime = getNowDateFormat();
	}else{
		
		reply.createTime=uploadListFormatDate(reply.createTime);
		
	}
	var replyEl = "<div class='reply'><div><a href='https://w3-connections.ibm.com/profiles/html/keywordSearch.do?keyword="+reply.cwaId+"' class='replyname'>"+reply.cwaId+"</a><span> replied: "+html_encode(reply.comments)+"</span></div>"
					+ "<p><span>"+reply.createTime+"</p></div>";
	return replyEl;
}
function filterNum(num){
	if(num < 10){
		return "0"+num;
	}else{
		return num;
	}
}
var createFirst='N';
function crateCommentFirstInfo(obj){
	createFirst='Y';
	obj.img="http://w3-services1.w3-969.ibm.com/myw3/unified-profile-photo/v1/image/"+obj.cwaId;
	
	if(typeof(obj.createTime) == "undefined" || obj.createTime == ""){
		obj.createTime = getNowDateFormat();
	}
	
	var el = "<div class='comment-info'><header><img src='"+obj.img+"'></header><div class='comment-right'><h3>"+obj.cwaId+"</h3>"
			+"<div class='comment-content-header'><span><i class='glyphicon glyphicon-time'></i>"+uploadListFormatDate(obj.createTime)+"</span>";
	
	if(typeof(obj.address) != "undefined" && obj.browse != ""){
		el =el+"<span><i class='glyphicon glyphicon-map-marker'></i>"+obj.address+"</span>";
	}
	el = el+"</div><p class='content'>"+html_encode(obj.comments)+"</p><div class='comment-content-footer'><div class='row'><div class='col-md-10'>";
	
	if(typeof(obj.osname) != "undefined" && obj.osname != ""){
		el =el+"<span><i class='glyphicon glyphicon-pushpin'></i> from:"+obj.osname+"</span>";
	}
	
	if(typeof(obj.browse) != "undefined" && obj.browse != ""){
		el = el + "<span><i class='glyphicon glyphicon-globe'></i> "+obj.browse+"</span>";
	}
	
	el = el + "</div><div class='col-md-2'><span id='"+obj.commentId+"' onclick ='replyClick(this);' class='reply-btn'>Reply</span></div></div></div><div class='reply-list'>";
	if(obj.replyList != undefined ){
	if(obj.replyList != "" && obj.replyList.length > 0){
		var arr = obj.replyList;
		for(var j=0;j<arr.length;j++){
			var replyObj = arr[j];
			el = el+createReplyComment(replyObj);
		}
	}
	}
	el = el+"</div></div></div>";
	return el;
	
	
}
function crateCommentInfo(obj){
	obj.img="http://w3-services1.w3-969.ibm.com/myw3/unified-profile-photo/v1/image/"+obj.cwaId;
	
	
	
	var el = "<div class='comment-info'><header><img src='"+obj.img+"'></header><div class='comment-right'><h3>"+obj.cwaId+"</h3>"
			+"<div class='comment-content-header'><span><i class='glyphicon glyphicon-time'></i>"+uploadListFormatDate(obj.createTime)+"</span>";
	
	if(typeof(obj.address) != "undefined" && obj.browse != ""){
		el =el+"<span><i class='glyphicon glyphicon-map-marker'></i>"+obj.address+"</span>";
	}
	el = el+"</div><p class='content'>"+html_encode(obj.comments)+"</p><div class='comment-content-footer'><div class='row'><div class='col-md-10'>";
	
	if(typeof(obj.osname) != "undefined" && obj.osname != ""){
		el =el+"<span><i class='glyphicon glyphicon-pushpin'></i> from:"+obj.osname+"</span>";
	}
	
	if(typeof(obj.browse) != "undefined" && obj.browse != ""){
		el = el + "<span><i class='glyphicon glyphicon-globe'></i> "+obj.browse+"</span>";
	}
	
	el = el + "</div><div class='col-md-2'><span id='"+obj.commentId+"' class='reply-btn'>Reply</span></div></div></div><div class='reply-list'>";
	if(obj.replyList != undefined ){
	if(obj.replyList != "" && obj.replyList.length > 0){
		var arr = obj.replyList;
		for(var j=0;j<arr.length;j++){
			var replyObj = arr[j];
			el = el+createReplyComment(replyObj);
		}
	}
	}
	el = el+"</div></div></div>";
	return el;
}
function html_encode(str)  
{  
	 return jQuery('<div/>').text(str).html();  
 
	}  