<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>��ӡ����ӦǩԼ�ͻ�</title>
</head>


<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>  
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/>  
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/AcquiesceSection.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
<script>
function AlertDate(){
  document.form1.action="QYCustomer.jsp";
  document.form1.submit();

}
function paulsel(){
		document.form1.submit();
	}
</script>
<%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
<%String DisplayS=China.getParameter(request,"Display"); %>

<%
 String FindWhere  ="";
 
String section=request.getParameter("section");
String paulurl="";
if(section==null || section.equals(""))
{
	paulurl="";
}else{
	paulurl=" where serialno='"+section+"'";
}
%>
  
<body  topmargin="1">
 <% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="1"; %>
  <form method="POST" name="form1" action="">
    <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  
  
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
    <p align="center"><b><font size="3" class=FontColor>  <div id=sectionname align="center"></div> </font></b></p>
 


    <%
String sql="";
if (DisplayS.equals(""))DisplayS="d0";
DisplayS=DisplayS.substring(1);
	//�趨��ѯ
	
		 if (DisplayS.equals("0")) {
	   		sql="select    *  from VIEW_QYCustomer "+paulurl+" and  convert(char(24),qytxdate,111)<=convert(char(24),getdate(),111)    order by serialno,loft,floors,room_no,qytxdate desc";
 	
		}else{
			sql="select * from VIEW_QYCustomer  "+paulurl+" and convert(char(24),dateadd(dd,-"+DisplayS+",qytxdate),111)<=convert(char(24),getdate(),111) order by serialno,loft,floors,room_no,qytxdate DESC";
        	}
		// out.print(sql);
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
String curr="";
String sj="";
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
	  CusName=getbyte(rs.getString("Cus_Name"));
	  Phone=getbyte(rs.getString("phone"));
	  sj=getbyte(rs.getString("sj"));
	   Phone+=" "+ sj;
		 
	   SerialNo=rs.getString("orderno");
	  Date=rs.getString("Date");
	  Date=Date.substring(0,4)+"-"+Date.substring(6,8)+"-"+Date.substring(9,10);
	   String sqQing = " select sum(shouldMoney) shouldMoney,sum(yijiao) as yijiao from GatheringRecord where";
              sqQing=sqQing + " cusno = '" + rs.getString("customer") + "' ";
              sqQing=sqQing + " and contactno = '" + rs.getString("id") + "' " ;
						
        ResultSet rsQing = fBean.executeQuery( sqQing ) ;
        double summoney = 0 ;
        double yj_money = 0 ;
        if( rsQing.next() ) {
            summoney= rsQing.getDouble( "shouldMoney" ) ;
            yj_money = rsQing.getDouble( "yijiao" ) ;
         
        }
        rsQing.close() ;
	 
	
	  Seller=getbyte(rs.getString("Seller"));
	  SalePrice=rs.getString("RMBPRICE");
	  curr=getbyte(rs.getString("currency"));
	    Date1=getbyte(rs.getString("qytxdate"));
	  if (str.equals("string")){
	  
 %> 
 
  <table width="98%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr   >
 
      <td align="center" height="4"   >���</td>
      <td  align="center" height="23"   >�������</td>
      <td  align="center" height="23"   >�ͻ�</td>
	   <td align="center" height="23"   >��ϵ�绰</td>
      <td  align="center" height="23"  >�Ϲ�����</td>
      <td  align="center" height="23"   >�Ϲ�����</td>
	 <td  align="center" height="23"   >ӦǩԼ����</td>
      <td align="center" height="23"   >�ɽ���</td>
	  <td align="center" height="23"   >���ڿ�</td>
      <td align="center" height="23"   >����Ա</td>
	   
    </tr>
	<%} %>
	<tr id=TR<%=i %> align="center"   onmouseover="mout(this);" onclick="changeclass1(this,'clickbg','listcontent');" > 
     <!--td   ><%=Section%></td>
	 <td   ><%=Loft%></td-->
	<td   > <%=i%></td> 
      <td  ><%=Loft+Room%></td>
      <td  align="left"><%=Repalce(CusName,"/")%></td>
	  <td  align="left" ><%=Repalce(Phone,"/")%></td>
      <td  ><%=SerialNo%></td>
      <td  ><%=Date%></td>
	   <td  ><%=Date1.substring(0,10)%></td>
	      <td  align="left"><%=curr+SalePrice%> </td>
	   
		 <td><%if (summoney<=yj_money)out.print("�ѽ���");
	          else if (summoney>yj_money&&yj_money>0)out.print("������");
		  else out.print("δ����");
		  %> 
	 </td>
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
<br>

 
 
 
����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"<br>
��2.ѡ��"��ȫ"->ѡ��"����intranet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>
   </div>
   
<script>
sectionname.innerHTML ="<%=Section %>ӦǩԼ�ͻ���ϸ��";
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