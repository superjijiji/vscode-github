package transform.edgeportal.bi.portal.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import transform.edgeportal.bi.jpa.message.Msgctgry;
import transform.edgeportal.bi.jpa.message.Msgentry;
import transform.edgeportal.bi.jpa.message.Msggroup;
import transform.edgeportal.bi.jpa.message.Msgtype;

/**
 * 
 * ClassName: MessagePanelController <br/>
 * Description: This controller is used for Messages. <br/>
 * Date: Jun 26, 2017 <br/>
 * 
 * @author yhqin
 */
@Controller
public class MessagePanelController extends BaseController {

	@Value("${getMessageAll}")
	private String	getMessageAll;

	@Value("${getMessageNew}")
	private String	getMessageNew;

//	@Value("${getMessageAllCategory}")
//	private String	getMessageAllCategory;

	@Value("${getAdmimMessageAll}")
	private String	getAdmimMessageAll;

	@Value("${getMessageAllCatogoryOrderByID}")
	private String	getMessageAllCatogoryOrderByID;

	@Value("${getMessageAllGroupOrderByID}")
	private String	getMessageAllGroupOrderByID;

	@Value("${getMessageAllTypeOrderByID}")
	private String	getMessageAllTypeOrderByID;

	@Value("${getAdminMessageAllSectroles}")
	private String	getAdminMessageAllSectroles;

	@Value("${getAdminMessageOne}")
	private String	getAdminMessageOne;

	@Value("${getAdminMessageCategoryOne}")
	private String	getAdminMessageCategoryOne;

	@Value("${getAdminMessageTypeOne}")
	private String	getAdminMessageTypeOne;

	@Value("${getAdminMessageRolegroupOne}")
	private String	getAdminMessageRolegroupOne;
	
	@Value("${getAdminMessageInit}")
	private String	getAdminMessageInit;

	@Value("${getMessageSubscribes}")
	private String	getMessageSubscribes;

	@Value("${saveMessageSubscribes}")
	private String	saveMessageSubscribes;

	@Value("${deleteSelectedMessages}")
	private String	deleteSelectedMessages;

	@Value("${deleteMessageCategories}")
	private String	deleteMessageCategories;

	@Value("${deleteMessageTypes}")
	private String	deleteMessageTypes;

	@Value("${deleteMessageGroups}")
	private String	deleteMessageGroups;

	@Value("${deleteExpiredMessages}")
	private String	deleteExpiredMessages;

	@Value("${updateAdminMessage}")
	private String	updateAdminMessage;

	@Value("${updateAdminMessageRolegroup}")
	private String	updateAdminMessageRolegroup;

	@Value("${updateAdminMessageCategory}")
	private String	updateAdminMessageCategory;

	@Value("${updateAdminMessageType}")
	private String	updateAdminMessageType;

//	@Value("${getAdmimMessageByFilter}")
//	private String	getAdmimMessageByFilter;

	public String getMessageAllRestService() {
		return getRestfulServerUrl() + getMessageAll;
	}

	public String getMessageNewRestService() {
		return getRestfulServerUrl() + getMessageNew;
	}

//	public String getMessageAllCategoryRestService() {
//		return getRestfulServerUrl() + getMessageAllCategory;
//	}

	public String getAdmimMessageAllRestService() {
		return getRestfulServerUrl() + getAdmimMessageAll;
	}

	public String getMessageAllCatogoryOrderByIDRestService() {
		return getRestfulServerUrl() + getMessageAllCatogoryOrderByID;
	}

	public String getMessageAllGroupOrderByIDRestService() {
		return getRestfulServerUrl() + getMessageAllGroupOrderByID;
	}

	public String getMessageAllTypeOrderByIDRestService() {
		return getRestfulServerUrl() + getMessageAllTypeOrderByID;
	}

	public String getAdminMessageAllSectrolesRestService() {
		return getRestfulServerUrl() + getAdminMessageAllSectroles;
	}

	public String getAdminMessageOneRestService() {
		return getRestfulServerUrl() + getAdminMessageOne;
	}

	public String getAdminMessageCategoryOneRestService() {
		return getRestfulServerUrl() + getAdminMessageCategoryOne;
	}

