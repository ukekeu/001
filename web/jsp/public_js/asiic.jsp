<%!
String Upp="";

public String AsiicZH(int j,char BeR){
 String N=" ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
 Upp=N;
 if(!java.lang.Character.isDigit(BeR)){
			N=N.substring(j,1+j);
		 }else{N= String.valueOf(j);}  
	return N;
	}

public String AsiicF(int j,String BeF){
 String N=" ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
 Upp=N;
    if (Upp.indexOf(BeF)>=0){
			N=N.substring(j,1+j);
		 }else{N= String.valueOf(j);}  
	return N;
	}
public String AsiicFloorType(String F,String fl_type){
	 String N="";
	 if(fl_type.equals("1")){
	    if (F.equals("A"))N="-1";
		else if (F.equals("B"))N="-2";	
		else if (F.equals("C"))N="-3";		
		else if (F.equals("D"))N="-4";	
	    else if (F.equals("E"))N="-5";		
		else if (F.equals("F"))N="-6";	
		else if (F.equals("G"))N="-7";	
		else if (F.equals("H"))N="-8";	
	 }else{N= F;}  
	return N;
	}		
 %>