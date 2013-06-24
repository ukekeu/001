<%@ page contentType="teXt/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<HTML><HEAD><TITLE>房地产买卖认购书</TITLE>
<META http-equiv=Content-Type content="teXt/html; charset=gb2312">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
<META content=FrontPage.Editor.Document name=ProgId>
<STYLE type=teXt/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 10pt; FONT-FAMILY: 宋体
}
TABLE {
	FONT-SIZE: 10pt; FONT-FAMILY: 宋体
}
A:link {
	COLOR: #0000cc; TEXT-DECORATION: none
}
A:visited {
	COLOR: #0000cc; TEXT-DECORATION: none
}
A:active {
	COLOR: #ff0000; TEXT-DECORATION: none
}
A:hover {
	TEXT-DECORATION: underline
}
.unnamed1 {
	FONT-SIZE: 9pt; FONT-FAMILY: "宋体"
}
.unnamed2 {
	FONT-SIZE: 15pt
}
</STYLE>
</HEAD>
<BODY bgColor=#ffffff> 
 <%//try{
	 String secno=getbyte2(request.getParameter("secno"));
     String loft=getbyte2(request.getParameter("loft"));
	 String roomno=getbyte2(request.getParameter("roomno"));
	 String floors=request.getParameter("Floor");
	 String  code=request.getParameter("code");
	 //读取业主资料
	 String SQL="SELECT  d.cell,o.serialno,o.customer,o.disc,o.ysumprice,o.note,year(getdate())  cyy,month(getdate())  cmm,day(getdate())  cdd,year(dateadd(dd,7,date))  yjyy,month(dateadd(dd,7,date))  yjmm,day(dateadd(dd,7,date))  yjdd,DATEDIFF(DD,o.VISADATE ,o.JLDATE) CD,c.cus_name,c.phone+' '+c.sj phone,c.id_card,c.zip_code,c.address,";
	 SQL+="o.section,o.loft,o.room_no,o.xiaoshoutype,o.floors,o.jzarea,o.area,dateadd(dd,30,visadate) ajdate,o.yong_tu,o.ajbk,";
	 SQL+="o.jzarea-o.area ft,o.subscription,o.count_type,o.rmbprice,o.rmbprice-o.ajmoney firstMoney,(o.rmbprice-o.ajmoney)*1.0/o.rmbprice*100 firstbl,o.rmbprice/o.area tnunitprice,o.rmbprice/o.jzarea unitprice,o.payment1,o.JLdate,o.ajyear,o.ajmoney,o.ajmoney*100.0/o.rmbprice ajb,o.visadate,DATEDIFF(dd,visadate,o.jldate) num,datediff(dd,dateadd(dd,30,visadate),o.jldate) num1,dateadd(m,2,visadate) xfjldate from order_contract o,customer c,room d where  o.section+o.loft+o.room_no=d.seccode+d.loft+d.room_code and c.serialno=o.customer and o.code="+code;
	  ResultSet rs=InsertBean.executeQuery(SQL);	
	 String cus_name="",id_card="",zip_code="",phone="",address="",Type="",ajbk="",note="";
	 String section="", room_no="", tnunitprice="",ajdate="",subscription="";
	  String jzarea="",tnarea="",ft="",uppercaseMoney="",unitprice="",firstMoney="",firstbl="";
	 boolean xiaoshoutype=false,count_type=false;
	 int xcnum=0,ysnum=0,cd=0;
	 String yroomno="",xfjldate="",yrmbprice="",disc="",cell="";
	 String payment1="",JLdate="",ajb="",ajmoney="",ajyear="",visadate="";
	 String yjyy="",yjmm="",yjdd="",cyy="",cmm="",cdd="",serialno="",ajrate="";
	 if (rs.next()){
	// ajrate =rs.getString("ajrate");
        disc =rs.getString("disc");
	    note=rs.getString("note");
	    cd=rs.getInt("cd") ;
        serialno=rs.getString("serialno");
        yrmbprice=rs.getString("ysumprice");
		cyy=rs.getString("cyy");
		cmm=rs.getString("cmm");
		cdd=rs.getString("cdd");
		yjyy=rs.getString("yjyy");
		yjmm=rs.getString("yjmm");
		yjdd=rs.getString("yjdd"); 
	    cus_name=rs.getString("cus_name");
		phone=rs.getString("phone");
		id_card=rs.getString("id_card");
		zip_code=rs.getString("zip_code");
		address=rs.getString("address");
		section=rs.getString("section");
		cell=rs.getString("cell");
		loft=rs.getString("loft");
		// if (loft.indexOf("-")>=0)loft=loft.substring(0,loft.indexOf("-")); 		
		room_no=rs.getString("room_no");
		yroomno=room_no;
		if (room_no.indexOf("-")>=0)room_no=room_no.substring(room_no.indexOf("-")+1);
		xiaoshoutype =rs.getBoolean("xiaoshoutype");
		floors=rs.getString("floors");
		if (floors.equals("0"))floors="地下";
		else if (Integer.parseInt(floors)<0){floors="地下"+floors.substring(floors.indexOf("-")+1)+"层";}
		if (floors.indexOf("层")>=0)floors=floors.substring(0,floors.indexOf("层"));
		
		jzarea=FormtD.getFloat1(rs.getFloat("jzarea"),2);
		tnarea=FormtD.getFloat1(rs.getFloat("area"),2);
		Type=rs.getString("yong_tu");
		ajbk=rs.getString("ajbk");
		//ajdate=rs.getDate("ajdate").toString();
		ft=FormtD.getFloat1(rs.getFloat("ft"),2);
		 
		subscription=rs.getString("subscription");
		count_type=rs.getBoolean("count_type");
 
		uppercaseMoney=rs.getString("rmbprice");
		firstMoney=rs.getString("firstMoney");
		firstbl=FormtD.getFloat(rs.getFloat("firstbl"),2);
		tnunitprice=FormtD.getFloat1(rs.getFloat("tnunitprice"),2);
		unitprice=FormtD.getFloat1(rs.getFloat("unitprice"),2);
		payment1=rs.getString("payment1");
		JLdate=rs.getString("JLdate");
		ajyear=rs.getString("ajyear");
		ajmoney=rs.getString("ajmoney");
		ajb=FormtD.getFloat(rs.getFloat("ajb"),2);
	 	 }
	 rs.close();
	 
	StringTokenizer st22 = new StringTokenizer(cus_name,"/") ;
	int count2 = st22.countTokens() ;
	String cusname1="",cusname2=" ",cusname3=" ",cusname4=" ";
	String tel1=" ",tel2=" ",tel3=" ",tel4=" ";
	String zjh1=" ",zjh2=" ",zjh3=" ",zjh4=" ";
	  int i1=0;
		 
			
 String tmpDoc = "";
 
  tmpDoc = "rgs1.doc";
  
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/zlcrm/jsp/sale/"+tmpDoc;
 
