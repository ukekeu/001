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
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/qx_checke.jsp"%>
<%
//权限审核
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT12");
Cortrol+=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT021");

  String sql="";
  int id=0;
  String Payname="";
  String secno= getbyte2(request.getParameter("secno"));
  String build= getbyte2(request.getParameter("build"));
  String roomno= getbyte2(request.getParameter("roomno"));
  String show= getbyte2(request.getParameter("show"));
  String loft= getbyte2(request.getParameter("loft" ));
  String state= getbyte2(request.getParameter("state"));
  String Floor= getbyte2(request.getParameter("Floor"));
  
  
//读取来自诚意数据的资料  
String ref_id = request.getParameter( "ref_id" ) ;
String ref_phone = request.getParameter( "ref_phone" ) ;
String ref_cusname = request.getParameter( "ref_cusname" ) ;
String ref_id_card = request.getParameter( "ref_id_card" ) ;
String ref_money = request.getParameter( "ref_money" ) ;
String chenyiSQL ="&ref_phone="+ref_phone+"&ref_cusname="+ref_cusname+"&ref_id_card="+ref_id_card+"&ref_money="+ref_money+"&ref_id="+ref_id;

  String yl="";
   
		
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
				int nn=0;
		  String yong_tu="";		
		  String saleloke="";		
		sql="select R.*,datediff(mi,R.salelokedate,getdate()) as nn,S.Name from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.seccode='"+secno+"' and R.Loft='"+loft+"' and "+" R.building='"+build+"' and "+"R.Room_code='"+roomno+"' and R.floor="+Floor;
 
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
           yong_tu    =getbyte(rs.getString("yong_tu"));
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
	  	  saleloke=getbyte(rs.getString("saleloke"));
		  if (saleloke.equals(""))saleloke="0";
		  nn=rs.getInt("nn");
		  name=getbyte(rs.getString("Name"));
	 
               String str="";
             if (state.equals("1")) str="预留";
             if (state.equals("4")) str="取消预留";
             if (state.equals("4"))yl="checked";
			 if (ref_id_card!=null)yl=" ";
		 
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
   <%if (ref_id_card!=null){ %>  
   window.location="order.jsp?secname=<%=name %>&secno=<%=secno %>&roomno=<%=roomno%>&build=<%=build%>&loft=<%=loft %>&Floor=<%=Floor %>&jldate=<%=date %><%=chenyiSQL %>";
   <%}else{ %>
   if (document.frm.choose[0].checked)
   { window.location="order.jsp?secname=<%=name %>&secno=<%=secno %>&roomno=<%=roomno%>&build=<%=build%>&loft=<%=loft %>&Floor=<%=Floor %>&jldate=<%=date %><%=chenyiSQL %>";}
   else if (document.frm.choose[1]){
     if (document.frm.choose[1].checked)
      window.location="ld_sale.jsp?code=<%=Code %>;"}
   <%} %>
   if (document.frm.choose2){
    if (document.frm.choose2.checked)
    // alert("SaveRoomYL.jsp?secname=<%=name %>&secno=<%=secno %>&roomno=<%=roomno%>&build=<%=build%>&loft=<%=loft %>&yl=<%=yl %>");
	  window.location="SaveRoomYL.jsp?secname=<%=name %>&secno=<%=secno %>&roomno=<%=roomno%>&build=<%=build%>&loft=<%=loft %>&yl=<%=yl %>";}

    if (document.frm.choose1)
	{ if (document.frm.choose1.checked)
	    window.location="CancelInput.jsp?secname=<%=name %>&secno=<%=secno %>&roomno=<%=roomno%>&build=<%=build%>&loft=<%=loft %>";
    }
 }
 function zlinfo(){
   
   
      window.location="zl_sale.jsp?code=<%=Code %>;" 
  
 }
 
 function checkrg(){
   // if (confirm("确认认购吗？确认后系统将锁定此数据，其他人不能再认购！"))
	  order1();
 }
  function checkqy(){
  //  if (confirm("确认认购吗？确认后系统将锁定此数据，其他人不能再认购！"))
	 window.location="orderok.jsp?secname=<%=name %>&secno=<%=secno %>&roomno=<%=roomno%>&build=<%=build%>&loft=<%=loft %>&Floor=<%=Floor %>&jldate=<%=date %><%=chenyiSQL %>"; 

 }
 </script>
 <form name=frm method="post" action="rgdj.jsp?para=aa" >
  <input type="hidden" name="Code" value="<%=Code%>">
  <input type="hidden" name="secno" value="<%=secno%>">
  <input type="hidden" name="Floor" value="<%=Floor%>">

