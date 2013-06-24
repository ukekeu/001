<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "组成员操作" , 
                  "添加"
                ) ;
%>

<%  String action_flag = request.getParameter("action_flag");
	
	String stid = request.getParameter("tid");
	aBean.executeUpdate("delete from teaman where tid="+stid+"");
	if(action_flag.equals("add")){
	String arr[] = request.getParameterValues( "s2" );
	boolean succ = true;
	for( int i = 0 ; i < arr.length ; i ++ ) {
		String sql = "insert into teaman(tid ,mid) values(" + stid 
					 + "," + arr[i] + ")";
		int temp = 0 ;
		try{
			temp = aBean.executeUpdate(sql);
		}catch(Exception es ){
			es.printStackTrace();
		}
		
		if( temp == 0 ) {
			succ = false ;
		}
	}
	}
	
%>
<script language=javascript>
		    alert("授权成功！"); 
   			var topage="zy_add_i.jsp?zhuradio=<%=stid %>&x="+Math.random();
			window.location =topage;
		</script>