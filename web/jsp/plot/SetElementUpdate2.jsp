<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*,common.*"%>
<jsp:useBean id = "updateBean" scope = "page" class = "ConnDatabase.SDatabase" />
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<body bgcolor="#FFFFFF" text="#000000">
  <%
	String code=request.getParameter("section");
	String sql="";
	sql="delete  from ModulesSet2 where section='"+code+"'";
    updateBean.executeUpdate(sql);
	
	String[] room=request.getParameterValues("room");
	String[] see=request.getParameterValues("see");
	//out.print("<center>ϵͳ���ڴ����������,���Ժ�...</center>");
	try
	{  
	if(see!=null)
	{  
	   for(int i=0;i<see.length;i++)
	   {
			//���
	
          sql="insert into ModulesSet2 (section,loft,Modulus) ";
		  sql=sql+"values ('"+code+"','"+getbyte1(room[i])+"',"+see[i]+")"; 		
		  //out.print(sql);
	      updateBean.executeUpdate(sql);
	   }//end for
	   out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	   out.println("alert('���óɹ���');"); 
	   out.println("window.close();");
	   out.println("</SCRIPT>");
    }
   }
   catch(Exception se)
   {     out.print(se);
		 out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	     out.println("alert('����ʧ�ܣ�');"); 
		 out.println("window.close();");
		 out.println("</SCRIPT>");
   }
 %>

</body>
</html>