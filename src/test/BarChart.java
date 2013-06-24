package test;

import ConnDatabase.SDatabase;
import java.awt.Color;
import java.awt.Font;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.ResultSet;
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

public class BarChart
{
  public String main1(String paramString1, String paramString2, String paramString3, String paramString4, String paramString5, String paramString6, String paramString7, String paramString8, String paramString9)
  {
    DefaultCategoryDataset localDefaultCategoryDataset = new DefaultCategoryDataset();
    int i = 100;
    SDatabase localSDatabase = new SDatabase();
    try
    {
      ResultSet localResultSet = null;
      if (!paramString6.equals("")) {
        localResultSet = localSDatabase.executeQuery(paramString6);

        if (localResultSet.next()) {
          i += 70;
          localDefaultCategoryDataset.addValue(localResultSet.getDouble("jzarea"), "广州", "总面积(千平方米)");
        }
        localResultSet.close();
      }
      if (!paramString7.equals(""))
      {
        localResultSet = localSDatabase.executeQuery(paramString7);

        if (localResultSet.next()) {
          i += 70;
          localDefaultCategoryDataset.addValue(localResultSet.getDouble("jzarea"), "广州", "累计销售");
        }
        localResultSet.close();
      }
      if (!paramString8.equals("")) {
        localResultSet = localSDatabase.executeQuery(paramString8);

        if (localResultSet.next()) {
          i += 70;
          localDefaultCategoryDataset.addValue(localResultSet.getDouble("jzarea"), "广州", "本年可售(千平方米)");
        }
        localResultSet.close();
      }
      if (!paramString9.equals("")) {
        i += 70;
        localResultSet = localSDatabase.executeQuery(paramString9);

        if (localResultSet.next()) {
          localDefaultCategoryDataset.addValue(localResultSet.getDouble("jzarea"), "广州", "本年已售");
        }
        localResultSet.close();
      }
      localResultSet = localSDatabase.executeQuery(paramString2);
      while (localResultSet.next()) {
        i += 150;
        localDefaultCategoryDataset.addValue(localResultSet.getDouble("jzarea"), "广州", localResultSet.getString("yearmonth"));
      }
      localResultSet.close(); } catch (Exception localException1) {
      System.out.print(localException1.getMessage());
    }
    JFreeChart localJFreeChart = ChartFactory.createBarChart3D(paramString3, paramString5, paramString4, localDefaultCategoryDataset, PlotOrientation.VERTICAL, false, false, false);

    CategoryPlot localCategoryPlot = localJFreeChart.getCategoryPlot();
    BarRenderer3D localBarRenderer3D = new BarRenderer3D();

    localJFreeChart.setBackgroundPaint(Color.WHITE);
    CategoryAxis localCategoryAxis = localCategoryPlot.getDomainAxis();

    localCategoryPlot.setDomainAxis(localCategoryAxis);
    ValueAxis localValueAxis = localCategoryPlot.getRangeAxis();

    localValueAxis.setUpperMargin(0.15D);

    localValueAxis.setLowerMargin(0.15D);
    localCategoryPlot.setRangeAxis(localValueAxis);

    localBarRenderer3D.setBaseOutlinePaint(Color.BLACK);

    localBarRenderer3D.setWallPaint(Color.gray);

    localBarRenderer3D.setItemMargin(0.1D);

    localBarRenderer3D.setItemLabelGenerator(new StandardCategoryItemLabelGenerator());
    localBarRenderer3D.setItemLabelFont(new Font("黑体", 0, 12));
    localBarRenderer3D.setItemLabelsVisible(true);
    localCategoryPlot.setRenderer(localBarRenderer3D);

    localCategoryPlot.setForegroundAlpha(0.5F);

    FileOutputStream localFileOutputStream = null;
    try {
      localFileOutputStream = new FileOutputStream(paramString1);
      ChartUtilities.writeChartAsJPEG(localFileOutputStream, 100.0F, localJFreeChart, i, 300, null);

      return paramString1.substring(paramString1.lastIndexOf("/") + 1);
    }
    catch (FileNotFoundException localFileNotFoundException)
    {
      localFileNotFoundException.printStackTrace();

      return paramString1.substring(paramString1.lastIndexOf("/") + 1);
    }
    catch (IOException localIOException)
    {
      localIOException.printStackTrace();

      return paramString1.substring(paramString1.lastIndexOf("/") + 1);
    }
    finally
    {
      try
      {
        localFileOutputStream.close(); } catch (Exception localException5) {
      }
      if (i == 200) paramString1 = ""; 
    }
  }

  public static void main2()
  {
    double[][] arrayOfDouble = { { 672.0D, 766.0D, 223.0D, 540.0D, 126.0D }, { 325.0D, 521.0D, 210.0D, 340.0D, 106.0D }, { 332.0D, 256.0D, 523.0D, 240.0D, 526.0D } };
    String[] arrayOfString1 = { "苹果", "梨子", "葡萄" };
    String[] arrayOfString2 = { "北京", "上海", "广州", "成都", "深圳" };
  }
}