
/**
 * Project Name: biportal
 * File Name: transform.edgeportal.bi.portal.web.DownloadDeckFileFromMailController.java
 * Date: 2017年7月24日
 * 
 * @author leo
 *         Copyright(c) 2017, IBM BI@IBM All Rights Reserved.
 */
package transform.edgeportal.bi.portal.web;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * ClassName: DownloadDeckFileFromMailController <br/>
 * Description: TODO <br/>
 * Date: 2017年7月24日 <br/>
 * 
 * @author leo
 */
@Controller
public class DownloadDeckFileFromMailController extends BaseController {

	private static final Logger	log	= Logger.getLogger(DownloadDeckFileFromMailController.class);

	@Value("${downloadDeckByLink}")
	private String				downloadDeckByLinkURL;

	@RequestMapping(value = "/portal/autodeck/downloadDeckByLink/{convert_id}/{running_id}/{extension_name}", method = RequestMethod.GET)
	public ModelAndView downloadDeckByLink(
			@PathVariable String convert_id,
			@PathVariable String running_id,
			@PathVariable String extension_name,
			HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, String> map = null;

		map = this.getRestTemplate().getForObject(
				getRestfulServerUrl() + downloadDeckByLinkURL,
				Map.class,
				this.getIntranetID(),
				this.getUserUid(),
				convert_id,
				running_id,
				extension_name);
		if(map.get("ErrorMessage")!=null && !map.get("ErrorMessage").equals("")){
			ModelAndView mav = new ModelAndView("/WEB-INF/portal/downloadDeckByLinkError.jsp");
			mav.addObject("errorMSG",map.get("ErrorMessage"));
			return mav;
		}

		OutputStream os = null;
		try {
			File file = new File(map.get("outputFile"));
			String fileName = map.get("fileName").replaceAll("[\\\\/:*?\"<>|]", "")+"."+extension_name;
			if (file.exists()) {
				os = new BufferedOutputStream(response.getOutputStream());
//				response.setContentType("application/octet-stream");
//				response.setHeader(
//						"Content-disposition",
//						"attachment; filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1"));
				
				response.setStatus(HttpServletResponse.SC_OK);
				response.setContentType("multipart/form-data");
				response.setCharacterEncoding("UTF-8");
				response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
				
				os.write(FileUtils.readFileToByteArray(file));
				os.flush();
			}
		} catch (Exception e) {
			log.error("ERROR:"+e);
			log.error(e.getMessage());
			e.printStackTrace();
		} finally {
			if (os != null) {
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

}
