// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RentDetail.java

package common;


public class RentDetail
{

    public RentDetail(int i, String s, String s1, String s2, String s3, int j, int k, 
            float f, int l)
    {
        id = i;
        section = s;
        building = s1;
        room = s2;
        customer = s3;
        year = j;
        month = k;
        money = f;
        gets = l;
    }

    public int getId()
    {
        return id;
    }

    public String getSection()
    {
        return section;
    }

    public String getBuilding()
    {
        return building;
    }

    public String getRoom()
    {
        return room;
    }

    public String getCustomer()
    {
        return customer;
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
        return money;
    }

    public int getGets()
    {
        return gets;
    }

    private int id;
    private String section;
    private String building;
    private String room;
    private String customer;
    private int year;
    private int month;
    private float money;
    private int gets;
}
