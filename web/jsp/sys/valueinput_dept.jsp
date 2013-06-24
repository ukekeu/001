<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%

%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>部门业绩指标</title>
</head>

 <%@ page import="java.sql.*" %>
 <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
  <%@ include file="../public_js/CheckSection.jsp"%>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<script>
 function count1(){
   document.all.perarea.value=parseFloat(document.all.areavalue.value)/parseFloat(document.all.salercount.value);
 
 }
 //限制输入的内容
function inputformat(src,strCheck,e){
var whichcode=(window.Event)?e.which:e.keyCode;
if(whichcode==13)return true;
key=String.fromCharCode(whichcode);
if(strCheck.indexOf(key)==-1)return false;
}
function savevalue(){
        if (document.frm.section.value==''){
		 alert("请选择楼盘");
		 document.frm.section.focus();
		 return false;
		}
		if (parseFloat(document.frm.perarea.value)+parseFloat(document.frm.plansumprice.value)+parseFloat(document.frm.planCount.value)<=0 ){
		 alert("请输入销售计划，至少选择一种");
		 
		 return false;
		}
		
		document.frm.action="valueaction.jsp?Operation=Insert&type=1";
		document.frm.submit();
}

</script>
<body  oncontextmenu="return false" onload="setSelectMad(document.frm.section,'<%=request.getParameter("section") %>');">
<form name=frm method="post">

<%@ include file="../public_js/getByteOut.jsp"%>

<center>
<%
 
String loginID=(String)session.getAttribute("loginid");
if (loginID==null)loginID="";


String SQL="select * from CortrolMan WHERE SerialNo='"+loginID+"'";
 

String control="";
ResultSet qx=null;
try{
  qx = aBean.executeQuery ( SQL );
if (qx.next()){
  control=getbyte(qx.getString("job"));
}
qx.close();
}catch(Exception s){out.println(SQL+s.getMessage());out.close();}
 %>
<p align="center"><b><font class=FontColor size="3" ><b>新增计划</font></b></p>
<table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
<%String section=request.getParameter("section");
  if(section==null)section=""; 
 String currSection=request.getParameter("section");
  %>
  <tr>
    <td width="18%"  class=roomleft >&nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;盘：</td>
    <td class=roomright  >&nbsp;<select name="section" onchange="document.forms[0].submit();">
	 <option value="">请选择小区</option>
	 
	 <%
	
	  if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
 	   String DEPT_NAME="";
	   String sectionstr="";
	   sectionstr="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
	   ResultSet temprs=aBean.executeQuery(sectionstr);
	   while(temprs.next())
	   {
	 %>
	 <option value="<%=temprs.getString(1)%>"><%=getbyte(temprs.getString(2))%></option>
	 <%
	   } 
	   temprs.close(); 
	   
	 %>
	</select>
  </td>
  
    <td width="10%"  class=roomleft >&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月：</td>  
    <td width="25%"   class=roomright colspan="3"><%
	      String RentYear=request.getParameter("RentYear");
		  String RentMonth=request.getParameter("RentMonth");
		  int w=1;
		  java.util.Date curDate=new java.util.Date();
		  int CurYear=curDate.getYear()+1900;
	      int CurMonth=curDate.getMonth()+1;
	      int CurDay=curDate.getDate();
		  if(RentYear==null || RentYear.equals(""))RentYear=CurYear+"";
		  if(RentMonth==null || RentMonth.equals(""))RentMonth=CurMonth+"";
		  %>&nbsp;<select name="RentYear">
		  <%
		for (w=2000;w < 2020;w++){ %>
		<option value="<%=w %>" ><%=w %></option>	
		<%} %>	
		</select>年
		  <select name="RentMonth">
		  <%
		for (w=1;w < 13;w++){ %>
		<option value="<%=w %>" ><%=w %></option>	
		<%} %>	
		</select>月</td>
 <script language="JavaScript">
      setSelectMad(document.all.RentYear,"<%=RentYear%>");
	  setSelectMad(document.all.RentMonth,"<%=RentMonth%>");
	   
   </script>
   <%
   if (section.equals(""))section=currSection;
   String sql="select sum(area) as area,sum(sumprice/10000) sumprice,count(*) num  from room where SaleState=1 and seccode='"+section+"'";
     double  area=0;
	 double sumprice=0;
	 int num=0;
     temprs=aBean.executeQuery(sql);
	 if(temprs.next()){
	   area=temprs.getDouble("area");
	   sumprice=temprs.getDouble("sumprice");
	   num=temprs.getInt("num") ;
	 } %>
	 
	 
    </td> 
  </tr><tr>
    <td width="10%"  class=roomleft >&nbsp;可售面积：</td>  
    <td width="18%"  class=roomright>&nbsp;<input type=text name=areavalue  size=10 value="<%=area %>" onKeyPress="return(inputformat(this,'1234567890.',event));" readonly >M<sup>2</sup></td><!-- onchange="count1();"-->
   <td width="10%"  class=roomleft >&nbsp;可售金额：</td>  
    <td width="18%"  class=roomright>&nbsp;<input type=text name=sumpricevalue  size=10 value="<%=Format.getFloat3(sumprice,0) %>" onKeyPress="return(inputformat(this,'1234567890.',event));" readonly > 万元</td><!-- onchange="count1();"-->
 <td width="12%"  class=roomleft >&nbsp;可售套数：</td>  
    <td width="18%"  class=roomright>&nbsp;<input type=text name=sumCount  size=6 value="<%=num%>" onKeyPress="return(inputformat(this,'1234567890.',event));" readonly > 套</td><!-- onchange="count1();"-->
 
