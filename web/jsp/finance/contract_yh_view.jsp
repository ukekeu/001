<%@ page contentType="text/html;charset=GBK" %>

 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>优惠核对</title>
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
<%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>

<%!
public String toEmpty( String str ) {
    if( str == null ) {
        str = "" ;
    }
    return str ;
}
%>

<% 

 
   String tmp=request.getParameter("pageno");
 
   SecNo=request.getParameter("SecNo");
 
    FindWhere="  and section='"+SecNo+"'";
 
 
   String choose = China.getParameter(request,"choose");//1表示认购,2表示已签约	
   if (choose.equals(""))choose="1";

  String strRoomType = request.getParameter("fx");
   if (strRoomType==null){strRoomType="";}
   else if (tmp==null){strRoomType= new String(strRoomType.getBytes("ISO8859_1"),"GBK");
   }
   SecNo=getbyte1(request.getParameter(SecNo));
     String strSecName = getbyte2(request.getParameter("SecName"));
 
    String strLoft = getbyte1(request.getParameter("Loft"));
 
   String strBuild = getbyte1(request.getParameter("Build"));
 
  
  String SectionName=China.getParameter(request,"SectionName") ; 
  String Region = China.getParameter(request,"Region") ; 

%>
<script>
	 
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
 <%
 
   //get session value
    String seller=(String)session.getAttribute("username");
	int totalnum=0;
    String condtion="";		
    String eof="false";
	String sqlWhere="";
    String start="";
    String find="";
 
	
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
	
	 
	java.text.DecimalFormat df2 = new java.text.DecimalFormat("#######.##"); 
    java.text.DecimalFormat df1 = new java.text.DecimalFormat("###,###,###.##"); 
    String PubPra=(String)session.getAttribute("job");	
    String user=(String)session.getAttribute("loginid");	
   if (PubPra.indexOf("员")<0)PubPra="1";
    String doWhat = getbyte( request.getParameter( "doWhat" ) ) ;
    String fanghou = getbyte( request.getParameter( "fanghou" ) ) ;
    String kehuxingming = getbyte( request.getParameter( "kehuxingming" ) ) ;
    String time1 = getbyte( request.getParameter( "time1" ) ) ;
    String time2 = getbyte( request.getParameter( "time2" ) ) ;
    String xiaoshouren = getbyte( request.getParameter( "xiaoshouren" ) ) ;    
    String youhui = getbyte( request.getParameter( "youhui" ) ) ;
	String rgno= getbyte( request.getParameter( "rgno" ) ) ;
    String htno= getbyte( request.getParameter( "htno" ) ) ;
    String findStr = "" ;
	
	 
    String orderbytype=request.getParameter("orderbytype");
	String orderby=request.getParameter("orderby");
	String orderStr="";
	if(orderbytype==null)orderbytype="1";
	if(orderby==null)orderby="1";
    if(orderbytype.equals("1")){
	   orderStr = " order by loft,floors,room_no";
	}else {orderStr = " order by date ";}
	if(orderby.equals("0")){
	   orderStr = orderStr + " desc ";}

 String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	  	
 
 pageSize=200;
	sql="select Top "+pageSize+"  * from PrintReportContract where    section+loft+room_no  in  (select  order_no from contract_disc where  disc_type<>'正常折扣' and  order_no like '%"+getbyte1(request.getParameter("SecNo"))+strLoft+"%' group by order_no )   and Code not in (Select top "+prenum +" code from PrintReportContract where  section+loft+room_no  in  (select  order_no from contract_disc where  disc_type<>'正常折扣' and  order_no like '%"+getbyte1(request.getParameter("SecNo"))+strLoft+"%' group by order_no )   "+find+FindWhere +findStr +orderStr+")    "+find+FindWhere +findStr +orderStr;
		sqlcount="select count(*) as num from PrintReportContract where     section+loft+room_no  in  (select  order_no from contract_disc where  disc_type<>'正常折扣' and  order_no like '%"+getbyte1(request.getParameter("SecNo"))+strLoft+"%' group by order_no)   " +find+FindWhere + findStr ;
 
