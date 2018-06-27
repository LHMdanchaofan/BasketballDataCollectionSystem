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
import basketball.util.MonthUtil;

public class PersonalDataChartServlet extends HttpServlet{
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
		DataChart dataChart=new DataChart();
		String begintime=request.getParameter("begintime");
		String endtime=request.getParameter("endtime");
		String pj=request.getParameter("project");
		if(StringUtil.isNotEmpty(pj)){
			if(Integer.parseInt(pj)==1){
				dataChart.setProject("shuttlerun");
				dataChart.setProjectcn("折返跑");
				dataChart.setMeasure("/s");
			}else if(Integer.parseInt(pj)==2){
				dataChart.setProject("benchpress");
				dataChart.setProjectcn("卧推");
				dataChart.setMeasure("/kg");
			}else if(Integer.parseInt(pj)==3){
				dataChart.setProject("50meters");
				dataChart.setProjectcn("50米跑");
				dataChart.setMeasure("/s");
			}else if(Integer.parseInt(pj)==4){
				dataChart.setProject("1000meters");
				dataChart.setProjectcn("1000米跑");
				dataChart.setMeasure("/s");
			}else if(Integer.parseInt(pj)==5){
				dataChart.setProject("setshot");
				dataChart.setProjectcn("定点投篮");
				dataChart.setMeasure("/个");
			}
		}
		HttpSession session=request.getSession();
		User currentUser=new User();
		currentUser=(User)session.getAttribute("currentUser");
		Connection con=null;
		try{
			con=dbUtil.getCon();
			if(StringUtil.isNotEmpty(begintime)){
				dataChart.setBegintime(begintime);
			}else{
				dataChart.setBegintime(trainDao.DataChartbegintime(con, currentUser.getId()));
			}
			if(StringUtil.isNotEmpty(endtime)){
				dataChart.setEndtime(endtime);
			}else{
				dataChart.setEndtime(trainDao.DataChartendtime(con, currentUser.getId()));
			}
			JSONObject result=new JSONObject();
			JSONArray xAxis=JSONArray.fromObject(MonthUtil.montharray(dataChart.getBegintime(),dataChart.getEndtime()));
			JSONArray data=JSONArray.fromObject(MonthUtil.dataarray(dataChart.getBegintime(),dataChart.getEndtime(),trainDao.DataChart(con, currentUser.getId(), dataChart)));
			result.put("project", dataChart.getProjectcn());
			result.put("xAxis", xAxis);
			result.put("data", data);
			result.put("measure", dataChart.getMeasure());
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
