<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 
<html>
<head>
	<title>�����ļ�</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>
<!--�����õ����ļ�-->-->
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<!--�������ݿ����ļ�-->-->
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
//���غ󱣴��ļ���·��
String strPicture=mySmartUpload.getFiles().getFile(0).getFileName();
if(strPicture.length()>0){
	strPicture="../picture/"+strPicture;
}
//�˴�����뱣��
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();

//��ȡ¼�����Ϣ
String []strPara=mySmartUpload.getRequest().getParameterValues("fileurl");
String para=strPara[0]; 
%>

</body>
</html>
 