<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>销售合同</title>

</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<% String userstate=(String) session.getAttribute("userstate");
  //按揭保险费
    String bxcharges="0";
  String bxrate="select insurance_rate, insurance_year from insurance_rate ";
   ResultSet bxRs=ViewBean.executeQuery(bxrate);
	try{

  out.print("<script>");
  out.print("var Ratebx=new Array();");
  out.print("var Yearbx=new Array();");
  int iii=0;

   while (bxRs.next()){
     out.print("Ratebx["+String.valueOf(iii)+"]="+"\""+getbyte(bxRs.getString("insurance_rate"))+"\""+";");
     out.print("Yearbx["+String.valueOf(iii)+"]="+"\""+bxRs.getString("insurance_year")+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
bxRs.close();
out.print("</script>");
	
  %>

 <%
  String  sqlrg="";
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"S002");


   String secno=getbyte2(request.getParameter("secno"));
  String loft=getbyte2(request.getParameter("loft"));
  String build=getbyte2(request.getParameter("build"));
  String room=getbyte2(request.getParameter("roomno"));
  String Floor=request.getParameter("Floor");
  String check=getbyte2(request.getParameter("check"));
  String see=request.getParameter("see");
  if(see==null)see="";
  
  
  
  //读取合同资料
      sqlrg="select o.code,o.sectionname,o.serialno,o.ContractNo,o.Customer,o.sectionname as secname,o.building,";
	  sqlrg+="o.Room_no,o.buildtype,o.roomtype,o.payment,";
	  sqlrg+="o.area,o.zx,o.unitprice,o.salerprice,salerprice/o.jzarea as salejzPrice,salerprice/o.area as saleUsePrice,o.AjMoney,o.MonthPayMoney,";
	  sqlrg+="o.subscription,o.jldate,o.currency,o.state,";
	  sqlrg+="convert(char(24),o.date,120) date,o.note,o.AjBk,o.AjYear,o.AJcs,o.Ajtype,o.jzarea";
	  sqlrg+=",c.signatory,o.JLdate,o.VisaDate,jzdate,ajdate,httype";
	  sqlrg+=",o.disc,c.ID_Card,c.Phone,c.sj,c.Address,c.Zip_Code,qytxdate,";
	  sqlrg+="o.CusType,o.currency,o.rate,o.seller,o.OutDate,o.FkDate,o.bxState,";
	  sqlrg+="o.bxMoney,o.firstState,o.yhMoney,o.GzState,o.ewdisc,c.bbj,c.sj,o.youhui,o.youhuibeizhu  ";
	  sqlrg+=" from Order_Contract o,customer c  ";
	  sqlrg+=" where  o.Customer=c.serialNo and ";
	  sqlrg+="o.section='"+secno+"' and loft='"+loft+"' and building='"+build+"'";
	  sqlrg+=" and Room_no='"+room+"' and Floors="+Floor;

	  ResultSet rs3=ViewBean.executeQuery(sqlrg);
 
	   String code="";
	   String rgno="";
	   String ContractNo="";
	   String secname="";
	   String buildtype="";
	   String roomtype="";
	   String httype="";
	   String zx="";
	   String cusno="";
	   String area="";;
	   float unitprice;
	   float saleprice;
	   float subscription;
	   String date="";
	   String year="";
	   String month="";
	   String VisaDate="";
	   String note="";
	   String price="";
	   String salprice="";
	   String saleJzPrice="";
	   String saleUsePrice="";
	   String firstmoney="";
	   String payment="";
	   String dj="";
	   String area1="";
	   String ajbk="";
	   String ajyr="";
	   String ajcs="";
	   String ajtype="";
	   String ajmoney="";
	   String monthpay="";
	   String cusname="";
	   String StrBBJ="";
	   String StrSJ="";
	   String JLdate="";
	   String disc1="";
       String disc2="";
	   String ID_Card="";
	   String Phone="";
	   String Address="";
	   String Zip_Code ="";
	   String custype="";
	   String curry="";
	   String rate="";
	   String seller="";
	   String StrAjDate="";
	   String StrCaDate="";
	   String StrJzDate="";
	   String StrAjState="";
	   String StrGzState="";
	   String StrBxState="";
	   String StrBxMoney="";
	   String StrFkDate="";
	   String StrEwDisc="";
	   String StrYhMoney="";
	   String StrFirstState="";
	   String StrState="";
	   String youhui="";
	   String sj="";
	   String qytxdate="";
	    String state="";
		String sectionName="";
	   String youhuibeizhu="";
	  while(rs3.next()){  
	     code=rs3.getString("code");  
		 sectionName=getbyte(rs3.getString("sectionName"));  
	     rgno=getbyte(rs3.getString("serialno"));  
		 ContractNo=getbyte(rs3.getString("ContractNo"));  
		 cusno=getbyte(rs3.getString("Customer"));  
	     secname=getbyte(rs3.getString("secname"));           
	     build=getbyte(rs3.getString("building"));           
		 room=rs3.getString("Room_no");  
		 buildtype=getbyte(rs3.getString("buildtype")); 
		 roomtype=getbyte(rs3.getString("roomtype"));
		 payment=getbyte(rs3.getString("payment"));

		//payment=payment.substring(0,payment.lastIndexOf("."))+"*"+payment.substring(payment.lastIndexOf(".")+1)+"*期";
		 area=rs3.getString("area"); 
		 zx=getbyte(rs3.getString("zx"));
		 unitprice=rs3.getFloat("unitprice"); 
		 price=String.valueOf(unitprice);
		 saleprice=rs3.getFloat("salerprice"); 
		 saleJzPrice=Format.getFloat1(rs3.getFloat("saleJzPrice"),2); 
		 saleUsePrice=Format.getFloat1(rs3.getFloat("saleusePrice"),2); 
		 ajmoney =rs3.getString("AjMoney"); 
		 monthpay =rs3.getString("MonthPayMoney"); 
		 if (payment.indexOf("揭")>=0)
		 firstmoney=String.valueOf(saleprice-Float.parseFloat(ajmoney));
		
		 salprice=String.valueOf(saleprice);
		 subscription=rs3.getFloat("subscription"); 
		 dj=String.valueOf(subscription);
		 JLdate=getbyte(rs3.getString("jldate")); 
		 curry=rs3.getString("currency"); 
		 date=getbyte(rs3.getString("date")); 
		 
		 if (!date.equals(""))date=date.substring(0,10);
		 note=getbyte(rs3.getString("note")); 
		  ajbk=getbyte(rs3.getString("AjBk")); 
		 ajyr=rs3.getString("AjYear"); 
         ajcs=rs3.getString("AJcs"); 
		 ajtype=getbyte(rs3.getString("Ajtype")); 
		 area1=rs3.getString("jzarea"); 
		 cusname=getbyte(rs3.getString("signatory")); 
		 
		 VisaDate=getbyte(rs3.getString("VisaDate")); 
		 StrJzDate=getbyte(rs3.getString("jzDate")); 
		 StrAjDate=getbyte(rs3.getString("ajDate")); 
		 httype=getbyte(rs3.getString("httype")); 
		 disc1=getbyte(rs3.getString("disc")); 
		  if (!disc1.equals(""))
		 disc2=disc1.substring(disc1.indexOf("*")+1);
		
 		 if (disc1.indexOf("*")>=0)
		  disc1=disc1.substring(0,disc1.indexOf("*"));
		  ID_Card=rs3.getString("ID_Card"); 
	      Phone=rs3.getString("Phone"); 
		  sj=rs3.getString("sj");
	      Address=getbyte(rs3.getString("Address")); 
	      Zip_Code =rs3.getString("Zip_Code"); 
		  qytxdate=getbyte(rs3.getString("qytxdate"));  
		  if (!qytxdate.equals(""))qytxdate=qytxdate.substring(0,10);
		  custype=getbyte(rs3.getString("custype")); 
		  curry=getbyte(rs3.getString("currency"));
		  StrState=getbyte(rs3.getString("state"));
		  rate=getbyte(rs3.getString("rate"));
		  seller=getbyte(rs3.getString("seller"));
		  StrCaDate=getbyte(rs3.getString("outdate"));
		  StrFkDate=getbyte(rs3.getString("fkdate"));
		  StrBxState=getbyte(rs3.getString("bxState"));
   	      StrBxMoney=getbyte(rs3.getString("bxMoney"));
		  StrFirstState=getbyte(rs3.getString("firstState"));
		  StrYhMoney=getbyte(rs3.getString("yhMoney"));
		  StrGzState=getbyte(rs3.getString("GzState"));
		  StrEwDisc=getbyte(rs3.getString("ewdisc"));
		  StrBBJ=getbyte(rs3.getString("BBJ"));
		  StrSJ=getbyte(rs3.getString("SJ"));
		  youhui=getbyte(rs3.getString("youhui"));
		  youhuibeizhu=getbyte(rs3.getString("youhuibeizhu"));
		  state=getbyte(rs3.getString("state"));
	 } 
	  rs3.close();  %>      
   

<%
 //读取客户交款资料
 String chargesSQL="SELECT sum(factmoney) as factmoney FROM FactGatheringRecord WHERE contractno='"+code+"' group by contractno ";
 ResultSet chargesRS=null;

 String factmoney="0";
 try{
  chargesRS=ViewBean.executeQuery(chargesSQL);
 if (chargesRS.next())factmoney=chargesRS.getString("factmoney");
 
 }catch(Exception s){}
chargesRS.close();
 
 %> 
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 

<SCRIPT language=javascript>
  
function fullData(){
   //setSelectMad1(document.cus.pay,"<%=payment %>");
   <%if (payment.indexOf("揭")>=0){ %>
   	 document.cus.fkc.disabled=false;
	 document.cus.ajc.disabled=false;
	 document.cus.ajbk.disabled=false;
   <%}else{ %>
   	 document.cus.fkc.disabled=true;
	 document.cus.ajc.disabled=true;
 	 document.cus.ajbk.disabled=true;
   <%} %> 
   setSelectMad(document.cus.custype,"<%=custype %>");
   setSelectMad(document.cus.httype,"<%=httype %>");
   setSelectMad(document.cus.ajyr,"<%=ajyr %>");
   setSelectMad(document.cus.curry,"<%=curry %>");
   <%if(!userstate.equals("1")){ %>
   setSelectMad(document.cus.ajbk,"<%=ajbk %>");
   setSelectMad(document.cus.bx,"<%=StrBxState %>");
   setSelectMad(document.cus.gz,"<%=StrGzState %>");
   <%} %>
} 
function checkContract(para){
  if (confirm("审核通过的优惠不能再修改！确认审核吗？"))
    openwin("ContractCheck1.jsp?code="+para,10,10,10,10);
    
}
</SCRIPT>

<%
String SecNo=getbyte2(request.getParameter("secno"));
String Loft=getbyte2(request.getParameter("loft"));
String Build=getbyte2(request.getParameter("build"));
String RoomNo=getbyte2(request.getParameter("roomno"));
String floors=getbyte2(request.getParameter("Floor"));
String UseArea="";
String SaleArea="";
String SaleUnitPrice="";
String UserUnitPrice="";
String SaleSumPrice="";
String Fitment="";
String RoomType="";
String Room_Type="";

String RoomSql="select UsedArea,Area,Unitprice,TNunitprice,Sumprice,Fitment,RoomType,Room_Type,Floor from room";
RoomSql+=" where seccode='"+SecNo+"' and loft='"+Loft+"' and building='";
RoomSql+=Build+"' and room_code='"+RoomNo+"'";
//out.print(RoomSql);
ResultSet rs=null;
try{
  rs=ViewBean.executeQuery(RoomSql);
  if (rs.next())  {
    UseArea=Format.getFloat1(rs.getFloat("UsedArea"),3);
    SaleArea=Format.getFloat1(rs.getFloat("Area"),3);
    SaleUnitPrice=Format.getFloat1(rs.getFloat("Unitprice"),2);
	UserUnitPrice=Format.getFloat1(rs.getFloat("TNunitprice"),2);
	SaleSumPrice=Format.getFloat1(rs.getFloat("Sumprice"),1);
	Fitment=getbyte(rs.getString("Fitment"));
	RoomType=getbyte(rs.getString("RoomType"));
	Room_Type=getbyte(rs.getString("Room_Type"));
        floors=getbyte(rs.getString("floor"));
  }
  rs.close();
}
catch(Exception s){out.print(s.getMessage());}

 %>

 <body onload="fullData();">

<form method="POST" name="cus" action=""> 
<input type="hidden" value="<%=code %>" name="code">
<input type=hidden name=change>
<input type=hidden name=context>
<input type=hidden name=checker>
<input type=hidden name=oldajmoney value="<%=ajmoney %>">
<input type=hidden name=oldpay value="<%=payment %>">
<input type=hidden name=oldsalprice value="<%=salprice %>">
<input type=hidden name=url value="SaveContract.jsp">
<input type=hidden name=oldRoom value="<%=request.getParameter("roomno") %>">
<input type=hidden name=hiarea value="<%=SaleArea%>">
<input type=hidden name=olddate value="<%=SaleArea%>">
<input type=hidden name=floor value="<%=floors%>">
<input type=hidden name=hisumprice value="<%=SaleSumPrice%>">
  <p align=center><font size=3><b>销售资料</b></font></p>

    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
   <tr> 
      <td colspan="8" align="center"><%if (StrState.equals("f")){ %><input type=radio name=choose  onclick="chooseRadio();">挞订<%} %>
	  <%//if (StrState.equals("2")){ %>
	  <%if (Cortrol.indexOf("A")>=0 && StrState.equals("1")  && see.equals("1")){ %>
	  <input type=radio name=choose  onclick="chooseRadio();">退定 
	  <input type=radio name=choose  onclick="chooseRadio();">换房
	  <input type=radio name=choose  onclick="chooseRadio();">付款情况<%} %>
	  </td>
    </tr>
    <tr> 
      <td colspan="8" align="center"  bgcolor="#CFE6EB">房 间 资 料 
    </tr>
	
    <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;楼盘名称</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=sectionName %> 
        <input type=hidden name="sectio" readonly value="<%=request.getParameter("secname") %>" size="10"  >
        <input type=hidden name="section"  value="<%=request.getParameter("secno") %>" size="10"  >
      </td>
      <td width="15%" align=left class=roomleft>&nbsp;房&nbsp;间&nbsp;号&nbsp;</td>
      <td   align=left class=roomright width="20%"><div id="idroomno">&nbsp;<%=request.getParameter("loft") %><%=request.getParameter("build") %><%=request.getParameter("roomno") %></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;交楼日期</td>
      <td width="19%" class=roomright align=left>&nbsp;<% if (!JLdate.equals(""))out.print(JLdate.substring(0,10)); %> 
        　</td>
    </tr>
	    <input type=hidden name="roomno" readonly value="<%=request.getParameter("roomno") %>" size="15"   onChange="toUpper(document.cus.roomno)">
        <input type="hidden" name="loft" readonly="readonly" size="15" value="<%=request.getParameter("loft") %>">
		<input type="hidden" name="oldloft" readonly="readonly" size="15" value="<%=request.getParameter("loft") %>">
		<input type=hidden name="build" readonly value="<%=request.getParameter("build") %>"   size="15"   onChange="toUpper(document.cus.build)">
    	<INPUT TYPE=hidden NAME=Date2 value="<%=request.getParameter("jldate") %>" size=10 readonly title="请选择认购日期" onkeydown="key(document.cus.pay)">
        <input type=hidden name="jzarea" readonly  value="<%=SaleArea %>"  size="15"  >
		<input type=hidden name="area" readonly value="<%=UseArea%>"  size="15"  >
		<input type=hidden name="tnunitprice" readonly  value="<%=UserUnitPrice%>"  size="15"  >
   	    <input type=hidden name="jzunitprice" readonly value="<%=SaleUnitPrice%>"  size="15"  >
        <input type=hidden name="fx" readonly  value="<%=RoomType %>"  size="15"   onChange="toUpper(document.cus.roomno)">
        <input type=hidden name="sumprice" readonly value="<%=SaleSumPrice %>"  size="15"  >
		<input type=hidden name="zx" readonly value="<%=Fitment %>"  size="15"   >
        <input type=hidden name="fl"  readonly value="<%=Room_Type%>" size="15"  >
    <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;建筑面积</td>
      <td width="19%" align=left class=roomright><div id="idjzarea">&nbsp;<%=SaleArea %></div></td>
      <td width="15%" align=left class=roomleft>&nbsp;套内建筑面积</td>
      <td   align=left class=roomright width="20%"><div id="idusearea">&nbsp;<%=UseArea%></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;套内建筑<br>&nbsp;面积单价</td>
      <td width="19%" class=roomright align=left><div id="idunitprice">&nbsp;<%=UserUnitPrice%></div></td>
    </tr>
    <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;建筑面积单价</td>
      <td width="19%" align=left class=roomright><div id="idsaleunitprice">&nbsp;<%=SaleUnitPrice%></div></td>
      <td width="15%" align=left class=roomleft>&nbsp;房间总价</td>
      <td   align=left class=roomright width="20%"><div id="idsumprice">&nbsp;<%=SaleSumPrice %></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;</td>
      <td width="19%" class=roomright align=left>&nbsp; 　</td>
    </tr>
  </table>
    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">        
	 <tr> 
      <td colspan="8" align="center"  bgcolor="#CFE6EB"></td> 
    </tr>
   </table>

  <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
    <tr> 
      <td  colspan=3 align="center" bgcolor="#CFE6EB">客 户 资 料</td>
    </tr>
    <tr> 
      <input type=hidden name="cusname" value="<%=cusno %>">
      <td width="16%" class=roomleft >&nbsp;客户姓名</td>
      <td colspan="2" class=roomright>&nbsp;<input type=text disabled   name="cusname1"  size=50 value="<%=cusname %>"  onkeydown="key(document.cus.carid)" title="如果多个姓名，请用'/'分隔">
       <!-- <font color=red>*</font> 
        <input type=button name=FindB  value="查找" onclick="FindOption();">
      　 
        <input type=button name=FindB  value="查找" onclick="FindOption();">
        <input type=button name=FindB  value="详情" onclick="xiangqing();">
		  -->
      <td width="2%"></td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;身份证号</td>
      <td class=roomright>&nbsp;<input type=text disabled  name="carid"  size=50  value="<%=ID_Card %>"  onkeydown="key(document.cus.tel)">
        　</td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;联系电话</td>
      <td class=roomright >&nbsp;<input type=text disabled  name="tel"  size=30   value="<%=Phone %>" onKeyDown="key(document.cus.bbj)">
     
       手机： 
        <input type=text disabled  name="sj"  size=11  value="<%=sj %>" onKeyDown="key(document.cus.addr)">
   
	   
       　</td>
    </tr>
	
    <tr> 
	<td width="16%" class=roomleft>&nbsp;联系地址</td>
         <td class=roomright >&nbsp;<input type=text disabled  name="Address"  size=50  value="<%=Address %>" onKeyDown="key(document.cus.shouji)">
      </td>
    
    </tr>

   <!--
    <tr> 
      <td width="16%" class=roomleft >&nbsp;联系地址</td>
      <td  class=roomright>&nbsp; 
        <input type=text disabled  name="addr"  value="<%=Address %>" size=30  onkeydown="key(document.cus.post)">
        邮编: 
        <input type=text disabled size=6 value="<%=Zip_Code %>" Onblur="check(document.cus.post);"  maxlength="6" name=post>
        　</td>
    </tr>
    -->

	
	<tr>
	 <td class=roomleft>&nbsp;优惠赠送
	 </td>
	 <td class=roomright>&nbsp;<input type=text disabled name=youhui size=50 value="<%=youhui %>">
		 <select disabled name=largees OnChange="chang();">
      <%
	    String StrSql="select type,codename from CODE where type='S' order by type";
     ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%out.print("<option>请选择赠品</option>");
		   while (codeRS.next()){
			 out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
        </select>
	 </td>
	</tr>    


    <tr> 
      <td width="16%" class=roomleft >&nbsp;客户类型</td>
      <td  class=roomright>&nbsp;<select disabled name=custype>
          <option value=个人>个人</option>
          <option value=企业>企业</option>
        </select>
        &nbsp;销售员:&nbsp;  
        <select disabled name="seller"  multiple size=1.5  onblur="SelectedSeller();">
          <option value="<%=seller %>" selected><%=seller %></option>
          <option ></option>
          <option ></option>
          <option ></option>
        </select>
        <input disabled type=button name=listlar value="<<" onclick="list1();" title="增加销售员">
        <input disabled type=button name=rem value=">>" onclick="remo();"  title="删除销售员">
        <!--
        <font color=red>*</font> 滞纳金比: 
        <input type=text disabled size=4 name=demurrage value=0.01>
        % </td>
        -->
        <input type=hidden name=demurrage value=0>
    </tr>
			
    <tr> 
      <td width="16%" rowspan="5"   class=roomleft>&nbsp;备&nbsp;注</td>
      <td  class=roomright> 
        &nbsp;<textarea rows="3" disabled name="note" cols="50"  ><%=note %></textarea>
      </td>
    </tr>
  </table>

  <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
    <tr> 
      <td colspan="8" align="center"  bgcolor="#CFE6EB">认&nbsp;购&nbsp;明&nbsp;细</td>
    </tr>
    <tr> 
      <td width="12%" class=roomleft>&nbsp;认购编号</td>
      <td width="12%" class=roomright>&nbsp;<input type=text disabled name="rgsno" value="<%=rgno %>"   size="10"   onChange="toUpper(document.cus.rgsno)" onKeyDown="key(document.cus.cale1)" <%if (rgno.equals("")){ %> onBlur="checkedOrderNoExist('rgno');"<%} %> title="只能是英文字母、数字及"-"组成">
       　</td>
      <td width="19%" class=roomleft>&nbsp;认购日期</td>
      <td width="19%" class=roomright>&nbsp;<input type=text disabled name=Date1 size=10 title="请选择认购日期"  value="<%if (!date.equals(""))out.print(date.substring(0,10)); %>" readonly onchange="key(document.cus.pay);" onKeyDown="key(document.cus.VisaDate)">
        <input type=button name=cale1  value=".."  disabled onClick="fPopUpCalendarDlg(Date1);return false;" title="请选择认购日期">
       </td>
	  
      <td width="15%" class=roomleft>&nbsp;付款方式</td>
      <td width="23%" class=roomright>&nbsp;<select disabled name="pay"      style="width : 100" onKeyDown="key(document.cus.VisaDate)" onChange="charges();"><!--onChange="charges();"-->
    <%if (payment.indexOf(".")<0)payment=payment+".";%>     
     <option value="<%=payment.substring(0,payment.indexOf("."))+"-"+disc1+"-"+dj+"*"+payment.substring(payment.lastIndexOf(".")+1)+"#g" %>"><%=payment %></option>
                 <%
     String sql="select * from PayMent ";
       rs3=ViewBean.executeQuery(sql);
	  String pay="";
	  float dic;
	  String dj1="";
	  String qdate="";
	  String ajdate="";	  
	  String num="";
	   String gddate="";	
     while (rs3.next()){
	    pay=getbyte(rs3.getString("PayName"));
		num=rs3.getString("num");
	    dic=rs3.getFloat("Discont");
		dj1=rs3.getString("prepay");
		qdate=rs3.getString("qdate");
		ajdate=rs3.getString("ajdate");
		gddate=getbyte(rs3.getString("gddate"));
		String dic1=String.valueOf(dic);
	    out.print("<option value='"+pay+"-"+dic1+"-"+dj1+"*"+num+"#"+qdate+"."+ajdate+"g"+gddate+"'>"+pay+"*"+num+"*期</option>");
	  }
	  
	    rs3.close();
     %>
        </select> 
        <input type=hidden name=dis size=6 readonly>
        </td>
    </tr>
    <tr> 
      <td width="19%" class=roomleft>&nbsp;额外优惠</td>
      <td width="19%" class=roomright   >&nbsp;<input type="hidden" name="ewyh1" size=10 value="<%=StrYhMoney %>"><input type=text disabled name="ewyh" size=10 value="<%=StrYhMoney %>" onblur="check(this);count5();"  onkeydown="key(document.cus.curry);">
      </td>

	   <td width="15%" class=roomleft>&nbsp;额外折扣</td>
      <td width="23%"    class=roomright>&nbsp;<input  type=hidden name=abcd1 value="<%=StrEwDisc %>"><input  type=text disabled name=abcd value="<%=StrEwDisc %>" onblur="check(this);count3();" size=8 title="输入格式：9.8*9.5*9.5" onkeydown="key(document.cus.curry);">%        
        　</td>

	  <td width="15%" class=roomleft>&nbsp;优惠备注</td>
      <td width="23%"    class=roomright>&nbsp;<input  type=text disabled name=youhuibeizhu  value="<%=youhuibeizhu %>" size=12 onkeydown="key(document.cus.curry);">
      </td>
      
      <input type=hidden name="ajtype" value="0">
      <!--
	  <input type=button name=abc12 value="确认"  onblur="disc();" >
	  <select disabled name=ajtype disabled OnChange="count();count1();document.cus.cusname1.focus();">
          <option></option>
          <option value=0>商业贷款</option>
          <option value=1>非商业贷款</option>
        </select>
		-->
    </tr>
<%String oldajcs="";
       try{  if (payment.indexOf("(")>0)oldajcs=payment.substring(payment.indexOf("(")+1,payment.indexOf("%"));
	   }catch(Exception s){}
      %>
<input type="hidden" name=oldajcs size=3 value=<%=oldajcs %>>
    <tr> 
      <td width="12%" class=roomleft >&nbsp;成数年限</td>
      <td width="12%"    class=roomright>&nbsp;<input type=text disabled name=ajcs size=3 value=<%=ajcs %>>
<select disabled name=ajyr    style="width : 40" onclick="count();"  onblur="bxRate();" onchange="document.cus.ewyh.focus();">
  <option></option>
  <%for (int i=1;i<=30;i++){
out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"年</option>");
} %>
</select>
       </td>
	<input type=hidden name=yukuan value=0>
      <td width="19%" class=roomleft>&nbsp;首&nbsp;期&nbsp;款</td>
      <td width="19%" class=roomright  >&nbsp;<input  type=text disabled size=9  value="<%=firstmoney%>" name=firstMoney   onblur="check(this);count4();">
        (元)　</td>
      <td width="15%" class=roomleft>&nbsp;按揭款</td>
      <td width="23%" class=roomright  >&nbsp;<input  type=text disabled size=10 value="<%=ajmoney %>"  name=ajmoney onblur="check(this);count3();">(元)　</td>
      
     
    </tr>
    <tr>
<td width="19%" class=roomleft >&nbsp;成交总价</td>
      <td width="19%"    class=roomright>&nbsp;<input type=text disabled name="dicprice" value="<%=salprice %>"  size="10" onchange="check(this);charges();" onkeydown="key(document.cus.cjjzprice);">元
   <input type=hidden name="countdiscprice" value="<%=salprice %>">
        <input type=hidden value=0 readonly name="MonthMoney"     size="10"  >
      </td>
      <td width="15%" class=roomleft>&nbsp;定 金</td>
      <td width="23%" class=roomright  >&nbsp;<input type=text disabled value="<%=dj %>" name="earnest"  readonly   size="10"  >
        　</td>     
      <td width="15%" class=roomleft>&nbsp;币&nbsp;&nbsp;&nbsp;&nbsp;种</td>
      <td width="23%" class=roomright  >&nbsp;<select disabled name="curry" style="width : 40" OnChange="CurrRa();">
         <option value="￥">人民币</option>
          <option value="HKD">港元</option>
          <option value="USD">美元</option>
        </select><input type=text disabled name="rate"  value=1.0  size="4" title="汇率" >
        　　</td>
    </tr>
    <tr>
      <td width="12%" class=roomleft >&nbsp;成交建筑<br>&nbsp;面积单价</td>
      <td width="12%" class=roomright >&nbsp;<input type=text disabled name="cjjzprice" value="<%=saleJzPrice %>" size=10 ></td>
      <td width="19%" class=roomleft >&nbsp;成交套内<br>&nbsp;建筑面积单价</td>
      <td width="19%"    class=roomright>&nbsp;<input type=text disabled name="cjtnprice"  value="<%=saleUsePrice %>" size=10> 元　</td>
       <td width="19%" class=roomleft >&nbsp;合同类别</td>
      <td width="19%" class=roomright >&nbsp;<select disabled name="httype"><option value=0>内销</option><option value=1>外销</option></select></td>  
   
    </tr>
  </table>

    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
    <tr bgcolor="#CFE6EB" align="center"> 
      <td width="16%" colspan="6">签&nbsp;约&nbsp;明&nbsp;细</td>
     
    </tr>
    <tr > 
      <td width="16%"  class=roomleft>已交首期款</td>
      <td width="18%"  class=roomright>&nbsp;<input type=text disabled size=10 value="<%=factmoney %>"><input type=hidden name="firstFT" value="1" style="width : 105"></td>
      <td width="16%"  class=roomleft>合同编号</td>
      <td width="18%"  class=roomright>&nbsp;<input type=text disabled name="constractno" value="<%=ContractNo %>"  <%if (ContractNo.equals("")){ %> onBlur="checkedOrderNoExist('htno');"<%} %> size="12"    onblur="checkedOrderNoExist(this.value);" OnChange="toUpper(document.cus.constractno)" onkeydown="key(document.cus.QYDate)" title="只能是英文字母、数字及"-"组成"></td>
      <td width="14%"  class=roomleft>签约日期
      </td> 
      <td width="18%"  class=roomright>&nbsp;<INPUT type=text disabled  NAME=QYDate value="<%if (state.equals("2")&&!VisaDate.equals(""))out.println(VisaDate.substring(0,10)); %>" size=10 readonly title="请选择签约日期"   onkeydown="key(document.cus.kkrate)"><input type=button name=cale  value=".."  disabled onclick="fPopUpCalendarDlg(QYDate);" title="请选择认购日期"></td>
    </tr>
 <input type="hidden" name="qydate" value="<%=qytxdate %>">
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>按揭银行</td>
      <td width="18%" class=roomright>&nbsp;<select disabled name=ajbk disabled style="width : 105">
         <option></option>
		      <%
	     StrSql="select type,codename from CODE where type='T' order by type";
        codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
			 out.print("<option value='"+getbyte(codeRS.getString("codename"))+"'>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%> 
		</td>
      <td width="14%" class=roomleft>按揭日期</td>
      <td width="18%" class=roomright>&nbsp;<INPUT type=text disabled value="<%if (!StrAjDate.equals("")&&Integer.parseInt(StrAjDate.substring(0,4))>=2000)out.println(StrAjDate.substring(0,10)); %>"  NAME=ajDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=ajc  value=".."  disabled onclick="fPopUpCalendarDlg(ajDate);return false;" title="请选择认购日期"></td>
      <td width="16%" class=roomleft>银行放款日期</td>
      <td width="18%" class=roomright>&nbsp;<INPUT type=text disabled value="<%if (!StrFkDate.equals("")&&Integer.parseInt(StrFkDate.substring(0,4))>=2000)out.println(StrFkDate.substring(0,10)); %>"  NAME=fkDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=fkc  value=".."  disabled onclick="fPopUpCalendarDlg(fkDate);" title="请选择认购日期"></td>
    </tr>
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>公证状态</td>
      <td width="18%" class=roomright>&nbsp;<select disabled name="gz" style="width : 105"><option value="0">未办</option><option value="1">已办</option></select></td>
      <td width="14%" class=roomleft>保险状态</td>
      <td width="18%" class=roomright>&nbsp;<select disabled name="bx" style="width : 105"><option value="0">未办</option><option value="1">已办</option></select></td>
      <td width="16%" class=roomleft>保险金额</td>
      <td width="18%" class=roomright>&nbsp;<input type=text disabled size=13 value="<%=StrBxMoney %>" name=bxmoney></td>
    </tr>
    
    <input type=hidden name=caDate value="1800-01-01">
    <input type=hidden name=aj value="0">
	 <input type=hidden name=orderstate value="1">
  </table>
    <p align="center"> 
   <input type=button name=check value="审核通过" onclick="checkContract(<%=code %>);">  </P>
      <jsp:include page="../finance/showGatheringProcess.jsp" flush="true">
     <jsp:param name="contractno" value="<%=code%>"/>
	  <jsp:param name="cusno" value="<%=cusno%>"/>
	  <jsp:param name="SalePrice" value="<%=salprice%>"/>
   
  </jsp:include>
  <p align="center"> 
    <input type=hidden name=saveorder value="modi">
	<%
	//String check=request.getParameter("check");
	//if (check!=null)
	 %>
  </P>
　
</center>
</form>
</body>

</html>
