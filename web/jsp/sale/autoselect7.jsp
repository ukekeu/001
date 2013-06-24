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

function changebuild(obj){
   var objvalue=obj.value;
   var html="";
   var i=0;
  
   var arr=new Array();
   <%String sqlx= "select SerialNo,Name from CRM_Project " ;
 ResultSet Rsx = ViewBean.executeQuery(sqlx) ;
 while (Rsx.next()) {
String tmpid = Rsx.getString("SerialNo") ;%>
    if(objvalue=="<%=tmpid%>"){
html="";
i=0;
<%  int j=1;
    int x=0;
	String sqlUser = "select loft from Sectiontree where  SerialNo='"+tmpid+"' group by loft";
ResultSet userRs = vemBean.executeQuery(sqlUser) ;
while (userRs.next()) {
String housename = userRs.getString("loft") ;
if (housename == null)
  housename = "" ;
  housename = getbyte(housename) ;
%>
arr[i]="<option value='<%=housename%>'><%=housename%></option>";
++i;
    <%}userRs.close();%>
html="<select name='Loft' style='width=100;'><option value=''></option>"+arr.join();
html=html+"</select>";
document.all("sub").innerHTML=html;

}
  <%}Rsx.close();%>
}
 
function checkdate(){
   document.forms[0].secName.value=document.forms[0].SecNo.options[document.forms[0].SecNo.selectedIndex].text;
<%if (!request.getParameter("type").equals("15")&&!request.getParameter("type").equals("8")&&!request.getParameter("type").equals("9")&&!request.getParameter("type").equals("7")&&!request.getParameter("type").equals("6")){ %>		
 
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
<%} %>		
 if (document.forms[0].SecNo.value.length<1){
	    	alert("请选择楼盘！");
	        document.forms[0].SecNo.focus();
	        return false;
	    }
 if (document.forms[0].Loft.value.length<1){
	    	alert("请选择楼栋！");
	        document.forms[0].Loft.focus();
	        return false;
	    }
<%if (!request.getParameter("type").equals("8")&&!request.getParameter("type").equals("9")&&!request.getParameter("type").equals("7")){ %>		
 if (document.forms[0].room.value.length<1){
	    	alert("请填写房间号！");
	        document.forms[0].room.focus();
	        return false;
	    }	
<%} %>		
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

<body onload="fulldate();">
 <%

 String type=request.getParameter("type");
 String url="";
if (type==null)type="";
if (type.equals("3"))url="saleDA.jsp";
else if (type.equals("1")) url="saleWreport.jsp";
else if (type.equals("2")) url="CusDc.jsp";
else if (type.equals("4")) url="sale_list.jsp";
else if (type.equals("5")) url="print_qtax.jsp";
else if (type.equals("6")) url="cqdj.jsp";
else if (type.equals("7")) url="cqzqq.jsp";
else if (type.equals("8")) url="../afterservice/csqk.jsp";
else if (type.equals("9")) url="../afterservice/csqk.jsp";
else if (type.equals("15")) url="dwcqdj.jsp";
%>           

     <p align="center"><b><font size="3" color="#000080">请选择查询条件</font></b>
<br>
	   <form name=frm method="post" action="<%=url %>"  target="_blank">
	  <input type=hidden name="type" value="<%=type %>">
	    <table   cellspacing="1" cellpadding>
                    <tr>
                      <td  align="center"><font  color="#000080">开始日期：</font></td>
					  <td  align="center"><input onkeydown="key(document.cus.VisaDate)" title="请选择认购日期" size="10" name="Date1"><input title="请选择开始日期" onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
                    <tr>
                      <td  align="center"><font  color="#000080">结束日期：</font></td>
					  <td  align="center"><input onkeydown="key(document.cus.VisaDate)" title="请选择认购日期" size="10" name="Date2"><input title="请选择开始日期" onclick="fPopUpCalendarDlg(Date2);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
					
                    <tr>
                      <td   align="center"><font  color="#000080">选择楼盘:&nbsp;</font></td>
					  <td   align="center">
					  <%@ include file="../public_js/CheckSection.jsp"%>
					  <%
      String sql="select SerialNo,Name from CRM_Project "+FindWhere;
					   ResultSet rs2=ViewBean.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="SecNo"  onclick="" style="width=108;" onchange="changebuild(this);"   ><!---->-->
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
                      <td  align="center"><font   color="#000080">选择栋号:&nbsp;</font></td>
					  <td  align="center" id="sub">
					 <select name="Loft"  style="width=110;">
					      <option value=""></option>
						 
							</select>
					</tr> 
					 <tr>
                      <td  align="center"><font   color="#000080">房　号:&nbsp;</font></td>
					  <td  align="center">
					  <input type=text name=room size=14>
					</tr> 
				</table>
				<input type=hidden name=secName>
				 <input type=submit name=submit1 value="预 览/打 印" onclick="return checkdate(this);"> <input type=button name=winclose value="关 闭" onclick="window.close();" >
</form>     
       
       
       
</body>       
</html>       
