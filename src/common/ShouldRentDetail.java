// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ShouldRentDetail.java

package common;


public class ShouldRentDetail
{

    public ShouldRentDetail(int i, String s, String s1, String s2, String s3, String s4, int j, 
            int k, float f, String s5, String s6)
    {
        id = i;
        section = s;
        sectionName = s1;
        building = s2;
        room = s3;
        customers = s4;
        year = j;
        month = k;
        rent = f;
        handler = s5;
        handleDate = s6;
    }

    public int getId()
    {
        return id;
    }

    public String getSection()
    {
        return section;
    }

    public String getSectionName()
    {
        return sectionName;
    }

    public String getBuilding()
    {
        return building;
    }

    public String getRoom()
    {
        return room;
    }

    public String getCustomers()
    {
        return customers;
    }

    public int getYear()
    {
        return year;
    }

    public int getMonth()
    {
        return month;
    }

    public float getMoney()
    {
        return rent;
    }

    public String getHandler()
    {
        return handler;
    }

    public String getHandleDate()
    {
        return handleDate;
    }

    private int id;
    private String section;
    private String sectionName;
    private String building;
    private String room;
    private String customers;
    private int year;
    private int month;
    private float rent;
    private String handler;
    private String handleDate;
}
