<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head><title>Ë®¾§±¨±í9.0</title></head>
<body>

<%@ page import=   "com.crystaldecisions.sdk.occa.report.reportsource.IReportSource,
                    com.crystaldecisions.report.web.viewer.*
"
                    %>

<%

//Retrieve the reportSource from Session
IReportSource reportSource = (IReportSource)session.getAttribute("reportSource");

//Create an Interactive Viewer

CrystalReportViewer tc1 = new CrystalReportViewer ();
//CrystalReportViewer tc1 = new //CrystalReportInteractiveViewer();
//Set viewer properties
tc1.setName("my_Crystal_Report_Interactive_Viewer");
tc1.setOwnPage(true);
tc1.setHasLogo(true);
tc1.setEnableDrillDown(true);
tc1.setDisplayGroupTree(false);



//Attach events to the viewer:
tc1.addToolbarCommandEventListener(new MyToolbarCommandEventAdapter());

tc1.addDrillDownSubreportEventListener(new MyDrillDownSubreportEventAdapter());
tc1.addDrillEventListener(new MyDrillEventAdapter());
tc1.addNavigateEventListener(new MyNavigateEventAdapter());
//Set the viewer's report source
tc1.setReportSource(reportSource);

//View the report using processHttpRequest
tc1.processHttpRequest(request, response, getServletConfig().getServletContext(), out);

%>

<%!

//Implement the behaviour of the events... This sample sends text to System.out with each event

//Toolbar
   public class MyToolbarCommandEventAdapter implements ToolbarCommandEventListener {
	   public MyToolbarCommandEventAdapter() {
	   }
	   public void command(ToolbarCommandEventArgs e) {
		//  System.out.println("Toolbar Event fired:: \n\tAction=" + e.getAction() + "\n\tValue=" + e.getValue());
	   }
   }
%>


<%!
//Drill-down subreports
   public class MyDrillDownSubreportEventAdapter implements DrillDownSubreportEventListener {
	   public MyDrillDownSubreportEventAdapter() {
	   }
	   public void drillDownSubreport(DrillDownSubreportEventArgs e) {
		   System.out.println("Drilldown Subreport Event fired:: (x,y) = (" +
		      e.getCurrentXOffset() + "," + e.getCurrentYOffset() + ")" +
  		      "\n\t CurrentSubreportName=" + e.getCurrentSubreportName() +
		      "\n\t Page# =" + e.getCurrentSubreportPageNumber());
	   }
   }
%>


<%!
//Drill-down groups
   public class MyDrillEventAdapter implements DrillEventListener {
	   public MyDrillEventAdapter() {
	   }
	   public void drill(DrillEventArgs e) {
		   System.out.println("Drill Event for Group :: " + e.getGroupName() +
		      "\n\tGroupNamePath = " + e.getGroupNamePath());
	   }
   }
%>

<%!
//Page Navigation Event
   public class MyNavigateEventAdapter implements NavigateEventListener {
	   public MyNavigateEventAdapter() {
	   }
       public void navigate(NavigateEventArgs e) {
		   System.out.println("Page Navigate Event:: moving to page# " + e.getPageNumber());
	   }
   }
%>

</body>
</html>
