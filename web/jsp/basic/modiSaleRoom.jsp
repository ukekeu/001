<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
	<title>新增房间资料</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%
	// Variables
	int count=0;        

	// Initialization
	mySmartUpload.initialize(pageContext);

	mySmartUpload.setTotalMaxFileSize(200000);

	// Upload	
	mySmartUpload.upload();

	try {
		count = mySmartUpload.save("/jsp/sectionpic/");
	} catch (Exception e) { 
		out.println(e.toString());
	}

String strPicture=mySmartUpload.getFiles().getFile(0).getFileName();
if(strPicture.length()>0){
	strPicture="../sectionpic/"+strPicture;
}
	// Retreive parameters
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();
String []strPara=mySmartUpload.getRequest().getParameterValues("para");
String para=strPara[0];

String [] strSecCode=mySmartUpload.getRequest().getParameterValues("SecCode");
String SecCode=strSecCode[0];
String [] strBuilding=mySmartUpload.getRequest().getParameterValues("Building");
String Building=strBuilding[0];
      //Building=new String(Building.getBytes("ISO8859_1"),"GBK");
String[] strFloor=mySmartUpload.getRequest().getParameterValues("Floor");
String Floor=strFloor[0];
String[] strLoft=mySmartUpload.getRequest().getParameterValues("Loft");
String Loft=strLoft[0];
String[] strRoomCode=mySmartUpload.getRequest().getParameterValues("RoomCode");
String RoomCode=strRoomCode[0];
String currRoom=RoomCode;
String[] strArea=mySmartUpload.getRequest().getParameterValues("Area");
String Area=strArea[0];
String [] strUsedArea=mySmartUpload.getRequest().getParameterValues("UsedArea");
String UsedArea=strUsedArea[0];
if (UsedArea==null){UsedArea="0";} 
String [] oldrooms=mySmartUpload.getRequest().getParameterValues("oldroom");
String oldroom=oldrooms[0]; 
String[] lu_tai_areas=mySmartUpload.getRequest().getParameterValues("lutai_area");
String lu_tai_area=lu_tai_areas[0];
String[] yong_tus=mySmartUpload.getRequest().getParameterValues("yong_tu");
String yong_tu= yong_tus[0];
String [] yangtai_areas=mySmartUpload.getRequest().getParameterValues("yangtai_area");
String yangtai_area=yangtai_areas[0];
String [] ftjd_areas=mySmartUpload.getRequest().getParameterValues("ftjd_area");
String ftjd_area=ftjd_areas[0];
String [] ftyd_areas=mySmartUpload.getRequest().getParameterValues("ftyd_area");
String ftyd_area=ftyd_areas[0];

String[] ytz_areas=mySmartUpload.getRequest().getParameterValues("ytz_area");
String ytz_area= ytz_areas[0];
String[] ytz_area_prices=mySmartUpload.getRequest().getParameterValues("ytz_area_price");
String ytz_area_price= ytz_area_prices[0];
String[] ty_areas=mySmartUpload.getRequest().getParameterValues("ty_area");
String ty_area= ty_areas[0];


String[] dt_area_prices=mySmartUpload.getRequest().getParameterValues("dt_area_price");
String dt_area_price= dt_area_prices[0];
String[] dt_areas=mySmartUpload.getRequest().getParameterValues("dt_area");
String dt_area= dt_areas[0];
String [] countTypes=mySmartUpload.getRequest().getParameterValues("countType");

 String[] wds=mySmartUpload.getRequest().getParameterValues("wd_area");
String wd_area= wds[0];
String[] wd_area_prices=mySmartUpload.getRequest().getParameterValues("wd_unitprice");
String wd_area_price= wd_area_prices[0];

String countType= "";
if (countTypes!=null)
countType=countTypes[0];
else
 countType="0";
 
  String sql="update room set Sumprice=unitprice*"+Area+",room_price=unitprice*"+Area+",UsedArea="+UsedArea+",Area="+Area+",room_code='"+RoomCode+"'";
  sql+=",lu_tai_area="+lu_tai_area+",yang_tai_zhao_price="+ytz_area_price+",yang_tai_zhao_sarea="+ytz_area;
  sql+=",ftjd_area="+ftjd_area+",ftyd_area="+ftyd_area+",dt_area="+dt_area+",dt_area_price="+dt_area_price;
  sql+=",yang_tai_area="+yangtai_area+",yong_tu='"+yong_tu+"',countType="+countType;
  sql+=",ty_area="+ty_area+",ty_y_area="+ty_area+",wd_area="+wd_area+",wd_y_area="+wd_area;
 
  sql+=",wd_area_price="+wd_area_price+",lu_tai_mapp_area="+lu_tai_area;
  sql+=" where seccode='"+SecCode+"' and Loft='";
  sql+=Loft+"' and building='"+Building+"' and Room_code='"+oldroom+"' and floor="+Floor;
   
 String MODIC="UPDATE Order_Contract SET Room_no='"+RoomCode+"' ,room_sumprice=rmbprice*1.0/area*"+UsedArea;
 MODIC+=",salerprice=rmbprice*1.0/area*"+UsedArea+",rmbprice=rmbprice*1.0/area*"+UsedArea;
 MODIC+=",jzarea="+Area;
 MODIC+=",area="+UsedArea+",yong_tu='"+yong_tu+"'";
 MODIC+=",ty_area="+ty_area+",wd_area="+wd_area;
 MODIC+=",lu_tai_area="+lu_tai_area +" where state<2 and  section='"+SecCode+"' and Loft='";
 MODIC+=Loft+"' and building='"+Building+"' and Room_no='"+RoomCode+"' and floors="+Floor;
 InsertBean.executeUpdate(sql);
 InsertBean.executeUpdate(MODIC);
%>

<script language=javascript>
  	function his(){
	 alert("继续输入或修改其他房号资料");
	 
	opener.window.location.reload();
	close();
	}
	his();
 </script>
</body>
</html>
