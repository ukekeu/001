<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">

<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>¥�����Ϲ���</title>
</head>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="chekcProject" scope="page" class="ConnDatabase.menu"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>

<script language="javascript" src="../public_js/public.js"></script>
 
<script>
	 	 function printView(){
		 		   openwin2("auto_select.jsp?PARA_SQL=ViewSectionData&url=18&reporttype=sale&tablename=",700,300,20,10);
		}		
	 
	</script>
<body oncontextmenu="return false"   >


<form method="POST" name="cus" action="crm_Project_list.jsp">

     <%
   
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B003");
   if (Cortrol==null)Cortrol="";
 out.print(chekcProject.doReadProject(Cortrol));
%>
 
			  <script>
			  var startnum="";
			  var parasecname="";
			  var parasecno="";
			  function EditInto(){
			  
   	              if (startnum==""){alert("��ѡ��¥��(ֻ�赥���б���ĳ��һ��)");}
		          else
				  openwin2("crm_project_modi.jsp?ID="+startnum,650,480,100,10);
		
  		       }
			  function Dele(){
			    if (confirm("���Ҫɾ��ѡ���¥����Ϣ��(ϵͳ��ɾ��������¥���й����ϡ�)")){
   	              if (startnum==""){alert("��ѡ��¥��(ֻ�赥���б���ĳ��һ��)");}
		          else{window.location="crm_ProjectDelete.jsp?SecNo="+parasecno+"&param=<%=request.getParameter("param")%>"; }
				}  
  		       }
              
  		      
			  function savepara(para,para1,para2){
			    startnum=para;
			    parasecname=para2;
			    parasecno=para1;
			  }
			  function setSubmit(){
			    if (parasecno=="")alert("��ѡ��¥��");
			    else{
				  document.cus.SetNo.value=parasecname+"*"+parasecno;
				  document.cus.action="crm_Project_list.jsp";
				  document.cus.submit();
				
				}
			  }
			   function setSubmit1(){
			    if (parasecno=="")alert("��ѡ��¥��");
			    else{
				 window.location='BuildingView.jsp?SecNo='+parasecno+'&SecNa='+parasecname;
				  
				}
			  }
			 
			 
			  </script>

</body>
</form>
</html>



