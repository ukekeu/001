<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�û�" , 
                  "ɾ��"
                ) ;
%>

<%
try{
	int rows = new Integer( request.getParameter("rows") ).intValue();	
	int a[] = new int[rows];
	String sql = "";
	String sql2 = "" ;
	boolean succ= true;	
	
	for( int i=0 ; i<rows ; i++ ){
		String sTid = request.getParameter("ic" + i);
		if( sTid!= null ) {
		sql="delete PopedomConrtrol where sellerid in (select SerialNo from cortrolman where id = " + sTid+")";
		int temp = aBean.executeUpdate(sql);
		sql="delete   ManModuleCortrol   where sellerid in (select SerialNo from cortrolman where id = " + sTid+")";
		  temp = aBean.executeUpdate(sql);
			sql = "delete from cortrolman where id = " + sTid;
			  temp = aBean.executeUpdate(sql);
			
			if( temp == 0 ) {
				succ = false;
			}
		}
	}	
	response.sendRedirect("user_list.jsp?delete=" + succ);
	 }catch(Exception s){out.print("ϵͳ�����쳣���󣬴���ԭ��"+s);}

%>

