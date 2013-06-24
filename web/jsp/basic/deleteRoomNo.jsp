<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>

<%!
public int toInt( String str ) throws Exception {
    return Math.round( new Float( str ).floatValue() ) ;    
}
%>
<%@ include file="../public_js/logrecord.jsp" %>
 <%

String strSection=getbyte2(request.getParameter("seccode"));
String strLoft=getbyte2(request.getParameter("loft"));  
String strBuilding=getbyte2(request.getParameter("building"));
String strRoomcode=getbyte2(request.getParameter("Room_code"));
 
 String SQL="select room_no from order_contract   where state<>3 and section='"+strSection+"' and loft='"+strLoft+"' and  Room_no='"+strRoomcode+"'";
  ResultSet rs=ViewBean.executeQuery(SQL);
  if (!rs.next()){

 SQL="delete roomno   where SectionNo='"+strSection+"' and Region='"+strLoft+"'";
SQL+=" and  RoomNo='"+strRoomcode+"' AND Building='"+strBuilding+"'";
 

try{
  ViewBean.executeUpdate(SQL);

    SQL="delete room   where seccode='"+strSection+"' and loft='"+strLoft+"'";
    SQL+=" and  Room_code='"+strRoomcode+"'";
  ViewBean.executeUpdate(SQL);
   setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "房间编号" , 
                  "取消编号("+strSection+strLoft+strRoomcode+")"
                ) ;
 }catch(Exception s){out.print(s.getMessage());out.close();}
}else{
%>
<%=SQL %>
<script>
alert("此号被出售，不能取消");
opener.window.location.reload();
 window.close();
</script>

<%out.close();} %>
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

