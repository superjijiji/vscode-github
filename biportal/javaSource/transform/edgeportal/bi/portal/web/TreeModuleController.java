package transform.edgeportal.bi.portal.web;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TreeModuleController extends BaseController {

	// -------------------for accessing REST services in backend app, BIAPI
	@Value("${tree_workOnTree}")
	private String	apiEndpoint4Tree;

	public String apiEndpoint4Tree_rest() {
		return getRestfulServerUrl() + apiEndpoint4Tree;
	}

	@RequestMapping(value = "/portal/tree/{cwa_id}/{uid}/{module}", method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public Object retieveOneTree(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String module) {
		return this.getRestTemplate().getForObject(this.apiEndpoint4Tree_rest(), Object.class, cwa_id, uid, module);
	}

	@RequestMapping(value = "/portal/tree/{cwa_id}/{uid}/{module}", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public Object createOneTree(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String module,
			@RequestBody Object tree) {
		return this.getRestTemplate().postForObject(
				this.apiEndpoint4Tree_rest(),
				tree,
				Object.class,
				cwa_id,
				uid,
				module);
	}

	// -------------------for this UI app, BIPORTAL
	@RequestMapping(value = "/portal/tree/editFolders/{module}", method = RequestMethod.GET)
	public ModelAndView editFolders(
			@PathVariable String module,
			@RequestParam(required = true, defaultValue = "/transform/biportal") String backUrl) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/treeManagement.jsp");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		mav.addObject("module", module);
		mav.addObject("backUrl", backUrl);
		mav.addObject("ep_nodes", "/action/portal/tree/" + this.getIntranetID() + "/" + this.getUserUid() + "/" + module);
		if (module.trim().equalsIgnoreCase("myreport")) {
			mav.addObject("ep_entries", "/action/portal/myrpts/getMyfavRpts/" + this.getIntranetID() + "/" + this.getUserUid());
			mav.addObject("joinString", "domain_Key-rptObjID");
			mav.addObject("getKeys", "rptName");
			mav.addObject("err_from_backend", "");
			mav.addObject("moduleName", "My reports");
			mav.addObject("moduleHelpKey", "MyReportsFolderManagement");
		} else if (module.trim().equalsIgnoreCase("mytbs")) {
			mav.addObject("ep_entries", "/action/portal/mycognosschedulelist/getAllMyCognosSchedules/" + this.getIntranetID() + "/" + this.getUserUid() );
			mav.addObject("joinString", "tbsRequestId");  
			mav.addObject("getKeys", "tbsRptName-tbsEmailSubject-promptsComments");
			mav.addObject("err_from_backend", "");
			mav.addObject("moduleName", "My Cognos schedules");
			mav.addObject("moduleHelpKey", "MyCognosSchedulesFolderManagement");
		} else {
			System.out.println("error...right now cannot handle this module=" + module);
			mav.addObject("err_from_backend", "error...right now cannot handle this module=" + module);
		}
		return mav;
	}

}
