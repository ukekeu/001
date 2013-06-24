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
     String SQL="SELECT year(getdate())  cyy,month(getdate())  cmm,day(getdate())  cdd,year(o.StartDate)  syy,month(o.StartDate)  smm,day(o.StartDate)  sdd,year(o.EndDate)  eyy,month(o.EndDate)  emm,day(o.EndDate)  edd,c.cus_name,o.tel+' '+o.sj phone,o.CardId ,";
	 SQL+="  o.subscription,o.payment,o.disc,";
	 SQL+="o.saleprice rmbprice, o.remark,o.fact_dj, o.subscription-o.fact_dj qs from SL_TemporarilyBuy o,customer c where c.serialno=o.cusname and o.roomcode="+code;
	 ResultSet rs=InsertBean.executeQuery(SQL);
	 String cus_name="",id_card="",zip_code="",phone="",address="",Type="";
	 String section="", room_no="", tnunitprice="",ajdate="",appDate="";
	  String  rmbprice="",serialno="" ,a1="",a2="",a3="",payment1="";
	 String b1="",b2="",b3="",jzarea="",ysumprice="",rgdate="",disc="";
	 String c1=" ",c2=" ",c3=" ",c4=" ",c5=" ",c6=" ",c7=" ",fact_dj="",qs="";
	 String zjh1=" ",zjh2=" ",dz="",area="",usearea="";
	 String e1=" ",e2=" ",e3=" ",bak="",subscription="";
	 
	 if (rs.next()){
         
	    cus_name=rs.getString("cus_name");
		phone=rs.getString("phone");
		id_card=rs.getString("CardId");
		rmbprice=rs.getString("rmbprice");
		payment1=rs.getString("payment");
		disc=rs.getString("disc");
		bak=rs.getString("remark");
		subscription=rs.getString("subscription");
		fact_dj=rs.getString("fact_dj");
		qs=rs.getString("qs");
	    c1=rs.getString("syy");
		c2=rs.getString("smm");
		c3=rs.getString("sdd");
		c4=rs.getString("eyy");
		c5=rs.getString("emm");
		c6=rs.getString("edd");
		e1=rs.getString("cyy");
		e2=rs.getString("cmm");
		e3=rs.getString("cdd");
	 }
	 rs.close();
	 
	 SQL="select R.* from Room R   where R.code="+code;
	 rs=InsertBean.executeQuery(SQL);
	 
		if (rs.next()){
		   
		  room_no=getbyte(rs.getString("Room_code"));
		  area=rs.getString("Area");		   
		  usearea=rs.getString("UsedArea"); 
          ysumprice=rs.getString("Sumprice");
		   
     }
	 rs.close();  
	  
String tmpDoc = "ld.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/zlcrm/jsp/sale/"+tmpDoc;
 
StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
 
sb.append("<bookmark name=\"A1\" value=\""+cus_name+"\"/>");
sb.append("<bookmark name=\"A2\" value=\""+id_card+"\"/>");
sb.append("<bookmark name=\"A3\" value=\""+c1+"\"/>");
 
sb.append("<bookmark name=\"A4\" value=\""+c2+"\"/>");
sb.append("<bookmark name=\"A5\" value=\""+c3+"\"/>");
sb.append("<bookmark name=\"A6\" value=\""+room_no+"\"/>");
sb.append("<bookmark name=\"A7\" value=\""+c4+"\"/>");
sb.append("<bookmark name=\"A8\" value=\""+c5+"\"/>");
sb.append("<bookmark name=\"A9\" value=\""+c6+"\"/>");
 
sb.append("<bookmark name=\"A10\" value=\""+subscription+"\"/>");
 
sb.append("<bookmark name=\"A11\" value=\""+fact_dj+" \"/>");
 
sb.append("<bookmark name=\"A12\" value=\""+qs+"\"/>");

 sb.append("<bookmark name=\"B1\" value=\""+ysumprice+"\"/>");
 sb.append("<bookmark name=\"B3\" value=\""+rmbprice+"\"/>");

sb.append("<bookmark name=\"B2\" value=\""+disc+"\"/>");
sb.append("<bookmark name=\"B4\" value=\""+payment1+" \"/>");
sb.append("<bookmark name=\"B5\" value=\""+area+"\"/>");
sb.append("<bookmark name=\"B6\" value=\""+usearea+"\"/>");
sb.append("<bookmark name=\"B7\" value=\""+bak+"\"/>");
sb.append("<bookmark name=\"B8\" value=\""+phone+"\"/>");
sb.append("<bookmark name=\"B9\" value=\""+e1+"\"/>");
sb.append("<bookmark name=\"B10\" value=\""+e2+"\"/>");
sb.append("<bookmark name=\"B11\" value=\""+e3+"\"/>");

sb.append("<bookmark name=\"B12\" value=\""+e1+"\"/>");
sb.append("<bookmark name=\"B13\" value=\""+e2+"\"/>");
sb.append("<bookmark name=\"B14\" value=\""+e3+"\"/>");
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
    