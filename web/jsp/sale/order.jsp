<%@ page contentType="text/html;charset=GBK" %>

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>�������ϵǼ�</title>
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%
//Ȩ�����
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT12");
Cortrol+=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT021");
String Cortrol1=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"C002");
 %>
 
<body oncontextmenu="return false"   onload="document.cus.cusname1.focus();">
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<%

//��ȡ��������
        String cusSerial = "" ;
        String cusName = "" ;
        String cusID = "" ;
        String cusPhone = "" ;
        String cusType = "" ;
        String ref_cusname=request.getParameter("ref_cusname");
		String ref_phone=request.getParameter("ref_phone");
		String ref_id_card=request.getParameter("ref_id_card");
		String ref_money=request.getParameter("ref_money");
		String ref_id=request.getParameter("ref_id");
		if (ref_money==null)ref_money="";
		if (ref_id==null)cusSerial="";
		if (ref_cusname!=null){
		  cusName=ref_cusname;
		  cusPhone=ref_phone;
		  cusID=ref_id_card;
		  cusSerial=ref_id;
		}
		
String SecNo=getbyte2(request.getParameter("secno"));
String Loft=getbyte2(request.getParameter("loft"));
String Build=getbyte2(request.getParameter("build"));
String RoomNo=getbyte2(request.getParameter("roomno"));
String Floor=getbyte2(request.getParameter("Floor"));
String UseArea="";
String SaleArea="";
String SaleUnitPrice="";
String UserUnitPrice="";
String SaleSumPrice="";
String Fitment="";
String RoomType="";
String Room_Type="";
String Code="";
String floor="";
String datalen="select PRICE_TYPE,unitlen,sumlen,disc ,salepricecounttype from SALE_PRICE_TYPE WHERE secno='"+SecNo+"'";
String price_type="1";
String unitlen="0";
String unitlen1="1";
String sumlen="0";
String discType="1";
String salepricecounttype="0";
 ResultSet rs=null;
  rs=ViewBean.executeQuery(datalen);	
if (rs.next()){
  price_type=rs.getString("PRICE_TYPE");
  unitlen=rs.getString("unitlen");
  if (unitlen.equals("2"))unitlen1="100";
  sumlen=rs.getString("sumlen");
  discType=rs.getString("disc");
  salepricecounttype=rs.getString("salepricecounttype");
}
rs.close();
 %>
 <%@ include file="order_pub.jsp"%>
<%
   String Ai="select * from order_contract where state<>3 and  loft='"+Loft+"' and section='"+SecNo+"' and room_no='"+RoomNo+"' and floors="+Floor;
  
  ResultSet exist=ViewBean.executeQuery(Ai);
   if (exist.next()){
   exist.close();
   %>
   <script>
   alert("�˵�λ�ѱ��Ϲ�,���ܱ���");
   window.close();
   </script>
   <%out.close();
   } 
   exist.close();
   //hh
String lokesql="UPDATE room SET saleLOKE=1,salelokedate=getdate() where seccode='"+SecNo+"' and loft='"+Loft+"'";
lokesql+=" and building='"+Build+"' and room_code='"+RoomNo+"' and  Floor="+Floor;
 
 ViewBean.executeUpdate(lokesql);
int floors=0;
String RoomSql="select gl_unitprice,gl_area,floor,Code,case when gl_tnprice>0 then  gl_tnarea+UsedArea else UsedArea end UsedArea,case when gl_unitprice>0 then  gl_area+Area else Area end    Area,Unitprice,TNunitprice,gl_area*gl_unitprice+Sumprice Sumprice,Fitment,RoomType,Room_Type,floor ";
RoomSql+=",gl_area*gl_unitprice+room_price room_price,yang_tai_area,yong_tu,lu_tai_area_price,lu_tai_area,lu_tai_area*lu_tai_area_price lu";
RoomSql+=",ty_area,ty_area_price,ty_area*ty_area_price typrice,wd_area,wd_area_price,wd_area*wd_area_price wdprice from room";
RoomSql+=" where seccode='"+SecNo+"' and loft='"+Loft+"' and building='";
RoomSql+=Build+"' and room_code='"+RoomNo+"' and Floor="+Floor;

