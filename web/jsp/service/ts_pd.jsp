 
<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
	<title>�� �� �Ǽ�</title>
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
<%
 String ts_code=request.getParameter("ts_code");
 String SQL="select * from TS_SERVICER where ts_code="+ts_code;
 String TS_CUSTOMER="";
 String TS_ROOM="";String TS_TITLE="";
 String TS_DATE="";
 String TS_TYPE="";
 String TS_CONTEXT="";
 String TS_STATE="",ts_clperson="";
 String TS_cus_type="",TS_END_DATE="";
 String TS_COMM_DATE="",TS_TXTS="";
 String TS_END_CONTEXT="",TS_COMM_endDATE="";
 String TS_TEL="",TS_APDATE="",TS_FT="";
 String TS_SJ="",TS_COMM_DEPT="",TS_COMM_PERSON="";
try{
	ResultSet rs=ViewBean.executeQuery(SQL);
 
 
	while (rs.next()){
	 
	  //��FIELDS˳��һGET��VALUE
	  String TS_code=getbyte(rs.getString("TS_code"));
	    TS_CUSTOMER=getbyte(rs.getString("TS_CUSTOMER"));
	    TS_ROOM=getbyte(rs.getString("TS_ROOM"));
	    TS_TITLE=getbyte(rs.getString("TS_TITLE"));
		TS_TEL=getbyte(rs.getString("TS_TEL"));
		TS_cus_type=getbyte(rs.getString("TS_CUSTOMER_TYPE"));
	    TS_DATE=getbyte(rs.getDate("TS_DATE").toString());
	    TS_TYPE=rs.getString("TS_TYPE");
	    TS_CONTEXT=getbyte(rs.getString("TS_CONTEXT"));
	    TS_STATE=getbyte(rs.getString("TS_STATE"));
	    if (!TS_STATE.equals("0")) TS_COMM_DATE=getbyte(rs.getDate("TS_COMM_DATE").toString());
		if (!TS_STATE.equals("0")) TS_COMM_endDATE=getbyte(rs.getDate("TS_COMM_endDATE").toString());
		TS_COMM_DEPT=getbyte(rs.getString("TS_COMM_DEPT"));
	    TS_COMM_PERSON=getbyte(rs.getString("TS_COMM_PERSON"));
	 
	    TS_FT=getbyte(rs.getString("TS_FT"));
	    TS_TXTS=getbyte(rs.getString("TS_TXTS"));
		 if (!TS_STATE.equals("0"))TS_APDATE=getbyte(rs.getDate("TS_APDATE").toString());
		 if (TS_STATE.equals("2"))TS_END_DATE=getbyte(rs.getDate("TS_END_DATE").toString());
	    TS_END_CONTEXT=getbyte(rs.getString("TS_END_CONTEXT"));
		ts_clperson=getbyte(rs.getString("ts_clperson"));
	   }
  rs.close();

}catch(Exception se){
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage()+SQL);
	out.close(); 
}
 
 %> 
 

 
<body>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<form name=form1 method="post">
<table align="center"  width="95%">
<tr><td colspan="4" align="center"><font size="3">��  �� </font></td></tr>
<tr><td colspan="4" align="center">&nbsp;</td></tr>
<tr>
<td class="roomleft">Ͷ�߿ͻ�</td>
<td class=roomright> &nbsp;<%=TS_CUSTOMER %></td>
<td class="roomleft">�ͻ����</td>
<td class=roomright>
<%if (TS_cus_type.equals("0")){out.print("ҵ��");}else{out.print("��ҵ��");} %>
   </td>

</tr>
<tr>
 <td class="roomleft">�ͻ��绰</td>
<td class=roomright>&nbsp;<%=TS_TEL %></td>
 
<td class="roomleft">���ڵ�Ԫ</td> 
<td class=roomright>&nbsp;<%=TS_ROOM %></td>
 
</tr>

<tr> 
<td class="roomleft">Ͷ�����</td> 
<td class=roomright>
 &nbsp;<%=TS_TYPE %>
 </td>
 <td class="roomleft">Ͷ������</td>
<td class=roomright>&nbsp;<%=TS_DATE %></td>
</tr>

<tr> 
<td class="roomleft">Ͷ������</td> 
<td  colspan="3" class=roomright>&nbsp;<%=TS_TITLE %></td>
 
</tr>
<tr> 
<td class="roomleft">Ͷ������</td> 
<td colspan="3" class=roomright>&nbsp;<%=TS_CONTEXT %></td>
 
</tr>
<tr><td colspan="4" align="center">&nbsp;</td></tr>
 

