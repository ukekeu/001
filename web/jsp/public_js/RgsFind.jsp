<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>认购列表</title>

<script language=javascript src="../public_js/basal.js"> </script>
</head>
<body>
<%@ page language="java" import="java.sql.*,java.util.Date,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<form name="cus" method="post" action="rgsview.jsp">
  <p>
区域: 
       <select name="Region" style="border-style: solid; border-width: 1">
		<%
		    
  	String Type1=request.getParameter("Type1");
 	String Type=request.getParameter("Type");
	String SectionName=request.getParameter("SectionName");
     String sql="select Area_Type,Area_Name from Region"+Type1;
	 String Area_Name="";
	 String Area_Type="";
     ResultSet rsR=ViewBean.executeQuery(sql);
     while (rsR.next()){
		Area_Type=rsR.getString("Area_Type");
		Area_Name=rsR.getString("Area_Name");
	    %> 
       <option value=<%=Area_Type+"*"+ Area_Name%>><%=Area_Name %></option>
    <%}
    rsR.close();
   %>
	</select>
	<input type=hidden name=SectionName  value=<%=SectionName %>>
楼盘 <select name="SecNo"  onchange="FindArry();"> <option value=""></option> 
<%
    sql="select SerialNo,Name from section"+Type;
    ResultSet secRs=ViewBean.executeQuery(sql);
    while (secRs.next()){
	   String no=secRs.getString("SerialNo");
	   
	   String sec=secRs.getString("Name");
     	out.print("<option value='"+no+"'>"+sec+"</option>");
	  }
	    secRs.close();
		String Sql="";
     %> </select>&nbsp;
	 <%@ include file="../public_js/selectSRB.jsp"%>
	 
	 房号<input type=text size=5 name=RoomNo>
	 <br>
	  认购日期:
	  <INPUT TYPE=TEXT NAME=Date1 size=10><input type=button name=cale value=".." onclick="DID('1');sh();">--><INPUT TYPE=TEXT NAME=Date2 size=10><input type=button name=cale value=".." onclick="DID('2');sh();">
	 户型: <select name="fx"> 
 <option></option>
<option value="一房">一房</option> <option value="一房一厅">一房一厅</option> <option value="两房一厅">两房一厅</option> <option value="两房两厅">两房两厅</option> 
<option value="三房一厅">三房一厅</option> <option value="三房两厅">三房两厅</option> <option value="四房一厅">四房一厅</option> <option value="四房两厅">四房两厅</option> 
</select>付款方式<select name="pay" > 
<option></option>

 <%
 	out.println(commonListBean.getList(ViewBean,"PayName","PayName"," from PayMent"));
 
     %> </select><input type=submit name="FindSection" value="查询">
	 
  </p>  
</div>
</form>
</body>

</html>
