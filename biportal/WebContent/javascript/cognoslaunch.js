//	cognosLaunch() utility
//  
//  Copyright (C) 2008 Cognos ULC, an IBM Company. All rights reserved.
//  Cognos (R) is a trademark of Cognos ULC, (formerly Cognos Incorporated).
//
//	Usage: cognosLaunch("ui.gateway","<gateway_uri>", "ui.tool","<studio_name>" [,"<name>","value>"]*)
//	Example: cognosLaunch("gateway","http://myserver:80/series8/cgi-bin/cognos.cgi","ui.tool","ReportStudio");
//     parameter "ui.gateway" is mandatory. If "gateway" is a null string, the function will assume a relative path.
//
//
//	Usage: cognosLaunchInWindow(winName, winProperties,
//							"ui.gateway","<gateway_uri>", "ui.tool","<studio_name>" [,"<name>","value>"]*)
//	Example: cognosLaunch( "mywindow", "height=300,width=400,scrollbars=yes,resizable=yes",
//                         "ui.gateway","http://myserver:80/series8/cgi-bin/cognos.cgi","ui.tool","ReportStudio");
//
//    if winName is null, empty or "_blank", a new window will be created with a random name
//    if no window named winName exists, a new window with that name will be created 
//    if a window named winName already exists, the studio will be loaded into that window.
//	  winProperties is a string containing a list of parameters that control the aspect/behavior of the new window
//
function cognosLaunch()
{
	var JSINFRAMEPARAM = "launch.openJSStudioInFrame";
	var jsinframeSpecified = false;

	var numArgs = arguments.length;
	var argsOut = new Array();

	for (var i = 0; i < numArgs; i += 2)
	{
		argsOut[i] = arguments[i];
		argsOut[i + 1] = arguments[i + 1];
		if ((jsinframeSpecified == false) && (arguments[i] == JSINFRAMEPARAM))
		{
			jsinframeSpecified = true;
		}
	}

	// If launch.openJSStudioInFrame hasn't been specified, set it to true as
	// when using cognosLaunch() we want the studio to open up in the existing
	// window.
	if (jsinframeSpecified == false)
	{
		argsOut[numArgs] = JSINFRAMEPARAM;
		argsOut[numArgs + 1] = 'true';
	}
	cognosLaunchArgArray(argsOut, "_self");
}

function cognosLaunchWithTarget(target)
{
	// remove the target from the arguments array so we can pass the rest onto
	// the usual congosLaunchArgArray
	var newArguments = new Array();
	var index;
	for (index = 1; index < arguments.length; index++)
	{
		newArguments[index - 1] = arguments[index];
	}

	if (target == '')
		cognosLaunchArgArray(newArguments, "_self");
	else
		cognosLaunchArgArray(newArguments, target);
}

function cognosLaunchInWindow(winName, winProperties)
{
	var target = winName;
	var newWindow = null;

	if (winName == null || winName == "_blank" || winName == "")
	{
		winName = "_blank";
		target = "_self";
	}
	if (!(winName == "_top" || winName == "_parent" || winName == "_self"))
	{
		newWindow = window.open("", winName, winProperties);
		newWindow.focus();
	}

	var argsOut = new Array();
	for (var i = 2; i < arguments.length; i++)
	{
		argsOut[i - 2] = arguments[i];
	}
	var numArgs = argsOut.length;
	argsOut[numArgs] = 'launch.launchInWindow';
	argsOut[numArgs + 1] = 'true';
	cognosLaunchArgArray(argsOut, target, newWindow);
}

function cognosLaunchArgArray(argArray, strTarget, winTarget)
{
	var ERR_NOGATEWAY = "cognosLaunch() error: ui.gateway parameter is missing.";
	var ERR_UNEVEN = "cognosLaunch() error: Uneven number of arguments.";
	var GATEWAYPARAM = "ui.gateway";

	var numArgs = argArray.length;
	var gateway = "";
	var gatewaySpecified = false;

	var docTarget = window.document;
	if (winTarget != null)
	{
		docTarget = winTarget.document;
	}

	var formElement = docTarget.createElement("form");
	formElement.setAttribute("name", "xtslaunch");
	formElement.setAttribute("method", "POST");
	formElement.setAttribute("target", strTarget);

	if ((numArgs % 2) != 0)
	{
		alert(ERR_UNEVEN);
		return;
	}

	for (var i = 0; i < numArgs; i += 2)
	{
		if (argArray[i] == GATEWAYPARAM)
		{
			gateway = argArray[i + 1];
			gatewaySpecified = true;
			break;
		}
	}

	if (!gatewaySpecified)
	{
		alert(ERR_NOGATEWAY);
		return;

	}

	if (gateway == "")
	{
		// No gateway specified. Generate an absolute gateway from the current
		// location. NOTE: An absolute gateway is needed so the that created
		// form will properly submit in FireFox.
		gateway = location.protocol + "//" + location.host + location.pathname;
	}

	// Convert a relative gateway into an absolute gateway for the created form.
	// NOTE: An absolute gateway is needed so the that created form will
	// properly submit in FireFox.
	if ((gateway.indexOf("http://") != 0) && (gateway.indexOf("https://") != 0))
	{
		gateway = location.protocol + "//" + location.host + gateway;
	}

	formElement.setAttribute("action", gateway);
	var hiddenElement = docTarget.createElement("input");
	hiddenElement.setAttribute("type", "hidden");
	hiddenElement.setAttribute("name", "b_action");
	hiddenElement.setAttribute("value", "xts.run");
	formElement.appendChild(hiddenElement);

	hiddenElement = docTarget.createElement("input");
	hiddenElement.setAttribute("type", "hidden");
	hiddenElement.setAttribute("name", "m");
	hiddenElement.setAttribute("value", "portal/launch.xts");
	formElement.appendChild(hiddenElement);

	for (var i = 0; i < numArgs; i += 2)
	{
		hiddenElement = docTarget.createElement("input");
		hiddenElement.setAttribute("type", "hidden");
		hiddenElement.setAttribute("name", argArray[i]);
		hiddenElement.setAttribute("value", argArray[i + 1]);
		formElement.appendChild(hiddenElement);
	}

	if (document.all && navigator.userAgent.toLowerCase().indexOf("msie") != -1)
	{
		docTarget.appendChild(formElement);
		formElement.submit();
		docTarget.removeChild(formElement);
	}
	else
	{
		docTarget.body.appendChild(formElement);
		formElement.submit();
		docTarget.body.removeChild(formElement);
	}
	formElement = null;
}