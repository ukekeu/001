<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>尚差房款明细</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		String dataType=China.getParameter(request,"dataType");
	    String Loft=China.getParameter(request,"Loft");
		 %>
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
 </div>
   <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
 
 <div id=titlestr><p align=center class=FontColor><font size=3><b>尚差房款明细</b></font></p></div>
 时段:<%=dates %>－<%=dates1 %>
 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1" height="47">
   <tr align="center">
    <td width="5%" rowspan="2">序号</td>
    <td width="5%" rowspan="2">交定金日期</td>
    <td width="5%" rowspan="2">交首期日期</td>
    <td width="5%" rowspan="2">姓名</td>
    <td width="5%" rowspan="2">房号</td>
    <td width="5%" rowspan="2">面积</td>
    <td width="5%" rowspan="2">单价</td>
    <td width="5%" rowspan="2">总价</td>
    <td width="6%" rowspan="2">已收定金</td>
    <td width="6%" rowspan="2">已收首期款</td>
    <td width="6%" rowspan="2">已收按揭</td>
    <td width="6%" rowspan="2">收款合计</td>
    <td width="6%" rowspan="2">尚差房款</td>
    <td width="24%" colspan="4">尚差房款明细</td>
    <td width="6%" rowspan="2">备注</td>
  </tr>
  <tr align="center">
    <td width="6%">公积金</td>
    <td width="6%">商贷</td>
    <td width="6%">首期</td>
    <td width="6%">尾款</td>
  </tr>
   
  
  
 
<%       double s_yssq=0;
		 double s_sssq=0;
		 double s_ssajk=0;
	     String whereSQL="";
		 String sectionName="";
		try{    
		 
		  if (dataType.equals("1")){
		  dataType=" and a.state=1 " ;
		  }else   if (dataType.equals("2")){
		   dataType=" and a.state=2 " ;
		  }
		  String SQL="SELECT a.sectionname,a.code,a.loft,a.ContractNo,convert(char(10),a.jldate,120) jldate,convert(char(10),a.VisaDate,120) VisaDate,b.cus_name,a.room_no,a.jzarea,a.y_jzarea,a.cj_f,a.unitprice ";
		   SQL+=",a.rmbprice,a.ajmoney,a.gjj  from order_contract a,customer b where a.state<>3 and a.customer=b.serialno";
         if (!SecNo1.equals(""))
		  SQL+=" and a.section='"+SecNo1+"'";
		 if (!Loft.equals(""))
		  SQL+=" and a.Loft='"+Loft+"' " ;
		  SQL+=dataType;
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
				double ssajk_g=0;        
                double ssajk=0;
				double ssajk_s=0;
				int ajmoney=0;
				int gjj=0;
				sectionName=rs.getString("sectionname");
		       String code=rs.getString("code");
			          Loft=rs.getString("Loft"); 	
				String ContractNo=rs.getString("ContractNo");	  
				String jldate=rs.getString("jldate");	  
				String VisaDate=getbyte(rs.getString("VisaDate"));	
				String cus_name=rs.getString("cus_name");	
				String roomno=rs.getString("room_no");	
				String jzarea=rs.getString("jzarea");	
				String y_jzarea=rs.getString("y_jzarea");	
				double cj_f=rs.getDouble("cj_f");	
				double unitprice=rs.getDouble("unitprice");	
				double rmbprice=rs.getDouble("rmbprice");	
				ajmoney=rs.getInt("ajmoney");
				gjj=rs.getInt("gjj");
				
				String fk_date="";
			    sql="select f.FactMonye money,aj_type from FactAjCharges f";
				//sql+=" where  contractno in (select code from order_contract where code="+code+" and state=2)";
				 sql+=" where  contractno ="+code+" ";
				 
				 sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				 rs1=ViewBean1.executeQuery(sql);//读取按按揭款
				  while  (rs1.next()){
				  int aj_type=rs1.getInt("aj_type");
				  ssajk+=rs1.getDouble("money");
				  if (aj_type==0)ssajk_s=rs1.getDouble("money");
				  else ssajk_g=rs1.getDouble("money");
				 
				 
				   
				  }
				   ssajk=ssajk_s+ssajk_g;
				 rs1.close();
				 s_ssajk+=ssajk;
				 String djdate="";
				 sql="select     f.factmoney*f.currrate  money ,convert(char(10),gather_date,120) djdate from factGatheringRecord f";
				 sql+=" where f.Period in(0) ";
				 sql+=" and contractno ="+code;
				   sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到定金
				 while (rs1.next()){ssdj+=rs1.getDouble("money");djdate=rs1.getString("djdate");}
				 rs1.close();
				 s_ssdj+=ssdj;
				 
				  sql="select  f.factmoney*f.currrate  money,gather_date from factGatheringRecord f";
				 sql+=" where f.Period in(1,2,3,4,8,12,13) ";
				  sql+=" and contractno ="+code; 
				 sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款
				  String sf_date="";
				 while (rs1.next()){sssq+=rs1.getDouble("money"); }
				 rs1.close();
				 s_sssq+=sssq;
				 
				  %>
			 <tr align="center">
			    <td width="4%"><%=ii %></td>
				<td width="4%"><%=djdate %></td>
				<td width="4%"><%=sf_date %></td>
			    
			    <td width="4%"><%=cus_name %></td>
			    <td width="4%"><%=Loft+roomno %></td>
			    <td width="4%"><%=jzarea %></td>
			  
			    <td width="4%"><%=FormatD.getFloat2(unitprice,2) %></td>
			    <td width="4%"><%=FormatD.getFloat2(rmbprice ,2)%></td>
				
			    <td width="4%"><%=FormatD.getFloat2(ssdj,2) %></td>
			    <td width="4%"><%=FormatD.getFloat2(sssq ,2)%></td>
				
			    <td width="4%"><%=FormatD.getFloat2(ssajk,2) %></td>
				
			    <td width="4%"><%=FormatD.getFloat2(ssajk+sssq+ssdj,2) %></td>
				
			    <td width="4%"><%=FormatD.getFloat2(rmbprice-ssajk-sssq-ssdj,2) %></td>
				
			     <td width="4%"><%=FormatD.getFloat2(gjj- ssajk_g,2)%></td>
			    <td width="4%"><%=FormatD.getFloat2(ajmoney-ssajk_s,2) %></td>
			    <td width="4%"><%=FormatD.getFloat2(rmbprice-ajmoney-gjj-sssq-ssdj,2) %></td>
			 
			    <td width="5%">0</td>
			    <td width="5%"></td>
        </tr>

				  <%
		     }rs.close();
				  
		}catch(Exception s){out.print(s);}
		dataType=China.getParameter(request,"dataType");
 %>
<tr>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    <td width="4%">　</td>
    
  
   
  </tr>
</table>
</div>

<script>
titlestr.innerHTML="<p align=center class=FontColor><font size=3><b><%  if (dataType.equals("1")){out.print("认购客户");}else if (dataType.equals("2")){out.print("签约客户"); }%>尚欠房款明细表</b></font></p>";
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
