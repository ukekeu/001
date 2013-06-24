<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBeanD" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>支取费用汇总表</title>
</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>

<%
String SectionNameS="";
SectionNameS=request.getParameter("SectionName");
String BuildingS="";
BuildingS=request.getParameter("Building");
if(BuildingS==null){
	BuildingS="";
}
String RoomS="";
RoomS=request.getParameter("Room");
if(RoomS==null){
	RoomS="";
}
String BeginYearS="";
BeginYearS=request.getParameter("BeginYear");
String BeginMonthS="";
BeginMonthS=request.getParameter("BeginMonth");
%>
<script>
function FullD(){
 CurrDate =new Date();
 setSelectMad(cus.BeginYear,CurrDate.getYear());
 setSelectMad(cus.BeginMonth,CurrDate.getMonth());
 setSelectMad(document.cus.BeginYear,'<%= BeginYearS %>');
 setSelectMad(document.cus.BeginMonth,'<%= BeginMonthS %>');
 setSelectMad(document.cus.SectionName,'<%= SectionNameS %>');
}
 </script> 
<body onload="FullD();">
<form method="POST" name="cus" action="">
<%
//取得查询条件
String StrWhere="";
/*
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
*/
  %>
<!-- <input type="hidden" name="StrWhere" value="<%=StrWhere%>">
-->  
                  <p align="center"><b><font size="3" color="#000080">支取费用汇总表</font></b>
    <table border="0" width="100%">
            <tr>
      <td width="557" valign="top" bgcolor="#96C7D1">&nbsp;楼盘： 
        <select size="1" name="SectionName">
          <%
		     String Sql="select SerialNo, Name from Section";
		     ResultSet Rs=ViewBean.executeQuery(Sql);
		     while (Rs.next()){
		%> 
          <option value=<%=Rs.getString("SerialNo") %>><%=getbyte(Rs.getString("Name")) %></option>
          <%}
		   Rs.close();
		%> 
        </select>
        栋号: 
        <input type=text size=5 name=Building value="<%=BuildingS%>">
        房号： 
        <input type=text size=5 name=Room value="<%=RoomS%>">
        日期 
        <select size="1" name="BeginYear" style="border-style: solid; border-width: 1">
          <option value="2001">2001</option>
          <option value="2002">2002</option>
          <option value="2003">2003</option>
          <option value="2004">2004</option>
          <option value="2005">2005</option>
          <option value="2000">2000</option>
          <option value="1999">1999</option>
        </select>
        年 
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
        月
<input type="submit" name="Search" value="查询">
  </table>
  
   <%

	String sql="";
	String SectionName="";
	float SumMoney=0;
	SectionNameS=request.getParameter("SectionName");

	BuildingS=request.getParameter("Building");
	if(BuildingS==null){
		BuildingS="";
	}
	RoomS=request.getParameter("Room");
	if(RoomS==null){
		RoomS="";
	}
	BeginYearS=request.getParameter("BeginYear");
	BeginMonthS=request.getParameter("BeginMonth");
	
	sql="select Name FROM crm_project where  SerialNo='"+SectionNameS+"'";
	ResultSet rsH=ViewBean.executeQuery(sql);
	if(rsH.next()){
		SectionName=rsH.getString("Name");
	}
	rsH.close();
if (SectionNameS==null)return;
%>
  <p align="center"><b><font size="3" color="#000080">支取费用汇总表</font></b>
  <hr size=1 width=80%>
  <p  align="center" >
    
 <table width="80%" align=center border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
<TR>
      <td width="10%" align="center" height="23"   >楼盘:</td>
      <td colspan="3" align="center" height="23"   ><%=SectionName%></td>
	   <td colspan="3" align="center" height="23"   >日期:</td>
      <td colspan="8" align="center" height="23"   ><%=BeginYearS%>年<%=BeginMonthS%>月</td>
    </tr>
  </table>
 <table width="80%" align=center border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
    <tr>
      <td width="30%"  align="center" height="23"    >款项名称</td>
      <td width="30%" align="center" height="23">总金额</td>
    </tr> 
