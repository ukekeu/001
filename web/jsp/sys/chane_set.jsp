<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import="java.sql.*" %>
<jsp:useBean id="modBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="nameBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%String uptown=getbyte2(request.getParameter("uptown"));
	   String zid=getbyte2(request.getParameter("zid"));
	   String zname=getbyte2(request.getParameter("zname")); 
	    String user_id =(String) session.getAttribute("loginuserid");
		if (!zid.equals("")){
		 modBean.executeUpdate("update PopedomConrtrol set choose=0 where sellerid='"+user_id+"'");
		 modBean.executeUpdate("update PopedomConrtrol set choose=1 where sellerid='"+user_id+"' and id in("+zid+")");
		 %>
		 <script>
		 
		 window.opener.parent.main.location="../manager/rigthmenu.jsp?MModuleNo=DESKTOP";
		 window.close();
		 
		 </script>
		 <%
		 } 
%>
 <html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<title>桌面设置——>选择我常用的模块</title>
<SCRIPT language="JavaScript" type="text/javascript"><!-- 

function chhoseData1(){
sendmess="";
sendto="";
var aaa=0;
   for (var i=0;i<document.pm.choos.length;i++){
 	   if (aaa>10){alert("最多只能设置10个快捷菜单！"); return false;}
	  if (document.pm.choos[i].checked){
	    var aa=document.pm.choos[i].value;
		aaa++;
	    if (sendmess=="")
		 sendmess=aa;
		else
		 sendmess+=","+aa;
	  
	  }
    }
	if (sendmess==""){alert("请选择你常用的模块到[我的桌面]"); return false;}
  document.pm.zid.value=sendmess;
  document.pm.submit();
}
//-->
</SCRIPT>
</head>
<script language="javascript" src="../public_js/public.js"></script>
<body topmargin="0" leftmargin="0" oncontextmenu="return false" >
<div>
<center>
<form name="pm" method="post">
<input type="Hidden" name="zid" >
 
  
<table border="0" width="100%"  cellspacing="1" cellpadding="0" class="L2">
  <tr>
    <td width="100%" align="center" colspan="2">
    
    <div align="center">
      <table border="0" width="100%" cellspacing="0" cellpadding="0">
        <tr>
          <td width="290" align="center">已授权模块列表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="oj" value="确认选择" onclick="chhoseData1();"></td>
          
        </tr>
      
		  <%String sqlPriv = "select distinct A.section ,A.manmodule,A.cortrol,B.MModuleName,B.orderby from ManModuleCortrol A,ModuleCortrol B where A.ManModule=B.MModuleNo and B.MModuleNo<>'desktop' and A.sellerid='"+user_id+"'  and b.nexus='P' order by B.orderby";
		 
			  %>
		  
		<%
		   String MODEL_NO="";
		   String MODEL_CNAME="";
		   String cortrol="";		   
		 //  if(!uptown.equals(""))
		  // {//and A.section like '%"+uptown+"%'
		  					 
		  	ResultSet rsPriv;
 			rsPriv = modBean.executeQuery(sqlPriv);
			while(rsPriv.next()){
			uptown=getbyte(rsPriv.getString("section")).trim();
				MODEL_NO = getbyte(rsPriv.getString("manmodule")).trim();
				cortrol= getbyte(rsPriv.getString("cortrol")).trim();
				MODEL_CNAME = getbyte(rsPriv.getString("MModuleName")).trim();
		  %>
		    <tr>
          <td width="140" class="input" align="right">
		  <%=MODEL_CNAME%> 
			</td>
			</tr>
		  <%
		  	String ModuleNo="";
			String ModuleName="";
			String id="";
			boolean choose=false;
			String sqlPri = "select distinct A.ModuleNo,A.checked,B.CModuleName,A.id,A.choose from PopedomConrtrol A,ModuleCortrol B where A.ModuleNo=B.CModuleNo and A.sellerid='"+user_id+"' and ManModuleNo='"+MODEL_NO+"' and b.nexus='c' order by A.ModuleNo";
							  
		  	ResultSet rsPri;
 			rsPri = nameBean.executeQuery(sqlPri);
			while(rsPri.next()){
				ModuleNo = getbyte(rsPri.getString("ModuleNo")).trim();
				id= getbyte(rsPri.getString("id")).trim();
				ModuleName = getbyte(rsPri.getString("CModuleName")).trim();
				choose=rsPri.getBoolean("choose");
		  %>  <tr>
          <td width="180" class="input" align="right">
		  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input  type=checkbox <%if (choose)out.print("checked"); %> value="<%=id%>" name=choos><%=ModuleName%>
			</td>
			</tr>
		   <%
		  	}
		  	rsPri.close();
			}
		  	rsPriv.close();
			
		 //  }
		  %>
          </select>
		  <input type=hidden name=uptown value="<%=uptown %>">
		  </td>
           
        </tr>
      </table>
      </center>
    </div>
    
    </td>
  </tr>
  <tr><td> </td></tr>
 
</table>
</form>

</div>
</body>

</html>