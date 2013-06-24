package regcheck;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class HardWareID
{
  String IPCONFIG_COMMAND_WIN = "ipconfig   /all";
  boolean realMac = true;
  String unique = "";

  public static String getMacAddress() { HardWareID localHardWareID = new HardWareID();
    return localHardWareID.getUnique().trim(); }

  private String getUnique()
  {
    String str = System.getProperty("os.name");

    if (str.startsWith("Windows")) {
      return getUniqueWindows();
    }
    return "";
  }

  private String getUniqueWindows()
  {
    String str1 = null;
    try {
      str1 = runConsoleCommand(this.IPCONFIG_COMMAND_WIN);
    }
    catch (IOException localIOException) {
      localIOException.printStackTrace();
    }

    StringTokenizer localStringTokenizer = new StringTokenizer(str1, "\n");
    while (localStringTokenizer.hasMoreTokens()) {
      String str2 = localStringTokenizer.nextToken().trim();

      int i = str2.indexOf(":");
      if (i > 0)
      {
        String str3 = str2.substring(i + 1).trim();

        if (isMacAddWin(str3)) {
          if (this.realMac == true) {
            generateUnique(str3);
          }
          else
            this.realMac = true;
        }
      }
    }
    return this.unique;
  }

  private void generateUnique(String paramString)
  {
    if (this.unique == "") {
      this.unique += paramString;
    }
    else {
      this.unique += "#";
      this.unique += paramString;
    }
  }

  private boolean isMacAddWin(String paramString) {
    Pattern localPattern = Pattern.compile("[0-9a-fA-F]{2}-[0-9a-fA-F]{2}-[0-9a-fA-F]{2}-[0-9a-fA-F]{2}-[0-9a-fA-F]{2}-[0-9a-fA-F]{2}");
    Matcher localMatcher = localPattern.matcher(paramString);
    return localMatcher.matches();
  }

  private boolean isMacAddOSX(String paramString)
  {
    if (paramString.length() != 17) {
      return false;
    }

    return true;
  }

  private String runConsoleCommand(String paramString)
    throws IOException
  {
    Process localProcess = Runtime.getRuntime().exec(paramString);
    BufferedInputStream localBufferedInputStream = new BufferedInputStream(localProcess.getInputStream());

    StringBuffer localStringBuffer = new StringBuffer();
    while (true) {
      int i = localBufferedInputStream.read();
      if (i == -1) {
        break;
      }
      localStringBuffer.append((char)i);
    }
    String str = localStringBuffer.toString();

    localBufferedInputStream.close();

    return str;
  }
  public static void main(String[] paramArrayOfString) {
    System.out.println(getMacAddress());
  }
}