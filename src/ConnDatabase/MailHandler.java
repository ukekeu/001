// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   MailHandler.java

package ConnDatabase;

import java.io.PrintStream;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

// Referenced classes of package ConnDatabase:
//            DmAuthenticator

public class MailHandler
    implements Runnable
{

    public MailHandler(String s, String as[], String s1, String s2)
    {
        from = s;
        to = as;
        title = s1;
        content = s2;
    }

    public void send()
    {
        Thread thread = new Thread(this);
        thread.start();
    }

    public void run()
    {
        System.out.println("mailhandler.java send .....");
        sendMail();
    }

    public void sendMail()
    {
        try
        {
            mailHost = "smtp.vip.163.com";
            Properties properties = new Properties();
            properties.put("mail.smtp.host", mailHost);
            Session session = null;
            if(mailAut != null && mailAut.equals("1"))
            {
                properties.put("mail.smtp.auth", "true");
                DmAuthenticator dmauthenticator = new DmAuthenticator(mailUser, mailPassword);
                session = Session.getInstance(properties, dmauthenticator);
            } else
            {
                session = Session.getInstance(properties, null);
            }
            MimeMessage mimemessage = new MimeMessage(session);
            mimemessage.setFrom(new InternetAddress(from));
            InternetAddress ainternetaddress[] = new InternetAddress[to.length];
            for(int i = 0; i < to.length; i++)
            {
                ainternetaddress[i] = new InternetAddress(to[i]);
                System.out.println("to[" + i + "] : " + to[i]);
            }

            mimemessage.setRecipients(javax.mail.Message.RecipientType.TO, ainternetaddress);
            mimemessage.setSubject(title);
            mimemessage.setText(content);
            mimemessage.setSentDate(new Date());
            System.out.println(mimemessage);
            Transport.send(mimemessage);
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        finally { }
    }

    public static String[] getToMails(String as[])
        throws Exception
    {
        String s = "";
        for(int i = 0; i < as.length; i++)
        {
            if(i > 0)
                s = s + ",";
            s = s + as[i];
        }

        try
        {
            Object aobj[][] = {
                {
                    null, "zlcrm@vip.163.com"
                }
            };
            String as1[] = new String[aobj.length];
            for(int j = 0; j < aobj.length; j++)
                as1[j] = (String)aobj[j][1];

            return as1;
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        return new String[0];
    }

    public static String getMailAddress(int i)
    {
        try
        {
            String s = "select user_id, email_address from tw_user where user_id =" + i;
            Object aobj[][] = {
                {
                    null, "zlcrm@vip.163.com"
                }
            };
            if(aobj.length < 1)
                return "";
            else
                return (String)aobj[0][1];
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        return "";
    }

    public static String mailHost = "";
    public static String mailAut = "1";
    public static String mailUser = "zlsale";
    public static String mailPassword = "zlsale";
    public static String workflowTitle = "\u4F60\u6709\u4E00\u4E2A\u6D41\u7A0B\u4EF6";
    public static String distributeTitle = "\u4F60\u6709\u4E00\u4E2A\u5206\u53D1\u4EF6";
    public static String cuibanTitle = "\u4F60\u6709\u4E00\u4E2A\u50AC\u529E\u4EF6";
    public static Map mailMap = new HashMap();
    private String from;
    private String to[];
    private String title;
    private String content;

}
