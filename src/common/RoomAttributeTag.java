// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RoomAttributeTag.java

package common;


// Referenced classes of package common:
//            ItemAttributeTag, HirableRoomDetail

public class RoomAttributeTag extends ItemAttributeTag
{

    public RoomAttributeTag()
    {
    }

    protected String createText()
    {
        HirableRoomDetail hirableroomdetail = (HirableRoomDetail)item;
        if(attribute == null || attribute.equalsIgnoreCase("SectionName"))
            return hirableroomdetail.getSectionName();
        if(attribute.equalsIgnoreCase("building"))
            return hirableroomdetail.getBuilding();
        if(attribute.equalsIgnoreCase("room"))
            return hirableroomdetail.getRoom();
        if(attribute.equalsIgnoreCase("roomtype"))
            return hirableroomdetail.getRoomType();
        if(attribute.equalsIgnoreCase("id"))
            return String.valueOf(hirableroomdetail.getId());
        if(attribute.equalsIgnoreCase("jzarea"))
            return String.valueOf(hirableroomdetail.getJzArea());
        else
            return null;
    }
}
