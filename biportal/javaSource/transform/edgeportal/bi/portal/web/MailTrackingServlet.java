
/**
 * Project Name: biportal
 * File Name: transform.edgeportal.bi.portal.web.MailTrackingServlet.java
 * Date: Feb 27, 2018
 * 
 * @author zhaoyutao
 *         Copyright(c) 2018, IBM BI@IBM All Rights Reserved.
 */
package transform.edgeportal.bi.portal.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.Properties;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.support.WebApplicationContextUtils;
import transform.edgeportal.bi.jpa.emailcenter.CognosEmailReadLog;

/**
 * ClassName: MailTrackingServlet <br/>
 * Description: TODO <br/>
 * Date: Feb 27, 2018 <br/>
 * 
 * @author zhaoyutao
 */
public class MailTrackingServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long	serialVersionUID			= -1668409966239843396L;

	private static final Logger	log							= Logger.getLogger(MailTrackingServlet.class);

	private String				appConfigLocation			= "";
	private ApplicationContext	ac							= null;
	private Properties			prop						= null;
	private String				postEmailReadingLog_URL		= "postEmailReadingLog_URL";

	@Override
	public void init(ServletConfig config) throws ServletException {

		appConfigLocation = config.getInitParameter("appConfigLocation");
		//
		ac = WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
		
		Resource r = WebApplicationContextUtils.getWebApplicationContext(config.getServletContext()).getResource(appConfigLocation);
	
		InputStream in = null;
		try {
			in = r.getInputStream();
			prop = new Properties();
			prop.load(in);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String request_type = request.getParameter("request_type");
		String request_id = request.getParameter("request_id");
		String running_id = request.getParameter("running_id");
		if (request_type == null || request_id == null || running_id == null) {
			request.getRequestDispatcher("images/em.png").forward(request, response);
		}
		log.info("request_type:" + request_type);
		log.info("request_id:" + request_id);
		log.info("running_id:" + running_id);

		try {
			String post_url = this.getProperties("restfulServerUrl")+this.getProperties(postEmailReadingLog_URL);
			RestTemplate restTemplate = this.getRestTemplate();
			CognosEmailReadLog cerl = new CognosEmailReadLog();
			cerl.setCuuid(Long.valueOf(0));
			cerl.setRequestType(request_type);
			cerl.setRequestId(request_id);
			cerl.setRunningId(running_id);
			cerl.setAccessTime(new Timestamp(System.currentTimeMillis()));
			ResponseEntity<String> entity = restTemplate.postForEntity(post_url, cerl, String.class);
			if (!entity.getStatusCode().equals(HttpStatus.OK)) {
				log.error(entity.getBody());
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
		}

		request.getRequestDispatcher("images/em.png").forward(request, response);

	}

	private RestTemplate getRestTemplate() throws Exception {
		if (ac != null) {
			try {
				
				RestTemplate restTemplate = ac.getBean("restTemplate", RestTemplate.class);
				return restTemplate;
			} catch (Exception e) {
				throw e;
			}

		}
		return null;
	}

	private String getProperties(String key) {
		if (prop != null) {
			return prop.getProperty(key);
		}
		return null;
	}

}
