<%@ page contentType="text/html;charset=GBK" %>

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE>办按揭备注</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<link rel="stylesheet" href="../class/news.css" >
 
</script>

<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%> 
  <%@ include file="../public_js/logrecord.jsp" %>
 <script>
 function cancelChoose(para){
  if (confirm("确认取消吗？")){
 
  document.forms[0].action = "AjBakAdd.jsp?deledata="+para ;
  document.forms[0].submit() ;
  
  }
 }
 </script>
 
<body >
<%
    String deledata = China.getParameter(request, "deledata") ;
    String section = China.getParameter(request, "section") ;
	String htno = China.getParameter(request, "htno") ;
	String code = China.getParameter(request, "code") ;
	String bakdate = China.getParameter(request, "bak_date") ;
	String nocq = China.getParameter(request, "nocq") ;
	String ajdata = China.getParameter(request, "ajdata") ;
	if (nocq.equals(""))nocq="0";
	String state2= China.getParameter(request, "state2") ;
	  if (!state2.equals("1"))state2="0";
	   if (!ajdata.equals("1"))ajdata="0";
	
	String state3= China.getParameter(request, "state3") ;
	 if (!state3.equals("1"))state3="0";
	 
	String state4= China.getParameter(request, "state4") ;
	 if (!state4.equals("1"))state4="0";
	String bak = China.getParameter(request, "bak") ;
	if (!bakdate.equals("")&&deledata.equals("")){
	  String SQL="SELECT * FROM  aj_bak WHERE contractno="+code;

	  ResultSet rs=aBean.executeQuery(SQL) ;
	
	  if (rs.next()){
	   SQL="UPDATE aj_bak SET   state4="+state4+", state3="+state3+",state2="+state2+",bakdate='"+bakdate+"',bak='"+bak+"',state="+nocq+ ",state1="+ajdata+ " where contractno="+code;
	 aBean.executeUpdate(SQL) ;
	 
	  }else{
	    SQL="insert into  aj_bak(contractno,bakdate,bak,state,state1,state2,state3,state4) values("+code+",'"+bakdate+"','"+bak+"',"+nocq+ ","+ajdata+","+state2+","+state3+","+state4+")";
	 aBean.executeUpdate(SQL) ;
		
	  
	  } 
 
	  rs.close();  
	  if (state3.equals("1")){
	    SQL="update Order_Contract set aj_send_date=null where code="+code;
		  aBean.executeUpdate(SQL) ;
	  }
	 
	 
	   
	   for (int i=1;i<19;i++){
	     String data=getbyte1(request.getParameter("Bdatacode"+String.valueOf(i)));
		    
		    String data1=getbyte1(request.getParameter("Bdata"+String.valueOf(i)));
	       SQL="";
		 if (!data.equals("")&&!data1.equals("")){
          SQL="insert into  cq_y_tjdata(contractno,cq_data_code,type) values("+code+","+data+",1)";
	      aBean.executeUpdate(SQL) ;
		 }
	  }
	setlog( bBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "按揭提交资料" , 
                  "备注"+getbyte1(request.getParameter("room"))
                ) ;	
	  %>
	  <script>
	  
	  alert("系统已保存备注");
	   opener.document.cus.submit();
	  
	  window.close();
	  </script>
	  <%out.close();
 	}else if (!deledata.equals("")){
	  String sql="delete cq_y_tjdata where code="+deledata;
	  aBean.executeUpdate(sql) ;
	 
	}
		
	 String SQL="SELECT * FROM  aj_bak WHERE contractno="+code;
	 
	  ResultSet rs=aBean.executeQuery(SQL) ;
	  if (rs.next())	{
	    nocq=rs.getString("state");
		if (!nocq.equals("0"))nocq="checked";
		ajdata=rs.getString("state1");
		if (!ajdata.equals("0"))ajdata="checked";
		bak=rs.getString("bak");
	   bakdate=getbyte(rs.getString("bakdate"));
	   state2=getbyte(rs.getString("state2"));
	   state3=getbyte(rs.getString("state3"));
	    state4=getbyte(rs.getString("state4"));
	   if (!state2.equals("0"))state2="checked";
	   if (!state3.equals("0"))state3="checked";
	   if (!state4.equals("0"))state4="checked";
	   
	   if (!bakdate.equals(""))bakdate=bakdate.substring(0,10);
	   }
	  rs.close();
%>
 
<form method="post" name=frm > 
<Input type=hidden name="code" value="<%=request.getParameter("code") %>">

<Input type=hidden name="section" value="<%=section %>">
<Input type=hidden name="room" value="<%=section+getbyte1(request.getParameter("Loft"))+getbyte1(request.getParameter("room")) %>">
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR > 
    <TD COLSPAN="2"> 
        <DIV ALIGN="CENTER"><font size=3><%=getbyte1(request.getParameter("Loft"))+getbyte1(request.getParameter("room"))  %>办按揭备注</font></DIV>
    </TD>
  </TR>
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
</TABLE>
   <table width="90" border="0" cellspacing="0" cellpadding="0">
