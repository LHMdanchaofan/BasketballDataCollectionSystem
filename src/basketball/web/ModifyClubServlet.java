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

public class ModifyClubServlet extends HttpServlet{
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
		int coaId=Integer.parseInt(request.getParameter("coaId"));
		HttpSession session=request.getSession();
		User currentUser=new User();
		currentUser=(User)session.getAttribute("currentUser");
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			int oldcoaId=userDao.getcoaId(con, currentUser.getId());
			if(coaId==oldcoaId){
				result.put("result", "不能选择相同的教练！");
			}else{
				int modifynum=userDao.modifyclub(con, currentUser.getId(), coaId);
				if(modifynum>0){
					session.invalidate();
					result.put("result", "审核中！请等候！");
				}else{
					result.put("result", "更换失败，请重试！");
				}
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
