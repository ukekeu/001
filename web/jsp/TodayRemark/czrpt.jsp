<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "���ձ���-->�����ͻ�" , 
                  "���"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>���ճ����ͻ�</title>
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
  document.form1.action="CACustomer.jsp";
  document.form1.submit();

}
</script>
<%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
<%String DisplayS=China.getParameter(request,"Display"); %>
<%
 aBean.executeUpdate("update VIEW_CACustomer set out=0");
String section=request.getParameter("section");
String paulurl="";
if(section==null || section.equals(""))
{
	paulurl="";
}else{
	paulurl=" and serialno='"+section+"'";
}
%>
<%@ include file="../public_js/CheckSection.jsp"%>
<body topmargin="1"?
<% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="1"; %>
  <form method="POST" name="form1" action="">
  <input type=hidden name="sel" value="<%=sel %>">
   
  
  
</center>
<script>
function findSub(para){
   document.form1.action=para;
   document.form1.submit();


}
</script>
 <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

         <p align="center"><b><font size="3" class=FontColor>Ӧ�����ͻ�</font></b></p> 
    <%
String sql="";
String sql1="";
String sql2="";
if (DisplayS.equals(""))DisplayS="d0";
DisplayS=DisplayS.substring(1);
	//�趨��ѯ
	
		if (DisplayS.equals("0")) {
	   		sql="select * from VIEW_CACustomer "+FindWhere+paulurl+" and   substring(convert(char(24),day,120),1,10)<=substring(convert(char(24),getdate(),120),1,10) order by day DESC";
	
		}else{
			sql="select * from VIEW_CACustomer "+FindWhere+paulurl+" and  substring(convert(char(24),dateadd(dd,-"+DisplayS+",day),120),1,10)<=substring(convert(char(24),getdate(),120),1,10) order by day DESC";

		}

//���ò�ѯ����Ĵ�ű���
int ID=0;
String Section="";
String Building="";
String Room="";
String CusName="";
String SerialNo="";
String Date="";
String Date1="";
String SalePrice="";
String State="";
String Loft="";
String Phone="";
String Seller="";
String handle="";
int i=0;
//out.print(sql);
//Add try...catch for search,2001-09-06
try{
	ResultSet rs=ViewBean.executeQuery(sql);
%>

<%String str="string";

	while (rs.next()){
	  i++;
	  //��FIELDS˳��һGET��VALUE
	  Section=getbyte(rs.getString("Name"));
	  Loft=getbyte(rs.getString("Loft"));
	  Building=getbyte(rs.getString("building"));
	  Room=rs.getString("Room_no");
  	  aBean.executeUpdate("update VIEW_CACustomer set out=1 where Name='"+Section+"' and Loft='"+Loft+"' and building='"+Building+"' and Room_no='"+Room+"'");
	  SerialNo=rs.getString("ContractNo");
	  CusName=getbyte(rs.getString("Cus_Name"));
	  Phone=getbyte(rs.getString("phone"));
	  Seller=getbyte(rs.getString("Seller"));
	  Date1=rs.getString("SendDate");
	  handle=getbyte(rs.getString("handle"));
	  Date=rs.getString("day");
	  
	  //SalePrice=rs.getString("RMBPRICE");
	 
	  
	 
	  if (str.equals("string")){
	  
 %> 
 
<table width="98%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

  <tr   >
      <!--td  align="center" height="23"  >¥��</td>
      <td  align="center" height="23"   >����</td>
	  <td  align="center" height="23"   >����</td-->
      <td  align="center" height="23"   >���</td>
      <td  align="center" height="23"   >�������</td>
	  <td  align="center" height="23"  >��ͬ���</td>
      <td  align="center" height="23"   >�ͻ�</td>
	  <td align="center" height="23"   >��ϵ�绰</td>
      <td  align="center" height="23"   >�Ͱ�����</td>
	  <td  align="center" height="23"   >Ӧ��������</td>
      <td align="center" height="23"   >�Ͱ���</td>
      <td align="center" height="23"   >����Ա</td>
    </tr>
	<%} %>
	<tr id=TR<%=i %> align="center"   onmouseover="mout(this);" onclick="changeclass1(this,'clickbg','listcontent');" > 
     <!--td   ><%=Section%></td>
	 <td   ><%=Loft%></td>
	  <td  ><%=Building%></td-->
      <td   ><%=i%></td>
      <td  ><%=Section+Loft+Building+Room%></td>
	    <td  ><%=SerialNo%></td>
      <td  align="left"><%=Repalce(CusName,"/")%></td>
	  <td  align="left" ><%=Repalce(Phone,"/")%></td>
    
      <td  ><%=Date1.substring(0,10)%></td>
	   <td  ><%=Date.substring(0,10)%></td>
      <td  align="left"><%=handle%></td>
	    <td  align="left"><%=Seller%></td>
    </tr>
    <%
	str="aa";
  }
  rs.close();
  }catch(Exception se){
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage()+sql);
	out.close(); 
}
if (i==0)out.print("��ǰû������");
%> 
  </table>

 </div>
    <DIV align=center id="printdiv">
<input type="button" onclick="bringToExcel()" value="������Excel">&nbsp;<input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">

</form> 
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
</body>
</form>
</html>