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
<title>补充协议</title>
<STYLE type=text/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 30pt; FONT-FAMILY: 宋体
}
tr{
	FONT-SIZE: 10pt; HEIGHT: 22pt; FONT-FAMILY: 宋体
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
 String SQL="SELECT o.section,o.ContractNo,c.cus_name,c.phone,c.sj,o.sectionname,o.loft,o.room_no,";
        SQL+="o.area,o.jzarea,o.jzarea-o.area ftarea,(o.room_sumprice+o.gaizhang_area*o.gaizhang_unitprice)/o.area ";
		SQL+="tnunitprice,(o.room_sumprice+o.gaizhang_area*o.gaizhang_unitprice)/o.jzarea jzunitprice,o.room_sumprice+o.gaizhang_area*o.gaizhang_unitprice room_sumprice,";
		SQL+="o.lu_tai_area,o.lu_tai_area_price,o.lu_tai_area*o.lu_tai_area_price luprice";
		SQL+=",o.gaizhang_area,o.gaizhang_unitprice,o.gaizhang_area*o.gaizhang_unitprice gzprice,o.room_sumprice+o.lu_tai_area*o.lu_tai_area_price sump";
		
		SQL+=",o.floors,o.ty_area,o.ty_area_price,o.wd_area,o.wd_area_price FROM ORDER_CONTRACT o,customer c WHERE o.customer=c.serialno and o.CODE="+request.getParameter("code");
   String section="";
   String cus_name="",phone="",sj="",sectionname="",loft="";
   String room_no="",area="",jzarea="",ftarea="",tnunitprice="";
   String gaizhang_area="",gaizhang_unitprice="",gzprice="",ContractNo="";
   String jzunitprice="",room_sumprice="",lu_tai_area_price="",luprice="";
   float lu_tai_area=0;
   int floors=0;
   float ty_area=0;
   float ty_area_price=0;
      float wd_area=0;
   float wd_area_price=0;
   String sump="";
    ResultSet rs=ViewBean.executeQuery(SQL);
  	
	if (rs.next()){
	   section=getbyte(rs.getString("section"));
	   ContractNo=getbyte(rs.getString("ContractNo"));
	 
	   cus_name=getbyte(rs.getString("cus_name"));
	   phone=getbyte(rs.getString("phone"));
	   sj=getbyte(rs.getString("sj"));
	   sectionname=getbyte(rs.getString("sectionname"));
	   loft=getbyte(rs.getString("loft"));
	   room_no=getbyte(rs.getString("room_no"));
	   area=Format.getFloat1(rs.getFloat("area"),3);
	   jzarea=Format.getFloat1(rs.getFloat("jzarea"),3);
	   ftarea=Format.getFloat1(rs.getFloat("ftarea"),3);
	   tnunitprice=Format.getFloat1(rs.getFloat("tnunitprice"),2);
	   jzunitprice=Format.getFloat1(rs.getFloat("jzunitprice"),2);
	   room_sumprice=Format.getFloat3(rs.getDouble("room_sumprice"),2);
	   lu_tai_area=rs.getFloat("lu_tai_area");
	   lu_tai_area_price=Format.getFloat1(rs.getFloat("lu_tai_area_price"),2);
	   luprice=Format.getFloat1(rs.getFloat("luprice"),2); 
	   gaizhang_area=Format.getFloat1(rs.getFloat("gaizhang_area"),3);
	   gaizhang_unitprice=Format.getFloat1(rs.getFloat("gaizhang_unitprice"),2);
	
	   gzprice=Format.getFloat1(rs.getFloat("gzprice"),2);
	   sump=Format.getFloat1(rs.getFloat("sump"),2);
	   floors=rs.getInt("floors");
	   ty_area=rs.getFloat("ty_area");
	   ty_area_price=rs.getFloat("ty_area_price");
	   wd_area=rs.getFloat("wd_area");
	   wd_area_price=rs.getFloat("wd_area_price");
	 
	 
	
	}
	rs.close();
    String upperMoney="";
    ResultSet execRs=ViewBean.executeQuery("exec dbo.L2U "+room_sumprice+",0 ");//大写金额转换存储过程
             if (execRs.next())
				upperMoney=getbyte(execRs.getString("dd"));
				execRs.close();
			
 
	String upperMoney1="";
	
 
       execRs=ViewBean.executeQuery("exec dbo.L2U "+gzprice+",0 ");//大写金额转换存储过程
             if (execRs.next())
				upperMoney1=getbyte(execRs.getString("dd"));
				execRs.close();
			
	String upperMoney2="";
	
 
       execRs=ViewBean.executeQuery("exec dbo.L2U "+luprice+",0 ");//大写金额转换存储过程
             if (execRs.next())
				upperMoney2=getbyte(execRs.getString("dd"));
				execRs.close();
				
String fzs="select fzs from LoftBuildCode where secno='"+section+"' and loft='"+loft+"'";				
  execRs=ViewBean.executeQuery(fzs);

  if (execRs.next())
				fzs=getbyte(execRs.getString("fzs"));
				execRs.close();
if (fzs.equals(""))				
  fzs="广东龙光(集团)有限公司";				
 %>
<body >
<DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <div align=left id=report1 style="background-color:#F7F7F7;height:200%;overflow:auto;width:100%;z-index:2" contentEditable>
<p align="center"><font size="4"><b>补充协议</b></font></p>
<table border="0" width="99%" > <tr>
    <td width="100%"  align="right">列<%=ContractNo %>号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
 
  <tr>
    <td width="100%">出卖人：<%=fzs %>　　　　　　　　　　　　联系电话：8888875</td>
  </tr>
  <tr>
    <td width="100%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 　　</td>
  </tr>
  <tr>
    <td width="100%">买受人：<%=cus_name%>　　　　　　　　　　　　　　　　　　　　　　　联系电话：<%=phone+sj %></td>
  </tr>
  <tr>
    <td width="100%">　　双方根据平等自愿的原则，经协商签订本补充协议共同遵守履行。</td>
  </tr>
  <tr>
    <td width="100%">　　第一条　　双方协商，买受人向出卖方认购位于汕头市<%=sectionname %>第<%=loft %>　　　<%=room_no %>　　　号单元(住宅)，</td>
  </tr>
  <tr>
    <td width="100%">套内建筑面积约为<%=area %>平方米(整套建筑面积约为<%=jzarea %>平方米，其中公共分摊面积约<%=ftarea %>平方米)，</td>
  </tr>
  <tr>
    <td width="100%">套内建筑面积单价<%=tnunitprice %>元/平方米，总价款计人民币<%=upperMoney %>（小写￥<%=room_sumprice %>元）。</td>
  </tr>
 
  <% 
  String de="第二条";
   String ds="第三条";
      String ds1="第四条";
	     String dw="第五条";
		 	     String dl="第六条";
				 	     String dq="第七条";
  if (!gaizhang_unitprice.equals("0")){ 
 
  %>
  <tr>
    <td width="100%">　　<%=de %>　　买受人同意按上述单价购买出卖人上述房产的同时自愿委托出卖人进行改装。改</td>
  </tr>
  <tr>
    <td width="100%">装面积<%=gaizhang_area %>平方米(阳台面积按50%计)，改装单价(含于本补充协议第一条单价之内)</td>
  </tr>
  
  <tr>
    <td width="100%">为<%=gaizhang_unitprice %>元/平方米，合计人民币<%=upperMoney1 %>（小写￥<%=gzprice %>元）。</td>
  </tr>
  <%}else{
  dl=dw;
  dq=dl;
   dw=ds1;
  ds1=ds;
  ds=de;} %>
  <tr>
    <td width="100%">　　<%=ds %>　　计价面积及价款于交房时的按实核结算，多退少补。</td>
  </tr>
  <%if (lu_tai_area>0){ %>
  <tr>
    <td width="100%">　　<%=ds1 %>　　该商品房毗连露台<%=lu_tai_area %>
      平方米，花园/露台单价<%=lu_tai_area_price %>元/平方米，总价<%=upperMoney2 %>元。</td>
  </tr>
  <%} %>
  <%if (ty_area_price>0){ %>
  <tr>
    <td width="100%">　　<%//=ds1 %>　　该商品房毗连花园<%=ty_area %>
      平方米，花园单价<%=ty_area_price %>元/平方米，总价<%=Format.getFloat2(ty_area_price*ty_area,2) %>元。</td>
  </tr>
  <%} %>
   <%if (wd_area_price>0){ %>
  <tr>
    <td width="100%">　　<%//=ds1 %>　　该商品房毗连花园<%=wd_area %>
      平方米，花园单价<%=wd_area_price %>元/平方米，总价<%=Format.getFloat2(wd_area_price*wd_area,2) %>元。</td>
  </tr>
  <%} %>
  <%
  SQL="SELECT PRICE FROM contractWYTK WHERE sectionno='"+section+"'";
     rs=ViewBean.executeQuery(SQL);
  	String xyprice="0";
	if (rs.next()){xyprice=rs.getString("price");}
	rs.close();
	
	
   %>
  <tr>
    <td width="100%">　　仅有使用权，不得擅自搭建，并应严格按照<%=sectionname %>管理处的物业管理规定合理使用(花园/露台</td>
  </tr>
  <tr>
    <td width="100%">不计产权面积）。<%if (wd_area_price==0){ %>如在交房时花园/露台面积出现差异，双方同意按以下原则处理：<%} %></td>
  </tr>
  <%if (wd_area_price==0){ %>
  <tr>
    <td width="100%">　　1、差异值-5%到＋5%以内(含本数)的，买卖双方不作任何补偿；</td>
  </tr>
  <tr>
    <td width="100%">　　2、差异值-5%到＋5%以上(不含本数)的，买卖双方按<%=xyprice %>元/平方米的配套建设费结算，多退少补。</td>
  </tr>
   <%} %>
  <tr>
    <td width="100%">　　<%=dw %>　双方约定其他事项：</td>
  </tr>
 
  <tr>
    <td width="100%">　</td>
  </tr>
  <tr>
    <td width="100%">　</td>
  </tr>
  <tr>
    <td width="100%">　</td>
  </tr>
  <tr>
    <td width="100%">　　<%=dl %>　　除涉及上述条款外其余事项仍按双方签订其它协议及合同时条款执行。</td>
  </tr>
  <tr>
    <td width="100%">　　<%=dq %>　　本补充协议一式贰份，双方各执一份，自签订之日起生效。</td>
  </tr>
  <tr>
    <td width="100%">　</td>
  </tr>
 
  <tr>
    <td width="100%">　　出卖人：　　　　　　　　　　　　　　　　　　　　买受人：</td>
  </tr>
  <tr>
    <td width="100%">　</td>
  </tr>
 
  <tr>
    <td width="100%">　　代表：　　　　　　　　　　　　　　　　　　　　　代表：</td>
  </tr>
    <tr>
    <td width="100%">　　　　　　　　　　　　　　　　　　　　　　　　　　　　签订日期：　　　　年　　　月　　　日</td>
  </tr>
</table>
</div>

</body>

</html>
