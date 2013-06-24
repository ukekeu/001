<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<HTML><HEAD><TITLE>挞定审批表</TITLE>
<META http-equiv=Content-Type content="teXt/html; charset=gb2312">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
</HEAD>
<BODY> 
 <%  String code=getbyte2(request.getParameter("code"));
     String SQL="SELECT c.cus_name,c.phone+' '+c.sj phone,c.id_card ,";
	 SQL+=" o.loft+o.room_no roomno,o.serialno, ";
	 SQL+="o.rmbprice,convert(char(10),getdate(),120) appDate from order_contract o,customer c where c.serialno=o.customer and o.code="+code;
	 ResultSet rs=InsertBean.executeQuery(SQL);
	 String cus_name="",id_card="",zip_code="",phone="",address="",Type="";
	 String section="", room_no="", tnunitprice="",ajdate="",appDate="";
	  String  rmbprice="",serialno="" ;
	 
	 if (rs.next()){
 
	    cus_name=rs.getString("cus_name");
		phone=rs.getString("phone");
		id_card=rs.getString("id_card");
		room_no=rs.getString("roomno");
		serialno=rs.getString("serialno");
		rmbprice=rs.getString("rmbprice");
		appDate=rs.getString("appDate");
		 
	 }
	 rs.close();
	 
	 String A_dj="",gather_date="",A_rmbprice="";
	  SQL="select sum(factmoney*CurrRate) as money from FactGatheringRecord where  period =0 and contractno='"+code+"'";
   
      ResultSet rsMoney=InsertBean.executeQuery(SQL);
      if (rsMoney.next())A_dj=FormtD.getFloat3(rsMoney.getDouble("money"),2);
	  rsMoney.close();
	 
      SQL="select  gather_date from FactGatheringRecord where  period =0 and contractno='"+code+"'";
   
        rsMoney=InsertBean.executeQuery(SQL);
      if (rsMoney.next()) gather_date =   rsMoney.getDate( "gather_date" ).toString() ;
	  rsMoney.close();
	 
	 
	   SQL="select sum(factmoney*CurrRate) as money from FactGatheringRecord where    contractno='"+code+"'";
   
        rsMoney=InsertBean.executeQuery(SQL);
      if (rsMoney.next())A_rmbprice=FormtD.getFloat3(rsMoney.getDouble("money"),2);
	  rsMoney.close();
	 
String tmpDoc = "TDB.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/zlcrm/jsp/sale/"+tmpDoc;
 
StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
 
sb.append("<bookmark name=\"A1\" value=\""+(String)session.getAttribute("loginname")+"\"/>");
sb.append("<bookmark name=\"A2\" value=\""+appDate+"\"/>");
sb.append("<bookmark name=\"A3\" value=\""+room_no+"\"/>");
 
sb.append("<bookmark name=\"A4\" value=\""+cus_name+"\"/>");
sb.append("<bookmark name=\"A5\" value=\""+phone+"\"/>");
sb.append("<bookmark name=\"A6\" value=\""+id_card+"\"/>");
sb.append("<bookmark name=\"A7\" value=\""+A_dj+"\"/>");
sb.append("<bookmark name=\"A8\" value=\""+gather_date+" \"/>");
sb.append("<bookmark name=\"A9\" value=\""+rmbprice+"\"/>");
 
sb.append("<bookmark name=\"A10\" value=\""+A_rmbprice+"\"/>");
  
  
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
    