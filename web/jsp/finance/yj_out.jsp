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
<title>佣金领取登记</title>
 
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
  <%@ include file="../public_js/CheckSection.jsp"%>
<%
String abc=getbyte1(request.getParameter("asc"));
if (!abc.equals("")){
 String SQL="INSERT INTO commisionOut(seller,money,date,handler) VALUES('";
 SQL+=getbyte1(request.getParameter("seller"))+"',"+getbyte1(request.getParameter("asc1"))+",getdate()  ,'"+(String)session.getAttribute("loginname")+"')";
 ViewBean.executeUpdate(SQL);
 String state="";
 String b2=abc.substring(0,abc.indexOf(","));

 if (Float.parseFloat(b2)>0)state="1";
 abc=abc.substring(abc.indexOf(",")+1);
 b2=abc.substring(0,abc.indexOf(","));
  if (Float.parseFloat(b2)>0)state="2";
 b2=abc.substring(abc.indexOf(",")+1);
 if (Float.parseFloat(b2)>0)state="3";
  
 SQL="UPDATE commisionCount SET state="+state +" where  contract_id in ("+getbyte1(request.getParameter("ids"))+")";
 
 ViewBean.executeUpdate(SQL);
}
 %>
<body bgcolor="#FFFFFF" text="#000000" onload="setSelectMad(document.cus.seller,'<%=getbyte1(request.getParameter("seller")) %>');">
<form name=cus>
<input type=hidden name=secno value="<%=getbyte1(request.getParameter("secno")) %>">
销售员:<select name=seller onchange="document.cus.submit();"><option></option>
  <%String sell="select  seller from seller where section_no in ("+SectionS+")";
ResultSet rs2=ViewBean.executeQuery(sell);
  while (rs2.next()){
	   String Name=getbyte(rs2.getString("seller"));
       out.print("<option value='  "+Name+"'>"+Name+"</option>") ;
	}
  rs2.close();
  %>
        </select>
 <input type=button name=aa value="领取登记" onclick="getseldocs2();">说明:选择要领取佣金的销售员后，选择在应发放的佣金右边的小框后，再点击"领取登记"即可完成，下次将不能再选择已发放的佣金
<table width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr> 
    <td rowspan="2" 　> 
      <div align="center">序号</div>
    </td>
   
    <td rowspan="2" 　 > 
      <div align="center">购买单位</div>
    </td>
       <td rowspan="2" 　 > 
      <div align="center">面积</div>
    </td>
 
   <td rowspan="2" 　> 
      <div align="center">成交总价</div>
    </td>	
      <td rowspan="2" 　> 
      <div align="center">付款方式</div>
    </td>	
	<td rowspan="2" 　 > 
      <div align="center">销售员</div>
    </td>
    <td rowspan="2" 　 > 
      <div align="center">佣金1(认购)</div>
    </td>
     <td rowspan="2" 　 > 
      <div align="center">佣金2(签约)</div>
    </td>
     <td rowspan="2" 　 > 
      <div align="center">佣金3(按揭)</div>
    </td>
  </tr>
  <tr></tr>
<%
 
    
String where=getbyte1(request.getParameter("seller"));
String secno=getbyte1(request.getParameter("secno"));
if (where.equals("选择销售员"))where="";
if (!where.equals(""))where=" and o.seller='"+where.trim()+"'";
String SQL=" select o.introductive, c.seller,o.loft+o.room_no room,o.jzarea,o.rmbprice,o.payment1,c.commision1,c.commision2,c.commision3,c.state,o.VisaDate,o.AjDate,c.contract_id from commisionCount  c,order_contract o where c.contract_id=o.code"+where+" and o.section='"+secno+"' order by o.loft+o.room_no";
 
