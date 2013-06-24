// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   MailHandler.java

package ConnDatabase;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

class DmAuthenticator extends Authenticator
{

    public DmAuthenticator(String s, String s1)
    {
        username = null;
        password = null;
        username = s;
        password = s1;
    }

    protected PasswordAuthentication getPasswordAuthentication()
    {
        return new PasswordAuthentication(username, password);
    }

    String username;
    String password;
}
