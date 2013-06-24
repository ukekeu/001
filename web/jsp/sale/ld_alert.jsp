<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>临定到期提醒</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%
  String code1=getbyte1(request.getParameter("code"));
 
  if (!code1.equals("")){
   ViewBean.executeUpdate("delete YLroom where code="+code1);
  setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "预留操作" , 
                  "取消"
                ) ;
 
  
  }
String menu= (String)session.getAttribute("menu");
 
if (menu==null)menu="1";
    String menusel=China.getParameter(request,"menusel");
    if(menusel.equals("")) menusel="3";
 %>
<%@ include file="../public_js/getByteOut.jsp"%> 
 

<%@ include file="../public_js/CheckSection.jsp"%>

<%@ include file="../public_js/qx_checke.jsp"%>
  

<body onload=" setSelectMad(document.form1.section,'<%=request.getParameter("section") %>');" topmargin="0" oncontextmenu="return false" >
<form name=form1 method="post" >
<input type=hidden name="SDate">
<input type=hidden name="EDate2">
<input type=hidden name="custype">
<input type=hidden name="gmyt">
<input type=hidden name="tel">
<input type=hidden name="age">
<input type=hidden name=cusname>
<input type=hidden name=FindS>
<input type=hidden name=Findsection>
<input type=hidden name=condi>
  <input type=hidden name="menusel" value="<%=menusel %>">
<table width="320" border="0" cellspacing="0" cellpadding="0" class="L2"  >
  <tr> 
    <td  class="<%if(menusel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=3;findSub('visitcusview_alert.jsp');""><font color='<%if(menusel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>跟进提醒</a>
	</td>
     <td  class="<%if(menusel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=0;findSub('yl_alert.jsp');""><font color='<%if(menusel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>预留提醒</a>
	</td>
	  <td  class="<%if(menusel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=2;findSub('ld_alert.jsp');""><font color='<%if(menusel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>临定提醒</a>
	</td>
   <td class="<%if(menusel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#"onclick="document.form1.menusel.value=1;findSub('QYCustomer.jsp');""><font color='<%if(menusel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>签约提醒</a>
	</td> 
	</tr>
</table>
<p align=center class=FontColor><font size=3><b>临定到期一览表</b></p>
<% String sel=(String)request.getParameter("sel");
      if(sel==null) sel="0";
   int colnum=0;
   int iiii=0;
    
    %> 
	  <input type=hidden name="grade" >
  <input type=hidden name="sel" value="<%=sel %>">
  
	<script>
function findSub(para){
   document.form1.action=para+"?Search=b&Find=b";
   document.form1.submit();


}
</script>
 <%
//权限审核
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"C002");
 %>
 
 
   <table width=100% border="0"><tr height="16"  ><td align="left">楼盘：<select name="section" onchange="changesub(this.value);"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
 
<script>
			function printall() {
			   	printdiv.innerText ="";
                 print(); 
			}
			function ordersubmit(){
			 if (document.form1.section.value!="")
			     changesub(document.form1.section.value);
			 document.form1.submit();	 
			}
			function changesub(para){
			document.form1.Findsection.value=para;
			
			document.form1.Find.value="o";
	 			document.form1.submit();
			
			}
</script>
<input type=hidden name="Find">
<input type=hidden name="Findsection">
<input type=hidden name="cusname">
<input type=hidden name="condi">
<input type=hidden name="age">
<input type=hidden name="tel">
<input type=hidden name="condi1">
<input type=hidden name="SDate1">
<input type=hidden name="Date2">
<input type=hidden name="custype">
<input type=hidden name="gmyt">
<input type=hidden name="cusche">
 


<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"   bgcolor="efefef" >
    <td>序号</td>  <td>姓名</td><td>电话</td> <td>临定日期</td><td>到期日期</td><td>房号</td>  <td>面积</td> <td>临定总价</td><td>付款方式</td><td>已交定金</td><td>交款日期</td><td>业务员</td>   
  </tr>	
  <%
  
   String SQL="select * from  View_LdList where salestate=5 and state=0 and    substring(CONVERT(char(24), EndDate, 120),1,10)<=convert(char(10),getdate(),120)";
   String section=getbyte1(request.getParameter("section"));
   if (!section.equals(""))
   SQL+=" and seccode='"+section+"'";
ResultSet rs=  ViewBean.executeQuery(SQL);
 
 int i=0;
  
  try{
  while (rs.next()) {i++;%>  
   <tr align="center"> 
    <td><%=i%></td>  <td><%=getbyte(rs.getString("cus_name")) %></td>
	<td><%=getbyte(rs.getString("tel"))+" "+ getbyte(rs.getString("sj"))%>&nbsp;</td>
	<td><%=getbyte(rs.getString("StartDate"))%></td>
	<td><%=getbyte(rs.getString("EndDate")).substring(0,10)%></td>
	 <td><%=getbyte(rs.getString("loft"))+getbyte(rs.getString("building"))+getbyte(rs.getString("room_code")) %>&nbsp;</td>
	   <td><%=getbyte(rs.getString("area")) %>&nbsp;</td> 
	   <td><%=getbyte(rs.getString("saleprice")) %>&nbsp;</td>  
	      <td><%=getbyte(rs.getString("payment")) %>&nbsp;</td>  
	   <td><%=getbyte(rs.getString("fact_dj")) %>&nbsp;</td>  
	   <td><%=getbyte(rs.getString("fact_date")) %>&nbsp;</td>  
	     <td><%=getbyte(rs.getString("receiver")) %>&nbsp;</td>   
  </tr>	
  
  <%}rs.close();  
   
   
}catch(Exception s){out.println(s.getMessage());}
 

 

 %> 
 
 <input type=hidden name=code value="">
