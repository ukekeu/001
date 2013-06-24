<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title></title>
</head>
<%@ page language="java" import="java.sql.*,java.lang.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%@ include file="../public_js/getByteOut.jsp"%>

 
<script language="javascript" src="../public_js/public.js">
</script>

<%
String Search=China.getParameter(request,"Search");
String StrFind=China.getParameter(request,"Find1");
String tmp=request.getParameter("pageno");
String  ldfind=China.getParameter(request,"ldfind");

int i=0;
String SecNo="";
String Loft="";
String Build="";
String RoomNo="";
String Floor="";
String state="";
String MessTitle="";
String SearchWhere="";
String no="";
String na="";	
String SecName="";
String secpara="";
String JZAREA="";
String RoomType="";
String unitprice="";
String CX="";
try{

//  if (!StrFind.equals("")){
	
   SecNo=China.getParameter(request,"SecNo");
   SecName=request.getParameter("SecName");

   if (Search.equals(""))  SecName=new String(SecName.getBytes("ISO8859_1"),"GBK");

   if (!SecNo.equals("")){
     	secpara=SecNo;
		SearchWhere=" and seccode ='"+SecNo+"'";
	}  

   Loft=request.getParameter("Loft");	
   if (Loft==null)Loft="";	
   if (Search.equals(""))  Loft=new String(Loft.getBytes("ISO8859_1"),"GBK");

   if (!Loft.equals("")){
        if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and Loft ='"+Loft+"'";
		 }  
		else {
		   SearchWhere=" and Loft ='"+Loft+"'";
		   }
		 }   
	
   Build=request.getParameter("Build");
   if (Build==null)Build="";
   if (Search.equals(""))  Build=new String(Build.getBytes("ISO8859_1"),"GBK");

   if (!Build.equals("")){
       if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and Building ='"+Build+"'";
		 }  
		else {
		   SearchWhere=" and Building ='"+Build+"'";
		   }
		 }  
		  

}catch(Exception s){out.print(s.getMessage());out.close();}
%>

 <body topmargin="1" >
 
<form method="POST" name="frm"  action="../basic/crm_ld_list.jsp">

<input type=hidden name=Find1>

<input type=hidden name=choose>
<input type=hidden name=SecName>
<input type=hidden name="SecNo" value="<%= SecNo%>" >
<input type=hidden name="Build" value="<%= Build%>" >
<input type=hidden name="Loft" value="<%= Loft%>" >
<input type=hidden name="Floor">
<input type=hidden name="RoomCode">
<input type=hidden name="unitprice">
<input type=hidden name="CX">
<input type=hidden name="JZAREA">
<input type=hidden name="RoomType">

	 <%
 String CountSql="select count(*) num ,sum(area)  area,sum(Subscription) Subscription  from Room R , Section S,SL_TemporarilyBuy L where L.roomcode=R.code and S.SerialNo=R.seccode and S.SerialNo in('"+SecNo+"') and  R.SaleState='5' "+SearchWhere+" group by R.seccode ";

  ResultSet CountRs=null;
  String num="0";
  String SumArea="0";
  String Money="0";
  try{
   CountRs=ViewBean.executeQuery(CountSql);
 
   while (CountRs.next()){
     num=CountRs.getString("num");
	 SumArea=FormatD.getFloat(CountRs.getFloat("area"),3);
	 Money=FormatD.getFloat(CountRs.getFloat("Subscription"),2);
   }
   CountRs.close();
  }catch(Exception s) {}

    String doWhat = getbyte1( request.getParameter( "doWhat" ) ) ;
    String fanghou = getbyte1( request.getParameter( "fanghou" ) ) ;
    String kehuxingming = getbyte1( request.getParameter( "kehuxingming" ) ) ;
    String time1 = getbyte1( request.getParameter( "time1" ) ) ;
    String time2 = getbyte1( request.getParameter( "time2" ) ) ;
    String xiaoshouren = getbyte1( request.getParameter( "xiaoshouren" ) ) ;
    String findStr = "" ;
	out.print(xiaoshouren);
    if( doWhat.equals( "find" ) ) {
       if( ! fanghou.equals( "" ) ) {
            findStr = findStr + " and room_code = '" + fanghou + "' " ;
       }
       if( ! kehuxingming.equals( "" ) ) {
            findStr = findStr + " and cus_name like '%" + kehuxingming + "%' " ;
       }
       if( ! time1.equals( "" ) ) {
            findStr = findStr + " and enddate >= '" + time1 + " 00:00:00" + "' " ;
       }
       if( ! time2.equals( "" ) ) {
            findStr = findStr + " and enddate <= '" + time2 + " 23:59:59" + "' " ;
       }
       if( ! xiaoshouren.equals( "" ) ) {
            findStr = findStr + " and receiver like '%" + xiaoshouren + "%' " ;
       }
    }

