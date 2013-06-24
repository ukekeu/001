// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   HiredRoomDetail.java

package common;


public class HiredRoomDetail
{

    public HiredRoomDetail(int i, int j, String s, String s1, String s2, String s3, String s4, 
            float f, String s5)
    {
        rid = i;
        hid = j;
        section = s;
        sectionName = s1;
        building = s2;
        room = s3;
        roomType = s4;
        jzArea = f;
        customers = s5;
    }

    public int getRid()
    {
        return rid;
    }

    public int getHid()
    {
        return hid;
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

    public String getRoomType()
    {
        return roomType;
    }

    public float getJzArea()
    {
        return jzArea;
    }

    public String getCustomers()
    {
        return customers;
    }

    private int rid;
    private int hid;
    private String section;
    private String sectionName;
    private String building;
    private String room;
    private String roomType;
    private float jzArea;
    private String customers;
}
