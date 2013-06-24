<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>按揭款登记</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<SCRIPT language=javascript>
  function saveaj(){
  if (Validate(document.cus1)){
   
     document.cus1.action="AjInsert.jsp";
	 document.cus1.submit();
   }
 }
     function Validate(aForm)
   {

		
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("请输入日期！");
	        aForm.Date1.focus();
	        return (false);
	    	}		
		if(isNaN(aForm.FactMoney.value)){
			alert("实收金额必须是数字！");
	        aForm.FactMoney.focus();
	        return (false);
		}
		
	 
		
		if (aForm.Receiver.value.length<1){
	    	alert("请输入收款员！");
	        aForm.Receiver.focus();
	        return (false);
	    }	
	  if (parseInt(document.cus1.FactMoney.value)>parseInt(document.cus1.ajmoney.value)){
	     alert("银行放款不能大于客户的按揭款");
	     document.cus1.FactMoney.focus();
	    return false;
	}
		//--Add End	
	    return (true);
   }
    
</SCRIPT>


<body  bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="">
   <input type=hidden name=room value="<%=getbyte2(request.getParameter("room")) %>">
	<p align="center"><b><font size="3" color="#000080">按揭款登记</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;到帐日期</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value=""  onkeydown="key(document.cus1.TAXNAME)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
         
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;放款金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney"  size=12 value="-<%=request.getParameter("aj") %>" onkeydown="key(document.cus1.BillType)" size="15" style="border-style: solid; border-width: 1">
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;按揭银行</td>
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
			 out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
        </select>
		  
        </td>
      </tr>
	  
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;收款员</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=Receiver size=12 onkeydown="key(document.cus1.Save)" value=<%=(String)session.getAttribute("loginname") %> size="15" style="border-style: solid; border-width: 1">
        </td>
      </tr>
    </table> 
	 <div align="center"> 

             <input type=hidden name=cusno value="<%=request.getParameter("cusno") %>">
			  <input type=hidden name=contractno value="<%=request.getParameter("code") %>">
			  <input type=hidden name=ajmoney  value="<%=request.getParameter("aj") %>">
            <input type="button" value="提　交" name="Save" onclick="saveaj();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                      <input type="reset" value="取  消" name="button" onclick="window.close();">
          </div> 
</form>     
 
   
       
       
</body>       
</html>       
