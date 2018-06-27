package basketball.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import basketball.dao.UserDao;
import basketball.model.User;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class PhoneLoginServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();	
	UserDao userDao=new UserDao();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session=request.getSession();
		String userName=request.getParameter("username");
		String passWord=request.getParameter("password");
		if(StringUtil.isEmpty(userName)||StringUtil.isEmpty(passWord)){
			response.sendRedirect("web/h5/login.html?result=1");
			return;
		}
		User user=new User(0,userName,passWord,2);
		Connection con=null;
		try {
			con=dbUtil.getCon();
			User currentUser=userDao.login(con, user);
			if(currentUser==null){
				// ·þÎñÆ÷Ìø×ª
				response.sendRedirect("web/h5/login.html?result=2");
			}else{
				session.setAttribute("currentUser", currentUser);
				    response.sendRedirect("web/h5/app.jsp");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				dbUtil.closeCon(con);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	}
