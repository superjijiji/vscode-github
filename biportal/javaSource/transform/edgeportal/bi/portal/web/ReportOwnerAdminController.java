
/**
 * Project Name: cognitive-ReportOwnerAdminController
 * File Name: transform.edgeportal.bi.portal.web.ReportOwnerAdminControlle.java
 * Date: May 1, 2018
 * 
 * @author Simon
 *         Copyright(c) 2018, IBM BI@IBM All Rights Reserved.
 */
package transform.edgeportal.bi.portal.web;

import java.util.List;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import net.sf.json.JSONArray;

import transform.edgeportal.bi.jpa.report.ReportProfilePanel;
import transform.edgeportal.bi.jpa.report.Reportprofile;

/**
 * ClassName: ReportOwnerAdminController <br/>
 * Description: TODO <br/>
 * Date: Nov 21, 2017 <br/>
 * 
 * @author Simon
 */
@Controller
public class ReportOwnerAdminController extends BaseController {

	private static final Logger log = Logger.getLogger(ReportOwnerAdminController.class);
	//assignaReportProfile
	@Value("${assignaReportProfile}")
	private String assignaReportProfile;
	@Value("${getSearchRptResults}")
	private String getSearchRptResults;
	@Value("${getCognetiveDomains}")
	private String getDomainsUrl;
	@Value("${updateCognetiveSetting}")
	private String updateCognetiveSetting;
	@Value("${listReportProfiles}")
	private String listReportProfilesURL;
	// saveReportProfiles
	@Value("${saveReportProfiles}")
	private String saveReportProfilesURL;
	// removeReportProfiles
	@Value("${removeReportProfiles}")
	private String removeReportProfilesURL;
	// activeReportProfiles
	@Value("${activeReportProfiles}")
	private String activeReportProfilesURL;
//getAssignedReportProfile
	@Value("${getAssignedReportProfile}")
	private String getAssignedReportProfileURL;
	public String getAssignedRptProfiles_rest() {
		return getRestfulServerUrl() + getAssignedReportProfileURL;
	}
	public String assignRptProfiles_rest() {
		return getRestfulServerUrl() + assignaReportProfile;
	}
	public String getSearchRptResults_rest() {
		return getRestfulServerUrl() + getSearchRptResults;
	}

	public String getRemoveReportProfiles_rest() {
		return getRestfulServerUrl() + removeReportProfilesURL;
	}

	public String getActiveReportProfiles_rest() {
		return getRestfulServerUrl() + activeReportProfilesURL;
	}

	public String updateSetting_rest() {
		return getRestfulServerUrl() + updateCognetiveSetting;
	}

	public String getDomains_rest() {
		return getRestfulServerUrl() + getDomainsUrl;
	}

	public String getSaveReportProile() {
		return getRestfulServerUrl() + saveReportProfilesURL;
	}

	@RequestMapping(value = "/portal/cognitive/updateSetting", method = RequestMethod.POST)
	@ResponseBody
	public Object updateSetting(@RequestBody Object ad) {
		log.info("update  - " + ad);
		return this.getRestTemplate().postForObject(this.updateSetting_rest(), ad, Object.class);
	}

