<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
 <%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
<title>���水���趨</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.sql.*" %>
  <jsp:useBean id="saveAjBean" scope="page" class="ConnDatabase.SDatabase" />
    <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
  <%
  	 String modiStr = "";
	
	 String SaveAj =getbyte1( request.getParameter("SaveData"));
	 //out.print(SaveAj);
	 
	 if (SaveAj==null) SaveAj="";

	 String id = request.getParameter("id");
	 if (id==null){id="";}
	 String type = request.getParameter("Type");
	 if (type == null)
	 	type = "";
	 type = new String(type.getBytes("ISO8859_1"),"GBK");	
	 String year = request.getParameter("Year");
	 String sel=request.getParameter("sel");
	 String chhosetype=request.getParameter("chhosetype");

 
	 String monthPay = request.getParameter("MonthPay");
 
	 String yong_tu = getbyte1(request.getParameter("yong_tu"));
	
	if (SaveAj.equals("�� ��")) {

    setlog( setlogBean , 
                      ( String )session.getAttribute( "loginid" ) ,
                      "�����趨" , 
                      "����"
                    ) ;

		modiStr = "insert into ajllgkb(Type,Year,monthpay) ";//OneInterestSum,SumInterest,
		modiStr = modiStr + "values('" + type + "'," + year + "," + monthPay + ")";
		 
	 }
 
	if (!id.equals("")) {
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "�����趨" , 
                          "ɾ��"
                        ) ;

		modiStr = "delete ajllgkb where id='" + id + "'";    
		saveAjBean.executeUpdate(modiStr);
			 
	}else{	
 
	String ajStr = " select type from ajllgkb where yong_tu='"+yong_tu+"' and Type='" + type + "' and Year=" + year + "";
	
	ResultSet ajRS = ViewBean.executeQuery(ajStr);	
	
	if(ajRS.next()){
	%>
	<script>
	  alert("�Ѿ����ڸð����趨��");
	  history.back();
	</script>
	<%}else{
	
	saveAjBean.executeUpdate(modiStr);
	out.print("ϵͳ�Ѵ�������")	;
	}
	ajRS.close();
 
	}     if (sel.equals("2"))
	 	   response.sendRedirect("AjList2.jsp?sel=2");	
		  else   
	        response.sendRedirect("AjList.jsp?sel=1");	
  %>
  


</body>
</html>