<tr> 
  <td class="menuselect3" width=88 height=21><font color="#FFFFFF">&nbsp;&nbsp;已提交资料</font></td>　 
</tr>
</table>	
 <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
   <%    SQL="SELECT a.dataname,b.code FROM  cq_tj_data  a, cq_y_tjdata b WHERE a.type=1 and b.cq_data_code=a.code and  b.contractno="+code+" and sectionno='"+section+"'";
	    rs=aBean.executeQuery(SQL) ; 
	  int i=0;
	   while (rs.next()){
	   i++;
	   %>
    <tr  > 
	 
      <td > 
        提交资料<%=i %>:
      </td>
      <td > 
   
          <%=rs.getString("dataname") %><input type="checkbox" name="Adata<%=i %>" size="30" onclick="cancelChoose(<%=rs.getString("code") %>);" checked value="<%=rs.getString("dataname") %>">
          <Input type=hidden name="datacode<%=i %>" value="<%=rs.getString("code") %>">
      </td> 
	  <%if (rs.next()){ i++;%>
	   <td > 
        提交资料<%=i %>:
      </td>
      <td > 
   
          <%=rs.getString("dataname") %><input type="checkbox" name="Adata<%=i %>" size="30" onclick="cancelChoose(<%=rs.getString("code") %>);" checked value="<%=rs.getString("dataname") %>">
            <Input type=hidden name="datacode<%=i %>" value="<%=rs.getString("code") %>">
      </td>
	  <%} %>
	   </tr>
	   <%}rs.close(); %>
	   </table>
  <table width="90" border="0" cellspacing="0" cellpadding="0">
<tr> 
  <td class="menuselect3" width=88 height=21><font color="#FFFFFF">&nbsp;&nbsp;未提交资料</font></td>　 
</tr>
</table>	
	    <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
   <%    SQL="SELECT * FROM  cq_tj_data   WHERE  type=1 and  not code in (select cq_data_code from  cq_y_tjdata where type=1 and  contractno="+code+") and  sectionno='"+section+"'";
	   
		 rs=aBean.executeQuery(SQL) ;
		  
	   i=0;
	   while (rs.next()){
	   i++;
	   %>
    <tr  > 
	     <td > 
        提交资料<%=i %>:
      </td>
      <td > 
   
          <%=rs.getString("dataname") %><input type="checkbox" name="Bdata<%=i %>" size="30"  value="<%=rs.getString("dataname") %>">
          <Input type=hidden name="Bdatacode<%=i %>" value="<%=rs.getString("code") %>">
      </td> 
	  <%if (rs.next()){ i++;%>
	   <td > 
        提交资料<%=i %>:
      </td>
      <td > 
   
          <%=rs.getString("dataname") %><input type="checkbox" name="Bdata<%=i %>" size="30"  value="<%=rs.getString("dataname") %>">
            <Input type=hidden name="Bdatacode<%=i %>" value="<%=rs.getString("code") %>">
      </td>
	  <%} %>
	   </tr>
	   <%}rs.close(); %>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
    <tr  > 
      <td > 
        备注日期
      </td>
      <td > 
	  <%Timestamp ts = new Timestamp(System.currentTimeMillis()) ;
		String currentDate = ts.toString().substring(0, 10) ;
		if (bakdate.equals(""))bakdate=currentDate;
		 %>
         <input type="text" name="bak_date" size="10"  value="<%=bakdate %>">
          <input type=button name=cale value=".." onClick="fPopUpCalendarDlg(bak_date);return false;" title="请选择日期">
         &nbsp;&nbsp;&nbsp;资料提交完:<input <%=ajdata  %> type=checkbox name=ajdata value=1>&nbsp;&nbsp;终审通过:<input <%=state2  %> type=checkbox name=state2 value=1>&nbsp;&nbsp;已存首期:<input <%=state4  %> type=checkbox name=state4 value=1>&nbsp;&nbsp;退件:<input <%=state3  %> type=checkbox name=state3 value=1>
      </td>
	   </tr>
	  <tr>
      <td> 
     备注内容
      </td>
	 
	  
      <td  > 
    
         <textarea cols="60" rows="3" name=bak><%=bak %></textarea>
  
      </td>
       
    </TR>
  </TABLE>
  

<table width="60%" border="0" align="center">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <div align="center">
        
		<input type="button" name="Submit3" value="提　交" onclick="return AddGh()">
      </div>
    </td>
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="退  出" onclick="window.close()">
      </div>
    </td>
  </tr>
</table>
</form>
<p>&nbsp; </p>
</BODY>
<script>
	function AddGh() {
	   if (document.frm.bak.value!="")	
	   {
		if (isNull(document.forms[0].bak_date, "请选择通知日期")) 
			return false ;	
		} 
		document.forms[0].action = "AjBakAdd.jsp" ;
		document.forms[0].submit() ;
	}
	
	 
</script>
</HTML>
