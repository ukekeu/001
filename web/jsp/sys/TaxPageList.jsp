<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%> 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>���ü����׼</title>
</head>
<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
    <%@ include file="../public_js/getByteOut.jsp"%>
   <%@ include file="../public_js/qx_checke.jsp"%>
   
   <%!
   String Cortrol="";
   
	  int jjj=0;
   %>   
   	 <%
 
Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B007");
   if (Cortrol==null)Cortrol="";
    %>
  
    
<%!
    String taxname="";
	 public String ShowTax(String sqlstr) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  String state="",type1="";
    
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
	 FormatData.FormatData formatD1=new FormatData.FormatData();
		while (TaxRs.next()) {
		int     id = TaxRs.getInt("ID");
		
	    String  money = formatD1.getFloat1(TaxRs.getFloat("money"),3);
		String  termvalue=TaxRs.getString("termvalue");
   	    String  termvalue1=getbyte(TaxRs.getString("termvalue1"));
		String term=getbyte(TaxRs.getString("term"));
		String term1=getbyte(TaxRs.getString("term1"));
		String custype=getbyte(TaxRs.getString("type"));//��λ�����
		String money1=formatD1.getFloat3(TaxRs.getDouble("money1"),2);
	    String  termvalue2=TaxRs.getString("termvalue2");
		 String term2=getbyte(TaxRs.getString("term2"));
		 String  termvalue3=TaxRs.getString("termvalue3");
		 String term3=getbyte(TaxRs.getString("term3"));
		 
		if (termvalue3==null)termvalue3="0";
		
		if (term.equals(">"))term="����";
		else if (term.equals("<"))term="С��";
		else if (term.equals("<="))term="С�ڵ���";
		else if (term.equals(">="))term="���ڵ���";
		else if (term.equals("="))term="����";
		if (term1.equals(">"))term1="����";
		else if (term1.equals("<"))term1="С��";
		else if (term1.equals("<="))term1="С�ڵ���";
		else if (term1.equals(">="))term1="���ڵ���";
		else if (term1.equals("="))term1="����";
		
		if (term2.equals(">"))term2="����";
		else if (term2.equals("<"))term2="С��";
		else if (term2.equals("<="))term2="С�ڵ���";
		else if (term2.equals(">="))term2="���ڵ���";
		else if (term2.equals("="))term2="����";
		if (term3.equals(">"))term3="����";
		else if (term3.equals("<"))term3="С��";
		else if (term3.equals("<="))term3="С�ڵ���";
		else if (term3.equals(">="))term3="���ڵ���";
		else if (term3.equals("="))term3="����";
		state=TaxRs.getString("state");
		type1=TaxRs.getString("type1");
		if (!state.equals(""))  jjj++;
		String  TaxName = "�Ʒѱ�׼"+String.valueOf(jjj);//getbyte(TaxRs.getString("TaxName"));
	  if (type1.equals("1"))type1="����100Ԫ����ȡ100����";
	  else type1="";
	  String type3=getbyte(TaxRs.getString("type3"));
	  if (type3.equals("1"))type3="��������";
	  else type3="";
	
	  if (custype.equals("1"))custype="��λ����";
	  else custype="";
	  type3+=" "+custype;
   str+="<tr  align='center' class=listcontent>";
   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"</td>";
  if (state.equals("1"))//���ۼ۰ٷֱȼ���
   str+="<td align=left>&nbsp;&nbsp;����"+term+termvalue+"��Ԫ��"+term1+termvalue1+"��Ԫ,��ȡ���۵�"+money+" ��&nbsp;"+type1+"("+type3+")</td>";
  else   if (state.equals("2")){//���̶�������

   str+="<td align=left>"+custype+"ÿ��&nbsp;&nbsp;"+money+"Ԫ&nbsp;("+type3+")</td>";
 } else   if (state.equals("3"))//�������������
   str+="<td align=left>&nbsp;&nbsp;���"+term+termvalue+"ƽ����"+term1+termvalue1+"ƽ����,��ȡ���۵�"+money+" ��&nbsp;"+type1+"("+type3+")</td>";
    else   if (state.equals("4"))//�������������
   str+="<td align=left>&nbsp;&nbsp;���"+term+termvalue+"ƽ����"+term1+termvalue1+"ƽ����,��ȡ"+money+"Ԫ&nbsp;"+type1+"("+type3+")</td>";
   else   if (state.equals("5"))//�������������
   str+="<td align=left>&nbsp;&nbsp;���"+term+termvalue+"ƽ����"+term1+termvalue1+"ƽ����,��ȡ"+money+" Ԫ/ƽ����&nbsp;"+type1+"("+type3+")</td>";
  
  
  
  
  else   if (state.equals("6"))//����������
   str+="<td align=left>&nbsp;&nbsp;ÿ��"+money+"Ԫ&nbsp;"+type1+"("+type3+")</td>";
 else   if (state.equals("7"))//���ҿ����
   str+="<td align=left>&nbsp;&nbsp;���ҿ�"+term+termvalue+"��Ԫ��"+term1+termvalue1+"��Ԫ,&nbsp;Ӧ�������ǰ��ҿ��"+money+" ��"+type1+"("+type3+")</td>";
  else   if (state.equals("8"))//������
   str+="<td align=left>&nbsp;&nbsp;����"+term+termvalue+"Ԫ��"+term1+termvalue1+"Ԫ,&nbsp;Ӧ���������ܷ�����"+money+" ��"+type1+"("+type3+")</td>";
  else   if (state.equals("9"))//������
   str+="<td align=left>&nbsp;&nbsp;1�����ڽ������"+term+termvalue+"�����ڽ����������"+term1+termvalue1+"��<br>2���������"+term2+termvalue2+"�ҽ����������"+term3+termvalue3+"�İ�"+money+"%&nbsp;����"+money1+"%</td>";
  
  
  str+="<td bgcolor='#cfe6eb'>";
  
   if (Cortrol.indexOf("D")>=0){
  str+="<a href='javascript:delTax("+ String.valueOf(id)+")'>ɾ��</a>";
  }
  str+="</td>";
  str+="<td bgcolor='#cfe6eb'>";
  if (Cortrol.indexOf("E")>=0){
  str+="<a href='javascript:editTax("+ String.valueOf(id)+")'>�޸�</a>";
  }
  str+="</td>";

  str+="</tr>";

 }
 
 TaxRs.close();
 return str;
}
%>
<%
taxname=getbyte1(request.getParameter("ch_name"));
 String code=request.getParameter("code");

 %>
