<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>费用支出月计划</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<LINK href="../class/mad.css" rel=stylesheet>
<script src="js/mad.js"> </script>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*,common.*,java.util.*" %>
<jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>

  <%
    String yeahmonth=China.getParameter(request,"yearmonth");
    String section=China.getParameter(request,"section");
    String no=China.getParameter(request,"no");
	if (!no.equals("")){
	  int  maxNo = Integer.parseInt(no) ;
	
	  try{
	   for (int i = 0; i <maxNo; i++) {
	 
		    String chargesn = China.getParameter(request, "chargesn" + i) ;
			String chargesv = China.getParameter(request, "charges" + i) ;
	        String purpose= China.getParameter(request, "purpose" + i) ;
	        String bak= China.getParameter(request, "bak" + i) ;			
			String date= China.getParameter(request, "date" + i) ;	
			 
			if (!chargesn.equals("")&&Float.parseFloat(chargesv)>0){
			 
			 String insertStr = "insert into "+
			 " out_charges(charges_name,charges_value, out_yeahmonth,"+
			 " section_no,purpose,bak) values('" +chargesn+"',"+chargesv+",'"+
			 yeahmonth+"','"+section+"','"+purpose+"','"+bak+"')";
			 
			  ViewBean.executeUpdate(insertStr) ;
   			}
	    }
		%>
		<script>
		alert("系统已增加费用");
		opener.window.document.frm.submit();
		window.close();
		</script>
		<%
		}catch(Exception s){}
	} 
    
     java.util.Date curDate=new java.util.Date();

      int CurYear=curDate.getYear()+1900;
      int CurMonth=curDate.getMonth()+1;
      int CurDay=curDate.getDate(); 
	 
%>

<body  onload="" >
<form name="frm" method="post" action="" onsubmit="return Validate(this);">
 <input type=hidden name=yeahmonth value="<%=yeahmonth %>">
   <center>
  
  <table width="95%" border="0" CELLSPACING=0 CELLPADDING=0 bordercolor="#000000" class="tablefill"> 
    <tr align="center"  class=listtitle> 
	    <td height="25"> 费用名称 </td>
	   <td> 
        用  途 
      </td>
      <td> 
        计划金额(万元) 
      </td>
	  
       <td> 
        备 注 
      </td>
    </tr>
	<%int i=0;
	String SQL="select * from charges_set where sectionno='"+section+"'";
	ResultSet aRs = ViewBean.executeQuery(SQL) ;
		while (aRs.next()) {		
		   String codename=getbyte(aRs.getString("chargesname"));
		   
		   
	%>
    <tr class=listcontent>  
	<input type=hidden name=chargesn<%=i %> value="<%=codename %>">
	<td>&nbsp;<%=codename %></td>
     <td > <input type=text name="purpose<%=i %>" size="30"   onkeydown="key(document.frm.charges<%=i %>)"  ></td> 
   <td > <input type=text name="charges<%=i %>" size="10" value=0 OnChange="check(document.frm.charges<%=i%>);" onkeydown="key(document.frm.bak<%=i %>)"  > </td> 

 
<td > <input type=text name="bak<%=i %>" size="30"    onkeydown="key(document.frm.purpose<%=i+1 %>)"  ></td> 
    </tr>
	<%i++;
		}
		aRs.close();
	%>
	</table>
	<input type=hidden name=no value="<%=i %>">
	<br>
   <%@ include file="../public_js/qx_checke.jsp"%>
	<br>
	<%
//权限审核
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"JC006");
 Cortrol+=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"market3");

    if (Cortrol==null)Cortrol="";
 %>
  <table width="90%" border="0" CELLSPACING=0 CELLPADDING=0>
  <tr><td   align="center"><% if (Cortrol.indexOf("A")>=0){ %><input type=button value=" 提 交 " name=save onclick="document.frm.submit();">&nbsp;<%} %><input type="button" value=" 退 出" onclick="window.close();"></td></tr>
  </table> 
  
  </center>
</form>
</body>
</html>

