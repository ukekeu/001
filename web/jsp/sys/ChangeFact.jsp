<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>系统颜色设置</title>
</head>

<%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body oncontextmenu="return false" >
<form name=colorset method="post"  action="">

<%@ include file="../public_js/getByteOut.jsp"%>

 
 <%
 String SQL="";
 String StrColor=request.getParameter("color");
 if (StrColor!=null){
   SQL="update FactColor set active=0";
   aBean.executeUpdate(SQL);
   SQL="update FactColor set active=1 where id="+StrColor;
   aBean.executeUpdate(SQL);
   String sql="SELECT * FROM FactColor where Active=1";
   ResultSet rs2 =null;
   try{
    rs2=aBean.executeQuery(sql);
    if (rs2.next())
     { 
      session.setAttribute("FactColorC",rs2.getString("ClssFile"))  ;
      session.setAttribute("FactColorT1",rs2.getString("TOPPIC1"))  ;
      session.setAttribute("FactColorT2",rs2.getString("TOPPIC2"))  ;
      session.setAttribute("FactColorL",rs2.getString("LEFTPIC"))  ;
     } 
   rs2.close();
   }catch(Exception s){}
  %>
  <script>
  parent.contents.window.location.reload();
  parent.banner.window.location.reload();
  alert("系统已经改变颜色");
  </script>
  <%
 }
 
 
  SQL="select * from FactColor where active=1";
  String ActiveName="";
   ResultSet rs=null;
  try{
   rs=aBean.executeQuery(SQL);
   if (rs.next()){
     ActiveName=getbyte(rs.getString("name"));
   
   }
   rs.close();
    }catch(Exception s){out.println(s.getMessage());}
%>
系统当前颜色：<%=ActiveName %>
<p>
<select name=color onchange="change();">
<option></option>
<%
   SQL="select * from FactColor";
   ResultSet rs1=null;
  try{
   rs1=aBean.executeQuery(SQL);
   while (rs1.next()){
    out.println("<option value="+rs1.getString("id")+">"+getbyte(rs1.getString("name"))+"</option>");
   }
  }catch(Exception s){out.println(s.getMessage());}
  
  rs1.close(); %>
  </select>
  </form>
<script>
function change(){
  document.colorset.action="ChangeFact.jsp";
  document.colorset.submit();
}
</script>
</body>

</html>
