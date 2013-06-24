<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/Repalce.jsp"%>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>优惠审批表</title>
</head>

<body>
<DIV align=center id="printdiv">
<font size=3>

</font><!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">&nbsp;<input type="button" onclick="bringToExcel()" value="导出到Excel">
 </div>

 

  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
<%
String sql="";
try{
String SecNo=getbyte1(request.getParameter("SecNo"));
String loft=getbyte1(request.getParameter("Loft"));
String roomno=getbyte1(request.getParameter("room"));
String Date1=getbyte1(request.getParameter("Date1"));
String Date2=getbyte1(request.getParameter("Date2"));
String codes=getbyte1(request.getParameter("codes"));
String whereSQL="";

if (!SecNo.equals(""))whereSQL+=" and o.section='"+SecNo+"'";
if (!loft.equals(""))whereSQL+=" and o.loft='"+loft+"'";
if (!roomno.equals(""))whereSQL+=" and o.room_no='"+roomno+"'";
if (!Date1.equals(""))whereSQL+=" and convert(char(10),o.youhui_date,120)>='"+Date1+"' and convert(char(10),o.youhui_date,120)<='"+Date2+"'";
if (!codes.equals(""))whereSQL+=" and o.code in("+codes+")";
 sql="select c.cus_name,c.phone p,c.sj ,o.sectionname,o.loft+o.room_no room,";
sql+="o.jzarea,r.unitprice yunitprice,r.unitprice*o.disc/100 zcprice, o.ysumprice/o.jzarea*o.disc/100*o.jzarea zj,o.disc,o.zhangxiaoyouhui,(o.rmbprice+o.gaizhang_unitprice*o.gaizhang_area)/o.jzarea zzj,o.ysumprice/o.jzarea*o.disc/100-(o.rmbprice+o.gaizhang_unitprice*o.gaizhang_area)/o.jzarea a";
sql+=",o.salerprice+o.youhui saleprice,o.salerprice,o.rmbprice+o.gaizhang_unitprice*o.gaizhang_area rmbprice   ,o.salerprice/o.jzarea su, (o.salerprice+o.youhui+(100.0-case when o.ewdisc='' then 0 else convert(numeric(9,2),o.ewdisc) end )*1.0/100*(o.ysumprice/o.jzarea)*o.jzarea)/o.jzarea-o.rmbprice/o.jzarea dc, o.ysumprice,o.ysumprice-o.youhui-(100.0-case when o.ewdisc='' then 0 else convert(numeric(9,2),o.ewdisc) end )*1.0/100*(o.ysumprice/o.jzarea)*o.jzarea price,(o.ysumprice-o.youhui-(100.0-case when o.ewdisc='' then 0 else convert(numeric(9,2),o.ewdisc) end )*1.0/100*(o.ysumprice/o.jzarea)*o.jzarea)/o.jzarea hh,o.youhui,o.youhuibeizhu,o.gxr";
sql+=",o.date from order_contract o,customer c,room r where o.section+o.loft+o.room_no=r.seccode+r.loft+r.room_code and o.customer=c.serialno and   o.state<>3 and (youhui>0 or (ewdisc<>'0' and  ewdisc<>''))  and  o.yh_check=0 "+whereSQL;
 
 ResultSet rs=InsertBean.executeQuery(sql);

 while (rs.next()){
 %>
 
 <p align="center"><b><font size=4>申请商品房优惠审批表</font></b></p>
 
 <table width="99%"    border=1 cellspacing='0'  cellpadding='0' bordercolordark=ffffff bordercolorlight=000000>
<tr><td>GLG/QRK(f)720-12</td></tr>
</table>
<table width="99%"    border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 
  <tr height="40"  >
    <td width="6%" rowspan="2">申请人</td>
    <td width="8%">购房人</td>
    <td width="54%" colspan="7"><%=getbyte(rs.getString("cus_name")) %></td>
    <td width="8%" >联系电话</td>
    <td width="24%" colspan="3" ><%=getbyte(rs.getString("p")) %>&nbsp;<%=getbyte(rs.getString("sj")) %></td>
  </tr>
  <tr height="40" >
    <td width="8%">关系人</td>
    <td width="54%" colspan="7">&nbsp;<%=getbyte(rs.getString("gxr")) %>　</td>
	  <td width="8%">认购日期</td>
    <td width="24%" colspan="3"><%=rs.getDate("date").toString() %></td>
  </tr>
  <tr align="center" height="40" >
    <td width="14%" colspan="2" rowspan="2">项目名称</td>
    <td width="7%" rowspan="2">幢房号</td>
    <td width="7%" rowspan="2">面积</td>
    <td width="8%" rowspan="2">售价表<br>单价</td>
    <td width="8%" rowspan="2">付款方式正常折扣</td>
    <td width="8%" rowspan="2">展销会<br>优惠</td>
    <td width="8%" rowspan="2">正常优惠</td>
    <td width="8%" rowspan="2">总房款</td>
    <td width="15%" colspan="2">优惠后</td>
    <td width="17%" colspan="2">优惠与正常售价差额</td>
  </tr>
  <tr align="center" height="40" >
    <td width="8%">单价</td>
    <td width="7%">总房款</td>
    <td width="9%">单价</td>
    <td width="8%">总房款</td>
  </tr>
  <tr height="40" >
    <td width="14%" colspan="2"><%=getbyte(rs.getString("sectionname")) %>　</td>
    <td width="7%"><%=getbyte(rs.getString("room")) %>　</td>
    <td width="7%"><%=FormtD.getFloat(rs.getFloat("jzarea"),3) %></td>
	<%float yunitprice =rs.getFloat("yunitprice");%>
    <td width="8%"><%=FormtD.getFloat(yunitprice,2) %></td>
    <td width="8%"><%=getbyte(rs.getString("disc")) %></td>
    <td width="8%"><%=getbyte(rs.getString("zhangxiaoyouhui")) %>&nbsp;</td>
   <%float ddd=rs.getFloat("zcprice"); %>
    <td width="8%"><%=FormtD.getFloat1(ddd,2) %></td>
	<%double zj= rs.getDouble("zj");%>
    <td width="8%"><%=Float.parseFloat(FormtD.getFloat1(ddd,2))*rs.getFloat("jzarea") %></td>
	<%float zzj= rs.getFloat("zzj");%>
    <td width="8%"><%=FormtD.getFloat(zzj,2) %></td>
	<%double rmb=rs.getDouble("rmbprice");  %>
    <td width="7%"><%=FormtD.getFloat2(rmb,2) %></td>
    <td width="9%"><%=FormtD.getFloat(Float.parseFloat(FormtD.getFloat1(ddd,2))-Float.parseFloat(FormtD.getFloat1(zzj,2)),2) %></td>
    <td width="8%"><%=FormtD.getFloat2(Float.parseFloat(FormtD.getFloat1(ddd,2))*rs.getFloat("jzarea")-rmb,2) %></td>
  </tr>
  <tr height="40" >
    <td width="14%" colspan="2">&nbsp;</td>
    <td width="7%">&nbsp;</td>
    <td width="7%">&nbsp;</td>
    <td width="8%">&nbsp;</td>
    <td width="8%">&nbsp;</td>
    <td width="8%">&nbsp;</td>
    <td width="8%">&nbsp;</td>
    <td width="8%">&nbsp;</td>
    <td width="8%">&nbsp;</td>
    <td width="7%">&nbsp;</td>
    <td width="9%">&nbsp;</td>
    <td width="8%">&nbsp;</td>
  </tr>
  <tr align="center" height="40" >
    <td width="6%" rowspan="2">备
      <p>注</td>
    <td width="62%" colspan="8" rowspan="2">&nbsp;<%=rs.getString("youhuibeizhu")%></td>
    <td width="8%">填表人</td>
    <td width="7%">部门经理</td>
	<td width="7%">营销总监</td>
    <td width="17%"  >总经理审批</td>
  </tr>
  <tr height="40" >
    <td width="8%">&nbsp;<%=(String)session.getAttribute("loginname") %></td>
    <td width="7%">&nbsp;</td>
	    <td width="7%">&nbsp;</td>
    <td width="17%" >&nbsp;</td>
  </tr>
</table>
<%}
rs.close();
 }catch(Exception s){out.print(sql);out.close();}
 %>
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
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
<br>
</body>

</html>
