 <%@ page contentType="text/html;charset=GBK" %>
 <jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
  
 <%
        try{        // 初始化
        mySmartUpload.initialize(pageContext);
		  mySmartUpload.setContentDisposition(null);
                // 设定contentDisposition为null以禁止浏览器自动打开文件，
                //保证点击链接后是下载文件。若不设定，则下载的文件扩展名为
                //doc时，浏览器将自动用word打开它。扩展名为pdf时，
                //浏览器将用acrobat打开。
				
                   // 下载文件
    mySmartUpload.downloadFile(request.getParameter("fileurel"));
	  }catch(Exception s){out.print(s);}
  %>  
 