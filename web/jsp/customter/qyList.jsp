 
<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 

<html>
<head>
	<title>客户台帐明细表</title>
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
  String SecNo=China.getParameter(request,"section") ;
  String job=(String)session.getAttribute("job");	
  String datetype=China.getParameter(request,"datetype") ;
  String payment=China.getParameter(request,"payment") ;
	 if (job.indexOf("销售员")>=0){
	    job=" and a.seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }else{job="";}
	 if (!payment.equals("")){
	    payment=" and a.payment like '%"+payment+"%'";
	 }else{payment="";}
	if (datetype.equals("1")) {
	   datetype="  and convert(char(10),a.date,120)>='"+stdate+"' and convert(char(10),a.date,120)<='"+endate+"'";
	
	}else if (datetype.equals("3")) {
	
	  datetype="  and convert(char(10),a.VisaDate,120)>='"+stdate+"' and convert(char(10),a.VisaDate,120)<='"+endate+"'";
	
	}else if (datetype.equals("2")) {
	
	  datetype="  and convert(char(10),b.csdate,120)>='"+stdate+"' and convert(char(10),b.csdate,120)<='"+endate+"'";
	
	}
   ResultSet rs=null;
  ResultSet rs1=null;
   ResultSet rs2=null;
 String sectionname="";
   List list1=new LinkedList();//存产权共有人姓名
	      List list2=new LinkedList();//存放合同号
          SQL="SELECT * FROM  cq_gyrqk WHERE htno in (select code from order_contract a where a.state=2 "+datetype+payment+" and section='"+SecNo+"')";
  	       rs1 = ViewBean.executeQuery(SQL);
		while (rs1.next()){
		     list1.add(rs1.getString("cusname"));
		     list2.add(rs1.getString("htno"));
		
		  		}
		rs1.close();  
   SQL="SELECT a.code,a.sectionname,a.payment1,a.loft,a.room_no roomno,b.cus_name,b.sj+' '+b.phone phone,CONVERT(char(10),b.csdate,120) csdate ,b.address,b.ID_Card,a.jzarea,a.unitprice,CONVERT(char(10),a.date,120) date,CONVERT(char(10),a.visadate,120) visadate ,a.subscription dj,CONVERT(char(10), DATEADD(dd,";
   SQL+="a.ajtxdate,a.VisaDate), 120) ajdate,a.ajmoney,a.AjBk,CONVERT(char(10),a.ajdate,120) ajdate,a.seller,a.rmbprice-a.subscription kk,a.rmbprice ,a.code FROM order_contract a ,customer b WHERE a.customer=b.serialno and  a.state<>3  "+datetype+payment+" and a.section='"+SecNo+"' "+job+"   order by a.loft+a.room_no";
    rs1=ViewBean1.executeQuery(SQL);
 
  %>
  <div align=left id=report1  >
  <p align="center"><font size=4><b>客户台帐明细表</b></font> </p>
  <table border="0" cellpadding="0" cellspacing="0"  width="99%"  >
  <tr >
  <td align="left" width="49%"><div id=w1></div></td>  <td align="right" width="49%"><div id=w2></div></td>
  </tr>
  </table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="180%" id="AutoNumber1" height="100%">
  <tr align="center">
    <td  rowspan="2" height="32">序号</td>
	<td  height="31" rowspan="2">认购日期</td>
    <td  rowspan="2" height="32">签约日期</td>
    <td  height="31" rowspan="2">客户姓名</td>
    <td  height="31" rowspan="2">栋号</td>
    <td  height="31" rowspan="2">房号</td>
    <td  height="31" rowspan="2">面积</td>
    <td  height="31" rowspan="2">单价</td>
    <td  height="31" rowspan="2">总价</td>
    <td  height="31" rowspan="2">付款方式</td>
    <td width="20%" height="15" colspan="8">应付首期款</td>
    <td  height="31" rowspan="2">尾款</td>
    <td  height="31" rowspan="2">联系电话</td>
    <td  height="31" rowspan="2">联系地址</td>
    <td  height="31" rowspan="2">身份证号码</td>
	  <td  height="31" rowspan="2">出生日期</td>
    <td  height="15" colspan="2">产权情况</td>
    <td  height="31" rowspan="2">置业顾问</td>
    <td  height="31" rowspan="2">贷款办理情况</td>
    <td  height="31" rowspan="2">按揭银行</td>
    
	   <td  height="31" rowspan="2">备注</td>
  </tr>
  <tr  align="center">
    <td  height="16">日期</td>
    <td  height="16">定金</td>
    <td  height="16">日期</td>
    <td  height="16">第一笔</td>
    <td  height="16">日期</td>
    <td  height="16">第二笔</td>
    <td  height="16">日期</td>
    <td  height="16">第三笔</td>
   
    <td  height="16">共有人</td>
	 <td  height="16">共有人</td>
  </tr>
  <%
     int ii=0;
    while (rs1.next()){
	  sectionname=getbyte(rs1.getString("sectionname"));
      ii++;
   %>
  <tr  align="center">
    <td  height="16"><%=ii %></td>
	 <td  height="16"><%=rs1.getString("date") %></td>
    <td  height="16"><%=getbyte(rs1.getString("visadate")) %></td>
    <td  height="16"><%=rs1.getString("cus_name") %></td>
    <td  height="16"><%=rs1.getString("loft") %></td>
    <td  height="16"><%=rs1.getString("roomno") %></td>
    <td  height="16"><%=rs1.getString("jzarea") %></td>
    <td  height="16"><%=rs1.getString("unitprice") %></td>
    <td  height="16"><%=rs1.getString("rmbprice") %></td>
    <td  height="16"><%=rs1.getString("payment1") %></td>
	<%
	//   convert(char(10),shouldDate,120)>='"+stdate+"' and convert(char(10),shouldDate,120)<='"+endate+"' and
	SQL="SELECT top 4 shouldDate,shouldMoney,state FROM GatheringRecord where  shouldQS<5 and  contactno = " +rs1.getString("code") +" order by shouldDate";
	 rs2=ViewBean2.executeQuery(SQL);
	 double yjsk=0;
	 int num=0;
	    while (rs2.next()){
		num++;
		yjsk+=rs2.getDouble("shouldMoney");
		 
		%>
		 <td  height="16"><%=rs2.getDate("shouldDate").toString() %></td>
    <td  height="16"><%=FormtD.getFloat2(rs2.getDouble("shouldMoney"),2)  %>
	<%if (rs2.getInt("state")==2) %><font color=red>√</font>
	</td>
		<%
		}
		rs2.close();
	for (int aaa=num;aaa<4;aaa++){
	// if (num<3){	 %>   
    <td  height="16"></td>
    <td  height="16"></td>
	<%} 
	
	String ID_Card= rs1.getString("ID_Card");
	
	
	%>
    
   
    
    <td  height="16"><%=rs1.getString("ajmoney") %></td>
    <td  height="16"><%=rs1.getString("phone") %></td>
    <td  height="16"><%=rs1.getString("address") %></td>
    <td  height="16"><%=ID_Card%></td>
	    <td  height="16"><%=getbyte(rs1.getString("csdate")) %></td>
	<%String sr1="",sr2="",sr3="";
	 String code=rs1.getString("code");
	 String codeValue="";
	  if (list2.contains(code)){
		   int index=list2.indexOf(code);
		   sr1=(String)list1.get(index);
		   codeValue=(String)list2.get(index+1);
		    if (codeValue.equals(code)){
			 sr2=(String)list1.get(index+1);
			
			}
		}
 
		       
	String ajdate=getbyte(rs1.getString("ajdate") );	
	if (!ajdate.equals(""))	 ajdate="已办理("+ajdate+")";  
	 %>
    <td  height="16"><%=sr1 %></td>
    <td  height="16"><%=sr2 %></td>
  
	
    <td  height="16"><%=rs1.getString("seller")  %></td>
	
    <td  height="16"><%=ajdate %></td>
    <td  height="16"><%=rs1.getString("ajbk") %></td>
   
	<td  height="16"></td>
  </tr>
  <%}
  rs1.close();
  
   %>
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
  
<script>

w1.innerHTML="楼盘名称：<%=sectionname %>      ";

w2.innerHTML="日期范围：<%=stdate %>--<%=endate %>      ";

</script>

</body>
</html>
