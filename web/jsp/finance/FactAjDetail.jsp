<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*" %> 
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "银行放款" , 
                  "浏览"
                ) ;
%>

<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>按揭明细表</title>
</head> 
<script language="javascript" src="../public_js/basal.js">
</script>

<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>

<%
String Search=request.getParameter("Search");
String para_D=request.getParameter("D");
String para_qs=request.getParameter("para2");
String para_cusno="";
String sqlpara="";
int i=0;
String shouldMoney=request.getParameter("shouldMoney");

String shouldDate=request.getParameter("shouldDate");
if (shouldDate==null)shouldDate="";


if (para_qs!=null){
    String para_qs1=para_qs.substring(0,para_qs.indexOf("*"));
    para_cusno=para_qs.substring(para_qs.indexOf("*")+1);
	if (para_D.equals("M")){
      sqlpara="update GatheringRecord set shouldMoney="+shouldMoney+" where cusno='"+para_cusno+"' and shouldQS='"+para_qs1+"'";
	}else{
      sqlpara="update GatheringRecord set shouldDate='"+shouldDate+"' where cusno='"+para_cusno+"' and shouldQS='"+para_qs1+"'";
	}  
	
 try{
   ViewBean.executeUpdate(sqlpara);
   }catch(Exception es){out.print("可能你输入的数据不对");}
}

String SectionNameS="";
String SectionNa="";
SectionNameS=request.getParameter("SecNo");

String BuildingS="";
BuildingS=request.getParameter("Build");
if(BuildingS==null)	BuildingS="";
if (Search!=null)
BuildingS=new String(BuildingS.getBytes("ISO8859_1"),"GBK");

String Loft="";
Loft=request.getParameter("Loft");
if (Search!=null)
Loft=new String(Loft.getBytes("ISO8859_1"),"GBK");

String RoomS="";
RoomS=request.getParameter("Room");
if(RoomS==null){
	RoomS="";
}
 
String BeginYearS="";
BeginYearS=request.getParameter("BeginYear");
if (BeginYearS==null)BeginYearS="";
String BeginMonthS="";
BeginMonthS=request.getParameter("BeginMonth");
if (BeginMonthS==null)BeginMonthS="";
String BeginDayS="";
BeginDayS=request.getParameter("BeginDay");
if (BeginDayS==null)BeginDayS="";
String choose=China.getParameter(request,"choose");
String noStr="";//未放款
String noyStr="";//已放款
String yesStr="";//已完成放款
if (choose.equals("")||choose.equals("no")){noStr="checked";noyStr="";yesStr="";}
if (choose.equals("noy")){noyStr="checked";noStr="";yesStr="";}
if (choose.equals("yes")){yesStr="checked";noStr="";noStr="";}
%>


<script language="JavaScript">
 function LoadF(){
 setSelectMad(document.cus.BeginYear,'<%= BeginYearS %>');
 setSelectMad(document.cus.BeginMonth,'<%= BeginMonthS %>');
 setSelectMad(document.cus.BeginDay,'<%= BeginDayS %>');
  
 }
</script>
<body onload="document.cus.Room.focus();document.cus.Room.select();">

 
<%
//取得查询条件
String StrWhere="";
if (!RoomS.equals(""))
 StrWhere+=" and room='"+RoomS+"'";
if (!Loft.equals("")) StrWhere+=" and loft='"+Loft+"'";
if (!SectionNameS.equals(""))StrWhere+=" and secno='"+SectionNameS+"'";
  %>
 <div id=titl align=center><b><font size="3" color="#000080">
<%=SectionNa %> 按揭款进度情况明细表
 
 </font></b></div>
 <%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
 <div id="FactInput" style="position:absolute; left:200px; top:50px; width:250px; height:52px; z-index:1; visibility: hidden"> 
 <iframe id="Input" src="AjInput.jsp" width="300" height="200" frameborder="0"></iframe>
</div>
 <div id=printdiv>
  <form method="POST" name="cus" action="">
  <table border="0" width="100%">
  <tr bgcolor="#EAEAEA"><td>
 <input type=hidden  name=SecNo value="<%=SectionNameS %>">
 <input type=hidden name=Build value="<%=BuildingS %>">
 <input type=hidden name=Loft value="<%=Loft %>">
  <input type=hidden name=secname value="">
 <input type=hidden name=cusname value="">
        房号: 
        <input type=text size=5 name=Room value="<%=RoomS%>">
&nbsp;<input type=submit name="find" value="查询">
</td><td align="right">
<% 
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"F007");
   if (Cortrol==null){Cortrol="";}
   %>
