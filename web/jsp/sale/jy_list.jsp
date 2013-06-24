<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<link rel=stylesheet href="../class/line.css" >
<title>交易明细</title>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
   <%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>

 <%  
try{
    defaultNo=(String)session.getAttribute("defaultNo");
}catch(Exception s){
}
if ( defaultNo == null ) {
    defaultNo="";//如何用户未设置默认楼盘，则显示用户选中或所有楼盘的楼栋
}
if (!defaultNo.equals(""))
{
    SectionS=defaultNo;
    SecNo=defaultNo;
}
 SecNo=request.getParameter("SecNo");
if ( !SecNo.equals("") ) { 
    FindWhere="  and section='"+SecNo+"'";
}else{
    FindWhere="  and section in("+SectionS+")";
}
 
 
   String tmp=request.getParameter("pageno");
 
   String choose = China.getParameter(request,"choose");//1表示认购,2表示已签约	
   if (choose.equals(""))choose="1";
 
  String strRoomType = request.getParameter("fx");
   if (strRoomType==null){strRoomType="";}
   else if (tmp==null){strRoomType= new String(strRoomType.getBytes("ISO8859_1"),"GBK");
   }
     String strSecName = request.getParameter("SecName");
   if (strSecName==null){strSecName="";}
   strSecName= new String(strSecName.getBytes("ISO8859_1"),"GBK");
   
    String strLoft = request.getParameter("Loft");
   if (strLoft==null){strLoft="";}
   strLoft= new String(strLoft.getBytes("ISO8859_1"),"GBK");
   
   String strBuild = request.getParameter("Build");
   if (strBuild==null){strBuild="";}
   strBuild= new String(strBuild.getBytes("ISO8859_1"),"GBK");
   
   String strRoomNo = request.getParameter("RoomNo");
   if (strRoomNo==null){strRoomNo="";}
   else if (tmp==null){strRoomNo= new String(strRoomNo.getBytes("ISO8859_1"),"GBK");
   }
    String pay= request.getParameter("pay");
   if (pay==null){pay="";}
   else if (tmp==null){pay= new String(pay.getBytes("ISO8859_1"),"GBK");
   }
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SectionName") ; 
  String Region = China.getParameter(request,"Region") ; 
 
%>
<script>
	function loadForm() {
		 
		
		frm.RoomNo.value="<%= strRoomNo %>";
		document.frm.Date1.value = "<%= stdate %>" ;
		document.frm.Date2.value = "<%= endate %>" ;
	}
	function submitf(){
	 	var href= "frm.jsp?print=print&section=" + document.frm.section.value+"&pay="+document.frm.pay.value;
		window.location = href;
		}
</script>
 <script>
 	function changeSection() {
		document.frm.SectionName.value = document.frm.SecNo.options[document.frm.SecNo.selectedIndex].text;
	}
 </script>
<%@ include file="../public_js/countpagenum.jsp"%>
 <% 
   String sql=""; 
   
 %>


