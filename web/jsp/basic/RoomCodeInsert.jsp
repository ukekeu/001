<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

<html>
<head>
	<title>�����������</title>
</head>

<body>
<%/*
 ���ɷ������
*/
 %>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*"%>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/asiic.jsp"%> 
<%@ include file="../public_js/getByteOut.jsp"%>
 <%
 try{
 String strjgh=China.getParameter(request,"dyjgh");
 String SecName=China.getParameter(request,"SecName");
 String LockRoomS=China.getParameter(request,"Lock");
 List Lock=new LinkedList();//��Ž��ú�
StringTokenizer st22;
  st22 = new StringTokenizer(LockRoomS,",") ;
 int count24 = st22.countTokens() ;
  while (st22.hasMoreElements()) {
	Lock.add((String)st22.nextElement());
 }
 String cw=China.getParameter(request,"cw");
String cd=China.getParameter(request,"cd");
String floorlen=China.getParameter(request,"floorlen");
 String showbuild="";
 String strSection=China.getParameter(request,"Section");
 String strBuilding=China.getParameter(request,"Building");
 	 showbuild=strBuilding;
 String strRegion=China.getParameter(request,"Region");	
String R_type=request.getParameter("R_type");
String BeginF=request.getParameter("BeginF");
String EndF=request.getParameter("EndF");
String Ecellname=China.getParameter(request,"Ecellname");
String Scellname=China.getParameter(request,"Scellname");
String cellname="";
String Rinfo=China.getParameter(request,"Rinfo");
String Finfo=China.getParameter(request,"Finfo");
String bmfs=China.getParameter(request,"bmfs");	
String cellqz=China.getParameter(request,"cellqz");		
char BeF=BeginF.charAt(0);
char EnF=EndF.charAt(0);
 
String FloorType="0";
int intBeginF=0;
int intEndF=0;
	 intBeginF=java.lang.Integer.parseInt(BeginF);
	 intEndF=java.lang.Integer.parseInt(EndF);
 int intEndR;
int intBeginR;
 
String BeginR=request.getParameter("BeginR");
String EndR=request.getParameter("EndR");
char BR=R_type.charAt(0);
  intBeginR=java.lang.Integer.parseInt(request.getParameter("BeginR"));
  intEndR=java.lang.Integer.parseInt(request.getParameter("EndR"));
 
char BeR=BeginR.charAt(0);
int scell=0,ecell=0;
char  CellN1=Scellname.charAt(0);
char  CellN2=Ecellname.charAt(0);

if (!Scellname.equals("")&&!Ecellname.equals("")){
   CellN1=Scellname.charAt(0);
   CellN2=Ecellname.charAt(0);

if(java.lang.Character.isDigit(CellN1)){
	 scell=java.lang.Integer.parseInt(request.getParameter("Scellname"));
	 ecell=java.lang.Integer.parseInt(request.getParameter("Ecellname"));
}
else{
     scell=Character.getNumericValue(CellN1)-9;
	 ecell=Character.getNumericValue(CellN2)-9;
}
 
}
 
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "���Ŷ���" , 
                  "����("+strSection+strRegion+",¥��:"+BeginF+"��"+EndF+",����:"+BeginR+"��"+EndR+")"
                ) ;
 

String sql="";
String sql1="";

sql1="insert into LockRoom(section,loft,build,lockroom) values('"+strSection+"','";
sql1+=strRegion+"','"+strBuilding+"','"+LockRoomS+"')";

