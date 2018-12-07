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
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

/**
 * 
 * ClassName: AutoCogUnsubscribeController <br/>
 * Description: The controller of autodeck and cognos schedule unsubscribe panel UI <br/>
 * Date: Jun 26, 2017 <br/>
 * 
 * @author ludi
 */
@Controller
public class AutoCogUnsubscribeController extends BaseController {

	private static final Logger	log	= Logger.getLogger(AutoCogUnsubscribeController.class);

	@Value("${getUnsubscribeList}")
	private String				getUnsubscribeList;

	@Value("${delUnsubscribe}")
	private String				delUnsubscribe;
	
	@Value("${doUnsubscribe}")
	private String doUnsubscribeURL;

	public String getUnsubscribeList_rest() {
		return getRestfulServerUrl() + getUnsubscribeList;
	}

	public String delUnsubscribe_rest() {
		return getRestfulServerUrl() + delUnsubscribe;
	}

	// for unsubscribe panel
	@RequestMapping(value = "/portal/autodeck/unsubmanage/unsubscribePanel/{request_id}/{report_type}", method = RequestMethod.GET)
	public ModelAndView getUnsubscribePage(@PathVariable String request_id, @PathVariable String report_type) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/auto_cognos_unsubscribe.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		modelAndView.addObject("request_id", request_id);
		modelAndView.addObject("report_type", report_type);
		log.info(this.getIntranetID());
		log.info(this.getUserUid());
		return modelAndView;

	}

	// for init unsubscribe list information
	@RequestMapping(value = "/portal/autodeck/unsubmanage/getUnsubscribeList/{cwa_id}/{uid}/{request_id}/{report_type}", method = RequestMethod.GET)
	@ResponseBody
	public List getUnsubscribeList(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String request_id,
			@PathVariable String report_type) {
		log.info("this.getUnsubscribeList_rest()" + this.getUnsubscribeList_rest());
		return this.getRestTemplate()
				.getForObject(this.getUnsubscribeList_rest(), List.class, cwa_id, uid, request_id, report_type);
	}

	// for delete unsubscribe
	@RequestMapping(value = "/portal/autodeck/unsubmanage/delUnsubscribeList", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.OK)
	public ResponseEntity<String> delUnsubscribe(@RequestBody List<Map<String, String>> confList) {
		log.info("this.delUnsubscribe_rest()" + this.delUnsubscribe_rest());
		int size = confList.size();
		Map<String, String> conf = null;
		if (size > 0) {
			for (int i = 0; i < size; i++) {
				conf = confList.get(i);

				ResponseEntity<String> rtn = this.getRestTemplate().exchange(
						this.delUnsubscribe_rest(),
						HttpMethod.DELETE,
						new HttpEntity<Map>(conf),
						String.class);
				log.info("i= " + i + " rtn: " + rtn);
				if (rtn.getStatusCodeValue() != 200) {
					return new ResponseEntity<String>("delete failed", HttpStatus.NOT_MODIFIED);
				} else {
					if (i == size - 1) {
						return new ResponseEntity<String>("delete is Successful", HttpStatus.OK);
					}
				}

			}
		}
		return new ResponseEntity<String>("delete is Successful for no record to process", HttpStatus.OK);
	}

	// add by leo for autodeck/cognos mail unsubscribe
	@RequestMapping(value = "/portal/mail/doUnsubscribePage/{request_id}/{report_type}", method = RequestMethod.GET)
	public ModelAndView doUnsubscribePage(@PathVariable String request_id, @PathVariable String report_type) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/mail_unsubscribe.jsp");
		modelAndView.addObject("request_id", request_id);
		modelAndView.addObject("report_type", report_type);
		return modelAndView;

	}
	
	@RequestMapping(value = "/portal/mail/doUnsubscribe/{request_id}/{report_type}", method = RequestMethod.GET)
	@ResponseBody
	public String doUnsubscribe(@PathVariable String request_id, @PathVariable String report_type) {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + doUnsubscribeURL,
				String.class,
				this.getIntranetID(),
				this.getUserUid(),
				request_id,
				report_type);
	}
	
	
}
