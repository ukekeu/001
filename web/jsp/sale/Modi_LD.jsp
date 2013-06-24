<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>

<HTML>
<HEAD>
<TITLE>修改临订</TITLE>
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
	 	   break;
	  }
	}
 
 } 
function checkedDate(){
  
  if (document.cus.Date2.value==""){
    alert("请选择临订日期");
    return false;
  }
 
  if (document.cus.dj.value!="") {
    if (isNaN(document.cus.dj.value)){
	  alert("临订订金必须是数字");
	  return false;
   }
  }else{
   alert("请录入客户临订订金");
   return false;
  
  }
 
   return true;

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
		  String payment="";
		  String BillType="";
		  String disc="";
		java.text.SimpleDateFormat date1 =null;
        date1=new java.text.SimpleDateFormat("yyyy-MM-dd");
        String TodayDate=date1.format(new java.util.Date()).toString();
        int curyear=Integer.parseInt(TodayDate.substring(0,4));
        int curmonth=Integer.parseInt(TodayDate.substring(5,7));
        int curday=Integer.parseInt(TodayDate.substring(8,10));
		
        String code=request.getParameter("code") ;
		String sql="select R.*,S.Name from Room R inner join CRM_Project  S on S.SerialNo=R.seccode where R.code="+code;
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
		  date=getbyte(rs.getString("Serve_Date"));
		  java.text.SimpleDateFormat Fdate =null;
  		  Fdate=new java.text.SimpleDateFormat("yyyy-MM-dd");
		  if (!date.equals(""))
  		  date=Fdate.format(Fdate.parse(date));
		  fl=getbyte(rs.getString("roomtype"));
		  unitprice=df1.format(rs.getFloat("Unitprice"));
          sumprice=df2.format(rs.getFloat("Sumprice"));
		  picpath=rs.getString("Map");
		  TNunitprice=df1.format(rs.getFloat("TNunitprice"));
	  	  name=getbyte(rs.getString("Name"));
     }
	 rs.close();
	 sql="select SL_TemporarilyBuy.*,customer.signatory from  SL_TemporarilyBuy,customer where SL_TemporarilyBuy.state=0 and  customer.serialno=SL_TemporarilyBuy.cusname and  roomcode="+code;
	 rs=ViewBean.executeQuery(sql);
 
	String LDID="";	
	String cus_name_no="";
	if (rs.next()){
	    cus_name_no=rs.getString("cusname");
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
		CusName=getbyte(rs.getString("signatory"));
		payment=getbyte(rs.getString("payment"));
		disc=getbyte(rs.getString("disc"));
		
		
	} 
	 rs.close();
	 
 %>
<BODY onload="document.cus.cusname1.focus(); setSelectMad(document.cus.curry,'<%=ldcurr %>')">
<script language="javascript" src="../public_js/public.js"></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 <form name="cus" method="POST" action="Modi_LD_action.jsp?LDID=<%=LDID %>">
<input type="hidden" name="action" value=""> 
 <p align="center"><font size=3 class=FontColor><b>修改临定资料</b></font></p>
 <center>
 
