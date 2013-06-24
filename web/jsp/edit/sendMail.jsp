<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean2" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>发送邮件</title>
</head>

<body>
<%
 
	// Variables
	int count=0;        
    String strPicture="";
	String strPicture1="";
	String strPicture2="";
	// Initialization
	mySmartUpload.initialize(pageContext);

	mySmartUpload.setTotalMaxFileSize(10000000);
try {
	// Upload	
	
	mySmartUpload.upload();
 
	com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
	
	if (!myFile.isMissing()){
	String ext= myFile.getFileExt(); //取得后缀名
	
	int file_size=myFile.getSize(); //取得文件的大小 
	String saveurl=request.getRealPath("/")+"/imail/files/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //保存路径
	strPicture="files/"+filename+"."+ext;
 
	myFile.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
	com.jspsmart.upload.File myFile1 = mySmartUpload.getFiles().getFile(1);
	if (!myFile1.isMissing()){
	String ext= myFile1.getFileExt(); //取得后缀名
	int file_size=myFile1.getSize(); //取得文件的大小 
	
	String saveurl=request.getRealPath("/")+"/imail/files/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //保存路径
	strPicture1="files/"+filename+"."+ext;
   strPicture+="&"+strPicture1;
	myFile1.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
	
	com.jspsmart.upload.File myFile2 = mySmartUpload.getFiles().getFile(2);
	if (!myFile2.isMissing()){
	String ext= myFile2.getFileExt(); //取得后缀名
	int file_size=myFile2.getSize(); //取得文件的大小 
	
	String saveurl=request.getRealPath("/")+"/imail/files/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //保存路径
	strPicture2="files/"+filename+"."+ext;
   strPicture+="&"+strPicture2;
	myFile2.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
} catch (Exception e) { 
		out.println(e.toString()+",或是你的文件太大，系统只支持2M文件上载");
		out.close();
}
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();
String []tuser1s=mySmartUpload.getRequest().getParameterValues("tuser1");
String tuser1=tuser1s[0];
//String []csusers=mySmartUpload.getRequest().getParameterValues("csuser");
String csuser="";//csusers[0];
 
//String []asusers=mySmartUpload.getRequest().getParameterValues("asuser");
String asuser="";//asusers[0];
  
String []subjects=mySmartUpload.getRequest().getParameterValues("subject");
String subject=subjects[0];
String []content1s=mySmartUpload.getRequest().getParameterValues("content1");
String content1=content1s[0];
  String[] zf_filenames= mySmartUpload.getRequest().getParameterValues("zf_file");
	 
	String zf_filename="";
	if (zf_filenames!=null)
	  zf_filename=zf_filenames[0];
	
	if (!zf_filename.equals("")&&!strPicture.equals(""))
	   strPicture+="&"+zf_filename;
	else if (!zf_filename.equals("")&&strPicture.equals(""))   
	      strPicture=zf_filename;
String loginuserid=(String)session.getAttribute("loginuserid");
String StrSql="";
 
 try{
if (!tuser1.equals("")){ 
				StrSql="insert into imail_message(jsuser,csuser,asuser,subject,body,issend,isread,state,annex,fuserid,filename) values(";
				StrSql+="'"+tuser1+"','"+csuser+"','"+asuser+"','"+subject+"','"+content1+"',0,0,1,0,'"+loginuserid+"','"+strPicture+"') ";
				  aBean.executeUpdate(StrSql); 
				 
				StrSql="select max(id) id  from imail_message   ";
				 ResultSet   rs=aBean.executeQuery(StrSql);
				 String id="";
				 if (rs.next()){
				 id=rs.getString("id");
				 }
				 rs.close();				 
StringTokenizer st22 = new StringTokenizer(tuser1,",") ;

int count2 = st22.countTokens() ;

 while (st22.hasMoreElements()) {
 tuser1=(String)st22.nextElement();
	 
  StrSql="insert into oa_mail_state(main_id,name,state,leave) values('";
  StrSql=StrSql+id+"','"+tuser1+"',1,0)";
  aBean.executeUpdate(StrSql); 
 
}

} }catch(Exception s){} 
 
%>

<script>
//opener.window.location="../manager/myplan.jsp";

 window.close();
</script>
 
</body>
</html>
