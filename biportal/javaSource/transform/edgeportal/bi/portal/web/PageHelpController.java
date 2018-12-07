package transform.edgeportal.bi.portal.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PageHelpController extends BaseController {

	@RequestMapping(value = "/portal/pagehelp", method = RequestMethod.GET)
	public ModelAndView getHelp(@RequestParam String pageKey, @RequestParam String pageName) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/pageHelp.jsp");
		mav.addObject("pageKey", pageKey);
		mav.addObject("pageName", pageName);
		return mav;
	}

}
