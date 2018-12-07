package transform.edgeportal.bi.portal.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import transform.edgeportal.bi.jpa.link.Link;
import transform.edgeportal.bi.portal.bs.ButtonAccess;

@Controller
public class BaseController {

	@Value("${restfulServerUrl}")
	private String			restfulServerUrl;

	@Value("${slaphApiBluePageUrl1}")
	private String			SLAPHAPI_BLUEPAGE_URL_1;

	@Value("${slaphApiBluePageUrl2}")
	private String			SLAPHAPI_BLUEPAGE_URL_2;

	@Value("${bluegroupXmlApi_inOneGroup}")
	private String			BLUEGROUP_XML_API_IN_ONE_GROUP;

	@Value("${bluegroupXmlApi_inAnyGroup}")
	private String			BLUEGROUP_XML_API_IN_ANY_GROUP;
	
	@Value("${link_adminSecurity}")
	private String linkByModule;

	@Autowired
	private RestTemplate	restTemplate;

	// @Autowired
	// HttpSession session;

	@ModelAttribute
	public void setIntranetID(HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean load_uid = false;
		String loginUserEmail = request.getRemoteUser();

		String loginUserUid = "";
		if (loginUserEmail == null || loginUserEmail.equals("")) {
			throw new Exception("System error, Can not get user logon id!");
		}
		// after moving to W3ID, we get cwaid as format
		// "/w3id.sso.ibm.com/auth/sps/samlidp/saml20/ZHAOYUT@cn.ibm.com"
		// so we need to add following codes to get real intranet id
		if (loginUserEmail.contains("/")) {
			loginUserEmail = loginUserEmail.substring(loginUserEmail.lastIndexOf("/") + 1);
		}
		HttpSession session = request.getSession(true);
		String session_cwa_id = (String) session.getAttribute("cwa_id");
		if (session_cwa_id == null || session_cwa_id.trim().equals("")) {
			load_uid = true;
		} else if (session_cwa_id.equals(loginUserEmail)) {
			load_uid = false;
		} else {
			load_uid = true;
		}
		if (load_uid == false) {
			loginUserUid = (String) session.getAttribute("uid");
			if (loginUserUid == null || loginUserUid.trim().equals("")) {
				load_uid = true;
			}
		}
		if (load_uid == true) {
			loginUserUid = getUidByIntranetID(loginUserEmail);
			if (loginUserUid == null || loginUserUid.trim().equals("")) {
				// throw new SystemException("");
			}
			session.setAttribute("cwa_id", loginUserEmail);
			session.setAttribute("uid", loginUserUid);
		}
	}

	/**
	 * @param cwa_id
	 *            - Intranet ID
	 * @return uid - serials number
	 */
	protected String getUidByIntranetID(String cwa_id) {
		// bluepages returns:
		// "dn: uid=201580672,c=cn,ou=bluepages,o=ibm.comuid: 201580672# rc=0, count=1, message=Success"
		String text = getRestTemplate().getForObject(
				SLAPHAPI_BLUEPAGE_URL_1 + cwa_id.trim() + SLAPHAPI_BLUEPAGE_URL_2,
				String.class);
		if (text.contains("rc=0, count=1, message=Success")) {
			return text.split("uid=")[1].split(",")[0].trim();
		} else {
			return null;
		}
	}

	public String getRestfulServerUrl() {
		return restfulServerUrl;
	}

	public String getIntranetID() {
		HttpSession session = (HttpSession) ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest().getSession(false);
		if (session == null) {
			return "dummy@us.ibm.com";
		}
		Object obj = session.getAttribute("cwa_id");
		if (obj == null) {
			return "dummy@us.ibm.com";
		}
		return (String) obj;
	}

	public String getUserUid() {
		HttpSession session = (HttpSession) ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest().getSession(false);
		if (session == null) {
			return "dummy";
		}
		Object obj = session.getAttribute("uid");
		if (obj == null) {
			return "dummy";
		}
		return (String) obj;
	}

	public RestTemplate getRestTemplate() {
		return restTemplate;
	}

	public boolean isUserInOneGroup(String cwa_id, String group_name) {
		String text = getRestTemplate().getForObject(BLUEGROUP_XML_API_IN_ONE_GROUP, String.class, cwa_id, group_name);
		return text.contains("<rc>0</rc>");
	}

	public boolean isUserInAnyGroup(String cwa_id, String[] groups) {
		StringBuffer tmp = new StringBuffer(BLUEGROUP_XML_API_IN_ANY_GROUP);
		tmp.append("&email=" + cwa_id);
		for (String name : groups) {
			tmp.append("&group=" + name);
		}
		String text = this.getRestTemplate().getForObject(tmp.toString(), String.class);
		return text.contains("<rc>0</rc>");
	}

