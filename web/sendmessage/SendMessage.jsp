<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*, java.io.*,java.net.*,java.util.*"%>
 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../jsp/public_js/getByteOut.jsp"%>
<html>
<head>
	<title>���Ͷ���</title>
</head>
<body>

<%
String sendmess=getbyte2(request.getParameter("sendmess"));
String messtype=getbyte2(request.getParameter("messtype"));
String sendto=getbyte2(request.getParameter("sendto"));
 
String cus=getbyte1(request.getParameter("cus"));
String txt=getbyte1(request.getParameter("txt"));
if (!cus.equals("")&&!txt.equals("")){

 
StringTokenizer st22 = new StringTokenizer(sendto,",") ;
 StringTokenizer st23 = new StringTokenizer(cus,",") ;
int count2 = st22.countTokens() ;
 
try{
 while (st22.hasMoreElements()&&st23.hasMoreElements()) {
     cus=(String)st22.nextElement() ;

	 sendmess=(String)st23.nextElement() ;
  String SQL="INSERT INTO SendMessage SELECT '"+cus+"','"+txt+"',getdate(),"+messtype+",'"+(String)session.getAttribute("loginname")+"'";

 
try{

      String httpReq = "http://WWW.SURGE.COM.CN:7001/smsHttp?username=bjsofe&password=666666&content="+cus+"�ŷ�ҵ��������!"+URLEncoder.encode(txt) + "&from=13600000000&to="+sendmess;
     URL url = new URL(httpReq);

      BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
      String s = "";
	 
      StringBuffer sb = new StringBuffer("");
       while((s = br.readLine()) != null){
        sb.append(s + "\r\n");
      } 
	  
      br.close();
      if (sb.toString().indexOf("OK")==-1){
	   	    %>
	  <script>alert("����ʧ��!��������Ķ��ŷ�������ͣ���뼰ʱ��ϵ�����ṩ��");</script>
	  <%
	  
	  }else{
	    aBean.executeUpdate(SQL);
	   	    %>
	  <script>alert("���ͳɹ�!");</script>
	  <%  
	  
	  }
     
    }
    catch(Exception e){
      out.print(e+"<br>���ӷ�����ʧ��,����û���������ӵ����ŷ�����ƽ̨��");
    }
}

 }catch(Exception s){out.print(s);}
 
 



}
%>
  <form method="POST" name="form1" action="../sendSMSServlet" accept-charset="GBK" enctype="application/x-www-form-urlencoded"  >
 
<input type=hidden name=messtype value="<%=messtype %>">
 

<table>
<!--<tr><td>���տͻ�:<br><textarea cols="45" rows="3" name="sendto" readonly><%=sendto %></textarea>-->
<tr><td>���պ���:<br><textarea cols="45" rows="3" name="ids"  ><%=sendmess %></textarea>

<tr><td>��������:<br><textarea cols="45" rows="6" name="smsinfo" title="��Ҫ����150������"></textarea>
</table>
<input type=button name=dd value="�� ��" onclick="document.form1.dd.disabled=true;document.form1.submit();">
</form>
</body>
</html>
