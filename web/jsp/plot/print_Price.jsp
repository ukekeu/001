<html>

 
<head>
<title>试算价格表</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
  <%@ include file="../public_js/qx_checke.jsp"%> 
 

<body>
<% 
    String SecName=getbyte2(request.getParameter("SecName"));
    String SecNo=getbyte2(request.getParameter("SecNo"));
	String Loft= getbyte2(request.getParameter("Loft")) ;
	String Build= getbyte2(request.getParameter("Build")) ;
	String payment=getbyte2(request.getParameter("payment")) ;
    String ok= getbyte1(request.getParameter("ok")); 
	if (ok.equals("ok")){
	  String SQL="select * from  试算价目表 where paymenttype=0 and  sectionno='"+SecNo+"' and loft='"+Loft+"' and payment='"+payment+"' and building='"+Build+"'";
	  ResultSet rs1 = aBean.executeQuery(SQL);

	   while (rs1.next()){
	     String unitprice=rs1.getString("price1");
		 String tnunitprice=rs1.getString("price");
		  String price=rs1.getString("sumprice");
		  String roomno=rs1.getString("roomno");
		  String cell=rs1.getString("cell");
	     String sql="Update room set Unitprice="+unitprice+",";
		 sql+="Sumprice="+price+",room_price="+price;
		 sql+=",TNunitprice="+tnunitprice;
		 sql+=" where seccode='"+SecNo+"' and salestate=1  and cell='"+cell+"' and loft='"+Loft+"' and room_code='"+roomno+"' and building='"+Build+"'";
	     aBean1.executeUpdate(sql);
		 
	   }
	     aBean1.executeUpdate(" update 试算价目表 set state=0 where paymenttype=0 and  sectionno='"+SecNo+"' and loft='"+Loft+"' and building='"+Build+"'");
	   aBean1.executeUpdate(" update 试算价目表 set state=1,checkstate=1,userstate=1 where paymenttype=0 and  sectionno='"+SecNo+"' and loft='"+Loft+"'and building='"+Build+"'  and payment='"+payment+"'");
	   
	%>
	<script>
    alert("系统已传递价格!");	
	 opener.window.location.reload();
 	 window.close();
	</script>
	<%
	
	}else if (ok.equals("modi")){
	  String num=request.getParameter("num");
	  for (int a=1;a<=java.lang.Integer.parseInt(num);a++){
	    String jzunitprice=getbyte1(request.getParameter("jzprice"+a));
	    String sumprice=getbyte1(request.getParameter("sumprice"+a));
		String roommo=getbyte1(request.getParameter("roommo"+a));
		if (!jzunitprice.equals("")){
			String modiSQL="update 试算价目表 set price="+sumprice+"*1.0/area";
			modiSQL+=",price1="+sumprice+"*1.0/area1 ,sumprice="+sumprice;
			modiSQL+=" where paymenttype=0 and  sectionno='"+SecNo+"' and loft='"+Loft+"'and building='"+Build+"' and payment='"+payment+"' and roomno='"+roommo+"'";
		    aBean1.executeUpdate(modiSQL);
			
		}  
	  }
	
	
	
	}
 
	
 
%>
<body >
 　
<form name=frm method=post action="ContractNoM.jsp">
 

<DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
&nbsp;<input type="button" name="Button1" value="确认启用" onClick="sendtoprice();"> 
&nbsp;<input type="button" name="Button2" value="保存修改" onClick="savemodi();">&nbsp; <input type="button" name="Button1" value="导出到EXCEL" onClick="window.open('Excel_Price.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&payment=<%=payment  %>')">

 </div>
<script>
function sendtoprice(){
  if (confirm("确认传递价格到房间吗？")){
  document.frm.action="print_Price.jsp?ok=ok&SecNo=<%=getbyte2(request.getParameter("SecNo")) %>&Loft=<%=getbyte2(request.getParameter("Loft")) %>&payment=<%=payment %>";
  document.frm.submit();
  }

}
function savemodi(){
 if (confirm("确认保存当前的修改吗？")){
 
  document.frm.action="print_Price.jsp?ok=modi&SecNo=<%=getbyte2(request.getParameter("SecNo")) %>&Loft=<%=getbyte2(request.getParameter("Loft")) %>&payment=<%=payment %>&num="+document.frm.num.value;
  document.frm.submit();
  }

}
</script>
 

  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <center>
  <form name=frm method="post">
   <table width="80%" cellpadding="0" cellspacing="0" border="0"> 
<tr align="center"> <td  ><font size=3><b>试算价格一览表</b></font></td></tr> 
</table>
<br>
 <table width="80%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
     <tr   > 
		<td  align="center">序号</td>
		<td  align="center">楼层</td>
		<td  align="center">房号</td>
		<td  align="center">建筑面积</td>
		<td  align="center">建筑单价</td>
		<td  align="center">总价</td>
		</tr>
	 
	 
   </tr>
  <%
   int num=0;
   int num2=0;
   String code="";
     String sql= "select a.* from  试算价目表 a,room b where a.paymenttype=0 and  b.salestate=1 and a.sectionno+a.loft+a.roomno=b.seccode+b.loft+b.room_code and a.sectionno='"+SecNo+"' and a.loft='"+Loft+"' and payment='"+payment+"'";
   ResultSet rs = aBean.executeQuery(sql);
  int ii=1;
 while (rs.next()){
    %>
	   <input type=hidden name=roommo<%=ii %> value="<%=rs.getString("roomno") %>">
     <tr  > 
     <td  align="center"><%=ii %></td>
	<td  align="center"><%=rs.getString("floors") %></td>
 <td  align="center"><%=rs.getString("roomno") %></td>
  <td  align="center"><%=rs.getString("area1") %></td>
   <td  align="center"><input type=text size=10 name=jzprice<%=ii %> onkeydown="key(document.frm.jzprice<%=ii+1 %>);"  value="<%=rs.getString("price1") %>" onchange="document.frm.sumprice<%=ii %>.value=parseFloat(document.frm.jzprice<%=ii %>.value)*<%=rs.getString("area1") %>;"></td>
    <td  align="center"><input type=text size=10  readonly name="sumprice<%=ii %>" value="<%=rs.getString("sumprice") %>"></td>
     </tr  > 
   <% 
  
   ii++;
   
 }
rs.close();
%> 
	  </table> 
	  <input type=hidden name=num value="<%=ii %>">
	   <%sql="SELECT yong_tu,sum(area1) area,sum(sumprice) /sum(area1) avg,sum(sumprice) sumprice ,count(*) num from 试算价目表 where paymenttype=0 and  sectionno='"+SecNo+"' and loft='"+Loft+"' group by yong_tu";
	 
	rs = aBean.executeQuery(sql);
 
	 %>
 <table width="80%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
   <tr>
    <td align="center">用途</td>   
    <td align="center">面积</td>  
	<td align="center">均价</td>   
    <td align="center">总金额</td>  
    <td align="center">套数</td>
   </tr>
   <%
 int iii=0;
   while (rs.next()){ 
      String yongtu=rs.getString("yong_tu") ;
	  float countarea=rs.getFloat("area");
      iii++;
      
   %>

   <tr><td align="center"><%=yongtu%></td>
       <td align="center"><%=FormatD.getFloat(countarea,2) %></td> 
     <td align="center"><%=FormatD.getFloat(rs.getFloat("avg"),2) %></td>
	
	 <td align="center"><%=FormatD.getFloat(rs.getFloat("sumprice"),2) %></td>
	 <td align="center"><%=rs.getString("num") %></td></tr>
   </tr>
   <%}rs.close(); %>

 </table>
	  
</form>	  
</body>
</html>
