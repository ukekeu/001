<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>预留资料</title>
</head>
<%@ page language="java" import="java.sql.*,java.lang.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js">
</script>

<%!
public String formatDateTime( java.sql.Timestamp dt , int flag ) throws Exception {
    java.text.SimpleDateFormat f = new java.text.SimpleDateFormat( "yyyy-MM-dd" ) ;
    return f.format( dt ) ;
}
%>

<%
String Search=China.getParameter(request,"Search");
String StrFind=China.getParameter(request,"Find1");
String tmp=request.getParameter("pageno");

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
		SearchWhere=" and R.seccode ='"+SecNo+"'";
	}  
   Loft=request.getParameter("Loft");	
   if (Loft==null)Loft="";	
   if (Search.equals(""))  Loft=new String(Loft.getBytes("ISO8859_1"),"GBK");

   if (!Loft.equals("")){
        if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and R.Loft ='"+Loft+"'";
		 }  
		else {
		   SearchWhere=" and R.Loft ='"+Loft+"'";
		   }
		 }   
	
   Build=request.getParameter("Build");
   if (Build==null)Build="";
   if (Search.equals(""))  Build=new String(Build.getBytes("ISO8859_1"),"GBK");

   if (!Build.equals("")){
       if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and R.Building ='"+Build+"'";
		 }  
		else {
		   SearchWhere=" and R.Building ='"+Build+"'";
		   }
		 }  

		 
   RoomNo=China.getParameter(request,"RoomCode");
   if (!RoomNo.equals("")){
      if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and Room_Code like '%"+RoomNo+"%'";}
      else{
	      SearchWhere="and Room_Code like '%"+RoomNo+"%'";}
	
	}  		 
   Floor=China.getParameter(request,"Floor");
   if (!Floor.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and Floor ="+Floor;}
	  else{
	      SearchWhere="and Floor ="+Floor;}
	  }	 
  CX=request.getParameter("CX");
  if (CX==null)CX="";
  if (!StrFind.equals(""))  CX=new String(CX.getBytes("ISO8859_1"),"GBK");
   if (!CX.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and Direction like '%"+CX+"%'";}
	  else{
	      SearchWhere="and Direction like '%"+CX+"%'";}
   }	
   RoomType=request.getParameter("RoomType");
  if (RoomType==null)RoomType="";
  if (!StrFind.equals(""))  RoomType=new String(RoomType.getBytes("ISO8859_1"),"GBK");
  if (!RoomType.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and roomtype like '%"+RoomType+"%'";}
	  else{
	     SearchWhere="and roomtype like '%"+RoomType+"%'";}
   }	
  JZAREA=China.getParameter(request,"JZAREA");
  
  if (!JZAREA.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and area="+JZAREA;}
	  else{
	     SearchWhere="and area="+JZAREA;}
   }	 
  unitprice=China.getParameter(request,"unitprice");
  if (!unitprice.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and Unitprice="+unitprice;}
	  else{
	     SearchWhere="and Unitprice="+unitprice;}
   }	  	  	  
//}

}catch(Exception s){out.print(s.getMessage());out.close();}

String doWhat = getbyte1( request.getParameter( "doWhat" ) ) ;
String fanghou = getbyte1( request.getParameter( "fanghou" ) ) ;
String kehuxingming = getbyte1( request.getParameter( "kehuxingming" ) ) ;
String time1 = getbyte1( request.getParameter( "time1" ) ) ;
String time2 = getbyte1( request.getParameter( "time2" ) ) ;
String xiaoshouren = getbyte1( request.getParameter( "xiaoshouren" ) ) ;
String findStr = "" ;
if( doWhat.equals( "find" ) ) {
   findStr = findStr + " and seccode like '%' " ;
   if( ! fanghou.equals( "" ) ) {
        findStr = findStr + " and room_code = '" + fanghou + "' " ;
   }
   if( ! kehuxingming.equals( "" ) ) {
        findStr = findStr + " and person like '%" + kehuxingming + "%' " ;
   }
   if( ! time1.equals( "" ) ) {
        findStr = findStr + " and dengji >= '" + time1 + " 00:00:00" + "' " ;
   }
   if( ! time2.equals( "" ) ) {
        findStr = findStr + " and dengji <= '" + time2 + " 23:59:59" + "' " ;
   }
   if( ! xiaoshouren.equals( "" ) ) {
        findStr = findStr + " and checker like '%" + xiaoshouren + "%' " ;
   }
}
%>

 <body topmargin="1" >
 
<form method="POST" name="frm" action="../basic/crm_ld_list.jsp">