double checksumprice=0;
String room_price="",yang_tai_area="",yong_tu="",lu_tai_area_price="",lu_tai_area="",lu="";
String ty_area="0",ty_area_price="0",typrice="0";
String wd_area="0",wd_area_price="0",wdprice="0",gl_unitprice="0",gl_area="0";
try{
 
  rs=ViewBean.executeQuery(RoomSql);
  if (rs.next())  {
     gl_unitprice=rs.getString("gl_unitprice");
    gl_area=rs.getString("gl_area");
    floors=rs.getInt("floor");
    Code=rs.getString("Code");
    UseArea=Format.getFloat1(rs.getFloat("UsedArea"),3);
    SaleArea=Format.getFloat1(rs.getFloat("Area"),3);
    SaleUnitPrice=Format.getFloat1(rs.getFloat("Unitprice"),2);
	UserUnitPrice=Format.getFloat1(rs.getFloat("TNunitprice"),2);
	//checksumprice=rs.getString("Sumprice");
	SaleSumPrice=Format.getFloat3(rs.getDouble("Sumprice"),2);
	Fitment=getbyte(rs.getString("Fitment"));
	RoomType=getbyte(rs.getString("RoomType"));
	Room_Type=getbyte(rs.getString("Room_Type"));
    floor=getbyte(rs.getString("Floor"));
	room_price=Format.getFloat3(rs.getDouble("room_price"),2);
	yang_tai_area=Format.getFloat1(rs.getFloat("yang_tai_area"),2);
	yong_tu=getbyte(rs.getString("yong_tu"));
	lu_tai_area_price=Format.getFloat1(rs.getFloat("lu_tai_area_price"),2);
	lu_tai_area=Format.getFloat1(rs.getFloat("lu_tai_area"),2);
	lu=Format.getFloat1(rs.getFloat("lu"),2);
	ty_area=rs.getString("ty_area");
	ty_area_price=rs.getString("ty_area_price");
	typrice=rs.getString("typrice");
	wd_area=rs.getString("wd_area");
	wd_area_price=rs.getString("wd_area_price");
	wdprice=rs.getString("wdprice");
  }
  rs.close();
}


catch(Exception s){out.print(s.getMessage());}
java.text.SimpleDateFormat date =null;
date=new java.text.SimpleDateFormat("yyyy-MM-dd");
String TodayDate=date.format(new java.util.Date()).toString();
int curyear=Integer.parseInt(TodayDate.substring(0,4));
int curmonth=Integer.parseInt(TodayDate.substring(5,7));
int curday=Integer.parseInt(TodayDate.substring(8,10));



  %>
<form method="POST" name="cus" action=""> 
<input type=hidden name=floor value="<%=floor%>">
  <p align=center><font size=3><b>�������ϵǼ�</b></font></p>
    
 <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>��������</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600">&nbsp; </font></td>
</tr>
</table>			  
  <table border=0 width="100%" cellspacing=0 cellpadding=0 align=center bordercolor="#ffffff" class="tablefill">
    
      <td width="15%" align=left class=roomleft>&nbsp;¥������</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=getbyte2(request.getParameter("secname")) %> 
        <input type=hidden name="sectio" readonly value="<%=getbyte2(request.getParameter("secname")) %>" size="10"  >
        <input type=hidden name="section"  value="<%=getbyte2(request.getParameter("secno")) %>" size="10"  >
      </td>
      <td width="15%" align=left class=roomleft>&nbsp;��&nbsp;��&nbsp;��&nbsp;</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=getbyte2(request.getParameter("loft")) %><%=getbyte2(request.getParameter("build"))+getbyte2(request.getParameter("roomno")) %> 
        �� </td>
      <td   align=left class=roomleft width="12%">&nbsp;��¥����</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=request.getParameter("jldate") %> 
        ��</td>
    </tr>
	    <input type=hidden name="roomno" readonly value="<%=getbyte2(request.getParameter("roomno")) %>"size="15"   onChange="toUpper(document.cus.roomno)">
        <input type="hidden" name="loft" readonly="readonly" size="15" value="<%=getbyte2(request.getParameter("loft")) %>">
		<input type=hidden name="build" readonly value="<%=getbyte2(request.getParameter("build")) %>"   size="15"   onChange="toUpper(document.cus.build)">
    	<INPUT TYPE=hidden NAME=Date2 value="<%=request.getParameter("jldate") %>" size=10 readonly title="��ѡ���Ϲ�����" onkeydown="key(document.cus.pay)">
        <input type=hidden name="jzarea" readonly  value="<%=SaleArea %>"  size="15"  >
		<input type=hidden name="area" readonly value="<%=UseArea%>"  size="15"  >
		<input type=hidden name="tnunitprice" readonly  value="<%=UserUnitPrice%>"  size="15"  >
   	    <input type=hidden name="jzunitprice" readonly value="<%=SaleUnitPrice%>"  size="15"  >
        <input type=hidden name="fx" readonly  value="<%=RoomType %>"  size="15"   onChange="toUpper(document.cus.roomno)">
        <input type=hidden name="sumprice" readonly value="<%=room_price %>"  size="15"  >
		 <input type=hidden name="Asumprice" readonly value="<%=SaleSumPrice %>"  size="15"  >
		
		<input type=hidden name="zx" readonly value="<%=Fitment %>"  size="15"   >
        <input type=hidden name="fl"  readonly value="<%=Room_Type%>" size="15"  >
		<input type=hidden name="yong_tu"  readonly value="<%=yong_tu%>" size="15"  >
		<input type=hidden name="yang_tai_area"  readonly value="<%=yang_tai_area%>" size="15"  >
       	<input type=hidden name="lu_tai_area_price"  readonly value="<%=lu_tai_area_price%>" size="15"  >
       	<input type=hidden name="lu_tai_area"  readonly value="<%=lu_tai_area%>" size="15"  >
 
	<tr> 
      <td width="15%" align=left class=roomleft>&nbsp;�������</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=SaleArea %></td>
      <td width="15%" align=left class=roomleft>&nbsp;���ڽ������</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=UseArea%></td>
      <td   align=left class=roomleft width="12%">&nbsp;���ڽ���<br>&nbsp;�������</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=UserUnitPrice%></td>
    </tr>
    <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;�����������</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=SaleUnitPrice%></td>
      <td width="15%" align=left class=roomleft>&nbsp;Ԥ���ܼ�</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=SaleSumPrice %></td>
      <td   align=left class=roomleft width="12%">&nbsp;�����ܼ�</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=room_price %> ��</td>
    </tr>
	<tr> 
     
      <td   align=left class=roomleft width="12%">&nbsp;��̨���</td>
      <td width="19%" class=roomright align=left  >&nbsp;<%=yang_tai_area %> ��</td>
    <td width="15%" align=left class=roomleft>&nbsp;��;</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=yong_tu%></td>
      <td width="15%" align=left class=roomleft>&nbsp;��¥���</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=gl_area%></td>
	</tr>
    <tr> 
      <td   align=left class=roomleft  >&nbsp;��������<input type=hidden name="fsfcmoney"  value=0></td>
      <td   align=left  colspan="3"   class=roomright  ><div id="idfsfc"></div><input type=hidden name="fsfc" size=8 readonly  value=""><INPUT TYPE="button"  NAME=xzfcfs value="���" title="��ӿͻ�����ĸ�������" onclick="document.cus.br.checked=false;openwin2('RoomCodeShowFS.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&SecName=<%=getbyte2(request.getParameter("secname")) %>',800,400,50,50);">&nbsp;<input type=checkbox name=br value=1 onclick="chfsfc(this);">���뷿��</td>
        <td width="15%" align=left class=roomleft>&nbsp;��¥����</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=gl_unitprice%></td>
  
  
    </tr>
 <tr><td colspan="6">
  <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>�ͻ�����</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"></td>