<table BORDER=0 width="80%" CELLSPACING=1 CELLPADDING=1 ALIGN=center bordercolor="#000000" class="tablefill">
  <input type=hidden name=code value="<%=code %>">
  <input type=hidden name=codeold value="<%=code %>">
  <tr>
    <td width="25%" class=roomleft>&nbsp;楼盘名称：</td>  
    <td width="25%" class=roomright  >&nbsp<%=name %><input type=hidden name=SecNa  readonly size=10  value=<%=name %>></td>
	<input type=hidden name=SecNo value="<%=StrSecNo%>">
 <input type=hidden name=SecName  value="<%=name %>">
	<input type=hidden name=Build readonly size=10 value="<%=StrBuilding %>">
	<input type=hidden name=RoomNo readonly size=15 value="<%=StrRoom_code%>">
	<input type=hidden name=Loft readonly size=15 value="<%=StrLoft%>">
	<input type=hidden name=jzarea readonly size=15 value=<%=area%>>
	<input type=hidden name=tnarea readonly size=15 value=<%=usearea%>>
	<input type=hidden name=change  size=15 value="">
	<input type=hidden name=cus_name_no  size=15 value="<%=cus_name_no %>">
	
    <td width="25%" class=roomleft>&nbsp;房号</td>  
    <td width="25%" class=roomright  ><div id="idroomno"><%=StrLoft+StrBuilding+StrRoom_code %></div><a href="#" onclick="RList()",500,450,100,10);">换房</a></td>
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
    <td width="25%" class=roomright  ><div id="idsumprice"><%=sumprice %></div></td>
 
    <td width="25%" class=roomleft>&nbsp;交楼日期：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=date %></td>
  </tr>
   
  <tr>
     <td width="25%" class=roomleft>&nbsp;临定日期：</td>
    <td width="25%" class=roomright  >&nbsp;<input type=text name=Date2  size=10 value="<%=ldStartDate %>"><input type=button name=Popu value=".." onClick="fPopUpCalendarDlg(Date2);return false"></td>
  
   <td width="25%" class=roomleft>&nbsp;失效日期：</td>
    <td width="25%" class=roomright  >&nbsp;<input type=text name=Date1 value="<%=ldEndDate%>" size=10><input type=button name=Popu value=".." onClick="fPopUpCalendarDlg(Date1);return false"></td>
 
  </tr>
   <tr>
    <td width="25%" class=roomleft>&nbsp;客户姓名：</td>
	<input type=hidden name=cusname>
    <td width="25%"  >&nbsp;<input type=text name=cusname1  value="<%=CusName %>" size=15 onKeyDown="key(document.cus.cardid)"><font color=red>*</font></td>
 
    <td width="25%" class=roomleft>&nbsp;身份证号：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name=cardid value="<%=CusCardId %>" size=15 onKeyDown="key(document.cus.tel)"></td>
  </tr>
  <tr>
   <td width="25%" class=roomleft>&nbsp;联系电话：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name=tel  value="<%=CusTel %>" size=15 onKeyDown="key(document.cus.sj)"></td>
 
    <td width="25%" class=roomleft>&nbsp;联系手机：</td>
	<input type=hidden name=cusname>
    <td width="25%" class=roomright  >&nbsp;<input type=text name=sj  value="<%=CusSj %>" size=15 onKeyDown="key(document.cus.bbj)"></td>
 
     </tr>
   <tr>
    <td width="25%" class=roomleft>&nbsp;BB机：</td>  
    <td width="25%" class=roomright   >&nbsp;<input type=text name=bbj value="<%=Cusbbj %>"  size=15 onKeyDown="key(document.cus.listlar)"></td>

    <td width="25%" class=roomleft>&nbsp;销售员：</td>
     <td>&nbsp;<select name="seller"   multiple size=1.5  onblur="SelectedSeller();"> 
 <option value="<%=Seller %>" selected><%=Seller %></option>
 <option ></option>
 <option ></option>
  <option ></option>
 </select><input type=button name=listlar value="<<" onclick="list1();" title="增加销售员"><input type=button name=rem value=">>" onclick="remo();"  title="删除销售员">
</td>

  </tr> 

