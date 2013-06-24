<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>商品房产权总确权申请审批表</title>
<STYLE type=text/css>
BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 10pt; FONT-FAMILY: 宋体
}
tr {
	FONT-SIZE: 10pt; HEIGHT: 29pt; FONT-FAMILY: 宋体
}
A:link {
	COLOR: #0000cc; TEXT-DECORATION: none
}
A:visited {
	COLOR: #0000cc; TEXT-DECORATION: none
}
A:active {
	COLOR: #ff0000; TEXT-DECORATION: none
}
A:hover {
	TEXT-DECORATION: underline
}
.unnamed1 {
	FONT-SIZE: 9pt; FONT-FAMILY: "宋体"
}
.unnamed2 {
	FONT-SIZE: 15pt
}
</STYLE>
</head>
<%
  String secno=getbyte1(request.getParameter("SecNo"));
 String Loft=getbyte1(request.getParameter("Loft"));
 String room=getbyte1(request.getParameter("room"));
 String SQL="SELECT c.cus_name,c.ID_Card,c.cus_sex,c.address,c.phone,c.sj,o.sectionname,o.loft,o.room_no,";
        SQL+="o.visadate,o.area,o.jzarea,o.jzarea-o.area ftarea,o.room_sumprice/o.area ";
		SQL+="tnunitprice,o.room_sumprice/o.jzarea jzunitprice,o.room_sumprice,";
		SQL+="o.lu_tai_area,o.lu_tai_area_price,o.lu_tai_area*o.lu_tai_area_price luprice";
		SQL+=",o.gaizhang_area,o.gaizhang_unitprice,o.gaizhang_area*o.gaizhang_unitprice gzprice";
		
		SQL+=" FROM ORDER_CONTRACT o,customer c WHERE not  o.visadate is null and  o.customer=c.serialno and o.section='"+secno+"'";
        SQL+=" and o.loft='"+Loft+"'";
 String cus_name="",phone="",sj="",sectionname="",loft="",card_id="",visadate="";
   String room_no="",area="",jzarea="",ftarea="",tnunitprice="",address="";
   String gaizhang_area="",gaizhang_unitprice="",gzprice="",cus_sex="";
   String jzunitprice="",room_sumprice="",lu_tai_area="",lu_tai_area_price="",luprice="";
   
    ResultSet rs=ViewBean.executeQuery(SQL);
  
	
	if (rs.next()){
	   cus_name=getbyte(rs.getString("cus_name"));
	   card_id=getbyte(rs.getString("ID_Card"));
	   cus_sex=getbyte(rs.getString("cus_sex"));
	   address=getbyte(rs.getString("address"));
	   phone=getbyte(rs.getString("phone"));
	   sj=getbyte(rs.getString("sj"));
	   sectionname=getbyte(rs.getString("sectionname"));
	   loft=getbyte(rs.getString("loft"));
	   room_no=getbyte(rs.getString("room_no"));
	   visadate=rs.getDate("visadate").toString();
	   area=Format.getFloat1(rs.getFloat("area"),3);
	   jzarea=Format.getFloat1(rs.getFloat("jzarea"),3);
	   ftarea=Format.getFloat1(rs.getFloat("ftarea"),3);
	   tnunitprice=Format.getFloat1(rs.getFloat("tnunitprice"),2);
	   jzunitprice=Format.getFloat1(rs.getFloat("jzunitprice"),2);
	   room_sumprice=Format.getFloat1(rs.getFloat("room_sumprice"),2);
	   lu_tai_area=Format.getFloat1(rs.getFloat("lu_tai_area"),3);
	   lu_tai_area_price=Format.getFloat1(rs.getFloat("lu_tai_area_price"),2);
	   luprice=Format.getFloat1(rs.getFloat("luprice"),2); 
	   gaizhang_area=Format.getFloat1(rs.getFloat("gaizhang_area"),3);
	   gaizhang_unitprice=Format.getFloat1(rs.getFloat("gaizhang_unitprice"),2);
	   gzprice=Format.getFloat1(rs.getFloat("gzprice"),2);
	}
	rs.close();
	
	String dh="";
	  String th="";
	  String jg="";
	  String floors="";
	
	  String date="";
	 
	  String jj="";
	
	  String jz="";
	
	  String ts="";
	  
	SQL="SELECT * FROM LoftBuildCode WHERE SecNo='"+secno+"'";
    SQL+=" and loft='"+Loft+"'";
	rs=ViewBean.executeQuery(SQL);
    if (rs.next()){
	    jg=getbyte(rs.getString("JieGou"));
		
	    floors=getbyte(rs.getString("floors"));
        dh=getbyte(rs.getString("DiHao"));
	    th=getbyte(rs.getString("tuHao"));
	    
	    date=getbyte(rs.getString("JianChenDate"));
	    jj=getbyte(rs.getString("JianZhuJiDi_area"));
	    jz=getbyte(rs.getString("JianZhuSum_area"));
	    ts=getbyte(rs.getString("ZongNum"));
	    if (!date.equals(""))date=date.substring(0,10);
	
	}
	rs.close(); 
	String tudishiyong_no="",cq_sd="",cq_ed="",useyear="",yong_tu="";
	String y="",m="",d="",AreaNo="",Type="",developcom="";
	String y1="",m1="",d1="",tdqyxz="",tdqsly="",frdz="",frdh="";
	
   SQL="SELECT tudishiyong_no, cq_sd, cq_ed ,useyear,tdqsly,tdqyxz,AreaNo,Type,developcom,frdz,frdh FROM crm_project where SerialNo='"+secno+"'";
   rs=ViewBean.executeQuery(SQL);
    if (rs.next()){
	   tudishiyong_no=getbyte(rs.getString("tudishiyong_no"));
	   cq_sd=getbyte(rs.getString("cq_sd"));
	   cq_ed=getbyte(rs.getString("cq_ed"));
	   useyear=getbyte(rs.getString("useyear"));
	   tdqsly=getbyte(rs.getString("tdqsly"));
	   tdqyxz=getbyte(rs.getString("tdqyxz"));
	   AreaNo=getbyte(rs.getString("AreaNo"));
	   Type=getbyte(rs.getString("Type"));   
	   developcom=getbyte(rs.getString("developcom")); 
	   frdz=getbyte(rs.getString("frdz")); 
	   frdh=getbyte(rs.getString("frdh")); 
	   if (!cq_sd.equals("")){
	   cq_sd=cq_sd.substring(0,10);
	
	   y=cq_sd.substring(0,4);
	   cq_sd=cq_sd.substring(5,10);
	   m=cq_sd.substring(0,2);
	   d=cq_sd.substring(3);
	   }
	   if (!cq_ed.equals(""))cq_ed=cq_ed.substring(0,10);
	   
	   
	   
	   
	}
	rs.close(); 
	
	
   
 %>
