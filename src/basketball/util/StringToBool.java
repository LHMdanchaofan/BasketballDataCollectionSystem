package basketball.util;

public class StringToBool {
	public static boolean isTrue(String str){
		if(str.equals("false")){
		   return false;
		}else if(str.equals("true")){
		   return true;
		}else{
			return false;
		}
	}
}
