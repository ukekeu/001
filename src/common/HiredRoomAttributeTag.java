// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   HiredRoomAttributeTag.java

package common;


// Referenced classes of package common:
//            ItemAttributeTag, HiredRoomDetail

public class HiredRoomAttributeTag extends ItemAttributeTag
{

    public HiredRoomAttributeTag()
    {
    }

    protected String createText()
    {
        HiredRoomDetail hiredroomdetail = (HiredRoomDetail)item;
        if(attribute == null || attribute.equalsIgnoreCase("SectionName"))
            return hiredroomdetail.getSectionName();
        if(attribute.equalsIgnoreCase("section"))
            return hiredroomdetail.getSection();
        if(attribute.equalsIgnoreCase("building"))
            return hiredroomdetail.getBuilding();
        if(attribute.equalsIgnoreCase("room"))
            return hiredroomdetail.getRoom();
        if(attribute.equalsIgnoreCase("roomtype"))
            return hiredroomdetail.getRoomType();
        if(attribute.equalsIgnoreCase("rid"))
            return String.valueOf(hiredroomdetail.getRid());
        if(attribute.equalsIgnoreCase("hid"))
            return String.valueOf(hiredroomdetail.getHid());
        if(attribute.equalsIgnoreCase("jzarea"))
            return String.valueOf(hiredroomdetail.getJzArea());
        if(attribute.equalsIgnoreCase("customers"))
            return hiredroomdetail.getCustomers();
        else
            return null;
    }
}
