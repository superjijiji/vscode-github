
/**
 * Project Name: biportal
 * File Name: transform.edgeportal.bi.portal.web.TbsConfigSettingsController.java
 * Date: Jul 10, 2017
 * 
 * @author wuxin
 *         Copyright(c) 2017, IBM BI@IBM All Rights Reserved.
 */
package transform.edgeportal.bi.portal.web;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import transform.edgeportal.bi.pojo.TBSConfigSettings;

/**
 * ClassName: TbsConfigSettingsController <br/>
 * Description: TODO <br/>
 * Date: Jul 10, 2017 <br/>
 * 
 * @author wuxin
 */
@Controller
public class TbsConfigSettingsController extends BaseController {

	private static final Logger	log	= Logger.getLogger(AutoDeckPanelController.class);

	@Value("${getTbsConfigSettings}")
	private String				getTbsConfigSettings;

	public String getTbsConfigSettings() {
		return getRestfulServerUrl() + getTbsConfigSettings;
	}

	@RequestMapping(value = "/portal/tbsconfigsettings", method = RequestMethod.GET)
	public Object autodeckEntry() {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/tbsConfigSettings.jsp");
		return modelAndView;
	}

	@RequestMapping(value = "/portal/tbsconfigsettings/service/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public TBSConfigSettings getDeckList(@PathVariable String cwa_id, @PathVariable String uid) {
		try {
			return this.getRestTemplate()
					.getForObject(this.getTbsConfigSettings(), TBSConfigSettings.class, cwa_id, uid);
		} catch (Exception e) {
			log.error(e);
			return null;
		}

	}
}
