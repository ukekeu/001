<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 
<html>
<head>
	<title>���������</title>
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
 int mm=0;
 try{
	// Variables
	int count=0;        
	// Initialization
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setTotalMaxFileSize(20971520);
	// Upload	
	mySmartUpload.upload();
	    //�����ļ�,���������ص��ļ�����
	count = mySmartUpload.save("/jsp/picture/");
//���غ󱣴��ļ���·��
String strPicture=mySmartUpload.getFiles().getFile(0).getFileName();
if(strPicture.length()>0){
	
 
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();
 String SecNo=getbyte1(request.getParameter("SecNo"));
 String Loft=getbyte1(request.getParameter("Loft"));
 
 nnn=InsertBean.executeUpdate("exec excel_to_customer '"+SecNo+"','"+strPicture+"'");
 String sql="select * from temp";
ResultSet rs=InsertBean.executeQuery(sql);	
while (rs.next()){
         String F1=getbyte(rs.getString("F1"));//��浥λ
		  String F2=getbyte(rs.getString("F2"));//�������
		 String F3=getbyte(rs.getString("F3"));//¥��
		 String F4=getbyte(rs.getString("F4"));//����
		 String F5=fa.getFloat3(rs.getDouble("F5"),2);//��潨�����
		 String F6=fa.getFloat3(rs.getDouble("F6"),2);//������ڽ������
		 String F7=fa.getFloat3(rs.getDouble("F7"),2);//��滨԰���
		 String F8=fa.getFloat3(rs.getDouble("F8"),2);//���¶̨���
		 String F9=fa.getFloat3(rs.getDouble("F9"),2);//��滨԰�������
		 String F10=getbyte(rs.getString("F10"));// ���¶̨�������
		 String F11=fa.getFloat3(rs.getDouble("F11"),2);//��̨���
		 String F12=getbyte(rs.getString("F12"));// ��������
		  String F13=getbyte(rs.getString("F13"));// ��԰�����
		 if (!F3.equals("")){  
          if (F3.indexOf(".")>=0)F3=F3.substring(0,F3.indexOf("."));//¥��
		   String room_code="";
	 	  if (!F4.equals("")){if (F4.indexOf(".")>=0)F4=F4.substring(0,F4.indexOf("."));}//����
		 
		   room_code=F4;
		   sql="select * from mapArea where section='"+SecNo+"' and loft='"+Loft+"' and room='"+room_code+"' and floors="+F3 +"";
 		   ResultSet rs1=InsertBean2.executeQuery(sql);
		 if (!rs1.next()){
		      sql="select area,UsedArea,lu_tai_area,ty_area,yang_tai_area from room where seccode='"+SecNo+"' and loft='"+Loft+"' and room_code='"+room_code+"' and floor="+F3 +"";
			    ResultSet rs2=InsertBean1.executeQuery(sql);
				String area="0",UsedArea="0",lu_tai_area="0",ty_area="0",yang_tai_area="0";
				if (rs2.next()){
				area=rs2.getString("area");
				UsedArea=rs2.getString("UsedArea");
			    lu_tai_area=rs2.getString("lu_tai_area");
				ty_area=rs2.getString("ty_area");
				yang_tai_area=rs2.getString("yang_tai_area");
	 		 
				}
				rs2.close();
			    sql="insert into mapArea (section,loft,Building,floors,room,area,y_area,UserArea,y_UserArea,";
				sql+="lutai_area,y_lutai_area,lutai_price,ty_area,y_ty_area,ty_price,yangtai_area,";
				sql+="y_yangtai_area,area_rate,area_rate1";
			   sql+=")";
			  sql+=" values('"+SecNo+"','"+Loft+"','',"+F3+",'"+room_code+"',";
			  sql+=area+","+F5+","+UsedArea+","+F6+",";
			  sql+=lu_tai_area+",'"+F8+"',"+F10+","+ty_area+",";
			  sql+=F7+","+F9+","+yang_tai_area+",'"+F11+"','"+F12+"','"+F13+"'";
	 		  sql+=")";
	 		  InsertBean1.executeUpdate(sql);
	 	 } 
		 rs1.close();
		  }
		  mm++;
	}
	rs.close();
	 InsertBean.executeUpdate("drop table temp");  
	}

} catch (Exception e) { 
        InsertBean.executeUpdate("exec deltemp");
		out.println(e.toString());
		 out.close();
}
	%>
	 
<SCRIPT>
<%if (mm>0){ %>
alert("����ɹ�");
<%}else{ %>
alert("���벻�ɹ��������㵼����ļ������Ƿ��붨��ı���һ��.");
<%} %>

 opener.document.frm.submit();
 window.close();
</SCRIPT>
</body>
</html>
 