	@RequestMapping(value = "/admin/cognitive/search", method = RequestMethod.GET)
	public ModelAndView searchPage(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "searchType", required = false, defaultValue = "basic") String searchType,
			@CookieValue(value = "domains", required = false, defaultValue = "ALL") String domains,
			@CookieValue(value = "fields", required = false, defaultValue = "reportDescription") String fields,
			@RequestParam(value = "keywords", required = false) String keywords,
			@RequestParam(value = "page", required = false, defaultValue = "1") String page,
			@CookieValue(value = "page_row", required = false, defaultValue = "50") String page_row) {
		if (searchType == null || "".equals(searchType.trim())) {
			searchType = "basic";
		}

		if (domains == null || "".equals(domains.trim()) || "ALL".equals(domains)) {
			domains = "ALL";
			Cookie domains_cookie = new Cookie("domains", "ALL");
			domains_cookie.setMaxAge(365 * 24 * 60 * 60);
			response.addCookie(domains_cookie);
		}

		if (fields == null || "".equals(fields.trim()) || "reportDescription".equals(fields)) {
			fields = "reportDescription";
			Cookie fields_cookie = new Cookie("fields", "reportDescription");
			fields_cookie.setMaxAge(365 * 24 * 60 * 60);
			response.addCookie(fields_cookie);

		}

		if (keywords == null || "".equals(keywords.trim())) {
			keywords = "";
		}

		try {
			if (page == null || Integer.valueOf(page) <= 0) {
				page = "1";
			}
		} catch (Exception e) {
			page = "1";
		}

		try {
			if (page_row == null || Integer.valueOf(page_row) <= 0 || Integer.valueOf(page_row) > 300
					|| "50".equals(page_row)) {
				page_row = "50";
				Cookie page_row_cookie = new Cookie("page_row", page_row);
				page_row_cookie.setMaxAge(365 * 24 * 60 * 60);
				response.addCookie(page_row_cookie);
			}
		} catch (Exception e) {
			page_row = "50";
			Cookie page_row_cookie = new Cookie("page_row", page_row);
			page_row_cookie.setMaxAge(365 * 24 * 60 * 60);
			response.addCookie(page_row_cookie);
		}
		//
		String cwa_id = this.getIntranetID();
		//
		ModelAndView modelAndView = null;
		String status = "success";
		if ("".equals(keywords)) {
			modelAndView = new ModelAndView("/WEB-INF/portal/cognitiveSearch.jsp");
			modelAndView.addObject("results", new JSONArray());
		} else {
			modelAndView = new ModelAndView("/WEB-INF/portal/searchRptResults.jsp");
			try {
				@SuppressWarnings("rawtypes")
				Map results = this.getRestTemplate().getForObject(this.getSearchRptResults_rest(), Map.class, cwa_id,
						keywords, domains, fields, page, page_row);
				modelAndView.addObject("results", JSONArray.fromObject(results));
			} catch (Exception e) {
				modelAndView.addObject("results", new JSONArray());
				status = "failed";
				e.printStackTrace();
				log.error(e.getMessage());
			}

		}
		//
		@SuppressWarnings("rawtypes")
		List domainList = this.getDomainList(cwa_id);
		if (domainList == null) {
			modelAndView.addObject("domainList", new JSONArray());
			status = "failed";
		} else {
			modelAndView.addObject("domainList", JSONArray.fromObject(domainList));
		}
		//
		modelAndView.addObject("status", status);
		modelAndView.addObject("cwa_id", cwa_id);
		modelAndView.addObject("searchType", searchType);
		modelAndView.addObject("domains", domains);
		modelAndView.addObject("fields", fields);
		modelAndView.addObject("keywords", keywords);
		modelAndView.addObject("page", page);
		modelAndView.addObject("page_row", page_row);
		return modelAndView;
	}

	@RequestMapping(value = "/cognitive/preferences", method = RequestMethod.GET)
	public ModelAndView preferencePage(HttpServletRequest request, HttpServletResponse response,
			@CookieValue(value = "domains", required = false, defaultValue = "ALL") String domains,
			@CookieValue(value = "fields", required = false, defaultValue = "reportDescription") String fields,
			@CookieValue(value = "page_row", required = false, defaultValue = "50") String page_row,
			@RequestParam(value = "keywords", required = false, defaultValue = "") String keywords) {

		log.info("domains:" + domains);
		log.info("fields:" + fields);
		log.info("page_row:" + page_row);

		if (domains == null || "".equals(domains.trim()) || "ALL".equals(domains)) {
			domains = "ALL";
			Cookie domains_cookie = new Cookie("domains", "ALL");
			domains_cookie.setMaxAge(365 * 24 * 60 * 60);
			response.addCookie(domains_cookie);
		}

		if (fields == null || "".equals(fields.trim()) || "reportDescription".equals(fields)) {
			fields = "reportDescription";
			Cookie fields_cookie = new Cookie("fields", "reportDescription");
			fields_cookie.setMaxAge(365 * 24 * 60 * 60);
			response.addCookie(fields_cookie);
		}

		try {
			if (page_row == null || Integer.valueOf(page_row) <= 0 || Integer.valueOf(page_row) > 300
					|| "50".equals(page_row)) {
				page_row = "50";
				Cookie page_row_cookie = new Cookie("page_row", page_row);
				page_row_cookie.setMaxAge(365 * 24 * 60 * 60);
				response.addCookie(page_row_cookie);
			}
		} catch (Exception e) {
			page_row = "50";
			Cookie page_row_cookie = new Cookie("page_row", page_row);
			page_row_cookie.setMaxAge(365 * 24 * 60 * 60);
			response.addCookie(page_row_cookie);
		}
		//
		String cwa_id = this.getIntranetID();
		//
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/searchPreferences.jsp");
		@SuppressWarnings("rawtypes")
		List domainList = this.getDomainList(cwa_id);
		if (domainList == null) {
			modelAndView.addObject("domainList", new JSONArray());
		} else {
			modelAndView.addObject("domainList", JSONArray.fromObject(domainList));
		}
		modelAndView.addObject("cwa_id", cwa_id);
		modelAndView.addObject("domains", domains);
		modelAndView.addObject("fields", fields);
		modelAndView.addObject("page_row", page_row);
		modelAndView.addObject("keywords", keywords);
		return modelAndView;
	}

	@SuppressWarnings({ "rawtypes" })
	private List getDomainList(String cwa_id) {
		try {
			List results = this.getRestTemplate().getForObject(this.getDomains_rest(), List.class, cwa_id);
			if (results.size() > 0) {
				return results;
			} else {
				log.error("Error to get domains from Watson discovery setting.");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
		}
		return null;
	}

	// for report setting user profiles
	@RequestMapping(value = "/portal/admin/profile/reportprofilelist", method = RequestMethod.GET)
	public ModelAndView showUserProfiles() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/admin_reportProfile_manage.jsp");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		return mav;
	}

	@RequestMapping(value = "/portal/reportprofile/listProfiles", method = RequestMethod.GET)
	@ResponseBody
	public ReportProfilePanel listUserProfiles(@RequestParam String cwa_id) {
		System.out.println("sssssssss");

		return this.getRestTemplate().getForObject(getRestfulServerUrl() + listReportProfilesURL,
				ReportProfilePanel.class);
	}

	@RequestMapping(value = "/portal/addReportProfile", method = RequestMethod.GET)
	public ModelAndView addReportProfile() {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/admin_reportProfile_edit.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		return modelAndView;

	}

	@RequestMapping(value = "/portal/edit/getReportProfile", method = RequestMethod.GET)
	public ModelAndView getReportProfile(@RequestParam String cwa_id, @RequestParam String pid) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/admin_reportProfile_edit.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("pid", pid);

		// reportprofile/saveReportProfile

		return modelAndView;

	}

	@RequestMapping(value = "/portal/reportprofile/saveReportProfile", method = RequestMethod.POST)
	@ResponseBody
	public Object saveReportProifle(@RequestBody Reportprofile rp) {
		log.info("update  - " + rp);
		return this.getRestTemplate().postForObject(getSaveReportProile(), rp, Object.class);
		// reportprofile/deleteReportProfile

	}

	@RequestMapping(value = "/portal/reportprofile/deleteReportProfile", method = RequestMethod.POST)
	@ResponseBody
	public Object delReportProifles(@RequestBody List<Integer> removeReportProfileList) {
		log.info(removeReportProfileList);
		return this.getRestTemplate().postForObject(getRemoveReportProfiles_rest(), removeReportProfileList,
				String.class);
		// reportprofile/deleteReportProfile

	}

	// reportprofile/activeProfiles
	@RequestMapping(value = "/portal/reportprofile/activeProfiles", method = RequestMethod.POST)
	@ResponseBody
	public Object activeReportProifles(@RequestBody List<Integer> acReportProfileList) {
		log.info(acReportProfileList);
		return this.getRestTemplate().postForObject(getActiveReportProfiles_rest(), acReportProfileList, String.class);
		// reportprofile/deleteReportProfile
	}
	
	@RequestMapping(value = "/portal/cognitive/assignReportProfile", method = RequestMethod.GET)
	public ModelAndView assignReportProfile(@RequestParam String cwa_id, @RequestParam String rpid) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/admin_reportProfile_assignment.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("rpid", rpid);

		// reportprofile/saveReportProfile

		return modelAndView;

	}
	
	@RequestMapping(value = "/portal/cognitive/getReprtProfile", method = RequestMethod.GET)
	@ResponseBody
	public List listUserProfiles(@RequestParam String cwa_id,@RequestParam String reportPk) {
		
System.out.println(getAssignedRptProfiles_rest());
		return this.getRestTemplate().getForObject(getAssignedRptProfiles_rest(),
				List.class,reportPk);
	}
	@RequestMapping(value = "/portal/cognitive/assignReprtProfile/{reportPK}", method = RequestMethod.POST)
	@ResponseBody
	public String assignProfiles(@PathVariable String reportPK, @RequestBody List<Integer> assignedList) {
		
System.out.println(getAssignedRptProfiles_rest());
		return this.getRestTemplate().postForObject(assignRptProfiles_rest(),assignedList,
				String.class,reportPK);
	}
	//assignRptProfiles_rest
}