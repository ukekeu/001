<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%> 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>费用计算标准</title>
</head>
<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
    <%@ include file="../public_js/getByteOut.jsp"%>
   <%@ include file="../public_js/qx_checke.jsp"%>
   
   <%!
   String Cortrol="";
   
	  int jjj=0;
   %>   
   	 <%
 
Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B007");
   if (Cortrol==null)Cortrol="";
    %>
  
    
<%!
    String taxname="";
	 public String ShowTax(String sqlstr) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  String state="",type1="";
    
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
	 FormatData.FormatData formatD1=new FormatData.FormatData();
		while (TaxRs.next()) {
		int     id = TaxRs.getInt("ID");
		
	    String  money = formatD1.getFloat1(TaxRs.getFloat("money"),3);
		String  termvalue=TaxRs.getString("termvalue");
   	    String  termvalue1=getbyte(TaxRs.getString("termvalue1"));
		String term=getbyte(TaxRs.getString("term"));
		String term1=getbyte(TaxRs.getString("term1"));
		String custype=getbyte(TaxRs.getString("type"));//单位与个人
		String money1=formatD1.getFloat3(TaxRs.getDouble("money1"),2);
	    String  termvalue2=TaxRs.getString("termvalue2");
		 String term2=getbyte(TaxRs.getString("term2"));
		 String  termvalue3=TaxRs.getString("termvalue3");
		 String term3=getbyte(TaxRs.getString("term3"));
		 
		if (termvalue3==null)termvalue3="0";
		
		if (term.equals(">"))term="大于";
		else if (term.equals("<"))term="小于";
		else if (term.equals("<="))term="小于等于";
		else if (term.equals(">="))term="大于等于";
		else if (term.equals("="))term="等于";
		if (term1.equals(">"))term1="大于";
		else if (term1.equals("<"))term1="小于";
		else if (term1.equals("<="))term1="小于等于";
		else if (term1.equals(">="))term1="大于等于";
		else if (term1.equals("="))term1="等于";
		
		if (term2.equals(">"))term2="大于";
		else if (term2.equals("<"))term2="小于";
		else if (term2.equals("<="))term2="小于等于";
		else if (term2.equals(">="))term2="大于等于";
		else if (term2.equals("="))term2="等于";
		if (term3.equals(">"))term3="大于";
		else if (term3.equals("<"))term3="小于";
		else if (term3.equals("<="))term3="小于等于";
		else if (term3.equals(">="))term3="大于等于";
		else if (term3.equals("="))term3="等于";
		state=TaxRs.getString("state");
		type1=TaxRs.getString("type1");
		if (!state.equals(""))  jjj++;
		String  TaxName = "计费标准"+String.valueOf(jjj);//getbyte(TaxRs.getString("TaxName"));
	  if (type1.equals("1"))type1="不足100元，收取100处理";
	  else type1="";
	  String type3=getbyte(TaxRs.getString("type3"));
	  if (type3.equals("1"))type3="外销费用";
	  else type3="";
	
	  if (custype.equals("1"))custype="单位费用";
	  else custype="";
	  type3+=" "+custype;
   str+="<tr  align='center' class=listcontent>";
   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"</td>";
  if (state.equals("1"))//按售价百分比计算
   str+="<td align=left>&nbsp;&nbsp;房价"+term+termvalue+"万元且"+term1+termvalue1+"万元,收取房价的"+money+" ‰&nbsp;"+type1+"("+type3+")</td>";
  else   if (state.equals("2")){//按固定金额计算

   str+="<td align=left>"+custype+"每套&nbsp;&nbsp;"+money+"元&nbsp;("+type3+")</td>";
 } else   if (state.equals("3"))//按购房面积计算
   str+="<td align=left>&nbsp;&nbsp;面积"+term+termvalue+"平方米"+term1+termvalue1+"平方米,收取房价的"+money+" ‰&nbsp;"+type1+"("+type3+")</td>";
    else   if (state.equals("4"))//按购房面积计算
   str+="<td align=left>&nbsp;&nbsp;面积"+term+termvalue+"平方米"+term1+termvalue1+"平方米,收取"+money+"元&nbsp;"+type1+"("+type3+")</td>";
   else   if (state.equals("5"))//按购房面积计算
   str+="<td align=left>&nbsp;&nbsp;面积"+term+termvalue+"平方米"+term1+termvalue1+"平方米,收取"+money+" 元/平方米&nbsp;"+type1+"("+type3+")</td>";
  
  
  
  
  else   if (state.equals("6"))//按户数计算
   str+="<td align=left>&nbsp;&nbsp;每户"+money+"元&nbsp;"+type1+"("+type3+")</td>";
 else   if (state.equals("7"))//按揭款计算
   str+="<td align=left>&nbsp;&nbsp;按揭款"+term+termvalue+"万元且"+term1+termvalue1+"万元,&nbsp;应交费用是按揭款的"+money+" ‰"+type1+"("+type3+")</td>";
  else   if (state.equals("8"))//按单价
   str+="<td align=left>&nbsp;&nbsp;单价"+term+termvalue+"元且"+term1+termvalue1+"元,&nbsp;应交费用是总房款款的"+money+" ‰"+type1+"("+type3+")</td>";
  else   if (state.equals("9"))//按单价
   str+="<td align=left>&nbsp;&nbsp;1、套内建筑面积"+term+termvalue+"且套内建筑面积单价"+term1+termvalue1+"或<br>2、建筑面积"+term2+termvalue2+"且建筑面积单价"+term3+termvalue3+"的按"+money+"%&nbsp;否则按"+money1+"%</td>";
  
  
  str+="<td bgcolor='#cfe6eb'>";
  
   if (Cortrol.indexOf("D")>=0){
  str+="<a href='javascript:delTax("+ String.valueOf(id)+")'>删除</a>";
  }
  str+="</td>";
  str+="<td bgcolor='#cfe6eb'>";
  if (Cortrol.indexOf("E")>=0){
  str+="<a href='javascript:editTax("+ String.valueOf(id)+")'>修改</a>";
  }
  str+="</td>";

  str+="</tr>";

 }
 
 TaxRs.close();
 return str;
}
%>
<%
taxname=getbyte1(request.getParameter("ch_name"));
 String code=request.getParameter("code");

 %>
