<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<meta contentType="text/html; charset=UTF-8">
<title>Message And Dataload Template</title>
<jsp:include page="/WEB-INF/include/v18include.jsp"></jsp:include>

</head>
<body id="ibm-com" class="ibm-type" style="align: center">
	<jsp:include page="/WEB-INF/include/v18head.jsp"></jsp:include>
	<br>
    <!-- =================== Loading div - START =================== -->
    <div id="csp_loading_id" style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 998; width: 100%; height: 100%; _padding: 0 20px 0 0; background: #f6f4f5; display: none;"></div>
    <div id="csp_ajax_loding_id" style="position: fixed; top: 0; left: 50%; z-index: 9999; opacity: 0; filter: alpha(opacity = 0); margin-left: -80px;">
        <div>
            <span>Updating template ... </span><img src='<%=request.getContextPath()%>/images/ajax-loader.gif' />
        </div>
    </div>
    <!-- =================== Loading div - END =================== -->
	<div>
		<div>
			<div>
				<div style="float: left;">
					<h1 id="id_title" class="ibm-h1 ibm-light">&nbsp;&nbsp;&nbsp;</h1>
				</div>
			</div>
		</div>
		
		<div class="ibm-rule">
			<hr>
		</div>
		
		<form id="__REPLACE_ME__01__" class="ibm-row-form" method="post" action="__REPLACE_ME__">
		    <div class="ibm-columns">
			    <div class="ibm-col-6-2">
		            <p>
		                <label for="id_templateName"><strong>Template name:</strong><span class="ibm-required"><strong>*</strong></span></label>
				        <span>
				            <input type="text" value="" size="40" id="id_templateName" name="first_name">
				        </span>
		            </p>
		        </div>
		        <div class="ibm-col-6-2">
			    	<p class="ibm-form-elem-grp">
				        <label><strong>If default:</strong><span class="ibm-required"><strong>*</strong></span></label>
				        <span>
				            <select id="id_ifDefault" style="width:90px;">
				                <option value="" selected>Select one</option>
				                <option value="Y">Yes</option>
				                <option value="N">No</option>
				            </select>
				        </span>
				    </p>
		        </div>
		        <div class="ibm-col-6-2">
				    <p id="id_p_templateType" class="ibm-form-elem-grp">
				        <label><strong>Template type:</strong><span class="ibm-required"><strong>*</strong></span></label>
				        <span>
				            <select name="template_type" id="id_templateType" style="width:90px;" onchange="switchValuesAndEg(this.value)">
				            </select>
				        </span>
			    	</p>
		        </div>
		        <br />
		        <br />
		        <div class="ibm-col-6-6">
		        <br />
		            <p id="id_p_mailSubject">
		                <label for="id_mailSubject" id = "id_label_mailSubject"><strong>Mail subject:</strong><span class="ibm-required"><strong>*</strong></span>
		                <br/>
		                <!--  <span id="id_egForSubject" class="ibm-item-note"></span>-->
		                </label>
		                <br/>
		                <span>
		                    <textarea id="id_mailSubject" rows="3" cols="120" name="mailSubject">${template.mailSubject}</textarea>
		                </span>
		                <div id="id_valuesForSubject">
		                </div>
		            </p>
		            <br />
		            
		            <p>
		                <label for="id_mailBody" id = "id_label_mailBody"><strong>Mail body:</strong><span class="ibm-required"><strong>*</strong></span>
		                <br/>
		                <!-- <span id="id_egForBody" class="ibm-item-note"></span>-->
		                </label>
		                <br/>
		                <span>
		                    <textarea id="id_mailBody" rows="13" cols="120" name="mailSubject">${template.mailBody}</textarea>
		                </span>
		                <div id="id_valuesForBody">
		                </div>
		            </p>
		            <br />
		            
		            <p>
		                <label for="id_comments"><strong>Comments:</strong></label>
		                <span>
		                    <textarea id="id_comments" rows="3" cols="120" name="comments">${template.comments}</textarea>
		                </span>
		            </p>
		            <br />
		            
		            <p>
		                <div id="mtedit_buttondiv" class="ibm-btn-row ibm-left">
		                	<input class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" type="button" id="mtedit_btn_ok" onclick="checkMandatory();return false;" value="OK" />
		                	<a class="ibm-btn-pri ibm-btn-small ibm-btn-blue-50" href="javascript:window.history.back()">Cancel</a>
				        </div>
		            </p>
		            
		        </div>
		        
		    </div>
		</form>

	</div>

	
	
	<jsp:include page="/WEB-INF/include/v18footer.jsp"></jsp:include>
	<script type="text/javascript">
	var mtContext = "<%=request.getContextPath()%>";
    var mailTemplates;
    var cwa_id = '${requestScope.cwa_id}';
    var uid = '${requestScope.uid}';
    var action = '${requestScope.action}';
    var error = '${requestScope.error}';
    var templateName = '${template.templateName}';
    var templateType = '${template.templateType}';
    var typeName = '${template.typeName}';
    var ifDefault = '${template.ifDefault}';
    var templateId = '${template.templateId}';

    function showLoading() {
        jQuery("#csp_loading_id").css({
            'display': 'block',
            'opacity': '0.8'
        });
        jQuery("#csp_ajax_loding_id").css({
            'display': 'block',
            'opacity': '0'
        });
        jQuery("#csp_ajax_loding_id").animate({
            'margin-top': '300px',
            'opacity': '1'
        }, 200);
    }

    function hiddLoading() {
        jQuery("#csp_loading_id").css({
            'display': 'none'
        });
        jQuery("#csp_ajax_loding_id").css({
            'display': 'none',
            'opacity': '0'
        });
    }
    

	function getMailTemplate() {
		
		showLoading();
		timeid = (new Date()).valueOf();
		
		jQuery.ajax({
	        type: 'GET', url: '<%=path%>/action/portal/mailtemplate/listMailTemplateTypes/' + cwa_id + '/' + uid + '?timeid=' + timeid,async:false,
	        success: function (data) {
	        //console.log("get data from rest api listMailTemplateTypes()");
	        //console.log(data);
	        
	        var templates = "<option value='' selected>Select one</option>";
	        for (var i = 0; i < data.length; i++) {
	     	   templates+="<option value='";
	     	   templates+=data[i].typeId;
	     	   templates+="'>";
	     	   templates+=data[i].typeName;
	     	   templates+="</option>";
	  	    }
	        
			jQuery("#id_templateType").append(templates);
			
	  	  	},
	        error: function (data) {
	            alert('listMailTemplateTypes - ajax return error!!!')
	        }
	    });
		
		//if(action != 'addMailTemplate'){
		if(!(action==null||action=="")){
			jQuery("#id_title").append("Message And Dataload Template Edit");
			jQuery.ajax({
		        type: 'GET', url: '<%=path%>/action/portal/mailtemplate/listMailTemplateValues/' + cwa_id + '/' + uid + '?timeid=' + timeid, async:false,
		        success: function (data) {
		        	for (var i = 0; i < data.length; i++) {
		        		if(!(""==templateType|| templateType==null) && templateType==data[i].templateType){
		        			jQuery("#id_label_mailSubject").append("<span name='values' id='id_egForSubject"+data[i].templateType+"' class='ibm-item-note'>"+"(eg."+data[i].egForSubject+")"+"</span>");
		        			jQuery("#id_valuesForSubject").append("<div name='values' id='id_valuesForSubject"+data[i].templateType+"'><br/>below is the filed you can choose:<br/>"+data[i].valuesForSubject+"</div>");
		        			
		        			jQuery("#id_label_mailBody").append("<span name='values' id='id_egForBody"+data[i].templateType+"' class='ibm-item-note'>"+"(eg."+data[i].egForBody+")"+"</span>")
		        			jQuery("#id_valuesForBody").append("<div name='values' id='id_valuesForBody"+data[i].templateType+"'><br/>below is the filed you can choose:<br/>"+data[i].valuesForBody+"</div>");
		        			
		        		}else{
		        			jQuery("#id_label_mailSubject").append("<span name='values' id='id_egForSubject"+data[i].templateType+"' class='ibm-item-note' style='display: none;'>"+"(eg."+data[i].egForSubject+")"+"</span>");
		        			jQuery("#id_valuesForSubject").append("<div name='values' id='id_valuesForSubject"+data[i].templateType+"' style='display: none;'><br/>below is the filed you can choose:<br/>"+data[i].valuesForSubject+"</div>");
		        			
		        			jQuery("#id_label_mailBody").append("<span name='values' id='id_egForBody"+data[i].templateType+"' class='ibm-item-note' style='display: none;'>"+"(eg."+data[i].egForBody+")"+"</span>")
		        			jQuery("#id_valuesForBody").append("<div name='values' id='id_valuesForBody"+data[i].templateType+"' style='display: none;'><br/>below is the filed you can choose:<br/>"+data[i].valuesForBody+"</div>");
		        			
		        		}
		        	}
		        	
		  	  	},
		        error: function (data) {
		            alert('listMailTemplates - ajax return error!!!')
		        }
		    });
		} else {
			jQuery("#id_title").append("Message And Dataload Template Add");
			
		}
		
		hiddLoading();
	
	  }
	
	function switchValuesAndEg(templateType){
		
		jQuery("[name='values']").hide();
		jQuery("#id_valuesForSubject"+templateType).show();
		jQuery("#id_valuesForBody"+templateType).show();
		jQuery("#id_egForSubject"+templateType).show();
		jQuery("#id_egForBody"+templateType).show();
	}
	
	function checkMandatory(){
		timeid = (new Date()).valueOf();
		var template = {};
		
		var newTemplateName = jQuery("#id_templateName").val().trim();
		if(newTemplateName==null||newTemplateName==""){
			alert('please enter Template name');
			return false;
		}else{
			var reg = /^[_0-9a-zA-Z]+$/;
			if(!reg.test(newTemplateName)){
				alert('template name is made up of letters, Numbers, and underscores');
				return false;
			}
		}
		template["templateName"] = newTemplateName;
		
		var newTemplateType = jQuery("#id_templateType").val();
		if(newTemplateType==null||newTemplateType==""){
			alert('please enter Template type');
			return false;
		}
		template["templateType"] = newTemplateType;
		
		var newIfDefault = jQuery("#id_ifDefault").val();
		if(newIfDefault==null||newIfDefault==""){
			alert('please enter If defualt');
			return false;
		}
		template["ifDefault"] = newIfDefault;
		
		var newMailSubject = jQuery("#id_mailSubject").val();
		if(newMailSubject==null||newMailSubject==""){
			alert('please enter Mail subject');
			return false;
		}
		template["mailSubject"] = newMailSubject;
		
		var newMailBody = jQuery("#id_mailBody").val();
		if(newMailBody==null||newMailBody==""){
			alert('please enter Mail Body');
			return false;
		}
		template["mailBody"] = newMailBody;
		
		template["comments"] = jQuery("#id_comments").val();
		
		template["templateCreater"] = cwa_id;
		
		showLoading();
 		if(action==null||action==""){
 			jQuery.ajax({
 				type : 'POST',
 				url : '<%=path%>/action/portal/mailtemplate/insertMailTemplate/' + '?timeid=' + timeid ,
 				data : JSON.stringify(template),
 				contentType : "application/json",
 				dataType : "json",
 				success : function(data) {
 					if(data!="success"){
 						hiddLoading();
 						alert(data);
 						return false;
 					}else{
 						hiddLoading();
 						window.location.href=document.referrer;
 					}
 				}
 			})
 			.done(function(){

 			})
 			.fail(function(jqXHR, textStatus, errorThrown){		
 				hiddLoading();
 				if (confirm("Unable to add the template - click \'OK\' to return to the current page and try again or \'Cancel\' to return to Message And Dataload Template page.")) {
 					var urlStr = "<%=request.getContextPath()%>/action/admin/mailTmpl/editMailTemplate/" + action;
 					window.location.href=urlStr;
 				} else{
 					window.location.href=document.referrer;
 				}
 			})
		}else{
			jQuery.ajax({
				type : 'POST',
				url : '<%=path%>/action/portal/mailtemplate/updateMailTemplate/' + templateName + '/' + templateId + '?timeid=' + timeid ,
				data : JSON.stringify(template),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					if(data!="success"){
						hiddLoading();
						alert(data);
						return false;
					}else{
						hiddLoading();
						window.location.href=document.referrer;
					}
				}
			})
			.done(function(){

			})
			.fail(function(jqXHR, textStatus, errorThrown){		
				hiddLoading();
				if (confirm("Unable to save the template - click \'OK\' to return to the current page and try again or \'Cancel\' to return to Message And Dataload Template page.")) {
					var urlStr = "<%=request.getContextPath()%>/action/admin/mailTmpl/editMailTemplate/" + action;
					window.location.href=urlStr;
				} else{
					window.location.href=document.referrer;
				}
			})
		}

	}

    
    jQuery(document).ready(function () {
    	
    	getMailTemplate();
    	jQuery("#id_templateName").val(templateName).trigger("change");
    	jQuery("#id_ifDefault").val(ifDefault).trigger("change");
    	jQuery("#id_templateType").val(templateType).trigger("change");

	});
  
	</script>
</body>
</html>