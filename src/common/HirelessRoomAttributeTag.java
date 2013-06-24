// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   HirelessRoomAttributeTag.java

package common;


// Referenced classes of package common:
//            ItemAttributeTag, HirelessRoomDetail

public class HirelessRoomAttributeTag extends ItemAttributeTag
{

    public HirelessRoomAttributeTag()
    {
    }

    protected String createText()
    {
        HirelessRoomDetail hirelessroomdetail = (HirelessRoomDetail)item;
        if(attribute == null || attribute.equalsIgnoreCase("SectionName"))
            return hirelessroomdetail.getSectionName();
        if(attribute.equalsIgnoreCase("building"))
            return hirelessroomdetail.getBuilding();
        if(attribute.equalsIgnoreCase("room"))
            return hirelessroomdetail.getRoom();
        if(attribute.equalsIgnoreCase("roomtype"))
            return hirelessroomdetail.getRoomType();
        if(attribute.equalsIgnoreCase("id"))
            return String.valueOf(hirelessroomdetail.getId());
        if(attribute.equalsIgnoreCase("jzarea"))
            return String.valueOf(hirelessroomdetail.getJzArea());
        else
            return null;
    }
}
