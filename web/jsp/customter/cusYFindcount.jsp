<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,java.util.Date" %>
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
<%Date currDate1=new Date();

  int year1=currDate1.getYear()+1900;
  int yy=0;
  int month=currDate1.getMonth()+1;
  int mm=0;
  int day=currDate1.getDate();
  int crD=1;
  String tdate=String.valueOf(currDate1.getYear()+1900)+"-"+ String.valueOf(currDate1.getMonth()+1)+"-"+String.valueOf(currDate1.getDate());
  %>

 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script>
function fxType(para){
document.cus.ty.value=para;
 
}
function fx(){
 
   
  document.cus.action="customerYFX.jsp";
 
	
 document.cus.submit();
}

</script>
<body>

<!--DemandAnalysepic.jsp-->
<form name=cus method="post" action="" target="_blank"> 
<input type=hidden name=section value="<%= request.getParameter("section") %>">

<p align=center><font size=4 class=FontColor><b>ѡ��ͻ���������</b></font><p>

<table BORDER=0 width="100%" class=parent  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
   <tr>
   <td class=roomleft width="10%" >&nbsp;�Ϲ�״̬</td><td  class=roomright>
	
	 &nbsp;<select name=datastate >  <option value=1>����</option>
	  <option value=2>�Ϲ�</option>
	  <option value=3>δ�Ϲ�</option>
	 </select >
	 </td></td>  
		</td><td class=roomleft  width="10%">&nbsp;��ʼ����:</td><td  class=roomright>
	
	 &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;"></td></td>  
		</td>
			 
			<td class=roomleft  width="10%">&nbsp;��������:</td><td  class=roomright>	
	 &nbsp;<INPUT TYPE=TEXT NAME=Date2 size=10 value="<%=tdate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date2);return false;"><font color=red>*</font></td></td>  
		</td></tr>
		<tr><td class=roomleft width="10%"  >
     		&nbsp;����ָ�� 
		</td><td  class=roomright colspan="5" >
		  <%String sql="select * from CustomerDc where sectionno='"+request.getParameter("section")+"'";
		    ResultSet rs2=ViewBean.executeQuery(sql);	
		     int iii=0;
		     while (rs2.next()){
			    String codeName=rs2.getString("codeName") ;
				String code     =rs2.getString("code") ;
		   %>	 
			   <input name="codcename" type="checkbox" value="<%=code %>"  ><%=codeName %> 
			 <%}
			 rs2.close(); %>  
       </td>  
 
</tr>
<!--
<tr><td class=roomleft width="10%"  >&nbsp;ͼ������</td><td class=roomright colspan="5">&nbsp;<select name="photo"><option value=3>��ͼ</option><option value=2>ֱ����״ͼ</option></select></td></tr>
-->   </table>
 <input type=hidden name=ty >
  <p align=center>	<input type=button name="Count" value="�� ��" onclick="fx();">
<input type=button name="Count" value="��  ��" OnClick="window.close();">

	</p>  
  </form> 

</body>

</html>
