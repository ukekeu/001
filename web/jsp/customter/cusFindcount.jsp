<%@ page contentType="text/html;charset=GBK" %> 

 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>

<html>
<head> 
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>�ͻ�����</title>

</head>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>

<script language="javascript" src="../public_js/public.js">
</script>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script>
function fxType(para){
document.cus.ty.value=para;
 
}
 
  
</script>
<body onload="setSelectMad(document.cus.section,'<%=request.getParameter("section") %>');">

<!--DemandAnalysepic.jsp-->
<form name=cus method="post" action=""  > 
 
<p align=center><font size=4 class=FontColor><b>ѡ��ͻ���������</b></font><p>

<table BORDER=0 width="80%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
  <tr > 
 <%@ include file="../public_js/CheckSection.jsp"%>
<%
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
	 String sql="";
      sql="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
      ResultSet rs2=ViewBean.executeQuery(sql);
	  String sec="";
	  String no="";
  %>
    <td   class=roomleft>&nbsp;¥&nbsp;&nbsp;&nbsp;&nbsp;��</td><td  class=roomright>
	&nbsp;<select name="section"  style="width : 104" onchange="document.cus.action='cusFindcount.jsp';document.cus.submit();">
<option>ѡ��¥��</option>
	 <%while (rs2.next()){
	   no=rs2.getString("SerialNo");
	   
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no+"'>"+sec+"</option>");
	  }
	    rs2.close();
     %>	
	</select>
	</td>
	 
   <td  class=roomleft >&nbsp;���ڷ�Χ:</td><td  class=roomright colspan="3">
	
	 &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">  
		 ��
	 &nbsp;<INPUT TYPE=TEXT NAME=Date2 size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date2);return false;">  
		</td></tr>
		<tr><td class=roomleft  >
     		&nbsp;����ָ�꣺
		</td><td  class=roomright colspan="5" >
		<input name="qy" type="checkbox" value="qy"  >�������� 
		  <% sql="select * from CustomerDc where  sectionno='"+request.getParameter("section")+"'";
		 
		     rs2=ViewBean.executeQuery(sql);	
		     int iii=0;
		     while (rs2.next()){
			    String codeName=rs2.getString("codeName") ;
				String code     =rs2.getString("code") ;
		   %>	 
			   <input name="codcename" type="checkbox" value="<%=code %>"  ><%=codeName %> 
			 <%}
			 rs2.close(); %>  
</td>  
</tr> <tr><td class=roomleft>����Դ</td><td class=roomright>&nbsp;<select name="cus_state"><option value=3>���пͻ�</option><option value=2>�ɽ��ͻ�</option><option value=1>δ�ɽ��ͻ�</option></select></td><td class=roomleft>�ͻ���Դ���:</td><td class=roomright>&nbsp;<select name="cus_type"><option value=4>���пͻ�</option><option value=0>����</option><option value=1>����</option></select><!--<option value=2>��Ч</option><option value=3>ת��Ч</option>--></td></tr>
  </table>
 <input type=hidden name=ty >
  <p align=center>	<input type=button name="Count" value="�� ��" onclick="document.cus.action='customerFX.jsp';document.cus.target='_blank';document.cus.submit();">
<input type=button name="Count" value="�� ��" onclick="window.close();">

	</p>  
  </form>



</body>

</html>
