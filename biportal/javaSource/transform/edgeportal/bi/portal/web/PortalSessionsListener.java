package transform.edgeportal.bi.portal.web;

import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Hashtable;
import java.util.Properties;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.client.RestTemplate;

@Controller
public class PortalSessionsListener implements HttpSessionAttributeListener, HttpSessionListener {

	private static Logger					log				= Logger.getLogger(PortalSessionsListener.class);
	private static InputStream				propIs			= Thread.currentThread().getContextClassLoader()
																	.getResourceAsStream("appConfig.properties");
	private static String					restfulAddPortalSessionUrl;
	private RestTemplate					restTemplate	= new RestTemplate();
	private Hashtable<String, HttpSession>	sessionTable	= new Hashtable<>();
	static {
		Properties props = new Properties();
		try {
			props.load(propIs);
			restfulAddPortalSessionUrl = props.get("restfulServerUrl").toString()
					+ props.get("addPortalSession").toString();
		} catch (IOException e) {
			log.error("Loading appConfig.properties for PortalSessionsListener failed.");
		} finally {
			try {
				propIs.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void attributeAdded(HttpSessionBindingEvent event) {
		attributeAct(event);
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent event) {}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent event) {}

	@Override
	public void sessionCreated(HttpSessionEvent event) {
		updateSession(event, "login");
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		updateSession(event, "logout");

	}

	private void attributeAct(HttpSessionBindingEvent event) {
		if (event.getSession() == null) {
			return;
		}

		if (event.getName().equals("cwa_id")) {
			updateSession(event, "login");
		}
	}

	@ModelAttribute
	private void updateSession(HttpSessionEvent event, String logType) {
		String hostName = "";
		try {
			hostName = InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}

		HttpSession session = event.getSession();
		if (session.getAttribute("cwa_id") == null) {
			return;
		}
		String userName = session.getAttribute("cwa_id").toString();
		String sessionID = session.getId();
		if (logType.equals("login")) {
			sessionTable.put(sessionID, session);
		} else if (logType.equals("logout")) {
			sessionTable.remove(sessionID);
		}

		PortalSeesionBean bean = new PortalSeesionBean();
		bean.setActiveTotal(sessionTable.size());
		bean.setCuuid(Long.valueOf(0));
		bean.setCwaId(userName);
		bean.setSessionId(sessionID);
		bean.setHostName(hostName);
		bean.setStatus(logType);

		restTemplate.postForObject(restfulAddPortalSessionUrl, bean, PortalSeesionBean.class);
	}

}