if (ldfind.equals("")){
fanghou ="";
kehuxingming="";
time1="";
time2 ="";
xiaoshouren ="";
}
  %>

<%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	   %>
<table width="610" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("2")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/crm_rg_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>认购明细</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('../sale/crm_rg_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>签约明细</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_ld_list.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>临订明细</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_yl_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>预留明细</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/CancelList.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>退房明细</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/ChangeList.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>换房明细</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect1");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_ws_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未售明细</font></a>
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
<%@ include file="../public_js/countpagenum.jsp"%>
<p align=center class=FontColor><font size=3><b> <%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft + Build %>临订房间明细表</b></font></p>

<table  width="100%">
 <tr >
   <td>
    <input type=hidden name="doWhat" value="find" >
    房号:<input type=text name=fanghou size=5 value="<%= fanghou %>" >
    客户姓名:<input type=text name=kehuxingming size=10 value="<%= kehuxingming%>" >
    时间段: 从<input type=input name=time1 size=10 readonly value="<%= time1%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">到<input type=input name=time2 size=10 readonly value="<%= time2%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;"><br>
    销售员:<input type=text name=xiaoshouren size=10 value="<%= xiaoshouren %>" >
    <input type=button value="查询" name="ldfind" onclick="doSearch()" >
  </td>
 </tr>
</table>

   <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center >
  <tr class=listtitle>
<td   align="center"   ><font color=white>客户</font></td>
	  <td   align="center"   ><font color=white>电话</font></td>
	  <td   align="center"   ><font color=white>订金</font></td>
      <td   align="center"   ><font color=white>房间代码</font></td>
      <td   align="center"   ><font color=white>面积</font></td>
      <td   align="center"   ><font color=white>单价</font></td>
      <td   align="center"   ><font color=white>户型</font></td>
   
      <td   align="center"   ><font color=white>总售价</font></td>
      <td   align="center"   ><font color=white>朝向</font></td>
      
	  <td   align="center"   ><font color=white>失效期</font></td>
	  <td   align="center"   ><font color=white>经手人</font></td>
   	    </tr>
  
<%

  String secno="";
  String sql="";
  String eof="false";
  sql = "select Top "+pageSize+" *  from View_LdList where seccode in('"+SecNo+"')"+SearchWhere 
      + findStr +  " order by  Room_code";
  sqlcount="select count(*) num from View_LdList 	where  seccode in('"+SecNo+"')"+SearchWhere ;
    
 
  int Code=0;  
  int salestate=0;
  String build="";
  String roomno="";
  String area="";
  String Stype="";
  String jg="";
  String fitment="";
  String countprice="";
  String JzUnitprice="";
  String TnUnitprice="";
  String loft="";
  String cx="";
  String color="";
  String area1="";
  String cusno="";
  String Cusname="";
  String Subscription="";
  String TEL="";
  String EndDate="";
  String Receiver="";

  ResultSet rs=null;
  try{
    
  rs=ViewBean.executeQuery(sql);

   i=0;
 while (rs.next()){

	 eof="true";
     i=i+1; 
	 Code=rs.getInt("code");
	 
	
    java.text.DecimalFormat df = new java.text.DecimalFormat(" #########.####"); 
	secno=rs.getString("seccode");
	loft=getbyte(rs.getString("Loft"));
	build=getbyte(rs.getString("building"));
	roomno=rs.getString("Room_code");
    area=df.format(rs.getFloat("Area"));
  
	
	cx=getbyte(rs.getString("Direction"));
	jg=getbyte(rs.getString("Scene"));
	fitment=getbyte(rs.getString("Fitment"));
	
	salestate=rs.getInt("SaleState");
	
    area1=df.format(rs.getFloat("UsedArea"));
	java.text.DecimalFormat df1 = new java.text.DecimalFormat(" ###,###,###.##"); 
    java.text.DecimalFormat df2 = new java.text.DecimalFormat(" ###,###,###"); 
	Stype=getbyte(rs.getString("RoomType"));
	JzUnitprice=df1.format(rs.getFloat("Unitprice")); 
    countprice=df2.format(rs.getFloat("Sumprice"));
	TnUnitprice=df1.format(rs.getFloat("TNunitprice"));
	//countprice=countprice.subString(1,2);
	cusno=getbyte(rs.getString("serialNo"));
	Cusname=getbyte(rs.getString("Cus_name"));
    Subscription=rs.getString("Subscription");
    TEL=getbyte(rs.getString("TEL"));
    EndDate=getbyte(rs.getString("EndDate"));
    Receiver=getbyte(rs.getString("Receiver"));
	
  %>
  <%switch (salestate)
    {
	  case 1:
	       color="blue";
		   MessTitle="修改当前房间资料";
		   break;
	  case 2:
	       color="red";
		   MessTitle="";//"不能修改已预售的房间资料";
		   break;
	  case 3:
	       color="black";
		   MessTitle="";//"不能修改已出售的房间资料";
		   break;
	  case 4:
	       color="yellow";
		   MessTitle="修改当前房间资料";
		   break;    
	}

  %>
 
    <tr id=TR<%=i %> align="center" class='listcontent' onmouseover="mout(this);"  onclick="changeclass1(this,'clickbg','listcontent');" > 
        <td><a href="#" onclick="openwin('../customter/listcusdata.jsp?cusno=<%=cusno %>','')"><%= Cusname.trim()%></a></td>
      <td    ><%=TEL.trim() %></td>
	  <td    ><%=Subscription.trim() %></td>
      <td    ><a href="#" onclick="openwin('../basic/roomdata.jsp?secno=<%=secno %>&roomno=<%=roomno%>&loft=<%=loft %>&build=<%=build%>&show=true','')"><%=loft+build+roomno %></a></td>
      <td    ><%=area %></td>
      <td    ><%=JzUnitprice %></td>
      <td    ><%=Stype %></td>
      <td    ><%=countprice.trim() %></td>
	   <td    ><%= cx.trim()%></td>
	
	  <td    ><%=EndDate.trim() %></td>
	  <td    ><%=Receiver.trim() %></td>
   </tr>
    <%
}
  rs.close();
}catch(Exception s)  {out.print(s.getMessage()+sql);out.close();}

%>
</table>
   <%@ include file="../public_js/changepage1.jsp"%>
<script lang=javascript>
    function doSearch()
    {
        var doWhat = document.forms[ 0 ].doWhat.value ;
        var fanghou = document.forms[ 0 ].fanghou.value ;
        var kehuxingming = document.forms[ 0 ].kehuxingming.value ;
        var time1 = document.forms[ 0 ].time1.value ;
        var time2 = document.forms[ 0 ].time2.value ;
        var xiaoshouren = document.forms[ 0 ].xiaoshouren.value ;

        var url2 = "&doWhat=" + doWhat
        url2 = url2 + "&fanghou=" + fanghou
        url2 = url2 + "&kehuxingming=" + kehuxingming
        url2 = url2 + "&time1=" + time1
        url2 = url2 + "&time2=" + time2
        url2 = url2 + "&xiaoshouren=" + xiaoshouren
        
        var url = document.location.href
        if( url.indexOf( "&doWhat=" ) != -1 ) {
            url = url.substring( 0 , url.indexOf( "&doWhat=" ) )
        }
        //document.location.href = url + url2
        document.forms[ 0 ].action = "RoomView3.jsp"
        document.forms[ 0 ].submit()
    }
</script>

</body>
</html>