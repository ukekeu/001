package test;

import ConnDatabase.SDatabase;
import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.Date;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer3D;
import org.jfree.data.category.DefaultCategoryDataset;

public class BarChartDemo
{
  public String main1(String paramString1, String paramString2, String paramString3, String paramString4, String paramString5, int paramInt, String paramString6, String paramString7, String paramString8, String paramString9)
  {
    DefaultCategoryDataset localDefaultCategoryDataset = new DefaultCategoryDataset();
    SDatabase localSDatabase = new SDatabase();
    int i = 100;
    try
    {
      ResultSet localResultSet = localSDatabase.executeQuery(paramString5);
      while (localResultSet.next()) {
        if (paramInt == 1) i += 100;
        else if (paramInt == 2) i += 150;
        else if (paramInt == 3) i += 180;
        else if (paramInt == 4) i += 200;

        for (int j = 0; j < paramInt; j++)
        {
          for (int k = 0; k < paramInt; k++)
          {
            String localObject1 = localResultSet.getString(1) + "";
            String localObject2;
			if (j == 0) {
              localObject2 = paramString6;
              localDefaultCategoryDataset.addValue(localResultSet.getDouble(2), (Comparable)localObject2, (Comparable)localObject1);
            }
            else if (j == 1) {
              localObject2 = paramString7;
              localDefaultCategoryDataset.addValue(localResultSet.getDouble(3), (Comparable)localObject2, (Comparable)localObject1);
            }
            else if (j == 2) {
              localObject2 = paramString8;
              localDefaultCategoryDataset.addValue(localResultSet.getDouble(4), (Comparable)localObject2, (Comparable)localObject1);
            }
            else if (j == 3) {
              localObject2 = paramString9;
              localDefaultCategoryDataset.addValue(localResultSet.getDouble(4), (Comparable)localObject2, (Comparable)localObject1);
            }
          }
        }
      }

      localResultSet.close(); } catch (Exception localException) {
      System.out.print(localException.getMessage());
    }
    JFreeChart localJFreeChart = ChartFactory.createBarChart(paramString4, paramString2, paramString3, localDefaultCategoryDataset, PlotOrientation.VERTICAL, true, true, false);

    localJFreeChart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, Color.white, 1000.0F, 0.0F, Color.red));

    CategoryPlot localCategoryPlot = localJFreeChart.getCategoryPlot();
    BarRenderer3D localBarRenderer3D = new BarRenderer3D();

    localJFreeChart.setBackgroundPaint(Color.WHITE);
    Object localObject1 = localCategoryPlot.getDomainAxis();

    localCategoryPlot.setDomainAxis((CategoryAxis)localObject1);
    Object localObject2 = localCategoryPlot.getRangeAxis();
    localCategoryPlot.setForegroundAlpha(0.9F);

    ((ValueAxis)localObject2).setUpperMargin(0.15D);

    ((ValueAxis)localObject2).setLowerMargin(0.15D);
    localCategoryPlot.setRangeAxis((ValueAxis)localObject2);

    localBarRenderer3D.setBaseOutlinePaint(Color.BLACK);

    localBarRenderer3D.setWallPaint(Color.gray);

    localBarRenderer3D.setItemMargin(0.1D);

    localBarRenderer3D.setItemLabelGenerator(new StandardCategoryItemLabelGenerator());
    localBarRenderer3D.setItemLabelFont(new Font("黑体", 0, 9));
    localBarRenderer3D.setItemLabelsVisible(true);
    localCategoryPlot.setRenderer(localBarRenderer3D);

    localCategoryPlot.setForegroundAlpha(0.5F);

    long l = new Date().getTime();
    String str1 = "Pie_" + l + ".jpeg";
    String str2 = paramString1;
    try {
      ChartUtilities.saveChartAsJPEG(new File(str2), 100.0F, localJFreeChart, i, 300);
    }
    catch (IOException localIOException) {
      System.out.print("不能创建JPEG图片! 可能是文件的路径不正确");
    }
    System.out.println("输出保存在D://中 Pie_" + l + ".jpeg");

    if (i == 100) paramString1 = "";
    return paramString1.substring(paramString1.lastIndexOf("/") + 1);
  }
}