<body>
<DIV align=center id="printdiv">
注意:在打印之前必须设置纸张及距，在菜单"文件"中选择"页面设置",<br><br>选择纸张类型"a4",方向选择"纵向",边距"左为20"右为15，上为"20"，下为10
  <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <center>
   <div align=left id=report1 style="background-color:#F7F7F7;height:300%;overflow:auto;width:90%;z-index:2" contentEditable>
<br><br>
  <table width="98%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr valign="top">
    <td width="200" colspan="2">&nbsp;</td>
    <td width="380" colspan="3" align="center"><%if (developcom.indexOf(" ")>=0){out.print(developcom.substring(0,developcom.indexOf(" ")));out.print("<br>"+developcom.substring(developcom.indexOf(" ")+1));}else{out.print(developcom);} %></td>
  </tr>
  <tr  valign="bottom">
    <td width="133" colspan="2">&nbsp;</td>
    <td width="380" colspan="2"  align="CENTER">&nbsp;&nbsp;<%=frdz %></td>
    <td width="300"align="right"><%=frdh %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr>
    <td width="133" colspan="2">&nbsp;</td>
    <td width="744" colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=AreaNo %></td>
  </tr>
  <tr>
    <td width="133" colspan="2">&nbsp;</td>
    <td width="288">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=jg+"  "+floors %></td>
    <td width="202">
      <p align="center">&nbsp;</td>
    <td width="242">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if (!date.equals("")){out.println(date.substring(0,7));} %></td>
  </tr>
  <tr>
    <td width="133" colspan="2">&nbsp;</td>
    <td width="288">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dh %></td>
    <td width="202">&nbsp;</td>
    <td width="242">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=th %></td>
  </tr>
  <tr valign="bottom">
    <td width="133" colspan="2">&nbsp;</td>
    <td width="288">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=tdqyxz %></td>
    <td width="202">&nbsp;</td>
    <td width="242">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=tdqsly %></td>
  </tr>
  <tr valign="bottom">
    <td width="133" colspan="2">&nbsp;</td>
    <td width="288">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=jj %></td>
    <td width="202">&nbsp;</td>
    <td width="242">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=jj %></td>
  </tr>
  
  <tr valign="bottom">
    <td width="133" colspan="2">&nbsp;</td>
    <td width="288">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=jz %></td>
    <td width="202">&nbsp;</td>
    <td width="242">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=jz %></td>
  </tr>
  <tr valign="bottom">
    <td width="133" colspan="2">&nbsp;</td>
    <td width="288">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="202">&nbsp;</td>
    <td width="242">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr valign="top">
    <td width="133"  colspan="2">&nbsp;</td>
    <td width="288" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ts %></td>
    <td width="202"  >&nbsp;</td>
    <td width="242"  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ts %></td>
  </tr>
  <tr valign="top">
    <td width="31" height="80" rowspan="5">&nbsp;</td>
    <td width="96">&nbsp;</td>
    <td width="288">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%="市国土局" %></td>
    <td width="202">&nbsp;</td>
    <td width="242">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=tudishiyong_no %></td>
  </tr>
  <tr>
    <td width="96">&nbsp;</td>
    <td width="288"></td>
    <td width="202">&nbsp;</td>
    <td width="242"></td>
  </tr>
 
 
  <tr  valign="bottom">
    <td width="96">&nbsp;</td>
    <td width="744" colspan="3"><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Type %></td>
  </tr>

  <tr valign="top">
    <td width="96">&nbsp;</td>
   
	<td width="738" colspan="3"><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=useyear+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+y+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+m+"&nbsp;&nbsp;&nbsp;&nbsp;"+d %>&nbsp;&nbsp;<%="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+y+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+m+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+d %></td>

  </tr>
  
  <tr>
    <td width="31"  >&nbsp;</td>
    <td width="846" colspan="4"></td>
  </tr>
  
</table>


</div>
 
</center>
</body>

</html>
