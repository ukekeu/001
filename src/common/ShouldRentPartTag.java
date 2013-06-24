// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ShouldRentPartTag.java

package common;

import ConnDatabase.ConnDatabase;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// Referenced classes of package common:
//            PartTag, ShouldRentDetail, RoomException, SelectedPart

public class ShouldRentPartTag extends PartTag
{

    public ShouldRentPartTag()
    {
    }

    protected void initParamPrefix()
    {
        prefix = "room_";
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

    public void setYear(String s)
    {
        year = s;
    }

    public void setMonth(String s)
    {
        month = s;
    }

    public void setGet(String s)
    {
        get = s;
    }

    protected SelectedPart findPart()
        throws Exception
    {
        System.out.println("rentparttag findpart ");
        String s = "";
        String s1 = "";
        String s2 = "";
        String s3 = "";
        String s4 = "";
        String s5 = "";
        if(!section.equals(""))
            s = " and h.section='" + section + "' ";
        if(!building.equals(""))
            s1 = " and h.building like '%" + building + "%' ";
        if(!room.equals(""))
            s2 = " and h.room like '%" + room + "%' ";
        if(!year.equals(""))
            s3 = " and h.year=" + year + " ";
        if(!month.equals(""))
            s4 = " and h.month=" + month + " ";
        if(get.equals("1"))
            s5 = " ";
        else
        if(get.equals("2"))
            s5 = " and gets=1 ";
        else
        if(get.equals("3"))
        {
            s5 = " and gets=0 ";
            s4 = " and ((h.month<=" + month + " and h.year=" + year + ") or h.year<" + year + ")";
        }
        System.out.print("section : " + section);
        String s6 = "select h.id,s.serialno section,s.name sectionname,h.building,";
        s6 = s6 + "h.room,c.signatory customers,h.year,h.month,h.money,";
        s6 = s6 + "h.handler,h.handledate";
        s6 = s6 + " from hire_shouldget h,customer c,section s";
        s6 = s6 + " where h.section=s.serialno and h.customer=c.serialno ";
        s6 = s6 + s + s1 + s2 + s3 + s4 + s5;
        s6 = s6 + " and h.active=1";
        s6 = s6 + " order by h.section,building,room,year desc,month desc";
        String s7 = "select count(*) ";
        s7 = s7 + " from hire_shouldget h,customer c,section s";
        s7 = s7 + " where h.section=s.serialno and h.customer=c.serialno ";
        s7 = s7 + s + s1 + s2 + s3 + s4 + s5;
        s7 = s7 + " and h.active=1";
        System.out.println(s6);
        SelectedPart selectedpart = null;
        int i = 0;
        byte byte0 = 10;
        int j = (pageIndex - 1) * byte0;
        int k = byte0;
        System.out.println("pageIndex : " + pageIndex);
        int l = 0;
        ArrayList arraylist = new ArrayList();
        ResultSet resultset = null;
        try
        {
            System.out.println("-----begin connection");
            ConnDatabase conndatabase = new ConnDatabase();
            System.out.println("----already connect");
            ResultSet resultset1 = conndatabase.executeQuery(s7);
            if(resultset1.next())
                l = resultset1.getInt(1);
            resultset1.close();
            System.out.println("allrents : " + l);
            resultset = conndatabase.executeQuery(s6);
            System.out.println("skiprooms : " + j);
            while(j-- > 0 && resultset.next()) ;
            System.out.println("pageSize : " + byte0);
            int j1;
            int k1;
            for(; k-- > 0 && resultset.next(); System.out.println("------" + j1 + "----" + k1))
            {
                i++;
                int i1 = resultset.getInt("id");
                String s8 = resultset.getString("section");
                String s9 = resultset.getString("sectionName");
                String s10 = resultset.getString("building");
                String s11 = resultset.getString("room");
                String s12 = resultset.getString("customers");
                j1 = resultset.getInt("year");
                k1 = resultset.getInt("month");
                float f = resultset.getFloat("money");
                String s13 = resultset.getString("handler");
                String s14 = resultset.getString("handleDate");
                System.out.println("customer : " + s12);
                ShouldRentDetail shouldrentdetail = new ShouldRentDetail(i1, s8, s9, s10, s11, s12, j1, k1, f, s13, s14);
                arraylist.add(shouldrentdetail);
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
        selectedpart = new SelectedPart(l, pageIndex, byte0, i, arraylist);
        return selectedpart;
    }

    private String section;
    private String building;
    private String room;
    private String year;
    private String month;
    private String get;
}
