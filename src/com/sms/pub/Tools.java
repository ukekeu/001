// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Tools.java

package com.sms.pub;

import java.io.PrintStream;
import java.util.Calendar;
import java.util.StringTokenizer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ConnDatabase.SDatabase;

public class Tools
{
	private static Logger logger = LoggerFactory.getLogger(Tools.class);

    public Tools()
    {
    }

    public static int b2i(byte b[], int iFrom, int iLen)
    {
        int iRet = 0;
        for(int i = iFrom; i < iFrom + iLen && i < b.length; i++)
        {
            int iTep = b[i];
            if(iTep < 0)
                iTep += 256;
            iRet = iRet << 8 | iTep;
        }

        return iRet;
    }

    public static void i2b(int iData, byte b[], int iFrom, int iLen)
    {
        int id = iData;
        int iOff = iLen - 1;
        if(iOff < 0)
            iOff = 0;
        for(int i = iFrom; i < iFrom + iLen && i < b.length; i++)
            if(i - iFrom < 4)
                b[i] = (byte)(id >> (iOff - (i - iFrom)) * 8 & 0xff);
            else
                b[i] = 0;

    }

    public static void s2b(String s, byte b[], int iFrom, int iLen, byte bFill)
    {
        byte t[] = null;
        if(s != null && s.length() > 0)
            t = s.getBytes();
        if(t == null)
        {
            for(int i = iFrom; i < iFrom + iLen && i < b.length; i++)
                b[i] = bFill;

        } else
        {
            for(int i = iFrom; i < iFrom + iLen && i < b.length; i++)
                if(i - iFrom < t.length)
                    b[i] = t[i - iFrom];
                else
                    b[i] = bFill;

        }
    }

    public static String b2s(byte b[], int iFrom, int iLen, byte bCut)
    {
        if(b == null || iFrom + iLen > b.length)
            return null;
        if(iLen < 1)
            return "";
        String s = new String(b, iFrom, iLen);
        if(s == null || s.length() == 0)
            return "";
        int i;
        for(i = s.length() - 1; i >= 0 && s.charAt(i) == (char)bCut; i--);
        if(i < 0)
            return "";
        else
            return s.substring(0, i + 1);
    }

    public static String b2s(byte b[], int iFrom, byte bEnd)
    {
        if(b == null || iFrom >= b.length)
            return null;
        int iTo = b.length;
        int i = iFrom;
        do
        {
            if(i >= b.length)
                break;
            if(b[i] == bEnd)
            {
                iTo = i;
                break;
            }
            i++;
        } while(true);
        if(iTo <= iFrom)
            return "";
        else
            return new String(b, iFrom, iTo - iFrom);
    }

    public static byte[] h2b(String sVal)
    {
        if(sVal == null || sVal.length() == 0)
            return null;
        sVal = sVal.toUpperCase();
        int iLen = sVal.length();
        if(iLen % 2 == 1)
            sVal = "0".concat(String.valueOf(String.valueOf(sVal)));
        iLen = sVal.length() / 2;
        byte b[] = new byte[iLen];
        for(int i = 0; i < iLen; i++)
        {
            char c1 = sVal.charAt(2 * i);
            char c2 = sVal.charAt(2 * i + 1);
            b[i] = c2b(c1, c2);
        }

        return b;
    }

    public static byte c2b(char c1, char c2)
    {
        byte b1;
        if(c1 >= 'A')
            b1 = (byte)((c1 - 65) + 10);
        else
            b1 = (byte)(c1 - 48);
        byte b2;
        if(c2 >= 'A')
            b2 = (byte)((c2 - 65) + 10);
        else
            b2 = (byte)(c2 - 48);
        return (byte)(b1 << 4 | b2);
    }

    public static String b2h(byte b)
    {
        int i = b;
        if(i < 0)
            i += 256;
        String s = "";
        int ih = i >> 4;
        int il = i & 0xf;
        if(ih >= 10)
            ih += 55;
        else
            ih += 48;
        if(il >= 10)
            il += 55;
        else
            il += 48;
        return s = String.valueOf(String.valueOf((char)ih)) + String.valueOf(String.valueOf((char)il));
    }

    public static void showBin(byte b[])
    {
        if(b == null)
        {
        	logger.info("null bytes!");
            return;
        } else
        {
            showBin(b, 0, b.length);
            return;
        }
    }

    public static void showBin(byte b[], int iFrom, int iLen)
    {
        if(b == null)
        {	 logger.info("\r\n");
        	logger.info("null bytes!");
            return;
        }
        logger.info("bytes length=".concat(String.valueOf(String.valueOf(b.length))));
        for(int i = iFrom; i < b.length && i < iFrom + iLen; i++)
        {
            if(i > 0 && i % 16 == 0)
            	logger.info(String.valueOf(String.valueOf(b2h(b[i]))).concat("-"));
        }

        logger.info("\r\n");
    }

