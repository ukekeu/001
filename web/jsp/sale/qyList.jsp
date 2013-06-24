 
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 

<html>
<head>
	<title>签约明细表</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body>
 <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel">

 </div>
 <%  String SQL="";
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SecNo=China.getParameter(request,"SecNo") ;
   ResultSet rs=null;
  ResultSet rs1=null;
   ResultSet rs2=null;
 
   SQL="SELECT a.code,a.sectionname,a.yong_tu,a.loft+a.room_no roomno,b.cus_name,b.sj+' '+b.phone phone ,b.address,a.ID_Card,a.jzarea,a.unitprice,CONVERT(char(10),a.date,120) date,CONVERT(char(10),a.visadate,120) visadate ,a.subscription dj,CONVERT(char(10), DATEADD(dd,";
   SQL+="a.ajtxdate,a.VisaDate), 120) ajdate,a.ajmoney,a.AjBk,a.seller,a.rmbprice-a.subscription kk,a.rmbprice ,a.code FROM order_contract a ,customer b WHERE a.customer=b.serialno and  a.state=2 and convert(char(10),a.date,120)>='"+stdate+"' and convert(char(10),a.date,120)<='"+endate+"' and a.section='"+SecNo+"'   order by a.loft+a.room_no";
       rs1=ViewBean1.executeQuery(SQL);
  %>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="100">
  <tr>
    <td width="4%" rowspan="2" height="32">序号</td>
    <td width="4%" rowspan="2" height="32">签约日期</td>
    <td width="4%" height="31" rowspan="2">客户姓名</td>
    <td width="4%" height="31" rowspan="2">栋号</td>
    <td width="4%" height="31" rowspan="2">房号</td>
    <td width="4%" height="31" rowspan="2">面积</td>
    <td width="4%" height="31" rowspan="2">单价</td>
    <td width="4%" height="31" rowspan="2">总价</td>
    <td width="4%" height="31" rowspan="2">付款方式</td>
    <td width="20%" height="15" colspan="6">首付款</td>
    <td width="4%" height="31" rowspan="2">尾款</td>
    <td width="4%" height="31" rowspan="2">联系电话</td>
    <td width="4%" height="31" rowspan="2">联系地址</td>
    <td width="4%" height="31" rowspan="2">身份证号码</td>
    <td width="8%" height="15" colspan="3">客户生日</td>
    <td width="4%" height="31" rowspan="2">置业顾问</td>
    <td width="5%" height="31" rowspan="2">贷款办理情况</td>
    <td width="5%" height="31" rowspan="2">按揭银行</td>
    <td width="5%" height="31" rowspan="2">认购日期</td>
	   <td width="5%" height="31" rowspan="2">备注</td>
  </tr>
  <tr>
    <td width="4%" height="16">日期</td>
    <td width="4%" height="16">第一笔</td>
    <td width="4%" height="16">日期</td>
    <td width="4%" height="16">第二笔</td>
    <td width="4%" height="16">日期</td>
    <td width="4%" height="16">第三笔</td>
    <td width="4%" height="16">产权人</td>
    <td width="4%" height="16">共有人</td>
	 <td width="4%" height="16">共有人</td>
  </tr>
  <%
     int ii=0;
    while (rs1.next()){
      ii++;
   %>
  <tr>
    <td width="4%" height="16"><%=ii %></td>
    <td width="4%" height="16"><%=rs1.getString("visadate") %></td>
    <td width="4%" height="16"><%=rs1.getString("cus_name") %></td>
    <td width="4%" height="16"><%=rs1.getString("roomno") %></td>
    <td width="4%" height="16"><%=rs1.getString("roomno") %></td>
    <td width="4%" height="16"><%=rs1.getString("jzarea") %></td>
    <td width="4%" height="16"><%=rs1.getString("unitprice") %></td>
    <td width="4%" height="16"><%=rs1.getString("rmbprice") %></td>
    <td width="4%" height="16"><%=rs1.getString("payment1") %></td>
	<%
	//   convert(char(10),shouldDate,120)>='"+stdate+"' and convert(char(10),shouldDate,120)<='"+endate+"' and
	SQL="SELECT shouldDate,shouldMoney FROM GatheringRecord where   contactno = " +rs1.getString("code");
	 rs2=ViewBean2.executeQuery(SQL);
	 double yjsk=0;
	 int num=0;
	    while (rs2.next()){
		num++;
		yjsk+=rs2.getDouble("shouldMoney");
		if (num==1 )price1+=rs2.getDouble("shouldMoney");
		else if (num==2 )price2+=rs2.getDouble("shouldMoney");
		else if (num==3 )price3+=rs2.getDouble("shouldMoney");
		%>
		 <td width="4%" height="16"><%=rs2.getDate("shouldDate").toString() %></td>
    <td width="5%" height="16"><%=FormtD.getFloat2(rs2.getDouble("shouldMoney"),2)  %></td>
		<%
		}
		rs2.close();
	for (int aaa=num;aaa<3;aaa++){
	// if (num<3){	 %>   
    <td width="5%" height="16"></td>
    <td width="5%" height="16"></td>
	<%} 
	
	String ID_Card= rs1.getString("ID_Card");
	
	
	%>
    
   
    
    <td width="4%" height="16"><%=rs1.getString("ajmoney") %></td>
    <td width="4%" height="16"><%=rs1.getString("phone") %></td>
    <td width="4%" height="16"><%=rs1.getString("address") %></td>
    <td width="4%" height="16"><%=ID_Card%></td>
	<%String sr1="",sr2="",sr3="";
	if (ID_Card.indexOf("/")>=0){
	  sr1=ID_Card.substring(0,ID_Card.indexOf("/"));
	  ID_Card=ID_Card.substring(ID_Card.indexOf("/")+1);
	  }
	 if (ID_Card.indexOf("/")>=0){
	  sr2=ID_Card.substring(0,ID_Card.indexOf("/"));
	  ID_Card=ID_Card.substring(ID_Card.indexOf("/")+1);
	  }
	 if (ID_Card.indexOf("/")<0&&!sr2.equals("")){  
	 sr3=ID_Card;
	 }else  if (ID_Card.indexOf("/")<0&&!sr1.equals("")){  
	  sr2=ID_Card;
	 }
	 if (sr2.equals("")&&sr3.equals(""))
	 { sr1=ID_Card;}
	 if (!sr1.equals("")&&sr1.length==18)
	   sr1=sr1.substring(8,14);
	 else  if (!sr1.equals("")&&sr1.length==15)   
	     sr1=sr1.substring(6,12);
		 
	  if (!sr2.equals("")&&sr2.length==18)
	   sr2=sr2.substring(8,14);
	 else  if (!sr2.equals("")&&sr2.length==15)   
	     sr2=sr2.substring(6,12);   
	 if (!sr3.equals("")&&sr3.length==18)
	   sr3=sr3.substring(8,14);
	 else  if (!sr3.equals("")&&sr3.length==15)   
	     sr3=sr3.substring(6,12);      
	 %>
    <td width="4%" height="16"><%=sr1 %></td>
    <td width="4%" height="16"><%=sr2 %></td>
    <td width="5%" height="16"><%=sr3 %></td>
	
    <td width="5%" height="16"><%=rs1.getString("seller")  %></td>
	
    <td width="5%" height="16"><%=sr3 %></td>
    <td width="5%" height="16"><%=rs1.getString("ajbk") %></td>
    <td width="5%" height="16"><%=rs1.getString("date") %></td>
	<td width="5%" height="16"></td>
  </tr>
  <%}
  rs1.close();
  
   %>
</table>



</body>
</html>
