<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean2" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>	
	<LINK href="../class/news.css" rel=stylesheet>
	<title>
	   �û��б�
	</title>
	
<script lang=javascript>
function addzhu_i()
{
	document.form1.action="zhuadd_i.jsp";
	document.form1.submit();
}
</script>

</head>
<script language="JavaScript" src='../public_js/public.js'></script>
<%
String user_id=getbyte(request.getParameter("user_id")).trim();
String ChangeState=getbyte(request.getParameter("ChangeState")).trim();
if (!ChangeState.equals("")&&!user_id.equals("")){//�Ƿ�ͬ������
 aBean.executeUpdate("update CortrolMan set existstate="+ChangeState +" where id="+user_id);
}

String chstate= request.getParameter("chstate");
String userid1= request.getParameter("userid");
 
if (chstate!=null){//�Ƿ�����
String chSQL="UPDATE CortrolMan SET ACTIVE="+chstate+" WHERE id="+userid1;
 aBean1.executeUpdate(chSQL);
 
} 
%>
<body oncontextmenu="return false" >
<form name=form1 method=post>

 <p align=center class=FontColor>
  <font size=3>
   <b>
    �û�����
   </b>
  </font>
 </p>
 
 <table width=100% border="0">
  <tr height="16" bgcolor="#EAEAEA">
   <td align="left">
 
     <input type=button name=add value="�� ��" onclick="window.open('add_user.jsp','er','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,height=300');">
  
 
     <input type=button name=modi value="�� ��"  onclick="zhuEdit();">
  
    <input type=button name=del value="ɾ ��"  onclick="zhu_de_a();"> 
   
   </td>
  </tr>
 </table>

 <table border=0 width=100% align=center id=AutoNumber cellspacing=1 cellpadding=1 >
   <tr class=listtitle>
    
	<td width=10% align=center>
	 <font color=white>
	  <input type=checkbox name=ca1 onclick="selectAll(this.checked)">ȫѡ
	 </font>
	</td>	
	 
	<td align=center>
	 <font color=white>
	  �û�����
	 </font>
	</td>	
	<!--<td width=10% align=center>
	 <font color=white>
	  �û�����
	 </font>
	</td>-->
	<td align=center>
	 <font color=white>
	  �û�����
	 </font>
	</td>
	<td align=center>
	 <font color=white>
	  ְλ
	 </font>
	</td>
	<td  align=center>
	 <font color=white>
	   ��ϵ�绰
	 </font>
	</td>
	<td align=center>
	 <font color=white>
	  ����
	 </font>
	</td>
	<td  align=center>
	 <font color=white>
	  ͬ������
	 </font>
	</td>
