package transform.edgeportal.bi.portal.web;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import transform.edgeportal.bi.jpa.schedule.Triggerid;
import transform.edgeportal.bi.jpa.status.Eodtappl;
import transform.edgeportal.bi.jpa.status.Loadtabs;
import transform.edgeportal.bi.jpa.trigger.CognosScheduleThrottles;
import transform.edgeportal.bi.jpa.trigger.CognosScheduleThrottlesPK;
import transform.edgeportal.bi.jpa.trigger.Trgrfedd;
import transform.edgeportal.bi.jpa.trigger.TrgrfeddPK;
import transform.edgeportal.bi.jpa.trigger.TriggeridStr;
import transform.edgeportal.bi.portal.bs.ButtonAccess;

/**
 * ClassName: TriggerController <br/>
 * Description: This controller is used to manage Trigger IDs, Application, Federated triggers and Trigger kick panel in admin panel. <br/>
 * Date: April 25, 2018 <br/>
 * 
 * @author yhqin
 *
 */
@Controller
public class TriggerPanelController extends BaseController {

	private static final Logger	log	= Logger.getLogger(TriggerPanelController.class);
	
	@Value("${getTriggeridAll}")
	private String	getTriggeridAll;
	
	@Value("${getTriggeridNew}")
	private String	getTriggeridNew;
	
	@Value("${getTriggeridEdit}")
	private String	getTriggeridEdit;
	
	@Value("${updateTriggerid}")
	private String	updateTriggerid;
	
	@Value("${deleteTriggerid}")
	private String	deleteTriggerid;
	
	@Value("${deleteDataloadtab}")
	private String	deleteDataloadtab;
	
	@Value("${getTriggeridTriggerTime}")
	private String	getTriggeridTriggerTime;
	
	@Value("${updateTriggeridTriggerTime}")
	private String	updateTriggeridTriggerTime;
	
	@Value("${getDataloadtabAll}")
	private String	getDataloadtabAll;
	
	@Value("${getDataloadtabEdit}")
	private String	getDataloadtabEdit;
	
	@Value("${updateDataloadtab}")
	private String	updateDataloadtab;
	
	@Value("${getApplicationAll}")
	private String	getApplicationAll;
	
	@Value("${deleteApplication}")
	private String	deleteApplication;
	
	@Value("${getApplicationNew}")
	private String	getApplicationNew;
	
	@Value("${getApplicationEdit}")
	private String	getApplicationEdit;
	
	@Value("${updateApplication}")
	private String	updateApplication;
	
	@Value("${getCognosScheduleThrottlesAll}")
	private String	getCognosScheduleThrottlesAll;
	
	@Value("${getCognosScheduleThrottlesList}")
	private String	getCognosScheduleThrottlesList;
	
	@Value("${getCognosScheduleThrottleEdit}")
	private String	getCognosScheduleThrottleEdit;
	
	@Value("${getCognosScheduleThrottleNew}")
	private String	getCognosScheduleThrottleNew;
	
	@Value("${updateCognosScheduleThrottle}")
	private String	updateCognosScheduleThrottle;
	
	@Value("${updateCognosScheduleThrottleMaxThrottle}")
	private String updateCognosScheduleThrottleMaxThrottle;
	
	@Value("${deleteCognosScheduleThrottle}")
	private String	deleteCognosScheduleThrottle;
	
	@Value("${getFederatedTriggersAll}")
	private String	getFederatedTriggersAll;
	
	@Value("${getFederatedTriggersNew}")
	private String	getFederatedTriggersNew;
	
	@Value("${getFederatedTriggersEdit}")
	private String	getFederatedTriggersEdit;
	
	@Value("${updateFederatedTriggers}")
	private String	updateFederatedTriggers;
	
	@Value("${deleteFederatedTrigger}")
	private String	deleteFederatedTrigger;
	
//	@Value("${getTriggerApplStatus}")
//	private String	getTriggerApplStatus;
	
//	@Value("${updateTriggerApplStatus}")
//	private String	updateTriggerApplStatus;
	
