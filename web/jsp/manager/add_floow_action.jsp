 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="updateBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="pageBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 
<% 	String floowtype=getbyte1(request.getParameter("floowtype"));
 	String flowname=getbyte1(request.getParameter("flowname"));
	String SQL="";
	try
	{
	   for (int i=1;i<8;i++){ 
	 
	        String N= getbyte(request.getParameter("N" + i)) ;
		    String P= getbyte(request.getParameter("P" + i)) ;
			String D= getbyte(request.getParameter("D" + i)) ;
	        SQL="INSERT INTO workflow(flow_code,flow_checker,checker_no,wait_day,flowname)"; 
		    SQL+=" values("+floowtype+","+P+","+N+","+D+",'"+flowname+"')";
		    if (!P.equals(""))
		    updateBean.executeUpdate(SQL);  
      }		
		updateBean.closeConn();
		out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
        out.println("alert('添加成功！');"); 
	    out.println("opener.location='flow_list.jsp?para=flowtype';");
        out.println("window.close();");
        out.println("</SCRIPT>");
	}
	catch(Exception se)
	{out.print(se+SQL);
	  updateBean.closeConn();
	  out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
      out.println("alert('添加失败');"); 
    // out.println("window.close();");
      out.println("</SCRIPT>");
	}

%>