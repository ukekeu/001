<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>

<HTML>
<HEAD>
<TITLE>看房记录</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<META HTTP-EQUIV="Expires" CONTENT="0">

<%
String sectionPara = request.getParameter("secno"); 
%>
 
<script>
 
function checkedDate(){
if (document.cus.cusname1.value==""){
    alert("请选择客户或输入客户资料");
    return false;
  }
  
 if (document.cus.Date1.value==""){
    alert("请选择看房日期");
    return false;
  } 
  if (document.cus.context.value==""){
    alert("填写客户看房记录");
    return false;
  } 
 if (document.forms[ 0 ].cusname1.value==""){
  if( has_name_phone() ) {
            alert( "该客户已存在!" )
            return false;
 }  
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
openwin2("../sale/FindCustomer.jsp?section=<%=getbyte2(request.getParameter("secno")) %>&FindCus="+document.cus.cusname1.value,400,380,300,100);  
 }
 

</script>

</HEAD>
<%
 
 


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
	      String yongtu="";
		java.text.SimpleDateFormat date1 =null;
        date1=new java.text.SimpleDateFormat("yyyy-MM-dd");
        String TodayDate=date1.format(new java.util.Date()).toString();
        int curyear=Integer.parseInt(TodayDate.substring(0,4));
        int curmonth=Integer.parseInt(TodayDate.substring(5,7));
        int curday=Integer.parseInt(TodayDate.substring(8,10));
		
        String code=request.getParameter("code") ;
		String sql="select R.*,S.Name from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.seccode='"+getbyte2(request.getParameter("secno"))+"' and R.loft='"+getbyte2(request.getParameter("loft"))+"' and R.room_code='"+getbyte2(request.getParameter("roomno"))+"' and R.floor="+request.getParameter("floor");
		 
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
		  yongtu=rs.getString("yong_tu");
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
 <p align="center"><font size=3 class=FontColor><b>客户看房反馈记录</b></font></p>
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
    <td width="25%" class=roomright  >&nbsp;<%=TNunitprice %></td>
 
    <td width="25%" class=roomleft>&nbsp;套内单价：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=unitprice %></td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;总价：</td>
    <td width="25%" class=roomright  >&nbsp;<%=sumprice %></td>
 
    <td width="25%" class=roomleft>&nbsp;交楼日期：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=date %></td>
  </tr>
     <tr>
    <td width="25%" class=roomleft>&nbsp;户型：</td>
    <td width="25%" class=roomright  >&nbsp;<%=fl %></td>
 
    <td width="25%" class=roomleft>&nbsp;用途：</td>  
    <td width="25%" class=roomright  >&nbsp;<%=yongtu %></td>
  </tr>
    
   <tr>
    <td width="25%" class=roomleft>&nbsp;客户姓名：</td>
	<input type=hidden name=cusname>
    <td width="25%"  >&nbsp;<input type=text name=cusname1  size=15 onchange="checkName();"></td>
 
    <td width="25%" class=roomleft>&nbsp;身份证号：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name=carid size=15 onKeyDown="key(document.cus.tel)"></td>
  </tr>
  <tr>
   <td width="25%" class=roomleft>&nbsp;联系电话：</td>  
    <td width="25%" class=roomright  >&nbsp;<input type=text name=tel  size=15 onchange="checkphone();"></td>
 
    <td width="25%" class=roomleft>&nbsp;联系手机：</td>
	
    <td width="25%" class=roomright  >&nbsp;<input type=text name=sj  size=15 onchange="checkSj();"></td>
 
     </tr>
   
 
<tr>
  
  <td width="25%" class=roomleft>&nbsp;看房日期：</td>
    <td width="25%" class=roomright  >&nbsp;<input type=text name=Date1  size=10 value="<%=curyear+"-"+curmonth+"-"+curday %>"><input type=button name=Popu value=".." onClick="fPopUpCalendarDlg(Date1);return false"></td>
  
 
    <td width="25%" class=roomleft>&nbsp;销售员：</td>
     <td>&nbsp;<select name="seller"   multiple size=1.5  onblur="SelectedSeller();"> 
 <option ></option>
 <option ></option>
 <option ></option>
  <option ></option>
 </select><input type=button name=listlar value="<<" onclick="list1();" title="增加销售员"><input type=button name=rem value=">>" onclick="remo();"  title="删除销售员">
</td>
</td>
</tr>
 
 
<tr> 
 <td width="25%" class=roomleft>&nbsp;看房记录</td>
      <td width="25%" class=roomright  colspan="3" >&nbsp;<textarea cols="60" rows="5" name="context"> </textarea>
 </td>
 
</tr>	 
 </table>
  <P align="center">
  <input type=button name=save value="提 交" onclick="loca1()">
  <input type=button name=cancel value="关 闭" onclick="window.close();">
  </p>
<p align="center"><b><font size="3" color="#000080"> 客户看房记录列表 </font></b></p>
 <table width="100%" cellspacing="1" cellpadding="2">
<tr  class=FloorC><td>客户名称</td><td>联系电话</td><td>单元</td><td>看房反馈</td><td>看房日期</td><td>是否出售</td></tr>

<%  
    String SecNo=request.getParameter("secno");
    String Date1 = request.getParameter("Date1");
    String Date2 = request.getParameter("Date2");
	 
	String SQL="";
    
	%>
	 
	<%
	SQL="SELECT b.cus_name,b.sj,b.phone,a.room_code,a.context,a.reco_date FROM KFRECO a,customer b  WHERE a.customer=b.serialno and a.SECNO='"+SecNo+"' order by room_code";// and room_code='"+name+StrLoft+StrBuilding+StrRoom_code+"'";
      rs=ViewBean.executeQuery(SQL); 
	 
	while (rs.next()){ 
      
	   ResultSet rs1=ViewBean1.executeQuery("select count(*) num from order_contract where sectionname+loft+room_no='"+name+StrLoft+StrBuilding+StrRoom_code+"'"); 
      int ddd=0;
	  if (rs1.next())ddd=rs1.getInt("num");
	  rs1.close();
 %>
  <tr  bgcolor="#EAEAEA"><td  ><%=rs.getString("cus_name") %> </td><td><%=rs.getString("sj") %> <%=rs.getString("phone") %></td><td height=16  >&nbsp;<%=rs.getString("room_code") %>&nbsp;&nbsp;</td> 
<td  ><%=rs.getString("context") %> </td><td  ><%=rs.getDate("reco_date") %> </td><td><%if (ddd>0){out.print("已售");}else{out.print("未售");} %></td>
	

</tr>   
<%} 
 %>     
					 
				</table>
</center>
<script>

function loca1(){
 if (checkedDate()){
    document.cus.submit();
 }
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
 
function list1(){
    openwin2("seleview.jsp?list=list&section=<%=StrSecNo%>",300,300,200,50);  
 }
</script>
</form>
 
</BODY></HTML>
