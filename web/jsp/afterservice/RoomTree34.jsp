<%@ page contentType="text/html;charset=GBK" %>

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
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
 
<body  class=tree onload="">
<form method="POST" name="cus" action="SectionView.jsp">
<%@ include file="../public_js/CheckSection.jsp"%>



<table border="0" width="120%" cellspacing="0" cellpadding="0">
 
<%
	String sqluptown="";
	String sqlbuilding="";
	String uptown_id="";
	String uptown_name="";
	String building_id="";
	String building_name="";
	int j=0;int num=0;
	 String LoftSql="select SerialNo,Name FROM CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";;
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
    <img src="../images/plus4.gif" border=0 align="absmiddle" hspace="4"  name="uptown_<%=SectionSerialNo%>" onclick="changesrc(this);document.all.T<%=SectionSerialNo%>.style.display=(document.all.T<%=SectionSerialNo%>.style.display=='none')?'block':'none';"><a href="../afterservice/JlManage.jsp?SecNo=<%=SectionSerialNo %>&Loft=&SecName=<%=SectionName%>" target="frmright"><%=SectionName%></a>
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
  <img src="../images/document1.gif" border=0 align="absmiddle" hspace="4" ><a href="#" onclick="FindPro('<%=SectionSerialNo %>','<%=SectionName%>','<%=Loft %>','');aad2(s<%=num %>,150);"><%=Loft %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
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
 <img src="../images/tree.gif" border=0 align="absmiddle" hspace="4" ><a href="#" onclick="FindPro('<%=SectionSerialNo %>','<%=SectionName%>','<%=Loft %>','<%=Build %>');aad2(s<%=num %>,150);"><%=Build %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
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
 <script language="JavaScript">
    function FindPro(para1,para2,para3,para4){
 
	parent.frmright.document.forms[0].SecNo.value=para1;
	parent.frmright.document.forms[0].secname.value=para2;
	parent.frmright.document.forms[0].Loft.value=para3;
	//parent.frmright.document.forms[0].build.value=para4;
	if (parent.frmright.document.forms[0].action=="")
   parent.frmright.document.forms[0].action="JlManage.jsp";
parent.frmright.document.forms[0].submit();
	
	}
    function searchcus(){

	parent.frmright.document.forms[0].cusname.value=document.cus.speedcusname.value;
	parent.frmright.document.forms[0].secname.value=document.cus.secname1.value;
		if (parent.frmright.document.forms[0].action=="")
	parent.frmright.document.forms[0].action="JlManage.jsp";
	parent.frmright.document.forms[0].submit();
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
