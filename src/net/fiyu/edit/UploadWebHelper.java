package net.fiyu.edit;

import java.io.File;
import java.io.PrintStream;
import java.util.Iterator;
import java.util.List;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class UploadWebHelper
{
  Document document = null;
  EditWebhelper ew = null;

  public String filename = "D:/style2.xml";

  public UploadBean InitPara()
  {
    UploadBean bean = new UploadBean();
    String sToolBar = "";
    try {
      List list = this.document.selectNodes("Edit_Style/style");
      bean.setSfileext(getNodeValue(list, "sfileext"));
      bean.setSfilesize(getNodeValue(list, "sfilesize"));
      bean.setSflashext(getNodeValue(list, "sflashext"));
      bean.setSflashsize(getNodeValue(list, "sflashsize"));
      bean.setSimageext(getNodeValue(list, "simageext"));
      bean.setSimagesize(getNodeValue(list, "simagesize"));
      bean.setSmediaext(getNodeValue(list, "smediaext"));
      bean.setSmediasize(getNodeValue(list, "smediasize"));
      bean.setSremoteext(getNodeValue(list, "sremoteext"));
      bean.setSremotesize(getNodeValue(list, "sremotesize"));
      bean.setSuploaddir(getNodeValue(list, "suploaddir"));
    }
    catch (Exception e) {
      System.out.println(e.getMessage());
    }
    this.document = null;
    return bean;
  }

  public UploadWebHelper getInstance()
  {
    UploadWebHelper uw = new UploadWebHelper();
    try {
      SAXReader saxReader = new SAXReader();
      this.document = saxReader.read(new File(this.filename));
    }
    catch (Exception e) {
      System.out.println(e.getMessage());
    }
    return uw;
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
    UploadWebHelper w = new UploadWebHelper();
    w.getInstance();
    UploadBean bean = w.InitPara();
    System.out.println(bean.getSfileext());
  }
}