</form>
</center>

<script>
 
   var cusno="";
    function Edit(para){
    	
   	         if (cusno==""){alert("请选择客户(只需单击列表中某行一次)");}
		     else{ openwin("CusFeedBack.jsp?cusno="+para,560,560,100,5);}
	
	}

	function Dele(){
	 if (confirm("真的要删除选择的客户信息吗？")){
	    chhoseData11();
		 
	    if (cusno==""&&choosecusno=="")
   	      {alert("请选择客户(只需单击列表中某行一次)");}
		else{
		
		
		openwin("deletecusdata.jsp?del=cus&cusno="+cusno+"&choosecusno="+choosecusno,10,10,10,10);}
	  }
	}
	
	function view(){
	  if (cusno==""){alert("请选择客户(只需单击列表中某行一次)");}
		   else{openwin("editcustomer.jsp?cusno="+cusno,560,560,100,5);}
	  }

    function savepara(para){
			  cusno=para;
			 
			  }
  function show(dd,obj){
  var  tr=document.all.AutoNumber.rows;

  for( var i=0;i<tr.length;i++){
    if (tr[i].trid=="tr"+dd)  
	 tr[i].style.display=(tr[i].style.display=="none")?"block":"none";
   }
   
  var img1="jia.gif";
  var img2="jian.gif";
  
  s=obj.src;
  no=parseInt(obj.no);
  if(s.indexOf("jian.gif")>-1){
     obj.src=s.replace("jian.gif","jia.gif");
  }else{
     obj.src=s.replace("jia.gif","jian.gif");
  }
  }
  function addCus(){
    if (document.form1.section.value==""){alert("请选择楼盘名称，以确认增加的客户属于哪个楼盘的来访问客户");return false;}
     openwin('customerin.jsp?section='+document.form1.section.value,620,560,100,5)
   }
   function addCus1(){
    if (document.form1.section.value==""){alert("请选择楼盘名称，以确认增加的客户属于哪个楼盘的来访问客户");return false;}
     openwin('ExcelToCus.jsp?section='+document.form1.section.value,360,260,200,205)
   }
    function addCus2(){
    if (document.form1.section.value==""){alert("请选择楼盘名称，以确认增加的客户属于哪个楼盘的来访问客户");return false;}
    showx = screen.availWidth;  // + deltaX;
	showy = screen.availHeight; // + deltaY;
     	 retval = window.showModalDialog("customerTo.jsp?section="+document.form1.section.value,"","dialogWidth:"+showx+"; dialogHeight:"+showy+"; dialogLeft:150px; dialogTop:20px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	 }
   
  function FindCusState(){
	document.form1.Find.value="o";
    document.form1.Findsection.value=document.form1.section.value;
     document.form1.submit();
  
  }
  function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
	 
    }

}
  function ch(para){
   if (para=="visit_date"){
  fPopUpCalendarDlg(document.form1.search_like);return false;

  }
  else
  document.form1.search_like.value="";
  }
  
  
var sendmess="";
var sendto="";
var choosecusno=""; 
function chhoseData11(){
  choosecusno="";
  if (document.form1.choos.length){
   for (var i=0;i<document.form1.choos.length;i++){
 	
	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].cusno;
	 
	    if (choosecusno=="")
		 choosecusno="'"+aa+"'";
		else
		 choosecusno+=",'"+aa+"'";
	  }
	   
    }
	}else if (document.form1.choos.checked){
	  var aa=document.form1.choos.cusno;
	   choosecusno="'"+aa+"'";
	}
 
}
function ToLs(){
 if (confirm("确认选择的客户已不购房了吗？确认后，请回到流失客户中登记流失原因。"))
 { chhoseData11();
   openwin("toLSCustomer.jsp?cusno="+choosecusno,10,10,10,10);
 
 }
}
function chhoseData1(){
sendmess="";
sendto="";
if (document.form1.choos.length){
   for (var i=0;i<document.form1.choos.length;i++){
 	
	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].value;
		
	    if (sendmess=="")
		 sendmess=aa.substring(0,aa.indexOf("|"));
		else
		 sendmess+=","+aa.substring(0,aa.indexOf("|"));
	  
	    if (sendto=="")
		 sendto=aa.substring(aa.indexOf("|")+1);
		else
		 sendto+=","+aa.substring(aa.indexOf("|")+1);
	  
	  }
    }
	}else if (document.form1.choos.checked){
	 var aa=document.form1.choos.value;
	 sendmess=aa.substring(0,aa.indexOf("|"));
	 sendto=aa.substring(aa.indexOf("|")+1);
	}
}
  function JH(){
 if (confirm("确认选择的客户转为机会客户吗？"))
 { chhoseData11();
  openwin("toJHCustomer.jsp?cusno="+choosecusno,10,10,10,10);
 
 }
}
function sendmessage()
{
chhoseData1();
 
 if (sendmess==""){alert("你选择的客户可能没有留下手机号，请重新选择客户");return false;}
openwin1("../../sendmessage/SendMessage.jsp?messtype=3&sendmess="+sendmess+"&sendto="+sendto,400,300,100,100);
}
  
  </script>

</body>
</html>
