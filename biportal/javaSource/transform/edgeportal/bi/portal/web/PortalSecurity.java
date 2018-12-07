
/**
 * Project Name: biportal
 * File Name: transform.edgeportal.bi.portal.web.PortalSecurity.java
 * Date: Jan 29, 2018
 * 
 * @author zhaoyutao
 *         Copyright(c) 2018, IBM BI@IBM All Rights Reserved.
 */
package transform.edgeportal.bi.portal.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonParser.Feature;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * ClassName: PortalSecurity <br/>
 * Description: TODO <br/>
 * Date: Jan 29, 2018 <br/>
 * 
 * @author zhaoyutao
 */
@Controller
public class PortalSecurity extends BaseController {

	private static final Logger	log	= Logger.getLogger(PortalSecurity.class);

	@Value("${bg_search_bluegroup_byName_URL}")
	private String				bg_search_bluegroup_byName_URL;
	@Value("${bg_search_bluegroup_byOwner_URL}")
	private String				bg_search_bluegroup_byOwner_URL;
	@Value("${bg_search_memberlist_listBGbyCWAID_URL}")
	private String				bg_search_memberlist_listBGbyCWAID_URL;
	@Value("${bp_search_person_byMail_URL}")
	private String				bp_search_person_byMail_URL;
	@Value("${bp_search_person_bySN_URL}")
	private String				bp_search_person_bySN_URL;
	@Value("${bp_search_person_byName_URL}")
	private String				bp_search_person_byName_URL;
	@Value("${bp_search_person_byNotes_URL}")
	private String				bp_search_person_byNotes_URL;

