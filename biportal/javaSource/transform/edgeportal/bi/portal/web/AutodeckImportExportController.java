package transform.edgeportal.bi.portal.web;

import java.io.File;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;


import transform.edgeportal.bi.portal.bs.AutodeckImportTemplateServlet;

@Controller
public class AutodeckImportExportController extends BaseController {
	private static Logger log = Logger.getLogger(BaseController.class);
	@Value("${autodeck_edit_saveDeck}")
	private String	saveDeckURL;

	@Value("${autodeck_edit_showPreview}")
	private String	showPreviewURL;
	@Value("${autodeck_edit_createPreview}")
	private String	createPreviewURL;
	@Value("${autodeck_edit_getDeck}")
	private String	getEditdeckbyId;

	public String editLoadbyId_rest() {
		return getRestfulServerUrl() + getEditdeckbyId;
	}

	@RequestMapping(value = "/portal/autodeck/edit/getAutodeck/{deck_id}", method = RequestMethod.GET)
	// @RequestMapping(value =
	// "/portal/allreports/getCognosMyReports/{domain_key}", method =
	// RequestMethod.GET)
	public ModelAndView getDeck(@PathVariable String deck_id) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/autodeck_edit.jsp");
		// modelAndView.addObject("folder_id", folder_id);
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		modelAndView.addObject("deck_id", deck_id);
		modelAndView.addObject("rest_url", getRestfulServerUrl());
		return modelAndView;

	}

	@RequestMapping(value = "/portal/autodeck/edit/import", method = RequestMethod.GET)
	// @RequestMapping(value =
	// "/portal/allreports/getCognosMyReports/{domain_key}", method =
	// RequestMethod.GET)
	public ModelAndView importtemplate() {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/autodeck_import.jsp");
		// modelAndView.addObject("folder_id", folder_id);
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());

		return modelAndView;

	}

	// for autodeck edit load deck rest api
	@RequestMapping(value = "/portal/autodeck/edit/loaddeck/{cwa_id}/{uid}/{deck_id}", method = RequestMethod.GET)
	@ResponseBody
	public Object getEditDeckById(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String deck_id) {
		//System.out.println("this.getCognosMy_rest()");
		Object a = this.getRestTemplate().getForObject(this.editLoadbyId_rest(), Object.class, cwa_id, uid, deck_id);
		return a;
	}

	@RequestMapping(value = "/portal/autodeck/edit/createpreview", method = RequestMethod.POST)
	@ResponseBody
	public Object createPreview(@RequestBody Object preview) {

		return this.getRestTemplate().postForObject(
				this.getRestfulServerUrl() + createPreviewURL,
				preview,
				Object.class);
	}

	@RequestMapping(value = "/portal/autodeck/edit/showpreview", method = RequestMethod.POST)
	@ResponseBody
	public Object showPreview(@RequestBody Object preview) {

		return this.getRestTemplate().postForObject(this.getRestfulServerUrl() + showPreviewURL, preview, Object.class);
	}

	@RequestMapping(value = "/portal/autodeck/edit/savedeck", method = RequestMethod.POST)
	@ResponseBody
	public Object saveDeck(@RequestBody Object deck) {

		return this.getRestTemplate().postForObject(this.getRestfulServerUrl() + saveDeckURL, deck, Object.class);
	}

	@RequestMapping(value = "/portal/uploadtest/{domain_key}", method = RequestMethod.GET)
	// @RequestMapping(value =
	// "/portal/allreports/getCognosMyReports/{domain_key}", method =
	// RequestMethod.GET)
	public ModelAndView getAllReportsCognos(@PathVariable String domain_key) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/UploadFile.jsp");
		// modelAndView.addObject("folder_id", folder_id);
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());

		return modelAndView;

	}

	@RequestMapping(value = "/portal/autodeck/edit/importtemplate", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String uploadNew(
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam("output_type") String output_type) {
	
		String path = file.getOriginalFilename();

		if (file.getSize() > 5 * 1024 * 1024) {
               
			log.error("size too big to import :"+file.getName());
		}

		// File newFile=new File(path);

		DiskFileItem fi = (DiskFileItem) ((CommonsMultipartFile) file).getFileItem();
		File newFile = fi.getStoreLocation();
		AutodeckImportTemplateServlet importTool = new AutodeckImportTemplateServlet();
		String json = importTool.processImportFile(newFile, output_type);
		return json;

	}

	@RequestMapping(value = "/portal/autodeck/edit/getdeck/{deck_id}/{output_type}", method = RequestMethod.GET)
	@ResponseBody
	public Object exportDeck(@PathVariable String deck_id, @PathVariable String output_type) {
		//System.out.println("this.getCognosMy_rest()");
		Object a = this.getRestTemplate().getForObject(this.editLoadbyId_rest(), Object.class, deck_id, output_type);
		// this.getRestTemplate().getForEntity(url, responseType)
		return a;
	}

	@RequestMapping(value = "/portal/autodeck/export/{deckid}", method = RequestMethod.GET)
	// @RequestMapping(value =
	// "/portal/allreports/getCognosMyReports/{domain_key}", method =
	// RequestMethod.GET)
	public ModelAndView getExportConfig(@PathVariable String deckid) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/UploadFile.jsp");
		// modelAndView.addObject("folder_id", folder_id);
		// call rest service get the object,then generate the file
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());

		return modelAndView;

	}

}
