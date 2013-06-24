 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>批量录入客户资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script src="js/mad.js"> </script>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<script>
this.resizeTo(screen.availWidth,screen.availHeight);
this.moveTo(0,0);
this.focus()
</script>
<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
 
<jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />

<%@ include file="../public_js/getByteOut.jsp"%>
  <%

 String StrSql="select type,codename from CODE WHERE CHILD=0 order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[500];
   String CodeType[]=new String[500];
   codeRS=ViewBean.executeQuery(StrSql);
   int ii=0;
   while (codeRS.next()){
     CodeType[ii]=getbyte(codeRS.getString("type"));
     CodeName[ii]=getbyte(codeRS.getString("codename"));
	 ii++;
   }
   codeRS.close();
 %>	 
<body   topmargin="1" onunload="window_onunload();">
  <p align=center><font size=3 class=FontColor><b>批量录入客户资料</b></font></p>
 <form name="frm" method=post action="UpdateCus.jsp?Section=<%=request.getParameter("section")%>">
 <table width="100%" border="0" cellpadding="1" cellspacing="1">
  <tr align="center"  class=listtitle> 
     <td  > 
      <font color=white>序号</font>
    </td>
  
    <td  > 
   客户名称</td>
	 
	 
	 <td  > 
   联系电话</td>
	 
	<td  > 
    知道途径
    </td>
	 <td  > 
    来访日期
    </td>
	 <td  > 
    来自区域
    </td>
	 <td  > 
    希望户型
    </td>
	 <td  > 
    希望面积
    </td>
	 
	 <td  > 
    销售员
    </td>
  </tr> 
  <%  java.util.Date curDate=new java.util.Date();
	int CurYear=curDate.getYear()+1900;
	int CurMonth=curDate.getMonth()+1;
	int CurDay=curDate.getDate();
	String CDate=CurYear+"-"+CurMonth+"-"+CurDay;
%>
  <% for (int i=1;i<=20;i++){ %>
  <tr align="center"  class=listcontent> 
 
  
   <td > <%=i %></td>
   <td > <input type=text name="B<%=i %>" size="12"     onkeydown="key(document.frm.G<%=i %>)" ></td>
   
       
    <td ><input type=text name="G<%=i %>" size="15"     onkeydown="key(document.frm.H<%=i %>)" ></td>
  
  <td ><select  name="H<%=i %>" style="width:117"      onkeydown="key(document.frm.I<%=i %>)">
  <option></option> 
 <%
   StrSql="select  CodeValue,code from CustomerDcValue where dcCode in (select code from CustomerDc where codeName like '%途径%' and  sectionno='"+request.getParameter("section")+"')";
    codeRS=ViewBean.executeQuery(StrSql);
   
   while (codeRS.next()){
  
	       out.print("<option value="+codeRS.getString("code")+">"+codeRS.getString("CodeValue")+"</option>");
		 
       }
	   codeRS.close();
  %>
 </select> </td> 
  <td > <input type=text name="I<%=i %>"  size="10"     onkeydown="key(document.frm.J<%=i %>)" value="<%=CDate %>"  onfocus="ReadDate(this);"  ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(I<%=i %>);return false"></td>
  <td ><select  name="J<%=i %>"        onkeydown="key(document.frm.K<%=i %>)">
  <option></option> 
 <%
   for (int iii=0;iii<500;iii++){
		  if (CodeType[iii]!=null){
		   if (CodeType[iii].equals("K"))
	       out.print("<option>"+CodeName[iii]+"</option>");
		  }
       }
  %>
 </select>  </td>
  <td > <select  name="K<%=i %>"       onkeydown="key(document.frm.L<%=i %>)">
  <option></option> 
 <%
  StrSql="select  CodeValue,code from CustomerDcValue where dcCode in (select code from CustomerDc where codeName like '%户型%' and  sectionno='"+request.getParameter("section")+"')";
    codeRS=ViewBean.executeQuery(StrSql);
   
   while (codeRS.next()){
  
	       out.print("<option value="+codeRS.getString("code")+">"+codeRS.getString("CodeValue")+"</option>");
		 
       }
	   codeRS.close();
  %>
 </select>   <td >
  <select  name="L<%=i %>"       onkeydown="key(document.frm.O<%=i %>)">
  <option></option> 
 <%
   StrSql="select  CodeValue,code from CustomerDcValue where dcCode in (select code from CustomerDc where codeName like '%面积%' and  sectionno='"+request.getParameter("section")+"')";
    codeRS=ViewBean.executeQuery(StrSql);
   
   while (codeRS.next()){
  
	       out.print("<option value="+codeRS.getString("code")+">"+codeRS.getString("CodeValue")+"</option>");
		 
       }
	   codeRS.close();
  %>
 </select> </td>
  <td > 
   <select  name="O<%=i %>"     onkeydown="key(document.frm.B<%=i+1 %>)">
 <%String sell="select  seller from seller where section_no='"+request.getParameter("section")+"'";
codeRS=ViewBean.executeQuery(sell);
  while (codeRS.next()){
	   String Name=getbyte(codeRS.getString("seller"));
       out.print("<option value='  "+Name+"'>"+Name+"</option>") ;
	}
  codeRS.close(); %>
   </select>
 </td>
  
 
  </tr>
  
  <%
   }
   
 
   %>
 
<input type=hidden name=MaxRoomNo value="20">
</table>
	<p align=center>
 
        <input type="button" name="Button" value="保 存" onclick="InsertMap()">&nbsp;<input type="button" name="Button1" value="退 出" onclick="if (confirm('确认退出吗？'))window.close();">
    
</p>
 
</form>
 
</center>
 </body>
<script>
   function window_onunload()
  {
    var ansarr=new Array(1);
	ansarr[0]="1000";
 	
    returnValue=ansarr;
  }
    function ReadDate(para){
	  if (para.value=="")para.value="<%=CDate %>"
	
	}
	function InsertMap() {
	 if (confirm("确认数据正确？")){
	  	document.forms[0].submit() ;
		}
	}
</script>
</html>