	@RequestMapping(value = "/portal/security/searchBluepagesForCB", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> searchBluepagesForCB(@RequestBody Map<String, String> search_map) {
		String search_type = search_map.get("search_type");
		String search_field = search_map.get("search_field");
		String search_keyword = search_map.get("search_keyword");
		String cwa_id = this.getIntranetID();
		String uid = this.getUserUid();
		//
		log.info("search_type:" + search_type);
		log.info("search_field:" + search_field);
		log.info("search_keyword:" + search_keyword);
		//
		Map bp_rtn = null;

		ResponseEntity<Object> entity = null;
		if (search_type.equalsIgnoreCase("user")) {
			if (search_field.equalsIgnoreCase("user_name")) {
				bp_rtn = searchUserByName(search_keyword);
			}
			if (search_field.equalsIgnoreCase("user_notes")) {
				bp_rtn = searchUserByNotes(search_keyword);
			}
			if (search_field.equalsIgnoreCase("user_cwa")) {
				bp_rtn = searchUserByMail(search_keyword);
			}
			if (search_field.equalsIgnoreCase("user_uid")) {
				bp_rtn = searchUserBySN(search_keyword);
			}
			if (bp_rtn != null) {
				Map bp_search = (Map) bp_rtn.get("search");
				Map bp_return = (Map) bp_search.get("return");
				List<Map> bp_entries = (List<Map>) bp_search.get("entry");
				Integer bp_code = (Integer) bp_return.get("code");
				String bp_message = (String) bp_return.get("message");
				Integer bp_count = (Integer) bp_return.get("count");
				if (bp_count < 1) {
					if (bp_code == 0) {
						entity = new ResponseEntity<Object>("Can not find any user.", HttpStatus.NOT_FOUND);
					} else {
						entity = new ResponseEntity<Object>(bp_message, HttpStatus.NOT_FOUND);
					}

				} else {
					List<Map> users = new ArrayList<Map>();
					for (Map entry : bp_entries) {
						Map<String, String> cb_user = new LinkedHashMap<String, String>();
						List<Map> attributes = (List<Map>) entry.get("attribute");
						cb_user.put("permission_type", "U");
						for (Map attribute : attributes) {
							if (attribute.get("name").toString().equalsIgnoreCase("mail")) {
								cb_user.put("permission_mail", ((List) attribute.get("value")).get(0).toString());
							}
							if (attribute.get("name").toString().equalsIgnoreCase("callupname")) {
								cb_user.put("permission_name", ((List) attribute.get("value")).get(0).toString());
							}
						}
						users.add(cb_user);
					}
					entity = new ResponseEntity<Object>(users, HttpStatus.OK);
				}
			} else {
				entity = new ResponseEntity<Object>("Failed to search bluepages, please try again later.",
						HttpStatus.SERVICE_UNAVAILABLE);
			}
		} else {
			if (search_field.equalsIgnoreCase("group_name")) {
				bp_rtn = searchBlueGroupsByName(search_keyword, cwa_id, uid);
			}
			if (search_field.equalsIgnoreCase("group_owner_cwa")) {
				bp_rtn = searchBlueGroupsByOwner(search_keyword, cwa_id, uid);
			}
			if (search_field.equalsIgnoreCase("group_owner_uid")) {
				bp_rtn = searchBlueGroupsByOwnerSN(search_keyword, cwa_id, uid);
			}
			if (bp_rtn != null) {
				Map bp_search = (Map) bp_rtn.get("search");
				Map bp_return = (Map) bp_search.get("return");
				List<Map> bp_entries = (List<Map>) bp_search.get("entry");
				Integer bp_code = (Integer) bp_return.get("code");
				String bp_message = (String) bp_return.get("message");
				Integer bp_count = (Integer) bp_return.get("count");
				if (bp_count < 1) {
					if (bp_code == 0) {
						entity = new ResponseEntity<Object>("Can not find any group.", HttpStatus.NOT_FOUND);
					} else {
						entity = new ResponseEntity<Object>(bp_message, HttpStatus.NOT_FOUND);
					}

				} else {
					List<Map> groups = new ArrayList<Map>();
					for (Map entry : bp_entries) {
						Map<String, String> cb_group = new LinkedHashMap<String, String>();
						List<Map> attributes = (List<Map>) entry.get("attribute");
						cb_group.put("permission_type", "G");
						String bp_desc = "";
						String memberCount = "0";
						for (Map attribute : attributes) {
							if (attribute.get("name").toString().equalsIgnoreCase("description")) {
								bp_desc = ((List) attribute.get("value")).get(0).toString();
							}
							if (attribute.get("name").toString().equalsIgnoreCase("membercount")) {
								memberCount = ((List) attribute.get("value")).get(0).toString();
							}

							if (attribute.get("name").toString().equalsIgnoreCase("cn")) {
								cb_group.put("permission_name", ((List) attribute.get("value")).get(0).toString());
							}
						}

						if (null != bp_desc && !bp_desc.equals("")) {
							cb_group.put("permission_mail", bp_desc + " (member count:" + memberCount + ")");
						} else {
							cb_group.put("permission_mail", "(member count:" + memberCount + ")");
						}

						groups.add(cb_group);
					}
					entity = new ResponseEntity<Object>(groups, HttpStatus.OK);
				}
			} else {
				entity = new ResponseEntity<Object>("Failed to search bluepages, please try again later.",
						HttpStatus.SERVICE_UNAVAILABLE);
			}
		}

		return entity;
	}

	@RequestMapping(value = "/portal/security/searchUserByMail", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> searchUserByMail(@RequestParam String cwa_id) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
		mapper.configure(Feature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER, true);
		mapper.configure(Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
		//
		try {
			String jsonObjectData = this.getRestTemplate()
					.getForObject(bp_search_person_byMail_URL, String.class, cwa_id);
			Map<String, Object> m = mapper.readValue(jsonObjectData, Map.class);
			return m;
		} catch (JsonParseException e) {
			e.printStackTrace();
			log.error(e);
		} catch (JsonMappingException e) {
			e.printStackTrace();
			log.error(e);
		} catch (IOException e) {
			e.printStackTrace();
			log.error(e);
		}
		return null;
	}

	public Map<String, Object> searchUserBySN(@RequestParam String uid) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
		mapper.configure(Feature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER, true);
		mapper.configure(Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
		//
		try {
			String jsonObjectData = this.getRestTemplate().getForObject(bp_search_person_bySN_URL, String.class, uid);
			Map<String, Object> m = mapper.readValue(jsonObjectData, Map.class);
			return m;
		} catch (JsonParseException e) {
			e.printStackTrace();
			log.error(e);
		} catch (JsonMappingException e) {
			e.printStackTrace();
			log.error(e);
		} catch (IOException e) {
			e.printStackTrace();
			log.error(e);
		}
		return null;
	}

	public Map<String, Object> searchUserByName(@RequestParam String name) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
		mapper.configure(Feature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER, true);
		mapper.configure(Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
		//
		try {
			String jsonObjectData = this.getRestTemplate()
					.getForObject(bp_search_person_byName_URL, String.class, name + "*");
			Map<String, Object> m = mapper.readValue(jsonObjectData, Map.class);
			return m;
		} catch (JsonParseException e) {
			e.printStackTrace();
			log.error(e);
		} catch (JsonMappingException e) {
			e.printStackTrace();
			log.error(e);
		} catch (IOException e) {
			e.printStackTrace();
			log.error(e);
		}
		return null;
	}

	public Map<String, Object> searchUserByNotes(@RequestParam String notes) {

		// need to convert notes to this format CN=Yu Tao Zhao/OU=China/O=IBM
		String[] token = notes.split("/");
		String notes_add = "";
		for (int i = 0; i < token.length; i++) {
			if (i == 0) {
				notes_add += "CN=" + token[0];
			}
			if (i == 1) {
				notes_add += "/OU=" + token[1];
			}
			if (i == 2) {
				notes_add += "/O=" + token[2];
			}
		}
		notes_add += "*";

		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
		mapper.configure(Feature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER, true);
		mapper.configure(Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
		//
		try {
			String jsonObjectData = this.getRestTemplate()
					.getForObject(bp_search_person_byNotes_URL, String.class, notes_add);
			Map<String, Object> m = mapper.readValue(jsonObjectData, Map.class);
			return m;
		} catch (JsonParseException e) {
			e.printStackTrace();
			log.error(e);
		} catch (JsonMappingException e) {
			e.printStackTrace();
			log.error(e);
		} catch (IOException e) {
			e.printStackTrace();
			log.error(e);
		}
		return null;
	}

	public Map<String, Object> searchBlueGroupsByName(
			@RequestParam String name,
			@RequestParam String cwa_id,
			@RequestParam String uid) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
		mapper.configure(Feature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER, true);
		mapper.configure(Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
		try {
			String jsonObjectData = this.getRestTemplate().getForObject(
					bg_search_bluegroup_byName_URL,
					String.class,
					name + "*",
					"uid=" + uid + "*",
					"uid=" + uid + "*");
			Map<String, Object> m = mapper.readValue(jsonObjectData, Map.class);
			return m;
		} catch (JsonParseException e) {
			e.printStackTrace();
			log.error(e);
		} catch (JsonMappingException e) {
			e.printStackTrace();
			log.error(e);
		} catch (IOException e) {
			e.printStackTrace();
			log.error(e);
		}
		return null;
	}

	public Map<String, Object> searchBlueGroupsByOwner(
			@RequestParam String owner_email,
			@RequestParam String cwa_id,
			@RequestParam String uid) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
		mapper.configure(Feature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER, true);
		mapper.configure(Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);

		try {

			Map owner = searchUserByMail(owner_email);
			if (owner == null) {
				return null;
			}

			Map bp_search = (Map) owner.get("search");
			Map bp_return = (Map) bp_search.get("return");
			List<Map> bp_entries = (List<Map>) bp_search.get("entry");
			Integer bp_code = (Integer) bp_return.get("code");
			String bp_message = (String) bp_return.get("message");
			Integer bp_count = (Integer) bp_return.get("count");
			String owner_uid = "";
			if (bp_count < 1) {
				return null;
			} else {
				for (Map entry : bp_entries) {
					List<Map> attributes = (List<Map>) entry.get("attribute");
					for (Map attribute : attributes) {
						if (attribute.get("name").toString().equalsIgnoreCase("uid")) {
							owner_uid = ((List) attribute.get("value")).get(0).toString();
							break;
						}
					}
				}
			}
			if ("".equals(owner_uid)) {
				return null;
			}

			String jsonObjectData = this.getRestTemplate().getForObject(
					bg_search_bluegroup_byOwner_URL,
					String.class,
					"uid=" + owner_uid + "*",
					"uid=" + uid + "*",
					"uid=" + uid + "*");
			Map<String, Object> m = mapper.readValue(jsonObjectData, Map.class);
			return m;
		} catch (JsonParseException e) {
			e.printStackTrace();
			log.error(e);
		} catch (JsonMappingException e) {
			e.printStackTrace();
			log.error(e);
		} catch (IOException e) {
			e.printStackTrace();
			log.error(e);
		}
		return null;
	}

	public Map<String, Object> searchBlueGroupsByOwnerSN(
			@RequestParam String owner_sn,
			@RequestParam String cwa_id,
			@RequestParam String uid) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
		mapper.configure(Feature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER, true);
		mapper.configure(Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
		try {
			String jsonObjectData = this.getRestTemplate().getForObject(
					bg_search_bluegroup_byOwner_URL,
					String.class,
					"uid=" + owner_sn + "*",
					"uid=" + uid + "*",
					"uid=" + uid + "*");
			Map<String, Object> m = mapper.readValue(jsonObjectData, Map.class);
			return m;
		} catch (JsonParseException e) {
			e.printStackTrace();
			log.error(e);
		} catch (JsonMappingException e) {
			e.printStackTrace();
			log.error(e);
		} catch (IOException e) {
			e.printStackTrace();
			log.error(e);
		}
		return null;
	}

}
