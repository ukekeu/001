<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>房间资料</title>
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body >
<SCRIPT language=javascript >
function openwin(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin6","toolbar=no,location=no,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
</SCRIPT>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 
<%
  String Show=request.getParameter("show"); 
  if (Show==null)Show="";
String Floor="";
  String sql="";
  int id=0;
  int Code=0;
  String Payname="";
   String name="";
  String secno=getbyte2(request.getParameter("secno"));
  String build=getbyte2(request.getParameter("loft"));
  String roomno=getbyte2(request.getParameter("roomno"));
  String order_code=request.getParameter("order_code");
  String customer=request.getParameter("customer");
		sql="select o.code,R.*,o.sectionName Name,o.customer from Room R , Order_Contract o where o.section=R.seccode and o.loft=R.loft and o.room_no =R.room_code and  R.seccode='"+secno+"' and "+"R.loft='"+build+"' and "+"R.Room_code='"+roomno+"'";
		java.text.DecimalFormat df = new java.text.DecimalFormat(" #########.####"); 
        java.text.DecimalFormat df1 = new java.text.DecimalFormat(" #########.##"); 
        java.text.DecimalFormat df2 = new java.text.DecimalFormat(" #########"); 
 
		ResultSet rs=ViewBean.executeQuery(sql);
		if (rs.next()){
		
		  Code=rs.getInt("Code");
		    Floor=rs.getString("Floor");
		  String area=df.format(rs.getFloat("Area"));
		  String fl=getbyte(rs.getString("Room_Type"));
		  String cx=getbyte(rs.getString("Direction"));
		  String jg=getbyte(rs.getString("Scene"));
		  String zx=getbyte(rs.getString("Fitment"));
		  String usearea=df.format(rs.getFloat("UsedArea"));
		  String apportionarea=df.format(rs.getFloat("ApportionArea"));
		  String date=rs.getString("Serve_Date");
		  java.text.SimpleDateFormat Fdate =null;
  		  Fdate=new java.text.SimpleDateFormat("yyyy-MM-dd");
  		  date=Fdate.format(Fdate.parse(date));
		  String fx=getbyte(rs.getString("roomtype"));
		  String unitprice=df1.format(rs.getFloat("Unitprice"));
          String sumprice=df2.format(rs.getFloat("Sumprice"));
	
		  String picpath=rs.getString("Map");

		   String TNunitprice=df1.format(rs.getFloat("TNunitprice"));
		   name=getbyte(rs.getString("Name"));
		   customer=getbyte(rs.getString("customer"));
		 
 %>
 <form name=frm method="post" action="RoomUpdate.jsp" ENCTYPE="multipart/form-data">
  <input type="hidden" name="Code" value="<%=Code%>">
  <input type="hidden" name="SecCode" value="<%=secno%>">
  <input type="hidden" name="Floor" value="<%=Floor%>">
<div align="center">
<p ><b><font size="3" CLASS=FontColor>房间资料</font></b></font></p></div>

<table border="0" width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center>
  <tr>
    <td width="25%" class=roomleft>&nbsp;楼盘名称</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=name %>&nbsp;</td>
    <td width="25%" class=roomleft>&nbsp;栋&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=build %>&nbsp;</td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=roomno %>&nbsp;</td>
    <td width="25%" class=roomleft>&nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;层</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=Floor %>&nbsp;</td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;户&nbsp;&nbsp;&nbsp;&nbsp;型</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=fx %>&nbsp;</td>
    <td width="25%" class=roomleft>&nbsp;建筑面积</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=area.trim()  %>&nbsp;</td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;朝&nbsp;&nbsp;&nbsp;&nbsp;向</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=cx%>&nbsp;</td>
   
	 <td width="25%" class=roomleft>&nbsp;套内面积</td>
    <td width="25%"  class=roomright ALIGN=center>&nbsp;<%=usearea.trim()  %>&nbsp;</td>


  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;装修标准</td>
    <td width="25%" class=roomright ALIGN=center>&nbsp;<%=zx %>&nbsp;</td>
    <td width="25%"  class=roomleft>&nbsp;分摊面积</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=apportionarea.trim() %>&nbsp;</td>

   
     </tr>
  <tr>
   	<td width="25%" class=roomleft>&nbsp;景&nbsp;&nbsp;&nbsp;&nbsp;观</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=jg %>&nbsp;</td>

	<td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;类</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=fl %>&nbsp;</td>

  </tr>
  <tr>
      <td width="25%" class=roomleft>&nbsp;交楼日期</td>
      <td width="25%" class=roomright  ALIGN=center>&nbsp;<%=date %>&nbsp;</td>
      <td width="25%"  class=roomleft>&nbsp;建筑单价</td>
    <td width="25%"   class=roomright ALIGN=center>&nbsp;<%=unitprice.trim()  %>&nbsp;</td>

   </tr>
  <TR>
    <td width="25%"  class=roomleft>&nbsp;套内单价</td>
    <td width="25%"  class=roomright ALIGN=center>&nbsp;<%=TNunitprice.trim()  %>&nbsp;</td>
    <td width="25%"   class=roomleft>&nbsp;总&nbsp;&nbsp;&nbsp;&nbsp;价</td>
    <td width="25%"  class=roomright ALIGN=center>&nbsp;<%=sumprice.trim()  %>&nbsp;</td>

   </tr>
  <TR>
    <td width="25%"  class=roomleft>&nbsp;退房原因</td>
    <td width="25%"  class=roomright ALIGN=center>&nbsp;<%if (request.getParameter("tfyy")!="") out.print(getbyte2(request.getParameter("ftyy"))) ;%>&nbsp;</td>
    <td width="25%"   class=roomleft>&nbsp;审批人</td>
    <td width="25%"  class=roomright ALIGN=center>&nbsp;<%=getbyte2(request.getParameter("checker"))  %>&nbsp;</td>

   </tr>
</table>
<table border=0 width="82%">
  <tr>
    <td  class=roomleft>平面图</td>
    <td  >
	<%
	if (picpath==null)picpath="";
	if (!picpath.equals("")){ %>
	<img border="0"   src="<%=picpath%>" width="100%" height=300 ><br>
	<%}else{out.print("无图片!");} %>
</td>
  </tr>
  
</table>

<P  ALIGN=center>
<%
if (!Show.equals("true")){
%>
  <input type="hidden" name="strPicture" value=<%=picpath%>>

<p align="center"> 
           &nbsp;&nbsp;
            <input type="SUBMIT" value="提 交" name="submit">
			&nbsp; <input type="BUTTON" value="退 出" name="submit" onclick="window.close()">
          </P>
<%
 }else%>
<p align="center"> 
         <input type="BUTTON" value="合同资料" name="submit3" onclick="orderlist()">
         <input type="BUTTON" value="客户详细资料" name="submit1" onclick="xiangqing()">
		 <input type="BUTTON" value="付款情况" name="submit2" onclick="sklist()">
         <input type="BUTTON" value="退 出" name="submit" onclick="window.close()">
  </P>
 
 <%
}

rs.close(); %>
</form>
<script>
function xiangqing() {
	
    var spa = 400 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa/3 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=400"  ;
    var posi = posi + ",width=550";
    var newwin1=window.open("../customter/editcustomer.jsp?edit=editcus&cusno=<%=customer %>","NewsW1","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
 
}
function sklist() {
openwin('../finance/yingshi.jsp?contractno=<%=Code %>&cusno=<%=customer %>&loft=&ldroomcode=3435&see=1',650,570,50,50);
}
function orderlist() {
openwin('showContract.jsp?order_code=<%=Code %>&secno=<%=secno %>&secname=<%=name %>&loft=<%=build %>&roomno=<%=roomno %>&Floor=<%=Floor %>&build=',650,570,50,50);
}
</script>
</body>

</html>
