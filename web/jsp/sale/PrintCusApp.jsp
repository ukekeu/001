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
     String CodeStr=getbyte2(request.getParameter("CodeStr"));
     String SQL="SELECT c.address,c.cus_name,c.phone+' '+c.sj phone,c.id_card ,";
	 SQL+="  o.room_no roomno,o.serialno, o.jzarea,o.ysumprice,";
	 SQL+="o.rmbprice,convert(char(10),getdate(),120) appDate,convert(char(10),date ,120) rgdate,o.payment1,o.disc  from order_contract o,customer c where c.serialno=o.customer and o.code="+code;
	 ResultSet rs=InsertBean.executeQuery(SQL);
	 String cus_name="",id_card="",zip_code="",phone="",address="",Type="";
	 String section="", room_no="", tnunitprice="",ajdate="",appDate="";
	  String  rmbprice="",serialno="" ,a1="",a2="",a3="",payment1="";
	 String b1="",b2="",b3="",jzarea="",ysumprice="",rgdate="",disc="";
	 String c1=" ",c2=" ",c3=" ",c4=" ",c5=" ",c6=" ",c7=" ";
	 String zjh1=" ",zjh2=" ",dz="";
	 String e1=" ",e2=" ",e3=" ";
	 
	 if (rs.next()){
        dz=rs.getString("address");
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
		
		 StringTokenizer st24 = new StringTokenizer(id_card,"/") ;
		int count24 = st24.countTokens() ;
		  ii=0;
		while (st24.hasMoreElements()) {
			if (ii==0)zjh1=(String)st24.nextElement();
			else if (ii==1)zjh2=(String)st24.nextElement();
		 
			ii++;
			}
		 StringTokenizer st23 = new StringTokenizer(CodeStr,",") ;
		int count23 = st23.countTokens() ;
		  ii=0;
		while (st23.hasMoreElements()) {
			String aa=(String)st23.nextElement();
			if (aa.equals("1"))c1="√";
			else if (aa.equals("2"))c2="√";
			else if (aa.equals("3"))c3="√";
			else if (aa.equals("4"))c4="√";
			else if (aa.equals("5"))c5="√";
			else if (aa.equals("6"))c6="√";
			else if (aa.equals("7"))c7="√";
			ii++;
			}
		
		
		
	  if (!appDate.equals("")){
		 a1=appDate.substring(0,4);
		 a2=appDate.substring(5,7);
		 a3=appDate.substring(8,10);
	  }
	 String A_dj="",gather_date="",A_rmbprice="";
	  SQL="select factmoney*CurrRate  as money,gather_date,period from FactGatheringRecord where     contractno='"+code+"'";
   
      ResultSet rsMoney=InsertBean.executeQuery(SQL);
	  ii=0;
      while (rsMoney.next())
	  {
	  if (ii==0){
	     e1=rsMoney.getDate( "gather_date" ).toString();
		 int period=0;
		 period=rsMoney.getInt("period");
		 if (period==0)e1+=" "+"定金";
		 else  if (period>=1)e1+=" "+"首期";
		 e1+=FormtD.getFloat3(rsMoney.getDouble("money"),2);
	  }else  if (ii==1){
	     e2=rsMoney.getDate( "gather_date" ).toString();
		 int period=0;
		 period=rsMoney.getInt("period");
		 if (period==0)e2+=" "+"定金";
		 else  if (period>=1)e2+=" "+"首期";
		 e2+=FormtD.getFloat3(rsMoney.getDouble("money"),2);
	  
	   }else  if (ii==2){
	     e3=rsMoney.getDate( "gather_date" ).toString();
		 int period=0;
		 period=rsMoney.getInt("period");
		 if (period==0)e3+=" "+"定金";
		 else  if (period>=1)e3+=" "+"首期";
		 e3+=FormtD.getFloat3(rsMoney.getDouble("money"),2);
	  
	  }
	  }
	  rsMoney.close();
	  
	 
String tmpDoc = "ModiCus.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/zlcrm/jsp/sale/"+tmpDoc;
 
StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
 
sb.append("<bookmark name=\"A1\" value=\""+a1+"\"/>");
sb.append("<bookmark name=\"A2\" value=\""+22+"\"/>");
sb.append("<bookmark name=\"A3\" value=\""+33+"\"/>");
 
sb.append("<bookmark name=\"A4\" value=\""+c1+"\"/>");
sb.append("<bookmark name=\"A5\" value=\""+c2+"\"/>");
sb.append("<bookmark name=\"A6\" value=\""+c3+"\"/>");
sb.append("<bookmark name=\"A7\" value=\""+c4+"\"/>");
sb.append("<bookmark name=\"A8\" value=\""+c5+"\"/>");
sb.append("<bookmark name=\"A9\" value=\""+c6+"\"/>");
 
sb.append("<bookmark name=\"A10\" value=\""+c7+"\"/>");
 
sb.append("<bookmark name=\"A11\" value=\""+serialno+" \"/>");
 
sb.append("<bookmark name=\"A12\" value=\""+b1+"\"/>");
sb.append("<bookmark name=\"A13\" value=\""+zjh1+" \"/>");
sb.append("<bookmark name=\"A14\" value=\""+b2+" \"/>");
sb.append("<bookmark name=\"A17\" value=\""+zjh2+" \"/>");

sb.append("<bookmark name=\"A18\" value=\""+dz+" \"/>");
sb.append("<bookmark name=\"A19\" value=\""+phone+"\"/>");
sb.append("<bookmark name=\"A20\" value=\""+room_no+"\"/>");
sb.append("<bookmark name=\"A21\" value=\""+jzarea+"\"/>");
sb.append("<bookmark name=\"A22\" value=\""+ysumprice+"\"/>");
sb.append("<bookmark name=\"A23\" value=\""+payment1+"\"/>");
sb.append("<bookmark name=\"A24\" value=\""+disc+"\"/>");
sb.append("<bookmark name=\"A25\" value=\""+rmbprice+"\"/>");

sb.append("<bookmark name=\"A26\" value=\""+e1+"\"/>");
sb.append("<bookmark name=\"A27\" value=\""+e2+"\"/>");
sb.append("<bookmark name=\"A28\" value=\""+e3+"\"/>");
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
    