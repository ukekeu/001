<%@ page import = "java.sql.*,java.util.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>数据库的备份</title>
</head>
	<LINK href="../class/news.css" rel=stylesheet>
<body oncontextmenu="return false" >

<%
try{
    //保存文件主目录
	String filename=getbyte1(request.getParameter("filename"));
	 
	 String filepath=request.getRealPath(request.getServletPath());
     String sep=System.getProperty("file.separator");
     String filesep="";
     if(sep.equals("\\"))
      filesep="\\"; //win平台
     else if(sep.equals("/"))
      filesep="/"; //unix平台
     int pos=filepath.lastIndexOf("\\");
     String savepath="";
	 String back_p=(String) session.getAttribute("loginuserid");
     if(pos!=-1)
       savepath=filepath.substring(0,pos-7)+"database\\"+filename;
  
if (!filename.equals("")){
  aBean.executeUpdate("exec back '"+savepath+"','"+back_p+"'");
  out.print("<script>alert('备份完毕');</script>");
  }
}catch(Exception s)   {out.println(s.getMessage());}
 //当前日期
 Calendar nowcal=new GregorianCalendar();
 int nowyear=nowcal.get(Calendar.YEAR);
 int nowmonth=(nowcal.get(Calendar.MONTH)+1);
 int nowday=nowcal.get(Calendar.DATE);
 String nowdate=""+nowyear+"-"+nowmonth+"-"+nowday;
 String strnowmonth=""+nowmonth;
 if(strnowmonth.length()==1) strnowmonth="0"+strnowmonth;
 String strnowday=""+nowday;
 if(strnowday.length()==1) strnowday="0"+strnowday;
 String strnowdate=""+nowyear+strnowmonth+strnowday;
   String sel=(String)request.getParameter("sel");
      if(sel==null) sel="2";	
 %>
 <form name=frm method=post>
 <input type=hidden name=sel value="<%=sel%>">
 <br>
 说明：本系统的数据库文件每天在第一个用户登录后自动备份,也可以手工备份。<br><br>
<table align="center" width="80%" ><tr ><td>请输入备份的数据库文件名称:</td><td><input type=text name=filename value="<%="crm_"+strnowdate+".bak" %>">&nbsp;&nbsp;<input type=button name=back value="开始备份数据库" onclick="s_b();"></td></tr>
</table>
<br>
<center> <font size=4>备&nbsp;份&nbsp;日&nbsp;志</font>
 <br>  
 
<table width="100%">
 <tr class=listtitle><td>	 <font color=white>备份人</font></td><td>	 <font color=white>备份时间</font></td><td>	 <font color=white>存在目录</font></td><td>	 <font color=white>下载</font></td></tr>
<%
  ResultSet rs=aBean.executeQuery("select backperson,backdate,databasepath from backlog");
  while (rs.next()){
  out.print("<tr class='listcontent'><td>"+getbyte(rs.getString("backperson"))+"</td>");
  out.print("<td>"+getbyte(rs.getString("backdate"))+"</td>");
  String backd=getbyte(rs.getString("databasepath"));
  out.print("<td>"+backd+"</td>");
  backd=backd.substring(backd.lastIndexOf("database"));
  %>
 <td><a href="../../<%=backd%>">下载</a></td></tr> 
  <%}
 %>
 </table>
</center>
<script>
 function s_b(){
 if (confirm("确认开始备份当前系统的数据库吗？"))
  document.frm.submit();
 }
</script>
</form>

</body>
</html>