<div align="center">
<%

if (saleloke.equals("1")){
 
 String Ai="select * from order_contract where state<>3 and loft='"+loft+"' and section='"+secno+"' and room_no='"+roomno+"' and floors="+Floor;

   ResultSet exist=ViewBean1.executeQuery(Ai);
   if (!exist.next()&&nn<1){
   exist.close();
    out.print("<script>alert('此房间曾已被人锁定，可能资料正在录入过程中出现了网络故障原因造成数据被锁定而未录入认购数据');window.close();</script>"); 
   }else if (nn<1){

 out.print("<script>alert('此房间已被人认购，资料正在录入过程中..');close();</script>");out.close();}}%>
<p align="center" class="FontColor"><b><font size="3" >房间基本资料表</font></b></p></div>
<table border="0" width="100%"CELLSPACING=1 CELLPADDING=1 ALIGN=center  ><tr><td>
<% 
   if (Cortrol==null){Cortrol="";}
 
%>

<%if ((yl.equals("")||ref_id_card!=null)&& Cortrol.indexOf("A")>=0 ){ %>
<input type=radio name=choose onclick="checkrg();">认购
 <input type=radio name=qy onclick="checkqy();">直接签约
<!--<input type=radio name=choose  title="签约合同" onclick="order1();">签约-->
<%} %>
<% if (!state.equals("5") && Cortrol.indexOf("A")>=0){ %>
<%if (yl.equals("")){ %>
<input type=radio name=choose  onclick="order1();">临定
<%} %>
<!--<input type=radio name=choose2  onclick="window.location='SaveRoomYL.jsp?secname=<%=name %>&secno=<%=secno %>&roomno=<%=roomno%>&build=<%=build%>&loft=<%=loft %>&yl=<%=yl %>';" <%=yl %>><a href="#" onclick="window.location='SaveRoomYL.jsp?secname=<%=name %>&secno=<%=secno %>&roomno=<%=roomno%>&build=<%=build%>&loft=<%=loft %>&yl=<%=yl %>';"><%=str %></a>-->
<%} %>

<%if (yl.equals("")&&Cortrol.indexOf("A")>=0){ %>
<% if (!state.equals("1")&&!state.equals("5")){ %>
 <input type=radio name=choose1  onclick="order1();">挞订
<%}
}%>
 <input type=radio name=choosezl  onclick="zlinfo();">租赁
<input type=hidden name=secname value="<%=name %>">
</td></tr></table>
<table border="0" width="100%"CELLSPACING=1 CELLPADDING=1 ALIGN=center  >
 
    
	<INPUT TYPE="hidden" name=loft value="<%=loft %>">
    
	<INPUT TYPE="hidden" name=build value="<%=build %>">
  
  <tr>
    <td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td width="25%" class=roomright><%=loft+roomno %></td>
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
	 <td width="25%" class=roomleft>&nbsp;套内建筑面积</td>
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
       <td width="25%" class=roomleft>&nbsp;建筑面积单价</td>
    <td width="25%" class=roomright><%=unitprice.trim()  %></td>
<input type=hidden name=Unitprice value=<%=unitprice %>>
   </tr>
  <TR>
    <td width="25%" class=roomleft>&nbsp;套内建筑单价</td>
    <td width="25%" class=roomright><%=TNunitprice.trim()  %></td>
	<input type=hidden name=tnunitprice value=<%=TNunitprice %>>
      <td width="25%" class=roomleft>&nbsp;总&nbsp;&nbsp;&nbsp;&nbsp;价</td>
    <td width="25%" class=roomright><%=sumprice.trim()  %></td>
	  <input type=hidden name=sumprice value=<%=sumprice %>>

  </tr>
   <TR>
    <td width="25%" class=roomleft>&nbsp;用途</td>
    <td width="25%" class=roomright><%=yong_tu %></td>
	<input type=hidden name=yong_tu value=<%=yong_tu %>>

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

<%

