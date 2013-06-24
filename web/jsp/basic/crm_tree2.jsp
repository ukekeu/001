<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="conn" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="conn1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="conn2" scope="page" class="ConnDatabase.SDatabase"/>
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
<SCRIPT language="JavaScript1.2" type="text/javascript"><!--
//-->
</SCRIPT>
<script language="JavaScript" src='../public_js/menu.js'></script>
<body class=tree oncontextmenu="return false"   >
<%@ include file="../public_js/CheckSection.jsp"%>
<form action="" method="post" name="submitform">
<div style="display:none">
<input type="text" name="model_name" value="HomePage">
<input type="text" name="sub_model_name">
<input type="text" name="model_url">
<input type="text" name="uptownid">
<input type="text" name="buildingid">
<input type="text" name="other">
</div>
<table border="0" width="120%" cellspacing="0" cellpadding="0">
 <% 
	int j=0; 
	int num=0;	 
	 String SQL="select SerialNo,Name FROM CRM_Project " +  FindWhere + " group by  Name,SerialNo order by name ";
 	 String SectionName="";
	 String SectionSerialNo="";
	ResultSet rs=conn2.executeQuery(SQL);
	while(rs.next()){
	   j=0;
	   SectionSerialNo=rs.getString("SerialNo");
	   SectionName=getbyte(rs.getString("Name"));
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
      SQL="select Loft FROM sectiontree where SerialNo='"+SectionSerialNo+"' group by Loft order by  loft";
	 String Loft="";
	 String Building="";

   ResultSet rs1=conn1.executeQuery(SQL);
  while(rs1.next()){
      Loft=getbyte(rs1.getString("Loft"));
	  j++;num++;
 %>
 <tr>
 <td id="buil_<%=Loft%>" class="L2" onclick="changeclassname(this,'BL2','L2');">
 
 <img src="../images/document1.gif" border=0 align="absmiddle" hspace="4" ><a href="RoomCodeInput.jsp?SecNo=<%=SectionSerialNo %>&Loft=<%=Loft %>&SecName=<%=SectionName %>&param=<%=request.getParameter("param") %>"  target="frmright" onclick="para('<%=Loft%>','<%=Loft%>');aad2(s<%=num %>,200);"><%=Loft %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
  </td>
  </tr>
   <% 
     SQL="select Build FROM sectiontree where SerialNo='"+SectionSerialNo+"' and Loft='"+Loft+"' group by Build";

   int jjj=0;
   ResultSet rs11=conn.executeQuery(SQL);
  while(rs11.next()){
     String  Build=getbyte(rs11.getString("Build"));
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
 <img src="../images/tree.gif" border=0 align="absmiddle" hspace="4" ><a href="RoomCodeInput.jsp?SecNo=<%=SectionSerialNo %>&Loft=<%=Loft %>&SecName=<%=SectionName %>&Build=<%=Build %>&param=<%=request.getParameter("param") %>" target="frmright" onclick="para('<%=Build%>','<%=Build%>');aad2(s<%=num %>,200);"><%=Build %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
  </td>
  </tr>
  <%if (jjj==0){ %>
    </table> 
	<%} %>

  <%}rs11.close();%>
  <%}rs1.close();%>
  </table> 
  </div> 
<%}rs.close();%>
     </td>
   </tr>	
 </td>
 </tr>
 </table>
 </div>
</form>
<%//}%>
 <%conn.closeConn();
  conn1.closeConn();
  conn2.closeConn();
        %>
 <script language="JavaScript">
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
function para(uptown_id,building_id){
   model_name=document.all.model_name.value;
   document.all.uptownid.value=uptown_id;
   document.all.buildingid.value=building_id;
   other=document.all.other.value;
  
}
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