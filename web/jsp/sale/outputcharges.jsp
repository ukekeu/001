<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>实际支出费用</title>
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
			if (!date.equals("")&&!chargesn.equals("")&&Integer.parseInt(chargesv)>0){
			  
			 String insertStr = "insert into "+
			 " out_charges(charges_name,charges_value, out_yeahmonth,"+
			 " section_no,purpose,bak,out_date) values('" +chargesn+"',"+chargesv+",'"+
			 yeahmonth+"','"+section+"','"+purpose+"','"+bak+"','"+date+"')";
			  ViewBean.executeUpdate(insertStr) ;
   			}
	    }
		%>
		<script>
		alert("系统已增加费用");
		window.location="chargeslist.jsp?section=<%=section %>&sel=2&yearmonth=<%=yeahmonth %>";
		</script>
		<%
		}catch(Exception s){}
	} 
   
   /*String year=Date2.substring(0,Date2.indexOf("-"));
String month=Date2.substring(Date2.indexOf("-")+1,Date2.lastIndexOf("-"));
String day=Date2.substring(Date2.lastIndexOf("-")+1);
java.util.Date curDate=new java.util.Date(Integer.parseInt(year)-1900,Integer.parseInt(month)-1,Integer.parseInt(day));
*/
java.util.Date curDate=new java.util.Date();

      int CurYear=curDate.getYear()+1900;
      int CurMonth=curDate.getMonth()+1;
      int CurDay=curDate.getDate(); 
	   String sel=(String)request.getParameter("sel");
  
   if(sel==null) sel="1";	
%>

<body  onload="" >
<form name="frm" method="post" action="" onsubmit="return Validate(this);">
<input type=hidden name=sel value="<%=sel%>">
  <center>
	 <table width=95% border="0"><tr height="16" bgcolor="#EAEAEA"><td align="left">楼盘：<select name="section" > 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1 ="select SerialNo,Name from CRM_Project "+FindWhere;

 
	  ResultSet rs2=ViewBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
	  String cusno="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
	 </td><td>年月:<select name="yearmonth">
	 <%for(int i=2000;i<2010;i++){ %>
	   	 <%for(int j=1;j<=12;j++){ %>
		 <option value="<%=String.valueOf(i)+"-"+String.valueOf(j) %>"><%=String.valueOf(i)+"年"+String.valueOf(j)+"月" %></option>
      <%}
	  
	  } %></select></td></tr></table>
	   <BR>
   <table width="176" border="0" cellspacing="0" cellpadding="0" class="L2">
   <tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;document.frm.action='inputcharges.jsp';document.frm.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>费用计划</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;document.frm.action='chargeslist.jsp';document.frm.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>实际支出</font></a>
	</td>
	</tr>
	</table>
  <table width="95%" border="0" CELLSPACING=0 CELLPADDING=0 bordercolor="#000000" class="tablefill"> 
    <tr align="center"  class=listtitle> 
	    <td height="25"> 费用名称 </td>
	   <td> 
        用  途 
      </td>
      <td> 
        支付金额 
      </td>
	   <td> 
        支付日期
      </td>
       <td> 
        备 注 
      </td>
    </tr>
	<%int i=0;
	String SQL="select * from CODE where TYPE='CH'";
	ResultSet aRs = ViewBean.executeQuery(SQL) ;
		while (aRs.next()) {		
		   String codename=getbyte(aRs.getString("CODENAME"));
		   
		   
	%>
    <tr class=listcontent>  
	<input type=hidden name=chargesn<%=i %> value="<%=codename %>">
	<td>&nbsp;<%=codename %></td>
     <td > <input type=text name="purpose<%=i %>" size="30" value=0   onkeydown="key(document.frm.charges<%=i %>)"  ></td> 
   <td > <input type=text name="charges<%=i %>" size="10" value=0 OnChange="check(document.frm.charges<%=i%>);" onkeydown="key(document.frm.date<%=i %>)"  >元</td> 

<td > <input type=text name="date<%=i %>" size="10" value=0   onkeydown="key(document.frm.bak<%=i %>)"  ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date<%=i %>);return false;"></td> 
<td > <input type=text name="bak<%=i %>" size="15" value=0   onkeydown="key(document.frm.purpose<%=i+1 %>)"  ></td> 
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
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"S010");
    if (Cortrol==null)Cortrol="";
 %>
  <table width="90%" border="0" CELLSPACING=0 CELLPADDING=0>
  <tr><td   align="center"><% if (Cortrol.indexOf("A")>=0){ %><input type=button value=" 提 交 " name=save onclick="document.frm.up.value='ok';document.frm.submit();">&nbsp;<%} %><input type="Reset" value=" 取 消"></td></tr>
  </table>
    <script>
 setSelectMad(document.frm.yearmonth,'<%=String.valueOf(CurYear)+"-"+String.valueOf(CurMonth) %>');

setSelectMad(document.frm.section,'<%=request.getParameter("section") %>');

function aa(){
  if (document.frm.section.value==""){alert("请选择楼盘");return false;}
  document.frm.submit();

}
</script>
  
  </center>
</form>
</body>
</html>

