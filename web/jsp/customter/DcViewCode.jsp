<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>客户调查数据项视图</title>
</head>
<script language="javascript" src="../public_js/public.js"></script>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
    <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>

 <%@ include file="../public_js/qx_checke.jsp"%>
<%
String section=getbyte1(request.getParameter("section"));
String codes=getbyte1(request.getParameter("codes"));
String deletecode=getbyte1(request.getParameter("deletecode"));
String dcType=getbyte1(request.getParameter("dcType"));
if (dcType.equals(""))dcType="0";
String SQL="";
if (!deletecode.equals("")){
   SQL="delete  CustomerDc where code="+deletecode;
   ViewBean.executeUpdate(SQL);
}
if (!codes.equals("")){
   SQL="insert into CustomerDc(codeName,sectionno,type) values('"+codes+"','"+section+"',"+dcType+")";
   ViewBean.executeUpdate(SQL);
}
  String menusel=China.getParameter(request,"menusel");
    if(menusel.equals("")) menusel="0";
	String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"market2");
%>
 <%@ include file="../public_js/CheckSection.jsp"%>

<body oncontextmenu="return false" topmargin="0"  >
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
  <table width=100% border="0"><tr height="16"  ><td align="left">类别：<select name="dcType" onchange="document.frm.submit();"> 
   <option value=0>未成交客户问卷表</option>
    <option value=1>已成交客户问卷表</option>
	</select>
   楼盘：<select name="section" onchange="document.frm.submit();"> 
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
		if (section.equals(""))section=no1;
		
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
 </td><td> <%if (Cortrol.indexOf("A")>=0){ %>调查项:<input type=text size=12 name=codes>&nbsp;<input type=button name=ok value="提交" onclick="savedata();"><%} %></td><td align="right"> <%if (Cortrol.indexOf("F")>=0){ %><input type=button name=ok value="打印" onclick="openwin1('PrintDcSetCode.jsp');"><%} %>&nbsp;&nbsp; <%if (Cortrol.indexOf("A")>=0){ %><input type=button name=ok value="复 制" onclick="copyData();"><%} %></td></tr></table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr align="center"  class=listtitle>
    <td width="10%">序号</td>
    <td width="20%">调查项</td>
	 <td width="65%">调查内容</td>
	  <td width="25%"> </td>
  </tr>
  <%
  SQL="select * from CustomerDc where sectionno='"+section+"' and type="+dcType;
 
  ResultSet rs=ViewBean.executeQuery(SQL);	
 
  int i=0;
   while (rs.next()){
     i++;
   %>
 <tr align="center">
    <td width="10%" ><%=i %></td>
    <td width="15%"><%=rs.getString("codeName") %></td>
	<td width="65%" align="left">
	<%
	 SQL="select  CodeValue,code from CustomerDcValue where dcCode="+rs.getString("code");
	 
	 ResultSet rs1=ViewBean1.executeQuery(SQL);	
    while (rs1.next()){
	    String codcename=rs1.getString("CodeValue");
		String code=rs1.getString("code");
	     %>
		   <input name="codcename" type="checkbox" value="<%=code %>" checked onclick="cancelChoose(this.checked,this.value);" ><%=codcename %> 
		 <% 
       }
	rs1.close();
	 %>
	
	</td>
	 <td width="30%"> <%if (Cortrol.indexOf("A")>=0){ %><a href="#" onclick="openwin1('DcSetCodeValue.jsp?SecNo=<%=section %>&dcType=<%=dcType %>&code=<%=rs.getString("code") %>',200,200,200,200);" title="添加内容"><img src="../images/edit.gif" border="0" ></a><%} %>&nbsp; <%if (Cortrol.indexOf("D")>=0){ %><a href="#" onclick="if (confirm('确认吗？删除将连同内容一起删除'))window.location='DcViewCode.jsp?deletecode=<%=rs.getString("code") %>&dcType=<%=dcType %>&SecNo=<%=section %>';" title="删除调查项"><img src="../images/button_sc.gif" border="0" ></a><%} %>
	 </td>
  </tr>
  <%}
  rs.close(); %>
  
</table>
 
</form>
<script>
 setSelectMad(document.frm.section,'<%=section %>');
  setSelectMad(document.frm.dcType,'<%=dcType %>');
function savedata(){
  if (document.frm.codes.value=="")
   {alert("请填写数据项！");
   document.frm.codes.focus();
    return false;
   }
   document.frm.submit();
}
function cancelChoose(para,para1){
  if (!para&&confirm("确认删除此数据项吗？")){
     openwin1("deleteDcCode.jsp?SecNo=<%=section %>&code="+para1+"&dcType=<%=dcType %>",10,10,10,10);
    }
}
function copyData(){
      openwin1("copy_cus_dc.jsp",500,150,100,100);
 
}
</script>

</body>
</html>
