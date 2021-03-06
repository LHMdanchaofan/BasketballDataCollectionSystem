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

public class GetDistributionServlet extends HttpServlet{
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
			JSONObject result=new JSONObject();
			JSONArray data=DistributionUtil.distributionarray(studentDao.getdistribution(con));
			ResultSet rs=studentDao.getdistributiondetail(con);
			result.put("distribution", data);
			while(rs.next()){
				result.put("max", rs.getInt(2));
				if(rs.getInt(1)<36){
					result.put("min", 0);
				}else{
					result.put("min", rs.getInt(3));
				}
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
