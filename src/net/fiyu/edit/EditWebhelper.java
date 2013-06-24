package net.fiyu.edit;

import java.io.File;
import java.io.PrintStream;
import java.util.Iterator;
import java.util.List;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class EditWebhelper
{
  String[] aButtonCode = new String[this.size]; String[] aButtonHTML = new String[this.size];

  Document document = null;
  Document document2 = null;
  EditWebhelper ew = null;

  public String filename = "D:/style2.xml";
  public String filename2 = "D:/button2.xml";

  String sStyleDir = "blue";

  int size = 255;

  public String Code2HTML(String s_Code)
  {
    String CodeToHTML = "";
    for (int i = 0; i < this.size; i++) {
      if (this.aButtonCode[i].equals(s_Code)) {
        CodeToHTML = this.aButtonHTML[i];
        return CodeToHTML;
      }
    }
    return CodeToHTML;
  }

  public void InitButtonArray()
  {
    try
    {
      List list = this.document2.selectNodes("Edit_Button/bcode");
      List list2 = this.document2.selectNodes("Edit_Button/bcode/@name");
      Iterator it = list.iterator();
      Iterator it2 = list2.iterator();
      int i = 0;
      int option = 0;
      while (it.hasNext()) {
        Attribute attribute = (Attribute)it2.next();
        Element button = (Element)it.next();
        this.aButtonCode[i] = attribute.getValue();
        option = Integer.parseInt(memoString(button, "btype").getTextTrim());

        switch (option) {
        case 0:
          this.aButtonHTML[i] = ("<DIV CLASS=\"" + memoString(button, "bclass").getTextTrim() + "\" TITLE=\"" + memoString(button, "btitle").getTextTrim() + "\" onclick=\"" + memoString(button, "bevent").getTextTrim() + "\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/" + this.sStyleDir + "/" + memoString(button, "bimage").getTextTrim() + "\"></DIV>");

          break;
        case 1:
          this.aButtonHTML[i] = ("<SELECT CLASS=\"" + memoString(button, "bclass").getTextTrim() + "\" onchange=\"" + memoString(button, "bevent").getTextTrim() + "\">" + memoString(button, "bhtml").getTextTrim() + "</SELECT>");

          break;
        case 2:
          this.aButtonHTML[i] = ("<DIV CLASS=\"" + memoString(button, "bclass").getTextTrim() + "\">" + notNull(memoString(button, "bhtml").getTextTrim()) + "</DIV>");

          break;
        }

        i++;
      }

      this.size = i;
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  public EditBean InitPara()
  {
    EditBean bean = new EditBean();
    String sToolBar = "";
    try {
      List list = this.document.selectNodes("Edit_Style/style");
      bean.setSAutoRemote(getNodeValue(list, "sautoremote"));
      bean.setSStyleName("standard");
      bean.setSBaseUrl(getNodeValue(list, "sbaseurl"));
      bean.setSDetectFromWord(getNodeValue(list, "sdetectfromword"));
      bean.setSInitMode(getNodeValue(list, "sinitmod"));
      bean.setSStyleID(getNodeValue(list, "sid"));
      bean.setSStyleDir(getNodeValue(list, "sdir"));
      bean.setNStateFlag(getNodeValue(list, "sstateflag"));
      this.sStyleDir = getNodeValue(list, "sdir");

      InitButtonArray();

      String[] aButton = getNodeValue(list, "stoolbar1").split("\\|");
      sToolBar = "<table border=0 cellpadding=0 cellspacing=0 width='100%' class='Toolbar' id='eWebEditor_Toolbar'>";
      sToolBar = sToolBar + "<tr><td><div class='yToolbar'>";
      for (int i = 0; i < aButton.length; i++)
      {
        if (aButton[i].equalsIgnoreCase("MAXIMIZE"))
          aButton[i] = "Minimize";
        sToolBar = sToolBar + Code2HTML(aButton[i]);
      }
      sToolBar = sToolBar + "</div></td></tr>";
      String[] aButton2 = getNodeValue(list, "stoolbar2").split("\\|");
      sToolBar = sToolBar + "<tr><td><div class='yToolbar'>";
      for (int j = 0; j < aButton2.length; j++) {
        if (aButton2[j].equalsIgnoreCase("MAXIMIZE"))
          aButton2[j] = "Minimize";
        sToolBar = sToolBar + Code2HTML(aButton2[j]);
      }
      sToolBar = sToolBar + "</div></td></tr></table>";
      bean.setSToolBar(sToolBar);
      bean.setSStyleName(getNodeValue(list, "sdir"));
      bean.setSStyleUploadDir(getNodeValue(list, "suploaddir"));
      bean.setSVersion("飞鱼修改版");
      bean.setSReleaseDate("2004-11-30");
    }
    catch (Exception e)
    {
      System.out.println(e.getMessage());
    }
    this.document = null;
    return bean;
  }

  public EditWebhelper getInstance()
  {
    EditWebhelper ew = new EditWebhelper();
    try {
      SAXReader saxReader = new SAXReader();
      this.document = saxReader.read(new File(this.filename));
      this.document2 = saxReader.read(new File(this.filename2));
    }
    catch (Exception e) {
      System.out.println(e.getMessage());
    }
    return ew;
  }

  public String getNodeValue(List list, String Node)
  {
    Iterator it = list.iterator();
    if (it.hasNext()) {
      Element styleElement = (Element)it.next();

      Iterator memo = styleElement.elementIterator(Node);
      if (memo.hasNext()) {
        Element memostring = (Element)memo.next();
        return memostring.getTextTrim();
      }

      return "";
    }

    return "";
  }

  public static void main(String[] args)
  {
    EditWebhelper editWebhelper1 = new EditWebhelper();
    editWebhelper1.filename = "D:/style2.xml";
    editWebhelper1.getInstance();
    EditBean bean = editWebhelper1.InitPara();
    System.out.println(bean.getSToolBar());
  }

  public Element memoString(Element button, String Node)
  {
    Iterator memo = button.elementIterator(Node);
    if (memo.hasNext()) {
      Element memostring = (Element)memo.next();
      return memostring;
    }

    return null;
  }

  public String notNull(String str)
  {
    String s = str;
    if (str == null) {
      return "";
    }
    return s;
  }
}