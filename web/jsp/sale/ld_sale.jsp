<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>

<HTML>
<HEAD>
<TITLE>临订登记</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function checkedDate(){
if (document.cus.cusname1.value==""){
    alert("请选择客户或输入客户资料");
    return false;
  }
  if (document.cus.Date2.value==""){
    alert("请选择临订日期");
    return false;
  }
 if (document.cus.Date1.value==""){
    alert("请选择失效日期");
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
openwin2("FindCustomer.jsp?section="+document.cus.SecNo.value+"&FindCus="+document.cus.cusname1.value,400,380,300,100);  
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
 %>
<BODY onload="document.cus.cusname1.focus();">
<script language="javascript" src="../public_js/public.js"></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 <form name="cus" method="POST" action="ld_sale_save.jsp">
<input type="hidden" name="action" value=""> 
 <p align="center"><font size=3 class=FontColor><b>临定登记</b></font></p>
 <center>
 
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center bordercolor="#000000" class="tablefill">
  <input type=hidden name=code value="<%=code %>">
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
    <td width="25%" class=roomleft>&nbsp;房号</td>  
    <td width="25%" class=roomright  >&nbsp;<%=StrLoft+StrBuilding+StrRoom_code %></td>
  </tr>

  <tr>
    <td width="25%" class=roomleft>&nbsp;建筑面积：</td>
    <td width="25%" class=roomright  >&nbsp;<%=area%></td>
 
    <td width="25%" class=roomleft>&nbsp;套内面积：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=usearea%></td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;建筑单价：</td>
    <td width="25%" class=roomright  >&nbsp;<%=unitprice%></td>
 
    <td width="25%" class=roomleft>&nbsp;套内单价：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=TNunitprice  %></td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;总价：</td>
    <td width="25%" class=roomright  >&nbsp;<%=sumprice %></td>
 
    <td width="25%" class=roomleft>&nbsp;交楼日期：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=date %></td>
  </tr>
   
  <tr>
     <td width="25%" class=roomleft>&nbsp;临定日期：</td>
    <td width="25%" class=roomright  >&nbsp;<input type=text name=Date2  size=10 value="<%=curyear+"-"+curmonth+"-"+curday %>"><input type=button name=Popu value=".." onClick="fPopUpCalendarDlg(Date2);return false"></td>
  
   <td width="25%" class=roomleft>&nbsp;失效日期：</td>
    <td width="25%" class=roomright  >&nbsp;<input type=text name=Date1  size=10 value="1">天后</td>
 
  </tr>
   <tr>
    <td width="25%" class=roomleft>&nbsp;客户姓名：</td>
	<input type=hidden name=cusname>
    <td width="25%"  >&nbsp;<input type=text name=cusname1  size=15 onKeyDown="key(document.cus.cardid)"><input type=button name=FindB  value="查找" onclick="FindOption();"></td>
 
    <td width="25%" class=roomleft>&nbsp;身份证号：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name=carid size=15 onKeyDown="key(document.cus.tel)"></td>
  </tr>
  <tr>
   <td width="25%" class=roomleft>&nbsp;联系电话：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name=tel  size=15 onKeyDown="key(document.cus.sj)"></td>
 
    <td width="25%" class=roomleft>&nbsp;联系手机：</td>
	
    <td width="25%" class=roomright  >&nbsp;<input type=text name=sj  size=15 onKeyDown="key(document.cus.bbj)"></td>
 
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
     <td>&nbsp;<input type=text name="disc" onblur="check(document.cus.dj)"  size=15></td>
</td>
</tr>
 
<tr>
  <td width="25%" class=roomleft>&nbsp;临定定金：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name="dj" onblur="check(document.cus.dj)"  size=15 onKeyDown="key(document.cus.saleprice)"><font  color=red>*</font></td>

    <td width="25%" class=roomleft>&nbsp;临定认购价：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name="saleprice" value=0 onblur="check(document.cus.saleprice)"  size=15 onKeyDown="key(document.cus.curry)"><font  color=red>*</font></td>
</tr> 
 
 
<tr> 
 <td width="25%" class=roomleft>&nbsp;备注</td>
      <td width="25%" class=roomright  colspan="3" >&nbsp;<input type=text name="context"  size=45 onKeyDown="key(document.cus.save)">
 销售员：<select name="seller"   multiple size=1.5  onblur="SelectedSeller();"> 
 <option ></option>
 <option ></option>
 <option ></option>
  <option ></option>
 </select><input type=button name=listlar value="<<" onclick="list1();" title="增加销售员"><input type=button name=rem value=">>" onclick="remo();"  title="删除销售员">
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

function loca1(){
 if (checkedDate()){
    document.cus.save.disabled=true;
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
