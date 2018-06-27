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

import basketball.dao.NewsDao;
import basketball.model.User;
import basketball.model.Notice;
import basketball.util.DateUtil;
import basketball.util.DbUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import net.sf.json.JSONObject;

import java.util.Date;
import java.text.SimpleDateFormat;

public class ModifyNewsServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();	
	NewsDao newsDao=new NewsDao();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	
		request.setCharacterEncoding("utf-8");
		String Id=request.getParameter("newsId");
		String newsname=request.getParameter("newsname");
		String newscontent=request.getParameter("newscontent");
		String addtime=request.getParameter("addtime");
		//System.out.println(Id);
		//System.out.println(newscontent);
		//System.out.println(addtime);
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			int modifynum;
			if(StringUtil.isNotEmpty(Id)){
				modifynum=newsDao.modifynews(con, Id,newsname,newscontent,addtime);
			}else{
				modifynum=newsDao.addnews(con,newsname,newscontent,addtime);
			}
			if(modifynum==1){
				result.put("result", modifynum);
			}else{
				result.put("result", modifynum);
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