<input type=hidden name=Find1>
<input type=hidden name=choose>
<input type=hidden name=SecName value="<%=SecName%>">
<input type=hidden name=SecNo value="<%= SecNo%>" >
<input type=hidden name="Build" value="<%= Build%>" >
<input type=hidden name="Loft" value="<%= Loft%>" >
<input type=hidden name="Floor">
<input type=hidden name="RoomCode">
<input type=hidden name="unitprice">
<input type=hidden name="CX">
<input type=hidden name="JZAREA">
<input type=hidden name="RoomType">

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
	<td class="<%if(sel.equals("3")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_ld_list.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>临订明细</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_yl_list.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>预留明细</font></a>
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
	 <%
  String CountSql="select count(*) num ,sum(area) area from Room R  where  R.seccode in('"+SecNo+"') and  R.SaleState='4'"+SearchWhere+"  group by R.seccode ";
  ResultSet CountRs=null;
  String num="0";
  String SumArea="0";
  String Money="0";
  try{    
   CountRs=ViewBean.executeQuery(CountSql);
   while (CountRs.next()){
     num=CountRs.getString("num");
	 SumArea=FormatD.getFloat(CountRs.getFloat("area"),3);
   }
   CountRs.close();
  }catch(Exception s) {}
  %>
  <!--
  <p align=center class=FontColor>
   <font size=2 >
    总套数:<%= num %> 套&nbsp;&nbsp;&nbsp; 
    总面积:<%= SumArea %> M2&nbsp;&nbsp;&nbsp; 
    统计日期：<%= DateInfo.currentYear() + "." + DateInfo.currentMonth() + "." + DateInfo.currentDay() %>
  </font></p>
 -->	<p align=center class=FontColor><font size=3><b> <%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft + Build %>预留明细</b></font></p>
 <table width="100%">
 <tr>
   <td>
    <input type=hidden name="doWhat" value="find" >
    房号:<input type=text name=fanghou size=5 value="<%= fanghou %>" >
    登记人:<input type=text name=kehuxingming size=10 value="<%= kehuxingming%>" >
    登记日期: 从<input type=input name=time1 size=10 readonly value="<%= time1%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">到<input type=input name=time2 size=10 readonly value="<%= time2%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;"><br>
    审核人:<input type=text name=xiaoshouren size=10 value="<%= xiaoshouren %>" >
    <input type=button value="查询" onclick="doSearch()" >
  </td>
 </tr>
</table>

   <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center >
  <tr class=listtitle>
      <td   align="center"> 序号 </td>
      <td   align="center"   ><font color=white>房间代码</font></td>
      <td   align="center"   ><font color=white>建筑面积</font></td>
      <td   align="center"   ><font color=white>建筑单价</font></td>
      <td   align="center"   ><font color=white>套内面积</font></td>
      <td   align="center"   ><font color=white>套内单价</font></td>
      <td   align="center"   ><font color=white>户型</font></td>     
      <td   align="center"   ><font color=white>装修状况</font></td>
      <td   align="center"   ><font color=white>总售价</font></td>
      <td   align="center"   ><font color=white>朝向</font></td>     
	  <td   align="center"   ><font color=white>经手人</font></td>
	  <td   align="center"   ><font color=white>批准人</font></td>
	  <td   align="center"   ><font color=white>登记日期</font></td>
	  <td   align="center"   ><font color=white>有效日期</font></td>
   	    </tr>
  
<%

  String secno="";
  String sql="";
  //设置分页用的变量及分页条件计算
String FindCon=(String)request.getParameter("condtion");
	if (FindCon!=null){
    	FindCon=" = "+FindCon;
    	}
    else{
	   FindCon="<>'2' ";
	 }  
	String condtion=FindCon;	
	
    String start="";
	int startnum=0;
    int pageSize=10;
    int pageno;
    String eof="false";
	

   if(tmp==null ||tmp.length()==0){
       pageno=1;
	   }
   else{
      pageno=Integer.parseInt(tmp);
	  }
   if (request.getParameter("startnum")!=null){
   	    start=" >"+request.getParameter("startnum");
	}
   else{
	 start=" >0";
	}
    int previous=pageno-1;
    int next=pageno+1;

  sql="select R.*,S.Name , y.person , y.checker , y.dengji , y.youxiao from Room R inner join CRM_Project S on S.SerialNo=R.seccode "
	  + " left join ylroom y on r.room_code=y.rooms and r.building = y.building  and r.seccode = y.section "
      + " where S.SerialNo in('"+SecNo+"') and  R.SaleState='4' and R.Code "+start+SearchWhere
      + findStr
      +" order by  y.dengji , R.Code ,R.Building,R.Room_code";

 

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
  String jingshou = "" ;
  String pizhun = "" ;
  String dengji = "" ;
  String youxiao = "" ;
	
  ResultSet rs=null;
  try{
  rs=ViewBean.executeQuery(sql);

   i=0;
 while (rs.next()&& i<pageSize){

	 eof="true";
     i=i+1; 
	 Code=rs.getInt("code");
	 if (i==pageSize){
       startnum=Code;
     }
	
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
	String name=getbyte(rs.getString("Name"));

	jingshou = getbyte(rs.getString("person"));
	pizhun = getbyte(rs.getString("checker"));
	dengji = formatDateTime( rs.getTimestamp( "dengji" ) , 0 )  ;
	youxiao = formatDateTime( rs.getTimestamp( "youxiao" ) , 0 )  ;
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
<td ><%=i%></td>     
 <td    ><a href="#" onclick="openwin('../basic/roomdata.jsp?secno=<%=secno %>&roomno=<%=roomno%>&loft=<%=loft %>&build=<%=build%>&show=true','')"><%=loft+build+roomno %></a></td>
      <td    ><%=area %></td>
      <td    ><%=JzUnitprice %></td>
      <td    ><%=area1 %></td>
      <td    ><%=TnUnitprice %></td>
      <td    ><%=Stype %></td>
      <td    ><%= fitment.trim()%></td>
      <td    ><%=countprice.trim() %></td>
      <td    ><%=cx.trim() %></td>

	  <td    ><%= jingshou %></td>
	  <td    ><%= pizhun %></td>
	  <td    ><%= dengji %></td>
	  <td    ><%= youxiao %></td>
   </tr>
    <%
}
  rs.close();
}catch(Exception s)  {out.print(s.getMessage());out.close();}
  

%>
</table>

<script lang="javascript">
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
        document.forms[ 0 ].action = "crm_ld_list.jsp" ;
        document.forms[ 0 ].submit() ;
    }
</script>

</body>
</html>