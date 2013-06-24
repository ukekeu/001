package net.fiyu.edit;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.PrintStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

public class RemotePic
{
  public String picurl;
  public String savepath;

  public boolean download()
  {
    String s = this.picurl;
    String s1 = this.savepath;
    try
    {
      URL url = new URL(s);
      URLConnection urlconnection = url.openConnection();
      urlconnection.connect();
      HttpURLConnection httpurlconnection = (HttpURLConnection)urlconnection;
      int i = httpurlconnection.getResponseCode();
      if (i != 200)
      {
        System.out.println("Connect to " + s + " failed,return code:" + i);
        return false;
      }
      int j = urlconnection.getContentLength();
      InputStream inputstream = urlconnection.getInputStream();
      byte[] abyte0 = new byte[1024];
      File file = new File(s1);
      if (!file.exists())
        file.createNewFile();
      FileOutputStream fileoutputstream = new FileOutputStream(file);
      int k = 0;
      if (j < 0)
      {
        while (k > -1)
        {
          k = inputstream.read(abyte0);
          if (k > 0)
            fileoutputstream.write(abyte0, 0, k);
        }
      }
      else
      {
    	  int l  = 0;
        for (l = 0; (l < j) && (k != -1); )
        {
          k = inputstream.read(abyte0);
          if (k > 0)
          {
            fileoutputstream.write(abyte0, 0, k);
            l += k;
          }
        }

        if (l < j)
        {
          System.out.println("download error");
          inputstream.close();
          fileoutputstream.close();
          file.delete();
          return false;
        }
      }
      fileoutputstream.flush();
      fileoutputstream.close();
      inputstream.close();
    }
    catch (Exception exception)
    {
      exception.printStackTrace();
      return false;
    }
    return true;
  }
}