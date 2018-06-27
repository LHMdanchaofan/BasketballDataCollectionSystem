package basketball.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import basketball.util.StringUtil;
import basketball.model.Display;
import basketball.model.PageBean;


public class DisplayDao {
    public int modifyDisplay(Connection con,Display display)throws Exception{
    	String sql="";
    	int result=0;
    	if(StringUtil.isNotEmpty(display.getCoaId0())){
    		sql="update tb_display set typeId="+display.getCoaId0()+" where Id=1";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=1";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getCoaId1())){
    		sql="update tb_display set typeId="+display.getCoaId1()+" where Id=2";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=2";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getCoaId2())){
    		sql="update tb_display set typeId="+display.getCoaId2()+" where Id=3";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=3";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getCoaId3())){
    		sql="update tb_display set typeId="+display.getCoaId3()+" where Id=4";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=4";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getCoaId4())){
    		sql="update tb_display set typeId="+display.getCoaId4()+" where Id=5";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=5";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getCoaId5())){
    		sql="update tb_display set typeId="+display.getCoaId5()+" where Id=6";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=6";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getClubId0())){
    		sql="update tb_display set typeId="+display.getClubId0()+" where Id=7";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=7";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getClubId1())){
    		sql="update tb_display set typeId="+display.getClubId1()+" where Id=8";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=8";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getClubId2())){
    		sql="update tb_display set typeId="+display.getClubId2()+" where Id=9";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=9";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getClubId3())){
    		sql="update tb_display set typeId="+display.getClubId3()+" where Id=10";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=10";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getClubId4())){
    		sql="update tb_display set typeId="+display.getClubId4()+" where Id=11";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=11";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
    	if(StringUtil.isNotEmpty(display.getClubId5())){
    		sql="update tb_display set typeId="+display.getClubId5()+" where Id=12";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}else{
    		sql="update tb_display set typeId=null where Id=12";
    		PreparedStatement pstmt=con.prepareStatement(sql);
    		result=result+pstmt.executeUpdate();
    	}
		return result;
    }
}
