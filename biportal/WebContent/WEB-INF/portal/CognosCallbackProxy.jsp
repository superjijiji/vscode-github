
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>BI@IBM | Cognos Schedule</title>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="BI@IBM HTML Wrapper" name="Description">
<meta content="Reports, BI@IBM, on demand, EDGE, Brio, BrioQuery"
	name="Keywords">
<meta content="edgeadm@us.ibm.com" name="Owner">
<meta content="edgeadm@us.ibm.com" name="feedback">
<meta content="index,follow" name="Robots">
<meta content="IBM internal use only" name="Security">
<meta content="v8 Template Generator" name="Source">
<meta content="US" name="IBM.Country">
<meta content="2004-02-19" scheme="iso8601" name="DC.Date">
<meta content="en-US" scheme="rfc1766" name="DC.Language">
<meta content="Copyright (c) 2001,2004 by IBM Corporation"
	name="DC.Rights">
<meta content="ZZ999" scheme="IBM_ContentClassTaxonomy" name="DC.Type">
<meta content="" scheme="IBM_SubjectTaxonomy" name="DC.Subject">
<meta content="IBM Corporation" name="DC.Publisher">
<meta content="" scheme="W3CDTF" name="IBM.Effective">
<meta content="ZZ" scheme="IBM_IndustryTaxonomy" name="IBM.Industry">
</head>
<body role="application">
	<%
String responseText = request.getParameter("responseText");
%>
	<script language="javascript">
function UrlDecode(str){
  var ret="";
  for(var i=0;i<str.length;i++){
   var chr = str.charAt(i);
    if(chr == "+"){
      ret+=" ";
    }else if(chr=="%"){
     var asc = str.substring(i+1,i+3);
     if(parseInt("0x"+asc)>0x7f){
      ret+=String.fromCharCode((parseInt("0x"+asc+str.substring(i+4,i+6))));
      i+=5;
     }else{
      ret+=String.fromCharCode((parseInt("0x"+asc)));
      i+=2;
     }
    }else{
      ret+= chr;
    }
  }
  return ret;
}

var responseText = UrlDecode('<%=java.net.URLEncoder.encode(responseText,"utf-8")%>');
parent.parent.callBackPromptSelected(responseText);

</script>
	<div class="skip">
		<a accesskey="2" href="#content-main">Skip to main content</a>
	</div>
	<div id="content-main"></div>
</body>
</html>

