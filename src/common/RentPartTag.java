// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RentPartTag.java

package common;

import ConnDatabase.ConnDatabase;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// Referenced classes of package common:
//            PartTag, RentDetail, RoomException, SelectedPart

public class RentPartTag extends PartTag
{

    public RentPartTag()
    {
    }

    protected void initParamPrefix()
    {
        prefix = "rent_";
    }

    public void setSection(String s)
    {
        section = s;
    }

    public void setBuilding(String s)
    {
        building = s;
    }

    public void setRoom(String s)
    {
        room = s;
    }

    protected SelectedPart findPart()
        throws Exception
    {
        System.out.println("rentparttag findpart ");
        System.out.print("section : " + section);
        String s = "select h.id,s.name section,h.building,h.room,c.signatory customer,h.year,h.month,h.money,h.gets";
        s = s + " from hire_shouldget h,section s,customer c where h.section='";
        s = s + section + "' and h.building='" + building;
        s = s + "' and h.room='" + room + "' and h.active=1";
        s = s + " and h.section=s.serialno and h.customer=c.serialno ";
        System.out.println(s);
        SelectedPart selectedpart = null;
        int i = 0;
        int j = 1;
        byte byte0 = 100;
        int k = (j - 1) * byte0;
        byte byte1 = byte0;
        System.out.println("pageIndex : " + j);
        byte byte2 = 100;
        ArrayList arraylist = new ArrayList();
        ResultSet resultset = null;
        try
        {
            System.out.println("-----begin connection");
            ConnDatabase conndatabase = new ConnDatabase();
            System.out.println("----already connect");
            System.out.println("allrents : " + byte2);
            resultset = conndatabase.executeQuery(s);
            System.out.println("skiprooms : " + k);
            System.out.println("pageSize : " + byte0);
            int i1;
            int j1;
            for(; resultset.next(); System.out.println("------" + i1 + "----" + j1))
            {
                i++;
                int l = resultset.getInt("id");
                String s1 = resultset.getString("section");
                String s2 = resultset.getString("building");
                String s3 = resultset.getString("room");
                String s4 = resultset.getString("customer");
                i1 = resultset.getInt("year");
                j1 = resultset.getInt("month");
                float f = resultset.getFloat("money");
                int k1 = resultset.getInt("gets");
                RentDetail rentdetail = new RentDetail(l, s1, s2, s3, s4, i1, j1, f, k1);
                arraylist.add(rentdetail);
            }

        }
        catch(SQLException sqlexception)
        {
            System.out.println("Rent List : " + sqlexception.getMessage());
            throw new RoomException("sqlexception while get rent detail : " + sqlexception.getMessage());
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
        selectedpart = new SelectedPart(byte2, j, byte0, i, arraylist);
        return selectedpart;
    }

    private String section;
    private String building;
    private String room;
}
