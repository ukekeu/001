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
<title>����Э��</title>
<STYLE type=text/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 30pt; FONT-FAMILY: ����
}
tr{
	FONT-SIZE: 10pt; HEIGHT: 22pt; FONT-FAMILY: ����
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
    ResultSet execRs=ViewBean.executeQuery("exec dbo.L2U "+room_sumprice+",0 ");//��д���ת���洢����
             if (execRs.next())
				upperMoney=getbyte(execRs.getString("dd"));
				execRs.close();
			
 
	String upperMoney1="";
	
 
       execRs=ViewBean.executeQuery("exec dbo.L2U "+gzprice+",0 ");//��д���ת���洢����
             if (execRs.next())
				upperMoney1=getbyte(execRs.getString("dd"));
				execRs.close();
			
	String upperMoney2="";
	
 
       execRs=ViewBean.executeQuery("exec dbo.L2U "+luprice+",0 ");//��д���ת���洢����
             if (execRs.next())
				upperMoney2=getbyte(execRs.getString("dd"));
				execRs.close();
				
String fzs="select fzs from LoftBuildCode where secno='"+section+"' and loft='"+loft+"'";				
  execRs=ViewBean.executeQuery(fzs);

  if (execRs.next())
				fzs=getbyte(execRs.getString("fzs"));
				execRs.close();
if (fzs.equals(""))				
  fzs="�㶫����(����)���޹�˾";				
 %>
<body >
<DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="��ӡԤ��" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <div align=left id=report1 style="background-color:#F7F7F7;height:200%;overflow:auto;width:100%;z-index:2" contentEditable>
<p align="center"><font size="4"><b>����Э��</b></font></p>
<table border="0" width="99%" > <tr>
    <td width="100%"  align="right">��<%=ContractNo %>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
 
  <tr>
    <td width="100%">�����ˣ�<%=fzs %>��������������������������ϵ�绰��8888875</td>
  </tr>
  <tr>
    <td width="100%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ����</td>
  </tr>
  <tr>
    <td width="100%">�����ˣ�<%=cus_name%>������������������������������������������������ϵ�绰��<%=phone+sj %></td>
  </tr>
  <tr>
    <td width="100%">����˫������ƽ����Ը��ԭ�򣬾�Э��ǩ��������Э�鹲ͬ�������С�</td>
  </tr>
  <tr>
    <td width="100%">������һ������˫��Э�̣���������������Ϲ�λ����ͷ��<%=sectionname %>��<%=loft %>������<%=room_no %>�������ŵ�Ԫ(סլ)��</td>
  </tr>
  <tr>
    <td width="100%">���ڽ������ԼΪ<%=area %>ƽ����(���׽������ԼΪ<%=jzarea %>ƽ���ף����й�����̯���Լ<%=ftarea %>ƽ����)��</td>
  </tr>
  <tr>
    <td width="100%">���ڽ����������<%=tnunitprice %>Ԫ/ƽ���ף��ܼۿ�������<%=upperMoney %>��Сд��<%=room_sumprice %>Ԫ����</td>
  </tr>
 
  <% 
  String de="�ڶ���";
   String ds="������";
      String ds1="������";
	     String dw="������";
		 	     String dl="������";
				 	     String dq="������";
  if (!gaizhang_unitprice.equals("0")){ 
 
  %>
  <tr>
    <td width="100%">����<%=de %>����������ͬ�ⰴ�������۹������������������ͬʱ��Ըί�г����˽��и�װ����</td>
  </tr>
  <tr>
    <td width="100%">װ���<%=gaizhang_area %>ƽ����(��̨�����50%��)����װ����(���ڱ�����Э���һ������֮��)</td>
  </tr>
  
  <tr>
    <td width="100%">Ϊ<%=gaizhang_unitprice %>Ԫ/ƽ���ף��ϼ������<%=upperMoney1 %>��Сд��<%=gzprice %>Ԫ����</td>
  </tr>
  <%}else{
  dl=dw;
  dq=dl;
   dw=ds1;
  ds1=ds;
  ds=de;} %>
  <tr>
    <td width="100%">����<%=ds %>�����Ƽ�������ۿ��ڽ���ʱ�İ�ʵ�˽��㣬�����ٲ���</td>
  </tr>
  <%if (lu_tai_area>0){ %>
  <tr>
    <td width="100%">����<%=ds1 %>��������Ʒ������¶̨<%=lu_tai_area %>
      ƽ���ף���԰/¶̨����<%=lu_tai_area_price %>Ԫ/ƽ���ף��ܼ�<%=upperMoney2 %>Ԫ��</td>
  </tr>
  <%} %>
  <%if (ty_area_price>0){ %>
  <tr>
    <td width="100%">����<%//=ds1 %>��������Ʒ��������԰<%=ty_area %>
      ƽ���ף���԰����<%=ty_area_price %>Ԫ/ƽ���ף��ܼ�<%=Format.getFloat2(ty_area_price*ty_area,2) %>Ԫ��</td>
  </tr>
  <%} %>
   <%if (wd_area_price>0){ %>
  <tr>
    <td width="100%">����<%//=ds1 %>��������Ʒ��������԰<%=wd_area %>
      ƽ���ף���԰����<%=wd_area_price %>Ԫ/ƽ���ף��ܼ�<%=Format.getFloat2(wd_area_price*wd_area,2) %>Ԫ��</td>
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
    <td width="100%">��������ʹ��Ȩ���������Դ����Ӧ�ϸ���<%=sectionname %>��������ҵ����涨����ʹ��(��԰/¶̨</td>
  </tr>
  <tr>
    <td width="100%">���Ʋ�Ȩ�������<%if (wd_area_price==0){ %>���ڽ���ʱ��԰/¶̨������ֲ��죬˫��ͬ�ⰴ����ԭ����<%} %></td>
  </tr>
  <%if (wd_area_price==0){ %>
  <tr>
    <td width="100%">����1������ֵ-5%����5%����(������)�ģ�����˫�������κβ�����</td>
  </tr>
  <tr>
    <td width="100%">����2������ֵ-5%����5%����(��������)�ģ�����˫����<%=xyprice %>Ԫ/ƽ���׵����׽���ѽ��㣬�����ٲ���</td>
  </tr>
   <%} %>
  <tr>
    <td width="100%">����<%=dw %>��˫��Լ���������</td>
  </tr>
 
  <tr>
    <td width="100%">��</td>
  </tr>
  <tr>
    <td width="100%">��</td>
  </tr>
  <tr>
    <td width="100%">��</td>
  </tr>
  <tr>
    <td width="100%">����<%=dl %>�������漰�������������������԰�˫��ǩ������Э�鼰��ͬʱ����ִ�С�</td>
  </tr>
  <tr>
    <td width="100%">����<%=dq %>����������Э��һʽ���ݣ�˫����ִһ�ݣ���ǩ��֮������Ч��</td>
  </tr>
  <tr>
    <td width="100%">��</td>
  </tr>
 
  <tr>
    <td width="100%">���������ˣ����������������������������������������������ˣ�</td>
  </tr>
  <tr>
    <td width="100%">��</td>
  </tr>
 
  <tr>
    <td width="100%">������������������������������������������������������</td>
  </tr>
    <tr>
    <td width="100%">��������������������������������������������������������ǩ�����ڣ����������ꡡ�����¡�������</td>
  </tr>
</table>
</div>

</body>

</html>
