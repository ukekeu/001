<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>


<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<link rel=stylesheet href="../class/line.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>��ӡѡ�������</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="fat" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<script>

this.resizeTo(screen.availWidth,screen.availHeight)
this.moveTo(0,0)
this.focus()
</script>
<body topmargin="0" onload="print();">

 
 <%
  String code=getbyte2(request.getParameter("code"));
    String yh=getbyte2(request.getParameter("yh"));
    
   if (yh.indexOf("*")>=0)yh=fat.getFloat3(Double.parseDouble(yh.substring(0,yh.indexOf("*")))*Double.parseDouble(yh.substring(yh.indexOf("*")+1))/100,2);
 
String paylist=getbyte2(request.getParameter("paylist"));
  ViewBean.executeUpdate("update room set readnum=readnum+1 where code in("+code+")");
  String sql="select getdate()curdate ,R.tnunitprice,R.loft,R.loft+R.room_code room_code,R.Room_Type,R.yong_tu,R.Area,R.RoomType,R.Direction,R.usedArea,R.Unitprice,R.Sumprice,S.Name,S.developcom from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.code in ("+code+")";
		 
		 String area="";
		 String jzarea="";
	  
		 String unitprice="",tnunitprice="";
		  String sumprice="";
		  String name="";
		  String room="";
		  String yongtu="";
		  String roomtype="";
		  String SaleArea="";
		  String room_code="";
		  String curdate="";
		  String developcom="";
		ResultSet rs=ViewBean.executeQuery(sql);
		while (rs.next()){
		 curdate=rs.getString("curdate");
		  if (!roomtype.equals(""))
		     roomtype+=",";
		   roomtype+=getbyte(rs.getString("RoomType"));
		  if (!jzarea.equals(""))
		     jzarea+=",";
		   jzarea+=rs.getString("Area");
		   if (!area.equals(""))
		     area+=","; 
		   area+=rs.getString("usedArea");
		   
		    if (!unitprice.equals(""))
		     unitprice+=","; 
		   unitprice+= rs.getString("Unitprice");
		    if (!tnunitprice.equals(""))
		     tnunitprice+=","; 
		   tnunitprice+=rs.getString("tnunitprice");
		     if (!sumprice.equals(""))
		     sumprice+=","; 
			 
		   sumprice+= rs.getString("Sumprice");
		    if (!room_code.equals(""))
		     room_code+=","; 
			 room_code+=getbyte(rs.getString("room_code"));
	
		   name=getbyte(rs.getString("Name"));
		   developcom=getbyte(rs.getString("developcom"));
		}rs.close();	
		
			
	
  StringTokenizer A1 = new StringTokenizer(room_code,",") ;
  int I1 = A1.countTokens() ; 
   StringTokenizer A2 = new StringTokenizer(jzarea,",") ;
  int I2 = A2.countTokens() ; 
   StringTokenizer A3 = new StringTokenizer(area,",") ;
  int I3 = A3.countTokens() ; 
   StringTokenizer A4 = new StringTokenizer(unitprice,",") ;
  int I4 = A4.countTokens() ; 
   StringTokenizer A5 = new StringTokenizer(tnunitprice,",") ;
  int I5 = A5.countTokens() ; 
   StringTokenizer A6 = new StringTokenizer(sumprice,",") ;
  int I6 = A6.countTokens() ; 
    StringTokenizer A7 = new StringTokenizer(roomtype,",") ;
  int I7 = A6.countTokens() ;
    String jzarea1[]=new String[I2];
   String tnarea1[]=new String[I3];	 
   String sumprice1[]=new String[I6];	
 %>
<form name=cus method=POST ACTION="">
<p align=center><font size=5 class=FontColor><b><%=name %>ѡ��������ϸ��</b></font></p>
<center>
  <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING1 ALIGN=center  >
  <tr><td>�ͻ�����:<input type=text name=lx class=unnamed1 ></td><td>VIP����:<input type=text name=lx class=unnamed1 ></td><td>��������:<%=curdate.substring(0,16) %></td></tr>
  </table>
