<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>���տ���ܱ�</title>
</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
<script>
function FullD(){
 CurrDate =new Date();
 setSelectMad(cus.BeginYear,CurrDate.getYear());
 setSelectMad(cus.BeginMonth,CurrDate.getMonth());
}
 </script> 

<%
String CusNoS="";
CusNoS=request.getParameter("CusNo");
%>

<body onload="setSelectMad(document.cus.CusNo,'<%= CusNoS %>');FullD();">
<form method="POST" name="cus" action="">
<%
     //get session value

	String user = setpro.getId();
	String type = setpro.getType();
	boolean sale = setpro.getSale();
	boolean hasRight = false;
	if (user==null)
	 {%> ���ѳ�ʱ,<a href="../default.htm" target="_blank">�����µ�¼</a> <%out.close();}%> 
<%
//ȡ�ò�ѯ����
String StrWhere="";

String strYear = request.getParameter("BeginYear");
String strMonth = request.getParameter("BeginMonth");



if(request.getParameter("Search")!=null){
	if(CusNoS.length()>0){
		StrWhere="secno='"+CusNoS+"' and shouldYear="+strYear+" and shouldMonth="+strMonth;
	}

}
if(request.getParameter("SearchStat")!=null){
	if(CusNoS.length()>0){
		StrWhere=" and secno='"+CusNoS+"'";
	}else{
		StrWhere="";
	}
}
  %>
  <input type="hidden" name="StrWhere" value="<%=StrWhere%>">
  <div id=printdiv align="center">
  <table border="0" width="100%">
  <%if (CusNoS==null){ %>
  <tr>
                <td width="100%" valign="top">
                  <p align="center"><b><font size="3" color="#000080">���տ���ܱ�</font></b></td>
              </tr>
 <%} %>			  
              <tr>
                <td width="100%" valign="top" height="10"></td>
              </tr>
              <tr bgcolor="#EBEBEB">
                <td width="100%" valign="top" >&nbsp;¥��<select size="1" name="CusNo">
                    
					<%
     String Sql="select SerialNo,Name from Section";
     ResultSet Rs=ViewBean.executeQuery(Sql);
     while (Rs.next()){
	    %>
   <option value=<%=Rs.getString("SerialNo") %>><%=getbyte(Rs.getString("Name")) %></option>
   <%}
   Rs.close();
 %>
                  </select>
        ���� 
        <select size="1" name="BeginYear" style="border-style: solid; border-width: 1">
          <option value="2001">2001</option>
          <option value="2002">2002</option>
          <option value="2003">2003</option>
          <option value="2004">2004</option>
          <option value="2005">2005</option>
          <option value="2000">2000</option>
          <option value="1999">1999</option>
        </select>�� 
        <select size="1" name="BeginMonth" style="border-style: solid; border-width: 1">
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
          <option value="8">8</option>
          <option value="9">9</option>
          <option value="10">10</option>
          <option value="11">11</option>
          <option value="12">12</option>
        </select>
        ��&nbsp;˰��:
 <select name="Type" style="border-style: solid; border-width: 1" >
            <option> </option>
            <%
     Sql="select ChargesName,tax from ChargesCode";
     ResultSet Rs1=ViewBean.executeQuery(Sql);
	 String ChargeName="";
	 String Tax="";
     while (Rs1.next()){
	 	ChargeName=getbyte(Rs1.getString("ChargesName"));
		Tax=Rs1.getString("tax");
		//format the Money
		Tax=FormatD.getFloat(java.lang.Float.parseFloat(Tax),2);		
	    %> 
            <option value="<%=ChargeName%>"><%=ChargeName+"*"+Tax%></option>
            <%}
   Rs1.close();
 %> 
          </select><input type="submit" name="Search" value="��ѯ"><input type=checkbox  onclick="printall()" >��ӡ

		<script>
			function printall() {
				printdiv.innerText = "" ;
                           print(); 
			}
		
		</script>
		
</table>
</div>
<%
   	if (CusNoS==null)return;
	String sql="";
	String SectionName="";
	//CusNoS=request.getParameter("CusNo");
	//String strYear = request.getParameter("BeginYear");
	//String strMonth = request.getParameter("BeginMonth");
	String strType= request.getParameter("Type");
       if (strType!=null){if (strType.length()>0){
       strType=new String(strType.getBytes("ISO8859_1"),"GBK");
    
     strType="  and Type like '%"+strType+"%'";}}
	sql="select Name FROM crm_project where  SerialNo='"+CusNoS+"'";
	ResultSet rsH=ViewBean.executeQuery(sql);
	if(rsH.next()){
		SectionName=getbyte(rsH.getString("Name"));
	}
	rsH.close();

%>
<p align=center><b><font size="3"><%=SectionName%><%=strYear%>��<%=strMonth%>�´��տ���ܱ�</font></b> </p>
     
 <table width="80%" align=center border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
    <tr> 
      <td align="center" height="23" >��������</td>
      <td width="35%" height="13" align="center" >�ܽ���λ��Ԫ��</td>
    </tr>
<%

	//�趨��ѯ
 float SumMoney=0;
	if (CusNoS.length()>0) {
   		sql="SELECT R.type,sum(R.InMoney) as TotalMoney FROM RepGatheringRecord R inner join saled_circs S on R.cusno=S.cusno ";
		sql=sql+"where S.secno='"+CusNoS+"' and DATEPART(yy,R.InDate)='"+strYear+"' and DATEPART(mm,R.InDate)='"+strMonth+"'";
		sql=sql+strType+" group by R.type,DATEPART(yy,R.InDate),DATEPART(mm,R.InDate) ";

 //���ò�ѯ����Ĵ�ű���
 String Type="";
 int TotalMoney=0;

 //out.print(sql);
 ResultSet rs=ViewBean.executeQuery(sql);
 while (rs.next()){
  //��FIELDS˳��һGET��VALUE
  Type=rs.getString("type");
  TotalMoney=rs.getInt("TotalMoney");
  SumMoney+=TotalMoney;
  String strTotalMoney=FormatD.getFloat(TotalMoney,2);

 %> 
  	<tr> 
      <td  align="center" height="23" ><%=Type%></td>
      <td width="35%" height="13" align="center" ><%=strTotalMoney%></td>
    </tr>

	<%
	}
	rs.close();
}
%> 
<tr bgcolor="#EBEBEB"> 
      <td  align="center" height="23" >�ϼƽ�</td>
      <td width="35%" height="13" align="center" ><%=FormatD.getFloat(SumMoney,2)%></td>
    </tr>
 </table> 
</body>
</form>
</html>