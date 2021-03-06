package basketball.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSetMetaData;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import java.sql.ResultSet;
import basketball.dao.StudentDao;
import basketball.dao.CoachDao;
import basketball.dao.ClubDao;
import basketball.model.User;
import basketball.model.DataChart;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import basketball.util.MonthUtil;

public class PersonalInformationServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String identity=request.getParameter("identity");
		String id=request.getParameter("Id");
		HttpSession session=request.getSession();
		User currentUser=new User();
		currentUser=(User)session.getAttribute("currentUser");
		Connection con=null;
		try{
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			JSONArray jsonArray=new JSONArray();
			if(StringUtil.isNotEmpty(identity)){
				if(identity.equals("2")){
					CoachDao coachDao=new CoachDao();
					jsonArray=JsonUtil.formatRsToJsonArray(coachDao.personalinformation(con,Integer.parseInt(id)));
				}else if(identity.equals("3")){
					ClubDao clubDao=new ClubDao();
					jsonArray=JsonUtil.formatRsToJsonArray(clubDao.personalinformation(con,Integer.parseInt(id)));
				}
			}else{
				if(currentUser.getIdentity()==1){
					StudentDao studentDao=new StudentDao();
					jsonArray=JsonUtil.formatRsToJsonArray(studentDao.personalinformation(con,currentUser.getId()));
				}else if(currentUser.getIdentity()==2){
					CoachDao coachDao=new CoachDao();
					jsonArray=JsonUtil.formatRsToJsonArray(coachDao.personalinformation(con,currentUser.getId()));
				}else if(currentUser.getIdentity()==3){
					ClubDao clubDao=new ClubDao();
					jsonArray=JsonUtil.formatRsToJsonArray(clubDao.personalinformation(con,currentUser.getId()));
				}
			}
			result.put("result", jsonArray);
			ResponseUtil.write(response, result);
		}catch(Exception e){
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
