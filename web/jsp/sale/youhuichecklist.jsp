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

 <p align="center"><b><font size=4><%=getbyte1(request.getParameter("SecName")) %>申请商品房优惠审批表</font></b></p>
 
 <%String sql="";
try{
String SecNo=getbyte1(request.getParameter("SecNo"));
String loft=getbyte1(request.getParameter("Loft"));
String roomno=getbyte1(request.getParameter("room"));
String Date1=getbyte1(request.getParameter("date1"));
String Date2=getbyte1(request.getParameter("date2"));
String codes=getbyte1(request.getParameter("codes"));
String datetype=getbyte1(request.getParameter("datetype"));
 %>
 日期范围:<%=Date1 %>到<%=Date2 %>
<table width="99%"    border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center" >
      <td  >序号</td>
    <td  >幢房号</td>
	<td >购房人</td>
	   <td >认购日期</td>
    <td >面积</td>
    <td  >售价表单价</td>
    <td  >付款方式正常折扣</td>
    <td  >展销会优惠</td>
    <td  >正常单价</td>
    <td  >正常总价</td>
    <td >优惠后单价</td>
	 <td  >优惠后总房款</td>
    <td >额外优惠单价</td>
    <td >额外优惠总房款</td>
    
	  <td >关系人</td>
	    <td >批准人</td>
	    <td >备注</td>
  </tr>
<%

String whereSQL="";

if (!SecNo.equals(""))whereSQL+=" and o.section='"+SecNo+"'";
if (!loft.equals(""))whereSQL+=" and o.loft='"+loft+"'";
if (!roomno.equals(""))whereSQL+=" and o.room_no='"+roomno+"'";
if (!Date1.equals("")&&datetype.equals("1"))whereSQL+=" and convert(char(10),o.date,120)>='"+Date1+"' and convert(char(10),o.date,120)<='"+Date2+"'";
if (!Date1.equals("")&&datetype.equals("0"))whereSQL+=" and convert(char(10),o.youhui_date,120)>='"+Date1+"' and convert(char(10),o.youhui_date,120)<='"+Date2+"'";
if (!codes.equals(""))whereSQL+=" and o.code in("+codes+")";
   sql="select c.cus_name,c.phone p,c.sj ,o.pzr,o.sectionname,o.loft+o.room_no room,";
sql+="o.jzarea,r.unitprice yunitprice,r.unitprice*o.disc/100 zcprice, o.ysumprice/o.jzarea*o.disc/100*o.jzarea zj,o.disc,o.zhangxiaoyouhui,(o.rmbprice+o.gaizhang_unitprice*o.gaizhang_area)/o.jzarea zzj,o.ysumprice/o.jzarea*o.disc/100-(o.rmbprice+o.gaizhang_unitprice*o.gaizhang_area)/o.jzarea a";
sql+=",o.salerprice+o.youhui saleprice,o.salerprice,o.rmbprice+o.gaizhang_unitprice*o.gaizhang_area rmbprice   ,o.salerprice/o.jzarea su, (o.salerprice+o.youhui+(100.0-case when o.ewdisc='' then 0 else convert(numeric(9,2),o.ewdisc) end )*1.0/100*(o.ysumprice/o.jzarea)*o.jzarea)/o.jzarea-o.rmbprice/o.jzarea dc, o.ysumprice,o.ysumprice-o.youhui-(100.0-case when o.ewdisc='' then 0 else convert(numeric(9,2),o.ewdisc) end )*1.0/100*(o.ysumprice/o.jzarea)*o.jzarea price,(o.ysumprice-o.youhui-(100.0-case when o.ewdisc='' then 0 else convert(numeric(9,2),o.ewdisc) end )*1.0/100*(o.ysumprice/o.jzarea)*o.jzarea)/o.jzarea hh,o.youhui,o.youhuibeizhu,o.gxr";
sql+=",o.date from order_contract o,customer c,room r where o.section+o.loft+o.room_no=r.seccode+r.loft+r.room_code and o.customer=c.serialno and   o.state<>3 and (youhui>0 or (ewdisc<>'0' and  ewdisc<>''))  and  o.yh_check=0 "+whereSQL;
 
 ResultSet rs=InsertBean.executeQuery(sql);
int ii=1;
 while (rs.next()){
 %>
 
  <tr height="40"  >
   <td ><%=ii %>　</td>
     <td ><%=getbyte(rs.getString("room")) %>　</td>
	 <td ><%=getbyte(rs.getString("cus_name")) %></td>
	 
    <td ><%=rs.getDate("date").toString() %></td>
  
    <td ><%=FormtD.getFloat(rs.getFloat("jzarea"),3) %></td>
	<%float yunitprice =rs.getFloat("yunitprice");%>
    <td ><%=FormtD.getFloat(yunitprice,2) %></td>
    <td ><%=getbyte(rs.getString("disc")) %></td>
    <td ><%=getbyte(rs.getString("zhangxiaoyouhui")) %>&nbsp;</td>
   <%float ddd=rs.getFloat("zcprice"); %>
    <td ><%=FormtD.getFloat1(ddd,2) %></td>
	<%double zj= rs.getDouble("zj");%>
    <td ><%=Float.parseFloat(FormtD.getFloat1(ddd,2))*rs.getFloat("jzarea") %></td>
	<%float zzj= rs.getFloat("zzj");%>
    <td ><%=FormtD.getFloat(zzj,2) %></td>
	<%double rmb=rs.getDouble("rmbprice");  %>
    <td ><%=FormtD.getFloat2(rmb,2) %></td>
    <td  ><%=FormtD.getFloat(Float.parseFloat(FormtD.getFloat1(ddd,2))-Float.parseFloat(FormtD.getFloat1(zzj,2)),2) %></td>
    <td  ><%=FormtD.getFloat2(Float.parseFloat(FormtD.getFloat1(ddd,2))*rs.getFloat("jzarea")-rmb,2) %></td>
 
     <td   >&nbsp;<%=getbyte(rs.getString("gxr")) %>　</td>
	   
	
    <td >&nbsp;<%=getbyte(rs.getString("pzr")) %>　</td>
   <td >&nbsp;<%=getbyte(rs.getString("youhuibeizhu")) %>　</td>
  </tr>

<%ii++;}
rs.close();
 }catch(Exception s){out.print(sql);out.close();}
 %>
 
 </table>
 <br><br>
 <table width="99%"   align="center"  border=0 cellspacing='0'  cellpadding='0' bordercolordark=ffffff bordercolorlight=000000>
<tr><td>填表人：</td><td>&nbsp;</td><td>&nbsp;</td><td>部门经理:</td><td>&nbsp;</td><td>&nbsp;</td><td>营销总监：</td><td>&nbsp;</td><td>&nbsp;</td><td>总经理：</td><td>&nbsp;</td><td>&nbsp;</td></tr>
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
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
<br>
</body>

</html>
