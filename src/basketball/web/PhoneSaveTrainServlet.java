package basketball.web;

import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import basketball.dao.TrainDao;
import basketball.model.PageBean;
import basketball.model.User;
import basketball.model.Student;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import basketball.util.DateUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class PhoneSaveTrainServlet extends HttpServlet{
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
		String trains=request.getParameter("score");
        String type=request.getParameter("type");
        int savenum;
        savenum=0;
		Connection con=null;
		try {
			Date now=new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
			String addtime=df.format(now);
			//System.out.println(addtime);
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			JSONArray jar=JSONArray.fromObject(trains);
			if(type.equals("1")||type.equals("3")||type.equals("4")){
			   for(int i=0;i<jar.size();i++){
				     String score=Integer.parseInt(jar.getJSONObject(i).getString("score").substring(0, 2))*60+Integer.parseInt(jar.getJSONObject(i).getString("score").substring(3, 5))+"."+jar.getJSONObject(i).getString("score").substring(6, 8);
				     savenum=savenum+trainDao.savetemporarytrain(con, jar.getJSONObject(i).getInt("Id"), score,addtime, type);
				   }	
		    }else if(type.equals("5")){
		    	for(int i=0;i<jar.size();i++){
				     String score=jar.getJSONObject(i).getString("score");
				     savenum=savenum+trainDao.savetemporarytrain(con, jar.getJSONObject(i).getInt("Id"), score,addtime, type);
				   }
		    }else if(type.equals("2")){
		    	for(int i=0;i<jar.size();i++){
				     String score=jar.getJSONObject(i).getString("score");
				     savenum=savenum+trainDao.savetemporarytrain(con, jar.getJSONObject(i).getInt("Id"), score,addtime, type);
				   }
		    }
			result.put("result", savenum);
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
