package transform.edgeportal.bi.portal.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CognosRequestController extends BaseController {

	@Value("${openCognosScheduleUrl}")
	private String				openCognosScheduleUrl;
	@Value("${getCognosInstance}")
	private String				getCognosInstance;
	@Value("${calculateReportAccess}")
	private String calculateReportAccess;
	private static final Logger	log	= Logger.getLogger(CognosRequestController.class);

	@RequestMapping(value = "/portal/report/cognosRequest/{cwa_id}/{uid}/{domain_key}/{content_id}/{report_name}/{rpt_type}/{sub_rpt_type}/{refer_objectid}/{refer_objectclass}/{operation}/{param}", method = RequestMethod.GET)
	public ModelAndView openSearchView(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String domain_key,
			@PathVariable String content_id,
			@PathVariable String report_name,
			@PathVariable String rpt_type,
			@PathVariable String sub_rpt_type,
			@PathVariable String refer_objectid,
			@PathVariable String refer_objectclass,
			@PathVariable String operation,
			@PathVariable String param) {

		String content = "";
		String contentType = "script";
		String gate_way = "";
		if (domain_key == null || domain_key.trim().equals("Invalid request")) {
			content = "<p> Invalid request, there is no domain </P>";
			contentType = "text";
		}

		if (content_id == null || content_id.trim().equals("")) {
			content = "<p> Invalid request, there is no store id </P>";
			contentType = "text";
		}

		if (operation == null || operation.trim().equals("")) {
			content = "<p> Invalid request, there is no operation type </P>";
			contentType = "text";
		}

		if (report_name == null || report_name.trim().equals("")) {
			content = "<p> Invalid request, there is no report name </P>";
			contentType = "text";

		}

		if (rpt_type == null || rpt_type.trim().equals("")) {
			content = "<p> Invalid request, there is no report type </P>";
			contentType = "text";
		}

		if (sub_rpt_type == null || sub_rpt_type.trim().equals("")) {
			content = "<p> Invalid request, there is no cognos report type </P>";
			contentType = "text";
		}

		if (sub_rpt_type.equals("shortcut")) {
			if (refer_objectid == null || refer_objectid.trim().equals("")) {
				content = "<p> Invalid request, shortcut does not have refer object id </P>";
				contentType = "text";
			}
			content_id = refer_objectid;
		}
		if (refer_objectid != null && !content_id.equals(refer_objectid)) {
			content_id = refer_objectid;
		}
		//
		String script = "";
		StringBuffer sbf = new StringBuffer();
		//
		if (operation.equals("schedule")) {
			sbf.setLength(0);
			sbf.append(openCognosScheduleUrl);
			script = sbf.toString().replace("{rptAccessID}", content_id).replace("{domainKey}", domain_key)
					.replace("{refer_objectid}", refer_objectid == null ? "NULL" : refer_objectid)
					+ "&searchPath=NULL";
			// sbf.append("?action=newSchedule");
			// sbf.append("&domain_key=" + domain_key);
			// sbf.append("&content_id=" + content_id);
			// sbf.append("&refer_objectid=" + refer_objectid);

			return new ModelAndView("redirect:" + script);
		}
		if (domain_key != null && !domain_key.equals("")) {
			try {
				Map<String, String> cogsinst = this.getRestTemplate().getForObject(
						getRestfulServerUrl() + getCognosInstance,
						Map.class,
						this.getIntranetID(),
						this.getUserUid(),
						domain_key);
				if (cogsinst == null || cogsinst.isEmpty()) {
					content = "<p> Invalid cognos instance, can not get cognos instace for this request </P>";
					contentType = "text";
				}
				gate_way = cogsinst.get("gateWay");
			} catch (Exception e) {
				log.error(e);
			}
		}
		if (gate_way == null || gate_way.equals("")) {
			content = "<p> Invalid cognos instance, can not get cognos instace for this request </P>";
			contentType = "text";
		}
		// edit_with_AS edit with analysis studio
		// edit_with_QS edit with query studio
		// edit_with_RS edit with report studio
		// open_ds open dashboard page
		// open_page open pagelet page
		// run_with_option
		// view_output
		// run_with_CV run with cognos viewer
		if (operation.equals("edit_with_AS")) {
			sbf.append(gate_way).append(
					"?b_action=xts.run&m=portal%2flaunch.xts&ui.tool=AnalysisStudio&ui.object=storeID(%22");
			sbf.append(content_id).append("%22)");
			sbf.append("&ui.gateway=").append(gate_way);
		}
		if (operation.equals("edit_with_QS")) {
			sbf.append(gate_way).append(
					"?b_action=xts.run&m=portal%2flaunch.xts&ui.tool=QueryStudio&ui.object=storeID(%22");
			sbf.append(content_id).append("%22)");
		}
		if (operation.equals("edit_with_RS")) {
			sbf.append(gate_way).append(
					"?b_action=xts.run&m=portal%2flaunch.xts&ui.tool=ReportStudio&ui.object=storeID(%22");
			sbf.append(content_id).append("%22)");
			sbf.append("&ui.gateway=").append(gate_way);
		}
		if (operation.equals("open_ds")) {
			sbf.append(gate_way).append("?b_action=dashboard&pathinfo=%2fcm&path=storeID(%22").append(content_id)
					.append("%22)");
		}
		if (operation.equals("open_page")) {
			sbf.append(gate_way).append("?b_action=dashboard&pathinfo=%2fcm&path=storeID(%22").append(content_id)
					.append("%22)");
		}
		if (operation.equals("run_with_option")) {
			sbf.append(gate_way).append(
					"?b_action=xts.run&m_class=report&m=portal%2frunWithOptions%2freport.xts&m_obj=storeID(%22");
			sbf.append(content_id).append("%22)&backURL=javascript%3Aclose()");
			
			
		}
		if (operation.equals("view_output")) {
			sbf.append(gate_way).append("?b_action=cognosViewer&ui.object=defaultOutput(storeID(%22");
			sbf.append(content_id).append("%22))");
		}
		if (operation.equals("run_with_CV")) {
			sbf.append(gate_way).append("?b_action=cognosViewer&ui.object=storeID(%22");
			sbf.append(content_id).append("%22)");
		}
		if (param != null && !param.trim().equals("") && !param.equals("none")) {
			if (!param.startsWith("&")) {
				sbf.append("&");
			}
			sbf.append(param);
		}
		try {
			String tmp = URLDecoder.decode(report_name, "iso-8859-1");
			report_name = tmp;
		} catch (Exception e) {

		}
		try {
			sbf.append("&ui.name=").append(URLEncoder.encode(report_name, "iso-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		script = "window.open('" + sbf.toString() + "','_self','resizable=yes,toolbar=no,menubar=no,scrollbars=yes');";
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/cognosRequest.jsp");
		mav.addObject("contentType", contentType);
		mav.addObject("title", report_name);
		mav.addObject("content", content);
		mav.addObject("script", script);
		
		return mav;
	}
	//calculate URL report access count for report ranking by leo
	@RequestMapping(value = "/portal/ranking/calculateReportAccess", method = RequestMethod.GET)
	public void calculateReportAccess(@RequestParam String searchPath) {
		log.info("searchPath:"+searchPath);
		this.getRestTemplate().getForObject(this.getReportAccessRestService(), Object.class, searchPath);
	}
	
	public String getReportAccessRestService() {
		return getRestfulServerUrl() + calculateReportAccess;
	}
}
