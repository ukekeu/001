<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>自定义报表输出</title>
<script language="JavaScript" src='../public_js/basal.js'></script>


</head>
<%	try{
 String type="";


String section=getbyte1(request.getParameter("section"));
String conStr=section;
String condi="";
if (!conStr.equals("")){
 type=conStr;
 section="select * from ReportSet where Type='"+type.substring(0,type.indexOf("*"))+"' and reportname='"+type.substring(type.indexOf("*")+1)+"'";
 }
 if (section!=null){condi="disabled";}else{section="";}
 
    String [] FiledEname=new String[100];
	String [] FiledCname=new String[100];
	String orderby="";
	 if (condi!=""){
		    ResultSetMetaData rsmd=null;
			ResultSet rs=null;
			try{
			 rs=ViewBean.executeQuery(section);
			
			}catch(Exception e){out.print(section);out.close();}
	
			 int i=0;
			 
			while (rs.next()){
			
			  FiledEname[i]=rs.getString("E_name");
			  
			  FiledCname[i]=getbyte(rs.getString("C_name"));
			  orderby=getbyte(rs.getString("orderby"));
			  i++;
			}
			rs.close();
	}		
 
  %>
<body>
        
    
	
             <%		
			 String PARA_SQL=" select ";
   		    for (int ii=0;ii<FiledCname.length;ii++){
            if (FiledCname[ii]==null)break;
			 String FieldName=FiledCname[ii];
			 String FieldValue=FiledEname[ii];
			 PARA_SQL+=FieldValue+","+FieldValue +" as "+FieldName+",";
			
			}
			PARA_SQL=PARA_SQL.substring(0,PARA_SQL.lastIndexOf(","));
		
      %>

       <script>
	   window.location="oneself_report.jsp?PARA_SQL=<%=PARA_SQL+" from RgsViewC" %>&orderby=<%=orderby %>";
	   </script>
       
       <%  }catch(Exception s){out.print("系统出现异常错误，错误原因："+s);}   %>
</body>       
</html>       
