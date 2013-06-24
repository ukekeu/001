<%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>иотьнд╪Ч</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>
  <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
    <jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
	  <jsp:useBean id="InsertBean2" scope="page" class="ConnDatabase.SDatabase"/>

	  CREATE TRIGGER [saveTail] ON dbo.tail_after 
FOR INSERT
AS
 
declare @customer varchar(50) 

declare @num  int
declare @numCount  int

begin
 select @customer=cusno ,@num=id   from inserted 
update customer set gzState=1  where SerialNo=@customer
select @numCount=count(*)  from tail_after where cusno=@customer
update tail_after set num=@numCount   where id =@num
end









	  
 <%
 int nnn=0;
 try{
	 
  String sql="select cusno from tail_after group by cusno";
ResultSet rs=InsertBean.executeQuery(sql);	
int ii=1;
while (rs.next()){
     ii=1;
	sql="select id from tail_after  where cusno='"+rs.getString("cusno")+"'";
	ResultSet rs1=InsertBean2.executeQuery(sql);	
	while (rs1.next()){
	         sql="update   tail_after set num="+ii+" where id="+rs1.getString("id");
			  InsertBean1.executeUpdate(sql);
			  ii++;
	}rs1.close();		  
	         
}
rs.close();
 

} catch (Exception e) { 
        
		out.println(e.toString());
		 out.close();
}
	%>
 
</body>
</html>
 