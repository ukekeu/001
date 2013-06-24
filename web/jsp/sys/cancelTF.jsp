<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>恢复退房</title>
		<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
   <%@ include file="../public_js/getByteOut.jsp"%>
   
<%@ include file="../public_js/logrecord.jsp" %>
<body oncontextmenu="return false"  topmargin="0">
<%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	
	 String CODE=getbyte2(request.getParameter("code"));
    if (!CODE.equals("")){
	
	  String  SQL="select o.code,o.state,o.visadate,o.section+o.loft+o.building+o.room_no room,o.sectionname+o.loft+o.building+o.room_no room1 from order_contract o,room r where o.state=3 and r.seccode+r.loft+r.building+r.room_code=o.section+o.loft+r.building+o.room_no and r.salestate=1 and o.code="+CODE;
      ResultSet rs1=ViewBean.executeQuery(SQL);
      if (rs1.next()){
         String code=rs1.getString("code");
         String date=getbyte(rs1.getString("visadate"));
		 String room =getbyte(rs1.getString("room"));
		 String room1=getbyte(rs1.getString("room1"));
	     if (date.equals("")){
		 
         ViewBean1.executeUpdate("update order_contract set state=1 where code="+code);
           ViewBean1.executeUpdate("update room set salestate=2,ssstate=1 where seccode+loft+building+room_code='"+room+"'");
         }else{
		  
          ViewBean1.executeUpdate("update order_contract set state=2 where code="+code);
           ViewBean1.executeUpdate("update room set salestate=3,ssstate=1 where seccode+loft+building+room_code='"+room+"'");
        }
		
			 
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "恢复退房" , 
                  "恢复"+room1
                ) ;
	   }	
	  rs1.close();
	}
	
	 %>
	 <form name=frm method="post" action="cancelTF.jsp">
 
<table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('sysCheckData.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>数据纠错</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('cancelTF.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>恢复退房</font></a>
	</td>
	 <td class="<%if(sel.equals("2")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=2;findSub('sysCheckDataLoke.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>异常锁定</font></a>
	</td>
   </tr>
<input type=hidden name=sel value="<%=sel%>">
 </table>
<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
 <p align="center"><font size=3><b>数据恢复管理</b></font></p>
<table width="90%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr class=listtitle align="center">
 <td>单位</td><td>退房日期</td><td>恢复</td></tr>

<%  
   
	
 String sql="select o.code,o.state,o.visadate,o.sectionname+o.loft+o.building+o.room_no room from order_contract o,room r where o.state=3 and r.seccode+r.loft+r.building+r.room_code=o.section+o.loft+r.building+o.room_no and r.salestate=1";
 ResultSet rs=ViewBean.executeQuery(sql);
 while (rs.next()){
   String code=rs.getString("code");
   String room=rs.getString("room");
   String date=getbyte(rs.getString("visadate"));
   if (!date.equals(""))date=date.substring(0,10);
 %>
  <tr align="center" class='listcontent' >
  <td><%=room %></td><td><%=date %>&nbsp;</td><td><a href="#" onclick="ok(<%=code %>);">恢复</a></td></tr>
 <%
       
 
 
 }
 rs.close();
  
  %>
</table>
</form>
<script>
function ok(para){
 
 if (confirm("恢复已退的吗?")) 
 window.location="cancelTF.jsp?sel=<%=sel %>&code="+para;

}

</script>
</body>
</html>
