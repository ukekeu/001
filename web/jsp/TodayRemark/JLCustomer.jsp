<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "���ձ���-->��¥����" , 
                  "���"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>���ս�¥�ͻ�</title>
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
  document.cus.action="JLCustomer.jsp";
  document.cus.submit();

}
</script>
 
<%String DisplayS=China.getParameter(request,"Display"); %>
<%
 
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
<body topmargin="1" onload="setSelectMad(document.cus.Display,'<%= DisplayS %>');setSelectMad(document.cus.section,'<%= section %>');">

  <form method="POST" name="cus" action="">
         <p align="center"><b><font size="3" class=FontColor>��¥�ͻ�</font></b></p>
<p>
��ʾ 
		<select name="Display" onchange="AlertDate();">
			<OPTION VALUE="d0">����</OPTION>
			<OPTION VALUE="d1">��ǰ1������</OPTION>
			<OPTION VALUE="d2">��ǰ2������</OPTION>
			<OPTION VALUE="d3">��ǰ3������</OPTION>
			<OPTION VALUE="d4">��ǰ4������</OPTION>
			<OPTION VALUE="d5">��ǰ5������</OPTION>
			<OPTION VALUE="d6">��ǰ6������</OPTION>
		</select>&nbsp;<input type=button name=Prin value="��ӡ" onclick="" title="�޴�ӡ">
			��¥����ʾ��<select name="section" onchange="javascript:document.forms[0].submit();"> 
   <option value=""></option>
   <%	
      String sqls="select SerialNo,Name from CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";

	  ResultSet rs2=ViewBean.executeQuery(sqls);
	  String sec="";
	  String no1="";
	  String daa="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
	   if(no1.equalsIgnoreCase(section)){
		   daa=" selected";
		   }else{
			   daa="";
		   }
       out.print("<option value='"+no1+"'"+daa+">"+sec+"</option>");
	  }
	  rs2.close();
     %> </select>
</p>
    <%
String sql="";
String sql1="";
String sql2="";
if (DisplayS.equals(""))DisplayS="d0";
DisplayS=DisplayS.substring(1);
	//�趨��ѯ
		if (DisplayS.equals("0")) {
	   		sql="select * from VIEW_JLCustomer "+FindWhere+paulurl+" and  convert(char(24),JLDATE,111)<=convert(char(24),getdate(),111)  order by JLDATE DESC";
	 	}else{
			sql="select * from VIEW_JLCustomer "+FindWhere+paulurl+" and convert(char(24),dateadd(dd,-"+DisplayS+",JLDATE),111)=convert(char(24),getdate(),111) order by JLDATE DESC";
    
		}
//out.print(sql);
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
String Note="";
int i=0;
 try{
	ResultSet rs=ViewBean.executeQuery(sql);
%>

 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=TXTColor  >
      <!--td  align="center" height="23"  >¥��</td>
      <td  align="center" height="23"   >����</td>
	  <td  align="center" height="23"   >����</td-->
      <td  align="center" height="23"   >���</td>
      <td  align="center" height="23"   >�������</td>
	  <td  align="center" height="23"  >��ͬ���</td>
      <td  align="center" height="23"   >�ͻ�</td>
	  <td  align="center" height="23"   >��ϵ�绰</td>
      <td  align="center" height="23"   >��¥����</td>
	  <td  align="center" height="23"   >��ע</td>
	   <td align="center" height="23"   >����Ա</td>
    </tr>
<%String str="string";

	while (rs.next()){
	  i++;
	  //��FIELDS˳��һGET��VALUE
	  Section=getbyte(rs.getString("Name"));
	  Loft=getbyte(rs.getString("Loft"));
	  Building=getbyte(rs.getString("building"));
	  Room=rs.getString("Room_no");
	  aBean.executeUpdate("update VIEW_JLCustomer set out=1 where Name='"+Section+"' and Loft='"+Loft+"' and building='"+Building+"' and Room_no='"+Room+"'");
	  SerialNo=rs.getString("ContractNo");
	  Seller=getbyte(rs.getString("Seller"));
	  CusName=getbyte(rs.getString("Cus_Name"));
	  Phone=getbyte(rs.getString("phone"));
	  Note=getbyte(rs.getString("Note"));
	  Date1=rs.getString("JLDate");
      
	  
	  //SalePrice=rs.getString("RMBPRICE");
	 
	  
	 
	  if (str.equals("string")){
	  
 %> 
 
	<%} %>
	<tr id=TR<%=i %> align="center"  class='listcontent' onmouseover="mout(this);" onclick="changeclass1(this,'clickbg','listcontent');" > 
     <!--td   ><%=Section%></td>
	 <td   ><%=Loft%></td>
	 <td  ><%=Building%></td-->
     <td  ><%=i%></td>
     <td  ><%=Section+Loft+Building+Room%></td>
	 <td  ><%=SerialNo%></td>
     <td  align="left"><%=Repalce(CusName,"/")%></td>
	 <td  align="left" ><%=Repalce(Phone,"/")%></td>
     <td  ><%=Date1.substring(0,10)%></td>
     <td  align="left"><%=Note%></td>
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

</body>
</form>
</html>