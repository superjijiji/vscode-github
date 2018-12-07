try {

    /*
     * autodeck upload file
     */
    function Autouploads() {
        this.uploadfiles = null;
    }

    Autouploads.prototype.addUploadFile = function(uploadfile) {
        if (this.uploadfiles == null) {
            this.uploadfiles = new Array();
        }
        this.uploadfiles.push(uploadfile);
    }

    Autouploads.prototype.toString = function() {

        if (this.uploadfiles == null || this.uploadfiles.length == 0) {
            return "";
        }
        var tables = "";

        if (this.uploadfiles != null && this.uploadfiles.length > 0) {
            for (var i = 0; i < this.uploadfiles.length; i++) {
                var Uploadfile = this.uploadfiles[i];
                tables += Uploadfile.toString();
            }
        }
        //tables += '</TBODY>';
        //tables += '</TABLE>';
        return tables;
    }

    Autouploads.prototype.empty = function() {
        if (this.uploadfiles != null) {
            this.uploadfiles.length = 0;
        }
    }

    Autouploads.prototype.getUploadfile = function(request_id) {
            if (this.uploadfiles != null && this.uploadfiles.length > 0) {
                for (var i = 0; i < this.uploadfiles.length; i++) {
                    if (this.uploadfiles[i].id === request_id) {
                        return this.uploadfiles[i];
                    }
                }
            }
            return null;
        }
    
    Date.prototype.format = function(format) {
    	var date = {
	    	"M+": this.getMonth() + 1,
	    	"d+": this.getDate(),
    	};
    	if (/(y+)/i.test(format)) {
    		format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    	}
    	for (var k in date) {
	    	if (new RegExp("(" + k + ")").test(format)) {
		    	format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
	    	}
    	}
    	return format;
    }  
        /*
         * Uploadfile
         */

    function Uploadfile(AutofileUpload) {
        this.id = AutofileUpload.requestId;
        this.name = AutofileUpload.fileName;
        this.fileName = AutofileUpload.fileName;
        this.desc = AutofileUpload.fileDesc;
        this.createTime = AutofileUpload.creationTime;
        this.updateTime = AutofileUpload.updateTime;
        this.expirateDate = new Date(AutofileUpload.expirationDate);
        this.status = AutofileUpload.status

        
        if (this.updateTime > this.createTime) {
            this.displayTime = new Date(this.updateTime);
            
            this.actionStr = "Updated: ";
        } else {
            this.displayTime = new Date(this.createTime);
            this.actionStr = "Created: ";
        }
        // update display time 2017-06-27
        //this.displayTime.toUTCString()；
        var newDisplayTime = new Date();
        newDisplayTime.setTime(this.displayTime);
        this.displayTime=newDisplayTime.toGMTString();
		
        var newDate = new Date();
        newDate.setTime(this.expirateDate);
        this.expirateDate = newDate.format('yyyy-MM-dd');
        
        if(AutofileUpload.fileName.indexOf('NOT Found this file on Autodeck server') !=-1){
        	this.fileName=AutofileUpload.fileName.substring(44);
        }

    }

    Uploadfile.prototype.toString = function() {
        var str = "";
        str = "<TR>";
        str += "<TD scope='row'><span class='ibm-checkbox-wrapper'> ";
        str += "<input id='xls_manage_" + this.id + "_checkbox'" + " type='checkbox' name='xls_checkbox' xlsID='" + this.id + "' class='ibm-styled-checkbox' /> ";
        str += "<label for='xls_manage_" + this.id + "_checkbox'" + "	class='ibm-field-label'><span class='ibm-access'>Select	row</span></label></span></td>";
        str += "<TD><A href=\"#\" onClick=\"loadUpload('" + this.id + "'); return 0;\">" + this.id + "</A></TD>"; // wait for the URL for update page.
        str += "<TD><span style='color: #333333; font-weight: bold;'>" + this.name + "</span><br>" + this.actionStr + this.displayTime + "</TD>";
        str += "<TD>" + this.desc + "</TD>";
        str += "<TD>" + this.status + "</TD>";
        str += "<TD>" + this.expirateDate + "</TD>";
        str += "</TR>"
        return str;
    }

} catch (oException) {
    alert(oException);
}