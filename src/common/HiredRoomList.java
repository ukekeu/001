// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   HiredRoomList.java

package common;

import ConnDatabase.ConnDatabase;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// Referenced classes of package common:
//            HiredRoomDetail, RoomException, SelectedPart

public class HiredRoomList
{

    public HiredRoomList()
    {
    }

    public SelectedPart getRooms(int i, int j, String s, String s1, String s2, String s3)
        throws RoomException
    {
        String s4 = "";
        String s5 = "";
        String s6 = "";
        String s7 = "";
        if(!s.equalsIgnoreCase(""))
            s4 = " and r.seccode='" + s + "'";
        if(!s1.equals(""))
            s5 = " and r.building='" + s1 + "'";
        if(!s2.equals(""))
            s6 = " and r.room_type='" + s2 + "' ";
        if(!s3.equals(""))
            if(s3.equals("50-"))
                s7 = " and r.area<50 ";
            else
            if(s3.equals("50+100-"))
                s7 = " and r.area<100 and r.area>50 ";
            else
            if(s3.equals("100+150-"))
                s7 = " and r.area<150 and r.area>150 ";
            else
            if(s3.equals("150+"))
                s7 = " and r.area>150 ";
        String s8 = "select count(*) from ";
        s8 = s8 + " room r,section s,customer c,hire_in h";
        s8 = s8 + " where r.seccode = s.serialno and ";
        s8 = s8 + " c.serialno=h.customer and h.active=1";
        s8 = s8 + " and r.seccode=h.section and r.building=h.building ";
        s8 = s8 + " and r.room_code= h.room ";
        s8 = s8 + s4 + s5 + s6 + s7;
        s8 = s8 + " and r.saleState=9";
        String s9 = "select r.code r_id,h.id h_id,s.serialno section,s.name sectionname,r.building,r.room_code room,";
        s9 = s9 + "r.area,r.room_type roomtype,c.signatory customers from ";
        s9 = s9 + " room r, section s,customer c,hire_in h";
        s9 = s9 + " where r.seccode = s.serialno and ";
        s9 = s9 + " c.serialno=h.customer and h.active=1";
        s9 = s9 + " and r.seccode=h.section and r.building=h.building ";
        s9 = s9 + " and r.room_code= h.room ";
        s9 = s9 + s4 + s5 + s6 + s7;
        s9 = s9 + " and r.saleState=9";
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
            resultset = conndatabase.executeQuery(s8);
            if(resultset.next())
                j1 = resultset.getInt(1);
            System.out.println("allrooms : " + j1);
            resultset = conndatabase.executeQuery(s9);
            System.out.println("skiprooms : " + l);
            while(l-- > 0 && resultset.next()) ;
            System.out.println("pageSize : " + j);
            String s10;
            for(; i1-- > 0 && resultset.next(); System.out.println("------" + s10))
            {
                k++;
                int k1 = resultset.getInt("r_id");
                int l1 = resultset.getInt("h_id");
                System.out.println("id : " + l1);
                s10 = resultset.getString("section").trim();
                String s11 = resultset.getString("sectionname").trim();
                String s12 = resultset.getString("building").trim();
                String s13 = resultset.getString("room").trim();
                float f = resultset.getFloat("area");
                String s14 = resultset.getString("roomtype").trim();
                String s15 = resultset.getString("customers").trim();
                HiredRoomDetail hiredroomdetail = new HiredRoomDetail(k1, l1, s10, s11, s12, s13, s14, f, s15);
                arraylist.add(hiredroomdetail);
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