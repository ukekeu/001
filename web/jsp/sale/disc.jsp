<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>�ۿۼ�¼��ϸ</title>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT12");
Cortrol+=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT021");

String code=getbyte2(request.getParameter("code"));
String deletecode=getbyte2(request.getParameter("deletecode"));
if (!deletecode.equals("")){
  ViewBean.executeUpdate("delete contract_disc where code="+deletecode);
   String SQL="SELECT * FROM  contract_disc  WHERE order_no='"+code+"' and disc_type<>'�����ۿ�' and state=1 order by code asc";
	ResultSet      rs1=ViewBean.executeQuery(SQL);
	 out.print(SQL);
	 %>
	  <script>
	   opener.charges();
        opener.yhview.innerHTML="";
		</script>
	 <%
	 String yy="";
	  while (rs1.next()){ 	
	    String disctype=rs1.getString("disc_type");
		
		String discobj=rs1.getString("discobj");
		String Disc=rs1.getString("Disc");
		if (Disc.equals(""))Disc="0";
		String youhui=rs1.getString("youhui");
	  	   if (disctype.equals("�����ۿ�"))yy+=" ��"+discobj+Disc+"��";
	     else yy+=" ��"+discobj+"�Ż�"+youhui+"Ԫ";
	  %>
	  <script>
	    var aaa="<%=Disc %>"; 
	  var dic_arr=aaa.split("*");
	     var disn=1;  
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
			// alert(isNaN(dic_arr[dd]));
			// if (isNaN(dic_arr[dd])){alert("�ۿ�������");return false;}
			// if (parseFloat(dic_arr[dd])<=0){alert("�ۿ�������");document.cus.disc.focus();return false;}
	   	   }
		 
       opener.discCount('<%=disctype %>',eval(aaa)/disn*100,'<%=discobj %>');
    
   </script>
	  <%
	  }
	 rs1.close();
	 %>
	 <script>
	   opener.document.cus.modijh.checked=true;
	   opener.document.cus.moditax.checked=true;
	   opener.yhview.innerHTML ="�Ż�:"+ " <%=yy %>";
     window.close();
		</script>
	 <%
   
}
String discPrice=getbyte2(request.getParameter("discPrice"));
String discUnit=getbyte2(request.getParameter("discUnit"));
String discold=getbyte2(request.getParameter("discold"));
if (discPrice.equals(""))discPrice="0";
String checkstate=getbyte2(request.getParameter("checkstate"));
if (checkstate.equals(""))checkstate="0";
String disctype=getbyte2(request.getParameter("disctype")); 
String discobj=getbyte2(request.getParameter("discobj")); 
String disc=getbyte2(request.getParameter("disc"));
String yh="0";
String countDisc=disc;

if (!disctype.equals("�����ۿ�")){yh=disc;disc="";}
String yy="";
String gxr=getbyte2(request.getParameter("gxr")); 
String bak=getbyte2(request.getParameter("bak"));
String disc_date=getbyte2(request.getParameter("disc_date")); 
String checker=getbyte2(request.getParameter("checker")); 
 String person=getbyte2(request.getParameter("person")); 
 if (!disctype.equals("")){
   if (disctype.equals("�����ۿ�"))yy+=" ��"+discobj+disc+"��";
	else yy+=" ��"+discobj+"�Ż�"+yh+"Ԫ";
    String SQL="Insert into contract_disc(order_no,discobj,discPrice,discUnit,disc_type,disc,youhui,disc_date,checker,disc_bak,gxr,person,state";
	if (checkstate.equals("1"))
	SQL+=",check_date";
	SQL+=") values(";
     SQL+="'"+code+"','"+discobj+"',"+discPrice+","+discUnit+",'"+disctype+"','"+disc+"',"+yh+",'"+disc_date+"','"+checker+"','"+bak+"','"+gxr+"','"+person+"',"+checkstate;
	 if (checkstate.equals("1"))
	 SQL+=",'"+disc_date+"'";
	SQL+=")";
	// ViewBean.executeUpdate(SQL);
   %>
   <script>
   opener.discCount('<%=disctype %>',<%=countDisc %>,'<%=discobj %>');
   //opener.SaveContract();
   
   opener.document.cus.discSQL.value=opener.document.cus.discSQL.value+"<%=SQL %>";
   var yh=opener.yhview.innerHTML;
   if (yh=="�Ż�")yh="�Ż�:";
   else yh+=" ";
      opener.yhview.innerHTML =yh+ " <%=yy %>";
	   opener.ykj_count();
    window.close();
   </script>
   <%
 
 }
