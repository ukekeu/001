<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <html>
<head>
	<title>���ܱ�</title>��
		<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

</head>

<body>
  <DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="������Excel"> 
  <br>����������ɹ������������IE�����⣬����"Ctrl+a"���ٸ��Ƶ�EXCEL��

 </div>
  <%
  
 
 double a1=0,a2=0,a3=0,a4=0,a5=0,a6=0,a7=0,a8=0,a9=0;
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SecNo") ; 
  String yong_tu=China.getParameter(request,"yont_tu") ; 
     SectionName=SectionName.substring(0,SectionName.indexOf("|"));
  String Loft=getbyte1(request.getParameter("Loft"));
   String sql=""; 
   
  ResultSet rs=null;
  ResultSet rs1=null;
	double aa=0,bb=0,cc=0,dd=0,ff=0; 
 sql="select   payment, count(*) num,sum(rmbprice) price,sum(ajmoney) ajk from order_contract   where  yong_tu='"+yong_tu+"' and  state<>3  and section='"+SectionName+"' ";

    if (!Loft.equals(""))
	  sql+=" and  loft='"+Loft+"' ";
sql+=" group by payment";	  
	  double sumprice=0;
	  String num="0",num3="",price="";
	  int num4=0,num2=0;
	  int ajk=0;
	    rs1 = ViewBean1.executeQuery( sql ) ;
		while (rs1.next()){
		 sumprice+=rs1.getDouble("price");
		if (rs1.getString("payment").indexOf("��")>=0){
		  
		   ajk=rs1.getInt("ajk");
		   num4=rs1.getInt("num");
		}else{
		    num3=rs1.getString("num");  
			price=rs1.getString("price");  
			 
			}
		}
		rs1.close();
		
		 sql="select  sum(CurrRate*factmoney) ff,contractno from factGatheringRecord where contractno in (select   code from order_contract   where  yong_tu='"+yong_tu+"' and  state<>3  and section='"+SectionName+"' and payment like '%һ��%' ";
    if (!Loft.equals(""))
	  sql+=" and  loft='"+Loft+"' ";
	 sql+=" ) and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"'  group by  contractno";
int ycx=0;
double  ycxp=0;

	    rs1 = ViewBean1.executeQuery( sql ) ;
		while (rs1.next()){
		 ycx++;
ycxp+=rs1.getDouble("ff");
		   // num3=rs1.getString("num");  
		//	price=FormtD.getFloat3(rs1.getDouble("ff"),2);  
			 
		}
		rs1.close();
