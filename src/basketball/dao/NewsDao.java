package basketball.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import basketball.util.StringUtil;
import basketball.model.Notice;
import basketball.model.PageBean;



public class NewsDao {

	public ResultSet getnews(Connection con,String Id,PageBean pageBean) throws Exception{
		String sql="";
		if(StringUtil.isNotEmpty(Id)){
			sql="select * from tb_news where Id="+Id;
		}else{
			if(pageBean!=null){
				sql="select Id,name,addtime,content from tb_news order by addtime desc,Id desc limit "+pageBean.getStart()+","+pageBean.getRows();
			}else{
			 sql="select Id,name,addtime from tb_news order by addtime desc,Id desc limit 0,6";
			}
		}		
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	public int newsCount(Connection con) throws Exception{
		String sql="";
		sql="select Count(*) as total from tb_news";	
		PreparedStatement pstmt=con.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public int modifynews(Connection con,String Id,String newsname,String newscontent,String addtime) throws Exception{
		String sql="update tb_news set name='"+newsname+"',content='"+newscontent+"',addtime='"+addtime+"' where Id="+Id;
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeUpdate();
	}
	public int addnews(Connection con,String newsname,String newscontent,String addtime) throws Exception{
		String sql="insert into tb_news(name,addtime,content) values('"+newsname+"','"+addtime+"','"+newscontent+"')";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeUpdate();
	}
	public int deletenews(Connection con,String delIds)throws Exception{
		String sql="delete from tb_news where Id in("+delIds+")";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeUpdate();
	}
}
