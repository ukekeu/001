<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>����λ�۸�仯��ϸ</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js"></script>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%   
    List list10=new LinkedList();//��ŷ�������
	List list11=new LinkedList();//��ŷ�������
	List list12=new LinkedList();//��Ž������
	List list13=new LinkedList();//�������
	List list14=new LinkedList();//��ŷ���
	List list15=new LinkedList();//��ŵ�λ
	List list16=new LinkedList();//��ŵ���
	List list17=new LinkedList();//����ܼ�
	int sumnum=0;
   try{
 
	String SecName=getbyte2(request.getParameter("SecName"));
	String SecNo=request.getParameter("SecNo");
	String Loft=getbyte2(request.getParameter("Loft"));
	String sql="select  payment,convert(char(10),date,120) date  from ";
	sql=sql+" �����Ŀ�� where SectionNo='"+SecNo+"'";
	sql=sql+"   and loft='"+Loft+"' and paymenttype=0 group by   payment,convert(char(10),date,120) order by convert(char(10),date,120)";
	ResultSet rs=InsertBean.executeQuery(sql); 
	int PaymentNum=0;
 
	while(rs.next())
	  {PaymentNum++;
	   list10.add(rs.getString("date"));
	  list11.add(rs.getString("payment"));
	 
	  }
	rs.close();

      sql="select roomno,payment,count(*),date,sum(price) price ,sum(sumprice)  sumprice from ";
	 
		sql=sql+" �����Ŀ�� where SectionNo='"+SecNo+"'";
		sql=sql+"   and loft='"+Loft+"' and paymenttype=0 group by roomno,payment ,date order by roomno, date";
		  rs=InsertBean.executeQuery(sql); 
		  	while(rs.next())
			{
			list15.add(rs.getString("roomno"));
			list14.add(rs.getString("payment"));
			list13.add(rs.getString("date").substring(0,10));
			list16.add(rs.getString("price"));
			list17.add(rs.getString("sumprice"));
			}	rs.close();
%>
<body>
<form method="post" name=frm  target="_blank">
      <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<center>
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable>

<p align="center"><font size=3><b><%=SecName +Loft%>����Ҽ�Ŀ��</font></b></p>
 <center> 
 
<table border="1" cellspacing="1" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1">
  <tr align="center">
   <td width="5%" rowspan="2">���</td>
    <td   rowspan="2">��λ</td>
    <td   rowspan="2">�������</td>
    <td   rowspan="2">����</td>
    <td   rowspan="2">�ܼ�</td>
	  <%for (int nn=0;nn<PaymentNum;nn++){ %>
      <td   colspan="2">��<%=nn+1 %>�ε���(<%try{out.print((String)list10.get(nn));}catch(Exception s)  {}   %> )</td>
     <%} %>
  </tr>
  <tr align="center">
    <%for (int nn=0;nn<PaymentNum;nn++){ %>
    
    <td  >����</td>
    <td  >�ܼ�</td>
    <%} %>
  </tr>
  <% 
  sql="select  loft,room_code,area,y_unitprice,y_sumprice  from room where seccode+loft='"+SecNo+Loft+"'";
  ResultSet rs2=InsertBean.executeQuery(sql); 
 int jj=0;
  while (rs2.next()){
  jj++;
  String room_code=rs2.getString("room_code");
   %>
  <tr>
   <td width="5%"><%=jj %></td> 
    <td  ><%=room_code %></td>
    <td  align="right" ><%=rs2.getString("area") %></td>
    <td  align="right"><%=rs2.getString("y_unitprice") %></td>
    <td  align="right"><%=rs2.getString("y_sumprice") %></td>
    
	<%int ft=0;
	 for (int nn=0;nn<PaymentNum;nn++){ 
	 //  if (list15.contains(room_code)){ 
	    String date= (String)list10.get(nn);
	    sql="select   price1 ,sumprice from  �����Ŀ�� where SectionNo='"+SecNo+"'";
		sql=sql+"   and loft='"+Loft+"' and paymenttype=0 and roomno='"+room_code+"' and convert(char(10),date,120)='"+date+"' order by convert(char(10),date,120)"; 
	    ResultSet rs3=InsertBean1.executeQuery(sql);
		
		 while (rs3.next()){
		 ft++;
	%>
 
    <td align="right" ><%=rs3.getString("price1")%></td>
    <td align="right" ><%=rs3.getString("sumprice")%></td>
	<%}rs3.close();%>
	
	 <% 
	   }%>
	   <%for (int nnn=ft;nnn<PaymentNum;nnn++)
	{  %>
	  <td  > </td>
      <td  > </td>
	  <%} %>
  </tr>
  <%}
  rs2.close(); %>
</table>
 
 </div>
  </form>
 
 
<% }catch(Exception s)  {out.print(s.getMessage());}   %>
<p align="center"> <div   id="divprint" align="center"><input type="button" name="Button" value="��ӡԤ��" onClick="window.divprint.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.divprint.style.display='block'"><input type="button" onclick="bringToExcel()" value="������Excel"></div>
</p>
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
</center>


</center>
<script>
function prin(){
divprint.innerHTML="";
print();
}
function save(){
 if(confirm("ȷ������ü۸񷽰�")){
document.frm.action="savepricelist.jsp";
document.frm.submit();}
//window.history.back(1);
}
</script>
</body>
</html>
