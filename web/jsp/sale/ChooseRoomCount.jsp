<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>


<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>ѡ���Ƽ�</title>
</head>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>

<%@ include file="../public_js/getByteOut.jsp"%>
<body >

<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
 <%
  String secno=getbyte2(request.getParameter("secno"));
  String build=getbyte2(request.getParameter("build"));
  String loft=getbyte2(request.getParameter("loft"));
  String roomno=getbyte2(request.getParameter("roomno"));
  String buildtype="";
  String sql="select R.Room_Type,R.yong_tu,R.Area,R.RoomType,R.Direction,R.usedArea,R.Unitprice,R.tnunitprice,R.Sumprice,S.Name from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.seccode='"+secno+"' and "+"R.building='"+build+"' and "+"R.Room_code='"+roomno+"' and R.loft='"+loft+"'";
		java.text.DecimalFormat df = new java.text.DecimalFormat(" #########.####"); 
        java.text.DecimalFormat df1 = new java.text.DecimalFormat(" #########.##"); 
        java.text.DecimalFormat df2 = new java.text.DecimalFormat(" #########"); 
		 String area="";
		 String jzarea="";
		 String roomtype="";
		 String cx="";
		 String unitprice="";
		  String tnunitprice="";
		  String sumprice="";
		  String name="";
		  String room="";
		  String yongtu="";
		  String Room_Type="";
		  String SaleArea="";
		ResultSet rs=ViewBean.executeQuery(sql);
		if (rs.next()){
	       Room_Type=getbyte(rs.getString("Room_Type"));
		   yongtu=getbyte(rs.getString("yong_tu"));
		   jzarea=df.format(rs.getFloat("Area"));
		 
		   roomtype=getbyte(rs.getString("RoomType"));
		   cx=getbyte(rs.getString("Direction"));
		   
		   area=df.format(rs.getFloat("usedArea"));
		   unitprice=df1.format(rs.getFloat("Unitprice"));
           sumprice=df2.format(rs.getFloat("Sumprice"));
	       tnunitprice=df2.format(rs.getFloat("tnunitprice"));
		   name=getbyte(rs.getString("Name"));
		   buildtype=Room_Type;
		}rs.close();	 
 %>
<form name=cus method=POST ACTION="">
<p align=center><font size=3 class=FontColor><b>�����������</b></font></p>
<center>

<input type=hidden name=Floor value="<%=request.getParameter("Floor") %>">
<table BORDER=0 width="90%" CELLSPACING=1 CELLPADDING1 ALIGN=center bordercolor="#000000" class="tablefill">
 <tr >
 <td class=roomleft>&nbsp;¥������</td>
 <td class=roomright align="left">&nbsp;<%=name%><input type="hidden" value="<%=name%>" name="SECNAME" size="15" style="border-style: solid; border-width: 1">
 </td>
 <td class=roomleft>&nbsp;����</td>
 <td class=roomright align="left">&nbsp;<%=loft+build+roomno %><input type="hidden" value="<%=loft+build+roomno%>" name="LOFT" size="15" style="border-style: solid; border-width: 1">
 </td>
 </tr>
 
 
 <tr >
 <td class=roomleft>&nbsp;�������</td>
 <td class=roomright align="left">&nbsp;<%=jzarea%><input type="hidden" name="JZAREA" value="<%=jzarea%>" size="13" style="border-style: solid; border-width: 1">M<sup>2</sup>
 <td class=roomleft>&nbsp;���ڽ������</td>
 <td class=roomright align="left">&nbsp;<%=area%><input type="hidden" name="USERAREA" value="<%=area%>" size="13" style="border-style: solid; border-width: 1">M<sup>2</sup> 
 </td>
 </tr>
<tr >
 <td class=roomleft>&nbsp;����</td>
 <td class=roomright align="left">&nbsp;<%=roomtype%><input type="hidden" name="ROOMTYPE" value="<%=roomtype%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 <td class=roomleft>&nbsp;����</td>
 <td class=roomright align="left">&nbsp;<%=cx%><input type="hidden" name="CX" value="<%=cx%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 </td>
 </tr>
<tr >
 <td class=roomleft>&nbsp;��;</td>
 <td class=roomright align="left">&nbsp;<%=yongtu%><input type="hidden" name="yongt" value="<%=Room_Type%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 <td class=roomleft>&nbsp;����</td>
 <td class=roomright align="left">&nbsp;<%=Room_Type%><input type="hidden" name="fl" value="<%=Room_Type%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 </td>
 </tr>