	@RequestMapping(value = "/admin/trigger/managetriggers", method = RequestMethod.GET)
	public ModelAndView showAdminTriggeridListPanel() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/admin_triggeridlist.jsp");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		return mav;
	}
	
	@RequestMapping(value = "/admin/trigger/getTriggeridAll/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getTriggeridAll(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List triggeridList = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getTriggeridAll, 
				List.class,
				cwa_id,
				uid);
		
		return triggeridList;
	}
	
	@RequestMapping(value = "/admin/trigger/getTriggeridInit/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Map getTriggeridInit(@PathVariable String cwa_id, @PathVariable String uid, HttpServletRequest request) {
		
		List triggeridList = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getTriggeridAll, 
				List.class,
				cwa_id,
				uid);
		
		List<ButtonAccess> buttonAccessList = this.checkPanelButtonAccess(request, "trigger", cwa_id);
				
		Map resultMap = new HashMap<>();
		resultMap.put("triggeridList", triggeridList);
		resultMap.put("buttonAccessList", buttonAccessList);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/getFederatedTriggersAll/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getFederatedTriggersAll(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List resultMap = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getFederatedTriggersAll, 
				List.class,
				cwa_id,
				uid);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/throttle/getCognosScheduleThrottlesList/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getCognosScheduleThrottlesList(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List throttleList = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getCognosScheduleThrottlesList, 
				List.class,
				cwa_id,
				uid);
		
		return throttleList;
	}
	
	@RequestMapping(value = "/admin/throttle/getCognosScheduleThrottlesAll/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Map getCognosScheduleThrottlesAll(@PathVariable String cwa_id, @PathVariable String uid) {
		
		Map resultMap = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getCognosScheduleThrottlesAll, 
				Map.class,
				cwa_id,
				uid);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/throttle/getCognosScheduleThrottlesInit/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Map getCognosScheduleThrottlesInit(@PathVariable String cwa_id, @PathVariable String uid, HttpServletRequest request) {
		
		Map resultMap = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getCognosScheduleThrottlesAll, 
				Map.class,
				cwa_id,
				uid);
		
		List<ButtonAccess> buttonAccessList = this.checkPanelButtonAccess(request, "throttle", cwa_id);
		resultMap.put("buttonAccessList", buttonAccessList);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/getDataloadtabAll/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getDataloadtabAll(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List resultMap = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getDataloadtabAll, 
				List.class,
				cwa_id,
				uid);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/getApplicationAll/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getApplicationAll(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List resultMap = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getApplicationAll, 
				List.class,
				cwa_id,
				uid);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/getTriggeridNew/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getTriggeridNew(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List resultMap = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getTriggeridNew, 
				List.class,
				cwa_id,
				uid);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/getTriggeridEdit", method = RequestMethod.POST)
	@ResponseBody
	public Map getTriggeridEdit(@RequestBody Object body) {
		
		log.info(body);
		
		Map resultMap = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + getTriggeridEdit, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/getFederatedTriggersNew/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getFederatedTriggersNew(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List resultMap = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getFederatedTriggersNew, 
				List.class,
				cwa_id,
				uid);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/getFederatedTriggersEdit", method = RequestMethod.POST)
	@ResponseBody
	public Map getFederatedTriggersEdit(@RequestBody TrgrfeddPK body) {
		
		log.info(body);
		
		Map resultMap = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + getFederatedTriggersEdit, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/getApplicationNew/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getApplicationNew(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List resultMap = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getApplicationNew, 
				List.class,
				cwa_id,
				uid);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/getApplicationEdit", method = RequestMethod.POST)
	@ResponseBody
	public Map getApplicationEdit(@RequestBody Eodtappl body) {
		
		log.info(body);
		
		Map resultMap = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + getApplicationEdit, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/throttle/getCognosScheduleThrottleNew/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Map getCognosScheduleThrottleNew(@PathVariable String cwa_id, @PathVariable String uid) {
		
		Map resultMap = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getCognosScheduleThrottleNew, 
				Map.class,
				cwa_id,
				uid);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/throttle/getCognosScheduleThrottleEdit", method = RequestMethod.POST)
	@ResponseBody
	public Map getCognosScheduleThrottleEdit(@RequestBody CognosScheduleThrottlesPK body) {
		
		log.info(body);
		
		Map resultMap = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + getCognosScheduleThrottleEdit, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return resultMap;
	}
	
//	@RequestMapping(value = "/admin/trigger/getTriggerApplStatus", method = RequestMethod.POST)
//	@ResponseBody
//	public Map getTriggerApplStatus(@RequestBody Eodtappl body) {
//		
//		log.info(body);
//		
//		Map resultMap = this.getRestTemplate().postForObject(
//				getRestfulServerUrl() + getTriggerApplStatus, 
//				body, 
//				Map.class, 
//				this.getIntranetID(),
//				this.getUserUid());
//		
//		return resultMap;
//	}
	
	@RequestMapping(value = "/admin/trigger/getDataloadtabEdit", method = RequestMethod.POST)
	@ResponseBody
	public Loadtabs getDataloadtabEdit(@RequestBody Loadtabs body) {
		
		log.info(body);
		
		Loadtabs resultMap = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + getDataloadtabEdit, 
				body, 
				Loadtabs.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/updateTriggerid/{action}", method = RequestMethod.POST)
	@ResponseBody
	public Map updateTriggerid(@PathVariable String action, @RequestBody Object body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + updateTriggerid,  
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid(),
				action);
		
		return result;
	}
	
	@RequestMapping(value = "/admin/trigger/updateApplication/{action}", method = RequestMethod.POST)
	@ResponseBody
	public Map updateApplication(@PathVariable String action, @RequestBody Eodtappl body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + updateApplication,  
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid(),
				action);
		
		return result;
	}
	
	@RequestMapping(value = "/admin/trigger/updateFederatedTriggers/{action}", method = RequestMethod.POST)
	@ResponseBody
	public Map updateFederatedTriggers(@PathVariable String action, @RequestBody Trgrfedd body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + updateFederatedTriggers,  
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid(),
				action);
		
		return result;
	}
	
	@RequestMapping(value = "/admin/throttle/updateCognosScheduleThrottle/{action}", method = RequestMethod.POST)
	@ResponseBody
	public Map updateCognosScheduleThrottle(@PathVariable String action, @RequestBody CognosScheduleThrottles body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + updateCognosScheduleThrottle,  
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid(),
				action);
		
		return result;
	}
	
	@RequestMapping(value = "/admin/throttle/updateCognosScheduleThrottleMaxThrottle", method = RequestMethod.POST)
	@ResponseBody
	public Map updateCognosScheduleThrottleMaxThrottle(@RequestBody List<CognosScheduleThrottles> body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + updateCognosScheduleThrottleMaxThrottle,  
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
//	@RequestMapping(value = "/admin/trigger/updateTriggerApplStatus", method = RequestMethod.POST)
//	@ResponseBody
//	public String updateTriggerApplStatus(@RequestBody ApplicationStatus body) {
//		
//		log.info(body);
//		
//		String result = this.getRestTemplate().postForObject(
//				getRestfulServerUrl() + updateTriggerApplStatus,  
//				body, 
//				String.class, 
//				this.getIntranetID(),
//				this.getUserUid());
//		
//		return result;
//	}
	
	@RequestMapping(value = "/admin/trigger/updateDataloadtab/{action}", method = RequestMethod.POST)
	@ResponseBody
	public Map updateDataloadtab(@PathVariable String action, @RequestBody Loadtabs body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + updateDataloadtab,  
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid(),
				action);
		
		return result;
	}
	
	@RequestMapping(value = "/admin/trigger/deleteTriggerid", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteTriggerid(@RequestBody Triggerid body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + deleteTriggerid, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/admin/throttle/deleteCognosScheduleThrottle", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteCognosScheduleThrottle(@RequestBody CognosScheduleThrottlesPK body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + deleteCognosScheduleThrottle, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/admin/trigger/deleteDataloadtab", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteDataloadtab(@RequestBody Loadtabs body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + deleteDataloadtab, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/admin/trigger/deleteApplication", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteApplication(@RequestBody Eodtappl body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + deleteApplication, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/admin/trigger/deleteFederatedTrigger", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteFederatedTrigger(@RequestBody TrgrfeddPK body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + deleteFederatedTrigger, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/admin/trigger/getTriggeridTriggerTime", method = RequestMethod.POST)
	@ResponseBody
	public TriggeridStr getTriggeridTriggerTime(@RequestBody Triggerid body) {
		
		log.info(body);
		
		TriggeridStr resultMap = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + getTriggeridTriggerTime, 
				body, 
				TriggeridStr.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/trigger/updateTriggeridTriggerTime", method = RequestMethod.POST)
	@ResponseBody
	public Map updateTriggeridTriggerTime(@RequestBody TriggeridStr body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + updateTriggeridTriggerTime,  
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/admin/trigger/manageapplications", method = RequestMethod.GET)
	public ModelAndView showAdminApplicationListPanel() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/admin_applicationlist.jsp");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		return mav;
	}
	
	@RequestMapping(value = "/admin/throttle/managethrottles", method = RequestMethod.GET)
	public ModelAndView showAdminCognosScheduleThrottleListPanel() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/admin_cognosschedulethrottles.jsp");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		return mav;
	}
}
