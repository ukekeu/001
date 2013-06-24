<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

 
 <%@ include file="../public_js/qx_checke.jsp"%>
 
<html>
<head>
	<title>交易变更</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js">
</script>
 
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean2" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<jsp:useBean id="saleshow" scope="page" class="sale.saleRoomState" />
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%
 

String strMessage=China.getParameter(request,"mess");
String SecName=China.getParameter(request,"SecName");
String Region=China.getParameter(request,"Region");
String condi=China.getParameter(request,"condi");

String RegionStr="";
   
String state="";
String fontColor="";
String strYN=request.getParameter("yn");
String strSection="";


String Loft="";
String strBuilding="";
 int aaa=0;

%> 
<SCRIPT language=javascript>
 
 
function submitC(){
  document.frm.action="modiRoomCodeShowS.jsp";
  document.frm.submit();


}
function getseldocs1(para) {
     var x=0;
	 var seldocs = new Array();
     var seldocs1 = new Array();
	 var temp=document.frm.elements.length;
 
     for (i=0;i<document.frm.yl.length;i++) {
	 if (document.frm.yl[i].checked&&document.frm.yl[i].ylloft==para)
		 {
       		seldocs[x]="'"+document.frm.yl[i].value+"'";
			seldocs1[x]=document.frm.yl[i].value;
			x++;
   		 }
	  }	
     var returnvalue="";
	  if (seldocs!="")
	   returnvalue=seldocs;//+"/"+seldocs1
   return returnvalue
}

function choose(para,para1){

  for (i=0;i<document.frm.elements.length;i++) {
 
 if((document.frm.elements[i].type=="checkbox")&&(document.frm.elements[i].value==para)&&(document.frm.elements[i].name=="yl")&&(document.frm.elements[i].ylloft==para1))
   document.frm.elements[i].checked=true;
 
}
}
function searcherdata(){

  if (frm.pxshow.value=='1')
  frm.action='modiRoomCodeShowS.jsp';
  else
  frm.action='modiRoomCodeShowS1.jsp'; 
 
  frm.submit();
}

function showfull(){
<%if (!getbyte1(request.getParameter("section_select")).equals("")){ %>
setSelectMad(document.frm.section_select,'<%=getbyte1(request.getParameter("section_select")) %>');
setSelectMad(document.frm.condi,'<%=getbyte1(request.getParameter("condi")) %>');
setSelectMad(document.frm.pxshow,'<%=getbyte1(request.getParameter("pxshow")) %>');
<%} %>
}// 
</script >	 
<body topmargin="1" onload="showfull();" oncontextmenu="return false">
 
<form name=frm method="post" action="modiRoomCodeShowS1.jsp">
 
 <% 
 String SectionS = setpopedom.getSectionlist(); //有权使用楼盘编码  
 out.print(saleshow.BeanshowLoft(getbyte1(request.getParameter("section_select")),request.getParameterValues("showLoft"),SectionS)); 
 strSection=getbyte1(request.getParameter("section_select"));
 String sql="";
 ResultSet rs2=null;
 String sec="";
 String no="";
 String Cortrol=checke_qx(InsertBean,(String)session.getAttribute("loginid"),"QT021");
 if (Cortrol==null)Cortrol="";
 out.print(saleshow.BeanCodeShow(Cortrol,China.getParameter(request,"condi")));
  %>  
  
 
</form>  
  <%InsertBean.closeConn();
  InsertBean1.closeConn();
 InsertBean2.closeConn();
  %>
 <script>
  function opennewwin(url,para,wh,hg,lf,tp) {
   var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
function ylroom(para,para1,para2){
    var rooms=getseldocs1(para2);
    if (rooms==""){alert("请选择预留的房间！");return false;}
	var url="";
	if (para==1) 
      url="add_yl_rooms.jsp?rooms="+rooms+"&loft="+para2+"&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
    else 
	   url="show_yl_rooms.jsp?rooms="+para1+"&loft="+para2+"&&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
  
    var newWin = window.open(url,"roomfrm","height=650,width=710,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
    newWin.focus() ;
}
</script>
</body>
</html>
