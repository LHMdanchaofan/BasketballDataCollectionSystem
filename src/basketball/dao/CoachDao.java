package basketball.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import basketball.util.StringUtil;

import basketball.model.PageBean;
import basketball.model.Personalinformation;
import basketball.model.Student;


public class CoachDao {
	public ResultSet coastuList(Connection con,int coaId,PageBean pageBean,Student student) throws Exception{
		StringBuffer sb=new StringBuffer("select tb_studentinformation.stuId,stuname,sex from tb_studentinformation,tb_studentcoach where tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=?");
		if(student.getStuId()!=0){
			sb.append(" and tb_studentinformation.stuId like '%"+student.getStuId()+"%'");
		}else if(StringUtil.isNotEmpty(student.getStuname())){
			sb.append(" and stuname like '%"+student.getStuname()+"%'");
		}
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, coaId);
		return pstmt.executeQuery();
	}
	public int coastuCount(Connection con,int coaId,Student student) throws Exception{
		StringBuffer sb=new StringBuffer("select Count(*) as total from tb_studentinformation,tb_studentcoach where tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=?");
		if(student.getStuId()!=0){
			sb.append(" and tb_studentinformation.stuId like '%"+student.getStuId()+"%'");
		}else if(StringUtil.isNotEmpty(student.getStuname())){
			sb.append(" and stuname like '%"+student.getStuname()+"%'");
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, coaId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public ResultSet coachDisplay(Connection con)throws Exception{
		String sql="select tb_coachinformation.coaId,coaname,clubname from tb_display,tb_coachinformation,tb_coachclub,tb_clubinformation where typename='coach' and typeId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId group by typeId order by tb_display.Id desc limit 0,6 ";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	
	public ResultSet coachList(Connection con,PageBean pageBean)throws Exception{
		StringBuffer sb=new StringBuffer("select * from tb_coachinformation,tb_clubinformation,tb_coachclub where tb_coachinformation.coaId=tb_coachclub.coaId and tb_clubinformation.clubId=tb_coachclub.clubId ");
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		return pstmt.executeQuery();
	}
	public int coachCount(Connection con)throws Exception{
		String sql="select count(*) as total from tb_coachinformation ";
		PreparedStatement pstmt=con.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public ResultSet personalinformation(Connection con,int coaId) throws Exception{
		String sql="select * from tb_coachinformation where coaId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, coaId);
		return pstmt.executeQuery();
	}
	public int modifypersonalinformation(Connection con,Personalinformation personalinformation) throws Exception{
		String sql="update tb_coachinformation set coaname='"+personalinformation.getName()+"',sex='"+personalinformation.getSex()+"',birthday='"+personalinformation.getBirthday()+"',idcardnumber='"+personalinformation.getIdcardnumber()+"',phonenumber='"+personalinformation.getPhonenumber()+"',email='"+personalinformation.getEmail()+"',address='"+personalinformation.getAddress()+"' where coaId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, personalinformation.getId());
		return pstmt.executeUpdate();
	}
	public ResultSet phonecoastuList(Connection con,int coaId,PageBean pageBean) throws Exception{
		StringBuffer sb=new StringBuffer("select tb_studentinformation.stuId,stuname,sex from tb_studentinformation,tb_studentcoach where tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentinformation.stuId!=all(select stuId from tb_temporarystudent) and tb_studentcoach.coaId=?");
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, coaId);
		return pstmt.executeQuery();
	}
	public int phonecoastuCount(Connection con,int coaId) throws Exception{
		StringBuffer sb=new StringBuffer("select Count(*) as total from tb_studentinformation,tb_studentcoach where tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentinformation.stuId!=all(select stuId from tb_temporarystudent) and tb_studentcoach.coaId=?");
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, coaId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public int phoneaddstudent(Connection con,int coaId,int stuId) throws Exception{
		String sql="insert into tb_temporarystudent(stuId,coaId) values(?,?)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		pstmt.setInt(2, coaId);
		return pstmt.executeUpdate();
	}
	public ResultSet phonegettemporarystudent(Connection con,int coaId) throws Exception{
		StringBuffer sb=new StringBuffer("select tb_studentinformation.stuId,stuname from tb_studentinformation,tb_temporarystudent where tb_studentinformation.stuId=tb_temporarystudent.stuId and  tb_temporarystudent.coaId=?");
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, coaId);
		return pstmt.executeQuery();
	}
}
