<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<HTML><HEAD><TITLE>折扣优惠申请表</TITLE>
<META http-equiv=Content-Type content="teXt/html; charset=gb2312">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
</HEAD>
<BODY> 
 <%  String code=getbyte2(request.getParameter("code"));
     String SQL="SELECT c.cus_name,c.phone+' '+c.sj phone,c.id_card ,";
	 SQL+="  o.room_no roomno,o.serialno, o.jzarea,o.ysumprice,";
	 SQL+="o.rmbprice,convert(char(10),getdate(),120) appDate,convert(char(10),date ,120) rgdate,o.payment1,o.disc  from order_contract o,customer c where c.serialno=o.customer and o.code="+code;
	 ResultSet rs=InsertBean.executeQuery(SQL);
	 String cus_name="",id_card="",zip_code="",phone="",address="",Type="";
	 String section="", room_no="", tnunitprice="",ajdate="",appDate="";
	  String  rmbprice="",serialno="" ,a1="",a2="",a3="",payment1="";
	 String b1="",b2="",b3="",jzarea="",ysumprice="",rgdate="",disc="";
	 
	 if (rs.next()){
 
	    cus_name=rs.getString("cus_name");
		phone=rs.getString("phone");
		id_card=rs.getString("id_card");
		room_no=rs.getString("roomno");
		serialno=rs.getString("serialno");
		jzarea=rs.getString("jzarea");
		ysumprice=rs.getString("ysumprice");
		rmbprice=rs.getString("rmbprice");
		appDate=rs.getString("appDate");
		rgdate=rs.getString("rgdate");
		payment1=rs.getString("payment1");
		disc=rs.getString("disc");
	 }
	 rs.close();
	 StringTokenizer st22 = new StringTokenizer(cus_name,"/") ;
		int count22 = st22.countTokens() ;
		int ii=0;
		while (st22.hasMoreElements()) {
			if (ii==0)b1=(String)st22.nextElement();
			else if (ii==1)b2=(String)st22.nextElement();
			else if (ii==2)b3=(String)st22.nextElement();
			ii++;
			}
		
	  if (!appDate.equals("")){
		 a1=appDate.substring(0,4);
		 a2=appDate.substring(5,7);
		 a3=appDate.substring(8,10);
	  }
	 String A_dj="",gather_date="",A_rmbprice="";
	  SQL="select sum(factmoney*CurrRate) as money from FactGatheringRecord where  period =0 and contractno='"+code+"'";
   
      ResultSet rsMoney=InsertBean.executeQuery(SQL);
      if (rsMoney.next())A_dj=FormtD.getFloat3(rsMoney.getDouble("money"),2);
	  rsMoney.close();
	 
      SQL="select gather_date from FactGatheringRecord where  period =0 and contractno='"+code+"'";
   
        rsMoney=InsertBean.executeQuery(SQL);
      if (rsMoney.next()) gather_date =   rsMoney.getDate( "gather_date" ).toString() ;
	  rsMoney.close();
	 
	 
	   SQL="select sum(factmoney*CurrRate) as money from FactGatheringRecord where    contractno='"+code+"'";
   
        rsMoney=InsertBean.executeQuery(SQL);
      if (rsMoney.next())A_rmbprice=FormtD.getFloat3(rsMoney.getDouble("money"),2);
	  rsMoney.close();
	 
String tmpDoc = "disc.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/zlcrm/jsp/sale/"+tmpDoc;
 
StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
 
sb.append("<bookmark name=\"A1\" value=\""+a1+" \"/>");
sb.append("<bookmark name=\"A2\" value=\""+a2+" \"/>");
sb.append("<bookmark name=\"A3\" value=\""+a3+" \"/>");
 
sb.append("<bookmark name=\"A4\" value=\""+b1+" \"/>");
sb.append("<bookmark name=\"A5\" value=\""+b2+" \"/>");
sb.append("<bookmark name=\"A6\" value=\""+b3+" \"/>");
sb.append("<bookmark name=\"A7\" value=\""+phone+" \"/>");
sb.append("<bookmark name=\"A8\" value=\""+room_no+" \"/>");
sb.append("<bookmark name=\"A9\" value=\""+jzarea+"\"/>");
 
sb.append("<bookmark name=\"A10\" value=\""+ysumprice+" \"/>");
 
sb.append("<bookmark name=\"A11\" value=\""+rgdate+" \"/>");
 
sb.append("<bookmark name=\"A12\" value=\""+serialno+" \"/>");
sb.append("<bookmark name=\"A13\" value=\""+payment1+" \"/>");
sb.append("<bookmark name=\"A14\" value=\""+disc+" \"/>");
sb.append("<bookmark name=\"A15\" value=\""+rmbprice+" \"/>");
	  sb.append("</document>");
out.println(sb.toString());
 
  %>
 
<OBJECT ID="BookmarkRplr" CLASSID="CLSID:D5D79C43-201A-4064-93A5-8FA6F768DF9E"
CODEBASE="liwbr32.CAB#version=1,1,0,4"></OBJECT>
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
    