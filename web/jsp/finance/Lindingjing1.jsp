<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase"/> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>

<html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<head>
	<title>�ٶ��������1d</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
 
<%
String SQLwhere="";
SQLwhere=getbyte1(request.getParameter("section"));
if (!SQLwhere.equals("")) SQLwhere=" and r.seccode='"+SQLwhere+"'";
String cusname=getbyte1(request.getParameter("cusname"));
String roomno=getbyte1(request.getParameter("roomno"));
String orderbytype=China.getParameter(request,"orderbytype");
String orderby=China.getParameter(request,"orderby");

//����ʽ
	if (!orderbytype.equals("")&&!orderby.equals("")){
	  if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by startdate desc";
	  if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by startdate asc";
	  if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by cus_name desc";}
	  if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by cus_name asc";
	    if (orderbytype.equals("2")&&orderby.equals("0")) {orderby=" order by room_code desc";}
	  if (orderbytype.equals("2")&&orderby.equals("1")) orderby=" order by room_code asc";
	}else{
	orderby=" order by  startdate desc";
	
	}
String choos =    getbyte( request.getParameter( "choos" ) ) ;
if (choos.equals("")||choos.equals("0"))choos="0";
else if (choos.equals("1"))choos="1";
else if (choos.equals("2"))choos="2";

String findStr="";
if (choos.equals("0"))findStr+=" and fact_dj=0 ";
else findStr+=" and fact_dj>0 ";

String state= getbyte( request.getParameter( "stateshow" ) ) ;
if (state.equals(""))state="0";
 %>
 <script>
function full(){
 setSelectMad(document.frm.orderbytype,'<%=orderbytype %>');
 setSelectMad(document.frm.orderby,'<%=China.getParameter(request,"orderby") %>');
setSelectMad(document.frm.stateshow,'<%=state%>');

setSelectMad(document.frm.section,'<%=request.getParameter("section") %>');
}

</script>
<body onload="full()">
 <form name=frm method=post >
    <p align="center"><font size=3>�ٶ�������ϸ��</font></p>
	<!-- <img src="../picture/button_tg.gif" title="������ȡ"  onclick="openwin('InputDj.jsp?code='+room_code,550,480,100,10);"><img  src="../picture/button_xg.gif" title="�޸�" onclick="openwin('InputDj.jsp?code='+room_code,550,480,100,10);" > -->
 ¥�̣�<select name="section" onchange="changesub(this.value);"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
    
	  ResultSet rs2=bBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>&nbsp;����:<select name="orderbytype"  onchange="document.frm.submit();">
        <option value=2>���ٶ�����</option>
	 <option value=0>���ٶ�����</option>
	 <option value=1>���ͻ�����</option>
	 </select>
	 <select name="orderby" onchange="document.frm.submit();">
     <option value=0>����</option>
	 <option value=1>����</option>
	 </select>
	 <select name="stateshow" onchange="document.frm.submit();">
     <option value=1>���Ϲ�</option>
	 <option value=0>δ�Ϲ�</option>
	 </select><br>�ͻ����ƣ�	 <input type=text name=cusname>&nbsp;��λ��	 <input type=text name=roomno>&nbsp;<input type=button name=ok value="�� ѯ" onclick="document.frm.submit();"><input name="choos" type="radio" value=1 <%if (choos.equals("1"))out.print("checked"); %> onclick="zh();">���ն���<input name="choos" type="radio" value=2 <%if (choos.equals("2"))out.print("checked"); %> onclick="zh2();">���˶���<input name="choos" type="radio" value=0 onclick="zh1();" <%if (choos.equals("0"))out.print("checked"); %>>δ�ն���
  <%@ include file="../public_js/qx_checke.jsp"%>
  <%
//Ȩ�����
String Cortrol=checke_qx(bBean,(String)session.getAttribute("loginid"),"F002");
    if (Cortrol==null)Cortrol="";
    %>
	 
<% 
    if (Cortrol.indexOf("A")>=0){ %> 
   
  <!-- <input type=button name=modi value="�տ�/�˿�" title="�޸ĳ���ͻ���������" onclick="refEdit_i();">-->
   
   <% }if (Cortrol.indexOf("E")>=0){ %>
  
     
  <%} if (Cortrol.indexOf("F")>=0){ %>
 
 
<input type=button name=modi value="����EXCEL" title="����֮ǰ��ѡ����Ŀ����" onclick="outexcel();">
 <%} %>
