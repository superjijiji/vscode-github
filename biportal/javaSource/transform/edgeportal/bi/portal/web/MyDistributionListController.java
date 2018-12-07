package transform.edgeportal.bi.portal.web;

import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * 
 * ClassName: MyDistributionListController <br/>
 * Description: The controller of my distribution lists panel UI <br/>
 * Date: Jun 26, 2017 <br/>
 * 
 * @author ludi
 */
@Controller
public class MyDistributionListController extends BaseController {

	private static final Logger	log	= Logger.getLogger(MyDistributionListController.class);

	@Value("${getMyDistList}")
	private String				getMyDistList;

	@Value("${creMyDistList}")
	private String				creMyDistList;

	@Value("${updMyDistList}")
	private String				updMyDistList;

	@Value("${delMyDistList}")
	private String				delMyDistList;

	public String getMyDistList_rest() {
		return getRestfulServerUrl() + getMyDistList;
	}

	public String creMyDistList_rest() {
		return getRestfulServerUrl() + creMyDistList;
	}

	public String updMyDistList_rest() {
		return getRestfulServerUrl() + updMyDistList;
	}

	public String delMyDistList_rest() {
		return getRestfulServerUrl() + delMyDistList;
	}

	// for my distribution list page
	@RequestMapping(value = "/portal/mydistlist/distmanage/getMyDistListPage", method = RequestMethod.GET)
	public ModelAndView getMyDistListPage() {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/myDistributionList.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		log.info(this.getIntranetID());
		log.info(this.getUserUid());
		return modelAndView;

	}

	// for retrieve my dist list information
	@RequestMapping(value = "/portal/mydistlist/getMyDistList/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getMyDistList(@PathVariable String cwa_id, @PathVariable String uid) {
		log.info("this.getMyDistList_rest()" + this.getMyDistList_rest());
		return this.getRestTemplate().getForObject(this.getMyDistList_rest(), List.class, cwa_id, uid);
	}

	// for create a dist list information
	@RequestMapping(value = "/portal/mydistlist/createMyDistList", method = RequestMethod.POST)
	@ResponseBody
	public String creMyDistList(@RequestBody Map<String, String> newDistInfor) {
		log.info("this.creMyDistList_rest()" + this.creMyDistList_rest());

		return this.getRestTemplate().postForObject(this.creMyDistList_rest(), newDistInfor, String.class);
	}

	// for update a dist list information
	@RequestMapping(value = "/portal/mydistlist/updateMyDistList", method = RequestMethod.POST)
	@ResponseBody
	public String updMyDistList(@RequestBody Map<String, String> updDistInfor) {
		log.info("this.updMyDistList_rest()" + this.updMyDistList_rest());
		return this.getRestTemplate().postForObject(this.updMyDistList_rest(), updDistInfor, String.class);
	}

	// for delete my dist list
	@RequestMapping(value = "/portal/mydistlist/deleteMyDistList", method = RequestMethod.DELETE)
	@ResponseBody
	public ResponseEntity<String> delMyDistList(@RequestBody List<Map<String, String>> distConfList) {
		log.info("this.delMyDistList_rest()" + this.delMyDistList_rest());

		ResponseEntity<String> rtn = this.getRestTemplate().exchange(
				this.delMyDistList_rest(),
				HttpMethod.DELETE,
				new HttpEntity<List<Map<String, String>>>(distConfList),
				String.class);

		if (rtn.getStatusCodeValue() != 200) {
			return new ResponseEntity<String>("delete failed", HttpStatus.NOT_MODIFIED);
		} else {
			return new ResponseEntity<String>("delete is Successful", HttpStatus.OK);
		}

	}

}
