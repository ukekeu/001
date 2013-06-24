<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="vemBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
  <%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>销售月报</title>
 

</head>
<%
String PARA_SQL=request.getParameter("PARA_SQL");
java.text.SimpleDateFormat date =null;
date=new java.text.SimpleDateFormat("yyyy-MM-dd");
String TodayDate=date.format(new java.util.Date()).toString();
int curyear=Integer.parseInt(TodayDate.substring(0,4));
int curmonth=Integer.parseInt(TodayDate.substring(5,7));
int curday=Integer.parseInt(TodayDate.substring(8,10));
String yearmonth="";
if (curmonth>9)
yearmonth=curyear+"-"+curmonth; 
else
yearmonth=curyear+"-0"+curmonth; 
 
String reporttype=request.getParameter("reporttype");
String tablename=request.getParameter("tablename");

String out3=request.getParameter("out3");
String ifvalueC=getbyte1(request.getParameter("ifvalueC"));
String ifvalueE=getbyte1(request.getParameter("ifvalueE"));
 String SQLwhere="";
  %>
<script language="javascript" src="../public_js/public.js">
</script>
 
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
html="<select name='Loft' style='width=100;'><option value=''></option>"+arr.join();
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
 
}


function fulldate(){
 
   setSelectMad(document.frm.yearmonth,"<%=yearmonth %>");
}
//-->
</SCRIPT>

<body onload="fulldate();">
 <%
 String type=request.getParameter("type");
 String url="";
if (type==null)type="";
if (type.equals("3"))url="printLdReport.jsp";
else url="WeekReport.jsp";
//rep_salemon.jsp
%>           

     <p align="center"><b><font size="3" color="#000080">请选择查询条件</font></b>
<br>
	   <form name=frm method="post" action="yue_bao.jsp" target="_blank">
	  <input type=hidden name="type" value="<%=type %>">
	    <table   cellspacing="1" cellpadding>
                  
					
                    <tr>
                      <td   align="center"><font  color="#000080">选择楼盘:&nbsp;</font>
					  
					 
					  <%
      String sql="select SerialNo,Name from CRM_Project "+FindWhere;
	 
					   ResultSet rs2=ViewBean.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="SecNo"  onclick="" style="width=110;" ><!--changebuild(this);-->
					      <option value=""></option>
						  <%while (rs2.next()){
	                          no=rs2.getString("SerialNo");
	                          sec=getbyte(rs2.getString("Name"));
     	                      out.print("<option value='"+no+"-"+sec+"'>"+sec+"</option>");
	                         }
	                        rs2.close();
	                        String Sql = "" ;
                              %> 
							</select>
					</tr>
					<!--<tr>
                      <td  align="center"><font   color="#000080">选择栋号:&nbsp;</font></td>
					  <td  align="center" id="sub">
					 <select name="Loft"  style="width=110;">
					      <option value=""></option>
						 
							</select>
					</tr>-->
					 
                    <tr>
                      <td  align="center"><font  color="#000080">选择年月:&nbsp;</font>
					  
					  
					  <select name="yearmonth" style="width=110;">
					  <%for (int i=2003;i<2015;i++){ %>
					     <%for (int ii=1;ii<=12;ii++){
						   if (ii<10){
						  %>
					  <option value="<%=i %>-0<%=ii %>"><%=i %>年-0<%=ii %>月</option>
					  <%}else{ %>
					   <option value="<%=i %>-<%=ii %>"><%=i %>年-<%=ii %>月</option>
					   <%}
					   }
					   } %>
					  </select>
					  </td>
                    </tr>
				</table>
				<input type=hidden name=secName>
				 <input type=submit name=submit1 value="预 览/打 印" onclick="return checkdate(this);"> <input type=button name=winclose value="关 闭" onclick="window.close();" >
</form>     
       
       
       
</body>       
</html>       
