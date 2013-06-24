<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "设置邮件接收对象" , 
                  "添加"
                ) ;
%>

<%  String action_flag = getbyte1(request.getParameter("action_flag"));
	
	String stid = request.getParameter("tid");
   
	if(action_flag.equals("add")){
	String arr[] = request.getParameterValues( "s2" );

	String ids="";
	if (arr!=null){
	for( int i = 0 ; i < arr.length ; i ++ ) {
		if (ids.equals("")) ids= arr[i];
		else  ids+=","+ arr[i];
	 
	}
	}
	    try{
		  String sql="update CortrolMan set mailtoobj='"+ids +"' where id="+stid;
	
	      aBean.executeUpdate(sql);
		}catch(Exception es ){
			 out.print(es);
			 out.close();
		}
 }
%>
<script language=javascript>
		    alert("授权成功！"); 
   			var topage="mailobjadd_i.jsp?zhuradio=<%=stid %>&x="+Math.random();
			window.location =topage;
			//opener.window.location ="mailtoobj.jsp";
		</script>