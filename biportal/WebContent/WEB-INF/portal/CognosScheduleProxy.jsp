
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" autoFlush="true" isThreadSafe="true" %>
<%@ page import="java.security.Key" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.security.NoSuchProviderException" %>
<%@ page import="cryptix.util.core.Hex" %>
<%@ page import="cryptix.provider.key.RawSecretKey" %>
<%@ page import="xjava.security.Cipher" %>
<%@ page import="java.util.StringTokenizer" %>
<%@page import="java.net.URLEncoder"%>

<!DOCTYPE html SYSTEM "http://www.ibm.com/data/dtd/v11/ibmxhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
 <head>
  <title> Cognos Schedule Panel </title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<meta name="dc.rights" content="copyright (c) 2011 by IBM corporation" />
	<meta name="dc.date" scheme="iso8601" content="2011-12-13" />
	<meta name="dc.language" scheme="rfc1766" content="en-US" />
	<meta name="description" content="BI@IBM" />
	<meta name="ibm.country" content="US" />
	<meta name="keywords" content="Cognos Schedule panel" />
	<meta name="owner" content="edgeteam@us.ibm.com" />
	<meta name="robots" content="noindex,nofollow" />
	<meta name="security" content="IBM internal use only" />
 </head>
 <%!
 	private static byte[]		A					= { (byte) 'A' };
	private static final int	MAX_COUNT			= 1000;
	private static final String	CIPHER				= "Blowfish";
	private static final String	HASH				= "SHA-1"; 
	
	private Key createNewKey(String keyValue) throws Exception {
		byte[] b4 = null;
		byte[] temp = null;

		MessageDigest md = null;
		//
		if (keyValue == null || keyValue.trim().equals("")) {
			throw new Exception("Please set a public key value. ");
		}
		b4 = keyValue.getBytes();
		//
		try {
			md = MessageDigest.getInstance(HASH);
		} // try
		catch (NoSuchAlgorithmException e) {
			throw e;
		} // catch

		md.update(b4);

		temp = md.digest();

		for (int count = 1; count < MAX_COUNT; count++) {
			temp = md.digest(temp);
		}
		java.security.Security.addProvider(new cryptix.provider.Cryptix());
		md.update(A);
		Key keyNew = new RawSecretKey(CIPHER, md.digest(temp));
		return keyNew;
	}
	
	private String descryptString(String key, String str) {

		Cipher cryptor = null;
		cryptix.provider.Cryptix provider = null;
		String decryptedString = "";

		provider = new cryptix.provider.Cryptix();

		java.security.Security.addProvider(provider);

		try {
			cryptor = Cipher.getInstance("Blowfish/CBC/PKCS#7", "Cryptix");
			cryptor.initDecrypt(createNewKey(key));
			decryptedString = new String(cryptor.crypt(Hex.fromString(str)));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return decryptedString;
	}
	
 %>
 
 <%
 	boolean ifError = false;
 	String errorMsg = "";
 	String encryptedUserID=null,encryptedStartTime=null,descryption_key=null,startTime=null;
 	String session_id = request.getParameter("parameter_session");
 	if(session_id==null||session_id.trim().equals("")){
 		ifError = true;
 		errorMsg = "invalid session";
 	}
	//
	if(!ifError){
		StringTokenizer stken1 = new StringTokenizer(session_id, ";");		
		if (stken1.hasMoreTokens()) {
			encryptedUserID = stken1.nextToken();
		}else{
			ifError = true;
			errorMsg = "invalid session format";
		}
		if(!ifError){
			if (stken1.hasMoreTokens()) {
				descryption_key = stken1.nextToken();			
			}else{
				ifError = true;
				errorMsg = "invalid session format";
			}
		}
	}
	//
	if(!ifError){
		String userID = descryptString(descryption_key,encryptedUserID);
		if(userID.equals("")){
			ifError=true;
			errorMsg="invalid user ID";
		}
		if(!ifError){
			StringTokenizer stken2 = new StringTokenizer(userID, ";");
			if(stken2.hasMoreTokens()){
				userID = stken2.nextToken();
				if(stken2.hasMoreTokens()){
					startTime = stken2.nextToken();
				}else{
					ifError=true;
					errorMsg="invalid user ID";					
				}
			}else{
				ifError=true;
				errorMsg="invalid user ID";			
			}
		}
		if(startTime.equals("")){
			ifError=true;
			errorMsg="invalid start time";		
		}
		//
	 	String cwa_id = request.getParameter("parameter_cwa_id");
	 	if(cwa_id==null||cwa_id.trim().equals("")){
			ifError=true;
			errorMsg="invalid user intranet id";		 	
	 	}
	 	if(!ifError){
		 	if(!userID.equals(cwa_id)){
				ifError=true;
				errorMsg="invalid request";
		 	}
		 	long currentTime = System.currentTimeMillis();
		 	if(currentTime - Long.valueOf(startTime).longValue() > 24*60*60*1000){
				ifError=true;
				errorMsg="request has been timeout";
		 	}
	 	}
	}
	String report_id=request.getParameter("parameter_report_id");
	if (report_id == null||report_id.trim().equals("")){
		ifError=true;
		errorMsg="invalid report id";
		report_id="";
	}
	String rds_url = request.getParameter("parameter_rds_url");
	if (rds_url == null||rds_url.trim().equals("")){
		ifError=true;
		errorMsg="invalid gateway url";
		rds_url="";
	}
	String cognoscallbackproxy_url = request.getParameter("cognoscallbackproxy_url");
	if (cognoscallbackproxy_url == null||cognoscallbackproxy_url.trim().equals("")){
		ifError=true;
		errorMsg="invalid callback servlet url";
		cognoscallbackproxy_url="";
	}
	String parameter_prompt_page_url = request.getParameter("parameter_prompt_page_url");
	if (parameter_prompt_page_url == null||parameter_prompt_page_url.trim().equals("")){
		ifError=true;
		errorMsg="invalid prompt page url";
		parameter_prompt_page_url="";
	}
	String parameter_prompt_page_url_m = request.getParameter("m");
	String parameter_prompt_page_url_ui_object = request.getParameter("ui.object");
	String parameter_prompt_page_url_promptID  = request.getParameter("promptID");
	String parameter_prompt_page_url_routingServerGroup = request.getParameter("ui.routingServerGroup");
	parameter_prompt_page_url += "&m="+ parameter_prompt_page_url_m;
	parameter_prompt_page_url += "&ui.object="+ parameter_prompt_page_url_ui_object;
	parameter_prompt_page_url += "&promptID="+ parameter_prompt_page_url_promptID;
	if(parameter_prompt_page_url_routingServerGroup!=null&&!"".equals(parameter_prompt_page_url_routingServerGroup)){
		parameter_prompt_page_url += "&ui.routingServerGroup="+ parameter_prompt_page_url_routingServerGroup;
	}
	//
	//cookies setting
	String cam_passport = request.getParameter("cam_passport");
	if(cam_passport!=null){
		cam_passport = java.net.URLEncoder.encode(cam_passport.replaceAll("my_special_and","&").replaceAll("my_special_equal","="),"UTF-8");
		
	}else{
		cam_passport="";
	}
	
	String usersessionid = request.getParameter("usersessionid");
	if(usersessionid!=null){
		usersessionid = java.net.URLEncoder.encode(usersessionid.replaceAll("my_special_and","&").replaceAll("my_special_equal","="),"UTF-8");
	}else{
		usersessionid="";
	}
	//
	String cea_ssa = request.getParameter("cea_ssa");
	if(cea_ssa!=null){
		cea_ssa = java.net.URLEncoder.encode(cea_ssa.replaceAll("my_special_and","&").replaceAll("my_special_equal","="),"UTF-8");
	}else{
		cea_ssa="";
	}
	//
	String CRN = request.getParameter("CRN");
	if(CRN!=null){
		CRN = java.net.URLEncoder.encode(CRN.replaceAll("my_special_and","&").replaceAll("my_special_equal","="),"UTF-8");
	}else{
		CRN="";
	}
	//
	String userCapabilities = request.getParameter("userCapabilities");
	if(userCapabilities!=null){
		userCapabilities = java.net.URLEncoder.encode(userCapabilities.replaceAll("my_special_and","&").replaceAll("my_special_equal","="),"UTF-8");
	}else{
		userCapabilities="";
	}
	//
	String cookie_namePrefix=request.getParameter("domain_key")+"_";
	//
	Cookie cookie_cam_passport = new Cookie("cam_passport", cam_passport);
	cookie_cam_passport.setPath("/ServletGateway/");
	cookie_cam_passport.setDomain(request.getServerName());	
	response.addCookie(cookie_cam_passport);
	Cookie domain_logon = new Cookie(cookie_namePrefix+"logon", cam_passport);
	domain_logon.setPath("/ServletGateway/");
	domain_logon.setDomain(request.getServerName());	
	response.addCookie(domain_logon);
	//
	Cookie cookie_usersessionid = new Cookie("usersessionid", usersessionid);
	cookie_usersessionid.setPath("/ServletGateway/");
	cookie_usersessionid.setDomain(request.getServerName());	
	response.addCookie(cookie_usersessionid);
	//
	Cookie cookie_cea_ssa = new Cookie("cea-ssa", cea_ssa);
	cookie_cea_ssa.setPath("/ServletGateway/");
	cookie_cea_ssa.setDomain(request.getServerName());	
	response.addCookie(cookie_cea_ssa);
	//
	Cookie cookie_CRN = new Cookie("CRN", CRN);
	cookie_CRN.setPath("/ServletGateway/");
	cookie_CRN.setDomain(request.getServerName());	
	response.addCookie(cookie_CRN);
	//
	Cookie cookie_userCapabilities = new Cookie("userCapabilities", userCapabilities);
	cookie_userCapabilities.setPath("/ServletGateway/");
	cookie_userCapabilities.setDomain(request.getServerName());	
	response.addCookie(cookie_userCapabilities);
	//
 %>
<script language="JavaScript" type="text/javascript">
<!--
//document.domain = "ibm.com";

var ifError = <%=ifError%>;
var errorMsg = '<%=errorMsg%>';
var rds_url='<%=rds_url%>';
var report_id='<%=report_id%>';
var logonWindow = null;
var promptWindow=null;
var initial_httpRequest=true;
var ifDoLogon = false;
//var promptIDValue = null;
var promptIDValue = '<%=parameter_prompt_page_url_promptID%>';
var parameter_prompt_page_url = '<%=parameter_prompt_page_url%>';
var parameter_promptID = '<%=parameter_prompt_page_url_promptID%>';

var objXHR = null;
var objXHR2 = null;
try {
  objXHR = new XMLHttpRequest();
  objXHR2 = new XMLHttpRequest();
} catch (e) {
  try {
    objXHR = new ActiveXObject('Msxml2.XMLHTTP');
    objXHR2 = new ActiveXObject('Msxml2.XMLHTTP');
  } catch (e) {
    try {
      objXHR = new ActiveXObject('Microsoft.XMLHTTP');
      objXHR2 = new ActiveXObject('Microsoft.XMLHTTP');
    } catch (e) {
      initial_httpRequest=false;
      alert('Error! We are sorry, your browser does not support XMLHttpRequest\n'+e);
    }
  }
}

function doLogon()
{
    ifDoLogon = true;
    var logon_url = rds_url + '?b_action=xts.run&m=portal/close.xts&h_CAM_action=logonAs';
    logonWindow = window.open(logon_url ,"logonWindow","status=1, toolbar=0, menubar=0, height="+screen.availHeight+", width="+screen.availWidth+", resizable=1" );
}

function getPromptValues()
{
  if(ifError){
  	alert(errorMsg);
  	//parent.callBackError(errorMsg);
  	return;  
  }
  var timestamp=new Date().getTime();
  var params = "status=1, toolbar=0, menubar=0, top=0, left=0, width="+screen.availWidth+", height="+screen.availHeight+", resizable=1, scrollbars=1";
  promptWindow=window.open(parameter_prompt_page_url+'&timeid='+timestamp,"promptWindow", params);

  checkPromptClosed();  
  /*
  var myPromptPage_url=rds_url+"/rds/promptPage/report/"+report_id+'?timeid='+timestamp;

  try
  {
    objXHR.open("GET", myPromptPage_url, true);
    objXHR.onreadystatechange = getPromptValuesCallBack;

    objXHR.send(null);
  }
  catch (e)
  {
    alert(e);
  }
  */
}

function getPromptValuesCallBack()
{
  if (objXHR.readyState == 4)
  {
    if (objXHR.status == 200)
    {

      var myPromptID=objXHR.responseXML.getElementsByTagName("rds:promptID")[0].firstChild.nodeValue;
      var myURL=objXHR.responseXML.getElementsByTagName("rds:url")[0].firstChild.nodeValue;
      //add follow code for Cognos RDS https bug
      if(rds_url.indexOf("https:") > -1){
      	myURL=myURL.replace(/http:/,"https:");
      }
      var timestamp=new Date().getTime();
      if(myURL.indexOf("?") > -1){
      	myURL=myURL+'&timeid='+timestamp;
      }else{
        myURL=myURL+'?timeid='+timestamp;
      }
      promptIDValue=myPromptID;
      var params = "status=1, toolbar=0, menubar=0, top=0, left=0, width="+screen.availWidth+", height="+screen.availHeight+", resizable=1, scrollbars=1";
      promptWindow=window.open(myURL,"promptWindow", params);

      checkPromptClosed();
    } else if (objXHR.status == 403) {

      if (!ifDoLogon){
        doLogon();
        checkLoginClosed();
      } else {

      }
    }
    else
    {
      alert("HTTP ERROR " + objXHR.status + ": " + objXHR.statusText);
      window.status = "Done";
    }
  }
}

function checkLoginClosed()
{
  if (logonWindow!=null && !logonWindow.closed){
    setTimeout('checkLoginClosed()', 1000);
  } else {
    getPromptValues();
  }
}

function getPromptAnswers()
{
  var timestamp=new Date().getTime();
  var myPromptAnswers=rds_url+"/rds/promptAnswers/conversationID/"+promptIDValue+"?timeid="+timestamp;    
  try
  {
    objXHR2.open("GET", myPromptAnswers, true);

    objXHR2.onreadystatechange = getPromptAnswersCallBack;
    objXHR2.send(null);
    }
  catch (e)
  {
    alert(e);
  }
}

function checkPromptClosed()
{
  if (!promptWindow.closed) {
    setTimeout('checkPromptClosed()', 1000);
  } else {
    getPromptAnswers();
  }
}

function XMLtoString(elem){
 var serialized;
  try {
          // XMLSerializer exists in current Mozilla browsers
          serializer = new XMLSerializer();
          serialized = serializer.serializeToString(elem);
   }
   catch(e){
       // Internet Explorer has a different approach to serializing XML
       serialized = elem.xml;
   }
    return serialized;
}

function getPromptAnswersCallBack()
{
  if (objXHR2.readyState == 4)
  {
    if(objXHR2.status == 200)
    {
       iframe = document.getElementById("id_frame_pickup_prompts");
        if(iframe == null){
              iframe = document.createElement('iframe');
              iframe.id = "id_frame_pickup_prompts";
              iframe.src= "about:blank";
              iframe.frameborder = "0";
              iframe.style.width = "0px";
              iframe.style.height = "0px";
              iframe.style.display = 'none';
              iframe.title = 'get_prompts';
              document.body.appendChild(iframe);
              iframe.contentWindow.document.open();
 			  response_xml = XMLtoString(objXHR2.responseXML).replace(/&/g,'%26');
              iframe.contentWindow.document.write("<html><head></head><body><form id='id_form_postData' method='post' target='_self'><input name='responseText' id='id_form_input_responseText' type='text' value='"+encodeURI(response_xml).replace(/\'/g,'%27')+"'/></form></body></html>");
              iframe.contentWindow.document.close();
        }
        iframe.contentWindow.document.getElementById("id_form_postData").action = '<%=cognoscallbackproxy_url%>';
        iframe.contentWindow.document.getElementById("id_form_postData").submit();
    } else {
      alert("HTTP ERROR " + objXHR2.status + ": " + objXHR2.statusText);
      window.status = "Done";
    }

  }
}

//-->
</script>
 <body onload="getPromptValues()" role="application">
 <div class="skip">
<a accesskey="2" href="#content-main">Skip to main content</a>
</div>
<div id="content-main">
</div>
 </body>
</html>

