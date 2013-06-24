<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
	<title>打印销售报表</title>
</head>
<script>
self.resizeTo(screen.availWidth,screen.availHeight)
self.moveTo(0,0)
self.focus()
</script>

<body>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="UpdateRs" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="txt" scope="page" class="ConnDatabase.WriteToTxtBean"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<form name=rep>
 <%
   String PARA_SQL=China.getParameter(request,"PARA_SQL");//表名
   String constractno=China.getParameter(request,"url1");
   String if_name=China.getParameter(request,"if_name");
   String if_value=China.getParameter(request,"if_value");
 
   String reporttype=request.getParameter("reporttype1");//报表类别/sale:为销售报表,finace:为财务报表
   String tablename=request.getParameter("tablename1");//如果在VIEW中使用特殊function,则只能更新Table Name
   String ifvalue[]=request.getParameterValues("ifvalue");//读取条件值
   String reportState=China.getParameter(request,"reportState");
  
   String WhereSQL="";
   String WhereSQL1="";
   String SqlStr="";
   String TableNameStr=""; 

 for (int ii=0;ii<ifvalue.length;ii++){//转换值成为组合条件
   if (WhereSQL.equals(""))WhereSQL=getbyte1(ifvalue[ii]);
   else WhereSQL+="  "+getbyte1(ifvalue[ii]);
 }
 
  
  if (reportState.equals("1")){
  
  
   try{
   //保存文件主目录
	 String filepath=request.getRealPath(request.getServletPath());
	 String company=request.getParameter("company");
     String sep=System.getProperty("file.separator");
     String filesep="";
     if(sep.equals("\\"))
      filesep="\\"; //win平台
     else if(sep.equals("/"))
      filesep="/"; //unix平台
     int pos=filepath.lastIndexOf("\\");
     String savepath="";
     if(pos!=-1)
     savepath=filepath.substring(0,pos+1)+"condition"+constractno+".txt";
     String file=txt.WriteToTXT(if_value,if_name,savepath); 
     out.print("系统已自动生成了财务文件文件，文件位于"+savepath);
    // txt.WriteToTXT(if_value,if_name);
  
   }catch(Exception s){out.print("保留条件出错，原因："+s.getMessage());}
    }

TableNameStr=PARA_SQL;
  if (tablename==null)tablename="";
  if (!tablename.equals(""))TableNameStr=tablename;
 
  WhereSQL1="update roomView set out='0' ";// where section='"+secno+"'";
  SqlStr="update roomView  set out='1'  where " +  WhereSQL;
  //ViewBean.executeQuery(sql);
	 
 try{
int a=InsertBean.executeUpdate(WhereSQL1);
  int b=InsertBean.executeUpdate(SqlStr);
  

}catch(Exception s){out.print(s.getMessage()+SqlStr);out.close();}
%>
<input type=hidden name=choose value=<%=constractno %>>

<script>
  window.location="sale_list1.jsp";
 
</script>

</form>
</body>
</html>
