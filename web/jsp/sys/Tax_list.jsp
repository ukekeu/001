<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%> 
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>˰��/���׷Ѽ��㹫ʽ����</title>
<script language="javascript" src="../public_js/public.js"></script>
<%
  String code=getbyte1(request.getParameter("code"));
  String section_d=getbyte1(request.getParameter("section_d"));
  if (!code.equals("")){
    ViewBean.executeUpdate("delete tax where code="+code);	
       setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "��������" , 
                          "ɾ��"
                        ) ;
  }

 %> 

<body oncontextmenu="return false">
 <form method="POST" name=frm >
 <center>
 <font class=FontColor size=3><b>����һ����</b></font>
    
 <%@ include file="../public_js/CheckSection.jsp"%>
  <table width=80%><tr height="3"><td>¥������
   <select name="section" onchange="document.frm.submit();"> 
   <option></option>
<%   
	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean.executeQuery(sql1);	
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
  
  </td><td align="right"> <%
 
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B007");
   if (Cortrol==null)Cortrol="";
    if (Cortrol.indexOf("A")>=0){ %>
  <input type=button name=add value="�� ��"  onclick="add_charges();"> 
<%} %></td></tr></table>  
<table border="0" width=90%" CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=listtitle align="center">
    <td width="30%"> ��������</td>
	<td width="10%"> �������</td>
	<td width="10%"> ���Ѷ���</td>
	<td width="10%"> ������;</td>
	<td width="10%"> ����</td>
	<td>�Ʒѱ�׼</td>
	<td>ɾ��</td>
	<td>�޸�</td>
   </tr>
   <%
    String section=getbyte1(request.getParameter("section"));
    if (section.equals(""))section=no1;
    sql1="select section,tax_Name,tax_type,type,Code,type1,type3 from tax where section='"+section+"' order by tax_type";
    rs2=ViewBean.executeQuery(sql1);	
   while (rs2.next()){
      String name=getbyte(rs2.getString("tax_name"));
	  String tax_type=getbyte(rs2.getString("tax_type"));
	  String type=getbyte(rs2.getString("type"));
	  String type1=getbyte(rs2.getString("type1"));
	  String type3=getbyte(rs2.getString("type3"));
	  if (type.equals("0"))type="���пͻ�";
	  else  if (type.equals("1"))type="���ҿͻ�";
	   else  if (type.equals("2"))type="��Ҫ�뻧�ͻ�";
	    else  if (type.equals("3"))type="����ͻ�";
	   if (tax_type.equals("0"))tax_type="���׷�";
	  else  if (tax_type.equals("1"))tax_type="˰��";
     out.print("<tr class=listcontent align='center'><td>"+name+"</td>");
	 out.print("<td>"+tax_type+"</td>");
	 out.print("<td>"+type+"</td>");
	  out.print("<td>"+type1+"</td>");
	  out.print("<td>"+type3+"</td>");
	 
	  code=getbyte(rs2.getString("Code"));
   %>
	 <td><a href="TaxPageList.jsp?code=<%=code %>&section=<%=section %>&ch_name=<%=name %>&param=<%=request.getParameter("param") %>">���üƷѱ�׼</a></td>
	 <td>
	 <%if (Cortrol.indexOf("D")>=0){ %>
	 <a href="#" onclick="del_charges(<%=code %>);">ɾ��</a>
	 <%} %>
	 </td> <td>
	 <%if (Cortrol.indexOf("D")>=0){ %>
	 <a href="#" onclick="modi_charges(<%=code %>);">�޸�</a>
	 <%} %>
	 </td>
	 </tr>
   <%
   }
   rs2.close();
    %>
	</table>
	<br><br><br><br><br>
	<table width="80%">
	<tr><td align="left">����˵����</td></tr>
	<tr><td align="left">&nbsp;&nbsp;&nbsp;&nbsp;�ڴ˹����У��û�������ҵ����ɵĸ���˰�Ѽ��Ʒѱ�׼,������������:<br>1.����"�� ��"�������ڵ����ĶԻ���������д�������ƺ��ٵ���"�� ��";<br>2.
	�����������ú��ڷ���һ�����е���"�Ʒѱ�׼",����ʾ�������ӵļƷѱ�׼������û���Ҫ�����µļƷѱ�׼���ɵ���"�� ��",�ڵ�����������д�Ʒѱ�׼��
	</td></tr>
	
	</table>
	<script>
	 setSelectMad(document.frm.section,'<%=section %>');
	 <%if (!section_d.equals("")){ %>
	 	 setSelectMad(document.frm.section,'<%=section_d %>');
	 <%} %>
	 function  add_charges(){
	 	 openwin("charges_set.jsp?section=<%=section %>",400,350,150,150);
     }		
	  function  del_charges(para){
	   if (confirm("ȷ��ɾ����"))
	 	 document.frm.action="Tax_list.jsp?section_d=<%=section %>&code="+para;
		 document.frm.submit();
     }		 
	 
	   function  modi_charges(para){
	   if (confirm("ȷ���޸���"))
	 	 openwin("Modicharges_set.jsp?section_d=<%=section %>&code="+para,300,250,100,100);
     }		 
	 
	 
	</script>
</body>

</html>
