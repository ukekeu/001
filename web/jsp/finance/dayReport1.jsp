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
<title>�����ۼ�¼�տ��ձ�</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		String okcheckstate=China.getParameter(request,"checkstate");
		String Loft=China.getParameter(request,"Loft");
	 %>
		 
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="������EXCEL" onClick="bringToExcel();">
 </div>
 
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
<div id=titlestr><p align=center class=FontColor><font size=3><b>�����ۼ�¼�տ��ձ���ϸ��</b></font></p></div>
 
 
 ʱ��:<%=dates %>��<%=dates1 %>
 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1" height="47">
  <tr align="center">
    <td width="4%">���</td> 
    <td width="4%">����</td>
    <td width="4%">����</td>
    <td width="4%">���</td>
    <td width="4%">�ܼ�</td>
 
    <td width="4%">�վݺ�</td>
     
    <td width="4%">�վݽ��</td>
 
    <td width="4%">�տ�����</td>
	<td width="4%">�տ���Ŀ</td>
    <td width="4%">���ʽ</td> 
	   <td width="4%">��ע</td> 
  </tr>
    <%@ include file="../public_js/CheckSection.jsp"%>
		 <%
		  String secName="";
		   int ii=0;
		     
   double skhj=0; 
      String Wheresql="select SerialNo,Name from CRM_Project "+FindWhere;
    if (!SecNo1.equals(""))
		  Wheresql+=" and SerialNo='"+SecNo1+"'";
     ResultSet rs1=ViewBean1.executeQuery(Wheresql);
    while (rs1.next()){
         SecNo1=rs1.getString("SerialNo");
		 secName=rs1.getString("Name");		
		
         try{    
		  String SQL="SELECT b.*,a.area";
		   SQL+=" from linshi_sk b ,room a   where  a.seccode+a.loft+a.room_code = b.sectionno+b.loft+b.room_code ";
         if (!SecNo1.equals(""))
		  SQL+="  and  b.sectionno='"+SecNo1+"'";
		 if (!Loft.equals(""))
		  SQL+=" and b.Loft='"+Loft+"' " ;		  
		  SQL+=" and  convert(char(10),b.sk_date,120)>='"+dates+"' and  convert(char(10),b.sk_date,120)<='"+dates1+"'";
		  SQL+="   order by  b.sectionno+b.loft+b.room_code ,b.sk_date ";
		  ResultSet rs=ViewBean.executeQuery(SQL);
	      int salestate=0;
		  
		  while (rs.next()){
		    			   ii++;
				String htcode=rs.getString("code");
				salestate=rs.getInt("state");
			    
			    double sk=rs.getDouble("sk_money");
				skhj+=sk;
				String period = rs.getString( "sk_type" ) ;
			    if (period.equals("0"))period ="����";
				else if (period.equals("1")) period ="����";
				int checkstate=rs.getInt("state");
				String jsbak=getbyte(rs.getString("bak"));
			  
			   
				  %>
			 <tr align="center">
			    <td width="1%"><%=ii %></td>
			    <td width="8%"><%=rs.getString("cus_name") %></td>
			    <td width="4%"><%=rs.getString("room_code")  %></td>
			    <td width="4%"><%=rs.getString("area") %></td>
			    
			    <td width="4%"><%=rs.getString("rmbprice") %></td>
			    
			    <td width="4%">&nbsp;<%=rs.getString("sk_no") %></td>
			    <td width="4%" align="right"><%=FormatD.getFloat2(sk,2) %></td>
				
				 
			    <td width="4%"><%=getbyte(rs.getDate("sk_date").toString()) %></td>
				<td width="4%"><%=period %></td>
			    <td width="4%"><%=rs.getString("pay_type") %></td>
			      <td width="4%"><%=jsbak %>&nbsp;</td>
			        </tr>

				  <%
		     }rs.close();
				  
		}catch(Exception s){out.print(s);}  
		%>
		<tr><td>�ϼ�:</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
		<td>&nbsp;</td><td align="right"><%=FormatD.getFloat2(skhj,2)%></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
		</tr>
		<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1" height="47">
 
      <tr ><td colspan="2" align="center">�ɿ����С��</td>
 
    <td   colspan="11" >&nbsp;</td>
   
  </tr>
  <% SecNo1=China.getParameter(request,"SecNo");
	  
		String  SQL="SELECT pay_type ,sum(sk_money*CurrRate) money ";
		   SQL+="  from linshi_sk where CODE>0  ";
         
if (!SecNo1.equals(""))
		  SQL+="  AND  sectionno='"+SecNo1+"'";
		 if (!Loft.equals(""))
		  SQL+=" and Loft='"+Loft+"' " ;
		 SQL+=" and  convert(char(10),sk_date,120)>='"+dates+"' and  convert(char(10),sk_date,120)<='"+dates1+"'";
			 SQL+=" group by  pay_type";	
		 
		 ResultSet   rs=ViewBean.executeQuery(SQL);
		 
		 while (rs.next()){
	 	
		  %>
      <tr align="center">
  <td   >&nbsp;<%=rs.getString("pay_type") %></td>
  <td   ><%=FormatD.getFloat2(rs.getDouble("money"),2) %></td>
  <td   colspan="11" >&nbsp;</td>
  </tr>
  <%}rs.close(); 
  
  }rs1.close();%>
  <tr align="center"><td>�ϼ�:</td><td ><%=FormatD.getFloat2(skhj,2)%></td></tr> 
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
    var selectArea=document.body.createTextRange(); //�����ı����� 
        selectArea.moveToElementText(report1);//���ı�����۽���printData 
        selectArea.select();//ѡ��printData 
        selectArea.execCommand("Copy");//��printData���Ƶ����а��� 
         oSheet.Paste();//�����а��е����ݸ��Ƶ�Excel��       
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 
 
</script>
</body>
</html>
