try {

	/*
	 * unsubscribeUser obj
	 */
	function UnsubscribeUsers() {
		this.unsubscribes = null;
	}

	UnsubscribeUsers.prototype.addUnsubscribe = function(Unsubscribe) {
		if (this.unsubscribes == null) {
			this.unsubscribes = new Array();
		}
		this.unsubscribes.push(Unsubscribe);
	}
	UnsubscribeUsers.prototype.toString = function() {
		if (this.unsubscribes == null || this.unsubscribes.length == 0) {
			return "";
		}
		var bodyValues = "";
		if (this.unsubscribes != null && this.unsubscribes.length > 0) {
			for (var i = 0; i < this.unsubscribes.length; i++) {
				var Unsubscribe = this.unsubscribes[i];
				bodyValues += Unsubscribe.toString();
			}
		}
		return bodyValues;
	}

	UnsubscribeUsers.prototype.empty = function() {
		if (this.unsubscribes != null) {
			this.unsubscribes.length = 0;
		}
	}
	UnsubscribeUsers.prototype.getUnsubscribe = function(request_id) {
		if (this.unsubscribes != null && this.unsubscribes.length > 0) {
			for (var i = 0; i < this.unsubscribes.length; i++) {
				if (this.unsubscribes[i].id === request_id) {
					return this.unsubscribes[i];
				}
			}
		}
		return null;
	}

	Date.prototype.format = function(format) {
		var date = {
			"M+" : this.getMonth() + 1,
			"d+" : this.getDate(),
			"h+" : this.getHours()
		};
		if (/(y+)/i.test(format)) {
			format = format.replace(RegExp.$1, (this.getFullYear() + '')
					.substr(4 - RegExp.$1.length));
		}
		for ( var k in date) {
			if (new RegExp("(" + k + ")").test(format)) {
				format = format.replace(RegExp.$1,
						RegExp.$1.length == 1 ? date[k] : ("00" + date[k])
								.substr(("" + date[k]).length));
			}
		}
		return format;
	}

	/*
	 * unsubscribe
	 */

	function Unsubscribe(UnsubscribeUser) {
		this.id = UnsubscribeUser.id.requestId;
		this.cwaId = UnsubscribeUser.id.cwaId;
		this.rptType = UnsubscribeUser.id.reportType;

		this.date = new Date(UnsubscribeUser.date);

		var newDateForDisplay = new Date();
		newDateForDisplay.setTime(this.date);
		this.date = newDateForDisplay.format('yyyy-MM-dd');

	}

	// Unsubscribe.prototype.toString = function() {
	// var str = "";
	// str = "<TR>";
	// str += "<TD scope='row'><span class='ibm-checkbox-wrapper'> ";
	// str += "<input id='unsubscribe_manage_" + this.id + "_checkbox'"
	// + " type='checkbox' name='unsubscribe_checkbox' unsubSribeID='"
	// + this.id + "' class='ibm-styled-checkbox' /> ";
	// str += "<label for='unsubscribe_manage_"
	// + this.id
	// + "_checkbox'"
	// + " class='ibm-field-label'><span class='ibm-access'>Select
	// row</span></label></span></td>";
	//
	// str += "<TD>" + this.cwaId + "</TD>";
	// str += "<TD>" + this.date + "</TD>";
	// str += "</TR>"
	// return str;
	// }

} catch (oException) {
	alert(oException);
}