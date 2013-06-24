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
else disnum+="<br>"+arry[n1];
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
  }  public String Repalce5(String str,String str1,String str2) throws Exception  {
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
else disnum+=arry[n1];
}
  }
  if (!sss)disnum=str.trim();
  
   return disnum;
  } 
  
  
 public String cnMoney(String money) {
String errstr="";
int l=0; 
char c1[]={'零','壹','贰','叁','肆','伍','陆','柒','捌','玖'}; 
char C2[]={'分','角',' ','元','拾','佰','仟','万','拾','佰','仟','亿','拾','佰','仟','万'}; 
//char C2[]={'元','拾','佰','仟','万','拾','佰','仟','亿','拾','佰','仟','万'}; 
String DX=""; 
if(money!=null){ 
if(money.length()<=16){ 
float price=0; 
try{ 
price=java.lang.Float.parseFloat(money); 
} 
catch(NumberFormatException e){ 
errstr="输入的不是数字格式"; 
} 
           if(errstr.length()==0){ 
               l=money.length()-money.indexOf("."); 
   if(l==money.length()+1){ 
 money=money; //+".00"
} 
   else if(l==2){ 
money=money+"0"; 
} 
  else if(l==3){ 
money=money; 
} 
     else{ 
errstr="小数点后面只能有两位数字"; 
} 
} 

if(errstr.length()==0){ 
for(int i=0;i<money.length();i++){ 
l=money.length()-i; 

    char i_char=money.charAt(i); 
if(i_char!='.'){ 
int i_int=Integer.parseInt(String.valueOf(i_char)); 
String aa=String.valueOf(C2[l-1]); 
DX=DX+c1[i_int]+aa; 
} 
} 
} 
}else{ 
errstr="数字太大了"; 
} 
} 
return (DX.equals(""))?errstr:DX+"整";
 }
  public String cnDate(String date) {
String errstr="";
int l=0; 
char c1[]={'0','一','二','三','四','五','六','七','八','九'}; 
//char C2[]={'分','角',' ','元','拾','佰','仟','万','拾','佰','仟','亿','拾','佰','仟','万'}; 
String DX=""; 
String DX1=""; 
String DX2=""; 
if(date!=null){ 
String year=date.substring(0,4);
String month=date.substring(4,6);
String day=date.substring(6,8);
for(int i=0;i<year.length();i++){ 
l=year.length()-i; 
    char i_char=year.charAt(i); 
int i_int=Integer.parseInt(String.valueOf(i_char)); 
DX=DX+c1[i_int];
}
 String FT="true";
for(int i=0;i<month.length();i++){ 
if (!month.substring(i,i+1).equals("0")){
 int i_int=Integer.parseInt(month.substring(i,i+1)); 
String aa="";
if (i==1&&FT.equals("true"))aa="十";
DX1=DX1+aa+c1[i_int];
}else{
 FT="false";
}
}
FT="true";
for(int i=0;i<day.length();i++){ 
if (!day.substring(i,i+1).equals("0")){
 int i_int=Integer.parseInt(day.substring(i,i+1)); 
String aa="";
if (i==1&&FT.equals("true"))aa="十";
DX2=DX2+aa+c1[i_int];
}else{
 FT="false";
}
}

DX+="年"; 
DX1+="月";
DX2+="日";
DX+=DX1+DX2;
} 

return (DX.equals(""))?errstr:DX;
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
