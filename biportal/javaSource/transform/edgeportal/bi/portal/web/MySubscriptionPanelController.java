package transform.edgeportal.bi.portal.web;

import java.util.List;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * 
 * ClassName: MySubscriptionPanelController <br/>
 * Description: This controller is used for My subscriptions panel. <br/>
 * Date: Jun 26, 2017 <br/>
 * 
 * @author yhqin
 */
@Controller
public class MySubscriptionPanelController extends BaseController {

	@Value("${getAllSubscribedBlobReport}")
	private String	getAllSubscribedBlobReport;

	@Value("${deleteSubscribedBlobReport}")
	private String	deleteSubscribedBlobReport;

	public String getAllSubscribedBlobReportRestService() {
		return getRestfulServerUrl() + getAllSubscribedBlobReport;
	}

	public String deleteSubscribedBlobReportRestService() {
		return getRestfulServerUrl() + deleteSubscribedBlobReport;
	}

	/**
	 * When call url /transform/biportal/action/portal/mysubscriptions, it will be redirect to mySubscriptions.jsp
	 * 
	 * @return My subscriptions panel
	 */
	@RequestMapping(value = "/portal/mysubscriptions", method = RequestMethod.GET)
	public ModelAndView showMySubscriptionsPanel() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/mySubscriptions.jsp");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		return mav;
	}

	/**
	 * Get all subscribed BLOB reports for user.
	 * 
	 * @param cwa_id
	 *            User intranet ID in IBM. For example, john@us.ibm.com
	 * @param uid
	 *            User ID/SN in IBM. For example, 123456672
	 * @return an array contains all subscribed BLOB reports for user.
	 */
	@RequestMapping(value = "/portal/mysubscription/loadSubBlobReport/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List loadSubBlobReport(@PathVariable String cwa_id, @PathVariable String uid) {

		return this.getRestTemplate().getForObject(
				this.getAllSubscribedBlobReportRestService(),
				List.class,
				cwa_id,
				uid);
	}

	/**
	 * Remove from My subscriptions.
	 * 
	 * @param report
	 *            a report user want to un-subscribed.
	 */
	@RequestMapping(value = "/portal/mysubscription/deleteSubBlobReport", method = RequestMethod.POST)
	@ResponseBody
	public void deleteSubBlobReport(@RequestBody BIReportBean report) {
		this.getRestTemplate().postForEntity(this.deleteSubscribedBlobReportRestService(), report, BIReportBean.class);
	}
}
