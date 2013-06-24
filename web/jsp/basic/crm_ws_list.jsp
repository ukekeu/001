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

 

   SecNo=getbyte1(request.getParameter("SecNo"));
   SecName=getbyte1(request.getParameter("SecName"));
 
   if (!SecNo.equals("")){
     	secpara=SecNo;
		SearchWhere=" and seccode ='"+SecNo+"'";
	}  
 
   Loft=getbyte1(request.getParameter("Loft"));	
   if (Loft==null)Loft="";	
   
   if (!Loft.equals("")){
        if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and Loft ='"+Loft+"'";
		 }  
		else {
		   SearchWhere=" and Loft ='"+Loft+"'";
		   }
		 }   
	
   Build=getbyte1(request.getParameter("Build"));
    if (!Build.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and Building ='"+Build+"'";}
	  else{
	      SearchWhere="and Building ='"+Build+"'";}
	  } 
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

 

%>

   <script>
   function fuu(){
  document.frm.Building.options[document.frm.Building.length]=new Option('<%=Build %>','<%=Build %>');
  document.frm.Loft.options[document.frm.Loft.length]=new Option('<%=Loft %>','<%=Loft %>');
  document.frm.RoomCode.value="<%=RoomNo %>";
 
  document.frm.Floor.value="<%=Floor %>";
  }
  </script>
 <body topmargin="1" >
 <!--设置分页用的变量及分页条件计算-->
<%@ include file="../public_js/countpagenum.jsp"%>
<form method="POST" name="frm" action="../basic/crm_ws_list.jsp" onsubmit="return check(this);" >
<input type=hidden name=SecName value=<%=SecName %>>
<input type=hidden name=SecNo value="<%=SecNo %>">
<input type=hidden name="Build" value="<%=Build %>">
<input type=hidden name="Loft" value="<%=Loft %>">
<input type=hidden name="Floor">
<input type=hidden name="RoomCode">
<input type=hidden name="unitprice">
<input type=hidden name="CX">
<input type=hidden name="JZAREA">
<input type=hidden name="RoomType">
	 
        <input type="hidden" name="Find" value="查询">
		<input type=hidden name=Search value="a">
      
<%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	 

	  %>
<table width="620" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("2")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/crm_rg_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>认购明细</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('../sale/crm_rg_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>签约明细</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_ld_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>临订明细</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_yl_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>预留明细</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/CancelList.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>退房明细</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/ChangeList.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>换房明细</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_ws_list.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未售明细</font></a>
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
		   <p align=center ><font size=3 class=FontColor><b><%=SecName %>房间资料表</b></font></p>
  
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
  String eof="";
  //设置分页用的变量及分页条件计算
String FindCon=(String)request.getParameter("condtion");
	 
   String SectionS="";//(String)session.getAttribute("Section");	
  sql="select Top "+pageSize+" *  from Room where code not in (Select top "+prenum +" code from room where      seccode='"+SecNo+"' and loft='"+Loft+"' and building='"+Build+"' "+SearchWhere+"  order by  floor,Room_code)  and   seccode='"+SecNo+"' and loft='"+Loft+"' and building='"+Build+"' "+SearchWhere+" order by loft, floor,Room_code";

  sqlcount="SELECT count(code) from room  where    seccode='"+SecNo+"' and loft='"+Loft+"' and building='"+Build+"' "+SearchWhere +" ";
 
 
 
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
        RoomNo1  =rs.getString("Room");
    area=df.format(rs.getFloat("Area"));
    Floo=rs.getString("Floor");
	//RoomNo=String.valueOf(Integer.parseInt(roomno.substring(Floo.length())));

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
 
	
  %>
  <%switch (salestate)
    {
	  case 1:
	     //  color="blue";
		   MessTitle="修改当前房间资料";
		   break;
	  case 2:
	      // color="red";
		   MessTitle="";//"不能修改已预售的房间资料";
		   break;
	  case 3:
	      // color="black";
		   MessTitle="";//"不能修改已出售的房间资料";
		   break;
	  case 4:
	      // color="yellow";
		   MessTitle="修改当前房间资料";
		   break;    
	}

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
 if (eof.equals("false")){
  out.print("</table>");
  out.print("此栋没有资料");
  out.print("<a href='javascript:window.history.back(1)'>返回</a>");
 
} 

%>

</table>
 <%@ include file="../public_js/changepage2.jsp"%>

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
		     else{openwin("RoomEdit.jsp?loft="+loft+"&seccode="+secno+"&Room_code="+room+"&Floor="+Floo+"&MaxFloor="+Floo+"&building="+build+"&BengR="+EndR+"&EndR="+EndR+"&Room="+EndR,400,450,100,100); }
	  }
	}

	function Dele(){
	 if (confirm("真的要删除选择的房间信息吗？")){
   	      if (secid==""){alert("请选择房间(只需单击列表中某行一次)");}
		   else{openwin("RoomDelete.jsp?secno="+secno+"&roomno="+room+"&build="+build+"&code="+secid,400,350,100,100); }
	  }
	}
	function view(){
	       if (secid==""){alert("请选择房间(只需单击列表中某行一次)");}
		     else{openwin("RoomEdit.jsp?loft="+loft+"&seccode="+secno+"&Room_code="+room+"&Floor="+Floo+"&MaxFloor="+Floo+"&building="+build+"&BengR="+EndR+"&EndR="+EndR+"&Room="+EndR,400,450,100,100); }
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