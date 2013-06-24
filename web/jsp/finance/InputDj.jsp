<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"F002");


 %>
<HTML>
<HEAD>
<TITLE>临定定金收取</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function CurrRa(){
 //汇率转换
   var curryName=document.cus.curry.options[document.cus.curry.selectedIndex].value;
   for (var jj=0;jj<RateName.length;jj++)
    {
	  if (RateName[jj]==curryName)
	  {
	   document.cus.rate.value=RateValue[jj];
	 //  document.cus.dicprice.value=parseFloat(document.cus.countdiscprice.value)/parseFloat(document.cus.rate.value);
	   break;
	  }
	}
 
 } 
function checkedDate(){
  
  if (document.cus.factDate.value==""){
    alert("请选择收款日期");
    return false;
  }
 
  if (document.cus.factdj.value!="") {
    if (isNaN(document.cus.factdj.value)){
	  alert("请录入正确的收款金额");
	  return false;
   }
  }else{
   alert("请录入客户临定定金");
   return false;
  
  }
 
   return true;

}
function list1(){
    openwin2("seleview.jsp?list=list",300,300,200,50);  
 }
 function remo(){
  document.cus.seller.options[document.cus.seller.selectedIndex]=null;
 for (var j=0;j<document.cus.seller.length;j++){
	 if (document.cus.seller.options[j].text!="")
	 document.cus.seller.options[j].selected=true;
	}
}
function FindOption(){
openwin2("FindCustomer.jsp?section="+document.cus.SecNo.value+"&FindCus="+document.cus.cusname1.value,300,380,300,100);  
 }
</script>

