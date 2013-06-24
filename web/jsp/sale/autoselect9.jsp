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
   <%String sqlx= "select SerialNo,Name from CRM_Project"+FindWhere;
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

<body  >
        

     <p align="center"><b><font size="3" color="#000080">请选择查询条件</font></b>
<br>
	   <form name=frm method="post" action="<%=url %>" target="_blank">
	  <input type=hidden name="type" value="<%=type %>">
	    <table  cellspacing="1" cellpadding>
                    
                    <tr>
                      <td width="20%" bgcolor="#EAEAEA"  align="center"><font  color="#000080">选择楼盘:&nbsp;</font></td>
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
							</td> <td width="10%" bgcolor="#EAEAEA" align="center"><font   color="#000080">栋号:&nbsp;</font></td>
					  <td width="40%" bgcolor="#EAEAEA" align="center" id="sub">
					 <select name="Loft"  style="width=110;">
					      <option value=""></option>
						 
							</select>
					</tr>
					
                  <tr>
                      <td width="20%" bgcolor="#EAEAEA" align="center"><font   color="#000080">房　号:&nbsp;</font></td>
					  <td width="80%" bgcolor="#EAEAEA" align="center" colspan="3">
					  <input type=text name=room size=30><input type=button name="add" value="添 加" onclick="addroom();">
					</tr> 
					 <tr>
                      <td width="20%" bgcolor="#EAEAEA" align="center"><font   color="#000080">用途&nbsp;</font></td>
					  <td  align="center" colspan="3">
					  <SELECT NAME="roomno" multiple size=10  style="width:110">
				     </SELECT>
					</tr> 
				</table>
				<input type=hidden name=secName>
				 <input type=submit name=submit1 value="预 览/打 印" onclick="return sele();"> <input type=button name=winclose value="关 闭" onclick="window.close();" >
</form>     
       
       
<script>
function addroom(){
  var section=document.frm.SecNo.value;
  var Loft=document.frm.Loft.value;
  var room=document.frm.room.value;
  if (room.indexOf("，")>=0){alert("分隔符只能半角状态中的','");return false;}
  var dic_arr=document.frm.room.value.split(",");
  var whereSQL="";	
	   var disn=1;
	   for (var dd=0;dd<dic_arr.length;dd++){
         
		  whereSQL=section+Loft+dic_arr[dd];
		  
	document.frm.roomno.options[document.frm.roomno.length]=new Option(whereSQL,"'"+whereSQL+"'");
// document.frm.roomno.options[document.frm.roomno.length].selected=true;
}
}
function sele(){
  if (document.frm.roomno.length==0){alert("请选择你要打印的条件");return false;}
       for (var j=0;j<document.frm.roomno.length;j++){
	     document.frm.roomno.options[j].selected=true;
	   }
}	   
</script>       
</body>       
</html>       