StringBuffer sb = new StringBuffer();
sb.append("<document>");

sb.append("<doc url=\""+url+"\"/>");
 
sb.append("<bookmark name=\"A1\" value=\""+yjyy+" \"/>");
sb.append("<bookmark name=\"A2\" value=\""+yjmm+" \"/>");
sb.append("<bookmark name=\"A3\" value=\""+yjdd+" \"/>");
sb.append("<bookmark name=\"A4\" value=\""+serialno+" \"/>");
sb.append("<bookmark name=\"A5\" value=\""+cus_name+"\"/>");
 
 sb.append("<bookmark name=\"A6\" value=\""+phone+"\"/>"); 
sb.append("<bookmark name=\"A7\" value=\""+id_card+"\"/>"); 

sb.append("<bookmark name=\"A8\" value=\""+address+"\"/>"); 
sb.append("<bookmark name=\"A9\" value=\""+loft+"\"/>"); 
 
sb.append("<bookmark name=\"A10\" value=\""+cell+"\"/>"); 
 
sb.append("<bookmark name=\"A11\" value=\" "+floors+"\"/>"); 
sb.append("<bookmark name=\"A12\" value=\""+room_no+"\"/>");
 

sb.append("<bookmark name=\"A13\" value=\""+jzarea+"\"/>"); 
sb.append("<bookmark name=\"A14\" value=\""+unitprice+"\"/>"); 
 
 
	   String p1="×",p2="×",p3="×",p4="×",p5="×",p6="×",p7="×",p8="×";
	   String uppercaseMoney1="";
	  String upperMoney="";
		ResultSet execRs=InsertBean1.executeQuery("exec dbo.L2U "+uppercaseMoney+",1 ");//大写金额转换存储过程
             if (execRs.next())
				upperMoney=getbyte(execRs.getString("dd"));
				execRs.close();
				
			 upperMoney=upperMoney.substring(0,upperMoney.indexOf("元")+1);
		 if (upperMoney.length()==8){  
		  for (int ii=1;ii<10;ii++){
		   if (ii==1)
		      p4= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p5= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p6= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p7= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p8= upperMoney.substring(ii-1,ii);  
			  }
		  }else   if (upperMoney.length()==10){
		   for (int ii=1;ii<10;ii++){
		      if (ii==1)
		      p3= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p4= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p5= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p6= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p7= upperMoney.substring(ii-1,ii);  
			   if (ii==11)
		      p8= upperMoney.substring(ii-1,ii);  
		   }
		  }else  if (upperMoney.length()==12){
		   for (int ii=1;ii<12;ii++){
		      if (ii==1)
		      p2= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p3= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p4= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p5= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p6= upperMoney.substring(ii-1,ii);  
			   if (ii==11)
		      p7= upperMoney.substring(ii-1,ii);  
			     if (ii==13)
		      p8= upperMoney.substring(ii-1,ii);  
		   }
		   }else  if (upperMoney.length()==14){
		   for (int ii=1;ii<14;ii++){
		      if (ii==1)
		      p1= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p2= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p3= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p4= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p5= upperMoney.substring(ii-1,ii);  
			   if (ii==11)
		      p6= upperMoney.substring(ii-1,ii);  
			     if (ii==13)
		      p7= upperMoney.substring(ii-1,ii);  
			      if (ii==15)
		      p8= upperMoney.substring(ii-1,ii); 
		   }
		  }
	 
  
	  sb.append("<bookmark name=\"A22\" value=\""+subscription +"\"/>");
       
	  sb.append("<bookmark name=\"A15\" value=\""+p1 +"\"/>");
	  sb.append("<bookmark name=\"A16\" value=\""+p2 +"\"/>");
	  sb.append("<bookmark name=\"A17\" value=\""+p3 +"\"/>");
	  sb.append("<bookmark name=\"A18\" value=\""+p4+"\"/>");
	  sb.append("<bookmark name=\"A19\" value=\""+p5+"\"/>");
	  sb.append("<bookmark name=\"A20\" value=\""+p6 +"\"/>");
	  sb.append("<bookmark name=\"A21\" value=\""+p7 +"\"/>");
      if (payment1.indexOf("揭")>=0){
			sb.append("<bookmark name=\"A23\" value=\""+firstbl+"\"/>");
			sb.append("<bookmark name=\"A24\" value=\""+firstMoney+"\"/>");
			}else{
			
			sb.append("<bookmark name=\"A23\" value=\" \"/>");
			sb.append("<bookmark name=\"A24\" value=\" \"/>");
			}
		

sb.append("</document>");
out.println(sb.toString());
 
  %>
  
<!-- http://localhost/liwbr32.asp //-->
<OBJECT ID="BookmarkRplr" CLASSID="CLSID:D5D79C43-201A-4064-93A5-8FA6F768DF9E" CODEBASE="liwbr32.CAB#version=1,1,0,4"></OBJECT>
<div id="renderMessage">正在下载...</div>
<script event="onload" for="window">
	execute();
</script>
<script language="javascript">
function execute(){
    BookmarkRplr.XMLString='<%=sb.toString()%>';
	BookmarkRplr.execute();
	while (BookmarkRplr.Busy){
		document.all.renderMessage.innerHTML = BookmarkRplr.Message;
	}
	document.all.renderMessage.innerHTML = BookmarkRplr.Message;
	window.close();
}
</script>
<input type="submit" value="如果下载数据不成功或者长时间停顿，请重新点击这个按钮尝试..." onclick="execute();">
<%//}catch(Exception s){  out.print(s.getMessage());out.close();}%>   
   </body>
</html>