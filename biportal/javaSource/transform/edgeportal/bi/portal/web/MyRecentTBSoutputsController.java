package transform.edgeportal.bi.portal.web;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MyRecentTBSoutputsController extends BaseController {

	private static final Logger	log	= Logger.getLogger(MyRecentTBSoutputsController.class);

	// Return download TBS Output Path
	@Value("${downLoadTBSOutput}")
	private String				downLoadTBSOutput;

	// Return download single TBS Output Path
	@Value("${downLoadSignleTBSOutput}")
	private String				downLoadSignleTBSOutput;

	// Download method with parameter requestID
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/portal/tbsoutputs/downLoadTBSOutput/{cwa_id}/{uid}/{with_request}/{requestID}", method = RequestMethod.GET)
	public ModelAndView downLoadTBSOutput(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String with_request,
			@PathVariable String requestID,
			HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, String> map = null;
		try {
			map = this.getRestTemplate().getForObject(
					getRestfulServerUrl() + downLoadTBSOutput,
					Map.class,
					cwa_id,
					uid,
					with_request,
					requestID);
		} catch (Exception e) {
			log.error(e);
			return showMyTBSoutputsError(
					cwa_id,
					uid,
					"Error occured in call the method downLoadTBSOutput from biapi",
					"null",
					"null");
		}

		if (map == null) {
			return showMyTBSoutputsError(
					cwa_id,
					uid,
					"Return map is null, please check your parameters",
					"null",
					"null");
		}

		boolean wr = false;
		if ("Y".equalsIgnoreCase(with_request)) {
			wr = true;
		}
		return sendOutputFiles(cwa_id, uid, map, wr, request, response);
	}

	/**
	 * 
	 * @param cwa_id
	 * @param uid
	 * @param runningID
	 * @param request
	 * @param response
	 * @return
	 */
	// downLoadSignleTBSOutput method with parameter runningID
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/portal/tbsoutputs/downLoadSignleTBSOutput/{cwa_id}/{uid}/{runningID}", method = RequestMethod.GET)
	public ModelAndView downLoadSignleTBSOutput(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String runningID,
			HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, String> map = null;

		try {
			map = this.getRestTemplate().getForObject(
					getRestfulServerUrl() + downLoadSignleTBSOutput,
					Map.class,
					cwa_id,
					uid,
					runningID);
		} catch (Exception e) {
			log.error(e);
			return showMyTBSoutputsError(
					cwa_id,
					uid,
					"Error occured in call the method downLoadSingleTBSOutput from biapi",
					"null",
					"null");
		}
		//
		if (map == null) {
			return showMyTBSoutputsError(
					cwa_id,
					uid,
					"Return map is null, please check your parameters",
					"null",
					"null");
		}
		//
		return sendOutputFiles(cwa_id, uid, map, false, request, response);
	}

	private ModelAndView sendOutputFiles(
			String cwa_id,
			String uid,
			Map<String, String> map,
			boolean with_request,
			HttpServletRequest request,
			HttpServletResponse response) {
		//
		String errorMessage = map.get("ErrorMessage");
		if (errorMessage != null && !"".equals(errorMessage)) {
			return showMyTBSoutputsError(
					cwa_id,
					uid,
					errorMessage,
					map.get("EmailSubject") == null ? "null" : map.get("EmailSubject"),
					map.get("ReportName") == null ? "null" : map.get("ReportName"));
		}
		//
		String requestID = null;
		String runningID = null;
		String outputFile = null;
		String reportName = null;
		String emailSubject = null;

		requestID = map.get("RequestID");
		runningID = map.get("RunningID");
		outputFile = map.get("OutputFile");
		reportName = map.get("ReportName");
		emailSubject = map.get("EmailSubject");
		// reportName = reportName.replaceAll("[\\\\/:*?\"<>|]", " ").trim();
		// reportName = reportName.replaceAll(" (System Generated Schedule)",
		// "");
		//
		//
		int i = -1;
		i = outputFile.lastIndexOf("/");
		String fileName = outputFile.substring((i < 0 ? 0 : i + 1), outputFile.length());
		log.info("fileName:::::" + fileName);
		i = fileName.lastIndexOf(".");
		String suffix = null;
		if (i > -1) {
			suffix = fileName.substring(i + 1, fileName.length());
			log.info("suffix:::::" + suffix);
		}
		if (suffix == null) {
			suffix = "txt";
		}
		String outputFileName = emailSubject.replaceAll("[\\\\/:*?\"<>|]", "");
//		outputFileName = outputFileName.replace("(System Generated Schedule)", "").trim(); // for story 1721819
		outputFileName =outputFileName.trim(); // for story 1721819
		// SMS8359_01 TSS Key Deals Weekly Report (System Generated Schedule)
		log.info("outputFileName:::::" + outputFileName);
		//
		if (with_request) {
			outputFileName = outputFileName + "-" + requestID + "." + suffix;
		} else {
			outputFileName = outputFileName + "." + suffix;
		}
		//
		try {
			response.setStatus(HttpServletResponse.SC_OK);
			response.setContentType("multipart/form-data");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename=\"" + outputFileName + "\"");
			ModelAndView mav = new ModelAndView("/output/" + fileName);
			return mav;
		} catch (Exception e) {
			return showMyTBSoutputsError(
					cwa_id,
					uid,
					"There is error occured in the file download process",
					emailSubject,
					reportName);
		}
	}

	/**
	 * 
	 * 
	 * 
	 * @param errorMessage
	 * @param emailSubject
	 * @param reportName
	 * @return
	 */
	private ModelAndView showMyTBSoutputsError(
			String cwaid,
			String uid,
			String errorMessage,
			String emailSubject,
			String reportName) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/myRecentTBSoutputs_error.jsp");
		mav.addObject("cwa_id", cwaid);
		mav.addObject("uid", uid);
		mav.addObject("ErrorMsg", errorMessage);

		if (emailSubject != null && !"".equals(emailSubject)) {
			mav.addObject("emailSubject", emailSubject);
		} else {
			mav.addObject("emailSubject", null);
		}
		if (reportName != null && !"".equals(reportName)) {
			// if (reportName.indexOf("-20") > 0) {
			// reportName = reportName.substring(0, reportName.indexOf("-"));
			// }
			mav.addObject("reportName", reportName);
		} else {
			mav.addObject("reportName", null);
		}

		return mav;
	}
}
