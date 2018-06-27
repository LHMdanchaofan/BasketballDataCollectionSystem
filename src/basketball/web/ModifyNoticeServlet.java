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

import basketball.dao.NoticeDao;
import basketball.model.User;
import basketball.model.Notice;
import basketball.util.DateUtil;
import basketball.util.DbUtil;
import java.util.Date;
import java.text.SimpleDateFormat;

public class ModifyNoticeServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();	
	NoticeDao noticeDao=new NoticeDao();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	
		request.setCharacterEncoding("utf-8");
		String newname=request.getParameter("newname");
		String newcontent=request.getParameter("newcontent");
		HttpSession session=request.getSession();
		User currentUser=new User();
		currentUser=(User)session.getAttribute("currentUser");
		Notice notice=new Notice();
		Connection con=null;
		try {
			con=dbUtil.getCon();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
			String addtime=df.format(new Date());// new Date()为获取当前系统时间
			notice.setName(newname);
			notice.setContent(newcontent);
			notice.setUsername(currentUser.getUserName());
			notice.setAddtime(addtime);
			int result=noticeDao.modifynotice(con, notice);
			if(result==1){
				response.sendRedirect("web/pages/noticemanage.jsp?result=success");
			}else{
				response.sendRedirect("web/pages/noticemanage.jsp?result=error");
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
