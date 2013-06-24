<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import = "java.sql.*" %>
<%@ include file="../public_js/qx_checke.jsp"%>
<jsp:useBean id = "ajListBean" scope = "page" class = "ConnDatabase.SDatabase" />

 <%@ include file="../public_js/getByteOut.jsp"%>
<%
			
 String sel=(String)request.getParameter("sel");
 String chhosetype=(String)request.getParameter("chhosetype");
  
   if(sel==null) sel="2";				
   if(chhosetype==null) chhosetype="1";	

%>

<html>
<head>
<title>商业贷款按揭利率管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body bgcolor="#FFFFFF" text="#000000" oncontextmenu="return false" >

<script language="javascript" src="../public_js/public.js">
</script>
<script> 
function save1(){
  document.ajform.SaveData1.disabled=true;
   document.ajform.action="SaveAj.jsp?SaveData="+document.ajform.SaveData1.value;

   document.ajform.submit();
 
 
 }
</script>
<form name="ajform" method="post"> 
<input type=hidden name=sel value="<%=sel%>">
<input type=hidden name=Type value="3">
<input type=hidden name=chhosetype value="<%=chhosetype%>">
<center>
<p align=center><b><font size=3>按揭利率设定</font></b></p>
<%
 
String Cortrol=checke_qx(ajListBean,(String)session.getAttribute("loginid"),"B010");
   if (Cortrol==null)Cortrol="";
    if (Cortrol.indexOf("A")>=0){ %>
<table width="75%" border="0" cellpadding="1" cellspacing="1"> 
<tr>  <td class=roomleft>&nbsp;贷款年限</td>
	 <td class=roomright>
<select name="Year">
 
 <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"</option>");
		} %>  

</select>

 </td>
  <td class=roomleft>&nbsp;月供系数</td>
 <td class=roomright>
	<input type="text" name="MonthPay" size="15" value=0 onblur="checkNaN(this);">(元)</td>
	
	  <td class=roomleft>&nbsp;置业类型：</td>
  <td class=roomright> 
  <input name="yong_tu" type="radio" value=0 checked>一次置业利率&nbsp;<input name="yong_tu" type="radio" value=1>二次或二次以上置业&nbsp;

 </td>
 </tr> </table>
 <P align=center>
    	 
 <input type=button name=SaveData1 value="保 存"  onclick="save1();"> 

 <input type=Reset name=cancel value="重 填" > 
 <%} %>
 </p>
 </center>
 
 </form>
   <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.ajform.sel.value=1;document.ajform.chhosetype.value=0;document.ajform.action='AjList.jsp';document.ajform.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>公积金贷款</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.ajform.sel.value=2;document.ajform.chhosetype.value=1;document.ajform.action='AjList2.jsp';document.ajform.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>商业性贷款</font></a>
	</td>
	 
   </tr>
 </table>
      <p align="center"><b><font size=3>按揭还贷利率对照表(以万元为准)</font></b></p>
   
 <table width="100%" border="0" cellpadding="1" cellspacing="1">
  <tr class=TXTColor> 
 
    <td > 
      <div align="center">贷款年限</div>
    </td>
 
	<td > 
      <div align="center">月供系数</div>
    </td>
	 
   <td > 
      <div align="center">置业类型</div>
    </td>
    <td > 
      <div align="center">操作</div>
    </td>
  </tr>
  
  <%!
	
	ResultSet ajRS = null;
	//int hasRecord；
	int id;
	int seq;
%>
  <%
  	String pageno = request.getParameter("pageNo");
	if (pageno == null) 
		pageno = "1";
	int pageNo = Integer.parseInt(pageno);
	int pageSize = 10;
	String hasNext = "N";
	int firstPos = (pageNo - 1) * pageSize + 1;
	int i = 0;
	
	String ajStr = "select id,year,MonthTax,yearTax,yong_tu,MonthPay,lx from ajllgkb  where type=3 order by yong_tu,year";//where id >=" + String.valueOf(firstPos);
	ResultSet ajRS = ajListBean.executeQuery(ajStr);	
 
	while (ajRS.next()) {// && i < pageSize)
		id = ajRS.getInt("id");
		int yongtu=ajRS.getInt("yong_tu");
	 
	
 %>
   <tr align="center" class=listcontent  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');"  > 

     
    <td  >
      <div align="center"><%= ajRS.getInt("year") %> </div>
    </td>
   
	<td  >
      <div align="center"><%= ajRS.getFloat("MonthPay") %> </div>
    </td>
  
     <td  >
      <div align="center"><%if (yongtu==0){out.print("一次置业利率");}else{out.print("二次或二次以上置业利率");}%> </div>
    </td>
    <td   > 
      <div align="center">
	  <%  if (Cortrol.indexOf("D")>=0){ %>
        <a href="javascript:delAj('<%= id %>')" >删除</a>
		<%} %>
		 </div>
    </td>
    <script>
		function delAj(id) {
			if (confirm("确实要删除该记录?"))
				window.location = "deleteAj.jsp?sel=2&chhosetype=3&aj_oper=dele&id=" + id;
		}
		
	</script>
  </tr>
 <%} %>
</table>
  
</p>
</body>
</html>
