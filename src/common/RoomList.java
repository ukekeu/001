// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RoomList.java

package common;

import ConnDatabase.ConnDatabase;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// Referenced classes of package common:
//            HirableRoomDetail, RoomException, SelectedPart

public class RoomList
{

    public RoomList()
    {
    }

    public SelectedPart getRooms(int i, int j, String s, String s1)
        throws RoomException
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
        s4 = s4 + " and r.saleState=1";
        String s5 = "select r.code id,s.name section,r.building,r.room_code room,";
        s5 = s5 + "r.area,r.room_type roomtype from room r, section s";
        s5 = s5 + " where r.seccode = s.serialno";
        s5 = s5 + s2 + s3;
        s5 = s5 + " and r.saleState=1";
        SelectedPart selectedpart = null;
        int k = 0;
        int l = (i - 1) * j;
        int i1 = j;
        System.out.println("pageIndex : " + i);
        int j1 = 0;
        ArrayList arraylist = new ArrayList();
        ResultSet resultset = null;
        try
        {
            System.out.println("-----begin connection");
            ConnDatabase conndatabase = new ConnDatabase();
            System.out.println("----already connect");
            resultset = conndatabase.executeQuery(s4);
            if(resultset.next())
                j1 = resultset.getInt(1);
            System.out.println("allrooms : " + j1);
            resultset = conndatabase.executeQuery(s5);
            System.out.println("skiprooms : " + l);
            while(l-- > 0 && resultset.next()) ;
            System.out.println("pageSize : " + j);
            String s6;
            for(; i1-- > 0 && resultset.next(); System.out.println("------" + s6))
            {
                k++;
                int k1 = resultset.getInt("id");
                s6 = resultset.getString("section").trim();
                String s7 = resultset.getString("building").trim();
                String s8 = resultset.getString("room").trim();
                float f = resultset.getFloat("area");
                String s9 = resultset.getString("roomtype").trim();
                HirableRoomDetail hirableroomdetail = new HirableRoomDetail(k1, s6, s7, s8, s9, f);
                arraylist.add(hirableroomdetail);
            }

        }
        catch(SQLException sqlexception)
        {
            System.out.println("RoomList : " + sqlexception.getMessage());
            throw new RoomException("sqlexception while get hirableroom : " + sqlexception.getMessage());
        }
        finally
        {
            try
            {
                if(resultset != null)
                    resultset.close();
            }
            catch(Exception exception1)
            {
                System.out.print("can't close roomRS in HirableRoomList");
            }
        }
        selectedpart = new SelectedPart(j1, i, j, k, arraylist);
        return selectedpart;
    }
}
