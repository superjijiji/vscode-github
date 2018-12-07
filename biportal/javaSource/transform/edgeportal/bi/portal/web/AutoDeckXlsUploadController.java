package transform.edgeportal.bi.portal.web;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import transform.edgeportal.bi.portal.bs.UploadBean;

@Controller
public class AutoDeckXlsUploadController extends BaseController {

	private static final Logger	log	= Logger.getLogger(AutoDeckXlsUploadController.class);

	@Value("${getInitUploadBean}")
	private String				getInitUploadBean;

	@Value("${getMyXLSList}")
	private String				getMyXLS;

	@Value("${delXLSInput}")
	private String				delXLSInput;

	@Value("${extXLSInput}")
	private String				extXLSInput;

	@Value("${insertDataAfterUpload}")
	private String				insertDataAfterUpload;

	@Value("${updateDataAfterUpload}")
	private String				updateDataAfterUpload;

	public String getInitUploadBean_rest() {
		return getRestfulServerUrl() + getInitUploadBean;
	}

	public String getMyXLSList_rest() {
		return getRestfulServerUrl() + getMyXLS;
	}

	public String delXLSInput_rest() {
		return getRestfulServerUrl() + delXLSInput;
	}

	public String extXLSInput_rest() {
		return getRestfulServerUrl() + extXLSInput;
	}

	public String insertDataAfterUpload_rest() {
		return getRestfulServerUrl() + insertDataAfterUpload;
	}

	public String updateDataAfterUpload_rest() {
		return getRestfulServerUrl() + updateDataAfterUpload;
	}

	// for xls management panel
	@RequestMapping(value = "/portal/autodeck/xlsmanage/getXLSManagePage", method = RequestMethod.GET)
	public ModelAndView getXLSManagePage() {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/autodeck_xlsManagement.jsp");
		modelAndView.addObject("cwa_id", this.getIntranetID());
		modelAndView.addObject("uid", this.getUserUid());
		log.info(this.getIntranetID());
		log.info(this.getUserUid());
		return modelAndView;

	}

	// for init my xls list information
	@RequestMapping(value = "/portal/autodeck/xlsmanage/getXLSList/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getXLSList(@PathVariable String cwa_id, @PathVariable String uid) {
		log.info("this.getMyXLSList_rest()" + this.getMyXLSList_rest());
		return this.getRestTemplate().getForObject(this.getMyXLSList_rest(), List.class, cwa_id, uid);
	}

	// for delete my upload xls file
	@RequestMapping(value = "/portal/autodeck/xlsmanage/delXLSInput/{cwa_id}/{uid}/{requestIDs}", method = RequestMethod.GET)
	@ResponseBody
	public void delXLSInput(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String requestIDs) {
		log.info("this.delXLSInput_rest()" + this.delXLSInput_rest());
		this.getRestTemplate().getForObject(this.delXLSInput_rest(), List.class, cwa_id, uid, requestIDs);
	}

	// for extend my upload xls file
	@RequestMapping(value = "/portal/autodeck/xlsmanage/extXLSInput/{cwa_id}/{uid}/{requestIDs}", method = RequestMethod.GET)
	@ResponseBody
	public void extXLSInput(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String requestIDs) {
		log.info("this.extXLSInput_rest()" + this.extXLSInput_rest());
		this.getRestTemplate().getForObject(this.extXLSInput_rest(), List.class, cwa_id, uid, requestIDs);
	}

