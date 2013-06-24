 <%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.jfree.chart.ChartFactory,org.jfree.chart.JFreeChart,org.jfree.chart.plot.PlotOrientation,org.jfree.chart.servlet.ServletUtilities,org.jfree.data.DefaultCategoryDataset"%>
<%

DefaultCategoryDataset dataset = new DefaultCategoryDataset();
dataset.addValue(300, "广州", "苹果");
dataset.addValue(200, "广州", "梨子");
dataset.addValue(500, "广州", "葡萄");
dataset.addValue(340, "广州", "芒果");
dataset.addValue(280, "广州", "荔枝");
JFreeChart chart = ChartFactory.createBarChart3D("水果销量统计图",
"水果",
"销量",dataset,
PlotOrientation.VERTICAL,
false,
false,
false);
String filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, null, session);
String graphURL = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;
%> 
<IMG height=300 src="<%= graphURL %>" width=500 useMap="#<%= filename %>" border=0> 
 
