<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
	<title>��ӡ���۱���</title>
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
   String PARA_SQL=China.getParameter(request,"PARA_SQL");//����
   String constractno=China.getParameter(request,"url1");
   String if_name=China.getParameter(request,"if_name");
   String if_value=China.getParameter(request,"if_value");
 
   String reporttype=request.getParameter("reporttype1");//�������/sale:Ϊ���۱���,finace:Ϊ���񱨱�
   String tablename=request.getParameter("tablename1");//�����VIEW��ʹ������function,��ֻ�ܸ���Table Name
   String ifvalue[]=request.getParameterValues("ifvalue");//��ȡ����ֵ
   String reportState=China.getParameter(request,"reportState");
  
   String WhereSQL="";
   String WhereSQL1="";
   String SqlStr="";
   String TableNameStr=""; 

 for (int ii=0;ii<ifvalue.length;ii++){//ת��ֵ��Ϊ�������
   if (WhereSQL.equals(""))WhereSQL=getbyte1(ifvalue[ii]);
   else WhereSQL+="  "+getbyte1(ifvalue[ii]);
 }
 
  
  if (reportState.equals("1")){
  
  
   try{
   //�����ļ���Ŀ¼
	 String filepath=request.getRealPath(request.getServletPath());
	 String company=request.getParameter("company");
     String sep=System.getProperty("file.separator");
     String filesep="";
     if(sep.equals("\\"))
      filesep="\\"; //winƽ̨
     else if(sep.equals("/"))
      filesep="/"; //unixƽ̨
     int pos=filepath.lastIndexOf("\\");
     String savepath="";
     if(pos!=-1)
     savepath=filepath.substring(0,pos+1)+"condition"+constractno+".txt";
     String file=txt.WriteToTXT(if_value,if_name,savepath); 
     out.print("ϵͳ���Զ������˲����ļ��ļ����ļ�λ��"+savepath);
    // txt.WriteToTXT(if_value,if_name);
  
   }catch(Exception s){out.print("������������ԭ��"+s.getMessage());}
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
