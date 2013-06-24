<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
    <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<jsp:useBean id="FormtD3" scope="page" class="test.PieChart"/>  
 
<script language="javascript" src="../public_js/public.js"></script>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>市场调查分析</title>
</head>

<body topmargin="0">
<script language="JavaScript">
<!--
 function ok(x){
	 document.all.photo.value=x;
	 form1.action="list_charges_plan.jsp?type=5&ch_type=3";
	 form1.submit();
 }
//-->
</script>
<%  
   String section=getbyte1(request.getParameter("section"));
   String Count=China.getParameter(request,"Count");
   String menusel=China.getParameter(request,"menusel");
    String qy=China.getParameter(request,"qy");
	String cus_state=China.getParameter(request,"cus_state");
	String dcType="";
	if (cus_state.equals("2"))dcType=" and type=1 ";
	else if (cus_state.equals("1"))dcType=" and type=0 ";
	
    if(menusel.equals("")) menusel="0"; %>
 <%@ include file="../public_js/CheckSection.jsp"%>
 <form name=frm>
  <input type=hidden name="menusel" value="<%=menusel %>">
 <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2"  >
  <tr> 
    <td  class="<%if(menusel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.menusel.value=0;findSub('DcViewCode.jsp');""><font color='<%if(menusel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>问卷定义</a>
	</td>
     <td  class="<%if(menusel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.menusel.value=1;findSub('marketFX.jsp');""><font color='<%if(menusel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>问卷分析</a>
	</td>
 
	</tr>
</table>
<script>
function findSub(para){
   document.frm.action=para+"?Search=b&Find=b";
   document.frm.submit();


}
</script>
  <table width=100% border="0"><tr height="16"  ><td align="left">楼盘：<select name="section" onchange="document.frm.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
		 
		
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
	 </td>
	   <td    >&nbsp;来访(电)日期范围: 
	
	 &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=10 value="<%=getbyte(request.getParameter("Date1")) %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">  
		 至
	 &nbsp;<INPUT TYPE=TEXT NAME=Date2 size=10 value="<%=getbyte(request.getParameter("Date2")) %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date2);return false;">  
		</td><td  > &nbsp;数据源 &nbsp;<select name="cus_state" onchange="document.frm.submit();"><option value=2>成交客户</option><option value=1>未成交客户</option></select></td>
		<td><input type=submit name="Count" value="分 析" onclick="document.frm.submit();"></td>
		
		</tr>
		</table>
		<table>
		<tr><td class=roomleft    >
     		&nbsp;分析指标：
		</td><td  class=roomright colspan="5" >
		<input name="qy" type="checkbox" value="qy"  >来自区域 
		  <% String sql="select * from CustomerDc where  sectionno='"+request.getParameter("section")+"' "+dcType;
		 
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

</tr> <tr></tr>
  </table>
	 
	 
	 </tr></table>
<%
 
  SecNo=section;//getbyte1(request.getParameter("SecNo")); 
 if (!Count.equals("")){
 String photo=request.getParameter("cus_state");
String Date1 =request.getParameter("Date1");
String Date2 =request.getParameter("Date2");
String dateWHERE="";

if (!Date1.equals("")&&!Date2.equals(""))
  dateWHERE=" and convert(char(10),visit_date,120) >='"+Date1+"' and convert(char(10),visit_date,120)<='"+Date2+"'";
else if (!Date1.equals("")&&Date2.equals(""))  
  dateWHERE=" and  convert(char(10),visit_date,120) >='"+Date1+"'";
else if (Date1.equals("")&&!Date2.equals(""))  	
   dateWHERE=" and  convert(char(10),visit_date,120) <='"+Date2+"'";
 
 
 
 String[] codcenames=request.getParameterValues("codcename");
String codcename="";
if (codcenames!=null){
   for (int aa=0;aa<codcenames.length;aa++){
    if (codcename.equals(""))codcename=codcenames[aa];
	else codcename+=","+codcenames[aa];
  }
}
try{
     sql="";
   if (photo.equals("2"))
      sql="select count(*) ,cus_name from customer a where a.serialno  in (select customer from order_contract where  Section='"+SecNo+"' and  state<>3) "+dateWHERE+" and  a. Section='"+SecNo+"'   group by cus_name";
   else  if (photo.equals("3"))
      sql="select count(*),cus_name from customer a  where    a. Section='"+SecNo+"'   "+dateWHERE+" group by cus_name";
    else  if (photo.equals("1"))
	  sql="select count(*),cus_name from customer a  where a.serialno not in (select customer from order_contract where  Section='"+SecNo+"'    and  state<>3)  "+dateWHERE+" and  a. Section='"+SecNo+"'  group by cus_name";
   ResultSet rs=ViewBean.executeQuery(sql); 
     int  num=0;
	 String projectname="";
	while  (rs.next())
	
	{num++;
	 
	}
	rs.close();
	 
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;分析客户数据:"+String.valueOf(num)+"</font></p>");
	
	  Calendar calendar1 = Calendar.getInstance();
 
  String filename = String.valueOf(calendar1.getTimeInMillis());	
  String messtitle=" ",pic="";
	if (!qy.equals("")){
	   messtitle="客户来自区域分析";
   if (photo.equals("3")){
   sql="select region nam,count(*) num from customer a where section='"+SecNo+"' "+dateWHERE+" group by  region";
   }else    if (photo.equals("2")){ 
   sql="select region nam,count(*) num from customer where serialno in (select customer from order_contract where state<>3 and section='"+SecNo+"'  "+dateWHERE+" ) and  section='"+SecNo+"' group by  region";
   
 }else    if (photo.equals("1")){  
   sql="select region nam,count(*) num from customer where serialno not in (select customer from order_contract where state<>3 and section='"+SecNo+"'  "+dateWHERE+" )  and section='"+SecNo+"' group by  region";
   
   }
 
     pic= FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/yxfxpic"+filename+".jpg",sql,messtitle);  
  if (!pic.equals(""))
    out.print("<img src='../picture/yxfxpic"+filename+".jpg'>");
	}
	 sql="select  code,codename from CustomerDc  where sectionno='"+SecNo+"' ";
     if (!codcename.equals(""))
     sql+=" and code in ("+codcename+")";
	 
	 
     rs=ViewBean.executeQuery(sql);
   while (rs.next()){
       sql="select b.codevalue nam,count(*) num from customer_xq a ,CustomerDcValue b,customer c where ";
	   sql+="a.xq_code=b.code and c.code=a.customer and b.dccode="+rs.getString("code")+" and c.Section='"+SecNo+"'";
	    if (photo.equals("2")){
		sql+=" and c.serialno in (select customer from Order_Contract where state<>3 and section='"+SecNo+"')";
		
		}
		sql+=dateWHERE;
		
	   sql+=" group by b.codevalue  ";
	 
  Calendar calendar = Calendar.getInstance();
 
    filename = String.valueOf(calendar.getTimeInMillis());	
    messtitle=rs.getString("codename")+"市场调查分析";
 
     pic= FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/yxfxpic"+filename+".jpg",sql,messtitle);  
  if (!pic.equals(""))
    out.print("<img src='../picture/yxfxpic"+filename+".jpg'>");
 
 }
 rs.close();
 }catch(Exception s){out.print(s+sql);}
}
 %>
 <script> setSelectMad(document.frm.section,'<%=section %>');
 
 setSelectMad(document.frm.cus_state,'<%=request.getParameter("cus_state") %>');
 
 </script>
 
 </form>
</body>
</html>