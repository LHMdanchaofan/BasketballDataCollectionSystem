package basketball.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSetMetaData;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import java.sql.ResultSet;
import basketball.dao.StudentDao;
import basketball.dao.CoachDao;
import basketball.dao.ClubDao;
import basketball.model.User;
import basketball.model.Personalinformation;
import basketball.util.DbUtil;
import basketball.util.JsonUtil;
import basketball.util.ResponseUtil;
import basketball.util.StringUtil;
import basketball.util.MonthUtil;

public class ModifyPersonalinformationServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		Personalinformation personalinformation=new Personalinformation();
		HttpSession session=request.getSession();
		User currentUser=new User();
		currentUser=(User)session.getAttribute("currentUser");
		Connection con=null;
		try{
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			JSONArray jsonArray=new JSONArray();
			if(currentUser.getIdentity()==1){
				String stuname=request.getParameter("fmname");
				String sex=request.getParameter("fmsex");
				String birthday=request.getParameter("fmbirthday");
				String idcardnumber=request.getParameter("fmidcardnumber");
				String phonenumber=request.getParameter("fmphonenumber");
				String email=request.getParameter("fmemail");
				String address=request.getParameter("fmaddress");
				personalinformation.setId(currentUser.getId());
				personalinformation.setName(stuname);
				personalinformation.setSex(sex);
				personalinformation.setIdcardnumber(idcardnumber);
				personalinformation.setPhonenumber(phonenumber);
				personalinformation.setBirthday(birthday);
				personalinformation.setEmail(email);
				personalinformation.setAddress(address);
				StudentDao studentDao=new StudentDao();
			    int modifynum=studentDao.modifypersonalinformation(con, personalinformation);
			    if(modifynum>0){
			    	result.put("result", "success");
			    }else{
			    	result.put("result", "error");
			    }
			}else if(currentUser.getIdentity()==2){
				String coaname=request.getParameter("fmname");
				String sex=request.getParameter("fmsex");
				String birthday=request.getParameter("fmbirthday");
				String idcardnumber=request.getParameter("fmidcardnumber");
				String phonenumber=request.getParameter("fmphonenumber");
				String email=request.getParameter("fmemail");
				String address=request.getParameter("fmaddress");
				personalinformation.setId(currentUser.getId());
				personalinformation.setName(coaname);
				personalinformation.setSex(sex);
				personalinformation.setIdcardnumber(idcardnumber);
				personalinformation.setPhonenumber(phonenumber);
				personalinformation.setBirthday(birthday);
				personalinformation.setEmail(email);
				personalinformation.setAddress(address);
				CoachDao coachDao=new CoachDao();
			    int modifynum=coachDao.modifypersonalinformation(con, personalinformation);
			    if(modifynum>0){
			    	result.put("result", "success");
			    }else{
			    	result.put("result", "error");
			    }
			}else if(currentUser.getIdentity()==3){
				String website=request.getParameter("newwebsite");
				if(StringUtil.isNotEmpty(website)){
					personalinformation.setWebsite(website);
					personalinformation.setId(currentUser.getId());
					ClubDao clubDao=new ClubDao();
				    int modifynum=clubDao.modifywebsite(con, personalinformation);
				    if(modifynum>0){
				    	result.put("result", "success");
				    }else{
				    	result.put("result", "error");
				    }
				}else{
					String clubname=request.getParameter("fmname");
					String phonenumber=request.getParameter("fmphonenumber");
					String email=request.getParameter("fmemail");
					String address=request.getParameter("fmaddress");
					String province=request.getParameter("fmprovince");
					personalinformation.setId(currentUser.getId());
					personalinformation.setName(clubname);
					personalinformation.setPhonenumber(phonenumber);
					personalinformation.setProvince(province);
					personalinformation.setEmail(email);
					personalinformation.setAddress(address);
					ClubDao clubDao=new ClubDao();
				    int modifynum=clubDao.modifypersonalinformation(con, personalinformation);
				    if(modifynum>0){
				    	result.put("result", "success");
				    }else{
				    	result.put("result", "error");
				    }
				}				
			}
		     ResponseUtil.write(response, result);
		}catch(Exception e){
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
