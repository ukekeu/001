<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>Ԥ���Ǽ�</title>
</head>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>

<%  
 
  String sql="";
  int id=0;
  String Payname="";
  String name=getbyte1(request.getParameter("secname"));
  String FindB1=getbyte1(request.getParameter("FindB1"));
  String rooms=getbyte1(request.getParameter("rooms"));
 
  String secno=getbyte1(request.getParameter("secno"));
  String build=getbyte1(request.getParameter("build"));
  String loft=getbyte1(request.getParameter("loft"));
  String cusname="",id_crad="",phone="",sj="",addr="",cusno="";
  String code1=getbyte1(request.getParameter("code"));
  if (!code1.equals("")){
   ViewBean.executeUpdate("delete YLroom where code="+code1);
  setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "Ԥ������" , 
                  "ȡ��"
                ) ;
 
  
  }
%>
<body >
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<SCRIPT language=javascript >
function FindOption(){

openwin("FindCustomer.jsp?section=<%=secno %>&FindCus=",400,380,300,100);  //+document.cus.cusname1.value
 }
 
function openwin(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
</SCRIPT>

 
<form name=cus method="post" action="add_yl_rooms.jsp">
  <input type="hidden" name="rooms" value="<%=rooms%>">
  <input type="hidden" name="secname" value="<%=name%>">
  <input type="hidden" name="secno" value="<%=secno%>">
  <input type="hidden" name="build" value="<%=build%>">  
  <input type="hidden" name="loft" value="<%=loft%>">  
   <input type="hidden" name="FindB1" value="ok">  

<div align="center">
<p><font color="#0000CC"><b><font size="3" class=FontColor>Ԥ���Ǽ�</font></b></font></p></div>

<table border="0" width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#fffff" class="tablefill" >
<tr>
    <td width="16%" class=roomleft>&nbsp;Ԥ������:</td>
    <td  class=roomright ><%=rooms %> </td>
  </tr>
  <tr>
    <td width="16%" class=roomleft>&nbsp;������:</td>
    <td class=roomright ><select name="person">
		  <%
           String StrSql="select seller from seller where section_no='"+secno+"'";
            ResultSet codeRS=null;
		   codeRS=ViewBean.executeQuery(StrSql);
		   String codename="";
		   while (codeRS.next()){
		     codename=getbyte(codeRS.getString("seller"));
			  out.print("<option value='"+codename+"'>"+codename+"</option>");
		   }
		   codeRS.close();
		   %>
		  </select>  </td>
  </tr>
  <tr>
    <td width="16%" class=roomleft>&nbsp;��׼��:</td>
    <td class=roomright>     <input type=text name="checker"  size="20"   >
</td>  
  </tr>
  <input type=hidden name="yl" value=4>
   
  <tr>
    <td width="16%" class=roomleft>&nbsp;��������:</td>
    <td  class=roomright >
     <input type=text name="youxiao"  size="20" readonly >
     <input type=button name=cale value=".." onclick="fPopUpCalendarDlg(youxiao);return false;"> <font color=red>*</font> 
    </td>	  
  </tr>
 
  </table>
  <table width="100%" >
   <input type=hidden name="cusname" value="<%=cusno %>" >
      <td width="16%" class=roomleft >&nbsp;�ͻ�����</td>
      <td colspan="2" class=roomright><input type=text   name="cusname1"  size=40  onkeydown="key(document.cus.carid)" title="����������������'/'�ָ�"  value="<%=cusname %>">
        <font color=red>*</font> 
        <input type=button name=FindB  value="����" onclick="FindOption();">
       
      <td width="2%"></td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;���֤��</td>
      <td class=roomright><input type=text  name="carid" value="<%=id_crad %>"  title="������������'/'�ָ�"   size=50   onkeydown="key(document.cus.tel)" >
        ��</td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;��ϵ�绰</td>
      <td class=roomright ><input type=text  name="tel"  size=50 title="������������'/'�ָ�"   onKeyDown="key(document.cus.youhui)" value="<%=phone %>" >
	  
      </td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;��ϵ�ֻ�</td>
      <td class=roomright ><input type=text  name="sj"  size=50 title="������������'/'�ָ�"   onKeyDown="key(document.cus.youhui)" value="<%=sj %>">        
      
      </td>
    </tr>
  <tr> 
	<td width="16%" class=roomleft>&nbsp;��ϵ��ַ</td>
         <td class=roomright ><input type=text  name="Address"  size=50    onKeyDown="key(document.cus.shouji)" value="<%=addr %>">
      </td>
    
    </tr>
  </table>
  
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
<td  align="right">���</td>
<td  align="center">�ͻ�����</td>
<td  align="center">��ϵ�绰</td>
<td  align="center">Ԥ������</td>
<td  align="center">��������</td>
<td  align="center">��׼��</td>
<td  align="center">����Ա</td>
<td  align="center">ȡ��</td>
</tr>
   <%
 String customer="select YLroom.code,customer.serialno,customer.cus_name,customer.id_card,";
 customer +="customer.sj,customer.phone,customer.address,YLroom.youxiao,";
 customer +=" YLroom.dengji,YLroom.checker,YLroom.person from customer, ";  
  customer +=" YLroom where YLroom.customer=customer.code and  YLroom.rooms in ";
customer+=" ("+rooms+") and  YLroom.section ='"+secno+"' and YLroom.loft='"+loft+"'";
  
ResultSet rs=ViewBean.executeQuery(customer);

int ii=1;
while (rs.next()){
   cusno="";
   String code=getbyte(rs.getString("code"));
   cusno=getbyte(rs.getString("serialno"));
   cusname=getbyte(rs.getString("cus_name"));
   id_crad=getbyte(rs.getString("id_card"));
   sj=getbyte(rs.getString("sj"));
   phone=getbyte(rs.getString("phone"));
   addr=getbyte(rs.getString("address"));
   String youxiao=getbyte(rs.getDate("youxiao").toString());
   String s_date=getbyte(rs.getDate("dengji").toString());
   String checker=getbyte(rs.getString("checker"));
   String person=getbyte(rs.getString("person"));
  %>
  <tr  class=listcontent> 
<td  align="right"><%=ii %></td>
<td  align="center"><%=cusname %></td>
<td  align="center"><%=phone+sj %></td>
<td  align="center"><%=s_date %></td>
<td  align="center"><%=youxiao %></td>

<td  align="center"><%=checker %></td>
<td  align="center"><%=person %></td>
<td  align="center"><a href="#" onclick="document.cus.code.value='<%=code %>';document.cus.submit();">ȡ��</a></td>
</tr>
<%ii++;}
rs.close();  
  if (cusno.equals("")&&!code1.equals("")){ ViewBean.executeUpdate("update room set salestate=1 where room_code in ("+rooms+") and  seccode ='"+secno+"' and loft='"+loft+"'");
 %>
 <SCRIPT language=javascript>
opener.window.document.frm.submit();
	 window.close();
 </script>
 
 <%
  }
%> 
<input type=hidden name=code value=aaa>
  <p align="center"> 
            &nbsp;&nbsp; <input type=button name=ss value=" �� �� " onclick="SaveCancel();" >
           &nbsp;&nbsp;
           <input type=button name=ss value=" �� �� "  onclick="window.close();">
          </P>

</form>
<SCRIPT language=javascript>
 
   function Validate(aForm)
   {   if (aForm.yl.value==4){
       if (aForm.person.value.length<1)
	    	{
	    	alert("�����뾭���ˣ�");
	        aForm.person.focus();
	        return (false);
	    	}	
		 if (aForm.checker.value.length<1)
	    	{
	    	alert("��������׼��");
	        aForm.comm.focus();
	        return (false);
	    	}			
			 if (aForm.cusname1.value.length<1)
	    	{
	    	alert("������Ԥ���ͻ�����");
	        aForm.cusname1.focus();
	        return (false);
	    	}			
			
      if (aForm.youxiao.value==""&&aForm.yl.value==4)
	    	{
	    	alert("��ѡ��Ԥ������");
	        aForm.youxiao.focus();
	        return (false);
	    	}	
			}					
	  return (true);
	}
	function SaveCancel(){
      if (Validate(document.cus)){
	   <%if (!cusno.equals("")){ %>
	     if (confirm("ȷ��Ԥ����")){
		 <%} %>
	   document.cus.action="SaveRoomYL.jsp";
	   document.cus.submit();
	     <%if (!cusno.equals("")){ %>
		 }
		 <%} %>
     }
    }	
   </script>		
</body>

</html>
