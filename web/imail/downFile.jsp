 <%@ page contentType="text/html;charset=GBK" %>
 <jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
  
 <%
        try{        // ��ʼ��
        mySmartUpload.initialize(pageContext);
		  mySmartUpload.setContentDisposition(null);
                // �趨contentDispositionΪnull�Խ�ֹ������Զ����ļ���
                //��֤������Ӻ��������ļ��������趨�������ص��ļ���չ��Ϊ
                //docʱ����������Զ���word��������չ��Ϊpdfʱ��
                //���������acrobat�򿪡�
				
                   // �����ļ�
    mySmartUpload.downloadFile(request.getParameter("fileurel"));
	  }catch(Exception s){out.print(s);}
  %>  
 