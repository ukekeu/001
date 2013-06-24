<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="vemBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>客户房看分析</title>
<script language="JavaScript" src='../public_js/basal.js'></script>


</head>
 

<body>
            
  <p align="center"><b><font size="3" color="#000080"> 客户房看分析结果 </font></b></p>
 <table width="100%" cellspacing="1" cellpadding="2">


<%  
    String SecNo=request.getParameter("SecNo");
	 String Loft=request.getParameter("Loft");
    String Date1 = request.getParameter("Date1");
    String Date2 = request.getParameter("Date2");
	if (Date1!=null){
	String SQL="SELECT count(*) dd FROM KFRECO WHERE SECNO='"+SecNo+"' and reco_date between  '"+Date1+"' and '"+Date2+"'";
	float sumnum=0;
    ResultSet rs=ViewBean.executeQuery(SQL); 
	if (rs.next()){ sumnum=rs.getFloat("dd");}
	rs.close();
	%>
	  <tr><td height=16  >&nbsp;</td><td>&nbsp;</td>
<td>&nbsp;<img src="../images/line.gif" height=16  width="<%=sumnum/sumnum*200%>"><%=FormtD.getFloat2(sumnum,0) %>人</td>
	

</tr> 
	<%
	SQL="SELECT room_code,count(*) dd FROM KFRECO WHERE SECNO='"+SecNo+"' and reco_date between  '"+Date1+"' and '"+Date2+"' group by room_code";
      rs=ViewBean.executeQuery(SQL); 
	while (rs.next()){ 
     float  dd=rs.getFloat("dd"); 
	  String room_code=rs.getString("room_code");
	  ResultSet rs1=vemBean.executeQuery("select count(*) num from order_contract where sectionname+loft+room_no='"+room_code+"'"); 
      int ddd=0;
	  if (rs1.next())ddd=rs1.getInt("num");
	  rs1.close();
	   rs1=vemBean.executeQuery("select context from KFRECO where room_code='"+room_code+"'"); 
      String reco="";
	  int i=1;
	  while (rs1.next()){reco+=String.valueOf(i++)+":"+rs1.getString("context")+"<br>";}
	  rs1.close();
	  
 %>
  <tr  bgcolor="#EAEAEA"><td height=16 >&nbsp;<%=room_code %>&nbsp;&nbsp;<%if (ddd>0){out.print("已售");}else{out.print("未售");} %>&nbsp; </td><td  ><%=reco %></td> 
<td >&nbsp;<img src="../images/line.gif" height=16  width="<%=dd/sumnum*200%>"><%=FormtD.getFloat2(dd*1.0/(sumnum)*100,2) %>%(<%=FormtD.getFloat2(dd,0) %>人)</td>
	

</tr>   
<%} 
}%>     
					 
				</table>
</form>     
       
       
       
</body>       
</html>       
