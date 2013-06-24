<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
	<title>新增房间资料</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*,java.util.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/asiic.jsp"%> 
 <%
 try{
	// Variables
	int count=0;        
	// Initialization
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setTotalMaxFileSize(209715200);
	// Upload	
	mySmartUpload.upload();

	try {
	    //上载文件,不更改上载的文件名称
		count = mySmartUpload.save("/jsp/picture/");
	} catch (Exception e) { 
		out.println(e.toString()+"<br>图片不能超20M");
	}
//com.jspsmart.upload.File file = mySmartUpload.getFiles().getFile(0);
//上载文件,更改上载的文件名称
//file.saveAs("/jsp/picture/" + "aa.txt");

String strPicture=mySmartUpload.getFiles().getFile(0).getFileName();
if(strPicture.length()>0){
	strPicture="../picture/"+strPicture;
}
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();
String []strPara=mySmartUpload.getRequest().getParameterValues("para");
String para=strPara[0];
String [] strSecCode=mySmartUpload.getRequest().getParameterValues("SecCode");
String SecCode=strSecCode[0];
String [] strBuilding=mySmartUpload.getRequest().getParameterValues("Building");
String Building=strBuilding[0];
String[] strFloor=mySmartUpload.getRequest().getParameterValues("Floor");
String Floor=strFloor[0];
String[] strLoft=mySmartUpload.getRequest().getParameterValues("Loft");
String Loft=strLoft[0];
String[] strRoomCode=mySmartUpload.getRequest().getParameterValues("RoomCode");
String RoomCode=strRoomCode[0];
String currRoom=RoomCode;
String[] strArea=mySmartUpload.getRequest().getParameterValues("Area");
String Area=strArea[0];
String[] strHouseType=mySmartUpload.getRequest().getParameterValues("HouseType");
String HouseType=strHouseType[0];
String[] strDirection=mySmartUpload.getRequest().getParameterValues("Direction");
String Direction=strDirection[0];
String[] strScene=mySmartUpload.getRequest().getParameterValues("Scene");
String Scene=strScene[0];
String[] strFitment=mySmartUpload.getRequest().getParameterValues("Fitment");
String Fitment=strFitment[0];
String [] strSaleState=mySmartUpload.getRequest().getParameterValues("SaleState");
String SaleState=strSaleState[0];
String [] strUsedArea=mySmartUpload.getRequest().getParameterValues("UsedArea");
String UsedArea=strUsedArea[0];
if (UsedArea==null){UsedArea="0";}
String[] strApportion=mySmartUpload.getRequest().getParameterValues("Apportion");
String Apportion=strApportion[0];
if (Apportion==null){Apportion="0";}
String[] strServeYear=mySmartUpload.getRequest().getParameterValues("Date1");
String ServeYear=strServeYear[0];
String ServeDate=ServeYear;//+"-"+ServeMonth+"-"+ServeDay;
String[] strRoomType=mySmartUpload.getRequest().getParameterValues("RoomType");
String RoomType=strRoomType[0];
String [] oldrooms=mySmartUpload.getRequest().getParameterValues("oldroom");
String oldroom=oldrooms[0];
String [] strJZUnitPrice=mySmartUpload.getRequest().getParameterValues("JZAreaUnitPrice");
String JZUnitPrice=strJZUnitPrice[0];
if ((JZUnitPrice==null)||(JZUnitPrice.length()==0)){JZUnitPrice="0";}

String [] strTNAreaUnitPrice=mySmartUpload.getRequest().getParameterValues("TNAreaUnitPrice");
String TNAreaUnitPrice=strTNAreaUnitPrice[0];
if ((TNAreaUnitPrice==null)||(TNAreaUnitPrice.length()==0)){TNAreaUnitPrice="0";}
String[] strSumPrice=mySmartUpload.getRequest().getParameterValues("ASumPrice");
String SumPrice=strSumPrice[0];
if ((SumPrice==null)||(SumPrice.length()==0)){SumPrice="0";}
String[] strroomprice=mySmartUpload.getRequest().getParameterValues("SumPrice");
String room_price=strroomprice[0];
String[] map1S=mySmartUpload.getRequest().getParameterValues("map1");
String map1=map1S[0];
String[] lu_tai_areas=mySmartUpload.getRequest().getParameterValues("lutai_area");
String lu_tai_area=lu_tai_areas[0];
String[] lu_tai_area_prices=mySmartUpload.getRequest().getParameterValues("lutai_unitprice");
String lu_tai_area_price=lu_tai_area_prices[0];
String[] yong_tus=mySmartUpload.getRequest().getParameterValues("yong_tu");
String yong_tu= yong_tus[0];
String[] ytz_areas=mySmartUpload.getRequest().getParameterValues("ytz_area");
String ytz_area= ytz_areas[0];
String[] ytz_area_prices=mySmartUpload.getRequest().getParameterValues("ytz_area_price");
String ytz_area_price= ytz_area_prices[0];
String[] ty_areas=mySmartUpload.getRequest().getParameterValues("ty_area");
String ty_area= ty_areas[0];
String[] ty_area_prices=mySmartUpload.getRequest().getParameterValues("ty_area_price");
String ty_area_price= ty_area_prices[0];

String[] dt_area_prices=mySmartUpload.getRequest().getParameterValues("dt_area_price");
String dt_area_price= dt_area_prices[0];
String[] dt_areas=mySmartUpload.getRequest().getParameterValues("dt_area");
String dt_area= dt_areas[0];

String []Ecellnames =mySmartUpload.getRequest().getParameterValues("Ecellname");
String Ecellname=Ecellnames[0];
String []Scellnames =mySmartUpload.getRequest().getParameterValues("Scellname");
String Scellname=Scellnames[0];
 
String cellname="";

String[] useryears=mySmartUpload.getRequest().getParameterValues("useryear");
String useryear= useryears[0];
String[] sds=mySmartUpload.getRequest().getParameterValues("sd");
String sd= sds[0];
String[] eds=mySmartUpload.getRequest().getParameterValues("ed");
String ed= eds[0];

String[] cgs=mySmartUpload.getRequest().getParameterValues("cg");
String cg= cgs[0];
String[] strfloormess=mySmartUpload.getRequest().getParameterValues("floormess");
String floormess= strfloormess[0];
String[] wds=mySmartUpload.getRequest().getParameterValues("wd_area");
String wd_area= wds[0];
String[] wd_area_prices=mySmartUpload.getRequest().getParameterValues("wd_unitprice");
String wd_area_price= wd_area_prices[0];
 
String[] yang_tai_areas=mySmartUpload.getRequest().getParameterValues("yangtai_area");
String yang_tai_area=yang_tai_areas[0];
String [] countTypes=mySmartUpload.getRequest().getParameterValues("countType");
 
String[] codes=mySmartUpload.getRequest().getParameterValues("code");
String code=codes[0];
String[] floorstypes=mySmartUpload.getRequest().getParameterValues("floorstype");
String floorstype=floorstypes[0];
String[] roomsds=mySmartUpload.getRequest().getParameterValues("roomsd");
String roomsd=roomsds[0];
String[] gl_unitprices =mySmartUpload.getRequest().getParameterValues("gl_unitprice");
String gl_unitprice=gl_unitprices[0];
String[] gl_tnprices =mySmartUpload.getRequest().getParameterValues("gl_tnprice");
String gl_tnprice=gl_tnprices[0];
String[] gl_tnareas =mySmartUpload.getRequest().getParameterValues("gl_tnarea");
String gl_tnarea=gl_tnareas[0];
String roombak="";
String[] roombaks =mySmartUpload.getRequest().getParameterValues("roombak");
  roombak=roombaks[0];
 
String countType= "";
if (countTypes!=null)
countType=countTypes[0];
else
 countType="0";
 

String sql1="select lockroom from lockroom where section ='"+SecCode+"' and ";
sql1+=" loft='"+Loft+"' and build='"+Building+"'";
ResultSet rsLock=null;
String LockRoomS="";
try{
  rsLock=InsertBean.executeQuery(sql1);
  while (rsLock.next()){
    LockRoomS=rsLock.getString("LockRoom");
  }
  rsLock.close();
}catch(Exception s)  {out.print("err");}  
 List list1=new LinkedList();//存放房间编码
 StringTokenizer st22 = new StringTokenizer(LockRoomS,",") ;
try{
 while (st22.hasMoreElements()) {
 	 list1.add((String)st22.nextElement());
	
}
 }catch(Exception s){}
String yes="";
String 	Mess="";
String sql="";
String eof="false";
String eofs="false";
String[] strGlAreas=mySmartUpload.getRequest().getParameterValues("gl_Area");
String strGlArea=strGlAreas[0];//阁楼面积
int MaxFloor=1; 
 
String[] FirstFloors=mySmartUpload.getRequest().getParameterValues("FirstFloor");
String[] EndFloors=mySmartUpload.getRequest().getParameterValues("EndFloor");
String[] FirstRooms=mySmartUpload.getRequest().getParameterValues("FirstRoom");
String[] EndRooms=mySmartUpload.getRequest().getParameterValues("EndRoom");

int EndFloor=0;
int FirstFloor=0;
int floornum=java.lang.Integer.parseInt(Floor);
String FirstRoom=FirstRooms[0];
String EndRoom=EndRooms[0];

char RST=FirstRoom.charAt(0);
char RET=EndRoom.charAt(0);
int intBeginR=0;
int intEndR=0;

if(java.lang.Character.isDigit(RST)){//起始房号(判断是字母还是数值)
	 intBeginR=java.lang.Integer.parseInt(FirstRoom);
}
else{
	 intBeginR=Character.getNumericValue(RST)-9;//转换为数字
}
String EndR=EndRoom;
if(java.lang.Character.isDigit(RET)){//终止房号(判断是字母还是数值)
	 intEndR=java.lang.Integer.parseInt(EndRoom);
}
else{
	 intEndR=Character.getNumericValue(RET)-9;//转换为数字

}
String Rinfo="";
int scell=0,ecell=0;
char  CellN1=Scellname.charAt(0);
char  CellN2=Ecellname.charAt(0);

if (!Scellname.equals("")&&!Ecellname.equals("")){
   CellN1=Scellname.charAt(0);
   CellN2=Ecellname.charAt(0);
 
if(java.lang.Character.isDigit(CellN1)){
	 scell=java.lang.Integer.parseInt(Scellname);
	 ecell=java.lang.Integer.parseInt(Ecellname);
}
else{
     scell=Character.getNumericValue(CellN1)-9;
	 ecell=Character.getNumericValue(CellN2)-9;
}
 
}
floornum=java.lang.Integer.parseInt(FirstFloors[0]);
MaxFloor=java.lang.Integer.parseInt(EndFloors[0]);
String StrUpper="ABCDEFGHIJKLOPQRST";
if (scell<0)scell=0;
if (ecell<0)ecell=0;

for(int j2=scell;j2<=ecell;j2++){
Rinfo=AsiicZH(j2,CellN1);
if (para.equals("")){//为增加房间资料


 
for (int r=intBeginR;r<=intEndR;r++){////按指定房号范围增加房间资料
   
  for(int j=floornum;j<=MaxFloor;j++){//按指定楼层范围增加房间资料
   if (roomsd.equals("1")&&r%2!=0)
       continue;
	 else  if (roomsd.equals("2")&&r%2==0)
      continue;
	    Floor=String.valueOf(j);
   String RoomC=String.valueOf(r);
   if (!list1.contains(RoomC)){
   //if (LockRoomS.indexOf(RoomC)<0){
    eof="false";
	  eofs="false";  
	   
	    //判断是否存在该房号
		String sqls="select * from Roomno where SectionNo='"+SecCode+"' and building='"+Building+"' and cell='"+Rinfo+"' and room="+String.valueOf(r)+" and floor="+String.valueOf(j)+" and Region='"+Loft+"'";
	    ResultSet rss= InsertBean.executeQuery(sqls);
	
		if (rss.next()){eof="true";RoomCode=rss.getString("Roomno");}
		 rss.close();
	
	    //判断是否已存在
		sql="select * from Room where seccode='"+SecCode+"' and building='"+Building+"' and cell='"+Rinfo+"' and room="+String.valueOf(r)+" and floor="+String.valueOf(j)+"   and Loft='"+Loft+"'";
	    ResultSet rs= InsertBean.executeQuery(sql);
		
	 
		if (!rs.next()){eofs="true";}
		 rs.close();
	  	if (eof.equals("true") && eofs.equals("true")){
		    sql="'"+SecCode+"','"+Building+"',";
			sql=sql+j+",'"+Loft+"','"+r+"','"+RoomCode+"',"+Area+","+strGlArea+",";
			sql=sql+"'"+HouseType+"','"+Direction+"',"+SaleState+",";
			sql=sql+""+UsedArea+",";
			sql=sql+"'"+Scene+"','"+Fitment+"',";
			sql=sql+"'"+RoomType+"','"+ yong_tu+"',"+JZUnitPrice+",";
			sql+=TNAreaUnitPrice+","+SumPrice+","+room_price+",'";
			sql+=strPicture+"',"+lu_tai_area+","+lu_tai_area_price+","+yang_tai_area+",";
			sql+="0,"+ytz_area+","+ytz_area_price+","+ty_area+","+ty_area_price+","+dt_area+","+dt_area_price+"";
			sql=sql+","+useryear+",'"+sd+"','"+ed+"',"+cg+","+wd_area+","+wd_area_price+","+countType+",'"+floormess+"','"+ServeYear+"','"+Rinfo+"',"+gl_unitprice+","+gl_tnprice+","+gl_tnarea;;
		   try{
		    
             if (floorstype.equals("0"))
		      InsertBean.executeUpdate("exec set_room "+sql);
			 else  if (floorstype.equals("1")&&j%2==0)
		      InsertBean.executeUpdate("exec set_room "+sql); 
			 else  if (floorstype.equals("2")&&j%2!=0)
		      InsertBean.executeUpdate("exec set_room "+sql);  
			  
			    eof="false";
	            eofs="false";  
				 sql="update room set bak='"+roombak+"'  where seccode+loft+room_code='"+SecCode+Loft+RoomCode+"'";
			   InsertBean.executeUpdate(sql);
			   setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "房间资料" , 
                  "增加("+SecCode+Building+Loft+RoomCode+")"
                ) ;
		    }
		    catch(Exception se){
		    out.print(se+sql);
			out.close();
		    }
	 }else{Mess="可能有些房间资料已存在";}
	 out.print(Mess);
	 }	
	}
	}	
	
}else if (para.equals("edit")){
 

 for (int r=intBeginR;r<=intEndR;r++){////按指定房号范围增加房间资料
 if (roomsd.equals("1")&&r%2!=0)
       continue;
	 else  if (roomsd.equals("2")&&r%2==0)
      continue;
 
  for(int j=floornum;j<=MaxFloor;j++){
    Floor=String.valueOf(j);
 
   String RoomC=String.valueOf(r);
   if (!list1.contains(RoomC)){
 
    

   if (strPicture.equals(""))strPicture=map1;
  // if (RoomCode.)
   
 String sqls="select * from Roomno where SectionNo='"+SecCode+"' and building='"+Building+"' and cell='"+Rinfo+"' and room="+String.valueOf(r)+" and floor="+String.valueOf(j)+" and Region='"+Loft+"'";
	    ResultSet rss= InsertBean.executeQuery(sqls);
	    eof="false";
		if (rss.next()){eof="true";RoomCode=rss.getString("Roomno");}
		 rss.close();
     if (!oldroom.equals(currRoom))RoomCode=currRoom;    
 	 
	sql="'"+RoomCode+"',"+Area+","+strGlArea+",";
	sql=sql+"'"+HouseType+"','"+Direction+"',"+SaleState+",";
	sql=sql+""+UsedArea+",";
	sql=sql+"'"+Scene+"','"+Fitment+"',";
	sql=sql+"'"+RoomType+"','"+ yong_tu+"',"+JZUnitPrice+",";
	sql+=TNAreaUnitPrice+","+SumPrice+","+room_price+",'";
	sql+=strPicture+"',"+lu_tai_area+","+lu_tai_area_price+","+yang_tai_area+",";
	sql+="0,"+ytz_area+","+ytz_area_price+","+ty_area+","+ty_area_price+","+dt_area+","+dt_area_price+"";
	sql=sql+","+useryear+",'"+sd+"','"+ed+"',"+cg+","+wd_area+","+wd_area_price+","+countType+",'"+floormess+"',"+code+",'"+ServeYear+"','"+oldroom+"','"+SecCode+"'";
    sql+=",'"+Loft+"','"+Building+"',"+RoomC+","+Floor+",'"+Rinfo+"',"+gl_unitprice+","+gl_tnprice+","+gl_tnarea;;
    try{
 
             if (floorstype.equals("0"))
		      InsertBean.executeUpdate("exec modi_room "+sql);
			 else  if (floorstype.equals("1")&&j%2==0)
		      InsertBean.executeUpdate("exec modi_room "+sql); 
			 else  if (floorstype.equals("2")&&j%2!=0)
		      InsertBean.executeUpdate("exec modi_room "+sql);  
			  sql="update room set bak='"+roombak+"' where seccode+loft+room_code='"+SecCode+Loft+RoomCode+"'";
			    InsertBean.executeUpdate(sql);
 
  setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "房间资料" , 
                  "修改("+SecCode+Building+Loft+RoomCode+")"
                ) ;
 
  }catch(Exception s)	  {out.print(sql+s);}
 }
 }
 }
 }
}
  }catch(Exception s){out.print("系统出现异常错误，错误原因："+s);}  
%>
 <%InsertBean.closeConn();
 
  %>
<p align=center>
 <script language=javascript>
  	function his(){
	 alert("继续输入或修改其他房号资料");
	 var urlstr=opener.window.location;
		    urlstr=urlstr+"b"
		    if (urlstr.indexOf(".jsp")>=0)
		      urlstr=urlstr.substring(0,urlstr.indexOf(".jsp"))+".jsp";
			  var secno=opener.window.document.cus.SecNo.value;
	          var loft=opener.window.document.cus.Loft.value;
			  var SecName=opener.window.document.cus.SecName.value;
			  var Ecellname=opener.window.document.cus.Ecellname.value;
			  var Scellname=opener.window.document.cus.Scellname.value;
	 	 	 opener.window.location=urlstr+"?Section="+secno+"&SecNo="+secno+"&Loft="+loft+"&Ecellname="+Ecellname+"&Scellname="+Scellname+"&SecName="+SecName;
	       close();
	}
	 his();
 </script>

</body>
</html>
 