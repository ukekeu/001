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
<title>�ͻ���ϸͳ�Ʊ�</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		 
			String Loft=China.getParameter(request,"Loft");
		 %>
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="������EXCEL" onClick="bringToExcel();">
 </div>
 
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

 
 <div id=titlestr><p align=center class=FontColor><font size=3><b>�ͻ��տ���ϸ��</b></font></p></div>
  �տ�ʱ��:<%=dates %>��<%=dates1 %>
 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1" height="47">
  <tr align="center">
    <td width="4%">���</td>
    <td width="4%">������</td>
    <td width="4%">��ͬ<br>���</td>
    <td width="4%">��ͬ<br>����</td>
    <td width="4%">����<br>����</td>
    <td width="4%">ǩԼ<br>����</td>
    <td width="4%">�׸�<br>����</td>
    <td width="4%">����<br>����</td>
    <td width="4%">����</td>
    <td width="4%">����</td>
    <td width="4%">Ԥ��<br>���</td>
    <td width="4%">ʵ��<br>���</td>
    <td width="4%">���<br>���</td>
    <td width="4%">����</td>
    <td width="4%">��ͬ<br>���</td>
    <td width="4%">��Ʊ<br>���</td>
    <td width="4%">����<br>���</td>
    <td width="4%">Ӧ��<br>����</td>
    <td width="4%">Ӧ��<br>����</td>
    <td width="4%">�ն���</td>
    <td width="5%">������</td>
    <td width="5%">�հ���</td>
	  <td width="5%">��/�˷�����</td>
    <td width="5%">�տ�ϼ�</td>
	
	
    <td width="5%">��ͬ��Ƿ����</td>
	 <td width="5%">Ӧ�����׷�</td>
	  <td width="5%">ʵ�����׷�</td>
	  <td width="5%">ʵ�����Ƿ����</td>
	<td width="5%">ʵ�����Ƿ����<br>�����׷�</td>
  </tr>
  
  
 
