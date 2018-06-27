package basketball.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import basketball.model.Notice;



public class NoticeDao {

	public ResultSet getnotice(Connection con) throws Exception{
		String sql="select * from tb_notice where Id=(select max(Id) from tb_notice)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	public int modifynotice(Connection con,Notice notice) throws Exception{
		String sql="update tb_notice set name='"+notice.getName()+"',content='"+notice.getContent()+"',addtime='"+notice.getAddtime()+"',username='"+notice.getUsername()+"' where Id=1 ";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeUpdate();
	}
}
