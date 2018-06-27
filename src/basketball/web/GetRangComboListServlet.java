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
import basketball.dao.TrainDao;
import basketball.model.User;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;

public class GetRangComboListServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();
	TrainDao trainDao=new TrainDao();
	
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
		Connection con=null;
		try{
			con=dbUtil.getCon();
			JSONArray jsonArray=new JSONArray();
			JSONObject jsonObject=new JSONObject();
			jsonObject.put("rangId", "1");
			jsonObject.put("rangtext", "È«¹ú");
			jsonArray.add(jsonObject);
			jsonObject.put("rangId", "2");
			jsonObject.put("rangtext", trainDao.rangpr(con, currentUser.getId(),currentUser.getIdentity()));
			jsonArray.add(jsonObject);
			jsonObject.put("rangId", "3");
			jsonObject.put("rangtext", trainDao.rangcl(con, currentUser.getId(),currentUser.getIdentity()));
			jsonArray.add(jsonObject);
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
