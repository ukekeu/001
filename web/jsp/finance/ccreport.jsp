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
String PARA_SQL=request.getParameter("PARA_SQL");

 
String reporttype=request.getParameter("reporttype");
String tablename=request.getParameter("tablename");

String out3=request.getParameter("out3");
String ifvalueC=getbyte1(request.getParameter("ifvalueC"));
String ifvalueE=getbyte1(request.getParameter("ifvalueE"));
 String SQLwhere="";
  %>
   <%
 String type=request.getParameter("url");
 String url="";
if (type==null)type="";
if (type.equals("1"))url="hlzb.jsp"; 
else if (type.equals("2"))url="xsqktjb.jsp"; 
else if (type.equals("3"))url="xshzb.jsp"; 
else if (type.equals("4"))url="cusSk.jsp"; //cushlzb.jsp
else if (type.equals("5"))url="xszjhlb.jsp";
else if (type.equals("6"))url="qkmx.jsp";
 else if (type.equals("16"))url="rep_qk_list.jsp";


%>           
 
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<SCRIPT language=javascript>

function changebuild(obj){
   var objvalue=obj.value;
   if (objvalue.indexOf("-")>=0)
   objvalue=objvalue.substring(0,objvalue.indexOf("-"));
 
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
 
}
<%String bxrate="select  f.TaxName,o.section from FactGatheringTaxRecord f,order_contract o where o.section in (select SerialNo from CRM_Project "+FindWhere+") and  f.contractno=o.code and f.checkstate=1 group by f.TaxName,o.section order by o.section";
   ResultSet bxRs=vemBean.executeQuery(bxrate);
	try{
  out.print("var Ratebx=new Array();");
  out.print("var Yearbx=new Array();");
  int iii=0;
  String TaxName1="";
   while (bxRs.next()){
    String TaxName=getbyte(bxRs.getString("TaxName"));
	if (!TaxName1.equals(TaxName)){
	TaxName1=TaxName;
     out.print("Ratebx["+String.valueOf(iii)+"]="+"\""+TaxName+"\""+";");
     out.print("Yearbx["+String.valueOf(iii)+"]="+"\""+bxRs.getString("section")+"\""+";");
	 iii++;
	 }
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
bxRs.close();
  %>
function demeTaxname(){
  var section=document.forms[0].SecNo.value;
    if (section.indexOf("-")>=0)
	  section=section.substring(0,section.indexOf("-"));
	  if (document.forms[0].TaxName){
	  var aaa=document.forms[0].TaxName.length;
	
  for (var jjj=0;jjj<aaa;jjj++)
    { 
	
	 //if (document.forms[0].TaxName.selectedIndex<0)break;
	document.forms[0].TaxName.options[0].selected=true;
	 
	 document.forms[0].TaxName.options[document.forms[0].TaxName.selectedIndex]=null;
	
	}
	   for (var jj=0;jj<Ratebx.length;jj++)
    {
	  if (Yearbx[jj]==section)
	  {
		  	document.forms[0].TaxName.options[document.forms[0].TaxName.length]=new Option(Ratebx[jj],Ratebx[jj]);
   
	  }
	}
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
 
<body onload="fulldate();setSelectMad2(document.frm.SecNo, '<%= getbyte1(request.getParameter("section")) %>');">

     <p align="center"><b><font size="3" color="#000080">请选择查询条件 </font></b>
<br>
	   <form name=frm method="post" action="<%=url %>" target="_blank" >
	  <input type=hidden name="type" value="<%=type %>">
	    <table width="30%" cellspacing="1" cellpadding>
                    <tr>
                      <td  align="center">开始日期：</td>
					  <td  align="center"><input onkeydown="key(document.cus.Date1)" title="请选择认购日期" size="11" name="Date1"><input title="请选择开始日期" onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
                    <tr>
                      <td  align="center">结束日期：</td>
					  <td  align="center"><input onkeydown="key(document.cus.Date2)" title="请选择认购日期" size="11" name="Date2"><input title="请选择开始日期" onclick="fPopUpCalendarDlg(Date2);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
					
                    <tr>
                      <td   align="center">选择楼盘：</td>
					  <td   align="center">
					
					  <%
      String sql="select SerialNo,Name from CRM_Project "+FindWhere;
					   ResultSet rs2=ViewBean.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="SecNo"  onclick="" style="width=110;" onchange="changebuild(this);demeTaxname();">
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
                      <td  align="center">选择栋号：</td>
					  <td  align="center" id="sub">
					 <select name="Loft"  style="width=110;">
					      <option value=""></option>
						 
							</select>
					</tr>
					<% if (type.equals("6")){ %> 
					<tr>
                      <td width="50%"   align="center">客户类型：</td>
					  <td width="50%" align="center" >
					 <select name="dataType"    style="width=110;" >
					      <option value=""></option>
					      <option value="1">认购</option>
						  <option value="2">签约</option>
							</select>
					</tr>
					<%} %>
				</table>
				<input type=hidden name=secName>
				 <input type=submit name=submit1 value="预 览/打 印" onclick="return checkdate(this);"> <input type=button name=winclose value="关 闭" onclick="window.close();" >
</form>     
       
       
       
</body>       
</html>       
