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

public class LoginServlet extends HttpServlet{
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
		int iden=0;
		HttpSession session=request.getSession();
		String userName=request.getParameter("username");
		String passWord=request.getParameter("password");
		String identity=request.getParameter("identity");
		if(StringUtil.isNotEmpty(identity)){
			 iden=Integer.parseInt(identity);
		}
		if(StringUtil.isEmpty(userName)||StringUtil.isEmpty(passWord)){
			response.sendRedirect("web/pages/login.jsp?result=1");
			return;
		}
		else if(iden==0)
		{
			response.sendRedirect("web/pages/login.jsp?result=2");
			return;
		}
		User user=new User(0,userName,passWord,iden);
		Connection con=null;
		try {
			con=dbUtil.getCon();
			User currentUser=userDao.login(con, user);
			if(currentUser==null){
				// 服务器跳转
				response.sendRedirect("web/pages/login.jsp?result=3");
			}else if(currentUser.getApply()==1){
				response.sendRedirect("web/pages/login.jsp?result=4");
		   }else{
				session.setAttribute("currentUser", currentUser);
				//// 客户端跳转
				if(iden == 1){
					response.sendRedirect("web/pages/main.jsp");
					return;
			    }else if(iden==2){
				    response.sendRedirect("web/pages/coachmain.jsp");
				    return;
				}else if(iden==3){
					response.sendRedirect("web/pages/clubmain.jsp");
				    return;
				}else{
					response.sendRedirect("web/pages/adminmain.jsp");
				    return;
				}
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