%>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
 

<SCRIPT language=javascript>
 
  function Validate(aForm)
   {
     // check(document.cus.disc);
      if (  document.cus.disc_date.value==""){alert("������ڲ���Ϊ��");return false;}
	  if (  document.cus.gxr.value==""){alert("��ϵ�˲���Ϊ��");document.cus.gxr.focus();return false;}
	 
	  if (  document.cus.checker.value==""){alert("����˲���Ϊ��");document.cus.checker.focus();return false;}
	  if (  document.cus.bak.value==""){alert("��ע����Ϊ��");document.cus.bak.focus();return false;}
	  if (parseFloat(document.cus.disc.value)<=0) {alert("��¼���Żݽ����ۿ�");document.cus.disc.focus();return false;}
        var dic_arr=document.cus.disc.value.split("*");
	  document.cus.discold.value=document.cus.disc.value;
	
	   var disn=1;
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
			 if (isNaN(dic_arr[dd])){alert("�ۿ�������");document.cus.disc.focus();return false;}
			 if (parseFloat(dic_arr[dd])<=0){alert("�ۿ�������");document.cus.disc.focus();return false;}
	   	   }
	  if (eval(document.cus.disc.value)/disn*100>=100&&(document.cus.disctype.value=="�����ۿ�")) {alert("��¼����ȷ�ۿۣ��ۿ������ܴ���100");document.cus.disc.focus();return false;}
       if (eval(document.cus.disc.value)/disn*100<90&&(document.cus.disctype.value=="�����ۿ�")) {if (!confirm("��Ķ����ۿ�Ϊ��"+document.cus.disc.value+"����������ȷ��"))return false;}
    document.cus.disc.value=eval(document.cus.disc.value)/disn*100;
	 
	   return true;
   }
  
</SCRIPT> 

<body onload="cus.disc.focus();" oncontextmenu="return false"  >
 
<form method="POST" name="cus" action=""  >
 <input type=hidden name=code value="<%=code %>">
 <input type=hidden name=discPrice value="<%=discPrice %>">
  <input type=hidden name=discUnit value="<%=discUnit %>">
    <input type=hidden name=discold value="0">
<p align=center><font size=3 class=FontColor><B>�Ǽ��ۿۼ�¼</b></font></p>
<table width="100%" border="0" cellspacing="1"   cellpadding="1" >
            
      <tr> 
        <td width="30%"  class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;���㷽��</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
         &nbsp;<select name="disctype"><option value="�����ۿ�">�����ۿ�</option><option value="�����Ż�">�����Ż�</option></select>
        </td>
     
	 	 
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�ۿ�/�Żݶ���</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<select name="discobj"><option value="�ܼ�">�ܼ�</option><option value="��������">��������</option></select>
        </td>
      </tr>
	  <tr> 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�ۿ�/�Ż���</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=disc size="15" value=0  onkeydown="key(document.cus.disc_date)"  > 
        </td>
      
        <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;����</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<input type=text name=disc_date size="12"  onkeydown="key(document.cus.gxr);"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(disc_date);return false;">
        </td>
      </tr>
      
      <tr align="left" > 
	   <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;��ϵ��</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<input type=text  name=gxr size="15"  onkeydown="key(document.cus.checker);" value="��˾" > 
        </td>

        <td  width="30%" class=roomright align="left"  colspan="2"  height="14">  &nbsp;<input type=checkbox name=checkstate value=1 checked>�����ͨ��&nbsp;&nbsp;&nbsp;�����
          &nbsp;<select size="1" name="checker" onkeydown="key(document.cus.person);"  style="width:117" >
   <option value=""></option>
