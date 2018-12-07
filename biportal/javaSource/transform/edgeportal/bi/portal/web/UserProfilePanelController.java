package transform.edgeportal.bi.portal.web;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import transform.edgeportal.bi.jpa.controlbook.Ctrlfilt;
import transform.edgeportal.bi.jpa.controlbook.Ctrlfltp;
import transform.edgeportal.bi.jpa.security.UserProfile;

/**
 * 
 * ClassName: UserProfilePanelController <br/>
 * Description: The controller of user profile panel UI <br/>
 * Date: May 24, 2018 <br/>
 * 
 * @author mengmin
 */

@Controller
public class UserProfilePanelController extends BaseController {

	private static final Logger	log	= Logger.getLogger(UserProfilePanelController.class);

	@Value("${listUserProfiles}")
	private String				listUserProfilesURL;
	
	@Value("${getUserProfile}")
	private String				getUserProfileURL;
	
	@Value("${getUPBusinessList}")
	private String				getUPBusinessListURL;
	
	@Value("${getUPGeoList}")
	private String				getUPGeoListURL;
	
	@Value("${updateUserProfile}")
	private String				updateUserProfileURL;
	
	@Value("${insertUserProfile}")
	private String				insertUserProfileURL;
	
	@Value("${deleteUserProfile}")
	private String				deleteUserProfileURL;
	
	@Value("${activeUserProfile}")
	private String				activeUserProfileURL;
	

	@RequestMapping(value = "/portal/security/userprofilelist", method = RequestMethod.GET)
	public ModelAndView showUserProfiles() {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/userProfile_manage.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		return modelAndView;
	}
	
	@RequestMapping(value = "/portal/security/addUserProfile", method = RequestMethod.GET)
	public ModelAndView addMailTemplate() {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/userProfile_edit.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		modelAndView.addObject("action", "Create");
		return modelAndView;
		
	}
	
	@RequestMapping(value = "/portal/security/edit/getUserProfile", method = RequestMethod.GET)
	public ModelAndView editMailTemplate(@RequestParam String cwa_id, @RequestParam String pid) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/userProfile_edit.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		modelAndView.addObject("pid", pid);
		modelAndView.addObject("action", "Edit");
		
		UserProfile userProfile = null;
		try {
			userProfile = this.getRestTemplate().getForObject(getRestfulServerUrl() + getUserProfileURL, UserProfile.class, cwa_id, pid);
		} catch (Exception e) {
			log.error(e);
			modelAndView.addObject("error", "System error:" + e.getMessage());
			return modelAndView;
		}
		modelAndView.addObject("profileName", userProfile.getProfileName());
		modelAndView.addObject("description", userProfile.getDescription());

		return modelAndView;

	}

	@RequestMapping(value = "/portal/security/userprofile/listUserProfiles", method = RequestMethod.GET)
	@ResponseBody
	public UserProfile[] listUserProfiles(@RequestParam String cwa_id) {
		return this.getRestTemplate()
				.getForObject(getRestfulServerUrl() + listUserProfilesURL, UserProfile[].class, cwa_id);
	}
	
	@RequestMapping(value = "/portal/security/userprofile/getUPBusinessList", method = RequestMethod.GET)
	@ResponseBody
	public Ctrlfilt[] getUPBusinessList(@RequestParam String cwa_id, @RequestParam String pid) {
		return this.getRestTemplate()
				.getForObject(getRestfulServerUrl() + getUPBusinessListURL, Ctrlfilt[].class, cwa_id, pid);
	}
	
	@RequestMapping(value = "/portal/security/userprofile/getUPGeoList", method = RequestMethod.GET)
	@ResponseBody
	public Ctrlfltp[] getUPGeoList(@RequestParam String cwa_id, @RequestParam String pid) {
		return this.getRestTemplate()
				.getForObject(getRestfulServerUrl() + getUPGeoListURL, Ctrlfltp[].class, cwa_id, pid);
	}

	@RequestMapping(value = "/portal/security/userprofile/updateUserProfile", method = RequestMethod.POST)
	@ResponseBody
	public String updateUserProfile(@RequestBody Object up) {
		log.info("update user profile - " + up);
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + updateUserProfileURL, up, String.class);
	}
	
	@RequestMapping(value = "/portal/security/userprofile/insertUserProfile", method = RequestMethod.POST)
	@ResponseBody
	public String insertUserProfile(@RequestBody Object up) {
		log.info("insert user profile - " + up);
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + insertUserProfileURL, up, String.class);
	}
	
	@RequestMapping(value = "/portal/security/userprofile/deleteUserProfile", method = RequestMethod.POST)
	@ResponseBody
	public String deleteUserProfile(@RequestBody String[] pids) {
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + deleteUserProfileURL, pids, String.class);
	}
	
	@RequestMapping(value = "/portal/security/userprofile/activeUserProfile", method = RequestMethod.POST)
	@ResponseBody
	public String activeUserProfile(@RequestBody String[] pids) {
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + activeUserProfileURL, pids, String.class);
	}

}
