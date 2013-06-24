// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   bbscom.java

package test;


public class bbscom
{

    public bbscom()
    {
        pagesCurrent = 0;
        pagesNext = 0;
        pagesLast = 0;
    }

    public int getPagesCurrent()
    {
        return pagesCurrent;
    }

    public int getPagesLast()
    {
        return pagesLast;
    }

    public int getPagesNext()
    {
        return pagesNext;
    }

    public void setPages(int j, int k)
    {
        if(j <= 0)
        {
            pagesCurrent = 0;
            pagesNext = 0;
            pagesLast = 0;
        } else
        {
            pagesCurrent = k;
            pagesNext = k + 1;
            pagesLast = k - 1;
            if(k >= j)
            {
                pagesCurrent = j;
                pagesNext = 0;
                pagesLast = k - 1;
            }
            if(k <= 1)
            {
                pagesCurrent = 1;
                pagesNext = k + 1;
                pagesLast = 0;
            }
            if(pagesNext > j)
                pagesNext = j;
            if(pagesNext == j)
                pagesNext = 0;
            if(pagesLast < 0)
                pagesLast = 1;
            if(pagesLast == 1)
                pagesLast = 0;
        }
    }

    int i;
    int pagesCurrent;
    int pagesNext;
    int pagesLast;
}
