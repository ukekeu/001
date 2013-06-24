<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>房间资料</title>
</head>

<body oncontextmenu="return false"  >
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
  String sql="";
  int id=0;
  String Payname="";
 
  
  
  String secno= getbyte2(request.getParameter("secno"));
  String build= getbyte2(request.getParameter("build"));
  String roomno= getbyte2(request.getParameter("roomno"));
  String show= getbyte2(request.getParameter("show"));
  String loft= getbyte2(request.getParameter("loft" ));
  String state= getbyte2(request.getParameter("state"));
 
  
  String yl="";
   
		  String Floor="";
		  String area="";
		  String fx="";
		  String cx="";
		  String jg="";
                String zx="";
                state="";

		  String usearea="";
		  String apportionarea="";
		  String date="";
		 
		  String fl="";
		  String unitprice="";
               String sumprice="";	
		  String picpath="";
		   String TNunitprice="";
	  	  String name="";
		
                int Code=0;
		sql="select R.*,S.Name from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.seccode='"+secno+"' and R.Loft='"+loft+"' and "+" R.building='"+build+"' and "+"R.Room_code='"+roomno+"'";
		java.text.DecimalFormat df = new java.text.DecimalFormat(" #########.####"); 
        java.text.DecimalFormat df1 = new java.text.DecimalFormat(" #########.##"); 
        java.text.DecimalFormat df2 = new java.text.DecimalFormat(" #########"); 
		ResultSet rs=ViewBean.executeQuery(sql);
	 
		if (rs.next()){
		  Code=rs.getInt("Code");
		  Floor=rs.getString("Floor");
		  area=df.format(rs.getFloat("Area"));
		  fl=getbyte(rs.getString("Room_Type"));
		  cx=getbyte(rs.getString("Direction"));
		  jg=getbyte(rs.getString("Scene"));
               
		  zx=getbyte(rs.getString("Fitment"));
                state=getbyte(rs.getString("salestate"));
		  usearea=df.format(rs.getFloat("UsedArea"));
		  apportionarea=df.format(rs.getFloat("ApportionArea"));
		  date=getbyte(rs.getString("Serve_Date"));
		  java.text.SimpleDateFormat Fdate =null;
  		  Fdate=new java.text.SimpleDateFormat("yyyy-MM-dd");
		  if (!date.equals(""))
  		  date=Fdate.format(Fdate.parse(date));
		  fx=getbyte(rs.getString("roomtype"));
		  unitprice=rs.getString("Unitprice");
               sumprice=rs.getString("Sumprice");
		  picpath=rs.getString("Map");
		  TNunitprice=rs.getString("TNunitprice");
	  	  name=getbyte(rs.getString("Name"));
               String str="";
             if (state.equals("1")) str="预留";
             if (state.equals("4")) str="取消预留";
             if (state.equals("4"))yl="checked";
		
 %>
 <script>
 function loca(){
  var secname=document.frm.secname.value;
  var build=document.frm.build.value;
  var roomno=document.frm.roomno.value;
  var Floor=document.frm.Floor.value;
  var Loft=document.frm.loft.value;
  var roomtype=document.frm.roomtype.value;
  var jzarea=document.frm.jzarea.value;
  var area=document.frm.area.value;
  var sumprice=document.frm.sumprice.value;
  var fitment=document.frm.fitment.value;
  var unitprice=document.frm.unitprice.value;
  var tnunitprice=document.frm.tnunitprice.value;
  var secno=document.frm.secno.value;
  
 // window.location="rgdj.jsp?para=aa&secname="+secname+"&build="+build+"&roomno="+roomno+"&roomtype="+roomtype+"&jzarea="+jzarea+"&area="+area+"&sumprice="+sumprice+"&fitment="+fitment+"&unitprice="+unitprice+"&tnunitprice="+tnunitprice+"&secno="+secno;
  
 }
 function order1(){
  if (document.frm.choose[0].checked){
	  var secname=document.frm.secname.value;
	  var build=document.frm.build.value;
	  var roomno=document.frm.roomno.value;
	  var Floor=document.frm.Floor.value;
	  var loft=document.frm.loft.value;
	  var roomtype=document.frm.roomtype.value;
	  var jzarea=document.frm.jzarea.value;
	  var area=document.frm.area.value;
	  var sumprice=document.frm.sumprice.value;
	  var fitment=document.frm.fitment.value;
	  var unitprice=document.frm.Unitprice.value;
	  var tnunitprice=document.frm.tnunitprice.value;
	  var secno=document.frm.secno.value;
	  var Floor=document.frm.Floor.value;
	  window.location="order_ld.jsp?code=<%=Code %>&secname=<%=name %>&secno=<%=secno %>&roomno=<%=roomno%>&build=<%=build%>&loft=<%=loft %>&jldate=<%=date %>&Floor="+Floor;
   }
    if (document.frm.choose[1].checked){ 
	  window.location="Modi_LD.jsp?code=<%=Code %>";
	}
	 if (document.frm.choose[2].checked){
	  if (confirm("确认取消吗?"))
	 window.location="delete_ld.jsp?code=<%=Code %>";
	 }
	 if (document.frm.choose[3]){
	  if (document.frm.choose[3].checked){
	 window.location="printLDSJ.jsp?code=<%=Code %>&Loft=<%=name+loft+build +roomno  %>";
	 }}
	} 
 </script>

 <form name=frm method="post" action="rgdj.jsp?para=aa" >
  <input type="hidden" name="Code" value="<%=Code%>">
  <input type="hidden" name="secno" value="<%=secno%>">
  <input type="hidden" name="Floor" value="<%=Floor%>">

<div align="center">
<p align="center" class="FontColor"><b><font size="3" >房间基本资料</font></b></p></div>
<table border="0" width="100%"CELLSPACING=1 CELLPADDING=1 ALIGN=center  ><tr><td>

<input type=radio name=choose onclick="order1();">认购<input type=radio name=choose  title="修改临定" onclick="order1();">修改临定<input type=radio name=choose  title="修改临定" onclick="order1();">取消临定<input type="button" value="打印临时定金协议书" name="submit2" onclick="window.location='PrintCusLs.jsp?code=<%=Code %>';"><!--<input type=radio name=choose  title="打印收据" onclick="order1();">打印收据-->


<input type=hidden name=secname value="<%=name %>">
</td></tr></table>
<table border="0" width="100%"CELLSPACING=1 CELLPADDING=1 ALIGN=center  >
  <tr>
      <td width="25%" class=roomleft>&nbsp;区&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td width="25%" class=roomright><%=loft %></td>
	<INPUT TYPE="hidden" name=loft value="<%=loft %>">
    <td width="25%" class=roomleft>&nbsp;栋&nbsp;&nbsp;&nbsp;号</td>
    <td width="25%" class=roomright><%=build %></td>
	<INPUT TYPE="hidden" name=build value="<%=build %>">
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td width="25%" class=roomright><%=roomno %></td>
	<input type=hidden name=roomno value=<%=roomno %>>
    <td width="25%" class=roomleft>&nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;层</td>
    <td width="25%" class=roomright><%=Floor %></td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;户&nbsp;&nbsp;&nbsp;&nbsp;型</td>
    <td width="25%" class=roomright><%=fx %></td>
	<input type=hidden name=roomtype value=<%=fx %>>
     <td width="25%" class=roomleft>&nbsp;建筑面积</td>
    <td width="25%" class=roomright><%=area.trim()  %></td>
	<input type=hidden name=jzarea value=<%=area %>>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;朝&nbsp;&nbsp;&nbsp;&nbsp;向</td>
    <td width="25%" class=roomright><%=cx%></td>
   <input type=hidden name=cx value=<%=cx %>>
	 <td width="25%" class=roomleft>&nbsp;套内面积</td>
    <td width="25%" class=roomright><%=usearea.trim()  %></td>
	<input type=hidden name=area value=<%=usearea %>>


  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;装修标准</td>
    <td width="25%" class=roomright><%=zx %></td>
	<input type=hidden name=fitment value=<%=zx %>>
       <td width="25%" class=roomleft>&nbsp;分摊面积</td>
    <td width="25%" class=roomright><%=apportionarea.trim() %></td>

   
     </tr>
  <tr>
   	<td width="25%" class=roomleft>&nbsp;景&nbsp;&nbsp;&nbsp;&nbsp;观</td>
    <td width="25%" class=roomright><%=jg %></td>

	<td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;类</td>
    <td width="25%" class=roomright><%=fl %></td>

  </tr>
  <tr>
      <td width="25%" class=roomleft>&nbsp;交楼日期</td>
    <td width="25%" class=roomright><%=date %></td>
       <td width="25%" class=roomleft>&nbsp;建面积单价</td>
    <td width="25%" class=roomright><%=unitprice.trim()  %></td>
<input type=hidden name=Unitprice value=<%=unitprice %>>
   </tr>
  <TR>
    <td width="25%" class=roomleft>&nbsp;套面积单价</td>
    <td width="25%" class=roomright><%=TNunitprice.trim()  %></td>
	<input type=hidden name=tnunitprice value=<%=TNunitprice %>>
      <td width="25%" class=roomleft>&nbsp;总&nbsp;&nbsp;&nbsp;&nbsp;价</td>
    <td width="25%" class=roomright><%=sumprice.trim()  %></td>
	  <input type=hidden name=sumprice value=<%=sumprice %>>

  </tr>
  <tr>
    <td width="25%" class=roomleft>平面图</td>
    <td width="75%" colspan="3" heigth="30" >
	<%
	if (picpath==null)picpath="";
	if (!picpath.equals("")){ %>
	<img border="0"   src="<%=picpath%>" width="100%" height=300 ><br>
	<%}else{out.print("无图片!");} %>

  </tr>

 
</table>
<%}
rs.close(); %>
</form>

</body>

</html>
