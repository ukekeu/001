<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="mBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>��Ʊ�Ǽ�</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<SCRIPT language=javascript>
function steven(){
    if ( Validate(document.cus1) ){
      //  document.cus1.action="FactGatherInsert.jsp?dsd";
	  document.cus1.Save.disabled=true;
        document.cus1.submit();
    }
}
     function Validate(aForm)
   {

		if (aForm.No.value.length<1)
	    	{
	    	alert("�����뷢Ʊ��ţ�");
	        aForm.No.focus();
	        return (false);
	    	}
		
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("���������ڣ�");
	        aForm.Date1.focus();
	        return (false);
	    	}		
		if (aForm.FactMoney.value.length<1)
	    	{
	    	alert("�����뷢Ʊ��");
	        aForm.FactMoney.focus();
	        return (false);
	    	}		
		if(isNaN(aForm.FactMoney.value)){
			alert("�����������֣�");
	        aForm.FactMoney.focus();
	        return (false);
		}
		
 
		 
		//--Add End	
	    return (true);
   }
       
</SCRIPT>


<body onload="document.cus1.No.focus();" bgcolor="#EBEBEB">
<%
 String no=getbyte1(request.getParameter("No"));
 String Date1=getbyte1(request.getParameter("Date1"));
 String room=getbyte1(request.getParameter("room"));
 String Receiver=getbyte1(request.getParameter("Receiver"));
 String FactMoney=getbyte1(request.getParameter("FactMoney"));
 String context=getbyte1(request.getParameter("context"));
 String contractno=getbyte1(request.getParameter("contractno"));
 
 if (!no.equals("")){
   String SQL="INSERT INTO F_invoice(order_contract,invoice_no,invoice_money,invoice_date,";
SQL+="invoice_person,invoice_txt) VALUES("+contractno+",";
SQL+="'"+no+"',"+FactMoney+",'"+Date1+"','"+Receiver+"','"+context+"')";
   ViewBean.executeUpdate(SQL);
   setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��Ʊ�Ǽ�" , 
                  "��Ʊ"+room+",��Ʊ��:"+no
                ) ;	
%>
<script>
alert("�ѱ�������");

opener.findSub('yingshi.jsp');
window.close();

</script>

<%
 }
 %>
<form method="POST" name="cus1" action="">
<input type="hidden" name="room" value="<%=getbyte2(request.getParameter("room")) %>">
<input type="hidden" name="contractno" value="<%=request.getParameter("contractno") %>">
 	<p align="center"><b><font size="3" color="#000080">��Ʊ�Ǽ�</font></b></p>
	
   <table width="100%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
    
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��Ʊ���</td>
        <td width="25%" align="left"  height="14"  >&nbsp;<input type=text name="No"   style="border-style: solid; border-width: 1" size=15>

          
        </td>
      
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;��Ʊ����</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value=""  ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��Ʊ���</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney"  onchange="checkNaN(this);"  size="15" style="border-style: solid; border-width: 1" >
        </td>
    
        
     
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��Ʊ��</td>
        <td width="25%" align="left"  height="14"  >
		 
          &nbsp;<select name="Receiver">
		  <option><%=(String)session.getAttribute("loginname") %></option>
		  <%/*
            StrSql="select type,codename from CODE  WHERE TYPE='P1' order by type";
    
		     codeRS=null;
		   codeRS=ViewBean.executeQuery(StrSql);
		   String codename="";
		   while (codeRS.next()){
		     codename=getbyte(codeRS.getString("codename"));
			  out.print( session.getAttribute("loginname"));
		  }
		   codeRS.close();
		   */
		   %>
		  </select> 
        </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��&nbsp;ע</td>
        <td width="25%" align="left"  height="14"  colspan="3" > 
          &nbsp;<textarea rows="2" name="context" cols="45"  ></textarea> 
        </td>
      </tr> 
    </table> 
	 <br>
	 <div align="center"> 
	        
             <input type=hidden name=cusno >
            <input type="button" value="�ᡡ��" name="Save" onclick="steven();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="ȡ  ��" name="button" onclick="window.close();">
          </div> 
</form>     
 
   
       
       
</body>       
</html>       
