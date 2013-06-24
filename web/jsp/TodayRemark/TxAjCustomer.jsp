<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>今日应签约客户</title>
</head>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/AcquiesceSection.jsp"%>

<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
<script>
function AlertDate(){
  document.form1.action="YAjCustomer.jsp";
  document.form1.submit();

}
</script>
<%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
<%String DisplayS=China.getParameter(request,"Display"); %>
<%@ include file="../public_js/CheckSection.jsp"%>
<body topmargin="1"　onload="setSelectMad(document.form1.section,'<%= getbyte1(request.getParameter("section")) %>');">


<% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="3"; %>
  <form method="POST" name="form1" action="">
  <input type=hidden name="sel" value="<%=sel %>">
   
  
  
</center>
<script>
function findSub(para){
   document.form1.action=para;
   document.form1.submit();


}
</script>
         <p align="center"><b><font size="3" class=FontColor>应办理按揭客房</font></b></p>
 <!-- <p align="left">
显示 
		<select name="Display" onchange="AlertDate();">
			<OPTION VALUE="d0"></OPTION>
			<OPTION VALUE="d1">已放款</OPTION>
			<OPTION VALUE="d2">未放款</OPTION>
		</select>&nbsp;<input type=button name=Prin value="打印" onclick="window.open('<%=reportAddrs %>QYCustomerRep.rpt');">
</p>  -->

按楼盘显示：<select name="section" onchange="javascript:document.form1.submit();"> 
   <option value=""></option>
   <%	
      String sqls="select SerialNo,Name from CRM_Project"+FindWhere+" group by  Name,SerialNo order by name";
String section=getbyte1(request.getParameter("section"));
	  ResultSet rs2=ViewBean.executeQuery(sqls);
	  String sec="";
	  String no1="";
	  String daa="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
	   if(no1.equalsIgnoreCase(section)){
		   daa=" selected";
		   }else{
			   daa="";
		   }
       out.print("<option value='"+no1+"'"+daa+">"+sec+"</option>");
	  }
	  rs2.close();
     %> </select>

    <%
String sql="";
String StrWhere="  section in  "+FindWhere.substring(FindWhere.indexOf("("));
if (section.equals(""))
  section=StrWhere;
else
   section=" section ='"+section+"'";
	if (!section.equals(""))
		    sql="select * from View_TxAjCustomer where "+section; 
   else 
            sql="select * from View_TxAjCustomer  where "+section; 
	//	}
		//out.print(section);
//设置查询结果的存放变量
int ID=0;
String secno="";
String Section="";
String Building="";
String Room="";
String CusName="";
String SerialNo="";
String CusNo="";
String Date="";
String Date1="";
String SalePrice="";
String State="";
String Loft="";
String Phone="";
String Seller="";
String curr="";
int i=0;
int code=0;
String AjDate="";
String FkDate="";
String AjBk="";
int AjMoney=0;
//out.print(sql);
//Add try...catch for search,2001-09-06
try{
	ResultSet rs=ViewBean.executeQuery(sql);
%>
<table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=TXTColor  >
      <td align="center" height="4"   >序号</td>
      <td  align="center" height="23"   >房间代码</td>
      <td  align="center" height="23"   >客户</td>
	   <td align="center" height="23"   >联系电话</td>
	   <td  align="center" height="23"   >签约日期</td>
    <td  align="center" height="23"   >按揭金额</td>
      <td  align="center" height="23"   >应按揭日期</td>

  
    </tr>
<%

	while (rs.next()){
	  i++;
	  //按FIELDS顺序一GET　VALUE
	  code=rs.getInt("code");
	  secno=getbyte(rs.getString("section"));
	  Section=getbyte(rs.getString("sectionname"));
	  Loft=getbyte(rs.getString("Loft"));
	  Room=rs.getString("Room_no");
	  CusNo=getbyte(rs.getString("customer"));
	  String visadate =getbyte(rs.getString("visadate"));
	  CusName=getbyte(rs.getString("Cus_Name"));
	  Phone=getbyte(rs.getString("phone"))+" "+getbyte(rs.getString("sj"));
	  AjMoney=rs.getInt("AjMoney");
	 // AjBk=getbyte(rs.getString("AjBk"));
	//  AjDate=getbyte(rs.getString("AjMonney"));
	  FkDate=getbyte(rs.getString("ajtxdate"));
	 // if (!FkDate.equals(""))
	  //  FkDate=FkDate.substring(0,10)	  ;
     //else FkDate="未放款";		
 %> 
 
 

	<tr id=TR<%=i %> align="center"  class='listcontent' onmouseover="mout(this);" onclick="changeclass1(this,'clickbg','listcontent');" > 
     <!--td   ><%=Section%></td>
	 <td   ><%=Loft%></td-->
	<td   ><%=i%></td> 
	 <td><%=Section+Loft+Room%></td>
     <td><a href="javascript:xiangqing('<%=CusNo%>');"><%= CusName %></a></td>
	  <td  align="center" ><%= Phone %></td>
	    <td  align="center" ><%= visadate.substring(0,10) %></td>
        <td  ><%=AjMoney%></td>
	  <td  ><%=FkDate%></td>
     <!--	      <td  align="left"><a href="#" onclick="openwin1('../finance/yingshi.jsp?contractno=<%=code %>&cusno=<%=CusNo %>&loft=<%=Section+Loft %>',650,570,50,50);"><%=curr+SalePrice%></a> </td>-->

    </tr>
    <%

  }
  rs.close();

}catch(Exception se){
	out.print("系统出错，出错如下：");
	out.print(se.getMessage()+sql);
	out.close(); 
}
if (i==0)out.print("当前没有任务");
%> 
  </table>
<script>

function xiangqing(pa1) {
	
    var spa = 400 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa/3 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=400"  ;
    var posi = posi + ",width=550";
    var newwin1=window.open("../customter/editcustomer.jsp?edit=editcus&cusno="+pa1,"NewsW1","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
 
}
function contractlist(pa1,pa2,pa3,pa4,pa5){
  openwin1("../sale/ContractInput.jsp?secname="+pa1+"&secno="+pa2+"&roomno="+pa3+"&build="+pa4+"&loft="+pa5+"&show=true",680,530,120,2);

}

</script>
</body>
</form>
</html>