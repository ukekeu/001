<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>Untitled</title>
</head>

<body>
<%@ page import="sun.net.smtp.SmtpClient,java.io.*,javax.mail.*,java.util.*,javax.mail.internet.*" %>
<%
String from="sczp74@163.com";
String to="sczp74@163.com";
try{
Properties props = new Properties();

        // Setup mail server
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.auth", "true"); //这样才能通过验证
SmtpClient client = new SmtpClient("mail.xxxxx.xxx");
client.from(from);
client.to(to);
PrintStream message = client.startMessage();
message.println("To: " + to);
message.println("Subject: Sending email from JSP!");
message.println("This was sent from a JSP page!");
message.println();
message.println("Cool beans! :-)");
message.println();
message.println("Govind Seshadri");
message.println("163.com");
message.println();
client.closeServer();
}
catch (IOException e){ 
System.out.println("ERROR SENDING EMAIL:"+e);
}
%>


</body>
</html>
