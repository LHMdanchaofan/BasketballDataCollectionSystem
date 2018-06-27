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

import basketball.dao.DisplayDao;
import basketball.model.Display;
import basketball.util.DbUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import net.sf.json.JSONObject;

import java.util.Date;
import java.text.SimpleDateFormat;

public class ModifyDisplayServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();	
	DisplayDao displayDao=new DisplayDao();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	
		String clubId0=request.getParameter("club0");
		String clubId1=request.getParameter("club1");
		String clubId2=request.getParameter("club2");
		String clubId3=request.getParameter("club3");
		String clubId4=request.getParameter("club4");
		String clubId5=request.getParameter("club5");
		String coaId0=request.getParameter("coach0");
		String coaId1=request.getParameter("coach1");
		String coaId2=request.getParameter("coach2");
		String coaId3=request.getParameter("coach3");
		String coaId4=request.getParameter("coach4");
		String coaId5=request.getParameter("coach5");
		Display display=new Display();
		if(StringUtil.isNotEmpty(clubId0)){
			display.setClubId0(clubId0);
		}
		if(StringUtil.isNotEmpty(clubId1)){
			display.setClubId1(clubId1);
		}
		if(StringUtil.isNotEmpty(clubId2)){
			display.setClubId2(clubId2);
		}
		if(StringUtil.isNotEmpty(clubId3)){
			display.setClubId3(clubId3);
		}
		if(StringUtil.isNotEmpty(clubId4)){
			display.setClubId4(clubId4);
		}
		if(StringUtil.isNotEmpty(clubId5)){
			display.setCoaId5(clubId5);
		}
		if(StringUtil.isNotEmpty(coaId0)){
			display.setCoaId0(coaId0);
		}
		if(StringUtil.isNotEmpty(coaId1)){
			display.setCoaId1(coaId1);
		}
		if(StringUtil.isNotEmpty(coaId2)){
			display.setCoaId2(coaId2);
		}
		if(StringUtil.isNotEmpty(coaId3)){
			display.setCoaId3(coaId3);
		}
		if(StringUtil.isNotEmpty(coaId4)){
			display.setCoaId4(coaId4);
		}
		if(StringUtil.isNotEmpty(coaId5)){
			display.setCoaId5(coaId5);
		}
		Connection con=null;
		try {
			con=dbUtil.getCon();
			int result=displayDao.modifyDisplay(con, display);
			if(result>0){
				response.sendRedirect("web/pages/displaymanage.jsp?result=success");
			}else{
				response.sendRedirect("web/pages/displaymanage.jsp");
			}
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
