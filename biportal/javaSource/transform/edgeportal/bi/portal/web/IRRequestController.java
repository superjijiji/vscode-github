package transform.edgeportal.bi.portal.web;

import java.io.UnsupportedEncodingException;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IRRequestController extends BaseController {

	@Value("${openIRReportUrl}")
	private String				openIRReportUrl;
	
	@Value("${mailIRReportUrl}")
	private String				mailIRReportUrl;
	
	@Value("${getIRHelpInfo}")
	private String				getIRHelpReportURL;
	
	@Value("${getIRReportURL}")
	private String				getIRReportURL;
	
	@Value("${emailIRReportURL}")
	private String				emailIRReportURL;
	
	
	private static final Logger	log	= Logger.getLogger(IRRequestController.class);

	@RequestMapping(value = "/portal/report/openIRReport", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView openIRReport(@RequestBody Map<String, String> irReport) {
		String cwa_id = irReport.get("cwaid");
		String uid = irReport.get("uid");
		String domain_key = irReport.get("domain_Key");
		String report_def_id = irReport.get("rptObjID");
		String report_name = irReport.get("rptName");
		String rpt_type = irReport.get("reportType");
		String helpDoc = irReport.get("helpDoc");
		String rpt_desc = irReport.get("rpt_desc");
		log.info(cwa_id);
		log.info(uid);
		log.info(domain_key);
		log.info(report_def_id);
		log.info(report_name);
		log.info(rpt_type);
		log.info(helpDoc);
		log.info(rpt_desc);
		//
		StringBuffer sbf = new StringBuffer();
		sbf.setLength(0);
		sbf.append(this.getRestfulServerUrl() + openIRReportUrl);
		sbf.append("?cwa_id=" + cwa_id);
		sbf.append("&domain_key=" + domain_key);
		sbf.append("&report_def_id=" + report_def_id);
		sbf.append("&rpt_name=" + report_name);
		sbf.append("&rpt_type=" + rpt_type);
		sbf.append("&helpDoc=" + helpDoc);
		sbf.append("&rpt_desc=" + rpt_desc);
		return new ModelAndView("redirect:" + sbf.toString());
		
	}

	@RequestMapping(value = "/portal/report/mailIRReport", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView mailIRReport(@RequestBody Map<String, String> irReport) {
		String cwa_id = irReport.get("cwaid");
		String uid = irReport.get("uid");
		String domain_key = irReport.get("domain_Key");
		String report_def_id = irReport.get("rptObjID");
		String report_name = irReport.get("rptName");
		String rpt_type = irReport.get("reportType");
		String helpDoc = irReport.get("helpDoc");
		String rpt_desc = irReport.get("rpt_desc");
		log.info(cwa_id);
		log.info(uid);
		log.info(domain_key);
		log.info(report_def_id);
		log.info(report_name);
		log.info(rpt_type);
		log.info(helpDoc);
		log.info(rpt_desc);
		//
		StringBuffer sbf = new StringBuffer();
		sbf.setLength(0);
		sbf.append(mailIRReportUrl);
		sbf.append("?cwa_id=" + cwa_id);
		sbf.append("&domain_key=" + domain_key);
		sbf.append("&report_def_id=" + report_def_id);
		sbf.append("&rpt_name=" + report_name);
		sbf.append("&rpt_type=" + rpt_type);
		sbf.append("&helpDoc=" + helpDoc);
		sbf.append("&rpt_desc=" + rpt_desc);
		return new ModelAndView("redirect:" + sbf.toString());
		
	}
	
	@RequestMapping(value = "/portal/irhelp/getIRHelpReportInfo", method = RequestMethod.GET)
	public ModelAndView getCognosReportDesc(@RequestParam String report_def_id) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/IRHelpReportInfo.jsp");
		mav.addObject("report_def_id", report_def_id);
		return mav;
	}
	
	@RequestMapping(value = "/portal/irhelp/getIRHelpReport", method = RequestMethod.GET)
	@ResponseBody
	public Object getIRHelpReport(@RequestParam String report_def_id) {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + getIRHelpReportURL,
				Object.class,
				report_def_id);
	}
	
	@RequestMapping(value = "/portal/irhelp/openIRReport", method = RequestMethod.GET)
	public ModelAndView openIRReport(
			@RequestParam String cwa_id,
			@RequestParam String domain_key,
			@RequestParam String report_def_id,
			@RequestParam String rpt_name,
			@RequestParam String rpt_type,
			@RequestParam String helpDoc,
			@RequestParam String rpt_desc) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/openIRReport.jsp");
		mav.addObject("cwa_id", cwa_id);
		mav.addObject("domain_key", domain_key);
		mav.addObject("report_def_id", report_def_id);
		mav.addObject("rpt_name", rpt_name);
		mav.addObject("rpt_type", rpt_type);
		mav.addObject("helpDoc", helpDoc);
		mav.addObject("rpt_desc", rpt_desc);
		mav.addObject("rest_url", getRestfulServerUrl());
		return mav;
	}
	
	@RequestMapping(value = "/portal/irhelp/getIRReport", method = RequestMethod.GET)
	@ResponseBody
	public Object getIRReport(
			@RequestParam String cwa_id,
			@RequestParam String domain_key,
			@RequestParam String report_def_id,
			@RequestParam String rpt_name,
			@RequestParam String rpt_type,
			@RequestParam String helpDoc,
			@RequestParam String rpt_desc) {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + getIRReportURL,
				Object.class,
				cwa_id,
				domain_key,
				report_def_id,
				rpt_name,
				rpt_type,
				helpDoc,
				rpt_desc);
	}
	
	@RequestMapping(value = "/portal/irhelp/mailIRReport", method = RequestMethod.GET)
	public ModelAndView mailIRReport(
			@RequestParam String cwa_id,
			@RequestParam String domain_key,
			@RequestParam String report_def_id,
			@RequestParam String rpt_name,
			@RequestParam String rpt_type,
			@RequestParam String helpDoc,
			@RequestParam String rpt_desc) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/mailIRReport.jsp");
		mav.addObject("cwa_id", cwa_id);
		mav.addObject("domain_key", domain_key);
		mav.addObject("report_def_id", report_def_id);
		mav.addObject("rpt_name", rpt_name);
		mav.addObject("rpt_type", rpt_type);
		mav.addObject("helpDoc", helpDoc);
		mav.addObject("rpt_desc", rpt_desc);
		return mav;
	}
	
	@RequestMapping(value = "/portal/irhelp/postMailIRReport", method = RequestMethod.POST)
	@ResponseBody
	public Object postMailIRReport(
			@RequestBody BIReportBean paramMailIRReport, 
			@RequestParam String cwa_id,
			@RequestParam String domain_key,
			@RequestParam String report_def_id,
			@RequestParam String rpt_name,
			@RequestParam String rpt_type,
			@RequestParam String helpDoc,
			@RequestParam String rpt_desc) {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + getIRReportURL,
				Object.class,
				cwa_id,
				domain_key,
				report_def_id,
				rpt_name,
				rpt_type,
				helpDoc,
				rpt_desc);
	}
	
	@RequestMapping(value = "/portal/irhelp/emailIRReport", method = RequestMethod.POST)
	@ResponseBody
	public Object emailIRReport(
			@RequestBody Object paramMailIRReport,
			@RequestParam String cwa_id,
			@RequestParam String domain_key,
			@RequestParam String report_def_id,
			@RequestParam String rpt_name,
			@RequestParam String rpt_type,
			@RequestParam String helpDoc,
			@RequestParam String rpt_desc) {
		log.info("emailIRReport - " + paramMailIRReport);
		return this.getRestTemplate().postForObject(
				this.getRestfulServerUrl() + emailIRReportURL, 
				paramMailIRReport, 
				Object.class,
				cwa_id,
				domain_key,
				report_def_id,
				rpt_name,
				rpt_type,
				helpDoc,
				rpt_desc);
	}
}
