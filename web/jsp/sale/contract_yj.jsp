<%@ page contentType="text/html;charset=GBK" %>
 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>合同移交管理</title>
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
 
 

<% 

 
   String tmp=request.getParameter("pageno");
   SecNo=getbyte1(request.getParameter("SecNo"));
    FindWhere="  and section='"+SecNo+"'";
 
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
		setSelectMad(frm.SecNo,"<%= SecNo %>");
		setSelectMad(frm.Loft,"<%= strLoft %>");
		setSelectMad(frm.pay,"<%= pay %>");
		setSelectMad(frm.fx,"<%= strRoomType %>");
		setSelectMad(frm.build,"<%= strBuild %>");
		
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
 <%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/countpagenum.jsp"%>
 <% 
   String sql=""; 
       String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"S002");
 %>


<%@ include file="../public_js/Repalce.jsp"%>
  <%
   

 String checkedStr="";
 String checkedStr1="";
 String checkedStr2="";
 String jzstate="";
  
 String state=request.getParameter("state");
 if (state==null)state="0"; 

 if (state.equals("1")){state=" yj=1 and";checkedStr="checked";checkedStr1="";}
 else if (state.equals("0")){state= "yj=0 and";checkedStr1="checked";checkedStr="";}
 
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
	   
	java.text.DecimalFormat df2 = new java.text.DecimalFormat("#######.####"); 
    java.text.DecimalFormat df1 = new java.text.DecimalFormat("###,###,###.####"); 
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
	
	
    if( doWhat.equals( "find" ) ) {
    //   findStr = findStr + " and serialno like '%' " ;
       if( ! fanghou.equals( "" ) ) {
            findStr = findStr + " and room_no = '" + fanghou + "' " ;
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
     	sql="select Top "+pageSize+"  * from PrintReportContract where "+state+"  not jzdate is null and  not Visadate is null and  Code not in (Select top "+prenum +" code from PrintReportContract where not jzdate is null and    not Visadate is null and  state=2   "+find+stdate+FindWhere +findStr +orderStr+")  and   state= 2 "+find+stdate+FindWhere +findStr +orderStr;
		sqlcount="select count(*) as num from PrintReportContract where "+state+"  not jzdate is null and  not Visadate is null and  state= 2   " +find+stdate+FindWhere + findStr ;
	 
%>
<body topmargin="1" onload="setSelectMad(document.frm.orderby,'<%=orderby %>');setSelectMad(document.frm.orderbytype,'<%=orderbytype %>');" >
<form action="contract_yj.jsp" method="post" name="frm">
<input type=hidden name=SecNo value="<%=SecNo %>">
<input type=hidden name=SecName value="<%=strSecName %>">
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
<input type=hidden name=fx value="<%=strRoomType %>">
<input type=hidden name=RoomNo value="<%=strRoomNo %>">
<input type=hidden name=Date1 value="<%=stdate %>">
<input type=hidden name=Date2 value="<%=endate %>">
<input type=hidden name=choose value="<%=choose %>">
<input type=hidden name=param  value=<%=request.getParameter("param") %>>


<table width="740" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('jy_list.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>交易一览</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('ContractNoM.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同号管理</font></a>
	</td>
	 
	  <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=5;findSub('contract_check.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>审核合同</font></a>
	</td>
	 <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('ContractJz.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>备案管理</font></a>
	</td>
	 <td class="<%if(sel.equals("9")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=9;findSub('contract_yj.jsp');"><font color='<%if(sel.equals("9")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>移交管理</font></a>
	</td>
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
<p align=center class=FontColor><font size=4><b><%if (!strSecName.equals(strLoft)){out.print(strSecName);} %><%=strLoft %> </b></font></p>
<table  width="100%">
 <tr bgcolor="#EAEAEA">
   <td>
     <input type=hidden name="doWhat" value="find" >
	<%if(!strLoft.equals("")){ %>
    房号:<input type=text name=fanghou size=5 value="<%//= fanghou %>" >
	<%} else{%>
	<input type=hidden name=fanghou size=5 value="" >
	<%} %>
    客户姓名:<input type=text name=kehuxingming size=10 value="<%//= kehuxingming%>" >
    时间段: 从<input type=input name=time1 size=10 readonly value="<%//= time1%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">到<input type=input name=time2 size=10 readonly value="<%//= time2%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;"><br>
    销售员:<input type=text name=xiaoshouren size=10 value="<%//= xiaoshouren %>" >
<%if (choose.equals("1")){%>
    认购编号:<input type=text name=rgno size=10>
<%}else{ %>	
   合同编号:<input type=text name=htno size=10>
     <%}		%>

    <input type=button value="查询" onclick="document.forms[0].submit();" >
	 排序:<select name="orderbytype"  onchange="javascript:document.forms[0].submit();">
    
	 <option value=1>按房间代码</option>
     <option value=0>按认购日期</option>
	 </select>
	 <select name="orderby" onchange="javascript:document.forms[0].submit();">
     
	 <option value=1>升序</option>
     <option value=0>降序</option>
	 </select>
	 &nbsp;&nbsp;&nbsp;&nbsp;<input type=button name=chcq value="移 交" onclick="checkyj();">
  </td>
 </tr>
</table>

<script>
    setSelectMad(document.forms[0].orderbytype,'<%=orderbytype %>');
    setSelectMad(document.forms[0].orderby,'<%=orderby%>');

</script>
<%if (Cortrol.indexOf("A")>=0){%>
<input <%=checkedStr %> type=radio name=state value="1" onclick="document.frm.submit();">已移交
<input <%=checkedStr1 %> type=radio name=state value="0" onclick="document.frm.submit();">未移交
<%} %>
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
<td  align="right">序号<input type=checkbox name=sh onclick="chooseCheckbox(this.checked);" ></td>
<td  align="center">合同编号</td>
<td  align="center">客户姓名</td>
<td  align="center">联系电话</td>
<td  align="center">房间代码</td>
<td align="center">面积</td>
<td  align="center">成交总价</td>
<td w align="center">付款方式</td>
<td  align="center">签约日期</td>
<td w align="center">额外优惠</td>
<td  align="center">备  注</td>
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
	boolean yj=true;
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
	 date=rs.getDate("Visadate").toString();
	  
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
	  youhuibak=getbyte(rs.getString("note"));
	 boolean checkstate=rs.getBoolean("checkstate"); 
	 yj=rs.getBoolean("yj"); 
	 
  %>
 <tr id=TR<%=i %> align="center" class=listcontent onmouseover="mout(this) ;" Onclick="savepara('<%=SerialNo%>','<%=secno%>','<%=building%>','<%=Room_no%>','<%=cusno%>','<%=section %>','<%=Customer %>','<%=date%>','<%=payment%>','<%=ysumprice%>','<%=seller%>','<%=subscription %>');changeclass1(this,'clickbg','listcontent');"  > 
<td   align="center"><%=i %>

<%if (!yj){ %><input name="aa" value="<%=startnum %>" type="checkbox"><%} %>
</td>
 
<td  align="left">&nbsp;<% out.print(ContractNo.trim());%></td>
<td   align="left">&nbsp;<a href="#" onclick="openwin1('showContract.jsp?secno=<%=secno %>&roomno=<%=Room_no %>&build=&loft=<%=loft %>&Floor=<%=Floor %>','')"><%out.print(Repalce(Customer,"/"));%></a>　</td>
<td  align="left">&nbsp;<%=Repalce(phone.trim(),"/").trim() %>&nbsp;</td>

<td   align="center">&nbsp;<%=loft+building+Room_no %>　</td>
 
<td    align="right">&nbsp;<%=area1 %>　</td>
<!--<td align="center"><%//=area %>　</td>-->
<td   align="right">&nbsp;<%if (!PubPra.equals("1")){out.print(currency); out.print(salerprice );}%></td>
<!--<td  align="right">&nbsp;<%=disc %></td>-->
<td  align="left">&nbsp;<a href="#" onclick="openwin1('ShowPayView1.jsp?cusno=<%=cusno %>',400,300,200,50)"><%=payment %></a></td>
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
	
	 function checkyj(){
	 
	 
	 if (getseldocs2()==""){alert("请选择可以移交合同");return false;}
	 
	 
	 
	   if (confirm("确认移交吗？"))
	   openwin1("print_ContractYj.jsp?SecName=<%=strSecName %>&code="+getseldocs2(),10,10,10,10);
	 
	 }
   	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].name=="aa")&&(frm.elements[i].checked))
		 { 
		    seldocs[x]=frm.elements[i].value ;
			x++;
   		 }
	  }	

   return seldocs ;
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
</script> 
 
</body>
 
</html>
