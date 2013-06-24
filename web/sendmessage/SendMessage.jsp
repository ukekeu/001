<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*, java.io.*,java.net.*,java.util.*"%>
 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../jsp/public_js/getByteOut.jsp"%>
<html>
<head>
	<title>发送短信</title>
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

      String httpReq = "http://WWW.SURGE.COM.CN:7001/smsHttp?username=bjsofe&password=666666&content="+cus+"号房业主，您好!"+URLEncoder.encode(txt) + "&from=13600000000&to="+sendmess;
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
	  <script>alert("发送失败!可能是你的短信服务功能暂停，请及时联系短信提供商");</script>
	  <%
	  
	  }else{
	    aBean.executeUpdate(SQL);
	   	    %>
	  <script>alert("发送成功!");</script>
	  <%  
	  
	  }
     
    }
    catch(Exception e){
      out.print(e+"<br>连接服务器失败,可能没有正常连接到短信服务器平台！");
    }
}

 }catch(Exception s){out.print(s);}
 
 



}
%>
  <form method="POST" name="form1" action="../sendSMSServlet" accept-charset="GBK" enctype="application/x-www-form-urlencoded"  >
 
<input type=hidden name=messtype value="<%=messtype %>">
 

<table>
<!--<tr><td>接收客户:<br><textarea cols="45" rows="3" name="sendto" readonly><%=sendto %></textarea>-->
<tr><td>接收号码:<br><textarea cols="45" rows="3" name="ids"  ><%=sendmess %></textarea>

<tr><td>短信内容:<br><textarea cols="45" rows="6" name="smsinfo" title="不要超过150个汉字"></textarea>
</table>
<input type=button name=dd value="发 送" onclick="document.form1.dd.disabled=true;document.form1.submit();">
</form>
</body>
</html>