%>
<body topmargin="1" >
<form action="contract_yh_view.jsp" method="post" name="frm">
<input type=hidden name=SecNo value="<%=getbyte1(request.getParameter("SecNo")) %>">
<input type=hidden name=SecName value="<%=strSecName %>">
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
 <table width="470" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('RoomCodeShowC.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>收款审核</font></a>
	</td>
	  <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=2;findSub('factSkhd.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>批量核对</font></a>
	</td>
 	 <td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=3;findSub('contract_yh_view.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>优惠核对</font></a>
	</td> 
	  <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('RoomCodeShowTC.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>一次退房款</font></a>
	</td> 
	  <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=5;findSub('tf_list.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>多次退房款</font></a>
	</td> 
   </tr>
<input type=hidden name=sel value="<%=sel%>">
 </table>
<script>
function findSub(para){
	   document.frm.action=para+"?SecNo=<%=getbyte1(request.getParameter("SecNo")) %>&Loft=<%=strLoft %>";
	 
	   document.frm.submit();
	}
</script>
<p align=center class=FontColor><font size=4><b><%if (!strSecName.equals(strLoft)){out.print(strSecName);} %><%=strLoft %> </b></font></p>
<table width="100%">
 <tr >
   <td>
      <input type=button name=chcq value="优惠审批表" onclick="openwin('../sale/youhuicheckrep.jsp?SecNo=<%=request.getParameter("SecNo") %>',600,500,10,10)">
   
	 <input type=button name=chcq value="核对记录" onclick="checkyh();">
 
  </td>
 </tr>
</table>
 
<table BORDER=0 width="110%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
<td  align="right">序号<input type=checkbox name=sh onclick="chooseCheckbox(this.checked);" ></td>
<td  align="center">客户姓名</td>
<td  align="center">联系电话</td>
<td  align="center">房间代码</td>
 
<td align="center">面积</td>
<td  align="center">成交总价</td>
 
<td w align="center">付款方式</td>

<td  align="center">认购日期</td>
<td w align="center">额外优惠</td>
 
 <td  align="center">核对备注</td>
	<%
	ResultSet rs=null;
	try{
		
	rs=ViewBean.executeQuery(sql);

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
    String shouYouHui = "" ;
	String youhuidisc="";
	String youhuibak="";
	int i=0;
	boolean cq=true;
	//out.print("size" + rs.getFetchSize());
   while (rs.next()){
	 eof="true";
     i=i+1;
   //按FIELDS顺序一GET　VALUE
     
       startnum=rs.getInt("Code");
	 
	  
     SerialNo=rs.getString("SerialNo");
     Customer=getbyte(rs.getString("signatory"));
	  
     secno=getbyte(rs.getString("section"));
	 loft=getbyte(rs.getString("loft"));
     building=getbyte(rs.getString("building"));
	 
     Room_no=rs.getString("Room_no");

	 area=df2.format(rs.getFloat("area"));
	 area1=df2.format(rs.getFloat("jzarea"));
	 payment=getbyte(rs.getString("payment"));
	 if (payment.indexOf("揭")>0)payment=payment.substring(0,payment.indexOf("揭")+1);
	 buildtype=getbyte(rs.getString("buildtype"));
	 roomtype=getbyte(rs.getString("roomtype")); 
     ysumprice=df1.format(rs.getFloat("ysumprice"));
	 salerprice=df1.format(rs.getFloat("salerprice"));
	 seller=getbyte(rs.getString("Seller"));

     //Fomrat date 
	 date=rs.getString("date");
	 String rgdate=date.substring(0,date.indexOf(" "));
     java.text.SimpleDateFormat needdate =null;
     needdate=new java.text.SimpleDateFormat("yyyy-mm-dd");
	 date=needdate.format(needdate.parse(date));
	 cusno=rs.getString("cusno");
	 section=getbyte(rs.getString("Name"));  
	 subscription=rs.getString("subscription");
	 currency=getbyte(rs.getString("currency"));
	 disc=getbyte(rs.getString("disc"));	
	 Note=getbyte(rs.getString("Note")); 
	 phone=getbyte(rs.getString("Phone"));
     ContractNo=getbyte(rs.getString("ContractNo"));

     shouYouHui=getbyte(rs.getString("youhui"));
	 String Floor=getbyte(rs.getString("Floors"));
	 strSecName=getbyte(rs.getString("sectionname"));
	 youhuidisc=getbyte(rs.getString("ewdisc"));
	  youhuibak=getbyte(rs.getString("yh_checkbak"));
	 boolean checkstate=rs.getBoolean("yh_check1"); 
	 cq=rs.getBoolean("cq"); 
 
	 
  %>
 <tr id=TR<%=i %> align="center" class=listcontent onmouseover="mout(this) ;" Onclick="changeclass1(this,'clickbg','listcontent');"  > 
<td   align="center"><%=i %>

<%if (!checkstate){ %><input name="aa" value="<%=startnum %>" type="checkbox"><%} %>
</td>

<td   align="left">&nbsp;<a href="#" onclick="openwin('showContract1.jsp?secno=<%=secno %>&roomno=<%=Room_no %>&build=&loft=<%=loft %>&Floor=<%=Floor %>','')"><%out.print(Repalce(Customer,"/"));%></a>　</td>
<td  align="left">&nbsp;<%=Repalce(phone.trim(),"/").trim() %>&nbsp;</td>

<td   align="center">&nbsp;<%//if (!strSecName.equals(loft)){out.print(strSecName);} %><%=loft+building+Room_no %>　</td>
 
<td    align="right">&nbsp;<%=area1 %>　</td>
 
<td   align="right">&nbsp;<%out.print(currency); out.print(salerprice );%></td>

<td  align="left">&nbsp;<a href="#" onclick="openwin('ShowPayView1.jsp?cusno=<%=cusno %>',400,300,200,50)"><%=payment %></a></td>
<td  align="left"&nbsp;><%=date %>　</td>
<td  align="left"&nbsp;><%=shouYouHui%>　</td>

<td  align="left"&nbsp;><%=youhuibak %>　</td>

 

</tr> 
 <%
 }
rs.close();
  out.print("</table>");

}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
 
 %> </table>
   <%@ include file="../public_js/changepage1.jsp"%>
 
 <script language="javascript">
  function chooseCheckbox(para) {//indexstring
     var x=0;
	// var seldocs = new Array();
	var aa="";
	if (frm.elements.length){
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].name=="aa"))
		 {
       		frm.elements[i].checked=para;
			
   		 }
	  }	
	  }
 
}
	function checkyh(){
	 
	 
	 if (getseldocs2()==""){alert("请选择已优惠审批通过的合同");return false;}
	 
	 
	 
	   if (confirm("确认通过吗？"))
	   openwin("yh_checkdj.jsp?codes="+getseldocs2(),500,200,100,100);
	 
	 }
   	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].checked))
		 { 
		    seldocs[x]=frm.elements[i].value ;
			x++;
   		 }
	  }	

   return seldocs ;
}
   
</script> 
 
</body>
 
</html>