    public static void addb(byte fb[], byte tb[], int iFrom, int iLen, byte bFill)
    {
        int iAdd = 0;
        if(fb != null)
        {
            for(int i = iFrom; i < tb.length && i < iFrom + iLen && i < iFrom + fb.length; i++)
            {
                tb[i] = fb[i - iFrom];
                iAdd++;
            }

        }
        for(; iAdd < iLen && iFrom + iAdd < tb.length; iAdd++)
            tb[iFrom + iAdd] = bFill;

    }

    public static byte[] cutb(byte fb[], int iFrom, int iLen, byte bCut)
    {
        int iAdd = 0;
        if(fb == null || iFrom >= fb.length)
            return null;
        int it = iFrom + iLen;
        if(it > fb.length)
            it = fb.length;
        for(it--; it >= iFrom && fb[it] == bCut; it--);
        if(it < iFrom)
        {
            return null;
        } else
        {
            int iLef = (it + 1) - iFrom;
            byte r[] = new byte[iLef];
            System.arraycopy(fb, iFrom, r, 0, iLef);
            return r;
        }
    }

    public static String toDate(String s)
    {
        if(s == null || s.length() < 8)
            return null;
        String s0 = s;
        long l = -1L;
        try
        {
            l = Long.parseLong(s0);
        }
        catch(Exception exception) { }
        if(l <= (long)0)
            s0 = "20000101";
        for(; s0.length() < 14; s0 = String.valueOf(String.valueOf(s0)).concat("0"));
        String sy = s0.substring(0, 4);
        String sm = s0.substring(4, 6);
        String sd = s0.substring(6, 8);
        String sh = s0.substring(8, 10);
        String mi = s0.substring(10, 12);
        String ss = s0.substring(12, 14);
        String s1 = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(sy)))).append("-").append(sm).append("-").append(sd).append(" ").append(sh).append(":").append(mi).append(":").append(ss)));
        String sDate = String.valueOf(String.valueOf((new StringBuffer("convert(datetime,'")).append(s1).append("')")));
        return sDate;
    }

    public static String getDate()
    {
        Calendar c = Calendar.getInstance();
        int iYear = c.get(1);
        int iMon = c.get(2) + 1;
        int iDay = c.get(5);
        String sYear = String.valueOf(iYear);
        if(iYear < 10)
            sYear = "0".concat(String.valueOf(String.valueOf(sYear)));
        String sMon = String.valueOf(iMon);
        if(iMon < 10)
            sMon = "0".concat(String.valueOf(String.valueOf(sMon)));
        String sDay = String.valueOf(iDay);
        if(iDay < 10)
            sDay = "0".concat(String.valueOf(String.valueOf(sDay)));
        return String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(sYear)))).append(sMon).append(sDay)));
    }

    public static String getTime()
    {
        Calendar c = Calendar.getInstance();
        int iHour = c.get(11);
        int iMin = c.get(12);
        int iSec = c.get(13);
        String sHour = String.valueOf(iHour);
        if(iHour < 10)
            sHour = "0".concat(String.valueOf(String.valueOf(sHour)));
        String sMin = String.valueOf(iMin);
        if(iMin < 10)
            sMin = "0".concat(String.valueOf(String.valueOf(sMin)));
        String sSec = String.valueOf(iSec);
        if(iSec < 10)
            sSec = "0".concat(String.valueOf(String.valueOf(sSec)));
        return String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(sHour)))).append(sMin).append(sSec)));
    }

    public static String getTimeStamp()
    {
        Calendar c = Calendar.getInstance();
        int iMon = c.get(2) + 1;
        int iDay = c.get(5);
        int iHour = c.get(11);
        int iMin = c.get(12);
        int iSec = c.get(13);
        String sMon = String.valueOf(iMon);
        if(iMon < 10)
            sMon = "0".concat(String.valueOf(String.valueOf(sMon)));
        String sDay = String.valueOf(iDay);
        if(iDay < 10)
            sDay = "0".concat(String.valueOf(String.valueOf(sDay)));
        String sHour = String.valueOf(iHour);
        if(iHour < 10)
            sHour = "0".concat(String.valueOf(String.valueOf(sHour)));
        String sMin = String.valueOf(iMin);
        if(iMin < 10)
            sMin = "0".concat(String.valueOf(String.valueOf(sMin)));
        String sSec = String.valueOf(iSec);
        if(iSec < 10)
            sSec = "0".concat(String.valueOf(String.valueOf(sSec)));
        return String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(sMon)))).append(sDay).append(sHour).append(sMin).append(sSec)));
    }

    public static boolean haveChina(byte b[])
    {
        if(b == null)
            return false;
        for(int i = 0; i < b.length; i++)
            if(b[i] < 0 || b[i] > 127)
                return true;

        return false;
    }

    public static boolean isNumber(String s)
    {
        if(s == null || s.length() == 0)
            return false;
        for(int i = 0; i < s.length(); i++)
        {
            char c = s.charAt(i);
            if(c < '0' || c > '9')
                return false;
        }

        return true;
    }

    public static String getString(byte b[], int iFrom, int iLen)
    {
        if(b == null || b.length < iFrom + iLen)
            return null;
        String s = "";
        for(int i = iFrom; i < iFrom + iLen; i++)
        {
            int b1 = b[i];
            if(b1 < 0)
                b1 += 256;
            int b2;
            if(++i < iFrom + iLen)
                b2 = b[i];
            else
                b2 = 0;
            if(b2 < 0)
                b2 += 256;
            char c = (char)(b1 << 8 | b2);
            s = String.valueOf(s) + String.valueOf(String.valueOf(c));
        }

        return s;
    }

    public static String getString1(byte b[], int iFrom, int iLen)
    {
        if(b == null || b.length < iFrom + iLen)
            return null;
        String s = "";
        boolean bSub = false;
        for(int i = iFrom; i < iFrom + iLen; i++)
            if(b[i] == 0)
                bSub = true;

        if(!bSub)
            try
            {
                String st = new String(b, iFrom, iLen);
                if(st != null && st.length() == iLen)
                {
                    String s1 = st;
                    return s1;
                }
            }
            catch(Exception exception) { }
        for(int i = iFrom; i < iFrom + iLen; i++)
        {
            int b1 = b[i];
            if(b1 < 0)
                b1 += 256;
            int b2;
            if(++i < iFrom + iLen)
                b2 = b[i];
            else
                b2 = 0;
            if(b2 < 0)
                b2 += 256;
            if(b1 == 0)
            {
                if(b2 != 0)
                    s = String.valueOf(s) + String.valueOf(String.valueOf((char)b2));
                continue;
            }
            if(b2 != 0)
            {
                char c = (char)(b1 << 8 | b2);
                s = String.valueOf(s) + String.valueOf(String.valueOf(c));
            } else
            {
                s = String.valueOf(s) + String.valueOf(String.valueOf((char)b1));
            }
        }

        return s;
    }

    public static String trimChar(String strTemp, String charTemp)
    {
        if(strTemp == null || strTemp.equals(""))
            return "";
        if(charTemp == null || charTemp.equals(""))
            charTemp = ",";
        if(strTemp.startsWith(charTemp))
            strTemp = strTemp.substring(charTemp.length(), strTemp.length() - 1);
        if(strTemp.endsWith(charTemp))
            strTemp = strTemp.substring(0, strTemp.length() - charTemp.length());
        return strTemp;
    }

    public static String[] splite(String str, String charTemp)
    {
        if(charTemp == null || charTemp.equals(""))
            charTemp = ",";
        StringTokenizer token = new StringTokenizer(str, charTemp);
        String result[] = new String[token.countTokens()];
        for(int i = 0; token.hasMoreTokens(); i++)
            result[i] = token.nextToken();

        return result;
    }

    public static String replaceStr(String str, String pattern, String replace)
    {
        int s = 0;
        int e = 0;
        StringBuffer result = new StringBuffer();
        while((e = str.indexOf(pattern, s)) >= 0) 
        {
            result.append(str.substring(s, e));
            result.append(replace);
            s = e + pattern.length();
        }
        result.append(str.substring(s));
        return result.toString();
    }

    public static String URLEncoding(String strContent)
    {
        strContent = replaceStr(strContent, "%", "%25");
        strContent = replaceStr(strContent, "!", "%21");
        strContent = replaceStr(strContent, "#", "%23");
        strContent = replaceStr(strContent, "$", "%24");
        strContent = replaceStr(strContent, "^", "%5E");
        strContent = replaceStr(strContent, "&", "%26");
        strContent = replaceStr(strContent, "(", "%28");
        strContent = replaceStr(strContent, ")", "%29");
        strContent = replaceStr(strContent, "<", "%3C");
        strContent = replaceStr(strContent, ">", "%3E");
        strContent = replaceStr(strContent, "?", "%3F");
        strContent = replaceStr(strContent, "/", "%2F");
        strContent = replaceStr(strContent, "\\", "%5C");
        strContent = replaceStr(strContent, "=", "%3D");
        strContent = replaceStr(strContent, "+", "%2B");
        strContent = replaceStr(strContent, "|", "%7C");
        strContent = replaceStr(strContent, "[", "%5B");
        strContent = replaceStr(strContent, "]", "%5D");
        strContent = replaceStr(strContent, "{", "%7B");
        strContent = replaceStr(strContent, "}", "%7D");
        strContent = replaceStr(strContent, ",", "%2C");
        strContent = replaceStr(strContent, ";", "%3B");
        strContent = replaceStr(strContent, ":", "%3A");
        strContent = replaceStr(strContent, "'", "%27");
        strContent = replaceStr(strContent, "\"", "%22");
        return strContent;
    }

    public String getStr(String str)
    {
        try
        {
            String temp_p = str;
            byte temp_t[] = temp_p.getBytes("ISO8859-1");
            String temp = new String(temp_t);
            String s = temp;
            return s;
        }
        catch(Exception exception)
        {
            return "";
        }
    }

    public static void main(String args[])
    {
        byte b[] = new byte[16];
        b[0] = 0;
        for(int i = 1; i < b.length; i++)
            b[i] = 0;

        b = cutb(b, 0, 16, (byte)0);
        logger.info(new String(b));
    }
}
