 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>换房一览表</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
<script language=javascript src="js/mad.js"> </script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script> 
 
 <body  oncontextmenu="return false"   topmargin="1"  >
<form name="frm" method="post" action="ChangeList.jsp"> 
 <%
	
	int hasRecord = 0;
	int id;
	String  SecNo=China.getParameter(request,"SecNo");
    String  SecName=China.getParameter(request,"SecName");
	String  Loft=China.getParameter(request,"Loft");	
	String  Build=China.getParameter(request,"Build");
	String section;
	String building;
	String OldRoom;
	String NowRoom;
	String ChangeDate;
    String Note="";
	String person="";
	String checker="";
	String seller="";
	String subscription="";
	
      String doWhat = getbyte( request.getParameter( "doWhat" ) ) ;
    String fanghou = getbyte( request.getParameter( "fanghou" ) ) ;
    String kehuxingming = getbyte( request.getParameter( "kehuxingming" ) ) ;
    String time1 = getbyte( request.getParameter( "time1" ) ) ;
    String time2 = getbyte( request.getParameter( "time2" ) ) ;
    String xiaoshouren = getbyte( request.getParameter( "xiaoshouren" ) ) ;
    String findStr = "" ;
    if( doWhat.equals( "find" ) ) {
       findStr = findStr + " and section like '%' " ;
       if( ! fanghou.equals( "" ) ) {
            findStr = findStr + " and oldroom = '" + fanghou + "' " ;
       }
       if( ! kehuxingming.equals( "" ) ) {
            findStr = findStr + " and person like '%" + kehuxingming + "%' " ;
       }
       if( ! time1.equals( "" ) ) {
            findStr = findStr + " and changedate >= '" + time1 + " 00:00:00" + "' " ;
       }
       if( ! time2.equals( "" ) ) {
            findStr = findStr + " and changedate <= '" + time2 + " 23:59:59" + "' " ;
       }
       if( ! xiaoshouren.equals( "" ) ) {
            findStr = findStr + " and checker like '%" + xiaoshouren + "%' " ;
       }
    }
       if(!Loft.equals(""))
	     findStr +=" and rtrim(Loft)='"+Loft+"' ";
