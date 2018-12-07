package transform.edgeportal.bi.portal.web;

import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SearchPanelController extends BaseController {

	@Value("${getDomains}")
	private String				domainsUrl;

	@Value("${searchDomain}")
	private String				searchDomainsUrl;

	@Value("${getSearchHistory}")
	private String				getsearchHistoryUrl;

	@Value("${saveSearchHistory}")
	private String				savesearchHistoryUrl;

	private static final Logger	log	= Logger.getLogger(SearchPanelController.class);

	@RequestMapping(value = "/portal/search/getDomains/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getDomains(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getRestfulServerUrl() + domainsUrl, List.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/search/openSearchView/{cwa_id}/{uid}/{domain_keys}/{keywords}/{page}/{page_row}", method = RequestMethod.GET)
	public ModelAndView openSearchView(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String domain_keys,
			@PathVariable String keywords,
			@PathVariable int page,
			@PathVariable int page_row) {

		log.info(cwa_id);
		log.info(uid);
		log.info(domain_keys);
		log.info(keywords);
		log.info(page);
		log.info(page_row);
		log.info(searchDomainsUrl);
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/reportSearchResults.jsp");
		mav.addObject("reportsearch_action", "openSearchView");
		mav.addObject("reportsearch_cwa_id", cwa_id);
		mav.addObject("reportsearch_uid", uid);
		mav.addObject("reportsearch_domain_keys", domain_keys);
		mav.addObject("reportsearch_keywords", keywords);
		mav.addObject("reportsearch_page", page);
		mav.addObject("reportsearch_page_row", page_row);
		return mav;
	}

	@RequestMapping(value = "/portal/search/searchDomain/{cwa_id}/{uid}/{domain_keys}/{keywords}/{page}/{page_row}", method = RequestMethod.GET)
	@ResponseBody
	public List searchDomain(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String domain_keys,
			@PathVariable String keywords,
			@PathVariable int page,
			@PathVariable int page_row) {

		log.info(cwa_id);
		log.info(uid);
		log.info(domain_keys);
		log.info(keywords);
		log.info(page);
		log.info(page_row);
		log.info(searchDomainsUrl);
		List domains = this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + searchDomainsUrl,
				List.class,
				cwa_id,
				uid,
				domain_keys,
				keywords,
				page,
				page_row);
		return domains;
	}

	@RequestMapping(value = "/portal/search/getSearchHistory/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getSearchHistory(@PathVariable String cwa_id, @PathVariable String uid) {
		List hostories = this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + getsearchHistoryUrl,
				List.class,
				cwa_id,
				uid);
		return hostories;
	}

	@RequestMapping(value = "/portal/search/saveSearchHistory", method = RequestMethod.POST)
	@ResponseBody
	public void saveSearchHistory(@RequestBody Map<String, String> body) {
		log.info(body);
		this.getRestTemplate().postForEntity(this.getRestfulServerUrl() + savesearchHistoryUrl, body, String.class);
	}

}
