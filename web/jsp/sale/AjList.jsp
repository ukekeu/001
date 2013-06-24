<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import = "java.sql.*" %>
 <jsp:useBean id = "ajListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<%@ include file="../public_js/qx_checke.jsp"%>
 
<%
 String sel=(String)request.getParameter("sel");
 String chhosetype=(String)request.getParameter("chhosetype");
  
   if(sel==null) sel="1";				
   if(chhosetype==null) chhosetype="0";	
%>

<html>
<head>
<title>公积金按揭利率</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body bgcolor="#FFFFFF" text="#000000">

<script language="javascript" src="../public_js/public.js">
</script>
<script>
  function submitValidate() {
 
	
	if (document.ajform.MonthPay.value==""){
	  alert("请输入月供供款");
	   document.ajform.MonthPay.focus();
	  return false;
	}
   return true;
  }
function save1(){
 if (submitValidate()){
   document.ajform.SaveData1.disabled=true;
   document.ajform.action="Aj_save.jsp?SaveData="+document.ajform.SaveData1.value;

   document.ajform.submit();
 
 }
 }
</script>
<form name="ajform" method="post"> 
<input type=hidden name=sel value="<%=sel%>">
<input type=hidden name=chhosetype value="<%=chhosetype%>">
<input type=hidden name=Type value="1">
<center>
<p align=center><b><font size=3>按揭设定</font></b></p>
 <% 
 String Cortrol=checke_qx(ajListBean,(String)session.getAttribute("loginid"),"B010");
   if (Cortrol==null)Cortrol="";
 
    if (Cortrol.indexOf("A")>=0){ %>
<table width="75%" border="0" cellpadding="1" cellspacing="1"> 
<tr>   <td class=roomleft>&nbsp;贷款年限</td>
	 <td class=roomright>
<select name="Year">
 <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"</option>");
		} %>  

</select>

 </td><td class=roomleft>&nbsp;月&nbsp;供&nbsp;款</td>
 <td class=roomright colspan=3> 
<input type="text" name="MonthPay" size="15" onkeydown="key(document.ajform.SaveData1)">(元) 
 </td></tr>
   </table>
 <P align=center>
    	
 <input type=button name=SaveData1 value="保 存"  onclick="save1();"> 


 <input type=Reset name=cancel value="重 填" > 
 <%} %>
 </p>
 </center>
 
 </form>

      <p align="center"><b><font size=3>按揭还贷利率对照表(以万元为准)</font></b></p>
   
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
<table width="100%" border="0" cellpadding="1" cellspacing="1">
  <tr class=listtitle> 
   
  
    <td > 
      <div align="center">贷款年限</div>
    </td>
    <!-- <td > 
      <div align="center">月利率</div>
    </td>
    <td > 
      <div align="center">年利率</div>
    </td>
   <td > 
      <div align="center">本息总额</div>
    </td>
    <td > 
      <div align="center">利息总额</div>
    </td>
    -->
    <td > 
      <div align="center">月供款(元)</div>
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
	
	String ajStr = "select * from ajllgkb  where type=1 order by year";//where id >=" + String.valueOf(firstPos);
 
	ResultSet ajRS = ajListBean.executeQuery(ajStr);	
 
	while (ajRS.next()) {// && i < pageSize)
		id = ajRS.getInt("id");
	
 %>
   <tr align="center" class=listcontent  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');"  > 

    <td  >
      <div align="center"><%= ajRS.getInt("year") %> </div>
    </td>
    <!--<td  >
      <div align="center"><%= ajRS.getFloat("MonthTax") %> </div>
    </td>
    <td  >
      <div align="center"><%= ajRS.getFloat("YearTax") %> </div>
    </td>
    <td  >
      <div align="center"><%= ajRS.getFloat("OneInterestSum") %> </div>
    </td>
	<td  >
      <div align="center"><%= ajRS.getFloat("SumInterest") %> </div>
    </td>
    -->
    <td  > 
	
      <div align="center"><%= ajRS.getFloat("MonthPay")%></div>
    </td>
	
    <td   > 
      <div align="center">
     <%  if (Cortrol.indexOf("D")>=0){ %>
        <a href="javascript:delAj('<%= id %>')" >删除</a>
		<%} %> </div>
    </td>
    <script>
		function delAj(id) {
			if (confirm("确实要删除该记录?"))
				window.location = "deleteAj.jsp?sel=1&chhosetype=<%=chhosetype %>&aj_oper=dele&id=" + id;
		}
		var type="<%=sel %>";
		 
	</script>
  </tr>
 <%} %>
</table>
  
</p>
</body>
</html>
