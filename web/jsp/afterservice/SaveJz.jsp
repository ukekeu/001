<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>送案处理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>
  <%@ page contentType="text/html;charset=GBK" %>
  
  <%@ page import="java.sql.*,java.util.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
<body bgcolor="#FFFFFF" text="#000000">

<script language="javascript" src="../public_js/public.js">
</script>
<%
	String htno = China.getParameter(request,"contractno");
	String code=htno;
	String saDate =China.getParameter(request,"INDATE");// + "-" + request.getParameter("SaDateMonth") + "-" + request.getParameter("SaDateDay");
	String caDate = China.getParameter(request,"day");// + "-" + request.getParameter("CaDateMonth") + "-" + request.getParameter("CaDateDay");
	String HANDLE=China.getParameter(request,"HANDLE");
	String check=China.getParameter(request,"check");
 
	
  String day=""; 
  StringTokenizer st22 = new StringTokenizer(htno,",") ;
  int count22 = st22.countTokens() ;
	String context=China.getParameter(request,"context");
	  while (st22.hasMoreElements()) {
	    htno = (String)st22.nextElement() ;
		if (check.equals("1"))day="dateadd(dd,"+caDate+",'"+saDate+"')";
		else day=caDate;
		String jzStr="select * from appraisal where contractno="+htno;
		ResultSet rs=aBean1.executeQuery(jzStr);
		if (!rs.next()){
		  jzStr = "insert into appraisal(contractno,senddate,";
		  jzStr = jzStr + "state,handle,day,context) values('";
		  jzStr = jzStr + htno + "','" + saDate + "','" + check + "','" + HANDLE ;
		  jzStr = jzStr + "'," + day + ",'"+context+"')";
 
		  try {
			aBean.startTransaction();
			 aBean.executeUpdate(jzStr);
			 
			 aBean.executeUpdate("update order_contract set jzdate='"+saDate+"' where code="+htno);
			aBean.commit();
			aBean.endTransaction();
		  }catch(Exception ee) {
			aBean.rollback();
			out.print(jzStr);
			out.print("鉴证添加失败,请重试或联系管理员");
		 }
		}
		rs.close();
	 }	
	
%>
<script>
			alert("送案登记已成功");
			
			//if (confirm("是否打印契税纳税申报表？"))
			// openwin1("../sale/print_qtax1.jsp?code=<%=code %>",500,300,10,10);
			opener.document.frm.submit();
		 	 close();
			</script>
</body>
</html>
