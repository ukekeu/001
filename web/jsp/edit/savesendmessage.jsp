 
<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <%@ include file="../inc/getByteOut.jsp"%>
<%@ include file="../inc/PunFun.inc"%>
<%@ include file="../inc/System.inc"%>
<%@ include file="../inc/UptownParm.inc"%>
<%@ include file="../inc/UserRight.inc"%>
 <jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="ViewBean" scope="page"  class="ConnDB.ConnODBC"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDB.ConnODBC"/>
 
 
<HTML>
<HEAD>
<TITLE>���ʼ�</TITLE> 
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<style>
body,td,input,textarea {font-size:9pt}
</style>
</HEAD> 
<BODY>
 


<%
   String strPicture="",strPicture1="",strPicture2="",strPicture3="",strPicture4="",strPicture5="";
try{  
      int count=0;   
      mySmartUpload.initialize(pageContext);
	  mySmartUpload.setTotalMaxFileSize(1000000000);
	  mySmartUpload.upload();
	  com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
	
	if (!myFile.isMissing()){
	String ext= myFile.getFileExt(); //ȡ�ú�׺��
	int file_size=myFile.getSize(); //ȡ���ļ��Ĵ�С 
	
	String saveurl=request.getRealPath("/")+"/knowledge/adjunct_file/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //����·��
	strPicture="adjunct_file/"+filename+"."+ext;

	myFile.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
	  com.jspsmart.upload.File myFile1 = mySmartUpload.getFiles().getFile(1);
	
	if (!myFile1.isMissing()){
	String ext= myFile1.getFileExt(); //ȡ�ú�׺��
	int file_size=myFile1.getSize(); //ȡ���ļ��Ĵ�С 
	
	String saveurl=request.getRealPath("/")+"/knowledge/adjunct_file/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //����·��
	strPicture1="adjunct_file/"+filename+"."+ext;
 strPicture+="&"+strPicture1;
	myFile1.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
	
		  com.jspsmart.upload.File myFile2 = mySmartUpload.getFiles().getFile(2);
	
	if (!myFile2.isMissing()){
	String ext= myFile2.getFileExt(); //ȡ�ú�׺��
	int file_size=myFile2.getSize(); //ȡ���ļ��Ĵ�С 
	
	String saveurl=request.getRealPath("/")+"/knowledge/adjunct_file/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //����·��
	strPicture2="adjunct_file/"+filename+"."+ext;
 strPicture+="&"+strPicture2;
	myFile2.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
		  com.jspsmart.upload.File myFile3 = mySmartUpload.getFiles().getFile(3);
	
	if (!myFile3.isMissing()){
	String ext= myFile3.getFileExt(); //ȡ�ú�׺��
	int file_size=myFile3.getSize(); //ȡ���ļ��Ĵ�С 
	
	String saveurl=request.getRealPath("/")+"/knowledge/adjunct_file/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //����·��
	strPicture3="adjunct_file/"+filename+"."+ext;
 strPicture+="&"+strPicture3;
	myFile3.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
		  com.jspsmart.upload.File myFile4 = mySmartUpload.getFiles().getFile(4);
	
	if (!myFile4.isMissing()){
	String ext= myFile4.getFileExt(); //ȡ�ú�׺��
	int file_size=myFile4.getSize(); //ȡ���ļ��Ĵ�С 
	
	String saveurl=request.getRealPath("/")+"/knowledge/adjunct_file/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //����·��
	strPicture4="adjunct_file/"+filename+"."+ext;
 strPicture+="&"+strPicture4;
	myFile4.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
		  com.jspsmart.upload.File myFile5 = mySmartUpload.getFiles().getFile(5);
	
	if (!myFile5.isMissing()){
	String ext= myFile5.getFileExt(); //ȡ�ú�׺��
	int file_size=myFile5.getSize(); //ȡ���ļ��Ĵ�С 
	
	String saveurl=request.getRealPath("/")+"/knowledge/adjunct_file/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //����·��
	strPicture5="adjunct_file/"+filename+"."+ext;
 strPicture+="&"+strPicture5;
	myFile5.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
		 
	
		  
	  String[] zf_filenames= mySmartUpload.getRequest().getParameterValues("zf_file");
	 
	String zf_filename="";
	if (zf_filenames!=null)
	  zf_filename=zf_filenames[0];
	
	if (!zf_filename.equals("")&&!strPicture.equals(""))
	   strPicture+="&"+zf_filename;
	else if (!zf_filename.equals("")&&strPicture.equals(""))   
	      strPicture=zf_filename;
	
	 
    String[] tuser1s= mySmartUpload.getRequest().getParameterValues("tuser1");
	String tuser1=tuser1s[0];
 String[] csusers= mySmartUpload.getRequest().getParameterValues("tuser2");
	String csuser=csusers[0];
	  String[] asusers= mySmartUpload.getRequest().getParameterValues("tuser3");
	String asuser= asusers[0];
  String[] subjects= mySmartUpload.getRequest().getParameterValues("subject");
	String subject=subjects[0]; 
   String[] content1s= mySmartUpload.getRequest().getParameterValues("content1");
	String content1=content1s[0]; 
 
String loginuserid=(String)session.getAttribute("USERNAME");
String StrSql="";
 
 
if (!tuser1.equals("")){ 
				StrSql="insert into imail_message(jsuser,csuser,asuser,subject,body,issend,isread,state,annex,fuserid,filename) values(";
				StrSql+="'"+tuser1+"','"+csuser+"','"+asuser+"','"+subject+"','"+content1+"',0,0,1,0,'"+loginuserid+"','"+strPicture+"') ";
				 ViewBean.executeUpdate(StrSql); 
				 
				StrSql="select max(id) id  from imail_message   ";
				 ResultSet   rs=ViewBean.executeQuery(StrSql);
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
  ViewBean1.executeUpdate(StrSql); 
 

}
StringTokenizer st221 = new StringTokenizer(csuser,",") ;
 
int count21 = st221.countTokens() ;
 while (st221.hasMoreElements()) {
 tuser1=(String)st221.nextElement();
	 
  StrSql="insert into oa_mail_state(main_id,name,state,leave) values('";
  StrSql=StrSql+id+"','"+tuser1+"',2,0)";
  ViewBean1.executeUpdate(StrSql); 
 

}
StringTokenizer st222 = new StringTokenizer(asuser,",") ;
 
int count22 = st222.countTokens() ;
 while (st222.hasMoreElements()) {
 tuser1=(String)st222.nextElement();
	 
  StrSql="insert into oa_mail_state(main_id,name,state,leave) values('";
  StrSql=StrSql+id+"','"+tuser1+"',3,0)";
  ViewBean1.executeUpdate(StrSql); 
 

}

%>
<script>
opener.window.location="../page/myplan.jsp";
 window.close();
 
</script>
<%

} }catch(Exception s){out.print(s);} 
  
%>
 

</BODY>
</HTML>
