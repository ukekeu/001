// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SelectTenement.java

package ConnDatabase;

import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.ArrayList;

// Referenced classes of package ConnDatabase:
//            medeDatabase

public class SelectTenement
{

    public SelectTenement()
    {
    }

    public static String SelectSecBRoom(String s, String s1, String s2)
        throws Exception
    {
        String s3 = "select count(*) counts from tenement";
        String s4 = "select distinct precinctid,building from tenement order by precinctid,building";
        ArrayList arraylist = new ArrayList();
        ArrayList arraylist1 = new ArrayList();
        int i = 0;
        String s5 = "";
        String s7 = "";
        String s9 = "";
        ConnDatabase mededatabase = new ConnDatabase();
        Object obj = null;
        try
        {
            String s8;
            for(ResultSet resultset = mededatabase.executeQuery(s4); resultset.next(); arraylist1.add(s8))
            {
                i++;
                String s6 = resultset.getString("precinctid").trim();
                s8 = resultset.getString("building").trim();
                arraylist.add(s6);
            }

        }
        catch(Exception exception)
        {
            System.out.print("system error \uFF1A<br>");
            System.out.print(exception.getMessage());
            System.out.close();
        }
        if(i == 0)
            return "";
        s9 = "<script> \n";
        s9 = s9 + " sectionBuildingArr = new Array(" + String.valueOf(i) + ") ;" + "\n";
        s9 = s9 + " sectionBuildingArr2 = new Array(" + String.valueOf(i) + ") ;" + "\n";
        for(int j = 0; j < i; j++)
        {
            s9 = s9 + " sectionBuildingArr[" + String.valueOf(j) + "]='" + (String)arraylist.get(j) + "' ;\n";
            s9 = s9 + " sectionBuildingArr2[" + String.valueOf(j) + "]='" + (String)arraylist1.get(j) + "' ;\n";
        }

        String s10 = "select precinctid,building,room from tenement order by precinctid,building,room";
        int k = 0;
        String s11 = "";
        String s13 = "";
        String s15 = "";
        try
        {
            ResultSet resultset1 = mededatabase.executeQuery(s3);
            if(resultset1.next())
                k = resultset1.getInt("Counts");
        }
        catch(Exception exception1)
        {
            System.out.print("system error \uFF1A<br>");
            System.out.print(exception1.getMessage());
            System.out.close();
        }
        if(k == 0)
            return "";
        s9 = s9 + "  sectionArr = new Array(" + String.valueOf(k) + ") ; " + "\n";
        s9 = s9 + "  buildingArr = new Array(" + String.valueOf(k) + ") ; " + "\n";
        s9 = s9 + "  roomArr = new Array(" + String.valueOf(k) + ") ; " + "\n";
        try
        {
            ResultSet resultset2 = mededatabase.executeQuery(s10);
            for(int l = 0; l < k && resultset2.next(); l++)
            {
                String s12 = resultset2.getString("precinctid").trim();
                String s14 = resultset2.getString("building").trim();
                String s16 = resultset2.getString("room").trim();
                s9 = s9 + " sectionArr[" + String.valueOf(l) + "]='" + s12 + "' ;\n";
                s9 = s9 + " buildingArr[" + String.valueOf(l) + "]='" + s14 + "' ;\n";
                s9 = s9 + " roomArr[" + String.valueOf(l) + "]='" + s16 + "'; \n";
            }

        }
        catch(Exception exception2)
        {
            System.out.print("system error \uFF1A<br>");
            System.out.print(exception2.getMessage());
            System.out.close();
        }
        s9 = s9 + " var currentSection" + "; \n";
        s9 = s9 + " var currentBuilding" + "; \n";
        s9 = s9 + " var currentRoom" + "; \n";
        s9 = s9 + "function ChangeSection() { " + "\n";
        s9 = s9 + "currentSection = document.forms[0]." + s + ".options[document.forms[0]." + s + ".selectedIndex].value ;" + "\n";
        s9 = s9 + "document.forms[0]." + s1 + ".length = 0 ;" + "\n";
        s9 = s9 + "document.forms[0]." + s2 + ".length = 0 ;" + "\n";
        s9 = s9 + "iii = 0 ;" + "\n";
        s9 = s9 + "document.forms[0]." + s1 + ".options[iii] = new Option('','') ;" + "\n";
        s9 = s9 + "iii ++ ;" + "\n";
        s9 = s9 + "for(ii = 0 ; ii < sectionBuildingArr.length ; ii ++) {" + "\n";
        s9 = s9 + "if (sectionBuildingArr[ii] == currentSection) {" + "\n";
        s9 = s9 + "document.forms[0]." + s1 + ".options[iii] = new Option(sectionBuildingArr2[ii],sectionBuildingArr2[ii]) ;" + "\n";
        s9 = s9 + "iii ++ ;" + "\n";
        s9 = s9 + "}" + "\n";
        s9 = s9 + "}" + "\n";
        s9 = s9 + "}" + "\n";
        s9 = s9 + "function ChangeBuilding() {" + "\n";
        s9 = s9 + "currentBuilding = document.forms[0]." + s1 + ".options[document.forms[0]." + "Building.selectedIndex].value ;" + "\n";
        s9 = s9 + "iii = 0 ;" + "\n";
        s9 = s9 + "document.forms[0]." + s2 + ".length = 0 ;" + "\n";
        s9 = s9 + "for (ii = 0 ; ii < sectionArr.length ; ii ++) {" + "\n";
        s9 = s9 + "if (sectionArr[ii] == currentSection && buildingArr[ii] == currentBuilding) {" + "\n";
        s9 = s9 + "document.forms[0]." + s2 + ".options[iii] = new Option(roomArr[ii],roomArr[ii]) ;" + "\n";
        s9 = s9 + "iii ++ ;" + "\n";
        s9 = s9 + "}" + "\n";
        s9 = s9 + "}" + "\n";
        s9 = s9 + "}" + "\n";
        s9 = s9 + "</script>" + "\n";
        return s9;
    }
}
