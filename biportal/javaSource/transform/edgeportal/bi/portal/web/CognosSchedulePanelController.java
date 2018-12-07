/**
 * 
 */
package transform.edgeportal.bi.portal.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import transform.edgeportal.bi.jpa.schedulepanel.CognosSchedulePanel;

/**
 * @author leo
 *
 */
@Controller
public class CognosSchedulePanelController extends BaseController {

	private static final Logger	log						= Logger.getLogger(CognosSchedulePanelController.class);

	@Value("${loadCognosSchedule}")
	private String				loadCognosScheduleURL;

	@Value("${saveCognosSchedule}")
	private String				saveCognosScheduleURL;

	@Value("${loadRunningErrlog}")
	private String				loadRunningErrlogURL;

	@Value("${createCognosSchedule}")
	private String				createCognosScheduleURL;

	@Value("${copyCognosSchedule}")
	private String				copyCognosScheduleURL;

	@Value("${addToMyFavorites}")
	private String				addToMyFavoritesURL;

	@Value("${getSession}")
	private String				getSessionURL;

	@Value("${openPromptpage}")
	private String				openPromptpageURL;

	@Value("${loadExistingSchedule}")
	private String				loadExistingScheduleURL;

	@Value("${updateActiveInactive}")
	private String				updateActiveInactiveURL;

	@Value("${deleteCognosSchedule}")
	private String				deleteCognosScheduleURL;

	@Value("${extendDateCognosSchedule}")
	private String				extendDateCognosScheduleURL;

	@Value("${getCognosReport}")
	private String				getCognosReportURL;

	public final static String	CAM_PASSPORT_NAME		= "cam_passport";
	public final static String	CC_SESSION_NAME			= "cc_session";
	public final static String	CEA_SSA_NAME			= "cea-ssa";
	public final static String	CRN_NAME				= "CRN";
	public final static String	USERCAPABILITIES_NAME	= "userCapabilities";
	public final static String	USERSESSIONID_NAME		= "usersessionid";
	public final static String	CC_LOGON				= "cc_logon";

