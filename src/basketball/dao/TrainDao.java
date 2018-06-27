package basketball.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import basketball.model.PageBean;
import basketball.model.SearchTrain;
import basketball.model.DataChart;
import basketball.util.DateUtil;
import basketball.util.StringUtil;
import java.text.SimpleDateFormat;

import basketball.model.Train;

import java.util.Date;
import java.sql.Types;

import basketball.model.Sortinfo;
import basketball.model.SearchData;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class TrainDao {

	/**
	 * 登录验证
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public ResultSet trainList(Connection con,int stuId,PageBean pageBean,SearchTrain searchTrain) throws Exception{
		StringBuffer sb=new StringBuffer("select * from tb_studenttraininformation where stuId=?");
		if(StringUtil.isNotEmpty(searchTrain.getBegintime()) || StringUtil.isNotEmpty(searchTrain.getEndtime())){
			if(StringUtil.isNotEmpty(searchTrain.getBegintime()) && StringUtil.isEmpty(searchTrain.getEndtime())){
				sb.append(" and addtime >= '"+searchTrain.getBegintime()+"'");
			}else if(StringUtil.isEmpty(searchTrain.getBegintime()) && StringUtil.isNotEmpty(searchTrain.getEndtime())){
				sb.append(" and addtime <= '"+searchTrain.getEndtime()+"'");
			}else{
				sb.append(" and addtime between '"+searchTrain.getBegintime()+"' and '"+searchTrain.getEndtime()+"'");
			}
		}
		if(searchTrain.getBeginshuttlerun()!=null || searchTrain.getEndshuttlerun()!=null){
			if(searchTrain.getBeginshuttlerun()!=null & searchTrain.getEndshuttlerun()==null){
				sb.append(" and shuttlerun >="+searchTrain.getBeginshuttlerun());
			}else if(searchTrain.getBeginshuttlerun()==null & searchTrain.getEndshuttlerun()!=null){
				sb.append(" and shuttlerun <="+searchTrain.getEndshuttlerun());
			}else{
				sb.append(" and shuttlerun between "+searchTrain.getBeginshuttlerun()+" and "+searchTrain.getEndshuttlerun());
			}
		}
		if(searchTrain.getBeginbenchpress()!=null || searchTrain.getEndbenchpress()!=null){
			if(searchTrain.getBeginbenchpress()!=null || searchTrain.getEndbenchpress()==null){
				sb.append(" and benchpress >="+searchTrain.getBeginbenchpress());
			}else if(searchTrain.getBeginbenchpress()==null || searchTrain.getEndbenchpress()!=null){
				sb.append(" and benchpress <="+searchTrain.getEndbenchpress());
			}else{
				sb.append(" and benchpress between "+searchTrain.getBeginbenchpress()+" and "+searchTrain.getEndbenchpress());
			}
		}
		if(searchTrain.getBegin50meters()!=null || searchTrain.getEnd50meters()!=null){
			if(searchTrain.getBegin50meters()!=null || searchTrain.getEnd50meters()==null){
				sb.append(" and 50meters >="+searchTrain.getBegin50meters());
			}else if(searchTrain.getBegin50meters()==null || searchTrain.getEnd50meters()!=null){
				sb.append(" and 50meters <="+searchTrain.getEnd50meters());
			}else{
				sb.append(" and 50meters between "+searchTrain.getBegin50meters()+" and "+searchTrain.getEnd50meters());
			}
		}
		if(searchTrain.getBeginsetshot()!=null || searchTrain.getEndsetshot()!=null){
			if(searchTrain.getBeginsetshot()!=null || searchTrain.getEndsetshot()==null){
				sb.append(" and setshot >="+searchTrain.getBeginsetshot());
			}else if(searchTrain.getBeginsetshot()==null || searchTrain.getEndsetshot()!=null){
				sb.append(" and setshot <="+searchTrain.getEndsetshot());
			}else{
				sb.append(" and setshot between "+searchTrain.getBeginsetshot()+" and "+searchTrain.getEndsetshot());
			}
		}
		if(searchTrain.getBeginsetshot()!=null || searchTrain.getEndsetshot()!=null){
			if(searchTrain.getBeginsetshot()!=null || searchTrain.getEndsetshot()==null){
				sb.append(" and setshot >="+searchTrain.getBeginsetshot());
			}else if(searchTrain.getBeginsetshot()==null || searchTrain.getEndsetshot()!=null){
				sb.append(" and setshot <="+searchTrain.getEndsetshot());
			}else{
				sb.append(" and setshot between "+searchTrain.getBeginsetshot()+" and "+searchTrain.getEndsetshot());
			}
		}
		sb.append(" order by addtime desc,Id desc");
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, stuId);
		return pstmt.executeQuery();
	}
	public int trainCount(Connection con,int stuId,SearchTrain searchTrain)throws Exception{
		StringBuffer sb=new StringBuffer("select count(*) as total from tb_studenttraininformation where stuId=?");
		if(StringUtil.isNotEmpty(searchTrain.getBegintime()) || StringUtil.isNotEmpty(searchTrain.getEndtime())){
			if(StringUtil.isNotEmpty(searchTrain.getBegintime()) && StringUtil.isEmpty(searchTrain.getEndtime())){
				sb.append(" and addtime >= '"+searchTrain.getBegintime()+"'");
			}else if(StringUtil.isEmpty(searchTrain.getBegintime()) && StringUtil.isNotEmpty(searchTrain.getEndtime())){
				sb.append(" and addtime <= '"+searchTrain.getEndtime()+"'");
			}else{
				sb.append(" and addtime between '"+searchTrain.getBegintime()+"' and '"+searchTrain.getEndtime()+"'");
			}
		}
		if(searchTrain.getBeginshuttlerun()!=null || searchTrain.getBeginshuttlerun()!=null){
			if(searchTrain.getBeginshuttlerun()!=null & searchTrain.getBeginshuttlerun()==null){
				sb.append(" and shuttlerun >="+searchTrain.getBeginshuttlerun());
			}else if(searchTrain.getBeginshuttlerun()==null & searchTrain.getBeginshuttlerun()!=null){
				sb.append(" and shuttlerun <="+searchTrain.getEndshuttlerun());
			}else{
				sb.append(" and shuttlerun between "+searchTrain.getBeginshuttlerun()+" and "+searchTrain.getEndshuttlerun());
			}
		}
		if(searchTrain.getBeginbenchpress()!=null || searchTrain.getEndbenchpress()!=null){
			if(searchTrain.getBeginbenchpress()!=null || searchTrain.getEndbenchpress()==null){
				sb.append(" and benchpress >="+searchTrain.getBeginbenchpress());
			}else if(searchTrain.getBeginbenchpress()==null || searchTrain.getEndbenchpress()!=null){
				sb.append(" and benchpress <="+searchTrain.getEndbenchpress());
			}else{
				sb.append(" and benchpress between "+searchTrain.getBeginbenchpress()+" and "+searchTrain.getEndbenchpress());
			}
		}
		if(searchTrain.getBegin50meters()!=null || searchTrain.getEnd50meters()!=null){
			if(searchTrain.getBegin50meters()!=null || searchTrain.getEnd50meters()==null){
				sb.append(" and 50meters >="+searchTrain.getBegin50meters());
			}else if(searchTrain.getBegin50meters()==null || searchTrain.getEnd50meters()!=null){
				sb.append(" and 50meters <="+searchTrain.getEnd50meters());
			}else{
				sb.append(" and 50meters between "+searchTrain.getBegin50meters()+" and "+searchTrain.getEnd50meters());
			}
		}
		if(searchTrain.getBeginsetshot()!=null || searchTrain.getEndsetshot()!=null){
			if(searchTrain.getBeginsetshot()!=null || searchTrain.getEndsetshot()==null){
				sb.append(" and setshot >="+searchTrain.getBeginsetshot());
			}else if(searchTrain.getBeginsetshot()==null || searchTrain.getEndsetshot()!=null){
				sb.append(" and setshot <="+searchTrain.getEndsetshot());
			}else{
				sb.append(" and setshot between "+searchTrain.getBeginsetshot()+" and "+searchTrain.getEndsetshot());
			}
		}
		if(searchTrain.getBeginsetshot()!=null || searchTrain.getEndsetshot()!=null){
			if(searchTrain.getBeginsetshot()!=null || searchTrain.getEndsetshot()==null){
				sb.append(" and setshot >="+searchTrain.getBeginsetshot());
			}else if(searchTrain.getBeginsetshot()==null || searchTrain.getEndsetshot()!=null){
				sb.append(" and setshot <="+searchTrain.getEndsetshot());
			}else{
				sb.append(" and setshot between "+searchTrain.getBeginsetshot()+" and "+searchTrain.getEndsetshot());
			}
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, stuId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public ResultSet rankList(Connection con,int stuId,PageBean pageBean,Sortinfo sortinfo,SearchData searchData) throws Exception{
		int count=2;
		String sql="";
		StringBuffer sb=new StringBuffer("select tb_studentinformation.stuId,stuname,coaname,clubname,tb_studentinformation.province,min(shuttlerun) as shuttlerun,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot "
				+ "from tb_studentinformation,tb_coachinformation,tb_clubinformation,tb_studentcoach,tb_coachclub,tb_studenttraininformation "
				+ "where tb_studentinformation.birthday between date_add((select birthday from tb_studentinformation where stuId=?), interval -6 month) and date_add((select birthday from tb_studentinformation where stuId=?), interval 6 month) "
				+ "and tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId= tb_clubinformation.clubId ");	
		if(searchData.getDatarang()==2){
			sb.append("and tb_studentinformation.province=(select province from tb_studentinformation where stuId=?) ");
			count++;
		}else if(searchData.getDatarang()==3){
			sb.append("and clubname=(select clubname from tb_studentcoach,tb_coachclub,tb_clubinformation where tb_studentcoach.stuId=? and tb_studentcoach.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId ) ");
			count++;
		}
		if(searchData.getDatatime()==2){
			sb.append("and date_format(tb_studenttraininformation.addtime,'%Y-%m')=date_format(now(),'%Y-%m') ");
		}else if(searchData.getDatatime()==3){
			sb.append("and YEARWEEK(date_format(tb_studenttraininformation.addtime,'%Y-%m-%d'))=YEARWEEK(now()) ");
		}
		sb.append("group by tb_studentinformation.stuId");
		if(StringUtil.isNotEmpty(sortinfo.getSort())){
			sb.append(" order by "+sortinfo.getSort()+" "+sortinfo.getOrder());
		}else{
			sb.append(" order by tb_studentinformation.stuId asc");
		}
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		if(searchData.getDatatype()==2){
			sql=sb.toString().replaceAll("min", "avg");
			sql.replaceAll("max", "avg");
		}else{
			sql=sb.toString();
		}
		String abc=sql;
		PreparedStatement pstmt=con.prepareStatement(sql);
		for(int i=0;i<count;i++){
		pstmt.setInt(i+1, stuId);
		}
		return pstmt.executeQuery();
	}
	public int rankCount(Connection con,int stuId,SearchData searchData) throws Exception{
		int count=2;
		StringBuffer sb=new StringBuffer("select count(*) as total from (select tb_studentinformation.stuId,stuname,coaname,clubname,min(shuttlerun) as shuttlerun,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot "
				+ "from tb_studentinformation,tb_coachinformation,tb_clubinformation,tb_studentcoach,tb_coachclub,tb_studenttraininformation "
				+ "where tb_studentinformation.birthday between date_add((select birthday from tb_studentinformation where stuId=?), interval -6 month) and date_add((select birthday from tb_studentinformation where stuId=?), interval 6 month) "
				+ "and tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId= tb_clubinformation.clubId ");
		if(searchData.getDatarang()==2){
			sb.append("and tb_studentinformation.province=(select province from tb_studentinformation where stuId=?) ");
			count++;
		}else if(searchData.getDatarang()==3){
			sb.append("and clubname=(select clubname from tb_studentcoach,tb_coachclub,tb_clubinformation where tb_studentcoach.stuId=? and tb_studentcoach.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId ) ");
			count++;
		}
		sb.append(" group by tb_studentinformation.stuId)aa");
		String abc=sb.toString();
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		for(int i=0;i<count;i++){
			pstmt.setInt(i+1, stuId);
		}
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public String rangpr(Connection con,int Id,int identity) throws Exception{
		String sql="";
		if(identity==1){
			sql="select tb_clubinformation.province from tb_studentinformation,tb_studentcoach,tb_coachinformation,tb_coachclub,tb_clubinformation where tb_studentinformation.stuId=? and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_studentcoach.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId";
		}else if(identity==2){
			sql="select tb_clubinformation.province from tb_coachinformation,tb_coachclub,tb_clubinformation where tb_coachinformation.coaId=? and tb_coachclub.clubId=tb_clubinformation.clubId";
		}
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Id);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getString("province");
		}else{
			return null;
		}
	}
	public String rangcl(Connection con,int Id,int identity) throws Exception{
		String sql="";
		if(identity==1){
			sql="select tb_clubinformation.clubname from tb_studentinformation,tb_studentcoach,tb_coachinformation,tb_coachclub,tb_clubinformation where tb_studentinformation.stuId=? and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_studentcoach.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId";
		}else if(identity==2){
			sql="select tb_clubinformation.clubname from tb_coachclub,tb_clubinformation where tb_coachclub.coaId=? and tb_coachclub.clubId=tb_clubinformation.clubId";
		}	
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Id);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getString("clubname");
		}else{
			return null;
		}
	}
	public String DataChartbegintime(Connection con,int stuId) throws Exception{
		String sql="select min(DATE_FORMAT(addtime,'%Y-%m')) as begintime from tb_studenttraininformation where stuId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getString("begintime");
		}else{
			return null;
		}
	}
	public String DataChartendtime(Connection con,int stuId) throws Exception{
		String sql="select max(DATE_FORMAT(addtime,'%Y-%m')) as endtime from tb_studenttraininformation where stuId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, stuId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getString("endtime");
		}else{
			return null;
		}
	}
	public ResultSet DataChart(Connection con,int stuId,DataChart dataChart) throws Exception{
		StringBuffer sb=new StringBuffer("select avg("+dataChart.getProject()+") as "+dataChart.getProject()+",DATE_FORMAT(addtime,'%Y-%m')months from tb_studenttraininformation where stuId=? and DATE_FORMAT(addtime,'%Y-%m') between '"+dataChart.getBegintime()+"' and '"+dataChart.getEndtime()+"' group by months");
		String sql=sb.toString();
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, stuId);
		return pstmt.executeQuery();
	}
	public ResultSet CountryBest(Connection con,int stuId,DataChart dataChart) throws Exception{
		StringBuffer sb=new StringBuffer("select "+dataChart.getProject()+",months from (select "+dataChart.getProject()+",if((DATE_FORMAT(birthday,'%m')+xx-yy*12)>12,DATE_FORMAT(CONCAT(yy+DATE_FORMAT(birthday,'%Y')+1,'-',DATE_FORMAT(birthday,'%m')+xx-yy*12-12,'-01'),'%Y-%m'),DATE_FORMAT(CONCAT(yy+DATE_FORMAT(birthday,'%Y'),'-',DATE_FORMAT(birthday,'%m')+xx-yy*12,'-01'),'%Y-%m')) as months from (select "+dataChart.getSize()+"("+dataChart.getProject()+") as "+dataChart.getProject()+",(DATE_FORMAT(addtime,'%Y')*12+DATE_FORMAT(addtime,'%m')-DATE_FORMAT(tb_studentinformation.birthday,'%Y')*12-DATE_FORMAT(tb_studentinformation.birthday,'%m'))xx,floor((DATE_FORMAT(addtime,'%Y')*12+DATE_FORMAT(addtime,'%m')-DATE_FORMAT(tb_studentinformation.birthday,'%Y')*12-DATE_FORMAT(tb_studentinformation.birthday,'%m'))/12)yy from tb_studenttraininformation,tb_studentinformation where tb_studentinformation.stuId=tb_studenttraininformation.stuId  group by xx)cc,tb_studentinformation where tb_studentinformation.stuId=?)dd where months between '"+dataChart.getBegintime()+"' and '"+dataChart.getProject()+"'");
		//String sql=sb.toString();
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, stuId);
		return pstmt.executeQuery();
	}
	public ResultSet CountryAverage(Connection con,int stuId,DataChart dataChart) throws Exception{
		StringBuffer sb=new StringBuffer("select "+dataChart.getProject()+",months from (select "+dataChart.getProject()+",if((DATE_FORMAT(birthday,'%m')+xx-yy*12)>12,DATE_FORMAT(CONCAT(yy+DATE_FORMAT(birthday,'%Y')+1,'-',DATE_FORMAT(birthday,'%m')+xx-yy*12-12,'-01'),'%Y-%m'),DATE_FORMAT(CONCAT(yy+DATE_FORMAT(birthday,'%Y'),'-',DATE_FORMAT(birthday,'%m')+xx-yy*12,'-01'),'%Y-%m')) as months from (select avg("+dataChart.getProject()+") as "+dataChart.getProject()+",(DATE_FORMAT(addtime,'%Y')*12+DATE_FORMAT(addtime,'%m')-DATE_FORMAT(tb_studentinformation.birthday,'%Y')*12-DATE_FORMAT(tb_studentinformation.birthday,'%m'))xx,floor((DATE_FORMAT(addtime,'%Y')*12+DATE_FORMAT(addtime,'%m')-DATE_FORMAT(tb_studentinformation.birthday,'%Y')*12-DATE_FORMAT(tb_studentinformation.birthday,'%m'))/12)yy from tb_studenttraininformation,tb_studentinformation where tb_studentinformation.stuId=tb_studenttraininformation.stuId  group by xx)cc,tb_studentinformation where tb_studentinformation.stuId=?)dd where months between '"+dataChart.getBegintime()+"' and '"+dataChart.getProject()+"'");
		//String sql=sb.toString();
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, stuId);
		return pstmt.executeQuery();
	}
	public ResultSet PersonalBest(Connection con,int stuId,DataChart dataChart) throws Exception{
		StringBuffer sb=new StringBuffer("select "+dataChart.getProject()+",months from (select "+dataChart.getProject()+",if((DATE_FORMAT(birthday,'%m')+xx-yy*12)>12,DATE_FORMAT(CONCAT(yy+DATE_FORMAT(birthday,'%Y')+1,'-',DATE_FORMAT(birthday,'%m')+xx-yy*12-12,'-01'),'%Y-%m'),DATE_FORMAT(CONCAT(yy+DATE_FORMAT(birthday,'%Y'),'-',DATE_FORMAT(birthday,'%m')+xx-yy*12,'-01'),'%Y-%m')) as months from (select "+dataChart.getSize()+"("+dataChart.getProject()+") as "+dataChart.getProject()+",(DATE_FORMAT(addtime,'%Y')*12+DATE_FORMAT(addtime,'%m')-DATE_FORMAT(tb_studentinformation.birthday,'%Y')*12-DATE_FORMAT(tb_studentinformation.birthday,'%m'))xx,floor((DATE_FORMAT(addtime,'%Y')*12+DATE_FORMAT(addtime,'%m')-DATE_FORMAT(tb_studentinformation.birthday,'%Y')*12-DATE_FORMAT(tb_studentinformation.birthday,'%m'))/12)yy from tb_studenttraininformation,tb_studentinformation where tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studenttraininformation.stuId=?  group by xx)cc,tb_studentinformation where tb_studentinformation.stuId=?)dd where months between '"+dataChart.getBegintime()+"' and '"+dataChart.getEndtime()+"'");
		//String sql=sb.toString();
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, stuId);
		pstmt.setInt(2, stuId);
		return pstmt.executeQuery();
	}
	public ResultSet PersonalAverage(Connection con,int stuId,DataChart dataChart) throws Exception{
		StringBuffer sb=new StringBuffer("select avg("+dataChart.getProject()+") from tb_studenttraininformation where stuId=? and DATE_FORMAT(addtime,'%Y-%m') between '"+dataChart.getBegintime()+"' and '"+dataChart.getEndtime()+"'");
		//String sql=sb.toString();
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, stuId);
		return pstmt.executeQuery();
	}
	public int AddTrain(Connection con,int stuId,Train train)throws Exception{
		StringBuffer sb=new StringBuffer("insert into tb_studenttraininformation values(null,?,");
		if(StringUtil.isNotEmpty(train.getShuttlerun())){
			sb.append(train.getShuttlerun()+",");
		}else{
			sb.append("null,");
		}
		if(StringUtil.isNotEmpty(train.getBenchpress())){
			sb.append(train.getBenchpress()+",");
		}else{
			sb.append("null,");
		}
		if(StringUtil.isNotEmpty(train.getFmeters())){
			sb.append(train.getFmeters()+",");
		}else{
			sb.append("null,");
		}
		if(StringUtil.isNotEmpty(train.getOmeters())){
			sb.append(train.getOmeters()+",");
		}else{
			sb.append("null,");
		}
		if(StringUtil.isNotEmpty(train.getSetshot())){
			sb.append(train.getSetshot()+",");
		}else{
			sb.append("null,");
		}
		sb.append("null,null,null,'"+train.getAddtime()+"',0,null,1)");
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, stuId);
        return pstmt.executeUpdate();
	}
	public int DeleteTrain(Connection con,String delIds)throws Exception{
		String sql="delete from tb_studenttraininformation where Id in("+delIds+")";
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeUpdate();
	}
	public int ModifyTrain(Connection con,int Id,Train train)throws Exception{
		StringBuffer sb=new StringBuffer("update  tb_studenttraininformation set ");
		if(StringUtil.isNotEmpty(train.getShuttlerun())){
			sb.append("shuttlerun="+train.getShuttlerun()+",");
		}else{
			sb.append("shuttlerun=null,");
		}
		if(StringUtil.isNotEmpty(train.getBenchpress())){
			sb.append("benchpress="+train.getBenchpress()+",");
		}else{
			sb.append("benchpress=null,");
		}
		if(StringUtil.isNotEmpty(train.getFmeters())){
			sb.append("50meters="+train.getFmeters()+",");
		}else{
			sb.append("50meters=null,");
		}
		if(StringUtil.isNotEmpty(train.getOmeters())){
			sb.append("1000meters="+train.getOmeters()+",");
		}else{
			sb.append("1000meters=null,");
		}
		if(StringUtil.isNotEmpty(train.getSetshot())){
			sb.append("setshot="+train.getSetshot()+",");
		}else{
			sb.append("setshot=null,");
		}
		sb.append("addtime='"+train.getAddtime()+"' where Id=?");
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, Id);
        return pstmt.executeUpdate();
	}
	public ResultSet feedBack(Connection con,int coaId,PageBean pageBean)throws Exception{
		StringBuffer sb=new StringBuffer("select Id,tb_studentinformation.stuId,stuname,shuttlerun,benchpress,50meters,1000meters,setshot,addtime,doubt,doubtcontent from tb_studentinformation,tb_studenttraininformation,tb_studentcoach where tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=? and doubt=1");
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, coaId);
		return pstmt.executeQuery();
	}
	public int feedBackCount(Connection con,int coaId)throws Exception{
		String sql="select count(*) as total from tb_studentinformation,tb_studenttraininformation,tb_studentcoach where tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=? and doubt=1";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, coaId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public int okDoubt(Connection con,int Id)throws Exception{
		String sql="update tb_studenttraininformation set doubt=2 where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1,Id);
        return pstmt.executeUpdate();
	}
	public ResultSet allTrainList(Connection con,PageBean pageBean,SearchTrain searchTrain)throws Exception{
		StringBuffer sb=new StringBuffer("select *  from tb_studenttraininformation,tb_studentinformation,tb_studentcoach,tb_coachinformation,tb_coachclub,tb_clubinformation where tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId");
		if(StringUtil.isNotEmpty(searchTrain.getStuId())){
			sb.append(" and tb_studenttraininformation.stuId like '%"+searchTrain.getStuId()+"%'");
		}
		if(StringUtil.isNotEmpty(searchTrain.getStuname())){
			sb.append(" and stuname like '%"+searchTrain.getStuname()+"%'");
		}
		if(StringUtil.isNotEmpty(searchTrain.getCoaname())){
			sb.append(" and coaname like '%"+searchTrain.getCoaname()+"%'");
		}
		if(StringUtil.isNotEmpty(searchTrain.getClubname())){
			sb.append(" and clubname like '%"+searchTrain.getClubname()+"%'");
		}
		if(StringUtil.isNotEmpty(searchTrain.getBegintime()) || StringUtil.isNotEmpty(searchTrain.getEndtime())){
			if(StringUtil.isNotEmpty(searchTrain.getBegintime()) && StringUtil.isEmpty(searchTrain.getEndtime())){
				sb.append(" and addtime >= '"+searchTrain.getBegintime()+"'");
			}else if(StringUtil.isEmpty(searchTrain.getBegintime()) && StringUtil.isNotEmpty(searchTrain.getEndtime())){
				sb.append(" and addtime <= '"+searchTrain.getEndtime()+"'");
			}else{
				sb.append(" and addtime between '"+searchTrain.getBegintime()+"' and '"+searchTrain.getEndtime()+"'");
			}
		}
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		return pstmt.executeQuery();
	}
	public int allTrainCount(Connection con,SearchTrain searchTrain)throws Exception{
		StringBuffer sb=new StringBuffer("select count(*) as total  from tb_studenttraininformation,tb_studentinformation,tb_studentcoach,tb_coachinformation,tb_coachclub,tb_clubinformation where tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId=tb_clubinformation.clubId");
		if(StringUtil.isNotEmpty(searchTrain.getStuId())){
			sb.append(" and tb_studenttraininformation.stuId like '%"+searchTrain.getStuId()+"%'");
		}
		if(StringUtil.isNotEmpty(searchTrain.getStuname())){
			sb.append(" and stuname like '%"+searchTrain.getStuname()+"%'");
		}
		if(StringUtil.isNotEmpty(searchTrain.getCoaname())){
			sb.append(" and coaname like '%"+searchTrain.getCoaname()+"%'");
		}
		if(StringUtil.isNotEmpty(searchTrain.getClubname())){
			sb.append(" and clubname like '%"+searchTrain.getClubname()+"%'");
		}
		if(StringUtil.isNotEmpty(searchTrain.getBegintime()) || StringUtil.isNotEmpty(searchTrain.getEndtime())){
			if(StringUtil.isNotEmpty(searchTrain.getBegintime()) && StringUtil.isEmpty(searchTrain.getEndtime())){
				sb.append(" and addtime >= '"+searchTrain.getBegintime()+"'");
			}else if(StringUtil.isEmpty(searchTrain.getBegintime()) && StringUtil.isNotEmpty(searchTrain.getEndtime())){
				sb.append(" and addtime <= '"+searchTrain.getEndtime()+"'");
			}else{
				sb.append(" and addtime between '"+searchTrain.getBegintime()+"' and '"+searchTrain.getEndtime()+"'");
			}
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public ResultSet besttrain(Connection con,int Id)throws Exception{
		String sql="select min(shuttlerun) as shuttlerun ,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot from "
				+ "(select tb_studentinformation.stuId,stuname,coaname,clubname,tb_studentinformation.province,min(shuttlerun) as shuttlerun,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot from tb_studentinformation,tb_coachinformation,tb_clubinformation,tb_studentcoach,tb_coachclub,tb_studenttraininformation where tb_studentinformation.birthday between date_add((select birthday from tb_studentinformation where stuId=?), interval -6 month) and date_add((select birthday from tb_studentinformation where stuId=?), interval 6 month) and tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId= tb_clubinformation.clubId group by tb_studentinformation.stuId)aa";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1,Id);
		pstmt.setInt(2,Id);
		return pstmt.executeQuery();
	}
	public ResultSet mybesttrain(Connection con,int Id)throws Exception{
		String sql="select shuttlerun,benchpress,50meters,1000meters,setshot from(select tb_studentinformation.stuId,stuname,coaname,clubname,tb_studentinformation.province,min(shuttlerun) as shuttlerun,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot from tb_studentinformation,tb_coachinformation,tb_clubinformation,tb_studentcoach,tb_coachclub,tb_studenttraininformation where tb_studentinformation.birthday between date_add((select birthday from tb_studentinformation where stuId=?), interval -6 month) and date_add((select birthday from tb_studentinformation where stuId=?), interval 6 month) and tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId= tb_clubinformation.clubId group by tb_studentinformation.stuId)aa where stuId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1,Id);
		pstmt.setInt(2,Id);
		pstmt.setInt(3,Id);
		return pstmt.executeQuery();
	}
	public ResultSet worsttrain(Connection con,int Id)throws Exception{
		String sql="select max(shuttlerun) as shuttlerun ,min(benchpress) as benchpress,max(50meters) as 50meters,max(1000meters) as 1000meters,min(setshot) as setshot from "
				+ "(select tb_studentinformation.stuId,stuname,coaname,clubname,tb_studentinformation.province,min(shuttlerun) as shuttlerun,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot from tb_studentinformation,tb_coachinformation,tb_clubinformation,tb_studentcoach,tb_coachclub,tb_studenttraininformation where tb_studentinformation.birthday between date_add((select birthday from tb_studentinformation where stuId=?), interval -6 month) and date_add((select birthday from tb_studentinformation where stuId=?), interval 6 month) and tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId= tb_clubinformation.clubId group by tb_studentinformation.stuId)aa";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1,Id);
		pstmt.setInt(2,Id);
		return pstmt.executeQuery();
	}
	public JSONArray studentPersonalRank(Connection con,int stuId)throws Exception{
		JSONArray result=new JSONArray();
		String sql="select count(*) as shuttlerun from (select tb_studentinformation.stuId,stuname,coaname,clubname,tb_studentinformation.province,min(shuttlerun) as shuttlerun,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot from tb_studentinformation,tb_coachinformation,tb_clubinformation,tb_studentcoach,tb_coachclub,tb_studenttraininformation where tb_studentinformation.birthday between date_add((select birthday from tb_studentinformation where stuId=?), interval -6 month) and date_add((select birthday from tb_studentinformation where stuId=?), interval 6 month) and tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId= tb_clubinformation.clubId group by tb_studentinformation.stuId)aa where aa.shuttlerun<(select min(shuttlerun)from tb_studenttraininformation where stuId=?)";
		PreparedStatement pstmt1=con.prepareStatement(sql);
		pstmt1.setInt(1,stuId);
		pstmt1.setInt(2,stuId);
		pstmt1.setInt(3,stuId);;
		ResultSet rs1=pstmt1.executeQuery();
		while(rs1.next()){
			result.add(rs1.getInt("shuttlerun")+1);
		}
		sql="select count(*) as benchpress from (select tb_studentinformation.stuId,stuname,coaname,clubname,tb_studentinformation.province,min(shuttlerun) as shuttlerun,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot from tb_studentinformation,tb_coachinformation,tb_clubinformation,tb_studentcoach,tb_coachclub,tb_studenttraininformation where tb_studentinformation.birthday between date_add((select birthday from tb_studentinformation where stuId=?), interval -6 month) and date_add((select birthday from tb_studentinformation where stuId=?), interval 6 month) and tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId= tb_clubinformation.clubId group by tb_studentinformation.stuId)aa where aa.benchpress>(select max(benchpress)from tb_studenttraininformation where stuId=?)";
		PreparedStatement pstmt2=con.prepareStatement(sql);
		pstmt2.setInt(1,stuId);
		pstmt2.setInt(2,stuId);
		pstmt2.setInt(3,stuId);
		ResultSet rs2=pstmt2.executeQuery();
		while(rs2.next()){
			result.add(rs2.getInt("benchpress")+1);
		}
		sql="select count(*) as 50meters from (select tb_studentinformation.stuId,stuname,coaname,clubname,tb_studentinformation.province,min(shuttlerun) as shuttlerun,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot from tb_studentinformation,tb_coachinformation,tb_clubinformation,tb_studentcoach,tb_coachclub,tb_studenttraininformation where tb_studentinformation.birthday between date_add((select birthday from tb_studentinformation where stuId=?), interval -6 month) and date_add((select birthday from tb_studentinformation where stuId=?), interval 6 month) and tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId= tb_clubinformation.clubId group by tb_studentinformation.stuId)aa where aa.50meters<(select min(50meters)from tb_studenttraininformation where stuId=?)";
		PreparedStatement pstmt3=con.prepareStatement(sql);
		pstmt3.setInt(1,stuId);
		pstmt3.setInt(2,stuId);
		pstmt3.setInt(3,stuId);
		ResultSet rs3=pstmt3.executeQuery();
		while(rs3.next()){
			result.add(rs3.getInt("50meters")+1);
		}
		sql="select count(*) as 1000meters from (select tb_studentinformation.stuId,stuname,coaname,clubname,tb_studentinformation.province,min(shuttlerun) as shuttlerun,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot from tb_studentinformation,tb_coachinformation,tb_clubinformation,tb_studentcoach,tb_coachclub,tb_studenttraininformation where tb_studentinformation.birthday between date_add((select birthday from tb_studentinformation where stuId=?), interval -6 month) and date_add((select birthday from tb_studentinformation where stuId=?), interval 6 month) and tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId= tb_clubinformation.clubId group by tb_studentinformation.stuId)aa where aa.1000meters<(select min(1000meters)from tb_studenttraininformation where stuId=?)";
		PreparedStatement pstmt4=con.prepareStatement(sql);
		pstmt4.setInt(1,stuId);
		pstmt4.setInt(2,stuId);
		pstmt4.setInt(3,stuId);
		ResultSet rs4=pstmt4.executeQuery();
		while(rs4.next()){
			result.add(rs4.getInt("1000meters")+1);
		}
		sql="select count(*) as setshot from (select tb_studentinformation.stuId,stuname,coaname,clubname,tb_studentinformation.province,min(shuttlerun) as shuttlerun,max(benchpress) as benchpress,min(50meters) as 50meters,min(1000meters) as 1000meters,max(setshot) as setshot from tb_studentinformation,tb_coachinformation,tb_clubinformation,tb_studentcoach,tb_coachclub,tb_studenttraininformation where tb_studentinformation.birthday between date_add((select birthday from tb_studentinformation where stuId=?), interval -6 month) and date_add((select birthday from tb_studentinformation where stuId=?), interval 6 month) and tb_studentinformation.stuId=tb_studenttraininformation.stuId and tb_studentinformation.stuId=tb_studentcoach.stuId and tb_studentcoach.coaId=tb_coachinformation.coaId and tb_coachinformation.coaId=tb_coachclub.coaId and tb_coachclub.clubId= tb_clubinformation.clubId group by tb_studentinformation.stuId)aa where aa.setshot>(select max(setshot)from tb_studenttraininformation where stuId=?)";
		PreparedStatement pstmt5=con.prepareStatement(sql);
		pstmt5.setInt(1,stuId);
		pstmt5.setInt(2,stuId);
		pstmt5.setInt(3,stuId);
		ResultSet rs5=pstmt5.executeQuery();
		while(rs5.next()){
			result.add(rs5.getInt("setshot")+1);
		}
	    return result;
	}
	public int savetemporarytrain(Connection con,int stuId,String score,String addtime,String type)throws Exception{
		String sql="";
		if(type.equals("1")){
			 sql="insert into tb_temporarytrain(stuId,shuttlerun,addtime) values("+stuId+","+score+",'"+addtime+"')";
		}else if(type.equals("2")){
			sql="insert into tb_temporarytrain(stuId,benchpress,addtime) values("+stuId+","+score+",'"+addtime+"')";
		}else if(type.equals("3")){
			sql="insert into tb_temporarytrain(stuId,50meters,addtime) values("+stuId+","+score+",'"+addtime+"')";
		}else if(type.equals("4")){
			sql="insert into tb_temporarytrain(stuId,1000meters,addtime) values("+stuId+","+score+",'"+addtime+"')";
		}else if(type.equals("5")){
			sql="insert into tb_temporarytrain(stuId,setshot,addtime) values("+stuId+","+score+",'"+addtime+"')";
		}
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeUpdate();
	}
	public ResultSet phonetrainList(Connection con,int coaId,PageBean pageBean,String type) throws Exception{
		StringBuffer sb=new StringBuffer();
		if(type.equals("1")){
			sb.append("select tb_studentinformation.stuId,stuname,sex,shuttlerun from tb_temporarytrain,tb_studentinformation,tb_temporarystudent where tb_temporarystudent.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_studentinformation.stuId and shuttlerun!='null' and tb_temporarystudent.coaId=?");
		}else if(type.equals("2")){
			sb.append("select tb_studentinformation.stuId,stuname,sex,benchpress from tb_temporarytrain,tb_studentinformation,tb_temporarystudent where tb_temporarystudent.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_studentinformation.stuId and benchpress!='null' and tb_temporarystudent.coaId=?");
		}else if(type.equals("3")){
			sb.append("select tb_studentinformation.stuId,stuname,sex,50meters from tb_temporarytrain,tb_studentinformation,tb_temporarystudent where tb_temporarystudent.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_studentinformation.stuId and 50meters!='null' and tb_temporarystudent.coaId=?");
		}else if(type.equals("4")){
			sb.append("select tb_studentinformation.stuId,stuname,sex,1000meters from tb_temporarytrain,tb_studentinformation,tb_temporarystudent where tb_temporarystudent.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_studentinformation.stuId and 1000meters!='null' and tb_temporarystudent.coaId=?");
		}else if(type.equals("5")){
			sb.append("select tb_studentinformation.stuId,stuname,sex,setshot from tb_temporarytrain,tb_studentinformation,tb_temporarystudent where tb_temporarystudent.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_studentinformation.stuId and setshot!='null' and tb_temporarystudent.coaId=?");
		}
		sb.append(" order by Id desc");
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, coaId);
		return pstmt.executeQuery();
	}
	public int phonetrainCount(Connection con,int coaId,String type)throws Exception{
		StringBuffer sb=new StringBuffer();
		if(type.equals("1")){
			sb.append("select Count(*) as total from tb_temporarytrain,tb_studentinformation,tb_temporarystudent where tb_temporarystudent.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_studentinformation.stuId and shuttlerun!='null' and tb_temporarystudent.coaId=?");
		}else if(type.equals("2")){
			sb.append("select Count(*) as total from tb_temporarytrain,tb_studentinformation,tb_temporarystudent where tb_temporarystudent.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_studentinformation.stuId and benchpress!='null' and tb_temporarystudent.coaId=?");
		}else if(type.equals("3")){
			sb.append("select Count(*) as total from tb_temporarytrain,tb_studentinformation,tb_temporarystudent where tb_temporarystudent.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_studentinformation.stuId and 50meters!='null' and tb_temporarystudent.coaId=?");
		}else if(type.equals("4")){
			sb.append("select Count(*) as total from tb_temporarytrain,tb_studentinformation,tb_temporarystudent where tb_temporarystudent.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_studentinformation.stuId and 1000meters!='null' and tb_temporarystudent.coaId=?");
		}else if(type.equals("5")){
			sb.append("select Count(*) as total from tb_temporarytrain,tb_studentinformation,tb_temporarystudent where tb_temporarystudent.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_studentinformation.stuId and setshot!='null' and tb_temporarystudent.coaId=?");
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
	public ResultSet alltemporarytrainList(Connection con,int coaId,PageBean pageBean) throws Exception{
		StringBuffer sb=new StringBuffer("select Id,stuname,tb_temporarytrain.stuId,shuttlerun as score,'折返跑' as type from tb_temporarytrain,tb_temporarystudent,tb_studentinformation where tb_studentinformation.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_temporarystudent.stuId and tb_temporarystudent.coaId=? and shuttlerun!='null' union select Id,stuname,tb_temporarytrain.stuId,benchpress as score,'卧推' as type from tb_temporarytrain,tb_temporarystudent,tb_studentinformation where tb_studentinformation.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_temporarystudent.stuId and tb_temporarystudent.coaId=? and benchpress!='null' union select Id,stuname,tb_temporarytrain.stuId,50meters as score,'50米跑' as type from tb_temporarytrain,tb_temporarystudent,tb_studentinformation where tb_studentinformation.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_temporarystudent.stuId and tb_temporarystudent.coaId=? and 50meters!='null' union select Id,stuname,tb_temporarytrain.stuId,1000meters as score,'1000米跑' as type from tb_temporarytrain,tb_temporarystudent,tb_studentinformation where tb_studentinformation.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_temporarystudent.stuId and tb_temporarystudent.coaId=? and 1000meters!='null'  union select Id,stuname,tb_temporarytrain.stuId,setshot as score,'定点投篮' as type from tb_temporarytrain,tb_temporarystudent,tb_studentinformation where tb_studentinformation.stuId=tb_temporarytrain.stuId and tb_temporarytrain.stuId=tb_temporarystudent.stuId and tb_temporarystudent.coaId=? and setshot!='null'  order by type desc,Id desc");
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		pstmt.setInt(1, coaId);
		pstmt.setInt(2, coaId);
		pstmt.setInt(3, coaId);
		pstmt.setInt(4, coaId);
		pstmt.setInt(5, coaId);
		return pstmt.executeQuery();
		
	}
	public int alltemporarytrainCount(Connection con,int coaId) throws Exception{
		String sql="select Count(*) as total from tb_temporarytrain,tb_temporarystudent where tb_temporarytrain.stuId=tb_temporarystudent.stuId and tb_temporarystudent.coaId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, coaId);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	public int phonedeletetrain(Connection con,int Id)throws Exception{
		String sql="delete from tb_temporarytrain where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Id);
		return pstmt.executeUpdate();
	}
	public int phonesavealltrain(Connection con,int coaId)throws Exception{
		int modifynum=0;
		String sql="";
		sql="insert into tb_studenttraininformation(stuId,shuttlerun,benchpress,50meters,1000meters,setshot,addtime) select tb_temporarytrain.stuId,shuttlerun,benchpress,50meters,1000meters,setshot,addtime from tb_temporarytrain,tb_temporarystudent where tb_temporarytrain.stuId=tb_temporarystudent.stuId and tb_temporarystudent.coaId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, coaId);
		modifynum=modifynum+pstmt.executeUpdate();
		sql="delete from tb_temporarytrain where stuId=any(select stuId from tb_temporarystudent where coaId=?)";
		PreparedStatement pstmt1=con.prepareStatement(sql);
		pstmt1.setInt(1, coaId);
		modifynum=modifynum+pstmt1.executeUpdate();
		sql="delete from tb_temporarystudent where coaId=?";
		PreparedStatement pstmt2=con.prepareStatement(sql);
		pstmt2.setInt(1, coaId);
		modifynum=modifynum+pstmt2.executeUpdate();
		return modifynum;
	}
	public ResultSet PhonePCDataChart(Connection con,int type) throws Exception{
		String sql="";
		if(type==1){
			sql=" select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m')  union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') union all select Count(*),date_format(now(),'%Y-%m') as addtime from tb_studenttraininformation as months where addtype=1 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(now(),'%Y-%m') ";
		}else if(type==2){
			sql=" select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m')  union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') union all select Count(*),date_format(now(),'%Y-%m') as addtime from tb_studenttraininformation as months where addtype=1 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(now(),'%Y-%m') ";
		}else if(type==3){
			sql=" select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m')  union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') union all select Count(*),date_format(now(),'%Y-%m') as addtime from tb_studenttraininformation as months where addtype=1 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(now(),'%Y-%m') ";
		}else if(type==4){
			sql=" select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m')  union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') union all select Count(*),date_format(now(),'%Y-%m') as addtime from tb_studenttraininformation as months where addtype=1 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(now(),'%Y-%m') ";
		}else if(type==5){
			sql=" select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m')  union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=1 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') union all select Count(*),date_format(now(),'%Y-%m') as addtime from tb_studenttraininformation as months where addtype=1 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(now(),'%Y-%m') ";
		}else if(type==6){
			sql=" select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m')  union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') union all select Count(*),date_format(now(),'%Y-%m') as addtime from tb_studenttraininformation as months where addtype=0 and shuttlerun!='null' and date_format(addtime,'%Y-%m')=date_format(now(),'%Y-%m') ";
		}else if(type==7){
			sql=" select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m')  union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') union all select Count(*),date_format(now(),'%Y-%m') as addtime from tb_studenttraininformation as months where addtype=0 and benchpress!='null' and date_format(addtime,'%Y-%m')=date_format(now(),'%Y-%m') ";
		}else if(type==8){
			sql=" select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m')  union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') union all select Count(*),date_format(now(),'%Y-%m') as addtime from tb_studenttraininformation as months where addtype=0 and 50meters!='null' and date_format(addtime,'%Y-%m')=date_format(now(),'%Y-%m') ";
		}else if(type==9){
			sql=" select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m')  union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') union all select Count(*),date_format(now(),'%Y-%m') as addtime from tb_studenttraininformation as months where addtype=0 and 1000meters!='null' and date_format(addtime,'%Y-%m')=date_format(now(),'%Y-%m') ";
		}else if(type==10){
			sql=" select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 5 MONTH),'%Y-%m')  union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 4 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 3 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 2 MONTH),'%Y-%m') union all select Count(*),date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') as months from tb_studenttraininformation where addtype=0 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(DATE_SUB(curdate(), INTERVAL 1 MONTH),'%Y-%m') union all select Count(*),date_format(now(),'%Y-%m') as addtime from tb_studenttraininformation as months where addtype=0 and setshot!='null' and date_format(addtime,'%Y-%m')=date_format(now(),'%Y-%m') ";
		}
		PreparedStatement pstmt=con.prepareStatement(sql);
		return pstmt.executeQuery();
	}
	public int adddoubt(Connection con,int Id,String detail)throws Exception{
		String sql="update tb_studenttraininformation set doubt=1,doubtcontent='"+detail+"' where Id=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Id);
		return pstmt.executeUpdate();
	}
}
