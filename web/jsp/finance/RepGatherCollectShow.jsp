<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBeanD" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/news.css" rel=stylesheet>
<title>���տ���ܱ�</title>
</head> 
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>

<body>
 <%
     //get session value

	String user = setpro.getId();
	String type = setpro.getType();
	boolean sale = setpro.getSale();
	boolean hasRight = false;
	if (user==null)
	 {%> ���ѳ�ʱ,<a href="../default.htm" target="_blank">�����µ�¼</a> <%out.close();}%> 
  <tr></tr>
  <%
    String StrWhere="";
	String sql="";
	String CusNoS="";
	String SectionName="";
	CusNoS=request.getParameter("CusNo");
	String strYear = request.getParameter("BeginYear");
	String strMonth = request.getParameter("BeginMonth");
	String strType= request.getParameter("Type");
       if (strType!=null){if (strType.length()>0){
       strType=new String(strType.getBytes("ISO8859_1"),"GBK");
    
     strType="  and Type like '%"+strType+"%'";}}
	sql="select Name FROM crm_project where  SerialNo='"+CusNoS+"'";
	ResultSet rsH=ViewBean.executeQuery(sql);
	if(rsH.next()){
		SectionName=rsH.getString("Name");
	}
	rsH.close();
%>
  <table border="0" width="100%" cellspacing cellpadding>
    <tr> 
      <td colspan="12" align="center" height="23" ><b><font size="3"><%=SectionName%><%=strYear%>��<%=strMonth%>�´��տ���ܱ�</font></b> 
      </td>
    </tr>
  </table>
  <hr size=1 width=80%>
   
  <table border="1" width="80%" cellspacing cellpadding height="26" align="center">
    <tr> 
      <td align="center" height="23" >��������</td>
      <td width="35%" height="13" align="center" >�ܽ���λ��Ԫ��</td>
    </tr>
<%

	//�趨��ѯ
	if (CusNoS.length()>0) {
   		sql="SELECT R.type,sum(R.InMoney) as TotalMoney FROM RepGatheringRecord R inner join saled_circs S on R.cusno=S.cusno ";
		sql=sql+"where S.secno='"+CusNoS+"' and DATEPART(yy,R.InDate)='"+strYear+"' and DATEPART(mm,R.InDate)='"+strMonth+"'";
		sql=sql+strType+" group by R.type,DATEPART(yy,R.InDate),DATEPART(mm,R.InDate) ";
	
//���ò�ѯ����Ĵ�ű���
//Modify by freejoy,  2001-09-03, change the View
String Type="";
int TotalMoney=0;

//out.print(sql);
ResultSet rs=ViewBean.executeQuery(sql);


 while (rs.next()){
  //��FIELDS˳��һGET��VALUE
  Type=rs.getString("type");
  TotalMoney=rs.getInt("TotalMoney");
  //Modify by freejoy,2001-09-05, format the Money
  java.text.DecimalFormat MoneyFormat = new java.text.DecimalFormat(" ###,###,##0.00");
  String strTotalMoney=MoneyFormat.format(TotalMoney);
  if(java.lang.Integer.parseInt(strTotalMoney.substring(strTotalMoney.indexOf(".")+1))==0){
	   strTotalMoney=strTotalMoney.substring(0,strTotalMoney.indexOf("."));
  }
 %> 
  	<tr> 
      <td  align="center" height="23" ><%=Type%></td>
      <td width="35%" height="13" align="center" ><%=strTotalMoney%></td>
    </tr>
<!--    <tr> 
      <td colspan="2">
        <table border="0" width="100%" cellspacing cellpadding height="26">
          <tr> 
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="17%"> 
              <div align="center">����</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="9%">����</td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="13%"> 
              <div align="center">�ͻ�</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="13%"> 
              <div align="center">���</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="14%"> 
              <div align="center">�տ�����</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="11%"> 
              <div align="center">Ʊ������</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="11%"> 
              <div align="center">Ʊ�ݺ���</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="12%"> 
              <div align="center">�տ�Ա</div>
            </td>
          </tr>
-->         
<%/*
	String sqlD="";
	
	sqlD="SELECT S.building,S.room,C.cus_name,R.* FROM RepGatheringRecord R inner ";
	sqlD=sqlD+"join saled_circs S on R.cusno=S.cusno inner join customer C on C.SerialNo=R.cusno ";
	sqlD=sqlD+"where DATEPART(yy,InDate)='"+strYear+"' and DATEPART(mm,InDate)='"+strMonth+"'";
	sqlD=sqlD+" and type='"+Type+"'";
		
//���ò�ѯ����Ĵ�ű���
String Building="";
String Room="";
String CusNo="";
int InMoney=0;
String InDate="";
String BillName="";
String BillNo="";
String CN="";

//out.print(sql);
ResultSet rsD=ViewBeanD.executeQuery(sqlD);

 while (rsD.next()){
  //��FIELDS˳��һGET��VALUE
  Building=rsD.getString("building");
  Room=rsD.getString("room");
  CusNo=rsD.getString("cus_name");
  InMoney=rsD.getInt("InMoney");
  String strInMoney=MoneyFormat.format(InMoney);
  if(java.lang.Integer.parseInt(strInMoney.substring(strInMoney.indexOf(".")+1))==0){
	   strInMoney=strInMoney.substring(0,strInMoney.indexOf("."));
  }
  InDate=rsD.getString("InDate");
  java.text.SimpleDateFormat date =null;
  date=new java.text.SimpleDateFormat("yyyy-MM-dd");
  InDate=date.format(date.parse(InDate));
  BillName=rsD.getString("BillName");
  if(BillName.equals("0")){
	 BillName="�վ�";
  }
  if(BillName.equals("1")){
  	BillName="��Ʊ";
  }
  BillNo=rsD.getString("BillNo");
  CN=rsD.getString("CN");
*/%> 
<!--          <tr align="center" BGCOLOR="#e6f9ff"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');"> 
            <td width="17%"  height="16" style="border-style: solid; border-width: 1"></td>
            <td width="9%"  height="16" style="border-style: solid; border-width: 1"></td>
            <td width="13%"  height="16" style="border-style: solid; border-width: 1"></td>
            <td width="13%"  height="16" style="border-style: solid; border-width: 1">/td>
            <td width="14%"  height="16" style="border-style: solid; border-width: 1"></td>
            <td width="11%"  height="16" style="border-style: solid; border-width: 1"></td>
            <td width="11%"  height="16" style="border-style: solid; border-width: 1"></td>
            <td colspan="5"  height="16" style="border-style: solid; border-width: 1" width="12%"></td>
          </tr>
-->          
<%/*
	}
	rsD.close();
	*/%> 
<!--        </table>
      </td>
    </tr>
-->    
  <%
	}
	rs.close();
}
%> 
 </table> 

</body>
</form>
</html>