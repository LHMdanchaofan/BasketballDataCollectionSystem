package basketball.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import basketball.model.Personalinformation;

public class StudentDao {
	public ResultSet getdistribution(Connection con) throws Exception{
		String sql="select count(*),province from tb_studentinformation group by province";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	public ResultSet getdistributiondetail(Connection con) throws Exception{
		String sql="select count(*),max(total),min(total) from (select count(*) as total,province from tb_studentinformation group by province)aa";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	public ResultSet personalinformation(Connection con,int stuId) throws Exception{
		String sql="select tb_studentinformation.stuId,stuname,tb_studentinformation.sex,tb_studentinformation.birthday,tb_studentinformation.idcardnumber,tb_studentinformation.phonenumber,tb_studentinformation.email,tb_studentinformation.address,tb_studentinformation.province,tb_coachinformation.coaId,coaname,clubname from tb_studentinformation,tb_studentcoach,tb_coachinformation,tb_coachclub,tb_clubinformation where tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId and tb_studentinformation.stuId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		return pstmt.executeQuery();
	}
	public int modifypersonalinformation(Connection con,Personalinformation personalinformation) throws Exception{
		String sql="update tb_studentinformation set stuname='"+personalinformation.getName()+"',sex='"+personalinformation.getSex()+"',birthday='"+personalinformation.getBirthday()+"',idcardnumber='"+personalinformation.getIdcardnumber()+"',phonenumber='"+personalinformation.getPhonenumber()+"',email='"+personalinformation.getEmail()+"',address='"+personalinformation.getAddress()+"' where stuId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, personalinformation.getId());
		return pstmt.executeUpdate();
	}
	public int getage(Connection con,int type) throws Exception{
		String sql="";
		if(type==1){
			sql="select count(*) from (select date_format(from_days(to_days(now())-to_days(birthday)), '%Y')+0 as age from tb_studentinformation where birthday!='null')aa where age between 0 and 24";
		}else if(type==2){
			sql="select count(*) from (select date_format(from_days(to_days(now())-to_days(birthday)), '%Y')+0 as age from tb_studentinformation where birthday!='null')aa where age between 0 and 9";
		}else if(type==3){
			sql="select count(*) from (select date_format(from_days(to_days(now())-to_days(birthday)), '%Y')+0 as age from tb_studentinformation where birthday!='null')aa where age between 10 and 15";
		}else if(type==4){
			sql="select count(*) from (select date_format(from_days(to_days(now())-to_days(birthday)), '%Y')+0 as age from tb_studentinformation where birthday!='null')aa where age between 16 and 24";
		}
		PreparedStatement pstmt=con.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt(1);
		}else{
			return 0;
		}
	}
}
