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
import basketball.model.Train;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import basketball.util.MonthUtil;

public class ModifyTrainServlet extends HttpServlet{
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
		request.setCharacterEncoding("utf-8");
		Train train=new Train();
		int Id=Integer.parseInt(request.getParameter("Id"));
		String shuttlerun=request.getParameter("shuttlerun");
		String benchpress=request.getParameter("benchpress");
		String fmeters=request.getParameter("fmeters");
		String ometers=request.getParameter("ometers");
		String setshot=request.getParameter("setshot");
		String addtime=request.getParameter("addtime");
		if(StringUtil.isNotEmpty(shuttlerun)){
			train.setShuttlerun(shuttlerun);
		}
		if(StringUtil.isNotEmpty(benchpress)){
			train.setBenchpress(benchpress);
		}
		if(StringUtil.isNotEmpty(fmeters)){
			train.setFmeters(fmeters);
		}
		if(StringUtil.isNotEmpty(ometers)){
			train.setOmeters(ometers);
		}
		if(StringUtil.isNotEmpty(setshot)){
			train.setSetshot(setshot);
		}
		train.setAddtime(addtime);
		Connection con=null;
		try{
			con=dbUtil.getCon();
			trainDao.ModifyTrain(con, Id, train);		
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
