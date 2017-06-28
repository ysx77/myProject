package util;

import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.util.HashMap;

public class testFilter extends HttpServlet implements Filter {
	private FilterConfig filterConfig;

	// Handle the passed-in FilterConfig
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

	// Process the request/response pair
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterChain) {
		try {
			((HttpServletResponse)response).sendRedirect("http://172.29.165.81:808/tbm/index.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// Clean up resources
	public void destroy() {
	}
}
