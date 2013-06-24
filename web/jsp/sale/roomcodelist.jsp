 <%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>选择</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.Date,java.util.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>

<%
 String sql="";
 String Eof="";
 String strSUBMIT=request.getParameter("SUBMIT");
 String strCusName=request.getParameter("cusna");
 String strCusNo=request.getParameter("serialNo");
 String strCusTel=request.getParameter("tel");
 String loft=getbyte1(request.getParameter("loft"));
String secna=request.getParameter("secna");
if (secna==null)secna="";
if (loft==null)loft="";
 String strsection=request.getParameter("section");
 String CusNo=request.getParameter("cusno");
 String cusname=getbyte1(request.getParameter("cusname"));
 String cusname1=getbyte1(request.getParameter("cusname1"));
 String type=getbyte(request.getParameter("type"));
  String PARA_SQL=getbyte1(request.getParameter("PARA_SQL"));
String groupname=getbyte1(request.getParameter("groupname"));
String ifvalue=getbyte1(request.getParameter("ifvalue"));
// out.print(PARA_SQL);
 String orderbytype=China.getParameter(request,"orderbytype");
 String orderby=China.getParameter(request,"orderby");
 //排序方式
if (!orderbytype.equals("")&&!orderby.equals("")){
  if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by customer.visit_date desc";
  if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by customer.visit_date asc";
  if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by customer.cus_name desc";}
  if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by customer.cus_name asc";
}else{
	orderby=" order by customer.visit_date desc";
	
	}

 if (strSUBMIT!=null)
     strCusName=getbyte(strCusName);
	%>
	
	<script>
function full(){
 //setSelectMad(document.cus1.orderbytype,'<%=orderbytype %>');
 //setSelectMad(document.cus1.orderby,'<%=China.getParameter(request,"orderby") %>');
}

</script>
<body onload="full();">
<form name=cus1 method="post" action="">
<%
String subSQL="";
 if (cusname!=null)cusname=getbyte(cusname);

 else cusname="";
 if (!cusname.equals("")&&!type.equals("")){
    if (!type.equals("room")){
      type= " where  "+type+" like '%"+cusname+"%'";
    }else{
	  type=" where serialno in ( select customer from order_contract where loft+building+room_no like '%"+cusname+"%')";
	
	}
 }
 String Section=request.getParameter("section");
 String paracusname=request.getParameter("FindCus");
 String serialNo="";

 String eof="true";
int ii=0;
if (ifvalue==null)ifvalue="";

if (!ifvalue.equals(""))ifvalue+=" where "+ifvalue;
if (!secna.equals("")&&!ifvalue.equals("")){
  ifvalue+=" and  name='"+secna+"' and loft='"+loft+"'  ";
 }
if (!secna.equals("")&&ifvalue.equals("")){
  ifvalue+=" where  name='"+secna+"' and loft='"+loft+"'  ";
 }

 sql="select  "+groupname+"  from RgsViewC group by "+groupname ;
 
  ResultSet rs=ViewBean.executeQuery(sql);

%>


<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
 

<script>
function ordersubmit(){
	document.cus1.submit();	 
	}
function FindOption(){
var str="";
var Fstr="";
var eof="";
Fstr=document.cus1.cusname.value;
   for (var i=0;i<document.cus1.cuslist.length;i++){
     str=document.cus1.cuslist.options[i].text;
	 document.cus1.cuslist.options[i].selected=false;
	   if (str.indexOf(Fstr)>=0){
		   document.cus1.cuslist.options[i].selected=true;
		   eof="a";
   	     break;
       }
	}
	if (eof==""){alert("没找到你的资料");;document.cus1.cusname.select();}
	document.cus1.cusname.focus()
}	
</script>	
<br>
<input type=button name="ok" value=" 确 认 " onclick="chooose('chooseroomno');">
  <table width="100%" border="0" CELLSPACING=1 CELLPADDING=1  ALIGN=center>
<tr  class=TXTColor align="center">
<td>选择</td>
<td>房间代码</td>
</tr>
<%
int i=0;
while (rs.next()){
i++;
Eof="false";
 
String strvalue=getbyte(rs.getString(groupname));
   
%>
 <tr id=TR<%=i %> align="left" title="单击选择后，系统自动关闭窗口" class=listcontent onmouseover="mout(this);changeclass1(this,'clickbg','listcontent');" onclick="aa('<%=strvalue%>');"  > 
<td align="center"> <input type="checkbox" name="chooseroomno" value="<%=strvalue %>"></td>
<td><%=strvalue %></td>

</tr>

    <%}%>
</table>
<%
  rs.close();
  if (Eof.equals("")){
  
   %>
   <script>
alert("系统没有查找到客户资料，请直接在合同资料登记表中录入");


</script>
<%} %>
 <script>
 function getseldocs2(indexstring) {
     var x=0;
	 var seldocs = new Array();
	 var temp=cus1.elements.length;
     for (i=0;i<cus1.elements.length;i++) {
       if ((cus1.elements[i].type=="checkbox")&&(cus1.elements[i].checked))
		 { 
		    <%if (groupname.indexOf("floor")>=0){ %>
			 seldocs[x]=cus1.elements[i].value ;
			 <%}else{ %>
			  seldocs[x]="'"+cus1.elements[i].value+"'" ;
			 
			 <%} %>
			
			x++;
   		 }
	  }	

   return seldocs ;
}
 function chooose(indexstring){
  if (getseldocs2(indexstring)!=""){
 opener.window.frm.choosroomno.value=getseldocs2(indexstring);
 opener.addif();
 window.close();
}else{alert("请选择条件");}
 
 }
function aa(para1,para2,para3,para4,para5,para6,para7){
  if (window.opener.document.frm.FindB1)
window.opener.document.frm.FindB1.value="详情";
 window.opener.document.frm.cusname.value=para1;
 window.opener.document.frm.cusname1.value=para2;
  if (window.opener.document.frm.tel)
 window.opener.document.frm.tel.value=para3; 

 if (window.opener.document.frm.sj)
 window.opener.document.frm.sj.value=para4;
  
  if (para3=="") window.opener.document.frm.tel.value=para4;
 if (window.opener.document.frm.carid)
  window.opener.document.frm.carid.value=para5
 if (window.opener.document.frm.Address)
    window.opener.document.frm.Address.value=para6;
 if (window.opener.document.frm.post) 
   window.opener.document.frm.post.value=para7; 

}
</script>



</form>
</body>

</html>
