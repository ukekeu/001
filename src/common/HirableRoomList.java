// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   HirableRoomList.java

package common;


// Referenced classes of package common:
//            RoomList, SelectedPart

public class HirableRoomList
{

    public HirableRoomList()
    {
    }

    public SelectedPart getRooms(int i, int j, String s, String s1)
    {
        String s2 = "";
        String s3 = "";
        if(!s.equalsIgnoreCase(""))
            s2 = " and r.seccode='" + s + "'";
        if(!s1.equals(""))
            s3 = " and r.building='" + s1 + "'";
        String s4 = "select count(*) from room r,section s";
        s4 = s4 + " where r.seccode = s.serialno";
        s4 = s4 + s2 + s3;
        String s5 = "select r.code id,s.name section,r.building,r.room_code room,";
        s5 = s5 + "r.area,r.room_type roomtype from room r, section s";
        s5 = s5 + " where r.seccode = s.serialno";
        s5 = s5 + s2 + s3;
        SelectedPart selectedpart = null;
        RoomList roomlist = new RoomList();
        return selectedpart;
    }
}
