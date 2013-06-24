// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RoomPartTag.java

package common;

import java.io.PrintStream;

// Referenced classes of package common:
//            PartTag, RoomList, SelectedPart

public class RoomPartTag extends PartTag
{

    public RoomPartTag()
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

    protected SelectedPart findPart()
        throws Exception
    {
        System.out.println("roomparttag findcollection ");
        RoomList roomlist = new RoomList();
        SelectedPart selectedpart = null;
        selectedpart = roomlist.getRooms(pageIndex, 10, section, building);
        return selectedpart;
    }

    private int lines;
    private String section;
    private String building;
}
