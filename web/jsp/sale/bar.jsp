 <%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.jfree.chart.ChartFactory,org.jfree.chart.JFreeChart,org.jfree.chart.plot.PlotOrientation,org.jfree.chart.servlet.ServletUtilities,org.jfree.data.DefaultCategoryDataset"%>
<%

DefaultCategoryDataset dataset = new DefaultCategoryDataset();
dataset.addValue(300, "����", "ƻ��");
dataset.addValue(200, "����", "����");
dataset.addValue(500, "����", "����");
dataset.addValue(340, "����", "â��");
dataset.addValue(280, "����", "��֦");
JFreeChart chart = ChartFactory.createBarChart3D("ˮ������ͳ��ͼ",
"ˮ��",
"����",dataset,
PlotOrientation.VERTICAL,
false,
false,
false);
String filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, null, session);
String graphURL = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;
%> 
<IMG height=300 src="<%= graphURL %>" width=500 useMap="#<%= filename %>" border=0> 
 
