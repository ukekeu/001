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
<title>ѡ������</title>
<script language="JavaScript" src='../public_js/basal.js'></script>
</head>
<%
String PARA_SQL=request.getParameter("PARA_SQL");

String url=request.getParameter("para");
 
 if (url.equals("1"))url="ExcelTovisitcusview2a.jsp";
 else  if (url.equals("2"))url="ExcelTovisitcusview3a.jsp";
 else  if (url.equals("3"))url="qyList.jsp";
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
   <%String sqlx= "select SerialNo,Name from CRM_Project  "+FindWhere;
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
html="ѡ�񶰺�:&nbsp;&nbsp;<select name='Loft' style='width=110;'><option value=''></option>"+arr.join();
html=html+"</select>";
 
document.all("sub").innerHTML=html;

}
  <%}Rsx.close();%>
}


function checkdate(){
if (document.forms[0].Date1.value.length<1){
	    	alert("��ѡ��ʼ���ڣ�");
	        document.forms[0].Date1.focus();
	        return false;
	    }
if (document.forms[0].Date2.value.length<1){
	    	alert("��ѡ��������ڣ�");
	        document.forms[0].Date2.focus();
	        return false;
	    }
if (document.forms[0].section.value.length<1){
	    	alert("��ѡ��¥�̣�");
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

<body onload="fulldate();">
            

     <p align="center"><b><font size="3" color="#000080">��ѡ���ѯ����</font></b>
<br>
	   <form name=frm method="post" action="<%=url %>"  target="_blank">
	    <table  border="0" cellspacing="1" cellpadding>
                    <tr>
                      <td  align="center"><font  color="#000080">��ʼ���ڣ�</font> <input   title="" size="11" name="Date1"><input title="��ѡ��ʼ����" onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
                    <tr>
                      <td  align="center"><font  color="#000080">�������ڣ�</font> <input   title="" size="11" name="Date2"><input title="��ѡ��ʼ����" onclick="fPopUpCalendarDlg(Date2);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
					
                    <tr>
                      <td   align="center"><font  color="#000080">ѡ��¥��:&nbsp;</font> 
					 
					  <%
      String sql="select SerialNo,Name from CRM_Project "+FindWhere;
					   ResultSet rs2=ViewBean.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="section"  onclick="changebuild(this);"  style="width=110;">
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
                      <td  align="center"  id="sub"><font   color="#000080">ѡ�񶰺�:&nbsp;</font> 
					 <select name="Loft"  style="width=110;">
					      <option value=""></option>
						 
							</select>
					</tr>
					<tr>
                      <td  align="center"><font   color="#000080">ѡ������:&nbsp;</font> 
					  <select name="px"  style="width=110;">
					      <option value="Order_Contract.Date">�Ϲ�����</option>
						  <option value="Order_Contract.visaDate">ǩԼ����</option>
                          <option value="Order_Contract.loft+Order_Contract.room_no">�Ϲ���Ԫ</option>
                          <option value="customer.cus_name">�Ϲ��ͻ�</option>
  					 </select>
					</tr>
					<tr>
                      <td  align="center"><font   color="#000080">��������:&nbsp;</font> 
					 <select name="datetype"  style="width=110;">
					   <option value="1" <%if (request.getParameter("para").equals("1")){out.print("selected");} %>>�Ϲ�����</option>
					      <option value="3" <%if (request.getParameter("para").equals("2")){out.print("selected");} %>>ǩԼ����</option>
                          <option value="2">�ͻ���������</option>
                         
  							</select>
					</tr>
					<tr>
                      <td  align="center"><font   color="#000080">���ʽ:&nbsp;</font> 
					 <select name="payment"  style="width=110;">
					    <%rs2=ViewBean.executeQuery("select payment1 from order_contract where state<>3 group by payment1"); %>
                          <option value=""></option>
						  <%while (rs2.next()){
	                          String payment1=rs2.getString("payment1");
	                          
     	                      out.print("<option value='"+payment1+"'>"+payment1+"</option>");
	                         }
	                        rs2.close();
	                       
                              %> 
  							</select>
					</tr > 
					</table>
					<p align="center">  <input type=submit name=submit1 value="Ԥ ��/�� ӡ" onclick="return checkdate(this);"> <input type=button name=winclose value="�� ��" onclick="window.close();" ></p>
			
</form>     
       
       
       
</body>       
</html>       
