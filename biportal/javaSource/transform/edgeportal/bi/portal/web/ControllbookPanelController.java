package transform.edgeportal.bi.portal.web;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.servlet.ModelAndView;
import transform.edgeportal.bi.jpa.controlbook.CbBlobconf;
import transform.edgeportal.bi.jpa.controlbook.Cnbkrept;
import transform.edgeportal.bi.jpa.controlbook.Ctrlbook;
import transform.edgeportal.bi.jpa.controlbook.CtrlbookDetails;
import transform.edgeportal.bi.jpa.link.Link;

@Controller
public class ControllbookPanelController extends BaseController {

	private static final Logger	log	= Logger.getLogger(ControllbookPanelController.class);

	@Value("${getCBReportList}")
	private String				getCBReportList;

	@Value("${getSelectedCBlist}")
	private String				getSelectedCBlist;

	@Value("${getUnSelectedCBlist}")
	private String				getUnSelectedCBlist;

	@Value("${removeCBUser}")
	private String				removeCBUser;

	@Value("${addCBUser}")
	private String				addCBUser;

	@Value("${getGeoList}")
	private String				getGeoList;

	@Value("${getBusinessList}")
	private String				getBusinessList;

	@Value("${link_getLink}")
	private String				getLink;

	@Value("${listMyManagedCB}")
	private String				listMyManagedCBURL;

	@Value("${getControlbooklist}")
	private String				getControlbooklist;

	@Value("${setLastAccessCB}")
	private String				setLastAccessCB;

	@Value("${getLastAccessCB}")
	private String				getLastAccessCB;

	@Value("${controlBookHelp}")
	private String				controlBookHelp;

	@Value("${getDashBoardURL}")
	private String				getDashBoardURL;
	@Value("${getDashboardTemplates}")
	private String				getDashboardTemplatesURL;
	@Value("${postControlbookURL}")
	private String				postControlbookURL;
	@Value("${getControlBookAllReports}")
	private String				getControlBookReportsURL;
	@Value("${postControlBookAllReports}")
	private String				postControlBookAllReportsURL;
	@Value("${deleteControlbookURL}")
	private String				deleteControlbookURL;
	@Value("${getControlbookPermissions}")
	private String				getControlbookPermissionsURL;
	@Value("${postControlbookPermissions}")
	private String				postControlbookPermissionsURL;

	public String getControlbooklistRestService() {
		return getRestfulServerUrl() + getControlbooklist;
	}

	public String getSetLastAccessCBRestService() {
		return getRestfulServerUrl() + setLastAccessCB;
	}

	public String getLastAccessCBRestService() {
		return getRestfulServerUrl() + getLastAccessCB;
	}

	public String getCBReportListRestService() {
		return getRestfulServerUrl() + getCBReportList;
	}

	public String getSelectedCBlist() {
		return getRestfulServerUrl() + getSelectedCBlist;
	}

	public String getUnSelectedCBlist() {
		return getRestfulServerUrl() + getUnSelectedCBlist;
	}

	public String removeCBUser() {
		return getRestfulServerUrl() + removeCBUser;
	}

	public String addCBUser() {
		return getRestfulServerUrl() + addCBUser;
	}

	public String getGeoList() {
		return getRestfulServerUrl() + getGeoList;
	}

	public String getBusinessList() {
		return getRestfulServerUrl() + getBusinessList;
	}

	public String getLink() {
		return getRestfulServerUrl() + getLink;
	}

	public String getControlBookHelp() {
		return getRestfulServerUrl() + controlBookHelp;
	}

	@RequestMapping(value = "/portal/controlbook/getControlbooklist/{cwaId}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getControlbooklist(@PathVariable String cwaId, @PathVariable String uid) {

		return this.getRestTemplate().getForObject(this.getControlbooklistRestService(), List.class, cwaId, uid);
	}

	@RequestMapping(value = "/portal/usage/lastAccessCB/{cwa_id}/{uid}/{lastCBID}/{CBview}", method = RequestMethod.GET)
	@ResponseBody
	public void setLastAccessCB(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String lastCBID,
			@PathVariable String CBview) {
		this.getRestTemplate()
				.postForEntity(this.getSetLastAccessCBRestService(), null, String.class, cwa_id, uid, lastCBID, CBview);
	}

	@RequestMapping(value = "/portal/usage/lastAccessCB/{cwaId}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Object getLastAccessCB(@PathVariable String cwaId, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getLastAccessCBRestService(), Object.class, cwaId, uid);
	}

	@RequestMapping(value = "/portal/controlbook/help", method = RequestMethod.GET)
	public ModelAndView getHelp(@RequestParam String id) {
		Ctrlbook book = this.getRestTemplate()
				.getForObject(this.getControlBookHelp(), Ctrlbook.class, this.getIntranetID(), this.getUserUid(), id);
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/myControlBooks_help.jsp");
		mav.addObject("controlBookName", book.getCtrlbookName());
		mav.addObject("controlBook", book);
		return mav;
	}

