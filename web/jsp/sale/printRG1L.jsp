 
<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/checktime.jsp"%>
<HTML><HEAD><TITLE>�Ϲ����״�</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
<META content=FrontPage.Editor.Document name=ProgId>
<STYLE type=text/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 10pt; FONT-FAMILY: ����
}
TABLE {
	FONT-SIZE: 10pt; HEIGHT: 31pt; FONT-FAMILY: ����
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
	FONT-SIZE: 9pt; FONT-FAMILY: "����"
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
String SQL="SELECT o.SerialNo,o.yong_tu,o.code,c.cus_name,c.phone,c.sj,c.id_card,c.address,o.sectionname,o.loft,o.room_no,";
        SQL+="o.payment1,o.ajmoney,o.ajmoney*1.0/o.rmbprice*100 ajrate,o.ajyear,o.rmbprice,(o.rmbprice-o.ajmoney)/o.rmbprice*100.0 firstrate,o.ajmoney/o.rmbprice*100.0 ajrate,o.rmbprice-o.ajmoney first,o.area,o.jzarea,o.jzarea-o.area ftarea,o.room_sumprice/o.area ";
		SQL+="tnunitprice,o.room_sumprice/o.jzarea jzunitprice,o.room_sumprice,o.subscription,";
		SQL+="o.lu_tai_area,o.lu_tai_area_price,o.lu_tai_area*o.lu_tai_area_price luprice";
		SQL+=",o.gaizhang_area,o.gaizhang_unitprice,o.gaizhang_area*o.gaizhang_unitprice gzprice,o.room_sumprice+o.lu_tai_area*o.lu_tai_area_price+o.ty_area*o.ty_area_price  sump ";
		
		SQL+=",o.wd_area,o.ty_area,o.ty_area_price,o.ty_area*o.ty_area_price  typrice FROM ORDER_CONTRACT o,customer c WHERE o.state<>3 and o.customer=c.serialno ";
		SQL+=" and o.loft='"+loft+"' and o.section='"+secno+"' and room_no='"+roomno+"'";// and floors="+floors;
   
   String ajyear="",ajmoney="",firstrate="",first="",ajrate="";
     String ty_area_price="0",typrice="0";
	    String ty_area="0";
   String cus_name="",phone="",sj="",sectionname="",id_card="",code="";
   String room_no="",area="",jzarea="",ftarea="",tnunitprice="",subscription="";
   String gaizhang_area="",gaizhang_unitprice="",gzprice="",address="",payment1="";
   String jzunitprice="",room_sumprice="",lu_tai_area="",lu_tai_area_price="",luprice="";
   String rmbprice="",yong_tu="",sump="",SerialNo="";
   float wd_area=0;
    ResultSet rs=ViewBean.executeQuery(SQL);
  
 
	if (rs.next()){
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
	   sump   =Format.getFloat3(rs.getDouble("sump"),3);
	     wd_area =rs.getFloat("wd_area");
	   	   ty_area =rs.getString("ty_area");
	   ty_area_price=rs.getString("ty_area_price");
	   typrice =Format.getFloat3(rs.getDouble("typrice"),2);
	
	
	}
	rs.close();
    String upperMoney="";
    ResultSet execRs=ViewBean.executeQuery("exec dbo.L2U "+sump+",0 ");//��д���ת���洢����
             if (execRs.next())
				upperMoney=getbyte(execRs.getString("dd"));
				execRs.close();
				
 
	String upperMoney1="";
	
 
       execRs=ViewBean.executeQuery("exec dbo.L2U "+gzprice+",0 ");//��д���ת���洢����
             if (execRs.next())
				upperMoney1=getbyte(execRs.getString("dd"));
				execRs.close();
				
	
	String upperMoney2="";
	
       execRs=ViewBean.executeQuery("exec dbo.L2U "+subscription+",0 ");//��д���ת���洢����
             if (execRs.next())
				upperMoney2=getbyte(execRs.getString("dd"));
				execRs.close();
				/*if (upperMoney2.indexOf("��")>0){
				  upperMoney2=upperMoney2.substring(0,upperMoney2.length()-1);
				  upperMoney2=upperMoney2.substring(0,upperMoney2.indexOf("��")-1)+"��"+upperMoney.substring(upperMoney.indexOf("��")-1);
			 }  */
  
    
 %>
 
<BODY bgColor=#ffffff>
<P align=center><B><FONT face=���� size=5></FONT></B></P>
<P align=center><FONT size=3>&nbsp;</FONT></P>
<form name=frm method="post">
<input type=hidden name=printrg value="ok">
<DIV align=center id="printdiv">
<font size=3>
ע��:�ڴ�ӡ֮ǰ��������ֽ�ţ����"��ӡԤ��"���ٵ��"��ӡ"�ҵ�"ͼ��"��ѡ��,<br><br>ѡ��ֽ������"A3",����ѡ��"����",��24���ң�10,�ϣ�24.69����:30</font><!--<input class="buttoninput" type="button" value="��ӡԤ��" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
</font><!--<input class="buttoninput" type="button" value="��ӡԤ��" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="submit" name="submit1" value="��ӡԤ��">
 </div>
  </form>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 
 
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR valign="top"><TD width=635  align="right" ><%=SerialNo %></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=630 
  border=0><TR valign="top"><TD width=625  align="right" ><%//=SerialNo %></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR>
</TABLE>
 
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR>
</TABLE>

<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR valign="bottom"><TD  width="80"></TD><TD width="250" >&nbsp;<%=cus_name %></TD><TD width="250" ><%=address %></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR valign="bottom"><TD  width="80"></TD><TD width="250" >&nbsp;<%=phone %>&nbsp;<%=sj %></TD><TD width="250" >&nbsp;<%=id_card %></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD ></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD >&nbsp;</TD></TR><TR><TD >&nbsp;</TD></TR><TD >&nbsp;</TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD >&nbsp;</TD></TR><TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR> <TD width="100" >&nbsp;</TD>
  <TD  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��<%=loft %>&nbsp;<%=room_no %>�ŷ�����;Ϊ<%=yong_tu %>,Ŀǰ�ݲ����ڽ������Լ��<%=area %>M<sup>2</sup>�����׽������Ϊ��<%=jzarea %>M<sup>2</sup>����̯���Ϊ��<%=ftarea %>M<sup>2</sup>��
   ���ڽ���������ۣ� <%=tnunitprice %>Ԫ/M<sup>2</sup>��¶̨���Ϊ��<%=lu_tai_area %>M<sup>2</sup>��¶̨���ۣ�<%=lu_tai_area_price %>Ԫ/M<sup>2</sup>����԰���Ϊ��<%=ty_area %>M<sup>2</sup>����԰���ۣ�<%=ty_area_price %>Ԫ/M<sup>2</sup>��<%if (wd_area>0){ %>���������<%=wd_area %>M<sup>2</sup><%} %>(��԰/¶̨/����������Ʋ�Ȩ���),�ϼ������:<%=upperMoney %>(Сд��<%=sump %>Ԫ)
  </TD</TR>
 
</TABLE>
<TABLE   cellSpacing=0 cellPadding=0 width=614 
  border=0><TR><TD  width="580" align="right">&nbsp;</TD></TR>
 
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR valign="top"><TD width="390" align="right"><TR valign="top"><TD width="390" align="right"></TR>
 <TR valign="bottom"><TD width="385" align="right"><%=upperMoney2 %>
</TABLE>
 
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0 ><TR valign="top"><TD width="390" align="right"><%//=upperMoney2 %><!--(��<%//=subscription %>Ԫ)--></TD></TR>
</TABLE>
<TABLE style="LINE-HEIGHT: 180%" cellSpacing=0 cellPadding=0 width=614 
  border=0><TR valign="top"><TD width="410" align="right"><%//=upperMoney2 %>
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
  border=0>
  <%
  
  int i=0;
  String dd="";
  String kx="";
   SQL="SELECT shouldQS,shouldDate,shouldMoney*rate shouldMoney ,shouldMoney*rate/"+rmbprice+"*100 aa FROM GatheringRecord WHERE ContactNo="+code+" order by shouldQS";
   rs=ViewBean.executeQuery(SQL);
   while (rs.next()){
   if (i==0)dd="��һ��";
   else if (i==1)dd="�ڶ���";
   else if (i==2)dd="������";
   else if (i==3)dd="���Ĵ�";
   else if (i==4)dd="�����";
   if (getbyte(rs.getString("shouldQS")).equals("0")) kx="����";
   else if (getbyte(rs.getString("shouldQS")).equals("1")) kx="����";
   else if (getbyte(rs.getString("shouldQS")).equals("2")) kx="����";
   else if (getbyte(rs.getString("shouldQS")).equals("3")) kx="����";
   else if (getbyte(rs.getString("shouldQS")).equals("4")) kx="����";
   else if (getbyte(rs.getString("shouldQS")).equals("5")) kx="��԰/¶̨��";
   else if (getbyte(rs.getString("shouldQS")).equals("6")) kx="��װ��";
   %>
  <TR><TD width="50" >&nbsp;</TD><TD ><%=dd %>����ʱ�䣺<%=rs.getDate("shouldDate").toString() %>����������:<%=kx %>��������:��<%=Format.getFloat3(rs.getDouble("shouldMoney"),2) %>Ԫ<%if (!kx.equals("��԰/¶̨��")){ %>,ռ�ܷ����<%=Format.getFloat3(rs.getDouble("aa"),2) %>%<%} %>��
  
  
  </TD></TR>
  <%i++;}
  rs.close();
  if (payment1.indexOf("����")>=0){
   %>
   <TR><TD width="50" >&nbsp;</TD><TD >����Ŀ���Ŀ��<%=ajmoney %>��ռ�ܷ����<%=ajrate %>%���������ṩ<%=ajyear %>�갴�ҡ�
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
 
    
 
