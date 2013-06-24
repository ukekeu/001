package regcheck;

import java.util.prefs.Preferences;

public class writereadregedit
{
  public void readinfo(String paramString1, String paramString2, String paramString3, String paramString4, String paramString5)
  {
    String[] arrayOfString1 = { "zlsoft", "sysdate", "author", "softfg", "project", "online", "regdate" };

    String[] arrayOfString2 = { "zhonglan technology company", paramString1, "zltc.net", paramString2, paramString3, paramString4, paramString5 };

    Preferences localPreferences = Preferences.userRoot().node("/com/syssoft/syscrm");

    for (int i = 0; i < arrayOfString1.length; i++)
    {
      localPreferences.put(arrayOfString1[i], arrayOfString2[i]);
    }
  }

  public String writeinfo()
  {
    String str = "";
    String[] arrayOfString = { "zlsoft", "sysdate", "author", "softfg", "project", "online", "regdate" };

    Preferences localPreferences = Preferences.userRoot().node("/com/syssoft/syscrm");

    for (int i = 0; i < arrayOfString.length; i++)
    {
      str = str + localPreferences.get(arrayOfString[i], str);
    }
    return str;
  }

  public String readRegDate()
  {
    String str = "";
    String[] arrayOfString = { "zlsoft", "sysdate", "author", "softfg", "project", "online", "regdate" };

    Preferences localPreferences = Preferences.userRoot().node("/com/syssoft/syscrm");

    str = str + localPreferences.get("sysdate", str);

    return str;
  }

  public String readRegsDate() {
    String str = "";
    String[] arrayOfString = { "zlsoft", "sysdate", "author", "softfg", "project", "online", "regdate" };

    Preferences localPreferences = Preferences.userRoot().node("/com/syssoft/syscrm");

    str = str + localPreferences.get("regdate", str);

    return str;
  }

  public String readRegState() {
    String str = "";
    String[] arrayOfString = { "zlsoft", "sysdate", "author", "softfg", "project", "online", "regdate" };

    Preferences localPreferences = Preferences.userRoot().node("/com/syssoft/syscrm");

    str = str + localPreferences.get("softfg", str);

    return str;
  }

  public String readRegProject()
  {
    String str = "";
    String[] arrayOfString = { "zlsoft", "sysdate", "author", "softfg", "project", "online", "regdate" };

    Preferences localPreferences = Preferences.userRoot().node("/com/syssoft/syscrm");

    str = str + localPreferences.get("project", str);

    return str;
  }

  public String readRegOnline()
  {
    String str = "";
    String[] arrayOfString = { "zlsoft", "sysdate", "author", "softfg", "project", "online", "regdate" };

    Preferences localPreferences = Preferences.userRoot().node("/com/syssoft/syscrm");

    str = str + localPreferences.get("online", str);

    return str;
  }

  public void delAllReg()
  {
    String[] arrayOfString = { "zlsoft", "sysdate", "author", "softfg", "project", "online", "regdate" };

    Preferences localPreferences = Preferences.userRoot().node("/com/syssoft/syscrm");
    try
    {
      localPreferences.removeNode();
    }
    catch (Exception localException)
    {
    }
  }
}