// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SelectedPart.java

package common;

import java.io.Serializable;
import java.util.Collection;

public class SelectedPart
    implements Serializable
{

    public SelectedPart(int i, int j, int k, int l, Collection collection)
    {
        allRecords = i;
        pageIndex = j;
        pageSize = k;
        selectedRecords = l;
        records = collection;
    }

    public int getAll()
    {
        return allRecords;
    }

    public int getIndex()
    {
        return pageIndex;
    }

    public int getSize()
    {
        return pageSize;
    }

    public int getSelect()
    {
        return selectedRecords;
    }

    public Collection getCollection()
    {
        return records;
    }

    private int allRecords;
    private int pageSize;
    private int pageIndex;
    private int selectedRecords;
    private Collection records;
}
