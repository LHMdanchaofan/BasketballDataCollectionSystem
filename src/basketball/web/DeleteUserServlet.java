package basketball.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import basketball.dao.UserDao;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class DeleteUserServlet extends HttpServlet{
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
		int identity=Integer.parseInt(request.getParameter("identity"));
		int Id=Integer.parseInt(request.getParameter("Id"));
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			if(identity==1){
				int delnum=userDao.deleteStudentUser(con, Id);
				if(delnum>0){
					result.put("result", "success");
				}else{
					result.put("result", "error");
					result.put("errorMsg", "删除失败");
				}
			}else if(identity==2){
				int stunum=userDao.coastuCount(con, Id);
				if(stunum>0){
					result.put("result", "error");
					result.put("errorMsg", "该教练用户下有学员用户");
				}else{
					int delnum=userDao.deleteCoachUser(con, Id);
					if(delnum>0){
						result.put("result", "success");
					}else{
						result.put("result", "error");
						result.put("errorMsg", "删除失败");
					}
				}
			}else if(identity==3){
				int coanum=userDao.clubcoaCount(con, Id);
				if(coanum>0){
					result.put("result", "error");
					result.put("errorMsg", "该训练中心下有教练用户");
				}else{
					int delnum=userDao.deleteClubUser(con, Id);
					if(delnum>0){
						result.put("result", "success");
					}else{
						result.put("result", "error");
						result.put("errorMsg", "删除失败");
					}
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
