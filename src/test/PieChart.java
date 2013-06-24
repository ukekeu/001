package test;

import ConnDatabase.SDatabase;
import java.awt.Color;
import java.awt.Font;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.general.DefaultPieDataset;

public class PieChart
{
  public String drawToFile(String paramString1, String paramString2, String paramString3)
  {
    int i = 100;
    DefaultPieDataset localDefaultPieDataset = new DefaultPieDataset();
    SDatabase localSDatabase = new SDatabase();
    try {
      ResultSet localResultSet = localSDatabase.executeQuery(paramString2);
      while (localResultSet.next()) {
        i += 100;
        String localObject1 = localResultSet.getString(1);
        double d = localResultSet.getDouble(2);
        localDefaultPieDataset.setValue((Comparable)localObject1, d);
      }
      localResultSet.close(); } catch (Exception localException1) {
      System.out.print(localException1.getMessage());
    }

    JFreeChart localJFreeChart = ChartFactory.createPieChart(paramString3, localDefaultPieDataset, true, true, true);
    localJFreeChart.setTitle(new TextTitle(paramString3, new Font("隶书", 2, 15)));

    Object localObject1 = (PiePlot)localJFreeChart.getPlot();
    ((PiePlot)localObject1).setForegroundAlpha(0.9F);

    localJFreeChart.setBackgroundPaint(Color.white);

    localJFreeChart.setBackgroundPaint(Color.white);

    Font localFont = new Font("黑体", 1, 15);
    TextTitle localTextTitle = new TextTitle(paramString3);
    localTextTitle.setFont(localFont); localJFreeChart.setTitle(localTextTitle);
    ((PiePlot)localObject1).setExplodePercent(0, 0.2D);

    ((PiePlot)localObject1).setLabelGenerator(new StandardPieSectionLabelGenerator("{0}={2}", NumberFormat.getNumberInstance(), new DecimalFormat("0.00%")));
    ((PiePlot)localObject1).setBackgroundPaint(Color.white);

    ((PiePlot)localObject1).setBackgroundAlpha(0.6F);

    ((PiePlot)localObject1).setForegroundAlpha(0.9F);

    FileOutputStream localFileOutputStream = null;
    try {
      localFileOutputStream = new FileOutputStream(paramString1);
      ChartUtilities.writeChartAsJPEG(localFileOutputStream, 100.0F, localJFreeChart, 500, 400, null);
    } catch (FileNotFoundException localFileNotFoundException) {
      localFileNotFoundException.printStackTrace();
    } catch (IOException localIOException) {
      localIOException.printStackTrace();
    } finally {
      try {
        localFileOutputStream.close(); } catch (Exception localException5) {
      }
    }
    if (i == 100) paramString1 = "";
    return paramString1.substring(paramString1.lastIndexOf("/") + 1);
  }
}