 
 
 
    <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="updateBean" scope="page" class="ConnDatabase.SDatabase"/>
      <%@ include file="../public_js/getByteOut.jsp"%>
 
 
<html>
<head>	
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<% 	String EMP_CODE=getbyte1(request.getParameter("emp_code"));
    String objectSTR=getbyte1(request.getParameter("object"));
	String remark=getbyte1(request.getParameter("remark"));
	String  EMPNAME=(String)session.getAttribute("loginname");
	String SQL="";
	       SQL="INSERT INTO workflow_set(flow_name,flow_show,flow_bak,set_person)"; 
		   SQL+=" values('"+EMP_CODE+"','"+objectSTR+"','"+remark+"','"+EMPNAME+"')";
 
	out.print("<center>ϵͳ���ڴ����������,���Ժ�...</center>");
	try
	{
		updateBean.executeUpdate(SQL); //����Ա��������������������
		updateBean.closeConn();
		out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
        out.println("alert('��ӳɹ���');"); 
	    out.println("opener.location='flow_type_list.jsp?para=flowtype';");
        out.println("window.close();");
        out.println("</SCRIPT>");
	}
	catch(Exception se)
	{
	  updateBean.closeConn();
	  out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
      out.println("alert('���ʧ��');"); 
     out.println("window.close();");
      out.println("</SCRIPT>");
	}

%>