<%       double s_yssq=0;
		 double s_sssq=0;
		 double s_ssajk=0;
	     String whereSQL="";
		  String sectionName="";
		try{    
		 
		// 
		  String SQL="SELECT a.sectionname,a.code,a.loft,a.ContractNo,convert(char(10),a.date,120) date,convert(char(10),a.jldate,120) jldate,convert(char(10),a.VisaDate,120) VisaDate,b.cus_name,a.room_no,a.jzarea,a.y_jzarea,a.maap_state,a.cj_f,a.unitprice ";
		   SQL+=",a.rmbprice from order_contract a,customer b where a.state<>3 and a.customer=b.serialno";
         if (!SecNo1.equals(""))
		  SQL+=" and a.section='"+SecNo1+"'";
		 if (!Loft.equals(""))
		  SQL+=" and a.Loft='"+Loft+"' " ;
		  SQL+=" and   convert(char(10),a.date,120)<='"+dates1+"'  and  convert(char(10),a.date,120)>='"+dates+"' ";
		  SQL+="   order by  a.section+a.loft+a.room_no ";
		  ResultSet rs=ViewBean.executeQuery(SQL);
	      
		   int ii=0;
		  while (rs.next()){
		    
			   ii++;
			   ResultSet rs1=null;
			   String sql="";
			    double yssq=0;
				double sssq=0;
				double ssdj=0;
				double s_ssdj=0;
				double ssajk=0;
				sectionName=rs.getString("sectionname");
		       String code=rs.getString("code");
			          Loft=rs.getString("Loft"); 	
				String ContractNo=rs.getString("ContractNo");	  
				String date=rs.getString("date");	  
				String jldate=rs.getString("jldate");	
				String VisaDate=getbyte(rs.getString("VisaDate"));	
				String cus_name=rs.getString("cus_name");	
				String roomno=rs.getString("room_no");	
				double jzarea=rs.getDouble("jzarea");	
				double y_jzarea=rs.getDouble("y_jzarea");	
				double cj_f=rs.getDouble("cj_f");	
				String unitprice=rs.getString("unitprice");	
				double rmbprice=rs.getDouble("rmbprice");	
				String fk_date="";
			    sql="select f.FactMonye money,factdate from FactAjCharges f";
				sql+=" where  contractno in (select code from order_contract where  state=2 and  code="+code+")";
				  sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ�����ҿ�
				  while (rs1.next()){ssajk+=rs1.getDouble("money");fk_date=rs1.getDate("factdate").toString();}
				 rs1.close();
				 s_ssajk+=ssajk;
				 
				 sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in(0) ";
				 sql+=" and contractno ="+code;
				   sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//��ȡʵ���յ����ڿ�
				 while (rs1.next())ssdj+=rs1.getDouble("money");
				 rs1.close();
				 s_ssdj+=ssdj;
				 
				  sql="select  f.factmoney*f.currrate  money,gather_date from factGatheringRecord f";
				 sql+=" where f.Period in(1,2,3,4,12,13) ";
				  sql+=" and contractno ="+code; 
				   sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//��ȡʵ���յ����ڿ�
				  String sf_date="";
				 while (rs1.next()){sssq+=rs1.getDouble("money");if (!sf_date.equals(""))sf_date=rs1.getDate("gather_date").toString();}
				 rs1.close();
				 s_sssq+=sssq;
				 
				 double fp_money=0;
				 /*sql="select sum(invoice_money) money  from F_invoice where order_contract = '" + code + "'";
				   rs1=ViewBean1.executeQuery(sql);//
				   if (rs1.next()){fp_money=rs1.getDouble("money");}
				   rs1.close();
				   */
				   
				   
				    sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in (0,1,2,3,4,8,12,13) ";
				 sql+=" and contractno ="+code;
				  sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  double qqqq=0;
				  rs1=ViewBean1.executeQuery(sql);//��ȡʵ���յ����ڿ�
				 while (rs1.next())qqqq+=rs1.getDouble("money");
				 rs1.close();
				 
				 //��/�˲��
				  
				    sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in (8) ";
				 sql+=" and contractno ="+code;
				  sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  double stce=0;
				  rs1=ViewBean1.executeQuery(sql);//��ȡʵ���յ����ڿ�
				 while (rs1.next())stce+=rs1.getDouble("money");
				 rs1.close();
				    
				    sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
				 sql+=" where f.Period in (8) ";
				 sql+=" and contractno ="+code;
				  sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  double bk=0;
				  rs1=ViewBean1.executeQuery(sql);//��ȡʵ���յ����ڿ�
				 while (rs1.next())bk=rs1.getDouble("money");
				 rs1.close();
				 
				 
				     sql="select  sum(taxmoney) money  from GatheringTaxRecord where ";
				     sql+="   contactno ="+code;
				  
				  double ystaopei=0;
				  rs1=ViewBean1.executeQuery(sql);//��ȡʵ���յ����ڿ�
				 while (rs1.next())ystaopei=rs1.getDouble("money");
				 rs1.close();
				 
				     sql="select  sum(money) money  from factGatheringTaxRecord where ";
				     sql+="   contractno ="+code;
				  
				  double sstaopei=0;
				  rs1=ViewBean1.executeQuery(sql);//��ȡʵ���յ����ڿ�
				 while (rs1.next())sstaopei=rs1.getDouble("money");
				 rs1.close();
				  %>
			 <tr align="center">
			    <td width="4%"><%=ii %></td>
			    <td width="4%"><%=Loft %></td>
			    <td width="4%"><%=ContractNo %></td>
			    <td width="4%"><%=date %></td>
			    <td width="4%"><%=jldate %></td>
			    <td width="4%"><%=VisaDate %></td>
			    <td width="4%"><%=sf_date %></td>
			    <td width="4%"><%=fk_date %></td>
			    <td width="4%"><%=cus_name %></td>
			    <td width="4%"><%=roomno %></td>
			    <td width="4%"><%=jzarea %></td>
			    <td width="4%"><%if (cj_f==0)out.print(jzarea);else out.print(y_jzarea); %></td>
			    <td width="4%"><%if (cj_f!=0)out.print(FormatD.getFloat2(y_jzarea-jzarea,2));else out.print("0"); %> </td>
			    <td width="4%"><%=unitprice %></td>
			    <td width="4%"><%=rmbprice %></td>
			    <td width="4%"><%=FormatD.getFloat2(rmbprice+cj_f,0) %></td><!---ssdj-sssq-ssajk fp_money-->
			    <td width="4%"><%=FormatD.getFloat2(cj_f,0) %></td>
			    <td width="4%"><%if (cj_f<0){  out.print(FormatD.getFloat2(cj_f,0));}else{ out.println("0");} %></td>
			    <td width="4%"><%if (cj_f>0) { out.print(FormatD.getFloat2(cj_f,0)); }else{ out.println("0"); }%></td>
			    <td width="4%"><%=ssdj %></td>
			   <td width="4%"><%=sssq %></td>
			    <td width="5%"><%=ssajk %></td>
				 <td width="5%"><%=stce%></td>
			    <td width="5%"><%=qqqq+ssajk %></td>
				 
				
			    <td width="5%"><% if (qqqq+ssajk==rmbprice+cj_f||(qqqq+ssajk-rmbprice-cj_f>=-1&&qqqq+ssajk-rmbprice-cj_f<=1)){out.print("0");}else{out.print(rmbprice-(qqqq+ssajk));}%><%//=rmbprice-ssdj-sssq-ssajk+bk %> </td>
				<td width="5%"><%=ystaopei%></td>
				<td width="5%"><%=sstaopei%></td>
				 <td width="5%"><% if (qqqq+ssajk==rmbprice+cj_f||(qqqq+ssajk-rmbprice-cj_f>=-1&&qqqq+ssajk-rmbprice-cj_f<=1)){out.print("0");}else{out.print(FormatD.getFloat2(rmbprice+cj_f-qqqq-ssajk,2));}%><%//=rmbprice-ssdj-sssq-ssajk+bk %> </td>
				 <td width="5%"><%=FormatD.getFloat2(rmbprice-stce-ssdj-sssq-ssajk+cj_f+(ystaopei-sstaopei),0) %></td>
        </tr>

				  <%
		     }rs.close();
				  
		}catch(Exception s){out.print(s);}
 %>
<tr>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
    <td width="4%">��</td>
	  <td width="5%">��</td>
    <td width="5%">��</td>
    <td width="5%">��</td>
    <td width="5%">��</td>
    <td width="5%">��</td>
  </tr>
</table>
</div>

<script>
titlestr.innerHTML="<p align=center class=FontColor><font size=3><b>�տ���ϸ��</b></font></p>";
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
