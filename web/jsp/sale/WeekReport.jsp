 
 <%@ page contentType="text/html;charset=GBK" %>
 
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/CheckSection.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>����</title>
</head>
<body  oncontextmenu="return false"  >
<%
String type=request.getParameter("type");
if (type==null)type="";
if (type.equals("1"))type="�ܱ�";
else type="�±�";
String secName=getbyte1(request.getParameter("secName"));
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String sectionNo=getbyte1(request.getParameter("SecNo"));
 

	
	 String up="";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==1)up="һ";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==2)up="��";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==3)up="��";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==4)up="��";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==5)up="��";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==6)up="��";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==7)up="��";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==8)up="��";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==9)up="��";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==10)up="ʮ";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==11)up="ʮһ";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==12)up="ʮ��"; 
 %>
 
<DIV align=center id="printdiv">
<input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'"><input type="button" onclick="bringToExcel()" value="������Excel"><br>

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

<table><tr><td>
��һ�ε���ǰ���������Ӧ���ã�<br>
  1.��IE�汾������IE5.5����<br>
��2.��IE��������ѡ��"internetѡ��"<br>
��3.ѡ��"��ȫ"->ѡ��"intranet"���ٵ��"�Զ��弶��"<br>
  4.������ActiveX���õĶ�ѡΪ���á�<br>
  </td></tr></table>
 </div>
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable>
<object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<table width="99%" cellspacing="0" cellpadding="0">
 <tr align="center" ><td  ><b><font size=4><%=secName+up %>������<%=type %>��</font></b> </td></tr>
</table>

