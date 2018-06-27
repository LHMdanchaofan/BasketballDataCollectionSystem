package basketball.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import basketball.model.PageBean;
import basketball.model.Personalinformation;


public class ClubDao {


	public ResultSet getWebsite(Connection con,int Id,int identity) throws Exception{
		String sql="";
		if(identity==1){
			sql="select tb_clubinformation.website from tb_studentcoach,tb_coachclub,tb_clubinformation where stuId=? and tb_studentcoach.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId";
		}else if(identity==2){
			sql="select tb_clubinformation.website from tb_coachclub,tb_clubinformation where coaId=? and tb_coachclub.clubId=tb_clubinformation.clubId";
		}else{
			sql="select website from tb_clubinformation where clubId=?";
		}
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Id);
		return pstmt.executeQuery();
	}
	public ResultSet clubDisplay(Connection con)throws Exception{
		String sql="select clubId,clubname from tb_display,tb_clubinformation where typename='club' and typeId=clubId group by typeId order by tb_display.Id desc limit 0,6 ";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	public ResultSet clubList(Connection con,PageBean pageBean)throws Exception{
		StringBuffer sb=new StringBuffer("select * from tb_clubinformation ");
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		return pstmt.executeQuery();
	}
	public int clubCount(Connection con)throws Exception{
		String sql="select count(*) as total from tb_clubinformation";
		PreparedStatement pstmt=con.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public ResultSet personalinformation(Connection con,int coaId) throws Exception{
		String sql="select * from tb_clubinformation where clubId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, coaId);
		return pstmt.executeQuery();
	}
	public int modifypersonalinformation(Connection con,Personalinformation personalinformation) throws Exception{
		String sql="update tb_clubinformation set clubname='"+personalinformation.getName()+"',phonenumber='"+personalinformation.getPhonenumber()+"',email='"+personalinformation.getEmail()+"',address='"+personalinformation.getAddress()+"',province='"+personalinformation.getProvince()+"' where clubId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, personalinformation.getId());
		sql="update tb_coachinformation set province='"+personalinformation.getProvince()+"' where coaId=(select coaId from tb_coachclub where clubId=?)";
		PreparedStatement pstmt1=con.prepareStatement(sql);
		pstmt1.setInt(1, personalinformation.getId());
		pstmt1.executeUpdate();
		sql="update tb_studentinformation set province='"+personalinformation.getProvince()+"' where stuId=(select stuId from tb_studentcoach,tb_coachclub where tb_studentcoach.coaId=tb_coachclub.coaId and clubId=?)";
		PreparedStatement pstmt2=con.prepareStatement(sql);
		pstmt2.setInt(1, personalinformation.getId());
		pstmt2.executeUpdate();
		return pstmt.executeUpdate();
	}
	public int modifywebsite(Connection con,Personalinformation personalinformation) throws Exception{
		String sql="update tb_clubinformation set website='"+personalinformation.getWebsite()+"' where clubId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, personalinformation.getId());
		return pstmt.executeUpdate();
	}
}