for(int j2=scell;j2<=ecell;j2++){
if (scell>0){  
  Rinfo=AsiicZH(j2,CellN1); 
}
String Rinfo1=Rinfo;
  if (!Rinfo.equals(""))Rinfo=Rinfo+strjgh;
for(int i=intBeginF;i<=intEndF;i++){
	int strFloor=i;
	 String floorslenvalue="";
	if (floorlen.equals("1"))if (i<10)floorslenvalue="0";
	for(int j=intBeginR;j<=intEndR;j++){

		if (!Lock.contains(String.valueOf(j))){
	    String strRoom=String.valueOf(j);
		String no=AsiicZH(j,BR);//����asiicת������
		
		int rr=i;
		String ro="";
	 
		ro=String.valueOf(i);
		 if (!cw.equals("")){
		       ro="";
		       for (int bhcd=String.valueOf(j).length();bhcd<java.lang.Integer.parseInt(cd);bhcd++) 
			   ro=ro+"0";
		   }
	    if(java.lang.Character.isDigit(BR)){//����Ϊ����
		    if (cw.equals("")){
		     if (j>=10)
		      no=cellqz+Rinfo+floorslenvalue+String.valueOf(ro)+bmfs+no;
		     else
		      no=cellqz+Rinfo+floorslenvalue+String.valueOf(ro)+bmfs+no;
			}
			 
			if (!cw.equals("")){ 
			  no=cellqz+Rinfo+floorslenvalue+String.valueOf(ro)+bmfs+no;
			}  
		}else{//����Ϊ��ĸ
		     no=cellqz+Rinfo+floorslenvalue+String.valueOf(ro)+bmfs+no;
		}	 
	 
		   String aaaa=no;
			  if (no.indexOf("-")>=0)
			   aaaa=no.substring(0,no.indexOf("-"))+no.substring(no.indexOf("-")+1);
		String strRoomNo=getbyte1(request.getParameter("RoomNo"+aaaa));
	 
		if (strRoomNo==null)strRoomNo="";
		if (!strRoomNo.equals("")){
			 
		//�ж��Ƿ����д˷���,����оͲ�д�����ݿ���
		sql="select * from RoomNo where Building='"+strBuilding+"' and  SectionNo='"+strSection+"' and room='"+String.valueOf(j)+"' and cell='"+Rinfo+"' and floor="+String.valueOf(i)+" and Region='"+strRegion+"'";
	 	ResultSet rs=InsertBean.executeQuery(sql);
		
		if (!rs.next()){
		 //�ѷ����д�����ݿ�
	     sql="'"+strSection+"','"+strRegion+"','"+strBuilding+"',";
		 sql=sql+strFloor+","+strRoom+",'"+strRoomNo.trim()+"',"+FloorType+",'"+Finfo+"','"+Rinfo1+"'";
		 
	  try{
	 
		  InsertBean1.executeUpdate("exec set_room_code "+sql);
		 
		 }
		 catch(Exception se){
		  out.print("ϵͳ�����������£�");
		  out.print(se.getMessage());
		  out.close();
		  
		 }
		}else{out.print("���·����Ѿ����ڣ�"+strRoomNo+"<br>");}
		rs.close(); 
	  }
	  }
	}
}
}
try{
  if (!LockRoomS.equals("")){

StringTokenizer st221;
  st221 = new StringTokenizer(LockRoomS,",") ;
 
  while (st221.hasMoreElements()) {
	 
   String existSQL="SELECT * FROM  LockRoom WHERE SECTION='"+strSection+"' and Loft='"+strRegion+"' and LockRoom='"+(String)st221.nextElement()+"'"; 
   ResultSet rs= InsertBean.executeQuery(existSQL);
  
   if (!rs.next())  InsertBean1.executeUpdate(sql1);
   rs.close();

 }
  
  
  }
}catch(Exception s){out.print(sql1);out.close();}

%>

 <script >
   window.location="crm_RoomCodeList2.jsp?Ecellname=<%=Ecellname %>&Scellname=<%=Scellname %>&Section=<%=strSection%>&SecName=<%=SecName%>&Building=<%=strBuilding%>&Loft=<%=strRegion %>&mess=ϵͳ�ѽ��ܱ���";
 </script>
<% 

}catch(Exception s){out.print("ϵͳ�����쳣���󣬴���ԭ��"+s);}
 %> <%InsertBean.closeConn();
  InsertBean1.closeConn();
 
  %>
</body>
</html>