ʱ���:<%=Date1 %> ��<%=Date2 %> (��Ԫ)
 <table width="99%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td>¥������</td>
    <td>¥��</td>
    <td>�������M<sup>2</sup></td>
    <td>��������</td>
    <td>�Ϲ����M<sup>2</sup></td>
    <td>�Ϲ�����</td>
    <td>�Ϲ��ܽ��</td>
    <td>�ۼ��Ϲ�<br>���M<sup>2</sup></td>
    <td>�ۼ��Ϲ�<br>����</td>
    <td>�ۼ��Ϲ�<br>���</td>
    <td>���۾���</td>
    <td>������</td>
    <td>�����տ��</td>
    <td>�ۼ��տ��</td>
  </tr>
  <%
 try{
 if (!sectionNo.equals(""))sectionNo= " and serialno='"+sectionNo+"'";
 String  Sql="select SerialNo,Name FROM crm_project "+FindWhere+sectionNo+" group by  Name,SerialNo order by name";;
  ResultSet rs2=ViewBean1.executeQuery(Sql);
  while (rs2.next()){
   String SectionNo=rs2.getString("SerialNo");
   String SectionName=getbyte(rs2.getString("Name"));
   int  nn=0;
   double SumJzArea=0;
   String SQL="";
   SQL="SELECT loft,count(*) aa FROM Room r,crm_project s where r.seccode=s.serialno  and r.seccode='"+SectionNo+"'  group by loft order by loft ";//and s.name like '%סլ%'
	  ResultSet rs=ViewBean2.executeQuery(SQL);

   int num=0;
   double sumarea_ks=0;
   int sumnum_ks=0;
   double sumarea_rg=0;
   int sumnum_rg=0;
   int summoney_rg=0;
   int sumnum_ljrg=0;
   double sumarea_ljrg=0;
   int summoney_ljrg=0;
   int avg=0;
   double rate=0;
   double w_sk=0;
   double lj_sk=0;
   while (rs.next()){
    num++;
   }
rs.close();
	SQL="SELECT loft,sum(area) area,count(*) aa FROM Room r,crm_project s where r.seccode=s.serialno  and r.seccode='"+SectionNo+"' group by loft order by loft ";//and s.name like '%סլ%'
	    rs=ViewBean2.executeQuery(SQL);
  String roomtype="";
  double SumArea=0;
  int SumPrice=0;
  int y=0;
   while (rs.next()){
   String loft=getbyte(rs.getString("loft"));
   SumJzArea=rs.getDouble("area");
   sumarea_ks+=SumJzArea;
   int ts=rs.getInt("aa");
   sumnum_ks+=ts;
  
  
   %>
  <tr align="right"> 
  <%if (y==0){ %> <td rowspan="<%=num %>" align="center"><%=SectionName %></td><%} %>
    <td align="center"><%=loft %></td>
    <td><%=Format.getFloat2(SumJzArea ,3)%>&nbsp;</td>
    <td><%=ts%>&nbsp;</td>

 <% y=1; 
    int ddd=0;
	double areaNum=0;
	double price=0;
	try{
	SQL="SELECT COUNT(*) num ,sum(jzarea) area,sum(rmbprice) price from order_contract where state<>3 and loft='"+loft+"' and  substring(CONVERT(char(24), date, 120),1,10)>='"+Date1+"' and   substring(CONVERT(char(24), date, 120),1,10)<='"+Date2+"' and section='"+SectionNo+"'";
 
	 ResultSet rs1=ViewBean.executeQuery(SQL);
	
	 if (rs1.next()){
	   ddd=rs1.getInt("num");
	   if (ddd!=0){
	    areaNum=rs1.getDouble("area");
	    price=rs1.getDouble("price");
	    sumarea_rg+=areaNum;
	    sumnum_rg+=ddd;
	    summoney_rg+=price;
	   }
	   
    }
	rs1.close();
	//
	 
	}catch(Exception s){out.print(SQL+s.getMessage());}
	 %>
    <td><%=Format.getFloat2(areaNum,3) %>&nbsp;</td>
    <td><%=ddd %>&nbsp;</td>
	<td><%=Format.getFloat2(price,2) %>&nbsp;</td>
	<%
	ddd=0;
	areaNum=0;
	price=0;
	 SumArea=0;
	 SumPrice=0;
	try{
	SQL="SELECT COUNT(*) num ,sum(jzarea) area,sum(rmbprice) price from order_contract where  state<>3 and  loft='"+loft+"' and section='"+SectionNo+"'";
	 ResultSet rs1=ViewBean.executeQuery(SQL);
	 if (rs1.next()){
	   ddd=rs1.getInt("num");
	   if (ddd!=0){
	   areaNum=rs1.getDouble("area");
	   price=rs1.getDouble("price");
	    sumarea_ljrg+=areaNum;
	    sumnum_ljrg+=ddd;
	    summoney_ljrg+=price;
	   }
     }
	 rs1.close();
 
	SumArea+=areaNum;
	SumPrice+=price;

	 %>
    <td><%=Format.getFloat2(areaNum,3) %>&nbsp;</td>
    <td><%=ddd %>&nbsp;</td>
  	<td><%=Format.getFloat2(price,2) %>&nbsp;</td>
    <td><%if (SumPrice>0){out.print(Format.getFloat2(SumPrice/SumArea,0));}else{out.print("&nbsp;");}%>&nbsp;</td>
    <td><%=Format.getFloat2((SumArea/SumJzArea)*100,3) %>%&nbsp;</td>
	<%
	
	SQL="SELECT sum(f.factmoney*f.CurrRate) price  from FactGatheringRecord f,order_contract o  where o.state<>3 and  o.code = f.contractno and o.loft='"+loft+"' and  substring(CONVERT(char(24), f.Gather_Date, 120),1,10)>='"+Date1+"' and   substring(CONVERT(char(24), f.Gather_Date, 120),1,10)<='"+Date2+"' and o.section='"+SectionNo+"'";
    double factMoney=0;
	 rs1=ViewBean.executeQuery(SQL);
	 if (rs1.next()){
	   String aa=rs1.getString("price");
	   if (aa!=null){factMoney=Double.parseDouble(aa);w_sk+=factMoney;}
	  }
	   rs1.close();
	  //���ܷſ�
	    SQL="select sum(f.FactMonye) fact from FactAjCharges f ,order_contract o";
		SQL+=" where o.state<>3 and  o.code = f.contractno and o.loft='"+loft+"' ";
		SQL+=" and  convert(char(10),f.FactDate,120)>='"+Date1+"' and  convert(char(10),f.FactDate,120)<='"+Date2+"' and o.section='"+SectionNo+"'";
	    rs1=ViewBean.executeQuery(SQL);//��ȡ�����ҿ�
		double ajk=0;
		while (rs1.next())
		  ajk+=rs1.getDouble("fact");
	   rs1.close();
	   w_sk+=ajk;
	  
	  %>
    <td><%=Format.getFloat2(factMoney+ajk,2) %>&nbsp;</td>
	<%
	
	 
	SQL="SELECT sum(f.factmoney*f.CurrRate) price  from FactGatheringRecord f,order_contract o  where o.state<>3 and  o.code = f.contractno and o.loft='"+loft+"' and o.section='"+SectionNo+"'";
      factMoney=0;
	 rs1=ViewBean.executeQuery(SQL);
	 if (rs1.next()){
	  String aa=rs1.getString("price");
	  if (aa!=null){factMoney=Double.parseDouble(aa);lj_sk+=factMoney;}
	  }  rs1.close();
	  
	  //�ۼƷſ�
	    SQL="select sum(f.FactMonye) fact from FactAjCharges f ,order_contract o";
		SQL+=" where o.state<>3 and  o.code = f.contractno and o.loft='"+loft+"' ";
		SQL+=" and    o.section='"+SectionNo+"'";
	    rs1=ViewBean.executeQuery(SQL);//��ȡ�����ҿ�
		  ajk=0;
		while (rs1.next())
		  ajk+=rs1.getDouble("fact");
		  lj_sk+=ajk;
	   rs1.close();
	  %>
  <td><%=factMoney+ajk %>&nbsp;</td>
  <%}catch(Exception s){out.print(SQL+s.getMessage());} %>
  </tr>
  <%
    } rs.close();
   %>
   <tr bgcolor='#EAECEC' align="right"><td align="center">С�ƣ�</td><td>&nbsp;</td><td><%=Format.getFloat2(sumarea_ks,3) %>&nbsp;</td><td><%=sumnum_ks %></td><td><%=Format.getFloat2(sumarea_rg,3) %>&nbsp;</td><td><%=sumnum_rg %></td><td><%=Format.getFloat2(summoney_rg,2) %>&nbsp;</td><td><%=Format.getFloat2(sumarea_ljrg,3) %></td><td><%=sumnum_ljrg %>&nbsp;</td><td><%=Format.getFloat2(summoney_ljrg,2) %>&nbsp;</td><td><%=Format.getFloat2(summoney_ljrg/sumarea_ljrg,0) %>&nbsp;</td>
<td><%=Format.getFloat2(sumarea_ljrg/sumarea_ks*100,2) %>%&nbsp;</td>
<td><%=Format.getFloat2(w_sk,2) %>&nbsp;</td><td><%=Format.getFloat2(lj_sk,2) %>&nbsp;</td>
</tr>
   <% 
	}rs2.close();
 }catch(Exception s){out.print(s.getMessage());} %>
 
 
  
  
  
</table>

<p>˵��:(1)������=�ۼ��Ϲ����/�������*100%   (2)����=�ۼ��Ϲ����/�ۼ��Ϲ����</p>
 </div>
</body>

</html>
