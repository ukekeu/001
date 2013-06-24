<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*,common.*,java.util.*"%>
<jsp:useBean id = "bBean" scope = "page" class = "ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<body bgcolor="#FFFFFF" text="#000000">
  <%
	
	String gdprice=request.getParameter("gdprice");
	String intEndF=request.getParameter("intEndF");
	String intEndR=request.getParameter("intEndR");
	String sum1=request.getParameter("sum");
	String floorRoom=China.getParameter(request,"floorRoom");
	String zhiroom=China.getParameter(request,"zhiroom");
	String zhiprice=China.getParameter(request,"zhiprice");
	String intBeginR=request.getParameter("intBeginR");
	String intBeginF=request.getParameter("intBeginF");
	String section=China.getParameter(request,"SecNo");
	String loft=China.getParameter(request,"Loft");
	String allint=request.getParameter("allint");
	String building=China.getParameter(request,"Build");
	String StrRoomType=China.getParameter(request,"roomtype");
	String projectname=China.getParameter(request,"projectname");
	String projectdate=request.getParameter("projectdate");
	String TJ=request.getParameter("TJ");
	String[] tmpArray1=new String[300];
	String[] tmpArray2=new String[300];
	String[] tmpArray3=new String[300];
	 List list=new LinkedList();//存放已销售的房间　
	String basicRoom=China.getParameter(request,"basicRoom");
	String jjb=request.getParameter("jjb");
	String DJscale=request.getParameter("DJscale");
	String GDmoney=request.getParameter("GDmoney");
	String yj=request.getParameter("yj");
	String GDscale1=request.getParameter("GDscale1");
	String GDmoney1=request.getParameter("GDmoney1");
	String ch=request.getParameter("ch");
	String choosetype=request.getParameter("choosetype");
	int id=0;
	int x=0;
	String strroom="";
	String sql="";
	
	String RoomNos="";
	String StartFloor="";
try{
	   for(int i=Integer.parseInt(intBeginF);i<=Integer.parseInt(intEndF);i++){
	     for(int j=Integer.parseInt(intBeginR);j<=Integer.parseInt(intEndR);j++){
	      strroom="";
		 
		   if (StartFloor.equals("")) StartFloor=String.valueOf(i);
		   tmpArray1[x]="Pr"+String.valueOf(i)+"A"+String.valueOf(j);
		   tmpArray3[x]=String.valueOf(i);
		   strroom=China.getParameter(request,tmpArray1[x]);
		   tmpArray2[x]="P"+String.valueOf(i)+"A"+String.valueOf(j);
		   if(!getbyte1(strroom).equals(""))x++;
		 }		
		
	   }   
		for(x=0;x<Integer.parseInt(allint);x++){
		 if ( tmpArray1[x]!=null){
	       String str=tmpArray1[x];
		   String str1=tmpArray2[x];
		    String str2=tmpArray3[x];
		       str1=China.getParameter(request,str1);
		   
		   String str3="Q"+String.valueOf(x);
		   str3=China.getParameter(request,str3);
		   String str4="R"+String.valueOf(x);
		    str4=China.getParameter(request,str4);
		   String str5="S"+String.valueOf(x);
		    str5=China.getParameter(request,str5);
		   String str6="T"+String.valueOf(x);
		    str6=China.getParameter(request,str6);
			sql  ="select max(id) as count1 from priceproject1";
	 getRs = bBean.executeQuery(sql) ;
	if(getRs.next()){
	   id=getRs.getInt("count1");
	}
			   sql="insert into ProjectRecord (projectid,room_code,room_rate,roomTypeRate,DecRate,AreaRate,FloorRate,floor)  values ("+id+",'"+getbyte1(request.getParameter(str))+"',"+str1+","+str3+","+str4+","+str5+","+str6+","+str2+") ";
          if (list.contains(getbyte1(request.getParameter(str))))
		   sql="insert into ProjectRecord  (projectid,room_code,room_rate,roomTypeRate,DecRate,AreaRate,FloorRate,floor)  values ("+id+",'"+getbyte1(request.getParameter(str))+"',0,0,0,0,0,"+str2+") ";
			
			  bBean.executeUpdate(sql);
 		//  out.print(sql+"<br>");
   			 }
}
}catch(Exception s){out.print(s.getMessage()+sql);}

 %>
 <script>
 alert("数据保存成功！");
 window.close() ;
 </script>
 <%} %>
</body>
</html>