// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CTools.java

package com.sms.cpa;

import com.sms.pub.Tools;

// Referenced classes of package com.sms.cpa:
//            CParam, CLoginRet, CLoginReq, CLogoutRet, 
//            CLogoutReq, CLinkRet, CLinkReq, CSendRet, 
//            CSendReq, CSendClusterRet, CSendClusterReq, CTimerSendRet, 
//            CTimerSendReq, CCancelSendRet, CCancelSendReq, CMoRet, 
//            CMoReq, CFeeRet, CFeeReq, CAgentRet, 
//            CAgentReq, CPasswdRet, CPasswdReq, TForceLogoutRet, 
//            TForceLogoutReq, TQueryClientRet, TQueryClientReq

public class CTools
{

    public CTools()
    {
    }

    public static CParam get(byte b[])
    {
        if(b == null)
            return null;
        if(b.length < 23)
            return null;
        int iType = Tools.b2i(b, 0, 1);
        boolean bRes = !isRequest(iType);
        if(bRes)
            iType -= 128;
        CParam c = null;
        try
        {
            if(iType == 1)
            {
                if(bRes)
                    c = new CLoginRet(b);
                else
                    c = new CLoginReq(b);
            } else
            if(iType == 2)
            {
                if(bRes)
                    c = new CLogoutRet(b);
                else
                    c = new CLogoutReq(b);
            } else
            if(iType == 3)
            {
                if(bRes)
                    c = new CLinkRet(b);
                else
                    c = new CLinkReq(b);
            } else
            if(iType == 4)
            {
                if(bRes)
                    c = new CSendRet(b);
                else
                    c = new CSendReq(b);
            } else
            if(iType == 17)
            {
                if(bRes)
                    c = new CSendClusterRet(b);
                else
                    c = new CSendClusterReq(b);
            } else
            if(iType == 18)
            {
                if(bRes)
                    c = new CTimerSendRet(b);
                else
                    c = new CTimerSendReq(b);
            } else
            if(iType == 19)
            {
                if(bRes)
                    c = new CCancelSendRet(b);
                else
                    c = new CCancelSendReq(b);
            } else
            if(iType == 5)
            {
                if(bRes)
                    c = new CMoRet(b);
                else
                    c = new CMoReq(b);
            } else
            if(iType == 8)
            {
                if(bRes)
                    c = new CFeeRet(b);
                else
                    c = new CFeeReq(b);
            } else
            if(iType == 9)
            {
                if(bRes)
                    c = new CAgentRet(b);
                else
                    c = new CAgentReq(b);
            } else
            if(iType == 16)
            {
                if(bRes)
                    c = new CPasswdRet(b);
                else
                    c = new CPasswdReq(b);
            } else
            if(iType == 22)
            {
                if(bRes)
                    c = new TForceLogoutRet(b);
                else
                    c = new TForceLogoutReq(b);
            } else
            if(iType == 21)
                if(bRes)
                    c = new TQueryClientRet(b);
                else
                    c = new TQueryClientReq(b);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return c;
    }

    public static boolean isRequest(int iType)
    {
        boolean bReq = true;
        if(iType >= 128)
            bReq = false;
        return bReq;
    }
}
