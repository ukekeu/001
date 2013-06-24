package test;

import ConnDatabase.SDatabase;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.Date;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.data.time.Day;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;
import org.jfree.data.time.TimeSeriesDataItem;

public class DIYseries
{
  public static void main1(String paramString1, String paramString2, String paramString3)
  {
    String str1 = "趋势分析";

    String str2 = "各年走势";

    String str3 = "应收余额";

    String str4 = "2006财年分析";

    TimeSeries localTimeSeries = new TimeSeries("公司A");
    SDatabase localSDatabase = new SDatabase();
    try {
      ResultSet localResultSet = localSDatabase.executeQuery(paramString2);
      int i = localResultSet.getInt("minfloor");
      int j = localResultSet.getInt("maxfloor");

      for (int k = i; k <= j; k++) {
        ResultSet localObject = localSDatabase.executeQuery("select avg(sumprice) sumprice from room where seccode='zlhy' and Floor=" + String.valueOf(k));
        while (((ResultSet)localObject).next()) {
          int m = ((ResultSet)localObject).getInt("price");

          localTimeSeries.add(new TimeSeriesDataItem(new Day(1 + k, m + 1, k), new Double(m + Math.random() * 600.0D)));
        }

        localResultSet.close();
      }

      localResultSet.close(); } catch (Exception localException) {
      System.out.print(localException.getMessage());
    }

    TimeSeriesCollection localTimeSeriesCollection = new TimeSeriesCollection();
    localTimeSeriesCollection.addSeries(localTimeSeries);

    JFreeChart localJFreeChart = ChartFactory.createTimeSeriesChart(str1, str2, str3, localTimeSeriesCollection, true, true, false);

    long l = new Date().getTime();
    Object localObject = "Pie_" + l + ".jpeg";
    String str5 = paramString1;
    try
    {
      ChartUtilities.saveChartAsJPEG(new File(str5), 100.0F, localJFreeChart, 600, 600);
    }
    catch (IOException localIOException) {
      System.out.print("不能创建JPEG图片! 可能是文件的路径不正确");
    }
    System.out.println("输出保存在D://中 Pie_" + l + ".jpeg");
  }
}