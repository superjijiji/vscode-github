/**
 * 
 */
package transform.edgeportal.bi.portal.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import transform.edgeportal.bi.jpa.tbsjobstatus.TBSJobStatus;

/**
 * @author leo
 *
 */
@Controller
public class TBSJobStatusController extends BaseController {

	private static final Logger	log		= Logger.getLogger(TBSJobStatusController.class);

	private SimpleDateFormat	sdf		= new SimpleDateFormat("HH:mm:ss 'GMT on' MMM dd yyyy");
	private String				curTime	= "";

	@Value("${loadTBSJobStatus}")
	private String				loadTBSJobStatusURL;

	@Value("${refreshSingleTBSJobStatus}")
	private String				refreshSingleTBSJobStatusURL;

	@RequestMapping(value = "/portal/TBSJobStatus/openTBSJobStatusPage", method = RequestMethod.GET)
	public ModelAndView loadTBSJobStatus() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/TBSJobStatus.jsp");
		return mav;
	}

	@RequestMapping(value = "/portal/TBSJobStatus/loadTBSJobStatus", method = RequestMethod.GET)
	@ResponseBody
	public List<TBSJobStatus> loadCognosSchedule() {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + loadTBSJobStatusURL,
				List.class,
				this.getIntranetID(),
				this.getUserUid());
	}

	@RequestMapping(value = "/portal/TBSJobStatus/refreshSingleTBSJobStatus/{job_running_id}", method = RequestMethod.GET)
	@ResponseBody
	public Object refreshSingleTBSJobStatus(@PathVariable String job_running_id) {
		return this.getRestTemplate().getForObject(
				this.getRestfulServerUrl() + refreshSingleTBSJobStatusURL,
				Object.class,
				this.getIntranetID(),
				this.getUserUid(),
				job_running_id);
	}

	@ModelAttribute("curTime")
	private String getCurrentTime() {
		sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
		return curTime = sdf.format(new Date());

	}
}
