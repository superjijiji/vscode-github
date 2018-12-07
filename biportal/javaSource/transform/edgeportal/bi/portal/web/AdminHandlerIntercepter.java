package transform.edgeportal.bi.portal.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import transform.edgeportal.bi.jpa.link.Link;

public class AdminHandlerIntercepter extends HandlerInterceptorAdapter{
	
	private static final Logger log = Logger.getLogger(AdminHandlerIntercepter.class);

	@Value("${bluegroupXmlApi_inOneGroup}")
	private String BLUEGROUP_XML_API_IN_ONE_GROUP;
	
	@Value("${link_adminSecurity}")
	private String linkByModule;	
	
	@Value("${restfulServerUrl}")
	private String restfulServerUrl;	
	
	@Autowired
	private RestTemplate	restTemplate;
	
	public String checkSecurity(HttpServletRequest request, String cwa_id, String module) {
		Link aLink = null;
		Link[] links = null; 
		try {
			links = this.restTemplate.getForObject(restfulServerUrl + linkByModule, Link[].class, cwa_id, module);
			if (links.length < 1) {
				return "System error: there is no security configuration for this module"; 
			}
			aLink = links[0]; //supposedly only a security role is configured for 1 module in EOD.LINK table.
			request.setAttribute("eodlink", aLink);
		} catch (Exception e) {
			log.error("RestClientException in checkSecurity: " + e.getMessage());
			return "System error: error in getting security role, rest client issue, probably timeout."; // do NOT expose rest url 
		}
		String role = aLink.getRole();	
		if (role == null) {
			role="weirdNoRoleIsSetUpForThis";
		}
		if (!role.equalsIgnoreCase("public")) { //supposedly nobody set 'public' to secure a module. 
			try {
				String text = this.restTemplate.getForObject(BLUEGROUP_XML_API_IN_ONE_GROUP, String.class, cwa_id, role);
				if ( text.contains("<rc>0</rc>") ) {
					return "success"; 
				} else {
					return "Sorry, you do not have permission to access this panel";
				}		
			} catch (Exception e) {
				return "System error: error in accessing bluegroups server. "+e.getMessage();
			}			
		}		
		return "success"; 
	}	
	
    @Override  
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) 
    		throws Exception { 
    		// user 		/transform/biportal/action/portal/index
    		// admin		/transform/biportal/action/admin/linkAdmin/listPage
    		// count		0    1       2       3      4      5
    		String requestURI = request.getRequestURI();  
    		String[] keys     = requestURI.split("/");  
    		if (keys.length < 6) {
    					return true; 
    		} else {
        		if (keys[4].equalsIgnoreCase("admin")) {
        			String loginUserEmail = request.getRemoteUser();
        			       loginUserEmail = loginUserEmail.substring(loginUserEmail.lastIndexOf("/") + 1);
        			String msg            = this.checkSecurity(request, loginUserEmail, keys[5]);  
        			if (msg.equalsIgnoreCase("success")) {
        				return true; 
        			} else {
        				request.getSession().setAttribute("errMsg", loginUserEmail+" does NOT have proper access to "+keys[4]+"-"+keys[5]+". "+msg);
        				request.getRequestDispatcher("/401.jsp").forward(request, response);  
        				return false; 
        			}					
        		} else {
        				return true; 
        		}   			
    		}
    } 
}