<script language="javascript" src="../public_js/public.js">
</script>
<script>

function delTax(id) {
	if ( confirm("确实想删除该条记录?"))
		openwin("saveTax.jsp?id=" + id+"&ch_name=<%=taxname %>&code=<%=code %>",550,380,150,150);
	}
	
function editTax(id) {
			openwin("TaxPage.jsp?taxname=<%=taxname %>&id=" + id+"&para1=edit",600,580,150,150);
	}
</script>
 
<body>
 <form method="POST" name=frm >
 <center>
    <font class=FontColor><b><font size="3"><br>
    <%=taxname %>计费标准一览表</font></b></font> 
    <table width=90%><tr height="16"><td align="right">
	  <input type=button name=add value="返 回" onclick="window.location='Tax_list.jsp?section=<%=request.getParameter("section") %>'" >
	 <%
 
 
   if (Cortrol==null)Cortrol="";
    if (Cortrol.indexOf("A")>=0){ %>
  <input type=button name=add value="增 加" onclick="openwin('TaxPage.jsp?code=<%=code %>&taxname=<%=taxname %>',700,600,150,100);">
<%} %>
 </td></tr>
 </table>
   
<table border="0" width=90%" CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=listtitle align="center">
    <td width="20%"> </td>
    <td width="60%">
    &nbsp; 计费标准
    
    </td>
	<td><font color=white>删&nbsp;除</font></td>
	<td><font color=white>修&nbsp;改</font></td>
  </tr>
<%jjj=0; %>
 <%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='1' and code="+code)); %>

 <%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='2' and code="+code)); %>
 <%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='3' and code="+code)); %>
 <%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='4' and code="+code)); %>
 <%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='5' and code="+code)); %>
<%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='6' and code="+code)); %>
<%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='7' and code="+code)); %>
<%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='8' and code="+code)); %>
<%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='9' and code="+code)); %>
 

</table>
 </center>
  </form>
</body>

</html>
