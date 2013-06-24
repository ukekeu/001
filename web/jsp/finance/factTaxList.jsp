<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "代收税费" , 
                  "浏览"
                ) ;
%>

<%@ page language="java" import="java.sql.*,java.util.*, common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean3" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>税费明细表</title>
</head> 
<script language="javascript" src="../public_js/basal.js">
</script>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language=javascript src="../sale/js/mad.js"> </script>
<script>
 function opennewwin(url,para,wh,hg,lf,tp) {
    var mess="是否认购登录还是查看房间资料？(如果是认购请单击‘确认’)";
	//alert(url+para)
	 var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
</script>


<%String cusname=China.getParameter(request,"cusname");
     String secname=China.getParameter(request,"secname");
   cusname=cusname.trim();
String cbdate="";
String cedate="";
cedate = getbyte( request.getParameter("cedate" ) ) ;
cbdate = getbyte( request.getParameter("cbdate" ) ) ;

String Search=request.getParameter("Search");
String para_cusno="";
String sqlpara="";
int i=0;

String SectionNameS="";
String SectionNa="";
SectionNameS=request.getParameter("SecNo");

String BuildingS = "" ;
BuildingS=China.getParameter(request,"Build");


String Loft = "" ;
if(Loft==null)Loft=""; 
if(!secname.equals("")){
   Loft=China.getParameter(request,"Loft");
  }else{Loft=request.getParameter("Loft");}

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
%>


<script language="JavaScript">
 function LoadF(){
 setSelectMad(document.cus.BeginYear,'<%= BeginYearS %>');
 setSelectMad(document.cus.BeginMonth,'<%= BeginMonthS %>');
 setSelectMad(document.cus.BeginDay,'<%= BeginDayS %>');
  
 }
 function Prin(){
 document.cus.action="PrintTaxList.jsp";
 document.cus.submit();
 
 }
</script>
<body onload="document.cus.Room.focus();document.cus.Room.select();">

 
<%
//取得查询条件
String StrWhere="";
if(SectionNameS == null)SectionNameS="";
if(RoomS == null)RoomS="";

if (!SectionNameS.equals("")) StrWhere=" and section='"+SectionNameS+"'";
if (!Loft.equals("")) StrWhere+=" and Loft ='"+Loft+"'";
if (!BuildingS.equals(""))StrWhere+=" and Building='"+BuildingS+"'  ";

if (!RoomS.equals(""))	StrWhere+= " and Room_NO='"+RoomS+"'";
if(!cusname.equals("")) StrWhere+= " and signatory like '%"+cusname+"%'";
if(!secname.equals("")) StrWhere+= " and section = '"+secname+"'";
  %>
 <div id=titl align=center><b><font size="3" color="#000080">
<%=SectionNa %>  客户应交税费明细表
 
 </font></b></div>
 <div id="FactInput" style="position:absolute; left:200px; top:50px; width:250px; height:52px; z-index:1; visibility: hidden"> 
 <iframe id="Input" src="TaxInput.jsp" width="300" height="230" frameborder="0"></iframe>
</div>
 <div id=printdiv>
  <form method="POST" name="cus" action="">
 
  <table border="0" width="100%">
    <tr bgcolor="#EAEAEA"><td>
 <input type=hidden  name=SecNo value="<%=SectionNameS %>">
 <input type=hidden name=Build value="<%=BuildingS %>">
 <input type=hidden name=Loft value="<%=Loft %>">
 <input type=hidden name=cusname>
<input type=hidden name=secname value="">
 <input type=hidden name=rep value=1>
        房号: 
        <input type=text size=5 name=Room value="<%=RoomS%>">&nbsp;
        代收税费日期: 从<input type=input name=cbdate size=10 readonly value="<%=cbdate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cbdate);return false;">到<input type=input name=cedate size=10 readonly value="<%=cedate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cedate);return false;">
        <input type=submit name=find value="查询">
    <%String Cortrol=(String)session.getAttribute("popedomStr"); 
   if (Cortrol==null){Cortrol="";}
    if (Cortrol.indexOf("A")>=0){ %> &nbsp;<img src="../images/button_ssdj.gif" alt="代收登记" onclick="shList('FactInput');">
	<%} %><input type="hidden" name="Input"  value="实收登记" disabled onclick="if (strpara1==''){alert('请选择交款的客户');return false;}else{shList('FactInput');}">
     &nbsp;<img src="../picture/icon_print.gif" alt="打印报表" onclick="Prin();">&nbsp;&nbsp;&nbsp;<input type=radio checked name=rep1 onclick="document.cus.rep.value=1">应交<input type=radio name=rep1 onclick="document.cus.rep.value=2">代收  <!--&nbsp;<input type=checkbox name=all value="3">全部打印-->
<!--      &nbsp;<input type="button" name="Input"  value="代收登记" disabled onclick="shList('FactInput');">&nbsp;&nbsp;&nbsp;<input type=button name=PrintRep value="打印报表" onclick="Prin();"><input type=radio checked name=rep1 onclick="document.cus.rep.value=1">应交<input type=radio name=rep1 onclick="document.cus.rep.value=2">代收-->

		<script>
			function printall() {
			    titl.innerText =document.cus.SecNo.options[document.cus.SecNo.selectedIndex].text+"->> 收款明细表" ;
				printdiv.innerText = "" ;
                           print(); 
			}
		
		</script>
      </td>
  </tr>
</table>
</form>
</div>
<p  align="center"><b>代收税费：</b></p>
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
 
    <td class=TXTColor> 
        <div align="center"> 序号</div>
      </td>
	   <td class=TXTColor> 
        <div align="center">房号</div>
      </td>
      <td class=TXTColor> 
        <div align="center"> 客户</div>
      </td>
	   <td class=TXTColor> 
        <div align="center"> 电话</div>
      </td>
        <td class=TXTColor  > 
        <div align="center" >税费名称</div>
      </td>
	   <td class=TXTColor  > 
        <div align="center" >金额</div>
      </td>
      <td class=TXTColor  > 
        <div align="center" >收取日期</div>
      </td>
     
    
      <td class=TXTColor > 
        <div align="center">收款员</div>
      </td>
	
    </tr>
	
<%
ID=0;

if( ! cbdate.equals( "" ) ) {
    cbdate =  cbdate + " 00:00:00";
}
if( !cedate.equals( "" ) ) {
    cedate = cedate + " 23:59:59";
}
if( !cbdate.equals("") ) {
    StrWhere = StrWhere + "and Indate >= '" + cbdate + "' " ;
}
if( !cedate.equals("") ) {
    StrWhere = StrWhere + "and Indate < '" + cedate + "' " ;
}

sql="select * from RepFactViewList where  section is not null "+StrWhere;

ResultSet rs1=null;
try{
rs1=ViewBean1.executeQuery(sql);

sql1="update  RepFactViewList  set out='0'" ;
ViewBean3.executeUpdate(sql1);
sql1="update  RepFactViewList  set out='1' where  section is not null "+StrWhere;
ViewBean3.executeUpdate(sql1);


 while (rs1.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   Lofts=getbyte(rs1.getString("loft"));
   BuildingS=getbyte(rs1.getString("building"));
   RoomNo=rs1.getString("room_no");
   TaxName=getbyte(rs1.getString("type"));
   TaxMoney=rs1.getFloat("InMoney");
   String DateStr=rs1.getString("Indate");
   String Receiver=getbyte(rs1.getString("Receiver"));
   CusName=getbyte(rs1.getString("signatory"));
    CusPhone=getbyte(rs1.getString("phone"));
   CusNo=rs1.getString("cusno");

    %> 
    <tr class=listcontent id=TR<%=i%>  align="left"  onclick="setpara('<%=CusNo %>','<%=TaxName %>','<%=TaxMoney %>');changeclass1(this,'clickbg','listcontent');document.cus.Input.disabled=false;">
      
      <td  ><%=i%></td>
	  <td  ><%=Lofts+RoomNo%></td>
      <td  ><%=CusName%></td>
	   <td  ><%=CusPhone%></td>
      <td  ><%=TaxName%></td>
	  <td  align="right" ><%=FormatD.getFloat(TaxMoney,2)%></td>
	   <td ><%=DateStr%></td>
      
	     <td    ><%=Receiver%></td>
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}
  rs1.close();
 }catch(Exception ex){out.println(ex.getMessage()+"0");}

%>
	
	</table>
</body>
</html>
