 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "ViewBean1" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>���ز���Ŀ�����ܣ��£�����</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

</head>

<body>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
<form name="frm">
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<p align="center"><font size=4><b>���ز���Ŀ�����ܣ��£�����</b></font> </p>
<table border="0" cellpadding="0" cellspacing="0"  width="99%"  >
  <tr >
  <td align="left" width="49%"><div id=w1></div></td>  <td align="right" width="49%"><div id=w2></div></td>
  </tr>
  </table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr>
    <td width="15%" colspan="6" align="center">�������</td>
    <td width="12%" colspan="4" align="center">�������÷���</td>
    <td width="18%" colspan="6" align="center">�������</td>
    <td width="35%" colspan="9" align="center">�ۼ��������</td>
    <td width="8%" align="center" colspan="2">�������</td>
  
  </tr>
  <tr>
    <td width="2%" rowspan="2" align="center">����</td>
    <td width="1%" rowspan="2" align="center">¥��</td>
    <td width="3%" rowspan="2" align="center">����ʱ��</td>
    <td width="3%" rowspan="2" align="center">���</td>
    <td width="3%" rowspan="2" align="center">����</td>
    <td width="3%" rowspan="2" align="center">�ܿ�</td>
    <td width="6%" colspan="2" align="center">����</td>
    <td width="6%" colspan="2" align="center">�ۼ�</td>
    <td width="9%" colspan="3" align="center">�Ϲ����</td>
    <td width="9%" colspan="3" align="center">ǩԼ���</td>
    <td width="11%" align="center" colspan="3">�Ϲ����</td>
    <td width="12%" align="center" colspan="3">ǩԼ���</td>
    <td width="12%" align="center" colspan="3">δ�����</td>
    <td width="4%" align="center" rowspan="2">���ܻ���</td>
    <td width="4%" align="center" rowspan="2">���ۻ���</td>
 
  </tr>
  <tr>
    <td width="3%" align="center">����</td>
    <td width="3%" align="center">����</td>
    <td width="3%" align="center">����</td>
    <td width="3%" align="center">����</td>
    <td width="3%" align="center">���</td>
    <td width="3%" align="center">����</td>
    <td width="3%" align="center">���</td>
    <td width="3%" align="center">���</td>
    <td width="3%" align="center">����</td>
    <td width="3%" align="center">���</td>
    <td width="3%" align="center">���</td>
    <td width="3%" align="center">����</td>
    <td width="3%" align="center">���</td>
    <td width="3%" align="center">���</td>
    <td width="3%" align="center">����</td>
    <td width="3%" align="center">���</td>
    <td width="3%" align="center">���</td>
    <td width="3%" align="center">����</td>
    <td width="3%" align="center">���</td>
  </tr>
