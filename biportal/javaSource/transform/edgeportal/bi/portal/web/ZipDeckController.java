package transform.edgeportal.bi.portal.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class ZipDeckController extends BaseController {

	Logger			log	= Logger.getLogger(ZipDeckController.class);

	@Value(value = "${createZipDeck}")
	private String	createZipDeckURL;

	@Value(value = "${createDeckZip}")
	private String	createDeckZipURL;

	@Value(value = "${getZipDeckLog}")
	private String	getZipDeckLogURL;

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/portal/zipdeck", method = RequestMethod.POST)
	public ModelAndView createZipDeck(
			@RequestParam String cwa_id,
			@RequestParam String uid,
			@RequestParam String deck_type,
			@RequestParam String deck_format,
			@RequestParam String[] request_id) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/deckPanel.jsp");
		//
		try {
			List<Map<String, String>> decks = new ArrayList<Map<String, String>>();
			for (int i = 0; i < request_id.length; i++) {
				Map<String, String> deck = new HashMap<String, String>();
				deck.put("cwa_id", cwa_id);
				deck.put("uid", uid);
				deck.put("deck_type", deck_type);
				deck.put("deck_format", deck_format);
				deck.put("request_id", request_id[i]);
				decks.add(deck);
			}
			Map<String, String> zipdeck = this.getRestTemplate().postForObject(
					getRestfulServerUrl() + createZipDeckURL,
					decks,
					Map.class);
			mav.setStatus(HttpStatus.CREATED);
			mav.addObject("statusCode", HttpStatus.CREATED);
			mav.addObject("zipDeckMap", zipdeck);
		} catch (Exception e) {
			mav.setStatus(HttpStatus.NOT_ACCEPTABLE);
			mav.addObject("statusCode", HttpStatus.NOT_ACCEPTABLE);
			mav.addObject("error", e.getLocalizedMessage());
		}
		return mav;
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/portal/zipdeck/zip", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map> zipDeck(@RequestBody Map<String, String> request) {

		try {
			ResponseEntity<Map> status = this.getRestTemplate().postForEntity(
					getRestfulServerUrl() + createDeckZipURL,
					request,
					Map.class);
			return status;
		} catch (Exception e) {
			log.error(e);
			ResponseEntity<Map> entity = null;
			if (e instanceof HttpClientErrorException) {
				HttpClientErrorException ee = (HttpClientErrorException) e;
				String json = ee.getResponseBodyAsString();
				Map error = jsonStrToMap(json);
				if (error == null) {
					error = new HashMap();
					error.put("Error", e.getMessage());
				}
				entity = new ResponseEntity<Map>(error, ee.getStatusCode());
			} else {
				Map error = new HashMap();
				error.put("Error", e.getMessage());
				entity = new ResponseEntity<Map>(error, HttpStatus.INTERNAL_SERVER_ERROR);
			}
			return entity;
		}
	}

	//
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/portal/zipdeck/log/{cwa_id}/{uid}/{runnig_id}", method = RequestMethod.GET)
	@ResponseStatus
	public ResponseEntity<Map> getZipDeckLog(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String runnig_id) {

		try {
			ResponseEntity<Map> entity = this.getRestTemplate().getForEntity(
					getRestfulServerUrl() + getZipDeckLogURL,
					Map.class,
					cwa_id,
					uid,
					runnig_id);
			return entity;
		} catch (Exception e) {
			log.error(e);
			ResponseEntity<Map> error = null;
			if (e instanceof HttpClientErrorException) {
				HttpClientErrorException ee = (HttpClientErrorException) e;
				error = new ResponseEntity<Map>(ee.getStatusCode());
			} else {
				error = new ResponseEntity<Map>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
			return error;
		}
	}

	//
	@RequestMapping(value = "/portal/zipdeck/download/{cwa_id}/{uid}/{deck_id}/{running_id}", method = RequestMethod.GET)
	public ModelAndView downLoadZipDeckLog(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String deck_id,
			@PathVariable String running_id,
			HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = null;
		ResponseEntity<Map> entity = null;
		try {
			entity = this.getRestTemplate().getForEntity(
					getRestfulServerUrl() + getZipDeckLogURL,
					Map.class,
					cwa_id,
					uid,
					running_id);
		} catch (Exception e) {
			log.error(e);
			return showDownloadError(cwa_id, uid, "Error occured while calling biapi method", "null", "null");
		}
		if (entity == null) {
			log.error("Can not find deck log data");
			return showDownloadError(cwa_id, uid, "Error occured while calling biapi method", "null", "null");
		}
		Map deck_log = entity.getBody();
		String str_cwa_id = deck_log.get("cwaId").toString();
		String outputFile = deck_log.get("outputFile").toString();
		//
		int i = -1;
		i = outputFile.lastIndexOf("/");
		String fileName = outputFile.substring((i < 0 ? 0 : i + 1), outputFile.length());
		// log.info("fileName:::::" + fileName);
		i = fileName.lastIndexOf(".");
		String suffix = null;
		if (i > -1) {
			suffix = fileName.substring(i + 1, fileName.length());
			// log.info("suffix:::::" + suffix);
		}
		if (suffix == null) {
			suffix = "txt";
		}
		//
		String outputFileName = "myzip_" + uid + "." + suffix;
		//
		try {
			response.setStatus(HttpServletResponse.SC_OK);
			response.setContentType("multipart/form-data");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename=\"" + outputFileName + "\"");
			mav = new ModelAndView("/zipdeck/" + fileName);
			return mav;
		} catch (Exception e) {
			return showDownloadError(
					cwa_id,
					uid,
					"There is error occured in the file download process--->" + e.getMessage(),
					"null",
					"null");
		}
	}

	/**
	 * 
	 * @param cwaid
	 * @param uid
	 * @param errorMessage
	 * @param emailSubject
	 * @param reportName
	 * @return
	 *         showDownloadError
	 */
	private ModelAndView showDownloadError(
			String cwaid,
			String uid,
			String errorMessage,
			String emailSubject,
			String reportName) {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/myRecentTBSoutputs_error.jsp");
		mav.addObject("cwa_id", cwaid);
		mav.addObject("uid", uid);
		mav.addObject("ErrorMsg", errorMessage);

		if (emailSubject != null && !"".equals(emailSubject)) {
			mav.addObject("emailSubject", emailSubject);
		} else {
			mav.addObject("emailSubject", null);
		}
		if (reportName != null && !"".equals(reportName)) {
			mav.addObject("reportName", reportName);
		} else {
			mav.addObject("reportName", null);
		}

		return mav;
	}

	/**
	 * 
	 * @param json_str
	 * @return
	 *         jsonStrToMap
	 */
	private Map<String, String> jsonStrToMap(String json_str) {
		try {
			Map<String, String> map = new ObjectMapper().readValue(
					json_str,
					new TypeReference<HashMap<String, String>>() {});
			return map;
		} catch (JsonParseException e1) {
			e1.printStackTrace();
		} catch (JsonMappingException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return null;
	}
}
