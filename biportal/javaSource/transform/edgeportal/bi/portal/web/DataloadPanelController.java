package transform.edgeportal.bi.portal.web;

import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DataloadPanelController extends BaseController {

	private static final Logger	log	= Logger.getLogger(DataloadPanelController.class);
	@Value("${getAllDataload}")
	private String				getAllDataload;

	@Value("${saveSbusForDataload}")
	private String				saveSbusForDataload;

	@Value("${getTabForDataload}")
	private String				getTabForDataload;

	@Value("${saveTabForDataload}")
	private String				saveTabForDataload;

	public String getAllDataloadRestService() {
		return getRestfulServerUrl() + getAllDataload;
	}

	public String saveSbusForDataloadRestService() {
		return getRestfulServerUrl() + saveSbusForDataload;
	}

	public String getTabForDataloadRestService() {
		return getRestfulServerUrl() + getTabForDataload;
	}

	public String saveTabForDataloadRestService() {
		return getRestfulServerUrl() + saveTabForDataload;
	}

	@RequestMapping(value = "/portal/dataload/getAllDataload/{update}", method = RequestMethod.GET)
	@ResponseBody
	public Map getAllDataload(@PathVariable String update) {
		return this.getRestTemplate().getForObject(
				this.getAllDataloadRestService(),
				Map.class,
				this.getIntranetID(),
				this.getUserUid(),
				update);
	}

	@RequestMapping(value = "/portal/dataload/getSubscribePage", method = RequestMethod.GET)
	public String getSubscribePage() {
		return "/WEB-INF/portal/dataloadSubscribe.jsp";
	}

	@RequestMapping(value = "/portal/dataload/saveDataloadSubscribes", method = RequestMethod.POST)
	@ResponseBody
	public void saveSubscribe(@RequestParam(value = "triggerCD", required = true) String triggerCD) {
		this.getRestTemplate().postForEntity(
				this.saveSbusForDataloadRestService(),
				null,
				String.class,
				this.getIntranetID(),
				this.getUserUid(),
				triggerCD);
	}

	@RequestMapping(value = "/portal/dataload/getTabPage", method = RequestMethod.GET)
	public String getTabPage() {
		return "/WEB-INF/portal/dataloadTab.jsp";
	}

	@RequestMapping(value = "/portal/dataload/getTab", method = RequestMethod.GET)
	@ResponseBody
	public List getAllDataload() {
		return this.getRestTemplate().getForObject(this.getTabForDataloadRestService(), List.class, this.getUserUid());
	}

	@RequestMapping(value = "/portal/dataload/saveDataloadTab", method = RequestMethod.POST)
	@ResponseBody
	public void saveDataloadTab(@RequestParam(value = "tabCD", required = true) String tabCD) {
		this.getRestTemplate().postForEntity(
				this.saveTabForDataloadRestService(),
				null,
				String.class,
				this.getUserUid(),
				tabCD);
	}
}
