<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%@ include file="../public_js/getByteOut.jsp"%>


<html>
<head>
	<title>删除客户</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="InsertBean2" scope="page" class="ConnDatabase.SDatabase"/>

<%
  String sql="";
  String cusno=request.getParameter("cusno");
    String choosecusno=request.getParameter("choosecusno");
 String con=request.getParameter("del");
 cusno="'"+cusno+"'";
 
 if (!choosecusno.equals(""))cusno=cusno+","+choosecusno;

 if (con==null){
          sql="delete cussaledemand where SerialNo in("+cusno+") ";  		
          //Delete customer date		  
		 InsertBean.executeUpdate(sql);
	}else{
	      sql="select * from order_contract where customer in ("+cusno+")";		
		  ResultSet rs=InsertBean.executeQuery(sql);		  
		  if (!rs.next()){		
		     sql="select * from SL_TemporarilyBuy a,room b  where a.roomcode=b.code and a.CusName in ("+cusno+")";		
		     ResultSet rs1=InsertBean1.executeQuery(sql);	
		  	    if (!rs1.next()){	
			 	 sql="select * from tb_chengyi a   where a.serialno in ("+cusno+")";		
		         ResultSet rs2=InsertBean2.executeQuery(sql);	
		  	    if (!rs2.next()){	
			       sql="delete tail_after where cusno   in("+cusno+") ";  
		          //Delete customer date
				   InsertBean.executeUpdate(sql);
			      sql="delete customer where   SerialNo in("+cusno+") ";  
		          //Delete customer date
				  InsertBean.executeUpdate(sql);  		 
		          setlog( setlogBean , 
		                  ( String )session.getAttribute( "loginid" ) ,
		                  "客户一鉴" , 
		                  "删除"
		                ) ;
%>
		 <script>
		   alert("已删除");
	       opener.changesub(opener.document.form1.section.value);
		   window.close();
		    </script>
		 <%out.close();
		 
		 }else{
		 %>
		  <script>
		     alert("不能删除此客户资料，此客户存在诚意认购信息")
		      	 window.close();
		   </script>
		   <% rs2.close();		 
		 }
		  }else{
		 %>  <script>
		     alert("不能删除此客户资料，此客户存在临定交易信息，房间代码:<%=getbyte(rs1.getString("Loft"))+getbyte(rs1.getString("Room_code"))%>")
		      //opener.changesub(opener.document.form1.section.value);
		  	 window.close();
		   </script>
		   <% rs1.close();		 
		  }
		 
		 }else{ 

		%><script>
		alert("不能删除此客户资料，此客户存在交易信息，房间代码:<%=getbyte(rs.getString("sectionname"))+getbyte(rs.getString("Loft"))+getbyte(rs.getString("Room_no"))%>")
		 // opener.changesub(opener.document.form1.section.value);
		  	   window.close();
		   </script>
		   <%
		 }
	   rs.close();
	}	 
		 out.print("系统已接受你的删除");
     	
	  
  %>
</body>
</html>