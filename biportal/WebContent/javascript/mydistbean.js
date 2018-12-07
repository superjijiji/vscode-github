try {

	/*
	 * my distbean list
	 */
	function DistbeanList() {
		this.distbeanlist = null;
	}

	DistbeanList.prototype.addDistBean = function(DistBean) {
		if (this.distbeanlist == null) {
			this.distbeanlist = new Array();
		}
		this.distbeanlist.push(DistBean);
	}

	DistbeanList.prototype.empty = function() {
		if (this.distbeanlist != null) {
			this.distbeanlist.length = 0;
		}
	}
	DistbeanList.prototype.getDistBean = function(dist_name) {
		if (this.distbeanlist != null && this.distbeanlist.length > 0) {
			for (var i = 0; i < this.distbeanlist.length; i++) {
				if (this.distbeanlist[i].distName === dist_name) {
					return this.distbeanlist[i];
				}
			}
		}
		return null;
	}

	/*
	 * dist list bean
	 */

	function DistBean(DistBean) {
		this.cwaId = DistBean.cwaId;
		this.uid = DistBean.uid;
		this.distName = DistBean.distName;
		this.emailStr = DistBean.eMailAddress;

		if (DistBean.inUse) {
			this.inUse = "YES";
		} else {
			this.inUse = "NO";
		}
	}

} catch (oException) {
	alert(oException);
}