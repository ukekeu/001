<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>����֧���Ǽ�</title>
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
		 
			String factcharges= China.getParameter(request, "factcharges" + i) ;
	    		
			String date= China.getParameter(request, "date" + i) ;	
		 	String bak= China.getParameter(request, "bak" + i) ;	
		 		
			if (!date.equals("")){
			  
			 String insertStr = "insert into fact_out_charges(out_charges,fact_value,out_date,bak) select "+
			 code+","+factcharges+" ,out_date='"+date+"','"+bak+"'";
 
			  ViewBean.executeUpdate(insertStr) ;
   			}
	    }
		%>
		<script>
		alert("ϵͳ����֧��");
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
//Ȩ�����
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"market3");
    if (Cortrol==null)Cortrol="";
 %>
<body  onload="" >
<form name="frm" method="post" action="" onsubmit="return Validate(this);">
<input type=hidden name=yearmonth value="<%=request.getParameter("yearmonth")%>">
<input type=hidden name=section value="<%=request.getParameter("section")%>">
 
  <center>
	��
  
  <table width="99%" border="0" CELLSPACING=0 CELLPADDING=0 bordercolor="#000000" class="tablefill"> 
    <tr align="center"  class=listtitle> 
	    <td height="25"> �������� </td>
	   <td> 
        ��  ; 
      </td>
      <td> 
        �ƻ����(��Ԫ) 
      </td>
	     <td> 
        ֧�����(��Ԫ) 
      </td>
	   <td> 
        ֧������ 
      </td>
       <td> 
        �� ע 
      </td>
	 
    </tr>
	<%int i=0;
	  String yeahmonth=China.getParameter(request,"yearmonth");
  	  String section=China.getParameter(request,"section");
	  String codes=China.getParameter(request,"code");
	  
	if (!section.equals("")&&!yeahmonth.equals("")){
	  String SQL="select * from out_charges  where   substring(out_yeahmonth,0,5)=substring('"+yeahmonth+"',0,5) and section_no='"+section+"' and code="+codes+" order by charges_name";
  
	  ResultSet aRs = ViewBean.executeQuery(SQL) ;
	  
		while (aRs.next()) {		
		   String code=getbyte(aRs.getString("code"));
		   String charges_name=getbyte(aRs.getString("charges_name"));
		   String charges_value=getbyte(aRs.getString("charges_value"));
		   
		   String purpose=getbyte(aRs.getString("purpose"));
		   String bak=getbyte(aRs.getString("bak"));
   		 
	%>
    <tr class=listcontent>  
	<input type=hidden name=code<%=i %> value="<%=code %>">
	<td>&nbsp;<%=charges_name %></td>
    <td > <%=purpose %>&nbsp;</td> 
   <td > <%=charges_value %>Ԫ</td> 
<td > <input type=text name="factcharges<%=i %>" size="10" value="0" OnChange="check(document.frm.factcharges<%=i%>);" onkeydown="key(document.frm.date<%=i %>)"  ></td> 

 <td > <input type=text name="date<%=i %>" size="10"   value=""   onkeydown="key(document.frm.factcharges<%=i+1 %>)"  ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date<%=i %>);return false;"></td> 
 
<td ><input type=text name="bak<%=i %>" size="10"   value="<%=bak %>"> </td> 
    
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
  <tr><td   align="center"><% if (Cortrol.indexOf("A")>=0){ %><input type=button value=" �� �� " name=save onclick="document.frm.up.value='ok';document.frm.submit();">&nbsp;<%} %><input type="button" value=" �� ��" onclick="window.close();"></td></tr>
  </table>
 
  
  </center>
</form>
</body>
</html>
