try {


	/*
	 * Navigation Bars
	 */
	function NavigBars(){
		this.navigBars = null;
	}
	NavigBars.prototype.addBar = function(navigBar){
		if (this.navigBars == null) {
			this.navigBars = new Array();
		}
		this.navigBars.push(navigBar);
	}
	NavigBars.prototype.toString = function(){
		if (this.navigBars == null || this.navigBars.length == 0){
			return "";
		}
		var htmls = '<br><div style="font-size: 14px;">';
		var navigBar 
		for (var int = this.navigBars.length - 1; int >=0;) {
			navigBar = this.navigBars[int];
			if (int == 0) {
				htmls += navigBar.folderName;
			} else {
				htmls += '<a style="font-size: 14px; cursor: pointer;" onclick="setReload(' + navigBar.folderId + ')" >'+navigBar.folderName+'</a>';
				htmls += ' > ';
			};
			int--;
		}
		htmls += '</div><br>'
 
		return htmls;		
	}
 

   function setReload(folderId){
       var oldUrl = window.location.href;
 	   var oldUrls = oldUrl.split("?")[0].split("/");
 	   var baseUrl = '';
 	   for (var i = 0; i < oldUrls.length - 1; i++) {
 	   	baseUrl += oldUrls[i] + '/';
 	   };
 	   
 	   window.location.replace(baseUrl + folderId);
 	   
   }

	function NavigBar(folder){
		this.folderId = folder.folderId;
		this.folderName = folder.folderName;
	}

 
	/*
	 * BlobFolders
	 */
	function Blobfolders(folder_id) {
		this.blobfolders = null;
		this.folderId = folder_id;
	}


	Blobfolders.prototype.addBlobfolder = function(blobfolder) {
		if (this.blobfolders == null) {
			this.blobfolders = new Array();
		}
		this.blobfolders.push(blobfolder);
	}
	

	Blobfolders.prototype.toString = function() {
		if (this.blobfolders == null || this.blobfolders.length == 0) {
			return "";
		}
		var tables = "";
		
		for (i in this.blobfolders) {
			tables += this.blobfolders[i].toString();
			}
		
		return tables;
		
		}
		
	
	function Blobfolder(blobfolder) {
		this.blobfolder = blobfolder;
		this.id = this.blobfolder.rptObjID;
		this.icon_class = "bifolder_Folder_Type_" + "BolbFolder";
		
	}
	
	
	Blobfolder.prototype.toString = function() {
		
		if (this.blobfolder == null) {
			return "";
		}

		var str_blobfolder = "";
		
		str_blobfolder += '<tr >';
 
		// str_blobfolder += '<td style="vertical-align: top;padding-top: 10px;"><div id="'+this.id+'_image" class="'+this.icon_class+'"/></td>';
		str_blobfolder += '<td style="vertical-align: top;padding-top: 10px;"><div id="'+this.id+'_image" class="'+this.icon_class+'"/></td>';
		str_blobfolder += '<td>';

		str_blobfolder += '<a onclick="setReload(' + this.id + ')"' + ' style="cursor: pointer">' + this.blobfolder.rptName + '</a>';
		str_blobfolder += '</td>';
		str_blobfolder += '<td>' + this.blobfolder.rptDate + '</td>';
		str_blobfolder += '<td></td>'  ;
		str_blobfolder += '</tr>';


		return str_blobfolder;
	}
	
} catch (oException) {
	alert(oException);
}