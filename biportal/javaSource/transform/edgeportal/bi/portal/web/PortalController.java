package transform.edgeportal.bi.portal.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PortalController extends BaseController {

	@RequestMapping("/portal/index")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/index.jsp");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		return mav;
	}

}
