<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 
<html>
<head>
	<title>导入读表数</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>

<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
 <jsp:useBean id="InsertBean" scope="page" class="ExcelODBC.ExcelODBC"/>
<jsp:useBean id="InsertBean1" scope="page" class="ExcelODBC.ExcelODBC"/>
<jsp:useBean id="InsertBean2" scope="page" class="ExcelODBC.ExcelODBC"/>
<jsp:useBean id="InsertBean3" scope="page" class="ExcelODBC.ExcelODBC"/>
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
  <%@ include file="../public_js/getByteOut.jsp"%>
 <%
	// Variables
	int mm=0;
	int count=0;  
	String Loft="";
	String oldprice ="";
	  String SecNo="";
	try{      
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
    SecNo=getbyte1(request.getParameter("SecNo"));
    Loft=getbyte1(request.getParameter("Loft"));
 String check=getbyte1(request.getParameter("check"));

 String []saleoldprices=mySmartUpload.getRequest().getParameterValues("saleoldprice");
String saleoldprice="";
 if (saleoldprices!=null)
  saleoldprice=saleoldprices[0]; 
  
  String []oldprices=mySmartUpload.getRequest().getParameterValues("oldprice");
    oldprice=oldprices[0]; 
 
  if (saleoldprice.equals("1"))
  InsertBean.executeUpdate("exec saveOldPrice '"+SecNo+"','"+Loft+"','"+oldprice+"'");
  
  InsertBean.executeUpdate("exec checkTableExist");
 int nnn=InsertBean.executeUpdate("exec excel_to_customer '"+SecNo+"','"+strPicture+"'");
 String sql="select * from temp";
ResultSet rs=InsertBean.executeQuery(sql);	
while (rs.next()){
         String F1=String.valueOf(rs.getInt("F1"));
		  String F2=getbyte(rs.getString("F2"));
		 String F3=getbyte(rs.getString("F3"));
		 String F4=getbyte(rs.getString("F4"));
		 String F5=fa.getFloat3(rs.getDouble("F5"),2);
		 String F6=fa.getFloat3(rs.getDouble("F6"),2);
		 String F7=fa.getFloat3(rs.getDouble("F7"),2);
		 String F8=fa.getFloat3(rs.getDouble("F8"),2);
		 String F9=fa.getFloat3(rs.getDouble("F9"),0);		 
		 String F10=fa.getFloat3(rs.getDouble("F9")/rs.getDouble("F6"),2);
		 String F11=getbyte(rs.getString("F10"));//户型
		 String F12=getbyte(rs.getString("F11"));//用途
		  String F13=getbyte(rs.getString("F12"));//朝向
		 String F14=getbyte(rs.getString("F13"));//交楼日期
		  String F15=getbyte(rs.getString("F14"));//房类		 
		 if (!F3.equals("")){  
          if (F3.indexOf(".")>=0)F3=F3.substring(0,F3.indexOf("."));
		   String room_code="";
		  if (!F2.equals("")){if (F2.indexOf(".")>=0)F2=F2.substring(0,F2.indexOf("."));}
		  if (!F4.equals("")){if (F4.indexOf(".")>=0)F4=F4.substring(0,F4.indexOf("."));}
		 
		   room_code=F4;
		if (!room_code.equals("")){
		   sql="select * from roomno where sectionno='"+SecNo+"' and region='"+Loft+"' and roomno='"+room_code+"' and floor="+F1 +" and room="+F3 +" and cell='"+F2+"'";
 		 
		   ResultSet rs2=InsertBean3.executeQuery(sql);
		   if (rs2.next()){  
		     sql="select * from room where seccode='"+SecNo+"' and loft='"+Loft+"' and room_code='"+room_code+"' and floor="+F1 +" and room="+F3 +" and cell='"+F2+"'";
 		      ResultSet rs1=InsertBean2.executeQuery(sql);
		    if (!rs1.next()){  
			  sql="insert into room (seccode,loft,floor,room_code,room,area,Y_area,usedarea,y_usedarea,unitprice,Y_Unitprice,sumprice,Y_Sumprice,room_price,tnunitprice,y_tnunitprice,Roomtype,yong_tu,Serve_date,Direction,room_type";
			  if (!F2.equals(""))
			    sql+=",cell";
			  sql+=")";
			  sql+=" values('"+SecNo+"','"+Loft+"',"+F1+",'"+room_code+"',";
			  sql+=F3+","+F5+","+F5+","+F6+",";
			  sql+=F6+",'"+F8+"',"+F8+","+F9+",";
			  sql+=F9+","+F9+","+F10+","+F10+",'"+F11+"','"+F12+"','"+F14+"','"+F13+"','"+F15+"'";
			    if (!F2.equals(""))
				 sql+=",'"+F2+"'";
			  sql+=")";			   
			  InsertBean1.executeUpdate(sql);
			  sql="update roomno set state=1 where sectionno='"+SecNo+"' and region='"+Loft+"' and roomno='"+room_code+"' and floor="+F1 +" and room="+F3+"  and cell='"+F2+"'";
			  mm+=InsertBean1.executeUpdate(sql);
			    
		   }else{
		      sql="update room set sumprice="+F9+",room_price="+F9+",unitprice="+F8+",tnunitprice="+F10 ;
			  if (!check.equals(""))
			  sql+=",area="+F5+",Y_area="+F5+",usedarea="+F6+",y_usedarea="+F6+" ";
			  sql+=",room_type='"+F15+"',roomtype='"+F11+"',yong_tu='"+F12+"',Direction='"+F13+"'";
			  
			  sql+=" where salestate=1 and  seccode='"+SecNo+"' and loft='"+Loft+"' and room_code='"+room_code+"' and floor="+F1 +" and room="+F3+"  and cell='"+F2+"'";
		      mm+=InsertBean1.executeUpdate(sql);
			   
		   } 
		   rs1.close();
		  }rs2.close();
		 }
		}
}
rs.close();
 
}

} catch (Exception e) { 
        InsertBean.executeUpdate("exec checkTableExist");
		out.println(e.toString());
		 out.close();
}
	%>
	 
<SCRIPT>
<%if (mm>0){ %>
alert("导入成功");
<%}else{ %>
alert("导入不成功，请检查你导入的文件数据是否与定义的编码一致.");
<%
InsertBean.executeUpdate("delete 试算价目表   where sectionno='"+SecNo+"' and loft='"+Loft+"' and payment='"+oldprice+"'");  

} %>

 opener.document.cus.submit();
 window.close();
</SCRIPT>
</body>
</html>
 