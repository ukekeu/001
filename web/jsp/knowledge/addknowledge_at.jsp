<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>

<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<body><%@ page language="java" import="com.jspsmart.upload.*,java.sql.*,java.util.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%
	// Variables
	int count=0;        
    String strPicture="";
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
} catch (Exception e) { 
		out.println(e.toString()+",或是你的文件太大，系统只支持2M文件上载");
		out.close();
}
 
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();
String []strtype=mySmartUpload.getRequest().getParameterValues("type");
String type=strtype[0];
String []strtitle=mySmartUpload.getRequest().getParameterValues("title");
String title=strtitle[0];
String []strtext=mySmartUpload.getRequest().getParameterValues("content1");
String text=strtext[0];
String []strdate=mySmartUpload.getRequest().getParameterValues("date");
String date=strdate[0];
String handler=(String)session.getAttribute("loginname") ;
	String  sql="";
	String userid="";
	sql="insert into knowledge_data(type,title,text,adjunct,handler,register_date)"; 
	sql=sql+" values('"+type+"','"+title+"','"+text+"','"+strPicture+"','"+handler+"'";
	sql=sql+",'"+date+"')";
	try{
     InsertBean.executeUpdate(sql);
	 String maxid="";
	 sql="select max(id) id from knowledge_data";
	  ResultSet rst = InsertBean.executeQuery(sql);
	  if (rst.next())maxid=rst.getString("id");
	  rst.close();
	 sql="select user_id from knowledge_type where type='"+type+"'";
	 rst = InsertBean.executeQuery(sql);
	 if(rst.next()){
	   userid=rst.getString("user_id"); 
	 }
	 rst.close();
	 
	 StringTokenizer st = new StringTokenizer(userid,",");
     int countTok = st.countTokens() ;
     String[] tmpArray=new String[countTok];
     int k=0;
   
    // for (k=0;k<countTok;k++){
     //   InsertBean1.executeUpdate("insert into my_remind (knowledge_id,userid) values("+maxid+",'"+(String)st.nextElement()+"')");
	 
    // }
	 
	 
	 %>
	 
	<script>
	  alert("系统已接受信息!");
	   setSelectMad(opener.document.form1.stateValue,'<%=type %>');
	  opener.document.form1.submit();
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