	/**
	 * Check button access in a panel for user.
	 * 
	 * @param request http request
	 * @param module refer to column MODULE in table EOD.LINK
	 * @param cwa_id user intranet id
	 * @return a list which must contain 4 ButtonAccess
	 */
	public List<ButtonAccess> checkPanelButtonAccess(HttpServletRequest request, String module, String cwa_id) {
		
		Object eodlink = request.getAttribute("eodlink");
		List<ButtonAccess> buttonAccessList = new ArrayList<ButtonAccess>();
		
		if (eodlink == null) {
			buttonAccessList = getLinkByModuleAndCheckButtonAccess(request, module, cwa_id);
		} else {
			Link link = (Link) eodlink;
			if (module.equals(link.getModule())) {
				buttonAccessList.add(checkOneButtonBluegroup(cwa_id, link.getButtonGroup1()));
				buttonAccessList.add(checkOneButtonBluegroup(cwa_id, link.getButtonGroup2()));
				buttonAccessList.add(checkOneButtonBluegroup(cwa_id, link.getButtonGroup3()));
				buttonAccessList.add(checkOneButtonBluegroup(cwa_id, link.getButtonGroup4()));
			} else {
				buttonAccessList = getLinkByModuleAndCheckButtonAccess(request, module, cwa_id);
			}
		}
		
		return buttonAccessList;
	}
	
	private List<ButtonAccess> getLinkByModuleAndCheckButtonAccess (HttpServletRequest request, String module, String cwa_id) {
		
		List<ButtonAccess> buttonAccessList = new ArrayList<ButtonAccess>();
		
		try {
			Link[] links = this.getRestTemplate().getForObject(getRestfulServerUrl() + linkByModule, Link[].class, cwa_id, module);
			if (links.length < 1) {
				// do not need to check button access
				buttonAccessList = createFailedListButtonAccess("Invalid URL: " + request.getRequestURI() + ". So you can not do any action now.");
			} else {
				Link link = links[0];
				buttonAccessList.add(checkOneButtonBluegroup(cwa_id, link.getButtonGroup1()));
				buttonAccessList.add(checkOneButtonBluegroup(cwa_id, link.getButtonGroup2()));
				buttonAccessList.add(checkOneButtonBluegroup(cwa_id, link.getButtonGroup3()));
				buttonAccessList.add(checkOneButtonBluegroup(cwa_id, link.getButtonGroup4()));
			}
		} catch (Exception e) {
			// exception when call biapi to get link by module
			buttonAccessList = createFailedListButtonAccess("System error: error in getting security role, rest client issue, probably timeout. Please try later.");
		}
		
		return buttonAccessList;
	}
	
	private ButtonAccess checkOneButtonBluegroup(String cwa_id, String blueGroup) {
		
		ButtonAccess buttonAccess = new ButtonAccess();
		
		if (blueGroup == null || "".equals(blueGroup)) {
			buttonAccess.setSuccess("1");
			buttonAccess.setAccess("0");
		} else {
			try {
				String text = this.getRestTemplate().getForObject(BLUEGROUP_XML_API_IN_ONE_GROUP, String.class, cwa_id, blueGroup);
				if (text.contains("<rc>0</rc>")) {
					buttonAccess.setSuccess("1");
					buttonAccess.setAccess("1");
				} else {
					buttonAccess.setSuccess("1");
					buttonAccess.setAccess("0");
				}		
			} catch (Exception e) {
				buttonAccess.setSuccess("0");
				buttonAccess.setAccess("0");
				buttonAccess.setMessage("System error: error in accessing bluegroups server for bluegroup " + blueGroup + ". Please try later.");
			}
		}
		
		return buttonAccess;
	}
	
	private List<ButtonAccess> createFailedListButtonAccess(String message) {
		
		List<ButtonAccess> buttonAccessList = new ArrayList<ButtonAccess>();
		buttonAccessList.add(createFailedOneButtonAccess(message));
		buttonAccessList.add(createFailedOneButtonAccess(message));
		buttonAccessList.add(createFailedOneButtonAccess(message));
		buttonAccessList.add(createFailedOneButtonAccess(message));
		return buttonAccessList;
	}
	
	private ButtonAccess createFailedOneButtonAccess(String message) {
		
		ButtonAccess button = new ButtonAccess();
		button.setSuccess("0");
		button.setAccess("0");
		button.setMessage(message);
		return button;
	}
}