<%sql="select count(*) num  from seller where section_no='"+section+"'";  
  int con=1;
  temprs=aBean.executeQuery(sql);
	 while(temprs.next()){
	   con=temprs.getInt("num");
	 } 
	 if (con==0)con=1;
    String per=Format.getFloat3(area/con,2);
	 String plan=Format.getFloat3(sumprice/con,0);
	 int panNum=num/con;
	temprs.close();
	
  %>
  
  <tr>

    <td width="10%"  class=roomleft >&nbsp;计划面积：</td>  
    <td width="18%"  class=roomright>&nbsp;<input type=text name=perarea  size=10 value="<%=area %>" onblur="checkednum(this,document.frm.areavalue.value,'计划面积不能大于可售面积');"  onKeyPress="return(inputformat(this,'1234567890.',event));" >M<sup>2</sup></td>
	  <td width="10%"  class=roomleft >&nbsp;计划金额：</td>  
    <td width="18%"  class=roomright>&nbsp;<input type=text name=plansumprice  size=10 value="<%=Format.getFloat3(sumprice,0) %>"  onblur="checkednum(this,document.frm.sumpricevalue.value,'计划销售额不能大于预售金额');" onKeyPress="return(inputformat(this,'1234567890.',event));"   > 万元</td><!-- onchange="count1();"-->
 <td width="12%"  class=roomleft >&nbsp;计划套数：</td>  
    <td width="18%"  class=roomright>&nbsp;<input type=text name=planCount  size=6 value="<%=num %>"   onblur="checkednum(this,document.frm.sumCount.value,'计划销售套数不能大于可售套数');" onKeyPress="return(inputformat(this,'1234567890.',event));"   > 套</td><!-- onchange="count1();"-->

  </tr>
  
  </table>
 <p align="left">注意：以上三种计划指标可以根据实际情况填写一种</p>
  <p align=center>
<input type=button name=save value="确   定" onclick="savevalue();">
<input type=reset name=del value="退  出" onclick="window.close();">
</p>

</center>
<script>
 function checkednum(p1,p2,p3)
 {
   if (parseFloat(p1.value)>parseFloat(p2)){alert(p3);p1.focus();}
 }
</script>
</form>
</body>

</html>
