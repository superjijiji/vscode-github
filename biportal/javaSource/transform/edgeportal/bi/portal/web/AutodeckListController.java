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

/**
 * for the deck list page
 * 
 * @author Walter, first created on Jan 26, 2018
 */
@Controller
public class AutodeckListController extends BaseController {

	private static final Logger	log	= Logger.getLogger(AutodeckListController.class);
	
	// -----------------------------------------------------------------------------------------------	
	/** 
	 * @return JSP to show a web page to end users
	 */
	@RequestMapping(value = "/portal/autodeck", method = RequestMethod.GET)
	public ModelAndView showMyCognosSchedulesList() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/autodeck_list.jsp");
		mav.addObject("cwa_id", 	this.getIntranetID());
		mav.addObject("uid", 	this.getUserUid());
		return mav;
	}	
	
	// -----------------------------------------------------------------------------------------------	
	@Value("${autodecklist_batch}")
	private String batch_str;

	@RequestMapping(value = "/portal/autodecklist/batch/{cwa_id}/{uid}", method = RequestMethod.POST)
	@ResponseBody
	public List<?> batch_web(
			@PathVariable String cwa_id, 
			@PathVariable String uid, 
			HttpServletRequest req, 
			@RequestBody String[] listOfRequestIds) {   
		
		StringBuffer param = new StringBuffer(getRestfulServerUrl() + batch_str + "?"); 
		Enumeration<String> em = req.getParameterNames();
		String name = null; 
		while (em.hasMoreElements()) {
		    name = (String) em.nextElement();
		    param.append("&"+name+"="+req.getParameter(name)); 
		}
		
		return getRestTemplate().postForObject(
				param.toString(),
				listOfRequestIds,
				List.class,
				cwa_id,
				uid);	
	}	
	
	// -----------------------------------------------------------------------------------------------	
	@Value("${autodecklist_getAutodeckList}")
	private String getAutodeckList_str;

	@RequestMapping(value = "/portal/autodecklist/getAutodeckList/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List<?> getAutodeckList_web(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + getAutodeckList_str, List.class, cwa_id, uid);
	}
	
	@Value("${autodecklist_getAutodeckListAndAssociatedSchedules}")
	private String getAutodeckListAndAssociatedSchedules_str;

	@RequestMapping(value = "/portal/autodecklist/getAutodeckListAndAssociatedSchedules/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List<?> getAutodeckListAndAssociatedSchedules_web(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + getAutodeckListAndAssociatedSchedules_str, List.class, cwa_id, uid);
	}

	@Value("${autodecklist_getThedeckAndItsSchedules}")
	private String getThedeckAndItsSchedules_str;

	@RequestMapping(value = "/portal/autodecklist/getThedeckAndItsSchedules/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Map<?, ?> getThedeckAndItsSchedules_web(@PathVariable String cwa_id, @PathVariable String uid, @RequestParam String deckId) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + getThedeckAndItsSchedules_str, Map.class, cwa_id, uid, deckId);
	}

}
