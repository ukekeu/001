<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<HTML><HEAD><TITLE>vip</TITLE>
<META http-equiv=Content-Type content="teXt/html; charset=gb2312">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
</HEAD>
<BODY> 
 <%  String code=getbyte2(request.getParameter("code"));
  
    String sql=  " select convert(char(10),a.dengji_riqi,120) dengji_riqi, ";
           sql+=" a.vipno,b.cus_name,b.phone+' '+b.sj phone,b.id_card,b.section ";
	   sql+="  from tb_chengyi a left join customer b";
	   sql+="  on a.serialNo = b.serialNo ";
           sql+=" where a.code = '" + code + "' ";
	     
	
	 ResultSet rs=InsertBean.executeQuery(sql);
	 String cus_name="",id_card="",phone="",section="";
	 
	 
	 String vipno=" ",bldate=" ";
	 
	 
	 if (rs.next()){
       
	    cus_name=rs.getString("cus_name");
		phone=rs.getString("phone");
		id_card=rs.getString("id_card");
		 
		vipno=rs.getString("vipno");
		 section=rs.getString("section");
		bldate=rs.getString("dengji_riqi");
		 
	 }
	 rs.close(); 
	 
	  sql=  " select count(*)+1 num  ";
          sql+="  from tb_chengyi ";
	  sql+=" where jinger>0  and  serialno like '%"+section+"%'";
            rs=InsertBean.executeQuery(sql);
	    String vipnum="0";
            if (rs.next())vipnum=rs.getString("num");
            rs.close();

String tmpDoc = "vipzj.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/zlcrm/jsp/sale/"+tmpDoc;
 
StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
 
sb.append("<bookmark name=\"p1\" value=\""+cus_name+"\"/>");
sb.append("<bookmark name=\"p2\" value=\""+phone+"\"/>");
sb.append("<bookmark name=\"p3\" value=\""+id_card+"\"/>");
 
sb.append("<bookmark name=\"p4\" value=\""+vipno+"\"/>");
sb.append("<bookmark name=\"p5\" value=\""+bldate+"\"/>");
sb.append("<bookmark name=\"p6\" value=\""+vipnum+"\"/>");  

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
    