<%if (TS_STATE.equals("0")){ %>
<tr><td class="roomleft">
ִ�в���

</td>
<td class=roomright><select name=dept>
<%String StrSql="select type,codename,bak from CODE where child=0 and  type='De' order by type";
   ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
     
     out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
	 
	 i++;
   }
   codeRS.close(); %>

</select></td>
<td class="roomleft">
ִ����

</td>
<td class=roomright><input type=text name=comm_person></td>
</tr>
<tr>
<td class="roomleft">��ʼ����</td>
<td  class=roomright><input type=text name=sdate size=17><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(sdate);return false;" title="��ѡ������"></td>
<td class="roomleft">��������</td>
<td  class=roomright><input type=text name=edate size=17><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(edate);return false;" title="��ѡ������"></td>

</tr>
<tr>
<td class="roomleft">�Ƿ�߰�</td>
<td  class=roomright><input type=checkbox name=tx size=17 value=1 onclick="checkft(this.checked);"> </td>
<td class="roomleft"> ��ǰ����</td>
<td  class=roomright><input type=text name=num value=0   size=17 disabled>  </td>

</tr>
<tr><td colspan="4" align="center"><input type=button name=save value=" �� ��" onclick="tj();">&nbsp;<input type=button name=winclose value=" �� ��" onclick="window.close();"  ></td></tr>
<%}else if (TS_STATE.equals("1")){%>
<tr><td class="roomleft">
ִ�в���

</td>
<td class=roomright><%=TS_COMM_DEPT %></td>
<td class="roomleft">
ִ����

</td>
<td class=roomright><%=TS_COMM_PERSON %></td>
</tr>
<tr>
<td class="roomleft">��ʼ����</td>
<td  class=roomright><%=TS_COMM_DATE %></td>
<td class="roomleft">��������</td>
<td  class=roomright><%=TS_COMM_endDATE %></td>

</tr>
<tr>
<td class="roomleft">�Ƿ�߰�</td>
<td  class=roomright><%if (TS_FT.equals("0")){out.print("���ް�");} else{out.print("�ް�");}%>  </td>
<td class="roomleft"> ��ǰ����</td>
<td  class=roomright><%=TS_TXTS %> </td>

</tr>

<tr>
<td class="roomleft">��������</td>
<td  class=roomright><input type=text name=sdate size=17><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(sdate);return false;" title="��ѡ������"></td>
<td class="roomleft">  </td>
<td  class=roomright>  </td>

</tr>
<tr><td colspan="4" align="center"> &nbsp;<input type=button name=winclose value=" �� ��" onclick="window.close();"  ></td></tr>

<%}else if (TS_STATE.equals("2")){%>
<tr><td class="roomleft">
ִ�в���

</td>
<td class=roomright><%=TS_COMM_DEPT %></td>
<td class="roomleft">
ִ����

</td>
<td class=roomright><%=TS_COMM_PERSON %></td>
</tr>
<tr>
<td class="roomleft">��ʼ����</td>
<td  class=roomright><%=TS_COMM_DATE %></td>
<td class="roomleft">��������</td>
<td  class=roomright><%=TS_COMM_endDATE %></td>

</tr>
<tr>
<td class="roomleft">�Ƿ�߰�</td>
<td  class=roomright><%if (TS_FT.equals("0")){out.print("���ް�");} else{out.print("�ް�");}%>  </td>
<td class="roomleft"> ��ǰ����</td>
<td  class=roomright><%=TS_TXTS %> </td>

</tr>

<tr>
<td class="roomleft">��������</td>
<td  class=roomright><%=TS_APDATE %></td>
<td class="roomleft">  ʵ���������</td>
<td  class=roomright> <%=TS_END_DATE %> </td>


</tr>
<tr>
<td class="roomleft">������</td>
<td  class=roomright><%=TS_END_CONTEXT %></td>
<td class="roomleft">  ������</td>
<td  class=roomright> <%=ts_clperson %> </td>


</tr>


<%} %>
</table>
</form>
<script>

function tj(){

 if (checkvalue()){
 
  document.form1.action="ts_input_save.jsp?options=PD&ts_code=<%=ts_code %>";
 
  document.form1.submit();
  

 }
}
function checkvalue(){

   
   if (document.form1.sdate.value==""){
      alert("��ѡ��ʼ����");
      return false;
   
   }
    if (document.form1.edate.value==""){
      alert("��ѡ���������");
      return false;
   
   }
   
  
    return true;
}
function searcher(){
  openwin("findcustomer.jsp?section="+document.form1.section.value,400,380,300,100); 

}
function checkft(para){
   if (!para)
   document.form1.num.value=0;
   document.form1.num.disabled=!para;
   
}
</script>

</body>
</html>
