<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>查询客户资料</title>

</head>


<body>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>


<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%String cons=request.getParameter("condtion");
%>
<form name=cus method="post" action="visitcusview.jsp?condtion=<%=cons%>&param=<%=request.getParameter("param") %>">

<p align=center><font size=3 color=#215CAA>请选择查询条件</font><p>

<table border="0" ALIGN=center width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3>

  
  <tr >
	<%@ include file="../public_js/CheckSection.jsp"%>
<%

     if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
				
      String sql="select SerialNo,Name FROM crm_project where SerialNo in("+SectionS+")";
      ResultSet rs2=ViewBean.executeQuery(sql);
	  String sec="";
	  String no="";
  %>
    <td width="10%"  class=roomleft>楼盘</td><td width=30%  class=roomright >
	<select name="section"  style="width : 120">
    <option></option>
	 <%while (rs2.next()){
	   no=rs2.getString("SerialNo");
	   
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no+"'>"+sec+"</option>");
	  }
	    rs2.close();
     %>	
	</select>
	</td>
	</tr>
	<tr >
	<td width="10%"  class=roomleft >客户姓名</td><td width=30%  class=roomright><input type=text name=cusname size=15></td>
	</tr><tr >
    <td width="10%"  class=roomleft>年龄:	</td><td width=30%  class=roomright> 
	<select name=condi> 
	<option value=""></option>
	<option value="=">=</option>
	<option  value=">=">>=</option>
	<option  value="<="><=</option>
	</select><input type=text name=age size=9.5 style="border-style: solid; border-width: 1">
	</td>
	</tr><tr >
    <td width="10%"  class=roomleft >联系电话:</td><td width=30%  class=roomright>
	<input type=text name=tel size=15 style="border-style: solid; border-width: 1">
	</td>  
	 
	  
  </tr> 
  <tr>
	 
	 <td width="10%"  class=roomleft>来访日期:</td><td width=30%  class=roomright>
		从<INPUT TYPE=TEXT NAME=Date1 size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;"><br>到<INPUT TYPE=TEXT NAME=Date2 size=10><input type=button name=cale1 value=".." onclick="fPopUpCalendarDlg(Date2);return false;"></td></td>  
	  </tr><tr  >
	   <td width="10%"  class=roomleft >客户类型:</td><td width=30%  class=roomright>
	   <select size="1" name="custype" style="width : 120">     
	   <option value=""></option>
      <option value="个人">个人</option>
      <option  value="公司">公司</option>
        <option value="集体">集体</option>
      </select>
	   </td>
	   </tr><tr  > 
	   <td  width="10%"  class=roomleft >购买用途:</td><td width=30%  class=roomright>
	   <select size="1" name="gmyt" style="width : 120">     
	   <option value=""> </option>                
     <%
 String StrSql="select type,codename from CODE where type='I' order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[200];
   String CodeType[]=new String[200];
   codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
     out.print("<option value="+getbyte(codeRS.getString("type"))+">");
    out.print(getbyte(codeRS.getString("codename"))+"</option>");
	 i++;
   }
   codeRS.close();
    %>
      </select></td>  
	  </tr><tr >
	  <td  width=10%  class=roomleft>条件:</td><td width=30%  class=roomright align="left">
	  <select name="cusche">
  	   <option value=2 selected>所有客户</option>
	   <option value=1>已购客户</option>
	 <!--  <option value=4>认购客户</option>-->
   	   <option value=0>未购客户</option>
	   <option value=3>临订客户</option>
	   
	   <option value=5>换房客户</option>
	   <option value=6>挞订客户</option>
	   <option value=7>已鉴证客户</option>
	   <!--<option value=8>未鉴证客户</option>-->
	   <option value=9>已放款客户</option>
	   <option value=10>未放款客户</option>
	   <option value=11>已办产权客户</option>
	   <option value=12>未办产权客户</option>
	   <option value=13>已交楼客户</option>
     </td>  
  </tr> 
  </table>
 <p align=center><input type=button name=Find value="提 交" onclick="ChooseFind()"> <input type=button name=cancel value="退 出" onclick="window.close();">
  </p>

 
  </form>
<script>
	 function ChooseFind(){

	    if (document.cus.section.options[document.cus.section.selectedIndex].value!="")
		opener.document.CusView.Findsection.value=document.cus.section.options[document.cus.section.selectedIndex].value;
		if (document.cus.cusname.value!="")
	 	opener.document.CusView.cusname.value=document.cus.cusname.value;
		if (document.cus.tel.value!="")
		opener.document.CusView.tel.value=document.cus.tel.value;
	    if (document.cus.condi.options[document.cus.condi.selectedIndex].value!="")
		opener.document.CusView.condi.value=document.cus.condi.options[document.cus.condi.selectedIndex].value;
		if (document.cus.age.value!="")
		opener.document.CusView.age.value=document.cus.age.value;
	    if (document.cus.Date1.value!="")
		{opener.document.CusView.Date1.value=document.cus.Date1.value;
		 opener.document.CusView.Date2.value=document.cus.Date2.value;
		}
	    if (document.cus.custype.options[document.cus.custype.selectedIndex].value!="")
		opener.document.CusView.custype.value=document.cus.custype.options[document.cus.custype.selectedIndex].value;
	     if (document.cus.gmyt.options[document.cus.gmyt.selectedIndex].value!="")
		opener.document.CusView.gmyt.value=document.cus.gmyt.options[document.cus.gmyt.selectedIndex].value;
		opener.document.CusView.cusche.value=document.cus.cusche.options[document.cus.cusche.selectedIndex].value;	
		opener.document.CusView.Find.value="Find";
		opener.document.CusView.submit();
		close();
	 }
	</script>
</body>

</html>
