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
<title>销售汇总表</title>
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

<p align="center"><font size=4><%=dates %>到<%= dates1%>销售汇总表</font></p><br>
 
 
 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1" height="47">
 <tr  align="center">
    <td width="6%" rowspan="2" height="42">项目</td>
    <td width="6%" rowspan="2" height="42">销售合同款</td>
    <td width="18%" colspan="3" height="9">实际已收房款</td>
    <td width="7%" rowspan="2" height="42">合同尚差房款</td>
    <td width="21%" height="9" colspan="3">合同差房款明细</td>
    <td width="14%" height="9" colspan="2">已签协议房款</td>
    <td width="7%" height="9">尚差房款</td>
    <td width="7%" height="9">合同未签已收定金</td>
    <td width="7%" height="41" rowspan="2">收款总计</td>
  </tr>
  <tr  align="center">
    <td width="6%" height="32">收期款</td>
    <td width="6%" height="32">收按揭</td>
    <td width="6%" height="32">收房款合计</td>
    <td width="7%" height="32">差按揭</td>
    <td width="7%" height="32">差首期</td>
    <td width="7%" height="32">差尾款</td>
    <td width="7%" height="32">协议已收房款</td>
    <td width="7%" height="32">协议房款</td>
    <td width="7%" height="32">合同＋协议</td>
    <td width="7%" height="32">　</td>
  </tr>
 


  
 
