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
import basketball.dao.UserDao;
import basketball.model.User;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;


public class GetClubCoaServlet extends HttpServlet{
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
		String province=request.getParameter("province");
		if(StringUtil.isNotEmpty(province)){
		    province=new String(province.getBytes("iso8859-1"),"utf-8");
		}
		String clubId=request.getParameter("clubId");
		Connection con=null;
		try{
			con=dbUtil.getCon();
			JSONArray jsonArray=new JSONArray();
			if(StringUtil.isNotEmpty(province)){
				jsonArray.addAll(JsonUtil.formatRsToJsonArray(userDao.getClub(con, province)));
			}else if(StringUtil.isNotEmpty(clubId)){
				jsonArray.addAll(JsonUtil.formatRsToJsonArray(userDao.getCoach(con, clubId)));
			}
			ResponseUtil.write(response, jsonArray);
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
