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

public class ModifyPWServlet extends HttpServlet{
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
		User currentUser=new User();
		currentUser=(User)session.getAttribute("currentUser");
		String oldpw;
		String newpw;
		int Id;
		if(StringUtil.isNotEmpty(request.getParameter("Id"))){
			Id=Integer.parseInt(request.getParameter("Id"));
		    oldpw=request.getParameter("oldpassword");
			newpw=request.getParameter("password");
		}else{
			Id=currentUser.getId();
			oldpw=request.getParameter("oldpw");
			newpw=request.getParameter("newpw");
		}
		Connection con=null;
		try {
			con=dbUtil.getCon();
			String pw=userDao.getpassword(con, Id);
			JSONObject result=new JSONObject();
			if(oldpw.equals(pw)){
				int modiefynum=userDao.modifypw(con, Id, newpw);
				if(modiefynum==1){
					result.put("information", "ÐÞ¸Ä³É¹¦");
				}else{
					result.put("information", "ÐÞ¸ÄÊ§°Ü");
				}
			}else{				
				result.put("information", "ÃÜÂë´íÎó");				
			}
			ResponseUtil.write(response, result);
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