&nbsp;&nbsp;<img src="../picture/icon_print.gif" alt="打印报表" onclick="PrinRep();"> &nbsp;<input type="radio" value="no" <%=noStr %> name=choose onclick="document.cus.submit();">未放款<input type="radio" value="noy" <%=noyStr %> name=choose onclick="document.cus.submit();">放款中<input type="radio" <%=yesStr %> value="yes" name=choose onclick="document.cus.submit();">完成放款<input type="hidden"  name="Input"  value="实收登记" disabled onclick="shList('FactInput');">
		<script>
			function PrinRep() {
			   window.open("<%=reportAddrs %>AjMoneyProcessRep.rpt");
			}
		
		</script>
      </td>
  </tr>
</table>
</form>
</div>
    
<table width="100%"  align="center" border="0" cellspacing="1"  cellpadding="1" >
  <tr > 
    <td rowspan="2"  class=listtitle width="6%"><div align="center"><font color="#FFFFFF">序号</font></div></td>
    <td rowspan="2"  class=listtitle width="10%"><div align="center"><font color="#FFFFFF">房号</font></div></td>
    <td  class=listtitle colspan="2"> 
      <div align="center"> <font color="#FFFFFF">客 户</font></div>
    </td>
    <td colspan="2"  class=listtitle   > 
      <div align="center" ><font color="#FFFFFF">按揭款</font></div>
    </td>
    <td colspan="2"  class=listtitle > 
      <div align="center"><font color="#FFFFFF">按揭进度</font></div>
    </td>
	    <td rowspan="2"  class=listtitle width="6%"><font color="#FFFFFF">修改</font></td>
<%if (!yesStr.equals("checked") && Cortrol.indexOf("A")>=0){%>
    <td rowspan="2"  align="center" width="6%" class=listtitle> <font color="#FFFFFF"> 放款登记</font></td>
<%} %>
  </tr>
  <tr > 
    <td  class=listtitle > 
      <div align="center"><font color="#FFFFFF">姓名</font></div>
    </td>
    <td  class=listtitle > 
      <div align="center"><font color="#FFFFFF">电话</font></div>
    </td>
    <td class=listtitle> 
      <div align="center" ><font color="#FFFFFF">金额</font></div>
    </td>
    <td class=listtitle> 
      <div align="center" ><font color="#FFFFFF">月供款</font></div>
    </td>
    <td  class=listtitle> 
      <div align="center"><font color="#FFFFFF">放款金额</font></div>
    </td>
    <td  class=listtitle> 
      <div align="center"><font color="#FFFFFF">未放款金额</font></div>
    </td>
	 
  </tr>
  <%
    String sql="";
    String ShowChoose="";
	if (!noStr.equals(""))ShowChoose=" where  factmoney is null  ";
	if (!noyStr.equals(""))ShowChoose=" where  not  factmoney is null and ovemoneym>0 ";
	if (!yesStr.equals(""))ShowChoose=" where not  factmoney is null and ovemoneym=0";
	if (StrWhere.length()>0) {
   		sql="select * from ViewAjMoneyProcess  "+ShowChoose+StrWhere+" order by room,customer ";
	
	}else{
		sql="select * from ViewAjMoneyProcess  "+ShowChoose+StrWhere+"  order by room,customer ";

	}
	
 
//设置查询结果的存放变量
int ID=0;
String CusNo="";
String CusName="";
String ConstractNo="";
String AjMoney="";
String MonthAjMoney="";
String ShouldAjMoney1="";
String GatherDate="";
String Receiver="";
String Building="";
String Room="";
String Phone="";
String loft="";
String checkmoney="";
String MonthPayMoney="";
String oveMoney="";
String code="";
java.text.DecimalFormat MoneyFormat = new java.text.DecimalFormat("###,###,###.##");

//out.print(sql);
//out.close();