%>
<%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	   %>
<table width="620" border="0" cellspacing="0" cellpadding="0" class="L2" >
<tr  valign="top">
    <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('crm_rg_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>认购明细</a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('crm_rg_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>签约明细</a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_ld_list.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>临订明细</a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_yl_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>预留明细</a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/CancelList.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>退房明细</a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/ChangeList.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>换房明细</a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_ws_list.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未售明细</a>
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
<input type=hidden name=choose>
<input type=hidden name=SecName value="<%=SecName %>">
<input type=hidden name=SecNo value="<%=SecNo %>" >
<input type=hidden name="Build" value="<%=Build %>">
<input type=hidden name="Loft" value="<%=Loft %>" >
<p align="center" class=FontColor><font size=3><b>  <%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft+Build %>换房明细</b></p>

<table bgcolor="#EAEAEA" width="140%">
 <tr bgcolor="#EAEAEA">
   <td>
    <input type=hidden name="doWhat" value="find" >
    原房号:<input type=text name=fanghou size=5 value="<%= fanghou %>" >
    经办人:<input type=text name=kehuxingming size=10 value="<%= kehuxingming%>" >
    换房日期: 从<input type=input name=time1 size=10 readonly value="<%= time1%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">到<input type=input name=time2 size=10 readonly value="<%= time2%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;">
    审批人:<input type=text name=xiaoshouren size=10 value="<%= xiaoshouren %>" >
    <input type=button value="查询" onclick="document.forms[0].submit();" >
  </td>
 </tr>
</table>

<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" >
  <td   align="center"   >序号</td>
 <td>现房间代码</td>
  <td>原房间代码</td>
  <td>客户姓名</td>
   <td>认购日期</td>
 <td>换房日期</td>
 <td>换房原因</td>
  <td>换房面积差</td>
    <td>换房总价差</td>
  <td>经办人</td>
 <td>审批人</td></tr> 
<%
	String changeStr = "select  *,sumprice-oldprice c_price,jzarea-oldarea c_area from ChangRoomR where section='"+SecName+"'and build='"+Build + "' "
                      + findStr
                      + " order by ChangeDate desc";
    String secno="";
	String customer="";
	String cusname="";
	String order_code="";
	String newloft="",newbuild="";
   // out.print( changeStr + "<br>" ) ;
    ResultSet changeRS1 = null;
	try{
	changeRS1 = changeListBean.executeQuery(changeStr);	
	hasRecord = 0;
	int i=0;
	while (changeRS1.next()) {
		hasRecord = 1;
		 i++;
		 secno=changeRS1.getString("secno");
		 customer=changeRS1.getString("customer");
		 
		 if(customer!=null){
		 String  sql="select customer.cus_name,Order_Contract.code  from customer,Order_Contract where Order_Contract.customer=customer.SerialNo and Order_Contract.section='"+secno+"' and customer.SerialNo='"+customer+"'";
		
		 ResultSet rs = ViewBean.executeQuery(sql);	
		 if(rs.next())
		    cusname=getbyte(rs.getString("cus_name"));
			order_code=getbyte(rs.getString("code"));
		 }
		 
		 section = getbyte(changeRS1.getString("Section"));
		 Loft =getbyte(changeRS1.getString("Loft"));
		 building = getbyte(changeRS1.getString("Build"));
		 OldRoom = changeRS1.getString("OldRoom"); 
		 NowRoom = changeRS1.getString("NowRoom"); 
		 newloft= changeRS1.getString("newloft"); 
		 newbuild= changeRS1.getString("newbuild"); 
         ChangeDate = changeRS1.getString("ChangeDate");
		 checker=getbyte(changeRS1.getString("Checker"));
		 Note=getbyte(changeRS1.getString("Note"));
	    person=getbyte(changeRS1.getString("person"));
		String c_price=getbyte(changeRS1.getString("c_price"));
		String c_area=getbyte(changeRS1.getString("c_area"));
		String oldname=getbyte(changeRS1.getString("oldname"));
		String olddate=getbyte(changeRS1.getString("olddate"));

 %> <b>
  <tr id=TR<%=i %>  align="center"    onclick="changeclass1(this,'clickbg','');"  onmouseover="mout(this) ; "  title="换房原因：<%=Note %>" >
  <td    ><%=i %></td>
<td ><a href="#" onclick="openwin('td_hf_list.jsp?secno=<%=secno %>&roomno=<%=NowRoom%>&loft=<%=Loft %>&build=<%=building%>&show=true&ftyy=<%=Note %>&checker=<%=checker %>&customer=<%=customer %>&order_code=<%=order_code %>',500,600,10,30)"><%= newloft+newbuild+NowRoom%></td>
<td><a href="#" onclick="openwin('../basic/roomdata.jsp?secno=<%=secno %>&roomno=<%=OldRoom%>&loft=<%=Loft %>&build=<%=building%>&show=true','')"><%= oldname+ Loft+building+OldRoom %></td>
<td><a href="#" onclick="openwin('../customter/listcusdata.jsp?cusno=<%=customer %>','')"><%=cusname %></td>
<td><%= olddate.substring(0,olddate.indexOf(" ")) %></td>
<td><%= ChangeDate.substring(0,ChangeDate.indexOf(" ")) %></td>
<td><%= Note %>&nbsp;</td>
<td><%= c_area %></td>
<td><%= c_price %></td>

<td><%= person %></td>
<td><%= checker %></td>
</tr>
</b> 
<%
  	}
	changeRS1.close();
	}catch(Exception e){}
  %>

</form>
<script lang=javascript>
    function doSearch()
    {
      document.frm.submit();
    }
</script>
</body>
</html>
