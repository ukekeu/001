<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>��Ŀ���ͼ</title>
</head>
<body>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<%
String sql="";
String name=request.getParameter("name");
String no=request.getParameter("secno");
       sql="select * from Section_pic where SerialNo='"+no+"'";
	   ResultSet rs=ViewBean.executeQuery(sql);
	   String eof="";
	   if (rs.next()){
	  
	    String PosMap=  getbyte(rs.getString("PosMap"));
	    String  CyberMap=getbyte(rs.getString("CyberMap"));
	    String MackMap =getbyte(rs.getString("MackMap"));
	    String FaceMap=getbyte(rs.getString("FaceMap"));
	    String PlaneMap=getbyte(rs.getString("PlaneMap"));
	    String FitmentMap=getbyte( rs.getString("FitmentMap"));
	    String  SightMap=getbyte(rs.getString("SightMap"));

 %>
 <center>
<table border="0" width="100%" >
<%if (!PosMap.equals("")){   eof="true";%>
  <tr>
    <td width="16%">λ��ͼ</td>
     <td width="84%">��
      <img border="0"   src="..<%=PosMap%>"  alt="<%=name%>"  >
	 </td>
  </tr>
  <%} %>
  <%if (!CyberMap.equals("")){  eof="true"; %>
  <tr>
    <td width="16%">���ӵ�ͼ</td>
    <td width="84%">��
     <img border="0"   src="..<%=CyberMap%>"  alt="<%=name%>"  >
	 </td>
  </tr>
    <%} %>
  <%if (!MackMap.equals("")){   eof="true";%>
  <tr>
    <td width="16%">�滮ͼ</td>
    <td width="84%">��
    <img border="0"   src="..<%=MackMap%>"  alt="<%=name%>"  >
	</td>
  </tr>
      <%} %>
  <%if (!FaceMap.equals("")){  eof="true"; %>
  <tr>
    <td width="16%">���ͼ</td>
    <td width="84%">��
    <img border="0"   src="..<%=FaceMap%>"  alt="<%=name%>"  >
	</td>
  </tr>
        <%} %>
  <%if (!FaceMap.equals("")){   eof="true";%>
  <tr>
    <td width="16%">ƽ��ͼ</td>
    <td width="84%">��
    <img border="0"   src="..<%=PlaneMap%>"  alt="<%=name%>"  >
	</td>
  </tr>
    <%} %>
  <%if (!FitmentMap.equals("")){   eof="true";%>
  <tr>
    <td width="16%">װ��ͼ</td>
    <td width="84%">��
    <img border="0"   src="..<%=FitmentMap%>"  alt="<%=name%>"  > 
	</td>
  </tr>
      <%} %>
  <%if (!SightMap.equals("")){  eof="true"; %>
  <tr>
    <td width="16%">����ͼ</td>
    <td width="84%">��
    <img border="0"   src="..<%=SightMap%>"  alt="<%=name%>"  >
	</td>
  </tr>
  <%}  %>
  
</table>
</center>
<%}
rs.close();
 
if (eof.equals("")){ 
out.print(name+"¥��û��ͼƬչ");
out.print("<a href="+"javascript:window.close();"+">����</a>");
}


 %>

</body>

</html>
