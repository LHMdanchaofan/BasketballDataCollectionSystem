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
import basketball.model.DataChart;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import basketball.util.DataContrastUtil;;

public class DataContrastServlet extends HttpServlet{
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
		String stuId=request.getParameter("stuId");
		int Id;
		if(StringUtil.isEmpty(stuId)){
			HttpSession session=request.getSession();
			User currentUser=new User();
			currentUser=(User)session.getAttribute("currentUser");
			Id=currentUser.getId();
		}else{
			Id=Integer.parseInt(stuId);
		}
		Connection con=null;
		try{
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			JSONArray jsonarray=JSONArray.fromObject(DataContrastUtil.datacontrast(trainDao.besttrain(con, Id), trainDao.mybesttrain(con, Id), trainDao.worsttrain(con, Id)));
			result.put("data", jsonarray);
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
