<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>销售费用列表</title>
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
			String chargesv = China.getParameter(request, "charges" + i) ;
	        String purpose= China.getParameter(request, "purpose" + i) ;
	        String bak= China.getParameter(request, "bak" + i) ;			
			String date= China.getParameter(request, "date" + i) ;	
		 		
			if (!date.equals("")){
			  
			 String insertStr = "update "+
			 " out_charges set charges_value="+chargesv+","+
			 " purpose='"+purpose+"',bak='"+bak+"',out_date='"+date+"' where code="+code;
 
			  ViewBean.executeUpdate(insertStr) ;
   			}
	    }
		%>
		<script>
		alert("系统已增加费用");
		
		</script>
		<%
		}catch(Exception s){}
	} 
     java.util.Date curDate=new java.util.Date();
      int CurYear=curDate.getYear()+1900;
      int CurMonth=curDate.getMonth()+1;
      int CurDay=curDate.getDate(); 
	   String sel=(String)request.getParameter("sel");
  
   if(sel==null) sel="1";	
   
%>
<%
//权限审核
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"market3");
 Cortrol+=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"JC");
    if (Cortrol==null)Cortrol="";
	
	  String yeahmonth=China.getParameter(request,"yearmonth");
	  String section=China.getParameter(request,"section");
	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
	
      String sql1 ="select SerialNo,Name from CRM_Project "+FindWhere;
     if (!yeahmonth.equals("")&&CurYear!=Integer.parseInt(yeahmonth))
	 { CurMonth=12;
	 CurYear=Integer.parseInt(yeahmonth);
	 }
	 
	 
 %>
<body  topmargin="0">
<form name="frm" method="post" action="" onsubmit="return Validate(this);">

<input type=hidden name=sel value="<%=sel%>">
 
	  <table width="260" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;document.frm.no.value='';document.frm.action='chargeslist.jsp';document.frm.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>费用计划</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;document.frm.action='charges_view.jsp';document.frm.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>实际支出</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;document.frm.action='charges_name_list.jsp';document.frm.submit();"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>费用设置</font></a>
	</td>
	
	</tr>
	</table>
	 <table width=96% border="0"><tr height="16" bgcolor="#EAEAEA"><td align="left">楼盘：<select name="section" onchange="document.frm.submit();"> 
   <option>请选择楼盘名称</option>
<%  
    
 
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
	 </td><td>年月:<select name="yearmonth"  onchange="document.frm.submit();">
	 <%for(int i=2005;i<2015;i++){ %>
	     <option value="<%=String.valueOf(i) %>"><%=String.valueOf(i)+"年"  %></option>
       
	  <% 
	  
	  } %></select></td><td align="right"><input type=button name=prin value="增加计划" onclick="openwin('inputcharges.jsp?section=<%=section %>&yearmonth='+document.frm.yearmonth.value,800,250,100,100);">&nbsp;&nbsp;<input type=button name=prin value=" 费用分析表" onclick="if (document.frm.section.value!='')openwin('print_sale_view_charges.jsp?section=<%=section %>&yearmonth=<%=CurYear %>');"></td></tr></table>
	   	   <BR>
  
  <table width="96%" border="0" CELLSPACING=0 CELLPADDING=0 bordercolor="#000000" class="tablefill"> 
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
	  <td width="100">
        操作 
      </td>
    </tr>
	<%
	 int i=0;
	if (!section.equals("")&&!yeahmonth.equals("")){
	  String SQL="select * from out_charges  where  substring(out_yeahmonth,0,5)=substring('"+yeahmonth+"',0,5) and section_no='"+section+"' order by charges_name";
 
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
    <tr class=listcontent align="center">  
	<input type=hidden name=code<%=i %> value="<%=code %>">
	<td>&nbsp;<%=charges_name %></td>
    <td > <%=purpose %>&nbsp; </td> 
   <td > <%=charges_value %></td> 

 
<td >&nbsp;<%=bak %></td> 
   <td width="100">&nbsp;&nbsp;<% if (Cortrol.indexOf("D")>=0){ %><a href="#" onclick="if (confirm('确认删除吗?')){document.frm.delID.value='<%=code %>';document.frm.submit();}">删除</a><%} %>&nbsp;&nbsp;<% if (Cortrol.indexOf("E")>=0){ %><a href="#" onclick="openwin('modicharges.jsp?section=<%=section %>&yearmonth=<%=yeahmonth %>',600,300,100,100);">修改</a><%} %></td> 

    </tr>
	<%i++;
		}
		aRs.close();
		}
		 
	 
		
		%>
	   <input type=hidden name=delID >
	    <input type=hidden name=up >
  </table>
  <input type=hidden name=no value="<%=i %>">

	 
  <script>
    setSelectMad(document.frm.yearmonth,'<%=String.valueOf(CurYear)%>');
    setSelectMad(document.frm.section,'<%=request.getParameter("section") %>');


</script>
  
  </center>
</form>
</body>
</html>
