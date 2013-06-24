<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
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
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>  
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/>  
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
    <jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/AcquiesceSection.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
<script>
function AlertDate(){
  document.form1.action="QYCustomer.jsp";
  document.form1.submit();

}
function paulsel(){
		document.form1.submit();
	}
</script>
<%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
<%String DisplayS=China.getParameter(request,"Display"); %>

<%
aBean.executeUpdate("update VIEW_QYCustomer set out=0");
String section=request.getParameter("section");
String paulurl="";
if(section==null || section.equals(""))
{
	paulurl="";
}else{
	paulurl=" and serialno='"+section+"'";
}
%>
<%@ include file="../public_js/countpagenum.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<body  topmargin="1" onload="setSelectMad(document.form1.Display,'<%= DisplayS %>');setSelectMad(document.form1.section,'<%= section %>');">
 <% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="1"; %>
  <form method="POST" name="form1" action="">
  <input type=hidden name="sel" value="<%=sel %>">
  
  
  
</center>
<script>
function findSub(para){
   document.form1.action=para;
   document.form1.submit();


}

 
var sendmess="";
var sendto="";
function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
	 
    }

}
function chhoseData1(){
sendmess="";
sendto="";
   for (var i=0;i<document.form1.choos.length;i++){
 	 
	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].value;
		
	    if (sendmess=="")
		 sendmess=aa.substring(0,aa.indexOf("|"));
		else
		 sendmess+=","+aa.substring(0,aa.indexOf("|"));
	  
	    if (sendto=="")
		 sendto=aa.substring(aa.indexOf("|")+1);
		else
		 sendto+=","+aa.substring(aa.indexOf("|")+1);
	  
	  }
    }

}
function sendmessage()
{
chhoseData1();
 if (sendmess==""){alert("选择的客户可能没有记录手机号");return false;}
  openwin1("../../sendmessage/SendMessage.jsp?messtype=0&sendmess="+sendmess+"&sendto="+sendto,400,300,100,100);
}
function printTx(){
 
 if (document.form1.section.value==""){alert("请选择楼盘名称");return false;}
   openwin1("../TodayRemark/pQYCustomer.jsp?section="+document.form1.section.value+"&Display="+document.form1.Display.value,750,600,10,10);
 }
  </script>
  <%String menu= (String)session.getAttribute("menu");
 
if (menu==null)menu="1";
    String menusel=China.getParameter(request,"menusel");
    if(menusel.equals("")) menusel="3";
	
	
	 %>
	<table width="320" border="0" cellspacing="0" cellpadding="0" class="L2"  >
    <tr> 
    <td  class="<%if(menusel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=3;findSub('visitcusview_alert.jsp');""><font color='<%if(menusel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>跟进提醒</a>
	</td>
     <td  class="<%if(menusel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=0;findSub('yl_alert.jsp');""><font color='<%if(menusel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>预留提醒</a>
	</td>
	  <td  class="<%if(menusel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=2;findSub('ld_alert.jsp');""><font color='<%if(menusel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>临定提醒</a>
	</td>
   <td class="<%if(menusel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#"onclick="document.form1.menusel.value=1;findSub('QYCustomer.jsp');""><font color='<%if(menusel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>签约提醒</a>
	</td> 
	</tr>
	</table>
	  <input type=hidden name="menusel" value="<%=menusel %>">
	    <input type=hidden name="sel" value="<%=sel %>">
         <p align="center"><b><font size="3" class=FontColor>应签约客户</font></b></p>
  <p align="left">
显示 
		<select name="Display" onchange="AlertDate();">
			<OPTION VALUE="d0">今日</OPTION>
			<OPTION VALUE="d1">提前1天提醒</OPTION>
			<OPTION VALUE="d2">提前2天提醒</OPTION>
			<OPTION VALUE="d3">提前3天提醒</OPTION>
			<OPTION VALUE="d4">提前4天提醒</OPTION>
			<OPTION VALUE="d5">提前5天提醒</OPTION>
			<OPTION VALUE="d6">提前6天提醒</OPTION>
		</select>&nbsp;<input type=button name=Prin value="打印" onclick="printTx();">
		按楼盘显示：<select name="section" onchange="paulsel();"> 
   <option value=""></option>
   <%	
      String sql1="select SerialNo,Name from CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";

	  ResultSet rs2=ViewBean.executeQuery(sql1);
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
     %> </select>&nbsp;&nbsp;&nbsp;&nbsp; <input type=button name=sendmess value="发送短信" onclick="sendmessage();">
</p>  



    <%