ResultSet rs=null;
try{
rs=ViewBean.executeQuery(sql);

 i=1;
//&& i<pageSize
 while (rs.next()){
  try{
 
  //按FIELDS顺序一GET　VALUE
 CusNo=rs.getString("Customer");
 ConstractNo=rs.getString("ContractNo");
 //Room=rs.getString("Room");

 //GatherDate=getbyte(rs.getString("FactDate"));


 // Receiver=getbyte(rs.getString("Receiver"));
  loft=getbyte(rs.getString("loft"));
  //Building=getbyte(rs.getString("Building"));
  Room=rs.getString("Room");
   AjMoney=rs.getString("AjMoney");
  String ParaValue=AjMoney;
 MonthAjMoney=rs.getString("MonthPayMoney");
 if (!MonthAjMoney.equals("")){
    MonthAjMoney=MoneyFormat.format(java.lang.Float.parseFloat(MonthAjMoney));
  }
 Phone=getbyte(rs.getString("Phone"));
 CusName=getbyte(rs.getString("signatory"));

  ShouldAjMoney1=getbyte(rs.getString("FactMoney"));
  code=getbyte(rs.getString("code"));
  if (ShouldAjMoney1.equals(""))ShouldAjMoney1="0";
  oveMoney=MoneyFormat.format(java.lang.Float.parseFloat(AjMoney)-java.lang.Float.parseFloat(ShouldAjMoney1));
  if (!AjMoney.equals("")){
    AjMoney=MoneyFormat.format(java.lang.Float.parseFloat(AjMoney));
  }
   if (!ShouldAjMoney1.equals("0")){
    ShouldAjMoney1=MoneyFormat.format(java.lang.Float.parseFloat(ShouldAjMoney1));
  }
//  checkmoney=getbyte(rs.getString("out"));
 %>
  <tr class=listcontent id=TR<%=i%>  onmouseover="mout(this);"  align="center"  onclick=";changeclass1(this,'clickbg','listcontent');document.cus.Input.disabled=false;"> 
    <td  align="center" bgcolor="#EBEBEB" ><%=i%></td>
    <td  align="left" bgcolor="#EBEBEB" ><%=loft +Room %></td>
    <td  align="left" bgcolor="#EBEBEB"  ><%=CusName %></td>
    <td  align="left" bgcolor="#EBEBEB"  ><%=Phone %></td>
    <td  align="right"  bgcolor="#EBEBEB" ><%=AjMoney%></td>
    <td  align="right"  bgcolor="#EBEBEB" ><%=MonthAjMoney%></td>
    <td  align="right"  bgcolor="#EBEBEB" ><%=ShouldAjMoney1%></td>
    <td  align="right" ><%=oveMoney%></td>
	 <%if (!noStr.equals("checked") && Cortrol.indexOf("A")>=0){%>
	<td><a href="#" onclick="editajmoney('<%=code %>')"><img  src=../picture/edit.gif alt='修改收款'  ></a></td><%}else{out.print("<td>&nbsp;</tc>");} %>
<td> <%if (Cortrol.indexOf("A")>=0&&!yesStr.equals("checked")){ %>
    &nbsp;<img src="../images/button_ssdj.gif" onclick="setpara('<%=CusNo %>','<%=ParaValue %>','<%=ParaValue %>','<%=code %>');dj();">
<%} %></td>
  </tr>
  <%i++;   
  }catch(Exception ex){out.print(ex.getMessage());}

}  }catch(Exception ex){out.print(ex.getMessage());}
  rs.close();

%>
</table>

 <script>
    var strpara1="";
    var strpara2=""
    var strpara3="";	
    var strpara4="";	
   function EditInto(){
		  if (confirm("真的要修改吗？")){
   	          if (strpara1==""){alert("请选择要修改的记录(只需单击列表中某行一次)");}
		       else{
                          var dd=prompt("请输入正确的应收款金额");
	
                       if (dd!=null&&dd!="")
						   window.location="FactGatherDetail.jsp?para2="+strpara2+"*"+strpara1+"&shouldMoney="+dd+"&D=M";
                      
                         }
			}
  		  }
	function EditD(){
		  if (confirm("真的要修改吗？")){
   	          if (strpara1==""){alert("请选择要修改的记录(只需单击列表中某行一次)");}
		       else{
                          var dd=prompt("请输入正确的应收款日期");
                           if (dd!=null&&dd!="")
						   window.location="FactGatherDetail.jsp?para2="+strpara2+"*"+strpara1+"&shouldDate="+dd+"&D=D";
                      
                         }
			}  
  		  }
  function CheckMoeny(frm,cusno){
    if (frm.checked){
	   if (confirm("确认记帐？记帐后数据不能再修改")){
	    openwin("CheckMoney.jsp?Aj=aj&CusNo="+cusno,20,10,10,10);
	   }
	 }
  }		  
  function Edit(cusno,no){
    openwin("FactGatherDataD.jsp?CusNo="+cusno+"&no="+no,300,300,100,100);

	
  }		  

  function setpara(para1,para2,para3,para4){
    strpara1=para1;
	Input.document.cus1.cusno.value=strpara1;
	Input.document.cus1.ajmoney.value=para2;
	Input.document.cus1.FactMoney.value=para3;
	Input.document.cus1.contractno.value=para4;
	
  }
 function editajmoney(para){
    openwin("AjEdit.jsp?code="+para,300,250,100,100);
 
 }
 function dj(){
 if (strpara1==""){alert("请选择登记的客户");return false;}
 
 shList('FactInput');
 
 
 
 }
</script>
</body>
</form>
</html>