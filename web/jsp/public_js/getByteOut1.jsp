
    <%!
//��ȡ���ݿ�
  public String getbyte(String para) throws Exception  {
  String temp=para;
  if (temp!=null){
 //temp =new String(temp.getBytes("iso-8859-1"));
   }
   else{temp="";}
   return temp;
  
  }
  //ͨ��submit�ύ�Ķ���
    public String getbyte1(String para) throws Exception  {
  String temp=para;
  if (temp!=null){
   temp =new String(temp.getBytes("iso-8859-1"));
   }
   else{temp="";}
   return temp;
  
  }
  //��?���ݲ�����
     public String getbyte2(String para) throws Exception  {
  String temp=para;
  if (temp!=null){
    temp =new String(temp.getBytes("iso-8859-1"));
   }
   else{temp="";}
   return temp;
  
  }
  
 %>
 