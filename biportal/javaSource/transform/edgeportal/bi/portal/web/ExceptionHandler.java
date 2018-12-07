package transform.edgeportal.bi.portal.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExceptionHandler {

	private static Logger	log	= Logger.getLogger(ExceptionHandler.class);

	/**
	 * 
	 javax.servlet.error.status_code
	 * javax.servlet.error.exception_type
	 * javax.servlet.error.message
	 * javax.servlet.error.request_uri
	 * javax.servlet.error.exception
	 * javax.servlet.error.servlet_name
	 */
	@RequestMapping(value = "/exception")
	public void getException(HttpServletRequest request, HttpServletResponse response) {
		Class exType = (Class) request.getAttribute("javax.servlet.error.exception_type");
		String reason = (String) request.getAttribute("javax.servlet.error.message");
		Exception ex = (Exception) request.getAttribute("javax.servlet.error.exception");
		log.error("biportal error:" + reason);

	}

}
