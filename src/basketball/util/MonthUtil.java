package basketball.util;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class MonthUtil {
      public static String montharray(String begintime,String endtime){
    	  StringBuffer sb=new StringBuffer("[");
    	  int i,j;
    	  int abc=Integer.parseInt(begintime.substring(5));
    	  int def=Integer.parseInt(endtime.substring(5));
    	  for(i=Integer.parseInt(begintime.substring(0, 4));i<=Integer.parseInt(endtime.substring(0, 4));i++)
    	  {
    		  if(Integer.parseInt(begintime.substring(0, 4))==Integer.parseInt(endtime.substring(0, 4))){
    			  for(j=abc;j<=def;j++){
        		      sb.append("'");
        		      if(j<10){
            		      sb.append(i+"-0"+j);
        		      }else{
        			      sb.append(i+"-"+j);
        		      }
        		      sb.append("',");
    			  }
    		  }else{
    		  if(i==Integer.parseInt(begintime.substring(0, 4))){
    			  for(j=abc;j<=12;j++){
        		      sb.append("'");
        		      if(j<10){
            		      sb.append(i+"-0"+j);
        		      }else{
        			      sb.append(i+"-"+j);
        		      }
        		      sb.append("',");
    			  }
    		  }else if(i<Integer.parseInt(endtime.substring(0, 4))){
    		      for(j=1;j<=12;j++){
    		      sb.append("'");
    		      if(j<10){
        		      sb.append(i+"-0"+j);
    		      }else{
    			      sb.append(i+"-"+j);
    		      }
    		      sb.append("',");
    		      }
    		   }else{
    	    		   for(j=1;j<=def;j++){
    	    		   sb.append("'");
    	    		   if(j<10){
    	        		   sb.append(i+"-0"+j);
    	    		   }else{
    	    			   sb.append(i+"-"+j);
    	    		   }
    	    		   sb.append("',");
    	    	  }
    		   }
    	  }
        }
    	  sb.append("]");
    	  return sb.toString();
      }
      public static String dataarray(String begintime,String endtime,ResultSet rs)throws Exception{
    	  StringBuffer sb=new StringBuffer();
    	  StringBuffer data=new StringBuffer("[");
    	  int i=0;
    	  int j=0;
    	  int count=Integer.parseInt(begintime.substring(0, 4));
    	  int abc=Integer.parseInt(begintime.substring(5));
    	  int def=Integer.parseInt(endtime.substring(5));
    	  while(rs.next()){
    		 for(i=count;i<=Integer.parseInt(endtime.substring(0, 4));i++){
    	      int flag=0;
    		  if(Integer.parseInt(begintime.substring(0, 4))==Integer.parseInt(endtime.substring(0, 4))){
    			  for(j=abc;j<=def;j++){
        		      if(j<10){
            		      sb.append(i+"-0"+j);
        		      }else{
        			      sb.append(i+"-"+j);
        		      }
    			      if(sb.toString().equals(rs.getString(2))){
    			    	  data.append(rs.getString(1)+",");
    			    	  sb.setLength(0);
    			    	  if(Integer.parseInt(rs.getString(2).substring(5))==12){
    			    		  count=i+1;
    			    		  abc=1;
    			    	  }else{
    			    		  count=i;
    			    		  abc=j+1;
    			    	  }
    			    	  flag=1;
    			    	  break;
    			      }else{
    			    	  data.append("null,");
    			    	  sb.setLength(0);
    			      }
    			   }
    		  }else{
    		  if(i==Integer.parseInt(begintime.substring(0, 4))){
    			  for(j=abc;j<=12;j++){
        		      if(j<10){
            		      sb.append(i+"-0"+j);
        		      }else{
        			      sb.append(i+"-"+j);
        		      }
        		      if(sb.toString().equals(rs.getString(2))){
    			    	  data.append(rs.getString(1)+",");
    			    	  sb.setLength(0);
    			    	  if(Integer.parseInt(rs.getString(2).substring(5))==12){
    			    		  count=i+1;
    			    		  abc=1;
    			    	  }else{
    			    		  count=i;
    			    		  abc=j+1;
    			    	  }
    			    	  flag=1;
    			    	  break;
    			      }else{
    			    	  data.append("null,");
    			    	  sb.setLength(0);
    			      }
    			  }
    		  }else if(i<Integer.parseInt(endtime.substring(0, 4))){
    		      for(j=1;j<=12;j++){
    		      if(j<10){
        		      sb.append(i+"-0"+j);
    		      }else{
    			      sb.append(i+"-"+j);
    		      }
    		      if(sb.toString().equals(rs.getString(2))){
			    	  data.append(rs.getString(1)+",");
			    	  sb.setLength(0);
			    	  if(Integer.parseInt(rs.getString(2).substring(5))==12){
			    		  count=i+1;
			    		  abc=1;
			    	  }else{
			    		  count=i;
			    		  abc=j+1;
			    	  }
			    	  break;
			      }else{
			    	  data.append("null,");
			    	  sb.setLength(0);
			      }
    		      }
    		   }else{
    	    		   for(j=1;j<=def;j++){
    	    		   if(j<10){
    	        		   sb.append(i+"-0"+j);
    	    		   }else{
    	    			   sb.append(i+"-"+j);
    	    		   }
    	    		   if(sb.toString().equals(rs.getString(2))){
     			    	  data.append(rs.getString(1)+",");
     			    	  sb.setLength(0);
     			    	 if(Integer.parseInt(rs.getString(2).substring(5))==12){
   			    		  count=i+1;
   			    		  abc=1;
   			    	  }else{
   			    		  count=i;
   			    		  abc=j+1;
   			    	  }
     			    	  flag=1;
     			    	  break;
     			      }else{
     			    	  data.append("null,");
     			    	  sb.setLength(0);
     			      }
    		   }
    		   }
    	  }
    		  if(flag==1){
    			  break;
    		  }
        }
    	  
    }
    	  String temporary="";
    	  if(j<10){
    		  temporary=i+"-0"+j;
    	  }else{
    		  temporary=i+"-"+j;
    	  }
    	  if(temporary.equals(endtime)){
    		  
    	  }else{
    		  for(i=Integer.parseInt(temporary.substring(0, 4));i<=Integer.parseInt(endtime.substring(0, 4));i++)
        	  {
        		  if(Integer.parseInt(temporary.substring(0, 4))==Integer.parseInt(endtime.substring(0, 4))){
        			  for(j=abc;j<=def;j++){
        				  data.append("null,");
        			  }
        		  }else{
        		  if(i==Integer.parseInt(temporary.substring(0, 4))){
        			  for(j=abc;j<=12;j++){
        				  data.append("null,");
        			  }
        		  }else if(i<Integer.parseInt(endtime.substring(0, 4))){
        		      for(j=1;j<=12;j++){
        		    	  data.append("null,");
        		      }
        		   }else{
        	    		   for(j=1;j<=def;j++){
        	    			   data.append("null,");
        	    	  }
        		   }
        	  }
            }
    	  }
    	  data.append("]");
    	  return data.toString();
      }
      public static String dataarray2(String begintime,String endtime,ResultSet rs)throws Exception{
    	  StringBuffer sb=new StringBuffer("[");
    	  int i,j;
    	  int abc=Integer.parseInt(begintime.substring(5));
    	  int def=Integer.parseInt(endtime.substring(5));
    	  while(rs.next()){
    	  for(i=Integer.parseInt(begintime.substring(0, 4));i<=Integer.parseInt(endtime.substring(0, 4));i++)
    	  {
    		  if(Integer.parseInt(begintime.substring(0, 4))==Integer.parseInt(endtime.substring(0, 4))){
    			  for(j=abc;j<=def;j++){
        		      sb.append(rs.getString(1));
        		      sb.append(",");
    			  }
    		  }else{
    		  if(i==Integer.parseInt(begintime.substring(0, 4))){
    			  for(j=abc;j<=12;j++){
    				  sb.append(rs.getString(1));
        		      sb.append(",");
    			  }
    		  }else if(i<Integer.parseInt(endtime.substring(0, 4))){
    		      for(j=1;j<=12;j++){
    		    	  sb.append(rs.getString(1));
        		      sb.append(",");
    		      }
    		   }else{
    	    		   for(j=1;j<=def;j++){
    	    			   sb.append(rs.getString(1));
    	        		      sb.append(",");
    	    	  }
    		   }
    	  }
        }
     }
    	  sb.append("]");
    	  return sb.toString();
      } 
}
