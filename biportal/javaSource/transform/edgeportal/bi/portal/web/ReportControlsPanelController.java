package transform.edgeportal.bi.portal.web;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
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

import transform.edgeportal.bi.jpa.link.Link;

@Controller
public class ReportControlsPanelController extends BaseController {

	//--------------------------------we shall have separate controllers for different UI components, but they are too simple, so all are here. 
	private static final Logger	log	= Logger.getLogger(ReportControlsPanelController.class);
	
	public static final String URL_BASE    ="/admin/linkAdmin"; 
	public static final String URL_LIST     ="/listPage"; 
	public static final String URL_FOLDER   ="/folderPage"; 
	public static final String URL_ALL_LINK ="/getAllLinks"; 

	@Value("${link_getAllLinksForOneEndUser}")
	private String				str_getAllLinksForOneEndUser;
	
	@Value("${link_adminPanel}")
	private String				str_admin;	
	//--------------------------------public link list, for the portal front page, everyone can see what he should see
	@RequestMapping(value = "/portal/link/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public List getAllLinksForOneEndUser(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + str_getAllLinksForOneEndUser, List.class, cwa_id, uid);
	}
	//--------------------------------admin	
	@RequestMapping(value = URL_BASE+URL_LIST, method = RequestMethod.GET)
	public ModelAndView adminLinkPageList() { 	
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/reportControls_adminLinkList.jsp");
		mav.addObject("cwa_id", 		this.getIntranetID());
		mav.addObject("uid", 		this.getUserUid());
		mav.addObject("baseUrl", 	"/action"+URL_BASE);
		mav.addObject("listUrl", 	URL_LIST);
		mav.addObject("folderUrl", 	URL_FOLDER);
		return mav;
	}		
	
	@RequestMapping(value = URL_BASE+URL_FOLDER, method = RequestMethod.GET)
	public ModelAndView adminLinkPageFolder(@RequestParam String backUrl) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/treeManagement.jsp");
		mav.addObject("cwa_id",	"fakecwa");
		mav.addObject("uid", 	"syslink");
		mav.addObject("module", 	"link");
		mav.addObject("backUrl", backUrl);
		mav.addObject("ep_nodes", "/action/portal/tree/fakecwa/syslink/link");

			mav.addObject("ep_entries", "/action"+URL_BASE+URL_ALL_LINK);
			mav.addObject("joinString", "id");  
			mav.addObject("getKeys", "name");
			mav.addObject("err_from_backend", "");
			mav.addObject("moduleName", "Manage portal links");
			mav.addObject("moduleHelpKey", "LinkFolderManagement");

		return mav;
	}	
	
	//--------------------------------REST duplication to return list directly for the folder management page
	@RequestMapping(value = URL_BASE+URL_ALL_LINK, method = RequestMethod.GET)
	@ResponseBody
	public List adminLinkPageFolderGetAllLinks() {
		return this.getRestTemplate().getForObject(getRestfulServerUrl() + str_admin, List.class);
	}		
 
	//--------------------------------REST CRUD
	@RequestMapping(value = URL_BASE, method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> adminLinkActionCreateOne(@RequestBody Link link) {
		HashMap<String,Object> result = new HashMap<String,Object>(); 
		try {
			result.put("link", this.getRestTemplate().postForObject(getRestfulServerUrl() + str_admin, link, Link.class));
			result.put("msg", "success"); 
		} catch (Exception e) {
			result.put("msg", e.getMessage()); 
		}
		return result; 
	}		

	@RequestMapping(value = URL_BASE, method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String,Object> adminLinkActionRetrieveAll() {
		HashMap<String,Object> result = new HashMap<String,Object>(); 
		try {
			result.put("links", this.getRestTemplate().getForObject(getRestfulServerUrl() + str_admin, List.class));
			result.put("msg", "success"); 
		} catch (Exception e) {
			result.put("msg", e.getMessage()); 
		}
		return result; 
	}		

	@RequestMapping(value = URL_BASE+"/{id}", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> adminLinkActionUpdateOne(@RequestBody Link link, @PathVariable String id) {
		HashMap<String,Object> result = new HashMap<String,Object>(); 
		try {
			result.put("link", this.getRestTemplate().postForObject(getRestfulServerUrl() + str_admin+"/"+id, link, Link.class));
			result.put("msg", "success"); 
		} catch (Exception e) {
			result.put("msg", e.getMessage()); 
		}
		return result; 
	}	
	
	@RequestMapping(value = URL_BASE+"/{id}", method = RequestMethod.DELETE)
	@ResponseBody
	public HashMap<String,Object> adminLinkActionDeleteOne(@PathVariable String id) {
		HashMap<String,Object> result = new HashMap<String,Object>(); 
		try {
			this.getRestTemplate().delete(getRestfulServerUrl() + str_admin+"/"+id);
			result.put("msg", "success"); 
		} catch (Exception e) {
			result.put("msg", e.getMessage()); 
		}
		return result; 
	}		
}
