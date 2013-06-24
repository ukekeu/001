 
<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/checktime.jsp"%>
<HTML><HEAD><TITLE>认购书</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
<META content=FrontPage.Editor.Document name=ProgId>
<STYLE type=text/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 10pt; FONT-FAMILY: 宋体
}
TABLE {
	FONT-SIZE: 10pt; HEIGHT: 31pt; FONT-FAMILY: 宋体
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
</HEAD>

<%
String secno=getbyte2(request.getParameter("secno"));
String loft=getbyte2(request.getParameter("loft"));
String roomno=getbyte2(request.getParameter("roomno"));
String floors=request.getParameter("Floor");
 String SQL="SELECT d.developcom,o.SerialNo,o.yong_tu,o.code,c.cus_name,c.phone,c.sj,c.id_card,c.address,o.sectionname,o.loft,o.room_no,";
        SQL+="o.payment1,o.ajmoney,o.ajmoney*1.0/o.rmbprice*100 ajrate,o.ajyear,o.rmbprice,(o.rmbprice-o.ajmoney)/o.rmbprice*100.0 firstrate,o.ajmoney/o.rmbprice*100.0 ajrate,o.rmbprice-o.ajmoney first,o.area,o.jzarea,o.jzarea-o.area ftarea,o.room_sumprice/o.area ";
		SQL+="tnunitprice,o.room_sumprice/o.jzarea jzunitprice,o.room_sumprice,o.subscription,";
		SQL+="o.lu_tai_area,o.lu_tai_area_price,o.lu_tai_area*o.lu_tai_area_price luprice";
		SQL+=",o.gaizhang_area,o.gaizhang_unitprice,o.gaizhang_area*o.gaizhang_unitprice gzprice,o.room_sumprice+o.lu_tai_area*o.lu_tai_area_price+o.ty_area*o.ty_area_price  sump ";
		
		SQL+=",o.wd_area,o.ty_area,o.ty_area_price,o.ty_area*o.ty_area_price  typrice FROM ORDER_CONTRACT o,customer c,CRM_Project d WHERE  o.section=d.SerialNo and o.state<>3 and o.customer=c.serialno ";
		SQL+=" and o.loft='"+loft+"' and o.section='"+secno+"' and room_no='"+roomno+"'";// and floors="+floors;
   
   String ajyear="",ajmoney="",firstrate="",first="",ajrate="";
  
   String cus_name="",phone="",sj="",sectionname="",id_card="",code="";
   String room_no="",area="",jzarea="",ftarea="",tnunitprice="",subscription="";
   String gaizhang_area="",gaizhang_unitprice="",gzprice="",address="",payment1="";
   String jzunitprice="",room_sumprice="",lu_tai_area="",lu_tai_area_price="",luprice="";
   String rmbprice="",yong_tu="",sump="",SerialNo="",developcom="";
   String ty_area="0";
   float wd_area=0;
   String ty_area_price="0",typrice="0";
    ResultSet rs=ViewBean.executeQuery(SQL);
  
	
	if (rs.next()){
	   developcom=getbyte(rs.getString("developcom"));
	   SerialNo=getbyte(rs.getString("SerialNo"));
	   yong_tu=getbyte(rs.getString("yong_tu"));
	   code=getbyte(rs.getString("code"));
	   cus_name=getbyte(rs.getString("cus_name"));
	   phone=getbyte(rs.getString("phone"));
	   sj=getbyte(rs.getString("sj"));
	   id_card=getbyte(rs.getString("id_card"));
	   address=getbyte(rs.getString("address"));
	   sectionname=getbyte(rs.getString("sectionname"));
	   loft=getbyte(rs.getString("loft"));
	   room_no=getbyte(rs.getString("room_no"));
	   payment1=getbyte(rs.getString("payment1"));
	    ajmoney=Format.getFloat1(rs.getFloat("ajmoney"),0);
		ajrate=Format.getFloat1(rs.getFloat("ajrate"),2);
		ajyear=Format.getFloat1(rs.getFloat("ajyear"),0);
		
		rmbprice=rs.getString("rmbprice");
		 firstrate=Format.getFloat1(rs.getFloat("firstrate"),2);
		 ajrate=Format.getFloat1(rs.getFloat("ajrate"),2);
		  first=Format.getFloat1(rs.getFloat("first"),2);
	   area=Format.getFloat1(rs.getFloat("area"),3);
	   jzarea=Format.getFloat1(rs.getFloat("jzarea"),3);
	   ftarea=Format.getFloat1(rs.getFloat("ftarea"),3);
	   tnunitprice=Format.getFloat1(rs.getFloat("tnunitprice"),2);
	   jzunitprice=Format.getFloat1(rs.getFloat("jzunitprice"),2);
	   room_sumprice=Format.getFloat1(rs.getFloat("room_sumprice"),2);
	   subscription=Format.getFloat1(rs.getFloat("subscription"),2);
	   lu_tai_area=Format.getFloat1(rs.getFloat("lu_tai_area"),3);
	   lu_tai_area_price=Format.getFloat1(rs.getFloat("lu_tai_area_price"),2);
	   luprice=Format.getFloat1(rs.getFloat("luprice"),2); 
	   gaizhang_area=Format.getFloat1(rs.getFloat("gaizhang_area"),3);
	   gaizhang_unitprice=Format.getFloat1(rs.getFloat("gaizhang_unitprice"),2);
	
	   gzprice=Format.getFloat1(rs.getFloat("gzprice"),2);
	   	   sump   =Format.getFloat3(rs.getDouble("sump"),2);
	   wd_area =rs.getFloat("wd_area");
	   ty_area =rs.getString("ty_area");
	   ty_area_price=rs.getString("ty_area_price");
	   typrice =Format.getFloat3(rs.getDouble("typrice"),2);
	
	}
	rs.close();
    String upperMoney="";
    ResultSet execRs=ViewBean.executeQuery("exec dbo.L2U "+sump+",0 ");//大写金额转换存储过程
             if (execRs.next())
				upperMoney=getbyte(execRs.getString("dd"));
				execRs.close();
				
 
	String upperMoney1="";
	
 
       execRs=ViewBean.executeQuery("exec dbo.L2U "+gzprice+",0 ");//大写金额转换存储过程
             if (execRs.next())
				upperMoney1=getbyte(execRs.getString("dd"));
				execRs.close();
				
	
	String upperMoney2="";
	
       execRs=ViewBean.executeQuery("exec dbo.L2U "+subscription+",0 ");//大写金额转换存储过程
             if (execRs.next())
				upperMoney2=getbyte(execRs.getString("dd"));
				execRs.close();
			/*	if (upperMoney2.indexOf("角")>0){
				  upperMoney2=upperMoney2.substring(0,upperMoney2.length()-1);
				  upperMoney2=upperMoney2.substring(0,upperMoney2.indexOf("角")-1)+"零"+upperMoney.substring(upperMoney.indexOf("角")-1);
			 }  
			 */

    %>
 
<BODY bgColor=#ffffff>
<P align=center><B><FONT face=黑体 size=5></FONT></B></P>
<P align=center><FONT size=3>&nbsp;</FONT></P>
<form name=frm method="post">
<input type=hidden name=printrg value="ok">
<DIV align=center id="printdiv">
<font size=3>
注意:在打印之前必须设置纸张，点击"打印预览"后再点击"打印"右的"图标"中选择,<br><br>选择纸张类型"A3",方向选择"横向",左：24，右：10,上：24.69，下:30</font><!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="submit" name="submit1" value="打印预览">
 </div>
 </form>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0  border="0">
 <tr><td  >
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR>
</TABLE>

<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=635 
  border=0><TR><TD width=635  align="right" ><%=SerialNo %></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD width=600  align="right" ></TD></TR>
 
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD width=600  align="right" ></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR> 
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR><TR><TD >&nbsp;</TD></TR><TR><TD >&nbsp;</TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD  width="114"></TD><TD width="250" >&nbsp;<%=cus_name %></TD><TD width="250" ><%=address %></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD  width="114"></TD><TD width="250" >&nbsp;<%=phone %>&nbsp;<%=sj %></TD><TD width="250" >&nbsp;&nbsp;<%=id_card %></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD  width="80">&nbsp;</TD> 
  <TD  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;第<%=loft %>&nbsp;<%=room_no %>号房，用途为<%=yong_tu %>,目前暂测套内建筑面积约：<%=area %>M<sup>2</sup>，整套建筑面积为：<%=jzarea %>M<sup>2</sup>，分摊面积为：<%=ftarea %>M<sup>2</sup>，
   套内建筑面积单价： <%=tnunitprice %>元/M<sup>2</sup>，露台面积为：<%=lu_tai_area %>M<sup>2</sup>，露台单价：<%=lu_tai_area_price %>元/M<sup>2</sup>，花园面积为：<%=ty_area %>M<sup>2</sup>，花园单价：<%=ty_area_price %>元/M<sup>2</sup>,<%if (wd_area>0){ %>屋面面积：<%=wd_area %>M<sup>2</sup><%} %>(花园/露台/屋面面积不计产权面积)，合计人民币:<%=upperMoney %>(小写￥<%=sump %>元)</TD></TR>
 <!--<TR><TD  width="80">&nbsp;</TD> <TD  ></TD></TR>-->

</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD  width="300" align="right">&nbsp;</TD></TR>
 <!--<TR><TD  width="300" align="right">&nbsp;</TD></TR>
  <TR><TD  width="300" align="right">&nbsp;</TD></TR>
   <TR><TD  width="300" align="right">&nbsp;</TD></TR>  --> 
</TABLE>
<TABLE   cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD  width="580" align="right">&nbsp;</TD></TR>
 
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR valign="top"><TD width="560" align="right"><%=upperMoney2 %>(￥<%=subscription %>元)</TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD  width="140" align="right">&nbsp; </TD></TR>
  <TR><TD  width="140" align="right">&nbsp; </TD></TR>
    <TR><TD  width="140" align="right">&nbsp; </TD></TR>
	
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <%
  
  int i=0;
  String dd="";
  String kx="";
   SQL="SELECT shouldQS,shouldDate,shouldMoney*rate shouldMoney ,shouldMoney*rate/"+rmbprice+"*100 aa FROM GatheringRecord WHERE ContactNo="+code+" order by shouldQS";
   rs=ViewBean.executeQuery(SQL);
   while (rs.next()){
   if (i==0)dd="第一次";
   else if (i==1)dd="第二次";
   else if (i==2)dd="第三次";
   else if (i==3)dd="第四次";
   else if (i==4)dd="第五次";
   if (getbyte(rs.getString("shouldQS")).equals("0")) kx="定金";
   else if (getbyte(rs.getString("shouldQS")).equals("1")) kx="房款";
   else if (getbyte(rs.getString("shouldQS")).equals("2")) kx="房款";
   else if (getbyte(rs.getString("shouldQS")).equals("3")) kx="房款";
   else if (getbyte(rs.getString("shouldQS")).equals("4")) kx="房款";
   else if (getbyte(rs.getString("shouldQS")).equals("5")) kx="花园/露台款";
   else if (getbyte(rs.getString("shouldQS")).equals("6")) kx="改装款";
   %>
  <TR><TD  width="50">&nbsp;</TD> <TD ><%=dd %>交款时间：<%=rs.getDate("shouldDate").toString() %>，款项名称:<%=kx %>，交款金额:￥<%=Format.getFloat3(rs.getDouble("shouldMoney"),2) %>元<%if (!kx.equals("花园/露台款")){ %>,占总房款的<%=Format.getFloat3(rs.getDouble("aa"),2) %>%<%} %>；
  
  
  </TD></TR>
  <%i++;}
  rs.close();
  if (payment1.indexOf("按揭")>=0){
   %>
   <TR><TD  width="50">&nbsp;</TD> <TD >其余的款项目金额￥<%=ajmoney %>，占总房款的<%=ajrate %>%，由银行提供<%=ajyear %>年按揭。
   </TD></TR>
   <%} %>
</TABLE>
 
 
 
</td>
<td width="160">&nbsp;</td>
<td  valign="top">
 
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD width="150" >&nbsp;</TD>
  <TD width="260" >&nbsp;</TD>  <TD width="160" align="right">&nbsp;</TD>
  </TR>
 
</TABLE>
</td></tr>
  </table> 
 <% String printrg=getbyte1(request.getParameter("printrg"));
 	 if (!printrg.equals(""))
	 {String   SQL1="UPDATE ORDER_CONTRACT SET printrg=1 where code="+code;
     ViewBean.executeUpdate(SQL1);
	  %>
	   <script>
	    window.printdiv.style.display='none';
		document.all.WebBrowser.ExecWB(7,1);
		window.printdiv.style.display='block';
	   </script>
	  <% }
 %>
 
