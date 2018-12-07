function checkPanelButtonAccessFlag(buttonAccessList) {

	var accessFlag1 = "0";
	var accessFlag2 = "0";
	var accessFlag3 = "0";
	var accessFlag4 = "0";
	
	if (buttonAccessList != null && buttonAccessList.length == 4) {
		
		var buttonAccess1 = buttonAccessList[0];
		var buttonAccess2 = buttonAccessList[1];
		var buttonAccess3 = buttonAccessList[2];
		var buttonAccess4 = buttonAccessList[3];
		
		if (buttonAccess1 != null && buttonAccess1.success == "0") {
			alert(buttonAccess1.message);
		} else if (buttonAccess2 != null && buttonAccess2.success == "0") {
			alert(buttonAccess2.message);
		} else if (buttonAccess3 != null && buttonAccess3.success == "0") {
			alert(buttonAccess3.message);
		} else if (buttonAccess4 != null && buttonAccess4.success == "0") {
			alert(buttonAccess4.message);
		}
		
		if (buttonAccess1 != null && buttonAccess1.success == "1" && buttonAccess1.access == "1") {
			accessFlag1 = "1";
		}
		
		if (buttonAccess2 != null && buttonAccess2.success == "1" && buttonAccess2.access == "1") {
			accessFlag2 = "1";
		}
		
		if (buttonAccess3 != null && buttonAccess3.success == "1" && buttonAccess3.access == "1") {
			accessFlag3 = "1";
		}
		
		if (buttonAccess4 != null && buttonAccess4.success == "1" && buttonAccess4.access == "1") {
			accessFlag4 = "1";
		}
	}
	
	var accessFlagList = new Array();
	accessFlagList[0] = accessFlag1;
	accessFlagList[1] = accessFlag2;
	accessFlagList[2] = accessFlag3;
	accessFlagList[3] = accessFlag4;
	return accessFlagList;
}