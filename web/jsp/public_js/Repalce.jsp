<%!
    public String Repalce(String str,String str1) throws Exception  {
      String disnum=str.trim();
	  String discnum="";
	  int num=0;
	  int num1=0;
	  String arry[]=new String[10];
	  boolean sss=false;
	  for (int n=0;n<disnum.length();n++)//
	  {
	     if (disnum.substring(n,n+1).equals(str1)){
		 sss=true;
		 arry[num]=disnum.substring(num1,n).trim();
		 num1=n+1;
		 num++;
		 if (!disnum.substring(n+1).equals(str1))
		 {arry[num]=disnum.substring(n+1).trim();}
		}
	  }
	  disnum="";
	  for (int n1=0;n1<=num;n1++)
	  {
	    if (arry[n1]!=null){
		if (disnum.equals(""))disnum=arry[n1];
		else disnum+="<br> "+arry[n1];
		}
	  }
	  if (!sss)disnum=str.trim();
	  
   return disnum;
  } 
  
   public String Repalce4(String str,String str1) throws Exception  {
      String disnum=str.trim();
	  String discnum="";
	  int num=0;
	  int num1=0;
         int jj=0;
         for(int ii=0;ii<disnum.length();ii++){
          if (disnum.substring(ii,ii+1).equals("/"))jj++;
         }

	  String arry[]=new String[jj+1];
	  boolean sss=false;
	  for (int n=0;n<disnum.length();n++)//
	  {
	     if (disnum.substring(n,n+1).equals(str1)){
		 sss=true;
		 arry[num]=disnum.substring(num1,n).trim();
		 num1=n+1;
		 num++;
		 if (!disnum.substring(n+1).equals(str1))
		 {arry[num]=disnum.substring(n+1).trim();}
		}
	  }
	  disnum="";
	  for (int n1=0;n1<=num;n1++)
	  {
	    if (arry[n1]!=null){
		if (n1==0)disnum="'"+arry[n1]+"'";
		else if (!arry[n1].equals(arry[n1-1]))    disnum+=",'"+arry[n1]+"'";
		}
              
	  }
	  if (!sss)disnum=str.trim();
	  
   return disnum;
  } 
  public String Repalce6(String str,String str1) throws Exception  {
      String disnum=str.trim();
	  String discnum="";
	  int num=0;
	  int num1=0;
         int jj=0;
         for(int ii=0;ii<disnum.length();ii++){
          if (disnum.substring(ii,ii+1).equals("/"))jj++;
         }

	  String arry[]=new String[jj+1];
	  boolean sss=false;
	  for (int n=0;n<disnum.length();n++)//
	  {
	     if (disnum.substring(n,n+1).equals(str1)){
		 sss=true;
		 arry[num]=disnum.substring(num1,n).trim();
		 num1=n+1;
		 num++;
		 if (!disnum.substring(n+1).equals(str1))
		 {arry[num]=disnum.substring(n+1).trim();}
		}
	  }
	  disnum="";
	  for (int n1=0;n1<=num;n1++)
	  {
	    if (arry[n1]!=null){
		if (n1==0)disnum="''"+arry[n1]+"''";
		else if (!arry[n1].equals(arry[n1-1]))    disnum+=",''"+arry[n1]+"''";
		}
              
	  }
	  if (!sss)disnum=str.trim();
	  
   return disnum;
  }
   public String Repalce5(String str,String str1,String str2) throws Exception  {
      String disnum=str.trim();
	  String discnum="";
	  int num=0;
	  int num1=0;
         int jj=0;
         for(int ii=0;ii<disnum.length();ii++){
          if (disnum.substring(ii,ii+1).equals(str1))jj++;
         }

	  String arry[]=new String[jj+1];
	  boolean sss=false;
	  for (int n=0;n<disnum.length();n++)//
	  {
	     if (disnum.substring(n,n+1).equals(str1)){
		 sss=true;
		 arry[num]=disnum.substring(num1,n).trim();
		 num1=n+1;
		 num++;
		 if (!disnum.substring(n+1).equals(str1))
		 {arry[num]=disnum.substring(n+1).trim();}
		}
	  }
	  disnum="";
	  for (int n1=0;n1<=num;n1++)
	  {
	    if (arry[n1]!=null){
		if (n1==0)disnum="'"+arry[n1]+"'";
		else if (!arry[n1].equals(arry[n1-1]))    disnum+=str2+arry[n1]+"'";
		}
              
	  }
	  if (!sss)disnum=str.trim();
	  
   return disnum;
  } 
  public String Repalce8(String str,String str1,String str2) throws Exception  {
      String disnum=str.trim();
	  String discnum="";
	  int num=0;
	  int num1=0;
         int jj=0;
         for(int ii=0;ii<disnum.length();ii++){
          if (disnum.substring(ii,ii+1).equals(str1))jj++;
         }

	  String arry[]=new String[jj+1];
	  boolean sss=false;
	  for (int n=0;n<disnum.length();n++)//
	  {
	     if (disnum.substring(n,n+1).equals(str1)){
		 sss=true;
		 arry[num]=disnum.substring(num1,n).trim();
		 num1=n+1;
		 num++;
		 if (!disnum.substring(n+1).equals(str1))
		 {arry[num]=disnum.substring(n+1).trim();}
		}
	  }
	  disnum="";
	  for (int n1=0;n1<=num;n1++)
	  {
	    if (arry[n1]!=null){
		if (n1==0)disnum=arry[n1];
		else if (!arry[n1].equals(arry[n1-1]))    disnum+=str2+arry[n1];
		}
              
	  }
	  if (!sss)disnum=str.trim();
	  
   return disnum;
  } 
   public String Repalce3(String str,String str1) throws Exception  {
      String disnum=str.trim();
	  String discnum="";
	  int num=0;
	  int num1=0;
	  String arry[]=new String[10];
	  boolean sss=false;
	  for (int n=0;n<disnum.length();n++)//
	  {
	     if (disnum.substring(n,n+1).equals(str1)){
		 sss=true;
		 arry[num]=disnum.substring(num1,n).trim();
		 num1=n+1;
		 num++;
		 if (!disnum.substring(n+1).equals(str1))
		 {arry[num]=disnum.substring(n+1).trim();}
		}
	  }
	  disnum="";
	  for (int n1=0;n1<=num;n1++)
	  {
	    if (arry[n1]!=null){
		if (disnum.equals(""))disnum="'"+arry[n1]+"'";
		else disnum+=",'"+arry[n1]+"'";
		}
	  }
	  if (!sss)disnum=str.trim();
	  
   return disnum;
  } 
  public String Repalce2(String str,String str1) throws Exception  {
      String disnum=str.trim();
	  String discnum="";
	  int num=0;
	  int num1=0;
	  String arry[]=new String[15];
	  boolean sss=false;
	  for (int n=0;n<disnum.length();n++)//
	  {
	     if (disnum.substring(n,n+1).equals(str1)){
		 sss=true;
		 arry[num]=disnum.substring(num1,n).trim();
		 num1=n+1;
		 num++;
		 if (!disnum.substring(n+1).equals(str1))
		 {arry[num]=disnum.substring(n+1).trim();}
		}
	  }
	  disnum="";
	  for (int n1=0;n1<=num;n1++)
	  {
	    if (arry[n1]!=null){
		if (disnum.equals(""))disnum=arry[n1];
		else disnum+=arry[n1];
		}
	  }
	  if (!sss)disnum=str.trim();
	  
   return disnum;
  } 
  
 public String Repalce1(String str,String str1) throws Exception  {
        if (!str.equals("")){
		StringTokenizer st22 = new StringTokenizer(str,str1) ;
		int count22 = st22.countTokens() ;
		String[] sellers22 = new String[count22] ;
		int j22 = 0 ;
		String sellerS="";
		String se="";
		while (st22.hasMoreElements()) {
		    se=(String)st22.nextElement();
			if (sellerS.equals(""))
			sellerS ="'"+ se.trim() +"'";
			else
			sellerS=sellerS+",'"+ se.trim() +"'";
			j22 ++ ;
		}
	
	  String SllerSql="select * from CortrolMan where SerialNo in("+sellerS+")";
	  ResultSet rs1=null;
	  ConnDatabase.SDatabase ViewBean=new ConnDatabase.SDatabase();
	  try{
	  rs1=ViewBean.executeQuery(SllerSql);
	  String name1="";
	  String userid="";
	  while(rs1.next()){        
	   userid=rs1.getString("SerialNo");
	   if (name1.equals(""))  name1=getbyte(rs1.getString("Name"));          
	   else name1+="<br>"+getbyte(rs1.getString("Name"));           
       }        
	  rs1.close(); 
	  
	 // return Repalce(name1,"*");
	 return name1;
	  }catch(Exception s){return s.getMessage();}
	  }else{
	  	  return str;
	  }
	}
	public String DateToFormat(String date) throws Exception  {
	 String StrDate="";
	 if (!date.equals("")){
	   java.text.SimpleDateFormat needdate =null;
       needdate=new java.text.SimpleDateFormat("yyyy-MM-dd");
	   StrDate=needdate.format(needdate.parse(date));
	 }
	 return  StrDate;
	}
 %>
