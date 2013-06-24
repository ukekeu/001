<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="writefile" scope="page" class="ConnDatabase.WriteToExcelBean"/>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>自定义报表</title>

</head>

<%
String title=request.getParameter("para");
String para=request.getParameter("para");
String type=request.getParameter("type");
String report=China.getParameter(request,"report");
if (para==null){

String  [] sells=request.getParameterValues("out1");
String  [] orderbys=request.getParameterValues("orderby");
String orderbytype=China.getParameter(request,"orderbytype");
String orderby="";
String dd="";
if (orderbys!=null){
for (int aa=0;aa<orderbys.length;aa++){
  if (orderbys[aa]!=null){
     dd= new String(orderbys[aa].getBytes("ISO8859_1"),"GBK");
	 dd=dd.substring(0,dd.indexOf("-"));
  if (orderbytype.equals("0")){
   if (orderby.equals(""))orderby=dd+" asc";
   else orderby+=","+dd+" asc";
  }else{
   if (orderby.equals(""))orderby=dd+" desc";
   else orderby+=","+dd+" desc";
    } 
	}
}
}
orderby="order by "+orderby;
 
int arrylen=sells.length;
String strFiledE[]=new String[arrylen];
String strFiledC[]=new String[arrylen];
String sqlstr="";
String errorT="";

/*try{
	 ViewBean.executeUpdate("delete ReportSet where Type='"+type+"'");
	 }catch(Exception d){}
*/	 
for (int i=0;i<arrylen;i++){
   try{
    strFiledE[i]=new String(sells[i].getBytes("ISO8859_1"),"GBK");

	strFiledC[i]=strFiledE[i].substring(strFiledE[i].indexOf("-")+1);
	strFiledE[i]=strFiledE[i].substring(0,strFiledE[i].indexOf("-"));
	sqlstr="insert into ReportSet (Type,E_name,C_name,reportname,orderby) values('"+type+"','"+strFiledE[i]+"','"+strFiledC[i]+"','"+report+"','"+orderby+"')";

	
	 ViewBean.executeUpdate(sqlstr);

	 errorT="TRUE";
	 %>
	
	<%
	 }catch(Exception d){	out.print(strFiledE[i]); out.close();}
}
} 
%>
<script>
	alert("系统已保存你的定义,请手工刷新");
	
       window.location="ReportSet.jsp?para=d"

	</script>
<body >


		
         
 
       
       
       
</body>       
</html>       
