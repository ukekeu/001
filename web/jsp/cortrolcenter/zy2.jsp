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
<title>打印置业计划书</title>
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
  String code=getbyte2(request.getParameter("code"));
  ViewBean.executeUpdate("update room set readnum=readnum+1 where code="+code);
  String sql="select R.tnunitprice,R.loft,R.room_code,R.Room_Type,R.yong_tu,R.Area,R.RoomType,R.Direction,R.usedArea,R.Unitprice,R.Sumprice,S.Name,R.seccode from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.code="+code;
		java.text.DecimalFormat df = new java.text.DecimalFormat(" #########.####"); 
        java.text.DecimalFormat df1 = new java.text.DecimalFormat(" #########.##"); 
        java.text.DecimalFormat df2 = new java.text.DecimalFormat(" #########"); 
		 String area="";
		 String jzarea="";
		 String roomtype="";
		 String cx="";
		 String unitprice="",tnunitprice="";
		  String sumprice="";
		  String name="";
		  String room="";
		  String yongtu="";
		  String Room_Type="";
		  String SaleArea="";
		ResultSet rs=ViewBean.executeQuery(sql);
		if (rs.next()){
		  tnunitprice=getbyte(rs.getString("tnunitprice"));
	       Room_Type=getbyte(rs.getString("Room_Type"));
		   yongtu=getbyte(rs.getString("yong_tu"));
		   jzarea=df.format(rs.getFloat("Area"));
		   loft=getbyte(rs.getString("loft"));
		   roomtype=getbyte(rs.getString("RoomType"));
		   cx=getbyte(rs.getString("Direction"));
		   roomno=getbyte(rs.getString("room_code"));
		   area=df.format(rs.getFloat("usedArea"));
		   unitprice=df1.format(rs.getFloat("Unitprice"));
           sumprice=df2.format(rs.getFloat("Sumprice"));
	
		   name=getbyte(rs.getString("Name"));
		   secno=getbyte(rs.getString("seccode"));
		}rs.close();	 
 %>
<form name=cus method=POST ACTION="">
<p align=center><font size=3 class=FontColor><b>房间基本资料</b></font></p>
<center>

<input type=hidden name=Floor value="<%=request.getParameter("Floor") %>">
<table BORDER=0 width="90%" CELLSPACING=1 CELLPADDING1 ALIGN=center bordercolor="#000000" class="tablefill">
 <tr >
 <td class=roomleft>&nbsp;楼盘名称</td>
 <td class=roomright align="left">&nbsp;<%=name%><input type="hidden" value="<%=name%>" name="SECNAME" size="15" style="border-style: solid; border-width: 1">
 </td>
 <td class=roomleft>&nbsp;房号</td>
 <td class=roomright align="left">&nbsp;<%=loft+build+roomno %><input type="hidden" value="<%=loft+build+roomno%>" name="LOFT" size="15" style="border-style: solid; border-width: 1">
 </td>
 </tr>
 
 
 <tr >
 <td class=roomleft>&nbsp;建筑面积</td>
 <td class=roomright align="left">&nbsp;<%=jzarea%><input type="hidden" name="JZAREA" value="<%=jzarea%>" size="13" style="border-style: solid; border-width: 1">M<sup>2</sup>
 <td class=roomleft>&nbsp;套内建筑面积</td>
 <td class=roomright align="left">&nbsp;<%=area%><input type="hidden" name="USERAREA" value="<%=area%>" size="13" style="border-style: solid; border-width: 1">M<sup>2</sup> 
 </td>
 </tr>
<tr >
 <td class=roomleft>&nbsp;户型</td>
 <td class=roomright align="left">&nbsp;<%=roomtype%><input type="hidden" name="ROOMTYPE" value="<%=roomtype%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 <td class=roomleft>&nbsp;朝向</td>
 <td class=roomright align="left">&nbsp;<%=cx%><input type="hidden" name="CX" value="<%=cx%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 </td>
 </tr>
