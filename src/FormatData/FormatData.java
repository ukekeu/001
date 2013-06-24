package FormatData;

import java.text.DecimalFormat;

public class FormatData
{
  public String getFloat(float paramFloat, int paramInt)
  {
    DecimalFormat localDecimalFormat = null;
    if (paramInt == 4)
      localDecimalFormat = new DecimalFormat("###,###,###,##0.0000");
    if (paramInt == 3)
      localDecimalFormat = new DecimalFormat("###,###,###,##0.000");
    if (paramInt == 2)
      localDecimalFormat = new DecimalFormat("###,###,###,##0.00");
    if (paramInt == 1)
      localDecimalFormat = new DecimalFormat("###,###,###,##0.0");
    if (paramInt == 0)
      localDecimalFormat = new DecimalFormat("###,###,###,##0");
    return localDecimalFormat.format(paramFloat).toString();
  }

  public String getFloat1(float paramFloat, int paramInt) {
    DecimalFormat localDecimalFormat = null;
    if (paramInt == 4)
      localDecimalFormat = new DecimalFormat("##########0.0000");
    if (paramInt == 3)
      localDecimalFormat = new DecimalFormat("##########0.000");
    if (paramInt == 2)
      localDecimalFormat = new DecimalFormat("###########0.00");
    if (paramInt == 1)
      localDecimalFormat = new DecimalFormat("###########0.0");
    if (paramInt == 0)
      localDecimalFormat = new DecimalFormat("###########0");
    return localDecimalFormat.format(paramFloat).toString();
  }
  public String getFloat2(double paramDouble, int paramInt) {
    DecimalFormat localDecimalFormat = null;
    if (paramInt == 4)
      localDecimalFormat = new DecimalFormat("###,###,###,###,##0.0000");
    if (paramInt == 3)
      localDecimalFormat = new DecimalFormat("###,###,###,###,##0.000");
    if (paramInt == 2)
      localDecimalFormat = new DecimalFormat("###,###,###,###,##0.00");
    if (paramInt == 1)
      localDecimalFormat = new DecimalFormat("###,###,###,###,##0.0");
    if (paramInt == 0)
      localDecimalFormat = new DecimalFormat("###,###,###,###,##0");
    return localDecimalFormat.format(paramDouble).toString();
  }

  public String getFloat3(double paramDouble, int paramInt) {
    DecimalFormat localDecimalFormat = null;
    if (paramInt == 4)
      localDecimalFormat = new DecimalFormat("###########0.0000");
    if (paramInt == 3)
      localDecimalFormat = new DecimalFormat("###########0.000");
    if (paramInt == 2)
      localDecimalFormat = new DecimalFormat("###########0.00");
    if (paramInt == 1)
      localDecimalFormat = new DecimalFormat("###########0.0");
    if (paramInt == 0)
      localDecimalFormat = new DecimalFormat("###########0");
    return localDecimalFormat.format(paramDouble).toString();
  }
}