</HEAD>
<%
         
	//生成币另汇率数组
	
	String RateSql="select * from currrate";
	ResultSet RateRs=null;
	
	try{
	  RateRs=ViewBean.executeQuery(RateSql);
	
	  out.print("<script>");
	  out.print("var RateName=new Array();");
	  out.print("var RateValue=new Array();");
	  int iii=0;
	
	   while (RateRs.next()){
	     out.print("RateName["+String.valueOf(iii)+"]="+"\""+getbyte(RateRs.getString("CurrName"))+"\""+";");
	     out.print("RateValue["+String.valueOf(iii)+"]="+"\""+RateRs.getString("CurrRate")+"\""+";");
		 iii++;
	      }	 
	}catch(Exception s){  out.print(s.getMessage());out.close();}
	RateRs.close();
	out.print("</script>");


          String Floor="";
		  String area="";
		  String fx="";
		  String cx="";
		  String jg="";
          String zx="";
          String state="";
		  String usearea="";
		  String apportionarea="";
		  String date="";
		  String fl="";
		  String unitprice="";
          String sumprice="";	
		  String picpath="";
	      String TNunitprice="";
     	  String name="";
		  String StrLoft="";
		  String StrBuilding="";
		  String StrSecNo="";
		  String StrRoom_code="";
	      
		  String ldStartDate="";
		  String ldEndDate="";
		  String CusTel="";
		  String CusSj="";
		  String Cusbbj="";
		  String CusCardId="";
		  String CusDJ="";
		  String SalePrice="";
		  String Seller="";
          String CusName="";
		  String ldcurr="";
		  String ldbillnum="";
		  String lddjperson="";
		  String ldrate="";
		  String PayType="";
		  String BillType="";
		java.text.SimpleDateFormat date1 =null;
        date1=new java.text.SimpleDateFormat("yyyy-MM-dd");
        String TodayDate=date1.format(new java.util.Date()).toString();
        int curyear=Integer.parseInt(TodayDate.substring(0,4));
        int curmonth=Integer.parseInt(TodayDate.substring(5,7));
        int curday=Integer.parseInt(TodayDate.substring(8,10));
		
        String code=request.getParameter("code") ;
		String sql="select R.*,S.Name from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.code="+code;
		java.text.DecimalFormat df = new java.text.DecimalFormat(" #########.####"); 
        java.text.DecimalFormat df1 = new java.text.DecimalFormat(" #########.##"); 
        java.text.DecimalFormat df2 = new java.text.DecimalFormat(" #########"); 
		ResultSet rs=ViewBean.executeQuery(sql);
	 
		if (rs.next()){
		  code=rs.getString("Code");
		  StrSecNo=rs.getString("seccode");
		  StrLoft=getbyte(rs.getString("Loft"));
		  StrBuilding=getbyte(rs.getString("building"));
		  StrRoom_code=getbyte(rs.getString("Room_code"));
		  Floor=rs.getString("Floor");
		  area=df.format(rs.getFloat("Area"));
		  fx=getbyte(rs.getString("Room_Type"));
		  cx=getbyte(rs.getString("Direction"));
		  jg=getbyte(rs.getString("Scene"));
		  zx=getbyte(rs.getString("Fitment"));
          state=getbyte(rs.getString("salestate"));
		  usearea=df.format(rs.getFloat("UsedArea"));
		  apportionarea=df.format(rs.getFloat("ApportionArea"));
		  date=rs.getString("Serve_Date");
		  java.text.SimpleDateFormat Fdate =null;
  		  Fdate=new java.text.SimpleDateFormat("yyyy-MM-dd");
  		  date=Fdate.format(Fdate.parse(date));
		  fl=getbyte(rs.getString("roomtype"));
		  unitprice=df1.format(rs.getFloat("Unitprice"));
          sumprice=df2.format(rs.getFloat("Sumprice"));
		  picpath=rs.getString("Map");
		  TNunitprice=df1.format(rs.getFloat("TNunitprice"));
	  	  name=getbyte(rs.getString("Name"));
     }
	 rs.close();
	 sql="select SL_TemporarilyBuy.*,customer.signatory from  SL_TemporarilyBuy,customer where   customer.serialno=SL_TemporarilyBuy.cusname and   SL_TemporarilyBuy.id="+request.getParameter("ldid");
	 rs=ViewBean.executeQuery(sql);
 
    String context="";
	String LDID="";	
	String zto="";
	String tk="0";
	String tk_date="0";
	String tk1="0";
	String tk_date1="0";
	String fact_dj="0";
	String fact_date="";
	if (rs.next()){
	    LDID=rs.getString("ID");
		ldStartDate=rs.getString("StartDate");
		ldStartDate=ldStartDate.substring(0,ldStartDate.indexOf(" "));
		ldEndDate=getbyte(rs.getString("EndDate"));
		if (!ldEndDate.equals(""))
		ldEndDate=ldEndDate.substring(0,ldEndDate.indexOf(" "));
		CusDJ=rs.getString("subscription");
		Seller=getbyte(rs.getString("receiver"));
		CusTel=rs.getString("tel");
		CusSj=rs.getString("sj");
		Cusbbj=rs.getString("bbj");
		SalePrice=rs.getString("SalePrice");
		CusCardId=rs.getString("CardId");
		ldcurr=getbyte(rs.getString("curr"));

		ldrate=getbyte(rs.getString("rate"));
		lddjperson=getbyte(rs.getString("person"));
		BillType=getbyte(rs.getString("BillType"));
		ldbillnum=getbyte(rs.getString("bill_num"));
		PayType=getbyte(rs.getString("PayType"));
		zto=getbyte(rs.getString("zto"));
		context=getbyte(rs.getString("remark"));
		
		CusName=getbyte(rs.getString("signatory"));
		  fact_dj=getbyte(rs.getString("fact_dj"));
		  fact_date=getbyte(rs.getString("fact_date"));
		if (!fact_date.equals(""))fact_date=fact_date.substring(0,10);
		else fact_date=curyear+"-"+curmonth+"-"+curday;
		tk=getbyte(rs.getString("tk"));
		tk_date=getbyte(rs.getString("tk_date"));
		if (!tk_date.equals(""))tk_date=tk_date.substring(0,10);
		tk1=getbyte(rs.getString("tk1"));
		if (tk1.equals(""))tk1="0";
		if (tk.equals(""))tk="0";
                if (ldrate.equals(""))ldrate="1";
		tk_date1=getbyte(rs.getString("tk_date1"));
		if (!tk_date1.equals(""))tk_date1=tk_date1.substring(0,10);
	}
	 rs.close();
 
 %>
