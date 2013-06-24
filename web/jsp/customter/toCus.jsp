<%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>上载文件</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>
  <%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
 <jsp:useBean id="InsertBean" scope="page" class="ExcelODBC.ExcelODBC"/>
<jsp:useBean id="InsertBean1" scope="page" class="ExcelODBC.ExcelODBC"/>
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
 String  pathSTR=request.getContextPath();
 pathSTR=pathSTR.substring(1);
 
 InsertBean.executeUpdate("exec checkTableExist");
 nnn=InsertBean.executeUpdate("exec excel_to_customer '"+request.getParameter("section")+"','"+strPicture+"'");//,'"+ pathSTR+"'
 String sql="select * from temp";
ResultSet rs=InsertBean.executeQuery(sql);	
while (rs.next()){
         String FF="";
         String F10=getbyte(rs.getString("F10"));
		 if (F10.indexOf(".")>=0)
        FF=F10.substring(0,F10.indexOf("."));
		 if (F10.indexOf("E")>=0&&F10.indexOf(".")>=0)
          FF+=F10.substring(F10.indexOf(".")+1,F10.indexOf("E"));
		 String phone=String.valueOf(rs.getInt("F11"));
		 if (phone.equals("0"))phone="";
		 sql="insert into customer(visit_date,Cus_Name,yixianmianji,age_range,Purpose,zj,attention,Knowledge_From,region,sj,Phone,job,demand,bak,seller)";
		 sql+=" values('"+getbyte(rs.getString("F1"))+"','"+getbyte(rs.getString("F2"))+"','"+getbyte(rs.getString("F3"))+"','"+getbyte(rs.getString("F4"))+"','";
		 sql+=getbyte(rs.getString("F5"))+"','"+getbyte(rs.getString("F6"))+"','"+getbyte(rs.getString("F7"))+"','"+getbyte(rs.getString("F8"))+"','";
		 sql+=getbyte(rs.getString("F9"))+"','"+FF+"','"+phone+"','"+getbyte(rs.getString("F12"))+"','";
		 sql+=getbyte(rs.getString("F13"))+"','"+getbyte(rs.getString("F14"))+"','"+getbyte(rs.getString("F15"))+"')";
		  InsertBean1.executeUpdate(sql);
}
rs.close();
 InsertBean.executeUpdate("drop table temp");
  sql="update Customer set signatory=cus_name,SerialNo=ltrim(rtrim('"+request.getParameter("section")+"')) "+"+'-'+" +" ltrim(rtrim(str(code))),Section='"+request.getParameter("section")+"'  where Section is null";

  InsertBean.executeUpdate(sql);
}

} catch (Exception e) { 
        InsertBean.executeUpdate("drop table temp");
		out.println(e.toString());
		 out.close();
}
	%>
<SCRIPT>alert("导入成功");opener.changesub(opener.document.form1.section.value);window.close();</SCRIPT>
</body>
</html>
 