	@RequestMapping(value = "/portal/schedulePanel/openCognosSchedulePanel/{requestID}/{domainKey}", method = RequestMethod.GET)
	public ModelAndView openCognosSchedulePanel(@PathVariable String requestID, @PathVariable String domainKey) {
		log.info(requestID);
		log.info(domainKey);

		ModelAndView mav = new ModelAndView("/WEB-INF/portal/cognosSchedulePanel.jsp");
		mav.addObject("requestID", requestID);
		mav.addObject("domainKey", domainKey);
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());			
		return mav;
	}

	@RequestMapping(value = "/portal/schedulePanel/loadCognosSchedule/{requestID}/{domainKey}", method = RequestMethod.GET)
	@ResponseBody
	public Object loadCognosSchedule(@PathVariable String requestID, @PathVariable String domainKey) {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + loadCognosScheduleURL,
				Object.class,
				this.getIntranetID(),
				this.getUserUid(),
				requestID,
				domainKey);
	}

	@RequestMapping(value = "/portal/schedulePanel/saveCognosSchedule", method = RequestMethod.POST)
	@ResponseBody
	public CognosSchedulePanel saveCognosSchedule(@RequestBody CognosSchedulePanel csp) {
		log.info("save cognos schedule - " + csp.getRequestID());
		return this.getRestTemplate()
				.postForObject(this.getRestfulServerUrl() + saveCognosScheduleURL, csp, CognosSchedulePanel.class);
	}

	@RequestMapping(value = "/portal/schedulePanel/getErrLogPage/{running_id}", method = RequestMethod.GET)
	public ModelAndView getErrLogPage(@PathVariable String running_id) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/cognosScheduleErrLog.jsp");
		mav.addObject("running_id", running_id);
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());					
		return mav;
	}

	@RequestMapping(value = "/portal/schedulePanel/getCognosReportDesc", method = RequestMethod.GET)
	public ModelAndView getCognosReportDesc(
			@RequestParam String cognos_cd,
			@RequestParam String cwa_id,
			@RequestParam String content_id) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/cognosReportDesc.jsp");
		mav.addObject("cognos_cd", cognos_cd);
		//mav.addObject("cwa_id", cwa_id);
		mav.addObject("content_id", content_id);
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());			
		
		return mav;
	}

	@RequestMapping(value = "/portal/schedulePanel/getCognosReport", method = RequestMethod.GET)
	@ResponseBody
	public Object getCognosReport(
			@RequestParam String cognos_cd,
			@RequestParam String cwa_id,
			@RequestParam String content_id) {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + getCognosReportURL,
				Object.class,
				this.getUserUid(),
				cognos_cd,
				cwa_id,
				content_id);
	}

	@RequestMapping(value = "/portal/schedulePanel/loadRunningErrlog/{running_id}", method = RequestMethod.GET)
	@ResponseBody
	public List loadRunningErrlog(@PathVariable String running_id) {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + loadRunningErrlogURL,
				List.class,
				this.getIntranetID(),
				this.getUserUid(),
				running_id);
	}

	@RequestMapping(value = "/portal/schedulePanel/createCognosSchedulePage", method = RequestMethod.GET)
	public ModelAndView createCognosSchedulePage(
			@RequestParam String rptAccessID,
			@RequestParam String domainKey,
			@RequestParam String referObjectid,
			@RequestParam String searchPath) {
		if (!referObjectid.equals("NULL") && !rptAccessID.equals(referObjectid)) {
			rptAccessID = referObjectid;
		}

		ModelAndView mav = new ModelAndView("/WEB-INF/portal/cognosSchedulePanel.jsp");
		mav.addObject("rptAccessID", rptAccessID);
		mav.addObject("domainKey", domainKey);
		mav.addObject("searchPath", searchPath);
		mav.addObject("cspAction", "create");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());	
		return mav;
	}

	@RequestMapping(value = "/portal/schedulePanel/createCognosSchedule", method = RequestMethod.GET)
	@ResponseBody
	public CognosSchedulePanel createCognosSchedule(
			@RequestParam String rptAccessID,
			@RequestParam String domainKey,
			@RequestParam String searchPath) {

		log.info("creating TBS, rptAccessID:" + rptAccessID);
		log.info("creating TBS, domainKey:" + domainKey);
		log.info("creating TBS, searchPath:" + searchPath);

		String prefix = domainKey + "_";
		String cam_passport = "empty";
		String cc_session = "empty";
		String cea_ssa = "empty";
		String crn = "empty";
		String userCapabilities = "empty";
		String usersessionid = "empty";
		String cc_logon = "empty";
		//
		Cookie[] cookies = request.getCookies();
		for (int c = 0; cookies != null && c < cookies.length; c++) {
			if (cookies[c].getName().endsWith(prefix + CAM_PASSPORT_NAME)) {
				cam_passport = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CC_SESSION_NAME)) {
				cc_session = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CEA_SSA_NAME)) {
				cea_ssa = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CRN_NAME)) {
				crn = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + USERCAPABILITIES_NAME)) {
				userCapabilities = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + USERSESSIONID_NAME)) {
				usersessionid = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CC_LOGON)) {
				cc_logon = cookies[c].getValue();
				continue;
			}
		}		
		//
		CognosSchedulePanel csp = new CognosSchedulePanel();
		csp.setRptAccessID(rptAccessID);
		csp.setDomainKey(domainKey);
		csp.setSearchPath(searchPath);
		csp.setCwaID(this.getIntranetID());
		csp.setUid(this.getUserUid());
		csp.setXmlData("");
		//set Cognos logon header information for back-end logon
		if(!cam_passport.equals("empty")){
			csp.setCam_passport(cam_passport);
			csp.setCc_session(cc_session);
			csp.setCea_ssa(cea_ssa);
			csp.setCrn(crn);
			csp.setUserCapabilities(userCapabilities);
			csp.setUsersessionid(usersessionid);
			csp.setCc_logon(cc_logon);
		}
		//
		csp = this.getRestTemplate().postForObject(this.getRestfulServerUrl() + createCognosScheduleURL, csp, CognosSchedulePanel.class);
		//set cookie for web interface
		if(csp.isNewPassport()){
			Cookie cookie_passport = new Cookie(prefix + CAM_PASSPORT_NAME,csp.getCam_passport());
			response.addCookie(cookie_passport);
			Cookie cookie_session = new Cookie(prefix + CC_SESSION_NAME,csp.getCc_session());
			response.addCookie(cookie_session);
			Cookie cookie_cea = new Cookie(prefix + CEA_SSA_NAME,csp.getCea_ssa());
			response.addCookie(cookie_cea);
			Cookie cookie_crn = new Cookie(prefix + CRN_NAME,csp.getCrn());
			response.addCookie(cookie_crn);
			Cookie cookie_usersessiondid = new Cookie(prefix + USERSESSIONID_NAME,csp.getUsersessionid());
			response.addCookie(cookie_usersessiondid);
			Cookie cookie_userCapabilities = new Cookie(prefix + USERCAPABILITIES_NAME,csp.getUserCapabilities());
			response.addCookie(cookie_userCapabilities);			
			Cookie cookie_cclogon = new Cookie(prefix + CC_LOGON,csp.getCc_logon());
			response.addCookie(cookie_cclogon);
			
		}
		return csp;
	}

	@RequestMapping(value = "/portal/schedulePanel/copyCognosSchedulePage/{requestID}", method = RequestMethod.GET)
	public ModelAndView copyCognosSchedulePage(@PathVariable String requestID) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/cognosSchedulePanel.jsp");
		mav.addObject("requestID", requestID);
		mav.addObject("cspAction", "copy");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		return mav;
	}

	@RequestMapping(value = "/portal/schedulePanel/copyCognosSchedule/{requestID}", method = RequestMethod.GET)
	@ResponseBody
	public Object copyCognosSchedule(@PathVariable String requestID) {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + copyCognosScheduleURL,
				Object.class,
				this.getIntranetID(),
				this.getUserUid(),
				requestID);
	}

	@RequestMapping(value = "/portal/schedulePanel/addToMyFavorites", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> addToMyFavorites(
			@RequestParam(value = "contentID", required = true) String contentID,
			@RequestParam(value = "domainKey", required = true) String domainKey) {
		log.info("add to my favorites - " + contentID + "," + domainKey);
		
		String prefix = domainKey + "_";
		String cam_passport = "empty";
		String cc_session = "empty";
		String cea_ssa = "empty";
		String crn = "empty";
		String userCapabilities = "empty";
		String usersessionid = "empty";
		String cc_logon = "empty";
		//
		Cookie[] cookies = request.getCookies();
		for (int c = 0; cookies != null && c < cookies.length; c++) {
			if (cookies[c].getName().endsWith(prefix + CAM_PASSPORT_NAME)) {
				cam_passport = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CC_SESSION_NAME)) {
				cc_session = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CEA_SSA_NAME)) {
				cea_ssa = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CRN_NAME)) {
				crn = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + USERCAPABILITIES_NAME)) {
				userCapabilities = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + USERSESSIONID_NAME)) {
				usersessionid = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CC_LOGON)) {
				cc_logon = cookies[c].getValue();
				continue;
			}
		}		
		//
		CognosSchedulePanel csp = new CognosSchedulePanel();
		csp.setRptAccessID(contentID);
		csp.setDomainKey(domainKey);
		csp.setSearchPath("NULL");
		csp.setCwaID(this.getIntranetID());
		csp.setUid(this.getUserUid());
		csp.setXmlData("");
		//set Cognos logon header information for back-end logon
		if(!cam_passport.equals("empty")){
			csp.setCam_passport(cam_passport);
			csp.setCc_session(cc_session);
			csp.setCea_ssa(cea_ssa);
			csp.setCrn(crn);
			csp.setUserCapabilities(userCapabilities);
			csp.setUsersessionid(usersessionid);
			csp.setCc_logon(cc_logon);
		}
		//		
		csp = this.getRestTemplate().postForObject(
				this.getRestfulServerUrl() + addToMyFavoritesURL,csp,CognosSchedulePanel.class);
		//set cookie for web interface
		if(csp.isNewPassport()){
			Cookie cookie_passport = new Cookie(prefix + CAM_PASSPORT_NAME,csp.getCam_passport());
			response.addCookie(cookie_passport);
			Cookie cookie_session = new Cookie(prefix + CC_SESSION_NAME,csp.getCc_session());
			response.addCookie(cookie_session);
			Cookie cookie_cea = new Cookie(prefix + CEA_SSA_NAME,csp.getCea_ssa());
			response.addCookie(cookie_cea);
			Cookie cookie_crn = new Cookie(prefix + CRN_NAME,csp.getCrn());
			response.addCookie(cookie_crn);
			Cookie cookie_usersessiondid = new Cookie(prefix + USERSESSIONID_NAME,csp.getUsersessionid());
			response.addCookie(cookie_usersessiondid);
			Cookie cookie_userCapabilities = new Cookie(prefix + USERCAPABILITIES_NAME,csp.getUserCapabilities());
			response.addCookie(cookie_userCapabilities);			
			Cookie cookie_cclogon = new Cookie(prefix + CC_LOGON,csp.getCc_logon());
			response.addCookie(cookie_cclogon);	
		}
		Map<String, String> resultMap = new HashMap<String, String>();
		if (csp.getErrMsg().equals("")) {
			resultMap.put("status", "success");
		} else {
			resultMap.put("status", "fail");
		}
		return resultMap;
	}

	@Autowired
	private HttpServletResponse	response;
	@Autowired
	private HttpServletRequest	request;

	@RequestMapping(value = "/portal/schedulePanel/getSession", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String> getSession(@RequestParam String cwaid, @RequestParam String domain_key) {
		log.info("get session...");
		log.info("cwaid:" + cwaid + ", domain_key:" + domain_key);
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + getSessionURL,
				Map.class,
				cwaid,
				this.getUserUid(),
				domain_key);
	}

	@RequestMapping("/portal/callbackproxy")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/CognosCallbackProxy.jsp");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		return mav;
	}

	@RequestMapping(value = "/portal/schedulePanel/openPromptpage", method = RequestMethod.POST)
	@ResponseBody
	public CognosSchedulePanel openPromptpage(@RequestBody CognosSchedulePanel csp) {
		String domain_key = csp.getDomainKey();
		//
		log.info("get prompt page url...");
		log.info("cwaid:" + csp.getCwaID());
		log.info("domain key:" + csp.getDomainKey());
		log.info("content_id:" + csp.getRptAccessID());
		log.info("request_id:" + csp.getRequestID());
		log.info("search_path:" + csp.getSearchPath());
		log.info("new TBS:" + csp.isNewSchedule());
		//
		domain_key = domain_key.trim();
		String prefix = domain_key + "_";

		String cam_passport = "empty";
		String cc_session = "empty";
		String cea_ssa = "empty";
		String crn = "empty";
		String userCapabilities = "empty";
		String usersessionid = "empty";
		String cc_logon = "empty";
		//
		Cookie[] cookies = request.getCookies();
		for (int c = 0; cookies != null && c < cookies.length; c++) {
			if (cookies[c].getName().endsWith(prefix + CAM_PASSPORT_NAME)) {
				cam_passport = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CC_SESSION_NAME)) {
				cc_session = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CEA_SSA_NAME)) {
				cea_ssa = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CRN_NAME)) {
				crn = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + USERCAPABILITIES_NAME)) {
				userCapabilities = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + USERSESSIONID_NAME)) {
				usersessionid = cookies[c].getValue();
				continue;
			}
			if (cookies[c].getName().endsWith(prefix + CC_LOGON)) {
				cc_logon = cookies[c].getValue();
				continue;
			}
		}
		//set Cognos logon header information for back-end logon
		if(!cam_passport.equals("empty")){
			csp.setCam_passport(cam_passport);
			csp.setCc_session(cc_session);
			csp.setCea_ssa(cea_ssa);
			csp.setCrn(crn);
			csp.setUserCapabilities(userCapabilities);
			csp.setUsersessionid(usersessionid);
			csp.setCc_logon(cc_logon);
		}
		//
		csp.setXmlData("");
		csp = this.getRestTemplate().postForObject(this.getRestfulServerUrl() + openPromptpageURL, csp, CognosSchedulePanel.class);
		//set cookie for web interface
		if(csp.isNewPassport()){
			Cookie cookie_passport = new Cookie(prefix + CAM_PASSPORT_NAME,csp.getCam_passport());
			response.addCookie(cookie_passport);
			Cookie cookie_session = new Cookie(prefix + CC_SESSION_NAME,csp.getCc_session());
			response.addCookie(cookie_session);
			Cookie cookie_cea = new Cookie(prefix + CEA_SSA_NAME,csp.getCea_ssa());
			response.addCookie(cookie_cea);
			Cookie cookie_crn = new Cookie(prefix + CRN_NAME,csp.getCrn());
			response.addCookie(cookie_crn);
			Cookie cookie_usersessiondid = new Cookie(prefix + USERSESSIONID_NAME,csp.getUsersessionid());
			response.addCookie(cookie_usersessiondid);
			Cookie cookie_userCapabilities = new Cookie(prefix + USERCAPABILITIES_NAME,csp.getUserCapabilities());
			response.addCookie(cookie_userCapabilities);			
			Cookie cookie_cclogon = new Cookie(prefix + CC_LOGON,csp.getCc_logon());
			response.addCookie(cookie_cclogon);
		}
		//
		return csp;
	}

	@RequestMapping(value = "/portal/schedulePanel/loadExistingSchedulePage/{rptAccessID}/{domainKey}/{requestID}", method = RequestMethod.GET)
	public ModelAndView loadExistingSchedulePage(
			@PathVariable String rptAccessID,
			@PathVariable String domainKey,
			@PathVariable String requestID) {

		ModelAndView mav = new ModelAndView("/WEB-INF/portal/existingCognosSchedule.jsp");
		mav.addObject("rptAccessID", rptAccessID);
		mav.addObject("domainKey", domainKey);
		mav.addObject("requestID", requestID);
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());			
		return mav;
	}

	@RequestMapping(value = "/portal/schedulePanel/loadExistingSchedule/{rptAccessID}/{domainKey}", method = RequestMethod.GET)
	@ResponseBody
	public List loadExistingSchedule(@PathVariable String rptAccessID, @PathVariable String domainKey) {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + loadExistingScheduleURL,
				List.class,
				this.getIntranetID(),
				this.getUserUid(),
				rptAccessID,
				domainKey);
	}

	@RequestMapping(value = "/portal/schedulePanel/updateActiveInactive", method = RequestMethod.POST)
	@ResponseBody
	public Map updateActiveInactive(@RequestParam(value = "requestID", required = true) String requestID) {
		log.info("updateActiveInactive: " + requestID);
		return this.getRestTemplate().postForObject(
				this.getRestfulServerUrl() + updateActiveInactiveURL,
				null,
				Map.class,
				this.getIntranetID(),
				this.getUserUid(),
				requestID);
	}

	@RequestMapping(value = "/portal/schedulePanel/deleteCognosSchedule", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteCognosSchedule(@RequestParam(value = "requestID", required = true) String requestID) {
		log.info("deleteCognosSchedule: " + requestID);
		return this.getRestTemplate().postForObject(
				this.getRestfulServerUrl() + deleteCognosScheduleURL,
				null,
				Map.class,
				this.getIntranetID(),
				this.getUserUid(),
				requestID);
	}

	@RequestMapping(value = "/portal/schedulePanel/extendDateCognosSchedule", method = RequestMethod.POST)
	@ResponseBody
	public Map extendDateCognosSchedule(@RequestParam(value = "requestID", required = true) String requestID) {
		log.info("extendDateCognosSchedule: " + requestID);
		return this.getRestTemplate().postForObject(
				this.getRestfulServerUrl() + extendDateCognosScheduleURL,
				null,
				Map.class,
				this.getIntranetID(),
				this.getUserUid(),
				requestID);
	}
}
