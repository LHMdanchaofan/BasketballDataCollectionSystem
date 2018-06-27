package basketball.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import basketball.dao.TrainDao;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class AddDoubtServlet extends HttpServlet{
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
		int Id=Integer.parseInt(request.getParameter("Id"));
		String detail=request.getParameter("detail");
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			if(StringUtil.isNotEmpty(detail)){
				detail="нч";
			}
			int modifynum=trainDao.adddoubt(con, Id, detail);
			result.put("result", modifynum);
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