price=FormtD.getFloat3(ycxp,2); 
		num3=String.valueOf(ycx);
		sql="select  sum(CurrRate*factmoney) ff,count(*) num,contractno from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"' and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period=0 group by contractno";
       String dj="0";
	  // int a1=0;
	  // double a2=0;    
      rs1 = ViewBean1.executeQuery( sql ) ;
	  while (rs1.next()){
	     a2+=rs1.getDouble("ff");
		  a1++;
		 
		}
		num=String.valueOf((int)a1);
		dj=FormtD.getFloat3(a2,2);
		rs1.close();
		sql="select  sum(CurrRate*factmoney) ff from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period=0 and  CurrName='��' and PayType='�ֽ�'";
       String dj1="0";
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
	    aa+=rs1.getDouble("ff");
		dj1=FormtD.getFloat3(rs1.getDouble("ff"),2);
		}
		rs1.close(); 
		
		sql="select  sum(CurrRate*factmoney) ff from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period=0 and  CurrName='HKD' and PayType='�ֽ�'";
       String dj2="0";
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
	     bb+=rs1.getDouble("ff");
		dj2=FormtD.getFloat3(rs1.getDouble("ff"),2);
		}
		rs1.close(); 
		sql="select  sum(CurrRate*factmoney) ff from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period=0  and PayType='POS��'";
       String dj3="0";
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
	   cc+=rs1.getDouble("ff");
		dj3=FormtD.getFloat3(rs1.getDouble("ff"),2);
		}
		rs1.close(); 
		sql="select  sum(CurrRate*factmoney) ff from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period=0  and PayType='�տ'";
       String dj4="0";
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
	   dd+=rs1.getDouble("ff");
		dj4=FormtD.getFloat3(rs1.getDouble("ff"),2);
		}
		rs1.close();
		sql="select  sum(CurrRate*factmoney) ff from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period=0  and (PayType='֧Ʊ' or PayType='ת��')";
       String dj5="0";
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
	     ff+=rs1.getDouble("ff");
		dj5=FormtD.getFloat3(rs1.getDouble("ff"),2);
		}
		rs1.close();
		
		
		sql="select  sum(factmonye) ff,count(*) num from FactAjCharges where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),factdate,120)>='"+stdate+"' and convert(char(10),factdate,120)<='"+endate+"' ";
       String aj="0";
	   int fk=0;
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
 
	  if (rs1.next()){
		aj=getbyte(rs1.getString("ff"));
		if (aj.equals(""))aj="0";
		fk=rs1.getInt("ff");
		num2=rs1.getInt("num");
		}
		rs1.close();
		
		sql="select  sum(CurrRate*factmoney) ff,count(*) num,contractno from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"' and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period<>0 group by contractno";
       String sq="0",num1="";
	   int aaaa=0;  
	   double bbbb=0   ;
      rs1 = ViewBean1.executeQuery( sql ) ;
	  while (rs1.next()){
	    bbbb+=rs1.getDouble("ff");
	
		aaaa++;
		}
		rs1.close();
		sq=FormtD.getFloat3(bbbb,2);
		num1=String.valueOf(aaaa);
		sql="select  sum(CurrRate*factmoney) ff from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period<>0 and  CurrName='��' and PayType='�ֽ�'";
       String sq1="0";
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
	   aa+=rs1.getDouble("ff");
		sq1=FormtD.getFloat3(rs1.getDouble("ff"),2);
		}
		rs1.close(); 
		
		sql="select  sum(CurrRate*factmoney) ff from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period<>0 and  CurrName='HKD' and PayType='�ֽ�'";
       String sq2="0";
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
	     bb+=rs1.getDouble("ff");
		sq2=FormtD.getFloat3(rs1.getDouble("ff"),2);
		}
		rs1.close(); 
		sql="select  sum(CurrRate*factmoney) ff from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period<>0  and PayType='POS��'";
       String sq3="0";
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
	     cc+=rs1.getDouble("ff");
		sq3=FormtD.getFloat3(rs1.getDouble("ff"),2);
		}
		rs1.close(); 
		sql="select  sum(CurrRate*factmoney) ff from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period<>0  and PayType='�տ'";
       String sq4="0";
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
	     dd+=rs1.getDouble("ff");
		sq4=FormtD.getFloat3(rs1.getDouble("ff"),2);
		}
		rs1.close();
		sql="select  sum(CurrRate*factmoney) ff from factGatheringRecord where contractno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"'  and state<>3)   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and period<>0  and (PayType='֧Ʊ' or PayType='ת��')";
       String sq5="0";
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
	    ff+=rs1.getDouble("ff");
		sq5=FormtD.getFloat3(rs1.getDouble("ff"),2);
		}
		rs1.close();
		
	   %>
	    <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <div valign=top id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
	   <p align="center"><%=SectionName %>¥������������ܱ�</p>
