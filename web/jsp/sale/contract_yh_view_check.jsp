<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>�Ż����</title>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
 <%@ include file="../public_js/CheckSection.jsp"%>
 <%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>

<%!
public String toEmpty( String str ) {
    if( str == null ) {
        str = "" ;
    }
    return str ;
}
%>

<% 
 String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT23");
     
 
   String tmp=request.getParameter("pageno");
 
   SecNo=getbyte1(request.getParameter("SecNo"));
 
    FindWhere="  and section='"+SecNo+"'";
 
  

%> 
<%@ include file="../public_js/countpagenum.jsp"%>
 <% 
   String sql=""; 
  
 %>


<%@ include file="../public_js/Repalce.jsp"%>
<%!
 	String user;
	String type;
	boolean rg;
  %> <%
 
   //get session value
    String seller=(String)session.getAttribute("username");
	int totalnum=0;
    String condtion="";		
    String eof="false";
	String sqlWhere="";
    String start="";
    String Loft=getbyte1(request.getParameter("Loft"));
    if (!Loft.equals(""))sqlWhere =" and loft='"+Loft+"'";
    String checkedstate=request.getParameter("state");
	if (checkedstate==null)checkedstate="0"; 
	String checkstate=checkedstate;
	 sqlWhere +=" and state='"+checkedstate+"'";
    String sel=(String)request.getParameter("sel");
    if(sel==null) sel="3";	  	
     ResultSet rs=null; 
			   
		sql="select Top "+pageSize+"  * from order_disc_view where      Code not in (Select top "+prenum +" code from order_disc_view where  code>0  "+sqlWhere+" )    " +sqlWhere ;
		sqlcount="select count(*) as num from order_disc_view where       code>0   " +sqlWhere  ;
	 
		
		String checkedStr="";
		String checkedStr1="";
		
		 
		if (checkedstate.equals("1")){checkedstate=" checkstate=1 and";checkedStr="checked";checkedStr1="";}
		else if (checkedstate.equals("0")){checkedstate= "checkstate=0 and";checkedStr1="checked";checkedStr="";}
%>
 
<body topmargin="1" >
<form action="contract_yh_view_check.jsp" method="post" name="frm">
<input type=hidden name=SecNo value="<%=getbyte1(request.getParameter("SecNo")) %>">
 
<input type=hidden name=Loft value="<%=getbyte1(request.getParameter("Loft")) %>">
 
 