<script language="javascript" src="../public_js/public.js">
</script>
<script>

function delTax(id) {
	if ( confirm("ȷʵ��ɾ��������¼?"))
		openwin("saveTax.jsp?id=" + id+"&ch_name=<%=taxname %>&code=<%=code %>",550,380,150,150);
	}
	
function editTax(id) {
			openwin("TaxPage.jsp?taxname=<%=taxname %>&id=" + id+"&para1=edit",600,580,150,150);
	}
</script>
 
<body>
 <form method="POST" name=frm >
 <center>
    <font class=FontColor><b><font size="3"><br>
    <%=taxname %>�Ʒѱ�׼һ����</font></b></font> 
    <table width=90%><tr height="16"><td align="right">
	  <input type=button name=add value="�� ��" onclick="window.location='Tax_list.jsp?section=<%=request.getParameter("section") %>'" >
	 <%
 
 
   if (Cortrol==null)Cortrol="";
    if (Cortrol.indexOf("A")>=0){ %>
  <input type=button name=add value="�� ��" onclick="openwin('TaxPage.jsp?code=<%=code %>&taxname=<%=taxname %>',700,600,150,100);">
<%} %>
 </td></tr>
 </table>
   
<table border="0" width=90%" CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=listtitle align="center">
    <td width="20%"> </td>
    <td width="60%">
    &nbsp; �Ʒѱ�׼
    
    </td>
	<td><font color=white>ɾ&nbsp;��</font></td>
	<td><font color=white>��&nbsp;��</font></td>
  </tr>
<%jjj=0; %>
 <%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='1' and code="+code)); %>

 <%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='2' and code="+code)); %>
 <%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='3' and code="+code)); %>
 <%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='4' and code="+code)); %>
 <%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='5' and code="+code)); %>
<%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='6' and code="+code)); %>
<%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='7' and code="+code)); %>
<%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='8' and code="+code)); %>
<%out.print(ShowTax("select id,money,termvalue,termvalue1,term,term1,money1,termvalue2,termvalue3,term2,term3,state,type,type1,type3,type4  from TaxChages where state='9' and code="+code)); %>
 

</table>
 </center>
  </form>
</body>

</html>