	public String getAdminMessageTypeOneRestService() {
		return getRestfulServerUrl() + getAdminMessageTypeOne;
	}

	public String getAdminMessageRolegroupOneRestService() {
		return getRestfulServerUrl() + getAdminMessageRolegroupOne;
	}

	public String getAdminMessageInitRestService() {
		return getRestfulServerUrl() + getAdminMessageInit;
	}

	public String getMessageSubscribesRestService() {
		return getRestfulServerUrl() + getMessageSubscribes;
	}

	public String getSaveMessageSubscribesRestService() {
		return getRestfulServerUrl() + saveMessageSubscribes;
	}

	public String deleteSelectedMessagesRestService() {
		return getRestfulServerUrl() + deleteSelectedMessages;
	}

	public String deleteMessageCategoriesRestService() {
		return getRestfulServerUrl() + deleteMessageCategories;
	}

	public String deleteMessageTypesRestService() {
		return getRestfulServerUrl() + deleteMessageTypes;
	}

	public String deleteMessageGroupsRestService() {
		return getRestfulServerUrl() + deleteMessageGroups;
	}

	public String deleteExpiredMessagesRestService() {
		return getRestfulServerUrl() + deleteExpiredMessages;
	}

	public String updateAdminMessageRestService() {
		return getRestfulServerUrl() + updateAdminMessage;
	}

	public String updateAdminMessageRolegroupRestService() {
		return getRestfulServerUrl() + updateAdminMessageRolegroup;
	}

	public String updateAdminMessageCategoryRestService() {
		return getRestfulServerUrl() + updateAdminMessageCategory;
	}

	public String updateAdminMessageTypeRestService() {
		return getRestfulServerUrl() + updateAdminMessageType;
	}

//	public String getAdmimMessageByFilterRestService() {
//		return getRestfulServerUrl() + getAdmimMessageByFilter;
//	}

	private static final Logger	log	= Logger.getLogger(MessagePanelController.class);

	/**
	 * Get all messages for user when user login BI@IBM portal.
	 * Get messages list for each category ID. And saved them into a map. Key word is category ID.
	 * 
	 * @return Map<categoryID, List<Message>>
	 */
	@RequestMapping(value = "/portal/messages/getMessageAll", method = RequestMethod.GET)
	@ResponseBody
	public Map getMessageAll() {
		return this.getRestTemplate().getForObject(
				this.getMessageAllRestService(),
				Map.class,
				this.getIntranetID(),
				this.getUserUid());
	}

	/**
	 * Get all new messages for user in last 10 minutes.
	 * Get new messages that are created/published in last 10 minutes for each category ID. And saved them into a map.
	 * Key word is category ID.
	 * 
	 * @return Map<categoryID, List<Message>>
	 */
	@RequestMapping(value = "/portal/messages/getMessageNew", method = RequestMethod.GET)
	@ResponseBody
	public Map getMessageNew() {
		return this.getRestTemplate().getForObject(
				this.getMessageNewRestService(),
				Map.class,
				this.getIntranetID(),
				this.getUserUid());
	}
	
//	@RequestMapping(value = "/portal/messages/getMessageAllCategory", method = RequestMethod.GET)
//	@ResponseBody
//	public List getMessageAllCategory() {
//		List allCategory =  this.getRestTemplate().getForObject(
//				getMessageAllCategoryRestService(), 
//				List.class,
//				this.getIntranetID(),
//				this.getUserUid());
//		return allCategory;
//	}
	
