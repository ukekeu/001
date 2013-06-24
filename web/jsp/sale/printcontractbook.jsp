<%@ page contentType="teXt/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<HTML><HEAD><TITLE>汕头市房地产买卖合同</TITLE>
<META http-equiv=Content-Type content="teXt/html; charset=GBK">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
<META content=FrontPage.Editor.Document name=ProgId>
<STYLE type=teXt/css>BODY {
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
<BODY bgColor=#ffffff>
<P align=center><B><FONT face=黑体 size=5></FONT></B></P>
<P align=center><FONT size=3>&nbsp;</FONT></P>
<script language="javascript" src="../public_js/public.js">
</script>
<DIV align=center id="printdiv">
<font size=3>
注意:在打印之前必须设置纸张及距，在菜单"文件"中选择"页面设置",<br><br>选择纸张类型"Tabloid",方向选择"横向",边距"左右为10"，上为"25"，下为"10"
</font><!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br>

  <form name=frm method="post" action="">
 
 <input type="button" name="Button1" value="第一页" onClick="prin(1);">
 <input type="button" name="Button2" value="第二页" onClick="prin(2);">
 <input type="button" name="Button3" value="第三页" onClick="prin(3);">
 <input type="button" name="Button4" value="第四页" onClick="prin(4);">
 <input type="button" name="Button5" value="第五页" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.EXecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button6" value="第六页" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.EXecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" name="Button7" value="第七页" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.EXecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button8" value="第八页" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.EXecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button9" value="第九页" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.EXecWB(7,1);window.printdiv.style.display='block'">
 </form>
  </div>
<script>
  function prin(para){
    if (para==1) {	
	openwin1('contractbook.jsp?code=<%=request.getParameter("code") %>&page='+para,500,300,300,300);
	}else{
	openwin1('contractbook.jsp?code=<%=request.getParameter("code") %>&page=2',500,300,300,300);
	openwin1('contractbook.jsp?code=<%=request.getParameter("code") %>&page=3',500,300,300,300);
	openwin1('contractbook.jsp?code=<%=request.getParameter("code") %>&page=4',500,300,300,300);
	openwin1('contractbook.jsp?code=<%=request.getParameter("code") %>&page=5',500,300,300,300);
	}
  }

</script>
 

  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<!--<object id="factory" style="display:none" viewasteXt classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
 codebase="ScriptX.cab#Version=5,60,0,360"></object>
 <OBJECT classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 id=WB width=0></OBJECT>
 <script language="JavaScript"> 
function doPrintSetup(){
//打印设置
WB.EXecWB(8,1)
}
function doPrintPreview(){
//打印预览
WB.EXecWB(7,1)
}
</script>
　-->
<br><br>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0  border="0">
 <tr><td  >
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
  border=0><TR><TD ></TD></TR>
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
  border=0><TR><TD ></TD></TR>
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
  border=0><TR><TD ></TD></TR>
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
  border=0><TR><TD ></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR>
</TABLE>
</td>
<td width="160">&nbsp;</td>
<td >
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD >&nbsp;</TD></TR>
  <TR><TD >&nbsp;</TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD >&nbsp;</TD><TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;广东龙光(集团)有限公司&nbsp;广东龙光(集团)有限公司金园分公司></TD></TR>
 
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><TD>&nbsp;</TD><TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;汕头市珠池路光明大厦八到十楼
</TD></TR>
</TABLE><TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD width="130">&nbsp;</TD><TD>(总)4405001000710&nbsp;</TD><TD>&nbsp;</TD><TD width="200">粤房开证字第1040005号</TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD width="70">&nbsp;</TD><TD align="left" width="100">&nbsp;&nbsp;&nbsp;杨定发</TD><TD  align="left" width="200">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(8888875</TD><TD   align="left" width="150" >&nbsp;&nbsp;&nbsp;88888</TD></TR>
</TABLE>
 
  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD width=114  >
	  &nbsp;</TD ><TD width=214  >X </TD ><TD width=114  >&nbsp;</TD ><TD width=214  >X</TD ></tr>
	 </table>
	 
	 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
	 <tr><TD width=114  >&nbsp;</TD ><TD width=150 >X </TD ><TD width=100>&nbsp;&nbsp;&nbsp;&nbsp;25549888</TD ><TD >&nbsp;</TD ></tr>
	    </table>
	 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
	  <tr><TD width=114  >&nbsp;</TD ><TD width=450 colspan="3">&nbsp;&nbsp;&nbsp;X </TD > </tr>
	  <tr><td  colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X</td> 
	  </tr>
	    <tr><td  colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X</td> 
	  </tr>
	  </table>
	  
	 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD  width=124>&nbsp;</td><td width=184>&nbsp;X</td><td width=114>&nbsp;</td><td>X</td> 
     </tr></table>
	  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD  width=124>&nbsp;</td><td width=184>&nbsp;X</td><td width=114>&nbsp;</td><td>X</td> 
     </tr></table>
	 <%
	 
	 String  code=request.getParameter("code");
	 //读取业主资料
	 String SQL="SELECT c.cus_name,c.phone+c.sj phone,c.id_card,c.zip_code,c.address,";
	 SQL+="o.section,o.loft,o.room_no,o.xiaoshoutype,o.floors,o.jzarea,o.area,";
	 SQL+="o.jzarea-o.area ft,o.count_type,o.rmbprice,o.tnunitprice,o.unitprice,o.payment1,o.JLdate,o.ajyear,o.ajmoney,o.ajmoney*100.0/o.rmbprice ajb from order_contract o,customer c where c.serialno=o.customer and o.code="+code;
	 ResultSet rs=InsertBean.executeQuery(SQL);
	 out.print(SQL);
	 String cus_name="",id_card="",zip_code="",phone="",address="";
	 String section="",loft="",room_no="",floors="",tnunitprice="";
	  String jzarea="",tnarea="",ft="",uppercaseMoney="",unitprice="";
	 boolean xiaoshoutype=false,count_type=false;
	 String payment1="",JLdate="",ajb="",ajmoney="",ajyear="";
	 if (rs.next()){
	    cus_name=rs.getString("cus_name");
		phone=rs.getString("phone");
		id_card=rs.getString("id_card");
		zip_code=rs.getString("zip_code");
		address=rs.getString("address");
		section=rs.getString("section");
		loft=rs.getString("loft");
		room_no=rs.getString("room_no");
		xiaoshoutype =rs.getBoolean("xiaoshoutype");
		floors=rs.getString("floors");
		jzarea=FormtD.getFloat1(rs.getFloat("jzarea"),2);
		tnarea=FormtD.getFloat1(rs.getFloat("area"),2);
		ft=FormtD.getFloat1(rs.getFloat("ft"),2);
		count_type=rs.getBoolean("count_type");
		uppercaseMoney=rs.getString("rmbprice");
		tnunitprice=FormtD.getFloat1(rs.getFloat("tnunitprice"),2);
		unitprice=FormtD.getFloat1(rs.getFloat("unitprice"),2);
		payment1=rs.getString("payment1");
		JLdate=rs.getString("JLdate");
		ajyear=rs.getString("ajyear");
		ajmoney=rs.getString("ajmoney");
		ajb=rs.getString("ajb");
		if (!JLdate.equals(""))JLdate=JLdate.substring(0,10);
	 }
	 rs.close();
	  %>
	     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><tr><td  width=124>&nbsp;</td><td  width=184>&nbsp;<%=cus_name %></td><td  width=124>&nbsp;</td><td>&nbsp;</td>
	 </tr>
  </table>
       <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD  >v&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=cus_name %></td><td  align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
  <TR><TD  >&nbsp;</td><td  align="left">&nbsp;</td></tr>
     <TR ><TD  height="25"   >&nbsp;v&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中国&nbsp;</td><td align="left" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td></tr>
  
  </table>
   
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <TR><td>&nbsp;v</td><td>&nbsp;X</td><td width=414 >X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=id_card %></td></tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <TR><td>&nbsp;</td><TD width=500 ><%=address %></td></tr>
   <TR><td>&nbsp;</td><TD width=500 >&nbsp;</td></tr>
  <TR><td>&nbsp;</td><TD width=500 ><%=zip_code %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=phone %></td></tr>
  </table>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <TR><td width=150>&nbsp;</td><TD width=500 >&nbsp;&nbsp;&nbsp;&nbsp;X</td></tr>
   </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
    <TR><td width=150 align="right">X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中国&nbsp;&nbsp;</td><TD width=500 ></td></tr>
    
	  <TR><td width=150 align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X&nbsp;&nbsp;</td><TD width=500 ></td></tr>

  </table>
       
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <TR><td width=110>&nbsp;</td><TD width=500 >X</td></tr>
  
   </table>  
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
    
  <TR><TD width=100 align="right" >X</td><TD width=200  align="right" >X</td></tr>
  </table>  
  </td>
</tr></table>
  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <TR><td width=150>&nbsp;</td><TD width=100 ></td><td width=250>&nbsp; </td><TD width=200 ></td></tr>
  </table> 
  <br><br>  <br><br>
   
  <!--2到3页-->
 

<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0  border="0">
 <tr><td  valign="top" >

     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <TR><td width=150>&nbsp;</td><TD width=100 ></td><td width=250>&nbsp; </td><TD width=200 ></td></tr>
  <TR><td width=150>&nbsp;</td><TD width=100 ></td><td width=250>&nbsp; </td><TD width=200 ></td></tr>
  
  <TR><td width=150>&nbsp;</td><TD width=100 ></td><td width=250>&nbsp; </td><TD width=200 ></td></tr>
  </table> 
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <TR><td width=150>&nbsp;</td><TD width=100 ></td><td width=250>&nbsp; </td><TD width=200 ></td></tr>
  </table> 
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <TR><td width=150>&nbsp;</td><TD width=100 ></td><td width=250>&nbsp; </td><TD width=200 ></td></tr>
  </table> 
  <%
    SQL="select  NAME,AreaNo,qddkfs,tudishiyong_no,GroundArea,Type,useyear,cq_sd,cq_ed";
	SQL+=" ,guihua_no,shigong_no,yushou_no,jiegou,chenggao,wuyei_com from section where serialno='"+section+"'";
    rs=InsertBean.executeQuery(SQL);
	String name="",GroundArea="",qddkfs="",tudishiyong_no="",Type="";
	String useyear="",cq_sd="",cq_ed="",guihua_no="",shigong_no="";
	String yushou_no="",AreaNo="",jiegou="",chenggao="",wuyei_com="";
	if (rs.next()){
	  name=rs.getString("NAME");
	  AreaNo=rs.getString("AreaNo");
	  qddkfs=rs.getString("qddkfs");
	  tudishiyong_no=rs.getString("tudishiyong_no");
	  GroundArea=FormtD.getFloat1(rs.getFloat("GroundArea"),2);
	  Type=rs.getString("Type");
	  useyear=rs.getString("useyear");
	  cq_sd=rs.getString("cq_sd");
	  cq_ed=rs.getString("cq_ed");
	  guihua_no=rs.getString("guihua_no");
	  shigong_no=rs.getString("shigong_no");
	  yushou_no=rs.getString("yushou_no");
	  jiegou=rs.getString("jiegou");
	  chenggao=rs.getString("chenggao");
	  wuyei_com=rs.getString("wuyei_com");
	}
	rs.close();
	SQL="SELECT yong_tu,useyear,s_year,e_year from room where seccode='"+section+"' and loft='"+loft+"' and room_code='"+room_no+"'";
       rs=InsertBean.executeQuery(SQL);
	   if (rs.next()){
	      Type=rs.getString("yong_tu");
		  useyear=rs.getString("useyear");
	      cq_sd=rs.getString("s_year");
	      cq_ed=rs.getString("e_year");
	   
	   }
	   rs.close();
   %>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <TR><td width=150>&nbsp;</td><TD width=100 >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=qddkfs %></td><td width=250>&nbsp; </td><TD width=200 ><%=AreaNo %></td></tr>
  </table> 
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
  <TR><td width=250 align="center">&nbsp;</td><TD width=200 >X</td></tr>
   <TR><td  colspan="2">&nbsp;</td></tr>
  </table> 


  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td width=280>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><TD width=200 >&nbsp;&nbsp;X</td></tr>
  </table> 
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td width=280>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><TD width=200 >&nbsp;&nbsp;X</td></tr>
  </table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td width=250>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v&nbsp;</td><TD width=200 ></td></tr>
  </table> 
  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td width=300 align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=tudishiyong_no %></td><TD width=200 ></td></tr>
  </table> 
  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td width=250>&nbsp;X</td><TD width=200 ></td></tr>
  <TR><td width=250>&nbsp;</td><TD width=200 ></td></tr>
    
  </table> 
 <% String a1="",a2="",a3="";
  a1=cq_sd.substring(0,4);
  a2=cq_sd.substring(6,7);
  a3=cq_sd.substring(9,10); %>
  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td width=280>&nbsp;</td><TD width=220 >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=GroundArea %></td><TD width=300 >&nbsp;</td></tr>
   <TR><td width=280>&nbsp;</td><TD width=200 >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><TD width=300 >&nbsp;</td></tr>
  <TR><td width=300>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= Type%>&nbsp;</td><TD width=100 >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=useyear %>&nbsp;&nbsp;&nbsp;
  </td><td width=200  >&nbsp;<%=a1 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <%=a2 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a3 %>
  </td> 
  </tr>
  </table> 
  <%
  
 
  a1=cq_ed.substring(0,4);
  a2=cq_ed.substring(6,7);
  a3=cq_ed.substring(9,10);
   %>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td width=300  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a1 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;<%=a2 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a3 %>
  </td>
 
  </tr>
  </table> 
    
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td width=124 >&nbsp;&nbsp;&nbsp; </td><td width=500 >&nbsp; </td>
  </tr>
   
 <TR><td width=140 >&nbsp;&nbsp;&nbsp;X </td><td width=460 >&nbsp; <%=name %></td>
  </tr>
  </table> 
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td width=184  align="center">&nbsp;&nbsp;&nbsp;&nbsp;<%=guihua_no %> </td><td  width=280>&nbsp;</td><td width=300 >&nbsp;&nbsp;&nbsp; <%=shigong_no %></td>
  
  </tr>
  </table> 
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
   <TR><td width=600 align="right" >&nbsp;&nbsp;&nbsp;</td>    </tr>
  <TR><td width=600 align="right" >&nbsp;&nbsp;&nbsp;</td>    </tr>
   <TR><td width=600 align="right" >&nbsp;&nbsp;&nbsp;</td>    </tr>
  </table> 
  <%String str1="",str2="";
   if (xiaoshoutype){str1="v";str2="X";}
   else {str1="X";str2="v";}
  
   %>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td width=314>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=str2 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=str1 %></td>
  <td width=250   >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=yushou_no %>&nbsp;&nbsp;</td>
  
  </tr>
  </table> 
 </td><td width="180">&nbsp;</td>
 <td>
  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
   <TR><td width=600 align="right" >&nbsp;&nbsp;&nbsp;</td>
  <TR><td width=600 align="right" >&nbsp;&nbsp;&nbsp;</td>
   <TR><td width=600 align="right" >&nbsp;&nbsp;&nbsp;</td>
   </table> 

     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td width=114>&nbsp;&nbsp;&nbsp;&nbsp;<%=loft %>&nbsp;&nbsp;&nbsp;</td>
  <td width=114   >&nbsp;&nbsp;&nbsp;<%=floors %>&nbsp;&nbsp;</td> <td width=114   ><%=room_no %>&nbsp;&nbsp;</td>
   <td width=114   >&nbsp; &nbsp;&nbsp;</td>
  </tr>
  </table> 
       <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=160>&nbsp;</td><td width=154><%=Type %>&nbsp;&nbsp;&nbsp;</td>
  <td width=124   ><%=jiegou %>&nbsp;&nbsp;</td>  
  </tr>
   <TR><td  width=214 colspan="3"><%=chenggao %></td> 
  </tr>
  </table> 
    
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=50>&nbsp;</td> <td  width=380 align="right">&nbsp;<%=jzarea %></td> 
  </tr>
  </table> 
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=120>&nbsp;</td> <td  width=100 >&nbsp;<%=tnarea %></td>
  <td  width=120  align="right">&nbsp;X&nbsp;&nbsp;&nbsp;&nbsp;</td>  
  </tr>
  </table> 
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=260>&nbsp;X</td> <td  width=120 >见附件图</td>
  <td  width=200  　>&nbsp;X&nbsp;&nbsp;&nbsp;&nbsp;</td>  
  </tr>
  <TR><td  width=160>&nbsp;</td> <td  width=120 ><%=ft %></td>
  <td  width=200  　>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>  
  </tr>
    <TR><td  width=300>&nbsp;</td> <td  width=120 ></td>
  <td  width=200  　>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>  
  </tr>
  </table><TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=200>&nbsp;</td> <td  width=314 >&nbsp;</td></tr>
  </table><TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width=500>&nbsp; </td></tr>
  <TR><td  width=500>&nbsp;<%=wuyei_com %></td></tr>
  </table> 
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=500>&nbsp;</td></tr> <TR><td  width=500>&nbsp;</td></tr>
  </table> 
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=500>&nbsp;</td></tr>
  </table> 
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=500>&nbsp;</td></tr>
  </table> 
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=500>&nbsp;</td></tr>
  </table> 
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=500>&nbsp;</td></tr>
  </table> 
   <%
   //计算方式
   String fs="";
   if (count_type)fs="3";
   else fs="1";
    %>  
       <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
   <TR><td  width=250>&nbsp;</td><td  width=300><%=fs %>&nbsp;</td></tr>
  <TR><td  width=300>&nbsp;</td><td  width=300>&nbsp;</td></tr>
  <TR><td  width=280>&nbsp;</td><td  width=300>&nbsp;</td></tr>
  </table> 
       <%	
	   String p1="X",p2="X",p3="X",p4="X",p5="X",p6="X",p7="X",p8="X";
	   String uppercaseMoney1="";
	  String upperMoney="";
		ResultSet execRs=InsertBean1.executeQuery("exec dbo.L2U "+uppercaseMoney+",1 ");//大写金额转换存储过程
             if (execRs.next())
				upperMoney=getbyte(execRs.getString("dd"));
				execRs.close();
				if (upperMoney.indexOf("角")>0){
				  upperMoney=upperMoney.substring(0,upperMoney.length()-1);
				  upperMoney=upperMoney.substring(0,upperMoney.indexOf("角")-1)+"零"+upperMoney.substring(upperMoney.indexOf("角")-1);
			 } 
			 upperMoney=upperMoney.substring(0,upperMoney.indexOf("元")+1);
		  if (!count_type){ 
		  if (upperMoney.length()==12){
		   for (int ii=1;ii<12;ii++){
		      if (ii==1)
		      p3= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p4= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p5= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p6= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p7= upperMoney.substring(ii-1,ii);  
			   if (ii==11)
		      p8= upperMoney.substring(ii-1,ii);  
		   }
		  }else  if (upperMoney.length()==14){
		   for (int ii=1;ii<14;ii++){
		      if (ii==1)
		      p1= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p2= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p3= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p4= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p5= upperMoney.substring(ii-1,ii);  
			   if (ii==11)
		      p6= upperMoney.substring(ii-1,ii);  
			     if (ii==13)
		      p7= upperMoney.substring(ii-1,ii);  
		   }
		   }else  if (upperMoney.length()==16){
		   for (int ii=1;ii<16;ii++){
		      if (ii==1)
		      p1= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p2= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p3= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p4= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p5= upperMoney.substring(ii-1,ii);  
			   if (ii==11)
		      p6= upperMoney.substring(ii-1,ii);  
			     if (ii==13)
		      p7= upperMoney.substring(ii-1,ii);  
			      if (ii==15)
		      p8= upperMoney.substring(ii-1,ii); 
		   }
		  }
		  
		 %> 
       <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=300>&nbsp;</td><td  width=200>&nbsp;人民币</td></tr>
  </table> 
         <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=100>&nbsp;<%=tnunitprice %></td><td  width=154 align="center">&nbsp;人民币</td><td  width=80>&nbsp;<%=p1 %></td>    <td  width=40><%=p2 %></td>
       <td  width=40>&nbsp;<%=p3 %></td>      <td  width=80>&nbsp;<%=p4 %></td></tr>
  </table> 
         <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=500 
  border=0> <TR><td  width=80>&nbsp;<%=p5 %></td><td  width=80>&nbsp;<%=p6%></td><td  width=80>&nbsp;<%=p7 %></td>    <td  width=80>&nbsp;<%=p8 %></td>
       <td  width=200>&nbsp;</td>      <td  width=200>&nbsp;</td> </tr>
  </table> 
     <%}else{ %>
	    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=300>&nbsp;</td><td  width=200>&nbsp;人民币</td></tr>
  </table> 
         <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=100>&nbsp;X</td><td  width=154>&nbsp;X</td><td  width=80>&nbsp;X</td>    <td  width=80>&nbsp;X</td>
       <td  width=80>&nbsp;X</td>      <td  width=80>&nbsp;X</td></tr>
  </table> 
         <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=80>&nbsp;X</td><td  width=80>&nbsp;X</td><td  width=80>&nbsp;X</td>    <td  width=80>&nbsp;X</td>
       <td  width=200>&nbsp;</td>      <td  width=200>&nbsp;</td> </tr>
  </table> 
  <%} %>
         <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=180>&nbsp;</td><td  width=180>&nbsp;X</td>    
  </tr>
  <TR><td  width=150>&nbsp;</td><td  width=180>&nbsp;</td>    
  </tr>
  </table> 
  </td></tr></table>
  <br><br>  
  <!--4到5页-->
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0  border="0">
 <tr><td  valign="top" > 
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width="400">&nbsp </td><td  width="200">&nbsp </td></tr>
<TR><td  width="400">&nbsp </td><td  width="200">&nbsp </td></tr>
<TR><td  width="400">&nbsp </td><td  width="200">&nbsp </td></tr>

  </table> 
	 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width=210 align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<b>X</b></td><td  width=154 align="center">X</td>  
  <td  width=140>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X</td>  <td  width=104>&nbsp;&nbsp;&nbsp;X</td>  <td  width=104>X</td>    
  </tr>
 <tr><td colspan="5"><table style="LINE-HEIGHT: 180%"><tr><td width="90" align="right">&nbsp;X</td>
 <td width="90" align="right">&nbsp;X</td><td width="90" align="right">&nbsp;X</td>
 <td width="90" >&nbsp;X</td><td width="90">&nbsp;X</td>
 <td width="90">&nbsp;X</td><td width="90">&nbsp;</td><td width="90">&nbsp;</td>
 </tr></table></td></tr>
  </table> 
   <% if (count_type){  %>  
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400" colspan="3">&nbsp </td><td  width="200">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>人民市</b></td>
  </tr>
  <TR><td  width="100">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<%=unitprice %></td><td  width="200">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;人民市</td>
  <td  width=100">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=p1 %></td>  <td  width=100">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=p2 %></td> <td  width=100"><%=p3 %></td>
   <td  width=100"><%=p4 %></td>
  </tr>
   <TR><td colspan="6">
   <table width="400">
   <tr><td  width="180">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=p5 %></td>  <td  width="180">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=p6 %></td> <td  width="180">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=p7 %></td>
   <td  width="180">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=p8 %></td>   <td  width="350">&nbsp; </td>

  </table>
  <td></tr>
  </table> 
  <%}else{ %>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400" colspan="3">&nbsp </td><td  width="200">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
   <TR><td  width="400" colspan="3">&nbsp </td><td  width="200">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>人民市</b></td>
  </tr>
  <TR><td  width="150" align="center">&nbsp; &nbsp;&nbsp;X</td><td  width="250">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;人民市</td>
  <td  width=120">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X</td>  <td  width=100">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;零</td> <td  width=100">&nbsp;X</td>
   <td  width=100">&nbsp;X</td>
  </tr>
   <TR><td colspan="6">
   <table width="400">
   <tr><td  width="180">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; X</td>  <td  width="180">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X</td> <td  width="180">&nbsp; &nbsp;&nbsp;&nbsp;X</td>
   <td  width="180"> &nbsp;&nbsp;&nbsp;X</td>   <td  width="350">&nbsp; </td>

  </table>
  <td></tr>
  </table> 
 <%} %> 
	
	 
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width="400">&nbsp </td><td  width="200">&nbsp </td>
  </tr>
  </table> 
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width="400">&nbsp </td><td  width="200">&nbsp </td>
  </tr>
  </table> 
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> <TR><td  width="400">&nbsp </td><td  width="200">&nbsp </td>
  </tr>
  </table> 
    
 
</td><td width="180">&nbsp;</td>
<td>
 <%
 String pa1="X",pa2="X",pa3="X";
 if (payment1.indexOf("一次")>=0){pa1="v";pa2="X";pa3="X";}
 else if (payment1.indexOf("分期")>=0){pa2="v";pa1="X";pa3="X";}
 else {pa1="X";pa2="X";pa3="v";}
  %>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0>
   <TR><td  width="70"> &nbsp;</td><td  width="80">&nbsp;</td><td  width="180">&nbsp;</td>
  </tr>
 <TR><td  width="70"> &nbsp;</td><td  width="80">&nbsp;</td><td  width="180">&nbsp;</td>
  </tr>
   <TR><td  width="70"> &nbsp;</td><td  width="80">&nbsp;</td><td  width="180">&nbsp;</td>
  </tr>
   <TR><td  width="70"> &nbsp;&nbsp;&nbsp;<%=pa1 %></td><td  width="80">&nbsp; &nbsp;&nbsp;&nbsp; <%=pa2 %></td><td  width="180">&nbsp;  &nbsp;&nbsp;&nbsp;<%=pa3 %></td>
  </tr>
  </table>
  <%
  //违约条款
   a1="";
  a2="";
  a3="";
 String a4="";
 String a5="";
 String a6="";
 String a7="";
 String a8="";
 String a9="";
 String a10=""; 
 String a11="";
 String a12="";
 String a13="";
 String a14="";
 String a15="";
 String bak1="";
 String bak2="";
 String bak3="";
 String bak4="";
 String bak5="";
 String bak6="";
 String bak7="";
 String bak8="";
 String bak9="";
 String bak10="";
 String bak11="";
 String bak12="";
 String bak13="";
 String bak14="";
 
  String bak15="";
 String bak16="";
 String bak17="";
 String bak18="";
 String bak19="";
  String bak20="";
 String bak21="";
   String choose1="1";
   String choose2="1";
   String choose3="1";
    String choose4="1";
  String wy="select * from contractWYTK  where sectionno='"+section+"'";
      rs=InsertBean.executeQuery(wy);
 if (rs.next()){
   a1=getbyte(rs.getString("a1"));
   a2=getbyte(rs.getString("a2"));
   a3=getbyte(rs.getString("a3"));
   a4=getbyte(rs.getString("a4"));
   a5=getbyte(rs.getString("a5"));
   a6=getbyte(rs.getString("a6"));
   a7=getbyte(rs.getString("a7"));
   a8=getbyte(rs.getString("a8"));
   a9=getbyte(rs.getString("a9"));
   a10=getbyte(rs.getString("a10"));
   a11=getbyte(rs.getString("a11"));
   a12=getbyte(rs.getString("a12"));
   a13=getbyte(rs.getString("a13"));
   a14=getbyte(rs.getString("a14"));
   a15=getbyte(rs.getString("a15"));
   bak1=getbyte(rs.getString("bak1"));
   bak2=getbyte(rs.getString("bak2"));
   bak3=getbyte(rs.getString("bak3"));
   bak4=getbyte(rs.getString("bak4"));
   bak5=getbyte(rs.getString("bak5"));
   bak6=getbyte(rs.getString("bak6"));
   bak7=getbyte(rs.getString("bak7"));
     bak8=getbyte(rs.getString("bak8"));
   bak9=getbyte(rs.getString("bak9"));
   
     bak10=getbyte(rs.getString("bak10"));
   bak11=getbyte(rs.getString("bak11"));
   bak12=getbyte(rs.getString("bak12"));
   bak13=getbyte(rs.getString("bak13"));
   bak14=getbyte(rs.getString("bak14"));
   bak15=getbyte(rs.getString("bak15"));
   bak16=getbyte(rs.getString("bak16"));
   bak17=getbyte(rs.getString("bak17"));
   bak18=getbyte(rs.getString("bak18"));
   bak19=getbyte(rs.getString("bak19"));
     bak20=getbyte(rs.getString("bak20"));
   bak21=getbyte(rs.getString("bak21"));
   choose1=getbyte(rs.getString("choose1"));
   choose2=getbyte(rs.getString("choose2")); 
   choose3=getbyte(rs.getString("choose3"));
    choose4=getbyte(rs.getString("choose4"));
 }
rs.close();
  
   %>
  <%String ajstr="";
  String ajstr1="";
  String ajstr2="";
  if (payment1.indexOf("按揭")<0)bak1="";
  else{ ajstr="按揭:买受人就在　　　　　　　前付给出卖人上述总房款的"+",计";
  ajstr1=uppercaseMoney+"元;对剩余的"+ajb+"总房款，计￥"+ajmoney+"元(由银行提供"+ajyear+"年按揭)，";
  ajstr2="买受人应授权或指定按揭银行于             前付给出卖人。";
  }
  
   %>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
   <TR><td  width="70"> &nbsp;</td><td  > &nbsp;</td>
  </tr>
  <TR><td  width="50"> &nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;<%=ajstr %> </td> </tr>
  <TR><td  width="50"> &nbsp;</td><td>&nbsp;<%=ajstr1 %> </td> </tr>
  <TR><td  width="50"> &nbsp;</td><td>&nbsp;<%=ajstr2 %>  </td> </tr>

  <TR><td  width="70"> &nbsp;</td><td>&nbsp; <%=bak10 %></td> </tr>
  <TR><td  width="70"> &nbsp;</td><td>&nbsp; <%=bak15 %></td> </tr>
   <TR><td  width="70"> &nbsp;</td><td > &nbsp;<%=bak16 %></td>
  </tr>
    <TR><td  width="70"> &nbsp;</td><td>&nbsp; </td> </tr>
  </table>
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
    <TR><td>&nbsp;&nbsp;</td> </tr><TR><td>&nbsp; </td> </tr>
   <TR><td>&nbsp;&nbsp;X</td> </tr><TR><td>&nbsp; </td> </tr>
  
  </table>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width=354 >&nbsp; X</td> <td  width=250 >&nbsp; X</td> </tr>
  
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td>&nbsp; </td> </tr><TR><td>&nbsp; </td> </tr>
    
  </table>
  
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td align="right"  width=480 >&nbsp; <%=choose1 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr>
    
  </table>
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td align="right">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr>
    
  </table>
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 

     <TR><td align="right">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr>
    
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td width="100">  &nbsp; </td><td>&nbsp;&nbsp;&nbsp;<%=a1 %>&nbsp;&nbsp;</td> </tr> 
    <TR><td width="100">  &nbsp; </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr> 
  </table>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td width="150">  &nbsp; </td><td>&nbsp;&nbsp;&nbsp;&nbsp;<%=a2 %>&nbsp;</td> </tr> 
  
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="100">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td  width="400">&nbsp;&nbsp;&nbsp;<%=a3 %> &nbsp;&nbsp;</td> </tr>
  
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="300" align="right">&nbsp; &nbsp;&nbsp;<%=a4 %></td><td  width="220">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr>
  
  </table>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="320">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td  width="200">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr>
  
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=530 
  border=0> 
<TR><td align="right" ><table><tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a5 %>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></table>  </td> </tr>
  
  </table>
 </td></tr></table>
  <!--6到7页-->
  <br><br><br><br>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0  
  border=0> <tr><td valign="top">
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr>
  <TR><td>&nbsp; </td> </tr>
   <TR><td>&nbsp; </td> </tr>
    <TR><td>&nbsp;</td> </tr>
		
  </table>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr>
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><TD width="100">&nbsp;</TD><td >&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=bak1 %></td> </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr>
  </table>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr>
  
  </table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <% a1=JLdate.substring(0,4);
  a2=JLdate.substring(6,7);
  a3=JLdate.substring(9,10); %>
  <tr><td width="270">&nbsp;</td><td width="200" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a1 %></td>
  <td width="100">&nbsp;&nbsp;<%=a2 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a3 %></td><td width="100" align="left">&nbsp;</td>
  <td width="200">&nbsp;</td>
  </tr>
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <tr><td width="420" align="right">&nbsp;1</td><td width="100" align="center">&nbsp;</td>
  
  </tr>
  </table>
 
  <table>
  <tr><td width="300">&nbsp;</td><td width="300">&nbsp;</td>
  
  </tr>
  </table> 
  <table width="614">
   <TR><td>  
  <tr><td width="314" align="right">&nbsp;v</td><td width="300">&nbsp;</td>
   </tr>
  </table>
   
  <table width="614">
  <tr><td width="360" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X</td><td >&nbsp;</td>
  
  </tr>
 </table>
  <table width="614">
  <tr><td width="440" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X</td><td width="200">&nbsp;</td>
  
  </tr>
  <tr><td width="420" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td width="280" align="right">X&nbsp;</td>
  
  </tr>
 
  </table>
  
  <table width="614">
  <tr><td width="300" align="right">&nbsp;</td><td width="300">&nbsp;</td>
 </tr>
   </table>
    <table width="614">
  <tr><td width="300" align="right">&nbsp;</td><td width="300">&nbsp;</td>
 </tr>
   </table>
    <table width="614">
  <tr><td width="500" align="right">&nbsp;30</td> 
 </tr>
   </table>
     <table width="614">
	 <tr><td  width="100" >&nbsp;&nbsp; </td><td  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
 </tr>
  <tr><td  width="100" >&nbsp;&nbsp; </td><td  >&nbsp;&nbsp;&nbsp;&nbsp;</td>
 </tr>
  <tr><td  width="100" >&nbsp;&nbsp; </td><td  >&nbsp;&nbsp;<%=bak18 %> </td>
 </tr>
  </table>  <table width="614">
  <tr><td  width="100" >&nbsp;&nbsp; </td><td  >&nbsp;&nbsp;<%=bak19 %> </td>
 </tr>
  </table>
  <table width="614">
 
  <tr><td width="350"  >&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td width="300">&nbsp;</td>
 </tr>
  </table>
  <table width="550">
  <tr><td align="right"  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=choose2 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
  </table>
 </td><td width="180">&nbsp;</td>
 <td>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td align="right">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr><TR><td>&nbsp </td> </tr>
  <TR><td align="right">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr><TR><td>&nbsp </td> </tr>

    </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR> <td width="150" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a6 %></td><td width="300">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
  <TR><td width="150"  align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td width="300">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
  <TR><td width="150"  align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td width="300">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>

 <TR><td width="140" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a7 %></td><td width="300"></td></tr>
 <TR><td width="140">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a8 %></td><td width="300"></td></tr>
  </table>
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=540 
  border=0> 
  <TR><td align="right">&nbsp;&nbsp;<%=a9 %>&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr>
  
  </table>
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="350">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
  <td  width="390">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a10 %></td> 
  </tr>
  
  </table>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="480">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
   <TR><td align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> </tr><TR><td>&nbsp </td> </tr>

  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="490" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a11 %>ff</td> 
     </tr><TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;<%=bak2 %>&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
    
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
   <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
   <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  <TR><td  width="600" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
  </td></tr>
  </table>
  <!--8到9页-->
  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 
  border=0> <tr><td>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
  </table>
 
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td   >&nbsp; &nbsp;&nbsp; &nbsp;&nbsp &nbsp;&nbsp; &nbsp;<%=bak5 %></td> 
     </tr>
	  <TR><td   >&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;<%=bak20 %></td> 
     </tr>
	  <TR><td   >&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;<%=bak21 %></td> 
     </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td   >&nbsp; &nbsp;&nbsp; &nbsp;&nbsp &nbsp;&nbsp; &nbsp;<%=bak6 %></td> 
     </tr>
	 <TR><td   >&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="230" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;<%=choose4 %>&nbsp;</td> 
     </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="200" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="200" align="right">&nbsp &nbsp;&nbsp;<%=bak8 %></td> 
     </tr>
	 <TR><td  width="200" align="right">&nbsp &nbsp;&nbsp;<%=bak9 %><</td> 
     </tr>
  </table>
  
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="200" align="right">X&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   <TR><td  width="200" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  </table>
   
   <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="200" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
  </table>
    </td>
	<td width="180">&nbsp;</td>
	<td>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="200" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
  </table>
  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="200" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="200" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
  </table>
  <%
  String gg="select * from loft_zhuangxiu where SECNO='"+section+"' and loft='"+loft+"'";
 rs=InsertBean.executeQuery(gg);
 String b1="X",b2="X",b3="X",b4="X",b5="X",b6="X",b7="X",b8="X";
 String waiqiang="",nieqing="",dingpeng="",dimian="",mengchuang="",chufang="",wc="",yangtai="",dianti="";
 String other="",fentanshoming="";
 if (rs.next()){
 
 
   waiqiang=getbyte(rs.getString("waiqiang"));
   nieqing=getbyte(rs.getString("nieqing"));
    dingpeng=getbyte(rs.getString("dingpeng"));
	dimian=getbyte(rs.getString("dimian"));
	mengchuang=getbyte(rs.getString("mengchuang"));
	chufang=getbyte(rs.getString("chufang"));
	wc=getbyte(rs.getString("wc"));
	yangtai=getbyte(rs.getString("yangtai"));
	dianti=getbyte(rs.getString("dianti"));
	other=getbyte(rs.getString("other"));
   fentanshoming=getbyte(rs.getString("fentanshoming"));
   b1=getbyte(rs.getString("gonggongsheshi1"));
   b2=getbyte(rs.getString("gonggongsheshi2"));
   b3=getbyte(rs.getString("gonggongsheshi3"));
   b4=getbyte(rs.getString("gonggongsheshi4"));
   b5=getbyte(rs.getString("gonggongsheshi5"));
   b6=getbyte(rs.getString("gonggongsheshi6"));
   b7=getbyte(rs.getString("gonggongsheshi7")); 
   b8=getbyte(rs.getString("gonggongsheshi8")); 
 }
   %>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="120" align="right">&nbsp;<%=b1 %>&nbsp &nbsp;</td> 
     </tr>
   </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="120" align="right">&nbsp;<%=b2 %>&nbsp &nbsp;</td> 
     </tr>
	 
 
  <TR><td  width="120" align="right">&nbsp;<%=b3 %>&nbsp;&nbsp;</td> 
     </tr>
	 
  
  <TR><td  width="120" align="right">&nbsp;<%=b4 %>&nbsp;&nbsp;</td> 
     </tr>
	 <TR><td  width="120" align="right">&nbsp;<%=b5 %>&nbsp;&nbsp;</td> 
     </tr>
  </table>
    
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="100" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	<TR><td  width="100" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	
  </table>
  <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="100" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
	
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
   <TR><td  width="120" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  <TR><td  width="120" align="right">&nbsp;<%=b6 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 <TR><td  width="120" align="right">&nbsp;<%=b7 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  </table>
     <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="380" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="360" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a12 %>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
  </table>
    <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
  </table>
      <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="180" align="right">&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<%=choose3 %>&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 
  </table>
 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=a13 %>&nbsp;&nbsp;</td> 
     </tr>
	  <TR><td  width="600" align="right">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
</table>

 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td><%=a13 %>&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="450" align="right" >&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<%=a14 %>&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=bak3 %> </td> 
     </tr>
	  <TR><td   >&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
</table>
</td></tr>
</table>
<!--10到11页-->
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0  
  border=0> <tr><td>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>

 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
</table>

 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
   <TR><td   align="CENTER" width="100">&nbsp;&nbsp;&nbsp;</td> <td   align="CENTER" width="500">&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  <TR><td   align="CENTER" width="100">&nbsp;&nbsp;&nbsp;</td> <td   align="left" width="500">&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  <TR><td   align="CENTER" width="100">&nbsp;&nbsp;&nbsp;</td> <td   align="left" width="500"><%=bak4 %>&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
  <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;<%=bak11 %></td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;<%=bak12 %></td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400" align="center" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=bak13 %></td> 
     </tr>
	 <TR><td  width="400" align="center" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400" align="center" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=bak14 %></td> 
     </tr>
	
</table>

 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="470" align="right" >&nbsp;&nbsp;<%=Type %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="350" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="3500" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="350" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="350" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
</td><td width="180">&nbsp;</td>
<td>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>  
	
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="150" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="150" align="right" >&nbsp;<%=bak7 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="150" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  <TR><td  width="150" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>  
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	    <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>  
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	    
</table>
<%String paystr="2";
if (payment1.indexOf("一次性")>=0)paystr="1";
 %>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="330" align="right" ><%=paystr %>&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>  
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="450" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400" align="right" >17&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="520"  >&nbsp;&nbsp;&nbsp;汕头市龙湖区土地房产交易所</td> 
     </tr>
	   
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400"  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400"  >&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
</table>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="400"  >&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   
</table>
</td>
 
</tr>
</table>
<!--12 到13页-->
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0  
  border=0> <tr><td>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500"   >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;汕头市龙湖区土地房产交易所 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
</td><td width="180">&nbsp;</td>
<td>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table> 
</td>
</tr></table>

<!--14 到15页-->
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0  
  border=0> <tr><td>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500"   >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=fentanshoming %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>

</td><td width="180">&nbsp;</td>
<td>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	<TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	<TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	<TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    ><%=waiqiang %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    ><%=nieqing %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    ><%=dingpeng %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    ><%=dimian %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
 <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    ><%=mengchuang %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
 <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    ><%=chufang %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    ><%=wc %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
 <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    ><%=yangtai %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
 <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    ><%=dianti %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	 <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	   <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
  <TR><td   width="100"  >&nbsp;&nbsp; </td> <td    ><%=other %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
</td>
</tr></table>

<!--16页-->
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0  
  border=0> <tr><td>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
<%
  SQL="select * from GatheringTaxRecord where taxname_type=0 and  ContactNo="+code;
    rs=InsertBean.executeQuery(SQL);
	

 %>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
   <TR><td  width="500"   >&nbsp;&nbsp;&nbsp;除本合同第四条约定的商品房价款外，买受人还应于付商品房首期价款的同时向</td> 
     </tr>
	 <TR><td  width="500"   >出卖人支付以下配套费:</td> 
     </tr>
  <%while (rs.next()){ %>
  <TR><td  width="500"   >&nbsp;&nbsp;&nbsp;<%=rs.getString("TaxName") %><%=FormtD.getFloat1(rs.getFloat("TaxMoney"),2) %>元</td> 
     </tr>
	  
	  <%}rs.close();
    %>
	<%
  SQL="select sum(TaxMoney) TaxMoney from GatheringTaxRecord where taxname_type=1 and  ContactNo="+code;
    rs=InsertBean.executeQuery(SQL);
	if (rs.next()){

 %>  
   <TR><td  width="500"   >&nbsp;&nbsp;&nbsp; 代收政府有关部门收取税费为:<%=FormtD.getFloat1(rs.getFloat("TaxMoney"),2) %>元</td> 
     </tr>
	 <%}rs.close(); %>
</table>
 <TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0> 
  <TR><td  width="500" align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
     </tr>
	  
</table>
</td>
<td></td>

<td></td>
</tr></table>