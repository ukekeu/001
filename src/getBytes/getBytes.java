package getBytes;

import javax.servlet.http.HttpServletRequest;

public class getBytes
{
  public String getParameter(HttpServletRequest httpservletrequest, String s)
    throws Exception
  {
    String s1 = "";
    s1 = s;
    if (s1 == null)
      s1 = "";
    s1 = new String(s1.getBytes("ISO8859_1"), "GBK");
    return s1;
  }

  public String getPara(String s) throws Exception
  {
    String s1 = "";
    s1 = s;
    if (s1 == null)
      s1 = "";
    s1 = new String(s1.getBytes("ISO8859_1"), "GBK");
    return s1;
  }

  public String Repalce4(String str, String str1) {
    String disnum = str.trim();
    int num = 0;
    int num1 = 0;
    int jj = 0;
    for (int ii = 0; ii < disnum.length(); ii++) {
      if (disnum.substring(ii, ii + 1).equals("/")) jj++;
    }

    String[] arry = new String[jj + 1];
    boolean sss = false;
    for (int n = 0; n < disnum.length(); n++)
    {
      if (disnum.substring(n, n + 1).equals(str1)) {
        sss = true;
        arry[num] = disnum.substring(num1, n).trim();
        num1 = n + 1;
        num++;
        if (!disnum.substring(n + 1).equals(str1))
          arry[num] = disnum.substring(n + 1).trim();
      }
    }
    disnum = "";
    for (int n1 = 0; n1 <= num; n1++)
    {
      if (arry[n1] != null) {
        if (n1 == 0) disnum = "'" + arry[n1] + "'";
        else if (!arry[n1].equals(arry[(n1 - 1)])) disnum = disnum + ",'" + arry[n1] + "'";
      }
    }

    if (!sss) disnum = str.trim();

    return disnum;
  }
  public String Repalce6(String str, String str1) {
    String disnum = str.trim();
    int num = 0;
    int num1 = 0;
    int jj = 0;
    for (int ii = 0; ii < disnum.length(); ii++) {
      if (disnum.substring(ii, ii + 1).equals("/")) jj++;
    }

    String[] arry = new String[jj + 1];
    boolean sss = false;
    for (int n = 0; n < disnum.length(); n++)
    {
      if (disnum.substring(n, n + 1).equals(str1)) {
        sss = true;
        arry[num] = disnum.substring(num1, n).trim();
        num1 = n + 1;
        num++;
        if (!disnum.substring(n + 1).equals(str1))
          arry[num] = disnum.substring(n + 1).trim();
      }
    }
    disnum = "";
    for (int n1 = 0; n1 <= num; n1++)
    {
      if (arry[n1] != null) {
        if (n1 == 0) disnum = "''" + arry[n1] + "''";
        else if (!arry[n1].equals(arry[(n1 - 1)])) disnum = disnum + ",''" + arry[n1] + "''";
      }
    }

    if (!sss) disnum = str.trim();

    return disnum;
  }
}