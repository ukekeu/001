 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>���۱����</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
<form name="frm">
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<p align="center"><font size=4><b>���������ϸ</b></font> </p>
<table border="0" cellpadding="0" cellspacing="0"  width="99%"  >
  <tr >
  <td align="left" width="49%"><div id=w1></div></td>  <td align="right" width="49%"><div id=w2></div></td>
  </tr>
  </table>

<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1">
  <tr align="center">
    <td width="4%" rowspan="2">���</td>
    <td width="4%" rowspan="2">�������</td>
    <td width="4%" rowspan="2">�Ϲ�����</td>
    <td width="4%" rowspan="2">�Ϲ���</td>
    <td width="4%" rowspan="2">�ٶ�����<br>
    �����/Ԫ</td>
    <td width="8%" colspan="2">�Ϲ���λ</td>
    <td width="8%" colspan="2">�������</td>
    <td width="8%" colspan="2">�ɽ����</td>
    <td width="4%" rowspan="2">��ҵ����</td>
    <td width="4%" rowspan="2">������</td>
  </tr>
  <tr  align="center">
    <td width="4%">���ǰ</td>
    <td width="4%">�����</td>
    <td width="4%">���ǰ</td>
    <td width="4%">�����</td>
    <td width="4%">���ǰ</td>
    <td width="4%">�����</td>
  </tr>
  <%
   String  SecNo=China.getParameter(request,"SecNo");
    String  Date1=China.getParameter(request,"Date1");
	String  Loft=China.getParameter(request,"Loft");	
	String  Date2=China.getParameter(request,"Date2");
	String Build="";
	String section;
	String building;
	String OldRoom;
	String NowRoom;
	String ChangeDate;
    String Note="";
	String person="";
	String checker="";
	String seller="";
	String subscription="";
	String secno="";
	String customer="";
	String cusname="";
	String order_code="";
	double s_c_a=0;
	double s_c_p=0;
	String sectionname="";
	String newloft="",newbuild="";
    ResultSet changeRS1 = null;
	String changeStr = "select  c.sectionname,c.subscription,c.seller,b.cus_name,a.*,a.sumprice-a.oldprice c_price,a.jzarea-a.oldarea c_area from ChangRoomR a,customer b,order_contract c   where a.section+a.newloft+a.newbuild+a.NowRoom=c.sectionname+c.loft+c.building+c.room_no and  a.customer=b.SerialNo and a.secno='"+SecNo+"' and a.build='"+Build + "' "
                      + " and convert(char(10),ChangeDate,120)>='"+Date1+"' and  convert(char(10),ChangeDate,120)<='"+Date2+"'"
                      + " order by ChangeDate desc";
		 	
    
	try{
	changeRS1 = changeListBean.executeQuery(changeStr);	
	 
	int i=0;
	
	while (changeRS1.next()) {
		 
		 i++;
		 sectionname=changeRS1.getString("sectionname");
		 subscription=changeRS1.getString("subscription");
		 seller=changeRS1.getString("seller");
		 secno=changeRS1.getString("secno");
		 customer=changeRS1.getString("customer");
		 cusname=getbyte(changeRS1.getString("cus_name"));
		 section = getbyte(changeRS1.getString("Section"));
		 Loft =getbyte(changeRS1.getString("Loft"));
		 building = getbyte(changeRS1.getString("Build"));
		 OldRoom = changeRS1.getString("OldRoom"); 
		 NowRoom = changeRS1.getString("NowRoom"); 
		 newloft= changeRS1.getString("newloft"); 
		 newbuild= changeRS1.getString("newbuild"); 
         ChangeDate = changeRS1.getString("ChangeDate");
		 checker=getbyte(changeRS1.getString("Checker"));
		 Note=getbyte(changeRS1.getString("Note"));
	    person=getbyte(changeRS1.getString("person"));
		String c_price=getbyte(changeRS1.getString("c_price"));
		s_c_p+=changeRS1.getDouble("c_price");
		String c_area=getbyte(changeRS1.getString("c_area"));
		s_c_a+=changeRS1.getDouble("c_area");
		String oldname=getbyte(changeRS1.getString("oldname"));
		String olddate=getbyte(changeRS1.getString("olddate"));
		String oldarea=getbyte(changeRS1.getString("oldarea"));
		String area=getbyte(changeRS1.getString("jzarea"));
		String sumprice=getbyte(changeRS1.getString("sumprice"));
		String oldprice=getbyte(changeRS1.getString("oldprice"));
		 

 %>
 
  <tr  align="center">
    <td width="4%"><%=i %></td>
    <td width="4%"><%= ChangeDate.substring(0,ChangeDate.indexOf(" ")) %></td>
    <td width="4%"><%= olddate.substring(0,olddate.indexOf(" ")) %></td>
    <td width="4%"><%=cusname %></td>
    <td width="4%"><%=subscription %></td>
    <td width="4%"><%=Loft+building+OldRoom %></td>
    <td width="4%"><%=newloft+newbuild+NowRoom %></td>
    <td width="4%"><%=oldarea %></td>
    <td width="4%"><%= area%></td>
    <td width="4%"><%=oldprice %></td>
    <td width="4%"><%= sumprice%></td>
    <td width="4%"><%=seller %></td>
    <td width="4%"><%= checker %></td>
  </tr>
  <%}
  
  changeRS1.close(); 
  }catch(Exception e){out.print(e);}
  %>
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

w2.innerHTML="�������ڷ�Χ��<%=Date1 %>--<%=Date2 %>      ";

</script>
</body>
</html>
