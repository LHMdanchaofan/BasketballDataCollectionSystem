package basketball.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import basketball.dao.UserDao;
import basketball.model.PageBean;
import basketball.model.User;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class GetApplyServlet extends HttpServlet{
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
		int page=Integer.parseInt(request.getParameter("page"));
		int rows=Integer.parseInt(request.getParameter("rows"));
		PageBean pageBean=new PageBean(page,rows);
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			JSONArray jsonArray=JsonUtil.formatRsToJsonArray(userDao.getApply(con,currentUser.getId(),pageBean));
			int total=userDao.getApplyCount(con, currentUser.getId());
			result.put("rows", jsonArray);
			result.put("total", total);
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
