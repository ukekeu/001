// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ShouldRentAttributeTag.java

package common;


// Referenced classes of package common:
//            ItemAttributeTag, ShouldRentDetail

public class ShouldRentAttributeTag extends ItemAttributeTag
{

    public ShouldRentAttributeTag()
    {
    }

    protected String createText()
    {
        ShouldRentDetail shouldrentdetail = (ShouldRentDetail)item;
        if(attribute == null || attribute.equalsIgnoreCase("SectionName"))
            return shouldrentdetail.getSectionName();
        if(attribute.equalsIgnoreCase("Section"))
            return shouldrentdetail.getSection();
        if(attribute.equalsIgnoreCase("building"))
            return shouldrentdetail.getBuilding();
        if(attribute.equalsIgnoreCase("room"))
            return shouldrentdetail.getRoom();
        if(attribute.equalsIgnoreCase("customers"))
            return shouldrentdetail.getCustomers();
        if(attribute.equalsIgnoreCase("Year"))
            return String.valueOf(shouldrentdetail.getYear());
        if(attribute.equalsIgnoreCase("month"))
            return String.valueOf(shouldrentdetail.getMonth());
        if(attribute.equalsIgnoreCase("id"))
            return String.valueOf(shouldrentdetail.getId());
        if(attribute.equalsIgnoreCase("rent"))
            return String.valueOf(shouldrentdetail.getMoney());
        if(attribute.equalsIgnoreCase("handler"))
            return shouldrentdetail.getHandler();
        if(attribute.equalsIgnoreCase("handledate"))
            return shouldrentdetail.getHandleDate();
        else
            return null;
    }
}
