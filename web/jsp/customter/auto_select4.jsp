<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="vemBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>输入打印报表条件</title>
<script language="JavaScript" src='../public_js/basal.js'></script>


</head>
<%
String PARA_SQL=request.getParameter("PARA_SQL");
String choose=request.getParameter("choose");
String url=request.getParameter("para");
 if (url.equals("1"))url="ExcelTovisitcusview2a.jsp";
 else  if (url.equals("2"))url="ExcelTovisitcusview3a.jsp";
String reporttype=request.getParameter("reporttype");
String tablename=request.getParameter("tablename");

String out3=request.getParameter("out3");
String ifvalueC=getbyte1(request.getParameter("ifvalueC"));
String ifvalueE=getbyte1(request.getParameter("ifvalueE"));
 String SQLwhere="";
  %>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<SCRIPT language=javascript> 

function checkdate(){
if (document.forms[0].Date1.value.length<1){
	    	alert("请选择开始日期！");
	        document.forms[0].Date1.focus();
	        return false;
	    }
if (document.forms[0].Date2.value.length<1){
	    	alert("请选择结束日期！");
	        document.forms[0].Date2.focus();
	        return false;
	    }
 if (document.forms[0].section.value.length<1){
	    	alert("请选择楼盘！");
	        document.forms[0].section.focus();
	        return false;
	    }
		 
}

function fulldate(){
var dd= new Date();
var mm=dd.getMonth()+1;
if (mm<10)mm="0"+mm;
var da=dd.getDate()
if (da<10)da="0"+da;


 document.forms[0].Date2.value=dd.getYear()+"-"+mm+"-"+da;

}
//-->
</SCRIPT>

<body>
            

     <p align="center"><b><font size="3" color="#000080">请选择打印条件</font></b>
<br>
	   <form name=frm method="post" action="Excel_visitcusview.jsp?choose=<%=choose %>"  target="_blank">
	    <table   cellspacing="1" cellpadding>
                    <tr>
                      <td   bgcolor="#EAEAEA" align="center"><font  color="#000080">开始日期：</font></td>
					  <td   bgcolor="#EAEAEA" align="left"><input onkeydown="key(document.frm.Date2)" title="请选择认购日期" size="10" name="Date1"><input title="请选择开始日期" onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
                    <tr>
                      <td   bgcolor="#EAEAEA" align="center"><font  color="#000080">结束日期：</font></td>
					  <td   bgcolor="#EAEAEA" align="left"><input  title="请选择认购日期" size="10" name="Date2"><input title="请选择开始日期" onclick="fPopUpCalendarDlg(Date2);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
					
                    <tr>
                      <td width="50%" bgcolor="#EAEAEA"  align="center"><font  color="#000080">选择楼盘:&nbsp;</font></td>
					  <td width="50%" bgcolor="#EAEAEA"  align="left">
					  <%@ include file="../public_js/CheckSection.jsp"%>
					  <%
      String sql="select SerialNo,Name from CRM_Project "+FindWhere;
					   ResultSet rs2=ViewBean.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="section"    style="width=110;">
					      <option value=""></option>
						  <%while (rs2.next()){
	                          no=rs2.getString("SerialNo");
	                          sec=getbyte(rs2.getString("Name"));
     	                      out.print("<option value='"+no+"'>"+sec+"</option>");
	                         }
	                        rs2.close();
	                        String Sql = "" ;
                              %> 
							</select>
					</tr>
					 
					<tr>
                      <td   bgcolor="#EAEAEA" align="center"><font   color="#000080">来访方式:&nbsp;</font></td>
					  <td   bgcolor="#EAEAEA" align="left" >
					  <select name="lffs" onchange="changesub(this.value);"><option value=0 >来访</option><option value=1 >来电</option></select>
					</tr>
					<tr>
                      <td   bgcolor="#EAEAEA" align="center"><font   color="#000080">选择排序:&nbsp;</font></td>
					  <td   bgcolor="#EAEAEA" align="left" >
					 <select name="px"  style="width=110;">
					      <option value="visit_date">来访(电)日期</option>
                          <option value="cus_name">客户名称</option>
  							</select>
					</tr>
					<tr>
                      <td   bgcolor="#EAEAEA" align="center"><font   color="#000080">置业顾问:&nbsp;</font></td>
					  <td   bgcolor="#EAEAEA" align="left" ><select size="1" name="seller" onkeydown="key(document.cus.demand)"  style="width:135" >
   <option value=""></option>
<%

    String job=(String)session.getAttribute("job");	
	String sell="";
	 if (job.indexOf("销售员")>=0){
	  sell="select  seller from seller where seller='"+(String)session.getAttribute("loginname")+"'  group by seller";
	  }else{
	   sell="select  seller from seller    group by seller";	  
	  }
String user=(String)session.getAttribute("loginname");	
rs2=ViewBean.executeQuery(sell);
  while (rs2.next()){
	   String Name=getbyte(rs2.getString("seller"));
	   String choosename="";
	   if (job.indexOf("销售员")>=0){if (user.equals(Name)){choosename="selected";}}
       out.print("<option value='  "+Name+"' "+choosename+" >"+Name+"</option>") ;
	}
  rs2.close();
  %>
	  
</select> 
					</tr>
				</table>
				
				 <input type=submit name=submit1 value="预 览/打 印" onclick="return checkdate(this);"> <input type=button name=winclose value="关 闭" onclick="window.close();" >
</form>     
       
       
       
</body>       
</html>       