<table width="175" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
   
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('contract_yh_view_check.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�Ż����</font></a>
	</td>
	  <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=5;findSub('contract_check_view.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��ͬ���</font></a>
	</td>
	 
	
	 
	 
   </tr>
  
<input type=hidden name=sel value="<%=sel%>">
 </table>
<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
<p align=center class=FontColor><font size=4><b> </b></font></p>
<table width="100%">
 <tr ><td><input <%=checkedStr %> type=radio name=state value="1" onclick="document.frm.submit();">�����
<input <%=checkedStr1 %> type=radio name=state value="0" onclick="document.frm.submit();">δ���
</td>
   <td align="right">
    <% 
	 if (Cortrol.indexOf("C")>=0){if (checkstate.equals("0")){%>
     <input type=button name=chcq value="���" onclick="checkyh();">
    <%}else{%> <input type=button name=chcq value="ȡ�����" onclick="cancelyh();"><%} }%>
  </td>
 </tr>
</table>
 
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
<td  align="right">���<input type=checkbox name=sh onclick="chooseCheckbox(this.checked);" ></td>
<td  align="center">�ͻ�����</td>
 
<td  align="center">�������</td>
 
<td align="center">���</td>
<td  align="center">�ɽ��ܼ�</td>
 
<td w align="center">���ʽ</td>

<td  align="center">�Ϲ�����</td>
<td  align="center">ǩԼ����</td>
<td w align="center">�Żݷ�ʽ</td>
<td w align="center">�����ۿ�</td>
<td w align="center">�����Ż�</td> 
<td w align="center">�Ż�����</td> 
<td w align="center">��ϵ��</td> 
	<%
	
	try{
		
	rs=ViewBean.executeQuery(sql);
 
	int i=0;
	boolean cq=true;
	 
   while (rs.next()){
	 
     i=i+1;
   //��FIELDS˳��һGET��VALUE
     
       int code=rs.getInt("Code");
	 
     String Customer=getbyte(rs.getString("cus_name"));
	 
	 String loft=getbyte(rs.getString("loft"));
   
	 
     String Room_no=rs.getString("Room_no");

 
	 String area1= rs.getString("jzarea");
	 String payment=getbyte(rs.getString("payment1"));
	 if (payment.indexOf("��")>0)payment=payment.substring(0,payment.indexOf("��")+1);
	 
	 String salerprice= rs.getString("rmbprice");
 	String date=getbyte(rs.getString("rgdate")); 
	 String VisaDate=getbyte(rs.getString("VisaDate")); 
	 String discObj=getbyte(rs.getString("discObj")); 
	 	 String disc_type=getbyte(rs.getString("disc_type")); 
	 String disc=getbyte(rs.getString("disc")); 
	  String disc_date=getbyte(rs.getString("disc_date")); 
	 String gxr=getbyte(rs.getString("gxr")); 
	  String youhui=getbyte(rs.getString("youhui")); 
    
	 
	 
  %>
  
 <tr id=TR<%=i %> align="center" class=listcontent onmouseover="mout(this) ;" Onclick="changeclass1(this,'clickbg','listcontent');"  > 
<td   align="center"><%=i %>
 <input name="aa" value="<%=code %>" type="checkbox">
</td>

<td   align="left">&nbsp;<%=Customer%> </td>
 

<td   align="center">&nbsp;<%=loft+Room_no %>��</td>
 
<td    align="right">&nbsp;<%=area1 %>��</td>
 
<td   align="right">&nbsp;<%=salerprice%></td>

<td  align="left">&nbsp;<%=payment %></td>
<td  align="left"><%=date %>��</td>
<td  align="left"><%=VisaDate %>��</td>
<td  align="left"><%=disc_type %></td>
<td  align="left"><%=disc %></td>
<td  align="left"><%=youhui %></td>
<td  align="left"><%=disc_date %></td>
<td  align="left"><%=gxr %></td>
</tr>
 <%
 }
rs.close();
  out.print("</table>");

}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
 
 %> </table>
   <%@ include file="../public_js/changepage2.jsp"%>
 
 <script language="javascript">
  function chooseCheckbox(para) {//indexstring
     var x=0;
	// var seldocs = new Array();
	var aa="";
	if (frm.elements.length){
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].name=="aa"))
		 {
       		frm.elements[i].checked=para;
			
   		 }
	  }	
	  }
 
}
    function listY(){
	  openwin1("youhuicheckrep.jsp?SecNo=<%=request.getParameter("SecNo")%>&codes="+getseldocs2(),600,500,10,10);
	}
	function checkyh(){
	 
	 
	 if (getseldocs2()==""){alert("��ѡ�����Ż�����ͨ���ĺ�ͬ");return false;}
	 
	 
	 
	   if (confirm("ȷ��ͨ����"))
	   openwin1("yh_checkdj.jsp?codes="+getseldocs2(),500,200,100,100);
	 
	 }
	 function cancelyh(){
	 
	 
	 if (getseldocs2()==""){alert("��ѡ����Ҫȡ���Ż�����ͨ���ĺ�ͬ");return false;}
	 
	 
	 
	   if (confirm("ȷ��ͨ����"))
	   openwin1("yh_canceldj.jsp?codes="+getseldocs2(),500,200,100,100);
	 
	 }
   	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].checked))
		 { 
		    seldocs[x]=frm.elements[i].value ;
			x++;
   		 }
	  }	

   return seldocs ;
}
   
</script> 
</body>
 
</html>
