 <%!
//读取数据库
  public String getbyte(String para) throws Exception  {
  String temp=para;
  if (temp!=null){
 //temp =new String(temp.getBytes("iso-8859-1"));
   }
   else{temp="";}
   return temp;
  
  }
  //通过submit提交的对象
    public String getbyte1(String para) throws Exception  {
  String temp=para;
  if (temp!=null){
   temp =new String(temp.getBytes("iso-8859-1"));
   }
   else{temp="";}
   return temp;
  
  }
  //带?传递参数的
     public String getbyte2(String para) throws Exception  {
  String temp=para;
  if (temp!=null){
    temp =new String(temp.getBytes("iso-8859-1"));
   }
   else{temp="";}
   return temp;
  
  }
  
 %>
 