�տ�ʱ��:<%=stdate %>	��<%=endate %>   
<table border="1" cellpadding="0" id=printData cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr align="center">
    <td   rowspan="2" colspan="2">���(<%=China.getParameter(request,"yont_tu") %>)</td>
    <td  rowspan="2">����</td>
    <td  rowspan="2">������</td>
    <td  colspan="5">����:�ʽ���ȡ��ϸ</td>
  </tr>
  <tr align="center">
    <td >�ֽ�</td>
    <td >�۱�</td>
    <td >���ÿ�</td>
    <td >���д�</td>
    <td >֧Ʊת��</td>
  </tr>
  <tr align="center">
    <td rowspan="4">����</td>
    <td ><%if (China.getParameter(request,"yont_tu").indexOf("סլ")>=0){out.println("�׷�");}else{out.println(China.getParameter(request,"yont_tu"));}%>����</td>
    <td ><%=num %></td>
    <td align="right"><%=dj %></td>
    <td align="right"><%=dj1 %></td>
    <td align="right"><%=dj2 %></td>
    <td align="right"><%=dj3 %></td>
    <td align="right"><%=dj4 %></td>
    <td align="right"><%=dj5 %></td>
  </tr>
  <tr align="center">
    <td><%if (China.getParameter(request,"yont_tu").indexOf("סլ")>=0){out.println("�׷�");}else{out.println(China.getParameter(request,"yont_tu"));}%>���ڿ�</td>
    <td  ><%=num1 %>��</td>
    <td align="right"><%=sq %></td>
    <td align="right"><%=sq1 %></td>
    <td align="right"><%=sq2 %></td>
    <td align="right"><%=sq3 %></td>
    <td align="right"><%=sq4 %></td>
    <td align="right"><%=sq5 %></td>
  </tr>
  <tr align="center">
    <td><%if (China.getParameter(request,"yont_tu").indexOf("סլ")>=0){out.println("�׷�");}else{out.println(China.getParameter(request,"yont_tu"));}%>���ҿ�</td>
    <td  ><%=num2 %></td>
    <td align="right"><%=aj %></td>
    <td ></td>
    <td ></td>
    <td ></td>
    <td ></td>
    <td ></td>
  </tr>
  <tr align="center">
    <td><%if (China.getParameter(request,"yont_tu").indexOf("סլ")>=0){out.println("�׷�");}else{out.println(China.getParameter(request,"yont_tu"));}%>һ���Խ���</td>
    <td ><%=num3 %></td>
    <td align="right"><%=price %></td>
    <td ></td>
    <td ></td>
    <td ></td>
    <td ></td>
    <td ></td>
  </tr>
  <%
		sql="select  sum(CurrRate*factmoney)  ff,count(*) num from factGatheringRecord where contractno in (select code from order_contract where state<>3 and yong_tu='"+yong_tu+"' and section='"+SectionName+"')   and convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' ";
       
	     double hj=0;  
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
		hj=rs1.getDouble("ff");
	 
		}
		rs1.close(); %>
  <tr align="center">
    <td  colspan="2"><font color="#ff0000">С��</font></td>
    <td >��</td>
    <td  align="right"><font color="#ff0000"><%=FormtD.getFloat3(hj+fk,2) %></font></td>
    <td  align="right"><font color="#ff0000"><%=FormtD.getFloat3(aa,2) %></font></td>
    <td  align="right"><font color="#ff0000"><%=FormtD.getFloat3(bb,2) %></font></td>
    <td  align="right"><font color="#ff0000"><%=FormtD.getFloat3(cc,2) %></font></td>
    <td  align="right"><font color="#ff0000"><%=FormtD.getFloat3(dd,2) %></font></td>
    <td  align="right"><font color="#ff0000"><%=FormtD.getFloat3(ff,2) %></font></td>��
  </tr>
 <%
     sql="select  sum(rate*shouldmoney) ff,count(*) num from GatheringRecord where contactno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"' and state<>3)   and shouldQS=0 and state<>2";
         dj="0";
	  num="0";      
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
		dj=FormtD.getFloat3(rs1.getDouble("ff"),2);
		num=rs1.getString("num");
		}
		rs1.close();
 
		
		sql="select  sum(rate*shouldmoney)-sum(yijiao) ff,count(*) num,contactno from GatheringRecord where contactno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"' and state<>3)   and shouldQS<>0 and state<>2 group by contactno";
        sq="0";num1="";
	    double b11=0;
		int b22=0; 
      rs1 = ViewBean1.executeQuery( sql ) ;
	  while (rs1.next()){
		b11+=rs1.getDouble("ff");
		 
		b22++;
		}
		rs1.close();
		sq=FormtD.getFloat3(b11,2);
		num1=String.valueOf(b22);
		sql="select  sum(rate*shouldmoney)-sum(yijiao) ff,count(*) num,contactno from GatheringRecord where contactno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"' and state<>3)     and state<>2 group by contactno";
      double wshk=0;
	       
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
		wshk=rs1.getDouble("ff");
		//num1=rs1.getString("num");
		}
		rs1.close();
		
		sql="select  sum(rate*shouldmoney) ff,count(*) num,contactno from GatheringRecord where contactno in (select code from order_contract where yong_tu='"+yong_tu+"' and section='"+SectionName+"' and payment like '%һ��%' and state<>3)    and state<>2 group by contactno";
         String w1="",w2="";
	     double ws=0;  
		 int wsn=0;
		 
      rs1 = ViewBean1.executeQuery( sql ) ;
	  while (rs1.next()){
		ws+=rs1.getDouble("ff");
		wsn++;//=rs1.getInt("num");
		}
		w2=FormtD.getFloat3(ws,2);
		rs1.close();
  %>
  <tr align="center">
    <td rowspan="4">Ӧ��δ��</td>
    <td><%if (China.getParameter(request,"yont_tu").indexOf("סլ")>=0){out.println("�׷�");}else{out.println(China.getParameter(request,"yont_tu"));}%>����</td>
    <td ><%=num %></td>
    <td  align="right"><%=dj%></td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
  </tr>
  <tr align="center">
    <td><%if (China.getParameter(request,"yont_tu").indexOf("סլ")>=0){out.println("�׷�");}else{out.println(China.getParameter(request,"yont_tu"));}%>���ڿ�</td>
    <td ><%=num1 %></td>
    <td align="right"><%=sq %></td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
  </tr>
  <tr align="center">
    <td><%if (China.getParameter(request,"yont_tu").indexOf("סլ")>=0){out.println("�׷�");}else{out.println(China.getParameter(request,"yont_tu"));}%>���ҿ�</td>
    <td  ><%=num4-num2 %></td>
    <td align="right"><%=ajk-fk %></td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
  </tr>
  <tr align="center">
    <td><%if (China.getParameter(request,"yont_tu").indexOf("סլ")>=0){out.println("�׷�");}else{out.println(China.getParameter(request,"yont_tu"));}%>һ���Խ���</td>
    <td ><%=wsn %></td></td>
    <td align="right"><%=w2 %></td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
  </tr>
  <tr align="center">
    <td  colspan="2"><font color=red>С��</font></td>
    <td >��</td>
    <td align="right"><font color=red><%=FormtD.getFloat3(wshk+(ajk-fk ),2) %></td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
  </tr>
  <tr align="center">
    <td  colspan="2"><font color=red>�ϼ�</td>
    <td >��</td>
    <td  align="right"><font color=red><%=FormtD.getFloat3(hj+fk+wshk+(ajk-fk ),2) %></td>
    <td  align="right"><font color=red><%=FormtD.getFloat3(aa,2) %>��</td>
    <td  align="right"><font color=red><%=FormtD.getFloat3(bb,2) %>��</td>
    <td  align="right"><font color=red><%=FormtD.getFloat3(cc,2) %>��</td>
    <td  align="right"><font color=red><%=FormtD.getFloat3(dd,2) %>��</td>
    <td  align="right"><font color=red><%=FormtD.getFloat3(ff,2) %>��</td>
  </tr>
  <%sql="select  sum(room_price) ff,count(*) num from room where yong_tu='"+yong_tu+"' and seccode='"+SectionName+"' and salestate=1";
           
	     
		double ws1=0;
 int  wsnum=0;
      rs1 = ViewBean1.executeQuery( sql ) ;
	  if (rs1.next()){
		ws1=rs1.getDouble("ff");
		w2=rs1.getString("num");
wsnum++;
		}
		 
		rs1.close(); %>
  <tr align="center">
    <td  colspan="2">���</td>
    <td >����</td>
    <td >Ԥ��δ��������</td>
    <td ></td>
    <td ></td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
  </tr>
  <tr align="center">
    <td>δ����</td>
    <td><%if (China.getParameter(request,"yont_tu").indexOf("סլ")>=0){out.println("�׷�");}else{out.println(China.getParameter(request,"yont_tu"));}%></td>
    <td ><%=w2 %></td>
    <td align="right"><%=FormtD.getFloat3(ws1,2) %></td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
  </tr>
  <tr align="center">
    <td colspan="2"><font color=red>�ϼ�</td>
    <td >��</td>
     <td align="right"><font color=red><%=FormtD.getFloat3(ws1,2) %></td>
    
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
    <td >��</td>
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
	 /*   var rowLen = printData.rows.length;//table��������� 

			for (var i=0;i< rowLen;i++){ 
			
			var colLen = printData.rows(i).cells.length;//table��������� 
			
			for (var j=0;j< colLen;j++)//ΪExcel��ĵ�Ԫ��ֵ 
			
			oSheet.Cells(i+1,j+1).value = printData.rows(i).cells(j).innerText;
			} 

*/
	  
	   var selectArea=document.body.createTextRange(); //�����ı����� 
        selectArea.moveToElementText(report1);//���ı�����۽���printData 
        selectArea.select();//ѡ��printData 
        selectArea.execCommand("Copy");//��printData���Ƶ����а��� 
         oSheet.Paste();//�����а��е����ݸ��Ƶ�Excel�� 
      //oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>


</body>
</html>
