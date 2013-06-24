<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*,java.lang.String.*,javax.servlet.ServletRequest.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>佣金提成比例设置</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<body>
<form name=frm >
<p align="center" class=FontColor>
<font size=3>佣金提成比例设置</font></p>
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
   
  <tr  ALIGN=center>
    <td width="50%" class=roomright >楼盘名称:</td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<select name="section" > 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name FROM crm_project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select></td>
  </tr>
   <tr  ALIGN=center>
    <td width="50%" class=roomright >提成比例(占销成交额):</td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<input name=bl1 type=text size=10 onblur="check(this);" value=0>‰</td>
   </tr>	
    <tr  ALIGN=center>
    <td width="50%" class=roomright >认购后提成比例:</td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<input name=bl2 type=text size=10 value=0>%</td>
   </tr>	
    <tr  ALIGN=center>
    <td width="30%" class=roomright >签约后提成比例:</td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<input type=text size=10 name=bl3 value=0>%</td>
   </tr>	
    <tr  ALIGN=center>
    <td width="50%" class=roomright >办按后提成比例:</td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<input type=text size=10 name=bl4 value=0>%</td>
   </tr>	
  </table>
<p align="center"><input type=button name=save value="提 交" onclick="save_comm();">&nbsp;&nbsp;<input type=button name=cancel value="退 出" onclick="window.close();">
</p>
</form>
<script>
  function save_comm(){
    document.frm.action="commision_act.jsp";
	document.frm.submit();
  }

</script>

</body>
</html>
