// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RentAttribute.java

package common;


// Referenced classes of package common:
//            ItemAttributeTag, RentDetail

public class RentAttribute extends ItemAttributeTag
{

    public RentAttribute()
    {
    }

    protected String createText()
    {
        RentDetail rentdetail = (RentDetail)item;
        if(attribute == null || attribute.equalsIgnoreCase("id"))
            return String.valueOf(rentdetail.getId());
        if(attribute.equalsIgnoreCase("section"))
            return rentdetail.getSection();
        if(attribute.equalsIgnoreCase("building"))
            return rentdetail.getBuilding();
        if(attribute.equalsIgnoreCase("room"))
            return rentdetail.getRoom();
        if(attribute.equalsIgnoreCase("customer"))
            return rentdetail.getCustomer();
        if(attribute.equalsIgnoreCase("year"))
            return String.valueOf(rentdetail.getYear());
        if(attribute.equalsIgnoreCase("month"))
            return String.valueOf(rentdetail.getMonth());
        if(attribute.equalsIgnoreCase("money"))
            return String.valueOf(rentdetail.getMoney());
        if(attribute.equalsIgnoreCase("gets"))
            return String.valueOf(rentdetail.getGets());
        else
            return null;
    }
}
