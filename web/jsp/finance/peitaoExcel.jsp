<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
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
		String SecNo1=request.getParameter("SecNo");
		String name=SecNo1.substring(SecNo1.indexOf("-")+1);
		SecNo1=SecNo1.substring(0,SecNo1.indexOf("-"));
		String Loft=request.getParameter("Loft"); 
		String roomno=request.getParameter("room");
		%>
 <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center"><font size=4><%=name %>配套费明细表</font></p><br>
 
收款时段:<%=dates %>---<%=dates1 %>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<%  
		 	
		
		
		  String SQL="SELECT ";
          SQL+="o.sectionname+o.loft room from order_contract o";
          SQL+=" where o.section='"+SecNo1+"' ";
		   if (!Loft.equals(""))
	      SQL+=" and o.Loft='"+Loft+"' " ;
		  SQL+=" group by o.sectionname+o.loft order by o.sectionname+o.loft";
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
		   
			  
		       if (room.equals("")){
			    room=getbyte(rs.getString("room"));
		         out.print("<tr align='center'><td>商品房名称</td>") ;
			     sql="select taxname from FactGatheringTaxRecord where TaxName_type=0    and contractno in (select code from order_contract where sectionname+loft='"+room+"') group by taxname  order by taxname";
                 rs1=ViewBean1.executeQuery(sql);
		 
			     while (rs1.next()){
				 sumcol++;
			      out.print("<td>"+getbyte(rs1.getString("taxname"))+"&nbsp;</td>");
			     }
				     out.print("<td>合计&nbsp;</td>");
			   out.print("</tr>");
			   rs1.close();
			   }else{room=getbyte(rs.getString("room"));}
			 
		       	 if (!roomno.equals("")) 
			    out.print("<tr><td>"+room+roomno+"</td>");
				else 
				  out.print("<tr><td>"+room+"</td>");
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 ";
		         sql+=" and  contractno in (select code from order_contract where sectionname+loft='"+room+"' ";
				 if (!roomno.equals("")) sql+=" and room_no='"+roomno+"'";
				 sql+=" ) and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
	           	sql+="  group by taxname  order by taxname";
				
				 rs1=ViewBean1.executeQuery(sql);//读取配套款
			    float money=0;
				 while (rs1.next()){
				  float money1=rs1.getFloat("money");
			      money+=money1;
				   col++;
			       out.print("<td>"+money1+"</td>");
				   
			     }
				 
				for (int a=col;a<sumcol;a++){
				 out.print("<td>&nbsp;</td>");
				
				 }
				  out.print("<td>"+money+"</td>");
				 rs1.close();
                sumpei+=money;
				 
			  }
		  rs.close();
		  
		  
		        out.print("<tr><td>合计</td>");
				 
				 sql="select taxname, SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 ";
		         sql+=" and  contractno in (select o.code from order_contract o    where o.section='"+SecNo1+"' ";
				 
				  if (!roomno.equals("")) sql+=" and room_no='"+roomno+"'";
				 sql+=")  and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
  	             sql+=" group by taxname  order by taxname";
				 rs1=ViewBean1.executeQuery(sql);//读取配套款
				 float aa=0;
				 col=0;
			     while (rs1.next()){
			      float money1=rs1.getFloat("money");
			      aa+=money1;
				    col++;
			       out.print("<td>"+money1+"</td>");
			     }
				 rs1.close();
				 for (int a=col;a<sumcol;a++){
				 out.print("<td>&nbsp;</td>");
				
				 }
				         out.print("<td>"+aa+"</td>");
						 
				  out.print("</tr>");
		 
 %>
</TABLE>
备注:<input type=text name=aa  size=100  class=unnamed1>
&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name=aa  size=100  class=unnamed1>


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
  bringToExcel();
  window.close();
  </script>
</body>
</html>
