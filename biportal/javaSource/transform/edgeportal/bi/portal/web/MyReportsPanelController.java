package transform.edgeportal.bi.portal.web;

import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MyReportsPanelController extends BaseController {

	@Value("${getMyFavReports}")
	private String				getMyFavReports;

	@Value("${removeMyFavReport}")
	private String				removeMyFavReport;

	@Value("${getRecentReports}")
	private String				getRecentReports;

	@Value("${addRecentReport}")
	private String				addRecentReport;

	@Value("${addMyFavReport}")
	private String				addMyFavReportUrl;

	@Value("${subscribeReport}")
	private String				subscribeReportUrl;

	@Value("${getCognosActionMenu}")
	private String				getCognosActionMenuUrl;

	@Value("${saveReportUsageUrl}")
	private String				saveReportUsageUrl;

	private static final Logger	log	= Logger.getLogger(MyReportsPanelController.class);

	public String getMyFavReports_rest() {
		return getRestfulServerUrl() + getMyFavReports;
	}

	public String removeMyFavReport_rest() {
		return getRestfulServerUrl() + removeMyFavReport;
	}

	public String getRecentReports_rest() {
		return getRestfulServerUrl() + getRecentReports;
	}

	public String addRecentReport_rest() {
		return getRestfulServerUrl() + addRecentReport;
	}

	@RequestMapping(value = "/portal/myrpts/getMyfavRpts/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getMyFavReports(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getMyFavReports_rest(), List.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/myrpts/removeMyreport", method = RequestMethod.POST)
	@ResponseBody
	public void removeMyFavReport(@RequestBody BIReportBean report) {

		this.getRestTemplate().postForEntity(this.removeMyFavReport_rest(), report, BIReportBean.class);
	}

	@RequestMapping(value = "/portal/myrpts/getRecentRpts/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getRecentReports(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getRecentReports_rest(), List.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/myrpts/getAllRecentRpts/{cwa_id}/{uid}", method = RequestMethod.GET)
	public ModelAndView getAllRecentReports(@PathVariable String cwa_id, @PathVariable String uid) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/myReports_allRecent.jsp");
		modelAndView.addObject("cwa_id", cwa_id);
		modelAndView.addObject("uid", uid);
		return modelAndView;
	}

	@RequestMapping(value = "/portal/myrpts/addRecentRpt", method = RequestMethod.POST)
	@ResponseBody
	public void addRecentReport(@RequestBody BIReportBean recentReport) {
		this.getRestTemplate().postForEntity(this.addRecentReport_rest(), recentReport, BIReportBean.class);
	}

	@RequestMapping(value = "/portal/myrpts/addMyfavRpt", method = RequestMethod.POST)
	@ResponseBody
	public void addMyfavRpts(@RequestBody BIReportBean myFavReport) {
		this.getRestTemplate().postForEntity(
				this.getRestfulServerUrl() + addMyFavReportUrl,
				myFavReport,
				BIReportBean.class);
	}

	@RequestMapping(value = "/portal/myrpts/subscribeRpt", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.NO_CONTENT)
	@ResponseBody
	public void subscribeReport(@RequestBody BIReportBean subReport) {
		this.getRestTemplate().postForEntity(
				this.getRestfulServerUrl() + subscribeReportUrl,
				subReport,
				BIReportBean.class);
	}

	@RequestMapping(value = "/portal/myrpts/getCognosActionMenu", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public Object getCognosActionMenu(@RequestBody BIReportBean report) {
		String cwa_id = report.getCwaid();
		String uid = report.getUid();
		String content_id = report.getRptObjID();
		String parent_id = report.getParent_folder_id();
		if (parent_id == null || parent_id.equals("")) {
			parent_id = "NONE";
		}
		String domain_key = report.getDomain_Key();
		String report_type = report.getReportType();
		String sub_rpt_type = report.getObjectClass();
		String refer_objectid = report.getRefer_Objectid();
		String refer_objectclass = report.getRefer_ObjectClass();
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + getCognosActionMenuUrl,
				Object.class,
				cwa_id,
				uid,
				content_id,
				parent_id,
				domain_key,
				report_type,
				sub_rpt_type,
				refer_objectid,
				refer_objectclass);
	}

	@RequestMapping(value = "/portal/usage/saveReportUsage/{action_cd}", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.NO_CONTENT)
	@ResponseBody
	public void saveReportUsage(@RequestBody BIReportBean report, @PathVariable String action_cd) {
		this.getRestTemplate().postForEntity(
				this.getRestfulServerUrl() + saveReportUsageUrl,
				report,
				Object.class,
				action_cd);
	}
}
