<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>收款日报</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		 String okcheckstate=China.getParameter(request,"checkstate");
			String Loft=China.getParameter(request,"Loft");
		 %>
		 
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
 </div>
 
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
<div id=titlestr><p align=center class=FontColor><font size=3><b>收款日报明细表</b></font></p></div>
 
 
 时段:<%=dates %>到<%=dates1 %>
 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1" height="47">
  <tr align="center">
    <td width="4%">序号</td> 
    <td width="4%">姓名</td>
    <td width="4%">房号</td>
    <td width="4%">面积</td>
    <td width="4%">单价</td>
	  <td width="4%">总价</td>
    <td width="4%">摘要</td>
    <td width="4%">收据号</td>
     
    <td width="4%">收据金额</td>
    <td width="4%">定金抵房款</td>
    <td width="4%">签合同</td>
    <td width="4%">付款方式</td> 
	   <td width="4%">备注</td> 
  </tr>
    <%@ include file="../public_js/CheckSection.jsp"%>
		 <%
		  String secName="";
		   int ii=0;
		    double s_yssq=0;
			double s_zj=0;
		 double s_sssq=0;
		 double s_ssajk=0;
	     String whereSQL="";
		 String sectionName="";
		 double xjarea=0,xjprice=0,jjprice=0;
		 double hjarea=0,hjprice=0,hjjjprice=0;
		 int salestate=0;
		 List list1=new LinkedList();//合同CODE
	     List list2=new LinkedList();//原姓名
	     List list3=new LinkedList();//更名日期
	 String ZM="SELECT DISTINCT a.oldname,a.zmdate,b.code from zm_bak a,Order_Contract b where a.newname<>a.oldname and a.htno=b.code and b.section='"+SecNo1+"'";
     ResultSet rs1=ViewBean1.executeQuery(ZM);
      while (rs1.next()){
	 
	     list1.add(rs1.getString("oldname"));
		 list2.add(rs1.getDate("zmdate").toString());
         list3.add(rs1.getString("code"));
     }rs1.close();
 
 
      String Wheresql="select SerialNo,Name from CRM_Project "+FindWhere;
    if (!SecNo1.equals(""))
		  Wheresql+=" and SerialNo='"+SecNo1+"'";
     rs1=ViewBean1.executeQuery(Wheresql);
    while (rs1.next()){
         SecNo1=rs1.getString("SerialNo");
		 secName=rs1.getString("Name");
		 
         xjarea=0;xjprice=0;jjprice=0;
		   
		try{    
		
		
		// 
		  String SQL="SELECT a.code,a.state,a.sectionname,a.code,a.loft+room_no room,a.ContractNo,convert(char(10),a.jldate,120) jldate,convert(char(10),a.VisaDate,120) VisaDate,b.cus_name,a.jzarea,a.y_jzarea,a.cj_f,a.unitprice ";
		   SQL+=",a.rmbprice,c.factmoney,c.Bill_Num,c.PayType,c.period,c.checkstate,c.context jsbak from order_contract a,customer b,factGatheringRecord c where    c.contractno=a.code and a.customer=b.serialno";
         if (!SecNo1.equals(""))
		  SQL+=" and a.section='"+SecNo1+"'";
		 if (!Loft.equals(""))
		  SQL+=" and a.Loft='"+Loft+"' " ;
		 if (okcheckstate.equals("1"))
		   SQL+=" and c.checkstate=1" ;
		 else    if (okcheckstate.equals("2"))
		   SQL+=" and c.checkstate=0" ;
		  SQL+=" and  convert(char(10),gather_date,120)>='"+dates+"' and  convert(char(10),gather_date,120)<='"+dates1+"'";
				
		  SQL+="   order by  a.section+a.loft+a.room_no ";
		  ResultSet rs=ViewBean.executeQuery(SQL);
	      
		
		  while (rs.next()){
		    			   ii++;
				String htcode=rs.getString("code");
				salestate=rs.getInt("state");
			    
			   sectionName=rs.getString("sectionname");
			  double sk=rs.getDouble("factmoney");
			  String period = rs.getString( "period" ) ;
			 
			  if (period.equals("0"))period ="定金";
				else if (period.equals("1")) period ="房款";
				else if (period.equals("2")) period ="房款";
				else if (period.equals("2"))period ="房款";
				else if (period.equals("3"))period ="房款";	
			    else if (period.equals("4"))period ="房款";	
				else if (period.equals("5"))period ="花园/露台款";	
			 	else if (period.equals("6"))period ="改装款";	
				else if (period.equals("7"))period ="滞纳金";				
				else if (period.equals("8"))period ="房款差额";	
				else if (period.equals("9"))period ="改装款差额";	
				else if (period.equals("10"))period ="花园/露台款差额";	
				else if (period.equals("11"))period ="阳台罩差额";	
					else if (period.equals("13"))period ="屋面款";	
				else if (period.equals("15"))period ="附属房产款";	
				int checkstate=rs.getInt("checkstate");
				String jsbak=getbyte(rs.getString("jsbak"));
			  s_sssq+=sk;
			  String oldename="",olddate="";
			  if (list3.contains(htcode)){
			    int index=list3.indexOf(htcode);
		        oldename=(String)list1.get(index);
		       // olddate=(String)list2.get(index);
			 
			  }
			  if (!oldename.equals("")){
			     oldename="(<font color=red>"+oldename+""+olddate+"</font>)";
			  
			  }
				  %>
			 <tr align="center">
			    <td width="1%"><%=ii %></td>
			    <td width="8%"><%=rs.getString("cus_name") +oldename%></td>
			    <td width="4%"><%=rs.getString("room")  %></td>
			    <td width="4%"><%=rs.getString("jzarea") %></td>
			    <td width="4%"><%=rs.getString("unitprice") %></td>
			    <td width="4%"><%=rs.getString("rmbprice") %></td>
			    <td width="4%"><%if (period.equals("8")){out.print("<font code=red>");} %><%=period %><%if (period.equals("8")){out.print("</font>");} %></td>
			    <td width="4%">&nbsp;<%=rs.getString("Bill_Num") %></td>
			    <td width="4%" align="right"><%=sk %></td>
				   <td width="4%"><%=jsbak %></td>
			    <td width="4%"><%=getbyte(rs.getString("VisaDate")) %></td>
			    <td width="4%"><%=rs.getString("PayType") %></td>
			  <td width="4%"><%if (checkstate==1){out.print("已核对");} %><%if (salestate==3){out.print("<font color=red>已退房</font>");} %></td>
        </tr>

				  <%
		     }rs.close();
				  s_zj+=s_sssq;
		}catch(Exception s){out.print(s);}
		
		
		  String SQL="select Distinct a.code ,a.jzarea,a.rmbprice/a.jzarea age,a.rmbprice ";
		   SQL+=" from order_contract a,customer b,factGatheringRecord c where  a.state<>3 and c.contractno=a.code and a.customer=b.serialno";
         if (!SecNo1.equals(""))
		  SQL+=" and a.section='"+SecNo1+"'";
		 if (!Loft.equals(""))
		  SQL+=" and a.Loft='"+Loft+"' " ;
		 if (okcheckstate.equals("1"))
		   SQL+=" and c.checkstate=1" ;
		 else    if (okcheckstate.equals("2"))
		   SQL+=" and c.checkstate=0" ;
		  SQL+=" and  convert(char(10),gather_date,120)>='"+dates+"' and  convert(char(10),gather_date,120)<='"+dates1+"'";
				
		   SQL+="  " ;
		    ResultSet rs=ViewBean.executeQuery(SQL);
			 
	      while (rs.next()){
		    xjarea+=rs.getDouble("jzarea");
		    xjprice+=rs.getDouble("rmbprice");
		  }
		rs.close();
		hjarea+=xjarea;
		hjprice+=xjprice;
 %>
<tr align="center">
    <td width="4%" colspan="2"><%=secName %>收款小计</td>
 
    <td width="4%">　</td>
     <td width="4%"><%=FormatD.getFloat2(xjarea,2) %></td>
    <td width="4%"><%if (xjarea>0){out.print(FormatD.getFloat2(xjprice/xjarea,2));}else{out.print("0");} %></td>
    <td width="4%"><%=FormatD.getFloat2(xjprice,2) %></td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%" align="right"><%=FormatD.getFloat2(s_sssq,2) %></td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
 
     
  </tr>
  <%
  s_sssq=0;
  }rs1.close();%>
  <tr align="center">
    <td width="4%" colspan="2">收款合计</td>
 
    <td width="4%">　</td>
  <td width="4%"><%=FormatD.getFloat2(hjarea,2) %></td>
    <td width="4%"><%if (hjarea>0){out.print(FormatD.getFloat2(hjprice/hjarea,2));}else{out.print("0");} %></td>
    <td width="4%"><%=FormatD.getFloat2(hjprice,2) %></td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%" align="right"><%=FormatD.getFloat2(s_zj,2) %></td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
   <td  >&nbsp;</td>
     
  </tr>
  <tr  align="center">
   <!-- <td >按揭银行(按揭款)</td>-->
       <td width="4%">序号</td> 
    <td width="4%">姓名</td>
    <td width="4%">房号</td>
    <td width="4%">面积</td>
    <td width="4%">单价</td>
	  <td width="4%">总价</td>
    <td width="4%">摘要</td>
    <td width="4%">收据号</td>
     
    <td width="4%">按揭金额</td>
    <td width="4%">定金抵房款</td>
    <td width="4%">签合同</td>
    <td width="4%">放款银行</td> 
	   <td width="4%">备注</td> 
  </tr>
  
  <%
  int i=1;
  double ajzj=0;
  double ajmoney=0;
  double sumajmoney=0;
  double fk=0;
 hjarea=0;hjprice=0;
 String SQL="";
   ResultSet rs=null;
   rs1=ViewBean1.executeQuery(Wheresql);
     while (rs1.next()){
	  xjarea=0;
      xjprice=0;
         SecNo1=rs1.getString("SerialNo");
		 secName=rs1.getString("Name");
	SQL="select o.payment1,o.jzarea,o.unitprice,o.rmbprice,o.loft+room_no room,o.ajbk,c.cus_name,c.phone,c.sj,o.VisaDate,o.dy_date,f.FactDate fkdate";
	SQL+=",f.FactMonye,o.ajmoney,f.aj_type,f.pjno,f.ajbk from order_contract o,customer c ,FactAjCharges f WHERE  o.code=f.contractno and  o.state=2 and  o.ajmoney>0 and  o.customer=c.serialno ";
	  if (!SecNo1.equals(""))
		  SQL+=" and o.section='"+SecNo1+"'";
 
 
	SQL+=" and convert(char(10),f.FactDate,120) >='"+dates+"' and  convert(char(10),f.FactDate,120) <='"+dates1+"' ";
   
 if (!Loft.equals(""))
	SQL+=" and o.Loft='"+Loft+"' " ;
	
	rs=ViewBean.executeQuery(SQL+" order by o.loft,o.room_no");
double fkmoney=0;
ajmoney=0;
sumajmoney=0;
fk=0;
 
 int aaa=0;
  while (rs.next()){
  ii++;
 String VisaDate= getbyte(rs.getString("VisaDate"));
 if (!VisaDate.equals(""))VisaDate=VisaDate.substring(0,10);
 
 String fk_date= getbyte(rs.getString("fkdate"));
 if (!fk_date.equals(""))fk_date=fk_date.substring(0,10);
 
 String dy_date= getbyte(rs.getString("dy_date"));
 if (!dy_date.equals(""))dy_date=dy_date.substring(0,10);
 ajmoney=rs.getDouble("AJMONEY") ;
 fkmoney=rs.getDouble("FactMonye") ;
 sumajmoney+=ajmoney;
 if (!fk_date.equals("")) fk+=fkmoney;
 
   %>
 <tr align="center">
 
  <td  >&nbsp;<%=ii%></td>

  <td  >&nbsp;<%=rs.getString("cus_name") %></td>
    <td  >&nbsp;<%=rs.getString("room") %></td>
    <td  ><%=rs.getString("jzarea") %></td>
	    <td  ><%=rs.getString("unitprice") %></td>
		    <td  ><%=rs.getString("rmbprice") %></td>
  <td  >&nbsp;<%if (rs.getInt("aj_type")==0){out.print("商贷");}else{out.print("公积金");} %> </td>
 <td  >&nbsp;<%=getbyte(rs.getString("pjno")) %></td>
 
     
    <td  ><%if (!fk_date.equals("")) out.print(FormatD.getFloat2(fkmoney,2));%></td>
	  <td  ></td>
   <td  >&nbsp;<%=VisaDate %></td>
 <td  ><%=getbyte(rs.getString("ajbk")) %></td>
    <td  >&nbsp;</td>
  </tr>
  <% }
  rs.close(); 
 ajzj+=fk;

 
		  SQL="SELECT  Distinct o.code ,o.jzarea,o.rmbprice/o.jzarea age,o.rmbprice ";
		SQL+="   from order_contract o,customer c ,FactAjCharges f WHERE  o.code=f.contractno and  o.state=2 and  o.ajmoney>0 and  o.customer=c.serialno ";
	  if (!SecNo1.equals(""))
		  SQL+=" and o.section='"+SecNo1+"'";
 
 
	SQL+=" and convert(char(10),f.FactDate,120) >='"+dates+"' and  convert(char(10),f.FactDate,120) <='"+dates1+"' ";
   
 if (!Loft.equals(""))
	SQL+=" and o.Loft='"+Loft+"' " ;
		SQL+="  " ; 
		     rs=ViewBean.executeQuery(SQL);
	      while (rs.next()){
		    xjarea+=rs.getDouble("jzarea");
		    xjprice+=rs.getDouble("rmbprice");
		  }
		rs.close();
		hjarea+=xjarea;
		hjprice+=xjprice;
 
  %>
  <tr align="center">
  <td   colspan="2">&nbsp;<%=secName %>放款小计</td>
 
   <td  >&nbsp;</td>
   <td width="4%"><%=FormatD.getFloat2(xjarea,2) %></td>
    <td width="4%"><%if (xjarea>0){out.print(FormatD.getFloat2(xjprice/xjarea,2));}else{out.print("0");} %></td>
    <td width="4%"><%=FormatD.getFloat2(xjprice,2) %></td>
   <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  ><%=FormatD.getFloat2(fk,2) %></td>  
    <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
   <td  >&nbsp;</td>
 
  </tr>
   <% }
  rs1.close(); 
 

  %>
  <tr align="center">
  <td   colspan="2">&nbsp;放款合计</td>
 
   <td  >&nbsp;</td>
  <td width="4%"><%=FormatD.getFloat2(hjarea,2) %></td>
    <td width="4%"><%if (hjarea>0){out.print(FormatD.getFloat2(hjprice/hjarea,2));}else{out.print("0");} %></td>
    <td width="4%"><%=FormatD.getFloat2(hjprice,2) %></td>
   <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;<%=FormatD.getFloat2(ajzj,2) %></td>  
    <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
   <td  >&nbsp;</td>
 
  </tr>
    <tr align="center">
  <td   colspan="2">&nbsp;总计</td>
 
   <td  >&nbsp;</td>
    <td  >&nbsp;</td>
   <td  >&nbsp;</td>
    <td  >&nbsp;</td>
   <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;<%=FormatD.getFloat2(s_zj+ajzj,2) %></td>  
    <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
   <td  >&nbsp;</td>
 
  </tr>
      <tr ><td colspan="2" align="center">缴款分类小计</td>
 
    <td   colspan="11" >&nbsp;</td>
   
  </tr>
  <% SecNo1=China.getParameter(request,"SecNo");
	  
		 SQL="SELECT PayType ,sum(factmoney*CurrRate) money ";
		   SQL+="  from order_contract a,customer b,factGatheringRecord c where   c.contractno=a.code and a.customer=b.serialno";
         
