 
 
 
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
 
	out.print("<center>系统正在处理你的请求,请稍候...</center>");
	try
	{
		updateBean.executeUpdate(SQL); //增加员工基本档案基本描述项
		updateBean.closeConn();
		out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
        out.println("alert('添加成功！');"); 
	    out.println("opener.location='flow_type_list.jsp?para=flowtype';");
        out.println("window.close();");
        out.println("</SCRIPT>");
	}
	catch(Exception se)
	{
	  updateBean.closeConn();
	  out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
      out.println("alert('添加失败');"); 
     out.println("window.close();");
      out.println("</SCRIPT>");
	}

%>