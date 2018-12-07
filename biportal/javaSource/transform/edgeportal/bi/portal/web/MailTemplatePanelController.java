package transform.edgeportal.bi.portal.web;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import transform.edgeportal.bi.jpa.dataload.Template;
import transform.edgeportal.bi.jpa.dataload.TemplateType;
import transform.edgeportal.bi.jpa.dataload.TemplateValue;
import transform.edgeportal.bi.jpa.link.Link;

@Controller
public class MailTemplatePanelController extends BaseController {

	private static final Logger	log	= Logger.getLogger(MailTemplatePanelController.class);


	@Value("${link_getLink}")
	private String				getLink;

	@Value("${listMailTemplates}")
	private String				listMailTemplatesURL;
	
	@Value("${listMailTemplateTypes}")
	private String				listMailTemplateTypesURL;
	
	@Value("${getMailTemplate}")
	private String				getMailTemplateURL;
	
	@Value("${listMailTemplateValues}")
	private String				listMailTemplateValuesURL;
	
	@Value("${updateMailTemplate}")
	private String				updateMailTemplateURL;
	
	@Value("${insertMailTemplate}")
	private String				insertMailTemplateURL;
	
	@Value("${deleteMailTemplate}")
	private String				deleteMailTemplateURL;
	
	@Value("${setAsDefaultMailTemplate}")
	private String				setAsDefaultMailTemplateURL;

	public String getLink() {
		return getRestfulServerUrl() + getLink;
	}


	@RequestMapping(value = "/admin/mailTmpl/mailtemplatelist", method = RequestMethod.GET)
	public ModelAndView showMailTemplates() {
		String cwa_id = this.getIntranetID();
		String uid = this.getUserUid();

		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/messageAndDataloadTemplate_manage.jsp");
		modelAndView.addObject("cwa_id", cwa_id);
		modelAndView.addObject("uid", uid);

		return modelAndView;
	}

	@RequestMapping(value = "/portal/mailtemplate/listMailTemplates/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Template[] listMailTemplate(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate()
				.getForObject(getRestfulServerUrl() + listMailTemplatesURL, Template[].class, cwa_id, uid);
	}
	
	@RequestMapping(value = "/admin/mailTmpl/addMailTemplate", method = RequestMethod.GET)
	public ModelAndView addMailTemplate() {
		
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/messageAndDataloadTemplate_edit.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		return modelAndView;
		
	}
	
	@RequestMapping(value = "/admin/mailTmpl/editMailTemplate/{action}", method = RequestMethod.GET)
	public ModelAndView editMailTemplate(@PathVariable String action) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/messageAndDataloadTemplate_edit.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		modelAndView.addObject("action", action);
		
		Template mailTemplate = null;
		try {
			mailTemplate = this.getRestTemplate().getForObject(getRestfulServerUrl() + getMailTemplateURL, Template.class, action);
		} catch (Exception e) {
			log.error(e);
			modelAndView.addObject("error", "System error:" + e.getMessage());
			return modelAndView;
		}
		if (mailTemplate == null) {
			modelAndView.addObject("error", "Sorry, this mail template, "+action+", doesn't exist.");
			return modelAndView;
		}
		mailTemplate.setMailSubject(mailTemplate.getMailSubject().replaceAll("<br/>", "\r\n"));
		mailTemplate.setMailBody(mailTemplate.getMailBody().replaceAll("<br/>", "\r\n"));
		modelAndView.addObject("template", mailTemplate);

		return modelAndView;

	}
	
	@RequestMapping(value = "/portal/mailtemplate/listMailTemplateTypes/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public TemplateType[] listMailTemplateTypes(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate()
				.getForObject(getRestfulServerUrl() + listMailTemplateTypesURL, TemplateType[].class, cwa_id, uid);
	}
	
	@RequestMapping(value = "/portal/mailtemplate/listMailTemplateValues/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public TemplateValue[] listMailTemplateValues(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate()
				.getForObject(getRestfulServerUrl() + listMailTemplateValuesURL, TemplateValue[].class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/mailtemplate/updateMailTemplate/{templateName}/{templateId}", method = RequestMethod.POST)
	@ResponseBody
	public String updateMailTemplate(@PathVariable String templateName, @PathVariable String templateId, @RequestBody Object mt) {
		log.info("update template - " + mt);
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + updateMailTemplateURL, mt, String.class, templateName, templateId);
	}
	
	@RequestMapping(value = "/portal/mailtemplate/insertMailTemplate", method = RequestMethod.POST)
	@ResponseBody
	public String insertMailTemplate(@RequestBody Object mt) {
		log.info("insert template - " + mt);
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + insertMailTemplateURL, mt, String.class);
	}
	
	@RequestMapping(value = "/portal/mailtemplate/deleteMailTemplate", method = RequestMethod.POST)
	@ResponseBody
	public void deleteMailTemplate(@RequestBody String[] templateNames) {
		this.getRestTemplate().postForObject(getRestfulServerUrl() + deleteMailTemplateURL, templateNames, Object.class);
	}
	
	@RequestMapping(value = "/portal/mailtemplate/setAsDefaultMailTemplate", method = RequestMethod.POST)
	@ResponseBody
	public String setAsDefaultMailTemplate(@RequestBody String[] templateNames) {
		return this.getRestTemplate().postForObject(getRestfulServerUrl() + setAsDefaultMailTemplateURL, templateNames, String.class);
	}

}
