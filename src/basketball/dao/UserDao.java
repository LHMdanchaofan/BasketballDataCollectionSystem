package basketball.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

import basketball.model.User;
import basketball.model.PageBean;
import basketball.util.StringUtil;


public class UserDao {

	/**
	 * µÇÂ¼ÑéÖ¤
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public User login(Connection con,User user) throws Exception{
		User resultUser=null;
		String sql="select * from tb_user where username=? and password=? and identity=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, user.getUserName());
		pstmt.setString(2, user.getPassWord());
		pstmt.setInt(3, user.getIdentity());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			resultUser=new User();
			resultUser.setId(rs.getInt("Id"));
			resultUser.setUserName(rs.getString("username"));
			resultUser.setPassWord(rs.getString("password"));
			resultUser.setIdentity(rs.getInt("identity"));
			resultUser.setApply(rs.getInt("apply"));
		}
		return resultUser;
	}
	public String getpassword(Connection con,int Id) throws Exception{
		String pw="";
		String sql="select password from tb_user where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Id);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			pw=rs.getString("password");
		}
		return pw;
	}
	public int modifypw(Connection con,int Id,String newpw) throws Exception{
		String sql="update tb_user set password=? where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, newpw);
		pstmt.setInt(2, Id);
		return pstmt.executeUpdate();
	}
	public ResultSet getUser(Connection con,String identity,String searchname,User currentUser)throws Exception{
	    StringBuffer sb=new StringBuffer();
		if(currentUser.getIdentity()==3&&identity.equals("2")){
	    	sb.append("select * from tb_user,tb_coachclub where tb_user.Id=tb_coachclub.coaId and tb_coachclub.clubId="+currentUser.getId());
	    }else if(currentUser.getIdentity()==4){
	    	sb.append("select * from tb_user where identity="+identity);
	    }	
		if(StringUtil.isNotEmpty(searchname)){
			sb.append(" and username like '%"+searchname+"%'");
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		return pstmt.executeQuery();
	}
	public int getUserCount(Connection con,String identity,String searchname)throws Exception{
		StringBuffer sb=new StringBuffer("select count(*) as total from tb_user where identity="+identity);
		if(StringUtil.isNotEmpty(searchname)){
			sb.append(" and username like '%"+searchname+"%'");
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public int deleteStudentUser(Connection con,int Id)throws Exception{
		String sql="delete from tb_user where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Id);
		sql="delete from tb_studentinformation where stuId=?";
		PreparedStatement pstm=con.prepareStatement(sql);
		pstm.setInt(1, Id);
		sql="delete from tb_studenttraininformation where stuId=?";
		PreparedStatement pst=con.prepareStatement(sql);
		pst.setInt(1, Id);
		sql="delete from tb_studentcoach where stuId=?";
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setInt(1, Id);
		return pstmt.executeUpdate();
	}
	public int coastuCount(Connection con,int Id)throws Exception{
		StringBuffer sb=new StringBuffer("select count(*) as count from tb_studentcoach where coaId=?");
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, Id);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("count");
		}else{
			return 0;
		}
	}
	public int deleteCoachUser(Connection con,int Id)throws Exception{
		String sql="delete from tb_user where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Id);
		sql="delete from tb_coachclub where coaId=?";
		PreparedStatement pstm=con.prepareStatement(sql);
		pstm.setInt(1, Id);
		sql="delete from tb_coachinformation where coaId=?";
		PreparedStatement pst=con.prepareStatement(sql);
		pst.setInt(1, Id);
		return pstmt.executeUpdate();
		
	}
	public int clubcoaCount(Connection con,int Id)throws Exception{
		StringBuffer sb=new StringBuffer("select count(*) as count from tb_coachclub where clubId=?");
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, Id);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("count");
		}else{
			return 0;
		}
	}
	public int deleteClubUser(Connection con,int Id)throws Exception{
		String sql="delete from tb_user where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Id);
		sql="delete from tb_clubinformation where clubId=?";
		PreparedStatement pstm=con.prepareStatement(sql);
		pstm.setInt(1, Id);
		return pstmt.executeUpdate();
		
	}
	public int addClubUser(Connection con,String username,String password)throws Exception{
		String sql="insert into tb_user(username,password,identity) values(?,?,3)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, username);
		pstmt.setString(2, password);
		return pstmt.executeUpdate();
		
	}
	public int equalname(Connection con,String username)throws Exception{
		String sql="select count(*) as equalname from tb_user where username='"+username+"'";
		PreparedStatement pstmt=con.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("equalname");
		}else{
			return 0;
		}
	}
	public int addCoachUser(Connection con,String username,String password,User currentUser)throws Exception{
		String sql="insert into tb_user(username,password,identity) values(?,?,2)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, username);
		pstmt.setString(2, password);
		sql="insert into tb_coachclub(coaId,clubId) values((select Id from tb_user where username=? and password=?),?)";
		PreparedStatement pstmt1=con.prepareStatement(sql);
		pstmt1.setString(1, username);
		pstmt1.setString(2, password);
		pstmt1.setInt(3, currentUser.getId());
		return pstmt.executeUpdate()+pstmt1.executeUpdate();
		
	}
	public ResultSet getClub(Connection con,String province)throws Exception{
	    String sql="select clubId,clubname from tb_clubinformation where province='"+province+"'";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	public ResultSet getCoach(Connection con,String clubId)throws Exception{
	    String sql="select tb_coachinformation.coaId,coaname from tb_coachinformation,tb_coachclub where tb_coachinformation.coaId=tb_coachclub.coaId and clubId="+clubId;
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	public int addStudentUser(Connection con,String username,String password)throws Exception{
		//int stuId;
		String sql="insert into tb_user(username,password,identity,apply) values(?,?,1,1)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, username);
		pstmt.setString(2, password);
		pstmt.executeUpdate();
		sql="select Id from tb_user where username=? and password=? and identity=1 and apply=1";
		PreparedStatement pstmt1=con.prepareStatement(sql);
		pstmt1.setString(1, username);
		pstmt1.setString(2, password);
		ResultSet rs=pstmt1.executeQuery();
		if(rs.next()){
			return rs.getInt("Id");
		}else{
			return 0;
		}		
	}
	public int addapply(Connection con,int stuId,int coaId,String name)throws Exception{
		//int stuId;
		String sql="insert into tb_apply(stuId,applycoaId,name) values(?,?,?)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		pstmt.setInt(2, coaId);
		pstmt.setString(3, name);
		return pstmt.executeUpdate();
	}
	public ResultSet getApply(Connection con,int clubId,PageBean pageBean)throws Exception{
	    StringBuffer sb=new StringBuffer("select stuId,name,username,coaname from tb_apply,tb_user,tb_coachinformation where coaId=applycoaId and tb_apply.stuId=tb_user.Id and applycoaId=any(select coaId from tb_coachclub where clubId=?)");
	    if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
	    PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, clubId);
		return pstmt.executeQuery();
	}
	public int getApplyCount(Connection con,int clubId)throws Exception{
	    String sql="select count(*) as total from tb_apply where  applycoaId=any(select coaId from tb_coachclub where clubId=?)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, clubId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public int apply(Connection con,int stuId)throws Exception{
	    String sql="update tb_user set apply=null where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		sql="insert into tb_studentcoach (stuId,coaId) value(?,(select applycoaId from tb_apply where stuId=?))";
		PreparedStatement pstmt1=con.prepareStatement(sql);
		pstmt1.setInt(1, stuId);
		pstmt1.setInt(2, stuId);
		pstmt1.executeUpdate();
		sql="insert into tb_studentinformation (stuId,stuname,province) value(?,(select name from tb_apply where stuId=?),(select province from tb_coachinformation,tb_studentcoach where tb_coachinformation.coaId=tb_studentcoach.coaId and tb_studentcoach.stuId=?))";
		PreparedStatement pstmt2=con.prepareStatement(sql);
		pstmt2.setInt(1, stuId);
		pstmt2.setInt(2, stuId);
		pstmt2.setInt(3, stuId);
		pstmt2.executeUpdate();
		sql="delete from tb_apply where stuId=?";
		PreparedStatement pstmt3=con.prepareStatement(sql);
		pstmt3.setInt(1, stuId);
		pstmt3.executeUpdate();
        return pstmt.executeUpdate();
	}
	public int apply2(Connection con,int stuId)throws Exception{
	    String sql="update tb_user set apply=null where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		sql="insert into tb_studentcoach (stuId,coaId) value(?,(select applycoaId from tb_apply where stuId=?))";
		PreparedStatement pstmt1=con.prepareStatement(sql);
		pstmt1.setInt(1, stuId);
		pstmt1.setInt(2, stuId);
		pstmt1.executeUpdate();
		sql="update tb_studentinformation set province=(select province from tb_studentcoach,tb_coachinformation where tb_studentcoach.coaId=tb_coachinformation.coaId and stuId=?) where stuId=?";
		PreparedStatement pstmt2=con.prepareStatement(sql);
		pstmt2.setInt(1, stuId);
		pstmt2.setInt(2, stuId);
		pstmt2.executeUpdate();
		sql="delete from tb_apply where stuId=?";
		PreparedStatement pstmt3=con.prepareStatement(sql);
		pstmt3.setInt(1, stuId);
		pstmt3.executeUpdate();
        return pstmt.executeUpdate();
	}
	public int modifyclub(Connection con,int stuId,int coaId)throws Exception{
		//int stuId;
		String sql="insert into tb_apply(stuId,applycoaId,oldcoaId,name) values(?,?,(select coaId from tb_studentcoach where stuId=?),(select stuname from tb_studentinformation where stuId=?))";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		pstmt.setInt(2, coaId);
		pstmt.setInt(3, stuId);
		pstmt.setInt(4, stuId);
		int a=pstmt.executeUpdate();
		sql="update tb_user set apply=1 where Id=?";
		PreparedStatement pstmt1=con.prepareStatement(sql);
		pstmt1.setInt(1, stuId);
		pstmt1.executeUpdate();
		sql="delete from tb_studentcoach where stuId=?";
		PreparedStatement pstmt2=con.prepareStatement(sql);
		pstmt2.setInt(1, stuId);
		pstmt2.executeUpdate();
		return a;
	}
	public int getoldcoaId(Connection con,int stuId)throws Exception{
		String sql="select oldcoaId from tb_apply where stuId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("oldcoaId");
		}
		 return 0;
	}
	public int getcoaId(Connection con,int stuId)throws Exception{
		String sql="select coaId from tb_studentcoach where stuId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("coaId");
		}
		 return 0;
	}
	public int refuse(Connection con,int stuId)throws Exception{
	    String sql="delete from tb_user where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		sql="delete from tb_apply where stuId=?";
		PreparedStatement pstmt1=con.prepareStatement(sql);
		pstmt1.setInt(1, stuId);
		pstmt1.executeUpdate();
        return pstmt.executeUpdate();
	}
	public int refuse2(Connection con,int stuId)throws Exception{
		String sql="update tb_user set apply=null where Id=?";
	    PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		sql="insert into tb_studentcoach (stuId,coaId) value(?,(select oldcoaId from tb_apply where stuId=?))";
		PreparedStatement pstmt1=con.prepareStatement(sql);
		pstmt1.setInt(1, stuId);
		pstmt1.setInt(2, stuId);
		pstmt1.executeUpdate();
		sql="delete from tb_apply where stuId=?";
		PreparedStatement pstmt2=con.prepareStatement(sql);
		pstmt2.setInt(1, stuId);
		pstmt2.executeUpdate();
        return pstmt.executeUpdate();
	}
}