	@RequestMapping(value = "/portal/controlbook/getCBReportList/{cwaId}/{uid}/{cbId}", method = RequestMethod.GET)
	@ResponseBody
	public List getCBReportList(@PathVariable String cwaId, @PathVariable String uid, @PathVariable String cbId) {

		return this.getRestTemplate().getForObject(this.getCBReportListRestService(), List.class, cwaId, uid, cbId);

	}

	@RequestMapping(value = "/portal/controlbook/getDashboard//{cwaId}/{uid}/{cbId}/{jsValName}/{jsType}", method = RequestMethod.GET)
	@ResponseBody
	public String getDashboard(
			@PathVariable String cwaId,
			@PathVariable String uid,
			@PathVariable String cbId,
			@PathVariable String jsValName,
			@PathVariable String jsType) {
		return this.getRestTemplate().getForObject(
				getRestfulServerUrl() + this.getDashBoardURL,
				String.class,
				cwaId,
				uid,
				cbId,
				jsValName,
				jsType);
	}

	@RequestMapping(value = "/portal/controlbook/showAddRemoveCB/{cwa_id}/{uid}", method = RequestMethod.GET)
	public ModelAndView showAddRemoveCB(@PathVariable String cwa_id, @PathVariable String uid) {
		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/myControlBook_addRemove.jsp");
		modelAndView.addObject("cwa_id", cwa_id);
		modelAndView.addObject("uid", uid);
		return modelAndView;
	}

	@RequestMapping(value = "/portal/controlbook/getSelectedCBlist/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getSelectedCBlist(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getSelectedCBlist(), List.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/controlbook/getUnSelectedCBlist/{cwa_id}/{uid}/{geo}/{business}", method = RequestMethod.GET)
	@ResponseBody
	public List getUnSelectedCBlist(
			@PathVariable String cwa_id,
			@PathVariable String uid,
			@PathVariable String geo,
			@PathVariable String business) {
		return this.getRestTemplate().getForObject(this.getUnSelectedCBlist(), List.class, cwa_id, uid, geo, business);
	}

	@RequestMapping(value = "/portal/controlbook/getGeoList/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getGeoList(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getGeoList(), List.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/controlbook/getBusinessList/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getBusinessList(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate().getForObject(this.getBusinessList(), List.class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/controlbook/removeCBUser/{cwa_id}/{uid}/{cbIds}", method = RequestMethod.DELETE)
	@ResponseBody
	public void removeCBUser(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String cbIds) {
		this.getRestTemplate().delete(this.removeCBUser(), cwa_id, uid, cbIds);
	}

	@RequestMapping(value = "/portal/controlbook/addCBUser/{cwa_id}/{uid}/{cbIds}", method = RequestMethod.GET)
	@ResponseBody
	public void addCBUser(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String cbIds) {
		this.getRestTemplate().getForObject(this.addCBUser(), List.class, cwa_id, uid, cbIds);
	}

	@RequestMapping(value = "/admin/ctrlbook/myControlBooks", method = RequestMethod.GET)
	public ModelAndView showMyControlBooks() {
		String cwa_id = this.getIntranetID();
		String uid = this.getUserUid();

		ModelAndView modelAndView = new ModelAndView("/WEB-INF/portal/myControlBook_manage.jsp");
		modelAndView.addObject("cwa_id", cwa_id);
		modelAndView.addObject("uid", uid);

		return modelAndView;
	}

