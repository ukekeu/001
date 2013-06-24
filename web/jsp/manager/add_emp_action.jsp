
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
 
<%@ page language="java" import="com.jspsmart.upload.*,java.sql.*,java.util.*" %>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
 <jsp:useBean id="updateBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
    <%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
 
 
<title>添加申请</title>
</head>
<body topmargin="0" leftmargin="0"  >
<form name="pm" method="post"  >
  

<%

 String SQL="";
 try{ 
      int count=0;   
	    String strPicture="";

	 mySmartUpload.initialize(pageContext);
	 mySmartUpload.setTotalMaxFileSize(20000000);
	 mySmartUpload.upload();
	  try {
	 
	
	com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
	if (!myFile.isMissing()){
	String ext= myFile.getFileExt(); //取得后缀名
	String saveurl=request.getRealPath("/")+"jsp/picture/";
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
	saveurl+=filename+"."+ext; //保存路径
	strPicture="../picture/"+filename+"."+ext;
 
	myFile.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
	}
	
	} catch (Exception e) { 
			out.println(e.toString()+",或是你的文件太大，系统只支持2M文件上载");
			out.close();
	}
	
	 
	  String floowtypes[]=mySmartUpload.getRequest().getParameterValues("floowtype");
	  String floowtype=floowtypes[0];
      String flownames[]=mySmartUpload.getRequest().getParameterValues("flowname");
	  String flowname=flownames[0];
      String flowtitles[]=mySmartUpload.getRequest().getParameterValues("flowtitle");
	  String flowtitle=flowtitles[0];
	  String Remark1s[]=mySmartUpload.getRequest().getParameterValues("content1");
	  String Remark1=Remark1s[0];
      String Nos[]=mySmartUpload.getRequest().getParameterValues("No");
	  String No=Nos[0];
	   String grads[]=mySmartUpload.getRequest().getParameterValues("grad");
	  String grad=grads[0];
	  String customers[]=mySmartUpload.getRequest().getParameterValues("customer");
	  String customer=customers[0];
	
 
	   String EMPNAME=(String)session.getAttribute("loginname");
	   
	       String SQL1="INSERT INTO workflow_txt(send_person,flow_code,flowname,flowtitle,check_txt,files,filetype,flowno,customer)"; 
		   SQL1+=" values('"+EMPNAME+"',"+floowtype+",'"+flowname+"','"+flowtitle+"','"+Remark1+"','"+strPicture+"',"+grad+",'"+No+"',"+customer+")";
 
		    out.print( updateBean.executeUpdate(SQL1));
			 SQL="";
			 
			SQL="select max(code) code from workflow_txt ";
			String maxCode="";
			  ResultSet codeRS=updateBean.executeQuery(SQL);
             if (codeRS.next()){maxCode=codeRS.getString("code");}
			 codeRS.close();
			 SQL="";
			SQL="insert into workflow_check_state(flow_no,flow_code,checker,checker_no,wait_day)  SELECT "+String.valueOf(maxCode)+",flow_code,flow_checker,checker_no,wait_day FROM workflow WHERE flowname='"+flowname+"' and flow_code="+floowtype;
			
			 
			   updateBean.executeUpdate(SQL);
			 SQL="";
			 SQL="update workflow_check_state set alert_date=DATEADD(dd,wait_day,getdate()) where checker_no=1 and flow_no="+String.valueOf(maxCode);
			 updateBean.executeUpdate(SQL);
			 SQL="";
			
			 
			   updateBean.closeConn(); 
			  
  }catch(Exception se){
      out.print("系统出错，原因如下：<br>");
      out.print(se.getMessage()+SQL);
	 
      updateBean.closeConn(); 
      out.close();
 
   }
  %>
  <script>
  opener.window.location="new_flow.jsp";
  
  window.close();</script>
</form>
 
</body>
</html>