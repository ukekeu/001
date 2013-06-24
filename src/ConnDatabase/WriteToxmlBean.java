// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   WriteToxmlBean.java

package ConnDatabase;

import FormatData.FormatData;
import java.io.*;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

// Referenced classes of package ConnDatabase:
//            SDatabase

public class WriteToxmlBean
{

    public WriteToxmlBean()
    {
    }

    public String getbyte(String s)
        throws Exception
    {
        String s1 = s;
        if(s1 != null)
            s1 = new String(s1.getBytes("iso-8859-1"));
        else
            s1 = "";
        return s1;
    }

    public String WriteToxml(String s, String s1)
    {
        String s2 = "";
        String s3 = "";
        String s8 = "";
        String s9 = "";
        String s12 = "  ";
        Object obj = null;
        try
        {
            PrintWriter printwriter = new PrintWriter(new FileOutputStream(s));
            printwriter.println("<?xml version='1.0' encoding='gb2312' ?> ");
            printwriter.println("<ufinterface roottag='voucher' billtype='' docid='' receiver='u8' sender='" + s1 + "' proc='Query' codeexchanged='N' renewproofno='n' exportneedexch='N'>");
            try
            {
                ResultSetMetaData resultsetmetadata = null;
                s8 = "SELECT code,company, voucher_type, fiscal_year,";
                s8 = s8 + " accounting_period, voucher_id,";
                s8 = s8 + " attachment_number, date, enter, cashier,";
                s8 = s8 + " signature, checker, posting_date, ";
                s8 = s8 + " posting_person, voucher_marking_system, memo1,";
                s8 = s8 + "  memo2, reserve1, reserve2 FROM dbo.Voucher1";
                SDatabase sdatabase = new SDatabase();
                SDatabase sdatabase1 = new SDatabase();
                SDatabase sdatabase2 = new SDatabase();
                FormatData formatdata = new FormatData();
                System.out.println("OK");
                ResultSet resultset = sdatabase.executeQuery(s8);
                int i = 0;
                if(resultset == null)
                {
                    System.out.println("result is nullA");
                } else
                {
                    resultsetmetadata = resultset.getMetaData();
                    i = resultsetmetadata.getColumnCount();
                }
                int j = 0;
                ResultSet resultset1;
                for(; resultset.next(); resultset1.close())
                {
                    String s4 = "";
                    String s10 = "";
                    j++;
                    printwriter.println("<voucher id=''>");
                    printwriter.println("<voucher_header>");
                    s10 = getbyte(resultset.getObject(1).toString().trim());
                    for(int k = 2; k <= i; k++)
                    {
                        String s13 = "  ";
                        s13 = resultsetmetadata.getColumnName(k);
                        System.out.println(s13);
                        String s5 = "<" + s13 + ">";
                        if(resultset.getObject(k) != null)
                        {
                            String s15 = resultset.getObject(k).toString().trim();
                            if(s15.indexOf(" ") > 0)
                                s15 = s15.substring(0, s15.indexOf(" "));
                            if(s15.indexOf(".") > 0)
                                s15 = String.valueOf(formatdata.getFloat1(Float.parseFloat(s15), 3));
                            s5 = s5 + s15;
                        }
                        s5 = s5 + "</" + s13 + ">";
                        printwriter.println(getbyte(s5));
                    }

                    printwriter.println("</voucher_header>");
                    printwriter.println("<voucher_body>");
                    s8 = "SELECT entry_id, account_code, abstract,";
                    s8 = s8 + " settlement, document_id, currency,";
                    s8 = s8 + " unit_price, exchange_rate1, exchange_rate2,";
                    s8 = s8 + " debit_quantity, primary_debit_amount, ";
                    s8 = s8 + " secondary_debit_amount,natural_debit_currency, credit_quantity,";
                    s8 = s8 + " primary_credit_amount ,";
                    s8 = s8 + "secondary_credit_amount,natural_credit_currency,";
                    s8 = s8 + " bill_type, bill_id, bill_date FROM dbo.voucher2";
                    s8 = s8 + " where code=" + s10;
                    resultset1 = sdatabase1.executeQuery(s8);
                    ResultSetMetaData resultsetmetadata1 = null;
                    if(resultset1 == null)
                    {
                        System.out.println("result is null" + s10);
                    } else
                    {
                        resultsetmetadata1 = resultset1.getMetaData();
                        i = resultsetmetadata1.getColumnCount();
                    }
                    for(; resultset1.next(); System.out.println("lenon"))
                    {
                        String s6 = "";
                        String s11 = "";
                        printwriter.println("<entry>");
                        for(int l = 1; l <= i; l++)
                        {
                            String s14 = "  ";
                            s14 = resultsetmetadata1.getColumnName(l);
                            String s7 = "<" + s14 + ">";
                            if(resultset1.getObject(l) != null)
                            {
                                String s16 = getbyte(resultset1.getObject(l).toString().trim());
                                if(s16.indexOf(" ") > 0)
                                    s16 = s16.substring(0, s16.indexOf(" "));
                                if(s16.indexOf(".") > 0)
                                    s16 = String.valueOf(formatdata.getFloat1(Float.parseFloat(s16), 3));
                                s7 = s7 + s16;
                            }
                            s7 = s7 + "</" + s14 + ">";
                            printwriter.println(s7);
                        }

                        printwriter.println(" <auxiliary_accounting>");
                        printwriter.println("<item name='dept_id'></item>");
                        printwriter.println("<item name='personnel_id'></item>");
                        printwriter.println("<item name='cust_id'></item>");
                        printwriter.println("<item name='supplier_id'></item>");
                        printwriter.println("<item name='item_id'></item>");
                        printwriter.println("<item name='item_class'></item>");
                        printwriter.println("<item name='operator'></item>");
                        printwriter.println("<item name='operator'/>");
                        printwriter.println("<item name='operator'/>");
                        printwriter.println("<item name='self_define1'></item>");
                        printwriter.println("<item name='self_define2'></item>");
                        printwriter.println("<item name='self_define3'></item>");
                        printwriter.println("<item name='self_define4'></item>");
                        printwriter.println("<item name='self_define5'></item>");
                        printwriter.println("<item name='self_define6'></item>");
                        printwriter.println("<item name='self_define7'></item>");
                        printwriter.println("<item name='self_define8'></item>");
                        printwriter.println("<item name='self_define9'></item>");
                        printwriter.println("<item name='self_define10'></item>");
                        printwriter.println("<item name='self_define11'></item>");
                        printwriter.println("<item name='self_define12'></item>");
                        printwriter.println("<item name='self_define13'></item>");
                        printwriter.println("<item name='self_define14'></item>");
                        printwriter.println("<item name='self_define15'></item>");
                        printwriter.println("<item name='self_define16'></item>");
                        printwriter.println("</auxiliary_accounting>");
                        printwriter.println("<detail>");
                        printwriter.println("<cash_flow_statement>");
                        printwriter.println("</cash_flow_statement>");
                        printwriter.println("</detail>");
                        printwriter.println("</entry>");
                    }

                }

                printwriter.println("</voucher_body>");
                printwriter.println("</voucher>");
                printwriter.println("</ufinterface>");
                s2 = "ok";
                resultset.close();
            }
            catch(Exception exception)
            {
                System.out.println(exception.getMessage() + "ERROR" + s8);
            }
            printwriter.close();
        }
        catch(IOException ioexception)
        {
            System.out.println(ioexception.getMessage());
        }
        return s2;
    }
}
