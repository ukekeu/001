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
<body  class=tree oncontextmenu="return false"  >
<form method="POST" name="cus"  >
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
    <img src="../images/plus4.gif" border=0 align="absmiddle" hspace="4"  name="uptown_<%=SectionSerialNo%>" onclick="changesrc(this);document.all.T<%=SectionSerialNo%>.style.display=(document.all.T<%=SectionSerialNo%>.style.display=='none')?'block':'none';"><a href="#" onclick="document.all.T<%=SectionSerialNo%>.style.display=(document.all.T<%=SectionSerialNo%>.style.display=='none')?'block':'none';"><%=SectionName%></a>
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
  <img src="../images/document1.gif" border=0 align="absmiddle" hspace="4" ><a href="#" onclick="loca('<%=SectionSerialNo %>','<%=Loft %>','<%=SectionName %>');aad2(s<%=num %>,200);"    title='单击后在右边查看按揭进度' ><%=Loft %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
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
 <img src="../images/tree.gif" border=0 align="absmiddle" hspace="4" ><a href="../afterservice/AjListS.jsp?SecNo=<%=SectionSerialNo %>&Loft=<%=Loft %>&SecName=<%=SectionName %>&Build=<%=Build %>" target="frmright"    title='单击后在右边查看按揭进度' onclick="aad2(s<%=num %>,200);"><%=Build %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >

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
    function searchcus(){
 	parent.frmright.document.forms[0].action="AjListS.jsp";
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


<script>
  function chooseClick(para1,para2,para3,para4,para5){
  		if (parent.frmright.document.frm.SecNo) {
	        parent.frmright.document.frm.SecNo.value=para1;
			parent.frmright.document.frm.Loft.value=para2;
			parent.frmright.document.frm.SecName.value=para3;
			parent.frmright.document.frm.Build.value=para4;
		}
	  }
 function ch(){
   var dd=parent.frmright.document.frm.SecNo.state1.length;
  
 
 }
 function loca(para1,para2,para3){
  var sel="0";
  if (parent.frmright.document.forms[0].sel)
     sel=parent.frmright.document.forms[0].sel.value;
 if (para2!=""){
  if (parent.frmright.document.forms[0].action=="")
  parent.frmright.location="../afterservice/AjListS.jsp?SecNo="+para1+"&Loft="+para2+"&SecName="+para3+"&sel="+sel;
 else
    parent.frmright.location=parent.frmright.document.forms[0].action+"?SecNo="+para1+"&Loft="+para2+"&SecName="+para3+"&sel="+sel;

 // parent.frmright.document.forms[0].submit();
  }
 }
 function loca1(para1,para2){
 if (para2!=""){
 if (parent.frmright.document.forms[0].action=="")
  parent.frmright.document.forms[0].action="../afterservice/AjListS.jsp?SecNo="+para1+"&Loft=&SecName="+para2;
else
    parent.frmright.document.forms[0].action=parent.frmright.document.forms[0].action+"?SecNo="+para1+"&Loft=&SecName="+para2;
   parent.frmright.document.forms[0].submit();
  }
 }
</script>

</form>
</body>

</html>