<tr>
 <td class=roomleft>&nbsp;�����������</td>
 <td class=roomright align="left">&nbsp;<%=unitprice%><input type="hidden" name="UNITPRICE"  value="<%=unitprice%>" size="9" style="border-style: solid; border-width: 1"> Ԫ/M<sup>2</sup>
 <td class=roomleft>&nbsp;�ܼ�</td>
 <td class=roomright align="left">&nbsp;<%=sumprice%><input type="hidden" name="SUMPRICE" value="<%=sumprice%>" size="13" style="border-style: solid; border-width: 1">Ԫ
 </td>
 </tr>
</table>
<p align=center><font class=FontColor><b>
ѡ�񸶿ʽ:
    <%
       sql="select * from PayMent where state=1 and seccoe='"+secno+"' order by PayName";
      ResultSet rs3=ViewBean.executeQuery(sql);
 
	  String pay="";
	  float dic;
	  String dj="";
	  float dj1;
	  String num="";
	  String id="";
	  int i=0;
	  String pay1="";
	  String prepay="";
	  String youhui="";

  %>
  <table>
 <%while (rs3.next()){
	    id=rs3.getString("ID");
		pay=getbyte(rs3.getString("PayName"));
		if (pay.indexOf("%")>=0)
		pay1=pay.substring(0,pay.indexOf("%"))+"��"+pay.substring(pay.indexOf("%")+1);
		else pay1=pay;
		num=rs3.getString("num");
	    dic=rs3.getFloat("Discont");
		prepay=rs3.getString("prepay");
		youhui=rs3.getString("youhui");
	 
		String dic1=String.valueOf(dic);
		if (i==0){
		  out.print("<tr>");
		 }
	     out.print("<td><input type='radio' name=pay value='A"+prepay+"A"+pay1+"-"+dic1+"-"+num+"*"+youhui+"|"+id+"'>"+pay+"*"+num+"*��</td>");
		 i++;
		 if (i==3)i=0;
		 if (i==0)out.print("</tr>");
	  }rs3.close();
     %></table>
	 <table border="0"><tr><td> 
	 <input type=hidden name=AjType value=0>
	 �������ޣ�
	 <select name="year" style="width:100">
	   <option value="<%=0.5 %>"><%=0.5 %>��</option>
	 <%for (int ii=1;ii<=30;ii++){ %>
	  <option value="<%=ii %>"><%=ii %>��</option>
	 <%} %>
   </select>
    �������ͣ�
	 <select name="dktype" style="width:100">
	  <option value=3>�ȶϢ���� </option>
	 <option value=0>��ҵ�Դ���</option>
	 <option value=1>�ȱ��𻹿� </option>
     <option value=2>��������� </option>
    </select></td></tr><tr><td>
�������ͣ�
	 <select name="saletype" style="width:100">
	 <option value=0>����</option>
	 <option value=1>����</option>
    </select>
	 �ͻ����ͣ�
	 <select name="custype" style="width:100">
	 <option value=0>����</option>
	 <option value=1>��λ</option>
    </select>
	</td></tr></table>
	 
  <input type=hidden vlaue="1" name=tax></b></font></p>
  <p align=center><input type=button name=submit1 value="��  ��" onclick="SubCheck()">&nbsp;&nbsp;<input type=button name=close value="��  ��"  onclick="window.close();">
</center>
</FORM>
<script>
 function SubCheck(){
      var FT="";
	  var paylist="";
	  var ajtype=document.cus.AjType.value;
	  if (document.cus.pay.length){
	 for (var i=0;i<document.cus.pay.length;i++) {
	   if (document.cus.pay[i].checked){paylist+="/"+document.cus.pay[i].value;FT="TRUE";}
	 }
    if (FT=="")
    {alert("��ѡ�񸶿ʽ");
	 return false;
	}
	 paylist=paylist.substring(paylist.indexOf("/")+1);
	 }else{
	  if (!document.cus.pay.checked)
	   { alert("��ѡ�񸶿ʽ");
	     return false;
	   }	 
	   paylist=document.cus.pay.value
	 }
	 var sumprice=document.cus.SUMPRICE.value;
	 var year=document.cus.year.value;
	 var saletype=document.cus.saletype.value;
	 var custype=document.cus.custype.value;
	 var dktype=document.cus.dktype.value;
	  var se="0";
	  //if (document.cus.se.checked)  se="1";
	 var tax="";
	  tax="yes";
     openwin2("ChargesCountList.jsp?year="+year+"&paylist="+paylist+"&sumprice="+sumprice+"&tax="+tax+"&ajtype="+ajtype+"&saletype="+saletype+"&loft=<%=loft %>&roomno=<%=loft %>&section=<%=secno %>&custype="+custype+"&dktype="+dktype+"&yongtu=<%=yongtu %>&SaleArea=<%=jzarea %>&area<%=area %>&buildtype=<%=buildtype %>&unitprice=<%=unitprice %>&tnunitprice=<%=unitprice %>&se="+se,600,550,200,10);
   }

</script>
</body>

</html>
