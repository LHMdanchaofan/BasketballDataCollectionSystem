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

import basketball.dao.CoachDao;
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

public class CoaStuListServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();	
	CoachDao coachDao=new CoachDao();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Student student=new Student();
		String value=request.getParameter("value");
		String name=request.getParameter("name");
		if(StringUtil.isNotEmpty(value)&&StringUtil.isNotEmpty(name)){
			if(name.equals("stuId")){
				student.setStuId(Integer.parseInt(value));
			}else{
				student.setStuname(value);
			}
		}
		HttpSession session=request.getSession();
		User currentUser=new User();
		currentUser=(User)session.getAttribute("currentUser");
		int page=Integer.parseInt(request.getParameter("page"));
		int rows=Integer.parseInt(request.getParameter("rows"));
		PageBean pageBean=new PageBean(page,rows);
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			int total=coachDao.coastuCount(con,currentUser.getId(),student);
			JSONArray jsonArray=JsonUtil.formatRsToJsonArray(coachDao.coastuList(con,currentUser.getId(),pageBean,student));
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
