package transform.edgeportal.bi.portal.web;

import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import transform.edgeportal.bi.portal.bs.UploadBean;

/**
 * 
 * ClassName: AutoDeckPanelController <br/>
 * Description: TODO <br/>
 * Date: Jun 20, 2017 <br/>
 * 
 * @author Simon/Mandy/LuDi/MengMin
 */
@Controller
// @RequestMapping(value = "fileOperate") // for testing
public class AutoDeckPanelController extends BaseController {

	private static final Logger	log	= Logger.getLogger(AutoDeckPanelController.class);

	@Value("${getInitUploadBean}")
	private String				getInitUploadBean;

	public String getInitUploadBean_rest() {
		return getRestfulServerUrl() + getInitUploadBean;
	}

	@Value("${getAutofileTemplatesList}")
	private String	getAutofileTemplatesList;

	public String getAutofileTemplates_rest() {
		return getRestfulServerUrl() + getAutofileTemplatesList;
	}

	@Value("${getAutofilePptPastetypesList}")
	private String	getAutofilePptPastetypesList;

	public String getAutofilePptPastetypes_rest() {
		return getRestfulServerUrl() + getAutofilePptPastetypesList;
	}

	@Value("${getAutofileAppendfilesList}")
	private String	getAutofileAppendfilesList;

	public String getAutofileAppendfiles_rest() {
		return getRestfulServerUrl() + getAutofileAppendfilesList;
	}

	@Value("${getAutofileUploadsList}")
	private String	getAutofileUploadsList;

	public String getAutofileUploadsList_rest() {
		return getRestfulServerUrl() + getAutofileUploadsList;
	}

	@Value("${loadScheduledRequestsList}")
	private String	loadScheduledRequestsList;

	public String loadScheduledRequestsList_rest() {
		return getRestfulServerUrl() + loadScheduledRequestsList;
	}

	@Value("${loadTBSList}")
	private String	loadTBSList;

	public String loadTBSList_rest() {
		return getRestfulServerUrl() + loadTBSList;
	}

	@Value("${loadTBSSetAsFinalList}")
	private String	loadTBSSetAsFinalList;

	public String loadTBSSetAsFinalList_rest() {
		return getRestfulServerUrl() + loadTBSSetAsFinalList;
	}

	@Value("${saveAutodeck}")
	private String	saveAutodeckURL;

	public String getSaveAutodeck_rest() {
		return getRestfulServerUrl() + saveAutodeckURL;
	}


	@RequestMapping(value = "/autodeck/initUploadInfo/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Object getInitUploadInfo(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getInitUploadBean_rest(), UploadBean.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/autodeck/getAutofileTemplates/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getAutofileTemplates(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getAutofileTemplates_rest(), List.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/autodeck/getAutofilePptPastetypes/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getAutofilePptPastetypes(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getAutofilePptPastetypes_rest(), List.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/autodeck/getAutofileAppendfiles/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getAutofileAppendfiles(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getAutofileAppendfiles_rest(), List.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/autodeck/getAutofileUploads/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getAutofileUploads(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getAutofileUploadsList_rest(), List.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/autodeck/loadScheduledRequestsList/{cwa_id}/{backup_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Object loadScheduledRequestsList(
			@PathVariable String cwa_id,
			@PathVariable String backup_id,
			@PathVariable String uid) {
		return this.getRestTemplate().getForObject(
				this.loadScheduledRequestsList_rest(),
				Object.class,
				cwa_id,
				backup_id,
				uid);
	}

	@RequestMapping(value = "/portal/autodeck/loadTBSList/{cwa_id}/{uid}/{deck_id}", method = RequestMethod.GET)
	@ResponseBody
	public Object loadTBSList(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String deck_id) {
		return this.getRestTemplate().getForObject(this.loadTBSList_rest(), Object.class, cwa_id, uid, deck_id);
	}

	@RequestMapping(value = "/portal/autodeck/loadTBSSetAsFinalList/{cwa_id}/{uid}/{deck_id}", method = RequestMethod.GET)
	@ResponseBody
	public Object loadTBSSetAsFinalList(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String deck_id) {
		return this.getRestTemplate().getForObject(
				this.loadTBSSetAsFinalList_rest(),
				Object.class,
				cwa_id,
				uid,
				deck_id);
	}

	@RequestMapping(value = "/portal/autodeck/createAutodeck", method = RequestMethod.GET)
	public Object createAutodeck() {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/autodeck_create.jsp");
		// modelAndView.addObject("cwa_id", this.getIntranetID());
		// modelAndView.addObject("uid", this.getUserUid());
		return modelAndView;
	}

