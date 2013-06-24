<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>

<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body><%@ page language="java" import="com.jspsmart.upload.*,java.sql.*,java.util.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%
	// Variables
	int count=0;        
    String strPicture="";
	String strPicture1="";
	String strPicture2="";
	// Initialization
	mySmartUpload.initialize(pageContext);

	mySmartUpload.setTotalMaxFileSize(20971520);
try {
	// Upload	
	mySmartUpload.upload();

	com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
	if (!myFile.isMissing()){
	String ext= myFile.getFileExt(); //取得后缀名
	int file_size=myFile.getSize(); //取得文件的大小 
	
	String saveurl=request.getRealPath("/")+"/jsp/knowledge/adjunct_file/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //保存路径
	strPicture="adjunct_file/"+filename+"."+ext;
 
	myFile.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
	com.jspsmart.upload.File myFile1 = mySmartUpload.getFiles().getFile(1);
	if (!myFile1.isMissing()){
	String ext= myFile1.getFileExt(); //取得后缀名
	int file_size=myFile1.getSize(); //取得文件的大小 
	
	String saveurl=request.getRealPath("/")+"/jsp/knowledge/adjunct_file/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //保存路径
	strPicture1="adjunct_file/"+filename+"."+ext;
   strPicture+="&"+strPicture1;
	myFile1.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
	
	com.jspsmart.upload.File myFile2 = mySmartUpload.getFiles().getFile(2);
	if (!myFile2.isMissing()){
	String ext= myFile2.getFileExt(); //取得后缀名
	int file_size=myFile2.getSize(); //取得文件的大小 
	
	String saveurl=request.getRealPath("/")+"/jsp/knowledge/adjunct_file/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //保存路径
	strPicture2="adjunct_file/"+filename+"."+ext;
   strPicture+="&"+strPicture2;
	myFile2.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
} catch (Exception e) { 
		out.println(e.toString()+",或是你的文件太大，系统只支持2M文件上载");
		out.close();
}
	// Retreive parameters 
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();
String []strdept=mySmartUpload.getRequest().getParameterValues("dept");
String dept=strdept[0];

String []strtitle=mySmartUpload.getRequest().getParameterValues("title");
String title=strtitle[0];
String []strtext=mySmartUpload.getRequest().getParameterValues("content1");
String text=strtext[0];
String []strdate=mySmartUpload.getRequest().getParameterValues("date");
String date=strdate[0];
String []strdate1=mySmartUpload.getRequest().getParameterValues("date1");
String date1=strdate1[0];
String handler=(String)session.getAttribute("loginname") ;
  //dept=(String)session.getAttribute("logindept") ;
 
	String  sql="";
	String userid="";
	sql="insert into gonggao(subject,body,date,tdate,deptid,filename,writerid)"; 
	sql=sql+" values('"+title+"','"+text+"','"+date+"','"+date1+"','"+dept+"','"+strPicture+"','"+handler+"')";
 
	try{
     InsertBean.executeUpdate(sql);
	 
	 
	 
	 %>
	 
	<script>
	  alert("系统已接受信息!");opener.window.location="gonggao_view.jsp";
	  
	  close();
	</script> 
<%
	}
   catch(SQLException ex){
	 out.print(sql);
	 out.print("系统出错，请检查你的数据是否正确");
	 out.print(ex.getMessage());
	 out.close();
	}

%>

</body>
</html>
