 
    <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="updateBean" scope="page" class="ConnDatabase.SDatabase"/>
      <%@ include file="../public_js/getByteOut.jsp"%>
<% 	String EMP_CODE=getbyte(request.getParameter("emp_code"));
  
	String SQL="";
	       SQL="delete  workflow_set where code in ("+EMP_CODE+")";
 
	out.print("<center>ϵͳ���ڴ����������,���Ժ�...</center>");
	try
	{
		updateBean.executeUpdate(SQL); //����Ա��������������������
		updateBean.closeConn();
		out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
        out.println("alert('��ӳɹ���');"); 
	    out.println("window.location='flow_type_list.jsp?para=flowtype';");
     
        out.println("</SCRIPT>");
	}
	catch(Exception se)
	{
	  updateBean.closeConn();
	  out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
      out.println("alert('���ʧ��');"); 
     out.println("window.location='flow_type_list.jsp?para=flowtype';");
     
      out.println("</SCRIPT>");
	}

%>