<BODY onload=";setSelectMad(document.cus.PayType,'<%=PayType %>');setSelectMad(document.cus.BillType,'<%=BillType %>');setSelectMad(document.cus.curry,'<%=ldcurr %>')">
<script language="javascript" src="../public_js/public.js"></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 <form name="cus" method="POST" action="SaveModiTemporarilyBuy.jsp?LDID=<%=LDID %>">
<input type="hidden" name="action" value=""> 
 <p align="center"><font size=3 class=FontColor><b>临定定登记</b></font></p>
 <center>
 
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center bordercolor="#000000" class="tablefill">
  <input type=hidden name=code value="<%=code %>">
  <input type=hidden name=codeold value="<%=code %>">
  <tr>
    <td width="25%" class=roomleft>&nbsp;楼盘名称：</td>  
    <td width="25%" class=roomright  >&nbsp<%=name %><input type=hidden name=SecNa  readonly size=10  value=<%=name %>></td>
	<input type=hidden name=SecNo value=<%=StrSecNo%>>
 <input type=hidden name=SecName  value=<%=name %>>
	<input type=hidden name=Build readonly size=10 value=<%=StrBuilding %>>
	<input type=hidden name=RoomNo readonly size=15 value=<%=StrRoom_code%>>
	<input type=hidden name=Loft readonly size=15 value=<%=StrLoft%>>
	<input type=hidden name=jzarea readonly size=15 value=<%=area%>>
	<input type=hidden name=tnarea readonly size=15 value=<%=usearea%>>
	<input type=hidden name=change  size=15 value="">
	
    <td width="25%" class=roomleft>&nbsp;房号</td>  
    <td width="25%" class=roomright  > <%=StrLoft+StrBuilding+StrRoom_code %></td>
  </tr>
<script>
  function RList(){
		   openwin("RoomCodeShow3.jsp?secno=<%=StrSecNo %>",500,450,100,10);
    }
</script>
  <tr>
    <td width="25%" class=roomleft>&nbsp;建筑面积：</td>
    <td width="25%" class=roomright  ><div id="idjzarea"><%=area%></div></td>
 
    <td width="25%" class=roomleft>&nbsp;套内面积：</td>  
    <td width="25%" class=roomright  ><div id="idusearea"><%=usearea%></div></td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;建筑单价：</td>
    <td width="25%" class=roomright  ><div id="idsaleunitprice"><%=TNunitprice %></div></td>
 <input type=hidden name=idunitprice readonly size=15 value=<%=area%>>
    <td width="25%" class=roomleft>&nbsp;套内单价：</td>  
    <td width="25%" class=roomright  ><div id="idunitprice"><%=unitprice %></div></td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;总价：</td>
    <td width="25%" class=roomright  ><%=sumprice %></td>
 
    <td width="25%" class=roomleft>&nbsp;交楼日期：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=date %></td>
  </tr>
   
  <tr>
     <td width="25%" class=roomleft>&nbsp;临定日期：</td>
    <td width="25%" class=roomright  >&nbsp;<%=ldStartDate %></td>
  
   <td width="25%" class=roomleft>&nbsp;失效日期：</td>
    <td width="25%" class=roomright  >&nbsp;<%=ldEndDate%> </td>
 
  </tr>
   <tr>
    <td width="25%" class=roomleft>&nbsp;客户姓名：</td>
	<input type=hidden name=cusname>
    <td width="25%"  class=roomright  >&nbsp;<%=CusName %></td>
 
    <td width="25%" class=roomleft>&nbsp;身份证号：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=CusCardId %></td>
  </tr>
  <tr>
   <td width="25%" class=roomleft>&nbsp;联系电话：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=CusTel %></td>
 
    <td width="25%" class=roomleft>&nbsp;联系手机：</td>
	<input type=hidden name=cusname>
    <td width="25%" class=roomright  >&nbsp;<%=CusSj %></td>
 
     </tr>
   <tr>
    <td width="25%" class=roomleft>&nbsp;BB机：</td>  
    <td width="25%" class=roomright   >&nbsp;<%=Cusbbj %></td>

    <td width="25%" class=roomleft>&nbsp;销售员：</td>
     <td class=roomright >&nbsp;<%=Seller %>
</td>

  </tr> 

<tr>
  <td width="25%" class=roomleft>&nbsp;应收订金：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=CusDJ %></td>

    <td width="25%" class=roomleft>&nbsp;临定售价：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=SalePrice %></td>
</tr> 
<tr>
  <td width="25%" class=roomleft>&nbsp;实收订金：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name="factdj"  value="<%=fact_dj %>" onblur="check(document.cus.factdj)"  size=15 onKeyDown="key(document.cus.BillType)"></td>

    <td width="25%" class=roomleft>&nbsp;实收日期：</td>  
    <td width="25%" class=roomright  >&nbsp;<INPUT TYPE=TEXT NAME=factDate size=12 value="<%=fact_date%>"   ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(factDate);return false;">
	</td>
