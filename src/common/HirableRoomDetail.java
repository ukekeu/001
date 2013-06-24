// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   HirableRoomDetail.java

package common;


public class HirableRoomDetail
{

    public HirableRoomDetail(int i, String s, String s1, String s2, String s3, float f)
    {
        id = i;
        sectionName = s;
        building = s1;
        room = s2;
        roomType = s3;
        jzArea = f;
    }

    public int getId()
    {
        return id;
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

    private int id;
    private String sectionName;
    private String building;
    private String room;
    private String roomType;
    private float jzArea;
}
