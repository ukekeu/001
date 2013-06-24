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
   <%String sqlx= "select SerialNo,Name from crm_project "+FindWhere;
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
<%if (!getbyte(request.getParameter("type")).equals("3")){ %>
<%if (getbyte(request.getParameter("type")).equals("1")){ %>
if (document.forms[0].SecNo.value.length<1){
	    	alert("请选择楼盘！");
	        document.forms[0].SecNo.focus();
	        return false;
	    }
<%} %>
if (document.forms[0].Date1.value.length<1){
	    	alert("请选择截止日期！");
	        document.forms[0].Date1.focus();
	        return false;
	    }
<%} %>
if (document.forms[0].show.value=="1")
document.forms[0].action="sale_count.jsp";
else
document.forms[0].action="sale_count_list.jsp";
}
function fulldate(){
var dd= new Date();
var mm=dd.getMonth()+1;
if (mm<10)mm="0"+mm;
var da=dd.getDate()
if (da<10)da="0"+da;

 document.forms[0].Date2.value=dd.getYear()+"-"+mm+"-"+da;

}
function fill(){
  if (document.forms[0].SecNo.options[document.forms[0].SecNo.selectedIndex].text!="") 
    document.forms[0].secname.value=document.forms[0].SecNo.options[document.forms[0].SecNo.selectedIndex].text;
  if (document.forms[0].Loft.options[document.forms[0].Loft.selectedIndex].text!="") 
    document.forms[0].loftname.value=document.forms[0].Loft.options[document.forms[0].Loft.selectedIndex].text;

}
//-->
</SCRIPT>

<body  >
            

     <p align="center"><b><font size="3" color="#000080">请选择查询条件</font></b>
<br>
	   <form name=frm method="post" action="<%if (getbyte1(request.getParameter("type")).equals("1")){ %>sale_count.jsp<%}else if (getbyte1(request.getParameter("type")).equals("2")){ %>wait_sale.jsp<%}else if (getbyte1(request.getParameter("type")).equals("3")){ %>wait_sale1.jsp<%}else{ %>sale_zb.jsp<%} %>"  target="_blank">
	    <table   cellspacing="1" cellpadding>
                
					
                    <tr>
                      <td   align="center"><font   color="#000080">选择楼盘:&nbsp;</font></td>
					  <td   align="center">
					  
					  <%
      String sql="select SerialNo,Name from crm_project "+FindWhere;
					   ResultSet rs2=ViewBean.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="SecNo"  onclick="changebuild(this);fill();" style="width=100;">
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
                      <td  align="center"><font    color="#000080">选择栋号:&nbsp;</font></td>
					  <td  align="center" id="sub">
					 <select name="Loft"  style="width=100;"  onblur="fill();">
					      <option value=""></option>
						 
							</select>
					</tr>
					<%if (!getbyte(request.getParameter("type")).equals("3")){ %>
					 <tr>
                      <td  align="center"><font   color="#000080">截止日期：</font></td>
					  <td  align="center"><input  type=text title="请选择认购日期" size="10" name="Date1"><input title="请选择开始日期" onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
					 <tr>
                      <td  align="center"><font   color="#000080">显示方式</font></td>
					  <td  align="center"><select name="show"><option value=1>按统计表显示</option><option value=0>按明细表显示</option></select>  </b></font></td>
                    </tr>
					
					<%} %>
				</table>
				<input type=hidden name=secname>
   			    <input type=hidden name=loftname>
				 <input type=submit name=submit1 value="预 览/打 印" onclick="fill();return checkdate(this);"> <input type=button name=winclose value="关 闭" onclick="window.close();" >
</form>     
       
       
       
</body>       
</html>       