<%String sell="select  serialno,name from CortrolMan where job like '%����%'";
  ResultSet rs2=ViewBean.executeQuery(sell);
  while (rs2.next()){
	   String Name=getbyte(rs2.getString("name"));
       out.print("<option value='"+getbyte(rs2.getString("serialno"))+"'>"+Name+"</option>") ;
	}
  rs2.close();
  %>
	  
</select>
        </td>
     
       
      </tr>
	     &nbsp;<input type="hidden" name="person" size="15" value="<%= (String )session.getAttribute( "loginname" )  %>" onkeydown="key(document.cus.bak)" > 
    
       <tr align="left" > 
       
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�� ע</td>
        <td  width="30%" class=roomright align="left"   height="14" colspan="3">
          &nbsp;<input type="text" name="bak" size="60" value="��˾�涨" onkeydown="key(document.cus.Apportion)" > 
        </td>
      </tr>
  </table>
     <p align="center">
			<input type="Button" name="saveRoom" value="�� ��" onclick="loca();">
		 
           &nbsp;&nbsp;
		   <input type="Button" name="saveRoom1" value="�� ��" onclick="window.close();"> &nbsp;&nbsp;
		  
          </P>
		    <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	  <tr bgcolor="#c0c0c0" align="center"><td>�ۿ۷���</td><td>����</td> <td>�Ż�</td><td>�ۿ�</td><td>�������</td><td>��ǰ�ܼ�</td><td>��ǰ����</td><td>��ϵ��</td><td>�����</td><td>����</td></tr>
	 
	  <%
	   String discSQL="SELECT * FROM  contract_disc  WHERE  bt=0 and order_no='"+code+"'  order by code asc";
	      
		   ResultSet      rs=ViewBean.executeQuery(discSQL);
				 int aaa12=0;
			 
			  while (rs.next()){ 		aaa12++;	   String disc_type=rs.getString("disc_type") ;   
	  %>
	   <tr id=A<%=aaa12 %> align="center"  onmouseover="mout(this) ;changeclass1(this,'clickbg','#ffffff');" title="�ۿ۱�ע:<%=rs.getString("disc_bak") %>"><td><%=rs.getString("disc_type")  %></td><td><%=rs.getDate("disc_date").toString() %></td>
	   
	   <td><%=rs.getString("youhui") %></td><td><%=rs.getString("disc") %>&nbsp;</td><td><%=rs.getString("discObj") %></td>
	   <td><%=rs.getString("discPrice") %></td><td><%=rs.getString("discUnit") %></td><td><%=rs.getString("gxr") %></td><td><%=rs.getString("checker") %></td>
	   <td><%if (rs.getInt("state")==0) {if (!disc_type.equals("�����ۿ�"))%><a href="modidisc.jsp?modi=<%=rs.getInt("code") %>">�޸�</a>&nbsp;<a href="#" onclick="if (confirm('ȷ��ɾ����'))window.location='disc.jsp?discPrice=<%=discPrice %>&code=<%=code %>&deletecode=<%=rs.getInt("code") %>&discUnit=<%=discUnit %>';">ɾ��</a><%}else{ %>�����<%} %>
		<%if (Cortrol.indexOf("C")>=0&&!disc_type.equals("�����ۿ�")) {%> <a href="modidisc.jsp?modi=<%=rs.getInt("code") %>">�޸�</a>&nbsp;<a href="#" onclick="if (confirm('ȷ��ɾ����'))window.location='disc.jsp?discPrice=<%=discPrice %>&code=<%=code %>&deletecode=<%=rs.getInt("code") %>&discUnit=<%=discUnit %>';">ɾ��</a><%} %>
		
		</td>
		 </tr>
	   <%}rs.close(); %>
	  </table>
   <script>
		function loca(){
		  
		    if (confirm("ȷ�ϵ�ǰ�����������")){
		  if (Validate(document.cus)){
		    document.cus.action="disc.jsp";
		    document.cus.submit();
          }		
		  }
		}
		</script>
</form>     
       
       
       
</body>       
</html>       