</tr>
</table>	
 
 </td></tr>
   

     
    <tr> 
      <%
       
	if (cusSerial.equals("null"))	cusSerial ="";
       if (cusName.equals("null"))  	cusName="";
       if (cusID.equals("null"))	       cusID="";
       if (cusPhone.equals("null"))	cusPhone="";

      %>
       <input type=hidden name="cusname" value="<%= cusSerial %>" >
      <td width="16%" class=roomleft >&nbsp;�ͻ�����</td>
      <td class=roomright colspan="5">&nbsp;<input type=text   name="cusname1"  size=67  onkeydown="key(document.cus.carid)" title="����������������'/'�ָ�" value="<%= cusName%>" onchange="aa();" ><input type=hidden name="editnow" value="2">
<input type=hidden name="cusname2" value="<%=cusName %>"><font color=red>*</font> <input type=button name=FindB  value="����" onclick="FindOption();"> 
         
    </tr>
	<script>
  function aa(){
    var aa=document.cus.cusname1.value;
    var aa1=document.cus.cusname2.value;
 
    if (aa1!=""){
    if (aa!=aa1){
       if (confirm("���ѱ���˿ͻ��������Ƿ���ԭ�ͻ�������"))
          setSelectMad(document.cus.editnow,"2");
       else
          setSelectMad(document.cus.editnow,"1");        

     }else {
     setSelectMad(document.cus.editnow,"1");
   }
}
}
</script>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;֤����</td>
      <td class=roomright colspan="5">&nbsp;<input type=text  name="carid" title="������������'/'�ָ�"   size=67   onblur="countAge();" onkeydown="key(document.cus.tel)" value="<%= cusID%>" >
        ��</td>
    </tr><input type=hidden name=age>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;��ϵ�绰</td>
      <td class=roomright colspan="5">&nbsp;<input type=text  name="tel"  size=30 title="������������'/'�ָ�"   onKeyDown="key(document.cus.sj)" value="<%= cusPhone%>">
        �ֻ�&nbsp;<input type=text   name="sj"  size=30 title="������������'/'�ָ�"   onKeyDown="key(document.cus.Address)" value=""> 
      </td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;��ϵ��ַ</td>
      <td class=roomright colspan="5">&nbsp;<input type=text  name="Address"  size=53  value="" onKeyDown="key(document.cus.zip)">&nbsp;�ʱ�&nbsp;<input type=text  name="zip"  size=7  value="" onKeyDown="key(document.cus.custype)">
      </td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft >&nbsp;�ͻ�����</td>
      <td  class=roomright colspan="5">&nbsp;<select name=custype onKeyDown="key(document.cus.memberT)">
          <option value=���� <% if( cusType.equals( "����" ) ) { out.print( "selected" ) ; } %> >����</option>
          <option value=��ҵ <% if( cusType.equals( "��ҵ" ) ) { out.print( "selected" ) ; } %> >��ҵ</option>
        </select> &nbsp;<select name=rh><option value=0>���뻧</option>
   <option value=1>��Ҫ�뻧</option>
        </select> &nbsp;�뻧��:<input type=text  size=8 name=rhn value=0>&nbsp;
      </td>
    </tr>
	<tr> 
      <td class=roomleft>&nbsp;�Ƿ�ҵ������</td>
      <td class=roomright colspan="5">&nbsp;<input type=checkbox name=memberT value=1  onKeyDown="key(document.cus.youhui)"  ><input type=text name=memberNO  readonly   size=43 maxlength="50">&nbsp;<input type=button name=FindC  value="����ҵ��" onclick="FindOption1();"> 
	  </td>
	  </tr>
    <tr> 
      <td class=roomleft>&nbsp;�Ż����� </td>
      <td class=roomright colspan="5">&nbsp;<input type=text name=youhui onKeyDown="key(document.cus.note)"  size=46 maxlength="50"> 
        <select name=largees OnChange="chang();">
          <%
	    String StrSql="select type,codename from CODE where type='S' and child=0 order by type";
     ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
          <%out.print("<option>��ѡ����Ʒ</option>");
		   while (codeRS.next()){
			 out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
        </select> </td>
    </tr>
    <tr> 
      <td width="16%"   class=roomleft>&nbsp;��&nbsp;ע</td>
      <td  class=roomright  colspan="5">&nbsp;<textarea rows="3" onKeyDown="key(document.cus.listlar)" name="note" cols="35"  ></textarea> &nbsp;����Ա:&nbsp; <select name="seller"  multiple size=3  onblur="SelectedSeller();" style="width:100">
          <option ></option>
          <option ></option>
          <option ></option>
          <option ></option>
        </select> <input type=button name=listlar value="<<" onclick="list1();" title="��������Ա"> 
        <input type=button name=rem value=">>" onclick="remo();"  title="ɾ������Ա"> 
        
      </td>
    </tr>
   <tr><td colspan="6">
  <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>�Ϲ�����</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"></td>
</tr>
</table>	
 
 </td></tr>
    <tr> 
      <td width="12%" class=roomleft>&nbsp;�Ϲ����</td>
      <td width="12%" class=roomright>&nbsp;<input type=text name="rgsno"   size="10"   onChange="toUpper(document.cus.rgsno)" onKeyDown="key(document.cus.cale1)" onBlur="checkedOrderNoExist();" title="ֻ����Ӣ����ĸ�����ּ�"-"���"></td>
      <td width="19%" class=roomleft>&nbsp;�Ϲ�����</td>
      <td width="19%" class=roomright>&nbsp;<input type=TEXT value="<%=curyear+"-"+curmonth+"-"+curday %>" name=Date1 size=10 title="��ѡ���Ϲ�����"  readonly onchange="key(document.cus.pay);" onKeyDown="key(document.cus.VisaDate)"><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(Date1);return false;" title="��ѡ���Ϲ�����"></td>
      <td width="15%" class=roomright colspan="2">&nbsp;���ʽ:<select name="pay"     onChange="charges();dkcount();" style="width : 150" onKeyDown="key(document.cus.VisaDate)">
          <option></option>
            <%
       String sql="select * from PayMent where TYPE=0 and seccoe='"+SecNo+"'";
      ResultSet rs3=ViewBean.executeQuery(sql);
	  String pay="";
	  String dic;
	  String dj1="";
	  String qdate="";
	  String ajdate="";	  
	  String gddate="";	 
	  String num="";
     while (rs3.next()){
	    pay=getbyte(rs3.getString("PayName"));
		num=rs3.getString("num");
	    dic=rs3.getString("Discont");
		dj1=rs3.getString("prepay");
		qdate=rs3.getString("qdate");
		ajdate=rs3.getString("ajdate");
		gddate=getbyte(rs3.getString("gddate"));
		if (gddate.indexOf(" ")>0)gddate=gddate.substring(0,gddate.indexOf(" "));
		String dic1=dic;
	    out.print("<option value='"+pay+"-"+dic1+"-"+dj1+"|"+num+"#"+qdate+"."+ajdate+"g"+gddate+"'>"+pay+"*"+dic+"��*"+num+"��</option>");
	  }
	  
	    rs3.close();
     %>
        </select></td>
    
        <input type=hidden name=dis size=6 readonly>
       
    </tr>
	<%if (Cortrol.indexOf("K")>=0){  %>
	<input type="hidden" name="ewyh" size=10  onchange="check(this);count5();"  onkeydown="key(document.cus.curry);">
	<input  type=hidden name=abcd  onchange="count3();" size=8 title="�����ʽ��98*95*95" onkeydown="key(document.cus.curry);">
	 <!--  <tr> 
      <td width="19%" class=roomleft>&nbsp;�����Ż�</td>
      <td width="19%" class=roomright   >&nbsp;<input type="text" name="ewyh" size=10  onchange="check(this);count5();"  onkeydown="key(document.cus.curry);">
      </td>

	  <td width="15%" class=roomleft>&nbsp;�����ۿ�</td>
      <td width="23%"    class=roomright>&nbsp;<input  type=text name=abcd  onchange="count3();" size=8 title="�����ʽ��98*95*95" onkeydown="key(document.cus.curry);">%
      </td>

	 
	 <td width="15%" class=roomleft>&nbsp;�Ż�����</td>
      <td width="23%"    class=roomright>&nbsp;<input  type=text name=youhui_date  size=12 onkeydown="key(document.cus.curry);"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(youhui_date);" title="��ѡ���Ϲ�����">
      </td>
    
	 </tr>
	 <tr> 
      <td width="19%" class=roomleft>&nbsp;�Żݱ�ע</td>
      <td width="19%" class=roomright  colspan="5"  >&nbsp;<input  type=text name=youhuibeizhu  size=50 onkeydown="key(document.cus.curry);">&nbsp;��ϵ��&nbsp;&nbsp;<input type=text size=10 name=gxr >
 </tr>
 -->
	 
	 <tr><td colspan="5"> 
	  <a href="#12" ><font color=red><div id=yhview>�� ��</div></font></a> 
	</td><td  >  <a href="#" onclick="discOPEN();">����Ż�</a> 
	</td></tr>
      <%} %>     
      <input type=hidden name="ajtype" value="0">
      <!--
	  <input type=button name=abc12 value="ȷ��"  onblur="disc();" >
	  <select name=ajtype disabled OnChange="count();count1();document.cus.cusname1.focus();">
          <option></option>
          <option value=0>��ҵ����</option>
          <option value=1>����ҵ����</option>
        </select>
		-->
    
	 
	 <!-- <select name=ajcs style="width : 40" disabled onBlur="count1();"  onchange="document.cus.ajyr.focus();">
          <option></option>
          <%for (int i=1;i<=10;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"0%</option>");
		} %>
       <!--  </select>-->
	   <tr><td class=roomleft>&nbsp;��������</td>
	    <td width="18%" class=roomright>&nbsp;<select name=ajbk   style="width : 80">
         <option></option>
		  <%
	     StrSql="select type,codename from CODE where type='T' order by type";
        codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
			 out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
        </select></td>
		<td class=roomleft>&nbsp;���������</td>
		<td class=roomright>&nbsp;<input type=text name=gjj size=10 value=0 OnBlur="check(this);dkcount1();">(Ԫ)</td>
		 <td width="12%" class=roomleft >&nbsp;��������</td> 
      <td width="15%"    class=roomright  >&nbsp;<select name=gjjy     onchange="count();"  style="width : 80" >
          <option></option>
		  <option value=0.5>0.5��</option>
          <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"��</option>");
		} %>
        </select></td>
	   </tr>
    <tr>
	 <td width="15%" class=roomleft>&nbsp;�� �� ��</td>
        <td width="19%" class=roomright  >&nbsp;<input  type=text size=10 value ="0"    disabled name=ajmoney onblur="check(this);countAj();" onChange="dkcount1();">(Ԫ)��</td>
   <td class=roomleft>&nbsp;��ҵ  ����</td>
		<td class=roomright>&nbsp;<input type=text name=sydk size=10  value=0 OnBlur="check(this);dkcount2();">(Ԫ)</td>
      <td width="12%" class=roomleft >&nbsp;��������</td><input type=hidden name=oldajcs size=4>
      <td width="15%"    class=roomright  >&nbsp;<input type=hidden name=ajcs size=4><select name=ajyr disabled    onchange="count();"  style="width : 80" ><!--onblur="bxRate();"-->
          <option></option>
		  <option value=0.5>0.5��</option>
          <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"��</option>");
		} %>
        </select></td>
		  </tr>

    <tr> 
      <td width="19%" class=roomleft >&nbsp;�ɽ�����</td>
      <td width="19%"    class=roomright  >&nbsp;�Զ���Ϊ׼:<input type=checkbox name=bz value=1 <%if (Cortrol.indexOf("C")<0){ %> title="�����Ȩ" disabled <%} %> checked onclick="checkcount();"></td>&nbsp;<td class=roomright>&nbsp;<input type=text name="dicprice"  defaultValue=""  value=0  size="10"     onblur="check(this);ykj_count();"    <%if (Cortrol.indexOf("C")==-1){ %>   readonly<%} %> >Ԫ
        <input type=hidden name="countdiscprice" ><input type=hidden value=0 readonly name="MonthMoney"     size="8"  ></td><td width="23%" class=roomright  >&nbsp;<select name="curry" style="width : 40" OnChange="CurrRa();">
          <option value="RMB">RMB</option>
          <option value="HKD">HKD</option>
          <option value="USD">USD</option>
        </select><input type=text name="rate"  value=1.0  size="4" title="����"  onblur="check(this);">
      </td>
	  <td width="19%" class=roomleft>&nbsp;��&nbsp;��&nbsp;��</td>
        <td width="19%" class=roomright >&nbsp;<input  type=text size=10  value ="0"   name=firstMoney disabled  onblur="check(this);countsq();dkcount1();">(Ԫ)</td>
      
     <input type=hidden name="Adicprice"     size="10" <%if (!(checksumprice>0)){ %>   onblur="check(this);charges();"     <%}else{out.print("readonly title='���ж��ۣ�����ֱ����д'");} %> onkeydown="key(document.cus.cjjzprice);"> 
      
      
    </tr>
	
	<input type=hidden name=yukuan value=0>
   <tr>
      <td width="12%" class=roomleft >&nbsp;�ɽ�����<br>&nbsp;�������</td> 
      <td width="12%" class=roomright >&nbsp;<input type=text name="cjjzprice" size=10 value=0  onblur="document.cus.dicprice.value=subs1(parseFloat(this.value)*parseFloat(document.cus.jzarea.value),<%=sumlen %>);document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);ykj_count();"></td>
      <td width="19%" class=roomleft >&nbsp;�ɽ����ڽ�<br>&nbsp;���������</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="cjtnprice" size=10  value=0 <%if (java.lang.Float.parseFloat(room_price)>0){ %>   readonly<%} %> onChange="document.cus.dicprice.value=subs1(parseFloat(this.value)*parseFloat(document.cus.area.value),<%=sumlen %>);document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);"></td>  
     <td width="15%" class=roomleft>&nbsp;�Ϲ�����</td>
      <td width="23%" class=roomright  >&nbsp;<input type=text name="earnest" onblur="check(this);"   size="10" title="���Ĭ��Ϊ0ʱ����ʾ�����ǰ��ܼ۰ٷֱȼ���,���ǿ���޸�Ϊ0ʱ����ʾ����Ҫ������" >
        ��</td>
	</tr>
	 <input type=hidden size=10 value=0  name="firstmoney"  onchange="sendfirst(this);">
	<input type=hidden size=10 name="factprice" readonly>
	<input type=hidden name="sjcjjzprice" size=10  readonly>
	<input type=hidden name="sjcjtnprice" size=8 readonly>
	<tr>
	  <td width="19%" class=roomleft >&nbsp;��ͬ���</td>
      <td width="19%" class=roomright >&nbsp;<select name="httype"  style="width : 80"><option value=0>����</option><option value=1>����</option></select></td>  
   
     
	  
	 
	<td width="19%" class=roomleft >&nbsp;��ͬ�Ƽ۷�ʽ</td>
      <td width="19%" class=roomright colspan="3" >&nbsp;<select name="counttype" style="width : 80">
          <option value="1">�������</option>
		  <option value="0">�������</option>
         
        </select></td> 
	 </tr>
	 <!--
	  <tr>
      <td width="12%" class=roomleft >&nbsp;ʵ�ʳɽ�����<br>&nbsp;�������</td>
      <td width="12%" class=roomright >&nbsp;</td>
      <td width="19%" class=roomleft >&nbsp;ʵ�ʳɽ�����<br>&nbsp;�����������</td>
      <td width="19%" class=roomright >&nbsp; Ԫ/M<sup>2</sup>��</td>  
	 
	 </tr>
	  
	    <tr>
      <td width="12%" class=roomleft >&nbsp;¶̨���</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="lutai_area" onblur="countlutai();"  size=10 value="<%=lu_tai_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;¶̨����</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="lutai_area_price" size=8   onblur="countlutai();" value="<%=lu_tai_area_price %>"  > Ԫ/M<sup>2</sup>��</td> 
	   <td width="19%" class=roomleft >&nbsp;¶̨�ܼ�</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="tai_area_sumprice" size=8 readonly  value="<%=lu %>" > Ԫ</td>  </tr>
  
	   </tr>
	     <tr>
      <td width="12%" class=roomleft >&nbsp;��԰���</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="ty_area" onblur="countty();"  size=10 value="<%=ty_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;��԰����</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="ty_area_price" size=8   onblur="countty();" value="<%=ty_area_price %>"  > Ԫ/M<sup>2</sup>��</td> 
	   <td width="19%" class=roomleft >&nbsp;��԰�ܼ�</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="ty_area_sumprice" size=8 readonly  value="<%=typrice %>" > Ԫ</td>  </tr>
  
	   </tr>
	     <tr>
      <td width="12%" class=roomleft >&nbsp;�������</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="wd_area" onblur="countwd();"  size=10 value="<%=wd_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;���浥��</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="wd_area_price" size=8   onblur="countwd();" value="<%=wd_area_price %>"  > Ԫ/M<sup>2</sup>��</td> 
	   <td width="19%" class=roomleft >&nbsp;�����ܼ�</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="wd_area_sumprice" size=8 readonly  value="<%=wdprice %>" > Ԫ</td>  </tr>
  
	   </tr>
	   -->
	    <input type=hidden onblur="countlutai();" name="lutai_area" size=10 value="0"  >
	   <input type=hidden onblur="countlutai();" name="lutai_area_price" size=8  value="0"  >
	   <input type=hidden name="tai_area_sumprice" size=8 readonly  value="0" >
	   <input type=hidden name="ty_area" onblur="countty();"  size=10 value="0"  >
	   <input type=hidden name="ty_area_price" size=8   onblur="countty();" value="0"  >
	   <input type=hidden name="ty_area_sumprice" size=8 readonly  value="0" >
	   <input type=hidden name="wd_area_sumprice" size=8 readonly  value="0" >
	   <input type=hidden name="wd_area_price" size=8   onblur="countwd();" value="0"  >
	   <input type=hidden name="wd_area" onblur="countwd();"  size=10 value="0"  >

	   <tr><td  class=roomleft>&nbsp;ǩԼ����</td><td colspan="5" class=roomright>&nbsp;<input type="test" size=10 name="qydate"  ><input type=checkbox name=gddate value=1> �̶����� </td>
	   </tr>
	   <script>
	   function countlutai(){
	      if (document.cus.lutai_area.value!=""&&document.cus.lutai_area_price.value!=""){
		   // document.cus.Adicprice.value=parseFloat(document.cus.dicprice.value)+parseFloat(document.cus.lutai_area.value)*parseFloat(document.cus.lutai_area_price.value)
		     document.cus.tai_area_sumprice.value=parseFloat(document.cus.lutai_area.value)*parseFloat(document.cus.lutai_area_price.value);
		  }
	   }
	    function countty(){
	      if (document.cus.ty_area.value!=""&&document.cus.ty_area_price.value!=""){
		     document.cus.ty_area_sumprice.value=parseFloat(document.cus.ty_area.value)*parseFloat(document.cus.ty_area_price.value)
		  }
	   }
	    function countwd(){
	      if (document.cus.wd_area.value!=""&&document.cus.wd_area_price.value!=""){
		     document.cus.wd_area_sumprice.value=parseFloat(document.cus.wd_area.value)*parseFloat(document.cus.wd_area_price.value)
		  }
	   }
	   </script>
  </table>
