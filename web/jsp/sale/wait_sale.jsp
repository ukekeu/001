  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import = "java.sql.*,common.*" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>���۲�Ʒ״��</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body>

<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
<form name="frm">
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<p align="center"><font size=4><b>���۲�Ʒ��ϸ���</b></font> </p>
<table border="0" cellpadding="0" cellspacing="0"  width="99%"  >
  <tr >
  <td align="left" width="49%"><div id=w1></div></td>  <td align="right" width="49%"><div id=w2></div></td>
  </tr>
  </table>

<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1">
  <tr>
    <td   align="center" rowspan="2">���</td>
    <td  colspan="5" align="center">����״��</td>
    <td  colspan="5" align="center">����״��</td>
    <td   rowspan="2" align="center">���������ۻ�����ԭ��</td>
    <td   rowspan="2" align="center">��Ӧ�Բ�</td>
  </tr>
  <tr>
    <td   align="center">¥��</td>
    <td   align="center">����ʱ��</td>
    <td   align="center">����</td>
    <td   align="center">���</td>
    <td   align="center">�ܼۿ�</td>
    <td   align="center">����</td>
    <td   align="center">���Ż�¥��ֲ�</td>
    <td   align="center">���</td>
    <td   align="center">����</td>
    <td   align="center">�ۿ�</td>
  </tr>

  
  <%  String endate = China.getParameter(request,"Date1") ;
      String Loft=getbyte1(request.getParameter("Loft"));
      String SecNo=China.getParameter(request,"SecNo") ;
	  String SQL="";
	  
	  int ksts=0;
	  int wsts=0;
	  double ksarea=0;
	  double wsarea=0;
	  double ksk=0;
	  double wsk=0;
	  String sectionname="";
	  ResultSet changeRS = null;
	  ResultSet changeRS1 = null;
	        SQL="SELECT NAME FROM CRM_Project WHERE SerialNo='"+SecNo+"'";
	        changeRS1 = changeListBean.executeQuery(SQL);	
			 if (changeRS1.next()) {
			     sectionname=changeRS1.getString("NAME");
			}
			changeRS1.close();	 
	         SQL="SELECT Loft,convert(char(10),kp_date,120) kp_date  FROM LoftBuildCode WHERE SecNo='"+SecNo+"' GROUP BY Loft ,convert(char(10),kp_date,120) order by loft";
	          if (!Loft.equals("")) 
			  SQL+=" AND loft='"+Loft+"'";
			   
			   try{
	           changeRS1 = changeListBean.executeQuery(SQL);	
			   int i=0;
	
	          while (changeRS1.next()) {
			     i++;
			      Loft=changeRS1.getString("Loft");
	          SQL="SELECT a.loft  ,count(*) num,sum(area) area,sum(sumprice) sumprice FROM room a   where  a.seccode='"+SecNo+"'";
			  
			  SQL+=" AND a.loft='"+Loft+"' group by a.loft";
			     changeRS = ViewBean.executeQuery(SQL);	
				 
    %>
			 <tr>
			 <% if (changeRS.next()) {
			 
			   ksts+=changeRS.getInt("num"); 
			   double aa=changeRS.getDouble("area"); 
			   ksarea+=aa; 
			   double bb=changeRS.getDouble("sumprice"); 
			   ksk+=bb;
			  %>
			    <td   align="center"><%=i %></td>
			    <td   align="center"><%=Loft %></td>
			    <td   align="center"><%= getbyte(changeRS1.getString("kp_date"))%></td>
			    <td   align="center"><%= getbyte(changeRS.getString("num"))%></td>
			    <td   align="center"><%=  FormtD.getFloat2(aa,2)%></td>
			    <td   align="center"><%= FormtD.getFloat2(bb,0)%></td>
			<%}changeRS.close();
			 SQL="SELECT a.loft,count(*) num,sum(area) area,sum(sumprice) sumprice FROM room a  where  a.seccode+a.loft+a.room_code not in  (select section+loft+room_no from order_contract where section='"+SecNo+"' and convert(char(10),date,120) <='"+endate+"') and a.seccode='"+SecNo+"'";
			 
			  SQL+=" AND a.loft=(select loft from LoftBuildCode where SecNo='"+SecNo+"' and ysxkz<>'' and loft='"+Loft+"' group by loft) group by  a.loft";
			     changeRS = ViewBean.executeQuery(SQL);	
			   double aa=0;
			   double bb=0;
			   int num=0;
			 if (changeRS.next()) { 
			    num=changeRS.getInt("num");
			   wsts+=num;
			   aa=changeRS.getDouble("area"); 
			    wsarea+=aa;
			    bb=changeRS.getDouble("sumprice"); 
			     wsk+=bb;
			 }changeRS.close(); 
			 
			 SQL="SELECT a.floor,count(*) num FROM room a  where  a.seccode+a.loft+a.room_code not in  (select section+loft+room_no from order_contract where section='"+SecNo+"' and convert(char(10),date,120) <='"+endate+"') and a.seccode='"+SecNo+"'";
			 
			  SQL+=" AND a.loft=(select loft from LoftBuildCode where SecNo='"+SecNo+"' and ysxkz<>'' and loft='"+Loft+"' group by loft) group by  a.floor";
			  
			      changeRS = ViewBean.executeQuery(SQL);	
			 
			 %>	
				
			    <td   align="center"><%=num %></td>
			    <td   align="center">
				<%
				
				   while (changeRS.next()) { 
				    out.print(changeRS.getString("floor")+"¥"+changeRS.getString("num")+"�ס�");
				
				 }
				 changeRS.close(); 
				 %></td>
			    <td   align="center"><%= FormtD.getFloat2(aa,2)%></td>
			    <td   align="center">
				<% SQL="SELECT a.roomtype,count(*) num FROM room a  where  a.seccode+a.loft+a.room_code not in  (select section+loft+room_no from order_contract where section='"+SecNo+"' and convert(char(10),date,120) <='"+endate+"') and a.seccode='"+SecNo+"'";
			 
			  SQL+=" AND a.loft=(select loft from LoftBuildCode where SecNo='"+SecNo+"' and ysxkz<>'' and loft='"+Loft+"' group by loft) group by  a.roomtype";
			  
			      changeRS = ViewBean.executeQuery(SQL);	
				  
				
				   while (changeRS.next()) { 
				    out.print(changeRS.getString("roomtype")+changeRS.getString("num")+"�ס�");
				
				 }
				 changeRS.close(); 
				  
			    %>
				</td>
			    <td   align="center"><%= FormtD.getFloat2(aa,0)%></td>
			    <td   align="center">��</td>
			    <td   align="center">��</td>
				
            </tr> 

					   <% }
	 changeRS1.close();
	}catch(Exception e){out.print(e);} %>
					
					<tr align="center">
					<td>�ϼƣ�</td>
					<td></td>
					<td></td>
					<td><%=ksts %></td>
					<td><%=FormtD.getFloat2(ksarea,2) %></td>
					<td><%=FormtD.getFloat2(ksk,0) %></td>
			 
					<td><%=wsts %></td>
					<td> </td>
					<td><%=FormtD.getFloat2(wsarea,2) %></td>
					<td></td>
					<td><%=FormtD.getFloat2(wsk,0) %></td>
					<td> </td>
					</tr>
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
</script>
<p align="center"> <div   id="divprint" align="center"><input type="button" name="Button" value="��ӡԤ��"  title="��ӡǰ�����������¥����" onClick="window.divprint.style.display='none';javascript:document.frm.WebBrowser.ExecWB(7,1);window.divprint.style.display='block'"> <input type="button" onclick="bringToExcel()" value="������Excel"><br>
����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"<br>
��2.ѡ��"��ȫ"->ѡ��"����intranet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>
 
<script>

w1.innerHTML="¥�����ƣ�<%=sectionname %>      ";

w2.innerHTML="��ֹ���ڣ�<%=endate %>    ";

</script>
</body>
</html>
