<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>上载文件</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>

<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
 <jsp:useBean id="InsertBean" scope="page" class="ExcelODBC.ExcelODBC"/>
<jsp:useBean id="InsertBean1" scope="page" class="ExcelODBC.ExcelODBC"/>
<jsp:useBean id="InsertBean2" scope="page" class="ExcelODBC.ExcelODBC"/>
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
  <%@ include file="../public_js/getByteOut.jsp"%>
 <%
 int nnn=0;
 try{
	// Variables
	int count=0;        
	// Initialization
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setTotalMaxFileSize(20971520);
	// Upload	
	mySmartUpload.upload();
	    //上载文件,不更改上载的文件名称
	count = mySmartUpload.save("/jsp/picture/");
//上载后保存文件的路径
String strPicture=mySmartUpload.getFiles().getFile(0).getFileName();
if(strPicture.length()>0){
	
 
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();
 String SecNo=getbyte1(request.getParameter("SecNo"));
 String Loft=getbyte1(request.getParameter("Loft"));
 
 nnn=InsertBean.executeUpdate("exec excel_to_customer '"+SecNo+"','"+strPicture+"'");
 String sql="select * from temp";
ResultSet rs=InsertBean.executeQuery(sql);	
while (rs.next()){
        
         String F1=getbyte(rs.getString("F1"));
		 String F2=getbyte(rs.getString("F2"));
		 String F3=getbyte(rs.getString("F3"));
		 String F4=getbyte(rs.getString("F4"));
		 String F5=fa.getFloat3(rs.getDouble("F5"),2);
		 String F6=fa.getFloat3(rs.getDouble("F6"),2);
		 String F7=fa.getFloat3(rs.getDouble("F7"),2);
		 String F8=fa.getFloat3(rs.getDouble("F8"),0);
		 String F9=fa.getFloat3(rs.getDouble("F9"),0);
		 String F10=fa.getFloat3(rs.getDouble("F9")/rs.getDouble("F5"),0);
		 String room_code="";
		 if (F1.equals(""))room_code=F2+F4;
		 else room_code=F1+"-"+F2+F4;
		 if (!F3.equals("")){  
		 sql="select * from room where seccode='"+SecNo+"' and loft='"+Loft+"' and room_code='"+F1+F3+"' and floor="+F1 +" and room="+F2;
		 ResultSet rs1=InsertBean2.executeQuery(sql);
		 if (!rs1.next()){  
			  sql="insert into room (seccode,loft,cell,floor,room_code,room,area,Y_area,usedarea,y_usedarea,unitprice,Y_Unitprice,sumprice,Y_Sumprice,room_price,tnunitprice,y_tnunitprice)";
			  sql+=" values('"+SecNo+"','"+Loft+"','"+F1+"',"+F2+",'"+room_code+"',";
			  sql+=F3+","+F5+","+F5+","+F7+",";
			  sql+=F7+",'"+F8+"',"+F8+","+F9+",";
			  sql+=F9+","+F9+","+F10+","+F10+")";
			  InsertBean1.executeUpdate(sql);
			  sql="update roomno set state=1 where sectionno='"+SecNo+"' and region='"+Loft+"' and roomno='"+room_code+"' and floor="+F2 +" and room="+F3 +" and cell='"+F1+"'";
			  InsertBean1.executeUpdate(sql);
		 }else{
		      sql="update room set sumprice="+F9+",room_price="+F9+",unitprice="+F8+",tnunitprice="+F10 +" where salestate=1 and  seccode='"+SecNo+"' and loft='"+Loft+"' and room_code='"+room_code+"' and floor="+F2 +" and room="+F3+" and cell='"+F1+"'";
		      InsertBean1.executeUpdate(sql);
		 } 
		 rs1.close();
		  }
}
rs.close();
  InsertBean.executeUpdate("drop table temp");
  
 
}


} catch (Exception e) { 
        InsertBean.executeUpdate("drop table temp");
		out.println(e.toString());
		 out.close();
}
	%>
<SCRIPT>
alert("导入成功");
 opener.window.location.reload();
 window.close();
</SCRIPT>
</body>
</html>
 