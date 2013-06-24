<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<html>
<head>
	<title>认购统计表</title>　
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<body>
<%  double a1=0,a2=0,a3=0,a4=0,a5=0,a6=0,a7=0,a8=0,a9=0;
    String stdate = China.getParameter(request,"Date1") ;
    String endate = China.getParameter(request,"Date2") ;
    String SectionName=China.getParameter(request,"SecNo") ; 
    SectionName=SectionName.substring(0,SectionName.indexOf("|"));
	String yong_tu=China.getParameter(request,"yont_tu") ; 
    if (!yong_tu.equals(""))yong_tu="   a.yong_tu='"+yong_tu+"' and ";
  %>
  <DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel"> 
  <br>如果导出不成功，可能是你的IE有问题，请用"Ctrl+a"后再复制到EXCEL中
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <div valign=top id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

 <p align="center"><%=SectionName %>楼盘销售收入明细表</p>
时段:<%=stdate %>	到<%=endate %>   
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr align="center">
    <td width="6%" rowspan="2">序号</td>
    <td width="6%" rowspan="2">户名</td>
    <td width="6%" rowspan="2">房号</td>
	<td width="6%" rowspan="2">建筑面积</td>
	<td width="6%" rowspan="2">建筑单价</td>
	<td width="6%" rowspan="2">套内面积</td>
	<td width="6%" rowspan="2">套内单价</td>
	<td width="6%" rowspan="2">原价合计</td>
    <td width="12%" colspan="2">正常折扣</td>
	<td width="12%" colspan="2">额外折扣</td>
    <td width="6%" rowspan="2">折后价应交合计</td>
    <td width="24%" colspan="4">实际收款</td>
    <td width="19%" colspan="3">认购方式(首期款%)</td>
    <td width="7%" rowspan="2">实际收款合计</td>
   
	    <td width="7%" rowspan="2">累计收到款</td>
		 <td width="7%" rowspan="2">应收未收款差额</td>
    <td width="7%" rowspan="2">认购日期</td>
  </tr>
  <tr>
    <td width="6%">一次性</td>
    <td width="6%">按揭</td>
	 <td width="6%">一次性</td>
    <td width="6%">按揭</td>
    <td width="6%">定金</td>
    <td width="6%">首期款</td>
    <td width="6%">按揭放款</td>
    <td width="6%">一次性余款</td>
    <td width="6%">首期百分比%</td>
    <td width="6%">一次性</td>
    <td width="7%">按揭款</td>
  </tr>
  <%
  
 


  String Loft=getbyte1(request.getParameter("Loft"));
   String sql=""; 
   sql="select    a.*,b.cus_name,c.area,c.room_price from order_contract a,customer b,room c where c.seccode+c.loft+c.room_code=a.section+a.loft+a.room_no and "+ yong_tu+" a.customer=b.serialno and a.state<>3 and a.section='"+SectionName+"' ";//convert(char(10),date,120)>='"+stdate+"' and convert(char(10),date,120)<='"+endate+"' and 
    if (!Loft.equals(""))
	  sql+=" and a.loft='"+Loft+"' ";
	  
  sql+=" order by a.loft,floors,room_no";
  ResultSet rs=null;
	   ResultSet rs1=null;
		// out.print(sql);
	rs=ViewBean.executeQuery(sql);
	 double aaaa=0;
	 double bbbb=0;
	 double cccc=0;
	 double dddd=0;
	 double gggg=0;
	  double eeee=0;
	   double sjlj=0;
	 double factj=0;
	int i=0;
 
   while (rs.next()){
	 i++;
	 a7+=rs.getDouble("room_price");
	 gggg+=rs.getDouble("area");
	  eeee+=rs.getDouble("jzarea");
   %>
  <tr>
    <td width="6%"><%=i %></td>
    <td width="6%"><%=rs.getString("cus_name") %></td>
    <td width="6%"><%=rs.getString("loft")+rs.getString("room_no") %></td>
	 <td width="7%"><%=rs.getString("jzarea") %></td>
    <td width="7%"><%=rs.getString("unitprice") %></td>
	 <td width="7%"><%=rs.getString("area") %></td>
    <td width="7%"><%=rs.getString("tnunitprice") %></td>
    <td width="7%"><%=rs.getString("room_price") %></td>
	<%String pay=rs.getString("payment") ; 
	if (pay.indexOf("一次")>=0){
	%>
    <td width="6%"><%=rs.getString("DISC") %><%String ewdisc=rs.getString("ewdisc");if (!ewdisc.equals("0")){out.print("*"+ewdisc);} %></td>
    <%}else{ %>
	 <td width="6%">&nbsp;</td>
	<%} 
	if (pay.indexOf("按揭")>=0){%>
	 <td width="6%"><%=rs.getString("DISC") %><%String ewdisc=rs.getString("ewdisc");if (!ewdisc.equals("0")){out.print("*"+ewdisc);} %></td>
  <%}else{ %>
   <td width="6%">&nbsp;</td>
   <%} 
   sql=" SELECT * FROM  contract_disc  WHERE  disc_type<>'正常折扣'  and   order_no='"+SectionName+rs.getString("loft")+rs.getString("room_no")+"'";
  String yy="";
  
   
  rs1 = ViewBean1.executeQuery( sql ) ;
   
    while (rs1.next()){
			    String dis=rs1.getString("disc");
				float yh1=rs1.getFloat("youhui");
			    String obj=rs1.getString("discObj");
				 if (yh1==0)yy+=" 按"+obj+rs1.getString("disc")+"折";
				 else yy+=" 按"+obj+"优惠"+rs1.getString("youhui")+"元";
				 
	}rs1.close();
	if (pay.indexOf("一次")>=0){
	%>
    <td width="6%"><%=yy %></td>
    <%}else{ %>
	 <td width="6%">&nbsp;</td>
	<%} 
	if (pay.indexOf("按揭")>=0){%>
	 <td width="6%"><%=yy%></td>
  <%}else{ %>
   <td width="6%">&nbsp;</td>
   <%} 
   a1+=rs.getDouble("rmbprice");
   
  String sq = " select ";
	
	sq+="sum(CurrRate*factmoney) ff from factGatheringRecord where  convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and    period=0 and contractno = " +rs.getString("code");
    double subscription1=0;
      rs1 = ViewBean1.executeQuery( sq ) ;	 
	  if (rs1.next()){
	    subscription1=rs1.getDouble("ff");
        a2+=rs1.getDouble("ff");
	  }rs1.close();
   %>
	<td width="6%"><%=rs.getString("rmbprice") %></td>
    <td width="6%"><%=FormtD.getFloat2(subscription1,2) %></td>
	<%sq = " select ";
	
	sq+="sum(CurrRate*factmoney) ff from factGatheringRecord where   convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and    period<>0 and contractno = " +rs.getString("code");
           
      rs1 = ViewBean1.executeQuery( sq ) ;
	  double yj=0;
	    double yk=0;
	  if (rs1.next()){
	    yj=rs1.getDouble("ff");
	  }
 
	  a3+=yj;
	  rs1.close();
	 
	 sq = " select sum(factmonye) ff from FactAjCharges where    contractno="+rs.getString("code"); 
	
	         
      rs1 = ViewBean1.executeQuery( sq ) ;
	   double ljaj=0;
	  if (rs1.next()){
	    ljaj=rs1.getDouble("ff");
		 
	  }
	 
	 sq = " select sum(factmonye) ff from FactAjCharges where  convert(char(10),factdate,120)>='"+stdate+"' and convert(char(10),factdate,120)<='"+endate+"' and   contractno="+rs.getString("code"); 
	
	         
      rs1 = ViewBean1.executeQuery( sq ) ;
	   double aj=0;
	  if (rs1.next()){
	    aj=rs1.getDouble("ff");
		bbbb+=aj;
	  }
	   a4+=aj;
	  rs1.close();
	 
	  int ajk=rs.getInt("ajmoney");
	   a5+=ajk;
	    yk=rs.getDouble("rmbprice")-yj-aj-subscription1;
	   a6+=yk;
	   %>
	 
    <td width="6%"><%=yj %></td>
	<%if (pay.indexOf("按揭")>=0){ %>
	 <td width="6%"><%=aj %></td>
	 <%}else{ %>
	  <td width="6%">&nbsp;</td>
	 <%} %>
	 <%if (pay.indexOf("按揭")<0){  dddd+=yk;%>
	 <td width="6%"><%=yk %></td>
	 <%}else{ %>
	  <td width="6%">&nbsp;</td>
	 <%} %>
 <%aaaa+=  yj+aj+subscription1;
 

  %>	  <td width="6%"><%=FormtD.getFloat2((rs.getDouble("rmbprice")-ajk)/rs.getDouble("rmbprice")*100,2) %> %</td>
       <td width="6%"><%=rs.getDouble("rmbprice")-yj-ajk-rs.getDouble("subscription") %> </td>
    <td width="6%"><%=ajk %></td>
	<%String sqlF="select sum(CurrRate*factmoney) ff from  factGatheringRecord where    convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and   contractno = " +rs.getString("code");
	 rs1 = ViewBean1.executeQuery( sqlF ) ;
	 double factmoney=0;
	 if (rs1.next()){
	    factmoney=rs1.getDouble("ff")+aj;;
	}
	factj+=factmoney;
	
	sqlF="select sum(CurrRate*factmoney) ff from  factGatheringRecord where      contractno = " +rs.getString("code");
	 rs1 = ViewBean1.executeQuery( sqlF ) ;
	 double ljfactmoney=0;
	 if (rs1.next()){
	    ljfactmoney=rs1.getDouble("ff")+aj;;
	}
	cccc+=rs.getDouble("rmbprice")- yj-ajk-subscription1;
 sjlj+=ljfactmoney+ljaj;
	%>  
    <td width="6%"><%=factmoney %> </td>
	    <td width="6%"><%= ljfactmoney+ljaj%></td>
    <td width="6%"><%= rs.getDouble("rmbprice")-ljfactmoney-ljaj%></td>
    <td width="7%"><%=rs.getDate("date").toString() %></td>
    </tr><%};
  rs.close(); %>
  <tr><td colspan="3">合计</td>
   <td>&nbsp;<%=FormtD.getFloat2(eeee,2) %></td> <td>&nbsp;</td>
  <td>&nbsp;<%=FormtD.getFloat2(gggg,2) %></td>  <td>&nbsp;</td>
   <td>&nbsp;<%=FormtD.getFloat2(a7,2) %></td>
    <td>&nbsp;</td>
	 <td>&nbsp;</td> <td>&nbsp;</td>
	 <td>&nbsp;</td> 
	    <td><%=FormtD.getFloat2(a1,2) %></td>
		    <td><%=FormtD.getFloat2(a2,2) %></td>
			 <td><%=FormtD.getFloat2(a3,2) %></td>
			  <td><%=FormtD.getFloat2(a4,2) %></td>
			    <td><%=FormtD.getFloat2(dddd,2) %></td>
				 <td><%=FormtD.getFloat2((a3+a2)/a1*100,2) %>%</td>
				 <td><%=FormtD.getFloat2(cccc,2) %></td>
				 <td><%=FormtD.getFloat2(a5,2) %></td>
				  <td><%=FormtD.getFloat2(factj,2) %></td>
				  <td> <%=sjlj %></td>
				    <td><%=FormtD.getFloat2(a6,2) %></td>
	  </tr>
</table>


 </div>
 
<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
     var selectArea=document.body.createTextRange(); //创建文本区域 
        selectArea.moveToElementText(report1);//将文本区域聚焦到printData 
        selectArea.select();//选中printData 
        selectArea.execCommand("Copy");//将printData复制到剪切板中 
         oSheet.Paste();//将剪切板中的数据复制到Excel中      
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>


</body>
</html>
