<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
	<title>已收款统计</title>
</head>

<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		String name=SecNo1.substring(SecNo1.indexOf("-")+1);
		SecNo1=SecNo1.substring(0,SecNo1.indexOf("-"));
		String Loft=China.getParameter(request,"Loft"); 
		String roomno=China.getParameter(request,"room");
		%>
			 	<DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center"><font size=4><%=name %>配套费明细表</font></p><br>
 
收款时段:<%=dates %>---<%=dates1 %>
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<%  
		 	
		List list1=new LinkedList();//存放栏名
	    List list2=new LinkedList();//存放实际的栏名
		List list3=new LinkedList();//实际栏名对应的数据
		  String SQL="SELECT ";
          SQL+=" o.loft+o.room_no room,c.cus_name,o.state,o.td_date  from order_contract o, customer c";
          SQL+=" where c.serialno=o.customer and o.section='"+SecNo1+"' ";
		   if (!Loft.equals(""))
	      SQL+=" and o.Loft='"+Loft+"' " ;
		  SQL+="  order by  o.loft,o.floors,o.room_no,c.cus_name";
		  ResultSet rs=ViewBean.executeQuery(SQL);
		  String sql="";
		   ResultSet rs1=null;
          String cusname="",cusid="",room="",ContractNo="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="";
		  String factmoney=""; 
		  String sumprice="",mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		 int sumcol=0;
		 int col=0;
		 double sumpei=0;
		  while (rs.next()){
		   		int state=rs.getInt("state");	
				String td_date  =getbyte(rs.getString("td_date"));
				if (!td_date.equals(""))td_date=td_date.substring(0,10);
		       if (room.equals("")){
			    
			    room=getbyte(rs.getString("room"));
		         out.print("<tr align='center'><td>商品房名称</td><td>客户名称</td>") ;
			     sql="select taxname from FactGatheringTaxRecord where TaxName_type=0    and contractno in (select code from order_contract where  section='"+SecNo1+"' ";
		   if (!Loft.equals(""))
	      sql+=" and  Loft='"+Loft+"' " ;
		   sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' group by taxname  order by taxname";
               
				 rs1=ViewBean1.executeQuery(sql);
		
			     while (rs1.next()){
				 sumcol++;
				 String title=getbyte(rs1.getString("taxname"));
				 list1.add(title);
			      out.print("<td>"+title+"&nbsp;</td>");
			     }
				     out.print("<td>合计&nbsp;</td>");
			   out.print("</tr>");
			   rs1.close();
			   }else{room=getbyte(rs.getString("room"));}
			 
		       	 if (!roomno.equals("")) 
			    out.print("<tr><td>"+room+roomno+"</td>");
				else 
				  out.print("<tr><td>"+room+"</td>");
				  out.print("<td>");
				  if (state==3) out.print("<font color=red>退房日期："+td_date+" ");
				  out.print(getbyte(rs.getString("cus_name")));
				   if (state==3) out.print("</font>");
				 out.print( "</td>");
				 sql="select SUM(money) money,taxname from FactGatheringTaxRecord where TaxName_type=0 ";
		         sql+=" and  contractno in (select code from order_contract where loft+room_no='"+room+"' and section='"+SecNo1+"' ";
				 if (!roomno.equals("")) sql+=" and room_no='"+roomno+"'";
				 sql+=")  and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
	           	sql+="  group by taxname  order by taxname";
							 
              
				 rs1=ViewBean1.executeQuery(sql);//读取配套款
				 
			    float money=0;
				 while (rs1.next()){
				 
				  float money1=rs1.getFloat("money");
				   list2.add(String.valueOf(money1));
				   list3.add(rs1.getString("taxname"));
			      money+=money1;
				   col++;
			       
				   
			     }
				 for (int a=0;a<sumcol;a++){
			       String strtax=(String)list1.get(a);
				   if (list3.contains(strtax))
				    {    int index=list3.indexOf(strtax);
				     out.print("<td>"+(String)list2.get(index)+"</td>");
				   }else 
				     out.print("<td>0</td>");  	 
				
				}
				  list2.clear();
				 list3.clear();
				  out.print("<td>"+money+"</td>");
				 rs1.close();
                sumpei+=money;
				 
			  }
		  rs.close();
		  
		  
		  
		       out.print("<tr><td>合计</td>");
				 
				 sql="select taxname, SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 ";
		         sql+=" and  contractno in (select o.code from order_contract o    where o.section='"+SecNo1+"' ";
				 
				  if (!roomno.equals("")) sql+=" and room_no='"+roomno+"'";
				  if (!Loft.equals("")) sql+=" and Loft='"+Loft+"'";
				 sql+=")  and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
  	             sql+=" group by taxname  order by taxname";
				 rs1=ViewBean1.executeQuery(sql);//读取配套款
				 float aa=0;
				 col=0;
				 list2.clear();
				 list3.clear();
			     while (rs1.next()){
			      float money1=rs1.getFloat("money");
			      aa+=money1;
				    col++;
				   list2.add(String.valueOf(money1));
				   list3.add(rs1.getString("taxname"));
			    
			     }
				 rs1.close();
				  out.print("<td>&nbsp;</td>");  	
				 for (int a=0;a<sumcol;a++){
			       String strtax=(String)list1.get(a);
				   if (list3.contains(strtax))
				    {    int index=list3.indexOf(strtax);
				     out.print("<td>"+(String)list2.get(index)+"&nbsp;</td>");
				   }else 
				     out.print("<td>&nbsp;</td>");  	 
				
				  }
				         out.print("<td>"+aa+"</td>");
						 
				  out.print("</tr>");
				  
		 
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
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
</body>
</html>