<tr >
 <td class=roomleft>&nbsp;用途</td>
 <td class=roomright align="left">&nbsp;<%=yongtu%><input type="hidden" name="yongt" value="<%=Room_Type%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 <td class=roomleft>&nbsp;房类</td>
 <td class=roomright align="left">&nbsp;<%=Room_Type%><input type="hidden" name="fl" value="<%=Room_Type%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 </td>
 </tr>
<tr>
 <td class=roomleft>&nbsp;建筑面积单价</td>
 <td class=roomright align="left">&nbsp;<%=unitprice%><input type="hidden" name="UNITPRICE"  value="<%=unitprice%>" size="9" style="border-style: solid; border-width: 1"> 元/M<sup>2</sup>
 <td class=roomleft>&nbsp;总价</td>
 <td class=roomright align="left">&nbsp;<%=sumprice%><input type="hidden" name="SUMPRICE" value="<%=sumprice%>" size="13" style="border-style: solid; border-width: 1">元
 </td>
 </tr>
</table>
<p align=center><font class=FontColor><b>
选择付款方式:
    <%
       sql="select * from PayMent  where state=1  and seccoe='"+secno+"' order by PayName";
      ResultSet rs3=ViewBean.executeQuery(sql);
	  String pay="";
	  String dic;
	  String dj="";
	  float dj1;
	  String num="";
	  String id="";
	  int i=0;
	  String pay1="";
	  String prepay="";

  %>
  <table>
 <%
 String cs="";
 while (rs3.next()){
	    id=rs3.getString("ID");
		pay=getbyte(rs3.getString("PayName"));
		if (pay.indexOf("揭")>=0){
          	cs=pay.substring(pay.indexOf("(")+1,pay.indexOf("%"));
	     }
			
		if (pay.indexOf("%")>=0)
		pay1=pay.substring(0,pay.indexOf("%"))+"成"+pay.substring(pay.indexOf("%")+1);
		else pay1=pay;
		num=rs3.getString("num");
	    dic=rs3.getString("Discont");
		prepay=rs3.getString("prepay");
		String dic1=String.valueOf(dic);
		if (i==0){
		  out.print("<tr>");
		 }
	     out.print("<td><input type='radio' name=pay value="+id+">"+pay+"</td>");
		 i++;
		 if (i==4)i=0;
		 if (i==0)out.print("</tr>");
	  }rs3.close();
%>
<tr><td>选择按揭年限&nbsp;<select name=dkyear>
<%for (int ii=1;ii<=30;ii++){ %>
<option value="<%=ii %>"><%=ii %>年</option>
<%} %>
</select></td></tr>
</table>
	 
	 
  <input type=hidden vlaue="1" name=tax></b></font></p>
  <p align=center><input type=button name=submit1 value="提  交" onclick="SubCheck()">&nbsp;&nbsp;<input type=button name=close value="退  出"  onclick="window.close();">
</center>
<p align=center>在打印置业计划书请先定义好客户购房时需要提交的资料及购买后需要交的配套费及税费等</p>
</FORM>
<script>
 function SubCheck(){
      var FT="";
	  var paylist="";
	 
	  if (document.cus.pay.length){
		 for (var i=0;i<document.cus.pay.length;i++) {
		   if (document.cus.pay[i].checked){paylist=document.cus.pay[i].value;FT="TRUE";}
		 }
	      if (FT=="")
	      {alert("请选择付款方式");
		   return false;
		  }
	 
	 }else{
		  if (!document.cus.pay.checked)
		   { alert("请选择付款方式");
		     return false;
		   }	 
		   paylist=document.cus.pay.value
	 }
 
    window.location="printzybook2.jsp?code=<%=code %>&pay="+paylist+"&dkyear="+document.cus.dkyear.value;
    
 
 
   }

</script>
</body>

</html>