<%@ include file="../public_js/Repalce.jsp"%>
<%!
 	String user;
	String type;
	boolean rg;
  %> 
  <%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="4";	   %>
  <%
 
   //get session value
    String seller=(String)session.getAttribute("username");
	int totalnum=0;
    String condtion="";		
    String eof="false";
	String sqlWhere="";
    String start="";
    String find="";
    String colnum=getbyte1( request.getParameter( "colnum" ) ) ;
	 
	
	 if (!(strRoomType.equals("")))	{
	  if (!(find.equals(""))){
	   find=find+" and roomtype='"+strRoomType+"'";
	  }else{find=" and roomtype='"+strRoomType+"'";}
	} 
	if (!(strLoft.equals("")))	{
	  if (!(find.equals(""))){
	   find=find+" and Loft='"+strLoft+"'";
	  }else{find=" and Loft='"+strLoft+"'";}
	}   
	if (!(strBuild.equals("")))	{
	  if (!(find.equals(""))){
	   find=find+" and building='"+strBuild+"'";
	  }else{find=" and building='"+strBuild+"'";}
	} 
	
	if (!(strRoomNo.equals("")))	{
	  if (!(find.equals(""))){
	   find=find+" and room_no like '%"+strRoomNo+"%'";
	  }else{find=" and room_no like '%"+strRoomNo+"%'";}
	}   
	if (!(pay.equals("")))	{
	  if (!(find.equals(""))){
	   find=find+" and payment like '%"+pay+"%'";
	  }else{  find=" and payment like '%"+pay+"%'";}
	}
	if (!stdate.equals("")&&endate.equals(""))	
	    stdate=" and convert(char(24),date,111)='"+stdate+"'";
	
	if (stdate.equals("")&&!endate.equals(""))	
	    stdate=" and convert(char(24),date,111)='"+endate+"'";
	
	if (!stdate.equals("")&&!endate.equals(""))	
	    stdate=" and convert(char(24),date,111)>='"+stdate+"' and convert(char(24),date,111)<='"+endate+"'";
	   
	     String PubPra=(String)session.getAttribute("job");	
	
    String user=(String)session.getAttribute("loginid");	
   if (PubPra.indexOf("员")<0)PubPra="1"; 
    String doWhat = getbyte1( request.getParameter( "doWhat" ) ) ;
    String fanghou = getbyte1( request.getParameter( "fanghou" ) ) ;
    String kehuxingming = getbyte1( request.getParameter( "kehuxingming" ) ) ;
    String time1 = getbyte1( request.getParameter( "time1" ) ) ;
    String time2 = getbyte1( request.getParameter( "time2" ) ) ;
    String xiaoshouren = getbyte1( request.getParameter( "xiaoshouren" ) ) ;    
    String youhui = getbyte1( request.getParameter( "youhui" ) ) ;
	String rgno= getbyte1( request.getParameter( "rgno" ) ) ;
    String htno= getbyte1( request.getParameter( "htno" ) ) ;
    String findStr = "" ;
	String roomchoose= getbyte1( request.getParameter( "roomchoose" ) ) ;
 
	 if (!roomchoose.equals(""))
	    findStr = findStr + " and loft+room_no in (" + roomchoose + ")" ;
    if( doWhat.equals( "find" ) ) {
 
       if( ! fanghou.equals( "" ) ) {
            findStr = findStr + " and room_no like '%" + fanghou + "%' " ;
       }
       if( ! kehuxingming.equals( "" ) ) {
            findStr = findStr + " and signatory like '%" + kehuxingming + "%' " ;
       }
       if( ! time1.equals( "" ) ) {
            findStr = findStr + " and date >= '" + time1 + " 00:00:00" + "' " ;
       }
       if( ! time2.equals( "" ) ) {
            findStr = findStr + " and date <= '" + time2 + " 23:59:59" + "' " ;
       }
       if( ! xiaoshouren.equals( "" ) ) {
            findStr = findStr + " and seller like '%" + xiaoshouren + "%' " ;
       }
       if( ! youhui.equals( "" ) ) {
            findStr = findStr + " and youhui like '%" + youhui + "%' " ;
       }
	   if( !rgno.equals( "" ) ) {
            findStr = findStr + " and serialno ='" + rgno + "'" ;
       }
	    if( !htno.equals( "" ) ) {
            findStr = findStr + " and ContractNo ='" + htno + "'" ;
       }
    }
    String showht=getbyte1(request.getParameter("showht"));
	if (showht.equals(""))showht="1";
    String orderbytype=request.getParameter("orderbytype");
	String orderby=request.getParameter("orderby");
	String orderStr="";
	if(orderbytype==null)orderbytype="1";
	if(orderby==null)orderby="1";
	if (!colnum.equals("")&&showht.equals("1")){
	 
	 for(int nn=1;nn<=Integer.parseInt(colnum);nn++)
      {
	     String qyrq=getbyte1(request.getParameter("qyd"+nn));
		 String qyht=getbyte1(request.getParameter("hth"+nn));
	     String htcode=getbyte1(request.getParameter("htcode"+nn));
	      if (!htcode.equals("")&&!qyrq.equals("")) 
		  {ViewBean.executeUpdate("update order_contract set state=2, visadate='"+qyrq+"',ContractNo='"+qyht+"' where code="+htcode);
		  ViewBean.executeUpdate("update room  set salestate=3 where seccode+loft+room_code in (select section+loft+room_no from order_contract where code="+htcode+")");
		   }
	  
	  }	
	
	}
    if(orderbytype.equals("1")){
	   orderStr = " order by loft,floors,room_no";
	}else {orderStr = " order by date ";}
	if(orderby.equals("0")){
	   orderStr = orderStr + " desc ";}
	   orderStr=" and state="+showht+orderStr;
   String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT022");
 
		sql="select Top "+pageSize+"  * from PrintReportContract where Code not in (Select top "+prenum +" code from PrintReportContract where  state<>3 "+find+stdate+FindWhere +findStr +orderStr+")  and   state<>3 "+find+stdate+FindWhere +findStr +orderStr;
		sqlcount="select count(*) as num from PrintReportContract where state<>3   " +find+stdate+FindWhere + findStr ;
 
