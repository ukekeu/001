<%@ page contentType="text/html;charset=GBK" %>
 
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>����Ӧ�����ͻ�</title>
</head>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>  
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
<script>
function AlertDate(){
  document.form1.action="JZCustomer.jsp";
  document.form1.submit();

}
</script>
<%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
<%String DisplayS=China.getParameter(request,"Display"); %>
<%if (DisplayS.equals(""))DisplayS="d6";
String section=request.getParameter("section");
String paulurl="";
if(section==null || section.equals(""))
{
	paulurl="";
}else{
	paulurl=" and section='"+section+"'";
}  
%>
 
<%@ include file="../public_js/CheckSection.jsp"%>
<body topmargin="1" >
<form method="POST" name="form1" action="">
 <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>

  
<div align=left id=report1 style="background-color:#F7F7F7;height:151%px;overflow:auto;width:100%;z-index:2" contentEditable >

   <p align="center"><b><font size="3" color="#000080">Ӧ�����ͻ� </font></b></p>
    
    <%
String sql="";
String sql1="";
String sql2="";

FindWhere=" where  section in  "+FindWhere.substring(FindWhere.indexOf("("));
if (DisplayS.equals(""))DisplayS="d6";
DisplayS=DisplayS.substring(1);
 sql="select * from VIEW_JZCustomer"+FindWhere+paulurl+" and  convert(char(24),dateadd(dd,-"+DisplayS+",jztx),111)<=convert(char(24),getdate(),111)   order by jztx";
        
 
//���ò�ѯ����Ĵ�ű���
String SecName="";
String Loft="";
String Building="";
String Room="";
String CusName="";
String Phone="";
String ConstractNo="";
float SalePrice=0;
String jztx="";
String VisaDate="";
String Seller="";
String Area="";
String aa="";
int i=0;
try{
	ResultSet rs=ViewBean.executeQuery(sql);
	
%>
   <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  >
      <!--td  align="center" height="23" >¥��</td>
      <td  align="center" height="23" >����</td>
	  <td  align="center" height="23" >����</td-->
      <td  align="center" height="4" >���</td>
      <td  align="center" height="26" >�������</td>
      <td  align="center" height="23" >��ͬ���</td>
      <td  align="center" height="23" >�ɽ���</td>
      <td  align="center" height="23"  >ǩԼ����</td>
	  <td  align="center" height="23"  >Ӧ��������</td>
	    <td  align="center" height="23" >ʣ������</td>
	  <td  align="center" height="23" >�ͻ�</td>
	  <td  align="center" height="23" >��ϵ�绰</td>
   
	  <td  align="center" height="23"  >����Ա</td>
    </tr>
<%  
	while (rs.next()){
	  i++;
	  //��FIELDS˳��һGET��VALUE
	  SecName=getbyte(rs.getString("Name"));
	  Loft=getbyte(rs.getString("Loft"));
	  Building=getbyte(rs.getString("building"));
	  Room=rs.getString("room_no");
	  aBean.executeUpdate("update VIEW_JZCustomer set out=1 where Name='"+SecName+"' and Loft='"+Loft+"' and building='"+Building+"' and Room_no='"+Room+"'");
	  Area=rs.getString("jzarea");
	  SalePrice=rs.getFloat("RMBPrice");
      ConstractNo=rs.getString("ContractNo");
	  CusName=getbyte(rs.getString("customer"));
	  Phone=rs.getString("Phone");
	  jztx=rs.getString("jztx");
	  VisaDate=rs.getString("VisaDate");
	  Seller=getbyte(rs.getString("Seller"));
	  int syday=rs.getInt("syday");
  if (aa.equals("")){
 %> 

<%} %>	
	<tr id=TR<%=i %> align="center"    onmouseover="mout(this);" onclick="changeclass1(this,'clickbg','listcontent');" > 
      <!--td    height="16"  ><%=SecName%></td>
	  <td    height="16"  ><%=Loft%></td>
	  <td    height="16"  ><%=Building%></td-->
      <td    height="16"  ><%=i%></td>
      <td    height="16"  ><%=SecName+Loft+Building+Room%></td>
	  <td    height="14"  ><%=ConstractNo%></td>
	  <td    height="14"  ><%=SalePrice%></td>
	  <td    height="10"  ><%=VisaDate%></td>
	  <td    height="10"  ><%=jztx.substring(0,10)%></td>
	   <td    height="16"  ><%if (syday<3){out.print("<font  color=red>");} %><%=syday%><%if (syday<3){out.print("</font>");} %></td>
      <td    height="16"  ><%=CusName%></td>
      <td    height="16" align="left" ><%=Repalce(Phone,"/").trim()%></td>
      
	  <td    height="10"  ><%=Seller%></td>	
    </tr>
    <%aa="true";
  }
  rs.close();
    out.print("</table>");
	  
}catch(Exception se){
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage());
	out.print(sql);
	out.close(); 
}
if (i==0)out.print("��ǰû������");
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
<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="������Excel"> 
<br>����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"<br>
��2.ѡ��"��ȫ"->ѡ��"����intranet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>
 </div>
</body>
</form>
</html>