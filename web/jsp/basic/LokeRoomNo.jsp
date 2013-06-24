<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

<%!
public int toInt( String str ) throws Exception {
    return Math.round( new Float( str ).floatValue() ) ;    
}
%>

<%
String strSection=request.getParameter("seccode");
String strLoft=getbyte2(request.getParameter("loft"));  
String strBuilding=getbyte2(request.getParameter("building"));
String strRoomcode=getbyte2(request.getParameter("RoomNo"));
String SQL="";
if (strBuilding==null)
 strBuilding=""; 
SQL="SELECT STATE FROM ORDER_CONTRACT  where state<>3 and Section='"+strSection+"' and LOFT='"+strLoft+"' and Building='"+strBuilding+"'";
   SQL+=" and  Room_no in (select room_CODE from room  where seccode='"+strSection+"' and LOFT='"+strLoft+"' and Building='"+strBuilding+"'";
   SQL+=" and  Room='"+strRoomcode+"')";
   
ResultSet rs=ViewBean.executeQuery(SQL);
if (!rs.next()){

SQL="insert into LockRoom(section,loft,build,lockroom) values('"+strSection+"','";
SQL+=strLoft+"','"+strBuilding+"','"+strRoomcode+"')";
 
try{
 // ViewBean.executeUpdate(SQL);
   SQL="delete roomno   where SectionNo='"+strSection+"' and Region='"+strLoft+"' and Building='"+strBuilding+"'";
   SQL+=" and  Room='"+strRoomcode+"'";
    ViewBean.executeUpdate(SQL);
	SQL="delete room   where seccode='"+strSection+"' and loft='"+strLoft+"'";
SQL+=" and  Room='"+strRoomcode+"' and Building='"+strBuilding+"' ";
  ViewBean.executeUpdate(SQL);
  
    setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "房间编号" , 
                  "删除编号("+strSection+strLoft+strRoomcode+")"
                ) ;
}catch(Exception s){out.print(s.getMessage());out.close();}

}else{

rs.close();
%>
<script>
alert("此号：已被买出，不能取消!");
 window.close();
</script>
<%


}
rs.close();
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title> </title>
 

</head> 
<script>
function closewind(){
opener.window.location.reload();
 window.close();

}
 closewind();
</script>
<body>      

</body>       
</html>       

