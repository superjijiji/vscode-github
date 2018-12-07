package transform.edgeportal.bi.portal.bs;

public class UploadBean {

	private String	cwaId							= null;
	private String	uid								= null;
	private String	repository						= null;
	private String	request_id						= null;
	private String	encoding						= "ISO-8859-1"; // charactor encoding,utf-8
	private int		uploadXLS_expired_days;
	private int		sizeThreshold;
	private long	filesSize						= 0;			// total file size of uploaded
	private long	sizeMax;										// 80*1024*1024;//80M default
	private String	fileNameWithoutExtensionName	= null;
	private String	fileDescription					= null;
	private String	fileType						= null;
	private String	fileStatus						= null;
	private String	returnMsg						= null;

	public String getCwaId() {
		return cwaId;
	}

	public void setCwaId(String cwaId) {
		this.cwaId = cwaId;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getRepository() {
		return repository;
	}

	public void setRepository(String repository) {
		this.repository = repository;
	}

	public String getRequest_id() {
		return request_id;
	}

	public void setRequest_id(String request_id) {
		this.request_id = request_id;
	}

	public String getEncoding() {
		return encoding;
	}

	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}

	public int getUploadXLS_expired_days() {
		return uploadXLS_expired_days;
	}

	public void setUploadXLS_expired_days(int uploadXLS_expired_days) {
		this.uploadXLS_expired_days = uploadXLS_expired_days;
	}

	public int getSizeThreshold() {
		return sizeThreshold;
	}

	public void setSizeThreshold(int sizeThreshold) {
		this.sizeThreshold = sizeThreshold;
	}

	public long getFilesSize() {
		return filesSize;
	}

	public void setFilesSize(long filesSize) {
		this.filesSize = filesSize;
	}

	public long getSizeMax() {
		return sizeMax;
	}

	public void setSizeMax(long sizeMax) {
		this.sizeMax = sizeMax;
	}

	public String getFileNameWithoutExtensionName() {
		return fileNameWithoutExtensionName;
	}

	public void setFileNameWithoutExtensionName(String fileNameWithoutExtensionName) {
		this.fileNameWithoutExtensionName = fileNameWithoutExtensionName;
	}

	public String getFileDescription() {
		return fileDescription;
	}

	public void setFileDescription(String fileDescription) {
		this.fileDescription = fileDescription;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFileStatus() {
		return fileStatus;
	}

	public void setFileStatus(String fileStatus) {
		this.fileStatus = fileStatus;
	}

	public String getReturnMsg() {
		return returnMsg;
	}

	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}

}
