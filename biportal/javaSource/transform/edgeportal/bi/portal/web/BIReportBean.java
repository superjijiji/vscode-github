package transform.edgeportal.bi.portal.web;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

public class BIReportBean implements Serializable {

	/**
	 * 
	 */
	private static final long	serialVersionUID	= 1L;

	private String				rptName;
	private String				rptDesc;
	private String				rptDate;
	private String				rptPath;
	private String				rptObjID;
	private String				helpDoc;
	private boolean				favorite			= false;
	private boolean				subscribe			= false;
	private String				reportType;
	private int					reportTypeCD;
	private String				rptUrl;
	private String				uid;
	private String				cwaid;
	private int					showOrder;
	private String				parentID;
	private String				objectClass;
	private String				refer_Objectid;
	private String				refer_ObjectClass;
	private String				searchPath;
	private String				domain_Key;
	private String				domain_name;
	private String				viewOutput;
	private String				outputFmt;
	private Timestamp			lastAccess;
	private String				parent_folder_id	= "";
	private String[]			userCapabilites;

	// Controllbook
	private String				accessible;
	private int					ctrlbookId;
	private String				ctrlbookName;
	private String				userRptName;
	private String				displayText;
	private String				displayName;

	public String getRptName() {
		return rptName;
	}

	public void setRptName(String rptName) {
		this.rptName = rptName;
	}

	public String getRptDesc() {
		return rptDesc;
	}

	public void setRptDesc(String rptDesc) {
		this.rptDesc = rptDesc;
	}

	public String getRptDate() {
		return rptDate;
	}

	public void setRptDate(String rptDate) {
		this.rptDate = rptDate;
	}

	public String getRptPath() {
		return rptPath;
	}

	public void setRptPath(String rptPath) {
		this.rptPath = rptPath;
	}

	public String getRptObjID() {
		return rptObjID;
	}

	public void setRptObjID(String rptObjID) {
		this.rptObjID = rptObjID;
	}

	public String getHelpDoc() {
		return helpDoc;
	}

	public void setHelpDoc(String helpDoc) {
		this.helpDoc = helpDoc;
	}

	public boolean isFavorite() {
		return favorite;
	}

	public void setFavorite(boolean favorite) {
		this.favorite = favorite;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getRptUrl() {
		return rptUrl;
	}

	public void setRptUrl(String rptUrl) {
		this.rptUrl = rptUrl;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getCwaid() {
		return cwaid;
	}

	public void setCwaid(String cwaid) {
		this.cwaid = cwaid;
	}

	public int getShowOrder() {
		return showOrder;
	}

	public void setShowOrder(int showOrder) {
		this.showOrder = showOrder;
	}

	public String getParentID() {
		return parentID;
	}

	public void setParentID(String parentID) {
		this.parentID = parentID;
	}

	public String getObjectClass() {
		return objectClass;
	}

	public void setObjectClass(String objectClass) {
		this.objectClass = objectClass;
	}

	public String getRefer_Objectid() {
		return refer_Objectid;
	}

	public void setRefer_Objectid(String refer_Objectid) {
		this.refer_Objectid = refer_Objectid;
	}

	public String getRefer_ObjectClass() {
		return refer_ObjectClass;
	}

	public void setRefer_ObjectClass(String refer_ObjectClass) {
		this.refer_ObjectClass = refer_ObjectClass;
	}

	public String getSearchPath() {
		return searchPath;
	}

	public void setSearchPath(String searchPath) {
		this.searchPath = searchPath;
	}

	public String getDomain_Key() {
		return domain_Key;
	}

	public void setDomain_Key(String domain_Key) {
		this.domain_Key = domain_Key;
	}

	public String getViewOutput() {
		return viewOutput;
	}

	public void setViewOutput(String viewOutput) {
		this.viewOutput = viewOutput;
	}

	public String getOutputFmt() {
		return outputFmt;
	}

	public void setOutputFmt(String outputFmt) {
		this.outputFmt = outputFmt;
	}

	public String[] getUserCapabilites() {
		return userCapabilites;
	}

	public void setUserCapabilites(String[] userCapabilites) {
		this.userCapabilites = userCapabilites;
	}

	public String getUserCapabilites(int i) {
		return this.userCapabilites[i];
	}

	public void setUserCapabilites(int i, String value) {
		this.userCapabilites[i] = value;
	}

	public boolean isSubscribe() {
		return subscribe;
	}

	public void setSubscribe(boolean subscribe) {
		this.subscribe = subscribe;
	}

	public Date getLastAccess() {
		return lastAccess;
	}

	public void setLastAccess(Timestamp lastAccess) {
		this.lastAccess = lastAccess;
	}

	public String getDomain_name() {
		return domain_name;
	}

	public void setDomain_name(String domain_name) {
		this.domain_name = domain_name;
	}

	public String getParent_folder_id() {
		return parent_folder_id;
	}

	public void setParent_folder_id(String parent_folder_id) {
		this.parent_folder_id = parent_folder_id;
	}

	public int getReportTypeCD() {
		return reportTypeCD;
	}

	public void setReportTypeCD(int reportTypeCD) {
		this.reportTypeCD = reportTypeCD;
	}

	// For controlbook
	public String getAccessible() {
		return accessible;
	}

	public void setAccessible(String accessible) {
		this.accessible = accessible;
	}

	public int getCtrlbookId() {
		return ctrlbookId;
	}

	public void setCtrlbookId(int ctrlbookId) {
		this.ctrlbookId = ctrlbookId;
	}

	public String getCtrlbookName() {
		return ctrlbookName;
	}

	public void setCtrlbookName(String ctrlbookName) {
		this.ctrlbookName = ctrlbookName;
	}

	public String getUserRptName() {
		return userRptName;
	}

	public void setUserRptName(String userRptName) {
		this.userRptName = userRptName;
	}

	public String getDisplayText() {
		return displayText;
	}

	public void setDisplayText(String displayText) {
		this.displayText = displayText;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see Comparable#compareTo(Object)
	 */
	public int compareTo(Object obj) {
		BIReportBean bean = (BIReportBean) obj;
		return this.getShowOrder() - bean.getShowOrder();
	}

	/*
	 * @see Object#hashCode()
	 */
	public int hashCode() {
		return this.getRptObjID().hashCode();
	}

	/*
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object arg0) {
		if (arg0 instanceof BIReportBean) {
			return (this.getDomain_Key() + this.getRptObjID()).equals(((BIReportBean) arg0).getDomain_Key()
					+ ((BIReportBean) arg0).getRptObjID());
		} else {
			return false;
		}
	}
}