<table BORDER=1 width="100%" height="80%" CELLSPACING=0 CELLPADDING1=0 ALIGN=center bordercolor="#000000" class="tablefill">
<tr align="center" >
 <td colspan="3" bgcolor="#808080"  <%if (I1==5){ %>width="35%" <%}else if (I1==4){ %>width="45%" <%}else if (I1==3){ %>width="45%" <%}else if (I1==2){ %>width="45%" <%}else if (I1==1){ %>width="50%" <%} %>>��������</td>
 <%try{
 int n=0;
 for (int nn=0;nn<I1;nn++) {n++;
 %>
 <td  bgcolor="#808080" >����λ<%=n %></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 <tr   align="center" >
 <td  colspan="3">����</td>
 <%try{
 while (A1.hasMoreElements()) {
 %>
 <td>&nbsp;<b><%= (String)A1.nextElement()%></b></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 <tr align="center" >
 <td colspan="3">�������(M<sup>2</sup>)</td>
 <%try{
 int jj=0;
 while (A2.hasMoreElements()) {
  String aaa=(String)A2.nextElement();
 jzarea1[jj]=aaa;
 %>
 <td><%= aaa%></td> 
 <%jj++;
}
 }catch(Exception s){}%> 
 </tr>
  <tr align="center" >
 <td colspan="3">���ڽ������(M<sup>2</sup>)</td>
 <%try{
  int jj=0;
 while (A3.hasMoreElements()) {
 String bbb=(String)A3.nextElement();
 tnarea1[jj]=bbb;
 %>
 <td><%= bbb%></td> 
 <%jj++;
}
 }catch(Exception s){}%> 
 </tr> 
  <tr align="center" >
 <td colspan="3">��ǰ�����������(Ԫ/M<sup>2</sup>)</td>
 <%try{ 
 while (A4.hasMoreElements()) {
    %>
 <td><%= (String)A4.nextElement()%></td> 
 <% 
}
 }catch(Exception s){}%> 
 </tr>
   <tr align="center" >
 <td colspan="3">��ǰ���ڽ����������(Ԫ/M<sup>2</sup>)</td>
 <%try{
 while (A5.hasMoreElements()) {
 %>
 <td><%= (String)A5.nextElement()%></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 
   <tr align="center" >
 <td colspan="3">��ǰ�ܼ�(Ԫ)</td>
 <%try{
 int jj=0;
 while (A6.hasMoreElements()) {
 
  String ccc=(String)A6.nextElement();
  sumprice1[jj] =ccc;
 %>
 <td><%= fat.getFloat2(Double.parseDouble(ccc),0)%></td> 
 <%jj++;
}
 }catch(Exception s){}%> 
 </tr>
<%//if (java.lang.Integer.parseInt(yh)>0){
 String hy=getbyte2(request.getParameter("hy"));
  if (!hy.equals("0")){
 %>
 <tr align="center"  ><td colspan="3">��Ա�����Ż�</td>
  <% 
  
 for (int nnn=0;nnn<I1;nnn++) { 
 %>
 <td><%=getbyte2(request.getParameter("hy")) %>��</td> 
 <%
  }
 %> 
 </tr> 
 
 <%} %>
 <%//if (java.lang.Integer.parseInt(yh)>0){
  if (!yh.equals("0")){
 %>
 <tr align="center"  ><td colspan="3">VIP�����Ż�</td>
  <% 
  
 for (int nnn=0;nnn<I1;nnn++) { 
 %>
 <td><%=getbyte2(request.getParameter("yh")) %>��</td> 
 <%
  }
 %> 
 </tr>
 <tr align="center"><td colspan="3">�����Żݺ��ܼ�</td>
  <% 
     StringTokenizer A61 = new StringTokenizer(sumprice,",") ;
  int I61 = A61.countTokens() ; 
   try{
   if (hy.equals("0"))hy="100";
   int jj=0;
 while (A61.hasMoreElements()) {
 String eee=(String)A61.nextElement();
  sumprice1[jj] =eee;
 %>
 <td><%= fat.getFloat2(Double.parseDouble(eee)*Double.parseDouble(yh)*Double.parseDouble(hy)/10000,0)%></td> 
 <%jj++;
}
 }catch(Exception s){}%> 
 
 </tr>
 
 <%} %>
 <%
 sql="select * from PayMent where  id in("+paylist+")  and PayName like '%��%'  order by PayName ";
		rs=ViewBean.executeQuery(sql);
		String PayName="";
		double disc=0;
     
 while (rs.next()){
      PayName=rs.getString("PayName");
	 
	%>	
	<tr align="center">
	<td  rowspan="<%if (PayName.indexOf("��")<0) {%>3<%}else{ %>5<%} %>"><%= PayName%><br>(<%=rs.getString("Discont") %>%��)</td>
	<td  rowspan="<%if (PayName.indexOf("��")<0) {%>3<%}else{ %>5<%} %>">��<br>��<br>��<br>��</td>
	<td   >�����������(Ԫ/M<sup>2</sup>)</td>
	
	
 

	<% 
  
	  
  double yh1= Double.parseDouble(yh);
   if (yh1==0)yh1=100;
double hy1=Double.parseDouble(hy);
if (hy1==0)hy1=100;
  sql="select "+rs.getString("Discont")+"/100.0 dd";
  ResultSet rs1=ViewBean1.executeQuery(sql);
  if (rs1.next())
   disc= rs1.getDouble("dd");
   rs1.close();
  
   try{
for (int arr=0;arr<I1;arr++) {
 
 %>
 <td><%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100/Double.parseDouble(jzarea1[arr]),2)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<tr align="center">
	
	<td   >���ڽ����������(Ԫ/M<sup>2</sup>)</td>
	 <% try{
for (int arr=0;arr<I1;arr++) {
 
 %>
 <td><%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100/Double.parseDouble(tnarea1[arr]),2)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<tr align="center">
	
	<td   >�ܼ�(Ԫ )</td>
	 <% try{
for (int arr=0;arr<I1;arr++) {
 
 %>
 <td><%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<%}
		rs.close();
 
 sql="select * from PayMent where  id in("+paylist+")  and PayName like '%����%'  order by PayName ";
		rs=ViewBean.executeQuery(sql);
		  PayName="";
		  disc=0;
		  double disc7=0;
		  double disc8=0;
          double ajcs=0;
 while (rs.next()){
      PayName=rs.getString("PayName");
	  ajcs=Double.parseDouble(PayName.substring(PayName.indexOf("(")+1,PayName.indexOf("%")));
	  
	%>	
	<tr align="center">
	<td  rowspan="<%if (PayName.indexOf("��")<0) {%>3<%}else{ %>5<%} %>"><%= PayName%><br>(<%=rs.getInt("Discont") %>%��)</td>
	<td  rowspan="<%if (PayName.indexOf("��")<0) {%>3<%}else{ %>5<%} %>">��<br>��<br>��<br>��</td>
	<td   >�����������(Ԫ/M<sup>2</sup>)</td>
	
	
 

	<% 
  
	  
  double yh1= Double.parseDouble(yh);
   if (yh1==0)yh1=100;
double hy1=Double.parseDouble(hy);
if (hy1==0)hy1=100;
   disc= rs.getDouble("Discont");
   if (ajcs==70)disc7=disc;
   else if (ajcs==80)disc8=disc;
   
   try{
for (int arr=0;arr<I1;arr++) {
 
 %>
 <td><%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100/Double.parseDouble(jzarea1[arr]),2)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<tr align="center">
	
	<td   >���ڽ����������(Ԫ/M<sup>2</sup>)</td>
	 <% try{
for (int arr=0;arr<I1;arr++) {
 
 %>
 <td><%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100/Double.parseDouble(tnarea1[arr]),2)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<tr align="center">
	
	<td   >�ܼ�(Ԫ )</td>
	 <% try{
for (int arr=0;arr<I1;arr++) {
 
 %>
 <td><%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
		 
	<%if (PayName.indexOf("��")>=0) { %>
	
	<tr align="center">
	
	<td   >���ڿ�</td>
	 <% 
	 String csnum="";
	 try{
	 if (PayName.indexOf("��")>=0){
          	csnum=PayName.substring(PayName.indexOf("(")+1,PayName.indexOf("%"));
	     }
for (int arr=0;arr<I1;arr++) {
  double ajk=(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100*Double.parseDouble(csnum)/100);
  int ajm=(int)ajk/10000;
//out.println(ajm);
 %>
 <td><%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100-ajm*10000,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<tr align="center">
	
	<td   >���ҿ�</td>
	 <% 
	   csnum="";
	 try{
	 if (PayName.indexOf("��")>=0){
          	csnum=PayName.substring(PayName.indexOf("(")+1,PayName.indexOf("%"));
	     }
for (int arr=0;arr<I1;arr++) {
   double ajk=(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100*Double.parseDouble(csnum)/100);     
 %>
 <td><%= fat.getFloat2(Double.parseDouble(String.valueOf((int)ajk/10000))*10000,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<%} %>
	<%	
		}
		rs.close();
	  yh=getbyte2(request.getParameter("yh"));
             
          if (yh.indexOf("*")>=0)yh=fat.getFloat3(Double.parseDouble(yh.substring(0,yh.indexOf("*")))*Double.parseDouble(yh.substring(yh.indexOf("*")+1))/100,2);
       
		  if ( Double.parseDouble(yh)==0) 
              yh="100";
		
		 %>
 <tr align="center">
	<td  rowspan="12" align="center">���а����¹���<br>(�ȶϢ���)</td>
	<td  rowspan="2" align="center" width="50">5�� </td>
	
	 <% 
	  String ajStr = "select id,year,MonthTax,yearTax,yong_tu,MonthPay,lx from ajllgkb  where type=3  and yong_tu=0 and year=5";//where id >=" + String.valueOf(firstPos);
	ResultSet ajRS = ViewBean.executeQuery(ajStr);	
  //ƽ����
 double pjpay=0;
	while (ajRS.next()) { 
	  pjpay=ajRS.getDouble("MonthPay");
	  
	}
	ajRS.close();
	 try{
for (int arr=0;arr<I1;arr++) {
 if (arr==0)out.print("<td   >70%</td>");
  Double ajkmoney= (Double.parseDouble(sumprice1[arr])*disc7/100*Double.parseDouble(yh)/100*Double.parseDouble(hy)/100*0.7);
  int ajkk=(int)(ajkmoney/10000);
 %>
 <td><%=fat.getFloat2(ajkk*pjpay,0)%> </td> 
 <% 
}
 }catch(Exception s){out.print(s);}%> 
 </tr>
 <tr align="center"> 
	
	 <% 
	    ajStr = "select id,year,MonthTax,yearTax,yong_tu,MonthPay,lx from ajllgkb  where type=3  and yong_tu=0 and year=5";//where id >=" + String.valueOf(firstPos);
	  ajRS = ViewBean.executeQuery(ajStr);	
 //ƽ����
   pjpay=0;
	while (ajRS.next()) { 
	  pjpay=ajRS.getDouble("MonthPay");
	  
	}
	ajRS.close();
	 try{
for (int arr=0;arr<I1;arr++) {
 if (arr==0)out.print("<td   >80%</td>");
  Double ajkmoney= (Double.parseDouble(sumprice1[arr])*disc8/100*Double.parseDouble(yh)/100*Double.parseDouble(hy)/100*0.8);
  int ajkk=(int)(ajkmoney/10000);
 %>
 <td><%=fat.getFloat2(ajkk*pjpay,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
 </tr>
 
 
 <%
 int year=10;
 yh=getbyte2(request.getParameter("yh"));

if (yh.indexOf("*")>=0)yh=fat.getFloat3(Double.parseDouble(yh.substring(0,yh.indexOf("*")))*Double.parseDouble(yh.substring(yh.indexOf("*")+1))/100,2);
  
 if ( Double.parseDouble(yh)==0) 
       yh="100";
	   
 while (year<=30){ %>
 <tr align="center">
	 
	<td  rowspan="2" width="50"><%=year %>�� </td>
	
	 <% 
	    ajStr = "select id,year,MonthTax,yearTax,yong_tu,MonthPay,lx from ajllgkb  where type=3  and yong_tu=0 and year="+year;//where id >=" + String.valueOf(firstPos);
	  ajRS = ViewBean.executeQuery(ajStr);	
 //ƽ����
   pjpay=0;
	while (ajRS.next()) { 
	  pjpay=ajRS.getDouble("MonthPay");
	  
	}
	ajRS.close();
	 try{
for (int arr=0;arr<I1;arr++) {
 if (arr==0)out.print("<td   >70% </td>");
  Double ajkmoney= (Double.parseDouble(sumprice1[arr])*98.0/100*Double.parseDouble(yh)/100*Double.parseDouble(hy)/100*0.7);
  int ajkk=(int)(ajkmoney/10000);
 %>
 <td><%=fat.getFloat2(ajkk*pjpay,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
 </tr>
 <tr align="center">
	 
	
	 <% 
	    ajStr = "select id,year,MonthTax,yearTax,yong_tu,MonthPay,lx from ajllgkb  where type=3  and yong_tu=0 and year="+year;//where id >=" + String.valueOf(firstPos);
	  ajRS = ViewBean.executeQuery(ajStr);	
 //ƽ����
   pjpay=0;
	while (ajRS.next()) { 
	  pjpay=ajRS.getDouble("MonthPay");
	  
	}
	ajRS.close();
	 try{
for (int arr=0;arr<I1;arr++) {
 if (arr==0)out.print("<td   >80%</td>");
   Double ajkmoney= (Double.parseDouble(sumprice1[arr])*98.0/100*Double.parseDouble(yh)/100*Double.parseDouble(hy)/100)*0.8;
  int ajkk=(int)(ajkmoney/10000);
 %>
 <td><%=fat.getFloat2(ajkk*pjpay,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
 </tr>
 <%year+=5;}
 
  %>  
</table> 
   <table BORDER=0 width="90%" CELLSPACING=0 CELLPADDING1 ALIGN=center  >
  <tr><td>1�����ϼ۸񲻺����������������˰�ѣ�</td></tr>
  <tr><td>2���ۺ�۸�=��ǰ�۸��VIP�����Żݣ�</td></tr>
   <tr><td>3�������ڵ���ס����Ӧ�ṹ�ȶ�ס���۸�����������2006��6��1���𣬸��˹���ڶ���ס�������ͽ������90ƽ�������ϵ��׸������Ϊ30%�����˹�������ס�������ͽ������90ƽ�������µ��׸������Ϊ20%��</td></tr>
 ��<tr><td>4���������ݽ����ο���������˫��ǩ���������ͬΪ׼��</td></tr>
  ��<tr><td>5��������ս���Ȩ��<%=developcom %>��</td></tr>
  </table>
 ��</center> 
 
 
</FORM> 
</body>

</html>