</tr> 
<tr> 
 <td width="25%" class=roomleft>&nbsp;币&nbsp;&nbsp;&nbsp;&nbsp;种</td>
      <td width="25%" class=roomright  >&nbsp;<select name="curry" style="width : 70" OnChange="CurrRa();">
          <option value="RMB">人民币</option>
          <option value="HKD">港元</option>
          <option value="USD">美元</option>
        </select><input type=text name="rate"  value="<%=ldrate %>"  size="4" title="汇率" >
 </td>
 <td width="25%" class=roomleft>&nbsp;票据</td>
 <td width="25%" class=roomright  >&nbsp;<select size="1" name="BillType" onkeydown="key(document.cus.billnum)" >
            <option value="0">收据</option>
            <option value="1">发票</option>
		
          </select><input type=text title="票据号" size=8 name="billnum"  value="<%=ldbillnum %>" onblur="check(document.cus.dj)"  size=15 onKeyDown="key(document.cus.person)">
</td>
</tr>
<tr> 
 <td width="25%" class=roomleft>&nbsp;收款人</td>
      <td width="25%" class=roomright  >&nbsp;<input  type=text  name="person"   value="<%=(String) session.getAttribute("loginname") %>">
		  <%
           String StrSql="";
            ResultSet codeRS=null;
		    
		   %>
		  

 </td>
 <td width="25%" class=roomleft>&nbsp;付款类型</td>
 <td width="25%" class=roomright  >&nbsp;<select size="1" name="PayType"  onkeydown="key(document.cus1.PayTypeNo)" style="border-style: solid; border-width: 1">
            <%
	  StrSql="select type,codename from CODE where type='U' order by type";
          codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
		     String codena=getbyte(codeRS.getString("codename"));
			 out.print("<option value='"+codena+"'>"+codena+"</option>");
		   }
		   codeRS.close();
				%>
          </select>
</td>
</td>
</tr>	
 
<tr> 
 <td width="25%" class=roomleft>&nbsp;备注</td>
      <td width="25%" class=roomright  colspan="3" >&nbsp;<input type=text name="context"  size=52  value="<%=context %>" onKeyDown="key(document.cus.save)">
 </td>
 
</tr>	
<%if (Double.parseDouble(fact_dj)>0){ %> 
<tr> 
 <td width="25%" class=roomleft>&nbsp;退款</td>
      <td width="25%" class=roomright  >&nbsp;<input type=text name="tk"  size=15 value="<%=tk %>" onKeyDown="key(document.cus.save)">
 </td>
 <td width="25%" class=roomleft>&nbsp;退款日期</td>
      <td width="25%" class=roomright  >&nbsp;<input type=text name="tkDate1" value="<%=tk_date %>" size=15  onKeyDown="key(document.cus.save)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(tkDate1);return false;">
 </td>
</tr>	
<tr> 
 <td width="25%" class=roomleft>&nbsp;退款</td>
      <td width="25%" class=roomright  >&nbsp;<input type=text name="tk1"  size=15 value="<%=tk1 %>" onKeyDown="key(document.cus.save)">
 </td>
 <td width="25%" class=roomleft>&nbsp;退款日期</td>
      <td width="25%" class=roomright  >&nbsp;<input type=text name="tkDate2" value="<%=tk_date1 %>" size=15  onKeyDown="key(document.cus.save)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(tkDate2);return false;">
 </td>
</tr>	
<%}else{ %>
<input type=hidden name="tk"  size=15 value="<%=tk %>">
<input type=hidden name="tkDate1" value="<%=tk_date %>" >
<input type=hidden name="tk1"  size=15 value="<%=tk1 %>">
<input type=hidden name="tkDate2" value="<%=tk_date1 %>">
<%} %>
 </table>
  <P align="center">
  <%if (zto.equals("0")){ %>
   <%if (Cortrol.indexOf("A")>=0){ %> 
  <input type=button name=save value="提 交" onclick="loca1()">
  <%} %>
  <%}else{ %>
  此客户已认购或签约，不能再修改临订订金
  <%} %>
  <input type=button name=cancel value="关 闭" onclick="window.close();">
  
  </p>
 
</center>
<script>

function loca1(){
 if (checkedDate()){
    document.cus.submit();
 }
 }
</script>
</form>

</BODY></HTML>
