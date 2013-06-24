<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

 
 <%@ include file="../public_js/qx_checke.jsp"%>
 
<html>
<head>
	<title>客户选房试算</title>
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
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%
 

String strMessage=China.getParameter(request,"mess");
String SecName=request.getParameter("SecName");
String Region=China.getParameter(request,"Region");
String condi=China.getParameter(request,"condi");

String RegionStr="";
   
String state="";
String fontColor="";
String strYN=request.getParameter("yn");
String strSection="";


String Loft="";
String strBuilding="";
   String  []  Lofts=request.getParameterValues("Loft");
     Loft="";
if (Lofts!=null){
for (int a=0;a<Lofts.length;a++){
       if (Loft.equals(""))  Loft="'"+getbyte1(Lofts[a])+"'";
	   else Loft+=",'"+getbyte1(Lofts[a])+"'";
    }
   }
   if(Loft.equals(""))  Loft="''";

%> 
<SCRIPT language=javascript>
 
 
function submitC(){
  document.frm.action="ChooseCount.jsp";
  document.frm.submit();


}
function getseldocs1() {
     var x=0;
	 var seldocs = new Array();
     var seldocs1 = new Array();
	 var temp=document.frm.elements.length;
 
     for (i=0;i<document.frm.yl.length;i++) {
	 if (document.frm.yl[i].checked)
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
function ylroom(){
    var rooms=getseldocs1();
    if (rooms==""){alert("请选择预留的房间！");return false;}
    var url="add_yl_rooms.jsp?rooms="+rooms+"&loft=<%=Loft %>&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
    var newWin = window.open(url,"roomfrm","height=350,width=510,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
    newWin.focus() ;
}
function choose(para){

  for (i=0;i<document.frm.elements.length;i++) {
 
 if((document.frm.elements[i].type=="checkbox")&&(document.frm.elements[i].value==para)&&(document.frm.elements[i].name=="yl"))
   document.frm.elements[i].checked=true;
   else document.frm.elements[i].checked=false;
}
}
function openwinzy(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
   var sendmess="";
function chhoseData1(){
sendmess="";
   for (var i=0;i<document.frm.chooseroom.length;i++){
 	 
	  if (document.frm.chooseroom[i].checked){
	    var aa=document.frm.chooseroom[i].value;
		
	    if (sendmess!="")
		 
		 sendmess+=","+aa;
	    else
		   sendmess=aa;
	    document.frm.chooseroom[i].checked=false;
	  }
    }
	 if (sendmess==""){alert("请选择需要试算的单位");}
	 else { openwinzy("zy1.jsp?code="+sendmess+"&yh="+document.frm.yh.value+"&hy="+document.frm.hy.value,550,450,100,100);}

}
</script >	 
<body oncontextmenu="return false"  topmargin="1" onload="setSelectMad(document.frm.section_select,'<%=getbyte1(request.getParameter("section_select")) %>');">
 


 
<form name=frm method="post" action="ChooseCount.jsp">
 
 
 
<table width="98%"  border="0">

<tr> 
<%@ include file="../public_js/CheckSection.jsp"%>
<%   strSection=getbyte1(request.getParameter("section_select"));
int aaa=0;
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
	  ResultSet rs2=InsertBean2.executeQuery(sql);
	
	  String sec="";
	  String no="";
  %> <td  width="100%"  >
 &nbsp;<select name="section_select" style="width:117" onchange="frm.submit();"> 
 <option value="">请选择楼盘名称<option>
<%
while (rs2.next()){
	   no=rs2.getString("SerialNo");
	 
	   sec=getbyte(rs2.getString("Name"));
	     if (strSection.equals(no))SecName=sec;
		   out.print("<option value='"+no+"'>"+sec+"</option>");
		
	  }
	    rs2.close();
     %> </select><font color=red>*</font> </td> 
	 </tr>
	 <tr>
	 <td    width="100%"  >   
	 
	 <%
	 String sqlUser = "select  loft from Sectiontree where  SerialNo='"+strSection+"' group by loft";

ResultSet userRs = InsertBean2.executeQuery(sqlUser) ;
while (userRs.next()) {
String housename = userRs.getString("loft") ;
 
	  %>
	  <input name="Loft" type="checkbox" <%if (Loft.indexOf(housename)>0){out.print("checked");} %> value="<%=housename %>"><%=housename %>
	  <%}userRs.close(); %>
	  </td>
	 </tr>
	 <tr><td> <input type=submit name=find value="请选择楼栋后再确认[搜 索]"  onclick="frm.submit();"> </td></tr>
 
</table>
 
<%
 
if (!Loft.equals("''")){
String manSQL="select roomtype,sum(readnum) readnum FROM room where seccode='"+strSection+"'";
 
manSQL+=" and Loft in ("+Loft+")";
 
manSQL+=" group by roomtype order by roomtype";
 
ResultSet manRS=null;
ResultSet manRS1=null;
 manRS=InsertBean2.executeQuery(manSQL);
 if (!Loft.equals("")){
 out.print("  <table width='70%' align='center'><tr  class=TXTColor ' align='center'><td width='20%'>户型</td><td width='15%'>试算次数</td><td>奇数层试算次数</td><td>偶数层试算次数</td></tr>");
 while (manRS.next()){
 aaa++;
 
  
   %>
 
   <tr ' align='center'><td width="20%"><%=getbyte(manRS.getString("roomtype")) %></td><td><%=getbyte(manRS.getString("readnum")) %></td> 
 
   

   
   <%  
   
     manSQL="select  sum(readnum) readnum FROM room where Floor % 2 <> 0  and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
	manSQL+=" and roomtype ='"+getbyte(manRS.getString("roomtype"))+"'";
    manRS1=InsertBean.executeQuery(manSQL);
	String jsc="0";
	
    if (manRS1.next()){
	  jsc=getbyte(manRS1.getString("readnum"));
	}manRS1.close();
   
     manSQL="select  sum(readnum) readnum FROM room where Floor % 2= 0  and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
	manSQL+=" and roomtype ='"+getbyte(manRS.getString("roomtype"))+"'";
    manRS1=InsertBean.executeQuery(manSQL);
	String ous="0";
	
    if (manRS1.next()){
	  ous=getbyte(manRS1.getString("readnum"));
	}manRS1.close();
    %>
   <td><%=jsc %></td>  <td><%=ous %></td> 
   <%
   
   }
   manRS.close();
  
   out.print("</tr></table>");
   
   out.print("<hr width='70%' >");
   
    manSQL="select  sum(readnum) readnum FROM room where floor<10 and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
  
   if (!Loft.equals("")){
   out.print("  <table width='70%' align='center'><tr  class=TXTColor align='center'><td width='20%'>楼层范围</td><td width='15%'>试算次数</td><td bgcolor='#FFFFFF'></td></tr><tr ' align='center'>");
     manRS=InsertBean2.executeQuery(manSQL);
   if (manRS.next()){
   out.print("<td>10层以内</td><td>"+getbyte(manRS.getString("readnum"))+"</td>");
   %>
   <td>
   <table width='100%' >
   
<%
 
 
   manSQL="select roomtype,sum(readnum) readnum FROM room where floor<10 and  seccode='"+strSection+"'";
 
manSQL+=" and Loft in ("+Loft+")";
 
manSQL+=" group by roomtype order by roomtype";
 
 
 
 manRS=InsertBean2.executeQuery(manSQL);
 if (!Loft.equals("")){
  out.print(" <tr   align='center'><td>户型</td><td>试算次数</td><td>奇数层试算次数</td><td>偶数层试算次数</td></tr>");
   while (manRS.next()){
 
 
  
   %>
 
   <tr ' align='center'><td><%=getbyte(manRS.getString("roomtype")) %></td><td><%=getbyte(manRS.getString("readnum")) %></td> 
 
   

   
   <%  
   
     manSQL="select  sum(readnum) readnum FROM room where floor<10 and Floor % 2 <> 0  and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
	manSQL+=" and roomtype ='"+getbyte(manRS.getString("roomtype"))+"'";
    manRS1=InsertBean.executeQuery(manSQL);
	String jsc="0";
	
    if (manRS1.next()){
	  jsc=getbyte(manRS1.getString("readnum"));
	}manRS1.close();
   
     manSQL="select  sum(readnum) readnum FROM room where floor<10 and Floor % 2= 0  and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
	manSQL+=" and roomtype ='"+getbyte(manRS.getString("roomtype"))+"'";
    manRS1=InsertBean.executeQuery(manSQL);
	String ous="0";
	
    if (manRS1.next()){
	  ous=getbyte(manRS1.getString("readnum"));
	}manRS1.close();
    %>
   <td><%=jsc %></td>  <td><%=ous %></td> 
   <%
   
   }
   manRS.close();
  
   out.print("</tr></table>");
   }
   %>
   
   
   </table>
   
   </td>
   <%
   
   
   
   }
     manRS.close();
   
   }
    
   out.print("<hr width='70%' >");
   
    manSQL="select  sum(readnum) readnum FROM room where floor>=10 and floor<=20 and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
  
   if (!Loft.equals("")){
   out.print("  <table width='70%' align='center'><tr  class=TXTColor ' align='center'><td width='20%'>楼层范围</td><td width='15%'>试算次数</td><td bgcolor='#FFFFFF'> </td></tr><tr ' align='center'>");
     manRS=InsertBean2.executeQuery(manSQL);
   if (manRS.next()){
   out.print("<td>10层到20层</td><td>"+getbyte(manRS.getString("readnum"))+"</td>");
   %>
   <td>
   <table width='100%' >
   
<%
 
 
   manSQL="select roomtype,sum(readnum) readnum FROM room where floor>=10 and floor<=20 and  seccode='"+strSection+"'";
 
manSQL+=" and Loft in ("+Loft+")";
 
manSQL+=" group by roomtype order by roomtype";
 
 
 
 manRS=InsertBean2.executeQuery(manSQL);
 if (!Loft.equals("")){ 
 out.print(" <tr   align='center'><td>户型</td><td>试算次数</td><td>奇数层试算次数</td><td>偶数层试算次数</td></tr>");
  while (manRS.next()){
 
 
  
   %>
 
   <tr ' align='center'><td><%=getbyte(manRS.getString("roomtype")) %></td><td><%=getbyte(manRS.getString("readnum")) %></td> 
 
   

   
   <%  
   
     manSQL="select  sum(readnum) readnum FROM room where floor>=10 and floor<=20 and Floor % 2 <> 0  and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
	manSQL+=" and roomtype ='"+getbyte(manRS.getString("roomtype"))+"'";
    manRS1=InsertBean.executeQuery(manSQL);
	String jsc="0";
	
    if (manRS1.next()){
	  jsc=getbyte(manRS1.getString("readnum"));
	}manRS1.close();
   
     manSQL="select  sum(readnum) readnum FROM room where floor>=10 and floor<=20 and Floor % 2= 0  and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
	manSQL+=" and roomtype ='"+getbyte(manRS.getString("roomtype"))+"'";
    manRS1=InsertBean.executeQuery(manSQL);
	String ous="0";
	
    if (manRS1.next()){
	  ous=getbyte(manRS1.getString("readnum"));
	}manRS1.close();
    %>
   <td><%=jsc %></td>  <td><%=ous %></td> 
   <%
   
   }
   manRS.close();
  
   out.print("</tr></table>");
   }
   %>
   
   
   </table>
   
   </td>
   <%
   
      
   }
     manRS.close();
   
   }
   
      
   out.print("<hr width='70%' >");
   
    manSQL="select  sum(readnum) readnum FROM room where floor>20 and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
  
   if (!Loft.equals("")){
   out.print("  <table width='70%' align='center'><tr  class=TXTColor ' align='center'><td width='20%'>楼层范围</td><td width='15%'>试算次数</td><td bgcolor='#FFFFFF'></td></tr><tr ' align='center'>");
     manRS=InsertBean2.executeQuery(manSQL);
   if (manRS.next()){
   out.print("<td>20层以上</td><td>"+getbyte(manRS.getString("readnum"))+"</td>");
   %>
   <td>
   <table width='100%' >
   
<%
 
 
   manSQL="select roomtype,sum(readnum) readnum FROM room where floor>20 and  seccode='"+strSection+"'";
 
manSQL+=" and Loft in ("+Loft+")";
 
manSQL+=" group by roomtype order by roomtype";
 
 
 
 manRS=InsertBean2.executeQuery(manSQL);
 if (!Loft.equals("")){
 out.print(" <tr   align='center'><td>户型</td><td>试算次数</td><td>奇数层试算次数</td><td>偶数层试算次数</td></tr>");
 while (manRS.next()){
 
 
  
   %>
 
   <tr ' align='center'><td><%=getbyte(manRS.getString("roomtype")) %></td><td><%=getbyte(manRS.getString("readnum")) %></td> 
 
   

   
   <%  
   
     manSQL="select  sum(readnum) readnum FROM room where floor>20 and Floor % 2 <> 0  and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
	manSQL+=" and roomtype ='"+getbyte(manRS.getString("roomtype"))+"'";
    manRS1=InsertBean.executeQuery(manSQL);
	String jsc="0";
	
    if (manRS1.next()){
	  jsc=getbyte(manRS1.getString("readnum"));
	}manRS1.close();
   
     manSQL="select  sum(readnum) readnum FROM room where floor>20 and Floor % 2= 0  and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
	manSQL+=" and roomtype ='"+getbyte(manRS.getString("roomtype"))+"'";
    manRS1=InsertBean.executeQuery(manSQL);
	String ous="0";
	
    if (manRS1.next()){
	  ous=getbyte(manRS1.getString("readnum"));
	}manRS1.close();
    %>
   <td><%=jsc %></td>  <td><%=ous %></td> 
   <%
   
   }
   manRS.close();
  
   out.print("</tr></table>");
   }
   %>
   
   
   </table>
   
   </td>
   <%
   
   
   
   }
     manRS.close();
   
   }
   
      out.print("<hr width='70%' >");
       manSQL="select  sum(readnum) readnum FROM room where Floor % 2 <> 0  and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
  
   if (!Loft.equals("")){
   
   out.print("  <table  width='70%' align='center'><tr  class=TXTColor ' align='center'><td>奇数层试算次数</td><td>偶数层试算次数</td></tr><tr ' align='center'>");
     manRS=InsertBean2.executeQuery(manSQL);
   if (manRS.next()){
   out.print("<td>"+getbyte(manRS.getString("readnum"))+"</td>");
   }
     manRS.close();
 
   }
   
          manSQL="select  sum(readnum) readnum FROM room where Floor % 2 = 0  and seccode='"+strSection+"'";
	if(Loft.equals(""))  Loft="''";
	manSQL+=" and Loft in ("+Loft+")";
  
   if (!Loft.equals("")){
  
     manRS=InsertBean2.executeQuery(manSQL);
   if (manRS.next()){
   out.print("<td>"+getbyte(manRS.getString("readnum"))+"</td>");
   }
     manRS.close();
   out.print("</tr></table>");
   }
    }
	}
	%>

 
</form>  
 

</body>
</html>
