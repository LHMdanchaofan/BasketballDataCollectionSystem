package basketball.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSetMetaData;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import java.util.Calendar;

public class PhonePCDataChartServlet extends HttpServlet{
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
		Connection con=null;
		try{
			con=dbUtil.getCon();
			Date now=new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");//设置日期格式
			String endtime=df.format(now);
			Calendar cl= Calendar.getInstance();
			cl.setTime(now);
			cl.add(Calendar.MONTH,-5);
			String begintime=df.format(cl.getTime());
			JSONObject result=new JSONObject();
			JSONArray xAxis=JSONArray.fromObject(MonthUtil.montharray(begintime,endtime));
			JSONArray pcshuttlerun=JSONArray.fromObject(MonthUtil.dataarray(begintime,endtime,trainDao.PhonePCDataChart(con,1)));
			JSONArray pcbenchpress=JSONArray.fromObject(MonthUtil.dataarray(begintime,endtime,trainDao.PhonePCDataChart(con,2)));
			JSONArray pc50meters=JSONArray.fromObject(MonthUtil.dataarray(begintime,endtime,trainDao.PhonePCDataChart(con,3)));
			JSONArray pc1000meters=JSONArray.fromObject(MonthUtil.dataarray(begintime,endtime,trainDao.PhonePCDataChart(con,4)));
			JSONArray pcsetshot=JSONArray.fromObject(MonthUtil.dataarray(begintime,endtime,trainDao.PhonePCDataChart(con,5)));
			JSONArray phoneshuttlerun=JSONArray.fromObject(MonthUtil.dataarray(begintime,endtime,trainDao.PhonePCDataChart(con,6)));
			JSONArray phonebenchpress=JSONArray.fromObject(MonthUtil.dataarray(begintime,endtime,trainDao.PhonePCDataChart(con,7)));
			JSONArray phone50meters=JSONArray.fromObject(MonthUtil.dataarray(begintime,endtime,trainDao.PhonePCDataChart(con,8)));
			JSONArray phone1000meters=JSONArray.fromObject(MonthUtil.dataarray(begintime,endtime,trainDao.PhonePCDataChart(con,9)));
			JSONArray phonesetshot=JSONArray.fromObject(MonthUtil.dataarray(begintime,endtime,trainDao.PhonePCDataChart(con,10)));
			result.put("xAxis", xAxis);
			result.put("pcshuttlerun", pcshuttlerun);
			result.put("pcbenchpress", pcbenchpress);
			result.put("pc50meters", pc50meters);
			result.put("pc1000meters", pc1000meters);
			result.put("pcsetshot", pcsetshot);
			result.put("phoneshuttlerun", phoneshuttlerun);
			result.put("phonebenchpress", phonebenchpress);
			result.put("phone50meters", phone50meters);
			result.put("phone1000meters", phone1000meters);
			result.put("phonesetshot", phonesetshot);
			
			ResponseUtil.write(response, result);
			//System.out.println(begintime);
			//System.out.println(endtime);
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
