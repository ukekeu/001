<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="vemBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>输入打印报表条件</title>
<script language="JavaScript" src='../public_js/basal.js'></script>


</head>
 
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<SCRIPT language=javascript>
function changebuild(obj){
   var objvalue=obj.value;
   objvalue=objvalue.substring(0,indexOf("-"));
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
 function fulldate(){
var dd= new Date();
var mm=dd.getMonth()+1;
if (mm<10)mm=mm;
var da=dd.getDate()
if (da<10)da="0"+da;


 document.forms[0].month.value=mm;
}
 
//-->
</SCRIPT>

<body onload="fulldate();" >
            

     <p align="center"><b><font size="3" color="#000080">请选择条件</font></b>
<br>
	   <form name=frm method="post" action="saleDataFx.jsp"  target="_blank">
	    <table   cellspacing="1" cellpadding>
                     
                    <tr>
                      <td  align="center"><font  color="#000080">时段方式：</font></td>
					  <td  align="center"><select name=timetype><option value=0>按月对比分析</option><option value=1>按季度对比分析</option></select></b></font></td>
                    </tr>
					 <tr>
                      <td  align="center"><font  color="#000080">当前年月或季度</font></td>
					  <td  align="center"><input type=text name=month value=0 size=14></b></font></td>
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
<select name="SecNo"  onclick="changebuild(this);"  style="width=110;">
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
					<tr>
                      <td  align="center"><font   color="#000080">选择栋号:&nbsp;</font></td>
					  <td  align="center" id="sub">
					 <select name="Loft"  style="width=110;">
					      <option value=""></option>
						 
							</select>
					</tr>
				</table>
				 <input type=submit name=submit1 value="预 览/打 印" onclick="return checkdate(this);"> <input type=button name=winclose value="关 闭" onclick="window.close();" >
</form>     
       
       
       
</body>       
</html>       
