 
<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 

<html>
<head>
	<title>�ͻ�̨����ϸ��</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body>
 <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <DIV align=center id="printdiv">
<input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="������Excel">

 </div>
 <%  String SQL="";
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SecNo=China.getParameter(request,"section") ;
  String job=(String)session.getAttribute("job");	
  String datetype=China.getParameter(request,"datetype") ;
  String payment=China.getParameter(request,"payment") ;
	 if (job.indexOf("����Ա")>=0){
	    job=" and a.seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }else{job="";}
	 if (!payment.equals("")){
	    payment=" and a.payment like '%"+payment+"%'";
	 }else{payment="";}
	if (datetype.equals("1")) {
	   datetype="  and convert(char(10),a.date,120)>='"+stdate+"' and convert(char(10),a.date,120)<='"+endate+"'";
	
	}else if (datetype.equals("3")) {
	
	  datetype="  and convert(char(10),a.VisaDate,120)>='"+stdate+"' and convert(char(10),a.VisaDate,120)<='"+endate+"'";
	
	}else if (datetype.equals("2")) {
	
	  datetype="  and convert(char(10),b.csdate,120)>='"+stdate+"' and convert(char(10),b.csdate,120)<='"+endate+"'";
	
	}
   ResultSet rs=null;
  ResultSet rs1=null;
   ResultSet rs2=null;
 String sectionname="";
   List list1=new LinkedList();//���Ȩ����������
	      List list2=new LinkedList();//��ź�ͬ��
          SQL="SELECT * FROM  cq_gyrqk WHERE htno in (select code from order_contract a where a.state=2 "+datetype+payment+" and section='"+SecNo+"')";
  	       rs1 = ViewBean.executeQuery(SQL);
		while (rs1.next()){
		     list1.add(rs1.getString("cusname"));
		     list2.add(rs1.getString("htno"));
		
		  		}
		rs1.close();  
   SQL="SELECT a.code,a.sectionname,a.payment1,a.loft,a.room_no roomno,b.cus_name,b.sj+' '+b.phone phone,CONVERT(char(10),b.csdate,120) csdate ,b.address,b.ID_Card,a.jzarea,a.unitprice,CONVERT(char(10),a.date,120) date,CONVERT(char(10),a.visadate,120) visadate ,a.subscription dj,CONVERT(char(10), DATEADD(dd,";
   SQL+="a.ajtxdate,a.VisaDate), 120) ajdate,a.ajmoney,a.AjBk,CONVERT(char(10),a.ajdate,120) ajdate,a.seller,a.rmbprice-a.subscription kk,a.rmbprice ,a.code FROM order_contract a ,customer b WHERE a.customer=b.serialno and  a.state<>3  "+datetype+payment+" and a.section='"+SecNo+"' "+job+"   order by a.loft+a.room_no";
    rs1=ViewBean1.executeQuery(SQL);
 
  %>
  <div align=left id=report1  >
  <p align="center"><font size=4><b>�ͻ�̨����ϸ��</b></font> </p>
  <table border="0" cellpadding="0" cellspacing="0"  width="99%"  >
  <tr >
  <td align="left" width="49%"><div id=w1></div></td>  <td align="right" width="49%"><div id=w2></div></td>
  </tr>
  </table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="180%" id="AutoNumber1" height="100%">
  <tr align="center">
    <td  rowspan="2" height="32">���</td>
	<td  height="31" rowspan="2">�Ϲ�����</td>
    <td  rowspan="2" height="32">ǩԼ����</td>
    <td  height="31" rowspan="2">�ͻ�����</td>
    <td  height="31" rowspan="2">����</td>
    <td  height="31" rowspan="2">����</td>
    <td  height="31" rowspan="2">���</td>
    <td  height="31" rowspan="2">����</td>
    <td  height="31" rowspan="2">�ܼ�</td>
    <td  height="31" rowspan="2">���ʽ</td>
    <td width="20%" height="15" colspan="8">Ӧ�����ڿ�</td>
    <td  height="31" rowspan="2">β��</td>
    <td  height="31" rowspan="2">��ϵ�绰</td>
    <td  height="31" rowspan="2">��ϵ��ַ</td>
    <td  height="31" rowspan="2">���֤����</td>
	  <td  height="31" rowspan="2">��������</td>
    <td  height="15" colspan="2">��Ȩ���</td>
    <td  height="31" rowspan="2">��ҵ����</td>
    <td  height="31" rowspan="2">����������</td>
    <td  height="31" rowspan="2">��������</td>
    
	   <td  height="31" rowspan="2">��ע</td>
  </tr>
  <tr  align="center">
    <td  height="16">����</td>
    <td  height="16">����</td>
    <td  height="16">����</td>
    <td  height="16">��һ��</td>
    <td  height="16">����</td>
    <td  height="16">�ڶ���</td>
    <td  height="16">����</td>
    <td  height="16">������</td>
   
    <td  height="16">������</td>
	 <td  height="16">������</td>
  </tr>
  <%
     int ii=0;
    while (rs1.next()){
	  sectionname=getbyte(rs1.getString("sectionname"));
      ii++;
   %>
  <tr  align="center">
    <td  height="16"><%=ii %></td>
	 <td  height="16"><%=rs1.getString("date") %></td>
    <td  height="16"><%=getbyte(rs1.getString("visadate")) %></td>
    <td  height="16"><%=rs1.getString("cus_name") %></td>
    <td  height="16"><%=rs1.getString("loft") %></td>
    <td  height="16"><%=rs1.getString("roomno") %></td>
    <td  height="16"><%=rs1.getString("jzarea") %></td>
    <td  height="16"><%=rs1.getString("unitprice") %></td>
    <td  height="16"><%=rs1.getString("rmbprice") %></td>
    <td  height="16"><%=rs1.getString("payment1") %></td>
	<%
	//   convert(char(10),shouldDate,120)>='"+stdate+"' and convert(char(10),shouldDate,120)<='"+endate+"' and
	SQL="SELECT top 4 shouldDate,shouldMoney,state FROM GatheringRecord where  shouldQS<5 and  contactno = " +rs1.getString("code") +" order by shouldDate";
	 rs2=ViewBean2.executeQuery(SQL);
	 double yjsk=0;
	 int num=0;
	    while (rs2.next()){
		num++;
		yjsk+=rs2.getDouble("shouldMoney");
		 
		%>
		 <td  height="16"><%=rs2.getDate("shouldDate").toString() %></td>
    <td  height="16"><%=FormtD.getFloat2(rs2.getDouble("shouldMoney"),2)  %>
	<%if (rs2.getInt("state")==2) %><font color=red>��</font>
	</td>
		<%
		}
		rs2.close();
	for (int aaa=num;aaa<4;aaa++){
	// if (num<3){	 %>   
    <td  height="16"></td>
    <td  height="16"></td>
	<%} 
	
	String ID_Card= rs1.getString("ID_Card");
	
	
	%>
    
   
    
    <td  height="16"><%=rs1.getString("ajmoney") %></td>
    <td  height="16"><%=rs1.getString("phone") %></td>
    <td  height="16"><%=rs1.getString("address") %></td>
    <td  height="16"><%=ID_Card%></td>
	    <td  height="16"><%=getbyte(rs1.getString("csdate")) %></td>
	<%String sr1="",sr2="",sr3="";
	 String code=rs1.getString("code");
	 String codeValue="";
	  if (list2.contains(code)){
		   int index=list2.indexOf(code);
		   sr1=(String)list1.get(index);
		   codeValue=(String)list2.get(index+1);
		    if (codeValue.equals(code)){
			 sr2=(String)list1.get(index+1);
			
			}
		}
 
		       
	String ajdate=getbyte(rs1.getString("ajdate") );	
	if (!ajdate.equals(""))	 ajdate="�Ѱ���("+ajdate+")";  
	 %>
    <td  height="16"><%=sr1 %></td>
    <td  height="16"><%=sr2 %></td>
  
	
    <td  height="16"><%=rs1.getString("seller")  %></td>
	
    <td  height="16"><%=ajdate %></td>
    <td  height="16"><%=rs1.getString("ajbk") %></td>
   
	<td  height="16"></td>
  </tr>
  <%}
  rs1.close();
  
   %>
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
  
<script>

w1.innerHTML="¥�����ƣ�<%=sectionname %>      ";

w2.innerHTML="���ڷ�Χ��<%=stdate %>--<%=endate %>      ";

</script>

</body>
</html>
