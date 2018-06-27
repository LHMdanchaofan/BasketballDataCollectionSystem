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
import basketball.model.SearchData;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.model.Sortinfo;
import basketball.util.StringUtil;
import basketball.util.DateUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class RankListServlet extends HttpServlet{
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
		String id=request.getParameter("id");
		int stuId;
		String drang=request.getParameter("datarang");
		String dtype=request.getParameter("datatype");
		String dtime=request.getParameter("datatime");
		SearchData searchData=new SearchData();
		if(StringUtil.isNotEmpty(drang)){
			searchData.setDatarang(Integer.parseInt(drang));
		}
		if(StringUtil.isNotEmpty(dtype)){
			searchData.setDatatype(Integer.parseInt(dtype));
		}
		if(StringUtil.isNotEmpty(dtime)){
			searchData.setDatatime(Integer.parseInt(dtime));
		}
		HttpSession session=request.getSession();
		User currentUser=new User();
		currentUser=(User)session.getAttribute("currentUser");
		if(StringUtil.isNotEmpty(id)){
			stuId=Integer.parseInt(id);
		}else{
			stuId=currentUser.getId();
		}
		int page=Integer.parseInt(request.getParameter("page"));
		int rows=Integer.parseInt(request.getParameter("rows"));
		String sort=request.getParameter("sort");
		String order=request.getParameter("order");
		PageBean pageBean=new PageBean(page,rows);
		Sortinfo sortinfo=new Sortinfo(sort,order);
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			int total=trainDao.rankCount(con,stuId,searchData);
			JSONArray jsonArray=JsonUtil.formatRsToJsonArray(trainDao.rankList(con,stuId,pageBean,sortinfo,searchData));
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
