<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>�����տ�Ǽ�</title>
</head>
<body>
 <%@ page language="java" import="java.sql.*,java.util.Date,java.lang.*,java.util.*,common.*"%>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="tBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="fat" scope="page" class="FormatData.FormatData"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
 <%
 setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�˿�Ǽ�" , 
                  "����"
                ) ;
//ȡ��FORM�������������

String strCusNo=China.getParameter(request,"CusNo");
String type=China.getParameter(request,"type");
String StrFactNo=China.getParameter(request,"FactNo");
String strPeriod=type;//China.getParameter(request,"Period");
String strysmoney=request.getParameter("ysmoney");
String strGatherDate=request.getParameter("Date1");//+"-"+request.getParameter("BeginMonth")+"-"+request.getParameter("BeginDay");
String strFactMoney=request.getParameter("FactMoney");
String strBillType=China.getParameter(request,"BillType");
String strBillNum=China.getParameter(request,"BillNum");	
String strReceiver=China.getParameter(request,"Receiver");
String PayType=China.getParameter(request,"PayType");
String PayTypeNo=China.getParameter(request,"PayTypeNo");
//��ǰ����ıұ�
String CurrName=China.getParameter(request,"curry");
String CurrRate=China.getParameter(request,"rate");
//��ͬ�еıұ�
String ycurry=request.getParameter("ycurry");
String yrate=request.getParameter("yrate");

String Print=China.getParameter(request,"Print");
String loft=China.getParameter(request,"loft");
String txt=China.getParameter(request,"context");//bak
String signatory=China.getParameter(request,"signatory");
//�ж��Ƕ�����¥��
//if (Float.parseFloat(strFactMoney)<=Float.parseFloat(strysmoney)){
//    strPeriod="0";
//}else strPeriod="1";
String huanshuanMoney="";//�ѵ�ǰ����ıұ���Ϊ��ͬ���Ӧ�ıұ���
 
	if (Float.parseFloat(CurrRate)<Float.parseFloat(yrate)){
	  huanshuanMoney=String.valueOf(fat.getFloat1(Integer.parseInt(strFactMoney)/Float.parseFloat(yrate),2));
	}else if (Float.parseFloat(CurrRate)>Float.parseFloat(yrate)){
	  huanshuanMoney=String.valueOf(fat.getFloat1(Integer.parseInt(strFactMoney)*Float.parseFloat(CurrRate),2));
	}else{
	  huanshuanMoney=strFactMoney;
	}
   
	String curryDX="",context="",sjcontext="",payment="";
	if (CurrName.equals("��"))curryDX="�����";
	if (CurrName.equals("HKD"))curryDX="�۱�";
	if (CurrName.equals("USD"))curryDX="��Ԫ";
	String upSQL="";
//ʵ�ʽ���

ResultSet execRs1=null;
String upperMoney1="";
execRs1=tBean.executeQuery("exec dbo.L2U "+strFactMoney+",0 ");//��д���ת���洢����
if (execRs1.next())
upperMoney1=getbyte(execRs1.getString("dd"));
execRs1.close();
        upSQL="insert into FactGatheringRecord (cusno,Period,"; 
        upSQL+="Gather_Date,factmoney,Bill_Num,Receiver,BillType,CurrName";
        upSQL+=",CurrRate,PayType,PayTypeNo,UppMoney,contractno,context)values ";
        upSQL+="('"+strCusNo+"',"+type+",'"+strGatherDate+"',";
  	upSQL+=strFactMoney+",'"+strBillNum+"','"+strReceiver+"',"+strBillType+",'";

upSQL+=CurrName+"',"+CurrRate+",'"+PayType+"','"+PayTypeNo+"','"+curryDX+upperMoney1+"','";
	    upSQL+= StrFactNo + "','"+txt+"')";

	    tBean.executeUpdate( upSQL ) ;//ʵ�ʽ���
	
	     
	ResultSet execRs=null;
	String upperMoney="";
	execRs=tBean.executeQuery("exec dbo.L2U "+request.getParameter("FactMoney")+",0 ");//��д���ת���洢����
	if (execRs.next())
	upperMoney=getbyte(execRs.getString("dd"));
	execRs.close();
	    
	
	
	if (strPeriod.equals("0"))context="�ջؽ�";
	else context="�ջؽ�";
	
    sjcontext="insert into printsksj(customer,payment,context,money1"
	+",money2,rate,checker,txt) values('"+signatory+"','"+payment+"','"+context+"("+loft+")�����"
	+"','"+curryDX+upperMoney+"',"+request.getParameter("FactMoney")+","+CurrRate+","
	+"'"+strReceiver+"','"+txt+"')";
	
	tBean.executeUpdate( "delete  printsksj" ) ;
	tBean.executeUpdate( sjcontext) ;
	 
    		
	%> 
	
	 


<script>
  opener.window.location.reload(); 
  window.close();
</script>
<center>
<a href="../voucher/createxml.jsp" >�����տ����ϵͳ��</a>&nbsp;&nbsp;&nbsp;<a href="#" onclick="window.close()">�� ��</a>
</center>
</body>
</html>
