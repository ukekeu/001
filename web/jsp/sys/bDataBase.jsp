<%@ page import = "java.sql.*,java.util.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>���ݿ�ı���</title>
</head>
	<LINK href="../class/news.css" rel=stylesheet>
<body oncontextmenu="return false" >

<%
try{
    //�����ļ���Ŀ¼
	String filename=getbyte1(request.getParameter("filename"));
	 
	 String filepath=request.getRealPath(request.getServletPath());
     String sep=System.getProperty("file.separator");
     String filesep="";
     if(sep.equals("\\"))
      filesep="\\"; //winƽ̨
     else if(sep.equals("/"))
      filesep="/"; //unixƽ̨
     int pos=filepath.lastIndexOf("\\");
     String savepath="";
	 String back_p=(String) session.getAttribute("loginuserid");
     if(pos!=-1)
       savepath=filepath.substring(0,pos-7)+"database\\"+filename;
  
if (!filename.equals("")){
  aBean.executeUpdate("exec back '"+savepath+"','"+back_p+"'");
  out.print("<script>alert('�������');</script>");
  }
}catch(Exception s)   {out.println(s.getMessage());}
 //��ǰ����
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
 ˵������ϵͳ�����ݿ��ļ�ÿ���ڵ�һ���û���¼���Զ�����,Ҳ�����ֹ����ݡ�<br><br>
<table align="center" width="80%" ><tr ><td>�����뱸�ݵ����ݿ��ļ�����:</td><td><input type=text name=filename value="<%="crm_"+strnowdate+".bak" %>">&nbsp;&nbsp;<input type=button name=back value="��ʼ�������ݿ�" onclick="s_b();"></td></tr>
</table>
<br>
<center> <font size=4>��&nbsp;��&nbsp;��&nbsp;־</font>
 <br>  
 
<table width="100%">
 <tr class=listtitle><td>	 <font color=white>������</font></td><td>	 <font color=white>����ʱ��</font></td><td>	 <font color=white>����Ŀ¼</font></td><td>	 <font color=white>����</font></td></tr>
<%
  ResultSet rs=aBean.executeQuery("select backperson,backdate,databasepath from backlog");
  while (rs.next()){
  out.print("<tr class='listcontent'><td>"+getbyte(rs.getString("backperson"))+"</td>");
  out.print("<td>"+getbyte(rs.getString("backdate"))+"</td>");
  String backd=getbyte(rs.getString("databasepath"));
  out.print("<td>"+backd+"</td>");
  backd=backd.substring(backd.lastIndexOf("database"));
  %>
 <td><a href="../../<%=backd%>">����</a></td></tr> 
  <%}
 %>
 </table>
</center>
<script>
 function s_b(){
 if (confirm("ȷ�Ͽ�ʼ���ݵ�ǰϵͳ�����ݿ���"))
  document.frm.submit();
 }
</script>
</form>

</body>
</html>
