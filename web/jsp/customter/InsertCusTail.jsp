<%@ page contentType="text/html;charset=GBK" %>
<html>
 <%@ include file="../public_js/checktime.jsp"%>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>���ټ�¼</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/logrecord.jsp" %>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%
 setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�ͻ�����" , 
                  "�ǼǸ���"
                ) ;
    String CusNo=request.getParameter("cusno");
	       CusNo= new String(CusNo.getBytes("ISO8859_1"),"GBK");
    String fc=China.getParameter(request,"fc");
    String alertday=China.getParameter(request,"alertday");
	 
	String seller=China.getParameter(request,"seller");
	String[] codcenames=request.getParameterValues("codes");
String codcename="";
if (codcenames!=null){
   for (int aa=0;aa<codcenames.length;aa++){
    if (codcename.equals(""))codcename=getbyte(codcenames[aa]);
	else codcename+=","+getbyte(codcenames[aa]);
  }
}
	String date=request.getParameter("year");//+"/"+request.getParameter("month")+"/"+request.getParameter("day");
	
	String  sql="";
	
	sql="update tail_after set state=1 where cusno ='"+CusNo+"'";
 
	 
	try{
	     InsertBean.executeUpdate(sql);
	sql="insert into tail_after(cusno,fc,seller,date,alert_day,info)"; 
	sql=sql+" values('"+CusNo+"','"+fc+"','"+seller+"'";
	sql=sql+",'"+date+"',"+alertday+",'"+codcename+"')";
     InsertBean.executeUpdate(sql);
	 
	  %>
	 
	<script>
	 alert("ϵͳ�ѽ��ܸ�����Ϣ!");
	 opener.window.document.forms[0].submit() ;
	 close();
	</script> 
<%
	}
   catch(SQLException ex){
	 out.print(sql);
	 out.print("ϵͳ����������������Ƿ���ȷ");
	 out.print(ex.getMessage());
	 out.close();
	}

%>

</body>
</html>
