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
<title>代收款汇总表</title>
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
	 {%> 你已超时,<a href="../default.htm" target="_blank">请重新登录</a> <%out.close();}%> 
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
      <td colspan="12" align="center" height="23" ><b><font size="3"><%=SectionName%><%=strYear%>年<%=strMonth%>月代收款汇总表</font></b> 
      </td>
    </tr>
  </table>
  <hr size=1 width=80%>
   
  <table border="1" width="80%" cellspacing cellpadding height="26" align="center">
    <tr> 
      <td align="center" height="23" >款项名称</td>
      <td width="35%" height="13" align="center" >总金额（单位：元）</td>
    </tr>
<%

	//设定查询
	if (CusNoS.length()>0) {
   		sql="SELECT R.type,sum(R.InMoney) as TotalMoney FROM RepGatheringRecord R inner join saled_circs S on R.cusno=S.cusno ";
		sql=sql+"where S.secno='"+CusNoS+"' and DATEPART(yy,R.InDate)='"+strYear+"' and DATEPART(mm,R.InDate)='"+strMonth+"'";
		sql=sql+strType+" group by R.type,DATEPART(yy,R.InDate),DATEPART(mm,R.InDate) ";
	
//设置查询结果的存放变量
//Modify by freejoy,  2001-09-03, change the View
String Type="";
int TotalMoney=0;

//out.print(sql);
ResultSet rs=ViewBean.executeQuery(sql);


 while (rs.next()){
  //按FIELDS顺序一GET　VALUE
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
              <div align="center">栋号</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="9%">房号</td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="13%"> 
              <div align="center">客户</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="13%"> 
              <div align="center">金额</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="14%"> 
              <div align="center">收款日期</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="11%"> 
              <div align="center">票据类型</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="11%"> 
              <div align="center">票据号码</div>
            </td>
            <td align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1" width="12%"> 
              <div align="center">收款员</div>
            </td>
          </tr>
-->         
<%/*
	String sqlD="";
	
	sqlD="SELECT S.building,S.room,C.cus_name,R.* FROM RepGatheringRecord R inner ";
	sqlD=sqlD+"join saled_circs S on R.cusno=S.cusno inner join customer C on C.SerialNo=R.cusno ";
	sqlD=sqlD+"where DATEPART(yy,InDate)='"+strYear+"' and DATEPART(mm,InDate)='"+strMonth+"'";
	sqlD=sqlD+" and type='"+Type+"'";
		
//设置查询结果的存放变量
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
  //按FIELDS顺序一GET　VALUE
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
	 BillName="收据";
  }
  if(BillName.equals("1")){
  	BillName="发票";
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