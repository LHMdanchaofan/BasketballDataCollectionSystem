package basketball.util;
import java.sql.ResultSet;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class DistributionUtil {
       
	 public static JSONArray distributionarray(ResultSet rs)throws Exception{
		 JSONArray array=new JSONArray();
		 while(rs.next()){
			 JSONObject mapOfColValues=new JSONObject();
			 mapOfColValues.put("name",rs.getString(2));
			 mapOfColValues.put("value",rs.getInt(1));
			 array.add(mapOfColValues);			 
		 }

		return array;
	 }
}
