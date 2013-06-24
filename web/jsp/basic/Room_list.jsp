<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>房间资料一览</title>
</head>
<%@ page language="java" import="java.sql.*,java.lang.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>


<script language="javascript" src="../public_js/public.js">
</script>


<script>
function check(aForm){
   if (aForm.SecNo.value<1)
		{
	        alert("请选择查询条件！");
	        aForm.SecNo.focus();
	        return false;
		}
	    return (true);
}		
</script>		
<%
String Search=China.getParameter(request,"Search");
String StrFind=China.getParameter(request,"Find");
String tmp=request.getParameter("pageno");
String strCode=request.getParameter("code");

if (strCode!=null){
    ViewBean.executeUpdate("delete room where code="+strCode);
}
int i=0;
String SecNo="";
String Loft="";
String Build="";
String RoomNo="";
String Floor="";
String state="";
 
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

  if (!Search.equals("")){

   SecNo=request.getParameter("SecNo");
   SecName=request.getParameter("SecName");
   if (!StrFind.equals(""))  SecName=new String(SecName.getBytes("ISO8859_1"),"GBK");
   if (!SecNo.equals("")){
     	secpara=SecNo;
		SearchWhere=" and seccode ='"+SecNo+"'";
	}  
   Loft=request.getParameter("Loft");	
   if (Loft==null)Loft="";	
   if (!StrFind.equals(""))  Loft=new String(Loft.getBytes("ISO8859_1"),"GBK");

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
   if (!StrFind.equals(""))  Build=new String(Build.getBytes("ISO8859_1"),"GBK");

   if (!Build.equals("")){
       if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and Building ='"+Build+"'";
		 }  
		else {
		   SearchWhere=" and Building ='"+Build+"'";
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
}

}catch(Exception s){out.print(s.getMessage());out.close();}

%>

   <script>
   function fuu(){
  document.cus.Building.options[document.cus.Building.length]=new Option('<%=Build %>','<%=Build %>');
  document.cus.Loft.options[document.cus.Loft.length]=new Option('<%=Loft %>','<%=Loft %>');
  document.cus.RoomCode.value="<%=RoomNo %>";
 
  document.cus.Floor.value="<%=Floor %>";
  }
  </script>
 <body  topmargin="1">
 <!--设置分页用的变量及分页条件计算-->
<%@ include file="../public_js/countpagenum.jsp"%>
<form method="POST" name="cus" action="Room_list.jsp" onsubmit="return check(this);" >
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">

