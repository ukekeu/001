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
String code=getbyte2(request.getParameter("code"));
String order_no=getbyte2(request.getParameter("order_no"));
if (!code.equals("")){
	    String checkstate=getbyte2(request.getParameter("checkstate"));
       if (checkstate.equals(""))checkstate="0";
		String discPrice=getbyte2(request.getParameter("discPrice"));
		String discUnit=getbyte2(request.getParameter("discUnit"));
		if (discPrice.equals(""))discPrice="0";
		String disctype=getbyte2(request.getParameter("disctype")); 
		String discobj=getbyte2(request.getParameter("discobj")); 
		String disc=getbyte2(request.getParameter("disc"));
		String discold=getbyte2(request.getParameter("discold"));
		String yh="0";
		String countDisc=disc;
		if (!disctype.equals("�����ۿ�")){yh=disc;}//disc="0";
		
		String gxr=getbyte2(request.getParameter("gxr")); 
		String bak=getbyte2(request.getParameter("bak"));
		String disc_date=getbyte2(request.getParameter("disc_date")); 
		String checker=getbyte2(request.getParameter("checker")); 
		String person=getbyte2(request.getParameter("person")); 
        String SQL1="update contract_disc set discobj='"+discobj+"',";
        SQL1+="disc_type='"+disctype+"',disc='"+discold+"',youhui="+yh+",";
		SQL1+="state="+checkstate+",";
	    SQL1+="disc_date='"+disc_date+"',checker='"+checker+"',disc_bak='"+bak+"',gxr='"+gxr+"',";
		SQL1+="person='"+person+"' where code="+code;
    
	 ViewBean.executeUpdate(SQL1);
 
     SQL1="SELECT * FROM  contract_disc  WHERE order_no='"+order_no+"' and disc_type<>'�����ۿ�'   order by code asc";
	ResultSet      rs1=ViewBean.executeQuery(SQL1);
	
	 %>
	  <script>
	   opener.charges();
        
		</script>
	 <%
	 String yy="";
	  while (rs1.next()){ 	
	  	
		   String dd= rs1.getString("disc");
       float yh1=rs1.getFloat("youhui");
	    String ddd="";
	   if (yh1==0)ddd=dd;
	   else ddd=rs1.getString("youhui"); 
	   if (yh1==0)yy+=" ��"+rs1.getString("discobj") +ddd+"��";
	     else yy+=" ��"+rs1.getString("discobj") +"�Ż�"+ddd+"Ԫ";
		if (dd.equals(""))dd="0";
	  %>
	  <script>
	  
	  	  var aaa="<%=dd %>"; 
	  var dic_arr=aaa.split("*");
	     var disn=1;  
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
			// alert(isNaN(dic_arr[dd]));
			// if (isNaN(dic_arr[dd])){alert("�ۿ�������");return false;}
			// if (parseFloat(dic_arr[dd])<=0){alert("�ۿ�������");document.cus.disc.focus();return false;}
	   	   }
		  
       opener.discCount('<%=rs1.getString("disc_type") %>',eval(aaa)/disn*100,'<%=rs1.getString("discobj") %>');
     
   </script>
	  <%
	  }
	 rs1.close();
	 %>
	 <script>
	   opener.document.cus.modijh.checked=true;
	   opener.document.cus.moditax.checked=true;
	   
      opener.yhview.innerHTML =" <%=yy %>";
         window.close();
		</script>
	 <%
   
}
String modi=getbyte2(request.getParameter("modi"));
  
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

<body onload="cus.disc.focus();">
 
<form method="POST" name="cus" action=""  >
     <input type=hidden name=discold value="0">
<p align=center><font size=3 class=FontColor><B>�Ǽ��ۿۼ�¼</b></font></p>
<%
 
if (!modi.equals("")){
  String SQL="SELECT * FROM  contract_disc  WHERE code='"+modi+"'   order by code asc";
 
	ResultSet      rs2=ViewBean.executeQuery(SQL);
	if (rs2.next()){
      String dt=rs2.getString("disc_type"); 
	  String obj=rs2.getString("discObj"); 
	 String dd= rs2.getString("disc");
	 float yh=rs2.getFloat("youhui");
	 int state=rs2.getInt("state");
	 String ddd="";
	 if (yh==0)ddd= dd ;
	 else ddd=rs2.getString("youhui"); 
 %>
<table width="100%" border="0" cellspacing="1"   cellpadding="1" >
            
      <tr> 
        <td width="30%"  class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;���㷽��</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
         &nbsp;<select name="disctype"><option value="�����ۿ�" <%if (dt.equals("�����ۿ�")){out.print("selected");} %>>�����ۿ�</option><option value="�����Ż�"  <%if (dt.equals("�����Ż�")){out.print("selected");} %>>�����Ż�</option></select>
        </td>
     
	 	 
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�ۿ�/�Żݶ���</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<select name="discobj"><option value="�ܼ�" <%if (obj.equals("�ܼ�")){out.print("selected");} %>>�ܼ�</option><option value="��������" <%if (obj.equals("��������")){out.print("selected");} %>>��������</option></select>
        </td>
      </tr>
	  <tr> 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�ۿ�/�Ż���</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=disc size="15" value="<%=ddd  %>"  onkeydown="key(document.cus.disc_date)"  > 
        </td>
      
        <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;����</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<input type=text name=disc_date size="12"   value="<%=rs2.getDate("disc_date").toString()  %>" onkeydown="key(document.cus.gxr);"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(disc_date);return false;">
        </td>
      </tr>
      
      <tr align="left" > 
	   <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;��ϵ��</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<input type=text  name=gxr size="15" value="<%=rs2.getString("gxr")   %>" onkeydown="key(document.cus.checker);"  > 
        </td>
     <td  width="30%" class=roomright align="left"  colspan="2"  height="14">  &nbsp;<input type=checkbox name=checkstate value=1 <%if (state==1) {%>checked <%} %>>�����ͨ��&nbsp;&nbsp;&nbsp;�����
    
          &nbsp;<input type=text name="checker"  value="<%=rs2.getString("checker")   %>" size="15" onkeydown="key(document.cus.person);"  > 
        </td>
      
       
      </tr>
	     &nbsp;<input type="hidden" name="person"  size="15" value="<%= (String )session.getAttribute( "loginname" )  %>" onkeydown="key(document.cus.bak)" > 
    
       <tr align="left" > 
       
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�� ע</td>
        <td  width="30%" class=roomright align="left"   height="14" colspan="3">
          &nbsp;<input type="text" name="bak" value="<%=rs2.getString("disc_bak")   %>" size="60" onkeydown="key(document.cus.Apportion)" > 
        </td>
      </tr>
  </table>
     <p align="center">
			<input type="Button" name="saveRoom" value="�� ��" onclick="loca();">
		 
           &nbsp;&nbsp;
		   <input type="Button" name="saveRoom1" value="�� ��" onclick="window.close();"> &nbsp;&nbsp;
		  
          </P> 
		  <input type=hidden name=order_no value="<%=rs2.getString("order_no") %>">
          <input type=hidden name=code value="<%=rs2.getString("code") %>">
		  <%}rs2.close(); }%>
   <script>
		function loca(){
		  
		    if (confirm("ȷ�ϵ�ǰ�����������")){
		  if (Validate(document.cus)){
		    document.cus.action="modidisc.jsp";
		    document.cus.submit();
          }		
		  }
		}
		</script>
</form>     
       
       
       
</body>       
</html>       