%>
<body topmargin="1"  onload="setSelectMad(document.frm.orderby,'<%=orderby %>');setSelectMad(document.frm.orderbytype,'<%=orderbytype %>');" >
<form action="jy_list.jsp" method="post" name="frm">
<input type=hidden name=SecNo value="<%=request.getParameter("SecNo") %>">
<input type=hidden name=SecName value="<%=strSecName %>">
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
<input type=hidden name=fx value="<%=strRoomType %>">
<input type=hidden name=RoomNo value="<%=strRoomNo %>">
<input type=hidden name=Date1 value="<%=stdate %>">
<input type=hidden name=Date2 value="<%=endate %>">
<input type=hidden name=choose value="<%=choose %>">
<input type=hidden name=param  value=<%=request.getParameter("param") %>>


<table width="650" border="0" cellspacing="0" cellpadding="0" class="L2">
     
<tr>
    <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('jy_list.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>交易一览</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('ContractNoM.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同号管理</font></a>
	</td>
	
	  <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=5;findSub('contract_check.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同审核</font></a>
	</td>
	 <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('ContractJz.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>备案管理</font></a>
	</td>
	<!-- <td class="<%if(sel.equals("9")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=9;findSub('contract_yj.jsp');"><font color='<%if(sel.equals("9")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>移交管理</font></a>
	</td>
	-->
	<td class="<%if(sel.equals("6")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=6;findSub('rh_view.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>入户管理</font></a>
	</td>
	
  <!--
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('contract_view.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已审核合同</font></a>
	</td>
	-->
	
	
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('paymoneyProcess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>付款进度</font></a>
	</td>
	 
	 
	<td class="<%if(sel.equals("8")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=8;findSub('contract_wycl.jsp');"><font color='<%if(sel.equals("8")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>违约处理</font></a>
	</td>
   </tr>
<input type=hidden name=sel value="<%=sel%>">

 </table>

 
<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
 
<table   width="100%">
 <tr  >
   <td>
     <input type=hidden name="doWhat" value="find"  >
	 <input type=hidden name="roomchoose"  >
     认购日期: 从<input type=input name=time1 size=10 readonly value="<%//= time1%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">到<input type=input name=time2 size=10 readonly value="<%//= time2%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;">
   
    <input type=button value="普通查询" onclick="document.forms[0].submit();"  >
	 排序:<select name="orderbytype"  onchange="javascript:document.forms[0].submit();">
    
	 <option value=1>按房间代码</option>
     <option value=0>按认购日期</option>
	 </select>
	 <select name="orderby" onchange="javascript:document.forms[0].submit();">
     
	 <option value=1>升序</option>
     <option value=0>降序</option>
	 </select>
	 &nbsp; <select name="showht" onchange="javascript:document.forms[0].submit();">
     
	 <option value=1 <%if (showht.equals("1"))out.print("selected"); %>>只显示未签约的</option>
     <option value=2 <%if (showht.equals("2"))out.print("selected"); %>>只显示已签约的</option>
	 </select>  &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; <input type=button value="高级查询" onclick="openwin('RoomCodeChoose.jsp?section_select=<%=request.getParameter("SecNo") %>&showLoft=<%=strLoft %>',500,500,10,10);"  >&nbsp;<%if (showht.equals("1")){%><input type=button value="批量更新" onclick="if (confirm('确认你录入签约日期及合同号是否正确，更新后只有审核权限用户才能修改'))document.forms[0].submit();"><%} %>
  </td>
 </tr>
</table>

<script>
    setSelectMad(document.forms[0].orderbytype,'<%=orderbytype %>');
    setSelectMad(document.forms[0].orderby,'<%=orderby%>');

</script>
 
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" >
<td  align="right">序号</td>
 

<td  align="center"  >客户姓名</td>
 
<td  align="center">房间代码</td>
<td  align="center">户型</td>
<td align="center">建筑面积</td>
<td  align="center">成交总价</td>
 
<td w align="center">付款方式</td>
 
<td  align="center">认购日期</td>
 <td  align="center">签约日期</td>
 <td  align="center">合同号</td>
	<%
	ResultSet rs=null;
	//保存输入值的变量
    String SerialNo="";
	String ContractNo="";
    String section="";
    String building="";
    String Room_no="";
    String area="";
    String area1="";
    String Customer="";
    String payment="";
    String buildtype="";
    String roomtype="";
	String salerprice;
    String ysumprice="";
	String date="";
	String cusno="";
	String secno="";
	String currency="";
	String sale=request.getParameter("sale");
	String subscription="";
	String disc="";
	String phone="";
	String Note="";
	String loft="";
	String floors="";
    String shouYouHui = "" ;
	String youhuidisc="";
	String youhuibak="";
	String visadate="";
	try{
 
	rs=ViewBean.executeQuery(sql);
	 
	
	int i=0;
	//out.print("size" + rs.getFetchSize());
   while (rs.next()){
	 eof="true";
     i=i+1;
   
       startnum=rs.getInt("Code");
	 
     SerialNo=getbyte(rs.getString("SerialNo"));
     Customer=getbyte(rs.getString("signatory"));
	  
     secno=getbyte(rs.getString("section"));
	 loft=getbyte(rs.getString("loft"));
     building=getbyte(rs.getString("building"));
	 
     Room_no=rs.getString("Room_no");

	 area=FormtD.getFloat(rs.getFloat("area"),2);
	 area1=FormtD.getFloat(rs.getFloat("jzarea"),2);
	 payment=getbyte(rs.getString("payment"));
	 if (payment.indexOf("揭")>0)payment=payment.substring(0,payment.indexOf("揭")+1);
	 buildtype=getbyte(rs.getString("buildtype"));
	 roomtype=getbyte(rs.getString("roomtype")); 
     ysumprice=FormtD.getFloat(rs.getFloat("ysumprice"),2);
	 salerprice=FormtD.getFloat(rs.getFloat("salerprice"),2);
	 seller=getbyte(rs.getString("Seller"));
 
	  visadate=getbyte(rs.getString("visadate"));
	  if (!visadate.equals(""))visadate=visadate.substring(0,10);
 
	  date=getbyte(rs.getDate("date").toString());
	 
	 String rgdate=date;
	 
	 cusno=rs.getString("cusno");
	 section=getbyte(rs.getString("Name"));  
	 subscription=rs.getString("subscription");
	 currency=getbyte(rs.getString("currency"));
	 disc=getbyte(rs.getString("disc"));	
	 Note=getbyte(rs.getString("Note")); 
	 phone=getbyte(rs.getString("Phone"));
     ContractNo=getbyte(rs.getString("ContractNo"));

     shouYouHui=getbyte(rs.getString("youhui"));
	 floors=getbyte(rs.getString("floors"));
	 strSecName=getbyte(rs.getString("sectionname"));
	 youhuidisc=getbyte(rs.getString("ewdisc"));
	  youhuibak=getbyte(rs.getString("youhuibeizhu"));
	 
  %>
 <tr id=TR<%=i %> align="center" title="双击可以显示详细信息"   onmouseover="mout(this) ;" onclick="changeclass1(this,'clickbg','');"  ondblclick="openwin1('<%if (Cortrol.indexOf("C")>=0 ){  %>ContractInput.jsp<%}else{ %>showCustomerContract.jsp<%} %>?secno=<%=secno %>&roomno=<%=Room_no %>&build=<%=building %>&loft=<%=loft %>&Floor=<%=floors %>',750,560,100,5);"  > 
<td   align="center"><%=i %></td>
 
<td   align="left" title="<%=phone %>">&nbsp;<%out.print(Repalce(Customer,"/"));%> 　</td>
 
<td   align="center">&nbsp;<%=loft+building+Room_no %>　</td>
<td  align="left">&nbsp;<%=roomtype%>　</td>
<td    align="right">&nbsp;<%=area1 %>　</td>
 
<td   align="right">&nbsp;<% out.print(salerprice );%></td>
 
<td  align="left">&nbsp;<%if (payment.length()>6)payment=payment.substring(0,6)+"..."; out.print(payment);%></td>
<td  align="left"><%=date %>　</td>
<td  align="left" width="100"><%if (visadate.equals("")){ %><input type=text name=qyd<%=i %>  tab=<%=i %> class=unnamed1  size=10 value="<%=visadate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(qyd<%=i %>);return false;"><%}else{ %><%=visadate %><%} %></td>
 <input type=hidden name=htcode<%=i %>  value="<%=startnum %>">

<td  align="left" width="100"><%if (showht.equals("1")){ %><input type=text name=hth<%=i %>  tab=<%=i %> class=unnamed1   onBlur="checkedOrderNoExist1(this);checkedOrderNoExist2(this,<%=i %>);" size=13 value="<%=ContractNo %>"><%}else{ %><%=ContractNo %><%} %> 　</td>

 

</tr> 
 <%
 }
rs.close();
  out.print("</table> <input type=hidden name=colnum value='"+i+"'>");

}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
 
 %> </table>

   <%@ include file="../public_js/changepage2.jsp"%>
  </div>
   <%
 
 

ResultSet RateRs=null;
  String RateSql="select SerialNo,contractno from order_contract where  state<>3 and  loft+room_no <>'"+loft+Room_no+"' and section='"+SecNo+"'";
try{
 
  RateRs=ViewBean.executeQuery(RateSql);

  out.print("<script>");
 
  out.print("var OrderNo1=new Array();");
  int iii=0;
   while (RateRs.next()){
       out.print("OrderNo1["+String.valueOf(iii)+"]="+"\""+getbyte(RateRs.getString("ContractNo"))+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
RateRs.close();
out.print("</script>");
 
  %>
    <%ViewBean.closeConn(); 
  
        %>
 <script language="javascript">
  
   function Delconfirm(rgsno,section,build,room,cusno){
      if  (confirm("是否确认删除当前资料？")){
         window.location="delete.jsp?rgsno="+rgsno+"&section="+section+"&build="+build+"&room="+room+"&cusno="+cusno;
    	}
    }	
	var rgsno="";
	var secno="";
	var build="";
	var room="";
	var cusno="";
	var pay="";
	var roomtype="";
	var buildtype="";
	var secname="";
	var cusname="";
	var datestr="";
	var ysumprice="";
	var seller="";
	var subscription="";
	function EditInfo(){
	 if (confirm("真的要修改当前的认购书吗？")){
	  if (rgsno==""){alert("请选择你认购书");}
		else{
         window.location="rgedit.jsp?rgsno="+rgsno+"&secno="+secno+"&build="+build+"&room="+room+"&cusno="+cusno;
    	}
	 }	
	}	
	function HF(){
	if (confirm("真的要对当前的认购书进行换房吗？")){
   	  if (rgsno==""){alert("请选择你认购书");}
		else{
	    window.location="ChangeRoomConfirm.jsp?orderno="+rgsno+"&secno="+secno+"&build="+build+"&room="+room+"&cusno="+cusno+"&name="+secname+"&cusname="+cusname+"&paracon=sale"+"&date="+datestr;
	  }
	 } 
	}
	function QY(){
	    if (rgsno==""){alert("请选择你认购书");}
		else{
	 	 window.location="Insale.jsp?rgno="+rgsno+"&secno="+secno+"&build="+build+"&room="+room+"&cusno="+cusno+"&secname="+secname+"&cusname="+cusname+"&pay="+pay+"&ysumprice="+ysumprice;
        }
	}
	function TD(){
	if (confirm("真的要挞订当前的认购书吗？")){
	  if (rgsno==""){alert("请选择你认购书");}
		else{
	 	window.location="CancelDetail.jsp?CancelPara="+rgsno+"*"+cusno+"*"+secname+"*"+build+"*"+room+"*"+datestr+"*"+seller+"*"+secno+"*"+subscription;
		}
   }
	}
	function OutPrint(){
	 	openwin("OutPrintPage.jsp?choose=<%=choose %>&SecNo=<%=SecNo%>&Loft=<%=strLoft %>&Build=<%=strBuild %>",350,258,150,150);
	}
	function DelInfo(){
	if (confirm("真的要删除当前的选中资料吗？")){
   	  if (rgsno==""){alert("请选择");}
		else{
	    openwin("deleteordercontract.jsp?orderno="+rgsno,10,10,10,10);
	  }
	 } 
	}
	function GoPage(pageNo) {
		document.forms[0].pageno.value = pageNo ;
		document.forms[0].submit() ;
	}
	function savepara(ro,so,bu,rom,co,sname,cname,dstr,pa,ys,sel,subs){

	  rgsno=ro;
	  secno=so;
	  build=bu;
	  room=rom;
	  cusno=co;
	  secname=sname;
	  cusname=cname;
	  datestr=dstr;
	  pay=pa;
	  ysumprice=ys;
	  seller=sel;
	  subscription=subs
	}
   	
    function doSearch()
    {
        var doWhat = document.forms[ 0 ].doWhat.value ;
        var fanghou = document.forms[ 0 ].fanghou.value ;
        var kehuxingming = document.forms[ 0 ].kehuxingming.value ;
        var time1 = document.forms[ 0 ].time1.value ;
        var time2 = document.forms[ 0 ].time2.value ;
        var xiaoshouren = document.forms[ 0 ].xiaoshouren.value ;

        var url2 = "?doWhat=" + doWhat
        url2 = url2 + "&fanghou=" + fanghou
        url2 = url2 + "&kehuxingming=" + kehuxingming
        url2 = url2 + "&time1=" + time1
        url2 = url2 + "&time2=" + time2
        url2 = url2 + "&xiaoshouren=" + xiaoshouren
        
        var url = document.location.href
        if( url.indexOf( "?doWhat=" ) != -1 ) {
            url = url.substring( 0 , url.indexOf( "?doWhat=" ) )
        }
        //document.location.href = url + url2
        document.forms[ 0 ].action = "rgsview.jsp"
        document.forms[ 0 ].submit() ;
    }
	
	
 function checkedOrderNoExist1(para){
    if (para.value=="")return false;
	var exist=0;
    for (var i=0;i<OrderNo1.length;i++){
	    if (para.value==OrderNo1[i]&&OrderNo1[i]!=""){
	      alert("此合同编号已经使用");
		  para.focus();
		  return false;
		}
	}
 }
 
  function checkedOrderNoExist2(para,para1){
    if (para.value=="")return false;
	var exist=0;
    for (var i=1;i<=document.frm.colnum.value;i++){
	    if (para.value==eval("document.frm.hth"+i).value&&eval("document.frm.hth"+i).value!=""&&i!=para1){
	      alert("此合同编号已经使用");
		 
		  para.focus();
		  return false;
		}
	}
 }
</script> 

</body>
 
</html>
