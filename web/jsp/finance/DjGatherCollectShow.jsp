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
<title>支取费用汇总表</title>
</head> 
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>

<body>
<DIV id="Layer1" style="position: absolute; left: 0; top: -7; width: 600; height: 242; z-index: 1">
<hr width=635> 
</div>
<DIV id="Layer1" style="position: absolute; left: 0; top: 5; width: 635; height: 242; z-index: 1"> 
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
	String SectionName="";
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
	
	sql="select Name FROM crm_project where  SerialNo='"+SectionNameS+"'";
	ResultSet rsH=ViewBean.executeQuery(sql);
	if(rsH.next()){
		SectionName=rsH.getString("Name");
	}
	rsH.close();
%>
   <p  align="center" > 支取费用汇总表 <hr size=1 width=80%>
   <p  align="center" >
    
<table width="80%" border="1" cellspacing cellpadding>
<TR>
      <td width="10%" align="center" height="23"   >楼盘:</td>
      <td colspan="3" align="center" height="23"   ><%=SectionName%></td>
	   <td colspan="3" align="center" height="23"   >日期:</td>
      <td colspan="8" align="center" height="23"   ><%=BeginYearS%>年<%=BeginMonthS%>月</td>
    </tr>
  </table>
<table width="80%" border="1" cellspacing cellpadding>
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
      <td width="54%" align="center" height="23"  ><%=Type%></td>
      <td width="30%" align="center" height="23"  ><%=strTotalMoney%></td>
    </tr>
<!--    <tr> 
      <td colspan="2">
        <table width="100%" border="0" cellspacing cellpadding height="26">
          <tr>
            <td align="center" height="23"   style="border-style: solid; border-width: 1" width="21%">栋号</td>
            <td align="center" height="23"   style="border-style: solid; border-width: 1" width="11%">房号</td>
            <td align="center" height="23"   style="border-style: solid; border-width: 1" width="25%">金额</td>
            <td align="center" height="23"   style="border-style: solid; border-width: 1" width="22%">日期</td>
            <td align="center" height="23"   style="border-style: solid; border-width: 1" width="21%">支取人</td>
          </tr>
-->          <%
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
  String strInMoney=MoneyFormat.format(InMoney);
  if(java.lang.Integer.parseInt(strInMoney.substring(strInMoney.indexOf(".")+1))==0){
	   strInMoney=strInMoney.substring(0,strInMoney.indexOf("."));
  }
  InDate=rsD.getString("Date");
  java.text.SimpleDateFormat date =null;
  date=new java.text.SimpleDateFormat("yyyy-MM-dd");
  InDate=date.format(date.parse(InDate));
  Person=rsD.getString("person");
	%> 
<!--          <tr align="center" BGCOLOR="#e6f9ff"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');">
            <td align="center" height="23" style="border-style: solid; border-width: 1" width="21%"><%=Building%></td>
            <td align="center" height="23" style="border-style: solid; border-width: 1" width="11%"><%=Room%></td>
            <td align="center" height="23" style="border-style: solid; border-width: 1" width="25%"><%=strInMoney%></td>
            <td align="center" height="23" style="border-style: solid; border-width: 1" width="22%"><%=InDate%></td>
            <td align="center" height="23" style="border-style: solid; border-width: 1" width="21%"><%=Person%></td>
          </tr>
-->          <% }
	rsD.close();%> 
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

</div>
</body>
</form>
</html>