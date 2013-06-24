<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 
<html>
<head>
	<title>上载文件</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>
<!--上载用的类文件-->-->
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<!--连接数据库类文件-->-->
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%
 try{
	// Variables
	int count=0;        
	// Initialization
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setTotalMaxFileSize(200000);
	// Upload	
	mySmartUpload.upload();

	try {
	    //上载文件,不更改上载的文件名称
		count = mySmartUpload.save("/jsp/picture/");
	} catch (Exception e) { 
		out.println(e.toString());
	}
//上载后保存文件的路径
String strPicture=mySmartUpload.getFiles().getFile(0).getFileName();
if(strPicture.length()>0){
	strPicture="../picture/"+strPicture;
}
//此代码必须保留
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();

//读取录入的信息
String []strPara=mySmartUpload.getRequest().getParameterValues("fileurl");
String para=strPara[0]; 
%>

</body>
</html>
 