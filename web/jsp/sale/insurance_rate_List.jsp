<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id = "bxBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "axBean" scope = "page" class = "ConnDatabase.SDatabase" />
<%@ include file="../public_js/logrecord.jsp" %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "���������趨" , 
                  "���"
                ) ;
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body bgcolor="#FFFFFF" onload="document.bxform.s_year.focus();" text="#000000">

<script language="javascript" src="../public_js/public.js">
</script>
<script>
  function submitValidate() {

    if (document.bxform.s_year.value==""){
	  alert("����������");
	  document.bxform.s_year.focus();
	  return false;
	}
     
	
	if (document.bxform.insurance_rate.value==""){
	  alert("������������");
	   document.bxform.insurance_rate.focus();
	  return false;
	}

   return true;
  }
function save1(){
 if (submitValidate()){
  document.bxform.submit();
 }
 }
</script>
<%
String s_year=China.getParameter(request,"s_year");
String e_year=China.getParameter(request,"e_year");
String to=China.getParameter(request,"to");
String insurance_rate=China.getParameter(request,"insurance_rate");
String bx_oper=request.getParameter("bx_oper");
if (bx_oper==null)bx_oper="";
String rateid=getbyte1(request.getParameter("id"));

String bxSQL=""; 
if (!s_year.equals("")){
   bxSQL="select insurance_year from insurance_rate where  insurance_year='"+s_year+to+e_year+"' ";
   ResultSet sqlrs =axBean.executeQuery(bxSQL);	
   if(sqlrs.next()){
      %>
	  <script>
	    alert("��������һ�£�����¼��");
	  </script>
	  <%
   }else{
   bxSQL="INSERT INTO insurance_rate(insurance_year,insurance_rate) VALUES ('"+s_year+to+e_year+"',"+insurance_rate+")";

   int a=bxBean.executeUpdate(bxSQL);
}

}
if (!rateid.equals("")){
   bxSQL="delete insurance_rate where id="+rateid;
   int a=bxBean.executeUpdate(bxSQL);
 
}
 %>
<form name="bxform" method="post" action=""> 
<center>
<p align=center><b><font size=3>���������趨</font></b></p>
 <%
 
String Cortrol=checke_qx(bxBean,(String)session.getAttribute("loginid"),"B004");
   if (Cortrol==null)Cortrol="";
    if (Cortrol.indexOf("A")>=0){ %>
<table width="55%" border="0" cellpadding="1" cellspacing="1"> 
<tr> <td class=roomleft>&nbsp;��������</td>
<td class=roomright>  

	 <input type=text name="s_year" size=5 onkeydown="key(document.bxform.to)" >��	 </td> 
	</tr>
  <tr> 
  <td class=roomleft>&nbsp;���շ���(��)</td>
  <td class=roomright> 
 <input type="text" name="insurance_rate" size="15" onkeydown="key(document.bxform.SaveData1)"  > %
 </td>
</tr>
 </table>
 <P align=center>
    	
 <input type=button name=SaveData1 value="�� ��"  onclick="save1();"> 


 <input type=Reset name=cancel value="�� ��" >  <%} %>
 </p>
 </center>
 
 </form>

      <p align="center"><b><font size=3>�������ʶ��ձ�(��)</font></b></p>
   <center>
<table width="55%" border="0" cellpadding="1" cellspacing="1">
  <tr class=listtitle> 
   
    <td > 
      <div align="center">��������</div>
    </td>
    <td > 
      <div align="center">����������(��)</div>
    </td>
   
    <td > 
      <div align="center">����</div>
    </td>
  </tr>

  <%!
	
	ResultSet ajRS = null;
	//int hasRecord��
	int id;
	int seq;
%>
  <%

  	String pageno = request.getParameter("pageNo");
	if (pageno == null) 
		pageno = "1";
	int pageNo = Integer.parseInt(pageno);
	int pageSize = 10;
	String hasNext = "N";
	int firstPos = (pageNo - 1) * pageSize + 1;
	int i = 0;
	
	String bxStr = "select * from insurance_rate order by insurance_year";//where id >=" + String.valueOf(firstPos);
	ResultSet bxRS =bxBean.executeQuery(bxStr);	
	while (bxRS.next()) {// && i < pageSize)
		id = bxRS.getInt("id");
	
 %>
   <tr align="center" class=listcontent  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');"  > 

   
    <td  >
      <div align="center"><%= getbyte(bxRS.getString("insurance_year")) %> </div>
    </td>
   
  
    <td  > 
	
      <div align="center"><%= bxRS.getFloat("insurance_rate")%></div>
    </td>
	
    <td   > 
      <div align="center">
	  <%  if (Cortrol.indexOf("D")>=0){ %>  
        <a href="javascript:delbx('<%= id %>')" >ɾ��</a><%} %> </div>
    </td>
    <script>
		function delbx(id) {
		
			if (confirm("ȷʵҪɾ���ü�¼?"))
				window.location = "insurance_rate_List.jsp?bx_oper=dele&id=" + id;
		}
	</script>
  </tr>
 <%} %>
</table>
  </center>
</p>
</body>
</html>