<table BORDER=0 width="102%" CELLSPACING=0 CELLPADDING=0 bordercolor="#FFFFFF" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
      <td  ><font color=white>���</font></td>
	  <td  ><font color=white>�ͻ�����</font></td>
      <TD  ><font color=white>�ٶ���λ</font></td>
	  <td ><font color=white>�ٶ�����</font></td>
	  <td  ><font color=white>��ȡ����</font></td>
	  <td  ><font color=white>��ȡ����</font></td>
	
	   
	  <td ><font color=white>״̬</font></td>
	  <td  ><font color=white>�Ǽ�</font></td>
	    <td  ><font color=white>��ӡ</font></td>
   </tr>  
 <%
 String vv=getbyte1(request.getParameter("section"));
 if (!vv.equals(""))SectionS="'"+request.getParameter("section")+"'";
String SQL="SELECT  s.id,s.roomcode,c.cus_name,l.name+r.loft+r.building+r.Room_code Room_code,s.StartDate,s.fact_dj,s.fact_date,s.billtype,s.bill_num,s.paytype,s.zto,s.tk  from  SL_TemporarilyBuy s,room r,customer c,CRM_Project l where  s.fact_dj>0 and s.tk+s.tk1=0 and  s.Cusname=c.serialno and s.RoomCode=r.code and r.seccode=l.serialno and r.seccode in ("+SectionS+")";
 if (!cusname.equals(""))
	 SQL+=" and c.cus_name like '%"+cusname+"%'";
 if (!roomno.equals(""))
	 SQL+=" and r.room_code like '%"+roomno+"%'";

 
ResultSet rs=aBean.executeQuery(SQL+findStr+ " and zto=" + state+ orderby);
 int i=0;
 
 while (rs.next()){ 
 i++;
  String sate=getbyte(rs.getString("zto")) ;
 %>
    <tr <% if (sate.equals("0")){ %> ondblclick="openwin('InputDj.jsp?ldid=<%=getbyte(rs.getString("id")) %>&code=<%=getbyte(rs.getString("roomcode")) %>',580,480,100,10);" <%} %>id=TR<%=i %>  class=listcontent  align="center"  onmouseover="mout(this);"  onclick="savepara('<%=getbyte(rs.getString("roomcode"))%>');changeclass1(this,'clickbg','listcontent');" title="˫������ȡ�Ǽ�">
      <td  > <%=i %></td>
	  <td  align="left" > <%
	  
	  String cus_name= getbyte(rs.getString("cus_name"));
	  out.print(cus_name);
	   %> </td>
      <TD align="left" > <%=getbyte(rs.getString("room_code")) %> </td>
	  <td > <%=getbyte(rs.getDate("StartDate").toString()) %> </td>
	  <td  ><%	  String factdj=rs.getString("fact_dj");
	   out.print(factdj);
	  %> </td>
	    <td  ><%=rs.getDate("fact_date").toString() %> </td>
	  
	  <td > <%
	 
	  float tk=rs.getFloat("tk");
	  if (tk==0){
	   if (sate.equals("0"))sate="δ��ת";
	   if (sate.equals("1"))sate="�ѽ�ת";
	      out.print(sate);
	}else{out.print("�˶�");}	  
	   %> </td>
	    <td><a href="#" onclick="openwin('InputDj.jsp?ldid=<%=getbyte(rs.getString("id")) %>&code=<%=getbyte(rs.getString("roomcode")) %>',580,480,100,10);">�Ǽ�</a></td>
	    <td ><img src="../images/icon_print.gif" alt='��ӡ�����վ�' onclick="openwin('printld.jsp?rowID=<%=getbyte(rs.getString("roomcode")) %>&REF_name=<%=cus_name %>');" onmouseover="javascript:this.style.cursor='hand'"></td>
          </td>
   </tr>  
 
 <%}rs.close(); %>  
 </form>
 </table>
<script>

  function refEdit_i(){
  openwin("InputDj.jsp?code="+room_code,580,480,100,10);
  
  }
  function outexcel(){
    if (document.frm.section.value==""){alert("��ѡ����Ŀ");return false;}
	  window.open("lingdj_excel.jsp?section="+document.frm.section.value)
  
  }
function zh(){
  document.frm.action="Lindingjing1.jsp?choos=1";
document.frm.submit();

  }
   function zh1(){
  document.frm.action="Lindingjing.jsp?choos=0";
document.frm.submit();

  }
  function zh2(){
  document.frm.action="Lindingjing2.jsp?choos=2";
document.frm.submit();

  }
var room_code="";
 function savepara(para){
	  room_code=para;
  }
  function changesub(para){
		//document.frm.Findsection.value=para;
  		document.frm.submit();
			
			}
			setSelectMad(document.frm.section,'<%=request.getParameter("section") %>');
</script>
</body>
</html>
