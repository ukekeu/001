<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<HTML>
<head>
<title>保存楼盘图片</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<BODY BGCOLOR="white">
<%

	// Variables
	int count=0;        

	// Initialization
	mySmartUpload.initialize(pageContext);

	//mySmartUpload.setTotalMaxFileSize(100000);

	// Upload	
	mySmartUpload.upload();

	try {
		count = mySmartUpload.save("/jsp/images/");
	} catch (Exception e) { 
		out.println(e.toString());
	}
	
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();

String strSerialNo="";
String strPosMap=mySmartUpload.getFiles().getFile(0).getFileName();

if(strPosMap.length()>0){
	strPosMap="../images/"+strPosMap;
}
String strCyberMap=mySmartUpload.getFiles().getFile(1).getFileName();

if(strCyberMap.length()>0){
	strCyberMap="../images/"+strCyberMap;
}
String strMackMap=mySmartUpload.getFiles().getFile(2).getFileName();
if(strMackMap.length()>0){
	strMackMap="../images/"+strMackMap;
}
String strFaceMap=mySmartUpload.getFiles().getFile(3).getFileName();
if(strFaceMap.length()>0){
	strFaceMap="../images/"+strFaceMap;
}
String strPlaneMap=mySmartUpload.getFiles().getFile(4).getFileName();
if(strPlaneMap.length()>0){
	strPlaneMap="../images/"+strPlaneMap;
}
 
 String[] picname1s = mySmartUpload.getRequest().getParameterValues("picname1");
 String picname1=picname1s[0];
 String[] picname2s = mySmartUpload.getRequest().getParameterValues("picname2");
 String picname2=picname2s[0];
  String[] picname3s = mySmartUpload.getRequest().getParameterValues("picname3");
 String picname3=picname3s[0];
   String[] picname4s = mySmartUpload.getRequest().getParameterValues("picname4");
 String picname4=picname4s[0];
   String[] picname5s = mySmartUpload.getRequest().getParameterValues("picname5");
 String picname5=picname5s[0];
	// Retreive parameters
	if (e.hasMoreElements()) {
		//String key = (String)e.nextElement();
		String[] values = mySmartUpload.getRequest().getParameterValues("SecNo");
				strSerialNo=values[0];
				
	}
String sql="";
   if (!picname1.equals("")){
	sql="insert into Section_pic(SerialNo,MapName,MapUrl) ";
 	sql=sql+"values ('"+strSerialNo+"','"+picname1+"','"+strPosMap+"')";
	}
	if (!picname2.equals("")){
	sql+=" insert into Section_pic(SerialNo,MapName,MapUrl) ";
	sql=sql+"values ('"+strSerialNo+"','"+picname2+"','"+strCyberMap+"')";
	}
	if (!picname3.equals("")){
	sql+="  insert into Section_pic(SerialNo,MapName,MapUrl) ";
	sql=sql+"values ('"+strSerialNo+"','"+picname3+"','"+strMackMap+"')";
	}
	if (!picname4.equals("")){
	 sql+="  insert into Section_pic(SerialNo,MapName,MapUrl) ";
	 sql=sql+"values ('"+strSerialNo+"','"+picname4+"','"+strFaceMap+"')";
    }
   if (!picname5.equals("")){
    sql+=" insert into Section_pic(SerialNo,MapName,MapUrl) ";
	sql=sql+"values ('"+strSerialNo+"','"+picname5+"','"+strPlaneMap+"')";
  }
try{
	 InsertBean.executeUpdate(sql);
}
catch(Exception se){out.print(sql+se);out.close();
}
%>
 <script language=javascript>
  	alert("系统已上载你的图片，请在楼盘列表中单击图标查看");
	window.location="ViewPic.jsp?menusel=1&SecNo=<%=strSerialNo%>";
 </script>

</BODY>
</HTML>
