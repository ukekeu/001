<%@ page contentType="text/html;charset=GBK" %>

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE>�찴����Ҫ�ύ����</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<link rel="stylesheet" href="../class/news.css" >
<script language=javascript src="../sale/js/mad.js"> </script>
</script>
<script language="javascript" src="../public_js/public.js">

</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
 
<body topmargin="0">
<%
	String section = China.getParameter(request, "section") ;
	 
	String code = China.getParameter(request, "code") ;
	String bakdate = China.getParameter(request, "bakdate") ;
	String nocq = China.getParameter(request, "nocq") ;
	if (nocq.equals(""))nocq="0";
	String aaa = China.getParameter(request, "aaa") ;
	if (!aaa.equals("")){
	   section = China.getParameter(request, "section1") ;
	   for (int i=1;i<9;i++){
	     String data=getbyte1(request.getParameter("data"+String.valueOf(i)));
	     String SQL="";
		
		 if (!data.equals("")){
          SQL="insert into  cq_tj_data(sectionno,dataname,type) values('"+section+"','"+data+"',1)";
	      aBean.executeUpdate(SQL) ;
		 }
	  }
	 String aaaa= China.getParameter(request, "aaaa") ;
	 if ( java.lang.Integer.parseInt(aaaa)>0){
	   for (int i=1;i<=java.lang.Integer.parseInt(aaaa);i++){
	        String data=getbyte1(request.getParameter("Adata"+String.valueOf(i)));
			String datacode=getbyte1(request.getParameter("datacode"+String.valueOf(i)));
	     String SQL="";
		 if (data.equals(""))
		   SQL="delete cq_tj_data where type=1 and code="+datacode;
		 else
		    SQL="update  cq_tj_data  set dataname='"+data+"' where type=1 and code="+datacode;  
		  aBean.executeUpdate(SQL) ;
		 
	   }
	   
	  }
   
	}
	 String SQL="";
	 
%>

<form method="post" name=frm action="add_aj_data.jsp" > 
<Input type=hidden name="section1" value="<%=section %>">
<Input type=hidden name="aaa" value="aa">
  <table width="90" border="0" cellspacing="0" cellpadding="0">
<tr> 
  <td class="menuselect3" width=88 height=21><font color="#FFFFFF">&nbsp;&nbsp;�������</font></td>�� 
</tr>
</table>	
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
    <tr  > 
      <td > 
        �ύ����1:
      </td>
      <td > 
   
          <input type="text" name="data1" size="30"  value="" onkeydown="key(document.frm.data2)">
          
      </td> 
	   <td > 
        �ύ����2:
      </td>
      <td > 
   
          <input type="text" name="data2" size="30"  value="" onkeydown="key(document.frm.data3)">
          
      </td>
	   </tr>
	 <tr  > 
      <td > 
        �ύ����3:
      </td>
      <td > 
   
          <input type="text" name="data3" size="30"  value="" onkeydown="key(document.frm.data4)">
          
      </td> 
	   <td > 
        �ύ����4:
      </td>
      <td > 
   
          <input type="text" name="data4" size="30"  value="" onkeydown="key(document.frm.data5)">
          
      </td>
	   </tr>
	    <tr  > 
      <td > 
        �ύ����5:
      </td>
      <td > 
   
          <input type="text" name="data5" size="30"  value="" onkeydown="key(document.frm.data6)">
          
      </td> 
	   <td > 
        �ύ����6:
      </td>
      <td > 
   
          <input type="text" name="data6" size="30"  value="" onkeydown="key(document.frm.data7)">
          
      </td>
	   </tr>
	    <tr  > 
      <td > 
        �ύ����7:
      </td>
      <td > 
   
          <input type="text" name="data7" size="30"  value="" onkeydown="key(document.frm.data8)">
          
      </td> 
	   <td > 
        �ύ����8:
      </td>
      <td > 
   
          <input type="text" name="data8" size="30"  value="" onkeydown="key(document.frm.Submit3)">
          
      </td>
	   </tr>
  </TABLE>
  
<hr>
  <table width="90" border="0" cellspacing="0" cellpadding="0">
<tr> 
  <td class="menuselect3" width=88 height=21><font color="#FFFFFF">&nbsp;&nbsp;���������</font></td>�� 
</tr>
</table>	
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
   <%    SQL="SELECT * FROM  cq_tj_data WHERE type=1 and sectionno='"+section+"'";
	 
	  ResultSet rs=aBean.executeQuery(SQL) ;
	  int i=0;
	   while (rs.next()){
	   i++;
	   %>
    <tr  > 
	 
      <td > 
        �ύ����<%=i %>:
      </td>
      <td > 
   
          <input type="text" name="Adata<%=i %>" size="30"  value="<%=rs.getString("dataname") %>" onkeydown="key(document.frm.data2)">
          <Input type=hidden name="datacode<%=i %>" value="<%=rs.getString("code") %>">
      </td> 
	  <%if (rs.next()){ i++;%>
	   <td > 
        �ύ����<%=i %>:
      </td>
      <td > 
   
          <input type="text" name="Adata<%=i %>" size="30"  value="<%=rs.getString("dataname") %>"  onkeydown="key(document.frm.data3)">
            <Input type=hidden name="datacode<%=i %>" value="<%=rs.getString("code") %>">
      </td>
	  <%} %>
	   </tr>
	   <%}rs.close(); %>
	   
	 <Input type=hidden name="aaaa" value="<%=i %>">
  </TABLE>
  
<table width="60%" border="0" align="center">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <div align="center">
        
		<input type="button" name="Submit3" value="�ᡡ��" onclick="frm.submit();">
      </div>
    </td>
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="��  ��" onclick="window.close()">
      </div>
    </td>
  </tr>
</table>
<table width="100%" border="0" align="center">
  <tr>
    <td>&nbsp;˵����</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td>&nbsp;�����Ҫ�޸������ӵ����ϣ���ֱ����ԭ�����������޸ĺ��ύ���漴����ɲ�����</td>
 
  </tr>
   <tr>
  
    <td>&nbsp;�����Ҫɾ�������ӵ����ϣ���ֱ����ɾ��ԭ�������ݺ��ύ���漴����ɲ���.</td>
  </tr>
  </table>
</form>
<p>&nbsp; </p>
</BODY>
 
</HTML>