	@RequestMapping(value = "/portal/controlbook/listMyManagedCB", method = RequestMethod.GET)
	@ResponseBody
	public CtrlbookDetails[] listMangedCB(@RequestParam String cwa_id, @RequestParam String uid) {
		return this.getRestTemplate()
				.getForObject(getRestfulServerUrl() + listMyManagedCBURL, CtrlbookDetails[].class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/controlbook/listDashboardTemplpates/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public CbBlobconf[] listDashboardTemplpates(@PathVariable String cwa_id, @PathVariable String uid) {
		return this.getRestTemplate()
				.getForObject(getRestfulServerUrl() + getDashboardTemplatesURL, CbBlobconf[].class, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/controlbook", method = RequestMethod.POST)
	@ResponseBody
	public int saveControlbook(
			@RequestBody CtrlbookDetails ctrlbookDetail,
			@RequestParam String cwa_id,
			@RequestParam String uid,
			@RequestParam String action) {
		log.info(cwa_id);
		log.info(uid);
		log.info(action);
		log.info(ctrlbookDetail.getCtrlbook_name());
		//
		Ctrlbook ctrlbook = new Ctrlbook();
		ctrlbook.setCtrlbookBackup(ctrlbookDetail.getCtrlbook_backup());
		ctrlbook.setCtrlbookDesc(ctrlbookDetail.getCtrlbook_desc());
		ctrlbook.setCtrlbookFilterId(Integer.parseInt(ctrlbookDetail.getCtrlbook_filter_id()));
		ctrlbook.setCtrlbookFilterTypeId(Integer.parseInt(ctrlbookDetail.getCtrlbook_filter_type_id()));
		ctrlbook.setCtrlbookHelp(ctrlbookDetail.getCtrlbook_help());
		ctrlbook.setCtrlbookId(Integer.parseInt(ctrlbookDetail.getCtrlbook_id()));
		ctrlbook.setCtrlbookName(ctrlbookDetail.getCtrlbook_name());
		ctrlbook.setCtrlbookOwner(ctrlbookDetail.getCtrlbook_owner());
		ctrlbook.setHasdashboard(ctrlbookDetail.getHasdashboard());
		ctrlbook.setIsupdate(ctrlbookDetail.getIsupdate());
		ctrlbook.setPurpose(ctrlbookDetail.getPurpose());
		ctrlbook.setRequestAccess(ctrlbookDetail.getRequest_access());
		ctrlbook.setSupportContact(ctrlbookDetail.getSupport_contact());
		ctrlbook.setTargetAud(ctrlbookDetail.getTarget_aud());
		ctrlbook.setXlsRptDefId(ctrlbookDetail.getXls_rpt_def_id());
		ctrlbook.setCtrlbookType(ctrlbookDetail.getCtrlbook_type());
		ctrlbook.setCtrlbookStatus(ctrlbookDetail.getCtrlbook_status());
		ctrlbook.setCtrlbookExpiry(ctrlbookDetail.getCtrlbook_expiry());
		ctrlbook.setCreateTime(ctrlbookDetail.getCreate_time());
		//
		try {
			ResponseEntity<Ctrlbook> entity = this.getRestTemplate().postForEntity(
					getRestfulServerUrl() + postControlbookURL,
					ctrlbook,
					Ctrlbook.class,
					cwa_id,
					uid,
					action);
			return entity.getBody().getCtrlbookId();
		} catch (HttpClientErrorException e) {
			if (e.getStatusCode() == HttpStatus.GONE) {
				log.error("Failed to save control book, can not find the control book");
				return -1;
			} else {
				log.error(e.getMessage());
				return -2;
			}
		}
	}

	@RequestMapping(value = "/portal/controlbook", method = RequestMethod.DELETE)
	@ResponseBody
	public ResponseEntity<String> removeControlbook(
			@RequestParam int cbid,
			@RequestParam String cwa_id,
			@RequestParam String uid) {
		if (!cwa_id.equalsIgnoreCase(this.getIntranetID())) {
			return new ResponseEntity<String>("Bad request to remove control book.", HttpStatus.BAD_REQUEST);
		}
		//
		Map<String, Object> removeRequest = new HashMap<String, Object>();
		removeRequest.put("cbid", cbid);
		removeRequest.put("cwa_id", cwa_id);
		removeRequest.put("uid", uid);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<Map<String, Object>> entity = new HttpEntity<Map<String, Object>>(removeRequest, headers);
		try {
			ResponseEntity<String> responseEntity = this.getRestTemplate()
					.exchange(getRestfulServerUrl() + deleteControlbookURL, HttpMethod.DELETE, entity, String.class);
			return responseEntity;
		} catch (HttpClientErrorException e) {
			return new ResponseEntity<String>(e.getResponseBodyAsString(), HttpStatus.NOT_ACCEPTABLE);
		}
		//
	}

	//
	@RequestMapping(value = "/portal/controlbook/reports", method = RequestMethod.GET)
	@ResponseBody
	public Cnbkrept[] listControlbookReports(
			@RequestParam int cbid,
			@RequestParam String cwa_id,
			@RequestParam String uid) {
		return this.getRestTemplate()
				.getForObject(getRestfulServerUrl() + getControlBookReportsURL, Cnbkrept[].class, cbid, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/controlbook/reports", method = RequestMethod.POST)
	@ResponseBody
	public Cnbkrept[] saveControlbookReports(
			@RequestBody Cnbkrept[] reports,
			@RequestParam int cbid,
			@RequestParam String cwa_id,
			@RequestParam String uid) {
		log.info(cbid);
		log.info(cwa_id);
		log.info(uid);
		log.info(reports.length);
		return this.getRestTemplate().postForObject(
				getRestfulServerUrl() + postControlBookAllReportsURL,
				reports,
				Cnbkrept[].class,
				cbid,
				cwa_id,
				uid);
	}
	//
	@RequestMapping(value = "/portal/controlbook/permissions", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String>[] listControlbookPermission(
			@RequestParam int cbid,
			@RequestParam String cwa_id,
			@RequestParam String uid) {
		return this.getRestTemplate()
				.getForObject(getRestfulServerUrl() + getControlbookPermissionsURL, Map[].class, cbid, cwa_id, uid);
	}

	@RequestMapping(value = "/portal/controlbook/permissions", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> saveControlbookPermission(
			@RequestBody Map<String, String>[] permissions,
			@RequestParam int cbid,
			@RequestParam String cwa_id,
			@RequestParam String uid) {
		 ResponseEntity<String> entity = this.getRestTemplate().postForEntity(
				getRestfulServerUrl() + postControlbookPermissionsURL,
				permissions,
				String.class,
				cbid,
				cwa_id,
				uid);
		return new ResponseEntity<String>(entity.getBody(),entity.getStatusCode());
		
	}
	
}
