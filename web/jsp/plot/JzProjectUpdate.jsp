<html>
<head>
<title>保存竞争资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

<%@ page import="java.sql.*, common.*" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<body bgcolor="#FFFFFF" text="#000000">
<%
	String Section = China.getParameter(request, "Section") ;
	String project = China.getParameter(request, "project") ;
	String company = China.getParameter(request, "company") ;
	String company1 = China.getParameter(request, "company1") ;
	String area = China.getParameter(request, "area") ;
	String avg = China.getParameter(request, "avg") ;
	String bak = China.getParameter(request, "bak") ;
	String operation= China.getParameter(request, "operation") ;
	String SQL="";
		try {
			aBean.startTransaction();
			if (operation.equals("Insert")) {
			 
				SQL="insert into JZFX(Section_NO,Jz_section,Jz_section_com,Jz_section_com1 ";
		        SQL+=",Jz_section_area,Jz_section_avg,BAK) values('"+Section;
		        SQL+="','"+ project+"','"+company+"','"+company1+"',"+area+","+avg+",'"+bak+"')";
		
				aBean.executeUpdate(SQL);
out.print(SQL);
                setlog( setlogBean , 
                                  ( String )session.getAttribute( "loginname" ) ,
                                  "竞争分析" , 
                                  "增加"
                                ) ;
			}

			if (operation.equals("Modify"))
				aBean.executeUpdate(SQL);
                setlog( setlogBean , 
                                  ( String )session.getAttribute( "loginname" ) ,
                                  "广告管理" , 
                                  "修改"
                                ) ;
			if (operation.equals("Delete")) {
				 
				aBean.executeUpdate(SQL) ;
                setlog( setlogBean , 
                                  ( String )session.getAttribute( "loginname" ) ,
                                  "广告管理" , 
                                  "删除"
                                ) ;
			}	
			 
			aBean.commit();
			aBean.endTransaction();
			
		} catch(Exception ee) {
			aBean.rollback();
			 
			  out.print(ee) ;
		}
	//}
			
	
%>
<script>

	 
	  window.opener.window.location = "JzFxList.jsp?Section=<%=request.getParameter("Section") %>&x=" + Math.random() ;
		  window.close() ; 
	
</script>
</body>
</html>