<td  align=center>
	 <font color=white>
	  ����״̬
	 </font>
	</td>
   </tr>
   
   <%  int id=0;
      int u = 0;
       String serialno="";
	   String name="";
	   String tel="";
	   String job="";
	   String dept="";
	   String company="";
	   String code="";
	   
	    ResultSet rsc = aBean2.executeQuery(" select company from CortrolMan where dj=0 group by company");
  while(rsc.next()){
          company= getbyte(rsc.getString("company"));
		 
		  %>
		   <tr class='listcontent'>
	 <td colspan=8>  <%=company %> </td>
	
	</tr>
		  <%
		 
	    ResultSet rs = aBean.executeQuery("select dept from CortrolMan  where  dj=0 and company='"+company+"' group by dept");


   while(rs.next()){
      dept= getbyte(rs.getString("dept"));
	  %>
	  <tr class='listcontent'>
	 <td colspan=8>&nbsp;&nbsp;<input type=checkbox name=aic<%= u%>   onclick="choosedata('<%=u %>',this.checked);"><a  href="#" onclick="show(<%=u %>);"><%=dept %></a></td>
	
	</tr>	
	<%
   ResultSet rs1 = aBean1.executeQuery(" select * from CortrolMan where  dept='"+dept+"'  and  dj=0 and company='"+company+"'");
  
   while(rs1.next()){
      id= rs1.getInt("id");
	  serialno=rs1.getString("serialno");
	   name=getbyte(rs1.getString("name"));
	  tel=getbyte(rs1.getString("tel"));
	  job=getbyte(rs1.getString("job"));
	  
	  dept=getbyte(rs1.getString("dept"));
String state=getbyte(rs1.getString("active"));
String state1=getbyte(rs1.getString("existstate"));
   	%>   	
	<tr class='listcontent'  id=tr<%=u %>>
	 
	
	 <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 <td><input type=checkbox name=ic<%= u%> value="<%=id %>" <%if (serialno.equals("scsteven")){out.print("disabled title='����Ա�û����ܱ��'");}%>><%= serialno%></td>	
	
	 <td><%= name%></td>	  
	 <td><%= job%></td>
	 <td><%= tel%></td>
	 <td><a href="#" onclick="javascript:window.open('ChangePassAction.jsp?id=<%=id %>&serialno=<%=serialno %>','ss','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500');">����</td>	
<td><select name=state<%=id %> onchange="changeState(this.value,<%=id %>);"> 
	<option value=1>����</option><option value=0>��������</option>
	</select>
	<script>
setSelectMad(document.form1.state<%=id %>,'<%=state1 %>');
</script>
	</td> 	 
         <td><select name=chstate<%=id%> onchange="ch(this.value,'<%=id%>');"><option value=1>����</option><option value=0>����</option></select></td>	
<script>
 setSelectMad(document.form1.chstate<%=id%>,'<%=state%>');  
</script>
</tr>	
	<%}
	rs1.close();
	u++;
   }
   rs.close();
   }
   rsc.close();
   %>    
   <tr class='listcontent'>
    <td colspan=8>
     <input type=checkbox name=ca onclick="selectAll(this.checked)"> &nbsp; ȫѡ/ȡ��
	</td>	
   </tr>	
 </table>
 
  <input type=hidden name=rows value=<%= u%> >
 
 	 <script lang=javascript>
	 	function zhu_de_a()
		{
		  	    var seldocs = new Array();
	 var temp=form1.elements.length;
	 var dd=0;
	  var strid="";
     for (i=0;i<form1.elements.length;i++) {
       if ((form1.elements[i].type=="checkbox"&&form1.elements[i].checked&&form1.elements[i].value.length>0))
		  { dd++;strid=form1.elements[i].value;
	 	 }
			 
		}
	if( dd>0 ) {
					if( confirm( "��ȷ��ɾ����ѡ�ļ�¼��?" ) ){				
						document.forms[0].action = "userdelete.jsp";
						document.forms[0].submit();				
					}else{
						return;
					}
				}else{
					alert( "��ѡ��Ҫɾ���ļ�¼!" );
					return;
			}
			 
		}
		
		function choosedata(para1,para2) {
     var x=0;
 
	 var seldocs = new Array();
	 var temp=form1.elements.length;
     for (i=0;i<form1.elements.length;i++) {
       if ((form1.elements[i].type=="checkbox")&&(form1.elements[i].name=="ic"+para1))
		 { 
	 		 form1.elements[i].checked=para2;
 
   		 }
		 
    }
}	
function selectAll(para1)
		{		
		   var x=0;
 
	 var seldocs = new Array();
	 var temp=form1.elements.length;
     for (i=0;i<form1.elements.length;i++) {
       if ((form1.elements[i].type=="checkbox"))
		 { 
	 		 form1.elements[i].checked=para1;
 
   		 }
		 
      }
 }
 
	function show(dd){
  var  tr=document.all.AutoNumber.rows;

  for( var i=0;i<tr.length;i++){
    if (tr[i].id=="tr"+dd) 
	 tr[i].style.display=(tr[i].style.display=="none")?"block":"none";
	 
   }
  }
 
		
		function zhuEdit()
		{	
		    var seldocs = new Array();
	 var temp=form1.elements.length;
	 var dd=0;
	  var strid="";
     for (i=0;i<form1.elements.length;i++) {
       if ((form1.elements[i].type=="checkbox"&&form1.elements[i].checked&&form1.elements[i].value.length>0))
		 { dd++;strid=form1.elements[i].value;
	 	 }
			 
		}
		if (dd>1){alert("ֻ��ѡ��һ����¼�����޸�");}
		else{
		    window.open('useredit.jsp?tid=' + strid,'','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,height=300');
}
		}
function ch(para,para1){
 document.form1.action="user_list.jsp?chstate="+para+"&userid="+para1;
 document.form1.submit();
}
function changeState(para,para1){
		  document.forms[0].action="user_list.jsp?ChangeState="+para+"&user_id="+para1
		  document.forms[0].submit();
		
		}
	 </script>
	  
</body>
</html>