<%
if(SectionNameS.length()>0){
		if(BuildingS.length()>0){
			if(RoomS.length()>0){
				if(BeginYearS.length()>0){
					if(BeginMonthS.length()>0){
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and Building='"+BuildingS+"' and ";
						StrWhere=StrWhere+" Room='"+RoomS+"' ";
						StrWhere=StrWhere+" and DATEPART(yy,Date)='"+BeginYearS+"' ";
						StrWhere=StrWhere+" and DATEPART(mm,Date)='"+BeginMonthS+"'";
					}else{
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and Building='"+BuildingS+"' and ";
						StrWhere=StrWhere+" Room='"+RoomS+"' ";
						StrWhere=StrWhere+" and DATEPART(yy,Date)='"+BeginYearS+"' ";
					}
				}else{
					if(BeginMonthS.length()>0){
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and Building='"+BuildingS+"' and ";
						StrWhere=StrWhere+" Room='"+RoomS+"' ";
						StrWhere=StrWhere+" and DATEPART(mm,Date)='"+BeginMonthS+"'";
					}else{
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and Building='"+BuildingS+"' and ";
						StrWhere=StrWhere+" Room='"+RoomS+"' ";
					}
				}
			}else{
				if(BeginYearS.length()>0){
					if(BeginMonthS.length()>0){
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and Building='"+BuildingS+"'";
						StrWhere=StrWhere+" and DATEPART(yy,Date)='"+BeginYearS+"' ";
						StrWhere=StrWhere+" and DATEPART(mm,Date)='"+BeginMonthS+"'";
					}else{
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and Building='"+BuildingS+"'";
						StrWhere=StrWhere+" and DATEPART(yy,Date)='"+BeginYearS+"' ";
					}
				}else{
					if(BeginMonthS.length()>0){
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and Building='"+BuildingS+"'";
						StrWhere=StrWhere+" and DATEPART(mm,Date)='"+BeginMonthS+"'";
					}else{
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and Building='"+BuildingS+"'";
					}
				}
			}
		}else{
			if(RoomS.length()>0){
				if(BeginYearS.length()>0){
					if(BeginMonthS.length()>0){
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and ";
						StrWhere=StrWhere+" Room='"+RoomS+"' ";
						StrWhere=StrWhere+" and DATEPART(yy,Date)='"+BeginYearS+"' ";
						StrWhere=StrWhere+" and DATEPART(mm,Date)='"+BeginMonthS+"'";
					}else{
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and ";
						StrWhere=StrWhere+" Room='"+RoomS+"' ";
						StrWhere=StrWhere+" and DATEPART(yy,Date)='"+BeginYearS+"' ";
					}
				}else{
					if(BeginMonthS.length()>0){
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and ";
						StrWhere=StrWhere+" Room='"+RoomS+"' ";
						StrWhere=StrWhere+" and DATEPART(mm,Date)='"+BeginMonthS+"'";
					}else{
						StrWhere=" and SectionNo='"+SectionNameS+"'"+" and ";
						StrWhere=StrWhere+" Room='"+RoomS+"' ";
					}
				}
			}else{
				if(BeginYearS.length()>0){
					if(BeginMonthS.length()>0){
						StrWhere=" and SectionNo='"+SectionNameS+"'";
						StrWhere=StrWhere+" and DATEPART(yy,Date)='"+BeginYearS+"' ";
						StrWhere=StrWhere+" and DATEPART(mm,Date)='"+BeginMonthS+"'";
					}else{
						StrWhere=" and SectionNo='"+SectionNameS+"'";
						StrWhere=StrWhere+" and DATEPART(yy,Date)='"+BeginYearS+"' ";
					}
				}else{
					if(BeginMonthS.length()>0){
						StrWhere=" and SectionNo='"+SectionNameS+"'";
						StrWhere=StrWhere+" and DATEPART(mm,Date)='"+BeginMonthS+"'";
					}else{
						StrWhere=" and SectionNo='"+SectionNameS+"'";
					}
				}
			}
		}
	}
	//设定查询
	if (StrWhere.length()>0) {
   		sql="SELECT type,sum(Money) as TotalMoney FROM DjGatheringRecord ";
		sql=sql+"where id>0 "+StrWhere;
		sql=sql+" group by SectionNo,Building,Room,type,DATEPART(yy,Date),DATEPART(mm,Date) ";
		
//设置查询结果的存放变量
String Type="";
int TotalMoney=0;
ResultSet rs=ViewBean.executeQuery(sql);
 while (rs.next()){
  //按FIELDS顺序一GET　VALUE
  Type=rs.getString("type");
  TotalMoney=rs.getInt("TotalMoney");
  SumMoney+=TotalMoney;
  String strTotalMoney=FormatD.getFloat(TotalMoney,2);
 
 %> 

	<tr>
      <td width="54%" align="center" height="23"  ><%=Type%></td>
      <td width="30%" align="center" height="23"  ><%=strTotalMoney%></td>
    </tr>
     <%
	String sqlD="";
	
	sqlD="SELECT * FROM DjGatheringRecord ";
	sqlD=sqlD+"where id>0 "+StrWhere;
		
//设置查询结果的存放变量
String Building="";
String Room="";
String CusNo="";
int InMoney=0;
String InDate="";
String Person="";

//out.print(sql);
ResultSet rsD=ViewBeanD.executeQuery(sqlD);

 while (rsD.next()){
  //按FIELDS顺序一GET　VALUE
  Building=rsD.getString("building");
  Room=rsD.getString("Room");
  //CusNo=rsD.getString("cus_name");
  InMoney=rsD.getInt("Money");
  String strInMoney=FormatD.getFloat(InMoney,2);
 
  InDate=rsD.getString("Date");
  java.text.SimpleDateFormat date =null;
  date=new java.text.SimpleDateFormat("yyyy-MM-dd");
  InDate=date.format(date.parse(InDate));
  Person=rsD.getString("person");
	%> 
     <% }
	rsD.close();%> 
 <%
  }
	rs.close();
}
%> 
 <tr bgcolor="#EBEBEB">
      <td width="30%"  align="center" height="23"    >合计：</td>
      <td width="30%" align="center" height="23"><%=FormatD.getFloat(SumMoney,2) %>元</td>
    </tr> 
</table>
</body>
</form>
</html>