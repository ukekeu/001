<%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>����Ա������ϸ��</title>
 
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<% 
 
 
 
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SecNo") ; 
  String Region = China.getParameter(request,"Region") ; 
   String room=getbyte1(request.getParameter("room"));
  String Loft=getbyte1(request.getParameter("Loft"));
  String yong_tu=getbyte1(request.getParameter("yong_tu"));
String saletype=getbyte1(request.getParameter("saletype"));
String job=(String)session.getAttribute("job");	
	 if (job.indexOf("����Ա")>=0){
	    job=" and a.seller like '%"+(String)session.getAttribute("loginname")+"%'";
  }else{job="";}
if (saletype.equals("1"))saletype=" and  convert(char(10),date,120)>='"+stdate+"' and convert(char(10),date,120)<='"+endate+"' and state=1 ";
else if (saletype.equals("2"))saletype=" and convert(char(10),visadate,120)>='"+stdate+"' and convert(char(10),visadate,120)<='"+endate+"' and state=2";
else if (saletype.equals("0"))saletype=" and  convert(char(10),date,120)>='"+stdate+"' and convert(char(10),date,120)<='"+endate+"'";

   String sql=""; 
   sql="select    a.rmbprice-a.ajmoney firstmoney,a.*,b.cus_name,b.phone + b.sj phone from order_contract a,customer b where a.customer=b.serialno and a.state<>3   and a.section='"+SectionName+"' "+saletype;
    if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and Room_no='"+room+"'";
	    if (!yong_tu.equals(""))
	  sql+=" and yong_tu='"+yong_tu+"'";
	  sql+=job;
  sql+=" order by loft,floors,room_no";
   int nn=0;
   double sump=0;
   double suma=0;
   double suml=0;
   double sum2=0;
   double sum3=0;
   double sum4=0;
   double sum5=0;
 %>


  
<body>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>

  
<div align=left id=report1 >
 <font size=3><div id=tit align="center"><%if (getbyte1(request.getParameter("saletype")).equals("1")){out.print("�Ϲ���ϸͳ�Ʊ�");}else if (getbyte1(request.getParameter("saletype")).equals("2")){out.print("ǩԼ��ϸͳ�Ʊ�");}else{out.print("�Ϲ�/ǩԼ��ϸͳ�Ʊ�");} %>  </div></font>
 
 <table width="99%"><tr><td colspan="3">ʱ���:<%=China.getParameter(request,"Date1")%>��<%=China.getParameter(request,"Date2") %></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
 
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">���</td>
 <td  align="center">״̬</td>
<td  align="center">�������</td>
<td  align="center">�ͻ�����</td>
<td  align="center">��ϵ��ʽ</td>
<td align="center">���</td>
<td w align="center">���ʽ</td>

<td  align="center">�ɽ�����</td>
<td  align="center">�ɽ��ܼ�</td>

<td  align="center">���ҽ��</td>
<td  align="center">���ڿ�</td>
 <td  align="center">�Ϲ�����</td>
 

<td  align="center">ǩԼ����</td>
<td  align="center">�ſ�����</td>
<td  align="center">Ƿ����</td>
<!--<td  align="center">��԰���</td>
  <td  align="center">��԰��</td>
<td  align="center">¶̨���</td>
<td  align="center">¶̨��</td>
<td  align="center">�������</td>--> 

 
 <td  align="center">����Ա</td>
