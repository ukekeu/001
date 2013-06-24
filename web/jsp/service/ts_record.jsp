    <%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>投诉一览</title>
</head>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>  
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/>  
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/AcquiesceSection.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
<script>
function AlertDate(){
  document.form1.action="ts_record.jsp";
  document.form1.submit();

}
function paulsel(){
		document.form1.submit();
	}
</script>
<%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
<%String DisplayS=China.getParameter(request,"Display"); %>

<%
 
String section=request.getParameter("section");
String paulurl="";
if(section==null || section.equals(""))
{
	paulurl="";
}else{
	paulurl=" and TS_SECTION='"+section+"'";
}
%>
<%@ include file="../public_js/countpagenum.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<body onload="setSelectMad(document.form1.Display,'<%= DisplayS %>');setSelectMad(document.form1.section,'<%= section %>');">
 <% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="0"; %>
  <form method="POST" name="form1" action="">
  <input type=hidden name="sel" value="<%=sel %>">
  <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=0;findSub('ts_record.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>业主投诉</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.form1.sel.value=1;findSub('ts_record.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>非业主投诉</font></a>
	</td>
	 
	</tr></table>
  
  
</center>
<script>
function findSub(para){
   document.form1.action=para;
   document.form1.submit();


}
</script>
         <p align="center"><b><font size="3" class=FontColor>投诉一览</font></b></p>
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
		</select>&nbsp;<input type=button name=Prin value="打印" onclick="window.open('<%=reportAddrs %>QYCustomerRep.rpt');">
		按楼盘显示：<select name="section" onchange="paulsel();"> 
   <option value=""></option>
   <%	
      String sql1="select SerialNo,Name from  CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";

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
     %> </select>
</p>  


<input type=button name=add  value="增 加" onclick="openwin1('ts_input.jsp',550,550,10,10);">&nbsp;<input type=button name=ap  value="派　单" onclick=" pddj();">&nbsp;<input type=button name=en  value="完 成" onclick="pdwc();">
 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=1 ALIGN=center>
  <tr class=TXTColor ALIGN=center >
 
    <td   rowspan="2">序号</td>
    <td  rowspan="2">投诉客户</td>
    <td   rowspan="2">所在单元</td>
    <td   rowspan="2">投诉主题</td>
	  <td  rowspan="2">类别</td>
    <td  rowspan="2">投诉日期</td>
    <td  colspan="3">处理情况</td>
	
  </tr>
  <tr >
  <td><table  BORDER=1  width="100%" bgcolor="#c0c0c0" CELLSPACING=1 CELLPADDING=1><tr> <td  >派单</td>
    <td  >完成</td>
    <td  >反馈</td></tr></table></td>
  
  </tr>

	  
    
    <%

	FindWhere=" where  TS_SECTION "+FindWhere.substring(FindWhere.indexOf("in")) ;
String sql="";
 
if (DisplayS.equals(""))DisplayS="d0";
DisplayS=DisplayS.substring(1);
	//设定查询
	
		if (DisplayS.equals("0")) {
	   		sql="select Top "+pageSize+"  *  from TS_SERVICER "+FindWhere+paulurl+" and TS_CUSTOMER_TYPE="+sel+" and   convert(char(24),TS_DATE,111)<=convert(char(24),getdate(),111) and  TS_Code not in (Select top "+prenum +" TS_Code from TS_SERVICER "+FindWhere+paulurl+" and  convert(char(24),TS_DATE,111)<=convert(char(24),getdate(),111) order by TS_DATE )  order by TS_DATE";
sqlcount="select count(TS_Code) code from TS_SERVICER "+FindWhere+paulurl+" and TS_CUSTOMER_TYPE="+sel;
	 
		}else{
			sql="select * from  TS_SERVICER "+FindWhere+paulurl+" and TS_CUSTOMER_TYPE="+sel+" and convert(char(24),dateadd(dd,-"+DisplayS+",TS_DATE),111)<=convert(char(24),getdate(),111) order by TS_DATE";

		}
		//out.print(sql);
//设置查询结果的存放变量
int ID=0;
 
int i=0;
//out.print(sql);
//Add try...catch for search,2001-09-06
try{
	ResultSet rs=ViewBean.executeQuery(sql);
%>

<%String str="string";
 
	while (rs.next()){
	  i++;
	  //按FIELDS顺序一GET　VALUE
	  String TS_code=getbyte(rs.getString("TS_code"));
	  String TS_CUSTOMER=getbyte(rs.getString("TS_CUSTOMER"));
	  String TS_ROOM=getbyte(rs.getString("TS_ROOM"));
	  String TS_TITLE=getbyte(rs.getString("TS_TITLE"));
	  String TS_DATE=getbyte(rs.getDate("TS_DATE").toString());
	  String TS_TYPE=rs.getString("TS_TYPE");
	  String TS_CONTEXT=getbyte(rs.getString("TS_CONTEXT"));
	  String TS_STATE=getbyte(rs.getString("TS_STATE"));
	  String TS_COMM_DATE=getbyte(rs.getString("TS_COMM_DATE"));
	  String TS_END_CONTEXT=getbyte(rs.getString("TS_END_CONTEXT"));
	  String TS_END_DATE=getbyte(rs.getString("TS_END_DATE"));
	   
	  
 %> 
 
	 
	<tr id=TR<%=i %> align="center"  class='listcontent' onmouseover="mout(this);" onclick="changeclass1(this,'clickbg','listcontent');pd(<%=TS_code %>);" > 
   
	<td    ><%=i%></td> 
      <td   ><%=TS_CUSTOMER%></td>
      <td align="left"><%=TS_ROOM%></td>
	  <td   align="left" ><%=TS_TITLE%></td>
	    <td  align="left" ><%=TS_TYPE%></td>
      <td   ><%=TS_DATE%></td>
      <td>
	  <table width="100%" BORDER=1  >
	  <%if (TS_STATE.equals("1")){ %>
	    <tr> <td  bgcolor="#ff00ff" >  &nbsp;</td>
         <td  >&nbsp; </td>
         <td  >&nbsp; </td>
		 </tr>
		 <%}else if (TS_STATE.equals("0")){  %>
		  <tr> <td   >&nbsp;</td>
         <td  > &nbsp;</td>
         <td  > &nbsp;</td>
		 </tr>
		 <%}else if (TS_STATE.equals("2")){  %>
		  <tr> <td bgcolor="#ff00ff" >&nbsp; </td>
         <td  bgcolor="#ff0000" >&nbsp; </td>
         <td  >&nbsp; </td>
		 </tr>
		 <%} %>
	</table>
	</td>
  
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
  <script>
  
  var TS_code="";
  function pd(para){
     TS_code=para;
	 
  }
  function pddj(){
    openwin1("ts_pd.jsp?ts_code="+TS_code,500,550,10,10);
 
  }
   function pdwc(){
    openwin1("ts_wc.jsp?ts_code="+TS_code,500,550,10,10);
 
  }
  </script>
</body>
</form>
</html>