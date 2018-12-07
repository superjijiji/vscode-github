package transform.edgeportal.bi.portal.web;

import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AllReportsPanelController extends BaseController {

	private static final Logger log = Logger.getLogger(AllReportsPanelController.class);
	
	@Value("${getBlobNavigBar}")
	private String getBlobNavigBar;

	@Value("${getBlobReports}")
	private String getBlobReports;

	@Value("${getLinksReports}")
	private String getLinksReports;

	@Value("${getBlobFoldersList}")
	private String getBlobFolders;

	@Value("${getCognosPublicList}")
	private String getCognosPublic;

	@Value("${getCognosMyReports}")
	private String getCognosMy;

	public String getBlobReports_rest() {
		return getRestfulServerUrl() + getBlobReports;
	}

	public String getLinksReports_rest() {
		return getRestfulServerUrl() + getLinksReports;
	}

	public String getBlobNavigBar_rest() {
		return getRestfulServerUrl() + getBlobNavigBar;
	}

	public String getBlobFolders_rest() {
		return getRestfulServerUrl() + getBlobFolders;
	}

	public String getCognosPublic_rest() {
		return getRestfulServerUrl() + getCognosPublic;
	}

	public String getCognosMy_rest() {
		return getRestfulServerUrl() + getCognosMy;
	}

	@RequestMapping(value = "/portal/allreports/getBlobNavigBar/{cwa_id}/{uid}/{folder_id}", method = RequestMethod.GET)
	@ResponseBody
	public List getBlobNavigBar(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String folder_id) {
		return this.getRestTemplate().getForObject(this.getBlobNavigBar_rest(), List.class, cwa_id, uid, folder_id);
	}

	@RequestMapping(value = "/portal/allreports/getAllReportsBlob/{folder_id}", method = RequestMethod.GET)
	public ModelAndView getAllReportsBlob(@PathVariable String folder_id) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/allreports_blob.jsp");
		modelAndView.addObject("folder_id", folder_id);
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		return modelAndView;
	}

	@RequestMapping(value = "/portal/allreports/getBlobReports/{cwa_id}/{uid}/{folder_id}", method = RequestMethod.GET)
	@ResponseBody
	public Object getBlobReports(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String folder_id) {
		return this.getRestTemplate().getForObject(this.getBlobReports_rest(), Object.class, cwa_id, uid, folder_id);
	}
	
	@RequestMapping(value = "/portal/allreports/getLinksReports/{cwa_id}/{uid}/{folder_id}", method = RequestMethod.GET)
	@ResponseBody
	public List getLinksReports(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String folder_id) {
		return this.getRestTemplate().getForObject(this.getLinksReports_rest(), List.class, cwa_id, uid, folder_id);
	}

	@RequestMapping(value = "/portal/allreports/getBlobFolders/{cwa_id}/{uid}/{folder_id}", method = RequestMethod.GET)
	@ResponseBody
	public List getBlobFoldersList(@PathVariable String cwa_id, @PathVariable String uid,
			@PathVariable String folder_id) {
		return this.getRestTemplate().getForObject(this.getBlobFolders_rest(), List.class, cwa_id, uid, folder_id);
	}

	// ==Simon begin 2017 -1-25==
	// for cognos all report panel
	@RequestMapping(value = "/portal/allreports/getAllReportsCognos/{domain_key}", method = RequestMethod.GET)
	// @RequestMapping(value =
	// "/portal/allreports/getCognosMyReports/{domain_key}", method =
	// RequestMethod.GET)
	public ModelAndView getAllReportsCognos(@PathVariable String domain_key) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/allreports_cognos.jsp");
		// modelAndView.addObject("folder_id", folder_id);
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		modelAndView.addObject("domain_key", domain_key);
		return modelAndView;

	}

	// for call cognos all report rest api
	@RequestMapping(value = "/portal/allreports/getCognosPublicRestAPI/{cwa_id}/{uid}/{domain_key}/{folder_id}", method = RequestMethod.GET)
	@ResponseBody
	public List getCognosPublicRestAPI(@PathVariable String cwa_id, @PathVariable String uid,
			@PathVariable String domain_key, @PathVariable String folder_id) {
		log.info("this.getCognosPublic_rest()" + this.getCognosPublic_rest());
		return this.getRestTemplate().getForObject(this.getCognosPublic_rest(), List.class, cwa_id, uid, domain_key,
				folder_id);
	}

	// ==Simon end

	// for cognos my report rest api
	@RequestMapping(value = "/portal/allreports/getCognosMyRestAPI/{cwa_id}/{folder_id}/{uid}/{domain_key}", method = RequestMethod.GET)
	@ResponseBody
	public List getCognosMyRestAPI(@PathVariable String cwa_id, @PathVariable String folder_id,
			@PathVariable String uid, @PathVariable String domain_key) {
		log.info("this.getCognosMy_rest()" + this.getCognosMy_rest());
		return this.getRestTemplate().getForObject(this.getCognosMy_rest(), List.class, cwa_id, folder_id, uid,
				domain_key);
	}

}
