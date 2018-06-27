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

import basketball.dao.SearchDao;
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

public class CoaStuNumServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();	
	SearchDao searchDao=new SearchDao();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	
		String clubId=request.getParameter("clubId");
		String coaId=request.getParameter("coaId");
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
            if(StringUtil.isNotEmpty(clubId)){
            	result.put("coanum",searchDao.coanum(con, Integer.parseInt(clubId)));
            	result.put("stunum",searchDao.stunum(con, Integer.parseInt(clubId)));
            }else if(StringUtil.isNotEmpty(coaId)){
            	result.put("stunum", searchDao.stunum2(con,Integer.parseInt(coaId)));
            }
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
