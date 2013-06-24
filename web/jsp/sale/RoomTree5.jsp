<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>楼栋树</title>
</head>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>

<script language="javascript" src="../public_js/menu.js">
</script>
<body  class=tree >
<form method="POST" name="cus" action="SectionView.jsp">
<%@ include file="../public_js/CheckSection.jsp"%>

<table border="0" width="120%" cellspacing="0" cellpadding="0">
<%
	  
	int j=0;
	int num=0;
	 String SQL="select SerialNo,Name FROM CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";;
	 String SectionName="";
	 String SectionSerialNo="";
	ResultSet rs=ViewBean2.executeQuery(SQL);
	while(rs.next()){
	   j=0;
	   SectionSerialNo=rs.getString("SerialNo");
	   SectionName=getbyte(rs.getString("Name"));
   %>
   <tr valign="top">
     <td id=upto_<%=SectionSerialNo%> onclick="changeclassname(this,'BL2','L2');">
    <img src="../images/minus.gif" border=0  id=src<%=SectionSerialNo %> align="absmiddle" hspace="4"  name="uptown_<%=SectionSerialNo%>" onclick="changesrc(this);document.all.T<%=SectionSerialNo%>.style.display=(document.all.T<%=SectionSerialNo%>.style.display=='none')?'block':'none';"><a href="../basic/BuildingView1.jsp?SecNo=<%=SectionSerialNo %>&SecName=<%=SectionName%>&Build=<%='a' %>" target="frmright"  onclick="changesrc(src<%=SectionSerialNo %>);document.all.T<%=SectionSerialNo%>.style.display=(document.all.T<%=SectionSerialNo%>.style.display=='none')?'block':'none';"><%=SectionName%></a>
	 </td>
   <tr>
   <td  valign="top">
   <div id="T<%=SectionSerialNo %>" style="display:block">
   <table border=0 cellspacing="0" cellpadding="0" width=100%>
   <% 
      SQL="select Loft FROM sectiontree where SerialNo='"+SectionSerialNo+"' group by Loft order by  loft";
	 String Loft="";
	 String Building="";

   ResultSet rs1=ViewBean1.executeQuery(SQL);
  while(rs1.next()){
      Loft=getbyte(rs1.getString("Loft"));
	  j++;
	  num++;
 %>
 <tr valign="middle">
 <td id="buil_<%=Loft%>"   onclick="changeclassname(this,'BL2','L2');">
  <img src="../images/document1.gif" border=0 align="absmiddle" hspace="4" ><a href="../sale/RoomCodeShow2.jsp?SecNo=<%=SectionSerialNo %>&Loft=<%=Loft %>&SecName=<%=SectionName%>" target="frmright" title='单击后在右边是销控表' onclick="aad2(s<%=num %>,200);"><%=Loft %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
  <!--<a href="../basic/BuildingView1.jsp?SecNo=<%=SectionSerialNo %>&SecName=<%=SectionName%>&Build=<%='a' %>&Loft=<%=Loft %>" target="frmright"  onclick="changesrc(document.all.uptown_<%=Loft%>);document.all.T<%=Loft%>.style.display=(document.all.T<%=Loft%>.style.display=='none')?'block':'none';"></a>-->

  </td>
  </tr>
  <% 
       SQL="select Build FROM sectiontree where SerialNo='"+SectionSerialNo+"' and Loft='"+Loft+"' group by Build";

   int jjj=0;
   ResultSet rs11=ViewBean.executeQuery(SQL);
  while(rs11.next()){
     String  Build=getbyte(rs11.getString("Build"));
	  j++;
	  num++;
	  if (Build.equals(""))break;
 %>
  <%if (jjj==0){ %>
   <tr>
  <td class="L2">
   <table border=0 cellspacing="0" cellpadding="0" width=100%>
  <%} %>
    
 <tr>
 <td id="buil_<%=Build%>" class="L2" onclick="changeclassname(this,'BL2','L2');">
 <img src="../images/tree.gif" border=0 align="absmiddle" hspace="4" ><a href="../sale/RoomCodeShow.jsp?SecNo=<%=SectionSerialNo %>&Loft=<%=Loft %>&SecName=<%=SectionName%>&Build=<%=Build %>" target="frmright" title='单击后在右边是销控表' onclick="aad2(s<%=num %>,100);"><%=Build %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
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
<%ViewBean.closeConn();
    ViewBean1.closeConn();
	ViewBean2.closeConn();
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

</body>
</form>
</html>
