package transform.edgeportal.bi.portal.web;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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
public class CognosScheduleAdminPanelsController extends BaseController {

	//--------------------------------we shall have separate controllers for different UI components, but they are too simple, so all are here. 
	private static final Logger	log	= Logger.getLogger(CognosScheduleAdminPanelsController.class);
	
	//--------------------------------owner transfer
	@Value("${csrAdmin_csrOwnTranGetSummary}")
	private String     csrOwnTranGetSummary_str;		
		
	@RequestMapping(value ="/admin/csrOwnTran/getSummary", method = RequestMethod.GET)
	@ResponseBody
	public Map<?, ?> csrOwnTranGetSummary(@RequestParam String fromUid, @RequestParam String toUid) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + csrOwnTranGetSummary_str, Map.class, this.getIntranetID(), this.getUserUid(), fromUid, toUid);
	}		
	
	@Value("${csrAdmin_csrOwnTranSubmitTransfer}")
	private String     csrOwnTranSubmitTransfer_str;
	
	@RequestMapping(value ="/admin/csrOwnTran/submitTransfer", method = RequestMethod.POST)
	@ResponseBody
	public Map<?, ?> csrOwnTranSubmitTransfer(@RequestBody Map map) {
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + csrOwnTranSubmitTransfer_str, map, Map.class, this.getIntranetID(), this.getUserUid());
	}	
	
	@RequestMapping(value = "/admin/csrOwnTran/firstPage", method = RequestMethod.GET)
	public ModelAndView csrOwnTranFirstPage() { 	
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/CognosScheduleAdminOwnerTransfer.jsp");
		mav.addObject("cwa_id", 		this.getIntranetID());
		mav.addObject("uid", 		this.getUserUid());
		return mav;
	}	
	
	//--------------------------------status change 
	@Value("${csrAdmin_csrStsChgGetXmlFile}")
	private String     csrStsChgGetXmlFile_str;
	
	@RequestMapping(value ="/admin/csrStsChg/getXmlFile/{requestId}", method = RequestMethod.GET)
	public void csrStsChgGetXmlFile(@PathVariable String requestId, HttpServletResponse response) {
		Map<String, ?> csrPrompts = this.getRestTemplate().getForObject(getRestfulServerUrl() + csrStsChgGetXmlFile_str, Map.class, this.getIntranetID(), this.getUserUid(), requestId);
		response.setContentType("application/xml;charset=utf-8");    
		response.setHeader("content-disposition","attachment;filename=\""+requestId+".xml\"");
		String XMLDATA = (String) csrPrompts.get("xmldata"); 
		OutputStream os=null;
		try{
	        	os =new BufferedOutputStream(response.getOutputStream());
	        	os.write(XMLDATA.getBytes());
	        	os.close();
	        	os.flush();
		} catch (IOException e) {
	        	e.printStackTrace();
		} 
	}	

	@Value("${csrAdmin_csrStsChgBatchUpdate}")
	private String     csrStsChgBatchUpdate_str;
	
	@RequestMapping(value ="/admin/csrStsChg/batchUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<?, ?> csrStsChgBatchUpdate(@RequestBody Map map) {
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + csrStsChgBatchUpdate_str, map, Map.class, this.getIntranetID(), this.getUserUid());
	}
	
	@Value("${csrAdmin_csrStsChgSearch}")
	private String     csrStsChgSearch_str;
	
	@RequestMapping(value ="/admin/csrStsChg/search", method = RequestMethod.GET)
	@ResponseBody
	public Map<?, ?> csrStsChgSearch(@RequestParam String reportName, @RequestParam String triggerCode, @RequestParam String requestId, @RequestParam String ownerCwa) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + csrStsChgSearch_str, Map.class, this.getIntranetID(), this.getUserUid(), reportName, triggerCode, requestId, ownerCwa);
	}		

	@RequestMapping(value = "/admin/csrStsChg/firstPage", method = RequestMethod.GET)
	public ModelAndView csrStsChgFirstPage() { 	
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/CognosScheduleAdminStatusChange.jsp");
		mav.addObject("cwa_id", 		this.getIntranetID());
		mav.addObject("uid", 		this.getUserUid());
		return mav;
	}		
	
	//--------------------------------blob publication 
	@RequestMapping(value = "/admin/csrBlobPub/firstPage", method = RequestMethod.GET)
	public ModelAndView csrBlobPubFirstPage() { 	
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/CognosScheduleAdminBlobPublication.jsp");
		mav.addObject("cwa_id", 		this.getIntranetID());
		mav.addObject("uid", 		this.getUserUid());
		return mav;
	}	
	
	@Value("${csrAdmin_csrBlobPubBatchUpdate}")
	private String     csrBlobPubBatchUpdate_str;
	
	@RequestMapping(value ="/admin/csrBlobPub/batchUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<?, ?> csrBlobPubBatchUpdate(@RequestBody Map map) {
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + csrBlobPubBatchUpdate_str, map, Map.class, this.getIntranetID(), this.getUserUid());
	}
	
	@Value("${csrAdmin_csrBlobPubSearch}")
	private String     csrBlobPubSearch_str;
	
	@RequestMapping(value ="/admin/csrBlobPub/search", method = RequestMethod.GET)
	@ResponseBody
	public Map<?, ?> csrBlobPubSearch(@RequestParam String reportName, @RequestParam String ownerCwa) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + csrBlobPubSearch_str, Map.class, this.getIntranetID(), this.getUserUid(), reportName, ownerCwa);
	}		
	
	@RequestMapping(value = "/admin/csrBlobPub/details", method = RequestMethod.GET)
	public ModelAndView csrBlobPubDetails(
			@RequestParam String csrRquestId, 
			@RequestParam String csrRptName, 
			@RequestParam String csrTriggerCd, 
			@RequestParam String csrEmailSubject, 
			@RequestParam String csrEmailComments, 
			@RequestParam String blobId) { 	
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/CognosScheduleAdminBlobPublicationDetails.jsp");
		mav.addObject("cwa_id", 			this.getIntranetID());
		mav.addObject("uid", 			this.getUserUid());
		mav.addObject("csrRquestId", 	csrRquestId);
		mav.addObject("csrRptName", 		csrRptName);
		mav.addObject("csrTriggerCd", 	csrTriggerCd);
		mav.addObject("csrEmailSubject", csrEmailSubject);
		mav.addObject("csrEmailComments",csrEmailComments);
		mav.addObject("blobId", 			blobId);
		return mav;
	}	
	
	@Value("${csrAdmin_csrBlobPubDetailsGetBlob}")
	private String     csrBlobPubDetailsGetBlob_str;
	
	@RequestMapping(value ="/admin/csrBlobPub/detailsGetBlob", method = RequestMethod.GET)
	@ResponseBody
	public Map<?, ?> csrBlobPubDetailsGetBlob(@RequestParam String reportDefId, @RequestParam String triggerCd) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + csrBlobPubDetailsGetBlob_str, Map.class, this.getIntranetID(), this.getUserUid(), reportDefId, triggerCd);
	}	
	
	@Value("${csrAdmin_csrBlobPubDetailsSaveBlob}")
	private String     csrBlobPubDetailsSaveBlob_str;
	
	@RequestMapping(value ="/admin/csrBlobPub/detailsSaveBlob", method = RequestMethod.POST)
	@ResponseBody
	public Map<?, ?> csrBlobPubDetailsSaveBlob(@RequestBody Map map) {
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + csrBlobPubDetailsSaveBlob_str, 
				map, 
				Map.class, 
				this.getIntranetID(), 
				this.getUserUid()); 
	}	
	
}
