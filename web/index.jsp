 <%try{ 
    %>
<%@ page import = "java.sql.*,java.util.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="loginBean" scope="page" class="ConnDatabase.SDatabase"/>
 
 <jsp:useBean id="reg" scope="page" class="regcheck.writereadregedit"/>
 <jsp:useBean id="checkreg" scope="page" class="regcheck.regcheck"/> 
  <jsp:useBean id="HID" scope="page" class="regcheck.GetMACAddress"/> 
 <jsp:useBean id='md5' scope='request' class='crypt.MD5'/>
<%
  String infodate=reg.readRegDate();
  String infosdate=reg.readRegsDate();
 String infoState=reg.readRegState();
 int day=0;
 
 if (infoState.equals("0")){
 String REGsql="select DATEDIFF(d,getdate(),'"+infodate+"')  ddd  where convert(char(10),'"+infosdate+"',120)<=convert(char(10),getdate(),120)";  
 
 ResultSet rs=loginBean.executeQuery(REGsql);
 if (rs.next())day=rs.getInt("ddd");
 rs.close();
 }
 
   out.print(checkreg.checkREGYear());
   %>
   <html>
<head>
<META http-equiv=Content-Type content="text/html; charset=gb2312"><LINK 
href="css/ss.css" type=text/css rel=stylesheet>
<title>U客售楼管理信息系统</title>
<style type="text/css">
<!--
body {
	background-color: #CCCCCC;
}
-->
</style></head>
<SCRIPT language=JScript event="OnCompleted(hResult,pErrorObject, pAsyncContext)" for=foo>
document.forms[0].txtMACAddr.value=unescape(MACAddr);
document.forms[0].txtIPAddr.value=unescape(IPAddr);
document.forms[0].txtDNSName.value=unescape(sDNSName);
//document.formbar.submit();
</SCRIPT>
<SCRIPT language=JScript event=OnObjectReady(objObject,objAsyncContext) for=foo>
   if(objObject.IPEnabled != null && objObject.IPEnabled != "undefined" && objObject.IPEnabled == true)
   {
    if(objObject.MACAddress != null && objObject.MACAddress != "undefined")
   MACAddr = objObject.MACAddress;
    if(objObject.IPEnabled && objObject.IPAddress(0) != null && objObject.IPAddress(0) != "undefined")
   IPAddr = objObject.IPAddress(0);
    if(objObject.DNSHostName != null && objObject.DNSHostName != "undefined")
   sDNSName = objObject.DNSHostName;
    }
</SCRIPT>
<OBJECT id=locator classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id=foo classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>

<SCRIPT language=JScript>
    var service = locator.ConnectServer();
    var MACAddr ;
    var IPAddr ;
    var DomainAddr;
    var sDNSName;
    service.Security_.ImpersonationLevel=3;
    service.InstancesOfAsync(foo, 'Win32_NetworkAdapterConfiguration'); 
</SCRIPT>
<script>
  window.status="温馨提示:请把登录地址设置为信任站点后，在IE设置中，把ActiveX插件设置为启用状态";
 
  function check(){
  
   if (document.login.username.value=="")
   	{
	    	alert("请输入登录帐号！");
	        document.login.username.focus();
	        return (false);
	   }	
   if (document.login.userpassword.value=="")
   	{
	    	alert("请输入登录密码！");
	        document.login.userpassword.focus();
	        return (false);
	   }	
	   
	  if (document.login.checkCode.value=="")
   	{
	    	alert("请输入登录验证码！");
	        document.login.checkCode.focus();
	        return (false);
	   }   
	 
	   return (true);  
  }
  function openwin(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"man","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}

  function logincheck(){
   if (check()&&!document.login.showtype.checked){
     document.login.submit();
  }else if (check()&&document.login.showtype.checked){
    login1();
  
  }
 }
  function login1(){
     showx = screen.availWidth;  // + deltaX;
	showy = screen.availHeight; // + deltaY;
	var aa=document.login.username.value;
	var bb=document.login.userpassword.value;
	document.login.username.value="";
	 document.login.username.disabled=true;
	  document.login.userpassword.disabled=true;
	  var txtIPAddr=document.login.txtMACAddr.value;
	  document.login.userpassword.value="";
	var ee=document.login.userID.value;
	var ff=document.login.PASS.value;
	var gg=document.login.checkCode.value;
	var menu=document.login.menu.value;

	var showtype=document.login.showtype.value;
	  document.login.checkCode.disabled=true;
	    document.login.showtype.disabled=true;
		 document.login.menu.disabled=true;
		 document.login.checkCode.value="";
	 	 openwin("soft?menu="+menu+"&showtype="+showtype+"&userPASS="+ff+"&userID="+ee+"&username="+aa+"&userpassword="+bb+"&checkCode="+gg+"&txtIPAddr="+txtIPAddr);
  
 }
 function key(para){ 

      if (event.keyCode==13){
        logincheck();
		 }
    
	}
 function alertmess(){
  showx = screen.availWidth;  // + deltaX;
	showy = screen.availHeight; // + deltaY;
     	retval = window.showModalDialog("../alert.jsp","","dialogWidth400px; dialogHeight:250px; dialogLeft:1px; dialogTop:10px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	 
 
 }
 function setSelectMad(selectObject,setValue)  {
		 for(var i = 0;i < selectObject.options.length;i ++) 
		 		 if (selectObject.options[i].value == setValue) {
				 	   selectObject.selectedIndex = i;
		 			break;
				 }
}
   </script>
<body topmargin="0" oncontextmenu="return false" >
<%  
   String   cookieValue   =   "1";   
   String   cookieValue1   =   "4";   
  if   (request.getCookies()   !=   null)   {   
      Cookie[]   cookie   =   request.getCookies();   
      for   (int   i   =   0;   i   <   cookie.length;   i++)   {   
          Cookie   myCookie   =   cookie[i];   
 
          if  (myCookie.getName().equals("showtype"))   {   
              cookieValue   =   myCookie.getValue();   
          }else if   (myCookie.getName().equals("showmenu"))   {   
		  cookieValue1   =   myCookie.getValue();   
		  }
      }   
  }  
 Calendar calendar = Calendar.getInstance();
 
  String filename = String.valueOf(calendar.getTimeInMillis());	
   %>
 <form method="POST" name="login" action="soft" >
     <INPUT type=hidden value=192.168.0.2 name=txtIPAddr>
   <INPUT type=hidden value=typ name=txtDNSName>
 <input type=hidden name=userID value="<%= md5.getMD5ofStr( filename)%>">
 <%   filename = String.valueOf(calendar.getTimeInMillis());	 %>
 <input type=hidden name=PASS value="<%= md5.getMD5ofStr( filename)%>">
 
<table width="759" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="26" background="images/top_bg.gif" align="right" valign="top">&nbsp;&nbsp;
		
		
		</td>
  </tr>
  <tr>
    <td height="97" valign="middle" background="images/top_banner.gif"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="8" valign="middle">
		
		</td>
        </tr>
      <tr>
        <td valign="middle">&nbsp;  
          </td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="348"   valign="top" background="images/main.gif"><table width="300" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
             <td height="120" colspan="2">&nbsp;<%if (day>0&&day<6&&infoState.equals("0")){out.print("<font color=red>可用时间为:"+day+"天</font>");}else  if (day<=0&&infoState.equals("0")){%><a href="#" onclick="reg();" >注册</a><%} %></td>   </tr>
      <tr>
        <td width="100" height="40"><div align="right">用户名：</div></td>
        <td width="200"><input type="text" name="username"    size=19 <%if (day<=0&infoState.equals("0")){out.print("disabled");} %>></td>
      </tr>
      <tr>
        <td height="40"><div align="right">密&nbsp;&nbsp;码：</div></td>
        <td><input type="password" name="userpassword" onkeydown="key();" size=20 <%if (day<=0&&infoState.equals("0")){out.print("disabled");} %>></td>
      </tr>
	  
	    <tr>
        <td height="40"><div align="right">验&nbsp;证&nbsp;码：</div></td>
        <td align="justify"><input type="text" name="checkCode" onkeydown="ch(this.value);key();" onchange="ch(this.value);" size=9 <%if (day<=0&&infoState.equals("0")){out.print("disabled");} %>><img  align="absmiddle"  src="imageServlet" width="70" height="18" /></td>
      </tr>
	   <INPUT type=hidden value="" name=txtMACAddr>
 
	
        <tr>
        <td height="40">&nbsp;</td><!-- <div align="right">菜单样式：</div></td> --> <td height="10"  ><select style="display:none;" name=menu <%if (day<=0&&infoState.equals("0")){out.print("disabled");} %>><option value=4>样式1</option><option value=1>样式2</option><option value=2>样式3</option><option value=3>样式4</option></select>&nbsp; <input name="showtype" value=1 <%if (cookieValue.equals("1")){out.print("checked");} %> type="checkbox" <%if (day<0){out.print("disabled");} %>>弹出窗口</td>
        </tr>
      <tr>
        <td colspan="2"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
		
            <td><div align="right"><a href="#" OnClick="logincheck();" title="进入系统"><img src="images/dl.gif" width="81" height="22" border="0"></a></div></td>
            <td width="30">&nbsp;</td>
            <td><a href="#" onclick="window.close();" title="关闭窗口"><img src="images/tc.gif" width="81" height="22" border="0"></a>  </td>
			<td><a href="#" onclick="openwin('help.jsp',600,600,100,100);" title="登录帮助"><img src="jsp/images/p4.gif"   border="0"></a></td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="108" background="images/bottom_bg.gif" align="center">&nbsp; U客软件　版权所有<br>
		  <a href="#" onclick="alert('技术服务电话：15814891599');" title="关闭窗口">
		  <img src="jsp/images/phone.gif" title="15814891599" border="0" /></a></td>
  </tr>
  
</table> 
</form>
 <script>
   setSelectMad(document.login.menu,<%=cookieValue1 %>);
   function reg(){
showx = screen.availWidth;  // + deltaX;
	showy = screen.availHeight; // + deltaY;
     	 retval = window.showModalDialog("jsp/manager/testerror.jsp","","dialogWidth400px; dialogHeight:200px; dialogLeft:150px; dialogTop:100px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	}
	function ch(pa){
	document.login.checkCode.value=pa.toUpperCase();
	}
   </script>
<% }catch(Exception se){
      out.print("系统出错，原因如下：<br>");
      out.println(se.getMessage());
      out.print("<br>估计是数据连接不成功，请刷新重新连接数据库。");
      out.close();
   } %> 

</body>
</html>
