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
<title>资金回笼总表</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		 
			String Loft=China.getParameter(request,"Loft");
		 %>
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
 </div>
 
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center"><font size=4>资金回笼总表</font></p><br>
 
 
 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1" height="47">
  <tr align="center">
    <td width="16%" height="29" rowspan="2">项目</td>
    <td width="16%" height="29" rowspan="2">计划回款</td>
    <td width="51%" colspan="3" height="13"><%=dates %>---<%=dates1 %>实际回款</td>
    <td width="17%" height="29" rowspan="2">差计划回款</td>
  </tr>
  <tr  align="center">
    <td width="17%" height="16">首期款</td>
    <td width="17%" height="16">按揭款</td>
    <td width="17%" height="16">合计</td>
  </tr>
  
 
<%       double s_yssq=0;
		 double s_sssq=0;
		 double s_ssajk=0;
	     String whereSQL="";
		try{    
		 
		// 
		  String SQL="SELECT a.SerialNo,a.name from CRM_Project  a";
         if (!SecNo1.equals(""))
		  SQL+=" where  a.SerialNo='"+SecNo1+"'";
		 
		 
		 
		  ResultSet rs=ViewBean.executeQuery(SQL);
	      
		   
		  while (rs.next()){
		      String   name=rs.getString("SerialNo");
			  String name1=rs.getString("name");
			   ResultSet rs1=null;
			   String sql="";
			    double yssq=0;
				double sssq=0;
				double ssajk=0;
		        sql="select sum(f.shouldMoney*f.rate) money from GatheringRecord f";
				sql+=" where f.shouldQS in(0,1,2,3,4,8,12,13) ";
				sql+=" and  convert(char(10),f.shouldDate,120)>='"+dates+"' and  convert(char(10),f.shouldDate,120)<='"+dates1+"'";
				sql+=" and ContactNo in (select code from order_contract where state<>3 and section='"+name+"')";
				 
				 rs1=ViewBean1.executeQuery(sql);//读取应收首期款
				 if (rs1.next())yssq=rs1.getDouble("money");
				 rs1.close();
				 s_yssq+=yssq;
				
			    sql="select sum(f.FactMonye) money from FactAjCharges f";
				sql+=" where  contractno in (select code from order_contract where state=2 and section='"+name+"')";
				sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取按按揭款
				  if (rs1.next())ssajk=rs1.getDouble("money");
				 rs1.close();
				 s_ssajk+=ssajk;
				 
				 sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in(0,1,2,3,4,8,12,13) ";
				 sql+=" and contractno in (select code from order_contract where state<>3 and section='"+name+"')";
				 sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				 
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款
				 if (rs1.next())sssq=rs1.getDouble("money");
				 rs1.close();
				 s_sssq+=sssq;
				  %>
				  <tr  align="center">
					    <td width="16%" height="16"><%=name1 %></td>
					    <td width="16%" height="16"><%=FormatD.getFloat2(yssq,2) %></td>
					    <td width="17%" height="16"><%=FormatD.getFloat2(sssq,2) %></td>
					    <td width="17%" height="16"><%=FormatD.getFloat2(ssajk,2) %></td>
					    <td width="17%" height="16"><%=FormatD.getFloat2(sssq+ssajk,2) %></td>
					    <td width="17%" height="16"><%=FormatD.getFloat2(yssq-sssq-ssajk,2) %></td>
				 </tr>

				  <%
		     }rs.close();
				  
		}catch(Exception s){out.print(s);}
 %>
  <tr  align="center">
					    <td width="16%" height="16">合计</td>
					    <td width="16%" height="16"><%=FormatD.getFloat2(s_yssq,2) %></td>
					    <td width="17%" height="16"><%=FormatD.getFloat2(s_sssq,2) %></td>
					    <td width="17%" height="16"><%=FormatD.getFloat2(s_ssajk,2) %></td>
					    <td width="17%" height="16"><%=FormatD.getFloat2(s_sssq+s_ssajk,2) %></td>
					    <td width="17%" height="16"><%=FormatD.getFloat2(s_yssq-s_sssq-s_ssajk,2) %></td>
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
