<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="txt" scope="page" class="ConnDatabase.WriteToTxtBean"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>选择送办条件</title>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script>
function okvalue(){
if (document.frm.bk.value==""){
  alert("请选择按揭的银行");
  return false;
  }
  if (document.frm.ajDate1.value==""){
  alert("请选择送办日期");
  return false;
  }
  if (document.frm.checkedAj.checked){
  
  if (document.frm.ajDate.value==""){
  alert("请选择按揭日期");
  return false;
  }
  if (document.frm.bank_person.value==""){
  alert("请选择银行经办人");
  return false;
  }
  }
 document.frm.submit();
}
function checkAjState(para){
  if (para.checked){
  document.frm.ajDate.disabled=false;
   document.frm.bank_person.disabled=false;
    document.frm.cale1.disabled=false;
  
  }else{
   document.frm.ajDate.disabled=true;
    document.frm.bank_person.disabled=true;
   document.frm.cale1.disabled=true;
  }


}
</script>
</head>
<center>
<form name=frm method="post" action="rep_ajlist.jsp?codes=<%=request.getParameter("codes") %>">
 <table width="100%" >
 
<tr class='listcontent'>
<td>按揭银行：</td><td><select name="bk"  style="width : 105">
         <option></option>
		  <%
	   String  StrSql="select type,codename from CODE where type='T' order by type";
    ResultSet    codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
		     String bk1=getbyte(codeRS.getString("codename"));
			 out.print("<option value='"+bk1+"'>"+bk1+"</option>");
		   }
		   codeRS.close();
				%>
        </select><font color="red">*</font></td>
 
  <td width="14%">送办日期：</td>
      <td width="18%"><INPUT TYPE="text"  readonly NAME=ajDate1 size=10  onkeydown="key(document.cus.ajDate1)" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ajDate1);return false;" title="请选择按揭日期"><font color="red">*</font></td>
 
  <td width="14%">按揭方式：</td>
      <td width="18%">
	  <select name="aj_type"><option value=1>商&nbsp;贷</option><option value=2>公积金</option><option value=3>商业+公积金</option></select>
	  
	  </td>
</tr>
<tr class='listcontent'><td width="14%">已办按揭：</td><td  width="18%"><input name="checkedAj" onclick="checkAjState(this);" type="checkbox" value=1>(选中表示确认)</td>
  <td width="14%">按揭日期</td>
      <td width="18%"><INPUT TYPE="text"  disabled  title="日期格式：年-月-日" NAME=ajDate size=10  onkeydown="key(document.cus.ajDate)" value=<%=getbyte(request.getParameter("ajDate")) %>><input type=button disabled name="cale1" value=".." onclick="fPopUpCalendarDlg(ajDate);return false;" title="请选择按揭日期"></td>
 <td width="14%">经办人</td>
      <td width="18%"><INPUT TYPE="text"  disabled  NAME=bank_person size=13  onkeydown="key(document.cus.ajDate1)" value=""></td>
</tr>

 
</table>
<p></p>
 <input type=button name=submit1 value="确认送办"  onclick="okvalue();"> <input type=button name=winclose value="关 闭" onclick="window.close();" >
 
</form>     
       
       </center>
</body>       
</html>       