	@RequestMapping(value = "/portal/autodeck/xlsmanage/XLSUploadConfigurationOnly", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> uploadConfigurationOnly(@RequestBody Map<String, String> conf) {
		log.info(conf.get("request_id"));
		String request_id = conf.get("request_id");
		String cwaid = conf.get("cwaId");
		String uid = conf.get("uid");
		String fileDescription = conf.get("fileDescription");
		String original_FN = conf.get("original_FN");
		// String status = conf.get("status");
		return uploadNew(null, request_id, cwaid, uid, fileDescription, original_FN);
	}

	@RequestMapping(value = "/portal/autodeck/xlsmanage/XLSUpload", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public ResponseEntity<String> uploadNew(
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam("request_id") String request_id,
			@RequestParam("cwaId") String cwaid,
			@RequestParam("uid") String uid,
			@RequestParam("fileDescription") String fileDescription,
			@RequestParam("original_FN") String original_FN) {
		//
		log.info("cwaid:" + cwaid);
		log.info("uid:" + uid);
		boolean updateFile = true;
		boolean isNew = false;
		if (file == null || file.isEmpty()) {
			updateFile = false;
		}
		if ("new".equalsIgnoreCase(request_id)) {
			isNew = true;
		}
		UploadBean beanInfo = this.getRestTemplate().getForObject(
				this.getInitUploadBean_rest(),
				UploadBean.class,
				cwaid,
				uid);
		log.info("get repository is: " + beanInfo.getRepository());
		//
		// if(fileDescription==null||"".equals(fileDescription.trim())){
		// fileDescription = "no description";
		// }
		if (fileDescription != null && !"".equals(fileDescription.trim())) {
			fileDescription = fileDescription.replace('\r', ' ');
			fileDescription = fileDescription.replace('\n', ' ');
			fileDescription = fileDescription.trim();
		} else {
			fileDescription = "NoValue";
		}
		beanInfo.setFileDescription(fileDescription);
		//
		if (isNew) {
			request_id = this.generateNewID();
		}
		beanInfo.setRequest_id(request_id);
		//

		// String fileStatus = status;
		String fileStatus = "A";
		String returnMsg = "OK";
		String fileType = "";
		String fileNameWithoutExtension = "";
		if (updateFile) {
			fileType = this.getExtensionName(file.getOriginalFilename());
			fileNameWithoutExtension = this.getFileNameWithoutExtension(file.getOriginalFilename());
			//
			String repositoryFolder = beanInfo.getRepository() + beanInfo.getUid(); // formal code for server
			//
			File parent = new File(repositoryFolder);
			if (!parent.exists() || !parent.isDirectory()) {
				parent.mkdirs();
			}
			//
			if (!this.isValidFile(file)) {
				returnMsg = "File saved failed";
			}
			//
			String newFileName = beanInfo.getRequest_id() + "." + fileType;
			try {
				file.transferTo(new File(repositoryFolder + "/" + newFileName));
				fileStatus = "A";
				returnMsg = "OK";
			} catch (IllegalStateException e) {
				e.printStackTrace();
				returnMsg = "File saved failed";
			} catch (IOException e) {
				e.printStackTrace();
				returnMsg = "File saved failed";
			}
		} else {
			fileType = this.getExtensionName(original_FN);
			fileNameWithoutExtension = this.getFileNameWithoutExtension(original_FN);
		}
		//
		beanInfo.setFileStatus(fileStatus);
		beanInfo.setReturnMsg(returnMsg);
		beanInfo.setFileType(fileType);
		beanInfo.setFileNameWithoutExtensionName(fileNameWithoutExtension);
		//
		// String requestID = beanInfo.getRequest_id();
		//
		if (beanInfo.getReturnMsg().equals("OK")) {
			if (isNew) {
				this.getRestTemplate().getForObject(
						this.insertDataAfterUpload_rest(),
						String.class,
						cwaid,
						uid,
						request_id,
						fileNameWithoutExtension,
						fileDescription,
						fileType,
						fileStatus);
			} else {
				this.getRestTemplate().getForObject(
						this.updateDataAfterUpload_rest(),
						String.class,
						cwaid,
						uid,
						request_id,
						fileNameWithoutExtension,
						fileDescription,
						fileType,
						fileStatus);
			}
			return new ResponseEntity<String>("uploading is Successful", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>("uploading failed", HttpStatus.NOT_MODIFIED);
		}
	}

	private String generateNewID() {
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmssSSSSSS");
		String id = sf.format(new Date()) + String.format("%1$04d", Double.valueOf(Math.random() * 13000).intValue())
				+ String.format("%1$04d", Double.valueOf(Math.random() * 11000).intValue());
		return id;
	}

	private boolean isValidFile(MultipartFile file) {
		boolean result = false;
		String filename = file.getOriginalFilename();
		if (file == null || filename == "" || "".equals(filename.trim()) || file.getSize() == 0) {
			result = false;
		}

		if (filename.indexOf(".") == -1) {
			result = false;
		}
		String extensionName = filename.substring(filename.lastIndexOf("."), filename.length());
		if (".xls".equalsIgnoreCase(extensionName.trim()) || ".xlsx".equalsIgnoreCase(extensionName.trim())) {
			result = true;
		}
		return result;
	}

	private String getExtensionName(String fileNameInput) {// uploadexcel.xls
		String extensionName = fileNameInput.substring(fileNameInput.lastIndexOf(".") + 1, fileNameInput.length());
		return extensionName;
	}

	private String getFileNameWithoutExtension(String fileName) {
		String fileNameWithoutExtension = fileName.substring(0, fileName.lastIndexOf("."));
		return fileNameWithoutExtension;

	}
}
