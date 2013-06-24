<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*,java.lang.String.*,javax.servlet.ServletRequest.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="writefile" scope="page" class="ConnDatabase.WriteToExcelBean"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<jsp:useBean id="getByte" scope="page" class="getBytes.getBytes"/>
<%@ include file="../public_js/getByteOut.jsp"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/news.css" >
<title>打印报表</title>

</head>
<%! public boolean  IsNumber(String str) 
    { 
    String number_chars = "1234567890"; 
    for (int i=0;i<str.length();i++) 
    { 
    if(number_chars.indexOf(str.charAt(i))==-1)
        return false; 
    } 
    return true; 
    } %>

<%
String para=request.getParameter("para");
String type=request.getParameter("type");
String out1=request.getParameter("out1");
String out2=request.getParameter("out2");
String title=request.getParameter("titl");
 title=getByte.getParameter(request,title);
  String excefile=request.getParameter("excefile");
  excefile=getByte.getParameter(request,excefile);
int sumprice=0;
int countnum=0;
String titlename=""; 
String sql="";
String WhereSQL="";
   int arrylen=Integer.parseInt(request.getParameter("filednum"));
   String strFiledE[]=new String[arrylen];//保存所选数据项的字段名
   String strFiledC[]=new String[arrylen];
   String filedname=China.getParameter(request,"filedname");
   String orderby=China.getParameter(request,"orderby");
 
   titlename="序号,"+filedname;
  
   String ifvalue1[]=request.getParameterValues("ifvalue");//读取条件值
   for (int ii=0;ii<ifvalue1.length;ii++){//转换值成为组合条件
    if (WhereSQL.equals(""))WhereSQL=getbyte2(ifvalue1[ii]);
    else WhereSQL+="  "+getbyte2(ifvalue1[ii]);
   }
 
   if (WhereSQL.indexOf("(")>=0){
    String aa=WhereSQL.substring(0,WhereSQL.indexOf("(")+1);
    String aa1=WhereSQL.substring(WhereSQL.lastIndexOf(")")-1);
    String aa2=WhereSQL.substring(WhereSQL.indexOf("''")+1,WhereSQL.lastIndexOf("''"));
    WhereSQL=aa+aa2+aa1;
   }  

    sql="select "+filedname+" from  RgsViewC where "+WhereSQL+" "+orderby;
		
for (int i=0;i<=arrylen-1;i++){
       if (filedname.indexOf(",")>=0){
	   strFiledC[i]=filedname.substring(0,filedname.indexOf(","));
	   filedname=filedname.substring(filedname.indexOf(",")+1);
	   }else{
	    strFiledC[i]=filedname ;
	   filedname=filedname;
	   }
	
   }
   String tablewidth="";
   if (arrylen>6&&arrylen<=9){tablewidth="100";}
   else if (arrylen<=6&&arrylen>=5){tablewidth="90";}
   else if (arrylen>9){tablewidth="120";}
   else {tablewidth="60";}
  
    String createfile="";
	if (excefile.equals("")){
	  createfile="/jsp/excel/test.csv";
	 }else{
	  createfile="/jsp/excel/"+excefile+".csv";
	 } 

	 String reportPath = request.getRequestURI().substring(0,request.getRequestURI().lastIndexOf("/"));

	 reportPath=reportPath.substring(0,reportPath.lastIndexOf("/"));
     reportPath=reportPath.substring(0,reportPath.lastIndexOf("/"));
	String path="";
	path=application.getRealPath(createfile);
	String SEDATE="";
 
 // String file=writefile.WriteToExcel(ViewBean,titlename,title,sql,path); 
//  out.print("<div id=printdiv>");
  //out.print("系统已自动生成了EXCEL文件<a href='"+reportPath+createfile+"'>"+path+"</a>");
/*
  out.println("<input type=checkbox  onclick='printall()' >打印");
  out.println("<script>");
  out.println("function printall() {");
  out.println("printdiv.innerText = '' ;");
  out.println("print();");
out.println("}");
out.println("</script>");
out.println("</div>");
*/
%>
<div align=left id=report1 style="background-color:#F7F7F7;height:350px;overflow:auto;width:100%;z-index:2" contentEditable >
<%
out.println("<p align=center><b><font size=3>"+title+"</font></b></p>");

   out.print("<table border=1  width='"+tablewidth+"%' align=center cellspacing='0'  cellpadding='2' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000><tr align=center>");
    out.print("<td>");
	 out.print("序号");
	 out.print("</td>");
   for (int j=0;j<=arrylen-1;j++){
     out.print("<td>");
	 out.print(""+getbyte(strFiledC[j])+"");
	 out.print("</td>");
   }
   out.print("</tr>");
  ResultSet rs=null;
  int nn=0;
  try{
	rs=ViewBean.executeQuery(sql);
	while (rs.next()){
	
	nn++;
	  out.print("<tr align=center>");
	   out.print("<td>");
	 out.print(""+nn+"");
	 out.print("</td>");
	  for( int aa=1;aa<=arrylen;aa++){
         out.print("<td>");
		 String outvalue=getbyte(String.valueOf(rs.getObject(aa)));
		  if (outvalue.equals("")||outvalue.equals("null"))outvalue=" ";
		 char  CellN2=outvalue.charAt(0);
		 
		 if (outvalue.indexOf(" ")>0)outvalue=outvalue.substring(0,outvalue.indexOf(" "));
	 
		  out.print(" "+outvalue+"");
		 	 
		 if (!outvalue.equals("")&&outvalue.indexOf("-")<0)
		  CellN2=outvalue.charAt(0);
		  if(!java.lang.Character.isDigit(CellN2)){
		 out.print("&nbsp;");
		  } 
    	 out.print("</td>");
	  }
	    out.print("</tr>");
	
	}
	rs.close();
	

 }catch(Exception s){out.print(s.getMessage());}

%>

</table>	
</div>

<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
<input type="button" onclick="bringToExcel()" value="导出到Excel"><br>
导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
  <script>
 // tit.innerText="销售明细表";
    </script>
<body >


</body>       
</html>       
