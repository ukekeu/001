<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>付款方案管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script src="js/mad.js"> </script>
<link rel=stylesheet href="../class/mad.css" >
<script language="javascript" src="../public_js/public.js"></script>
<script>
    var ID="";
	function Dele() {
		if (ID==""){alert("请选折想删除的方案");return false;}
		else {if ( confirm("确实想删除该条记录?"))
			window.location = "SavePayment.jsp?id=" + ID+ "&payment_oper=dele&section="+document.form1.section.value;
		}
	}
	function Choose(para){
       ID=para;
	}
	function EditDate(){
		if (ID==""){alert("请选择需修改的方案");return false;}
		openwin2("PaymentDetail.jsp?payment_status=modi&id="+ID+"&no="+document.form1.aa.value ,480,450,250,50);

	}
</script>

</head>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
  <jsp:useBean id = "paymentListBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/CheckSection.jsp"%>

<%@ include file="../public_js/qx_checke.jsp"%>
<body >
 
      <p align="center" class=FontColor><font size=3 ><b>付款方案一览表</b></font></p>
  <%
//权限审核
String Cortrol=checke_qx(paymentListBean,(String)session.getAttribute("loginid"),"B011");
 %>
   <center>
   <form name=form1>
  <table width=90% border=0><tr height="16" bgcolor="#EAEAEA"><td align="right">
   <%if (Cortrol.indexOf("A")>=0){ %><input type=button value="增 加" title="添加付款方案"  onClick="openwin2('PaymentDetail.jsp?no='+document.form1.aa.value,480,420,250,100)">
   <input type=button value="复 制" title="复制付款方案"  onClick="openwin1('CopayPaymentDetail.jsp',480,420,250,200)">
   <%}
   if (Cortrol.indexOf("E")>=0){ %><input type=button value="修改" title="修改选中的付款方案" onclick="EditDate();" ><%}
   if (Cortrol.indexOf("D")>=0){ %><input type=button value="删 除" title="删除选中的付款方案"  onclick="Dele();"><%}%>
  
  </td></tr></table>
  楼盘：<select name="section" onchange="document.form1.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=paymentListBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (getbyte1(request.getParameter("section")).equals(""))
  	    {if (!no1.equals(""))defaultNo=no1;}
	  else defaultNo=getbyte1(request.getParameter("section"));
	    rs2.close();
	
     %> </select>
	 
   <table width=90% border=0 ><tr height="3"><td></td></tr></table>   
<table width="90%" border=0 CELLSPACING=1 CELLPADDING=1 ALIGN=center>

  <tr class=TXTColor ALIGN=center> 
   
    <td  > 
      付款名称
    </td>
	  <td  > 
     付款期数
    </td>
    <td  > 
      执行日期
    </td>
    <td  > 
     结束日期
    </td>
    <td  > 
     折扣
    </td>
   <td  > 
     状态
    </td>

  </tr>
   <%
  	int id = 0;
	String SQL = "UPDATE Payment SET TYPE=1 WHERE datediff(d,getdate(),EnDate) <0";
	 paymentListBean.executeUpdate(SQL);
	  SQL = "UPDATE Payment SET TYPE=0 WHERE datediff(d,getdate(),EnDate) >0";
	 paymentListBean.executeUpdate(SQL);
	String paymentStr = "select *,datediff(d,getdate(),EnDate) cudate from Payment where seccoe='"+defaultNo+"'";
	ResultSet paymentRS = paymentListBean.executeQuery(paymentStr);
 
	int hasRecord = 0;
	int i=0;
	while (paymentRS.next()) {
	i++;
		id = paymentRS.getInt("ID");
		String payName =getbyte(paymentRS.getString("PayName"));
		int paynum=paymentRS.getInt("num");
		String Sdate =paymentRS.getDate("ExDate").toString();
		String Edate=paymentRS.getDate("EnDate").toString();
    	int Currdate=paymentRS.getInt("cudate");
		int type=paymentRS.getInt("type");
		String prePay=getbyte(paymentRS.getString("prePay"));
		String seccoe=getbyte(paymentRS.getString("seccoe"));
	 %>
   <tr id=TR<%=i %> <%if (Currdate>0){ %>class=listcontent <%}else{ %>  bgcolor='#EAECEC' <%} %>  align="center"   Onclick="Choose(<%= id %>);changeclass1(this,'clickbg','listcontent');"  onmouseover="mout(this) ;"> 
   <a href="javascript:detail('<%=id %>')" >
	<td  > <%= payName %> </td>
	<td  > <%=paynum%> </td>
    <td  ><%= Sdate %></td>
    <td  ><%= Edate %></td>
    <td  ><%= paymentRS.getString("Discont") %></td>
    </a>
 <td  ><% if (Currdate>0){out.print("有效");}else{out.print("失效");} %></td>
  </tr>
 
  <tr ><td  colspan="7">
  <div id="detail<%=id %>" style="display:none">
   <jsp:include page="PayListView.jsp" flush="true">
     <jsp:param name="code" value="<%=id%>"/>
	 <jsp:param name="Cortrol" value="<%=Cortrol%>"/> 
	  <jsp:param name="paynum" value="<%=paynum%>"/>
     <jsp:param name="payname" value="<%=payName%>"/>
	  <jsp:param name="prePay" value="<%=prePay%>"/>
	 <jsp:param name="seccoe" value="<%=seccoe%>"/>
	  
  </jsp:include>
 
  </div>
  </td></tr>
 <%}
  paymentRS.close();%>
  </table>
  <input type=hidden name=aa value="<%=defaultNo %>">
</form>
<script>
 setSelectMad(document.form1.section,'<%=defaultNo%>');

</script>
   </center>
</body>
</html>
