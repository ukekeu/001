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
  if (Show==null)Show="true";

  String sql="";
  int id=0;
  String Payname="";
  String secno=request.getParameter("secno");
  String build=request.getParameter("build");
  String roomno=request.getParameter("roomno");
		sql="select R.*,S.Name from Room R inner join Section S on S.SerialNo=R.seccode where R.seccode='"+secno+"' and "+"R.building='"+build+"' and "+"R.Room_code='"+roomno+"'";
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

<table border="0" width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center>
  <tr>
    <td width="25%" class=roomleft>&nbsp;楼盘名称</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name="secname1"  value="<%=name %>" size="12" style="border-style: solid; border-width: 1" readonly>&nbsp;</td>
    <td width="25%" class=roomleft>&nbsp;栋&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name="Building"  value="<%=build %>" size="12" style="border-style: solid; border-width: 1" readonly>&nbsp;</td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name="RoomCode"  value="<%=roomno %>" size="12" style="border-style: solid; border-width: 1" readonly>&nbsp;</td>
    <td width="25%" class=roomleft>&nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;层</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name="Floor"  value="<%=Floor %>"  size="12" style="border-style: solid; border-width: 1">&nbsp;</td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;户&nbsp;&nbsp;&nbsp;&nbsp;型</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name=HouseType  value="<%=fx %>"  size="12" style="border-style: solid; border-width: 1">&nbsp;</td>
    <td width="25%" class=roomleft>&nbsp;建筑面积</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name="Area"  value="<%=area.trim()  %>"  size="12" style="border-style: solid; border-width: 1">&nbsp;</td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;朝&nbsp;&nbsp;&nbsp;&nbsp;向</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name=Direction  value="<%=cx%>"  size="12" style="border-style: solid; border-width: 1">&nbsp;</td>
   
	 <td width="25%" class=roomleft>&nbsp;套内面积</td>
    <td width="25%"  class=roomright ALIGN=center>&nbsp;<input type=text name=UsedArea value="<%=usearea.trim()  %>" size="12" style="border-style: solid; border-width: 1">&nbsp;</td>


  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;装修标准</td>
    <td width="25%" class=roomright ALIGN=center>&nbsp;<input type=text name=Fitment  value="<%=zx %>"  size="12" style="border-style: solid; border-width: 1">&nbsp;</td>
    <td width="25%"  class=roomleft>&nbsp;分摊面积</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name=Apportion  value="<%=apportionarea.trim() %>" size="12" style="border-style: solid; border-width: 1">&nbsp;</td>

   
     </tr>
  <tr>
   	<td width="25%" class=roomleft>&nbsp;景&nbsp;&nbsp;&nbsp;&nbsp;观</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name=Scene  value="<%=jg %>"  size="12" style="border-style: solid; border-width: 1">&nbsp;</td>

	<td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;类</td>
    <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name=RoomType  value="<%=fl %>"  size="12" style="border-style: solid; border-width: 1">&nbsp;</td>

  </tr>
  <tr>
      <td width="25%" class=roomleft>&nbsp;交楼日期</td>
      <td width="25%" class=roomright  ALIGN=center>&nbsp;<input type=text name=date  value="<%=date %>" size="12" style="border-style: solid; border-width: 1">&nbsp;</td>
      <td width="25%"  class=roomleft>&nbsp;建筑单价</td>
    <td width="25%"   class=roomright ALIGN=center>&nbsp;<input type=text name=UnitPrice  value="<%=unitprice.trim()  %>" size="12" style="border-style: solid; border-width: 1">&nbsp;</td>

   </tr>
  <TR>
    <td width="25%"  class=roomleft>&nbsp;套内单价</td>
    <td width="25%"  class=roomright ALIGN=center>&nbsp;<input type=text name="TNunitprice"  value="<%=TNunitprice.trim()  %>"  size="12" style="border-style: solid; border-width: 1">&nbsp;</td>
    <td width="25%"   class=roomleft>&nbsp;总&nbsp;&nbsp;&nbsp;&nbsp;价</td>
    <td width="25%"  class=roomright ALIGN=center>&nbsp;<input type=text name="SumPrice"  value="<%=sumprice.trim()  %>"  size="12" style="border-style: solid; border-width: 1">&nbsp;</td>

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
<input type="file" name="Map" style="border-style: solid; border-width: 1" value="<%//=picpath%>"></td>
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
          <input type="BUTTON" value="退 出" name="submit" onclick="window.close()">
  </P>
 
 <%
}

rs.close(); %>
</form>

</body>

</html>
