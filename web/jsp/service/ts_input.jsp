 
<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
	<title>Ͷ�ߵǼ�</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>  
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/>  
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
 <%@ include file="../public_js/AcquiesceSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<body>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<form name=form1 method="post">
<table align="center">
<tr><td colspan="4" align="center"><font size="3">Ͷ�ߵǼ�</font></td></tr>
<tr><td colspan="4" align="center">&nbsp;</td></tr>
<tr>
<td>������Ŀ</td>
<td><select name="section" onchange="paulsel();"> 
   <option value=""></option>
   <%	
String section=request.getParameter("section");
 String paulurl="";
if(section==null || section.equals(""))
{
	paulurl="";
}else{
	paulurl=" and serialno='"+section+"'";
}
      String sql1="select SerialNo,Name from CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";

	  ResultSet rs2=ViewBean.executeQuery(sql1);
	  String sec="";
	  String no1="";
	  String daa="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
	   if(no1.equalsIgnoreCase(section)){
		   daa=" selected";
		   }else{
			   daa="";
		   }
       out.print("<option value='"+no1+"'"+daa+">"+sec+"</option>");
	  }
	  rs2.close();
     %> </select></td>
<td>�ͻ����</td>
<td><select name="customertype" onchange="paulsel();"> 
   <option value="0">ҵ��</option>
    <option value="1">��ҵ��</option>
	</select>
   </td>

</tr>
<tr>
<td>�ͻ�����</td>
<td>
<input type=text name=customer><input type=button name="fin" value=".." onclick="searcher();"></td>
<td>�ͻ��绰</td>
<td><input type=text name=tel></td>
</tr>
<tr> 
<td>���ڵ�Ԫ</td> 
<td><input type=text name=room></td>
<td>��ϵ��ַ</td>
<td><input type=text name=addr></td>
</tr>

<tr> 
<td>Ͷ�����</td> 
<td>
 
<select name="tstype"> 
<%String StrSql="select type,codename,bak from CODE where child=0 and  type='ty' order by type";
   ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
     
     out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
	 
	 i++;
   }
   codeRS.close(); %>

	</select>

 </td>
 <td>Ͷ������</td>
<td><input type=text name=tsdate size=17><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(tsdate);return false;" title="��ѡ��Ͷ������"></td>
</tr>

<tr> 
<td>Ͷ������</td> 
<td  colspan="3"><input type=text name=title size=54></td>
 
</tr>
<tr> 
<td>Ͷ������</td> 
<td colspan="3"><textarea cols="52" rows="10" name=context> </textarea></td>
 
</tr>
<tr><td colspan="4" align="center">&nbsp;</td></tr>

<tr><td colspan="4" align="center">&nbsp;</td></tr>

<tr><td colspan="4" align="center"><input type=button name=save value=" �� ��" onclick="tj();">&nbsp;<input type=button name=winclose value=" �� ��" onclick="window.close();"  ></td></tr>

</table>
</form>
<script>

function tj(){

 if (checkvalue()){
 
  document.form1.action="ts_input_save.jsp?options=add";
 
  document.form1.submit();
  

 }
}
function checkvalue(){

   if (document.form1.section.value==""){
      alert("��ѡ��Ͷ��������Ŀ");
      return false;
   
   }
   if (document.form1.customer.value==""){
      alert("��ѡ��Ͷ�߿ͻ�");
      return false;
   
   }
   if (document.form1.tsdate.value==""){
      alert("��ѡ��Ͷ������");
      return false;
   
   }
    if (document.form1.title.value==""){
      alert("����дͶ������");
      return false;
   
   }
   if (document.form1.context.value==""){
      alert("����дͶ������");
      return false;
   
   }
  
    return true;
}
function searcher(){
  openwin("findcustomer.jsp?section="+document.form1.section.value,400,380,300,100); 

}
</script>

</body>
</html>
