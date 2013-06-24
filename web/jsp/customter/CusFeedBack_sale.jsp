<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<%@ include file="../public_js/qx_checke.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>登记成交客户跟踪记录</title>
</head>


<script language="javascript" src="../public_js/public.js"></script>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script>
function FindOption(){
var str="";
 
	   openwin1("../sale/newcustomer.jsp?section="+document.cus.section.value+"&FindCus="+document.cus.FindName.value,350,380,300,100);
	 
}
</script>	
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
     <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/CheckSection.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>

<%String StrCusNo=request.getParameter("cusno");//传送客户编号
 if (StrCusNo==null)StrCusNo="";
 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";								
 String sql2="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
      ResultSet rs2=ViewBean.executeQuery(sql2);
	  String sec="";
	  String no="";
%>
<script>
function check(aForm){
  if (document.cus.fc.value==""){alert("请填写客户反馈信息！");document.cus.fc.focus(); return false;}
   if (document.cus.seller.value==""){alert("请选择跟踪人！");document.cus.seller.focus();return false;}
   if (document.cus.year.value==""){alert("请选择跟踪日期！");document.cus.year.focus();return false;}

  
 return (true);
}
</script>
<body  oncontextmenu="return false" > 
<p align=center><font size=3 class=FontColor><b>登记客户跟踪记录</b></font></p>
<form method="POST" name="cus" action="InsertCusTail.jsp?cusno=<%=StrCusNo %>" onsubmit="return check(this);">
<table width="100%" border="0" cellspacing="1"  cellpadding="1" >
 
  <tr>
    <td width="76" class=roomleft >&nbsp;跟踪记录</td>
    <td width="490" class=roomright><textarea rows="5" name="fc" cols="54"></textarea>　</td>
  </tr> 
  <tr>
    <td width="76"class=roomleft>&nbsp;业&nbsp;务&nbsp;员</td>
    <td width="490"class=roomright>
      <table border="0" width="100%">
        <tr> 
		<%String job=(String)session.getAttribute("job");	
		String user=(String)session.getAttribute("loginname");	
	   if (job.indexOf("销售员")<0){user="";} %>
          <td width="10%"class=roomright><select size="1" name="seller" onkeydown="key(document.cus.demand)"  >
    <option value=""></option>
 
  <%String sell="select  seller from seller where section_no in ("+SectionS+")";
rs2=ViewBean.executeQuery(sell);
  while (rs2.next()){
	   String Name=getbyte(rs2.getString("seller"));
	   String choosename ="";
	    if (job.indexOf("销售员")>=0){if (user.equals(Name)){choosename="selected";}}
       out.print("<option value='  "+Name+"' "+choosename+" >"+Name+"</option>") ;
      
	}
  rs2.close();
  
  %>
  <%  java.util.Date curDate=new java.util.Date();
	int CurYear=curDate.getYear()+1900;
	int CurMonth=curDate.getMonth()+1;
	int CurDay=curDate.getDate();
	String CDate=CurYear+"-"+CurMonth+"-"+CurDay;
%>
    </select>   
      </td>
          <td width="10%"class=roomleft >&nbsp;跟进日期</td>
          <td width="40%"class=roomright><input type=text size="10" name="year" value="<%=CDate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(year);return false">       <input type=text size="3" name="alertday" value=2>天之后再提醒继续跟踪
       </td>   
          
		  <input type=hidden name="yn">
		  
        </tr>
      </table>
    </td>
  </tr>
</table>
<p>
<div align="center"> 
 <%
 String SQL1="SELECT code,serialNo FROM tb_chengyi WHERE serialNo='"+StrCusNo+"'";
 rs2=ViewBean.executeQuery(SQL1);
 String serialNo="",id="";
 if (rs2.next()){serialNo=rs2.getString("serialNo");
 id=rs2.getString("code");
 }
 rs2.close();
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"C002");
   if (Cortrol==null)Cortrol="";
     %>
	  <%if (Cortrol.indexOf("A")>=0){  %>
            &nbsp;&nbsp;<input type="submit" value="提　交" name="submit"  >
			<%} %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="button" value="退  出" name="cancel" onclick="window.close();">
          </div>
</p>
  </form>    
  <p align="center">跟踪记录</p>
  <table height=16  width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr align="center"><td height=16   width="15%" >&nbsp;跟踪日期</td><td height=16   width="60%" >反馈内容</td><td height=16   width="15%">跟踪人</td></tr>

<%
String SQL="SELECT date,fc,seller FROM tail_after WHERE cusno='"+StrCusNo+"'";
 rs2=ViewBean.executeQuery(SQL);
while (rs2.next()){
%>
<tr><td height=16  width="15%" align="center">&nbsp;<%=rs2.getDate("date").toString() %></td><td height=16  width="60%"><%=getbyte(rs2.getString("fc")) %>&nbsp;</td><td height=16  width="15%" align="center">&nbsp;<%=getbyte(rs2.getString("seller")) %></td></tr>

<%
}
rs2.close();

 %>     
 
</body>

</html>
