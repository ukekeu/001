<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
	<title>������������</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
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
	    //�����ļ�,���������ص��ļ�����
		count = mySmartUpload.save("/jsp/picture/");
	} catch (Exception e) { 
		out.println(e.toString());
	}
com.jspsmart.upload.File file = mySmartUpload.getFiles().getFile(0);
//�����ļ�,�������ص��ļ�����
file.saveAs("/jsp/picture/" + "aa.txt");


//��ȡ���ص��ļ�����

String strPicture=mySmartUpload.getFiles().getFile(0).getFileName();
if(strPicture.length()>0){
	strPicture="../picture/"+strPicture;
}

//��ȡ�����ֵ
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();
String []strPara=mySmartUpload.getRequest().getParameterValues("para");
String para=strPara[0];
String [] strSecCode=mySmartUpload.getRequest().getParameterValues("SecCode");
String SecCode=strSecCode[0];
   %>

</body>
</html>
 