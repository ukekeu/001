<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>收款情况记录表</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		String name="";
		 if (SecNo1.indexOf("-")>=0){name=SecNo1.substring(SecNo1.indexOf("-")+1);SecNo1=SecNo1.substring(0,SecNo1.indexOf("-"));}
			String Loft=China.getParameter(request,"Loft");
		 %>
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
 </div>
 
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

 
 <div id=titlestr><p align=center class=FontColor><font size=3><b><%=name %>收款情况记录表</b></font></p></div>
  收款时段:<%=dates %>到<%=dates1 %>
 
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr>
    <td width="5%" rowspan="2" align="center">序号</td>
    <td width="5%" rowspan="2" align="center">房号</td>
    <td width="6%" rowspan="2" align="center">客户姓名</td>
    <td width="6%" rowspan="2" align="center">联系电话</td>
    <td width="6%" rowspan="2" align="center">签定合同时间</td>
    <td width="6%" rowspan="2" align="center">收取定金时间</td>
    <td width="6%" rowspan="2" align="center">付款方式</td>
	 <td width="6%" rowspan="2" align="center">总房款</td>
    <td width="6%" rowspan="2" align="center">应收日期</td>
    <td width="18%" colspan="3" align="center">应收款项</td>
    <td width="18%" colspan="3" align="center">已收款项</td>
    <td width="18%" colspan="3" align="center">欠收款项</td>
  </tr>
  <tr>
    <td width="6%" align="center">首期款</td>
    <td width="6%" align="center">配套费</td>
    <td width="6%" align="center">合计</td>
    <td width="6%" align="center">首期款</td>
    <td width="6%" align="center">配套费</td>
    <td width="6%" align="center">合计</td>
    <td width="6%" align="center">首期款</td>
    <td width="6%" align="center">配套费</td>
    <td width="6%" align="center">合计</td>
  </tr>
  
 <%String pay_SQL="select payment1 from order_contract where";
 
    if (!SecNo1.equals(""))
		 
		   pay_SQL+="   section='"+SecNo1+"'";
		 if (!Loft.equals(""))
		   pay_SQL+=" and Loft='"+Loft+"' " ;
		   pay_SQL+="group by  payment1" ;
		  ResultSet rs2=ViewBean2.executeQuery(pay_SQL);
		  while (rs2.next()){
		    String payment= rs2.getString("payment1");
		  
  %> 
<tr><td colspan="20"><%=payment %></td></tr>
  
  
 
<%       double s_yssq=0;
		 double s_sssq=0;
		 double s_ssajk=0;
	     String whereSQL="";
		 String sectionName="";
		  
		  double a1=0,a2=0,a3=0,a4=0,a5=0,a6=0,a7=0,a8=0,a9=0,a10=0;
		try{    
		 
		// 
		  String SQL="SELECT a.sectionname,a.code,a.loft,a.ContractNo,convert(char(10),a.date,120) date,convert(char(10),a.jldate,120) jldate,convert(char(10),a.VisaDate,120) VisaDate,b.cus_name,b.sj+' '+b.phone tel, a.room_no,a.jzarea,a.y_jzarea,a.maap_state,a.cj_f,a.unitprice ";
		   SQL+=",a.rmbprice  hj,a.rmbprice -a.ajmoney sqk,a.payment1 from order_contract a,customer b where a.state<>3 and a.customer=b.serialno and a.payment1= '"+payment+"'";
         if (!SecNo1.equals(""))
		 
		  SQL+=" and a.section='"+SecNo1+"'";
		 if (!Loft.equals(""))
		  SQL+=" and a.Loft='"+Loft+"' " ;
		 // SQL+=" and a.date>='"+dates+"' and a.date<='"+dates1+"'";
		  SQL+="   order by  a.section+a.loft+a.room_no ";
	 ResultSet rs=ViewBean.executeQuery(SQL);
	 
		   int ii=0;
		  while (rs.next()){
		 
			   ii++;
			   ResultSet rs1=null;
			   String sql="";
			    double yssq=0;
				double sssq=0;
				double ssdj=0;
				double s_ssdj=0;
				double ssajk=0;
				double sqk=0;
				sectionName=rs.getString("sectionname");
		       String code=rs.getString("code");
			   String Loft1=rs.getString("Loft"); 	
				String ContractNo=rs.getString("ContractNo");	  
				String date=rs.getString("date");	  
				String jldate=rs.getString("jldate");	
				String VisaDate=getbyte(rs.getString("VisaDate"));	
				String cus_name=rs.getString("cus_name");
				String tel=rs.getString("tel");		
				String roomno=rs.getString("room_no");	
				double jzarea=rs.getDouble("jzarea");	
				double y_jzarea=rs.getDouble("y_jzarea");	
				double cj_f=rs.getDouble("cj_f");	
				String unitprice=rs.getString("unitprice");	
				double rmbprice=rs.getDouble("hj");	
				sqk=rs.getDouble("sqk");	
				String payment1=rs.getString("payment1");	
				String fk_date="";
				
				
				     sql="select  sum(taxmoney) money  from GatheringTaxRecord where ";
				     sql+="   contactno ="+code;
				  
				  double ystaopei=0;
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款
				 while (rs1.next())ystaopei=rs1.getDouble("money");
				 rs1.close();
				 
				     sql="select  sum(money) money  from factGatheringTaxRecord where ";
				     sql+="   contractno ="+code;
				  
				  double sstaopei=0;
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款
				 while (rs1.next())sstaopei=rs1.getDouble("money");
				 rs1.close();
				
			    sql="select f.FactMonye money,factdate from FactAjCharges f";
				sql+=" where  contractno in (select code from order_contract where  state=2 and  code="+code+")";
				  sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取按按揭款
				  while (rs1.next()){ssajk+=rs1.getDouble("money");fk_date=rs1.getDate("factdate").toString();}
				 rs1.close();
				 s_ssajk+=ssajk;
				 
				 sql="select Gather_Date from factGatheringRecord f";
				 sql+=" where f.Period in(0) ";
				 sql+=" and contractno ="+code;
				   sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				 String Gather_Date="";
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到定金时间
				 if (rs1.next())Gather_Date=rs1.getDate("Gather_Date").toString();
				 rs1.close();
				   
				 sql="select shouldDate from GatheringRecord f";
				 sql+=" where f.shouldQS in(1) ";
				 sql+=" and contactno ="+code;
				   sql+=" and  convert(char(10),f.shouldDate,120)>='"+dates+"' and  convert(char(10),f.shouldDate,120)<='"+dates1+"'";
				 String shouldDate="";
				  rs1=ViewBean1.executeQuery(sql);//读取应收到首期时间
				 if (rs1.next())shouldDate=rs1.getDate("shouldDate").toString();
				 rs1.close();
				 
				  sql="select  f.factmoney*f.currrate  money,gather_date from factGatheringRecord f";
				 sql+=" where f.Period in(1,2,3,4,8,12,13) ";
				  sql+=" and contractno ="+code; 
				   sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款
				  String sf_date="";
				 while (rs1.next()){sssq+=rs1.getDouble("money");if (!sf_date.equals(""))sf_date=rs1.getDate("gather_date").toString();}
				 rs1.close();
				 s_sssq+=sssq;
				 
				 double fp_money=0;
				 
				   
				   
				    sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in (0,1,2,3,4,8,12,13) ";
				 sql+=" and contractno ="+code;
				  sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  double qqqq=0;
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款
				 while (rs1.next())qqqq+=rs1.getDouble("money");
				 rs1.close();
				 
				 if (sqk-qqqq+(ystaopei-sstaopei)!=0){
				 a9+=sqk-qqqq+(ystaopei-sstaopei);
				 a8+=ystaopei-sstaopei;
				 a7+=sqk-qqqq;
				 a6+=sstaopei+ssajk+qqqq;
				 a5+=sstaopei;
				 a4+=ssajk+qqqq;
				 a3+=ystaopei+sqk;
				 a2+=ystaopei;
				 a1+=rmbprice;
				
				 a10+=sqk;
				  %>
				  
  <tr  align="center">
    <td width="5%" align="center"><%=ii %></td>
    <td width="5%" align="center"><%=Loft1 +roomno%></td>
    <td width="6%" align="center"><%=cus_name %></td>
    <td width="6%" align="center"><%=tel %></td>
    <td width="6%" align="center"><%=VisaDate %></td>
    <td width="6%" align="center"><%=Gather_Date %></td>
    <td width="6%" align="center"><%=payment1 %></td>
	  <td width="6%" align="center"><%=FormatD.getFloat2(rmbprice,2) %></td>
    <td width="6%" align="center"><%=shouldDate %></td>
    <td width="6%" align="center"><%=FormatD.getFloat2(sqk,2) %></td>
    <td width="6%" align="center"><%=FormatD.getFloat2(ystaopei,2) %></td>
    <td width="6%" align="center"><%=FormatD.getFloat2(ystaopei+sqk ,2)%></td>
    <td width="6%" align="center"><%=FormatD.getFloat2(ssajk+qqqq,2) %></td>
    <td width="6%" align="center"><%=FormatD.getFloat2(sstaopei,2) %></td>
	 <td width="6%" align="center"><%=FormatD.getFloat2(sstaopei+ssajk+qqqq,2) %></td>
    <td width="6%" align="center"><%= FormatD.getFloat2(sqk-qqqq,2)%></td>
    <td width="6%" align="center"><%= FormatD.getFloat2(ystaopei-sstaopei,2)%></td>

    <td width="6%" align="center"><%= FormatD.getFloat2(sqk-qqqq+(ystaopei-sstaopei),2)%></td>
  </tr>
   

				  <%
				  }
		     }rs.close();
				  
		}catch(Exception s){out.print(s);}
		if (a9>0){
 %>
<tr>
    <td width="5%">合计</td>
    <td width="5%">　</td>
    <td width="6%">　</td>
    <td width="6%">　</td>
    <td width="6%">　</td>
    <td width="6%">　</td>
    <td width="6%">　</td>
	   <td width="6%"><%= FormatD.getFloat2(a1,2) %></td>
    <td width="6%">　</td>
 
	  <td width="6%"><%= FormatD.getFloat2(a10,2) %></td>
    <td width="6%"><%= FormatD.getFloat2(a2,2) %></td>
    <td width="6%"><%= FormatD.getFloat2(a3,2) %></td>
    <td width="6%"><%= FormatD.getFloat2(a4,2) %></td>
    <td width="6%"><%= FormatD.getFloat2(a5,2) %></td>
    <td width="6%"><%= FormatD.getFloat2(a6,2) %></td>
    <td width="6%"><%= FormatD.getFloat2(a7,2) %></td>
    <td width="6%"><%= FormatD.getFloat2(a8,2) %></td>
    <td width="6%"><%= FormatD.getFloat2(a9,2) %></td>
  </tr>
  
  <% }
  }
   rs2.close(); %>
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