<%if(userstate.equals("1")){ %>
<INPUT TYPE="hidden"  NAME=QYDate size=10>
 
<INPUT TYPE="hidden"  NAME=ajDate size=10 >
<INPUT TYPE="hidden"  NAME=fkDate size=10 >

<input type=hidden size=13 value="0" name=bxmoney>
<input type="hidden" value="0" name="firstFT">
<input type="hidden"  name="constractno">
<input type="hidden" value="0" name="gz">
<input type="hidden" value="0" name="bx">
<%}else{ %>
 <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>��ͬ����</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600"> &nbsp;</font></td>
</tr>
</table>	
    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
   
    <tr > 
      <td width="16%"  class=roomleft>���ڿ�״̬</td>
      <td width="18%"  class=roomright>&nbsp;<select name="firstFT" style="width : 105"><option value="0">δ��</option><option value="1">�ѽ�</option></select></td>
      <td width="16%"  class=roomleft>��ͬ���</td>
      <td width="18%"  class=roomright>&nbsp;<input type="text" name="constractno"  size="12"    onblur="checkedOrderNoExist(this.value);" OnChange="if (document.cus.rgsno.value=='')document.cus.rgsno.value=document.cus.constractno.value;toUpper(document.cus.constractno)" onkeydown="key(document.cus.QYDate)" title="ֻ����Ӣ����ĸ�����ּ�"-"���"></td>
      <td width="14%"  class=roomleft>ǩԼ����
      </td>
      <td width="18%"  class=roomright>&nbsp;<INPUT TYPE="text"  NAME=QYDate size=10  title="��ѡ��ǩԼ����"  OnChange="document.cus.Date1.value=document.cus.QYDate.value;" onkeydown="key(document.cus.kkrate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(QYDate);document.cus.Date1.value=document.cus.QYDate.value;return false;" title="��ѡ���Ϲ�����"></td>
    </tr>
	 
   
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>��������</td>
      <td width="18%" class=roomright>&nbsp;<select name=ajbk disabled style="width : 105">
         <option></option>
		  <%
	     StrSql="select type,codename from CODE where type='T' order by type";
        codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
			 out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
        </select></td>
      <td width="14%" class=roomleft>��������</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text"  disabled NAME=ajDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ajDate);return false;" title="��ѡ���Ϲ�����"></td>
      <td width="16%" class=roomleft>���зſ�����</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text" disabled NAME=fkDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(fkDate);" title="��ѡ���Ϲ�����"></td>
    </tr>

    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>��֤״̬</td>
      <td width="18%" class=roomright>&nbsp;<select name="gz" style="width : 105"><option value="0">δ��</option><option value="1">�Ѱ�</option></select></td>
      <td width="14%" class=roomleft>����״̬</td>
      <td width="18%" class=roomright>&nbsp;<select name="bx" style="width : 105"><option value="0">δ��</option><option value="1">�Ѱ�</option></select></td>
      <td width="16%" class=roomleft>���ս��</td>
      <td width="18%" class=roomright>&nbsp;<input type=text size=13 value="0" name=bxmoney></td>
    </tr>
    <!--
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>�Ƿ񰴽�</td>
      <td width="18%" class=roomright>&nbsp;<select name="aj" style="width : 105"><option value="1">������</option><option value="0">����</option></select></td>
    </tr>
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>��������</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text"  NAME=baDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(baDate);" title="��ѡ���Ϲ�����"></td>
      <td width="14%" class=roomleft>��������</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text"  NAME=caDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(caDate);" title="��ѡ���Ϲ�����"></td>
    </tr>    
    -->

  </table>
  <%} %>
  <%ViewBean.closeConn();
    fBean.closeConn();
   %>
  <p align="center"> 
    <input type=hidden name=discSQL value="">
    <input type=hidden name=saveorder value="insert">
  <input type=hidden name=ajtxdate >
   <%if (Cortrol.indexOf("A")>=0) {%>
    <input type="button" value="�ᡡ��" name="submit1" onclick="SaveContract();">
	<%} %>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <input type="button" value="�� ��" name="reset" onclick="window.close();">
  </P>
     <script>
	 function dkcount(){
	   document.cus.sydk.value= document.cus.ajmoney.value;
		 }
	function dkcount1(){
	 
	    if (document.cus.gjj.value=="")
		document.cus.gjj.value="0";
	     document.cus.sydk.value= parseInt(document.cus.ajmoney.value)-parseInt(document.cus.gjj.value);

		 }	 
	function dkcount2(){
	   if (parseInt(document.cus.sydk.value)>0)
	     document.cus.gjj.value= parseInt(document.cus.ajmoney.value)-parseInt(document.cus.sydk.value);
	   else
	      document.cus.gjj.value= document.cus.ajmoney.value;	 
		 }	 	 
	 function checkdisc(para){
	    var discC=parseFloat(<%=(String)session.getAttribute("disc") %>);
		if  (para>discC){alert("�ۿ����󣬿�������û�д�Ȩ�޵��ۿ�");document.cus.disc.focus();return false;}
	   return true;
	 }
	 function SaveContract(){
	// if (checkdisc(document.cus.disc.value)){alert("�ۿ����󣬿�������û�д�Ȩ�޵��ۿ�");document.cus.disc.focus();return false;}
    if (document.cus.qydate.value==""){alert("ǩԼ�������ڲ���Ϊ��");document.cus.qydate.focus();return false;}
	 if (isNaN(document.cus.qydate.value))
      {
       if (confirm("ǩԼ���������ǹ̶�������")){
	      dic_arr=document.cus.qydate.value.split("-");
	      var disn=1;
	     for (var dd=0;dd<dic_arr.length;dd++){
			   if (isNaN(dic_arr[dd])){alert("���ڸ�ʽ����");document.cus.qydate.focus();return false;}
			   if (parseFloat(dic_arr[dd])<=0){alert("���ڸ�ʽ����");document.cus.qydate.focus();return false;}
	   	   }
	       document.cus.gddate.checked=true;
	   
	} else{ document.cus.qydate.focus();document.cus.qydate.select();}
     }	
   if (Validate(document.cus)){
    if (document.cus.Date2.value==""){alert("��¥���ڲ���Ϊ��,�����ڷ�����������д");return false;}
   
     document.cus.action="order_save.jsp?ref_money=<%=ref_money %>&code=<%=Code %>";
	if (confirm("ȷ�ϱ��浱ǰ������"))	
	{ document.cus.submit1.disabled=true;
	 document.cus.submit();
	 }
   }
 }
function chfsfc(para){
 
 if (para.checked){document.cus.sumprice.value=parseFloat(document.cus.sumprice.value)+parseInt(document.cus.fsfcmoney.value);charges();}
 else{ document.cus.sumprice.value=parseFloat(document.cus.sumprice.value)-parseInt(document.cus.fsfcmoney.value);charges();}
}	
function ListFs(){
   if (document.cus.fsfc.value!=""){
     openwin3("fsfcList.jsp?codes="+document.cus.fsfc.value,400,300,200,200);
   
   }

}
function discOPEN(){
 
if (parseFloat(document.cus.dicprice.value)==0){alert("����ѡ�񸶿ʽ");return false;}

openwin3("disc.jsp?code=<%=SecNo+Loft+RoomNo %>&discPrice="+document.cus.dicprice.value+"&discUnit="+document.cus.cjjzprice.value,700,400,100,100);
}
 
	 </script>
</form>
</body>
</html>