	@RequestMapping(value = "/portal/autodeck/autodeckTBSStatus/{deck_id}", method = RequestMethod.GET)
	public Object autodeckTBSStatus(@PathVariable String deck_id) {
		log.info("TBS Status - " + deck_id);
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/autodeck_TBSStatus.jsp");
		modelAndView.addObject("deck_id", deck_id);
		return modelAndView;
	}

	@RequestMapping(value = "/portal/autodeck/saveAutodeck", method = RequestMethod.POST)
	@ResponseBody
	public Object saveAutodeck(@RequestBody Object ad) {
		log.info("save autodeck - " + ad);
		return this.getRestTemplate().postForObject(this.getSaveAutodeck_rest(), ad, Object.class);
	}

	private String generateNewID() {
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmssSSSSSS");
		String id = sf.format(new Date()) + String.format("%1$04d", Double.valueOf(Math.random() * 13000).intValue())
				+ String.format("%1$04d", Double.valueOf(Math.random() * 11000).intValue());
		return id;
	}

	private boolean isValidFile(MultipartFile file) {
		// TODO Auto-generated method stub
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

	private String getfileNameWithoutExtensionName(String fileNameInput) {
		String fileName = fileNameInput.substring(0, fileNameInput.lastIndexOf("."));
		return fileName;
	}

	private String getExtensionName(String fileNameInput) {// uploadexcel.xls
		String extensionName = fileNameInput.substring(fileNameInput.lastIndexOf(".") + 1, fileNameInput.length());
		return extensionName;
	}

	private static String formatFileSize(long fileS) {
		DecimalFormat df = new DecimalFormat("#.00");
		String fileSizeString = "";
		if (fileS < 1024) {
			fileSizeString = df.format((double) fileS) + "B";
		} else if (fileS < 1048576) {
			fileSizeString = df.format((double) fileS / 1024) + "K";
		} else if (fileS < 1073741824) {
			fileSizeString = df.format((double) fileS / 1048576) + "M";
		} else {
			fileSizeString = df.format((double) fileS / 1073741824) + "G";
		}
		return fileSizeString;
	}

	/**
	 * delete the file or directory that under the specified directory which
	 * conform to specified <param>pattern</param>
	 * 
	 * @param path
	 *            the specified directory
	 * @param pattern
	 *            the target file or directory that will be deleted such as:
	 *            2013092315183000005043995065.xls, \\d{28,33}.(xls|xlsx)
	 */
	private void delete(String path, String pattern) {
		if (path == null || "".equals(path.trim()) || pattern == null || "".equals(pattern.trim())) {
			log.info("path and pattern should not be null");
			// throw new IllegalArgumentException("path and pattern should not
			// be null");
		} else {
			path = path.trim();
			pattern = pattern.trim();
		}
		try {
			File dir = new File(path);
			if (!dir.exists() || !dir.isDirectory()) {
				log.info("is not directory or the directory does not exist:" + dir);
				// throw new IllegalArgumentException("is not directory or the
				// directory does not exist");
			}

			List<File> fileMatched = new ArrayList<File>();
			fileMatched = applyPattern(dir, pattern);

			if (fileMatched.size() == 0) {
				log.info("no matched file, do not delete old file");
				return;
			}

			for (int i = 0; i < fileMatched.size(); i++) {
				boolean r = deleteFile(fileMatched.get(i));
				if (!r)
					log.info("failed delete file:" + fileMatched.get(i).getPath());
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	private List<File> applyPattern(File folder, String pattern) throws Exception {
		List<File> list = new ArrayList<File>();
		if (folder == null || folder.isFile() || pattern == null)
			return list;

		Pattern p = createPattern(pattern);

		File[] files = folder.listFiles();
		for (int i = 0; i < files.length; i++) {
			File file = files[i];
			String name = file.getName();
			Matcher m = p.matcher(name);
			if (m.matches()) {
				list.add(file);
				// trace("[Matched] Folder: " + folder + ", Pattern: " + pattern
				// + ", File: " + name);
			}
			// else {
			// trace("[No Matched] Folder: " + folder + ", Pattern: " + pattern
			// + ", File: " + name);
			// }
		}

		return list;
	}

	/**
	 * become the string contains wildcard(*) to the regular expression
	 * 
	 * @param pattern
	 * @return replace "." and "*"
	 */
	private Pattern createPattern(String pattern) throws Exception {
		Pattern p = Pattern.compile(pattern, Pattern.CASE_INSENSITIVE);
		return p;
	}

	private boolean deleteFile(File f) throws Exception {

		if (f.isDirectory()) {
			log.info("here do not delete directory: " + f.getPath());
			return false;
		}

		if (f.isFile()) {
			f.delete();
			log.info("DELETED: " + f.getPath());
			return true;
		}
		return false;
	}

}
