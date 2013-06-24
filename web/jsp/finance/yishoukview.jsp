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
<title>收款明细统计表</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		String name="";
		if (!SecNo1.equals("")){
		  name=SecNo1.substring(SecNo1.indexOf("-")+1);
		  SecNo1=SecNo1.substring(0,SecNo1.indexOf("-"));
		}
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

<p align="center"><font size=4>缴款明细表</font></p><br>
收款时段:<%=dates %>---<%=dates1 %>
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<%  
            out.print("<tr align='center'><td>序号</td><td>缴款日期</td><td>客户姓名</td><td>楼盘名称</td><td>房号</td><td>总价</td> <td>本次缴款金额</td><td>欠款</td><td>折扣</td></tr>") ;//<td>累计缴款金额</td><td>欠款</td>
			 
	   	  int taxnum=0;
		try{   int countnum=0;
		
		  String SQL="SELECT ";
          SQL+="  d.factmoney*d.currrate  factmoney,d.Gather_Date ,o.code,o.section,o.sectionname,o.loft+o.room_no room,c.cus_name,o.jzarea,o.date,o.rmbprice,o.youhui,o.ewdisc from order_contract o,customer c,factGatheringRecord d";
          SQL+=" where    convert(char(10),d.Gather_Date,120)>='"+dates+"' and  convert(char(10),d.Gather_Date,120)<='"+dates1+"' and  o.code=d.ContractNo and o.state<>3 and c.serialno=o.customer "; 
		   if (!SecNo1.equals(""))
		  SQL+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
		 
		  SQL+="  order by o.sectionname,o.loft,o.floors,o.room,o.room_no asc,d.Gather_Date asc ";//group by o.sectionname+o.loft
		  ResultSet rs=ViewBean.executeQuery(SQL);
	      String cusname="",cusid="",room="",ContractNo="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="";
		  String factmoney=""  ,rgdate="",rmbprice="";
		  double zhongji=0;   
		  int sumajfk=0;
		  double hjarea=0;
		  double rmbpri=0;
		  int ii=0;
		  double ljqk=0;
		  double xiaoji=0;
		  String sumprice="",mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		  while (rs.next()){
		        code=rs.getString("code");
		       String sql="";
			   ResultSet rs1=null;
			    
		        ii++;
			
		       room=getbyte(rs.getString("room"));
			   SecNo1=getbyte(rs.getString("section"));
			   
			  /*  sql="select sum(f.FactMonye) fact from FactAjCharges f";
				sql+=" where   f.contractno ="+code;
				sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取按按揭款
				
				int ajk=0;
				 while (rs1.next())
			   ajk+=rs1.getInt("fact");
			   
			   rs1.close();
			   sumajfk+=ajk;
			   */
			    out.print("<tr  align='center' ><td>"+ii+"</td>");
				double factmoney1=rs.getDouble("factmoney");
				hjarea+=factmoney1;
				double pr=rs.getDouble("rmbprice");
				rmbpri+=pr;
				out.print("<td>"+rs.getDate("Gather_Date").toString()+"</td>");
				out.print("<td>"+getbyte(rs.getString("cus_name"))+"</td>");
				out.print("<td>"+getbyte(rs.getString("sectionname"))+"</td>");
				out.print("<td>"+getbyte(rs.getString("room"))+"</td>");
				out.print("<td  align='left'>&nbsp;"+FormatD.getFloat2(pr,2)+"</td>");
				out.print("<td align='left'>&nbsp;"+FormatD.getFloat2(factmoney1,2)+"</td>");
				out.print("<td align='left'>&nbsp;"+FormatD.getFloat2(pr-factmoney1,2)+"</td>");
				  //累计收款 
				  /*
				sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,8,12,13) and f.ContractNo ="+code;
				sql+=" and   convert(char(10),f.Gather_Date,120)<='"+rs.getDate("Gather_Date").toString()+"'";
				 double fk=0;
				 rs1=ViewBean1.executeQuery(sql);//读取房款
 			     while (rs1.next()){
				   fk=rs1.getDouble("fact");
				  xiaoji+=fk;//+ajk;
			      out.print("<td align='left'>&nbsp;"+getbyte(FormatD.getFloat2(fk,2))+"</td>");
			     }
				 rs1.close();
			    //欠款
				   out.print("<td align='left'>&nbsp;"+FormatD.getFloat2(pr-fk,2)+"&nbsp;</td>");
				   ljqk+=pr-fk;
				   */
				 String yy="";
				//String StrEwDisc=getbyte(rs.getString("ewdisc"));
		      //  if (StrEwDisc.equals("0"))StrEwDisc="";
				//else yy+="折扣:"+StrEwDisc;
				//double youhui= rs.getDouble("youhui");
				 String discSQL="SELECT * FROM  contract_disc  WHERE  order_no='"+SecNo1+room+"' and state<>1 order by code asc";
				// out.print(discSQL);
				  rs1=ViewBean1.executeQuery(discSQL);//读取折扣数
				   while (rs1.next()){
				     yy=rs1.getString("disc_type");
				     if (yy.equals("额外折扣"))yy+=":"+rs1.getString("disc");
					 else  if (yy.equals("额外优惠"))yy+=":"+rs1.getString("youhui");
				   }
				   rs1.close();
				//  if (youhui>0)yy+="优惠:"+FormatD.getFloat2(youhui,2)+"元";
				 out.print("<td align='left'>&nbsp;"+yy+"</td>");
				  out.print("</tr>");
				  
				
			 
				
				 
			  }
		  rs.close();
                    SQL="SELECT ";
          SQL+="  d.FactMonye  factmoney,d.FactDate ,o.code,o.section,o.sectionname,o.loft+o.room_no room,c.cus_name,o.jzarea,o.date,o.rmbprice,o.youhui,o.ewdisc from order_contract o,customer c,FactAjCharges  d";
          SQL+=" where  d.contractno=o.code and  convert(char(10),d.FactDate,120)>='"+dates+"' and  convert(char(10),d.FactDate,120)<='"+dates1+"' and  o.code=d.ContractNo and o.state<>3 and c.serialno=o.customer "; 
		   if (!SecNo1.equals(""))
		  SQL+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
		 
		  SQL+="  order by o.sectionname,o.loft,o.floors,o.room,o.room_no asc,d.FactDate asc ";//group by o.sectionname+o.loft
  ResultSet rs1=null;
  int iii=0;
		    rs1=ViewBean.executeQuery(SQL); 
		   while (rs1.next()){
		   if (iii==0){
		      out.print("<tr  align='center' ><td  colspan=8>放款记录</td>");
		   
		   }iii++;
		   ii++;
                    code =rs1.getString("code");
   	                 room=getbyte(rs1.getString("room"));
                      double pr=rs1.getDouble("rmbprice");
                      double ajk=rs1.getDouble("factmoney");
		        out.print("<tr  align='center' ><td>"+ii+"</td>");
				out.print("<td>"+rs1.getDate("FactDate").toString()+"</td>");
				out.print("<td>"+getbyte(rs1.getString("cus_name"))+"</td>");
				out.print("<td>"+getbyte(rs1.getString("sectionname"))+"</td>");
				out.print("<td>"+getbyte(rs1.getString("room"))+"</td>");
				out.print("<td  align='left'>&nbsp;"+FormatD.getFloat2(pr,2)+"</td>");
				out.print("<td align='left'>&nbsp;"+FormatD.getFloat2(ajk,2)+"</td>");
			    out.print("<td align='left'>&nbsp; </td>");
				out.print("</tr>");
                               hjarea+=ajk;   
			 
                    
		   }rs1.close();
   		  %>
		  <tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;合计</td>
		  <td>&nbsp;<%=FormatD.getFloat2(rmbpri,2) %></td> <td>&nbsp;<%=FormatD.getFloat2(hjarea,2) %></td>
		<td>&nbsp;</td>
		  </tr>
		  <%
		   
				  
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
