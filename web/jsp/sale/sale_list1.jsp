<%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>������ϸ��</title>
 
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<% 
 
 
 
   
   String sql=""; 
   sql="select    * from ViewSectionData where out=1";
     
  sql+=" order by loft,floor,Room_code";
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
<form action="rgsview.jsp" method="post" name="frm">
  
<div align=left id=report1  >
 <font size=3><div id=tit align="center">��Ŀ������ϸ��  </div></font>
 
 <table width="99%"><tr><td colspan="3"></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
 
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">���</td>
 
<td  align="center">�������</td>
<td  align="center">��;</td>
<td  align="center">����</td>
<td align="center">�������</td>
<td align="center">���ڽ������</td> 
<td  align="center">Ԥ�۵���</td>
<td  align="center">Ԥ���ܼ�</td>
<!--
 <td  align="center">��԰���</td>
 
<td  align="center">¶̨���</td>
 
<td  align="center">�������</td>
 -->
<td  align="center">��  ע</td>
	<%
	ResultSet rs=null;
	try{
		 
	rs=ViewBean.executeQuery(sql);
	 
	 
	int i=0;
 
   while (rs.next()){
	 i++;
	  
     String room =getbyte(rs.getString("roomno"));
    
     String jzarea=FormtD.getFloat(rs.getFloat("area"),3);
	 String usedarea =FormtD.getFloat(rs.getFloat("usedarea"),3);
	 String unitprice=FormtD.getFloat2(rs.getDouble("unitprice"),2);
	 String sumprice=FormtD.getFloat2(rs.getDouble("sumprice"),2);
	  float lta=rs.getFloat("lu_tai_area");
	// float ltp=rs.getFloat("lu_tai_area_price");
	 String lu_tai_area=FormtD.getFloat(lta,3);
	// String lt_price=FormtD.getFloat(ltp*lta,3);
	 float tya=rs.getFloat("ty_area");
	 //float typ=rs.getFloat("ty_area_price");
	 String ty_area=FormtD.getFloat(tya,3);
	// String ty_price=FormtD.getFloat(tya*typ,3);
	 
	 String wd_area=FormtD.getFloat(rs.getFloat("wd_area"),3);
	 
	 String SaleState =getbyte(rs.getString("SaleState"));
	 String yong_tu=getbyte(rs.getString("yong_tu"));
	 String Roomtype=getbyte(rs.getString("Roomtype"));
  %>
 <tr   align="center">
<td   align="center"><%=i %></td>
<td  align="left">&nbsp;<%=room %></td>
<td   align="left">&nbsp;<%=yong_tu%>��</td>
<td   align="center">&nbsp;<%=Roomtype%>��</td>
 
<td    align="right"><%=jzarea %>��</td>
<td    align="right"><%=usedarea %>��</td>
<td  align="left">&nbsp; <%=unitprice %></td>
<td  align="right"><%=sumprice %></td>
<!--

<td  align="right">&nbsp;<%=ty_area %></td>
 
<td  align="right">&nbsp;<%=lu_tai_area %></td>
 
<td  align="right">&nbsp;<%=wd_area %></td>
-->
 <td  align="right">&nbsp;<%=SaleState %></td>
 
</tr> 
 <%
 }
rs.close(); 
 
   sql="select  yong_tu,count(*) num,sum(sumprice) price,sum(area) jzarea,sum(lu_tai_area) lu_tai_area,sum(ty_area) ty_area ,sum(wd_area) wd_area from ViewSectionData where out=1 group by yong_tu";
    
   rs=ViewBean.executeQuery(sql);

   while (rs.next()){
   
     String payment=getbyte(rs.getString("yong_tu")) ;
	 int num=rs.getInt("num");
	 nn+=num;
	 double price=rs.getDouble("price");
	 double jzarea=rs.getDouble("jzarea");
	 double lu_tai_area=rs.getDouble("lu_tai_area");
	   
	 double ty_area=rs.getDouble("ty_area");
	 
	  	
	  double wd_area=rs.getDouble("wd_area");
	 sump+=price;
	 suma+=jzarea;
	 suml+=lu_tai_area;
	 sum2+=ty_area;
	 sum3+=wd_area;
	 
   %>
   <tr>
   <td>�ϼ�</td><td>&nbsp;</td><td><%=payment%></td>
   <td><b><%=num %></b>��</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    <td align="right"><b><%=FormtD.getFloat2(price,2) %></b></td><td>&nbsp;</td>
	<!--
	<td>&nbsp;<%=FormtD.getFloat2(ty_area,2) %></td><td>&nbsp; </td><td>&nbsp;<%=FormtD.getFloat2(lu_tai_area,2) %></td><td>&nbsp;</td>
  -->
   </tr>
 
  <%}%>
    <tr>
   <td>�ܼ�</td><td>&nbsp;</td><td>&nbsp;</td>
   <td>&nbsp;</td><td><b><%=FormtD.getFloat2(suma,2) %></b>M<sup>2</sup></td><td>&nbsp;</td><td>&nbsp;</td>
    <td align="right"><b><%=FormtD.getFloat2(sump,2) %></b>Ԫ</td>
	<!--
	<td align="right"><b><%=FormtD.getFloat2(sum2,2) %></b>M<sup>2</sup></td>
		</td> <td align="right"><b><%=FormtD.getFloat2(sum5,2) %></b>Ԫ</td>
	<td align="right"><b><%=FormtD.getFloat2(suml,2) %></b>M<sup>2</sup>
	</td> -->
  <td>&nbsp;</td>
  
   </tr>
   
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
<input type="button" onclick="bringToExcel()" value="������Excel"><br>
����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"<br>
��2.ѡ��"��ȫ"->ѡ��"����intranet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>
 
  <%
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
  %>
 
 
 
</body>
 
</html>
