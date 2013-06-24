 
<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
	<title>投诉登记</title>
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
 String TS_STATE="";
 String TS_cus_type="";
 String TS_COMM_DATE="",TS_TXTS="";
 String TS_END_CONTEXT="",TS_COMM_endDATE="";
 String TS_TEL="",TS_APDATE="",TS_FT="";
 String TS_SJ="",TS_COMM_DEPT="",TS_COMM_PERSON="";
try{
	ResultSet rs=ViewBean.executeQuery(SQL);
 
 
	while (rs.next()){
	 
	  //按FIELDS顺序一GET　VALUE
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
	    TS_COMM_DATE=getbyte(rs.getDate("TS_COMM_DATE").toString());
		TS_COMM_endDATE=getbyte(rs.getDate("TS_COMM_endDATE").toString());
		TS_COMM_DEPT=getbyte(rs.getString("TS_COMM_DEPT"));
	    TS_COMM_PERSON=getbyte(rs.getString("TS_COMM_PERSON"));
		TS_APDATE=getbyte(rs.getString("TS_APDATE"));
	    TS_FT=getbyte(rs.getString("TS_FT"));
	    TS_TXTS=getbyte(rs.getString("TS_TXTS"));
		if (!TS_STATE.equals("0"))TS_APDATE=getbyte(rs.getDate("TS_APDATE").toString());
	   }
  rs.close();

}catch(Exception se){
	out.print("系统出错，出错如下：");
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
<tr><td colspan="4" align="center"><font size="3">派  单 </font></td></tr>
<tr><td colspan="4" align="center">&nbsp;</td></tr>
<tr>
<td class="roomleft">投诉客户</td>
<td class=roomright> &nbsp;<%=TS_CUSTOMER %></td>
<td class="roomleft">客户类别</td>
<td class=roomright>
<%if (TS_cus_type.equals("0")){out.print("业主");}else{out.print("非业主");} %>
   </td>

</tr>
<tr>
 <td class="roomleft">客户电话</td>
<td class=roomright>&nbsp;<%=TS_TEL %></td>
 
<td class="roomleft">所在单元</td> 
<td class=roomright>&nbsp;<%=TS_ROOM %></td>
 
</tr>

<tr> 
<td class="roomleft">投诉类别</td> 
<td class=roomright>
 &nbsp;<%=TS_TYPE %>
 </td>
 <td class="roomleft">投诉日期</td>
<td class=roomright>&nbsp;<%=TS_DATE %></td>
</tr>

<tr> 
<td class="roomleft">投诉主题</td> 
<td  colspan="3" class=roomright>&nbsp;<%=TS_TITLE %></td>
 
</tr>
<tr> 
<td class="roomleft">投诉内容</td> 
<td colspan="3" class=roomright>&nbsp;<%=TS_CONTEXT %></td>
 
</tr>
<tr><td colspan="4" align="center">&nbsp;</td></tr>
 

<%if (TS_STATE.equals("0")){ %>
<tr><td class="roomleft">
执行部门

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
执行人

</td>
<td class=roomright><input type=text name=comm_person></td>
</tr>
<tr>
<td class="roomleft">开始日期</td>
<td  class=roomright><input type=text name=sdate size=17><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(sdate);return false;" title="请选择日期"></td>
<td class="roomleft">结束日期</td>
<td  class=roomright><input type=text name=edate size=17><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(edate);return false;" title="请选择日期"></td>

</tr>
<tr>
<td class="roomleft">是否催办</td>
<td  class=roomright><input type=checkbox name=tx size=17 value=1> </td>
<td class="roomleft"> 提前天数</td>
<td  class=roomright><input type=text name=num value=0   size=17 disabled>  </td>

</tr>
<tr><td colspan="4" align="center"><input type=button name=save value=" 提 交" onclick="tj();">&nbsp;<input type=button name=winclose value=" 退 出" onclick="window.close();"  ></td></tr>
<%}else if (TS_STATE.equals("1")){%>
<tr><td class="roomleft">
执行部门

</td>
<td class=roomright><%=TS_COMM_DEPT %></td>
<td class="roomleft">
执行人

</td>
<td class=roomright><%=TS_COMM_PERSON %></td>
</tr>
<tr>
<td class="roomleft">开始日期</td>
<td  class=roomright><%=TS_COMM_DATE %></td>
<td class="roomleft">结束日期</td>
<td  class=roomright><%=TS_COMM_endDATE %></td>

</tr>
<tr>
<td class="roomleft">是否催办</td>
<td  class=roomright><%if (TS_FT.equals("0")){out.print("不崔办");} else{out.print("崔办");}%>  </td>
<td class="roomleft"> 提前天数</td>
<td  class=roomright><%=TS_TXTS %> </td>

</tr>

<tr>
<td class="roomleft">安排日期</td>
<td  class=roomright><%=TS_APDATE %>  </td>
<td class="roomleft">  </td>
<td  class=roomright>  </td>

</tr>
<tr>
<td class="roomleft">完成日期</td>
<td  class=roomright><input type=text name=wcdate size=17><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(wcdate);return false;" title="请选择日期"> </td>
<td class="roomleft"> 处理人 </td>
<td  class=roomright> <input type=text name=clr size=17> </td>

</tr>
<tr> 
<td class="roomleft">处理结果</td> 
<td colspan="3" class=roomright><textarea cols="52" rows="5" name=context> </textarea></td>
 
</tr>
<tr><td colspan="4" align="center"> <input type=button name=save value=" 提 交" onclick="tj();">&nbsp;<input type=button name=winclose value=" 退 出" onclick="window.close();"  ></td></tr>


<%} %>
</table>
</form>
<script>

function tj(){

 if (checkvalue()){
 
  document.form1.action="ts_input_save.jsp?options=wc&ts_code=<%=ts_code %>";
 
  document.form1.submit();
  

 }
}
function checkvalue(){

   
   if (document.form1.wcdate.value==""){
      alert("请选择完成日期");
      return false;
   
   }
    if (document.form1.clr.value==""){
      alert("请填写处理人");
      return false;
   
   }
    if (document.form1.context.value==""){
      alert("请填写处理结果");
      return false;
   
   }
   
  
    return true;
}
function searcher(){
  openwin("findcustomer.jsp?section="+document.form1.section.value,400,380,300,100); 

}
</script>

</body>
</html>
