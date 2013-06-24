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
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
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

  String sql="";
  int id=0;
  String Payname="";
  String secno=getbyte2(request.getParameter("secno"));
  String build=getbyte2(request.getParameter("build"));
  String loft=getbyte2(request.getParameter("loft"));
  String floor=request.getParameter("floor");
  String roomno=getbyte2(request.getParameter("roomno"));
		sql="select R.*,S.Name from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.seccode='"+secno+"' and "+"R.building='"+build+"' and "+"R.Room_code='"+roomno+"' and R.loft='"+loft+"' and R.floor="+floor;
 
		java.text.DecimalFormat df = new java.text.DecimalFormat(" #########.####"); 
        java.text.DecimalFormat df1 = new java.text.DecimalFormat(" #########.##"); 
        java.text.DecimalFormat df2 = new java.text.DecimalFormat(" #########"); 
		
		ResultSet rs=ViewBean.executeQuery(sql);
		if (rs.next()){
		  int Code=rs.getInt("Code");
		  String Floor=rs.getString("Floor");
		  String area=df.format(rs.getFloat("Area"));
		  String fx=getbyte(rs.getString("Room_Type"));
		  String cx=getbyte(rs.getString("Direction"));
		  String jg=getbyte(rs.getString("Scene"));
		  String zx=getbyte(rs.getString("Fitment"));
		  String usearea=df.format(rs.getFloat("UsedArea"));
		  String apportionarea=df.format(rs.getFloat("ApportionArea"));
		  String date=rs.getString("Serve_Date");
		  java.text.SimpleDateFormat Fdate =null;
  		  Fdate=new java.text.SimpleDateFormat("yyyy-MM-dd");
  		  date=Fdate.format(Fdate.parse(date));
		  String fl=getbyte(rs.getString("roomtype"));
		  String unitprice=df1.format(rs.getFloat("Unitprice"));
          String sumprice=df2.format(rs.getFloat("Sumprice"));
	
		  String picpath=rs.getString("Map");

		   String TNunitprice=df1.format(rs.getFloat("TNunitprice"));
		  String name=getbyte(rs.getString("Name"));
		 
 %>
 <form name=frm method="post" action="RoomUpdate.jsp" ENCTYPE="multipart/form-data">
  <input type="hidden" name="Code" value="<%=Code%>">
  <input type="hidden" name="SecCode" value="<%=secno%>">
  <input type="hidden" name="Floor" value="<%=Floor%>">
<div align="center">
<p ><b><font size="3" CLASS=FontColor>房间资料</font></b></font></p></div>

<table border="0" width="100%" CELLSPACING=1 CELLPADDING=1   >
  <tr>
    <td width="25%" class=roomleft>&nbsp;楼盘名称</td>
    <td width="25%" class=roomright   >&nbsp;<%=name %></td>
    <td width="25%" class=roomleft>&nbsp;栋&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td width="25%" class=roomright   >&nbsp;<%=build %></td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td width="25%" class=roomright   >&nbsp;<%=roomno %></td>
    <td width="25%" class=roomleft>&nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;层</td>
    <td width="25%" class=roomright   >&nbsp;<%=Floor %></td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;户&nbsp;&nbsp;&nbsp;&nbsp;型</td>
    <td width="25%" class=roomright   >&nbsp;<%=fx %></td>
    <td width="25%" class=roomleft>&nbsp;建筑面积</td>
    <td width="25%" class=roomright   >&nbsp;<%=area.trim()  %></td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;朝&nbsp;&nbsp;&nbsp;&nbsp;向</td>
    <td width="25%" class=roomright   >&nbsp;<%=cx%></td>
   
	 <td width="25%" class=roomleft>&nbsp;套内面积</td>
    <td width="25%"  class=roomright  >&nbsp;<%=usearea.trim()  %></td>


  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;装修标准</td>
    <td width="25%" class=roomright  >&nbsp;<%=zx %></td>
    <td width="25%"  class=roomleft>&nbsp;分摊面积</td>
    <td width="25%" class=roomright   >&nbsp;<%=apportionarea.trim() %></td>

   
     </tr>
  <tr>
   	<td width="25%" class=roomleft>&nbsp;景&nbsp;&nbsp;&nbsp;&nbsp;观</td>
    <td width="25%" class=roomright   >&nbsp;<%=jg %></td>

	<td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;类</td>
    <td width="25%" class=roomright   >&nbsp;<%=fl %></td>

  </tr>
  <tr>
      <td width="25%" class=roomleft>&nbsp;交楼日期</td>
      <td width="25%" class=roomright   >&nbsp;<%=date %></td>
      <td width="25%"  class=roomleft>&nbsp;建筑单价</td>
    <td width="25%"   class=roomright  >&nbsp;<%=unitprice.trim()  %>元</td>

   </tr>
  <TR>
    <td width="25%"  class=roomleft>&nbsp;套内单价</td>
    <td width="25%"  class=roomright  >&nbsp;<%=TNunitprice.trim()  %>元</td>
    <td width="25%"   class=roomleft>&nbsp;总&nbsp;&nbsp;&nbsp;&nbsp;价</td>
    <td width="25%"  class=roomright  >&nbsp;<%=sumprice.trim()  %>元</td>

   </tr>
</table>
<%if (!picpath.equals("")){ %>
<table border=0 width="82%">
  <tr>
    <td  class=roomleft>平面图</td>
    <td  ><img border="0"   src="<%=picpath%>" width="100%">

  </tr>
</table>
<%} %>
<p align="center"> 
          <input type="BUTTON" value="退 出" name="submit" onclick="window.close()">
  </P>
 
 <%
}

rs.close(); %>
</form>

</body>

</html>