<%       
	     String whereSQL="";
		  double ht_price=0;
				double xy_price=0;
				double xy_ys_price=0;
				
			    double ssajk=0;
		        double sssq=0;
				double sssq_cfq=0;
				double yssq=0;
				double s_ssajk=0;
				double s_sssq=0;
				double s_ht_price=0;
				double s_xy_price=0;
				double s_yssq=0;
				double y_ajk=0;
				double s_y_ajk=0;
				double fq_sssq=0;
				double fq_yssq=0;
				double s_fq_sssq=0;
				double s_fq_yssq=0;
				double s_fq_s_yssq=0;
				double xy_ssdj=0;
				double s_xy_ssdj=0;
				double xy_sssq=0;
				double s_fq_s_sssq=0;
				double s_xy_sssq=0;
				double zjk=0;
				double s_zjk=0;
				double a1=0,a2=0,a3=0,a4=0,a5=0,a6=0,a7=0,a8=0,a9=0,a0=0,a10=0,a11=0,a12=0,a13=0;
				double ys_fq=0,ss_fq=0;
		try{    
		 
		  String SQL="SELECT a.SerialNo,a.name from CRM_Project  a";
         if (!SecNo1.equals(""))
		  SQL+=" where  a.SerialNo='"+SecNo1+"'";
		  
		  ResultSet rs=ViewBean.executeQuery(SQL);
	      
		   
		  while (rs.next()){
		      String   name=rs.getString("SerialNo");
			   String name1=rs.getString("name");
			   ResultSet rs1=null;
			   String sql="";
			    s_zjk=0;
			   
		 //协议房款
				sql="select sum(rmbprice) rmbprice,count(*) num from  order_contract  ";
				sql+=" where  section<>''  and state=1 ";
				sql+=" and  section= '"+name+"' ";
				//sql+=" and  convert(char(10),date,120)>='"+dates+"' and  convert(char(10),date,120)<='"+dates1+"'";
				
				 rs1=ViewBean1.executeQuery(sql);// 协议房款
				 if (rs1.next()){xy_price=rs1.getDouble("rmbprice");}
				 rs1.close();
				s_xy_price+=xy_price;
		
				 //已签合同 
				sql="select sum(rmbprice) rmbprice,sum(rmbprice-ajmoney) sq_money,count(*) num from  order_contract  ";
				sql+=" where  section<>''  and state=2 ";
				sql+=" and   section='"+name+"' ";
				//sql+=" and  convert(char(10),date,120)>='"+dates+"' and  convert(char(10),date,120)<='"+dates1+"'";
				
				 rs1=ViewBean1.executeQuery(sql);// 已售合同款
				 if (rs1.next()){ht_price=rs1.getDouble("rmbprice");yssq=rs1.getDouble("sq_money");}
				 rs1.close();
				  s_ht_price+=ht_price;
				  
				 		 //已签合同应收按揭 
				sql="select sum(ajmoney) rmbprice,count(*) num from  order_contract  ";
				sql+=" where  section<>'' and payment like '%按揭%'  and state=2 ";
				sql+=" and  section='"+name+"' ";
				//sql+=" and  convert(char(10),date,120)>='"+dates+"' and  convert(char(10),date,120)<='"+dates1+"'";
				
				 rs1=ViewBean1.executeQuery(sql);// 已签合同应收按揭
				 if (rs1.next()){y_ajk=rs1.getDouble("rmbprice");}
				 rs1.close();
				  s_y_ajk+=y_ajk; 
				  
				  //实际放款
				 sql="select sum(f.FactMonye) money from FactAjCharges f";
				 sql+=" where  contractno in (select code from order_contract where  state=2 and  section= '"+name+"')";
				 sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取按按揭款
				  if (rs1.next())ssajk=rs1.getDouble("money");
				 rs1.close();
				 s_ssajk+=ssajk;
				  
				 sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in(0,1,2,3,4,8,12,13) ";
				 sql+=" and contractno in (select code from order_contract where  state=2 and  section= '"+name+"')";
				 sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款
				 if (rs1.next())sssq=rs1.getDouble("money");
				 rs1.close();
				 s_sssq+=sssq;
				 
				/* 
				    sql="select sum(f.shouldMoney*f.rate) money from GatheringRecord f";
				sql+=" where f.shouldQS in(0,1,2,3,4,8,12,13) ";
				//sql+=" and  convert(char(10),f.shouldDate,120)>='"+dates+"' and  convert(char(10),f.shouldDate,120)<='"+dates1+"'";
				sql+=" and ContactNo in (select code from order_contract where  state=2  and section= '"+name+"' and  not payment like '%分期%') ";//
				 
				 rs1=ViewBean1.executeQuery(sql);//读取应收首期款,除分期款外
				 if (rs1.next())yssq=rs1.getDouble("money");
				 rs1.close();
				 
				 */
				 s_yssq+=yssq;
				  
				 
				sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in(0,1,2,3,4,8,12,13) ";
				 sql+=" and contractno in (select code from order_contract where  state=2 and  not payment like '%分期%' and section= '"+name+"')";
				 sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款,除分期款外
				 if (rs1.next())sssq_cfq=rs1.getDouble("money");
				 rs1.close();
				// s_sssq+=sssq;
				  
				  
				 
				  
				 sql="select sum(f.shouldMoney*f.curry) money from GatheringRecord f";
				sql+=" where f.shouldQS in(0,1,2,3,4,8,12,13) ";
				sql+=" and  convert(char(10),f.shouldDate,120)>='"+dates+"' and  convert(char(10),f.shouldDate,120)<='"+dates1+"'";
				sql+=" and ContactNo in (select code from order_contract where  state=2 and  payment like '%分期%' and section= '"+name+"')";
				 rs1=ViewBean1.executeQuery(sql);//读取应收首期款,限分期款
				 if (rs1.next())fq_yssq=rs1.getDouble("money");
				 rs1.close();
				 s_fq_s_yssq+=fq_yssq;
				 
				  
				 sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in(0,1,2,3,4,8,12,13) ";
				 sql+=" and contractno in (select code from order_contract where  state=2 and payment like '%分期%' and section= '"+name+"')";
				 sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款,限分期款
				 if (rs1.next())fq_sssq=rs1.getDouble("money");
				 rs1.close();
				 s_fq_s_sssq+=fq_sssq;
				  
				  
				  
				   sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in(0,1,2,3,4,8,12,13) ";//,1,2,3,4,8,12,13
				 sql+=" and contractno in (select code from order_contract where  state=1 and  section= '"+name+"')";
				sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				 
				  rs1=ViewBean1.executeQuery(sql);//读取实际收到认购总款//定金
				 if (rs1.next())xy_ssdj=rs1.getDouble("money");
				 rs1.close();
				 s_xy_ssdj+=xy_ssdj;
				  
				  
				   sql="select sum(rmbprice) money from order_contract where code in ( select contractno from factGatheringRecord f";
				 sql+=" where f.Period in(0) ";
				 sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				 sql+=" ) and state=1 and  section= '"+name+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//读取认购总款
				 if (rs1.next())xy_ys_price=rs1.getDouble("money");
				 rs1.close();
				 
				 
				 
				   
				 
			    sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in(0,1,2,3,4,8,12,13) ";
				 sql+=" and contractno in (select code from order_contract where state=1 and   section= '"+name+"')";
				 sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//读取认购总款
				 if (rs1.next())xy_sssq=rs1.getDouble("money");
				 rs1.close();
				 s_xy_sssq+=xy_sssq;
				//out.println(xy_sssq);
					
				 
			    sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in(0,1,2,3,4,8,12,13) ";
				 sql+=" and contractno in (select code from order_contract where state<>3 and   section= '"+name+"')";
				 sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//总的收款
				 if (rs1.next())zjk=rs1.getDouble("money");
				 rs1.close();

				 s_zjk+=zjk;
				 
				   sql="select sum(f.FactMonye) money from FactAjCharges f";
				 sql+=" where  contractno in (select code from order_contract where   state<>3 and   section= '"+name+"')";
				 sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取按按揭款
				  if (rs1.next())zjk=rs1.getDouble("money");
				 rs1.close();
 
				 s_zjk+=zjk;
				 
				 
				   sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where  ";
				 sql+="   contractno in (select code from order_contract where state=3 and   section= '"+name+"')";
				 // sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				double t_sk=0;
				 
				  rs1=ViewBean1.executeQuery(sql);//已退定的总的收款
				 if (rs1.next())t_sk=rs1.getDouble("money");
				 rs1.close();
				 s_zjk+=t_sk;
				  %>
  <tr  align="center">
    <td width="6%" height="16"><%=name1 %></td>
    <td width="6%" height="16"><%=FormatD.getFloat2(ht_price,2) %></td>
    <td width="6%" height="16"><%=FormatD.getFloat2(sssq,2) %></td>
    <td width="6%" height="16"><%=FormatD.getFloat2(ssajk,2) %></td>
    <td width="6%" height="16"><%=FormatD.getFloat2(sssq+ssajk,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(ht_price-sssq-ssajk,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(y_ajk-ssajk,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(yssq-sssq_cfq,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(fq_yssq-fq_sssq,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(xy_ssdj,2) %></td>
	
	
    <td width="7%" height="16"><%=FormatD.getFloat2(xy_ys_price,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2((ht_price-sssq-ssajk)+(xy_ys_price -xy_sssq),2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(t_sk,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(s_zjk,2) %></td>
  </tr>
		  <% 
		  a13+=t_sk;
		  a10+=ht_price;
		  a0+=sssq;
		  a1+=ssajk;
		  a2+=sssq+ssajk;
		   a3+=ht_price-sssq-ssajk;
		   
		   a4+=y_ajk-ssajk;
		   a5+=fq_yssq-fq_sssq;
		   a6+=xy_ssdj;
		   a7+=xy_ys_price;
		   a8+=(ht_price-sssq-ssajk)+(xy_ys_price -xy_sssq);
		   a9+=s_zjk;
		   a11+=yssq-sssq;
		     }rs.close();
				  
		}catch(Exception s){out.print(s);}
 %>
  <tr align="center">
    <td width="6%" height="16">合计</td>
    <td width="6%" height="16"><%=FormatD.getFloat2(a10,2) %></td>
    <td width="6%" height="16"><%=FormatD.getFloat2(a0,2) %></td>
    <td width="6%" height="16"><%=FormatD.getFloat2(a1,2) %></td>
    <td width="6%" height="16"><%=FormatD.getFloat2(a2,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(a3,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(a4,2) %></td>
		<td width="7%" height="16"><%=FormatD.getFloat2(a11,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(a5,2) %></td>

    <td width="7%" height="16"><%=FormatD.getFloat2(a6,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(a7,2) %></td>
    <td width="7%" height="16"><%=FormatD.getFloat2(a8,2) %></td>
     <td width="7%" height="16"><%=FormatD.getFloat2(a13,2) %></td>
   <td width="7%" height="16"><%=FormatD.getFloat2(a9,2) %></td>
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
