package basketball.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class ForumDao {

	public ResultSet getfriendforum(Connection con) throws Exception{
		String sql="select * from tb_friendforum where display=1";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	public ResultSet forumList(Connection con) throws Exception{
		String sql="select * from tb_friendforum";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	public int forumCount(Connection con) throws Exception{
		String sql="select count(*) as total from tb_friendforum";
		PreparedStatement pstmt=con.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public int forumdisplayCount(Connection con) throws Exception{
		String sql="select count(*) as total from tb_friendforum where display=1";
		PreparedStatement pstmt=con.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public int addforumdisplay(Connection con,String Id) throws Exception{
		String sql="update tb_friendforum set display=1 where Id="+Id;
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeUpdate();
	}
	public int deleteforumdisplay(Connection con,String Id) throws Exception{
		String sql="update tb_friendforum set display=0 where Id="+Id;
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeUpdate();
	}
	public int addforum(Connection con,String name,String url) throws Exception{
		String sql="insert into tb_friendforum(forumname,forumurl,display) values('"+name+"','"+url+"',0)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeUpdate();
	}
	public int deleteforum(Connection con,String delIds)throws Exception{
		String sql="delete from tb_friendforum where Id in("+delIds+")";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeUpdate();
	}
}
