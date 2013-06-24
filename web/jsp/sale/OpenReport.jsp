<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head><title>Ë®¾§±¨±í9.0</title></head>
<body>
<%@ page import=   "java.net.*,
                    java.util.*,
                    com.crystaldecisions.sdk.occa.report.application.ReportClientDocument,
                    com.crystaldecisions.sdk.occa.report.application.OpenReportOptions,
                    com.crystaldecisions.sdk.occa.report.reportsource.IReportSource,
                    "
                    %>

<%

ReportClientDocument rptDoc = new ReportClientDocument();

//Set the Report Application Server machine name using the java.net.InetAddress class
//This code assumes the RAS SDK and RAS Server are on the same machine. If they are not,
//then specify the RAS Server machine name or IP address in place of ip.GetHostName()
InetAddress ip = InetAddress.getLocalHost();
rptDoc.setReportAppServer(ip.getHostName());
//out.println(request.getParameter("report"));
//Retrieve the reportName from the HTML page
String strReport =request.getParameter("report");
//"../report/saleListRpt.rpt";
//Open the report
rptDoc.open(strReport, OpenReportOptions._retrievePictureImage);
//OpenReportOptions._openAsReadOnly
IReportSource reportSource = rptDoc.getReportSource();

//Store the reportSource in session and redirect to the viewer
session.setAttribute("reportSource", reportSource);
response.sendRedirect("Interactive_Viewer_Events.jsp");

%>


</body>
</html>