<tr> 
 <td width="25%" class=roomleft>&nbsp;付款方式</td>
     <td>&nbsp;<select name="pay"     onChange="charges(this.value);" style="width : 120" onKeyDown="key(document.cus.VisaDate)">
          <option></option>
            <%
         sql="select * from PayMent where TYPE=0 and seccoe='"+StrSecNo+"'";
      ResultSet rs3=ViewBean.executeQuery(sql);
	  String pay="";
	  String dic;
	  String dj1="";
	 
     while (rs3.next()){
	    pay=getbyte(rs3.getString("PayName"));
		 
	    dic=rs3.getString("Discont");
		dj1=rs3.getString("prepay");
		 
		String dic1=dic;
	    out.print("<option value='"+pay+"-"+dic1+"-"+dj1+"'>"+pay+"</option>");
	  }
	  
	    rs3.close();
     %>
        </select><font  color=red>*</font>
 </td>
 
 
    <td width="25%" class=roomleft>&nbsp;折扣：</td>
     <td>&nbsp;<input type=text name="disc" onblur="check(document.cus.dj)"  size=15 value="<%=disc %>"></td>
</td>
</tr>
<tr>
  <td width="25%" class=roomleft>&nbsp;临定定金：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name="dj"  value="<%=CusDJ %>" onblur="check(document.cus.dj)"  size=15 onKeyDown="key(document.cus.saleprice)"></td>

    <td width="25%" class=roomleft>&nbsp;临定售价：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name="saleprice" value="<%=SalePrice %>"  onblur="check(document.cus.saleprice)"  size=15 onKeyDown="key(document.cus.save)"></td>
</tr> 
<tr> 
 <td width="25%" class=roomleft>&nbsp;币&nbsp;&nbsp;&nbsp;&nbsp;种</td>
      <td width="25%" class=roomright  >&nbsp;<select name="curry" style="width : 70" OnChange="CurrRa();">
          <option value="￥">人民币</option>
          <option value="HKD">港元</option>
          <option value="USD">美元</option>
        </select><input type=text name="rate"  value="<%=ldrate %>"  size="4" title="汇率" >
 </td>
 <td width="25%" class=roomleft>&nbsp; </td>
 <td width="25%" class=roomright  >&nbsp; 
</td>
</tr>
 
<tr> 
 <td width="25%" class=roomleft>&nbsp;备注</td>
      <td width="25%" class=roomright  colspan="3" >&nbsp;<input type=text name="context"  size=52 onKeyDown="key(document.cus.save)">
 </td>
 
</tr>	 
 </table>
  <P align="center">
  <input type=button name=save value="提 交" onclick="loca1()">
  <input type=button name=cancel value="关 闭" onclick="window.close();">
  </p>
  <input type=hidden name=del value="删除" onclick="delSeller(RSID);">
</center>
<script>
 setSelectMad2(document.cus.pay,"<%=payment%>");
function loca1(){
 if (checkedDate()){
    document.cus.submit();
 }
 }
 
  function charges(para){
   var values=para;
    
   var sumprice="<%=sumprice %>";
     document.cus.dj.value=values.substring(values.lastIndexOf("-")+1);
	 document.cus.disc.value=values.substring(values.indexOf("-")+1,values.lastIndexOf("-"));
	  var discnum=countDisc(document.cus.disc.value);
	  
	 document.cus.saleprice.value=subs1(parseFloat(sumprice)*eval(document.cus.disc.value)/parseFloat(discnum),0);
 }
 function charges1(pa){
   var sumprice=pa;
      var discnum=countDisc(document.cus.disc.value);
	  
	 document.cus.saleprice.value=subs1(parseFloat(sumprice)*eval(document.cus.disc.value)/parseFloat(discnum),0);
 }
function CurrRa(){
 //汇率转换
   var curryName=document.cus.curry.options[document.cus.curry.selectedIndex].value;
   for (var jj=0;jj<RateName.length;jj++)
    {
	  if (RateName[jj]==curryName)
	  {
	   document.cus.rate.value=RateValue[jj];
	   break;
	  }
	}
 
 } 
 
   function countDisc(para){
       var dic_arr=para.split("*");
	   var disn=1;
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
	  	}
	 return disn
   
   }
   function list1(){
    openwin2("seleview.jsp?list=list&section=<%=StrSecNo%>",300,300,200,50);  
 }
</script>

</form>
 
</BODY></HTML>
