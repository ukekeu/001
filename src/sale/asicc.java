// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   asicc.java

package sale;


public class asicc
{

    public asicc()
    {
        day = 0;
        fg = 0;
        state = 1;
        alertmess = "";
        userregno = "";
        Upp = "";
    }

    public String AsiicZH(int i, char c)
    {
        String s = " ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
        Upp = s;
        if(!Character.isDigit(c))
            s = s.substring(i, 1 + i);
        else
            s = String.valueOf(i);
        return s;
    }

    public String AsiicF(int i, String s)
    {
        String s1 = " ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
        Upp = s1;
        if(Upp.indexOf(s) >= 0)
            s1 = s1.substring(i, 1 + i);
        else
            s1 = String.valueOf(i);
        return s1;
    }

    public String AsiicFloorType(String s, String s1)
    {
        String s2 = "";
        if(s1.equals("1"))
        {
            if(s.equals("A"))
                s2 = "-1";
            else
            if(s.equals("B"))
                s2 = "-2";
            else
            if(s.equals("C"))
                s2 = "-3";
            else
            if(s.equals("D"))
                s2 = "-4";
            else
            if(s.equals("E"))
                s2 = "-5";
            else
            if(s.equals("F"))
                s2 = "-6";
            else
            if(s.equals("G"))
                s2 = "-7";
            else
            if(s.equals("H"))
                s2 = "-8";
        } else
        {
            s2 = s;
        }
        return s2;
    }

    public int day;
    public int fg;
    public int state;
    public String alertmess;
    public String userregno;
    public String Upp;
}
