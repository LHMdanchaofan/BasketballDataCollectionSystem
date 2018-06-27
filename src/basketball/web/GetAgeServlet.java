package basketball.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import basketball.dao.StudentDao;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.DistributionUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import java.sql.ResultSet;

public class GetAgeServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();	
	StudentDao studentDao=new StudentDao();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	
		Connection con=null;
		try {
			con=dbUtil.getCon();
			int detail=studentDao.getage(con, 1);
			int children=studentDao.getage(con, 2);
			int juvenile =studentDao.getage(con, 3);
			int youngth=studentDao.getage(con, 4);
			//double abc=7.0/8.0;
			JSONObject result=new JSONObject();
			result.put("children", children*1.0/(detail*1.0)*100);
			result.put("juvenile", juvenile*1.0/(detail*1.0)*100);
			result.put("youngth", youngth*1.0/(detail*1.0)*100);
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
