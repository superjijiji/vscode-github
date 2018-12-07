package transform.edgeportal.bi.portal.web;

public class PortalSeesionBean {

	private static final long	serialVersionUID	= 1L;

	private Long				cuuid;

	private int					activeTotal;

	private String				cwaId;

	private String				sessionId;

	private String				hostName;

	private String				status;

	public Long getCuuid() {
		return cuuid;
	}

	public void setCuuid(Long cuuid) {
		this.cuuid = cuuid;
	}

	public int getActiveTotal() {
		return activeTotal;
	}

	public void setActiveTotal(int activeTotal) {
		this.activeTotal = activeTotal;
	}

	public String getCwaId() {
		return cwaId;
	}

	public void setCwaId(String cwaId) {
		this.cwaId = cwaId;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getHostName() {
		return hostName;
	}

	public void setHostName(String hostName) {
		this.hostName = hostName;
	}

}
