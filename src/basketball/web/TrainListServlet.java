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
import basketball.model.SearchTrain;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import basketball.util.DateUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TrainListServlet extends HttpServlet{
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
		int stuId;
		HttpSession session=request.getSession();
		User currentUser=new User();
		currentUser=(User)session.getAttribute("currentUser");
		String Id=request.getParameter("id");
		if(StringUtil.isEmpty(Id)&&currentUser.getIdentity()==2){
			return;
		}else if(StringUtil.isNotEmpty(Id)&&currentUser.getIdentity()==2){
			stuId=Integer.parseInt(Id);
		}else{
			stuId=currentUser.getId();
		}
		SearchTrain searchTrain=new SearchTrain();
		String btime=request.getParameter("begintime");
		String etime=request.getParameter("endtime");
		String bsr=request.getParameter("beginshuttlerun");
		String esr=request.getParameter("endshuttlerun");
		String bbp=request.getParameter("beginbenchpress");
		String ebp=request.getParameter("endbenchpress");
		String bfm=request.getParameter("begin50meters");
		String efm=request.getParameter("end50meters");
		String bom=request.getParameter("begin1000meters");
		String eom=request.getParameter("end1000meters");
		String bss=request.getParameter("beginsetshot");
		String ess=request.getParameter("endsetshot");
		if(StringUtil.isNotEmpty(btime)){
			searchTrain.setBegintime(btime);
		}
		if(StringUtil.isNotEmpty(etime)){
			searchTrain.setEndtime(etime);
			
		}
		if(StringUtil.isNotEmpty(bsr)){
			Double beginshuttlerun=Double.parseDouble(bsr);
			searchTrain.setBeginshuttlerun(beginshuttlerun);			
		}
		if(StringUtil.isNotEmpty(esr)){
			Double endshuttlerun=Double.parseDouble(esr);
			searchTrain.setEndshuttlerun(endshuttlerun);
		}
		if(StringUtil.isNotEmpty(bbp)){
			Double beginbenchpress=Double.parseDouble(bbp);
			searchTrain.setBeginbenchpress(beginbenchpress);
		}
		if(StringUtil.isNotEmpty(ebp)){
			Double endbenchpress=Double.parseDouble(ebp);
			searchTrain.setEndbenchpress(endbenchpress);
		}
		if(StringUtil.isNotEmpty(bfm)){
			Double begin50meters=Double.parseDouble(bfm);
			searchTrain.setBegin50meters(begin50meters);
		}
		if(StringUtil.isNotEmpty(efm)){
			Double end50meters=Double.parseDouble(efm);
			searchTrain.setEnd50meters(end50meters);
		}
		if(StringUtil.isNotEmpty(bom)){
			Double begin1000meters=Double.parseDouble(bom);
			searchTrain.setBegin1000meters(begin1000meters);
		}
		if(StringUtil.isNotEmpty(eom)){
			Double end1000meters=Double.parseDouble(eom);
			searchTrain.setEnd1000meters(end1000meters);
		}
		if(StringUtil.isNotEmpty(bss)){
			Double beginsetshot=Double.parseDouble(bss);
			searchTrain.setBeginsetshot(beginsetshot);
		}
		if(StringUtil.isNotEmpty(ess)){
			Double endsetshot=Double.parseDouble(ess);
			searchTrain.setEndsetshot(endsetshot);
		}
		int page=Integer.parseInt(request.getParameter("page"));
		int rows=Integer.parseInt(request.getParameter("rows"));
		PageBean pageBean=new PageBean(page,rows);
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			int total=trainDao.trainCount(con,stuId,searchTrain);
			JSONArray jsonArray=JsonUtil.formatRsToJsonArray(trainDao.trainList(con,stuId,pageBean,searchTrain));
			result.put("rows", jsonArray);
			result.put("total", total);
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
