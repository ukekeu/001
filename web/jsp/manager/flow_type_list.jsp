 


  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="pageBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
    <%@ include file="../public_js/getByteOut.jsp"%>

<% 
	//获得该员工的部门编号和部门编码
	//int DEPT_ID = 0;
	String DEPT_CODE = null;
	String sqlDept = null;
	 
	String findstr1="";
	//查询条件
	String dept=request.getParameter("dept");
	if(dept==null) dept="";
    String emp=(request.getParameter("emp"));
	if(emp==null) emp="";
	String startdate=(request.getParameter("startdate"));
	if(startdate==null) startdate="";
	String enddate=(request.getParameter("enddate"));
	if(enddate==null) enddate="";
	if(!dept.equals(""))
	   findstr1=findstr1+" and dept_id="+dept;
    if(!emp.equals(""))
	   findstr1=findstr1+" and user_id="+emp;
	if(!startdate.equals(""))
	   findstr1=findstr1+" and ACTION_DATE>='"+startdate+"'";
	if(!enddate.equals(""))
	   findstr1=findstr1+" and ACTION_DATE<='"+enddate+"'";
   String choose=getbyte(request.getParameter("choose"));
   if (choose.equals(""))choose="2";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>流程类别</title>
</head>
<body>

<script language="javascript" src="../public_js/public.js"></script>
<SCRIPT language="JavaScript1.2" type="text/javascript"><!--
var para_id="";
 function para(para1){
    para_id=para1;
  } 
 
 
 function chhoseData(){
   if (confirm("确认删除吗？")){
   var seldocs = new Array();
     var x=0;
   for (var i=0;i<document.pm.choosetype.length;i++){
 	  if (document.pm.choosetype[i].checked)
	 { seldocs[x]=document.pm.choosetype[i].value;
	  x++;
	  }
     }
	 if (x==0)seldocs[0]=document.pm.choosetype.value
    var returnvalue="";
	  if (seldocs!="")
	    OpenForm("delete_floow_type.jsp?emp_code="+seldocs,"","500","200");;//+"/"+seldocs1
   }
}
 function page_change(sel,urlstr)
 {    
   var topage="";
   topage=urlstr+"?para=flowtype&sel="+sel; 
    window.location=topage;
 }
//-->
</SCRIPT>
<div align="center">
 <form action="" method="post" name="pm">
<% 
  /*
    fun:显示小区信息页
    */
   String sel=(String)request.getParameter("sel");
   String pageurl="";
   if(sel==null) sel="1";
   if(sel.equals("1"))
   {
	 pageurl="pm_tenement_list.jsp";
   }
   else if(sel.equals("2"))
   {
	 pageurl="pm_old_tenement_list.jsp";
   }
%>
   <input type=hidden name=sel value="<%=sel%>">
    <table width="182" border="0" cellspacing="0" cellpadding="0" class="L2">
     <tr>
    <td class="<%if(sel.equals("1")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="page_change(1,'flow_type_list.jsp');return false;"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>流程类别</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="page_change(2,'flow_list.jsp');return false;"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>流程一览</font></a>
	</td>
	 
   </tr>
 </table>
 <br>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="L2">
  <tr><td  align=center>流程类别一览</td></tr>	
 </table>
 <table width="95%" border="0" cellspacing="1" cellpadding="0">
     <tr>
	   <td align="left">
	    <a href="#" onclick="openwin2('add_flow_type.jsp','560','300',100,100);return false;">增 加</a>
	
	   
	 
	 </tr>
</table>

<table border="0" cellspacing="1" cellpadding="0"   width=95%>
   <tr align="center" class=listtitle>
    <td width="6%">序号</td>
    <td width="15%">流程类别名称</td>
    <td width="30%">拥有权限者</td>
	<td width="12%">定义日期</td>
	<td width="12%">定义人</td>
	  <td width="20%">备注</td>
	   <td width="12%">删除</td>
  </tr>
<%
  
    //取得页数
      String Strpageno=request.getParameter("pageno");
      //第1页
      int pageno=1;
      if(Strpageno!=null && Strpageno.length()>0)
	  {
        pageno=Integer.parseInt(Strpageno);
      }
      //取得一页显示的行数
      String StrpageSize=request.getParameter("pagesize");
      int pageSize=20;	
      if(StrpageSize!=null && StrpageSize.length()>0)
	  {
        pageSize=Integer.parseInt(StrpageSize);
      }   
      //上一页
      int previous=pageno-1;
      //下一页
      int next=pageno+1;
      //开始记录数
      int startnum=pageno*pageSize;
      //上次记录数
      int prenum=previous*pageSize;
      int pagecount=0;	
	 
	  String SQL="SELECT Top "+pageSize+" * "+
	             "FROM workflow_set "+
	             "WHERE  code not in (select top "+prenum+" code FROM  workflow_set  order by set_date desc )  order by set_date desc";
				//  out.print(SQL);
	  String sqlcount = "select count(*) FROM workflow_set ";
	  ResultSet rs=pageBean.executeQuery(SQL);		
	
	 
	  int i=0;
	
	  while(rs.next())
	  {
	    i++;
	 
		String code=rs.getString("code");
	 
		String flow_name= rs.getString("flow_name");
		String flow_show = getbyte(rs.getString("flow_show"));
		String flow_bak= getbyte(rs.getString("flow_bak"));
		String set_date= getbyte(rs.getString("set_date")).substring(0,10);
		String set_person= getbyte(rs.getString("set_person"));
 %>
   <tr  align="center"  >
           <td><%=i %><input name="choosetype"  value="<%=code %>" type="checkbox"></td>	
	    <td><%=flow_name %></td>	
		<td><%=flow_show %></td>	
		 
		<td><%=set_date %></td>	
		<td><%=set_person%></td>
		<td width="21%"><%=flow_bak%></td>
		<td width="12%"><a href="delete_floow_type.jsp?emp_code=<%=code %>"> 删除</a></td>
	</tr>
<%  }
    if(i>0)
	{
%>
</table>
 
<%
    }
	else
	{
%>
  <br>
  <table width="50%" border="0" class="msgbody" >
   <tr align="center"><td><img src="../images/infor.gif"></td></tr>
   <tr>
    <td align="center">
     暂没有定义流程类别</font></a>
   </td></tr>
  </table>
<%
    }
	pageBean.closeConn();
 %>
 </form>
 </div>