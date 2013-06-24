<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/yonghuhuodong.jsp" %>
<%
setYongHuHuoDong( setYongHuHuoDongBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "今日备忘-->按揭情况客户" , 
                  "浏览"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>已按揭客户</title>
</head>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/AcquiesceSection.jsp"%>

<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
<script>
function AlertDate(){
  document.cus.action="YAjCustomer.jsp";
  document.cus.submit();

}
</script>
<%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
<%String DisplayS=China.getParameter(request,"Display"); %>
<%aBean.executeUpdate("update ajcustomerlist set out=0");
 
String section=request.getParameter("section");
String paulurl="";
if(section==null || section.equals(""))
{
	paulurl="";
}else{
	paulurl=" and section='"+section+"'";
}
%>
<%@ include file="../public_js/CheckSection.jsp"%>
<body onload="setSelectMad(document.cus.Display,'<%= DisplayS %>');setSelectMad(document.cus.section,'<%= section %>');">

  <form method="POST" name="cus" action="">
         <p align="center"><b><font size="3" class=FontColor>按揭客户情况</font></b></p>
  <p align="left">
显示 
		<select name="Display" onchange="AlertDate();">
			<OPTION VALUE="d0"></OPTION>
			<OPTION VALUE="d1">已放款</OPTION>
			<OPTION VALUE="d2">未放款</OPTION>
		</select>&nbsp;<input type=button name=Prin value="打印" onclick="window.open('<%=reportAddrs %>AjCustomerList.rpt');">
  按楼盘显示：<select name="section" onchange="javascript:document.forms[0].submit();"> 
   <option value=""></option>
   <%	
      String sqls="select SerialNo,Name from section"+FindWhere+" group by  Name,SerialNo order by name";

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
</p>  
    <%
		String FindWhere1="";
  if ( !SecNo.equals("") ) { 
    FindWhere1=" and section='"+SecNo+"'";
  }else{
    FindWhere1=" and section in("+SectionS+")";
  }
String sql="";
if (DisplayS.equals(""))DisplayS="d0";
DisplayS=DisplayS.substring(1);
	//设定查询
	
		if (DisplayS.equals("1")) {
	   		sql="select * from YAjCustomer  where not fkdate  is null"+FindWhere1+paulurl;
		}else if (DisplayS.equals("2")) {
			sql="select * from YAjCustomer where  fkdate  is null"+FindWhere1+paulurl;
		}else{
		    sql="select * from YAjCustomer where code >0 "+paulurl+FindWhere1;
		}
		//out.print(DisplayS);
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
<table BORDER=0 width="110%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=TXTColor  >
      <td align="center" height="4"   >序号</td>
      <td  align="center" height="23"   >房间代码</td>
      <td  align="center" height="23"   >客户</td>
	   <td align="center" height="23"   >联系电话</td>
   
      <td  align="center" height="23"   >按揭日期</td>
	  <td  align="center" height="23"   >放款情况</td>
  
    </tr>
<%String allname="";

	while (rs.next()){
	  i++;
	  //按FIELDS顺序一GET　VALUE
	  code=rs.getInt("code");
	  secno=getbyte(rs.getString("section"));
	  Section=getbyte(rs.getString("sectionname"));
	  Loft=getbyte(rs.getString("Loft"));
	  Room=rs.getString("Room_no");
	  allname=Section+Loft+Room;
	  CusNo=getbyte(rs.getString("customer"));
	  aBean.executeUpdate("update ajcustomerlist set out=1 where roomno='"+allname+"'");
	  CusName=getbyte(rs.getString("Cus_Name"));
	  Phone=getbyte(rs.getString("phone"));
	  AjMoney=rs.getInt("AjMoney");
	  AjBk=getbyte(rs.getString("AjBk"));
	  AjDate=getbyte(rs.getString("Ajdate"));
	  FkDate=getbyte(rs.getString("fkdate"));
	  if (!FkDate.equals(""))
	    FkDate=FkDate.substring(0,10)	  ;
     else FkDate="未放款";		
 %> 
 
 

	<tr id=TR<%=i %> align="center"  class='listcontent' onmouseover="mout(this);" onclick="changeclass1(this,'clickbg','listcontent');" > 
     <!--td   ><%=Section%></td>
	 <td   ><%=Loft%></td-->
	<td   ><%=i%></td> 
	 <td><a href="javascript:contractlist('<%=Section %>','<%=secno %>','<%=Room %>','','<%=Loft %>');"><%=Section+Loft+Room%></a></td>
     <td><a href="javascript:xiangqing('<%=CusNo%>');"><%=Repalce(CusName,"/")%></a></td>
	  <td  align="left" ><%=Repalce(Phone,"/")%></td>
      <td  ><%=AjDate.substring(0,10)%></td>
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