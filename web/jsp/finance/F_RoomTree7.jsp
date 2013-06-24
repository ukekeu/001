<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>楼栋树</title>
</head>
<%
String checkQX=request.getParameter("check"); %>

<script language="javascript" src="../public_js/public.js">
</script>

<script language="javascript" src="../public_js/menu.js">
</script>

<body  class=tree  oncontextmenu="return false">
<form method="POST" name="cus" action="SectionView.jsp">
<%@ include file="../public_js/CheckSection.jsp"%>

<table border="0" width="120%" cellspacing="0" cellpadding="0">
<tr><td>楼栋树</td></tr>
<% 
	String sqluptown="";
	String sqlbuilding="";
	String uptown_id="";
	String uptown_name="";
	String building_id="";
	String building_name="";
	int j=0;int num=0;
	 String LoftSql="select SerialNo,Name FROM CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";
 
	 String SectionName="";
	 String SectionSerialNo="";
	ResultSet rsuptown=ViewBean2.executeQuery(LoftSql);
	while(rsuptown.next()){
	   j=0;
	   SectionSerialNo=rsuptown.getString("SerialNo");
	   SectionName=getbyte(rsuptown.getString("Name"));
   %>

   <tr valign="top">
     <td id=upto_<%=SectionSerialNo%> onclick="changeclassname(this,'BL2','L2');">
    <img src="../images/plus4.gif" border=0 align="absmiddle" hspace="4"  name="uptown_<%=SectionSerialNo%>" onclick="changesrc(this);document.all.T<%=SectionSerialNo%>.style.display=(document.all.T<%=SectionSerialNo%>.style.display=='none')?'block':'none';"><a href="#" onclick="changesrc(document.all.uptown_<%=SectionSerialNo%>);document.all.T<%=SectionSerialNo%>.style.display=(document.all.T<%=SectionSerialNo%>.style.display=='none')?'block':'none';"><%=SectionName%></a>
	 </td>
   <tr>
   <td  valign="top">
   <div id="T<%=SectionSerialNo %>" style="display:none">
   <table border=0 cellspacing="0" cellpadding="0" width=100%>
   <% 
      LoftSql="select Loft FROM sectiontree where SerialNo='"+SectionSerialNo+"' group by Loft order by  loft";
	 String Loft="";
	 String Building="";

   ResultSet rsbuilding=ViewBean1.executeQuery(LoftSql);
  while(rsbuilding.next()){
      Loft=getbyte(rsbuilding.getString("Loft"));
	  j++;num++;
 %>
 <tr valign="middle">
 <td id="buil_<%=Loft%>"   onclick="changeclassname(this,'BL2','L2');">
  <img src="../images/document1.gif" border=0 align="absmiddle" hspace="4" ><a href="jz_charges.jsp?SecNo=<%=SectionSerialNo %>&Loft=<%=Loft %>&SecName=<%=SectionName%>&checkQX=<%=checkQX %>" target="frmright"onclick="aad2(s<%=num %>,100);"><%=Loft %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
  </td>
  </tr>
   <% 
     String BuildSql="select Build FROM sectiontree where SerialNo='"+SectionSerialNo+"' and Loft='"+Loft+"' group by Build";

   int jjj=0;
   ResultSet rsbuilding1=ViewBean.executeQuery(BuildSql);
  while(rsbuilding1.next()){
     String  Build=getbyte(rsbuilding1.getString("Build"));
	  j++;num++;
	  if (Build.equals(""))break;
 %>
  <%if (jjj==0){ %>
   <tr>
  <td class="L2">
   <table border=0 cellspacing="0" cellpadding="0" width=100%>
  <%} %>
 <tr>
 <td id="buil_<%=Build%>" class="L2" onclick="changeclassname(this,'BL2','L2');">
 <img src="../images/tree.gif" border=0 align="absmiddle" hspace="4" ><a href="jz_charges.jsp?SecNo=<%=SectionSerialNo %>&Loft=<%=Loft %>&SecName=<%=SectionName%>&Build=<%=Build %>" target="frmright"  title='单击后在右边查看付款情况' onclick="aad2(s<%=num %>,100);"><%=Build %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >

  </td>
  </tr>
<%if (jjj==0){ %>
    </table> 
	<%} %>

  <%}rsbuilding1.close();%>


  <%}rsbuilding.close();%>
  </table> 
  </div> 
<%}rsuptown.close();%>
     </td>
   </tr>	
 </td>
 </tr>
 </table>
<br>
  <select name=secname1 value=>
 <% LoftSql="select SerialNo,Name FROM CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";;
	  SectionName="";
	  SectionSerialNo="";
	    rsuptown=ViewBean2.executeQuery(LoftSql);
	while(rsuptown.next()){
	   j=0;
	   SectionSerialNo=rsuptown.getString("SerialNo");
	   SectionName=getbyte(rsuptown.getString("Name"));
   %> %>
  <option value="<%=SectionSerialNo %>"><%=SectionName %></option>
   <%}rsuptown.close(); %>
 </select>
 <br>
搜索姓氏:<br>
 <select name=speedcusname onchange="searchcus();">
 <option><option>
<%
String findSQL="exec set_customer '"+s_sec1+"'";
  ResultSet rs=ViewBean2.executeQuery(findSQL);
  while (rs.next()){
   String x=getbyte(rs.getString("name"));
   out.print("<option value='"+x+"'>"+x+"</option>");
  
  }
  rs.close();
 %>
 </select>
<br>

 </div>
</form>
<%//}%>
 <%ViewBean.closeConn();
    ViewBean1.closeConn();
	ViewBean2.closeConn();
   %>
 <script language="JavaScript">
    function searchcus(){

	parent.frmright.document.frm.cusname.value=document.cus.speedcusname.value;
	parent.frmright.document.frm.secname.value=document.cus.secname1.value;
	parent.frmright.document.frm.action="jz_charges.jsp";
	parent.frmright.document.frm.submit();
	}
    function changesrc(s){
     thissrc=s.src;
	 thissrc=thissrc.substring(thissrc.length-9,thissrc.length);
	
	 if(thissrc=="plus4.gif"){
	    s.src="../images/minus.gif";
	 }else{
	   s.src="../images/plus4.gif";
	 }
   }
   </script>
  

<script language="JavaScript">
		  function  changeclassname(src,clrOver,clrIn){ 
             var td = document.all.tags("TD") ;
			 var tmp=src.id.substring(0,4);
			 if(tmp=="upto"){tmp2="buil";}else{tmp2="upto";}
			 for ( i = 0 ; i < td.length ; i ++ ) {
			 if (td[i].id) {
	     	      var tt = td[i].id ;
			      if (tt.indexOf(tmp) > -1) {
				    if(tt==src.id){
					   document.all.tags("TD")[i].className=clrOver;
					}else{
					   document.all.tags("TD")[i].className=clrIn;
					}
			     }
				 if(tt.indexOf(tmp2)>-1){
				   document.all.tags("TD")[i].className=clrIn;
				 }
			   }
		     }
		  }	
  </script>
</form>
</body>
</html>
