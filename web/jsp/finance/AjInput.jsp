<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>

<%@ include file="../public_js/getByteOut.jsp"%>
 
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>���ҿ�Ǽ�</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<SCRIPT language=javascript>
  function saveaj(){
  if (Validate(document.cus1)){
     document.cus1.Save.disabled=true;
     document.cus1.action="AjInsert.jsp";
	 document.cus1.submit();
   }
 }
     function Validate(aForm)
   {
     
		
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("���������ڣ�");
	        aForm.Date1.focus();
	        return (false);
	    	}		
			 if (aForm.ajtype.value.length<1)
	    	{
	    	alert("��ѡ�񰴽����ͣ�");
	        aForm.ajtype.focus();
	        return (false);
	    	}		
			 if (aForm.ajbk.value.length<1)
	    	{
	    	alert("��ѡ�񰴽����У�");
	        aForm.ajbk.focus();
	        return (false);
	    	}	
			
			 if (aForm.FactMoneyType.value.length<1)
	    	{
	    	alert("��ѡ��������ԣ�");
	        aForm.FactMoneyType.focus();
	        return (false);
	    	}	
			
			
		if(isNaN(aForm.FactMoney.value)){
			alert("ʵ�ս����������֣�");
	        aForm.FactMoney.focus();
	        return (false);
		}
		if (aForm.Receiver.value.length<1){
	    	alert("�������տ�Ա��");
	        aForm.Receiver.focus();
	        return (false);
	    }	
	  if (parseInt(document.cus1.FactMoney.value)>parseInt(document.cus1.ajmoney.value)){
	     alert("���зſ�ܴ��ڿͻ��İ��ҿ�");
	     document.cus1.FactMoney.focus();
	    return false;
	  }
	
	if (aForm.ajtype.value==0&&aForm.FactMoneyType.value==1){
	  alert("�������Կ�������");
	return false;
	
	}if (aForm.ajtype.value==1&&aForm.FactMoneyType.value==0){
	  alert("�������Կ�������");
	return false;
	
	}
		//--Add End	
		if (confirm("ȷ��������ȷ��"))
	    return (true);
   }
    
</SCRIPT>


<body  bgcolor="#EBEBEB" onload="full();">
<%String sql="select aj_type,AjBk from order_contract where code="+request.getParameter("code") ; 

  ResultSet rs=ViewBean.executeQuery(sql);
  String ajtype="";
  String ajbank="";
  if (rs.next()){  
    ajtype=rs.getString("aj_type");
	ajbank=rs.getString("AjBk");
  }
  if (ajtype.equals("0"))ajtype="";
  rs.close();

%>
<form method="POST" name="cus1" action="">
   <input type=hidden name=room value="<%=getbyte2(request.getParameter("room")) %>">
	<p align="center"><b><font size="3" color="#000080">���ҿ�Ǽ�</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;��������</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value=""  onkeydown="key(document.cus1.TAXNAME)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
           <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;�������</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=ajtype style="width : 115"><option></option><option value=0>��ҵ����</option><option value=1>������</option><option value=2>��ҵ+������</option></select>
        </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;�ſ���</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney"   value="<%=request.getParameter("aj") %>" onkeydown="key(document.cus1.pjno)" size="15" style="border-style: solid; border-width: 1">
        </td>
      </tr>
	   <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��������</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=FactMoneyType style="width : 115"><option></option><option value=0>��ҵ����</option><option value=1>������</option></select>
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;Ʊ�ݺ���</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="pjno"   value="" onkeydown="key(document.cus1.BillType)" size="15" style="border-style: solid; border-width: 1">
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��������</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=ajbk   style="width : 115">
         <option></option>
		  <%
	 String    StrSql="select type,codename from CODE where type='T' order by type";
    ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
		     String ajbk=getbyte(codeRS.getString("codename"));
			 out.print("<option value='"+ajbk+"'>"+ajbk+"</option>");
		   }
		   codeRS.close();
				%>
        </select>
		  
        </td>
      </tr>
	  
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;�տ�Ա</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=Receiver  onkeydown="key(document.cus1.Save)" value=<%=(String)session.getAttribute("loginname") %> size="15" style="border-style: solid; border-width: 1">
        </td>
      </tr>
    </table> 
	<p></p>
	 <div align="center"> 

             <input type=hidden name=cusno value="<%=request.getParameter("cusno") %>">
			  <input type=hidden name=contractno value="<%=request.getParameter("code") %>">
			  <input type=hidden name=ajmoney  value="<%=request.getParameter("aj") %>">
            <input type="button" value="�ᡡ��" name="Save" onclick="saveaj();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                      <input type="reset" value="��  ��" name="button" onclick="window.close();">
          </div> 
</form>     
 
   <script>
function full(){
  setSelectMad(document.cus1.ajtype,'<%=ajtype %>');
  setSelectMad(document.cus1.ajbk,'<%=ajbank%>');

}

</script>
       
       
</body>       
</html>       
