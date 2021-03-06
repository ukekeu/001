// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   HirelessRoomPartTag.java

package common;

import java.io.PrintStream;

// Referenced classes of package common:
//            PartTag, HirelessRoomList, SelectedPart

public class HirelessRoomPartTag extends PartTag
{

    public HirelessRoomPartTag()
    {
    }

    protected void initParamPrefix()
    {
        prefix = "room_";
    }

    public void setLines(String s)
    {
        if(s.equals(""))
            s = "0";
        try
        {
            lines = Integer.parseInt(s);
        }
        catch(Exception exception)
        {
            System.out.println("roomPartttag : ");
            lines = 0;
        }
    }

    public void setSection(String s)
    {
        section = s;
    }

    public void setBuilding(String s)
    {
        building = s;
    }

    public void setRoomType(String s)
    {
        roomType = s;
    }

    public void setArea(String s)
    {
        area = s;
    }

    protected SelectedPart findPart()
        throws Exception
    {
        System.out.println("roomparttag findcollection ");
        HirelessRoomList hirelessroomlist = new HirelessRoomList();
        SelectedPart selectedpart = null;
        selectedpart = hirelessroomlist.getRooms(pageIndex, 10, section, building, roomType, area);
        return selectedpart;
    }

    private int lines;
    private String section;
    private String building;
    private String roomType;
    private String area;
}