<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('crm_RoomCodeList1.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>房源资料</font> 
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=2;findSub('crm_RoomCodeList3.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>销售情况</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('Room_list.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>房源视图</font></a>
	</td>
	</tr></table>
	<script>
function findSub(para){
   document.cus.action=para+"?Search=b&Find=b";
   document.cus.submit();


}
</script>
<input type=hidden name=SecName value=<%=SecName %>>
<input type=hidden name=SecNo value=<%=SecNo %>>
<input type=hidden name="Build" value=<%=Build %>>
<input type=hidden name="Loft" value="<%=Loft %>">
<input type=hidden name="Floor">
<input type=hidden name="RoomCode">
<input type=hidden name="unitprice">
<input type=hidden name="CX">
<input type=hidden name="JZAREA">
<input type=hidden name="RoomType">
<input type="hidden" name="Find" value="查询">
<input type=hidden name=Search value="a">
      
		   <p align=center ><font size=3 class=FontColor><b><%=SecName %>房间资料表</b></font></p>
   <table width=100%><tr height="16" bgcolor="#EAEAEA">
   <td><a href="javascript:window.history.back(1);">返回</a></td>
   <td align="right">
       <%@ include file="../public_js/qx_checke.jsp"%>
		   <%String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B005"); %>

		   <%if (Cortrol.indexOf("E")>=0){ %>
   	       <input type=button value="修 改" onclick="Edit();">&nbsp;&nbsp;
		   <%}
		     if (Cortrol.indexOf("D")>=0){%>
		   <input type=button value="删 除" onclick="Dele();">&nbsp;&nbsp;
	       <%}
		     if (Cortrol.indexOf("F")>=0){%>
		   <input type=button value="详 情" onclick="view();">&nbsp;&nbsp;  
		   <input type=button value="查 询" onclick="openwin1('FindDataPage.jsp',250,250,100,100)" >
	   	   <%} %>
		   </td></tr></table>
  <table width=100%><tr height="3"><td></td></tr></table>    	
   <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center >
  <tr class=listtitle>
      <td   align="center"   ><font color=white>房间代码</font></td>
      <td   align="center"   ><font color=white>建筑面积</font></td>
      <td   align="center"   ><font color=white>建筑单价</font></td>
      <td   align="center"   ><font color=white>套内面积</font></td>
      <td   align="center"   ><font color=white>套内单价</font></td>
      <td   align="center"   ><font color=white>户型</font></td>
     
      <td   align="center"   ><font color=white>装修状况</font></td>
      <td   align="center"   ><font color=white>总售价</font></td>
      <td   align="center"   ><font color=white>朝向</font></td>
     
   	    </tr>
  
<%

  String secno="";
  String sql="";
 
  String SectionS=""; 
  sql="select Top "+pageSize+" *  from Room where code not in (Select top "+prenum +" code from room where      seccode='"+SecNo+"' and loft='"+Loft+"' "+SearchWhere+"  order by  floor,Room_code)  and   seccode='"+SecNo+"' and loft='"+Loft+"' "+SearchWhere+" order by loft, floor,Room_code";
  sqlcount="SELECT count(code) from room  where    seccode='"+SecNo+"' and loft='"+Loft+"' "+SearchWhere +" ";
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
  String Floo="";
  String RoomNo1="";
  ResultSet rs=null;
  try{
  rs=ViewBean.executeQuery(sql);

   i=0;
 while (rs.next()){
    i=i+1; 
	Code=rs.getInt("code");
	
	secno=rs.getString("seccode");
	loft=getbyte(rs.getString("Loft"));
	build=getbyte(rs.getString("building"));
	roomno=rs.getString("Room_code");
    RoomNo1  =rs.getString("Room");
    area=FormtD.getFloat3(rs.getDouble("Area"),2);
    Floo=rs.getString("Floor");
	cx=getbyte(rs.getString("Direction"));
	jg=getbyte(rs.getString("Scene"));
	fitment=getbyte(rs.getString("Fitment"));
	salestate=rs.getInt("SaleState");
    area1=FormtD.getFloat3(rs.getDouble("UsedArea"),2);
	
	Stype=getbyte(rs.getString("RoomType"));
	JzUnitprice=FormtD.getFloat3(rs.getDouble("Unitprice"),2); 
    countprice=FormtD.getFloat3(rs.getDouble("Sumprice"),2);
	TnUnitprice=FormtD.getFloat3(rs.getDouble("TNunitprice"),2);
	//countprice=countprice.subString(1,2);
 
	
  %>
  
 
    <tr id=TR<%=i %> title="双击可修改或查看资料" align="center" class='listcontent' onmouseover="mout(this);"  onclick="savepara('<%=Code %>','<%=secno%>','<%=build%>','<%=roomno%>','<%=loft %>','<%=Floo %>','<%=RoomNo %>','<%=RoomNo1 %>');changeclass1(this,'clickbg','listcontent');"  ondblclick="Edit();" > 

      <td    ><font color="<%=color%>"><%=loft+build+roomno %></font></td>
      <td    ><%=area %></td>
      <td    ><%=JzUnitprice %></td>
      <td    ><%=area1 %></td>
      <td    ><%=TnUnitprice %></td>
      <td    ><%=Stype %></td>
      <td  ><%= fitment.trim()%></td>
      <td    ><%=countprice.trim() %></td>
      <td   ><%=cx.trim() %></td>

    
       
       </tr>
    <%
}
  rs.close();
}catch(Exception s)  {out.print(s.getMessage());out.close();}
 %>
</table>
 <%@ include file="../public_js/changepage4.jsp"%>
 <%ViewBean.closeConn(); 
        %>
  <script>
   var secid="";
   var secno="";
   var build="";
   var loft="";
   var room="";
   var Floo=""
   var EndR="";
    function Edit(){
    	 if (confirm("真的要修改选择的房间信息吗？")){
   	         if (secid==""){alert("请选择房间(只需单击列表中某行一次)");}
		     else{openwin1("crm_RoomEdit.jsp?loft="+loft+"&seccode="+secno+"&Room_code="+room+"&Floor="+Floo+"&MaxFloor="+Floo+"&building="+build+"&BengR="+EndR+"&EndR="+EndR+"&Room="+EndR,500,450,100,100); }
	  }
	}

	function Dele(){
	 if (confirm("真的要删除选择的房间信息吗？")){
   	      if (secid==""){alert("请选择房间(只需单击列表中某行一次)");}
		   else{openwin1("RoomDelete.jsp?secno="+secno+"&roomno="+room+"&build="+build+"&code="+secid,400,350,100,100); }
	  }
	}
	function view(){ 
	       if (secid==""){alert("请选择房间(只需单击列表中某行一次)");}
		     else{openwin1("crm_RoomEdit.jsp?loft="+loft+"&seccode="+secno+"&Room_code="+room+"&Floor="+Floo+"&MaxFloor="+Floo+"&building="+build+"&BengR="+EndR+"&EndR="+EndR+"&Room="+EndR,500,450,100,100); }
	}
    function savepara(para,para1,para2,para3,para4,para5,para6,para7){
			  secid=para;
			  secno=para1;
			  build=para2;
			  room=para3;
			  loft=para4;
			  Floo=para5;
			  EndR=para7;
		
			 
			  }
  
  </script>

</body>
</html>