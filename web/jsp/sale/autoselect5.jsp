<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="vemBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/CheckSection.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>输入打印报表条件</title>
<script language="JavaScript" src='../public_js/basal.js'></script>


</head>
<%
 String type=request.getParameter("type");
 String url="";
if (type==null)type="";
if (type.equals("3"))url="saleDA.jsp";
else if (type.equals("1")) url="saleWreport.jsp";
else if (type.equals("2")) url="CusDc.jsp";
else if (type.equals("4")) url="sale_list.jsp";
else if (type.equals("5")) url="print_qtax.jsp";
else if (type.equals("6")) url="youhuicheckrep.jsp";
else if (type.equals("7")) url="ProjectZjHl.jsp";
else if (type.equals("8")) url="sale_change_rep.jsp";//ChangeRoomOrder.jsp
else if (type.equals("9")) url="zm_view.jsp";
else if (type.equals("10")) url="pay_change_rep.jsp";
else if (type.equals("11")) url="sale_tz1.jsp";
else if (type.equals("12")) url="sale_tz2.jsp";
else if (type.equals("13")) url="sale_tz3.jsp";
else if (type.equals("14")) url="ChangeRoomList.jsp";
%>    
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
   <%String sqlx= "select SerialNo,Name from CRM_Project "+FindWhere;
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
html="<select name='Loft' style='width=110;'><option value=''></option>"+arr.join();
html=html+"</select>";
 
document.all("sub").innerHTML=html;

}
  <%}Rsx.close();%>
}


function checkdate(){
   document.forms[0].secName.value=document.forms[0].SecNo.options[document.forms[0].SecNo.selectedIndex].text;
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
<%if (!type.equals("5")){ %>		
 if (document.forms[0].SecNo.value.length<1){
	    	alert("请选择楼盘！");
	        document.forms[0].SecNo.focus();
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
        

     <p align="center"><b><font size="3" color="#000080">请选择查询条件</font></b>
<br>
	   <form name=frm method="post" action="<%=url %>" target="_blank">
	  <input type=hidden name="type" value="<%=type %>">
	    <table  cellspacing="1" cellpadding>
                    <tr>
                      <td  align="center"><font  color="#000080">开始日期：</font></td>
					  <td  align="center"><input onkeydown="key(document.frm.Date2)" title="" size="11" name="Date1"><input title="" onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
                    <tr>
                      <td  align="center"><font  color="#000080">结束日期：</font></td>
					  <td  align="center"><input  title="" size="11" name="Date2"><input title="" onclick="fPopUpCalendarDlg(Date2);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
					
                    <tr>
                      <td   align="center"><font  color="#000080">选择楼盘：</font></td>
					  <td   align="center">
					 
					  <%
      String sql="select SerialNo,Name from CRM_Project "+FindWhere;
					   ResultSet rs2=ViewBean.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="SecNo"  onclick="" style="width=110;" onchange="changebuild(this);"   ><!---->-->
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
					
					<%if (type.equals("4")){%>
					 <tr>
                      <td  align="center"><font   color="#000080">付款方式:&nbsp;</font></td>
					  <td  align="center">
					 <select name="payment"  style="width=110;">
					      <option value=""></option>
						   <option value="一次">一次性付款</option>
						     <option value="按揭">按揭付款</option>
							   <option value="分期">分期付款</option>
							</select>
					</tr> 
					<%} %>
					<%if (!type.equals("1")&&!type.equals("7")&&!type.equals("6")&&!type.equals("3")&&!type.equals("4")&&!type.equals("8")&&!type.equals("9")&&!type.equals("10")&&!type.equals("11")&&!type.equals("12")&&!type.equals("13")){ %>
                  <tr>
                      <td  align="center"><font   color="#000080">录入房号:&nbsp;</font></td>
					  <td  align="center">
					  <input type=text name=room size=14>
					</tr> 
					 <tr>
                      <td  align="center"><font   color="#000080">选择用途:&nbsp;</font></td>
					  <td  align="center" >
					  <SELECT NAME="yong_tu" style="width=110;">
					  <option ></option>
		<%
		String StrSql="select type,codename,bak from CODE where child=0 and type='YT' order by type";
   ResultSet codeRS=null;
  
    codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
   
     String a=getbyte(codeRS.getString("codename"));
	 
	       out.print("<option value='"+a+"'>"+a+"</option>");
	 
       }
	   codeRS.close();
  %>
     </SELECT>
					</tr> 
					<%} %>
					<%if (type.equals("4")){ %> <tr>
                      <td  align="center"><font   color="#000080">统计类型&nbsp;</font></td>
					  <td  align="center" >
					  <SELECT NAME="saletype" style="width=110;">
					    <option value=0>全部</option>
					    <option value=1>按认购统计</option>
					    <option value=2>按签约统计</option>
					  </SELECT>
					</tr> 
					<%} %>
				</table>
				<input type=hidden name=secName>
				 <input type=submit name=submit1 value="预 览/打 印" onclick="return checkdate(this);"> <input type=button name=winclose value="关 闭" onclick="window.close();" >
</form>     
       
       
       
</body>       
</html>       
