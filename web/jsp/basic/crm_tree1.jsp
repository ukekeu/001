<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>¥����</title>
</head>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="conn" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="conn1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="conn2" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<script language="JavaScript" src='../public_js/menu.js'></script>

<script language="javascript" src="../public_js/public.js">
</script>
 
<body  class=tree onload="" background="../images/L_tu2.jpg">
<form method="POST" name="cus" action="SectionView.jsp">
   
 
<%@ include file="../public_js/CheckSection.jsp"%>
<table border="0" width="120%" cellspacing="0" cellpadding="0">
<%
 
	int j=0;int num=0;
	String SQL="select SerialNo,Name FROM CRM_Project " + FindWhere + " group by  Name,SerialNo order by name";	
	String SectionName="";
	String SectionSerialNo="";
	ResultSet rsuptown=conn2.executeQuery(SQL);
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
      SQL="select Loft FROM sectiontree where SerialNo='"+SectionSerialNo+"' group by Loft order by  loft";
	 String Loft="";
	 String Building="";

   ResultSet rsbuilding=conn1.executeQuery(SQL);
  while(rsbuilding.next()){
      Loft=getbyte(rsbuilding.getString("Loft"));
	  j++;num++;
 %>
 <tr>
 <td id="buil_<%=Loft%>" class="L2" onclick="changeclassname(this,'BL2','L2');">
 
 <img src="../images/document1.gif" border=0 align="absmiddle" hspace="4" ><a href="#" onclick="chooseClick('<%=SectionSerialNo %>','<%=Loft %>','<%=SectionName %>','');ChooseForm();aad2(s<%=num %>,250);"><%=Loft %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
  </td>
  </tr>
   <% 
     String BuildSql="select Build FROM sectiontree where Build <>'' and SerialNo='"+SectionSerialNo+"' and Loft='"+Loft+"' group by Build";
 
   int jjj=0;
   ResultSet rsbuilding1=conn.executeQuery(BuildSql);
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
 <img src="../images/tree.gif" border=0 align="absmiddle" hspace="4" ><a href="#" onclick="chooseClick('<%=SectionSerialNo %>','<%=Loft %>','<%=SectionName %>','<%=Build %>');ChooseForm();aad2(s<%=num %>,250);"><%=Build %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
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
<script>
  function chooseClick(para1,para2,para3,para4,para5){
        parent.frmright.document.forms[0].SecNo.value=para1;
		parent.frmright.document.forms[0].Loft.value=para2;
		parent.frmright.document.forms[0].SecName.value=para3;
		parent.frmright.document.forms[0].Build.value=para4;
		parent.frmright.document.forms[0].Find.value="a";
		parent.frmright.document.forms[0].Search.value="b";
     
	  }
 function ChooseForm(){
     if ( parent.frmright.document.forms[0].action=="")
     parent.frmright.document.forms[0].action="crm_RoomCodeList1.jsp";
	 parent.frmright.document.forms[0].submit();	
  }
</script>
</form>
</body>
</html>