if (!SecNo1.equals(""))
		  SQL+=" and a.section='"+SecNo1+"'";
		 if (!Loft.equals(""))
		  SQL+=" and a.Loft='"+Loft+"' " ;
		 if (okcheckstate.equals("1"))
		   SQL+=" and c.checkstate=1" ;
		 else    if (okcheckstate.equals("2"))
		   SQL+=" and c.checkstate=0" ;
		  SQL+=" and  convert(char(10),gather_date,120)>='"+dates+"' and  convert(char(10),gather_date,120)<='"+dates1+"'";
			 SQL+=" group by  PayType";	
		 
		    rs=ViewBean.executeQuery(SQL);
		 
		 while (rs.next()){
	 	
		  %>
      <tr align="center">
  <td   >&nbsp;<%=rs.getString("PayType") %></td>
  <td   ><%=FormatD.getFloat2(rs.getDouble("money"),2) %></td>
  <td   colspan="11" >&nbsp;</td>
  </tr>
  <%}rs.close(); %>
  
  <% 
	SQL="select  f.ajbk,sum(f.FactMonye) FactMonye from order_contract o,customer c ,FactAjCharges f WHERE  o.code=f.contractno and  o.state=2 and  o.ajmoney>0 and  o.customer=c.serialno ";
	  if (!SecNo1.equals(""))
		  SQL+=" and o.section='"+SecNo1+"'";
 
 
	SQL+=" and convert(char(10),f.FactDate,120) >='"+dates+"' and  convert(char(10),f.FactDate,120) <='"+dates1+"' ";
   
 if (!Loft.equals(""))
	SQL+=" and o.Loft='"+Loft+"' " ;
	
	SQL+="group by  f.ajbk" ;
	   rs=ViewBean.executeQuery(SQL);
		 
		 while (rs.next()){
	 	
		  %>
      <tr align="center">
  <td   >&nbsp;<%=getbyte(rs.getString("ajbk")) %></td>
  <td   ><%=FormatD.getFloat2(rs.getDouble("FactMonye"),2) %></td>
  <td   colspan="11" >&nbsp;</td>
  </tr>
  <%}rs.close(); %>
  
  
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
