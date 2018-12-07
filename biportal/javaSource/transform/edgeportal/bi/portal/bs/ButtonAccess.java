package transform.edgeportal.bi.portal.bs;

import java.io.Serializable;

/**
 * It's used to control button access in panel. 
 * 
 * @author yhqin
 *
 */
public class ButtonAccess implements Serializable {

	private static final long	serialVersionUID	= 1L;
	
	public ButtonAccess() {}
	
	// it's 1 when this user is in bluegroup
	// it's 0 when this user is NOT in bluegroup
	private String access;
	// it's 1 when call bluegroup api to check user status successully
	// it's 0 when failed to call bluegroup or any other issues, for example network issue .etc
	private String success;
	// error message to show why failed to check user status
	// it must have text when success = 0
	// it is null when success = 1
	private String message;

	public String getAccess() {
		return access;
	}
	public void setAccess(String access) {
		this.access = access;
	}
	public String getSuccess() {
		return success;
	}
	public void setSuccess(String success) {
		this.success = success;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

}
