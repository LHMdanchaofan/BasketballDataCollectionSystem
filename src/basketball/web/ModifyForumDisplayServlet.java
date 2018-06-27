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

import basketball.dao.ForumDao;
import basketball.model.User;
import basketball.model.Notice;
import basketball.util.DateUtil;
import basketball.util.DbUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import net.sf.json.JSONObject;

import basketball.util.StringToBool;

public class ModifyForumDisplayServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();	
	ForumDao forumDao=new ForumDao();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	
		String Id=request.getParameter("Id");
		String checked=request.getParameter("checked");
		//System.out.println(Id);
		//System.out.println(newscontent);
		//System.out.println(addtime);
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			if(StringToBool.isTrue(checked)==true){
				int displaynum=forumDao.forumdisplayCount(con);
				if(displaynum>=6){
					result.put("result", "error");
					result.put("errorMsg", "主页只能显示六条论坛");
				}else{
					int modifynum=forumDao.addforumdisplay(con, Id);
					if(modifynum>0){
						result.put("result", "success");
					}else{
						result.put("result", "error");
						result.put("errorMsg", "修改失败");
					}
				}
			}else{
				int modifynum=forumDao.deleteforumdisplay(con, Id);
				if(modifynum>0){
					result.put("result", "success");
				}else{
					result.put("result", "error");
					result.put("errorMsg", "修改失败");
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
