<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>修改销售费用</title>
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
   <%@ include file="../public_js/qx_checke.jsp"%>
  <%
   
   
   /*String year=Date2.substring(0,Date2.indexOf("-"));
String month=Date2.substring(Date2.indexOf("-")+1,Date2.lastIndexOf("-"));
String day=Date2.substring(Date2.lastIndexOf("-")+1);
java.util.Date curDate=new java.util.Date(Integer.parseInt(year)-1900,Integer.parseInt(month)-1,Integer.parseInt(day));
*/

     String deleID=China.getParameter(request,"delID");
	 if (!deleID.equals("")){
	  
	    ViewBean.executeUpdate("delete out_charges where code="+deleID);
	 }
 String no=China.getParameter(request,"no");
  String up=China.getParameter(request,"up");
 
	if (!no.equals("")&&!up.equals("")){
	  int  maxNo = Integer.parseInt(no) ;
	 
	  try{
	   for (int i = 0; i <maxNo; i++) {
	 
		    String code = China.getParameter(request, "code" + i) ;
			String chargesv = China.getParameter(request, "charges" + i) ;
	        String purpose= China.getParameter(request, "purpose" + i) ;
	        String bak= China.getParameter(request, "bak" + i) ;			
			String date= China.getParameter(request, "date" + i) ;	
		 		
			if (!purpose.equals("")){
			  
			 String insertStr = "update "+
			 " out_charges set charges_value="+chargesv+","+
			 " purpose='"+purpose+"',bak='"+bak+"'  where code="+code;
 
			  ViewBean.executeUpdate(insertStr) ;
   			}
	    }
		%>
		<script>
		alert("系统已修改费用");
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
<%
//权限审核
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"market3");
    if (Cortrol==null)Cortrol="";
 %>
<body  onload="" >
<form name="frm" method="post" action="" onsubmit="return Validate(this);">
<input type=hidden name=yearmonth value="<%=request.getParameter("yearmonth")%>">
<input type=hidden name=section value="<%=request.getParameter("section")%>">
 
  <center>
	　
  
  <table width="99%" border="0" CELLSPACING=0 CELLPADDING=0 bordercolor="#000000" class="tablefill"> 
    <tr align="center"  class=listtitle> 
	    <td height="25"> 费用名称 </td>
	   <td> 
        用  途 
      </td>
      <td> 
        计划金额 (万元)
      </td>
	    
       <td> 
        备 注 
      </td>
	 
    </tr>
	<%int i=0;
	  String yeahmonth=China.getParameter(request,"yearmonth");
  	  String section=China.getParameter(request,"section");
	if (!section.equals("")&&!yeahmonth.equals("")){
	  String SQL="select * from out_charges  where out_yeahmonth='"+yeahmonth+"' and section_no='"+section+"' order by charges_name";
  
	  ResultSet aRs = ViewBean.executeQuery(SQL) ;
	  
		while (aRs.next()) {		
		   String code=getbyte(aRs.getString("code"));
		   String charges_name=getbyte(aRs.getString("charges_name"));
		   String charges_value=getbyte(aRs.getString("charges_value"));
		   String purpose=getbyte(aRs.getString("purpose"));
		   String bak=getbyte(aRs.getString("bak"));
   		   String date=getbyte(aRs.getString("out_date"));
		   if (!date.equals(""))date=date.substring(0,10);
	%>
    <tr class=listcontent>  
	<input type=hidden name=code<%=i %> value="<%=code %>">
	<td>&nbsp;<%=charges_name %></td>
    <td > <input type=text name="purpose<%=i %>" size="30"    onkeydown="key(document.frm.charges<%=i %>)" value="<%=purpose %>" ></td> 
   <td > <input type=text name="charges<%=i %>" size="10"  value="<%=charges_value %>" OnChange="check(document.frm.charges<%=i%>);" onkeydown="key(document.frm.bak<%=i %>)"  ></td> 

 
<td > <input type=text name="bak<%=i %>" size="15" value="<%=bak %>"   onkeydown="key(document.frm.purpose<%=i+1 %>)"  ></td> 
    
    </tr>
	<%i++;
		}
		aRs.close();
		}
		
		if (yeahmonth.equals(""))yeahmonth=String.valueOf(CurYear)+"-"+String.valueOf(CurMonth);
	%>
	   <input type=hidden name=delID >
	    <input type=hidden name=up >
  </table>
  <input type=hidden name=no value="<%=i %>">

	<br>
	
  <table width="90%" border="0" CELLSPACING=0 CELLPADDING=0>
  <tr><td   align="center"><% if (Cortrol.indexOf("E")>=0){ %><input type=button value=" 提 交 " name=save onclick="document.frm.up.value='ok';document.frm.submit();">&nbsp;<%} %><input type="button" value=" 退 出" onclick="window.close();"></td></tr>
  </table>
 
  
  </center>
</form>
</body>
</html>
