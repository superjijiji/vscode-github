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

import transform.edgeportal.bi.jpa.trigger.SchtevntPK;
import transform.edgeportal.bi.portal.bs.ButtonAccess;

@Controller
public class BusinessEventPanelController extends BaseController {

	private static final Logger	log	= Logger.getLogger(BusinessEventPanelController.class);
	
	@Value("${getBusinessEventShowAll}")
	private String	getBusinessEventShowAll;
	
	@Value("${getBusinessEventNew}")
	private String	getBusinessEventNew;
	
	@Value("${getBusinessEventEdit}")
	private String	getBusinessEventEdit;
	
	@Value("${updateBusinessEvent}")
	private String	updateBusinessEvent;
	
	@Value("${deleteBusinessEvent}")
	private String	deleteBusinessEvent;
	
	@RequestMapping(value = "/admin/busievent/getBusinessEventAll/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getBusinessEventAll(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List businessEventList = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getBusinessEventShowAll, 
				List.class,
				cwa_id,
				uid);
		
		return businessEventList;
	}
	
	@RequestMapping(value = "/admin/busievent/getBusinessEventInit/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Map getBusinessEventInit(@PathVariable String cwa_id, @PathVariable String uid, HttpServletRequest request) {
		
		List businessEventList = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getBusinessEventShowAll, 
				List.class,
				cwa_id,
				uid);
		
		List<ButtonAccess> buttonAccessList = this.checkPanelButtonAccess(request, "busievent", cwa_id);
				
		Map resultMap = new HashMap<>();
		resultMap.put("businessEventList", businessEventList);
		resultMap.put("buttonAccessList", buttonAccessList);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/busievent/getBusinessEventNew/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getBusinessEventNew(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List resultList = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + getBusinessEventNew, 
				List.class,
				cwa_id,
				uid);
		
		return resultList;
	}
	
	@RequestMapping(value = "/admin/busievent/getBusinessEventEdit", method = RequestMethod.POST)
	@ResponseBody
	public Map getBusinessEventEdit(@RequestBody SchtevntPK body) {
		
		log.info(body);
		
		Map resultMap = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + getBusinessEventEdit, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/busievent/updateBusinessEvent/{action}", method = RequestMethod.POST)
	@ResponseBody
	public Map updateBusinessEvent(@PathVariable String action, @RequestBody Object body) {
		
		log.info(body);
		
		Map resultMap = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + updateBusinessEvent,  
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid(),
				action);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/busievent/deleteBusinessEvent", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteBusinessEvent(@RequestBody SchtevntPK body) {
		
		log.info(body);
		
		Map resultMap = this.getRestTemplate().postForObject(
				getRestfulServerUrl() + deleteBusinessEvent, 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return resultMap;
	}
	
	@RequestMapping(value = "/admin/busievent/managebusinessevents", method = RequestMethod.GET)
	public ModelAndView showAdminBusinessEventListPanel() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/admin_businessevent.jsp");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		return mav;
	}
}
