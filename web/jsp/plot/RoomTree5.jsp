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
<body  class=tree   oncontextmenu="return false">
<%@ include file="../public_js/CheckSection.jsp"%>
<form method="POST" name="cus" action="SectionView.jsp">
	 
<table border="0" width="120%" cellspacing="0" cellpadding="0">
 
 
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
    <img src="../images/plus4.gif" id=src<%=SectionSerialNo %> border=0 align="absmiddle" hspace="4"  name="uptown_<%=SectionSerialNo%>" onclick="changesrc(this);document.all.T<%=SectionSerialNo%>.style.display=(document.all.T<%=SectionSerialNo%>.style.display=='none')?'block':'none';"><a href="#" onclick="changesrc(src<%=SectionSerialNo %>);document.all.T<%=SectionSerialNo%>.style.display=(document.all.T<%=SectionSerialNo%>.style.display=='none')?'block':'none';chooseClick('<%=SectionSerialNo %>','','<%=SectionName %>','');ChooseForm();"><%=SectionName%></a><!--<a href="../basic/BuildingView1.jsp?SecNo=<%=SectionSerialNo %>&SecName=<%=SectionName%>&Build=<%='a' %>" target="frmright"  onclick="changesrc(document.all.uptown_<%=SectionSerialNo%>);document.all.T<%=SectionSerialNo%>.style.display=(document.all.T<%=SectionSerialNo%>.style.display=='none')?'block':'none';"></a>-->
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
 <tr>
 <td id="buil_<%=Loft%>" class="L2" onclick="changeclassname(this,'BL2','L2');">
 
 <img src="../images/document1.gif" border=0 align="absmiddle" hspace="4" ><a href="#" onclick="chooseClick('<%=SectionSerialNo %>','<%=Loft %>','<%=SectionName %>','');ChooseForm();aad2(s<%=num %>,200);"><%=Loft %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
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
 <img src="../images/tree.gif" border=0 align="absmiddle" hspace="4" ><a href="#" onclick="chooseClick('<%=SectionSerialNo %>','<%=Loft %>','<%=SectionName %>','<%=Build %>');ChooseForm();aad2(s<%=num %>,200);"><%=Build %></a><img src="../images/h.gif"  name="s<%=num %>"  value="<%=num %>" >
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
   model_name=document.cus.model_name.value;
   document.cus.uptownid.value=uptown_id;
   document.cus.buildingid.value=building_id;
   other=document.cus.other.value;
  
}
		  function  changeclassname(src,clrOver,clrIn){ 
             var td = document.cus.tags("TD") ;
			 var tmp=src.id.substring(0,4);
			 if(tmp=="upto"){tmp2="buil";}else{tmp2="upto";}
			 for ( i = 0 ; i < td.length ; i ++ ) {
			 if (td[i].id) {
	     	      var tt = td[i].id ;
			      if (tt.indexOf(tmp) > -1) {
				    if(tt==src.id){
					   document.cus.tags("TD")[i].className=clrOver;
					}else{
					   document.cus.tags("TD")[i].className=clrIn;
					}
			     }
				 if(tt.indexOf(tmp2)>-1){
				   document.cus.tags("TD")[i].className=clrIn;
				 }
			   }
		     }
		  }	
  </script>

<script>
  function chooseClick(para1,para2,para3,para4,para5){
            if (parent.frmright.document.frm.SecNo)
              parent.frmright.document.frm.SecNo.value=para1;
            if (parent.frmright.document.frm.Loft)
              parent.frmright.document.frm.Loft.value=para2;
              if (parent.frmright.document.frm.SecName)
 		parent.frmright.document.frm.SecName.value=para3;
		parent.frmright.document.frm.Build.value=para4;
           
	  }
 function ChooseForm(){
    
	    parent.frmright.document.frm.action="PriceProjectList.jsp";
 
	 parent.frmright.document.frm.submit();	
  }
</script>
</form>
<body>
</html>
