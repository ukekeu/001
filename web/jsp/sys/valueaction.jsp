<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page"  class="ConnDatabase.SDatabase"/>
<jsp:useBean id="UpdateBean" scope="page"  class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<script language="JavaScript" src='../public_js/public.js'></script>
<%
String Operation=request.getParameter("Operation");
String ID=request.getParameter("ID");
String uptown=request.getParameter("section");
String RentYear = request.getParameter("RentYear");
String RentMonth = request.getParameter("RentMonth");
String areavalue = request.getParameter("areavalue");
String salercount = request.getParameter("salercount");
String perarea = request.getParameter("perarea");
String seller= getbyte1(request.getParameter("seller"));
String num= getbyte1(request.getParameter("num"));
String sumCount= getbyte1(request.getParameter("sumCount"));
String planCount= getbyte1(request.getParameter("planCount"));
String plansumprice= getbyte1(request.getParameter("plansumprice"));
String type=getbyte1(request.getParameter("type"));
String sql="";
if(Operation.equals("Insert")){
     sql="select id from SalerValue where type="+type+" and uptown='"+uptown+"' and RentYear="+RentYear+" and RentMonth="+RentMonth+" and seller='"+seller+"'";
	 
	 ResultSet rs=ViewBean.executeQuery(sql);
	 if(rs.next()){
	   %>
	 <script>
	   alert("该指标已经录入");
	   window.close();
	 </script>
	   <%
	 }else{
     sql="insert into SalerValue (uptown,RentYear,RentMonth,areavalue,salercount,perarea,seller,sale_money,sale_num,type)";
     sql=sql+" values ('"+uptown+"',"+RentYear+","+RentMonth+","+areavalue+","+sumCount+","+perarea+",'"+seller+"',"+plansumprice+","+planCount+","+type+")";
 
   setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "业绩指标" , 
                  "增加"
                ) ;
 
    try{
           UpdateBean.executeUpdate(sql);
        %> 
                <script language=javascript>
                  alert("提交成功");
				  
                  
				  setSelectMad(opener.document.f1.section,"<%=uptown %>");
				 opener.document.forms[0].submit();
                  window.close();
                </script>
    <%
    }catch(Exception se){
      out.print("系统出错，原因如下：<br>");
      out.print(se.getMessage());
          out.print(sql);
      out.close();
  }
  } 
}

if(Operation.equals("Delete")){
        sql="delete SalerValue where ID="+ID;
        try{
           UpdateBean.executeUpdate(sql);
        %> 
                <script language=javascript>
                  alert("提交成功");
                   opener.document.forms[0].submit();
                  window.close();
                </script>
    <%
	 setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "业绩指标" , 
                  "删除"
                ) ;
    }catch(Exception se){
      out.print("系统出错，原因如下：<br>");
      out.print(se.getMessage());
      out.close();
   }
}

if(Operation.equals("Modify")){
    sql="update SalerValue set perarea="+perarea+"";
	sql=sql+",sale_money="+plansumprice+",sale_num="+planCount+" where ID="+ID;
//out.print(sql);
        try{
           UpdateBean.executeUpdate(sql);
        %> 
                <script language=javascript>
                  alert("提交成功");
                 setSelectMad(opener.document.f1.section,"<%=uptown %>");
				 opener.document.forms[0].submit();
                  window.close();
                </script>
    <%
	setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "业绩指标" , 
                  "修改"
                ) ;
    }catch(Exception se){
      out.print("系统出错，原因如下：<br>");
      out.print(se.getMessage());
          out.print(sql);
      out.close();
   }
}

 %>
 <html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>保存业绩指标</title>
</head>
<body>
</body>
</html>