<%
    String  SecNo=China.getParameter(request,"SecNo");
    String  Date1=China.getParameter(request,"Date1");
	String  Loft=China.getParameter(request,"Loft");	
	String  Date2=China.getParameter(request,"Date2");
	String sql="",code="",sectionname="";
 	ResultSet changeRS = null;
	ResultSet changeRS1 = null;
	ResultSet changeRS2 = null;
	       sql="select name from crm_project where serialno='"+SecNo+"'";
		   changeRS1 = changeListBean.executeQuery(sql);	
		   if (changeRS1.next()) {	
		   sectionname=changeRS1.getString("name");
		   }
		   changeRS1.close();
	       sql="SELECT ROOM_TYPE FROM ROOM WHERE SECCODE='"+SecNo+"'";
		  if (!Loft.equals(""))
			 sql+=" and  loft='"+Loft+"' ";
		  sql+=" group by  ROOM_TYPE order by ROOM_TYPE";
		  try{
			changeRS1 = changeListBean.executeQuery(sql);	
			  
			int i=0;
			int num=0;
			while (changeRS1.next()) {	 
			  String room_type=getbyte(changeRS1.getString("ROOM_TYPE")) ;
           //  sql="select  room_type,loft,count(*) from room where room_type='"+room_type+"' and    seccode='"+SecNo++"'   group by room_type,loft order by loft";
               sql="select loft  from room where room_type='"+room_type+"' and    seccode='"+SecNo+"' group by loft";
               int rows=0;
			   changeRS = ViewBean.executeQuery(sql);	
			   while (changeRS.next()) {	 
			      rows++;
			   }
               changeRS.close(); 
 %>
   <%   int aaa=0;
	    sql="select  loft,count(*) num ,sum(area) area,sum(sumprice) sumprice from room where room_type='"+room_type+"' and    seccode='"+SecNo+"'   group by loft order by loft";
        changeRS = ViewBean.executeQuery(sql);      
	     while (changeRS.next()) {	 
		  if (aaa==0){
	 %> 
	 <tr>
    <td width="2%" align="center" rowspan="<%=rows %>"><%=room_type%></td>
	<%}else{ %>
	  <tr>
	  <%}
	  aaa++;
	  
	  String loftstr=getbyte(changeRS.getString("loft"));
	  sql="SELECT convert(char(10),kp_date,120) kp_date,convert(char(10),kf_date,120) kf_date  FROM LoftBuildCode WHERE SecNo='"+SecNo+"' and Loft='"+loftstr+"'";
	   changeRS2 = ViewBean1.executeQuery(sql);	
	   String kp_date="";
	   if (changeRS2.next()) {	
	      kp_date=getbyte(changeRS2.getString("kp_date"));
	   }   changeRS2.close();    
	   %>
    <td width="1%" align="center"><%=loftstr %></td>
    <td width="3%" align="center"><%=kp_date %></td>
    <td width="3%" align="center"><%=getbyte(changeRS.getString("area"))%></td>
    <td width="3%" align="center"><%=getbyte(changeRS.getString("num"))%></td>
    <td width="3%" align="center"><%=FormtD.getFloat2(changeRS.getDouble("sumprice"),0)%></td>
	<%
	  sql="select count(*) num ,visitstate from customer where section='"+SecNo+"' and convert(char(10),visit_date,120)>='"+Date1+"' and  convert(char(10),visit_date,120)<='"+Date2+"' and hjsl='"+room_type+"' group by visitstate";
	  changeRS2 = ViewBean1.executeQuery(sql);	
	  int lds=0,lfs=0;
	   while  (changeRS2.next()) {	
	      String visitstate=getbyte(changeRS2.getString("visitstate"));
		  if (visitstate.equals("0"))lfs=changeRS2.getInt("num");
		  else lds=changeRS2.getInt("num");
	   }   changeRS2.close();   
	 %>
    <td width="3%" align="center"><%=lfs %></td>
    <td width="3%" align="center"><%=lds %></td>
	<%
	  sql="select count(*) num ,visitstate from customer where section='"+SecNo+"'   and hjsl='"+room_type+"' group by visitstate";
	  changeRS2 = ViewBean1.executeQuery(sql);	
	     lds=0;lfs=0;
	   while  (changeRS2.next()) {	
	      String visitstate=getbyte(changeRS2.getString("visitstate"));
		  if (visitstate.equals("0"))lfs=changeRS2.getInt("num");
		  else lds=changeRS2.getInt("num");
	   }   changeRS2.close();  
	
	  sql="select sum(jzarea) jzarea,count(*) num,sum(rmbprice) sumprice from order_contract where state=1 and convert(char(10),date,120)>='"+Date1+"' and  convert(char(10),date,120)<='"+Date2+"'  and section+loft='"+SecNo+loftstr+"'";
	  sql+=" and buildtype='"+room_type+"'";
	  int rgs=0;
	  double rgarea=0,rgj=0;
	  changeRS2 = ViewBean1.executeQuery(sql);	
	    while  (changeRS2.next()) {	
	      rgs=changeRS2.getInt("num");
		  rgarea=changeRS2.getDouble("jzarea"); 
		  rgj=changeRS2.getDouble("sumprice");  
	   }   changeRS2.close();  
	   
	   
	 %>
  <td width="3%" align="center"><%=lfs %></td>
    <td width="3%" align="center"><%=lds %></td>
 
    <td width="3%" align="center"><%=FormtD.getFloat2(rgarea,2) %></td>
	   <td width="3%" align="center"><%=rgs %></td>
    <td width="3%" align="center"><%=FormtD.getFloat2(rgj,0) %></td>
	<%
	  sql="select sum(jzarea) jzarea,count(*) num,sum(rmbprice) sumprice from order_contract where state=2  and convert(char(10),visadate,120)>='"+Date1+"' and  convert(char(10),visadate,120)<='"+Date2+"'  and section+loft='"+SecNo+loftstr+"'";
	  sql+=" and buildtype='"+room_type+"'";
	  int  qys=0;
	   double qyarea=0,qyj=0;
	  changeRS2 = ViewBean1.executeQuery(sql);	
	    while  (changeRS2.next()) {	
	      qys=changeRS2.getInt("num");
		  qyarea=changeRS2.getDouble("jzarea"); 
		  qyj=changeRS2.getDouble("sumprice");  
	   }  
	    changeRS2.close();  
	   
	//�ۼ��Ϲ�
	sql="select sum(jzarea) jzarea,count(*) num,sum(rmbprice) sumprice from order_contract where state=1 and section+loft='"+SecNo+loftstr+"'";
	  sql+=" and buildtype='"+room_type+"'";
	    rgs=0;
	    rgarea=0;rgj=0;
	  changeRS2 = ViewBean1.executeQuery(sql);	
	    while  (changeRS2.next()) {	
	      rgs=changeRS2.getInt("num");
		  rgarea=changeRS2.getDouble("jzarea"); 
		  rgj=changeRS2.getDouble("sumprice");  
	   }   changeRS2.close();  
	   
	   //�ۼ�ǩԼ
	 sql="select sum(jzarea) jzarea,count(*) num,sum(rmbprice) sumprice from order_contract where state=2  and section+loft='"+SecNo+loftstr+"'";
	  sql+=" and buildtype='"+room_type+"'";
	     qys=0;
	     qyarea=0;qyj=0;
	  changeRS2 = ViewBean1.executeQuery(sql);	
	    while  (changeRS2.next()) {	
	      qys=changeRS2.getInt("num");
		  qyarea=changeRS2.getDouble("jzarea"); 
		  qyj=changeRS2.getDouble("sumprice");  
	   }  
	    changeRS2.close();  
	
	 %>
	 <td width="3%" align="center"><%=FormtD.getFloat2(qyarea,2) %></td>
	 <td width="3%" align="center"><%=qys %></td>
    
    <td width="3%" align="center"><%=FormtD.getFloat2(qyj,0) %></td>
	
 <td width="3%" align="center"><%=FormtD.getFloat2(rgarea,2) %></td>
    <td width="3%" align="center"><%=rgs %></td>
   
    <td width="3%" align="center"><%=FormtD.getFloat2(rgj,0) %></td>
    <td width="3%" align="center"><%=FormtD.getFloat2(qyarea,2) %></td>
	<td width="3%" align="center"><%=qys %></td>
    
    <td width="3%" align="center"><%=FormtD.getFloat2(qyj,0) %></td>
	<%
	  //δ��
	 sql="select sum(area) jzarea,count(*) num,sum(sumprice) sumprice from room where salestate=1 and seccode+loft='"+SecNo+loftstr+"'";
	  sql+=" and room_type='"+room_type+"'";
	     qys=0;
	     qyarea=0;qyj=0;
	  changeRS2 = ViewBean1.executeQuery(sql);	
	    while  (changeRS2.next()) {	
	      qys=changeRS2.getInt("num");
		  qyarea=changeRS2.getDouble("jzarea"); 
		  qyj=changeRS2.getDouble("sumprice");  
	   }  
	    changeRS2.close();
	
	 %> <td width="3%" align="center"><%=FormtD.getFloat2(qyarea,2) %></td>
	<td width="3%" align="center"><%=qys %></td>
    
    <td width="3%" align="center"><%=FormtD.getFloat2(qyj,0) %></td>
	
	<%
	sql="select sum(factmoney*currrate) money from factGatheringRecord where ContractNo in (select code from order_contract where section+loft='"+SecNo+loftstr+"')";
	sql+=" and convert(char(10),Gather_Date,120)>='"+Date1+"' and  convert(char(10),Gather_Date,120)<='"+Date2+"' ";
	double sqk=0,ajk=0,ljk=0,ajk1=0;
	changeRS2 = ViewBean1.executeQuery(sql);	
	    while  (changeRS2.next()) {	
	      sqk=changeRS2.getDouble("money"); 
	   }  
	    changeRS2.close();
	sql="select sum(factmoney*currrate) money from factGatheringRecord where ContractNo in (select code from order_contract where section+loft='"+SecNo+loftstr+"')";
	 
	 
	changeRS2 = ViewBean1.executeQuery(sql);	
	    while  (changeRS2.next()) {	
	      ljk=changeRS2.getDouble("money"); 
	   }  
	    changeRS2.close();
		
		sql="select sum(FactMonye) money from FactAjCharges where contractno in (select code from order_contract where section+loft='"+SecNo+loftstr+"')";
	    sql+="and  convert(char(10),FactDate,120)>='"+Date1+"' and  convert(char(10),FactDate,120)<='"+Date2+"'";
	 
	changeRS2 = ViewBean1.executeQuery(sql);	
	    while  (changeRS2.next()) {	
	      sqk+=changeRS2.getDouble("money"); 
	   }  
	    changeRS2.close();
		
		
		sql="select sum(FactMonye) money from FactAjCharges where contractno in (select code from order_contract where section+loft='"+SecNo+loftstr+"')";
	 
	 
	changeRS2 = ViewBean1.executeQuery(sql);	
	    while  (changeRS2.next()) {	
	      ljk+=changeRS2.getDouble("money"); 
	   }  
	    changeRS2.close();
	 %>
	
    <td width="4%" align="center"><%=FormtD.getFloat2(sqk,2) %></td>
    <td width="4%" align="center"><%=FormtD.getFloat2(ljk,2) %></td>
  
  </tr>
 <%}changeRS.close(); 
 }
  
  changeRS1.close(); 
  }catch(Exception e){out.print(e);}
  %>
  <tr>
    <td width="2%" align="center">�ϼ�</td>
    <td width="1%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="3%" align="center">��</td>
    <td width="4%" align="center">��</td>
    <td width="4%" align="center">��</td>
    <td width="4%" align="center">��</td>
    <td width="4%" align="center">��</td>
    <td width="4%" align="center">��</td>
    <td width="4%" align="center">��</td>
    <td width="4%" align="center">��</td>
    <td width="4%" align="center">��</td>
    <td width="4%" align="center">��</td>
    <td width="4%" align="center">��</td>
 
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

w2.innerHTML="���ڷ�Χ��<%=Date1 %>--<%=Date2 %>      ";

</script>

</body>
</html>
