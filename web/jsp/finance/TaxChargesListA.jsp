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
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"A004");


 %>
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
        代收日期: 从<input type=input name=cbdate size=10 readonly value="<%=cbdate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cbdate);return false;">到<input type=input name=cedate size=10 readonly value="<%=cedate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cedate);return false;">
        <input type=submit name=find value="查询">
    <%if (Cortrol.indexOf("A")>=0){ %> <input type=button  name=count value="费用计算" onclick="openwin('TaxCount.jsp?section=<%=SectionNameS %>',10,10,10,10);"><%} %>
	 <input type="hidden" name="Input"  value="实收登记" disabled onclick="if (strpara1==''){alert('请选择交款的客户');return false;}else{shList('FactInput');}"> <%if (Cortrol.indexOf("P")>=0){ %><input type=button  name=count value="打印报表" onclick="openwin('auto_select3.jsp',300,250,100,100)"><%} %>
     

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
   <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >序号</td><td  >房号</td><td  > 客户 </td><td  > 电话 </td>
      <td    >费用名称</td><td>金额</td><td>代收金额</td><td>代收日期
      </td><td>票据号</td><td>代收人</td>
    </tr>
	
  
    <%
String sql="";
String sql1="";
	
	//设定查询

   		sql="select * from TaxViewList where section is not null "+StrWhere+" order by room_no desc";
//设置查询结果的存放变量
int ID=0;
String RoomNo="";
String CusNo="";
String CusName="";
String CusPhone="";
String TaxName="";
String Lofts="";
float TaxMoney=0;
String Order_Code="";
String Sectionname="";
String ajSection="";
String floors="";
sql1="update  TaxViewList  set out='0' ";
ViewBean1.executeUpdate(sql1);
sql1="update  TaxViewList  set out='0' where  section is not null "+StrWhere;
ViewBean1.executeUpdate(sql1);

ResultSet rs=ViewBean.executeQuery(sql);

 i=0;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   ajSection=rs.getString("section");
   Lofts=getbyte(rs.getString("Loft"));
   CusName=getbyte(rs.getString("signatory"));
   CusPhone=getbyte(rs.getString("phone"));
  // BuildingS=getbyte(rs.getString("building"));
   RoomNo=rs.getString("room_no");
   TaxName=getbyte(rs.getString("TaxName"));
   TaxMoney=rs.getFloat("TaxMoney");
   String factdate=getbyte(rs.getString("factdate"));
   if (!factdate.equals(""))factdate=factdate.substring(0,factdate.indexOf(" "));
   String factmoney=getbyte(rs.getString("factmoney"));
   String factperson=getbyte(rs.getString("factperson"));
   String buillnum=getbyte(rs.getString("buillnum"));
   Order_Code=getbyte(rs.getString("code"));
   floors=getbyte(rs.getString("floors"));
    %> 
    <tr class=listcontent id=TR<%=i%>  align="left"  title="双击可登记代收费用" ondblClick="openwin('TaxInput.jsp?code=<%=Order_Code %>',300,300,100,100);" onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	  <td  ><a href="#" onclick="opennewwin('../sale/showContract.jsp','?secname=<%=Sectionname %>&secno=<%=ajSection %>&roomno=<%=RoomNo%>&build=<%=BuildingS%>&loft=<%=Lofts %>&Floor=<%=floors %>&show=true',680,530,120,2)"><%=Lofts+RoomNo%></td>
      <td  ><%=CusName%></td>
	   <td  ><%=CusPhone%></td>
      <td  ><%=TaxName%></td>
	  <td  ><%=TaxMoney%></td>
      <td  align="right"><%=factmoney%></td>
	   <td  align="right"><%=factdate%></td>
	    <td  align="right"><%=buillnum%></td>
	    <td  align="right"><%=factperson%></td>
		
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}
  rs.close();
%>
</table>
 
 <script>
   var strpara1="";
    var strpara2=""
 var strpara3="";	
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
  function CheckMoeny(frm,cusno,no){
    if (frm.checked){
	   if (confirm("确认记帐？记帐后数据不能再修改")){
	    openwin("CheckMoney.jsp?CusNo="+cusno+"&no="+no,20,10,10,10);
	   }
	 }
  }		  
  function Edit(cusno,no){
    openwin("FactGatherDataD.jsp?CusNo="+cusno+"&no="+no,300,300,100,100);

	
  }		  

  function setpara(para1,para2,para3,para4){
    strpara1=para1;
    strpara2=para2;
    strpara3=para3;
	 strpara4=para4;
	Input.document.cus1.cusno.value=strpara1;
	Input.document.cus1.TAXNAME.value=strpara2;
	Input.document.cus1.FactMoney.value=strpara3;
	Input.document.cus1.FactMoney1.value=strpara3;
	Input.document.cus1.no.value=strpara4;
  }

</script>
</body>
</form>
</html>