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

public class AddUserServlet extends HttpServlet{
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
		request.setCharacterEncoding("utf-8");
		String username=request.getParameter("addusername");
		String password=request.getParameter("addpassword");
		int identity=Integer.parseInt(request.getParameter("identity"));
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			if(identity==1){
				int equalname=userDao.equalname(con, username);
				if(equalname>0){
					 result.put("result", "�û����Ѵ���");
				}else{
					String name=request.getParameter("name");
					int coaId=Integer.parseInt(request.getParameter("coaId"));
					int stuId=userDao.addStudentUser(con,username,password);
					if(stuId>0){
						userDao.addapply(con, stuId, coaId, name);
						result.put("result", "�����,��Ⱥ�");
					}else{
						result.put("result", "ע��ʧ��");
					}
				}
			}else if(identity==2){
				int equalname=userDao.equalname(con, username);
				if(equalname>0){
					 result.put("result", "�û����Ѵ���");
				}else{
					HttpSession session=request.getSession();
					User currentUser=new User();
					currentUser=(User)session.getAttribute("currentUser");
					int addnum=userDao.addCoachUser(con, username,password,currentUser);
					if(addnum>0){
						result.put("result", "��ӳɹ�");
					}else{
						result.put("result", "���ʧ��");
					}	
				}
			}else if(identity==3){
				int equalname=userDao.equalname(con, username);
				if(equalname>0){
					 result.put("result", "�û����Ѵ���");
				}else{
					int addnum=userDao.addClubUser(con, username,password);
					if(addnum>0){
						result.put("result", "��ӳɹ�");
					}else{
						result.put("result", "���ʧ��");
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
