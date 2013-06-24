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
<title>销售一览表</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		String name=SecNo1.substring(SecNo1.indexOf("-")+1);
		SecNo1=SecNo1.substring(0,SecNo1.indexOf("-"));
			String Loft=China.getParameter(request,"Loft");
		String roomno=China.getParameter(request,"room");%>
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
 </div>
 <!--window.open('yishoukuanviewExcel.jsp?Date1=<%=dates %>&Date2=<%=dates1 %>&SecNo=<%=China.getParameter(request,"SecNo") %>&Loft=<%=Loft %>');-->
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center"><font size=4><%=name %>实收款明细表</font></p><br>
收款时段:<%=dates %>---<%=dates1 %>
 <table width="115%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<%       List list1=new LinkedList();//存放栏名
	    List list2=new LinkedList();//存放实际的栏名
		List list3=new LinkedList();//实际栏名对应的数据
		String whereSQL=" and  convert(char(10),o.date,120)>='"+dates+"' and  convert(char(10),o.date,120)<='"+dates1+"'	";
		  int taxnum=0;
		try{   int countnum=0;
		
		  String SQL="SELECT ";
          SQL+="  o.ajmoney ,o.code,o.section,o.loft+o.room_no room,c.cus_name,o.jzarea,convert(char(10),o.date,120) date,o.rmbprice,o.unitprice,o.lu_tai_area*o.lu_tai_area_price luprice from order_contract o,customer c";
          SQL+=" where o.state<>3 and c.serialno=o.customer "; 
		  SQL+=" and o.section='"+SecNo1+"'";
		  SQL+=whereSQL;
		  if (!Loft.equals(""))
		  SQL+=" and o.loft='"+Loft+"'";
		  SQL+="  order by o.sectionname,o.loft,o.floors,o.room,o.room_no asc";//group by o.sectionname+o.loft
		  
		  ResultSet rs=ViewBean.executeQuery(SQL);
	      String cusname="",cusid="",room="",ContractNo="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="";
		  String factmoney=""  ,rgdate="",rmbprice="";
		  double zhongji=0;   
		  int sumajfk=0;
		  double hjarea=0;
		  double rmbpri=0;
		  double zjqk=0;
		  int hjzjfk=0;
		  int y_ajk=0;
		  int zts=0;
		  double zj_luprice=0;
		  double zjysfk=0;//累计已收到房款，配套、税费
		  String sumprice="",mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		  while (rs.next()){
		       zts++;
		        code=rs.getString("code");
		       String sql="";
			   int ajmoney=rs.getInt("ajmoney");
			   y_ajk+=ajmoney;
			   ResultSet rs1=null;
			    double xiaoji=0;
		       if (room.equals("")){
			   room=rs.getString("room");
		         out.print("<tr align='center'><td>序号</td><td>客户</td><td>认购日期</td><td>房号</td><td>建筑面积</td><td>单价</td><td>房款</td><td>露台款</td><td>露台罩款</td> <td>配套款</td>") ;
			     sql="select taxname from GatheringTaxRecord where TaxName_type=1 and taxmoney>0 and contactno in (select code from order_contract where section='"+SecNo1+"') group by taxname order by taxname";

				 rs1=ViewBean1.executeQuery(sql);
			     while (rs1.next()){
				 taxnum++;
				  String title=getbyte(rs1.getString("taxname"));
				 list1.add(title);
			      out.print("<td>"+title+"&nbsp;</td>");
			     }
				  out.print("<td>总房款(含其它)</td><td>按揭款</td><td>已放款</td><td>已交款</td><td>已报房款</td><td>尚欠款</td>");
			   out.print("</tr>");
			   rs1.close();
			   }
			
		       room=getbyte(rs.getString("room"));
			   
			   
			    sql="select sum(f.FactMonye) fact from FactAjCharges f";
				sql+=" where   f.contractno ="+code;
				sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取按按揭款
				
				int ajk=0;
				 while (rs1.next())
			   ajk+=rs1.getInt("fact");
			   hjzjfk+=ajk;
			   rs1.close();
			   sumajfk+=ajk;
			    out.print("<tr  align='center' ><td>"+zts+"</td>");
				 out.print("<td>"+getbyte(rs.getString("cus_name"))+"</td>");
				  out.print("<td>"+getbyte(rs.getString("date"))+"</td>");
				 out.print("<td>"+room+"</td>");
				double mj=rs.getDouble("jzarea");
				hjarea+=mj;
				double pr=rs.getDouble("rmbprice");
				  xiaoji+=pr;
				rmbpri+=pr;
				out.print("<td>"+mj+"</td>");
				out.print("<td>"+rs.getString("unitprice")+"</td>");
				out.print("<td>"+pr+"</td>");
				zj_luprice+=rs.getDouble("luprice");
				out.print("<td>"+FormatD.getFloat2(rs.getDouble("luprice"),2)+"</td>");
				sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where  f.ContractNo ="+code;
				//sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				  double zfk=0;
				 rs1=ViewBean1.executeQuery(sql);//读取已收到房款
 			     while (rs1.next()){
				   zfk=rs1.getDouble("fact");
				 
			     }
				 rs1.close();
				 //代收到的费用
				 
				 sql="select SUM(money) money from factGatheringTaxRecord where ";
		         sql+="    contractno ="+code;
				  rs1=ViewBean1.executeQuery(sql);//读取已收配套款/税费
				 while (rs1.next()){
				   zfk+=rs1.getDouble("money");
			     }
				 rs1.close();
				 zjysfk+=zfk;
				    sql="select SUM(taxmoney) money from GatheringTaxRecord where TaxName_type=0 and  taxname  like '%罩%'";
		         sql+=" and  contactno ="+code;
				// sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
				
				 rs1=ViewBean1.executeQuery(sql);//读取配套款
			     while (rs1.next()){
				   double fk=rs1.getDouble("money");
				   xiaoji+=fk;
			       String aa=getbyte(FormatD.getFloat2(fk,2));
				   if (!aa.equals(""))
			       out.print("<td>"+aa+"</td>");
			     }
				 rs1.close(); 
				 sql="select SUM(taxmoney) money from GatheringTaxRecord where TaxName_type=0 and not taxname  like '%罩%'";
		         sql+=" and  contactno ="+code;
				 //sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
				
				 rs1=ViewBean1.executeQuery(sql);//读取配套款
			     while (rs1.next()){
				   double fk=rs1.getDouble("money");
				   xiaoji+=fk;
			       String aa=getbyte(FormatD.getFloat2(fk,2));
				   if (!aa.equals(""))
			       out.print("<td>"+aa+"</td>");
			     }
				 rs1.close();
				 sql="select SUM(taxmoney) money,taxname  from GatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contactno = "+code +" group by taxname order by taxname";
				// sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' ";
				 int nnn=0;
		 
				 rs1=ViewBean1.executeQuery(sql);//读取税费
			     while (rs1.next()){
				 nnn++;
				  double fk=rs1.getDouble("money");
				   xiaoji+=fk;
				  String aa=getbyte(FormatD.getFloat2(fk,2));
				    list2.add(aa);
				    list3.add(rs1.getString("taxname"));
				 
			     }
				 rs1.close();
				 
				 for (int i=0;i<taxnum;i++){
				 
			       String strtax=(String)list1.get(i);
				   if (list3.contains(strtax))
				    {    int index=list3.indexOf(strtax);
				     out.print("<td>"+(String)list2.get(index)+"</td>");
				   }else 
				     out.print("<td>&nbsp;</td>");  	 
				
				}
				  list2.clear();
				 list3.clear();

				 
				 zhongji+=xiaoji;
				  out.print("<td>"+FormatD.getFloat2(xiaoji,2)+"</td>");
				  out.print("<td>"+FormatD.getFloat2(ajmoney,0)+"</td>");
				  out.print("<td>"+FormatD.getFloat2(ajk,0) +"</td>");
				   out.print("<td>"+FormatD.getFloat2(zfk,2)+"</td>");
				     out.print("<td>&nbsp;</td>");
				   out.print("<td>"+FormatD.getFloat2(xiaoji-ajmoney-zfk,2)+"</td>");
				  out.print("</tr>");
				 zjqk+=xiaoji-ajmoney-zfk;
			  }
		  rs.close();
		   ResultSet rs1=null;
		   String  sql="";
		   
		  
			   
		         out.print("<tr align='center'><td >合计</td>");
				 out.print("<td >&nbsp;</td>");
				  out.print("<td >&nbsp;</td>");
				  out.print("<td >&nbsp;</td>");
				 out.print("<td >"+FormatD.getFloat2(hjarea,2)+"</td>");
				 out.print("<td >&nbsp;</td>");
				 out.print("<td >"+FormatD.getFloat2(rmbpri,2)+"</td>");
				 out.print("<td >"+FormatD.getFloat2(zj_luprice,2)+"</td>");
								   
				
				
			 
				   
				 sql="select SUM(taxmoney) money from GatheringTaxRecord where TaxName_type=0 and  taxname  like '%罩%'";
		         sql+=" and  contactno in (";
				  sql+="SELECT ";
		         sql+="o.code  from order_contract o";
		         sql+=" where  o.state<>3 ";
			     sql+=" and o.section='"+SecNo1+"'";
			     if (!Loft.equals(""))
			     sql+=" and o.Loft='"+Loft+"' " ;
		       	 sql+=")";

				 rs1=ViewBean1.executeQuery(sql);//读取配套款
			     while (rs1.next()){
			       String aa=getbyte(FormatD.getFloat2(rs1.getDouble("money"),2));
				 
                   if (!aa.equals(""))
			       out.print("<td>"+aa+"</td>");
			     }
				 rs1.close();
				 
				  sql="select SUM(taxmoney) money from GatheringTaxRecord where TaxName_type=0 and not taxname  like '%罩%'";
		         sql+=" and  contactno in (";
				  sql+="SELECT ";
		         sql+="o.code  from order_contract o , customer c where o.state<>3 and c.serialno=o.customer and " ;
		         sql+="    o.state<>3 ";
			     sql+=" and o.section='"+SecNo1+"'";
			     if (!Loft.equals(""))
			     sql+=" and o.Loft='"+Loft+"' " ;
		       	 sql+=")";

				 rs1=ViewBean1.executeQuery(sql);//读取配套款
			     while (rs1.next()){
			       String aa=getbyte(FormatD.getFloat2(rs1.getDouble("money"),2));
				 
                   if (!aa.equals(""))
			       out.print("<td>"+aa+"</td>");
			     }
				 rs1.close();
				 
				 sql="select SUM(taxmoney) money,taxname  from GatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contactno in (";
				 
				   sql+="SELECT ";
          sql+="o.code  from order_contract o, customer c where o.state<>3 and c.serialno=o.customer and " ;
          sql+="    o.state<>3 ";
		   sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
				 sql+=")  group by taxname order by taxname";
		        list2.clear();
				list3.clear();
		 
				 rs1=ViewBean1.executeQuery(sql);//读取税费
			     while (rs1.next()){
				  String aa=getbyte(FormatD.getFloat2(rs1.getDouble("money"),2));
				    list2.add(aa);
				    list3.add(rs1.getString("taxname"));
			     }
				 rs1.close();
				  for (int i=0;i<taxnum;i++){
				 
			       String strtax=(String)list1.get(i);
				   if (list3.contains(strtax))
				    {    int index=list3.indexOf(strtax);
				     out.print("<td>"+(String)list2.get(index)+"</td>");
				   }else 
				     out.print("<td>&nbsp;</td>");  	 
				
				} 
				  out.print("<td>"+FormatD.getFloat2(zhongji,2)+"</td>");  
				  out.print("<td>"+FormatD.getFloat2(y_ajk/10000,2)+"</td>");  
				  out.print("<td >"+FormatD.getFloat2(hjzjfk/10000,2)+"</td>");
				  out.print("<td >"+FormatD.getFloat2(zjysfk,2)+"</td>"); out.print("<td ></td>");
				  out.print("<td>"+FormatD.getFloat2(zjqk,2)+"</td>");
				 
				  out.print("</tr>");
				 out.print("<tr align='center'><td>序号</td><td>客户</td><td>认购日期</td><td>房号</td><td>建筑面积</td><td>单价</td><td>房款</td><td>露台款</td><td>露台罩款</td> <td>配套款</td>") ;
			     sql="select taxname from GatheringTaxRecord where TaxName_type=1 and taxmoney>0 and contactno in (select code from order_contract where section='"+SecNo1+"') group by taxname order by taxname";

				 rs1=ViewBean1.executeQuery(sql);
			     while (rs1.next()){
				 taxnum++;
				  String title=getbyte(rs1.getString("taxname"));
				 list1.add(title);
			      out.print("<td>"+title+"&nbsp;</td>");
			     }
				  out.print("<td>总房款(含其它)</td><td>按揭款</td><td>已放款</td><td>已交款</td><td>已报房款</td><td>尚欠款</td>");
			   out.print("</tr>");
			   rs1.close();  
	 
				  
		}catch(Exception s){out.print(s);}
 %> 
</TABLE>
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