	@RequestMapping(value = "/portal/messages/getAdmimMessageAll/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Map getAdmimMessageAll(@PathVariable String cwa_id, @PathVariable String uid) {
		
		Map resultMap = this.getRestTemplate().getForObject(
				this.getAdmimMessageAllRestService(), 
				Map.class,
				cwa_id,
				uid);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/portal/messages/getMessageAllCatogoryOrderByID/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getMessageAllCatogoryOrderByID(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List allCategoryList = this.getRestTemplate().getForObject(this.getMessageAllCatogoryOrderByIDRestService(), List.class, cwa_id, uid);
		
		return allCategoryList;
	}
	
	@RequestMapping(value = "/portal/messages/getMessageAllGroupOrderByID/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getMessageAllGroupOrderByID(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List allGroupList = this.getRestTemplate().getForObject(this.getMessageAllGroupOrderByIDRestService(), List.class, cwa_id, uid);
		
		return allGroupList;
	}
	
	@RequestMapping(value = "/portal/messages/getMessageAllTypeOrderByID/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getMessageAllTypeOrderByID(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List allTypeList = this.getRestTemplate().getForObject(this.getMessageAllTypeOrderByIDRestService(), List.class, cwa_id, uid);
		
		return allTypeList;
	}
	
	@RequestMapping(value = "/portal/messages/getAdminMessageAllSectroles/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public List getAdminMessageAllSectroles(@PathVariable String cwa_id, @PathVariable String uid) {
		
		List allSectroleList = this.getRestTemplate().getForObject(this.getAdminMessageAllSectrolesRestService(), List.class, cwa_id, uid);
		
		return allSectroleList;
	}
	
	@RequestMapping(value = "/portal/messages/getAdminMessageOne/{cwa_id}/{uid}/{msgId}", method = RequestMethod.GET)
	@ResponseBody
	public Map getAdminMessageOne(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable int msgId) {
		
		Map resultMap = this.getRestTemplate().getForObject(
				this.getAdminMessageOneRestService(), 
				Map.class, 
				cwa_id,
				uid,
				msgId);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/portal/messages/getAdminMessageCategoryOne/{cwa_id}/{uid}/{msgCategoryId}", method = RequestMethod.GET)
	@ResponseBody
	public Msgctgry getAdminMessageCategoryOne(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String msgCategoryId) {
		
		Msgctgry resultMap = this.getRestTemplate().getForObject(
				this.getAdminMessageCategoryOneRestService(), 
				Msgctgry.class, 
				cwa_id,
				uid,
				msgCategoryId);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/portal/messages/getAdminMessageTypeOne/{cwa_id}/{uid}/{msgTypeId}", method = RequestMethod.GET)
	@ResponseBody
	public Msgtype getAdminMessageTypeOne(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String msgTypeId) {
		
		Msgtype resultMap = this.getRestTemplate().getForObject(
				this.getAdminMessageTypeOneRestService(), 
				Msgtype.class, 
				cwa_id,
				uid,
				msgTypeId);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/portal/messages/getAdminMessageRolegroupOne/{cwa_id}/{uid}/{msgGroupId}", method = RequestMethod.GET)
	@ResponseBody
	public Map getAdminMessageRolegroupOne(@PathVariable String cwa_id, @PathVariable String uid, @PathVariable String msgGroupId) {
		
		Map resultMap = this.getRestTemplate().getForObject(
				this.getAdminMessageRolegroupOneRestService(), 
				Map.class, 
				cwa_id,
				uid,
				msgGroupId);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/portal/messages/getAdminMessageInit/{cwa_id}/{uid}", method = RequestMethod.GET)
	@ResponseBody
	public Map getAdminMessageInit(@PathVariable String cwa_id, @PathVariable String uid) {
		
		Map resultMap = this.getRestTemplate().getForObject(
				this.getAdminMessageInitRestService(), 
				Map.class, 
				cwa_id,
				uid);
		
		return resultMap;
	}

	/**
	 * Forward page from portal to Messages subscriptions page.
	 * 
	 * @return JSP for Messages subscriptions page.
	 */
	@RequestMapping(value = "/portal/messages/getMessageSubsbPage", method = RequestMethod.GET)
	public String getMessageSubscribesPage() {
		return "/WEB-INF/portal/messages-subscribe.jsp";
	}

	/**
	 * Get all information related to messages subscriptions.
	 * 
	 * @return Map<"MSGCTGRY"/"MSGTYPE"/"SUBSUCTS", List<Msgctgry/Msgtype/Subsucts>>
	 */
	@RequestMapping(value = "/portal/messages/getMessageSubscribes", method = RequestMethod.GET)
	@ResponseBody
	public Map getMessageSubscribes() {
		return this.getRestTemplate().getForObject(
				this.getMessageSubscribesRestService(),
				Map.class,
				this.getIntranetID(),
				this.getUserUid());
	}

	/**
	 * Saved subscriptions for user.
	 * 
	 * @param body
	 *            A JSON object contains all messages subscriptions selected by user from UI.
	 * @return {"status", "success"}: Subscription successfully updated. {"status", "fail"}: Failed to update
	 *         subscriptions.
	 */
	@RequestMapping(value = "/portal/messages/saveMessageSubscribes", method = RequestMethod.POST)
	@ResponseBody
	public Map saveMessageSubscribes(@RequestBody List<Map<String, String>> body) {

		log.info(body);

		ResponseEntity<String> result = this.getRestTemplate().postForEntity(
				this.getSaveMessageSubscribesRestService(),
				body,
				String.class,
				this.getIntranetID(),
				this.getUserUid());

		// log.info("messages subscribes - yonghai statuscode:" + result.getStatusCode());
		log.info("messages subscribes - yonghai statuscodevalue:" + result.getStatusCodeValue());

		Map<String, String> resultMap = new HashMap<String, String>();

		if (result.getStatusCodeValue() == 200) {
			resultMap.put("status", "success");
		} else {
			resultMap.put("status", "fail");
		}

		return resultMap;
	}
	
	@RequestMapping(value = "/portal/messages/deleteSelectedMessages", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteSelectedMessages(@RequestBody List<Msgentry> body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				this.deleteSelectedMessagesRestService(), 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/portal/messages/deleteMessageCategories", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteMessageCategories(@RequestBody List<Msgctgry> body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				this.deleteMessageCategoriesRestService(), 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/portal/messages/deleteMessageTypes", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteMessageTypes(@RequestBody List<Msgtype> body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				this.deleteMessageTypesRestService(), 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/portal/messages/deleteMessageGroups", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteMessageGroups(@RequestBody List<Msggroup> body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				this.deleteMessageGroupsRestService(), 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/portal/messages/deleteExpiredMessages", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteExpiredMessages() {
		
		Map result = this.getRestTemplate().postForObject(
				this.deleteExpiredMessagesRestService(), 
				null, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid());
		
		return result;
	}
	
	@RequestMapping(value = "/portal/messages/updateAdminMessage/{action}", method = RequestMethod.POST)
	@ResponseBody
	public Map updateAdminMessage(@PathVariable String action, @RequestBody Object body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				this.updateAdminMessageRestService(), 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid(),
				action);
		
		return result;
	}
	
	@RequestMapping(value = "/portal/messages/updateAdminMessageRolegroup/{action}", method = RequestMethod.POST)
	@ResponseBody
	public Map updateAdminMessageRolegroup(@PathVariable String action, @RequestBody Object body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				this.updateAdminMessageRolegroupRestService(), 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid(),
				action);
		
		return result;
	}
	
	@RequestMapping(value = "/portal/messages/updateAdminMessageCategory/{action}", method = RequestMethod.POST)
	@ResponseBody
	public Map updateAdminMessageCategory(@PathVariable String action, @RequestBody Object body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				this.updateAdminMessageCategoryRestService(), 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid(),
				action);
		
		return result;
	}
	
	@RequestMapping(value = "/portal/messages/updateAdminMessageType/{action}", method = RequestMethod.POST)
	@ResponseBody
	public Map updateAdminMessageType(@PathVariable String action, @RequestBody Object body) {
		
		log.info(body);
		
		Map result = this.getRestTemplate().postForObject(
				this.updateAdminMessageTypeRestService(), 
				body, 
				Map.class, 
				this.getIntranetID(),
				this.getUserUid(),
				action);
		
		return result;
	}
	
//	@RequestMapping(value = "/portal/messages/getAdmimMessageByFilter", method = RequestMethod.POST)
//	@ResponseBody
//	public Map getAdmimMessageByFilter(@RequestBody Object body) {
//		
//		log.info(body);
//		
//		Map result = this.getRestTemplate().postForObject(
//				this.getAdmimMessageByFilterRestService(), 
//				body, 
//				Map.class, 
//				this.getIntranetID(),
//				this.getUserUid());
//		
//		return result;
//	}

	/**
	 * Forward page from portal to View all messages page.
	 * 
	 * @return JSP for View all messages page.
	 */
	@RequestMapping(value = "/portal/messages/getMessageMaxPage", method = RequestMethod.GET)
	public String getMessageMaxPage() {
		return "/WEB-INF/portal/messages_max.jsp";
	}
	
	@RequestMapping(value = "/admin/msgentry/managemessages", method = RequestMethod.GET)
	public ModelAndView showAdminMessageListPanel() {
		ModelAndView mav = new ModelAndView("/WEB-INF/portal/messages_admin_messagelist.jsp");
		mav.addObject("cwa_id", this.getIntranetID());
		mav.addObject("uid", this.getUserUid());
		return mav;
	}
	
//	@RequestMapping(value = "/portal/messages/messages_admin_categorylist", method = RequestMethod.GET)
//	public ModelAndView showAdminCategoryListPanel() {
//		ModelAndView mav = new ModelAndView("/WEB-INF/portal/messages_admin_categorylist.jsp");
//		mav.addObject("cwa_id", this.getIntranetID());
//		mav.addObject("uid", this.getUserUid());
//		return mav;
//	}
//	
//	@RequestMapping(value = "/portal/messages/messages_admin_typelist", method = RequestMethod.GET)
//	public ModelAndView showAdminTypeListPanel() {
//		ModelAndView mav = new ModelAndView("/WEB-INF/portal/messages_admin_typelist.jsp");
//		mav.addObject("cwa_id", this.getIntranetID());
//		mav.addObject("uid", this.getUserUid());
//		return mav;
//	}
//	
//	@RequestMapping(value = "/portal/messages/messages_admin_rolegrouplist", method = RequestMethod.GET)
//	public ModelAndView showAdminRoleGroupListPanel() {
//		ModelAndView mav = new ModelAndView("/WEB-INF/portal/messages_admin_rolegrouplist.jsp");
//		mav.addObject("cwa_id", this.getIntranetID());
//		mav.addObject("uid", this.getUserUid());
//		return mav;
//	}
//	
//	@RequestMapping(value = "/portal/messages/messages_admin_messageedit/{action}/{msgId}", method = RequestMethod.GET)
//	public ModelAndView showAdminMessageEditPanel(@PathVariable String action, @PathVariable int msgId) {
//		ModelAndView mav = new ModelAndView("/WEB-INF/portal/messages_admin_messageedit.jsp");
//		mav.addObject("cwa_id", this.getIntranetID());
//		mav.addObject("uid", this.getUserUid());
//		mav.addObject("action", action);
//		mav.addObject("msgId", msgId);
//		return mav;
//	}
//	
//	@RequestMapping(value = "/portal/messages/messages_admin_categoryedit/{action}/{msgCategoryId}", method = RequestMethod.GET)
//	public ModelAndView showAdminCategoryEditPanel(@PathVariable String action, @PathVariable String msgCategoryId) {
//		ModelAndView mav = new ModelAndView("/WEB-INF/portal/messages_admin_categoryedit.jsp");
//		mav.addObject("cwa_id", this.getIntranetID());
//		mav.addObject("uid", this.getUserUid());
//		mav.addObject("action", action);
//		mav.addObject("msgCategoryId", msgCategoryId);
//		return mav;
//	}
//	
//	@RequestMapping(value = "/portal/messages/messages_admin_typeedit/{action}/{msgTypeId}", method = RequestMethod.GET)
//	public ModelAndView showAdminTypeEditPanel(@PathVariable String action, @PathVariable String msgTypeId) {
//		ModelAndView mav = new ModelAndView("/WEB-INF/portal/messages_admin_typeedit.jsp");
//		mav.addObject("cwa_id", this.getIntranetID());
//		mav.addObject("uid", this.getUserUid());
//		mav.addObject("action", action);
//		mav.addObject("msgTypeId", msgTypeId);
//		return mav;
//	}
//	
//	@RequestMapping(value = "/portal/messages/messages_admin_rolegroupedit/{action}/{msgGroupId}", method = RequestMethod.GET)
//	public ModelAndView showAdminRolegroupEditPanel(@PathVariable String action, @PathVariable String msgGroupId) {
//		ModelAndView mav = new ModelAndView("/WEB-INF/portal/messages_admin_rolegroupedit.jsp");
//		mav.addObject("cwa_id", this.getIntranetID());
//		mav.addObject("uid", this.getUserUid());
//		mav.addObject("action", action);
//		mav.addObject("msgGroupId", msgGroupId);
//		return mav;
//	}
}
