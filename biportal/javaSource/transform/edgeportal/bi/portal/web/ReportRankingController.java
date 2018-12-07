package transform.edgeportal.bi.portal.web;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import transform.edgeportal.bi.jpa.ranking.CognosReportComment;
import transform.edgeportal.bi.jpa.ranking.CognosReportRank;

@Controller
public class ReportRankingController extends BaseController {

	private static final Logger log = Logger.getLogger(ReportRankingController.class);
	
	@Value("${getBlobNavigBar}")
	private String getBlobNavigBar;
	@Value("${getCognosReportRankByPath}")
	private String getReportRanking;
	@Value("${saveCognosReportRank}")
	private String saveReportRanking;
	@Value("${saveCognosReportComment}")
	private String saveCognosReportComment;
	@Value("${getBlobReports}")
	private String getBlobReports;

	@Value("${getLinksReports}")
	private String getLinksReports;
	@Value("${getCognosReportComments}")
	private String getCognosReportComments;
	@Value("${getBlobFoldersList}")
	private String getBlobFolders;

	@Value("${getCognosPublicList}")
	private String getCognosPublic;

	@Value("${getCognosMyReports}")
	private String getCognosMy;
	@Value("${getCognosReportByPath}")
	private String getCognosbyPath;
	public String getCognosReport_rest() {
		return getRestfulServerUrl() + getCognosbyPath;
	}
	public String getCognosRanking_rest() {
		return getRestfulServerUrl() + getReportRanking;
	}
	public String saveCognosRanking_rest() {
		return getRestfulServerUrl() + saveReportRanking;
	}
	public String saveCognosComment_rest() {
		return getRestfulServerUrl() + saveCognosReportComment;
	}
	public String getCognosReportComments_rest() {
		return getRestfulServerUrl() + getCognosReportComments;
	}
//h/transform/biportal/action/portal/rank/getReportRankingPage?search_path=ddddddd
	@RequestMapping(value = "/portal/rank/getReportRankingPage", method = RequestMethod.GET)

public ModelAndView getAllReportRanking(@RequestParam String search_path) {
		String tmp_search="";
		
		try {
			 tmp_search=URLEncoder.encode(search_path, "iso-8859-1");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/ranking.jsp");
		// modelAndView.addObject("folder_id", folder_id);
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		modelAndView.addObject("rpt_path", tmp_search);
		
		log.info("getAllReportRanking -rpt_path: " + tmp_search);
		return modelAndView;

	}
	                        //portal/rank/getReportRanking
	@RequestMapping(value = "/portal/rank/getReportRanking", method = RequestMethod.GET)
	@ResponseBody
	public List getCognosMyRestAPI111(@RequestParam String cwa_id,@RequestParam String search_path) {
		
		log.info("getReportRanking -cwa_id: " + cwa_id);
		log.info("getReportRanking -search_path: " + search_path);
//		String tmp_search="";
//	try {
//		tmp_search=	URLEncoder.encode(search_path, "iso-8859-1");
//		
//		log.info("getReportRanking -search_path after encode: " + search_path);
//	} catch (UnsupportedEncodingException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	}
		return this.getRestTemplate().getForObject(this.getCognosRanking_rest(), List.class, search_path, cwa_id);
	}
///portal/rank/saveReportRanking
	///portal/rank/getReportRanking
	@RequestMapping(value = "/portal/rank/saveReportRanking", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> saveReportRank(@RequestBody List<CognosReportRank> ad) {
		log.info("save 111222212asdassa1 - " + ad.size());
		log.info("save 111222212asdassa1 - " + this.saveCognosRanking_rest());
		return this.getRestTemplate().postForEntity(this.saveCognosRanking_rest(), ad,String.class,this.getIntranetID());
	//this.getRestTemplate().postForEntity(
		
	 
	}

	
	@RequestMapping(value = "/portal/rank/getReportByPath", method = RequestMethod.GET)
	@ResponseBody
	public Object getCognosByPath(@RequestParam String cwa_id,@RequestParam String search_path) {
		
		log.info("getReportRanking -cwa_id: " + cwa_id);
		log.info("getReportRanking -search_path: " + search_path);
//		String tmp_search="";
//	try {
//		tmp_search=	URLEncoder.encode(search_path, "iso-8859-1");
//		
//		log.info("getReportRanking -search_path after encode: " + search_path);
//	} catch (UnsupportedEncodingException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	}
		return this.getRestTemplate().getForObject(this.getCognosReport_rest(), Object.class, search_path, cwa_id);
	}
	
	@RequestMapping(value = "/portal/rank/getReportComments", method = RequestMethod.GET)
	@ResponseBody
	public List getCognosComments(@RequestParam String cwa_id,@RequestParam String rpt_pk) {
		
		log.info("getCognosComments -cwa_id: " + cwa_id);
		log.info("getCognosComments -rpt_pk: " + rpt_pk);
//		String tmp_search="";
//	try {
//		tmp_search=	URLEncoder.encode(search_path, "iso-8859-1");
//		
//		log.info("getReportRanking -search_path after encode: " + search_path);
//	} catch (UnsupportedEncodingException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	}
		return this.getRestTemplate().getForObject(this.getCognosReportComments_rest(), List.class, rpt_pk);
	}	
	@RequestMapping(value = "/portal/rank/saveReportComment", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> saveReporComment(@RequestBody CognosReportComment ad) {
		log.info("save 111222212asdassa1 - " + ad);
		
		return this.getRestTemplate().postForEntity(this.saveCognosComment_rest(), ad,String.class);
	//this.getRestTemplate().postForEntity(
		
	 
	}

}
