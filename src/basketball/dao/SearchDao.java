package basketball.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import basketball.model.PageBean;

public class SearchDao {
	public ResultSet searchinformation(Connection con,String name,String value,PageBean pageBean) throws Exception{
		StringBuffer sb=new StringBuffer();
		if(name.equals("club")){
			sb.append("select * from tb_clubinformation where clubname like '%"+value+"%'");
		}else if(name.equals("coach")){
			sb.append("select tb_coachinformation.coaId,coaname,sex,tb_coachinformation.birthday,tb_coachinformation.email,tb_coachinformation.phonenumber,tb_coachinformation.province,clubname from tb_coachinformation,tb_coachclub,tb_clubinformation where tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId and tb_coachinformation.coaname like '%"+value+"%'");
		}else if(name.equals("student")){
			sb.append("select tb_studentinformation.stuId,stuname,tb_studentinformation.sex,tb_studentinformation.phonenumber,tb_studentinformation.birthday,tb_studentinformation.email,coaname,clubname,tb_studentinformation.province from tb_studentinformation,tb_studentcoach,tb_coachinformation,tb_coachclub,tb_clubinformation where tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId and tb_studentinformation.stuname like '%"+value+"%'");
		}
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		return pstmt.executeQuery();
	}
	public int searchinformationCount(Connection con,String name,String value) throws Exception{
		StringBuffer sb=new StringBuffer();
		if(name.equals("club")){
			sb.append("select count(*) as total from tb_clubinformation where clubname like '%"+value+"%'");
		}else if(name.equals("coach")){
			sb.append("select count(*) as total from tb_coachinformation,tb_coachclub,tb_clubinformation where tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId and tb_coachinformation.coaname like '%"+value+"%'");
		}else if(name.equals("student")){
			sb.append("select count(*) as total from tb_studentinformation,tb_studentcoach,tb_coachinformation,tb_coachclub,tb_clubinformation where tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId and tb_studentinformation.stuname like '%"+value+"%'");
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public int coanum(Connection con,int clubId) throws Exception{
		String sql="select count(*) as coanum from tb_coachclub where clubId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1,clubId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("coanum");
		}else{
			return 0;
		}
	}
	public int stunum(Connection con,int clubId) throws Exception{
		String sql="select count(*) as stunum from tb_coachclub,tb_studentcoach where tb_coachclub.coaId=tb_studentcoach.coaId and clubId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1,clubId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("stunum");
		}else{
			return 0;
		}
	}
	public int stunum2(Connection con,int coaId) throws Exception{
		String sql="select count(*) as stunum from tb_studentcoach where coaId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1,coaId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("stunum");
		}else{
			return 0;
		}
	}
}
