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
<title>合同一览</title>
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
    FindWhere="  and sectionno='"+SecNo+"'";
}else{
    FindWhere="  and sectionno in("+SectionS+")";
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
	 
	     String PubPra=(String)session.getAttribute("job");	
	
    String user=(String)session.getAttribute("loginid");	
   if (PubPra.indexOf("员")<0)PubPra="1"; 
    String doWhat = getbyte1( request.getParameter( "doWhat" ) ) ;
    String cusname = getbyte1( request.getParameter( "cusname" ) ) ;
   
	String phone= getbyte1( request.getParameter( "phone" ) ) ;
    String htno= getbyte1( request.getParameter( "htn" ) ) ;
    String findStr = "" ;
	 
      if( doWhat.equals( "find" ) ) {
 
       if( ! htno.equals( "" ) ) {
            findStr = findStr + " and htn like '%" + htno + "%' " ;
       }
       if( ! phone.equals( "" ) ) {
            findStr = findStr + " and phone like '%" + phone + "%' " ;
       }
       if( ! cusname.equals( "" ) ) {
          findStr = findStr + " and cusname like '%" + cusname + "%' " ;
       }
        
    }
    String showht=getbyte1(request.getParameter("showht"));
	if (showht.equals(""))showht="1";
    String orderbytype=request.getParameter("orderbytype");
	String orderby=request.getParameter("orderby");
	String orderStr="";
	if(orderbytype==null)orderbytype="1";
	if(orderby==null)orderby="1";
 
    if(orderbytype.equals("1")){
	   orderStr = " order by loft,roomno";
	}else {orderStr = " order by qd_date ";}
	if(orderby.equals("0")){
	   orderStr = orderStr + " desc ";}
	String  a_day=getbyte1(request.getParameter("alertday"));
   String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT022");
 ResultSet rs=null;
 
 if (a_day.equals("")){
  rs=ViewBean.executeQuery("select alertday from alertDay");
  if (rs.next())
   a_day=rs.getString("alertday");
   rs.close();
   }else{
   
   ViewBean.executeUpdate("update alertDay set  alertday = "+a_day);
   }
		sql="select Top "+pageSize+"  *,datediff(d,enddate,getdate()) day  from View_Rent_List where Code not in (Select top "+prenum +" code from View_Rent_List where  datediff(d,dateadd(dd,"+a_day+",enddate),getdate())<=0 and  ht_state=0 "+find+stdate+FindWhere +findStr +orderStr+")  and   datediff(d,dateadd(dd,"+a_day+",enddate),getdate())<=0 and  ht_state=0 "+find+stdate+FindWhere +findStr +orderStr;
		sqlcount="select count(*) as num from View_Rent_List where datediff(d,dateadd(dd,"+a_day+",enddate),getdate())<=0 and ht_state=0   " +find+stdate+FindWhere + findStr ;
 %>
<body topmargin="1" onload="setSelectMad(document.frm.alertday,'<%=a_day %>');" >
<form action="alert_rent_list.jsp" method="post" name="frm">
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


<table width="480" border="0" cellspacing="0" cellpadding="0" class="L2">
     
<tr>
    <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('rent_list.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>有效合同</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('old_rent_list.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>历史合同</font></a>
	</td>
	
	  <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=5;findSub('alert_rent_list.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>到期合同</font></a>
	</td>
	 <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('ContractJz.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>业态分析</font></a>
	</td>
 
	<td class="<%if(sel.equals("6")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=6;findSub('rh_view.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>租控表</font></a>
	</td>
	
 
	
	
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('paymoneyProcess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>租金变更提供</font></a>
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
     合同号:<input type=input name=htn size=10  value="" >&nbsp;联系电话:<input type=input name=phone size=10  value="" >&nbsp;商户名称:<input type=input name=cusname size=15  value="" >
   
    <input type=button value="普通查询" onclick="document.forms[0].submit();"  >
	<select name=alertday onchange="document.frm.submit();"><option value=60>提前2个月</option><option value=30>提前1个月</option><option value=90>提前3个月</option></select>
	  </td>
 </tr>
</table>

 
 
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" >
<td  align="right">序号</td>
  <td  align="center">合同号</td>

<td  align="center"  >商户名称</td>
 
<td  align="center">租用单位</td>
<td align="center">建筑面积</td>
<td  align="center">联系人</td>
<td  align="center">联系电话</td>
 
<td w align="center">租金</td>
 
<td  align="center">管理费</td>
 <td  align="center">有效期限</td>
 
 

	<%
	
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
	      phone="";
	String Note="";
	String loft="";
	String floors="";
    String shouYouHui = "" ;
	String youhuidisc="";
	String youhuibak="";
	String visadate="";
	int day=0;
	try{
 
	rs=ViewBean.executeQuery(sql);
	 
	
	int i=0;
	   while (rs.next()){
	 i++;
	 day=rs.getInt("day");
	 
  %>
 <tr id=TR<%=i %> align="center" title="双击可以显示详细信息"   onmouseover="mout(this) ;" onclick="changeclass1(this,'clickbg','');"  ondblclick="openwin1('<%if (Cortrol.indexOf("C")>=0 ){  %>ContractInput.jsp<%}else{ %>showCustomerContract.jsp<%} %>?secno=<%=secno %>&roomno=<%=Room_no %>&build=<%=building %>&loft=<%=loft %>&Floor=<%=floors %>',750,560,100,5);"  > 
<td   align="center"><%=i %></td>
 <td  align="center" width="100"><%=rs.getString("htn")%></td>
<td   align="center">&nbsp;<%=rs.getString("cusname")%> 　</td>
 
<td   align="center">&nbsp;<%=rs.getString("loft")+rs.getString("roomno") %>　</td>
<td  align="center">&nbsp;<%=rs.getString("area")%>　</td>
<td    align="center">&nbsp;<%=rs.getString("linkman") %>　</td>
 
<td   align="center">&nbsp;<%=rs.getString("phone")%></td>
 
<td  align="center">&nbsp;<%=rs.getString("zj")%></td>
<td  align="center"><%=rs.getString("glf") %>　</td>
<td  align="center"  > <%if (day>=0){ %><font color=red><%} %><%=rs.getDate("startdate").toString() %>~<%=rs.getDate("enddate").toString() %><%if (day>=0){ %></font><%} %></td>


 

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
