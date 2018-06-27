package basketball.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.sql.ResultSet;

public class DataContrastUtil {

	public static String datacontrast(ResultSet rs1,ResultSet rs2,ResultSet rs3)throws Exception{
		StringBuffer sb=new StringBuffer("[");
		Double result;
		while(rs1.next()&&rs2.next()&&rs3.next()){
			if(Double.parseDouble(rs1.getString(1))-Double.parseDouble(rs2.getString(1))==0){
				result=10.0;
			}else if(Double.parseDouble(rs3.getString(1))-Double.parseDouble(rs2.getString(1))==0){
				result=0.0;
			}else{
				result=(Double.parseDouble(rs2.getString(1))-Double.parseDouble(rs3.getString(1)))/(Double.parseDouble(rs1.getString(1))-Double.parseDouble(rs3.getString(1)))*10;
			}
			sb.append(result+",");
			if(Double.parseDouble(rs1.getString(2))-Double.parseDouble(rs2.getString(2))==0){
				result=10.0;
			}else if(Double.parseDouble(rs3.getString(2))-Double.parseDouble(rs2.getString(2))==0){
				result=0.0;
			}else{
				result=(Double.parseDouble(rs2.getString(2))-Double.parseDouble(rs3.getString(2)))/(Double.parseDouble(rs1.getString(2))-Double.parseDouble(rs3.getString(2)))*10;
			}
			sb.append(result+",");
			if(Double.parseDouble(rs1.getString(3))-Double.parseDouble(rs2.getString(3))==0){
				result=10.0;
			}else if(Double.parseDouble(rs3.getString(3))-Double.parseDouble(rs2.getString(3))==0){
				result=0.0;
			}else{
				result=(Double.parseDouble(rs2.getString(3))-Double.parseDouble(rs3.getString(3)))/(Double.parseDouble(rs1.getString(3))-Double.parseDouble(rs3.getString(3)))*10;
			}
			sb.append(result+",");
			if(Double.parseDouble(rs1.getString(4))-Double.parseDouble(rs2.getString(4))==0){
				result=10.0;
			}else if(Double.parseDouble(rs3.getString(4))-Double.parseDouble(rs2.getString(4))==0){
				result=0.0;
			}else{
				result=(Double.parseDouble(rs2.getString(4))-Double.parseDouble(rs3.getString(4)))/(Double.parseDouble(rs1.getString(4))-Double.parseDouble(rs3.getString(4)))*10;
			}
			sb.append(result+",");
			System.out.println(5.0/0.0);
			if(Double.parseDouble(rs1.getString(5))-Double.parseDouble(rs2.getString(5))==0){
				result=10.0;
			}else if(Double.parseDouble(rs3.getString(5))-Double.parseDouble(rs2.getString(5))==0){
				result=0.0;
			}else{
				result=(Double.parseDouble(rs2.getString(5))-Double.parseDouble(rs3.getString(5)))/(Double.parseDouble(rs1.getString(5))-Double.parseDouble(rs3.getString(5)))*10;
			}
			sb.append(result+",");
		}
		sb.append("]");
		return sb.toString();
	}
}