String sql="";
if (DisplayS.equals(""))DisplayS="d0";
DisplayS=DisplayS.substring(1);
	//设定查询
	
		if (DisplayS.equals("0")) {
	   		sql="select Top "+pageSize+"  *  from VIEW_QYCustomer "+FindWhere+paulurl+" and  convert(char(24),qytxdate,111)<=convert(char(24),getdate(),111) and  id not in (Select top "+prenum +" id from VIEW_QYCustomer "+FindWhere+paulurl+" and  convert(char(24),qytxdate,111)<=convert(char(24),getdate(),111) order by serialno,loft,floors,room_no,qytxdate desc )  order by serialno,loft,floors,room_no,qytxdate desc";
sqlcount="select count(id) code from VIEW_QYCustomer "+FindWhere+paulurl+" and  convert(char(24),qytxdate,111)<=convert(char(24),getdate(),111)";
	
		}else{
			sql="select * from VIEW_QYCustomer  "+FindWhere+paulurl+" and convert(char(24),dateadd(dd,-"+DisplayS+",qytxdate),111)<=convert(char(24),getdate(),111) order by serialno,loft,floors,room_no,qytxdate DESC";
            sqlcount="select count(id) code from VIEW_QYCustomer  "+FindWhere+paulurl+" and convert(char(24),dateadd(dd,-"+DisplayS+",qytxdate),111)<=convert(char(24),getdate(),111)";
		}
		// out.print(sql);
//设置查询结果的存放变量
int ID=0;
String Section="";
String Building="";
String Room="";
String CusName="";
String SerialNo="";
String Date="";
String Date1="";
String SalePrice="";
String State="";
String Loft="";
String Phone="";
String Seller="";
String curr="";
String sj="";
int i=0;
String sectinno="";
//out.print(sql);
//Add try...catch for search,2001-09-06
try{
	ResultSet rs=ViewBean.executeQuery(sql);
%>

<%String str="string";

	while (rs.next()){
	  i++;
	  //按FIELDS顺序一GET　VALUE
	 sectinno=getbyte(rs.getString("SerialNo"));
	  Section=getbyte(rs.getString("Name"));
	  Loft=getbyte(rs.getString("Loft"));
	  Building=getbyte(rs.getString("building"));
	  Room=rs.getString("Room_no");
	  CusName=getbyte(rs.getString("Cus_Name"));
	  Phone=getbyte(rs.getString("phone"));
	  sj=getbyte(rs.getString("sj"));
	  if (Phone.equals(""))Phone=sj;
		else Phone=" "+sj;
	   SerialNo=rs.getString("orderno");
	  Date=rs.getString("Date");
	   String sqQing = " select sum(shouldMoney) shouldMoney,sum(yijiao) as yijiao from GatheringRecord where";
              sqQing=sqQing + " cusno = '" + rs.getString("customer") + "' ";
              sqQing=sqQing + " and contactno = '" + rs.getString("id") + "' " ;
						
        ResultSet rsQing = fBean.executeQuery( sqQing ) ;
        double summoney = 0 ;
        double yj_money = 0 ;
        if( rsQing.next() ) {
            summoney= rsQing.getDouble( "shouldMoney" ) ;
            yj_money = rsQing.getDouble( "yijiao" ) ;
         
        }
        rsQing.close() ;
	 
	
	  Seller=getbyte(rs.getString("Seller"));
	  SalePrice=fa.getFloat2(rs.getDouble("RMBPRICE"),2);
	  curr=getbyte(rs.getString("currency"));
	    Date1=getbyte(rs.getString("qytxdate"));
		 String floors=getbyte(rs.getString("floors"));
	  if (str.equals("string")){
	  
 %> 

<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"   bgcolor="efefef" >
      <td align="center" height="4"   ><input type=checkbox name=ch onclick="chhoseData(this.checked);">序号</td>
      <td  align="center" height="23"   >房间代码</td>
      <td  align="center" height="23"   >客户</td>
	   <td align="center" height="23"   >联系电话</td>
      <td  align="center" height="23"  >认购书编号</td>
      <td  align="center" height="23"   >认购日期</td>
	 <td  align="center" height="23"   >应签约日期</td>
      <td align="center" height="23"   >成交价</td>
	  <td align="center" height="23"   >已收首期款</td>
      <td align="center" height="23"   >销售员</td>
	   
    </tr>
	<%} %>
	<tr id=TR<%=i %> align="center"  title="双击可以弹出合同信息"   ondblclick="openwin1('../sale/showContract.jsp?secname=&secno=<%=sectinno %>&roomno=<%=Room %>&build=&loft=<%=Loft%>&Floor=<%=floors %>&show=true',680,530,50,2);"  onmouseover="mout(this);" onclick="changeclass1(this,'clickbg','listcontent');" > 
     <!--td   ><%=Section%></td>
	 <td   ><%=Loft%></td-->
	<td   ><input type=checkbox name=choos value="<%=sj %>|<%=Section+Loft+Room%>"><%=i%></td> 
      <td  ><%=Section+Loft+Room%></td>
      <td  align="center"><%=CusName%></td>
	  <td  align="center" ><%=Phone%>&nbsp;</td>
      <td  ><%=SerialNo%>&nbsp;</td>
      <td  ><%=Date.substring(0,10)%></td>
	   <td  ><%=Date1.substring(0,10)%></td>
	      <td  align="center"><%=SalePrice%> </td>
	   
		 <td align="center" ><%=fa.getFloat2(yj_money,2)	%> 
	 </td>
	  <td  align="center"><%=Seller%>&nbsp;</td>
    </tr>
    <%
	str="aa";
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
  <%@ include file="../public_js/changepage.jsp"%>
</body>
</form>
</html>