try{
 ResultSet rs = ViewBean.executeQuery(SQL) ;
 
  int i=1;
  while (rs.next()){ 
     String introductive=rs.getString("introductive");
	String  seller=getbyte(rs.getString("seller").trim()) ;
	String room=getbyte(rs.getString("room"));
	String area=Format.getFloat(rs.getFloat("jzarea"),3);
	float price=rs.getFloat("rmbprice");
	String payment=getbyte(rs.getString("payment1"));
	String commision1=rs.getString("commision1");
	String commision2=rs.getString("commision2");
	String commision3=rs.getString("commision3");
	String state=rs.getString("state");
	String qydate=getbyte(rs.getString("VisaDate"));
	String ajdate=getbyte(rs.getString("AjDate"));
	String contract_id=getbyte(rs.getString("contract_id"));
	String a1="";
	String a2="";
	String a3="";
	//if (qydate.equals(""))a2="disabled ";
	//if (ajdate.equals(""))a3="disabled ";
	if (state.equals("1"))a1="disabled ";
	else if (state.equals("2")){a2="disabled ";a1="disabled ";}
	else if (state.equals("3")){a2="disabled ";a1="disabled ";a3="disabled ";}
 
	String da="";
    if (introductive.equals("1")) da="(介绍)";
   %>
    <tr>
    <td >&nbsp;<%=i++ %></td>
    <td  align="left"  height="19">&nbsp;<%=room %></td>
    <td  align="left" height="19">&nbsp;<%= area%></td>
    <td  align="left" height="19">&nbsp;<%=Format.getFloat(price,0)%></td>
    <td  align="left" height="19">&nbsp;<%=payment%></td>
    <td  align="left" height="19">&nbsp;<%= seller+da%></td>
	<td  align="left" height="19">&nbsp;<%=commision1%><input  type="checkbox" name=commision1<%=i %> value="<%=commision1 %>|<%=contract_id %>" <%=a1 %>  ></td>
	<td  align="left" height="19">&nbsp;<%=commision2%>
	<%if  (!qydate.equals("")){%>
	<input  type="checkbox" name=commision2<%=i %> value="<%=commision2 %>|<%=contract_id %>"  <%=a2 %> ><%}%></td>
	<td  align="left" height="19">&nbsp;<%=commision3%>
	<%if  (!ajdate.equals("")){%>
	<input  type="checkbox" name=commision3<%=i %> value="<%=commision2 %>|<%=contract_id %>"  <%=a3 %>  ><%}%></td>
	 
	
	
	
	</tr>
	 <%
	 }
  }catch(Exception s){out.print(s.getMessage()+SQL);}
  %>

</table>
<input type=hidden name="asc">
<input type=hidden name="asc1">
<input type=hidden name="ids">
</form>
 <script>
 function getseldocs2() {
    var j=0;
 
     var x=0;
	 var x1=0;
	 var x2=0;
	 var seldocs = "";
	  var ida = new Array();
	 var aaa="";
	 var temp=cus.elements.length;
	 if (cus.seller.value==""){alert("选择销售员");return false;}
     for (i=0;i<cus.elements.length;i++) {
       if ((cus.elements[i].type=="checkbox")&&(cus.elements[i].checked))
		 {  var comm=cus.elements[i].name;
            var ddd=cus.elements[i].value;
		  
		    if (comm.substring(0,10)=="commision1"){
		     x+=parseFloat(ddd.substring(0,ddd.indexOf("|")));
			 ida[j]=ddd.substring(ddd.indexOf("|")+1);
			 }
			 if (comm.substring(0,10)=="commision2"){
		     x1+=parseFloat(ddd.substring(0,ddd.indexOf("|")));
			 ida[j]=ddd.substring(ddd.indexOf("|")+1);
			 }
			 if (comm.substring(0,10)=="commision3"){
		      x2+=parseFloat(ddd.substring(0,ddd.indexOf("|")));
			 ida[j]=ddd.substring(ddd.indexOf("|")+1); }
			 aaa="aa"; j++;
   		 }
		
	  }	
	  if (aaa==""){alert("选择付的佣金");return false;}
    seldocs=x+","+x1+","+x2;
    cus.asc.value=seldocs;
    cus.ids.value=ida;
 
	  cus.asc1.value=x+ x1 +x2;
 document.cus.submit();
}

</script>
</body>
</html>