<td  align="center">��  ע</td>
	<%
	ResultSet rs=null;
	ResultSet rs1=null;
	try{
 
	rs=ViewBean.executeQuery(sql);
	 
	 
	int i=0;
 
   while (rs.next()){
	 i++;
	  
     String sectionname =getbyte(rs.getString("sectionname"));
      room=getbyte(rs.getString("loft"))+getbyte(rs.getString("room_no"));
     String jzarea=rs.getString("jzarea");
	 String payment =getbyte(rs.getString("payment1"));
	 String unitprice=FormtD.getFloat2(rs.getDouble("unitprice"),2);
	 String sumprice=FormtD.getFloat2(rs.getDouble("rmbprice"),2);
	  float lta=rs.getFloat("lu_tai_area");
	 float ltp=rs.getFloat("lu_tai_area_price");
	 String lu_tai_area=FormtD.getFloat(lta,3);
	 String lt_price=FormtD.getFloat(ltp*lta,3);
	 float tya=rs.getFloat("ty_area");
	 float typ=rs.getFloat("ty_area_price");
	 String ty_area=FormtD.getFloat(tya,3);
	
	 String ty_price=FormtD.getFloat(tya*typ,3);
	 
	 String wd_area=FormtD.getFloat(rs.getFloat("wd_area"),3);
	 String phone=getbyte(rs.getString("phone"));
	 String rg_date="",ContractNo="",ht_date="",firstmoney="";
	    rg_date=rs.getDate("date").toString(); 
	   
	  ht_date=getbyte(rs.getString("visadate"));
	   firstmoney=getbyte(rs.getString("firstmoney"));
	  if (!ht_date.equals(""))ht_date=ht_date.substring(0,10);
	 String context =getbyte(rs.getString("note"));
	  String seller =getbyte(rs.getString("seller"));
	   String cus_name =getbyte(rs.getString("cus_name"));
	    String ajk =getbyte(rs.getString("ajmoney"));
		String fk_date=getbyte(rs.getString("fkdate"));
	 double yk=0;
	  if (!fk_date.equals(""))fk_date=fk_date.substring(0,10);
     sql="select   sum(factmoney*CurrRate) money from factGatheringRecord where contractno = " +rs.getString("code");
	 rs1=ViewBean1.executeQuery(sql);
	 
	 if (rs1.next())
	   yk=rs1.getDouble("money");
	 rs1.close();
	yk=rs.getDouble("rmbprice")-Double.parseDouble(ajk)-yk; 
  %>
 <tr   align="center">
<td   align="center"><%=i %></td>
 <td   align="left"><%if (ht_date.equals("")){out.print("�Ϲ�");}else{out.print("ǩԼ");} %>��</td>
<td   align="left">&nbsp;<%=room%>��</td>
<td   align="left">&nbsp;<%=cus_name%>��</td>
<td   align="left">&nbsp;<%=phone%>��</td>

<td   align="center"><%=jzarea%>��</td>
 
<td    align="right">&nbsp;<%=payment %>��</td>
<td  align="left">&nbsp; <%=unitprice %></td>
<td  align="right"><%=sumprice %></td>
<td  align="right"><%=ajk %></td>
<td  align="right">&nbsp;<%=firstmoney %></td>
 <td  align="right">&nbsp;<%=rg_date %></td>


 

<td  align="right">&nbsp;<%=ht_date %></td>
<td  align="right">&nbsp;<%=fk_date %></td>
<td  align="right">&nbsp;<%if (yk<0){ %><font color=red><%} %><%=FormtD.getFloat2(yk,2) %><%if (yk<0){ %></font><%} %></td>
<!--<td  align="right">&nbsp;<%=ty_area %></td>
<td  align="right">&nbsp;<%=ty_price %></td>
<td  align="right">&nbsp;<%=lu_tai_area %></td>

<td  align="right">&nbsp;<%=lt_price %></td>
<td  align="right">&nbsp;<%=wd_area %></td>-->
 <td  align="right">&nbsp;<%=seller %></td>
 <td  align="right">&nbsp;<%=context %></td>
</tr> 
 <%
 }
rs.close(); 
 room=getbyte1(request.getParameter("room"));
   sql="select  payment1,count(*) num,sum(rmbprice) price,sum(jzarea) jzarea,sum(ajmoney) ajmoney,sum(lu_tai_area) lu_tai_area,sum(lu_tai_area*lu_tai_area_price) ltprice,sum(ty_area) ty_area ,sum(ty_area*ty_area_price) typrice,sum(wd_area) wd_area from order_contract where state<>3 and     section='"+SectionName+"' "+saletype;
    if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and Room_no='"+room+"'";
	    if (!yong_tu.equals(""))
	  sql+=" and yong_tu='"+yong_tu+"'";
   sql+=" group by payment1";
   rs=ViewBean.executeQuery(sql);
  int ajmoneys=0;
  int sumnum=0;
   while (rs.next()){
   
     String payment=getbyte(rs.getString("payment1")) ;
	 int num=rs.getInt("num");
	 nn+=num;
	 double price=rs.getDouble("price");
	 double jzarea=rs.getDouble("jzarea");
	 double lu_tai_area=rs.getDouble("lu_tai_area");
	   double ltprice=rs.getDouble("ltprice");
	 double ty_area=rs.getDouble("ty_area");
	  double typrice=rs.getDouble("typrice");
	  int ajmoney	=rs.getInt("ajmoney");
	  ajmoneys+=ajmoney;
	  double wd_area=rs.getDouble("wd_area");
	 sump+=price;
	 suma+=jzarea;
	 suml+=lu_tai_area;
	 sum2+=ty_area;
	 sum3+=wd_area;
	 sum4+=ltprice;
	 sum5+=typrice;
	 sumnum+=num;
   %>
   <tr>
   <td>С��</td><td>&nbsp;</td><td>&nbsp;</td><td><%=payment%></td>
   <td><b><%=num %></b>��</td><td>&nbsp;<%=FormtD.getFloat2(jzarea,2) %></td><td>&nbsp;</td>
    <td align="right"><b><%=FormtD.getFloat2(price,2) %></b></td><td align="right">&nbsp;<b><%=ajmoney %></b></td><td>&nbsp;</td><td>&nbsp;</td> <td>&nbsp;</td> <td>&nbsp;</td>   <td>&nbsp;</td>  <td>&nbsp;</td><!-- <td align="right">&nbsp;<%=FormtD.getFloat2(ty_area,2) %></td><td align="right">&nbsp;<%=FormtD.getFloat2(typrice,2) %></td><td align="right">&nbsp;<%=FormtD.getFloat2(lu_tai_area,2) %></td><td align="right">&nbsp;<%=FormtD.getFloat2(ltprice,2) %></td>-->
   <td>&nbsp;</td>  <td>&nbsp;</td> 
   </tr>
 
  <%}%>
    <tr>
   <td>�ܼ�</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td><b><%=sumnum %></b></td>
   <td><b><%=FormtD.getFloat2(suma,2) %></b></td><td>&nbsp;</td>
    <td align="right"><b><%=FormtD.getFloat2(sump,2) %></b></td><td align="right">&nbsp;<B><%=ajmoneys %></B></td> <td>&nbsp;</td> <td>&nbsp;</td> <td>&nbsp;</td> <td>&nbsp;</td>  <td>&nbsp;</td>
		  <td>&nbsp;</td><td>&nbsp;</td>  <td>&nbsp;</td>
     
   </tr>
   
   </table>
<table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

<tr  > 
<td  align="center">���</td>
 
<td  align="center">��;</td>
 <td  align="center">����</td>
<td align="center">���</td>
 
<td  align="center">�ɽ��ܼ�</td>
 
  <%
rs.close(); 
 room=getbyte1(request.getParameter("room"));
   sql="select  yong_tu,count(*) num,sum(rmbprice) price,sum(jzarea) jzarea,sum(lu_tai_area) lu_tai_area,sum(lu_tai_area*lu_tai_area_price) ltprice,sum(ty_area) ty_area ,sum(ty_area*ty_area_price) typrice,sum(wd_area) wd_area from order_contract where state<>3   and section='"+SectionName+"' "+saletype;
    if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and Room_no='"+room+"'";
	    if (!yong_tu.equals(""))
	  sql+=" and yong_tu='"+yong_tu+"'";
   sql+=" group by yong_tu";
   rs=ViewBean.executeQuery(sql);
 int nnn=0;
   while (rs.next()){
   
     String payment=getbyte(rs.getString("yong_tu")) ;
	 int num=rs.getInt("num");
	 nn+=num;
	 nnn++;
	 double price=rs.getDouble("price");
	 double jzarea=rs.getDouble("jzarea");
	 double lu_tai_area=rs.getDouble("lu_tai_area");
	  double ltprice=rs.getDouble("ltprice");
 double ty_area=rs.getDouble("ty_area");
	  double typrice=rs.getDouble("typrice");
	  double wd_area=rs.getDouble("wd_area");
	    
	
	 sump+=price;
	 suma+=jzarea;
	 suml+=lu_tai_area;
	 sum2+=ty_area;
	 sum3+=wd_area;
   %>
   <tr >
   <td align="center"><%=nnn %></td> <td align="center"><%=payment%></td>
   <td><b><%=num %></b>��</td>
<td align="right"><b><%=FormtD.getFloat2(jzarea,2) %></b></td> 
    <td align="right"><b><%=FormtD.getFloat2(price,2) %></b></td>
	     
   </tr>
  <%}rs.close();%>
 </table>
 </div>
 
<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
     var selectArea=document.body.createTextRange(); //�����ı����� 
        selectArea.moveToElementText(report1);//���ı�����۽���printData 
        selectArea.select();//ѡ��printData 
        selectArea.execCommand("Copy");//��printData���Ƶ����а��� 
         oSheet.Paste();//�����а��е����ݸ��Ƶ�Excel��      
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="������Excel"> 
<br>����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"<br>
��2.ѡ��"��ȫ"->ѡ��"����intranet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>
 </div>
 

 
  <%
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
  %>
 
 
 
</body>
 
</html>
