package transform.edgeportal.bi.portal.web;

import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import transform.edgeportal.bi.jpa.mycognosschedule.MyCognosSchedule;
import transform.edgeportal.bi.jpa.schedulepanel.CognosEvent;

/** 
 * web controller to forward requests to backend BIAPI
 * @author pengzhao@cn.ibm.com, create this in Sep of 2017
 *
 */
@Controller
public class MyCognosScheduleListController extends BaseController {
	
	private static final Logger	log	= Logger.getLogger(MyCognosScheduleListController.class);
	
	/** 
	 * for this UI app, BIPORTAL, return the JSP to end users
	 * @return JSP to show a web page 
	 */
	@RequestMapping(value = "/portal/mycognosschedulelist", method = RequestMethod.GET)
	public ModelAndView showMyCognosSchedulesList() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/myCognosScheduleList.jsp");
		mav.addObject("cwa_id", 	this.getIntranetID());
		mav.addObject("uid", 		this.getUserUid());
		try {
			mav.addObject("isUserInPublishGroups", this.isUserInAnyGroup(this.getIntranetID(), new String[] { "RL_Publish", "Super_RL_Publish" }));
		} catch (Exception e) {
			mav.addObject("isUserInPublishGroups", false);
			log.error("don't know why bluegroup is NOT stable at this point, exception msg = "+e.getMessage(), e);
		}
		return mav;
	}	
	
	// -----------------------------------------------------------------------------------------------
	
	@Value("${mycognosschedulelist_triggers}")
	private String	tbsListTrigger;	
	/** 
	 * a list of available triggers for UI to select
	 * @param cwa_id
	 * @param uid
	 * @param domainKey
	 * @param searchPath
	 * @return a list of triggers 
	 */
	@RequestMapping(value = "/portal/mycognosschedulelist/getAvailableTriggers/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List<?> getAvailableTriggers(@PathVariable String cwa_id, @PathVariable String uid, @RequestParam String domainKey, @RequestParam String searchPath) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + tbsListTrigger, List.class, cwa_id, uid, domainKey, searchPath);
	}	
	
	
	@Value("${mycognosschedulelist_formats}")
	private String	tbsListFormat;	
	/** 
	 * a list of available formats for UI to select
	 * @param cwa_id
	 * @param uid
	 * @param domainKey
	 * @param rptType
	 * @return List of formats
	 */
	@RequestMapping(value = "/portal/mycognosschedulelist/getAvailableOutputFormats/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List<?> getAvailableOutputFormats(@PathVariable String cwa_id, @PathVariable String uid, @RequestParam String domainKey, @RequestParam String rptType) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + tbsListFormat, List.class, cwa_id, uid, domainKey, rptType);
	}	
	
	
	@Value("${mycognosschedulelist_events}")
	private String	tbsListEvents;
	/** 
	 * for forwarding to BIAPI
	 * to get a list of configured business events of an application
	 * @param cwa_id
	 * @param uid
	 * @param appl_cd
	 * @return list of events
	 */
	@RequestMapping(value = "/portal/schedulebusinessevents/{cwa_id}/{uid}/{appl_cd}", method = RequestMethod.GET)
	@ResponseBody
	public CognosEvent[] getTbsListEventsRemote(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String appl_cd) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + tbsListEvents, CognosEvent[].class, cwa_id, uid, appl_cd);
	}
	
	
	@Value("${mycognosschedulelist_getAllMyCognosSchedules}")
	private String	tbsListAllMySchedules;
	/** 
	 * for forwarding to BIAPI
	 * to get a full list of schedules owned by this cwa, either as a owner or as a backup
	 * @param cwa_id
	 * @param uid
	 * @return list of schedules
	 */
	@RequestMapping(value = "/portal/mycognosschedulelist/getAllMyCognosSchedules/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List<?> getTbsListAllMySchedulesRemote(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + tbsListAllMySchedules, List.class, cwa_id, uid);
	}	

	
	@Value("${mycognosschedulelist_batch}")
	private String	tbsListBatch;
	/** 
	 * for forwarding to BIAPI
	 * the batch update function, the passed in parameter 'operation' is a key. 
	 * @param cwa_id
	 * @param uid
	 * @param req
	 * @param listOfRequestIds
	 * @return a map wrapping up a list of schedules
	 */
	@RequestMapping(value = "/portal/mycognosschedulelist/batch/{cwa_id}/{uid}", method = RequestMethod.POST)
	@ResponseBody
	public Map<?, ?> processTbsListBatchRemote(
			@PathVariable String cwa_id, 
			@PathVariable String uid, 
			HttpServletRequest req, 
			@RequestBody MyCognosSchedule[] listOfRequestIds) {   
		
		StringBuffer param = new StringBuffer(getRestfulServerUrl() + tbsListBatch + "?"); 
		Enumeration<String> em = req.getParameterNames();
		String name = null; 
		while (em.hasMoreElements()) {
		    name = (String) em.nextElement();
		    param.append("&"+name+"="+req.getParameter(name)); 
		}
		
		return getRestTemplate().postForObject(
				param.toString(),
				listOfRequestIds,
				Map.class,
				cwa_id,
				uid);	
	}
	
}
