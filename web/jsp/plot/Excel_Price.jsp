<html>

 
<head>
<title>����۸��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*,common.*" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
  <%@ include file="../public_js/qx_checke.jsp"%>
  
  
 

<body>
<% 
    String SecName=getbyte2(request.getParameter("SecName"));
    String SecNo=getbyte2(request.getParameter("SecNo"));
	String Loft= getbyte2(request.getParameter("Loft") );
	String payment=getbyte2(request.getParameter("payment")) ;
    String ok= getbyte1(request.getParameter("ok")); 
	if (ok.equals("ok")){
	  String SQL="select * from  �����Ŀ�� where sectionno='"+SecNo+"' and loft='"+Loft+"' and payment='"+payment+"'";
	  ResultSet rs1 = aBean.executeQuery(SQL);

	   while (rs1.next()){
	     String unitprice=rs1.getString("price1");
		 String tnunitprice=rs1.getString("price");
		  String price=rs1.getString("sumprice");
		  String roomno=rs1.getString("roomno");
	     String sql="Update room set Unitprice="+unitprice+",Y_Unitprice="+unitprice+",";
		 sql+="Sumprice="+price+",Y_Sumprice="+price+",room_price="+price;
		 sql+=",TNunitprice="+tnunitprice+",Y_TNunitprice="+tnunitprice;
		 sql+=" where seccode='"+SecNo+"' and loft='"+Loft+"' and room_code='"+roomno+"'";
	     aBean1.executeUpdate(sql);
		 out.print(sql+"<br><br>");
	   }
	   aBean1.executeUpdate(" update �����Ŀ�� set state=1 where sectionno='"+SecNo+"' and loft='"+Loft+"' and payment='"+payment+"'");
	   
	%>
	<script>
    alert("ϵͳ�Ѵ��ݼ۸�!");	
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
			String modiSQL="update �����Ŀ�� set price="+sumprice+"*1.0/area";
			modiSQL+=",price1="+sumprice+"*1.0/area1 ,sumprice="+sumprice;
			modiSQL+=" where sectionno='"+SecNo+"' and loft='"+Loft+"' and payment='"+payment+"' and roomno='"+roommo+"'";
		    aBean1.executeUpdate(modiSQL);
			
		}  
	  }
	
	
	
	}
 
	
 
%>
<body >
 ��
<form name=frm method=post action="ContractNoM.jsp">
 
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

  <center>
  <form name=frm method="post">
   <table width="80%" cellpadding="0" cellspacing="0" border="0"> 
<tr align="center"> <td  ><font size=3><b>����۸�һ����</b></font></td></tr> 
</table>
<br>
 <table width="80%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
     <tr   > 
		<td  align="center">���</td>
		<td  align="center">¥��</td>
		<td  align="center">����</td>
		<td  align="center">�������</td>
		<td  align="center">��������</td>
		<td  align="center">�ܼ�</td>
		</tr>
	 
	 
   </tr>
  <%
   int num=0;
   int num2=0;
   String code="";
     String sql= "select * from  �����Ŀ�� where sectionno='"+SecNo+"' and loft='"+Loft+"' and payment='"+payment+"'";
   ResultSet rs = aBean.executeQuery(sql);
  int ii=1;
 while (rs.next()){
    %>
	   <tr  > 
     <td  align="center"><%=ii %></td>
	<td  align="center"><%=rs.getString("floors") %></td>
 <td  align="center"><%=rs.getString("roomno") %></td>
  <td  align="center"><%=rs.getString("area1") %></td>
   <td  align="center"><%=rs.getString("price1") %></td>
    <td  align="center"> <%=rs.getString("sumprice") %></td>
     </tr  > 
   <% 
  
   ii++;
   
 }
rs.close();
%> 
	  </table> 
	  
	   <%sql="SELECT yong_tu,sum(area1) area,sum(sumprice) /sum(area1) avg,sum(sumprice) sumprice ,count(*) num from �����Ŀ�� where sectionno='"+SecNo+"' and loft='"+Loft+"' and payment='"+payment+"' group by yong_tu";
	 
	rs = aBean.executeQuery(sql);
 
	 %>
 <table width="80%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
   <tr>
    <td align="center">��;</td>   
    <td align="center">���</td>  
	<td align="center">����</td>   
    <td align="center">�ܽ��</td>  
    <td align="center">����</td>
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
        var selectArea=document.body.createTextRange(); //�����ı����� 
        selectArea.moveToElementText(report1);//���ı�����۽���printData 
        selectArea.select();//ѡ��printData 
        selectArea.execCommand("Copy");//��printData���Ƶ����а��� 
         oSheet.Paste();//�����а��е����ݸ��Ƶ�Excel��    
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 bringToExcel();
 window.close();
 
</script>	  
</body>
</html>