sql="select  a.* ,c.cus_name,b.date from TFRecord a ,order_contract b,customer c"
	                  +" where a.secno+a.loft+a.room =b.section+b.loft+b.room_no and a.customer=c.SerialNo and b.state=3 and  "
					 
					 +"   a.secno+a.loft+a.room='"+secno+loft+roomno+"'" 
                      + " order by a.loft+a.room asc,a.tf_date desc";
  rs=ViewBean.executeQuery(sql);
  int jjj=0;
  while (rs.next()){
  if (jjj==0){
%>
 <hr>
<table width="90" border="0" cellspacing="0" cellpadding="0" class="L2"  >
   <tr> 
     <td  class="<%out.print("menuselect3");%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=0;findSub('visitcusview.jsp');""><font color='<%out.print("#FFFFFF");%>'>历史退定记录</a>
	</td>
</table>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef"  align="center">
  <td >序号</td>
  <td> 认购日期</td>
 
  <td> 客户姓名 </td>
  <td> 建筑面积 </td>
  <td> 退房金额 </td>
  <td> 退定日期 </td>
  <td> 退定原因 </td>
  <td> 经办人 </td>
  <td> 审批人 </td></tr> 
  <%}jjj++;
        
		 String cusname=getbyte(rs.getString("cus_name"));
	 
		 String Loft =getbyte(rs.getString("Loft"));
		 
		  String Room_code = rs.getString("room"); 
		  String  jzarea = rs.getString("jzarea");
		    sumprice = rs.getString("sumprice");
	     String CancelDate = rs.getString("tf_date");
		 String Note = getbyte(rs.getString("context"));
		 String person=getbyte(rs.getString("person"));
		 String checker=getbyte(rs.getString("checker"));
		 String rgdate=rs.getDate("date").toString();
  
   %>
     <tr id=TR<%=jjj %>  align="center"  onclick="changeclass1(this,'clickbg','');"  onmouseover="mout(this) "  title="挞订原因：<%=Note %>" >
   <td    ><%=jjj %></td>
    <td    ><%=rgdate%></td>
 
<td> <%=cusname %></td>
<td ><%=jzarea%></td>
<td><%= sumprice%></td>
<td><%= CancelDate.substring(0,10) %></td>
<td><%= Note %>&nbsp;</td>
<td><%= person %></td>
<td><%= checker %></td>
</tr>
<%}rs.close();
if (jjj>0) out.print("</table>");
 %>
 
 
<%

sql="select  a.*,b.cus_name from ChangRoomR a ,customer b "
	                  +" where  a.customer=b.serialno and a.secno+a.loft+a.oldroom='"+secno+loft+roomno+"'  order by a.ChangeDate";
  rs=ViewBean.executeQuery(sql);
 
 
    jjj=0;
  while (rs.next()){
  if (jjj==0){
%>
<hr>
<table width="90" border="0" cellspacing="0" cellpadding="0" class="L2"  >
   <tr> 
     <td  class="<%out.print("menuselect3");%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=0;findSub('visitcusview.jsp');""><font color='<%out.print("#FFFFFF");%>'>历史换房记录</a>
	</td>
</table>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" align="center">
  <td >序号</td>
  <td> 认购日期</td>
  <td> 客户姓名 </td>
   <td> 换前建筑面积 </td>
  <td> 换后建筑面积 </td>
  <td> 换房日期 </td>
  <td>换房原因 </td>
   <td>换后房间 </td>
 </tr> 
  <%}jjj++;
        
		 String cusname=getbyte(rs.getString("cus_name"));
	 
		 String Loft =getbyte(rs.getString("newLoft"));
		 
		 String Room_code = rs.getString("nowroom"); 
		 String  jzarea = rs.getString("jzarea");
		 sumprice = rs.getString("sumprice");
	     String ChangeDate = rs.getString("ChangeDate");
		 String Note = getbyte(rs.getString("note"));
			 String rgdate=rs.getDate("olddate").toString();
  
   %>
     <tr id=TR<%=jjj %>  align="center"  onclick="changeclass1(this,'clickbg','');"  onmouseover="mout(this) "  title="挞订原因：<%=Note %>" >
   <td    ><%=jjj %></td>
    <td    ><%=rgdate%></td>

<td> <%=cusname %></td>
<td ><%=area%></td>
 <td ><%=jzarea%></td>
<td><%= ChangeDate.substring(0,10) %></td>
<td><%= Note %>&nbsp;</td>
 
 <td><%= Loft+Room_code %></td>
</tr>
<%}rs.close();
if (jjj>0) out.print("</table>");
%>
</form>

</body>

</html>
