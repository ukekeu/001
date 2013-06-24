<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page import = "java.sql.*" %> 
<jsp:useBean id = "SendSt" scope = "page" class = "ConnDatabase.SendData" /> 
<jsp:useBean id = "ReadSt" scope = "page" class = "ConnDatabase.SDatabase" /> 
<jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/> 
	 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>传送数据......</title>
</head>

<body>
<%

 String locaSQL="SELECT * FROM room where send=1";
 String remSQL="";
 ResultSet locaRs=null;
try{
    String strSection="";
	String strLoft="";  
	String strBuilding="";
	String currNo="";
	String strFloor="";
	String strRoomcode="";
	String Sumprice="";
	String JzArea="";
	String TnArea="";
	String TnPrice="";
	String JzPrice="";
	String Roomtype="";
	String Fitment="";
	String Direction="";
	String Scene="";
	String Room_Type="";//房类
	String ApportionArea="";
	String SaleState="";
	String Map="";
 locaRs=ReadSt.executeQuery(locaSQL);
 while (locaRs.next()){
    strSection=locaRs.getString("seccode"); 
	strLoft=getbyte(locaRs.getString("loft"));
	strBuilding=getbyte(locaRs.getString("building"));
	strRoomcode=locaRs.getString("Room_code");
	currNo=locaRs.getString("Room");
	strFloor=locaRs.getString("Floor");
    Sumprice=RsRoom.getString("Sumprice");
    JzArea=FormtD.getFloat(RsRoom.getFloat("JzArea"),4);
	TnArea=FormtD.getFloat(RsRoom.getFloat("TnArea"),4);
	TnPrice=FormtD.getFloat1(RsRoom.getFloat("TnPrice"),2);
	JzPrice=FormtD.getFloat1(RsRoom.getFloat("JzPrice"),2);
	Roomtype=getbyte(RsRoom.getString("Roomtype"));
	Fitment=getbyte(RsRoom.getString("Fitment"));
	Direction=getbyte(RsRoom.getString("Direction"));
	Scene=getbyte(RsRoom.getString("Scene"));
	Room_Type=getbyte(RsRoom.getString("Room_Type"));
	ApportionArea=FormtD.getFloat(RsRoom.getFloat("ApportionArea"),4);
	SaleState=RsRoom.getString("SaleState");
	Map=RsRoom.getString("Map");
    remSQL="update room  set SaleState="+locaRs.getString("SaleState")
	+" where seccode='"
    +strSection+"' and loft='"
	+strLoft+"' and building='"
	+strBuilding+"' and Room_code='"
	+strRoomcode+"'";
    int i=SendSt.executeUpdate(remSQL);
	if (i>0)out.print("ok");
	else out.print("erro");
	
 
 }
 locaRs.close();
 }catch(Exception s){out.print(remSQL);}
 %>


</body>
</html>
