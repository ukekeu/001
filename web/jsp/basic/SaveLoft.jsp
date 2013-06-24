<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>

<title>请输入楼栋资料</title>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
</head>

<SCRIPT language=javascript>
     function Validate(aForm)
   {

	
		if (aForm.Building.value.length<1)
		{
	        alert("请输入栋号！");
	        aForm.Building.focus();
	        return false;
		}
		return (true);
   }   
   function toUpper(aa){
    var a=aa.value;
    aa.value=a.toUpperCase();
  }
   function setfocus()
   {
   		cus.Section.focus();
   }

</SCRIPT>
<%
  String Para=China.getParameter(request,"Para");

  String Loft=China.getParameter(request,"Loft");
  String SecNo=China.getParameter(request,"SecNo");
  String Name=China.getParameter(request,"Name");
  String Build=China.getParameter(request,"Build");
  String oper=China.getParameter(request,"oper");
  String Edit=China.getParameter(request,"Edit");
  String EditName=China.getParameter(request,"EditName");
  
  String SQL="";
  String Eof="false";
  	 
 if (Edit.equals("")) {
   if (Loft.equals("")&&(!oper.equals("delete"))){
     ResultSet rsLoft=null;
	 SQL="select * from LoftBuildCode where SecNo='"+SecNo+"' and Loft='"+Name+"'";

	 try{
	  rsLoft=ViewBean.executeQuery(SQL);
      if (rsLoft.next()){
       Eof="true";
      }
	 }catch(Exception e){}
     rsLoft.close();
     if (Eof.equals("false")){
      SQL="insert into LoftBuildCode(SecNo,Loft) values('"+SecNo+"','"+Name+"')";
  
	  try{
	    ViewBean1.executeUpdate(SQL);
		  setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "楼栋资料" , 
                  "增加楼栋("+SecNo+Name+")"
                ) ;
	    out.print("<script>");
		out.print("alert('系统接受你的操作!,你展开左边树结构');");
		out.print("</script>");
	  }catch(Exception e){}
     }
   }else if (Para.equals("Build")&&(!oper.equals("delete"))){
    ResultSet rsBuild=null;
	SQL="select * from LoftBuildCode where SecNo='"+SecNo+"' and Loft='"+Loft+"' and Build='"+Name+"'";
      

	 try{
	   rsBuild=ViewBean.executeQuery(SQL);
       if (rsBuild.next()){
         Eof="true";
       }
	 }catch(Exception e){}
     rsBuild.close();

     if (Eof.equals("false")){
	 SQL="SELECT * FROM LoftBuildCode where secno='"+SecNo+"' and Loft='"+Loft+"' and Build IS NULL";

	try{
	   rsBuild=ViewBean.executeQuery(SQL);
       if (rsBuild.next()){
         Eof="true";
		 SQL="update LoftBuildCode set Build='"+Name+"' where SecNo='"+SecNo+"' and Loft='"+Loft+"'";
		 ViewBean1.executeUpdate(SQL);
		   setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "楼栋资料" , 
                  "修改("+SecNo+Name+")"
                ) ;
		 out.print("<script>");
		 out.print("alert('系统接受你的操作!,你展开左边树结构');");
		 out.print("</script>");
      }
	}catch(Exception e){}
	rsBuild.close();
	}
	 
	 if (Eof.equals("false")){
	 // SQL="insert into LoftBuildCode(SecNo,Loft,Build) values('"+SecNo+"','"+Loft+"','"+Name+"')";
       SQL="update LoftBuildCode set Build='"+Name+"' where SecNo='"+SecNo+"' and Loft='"+Loft+"'";
   
	  try{
	    ViewBean.executeUpdate(SQL);
		out.print("<script>");
		out.print("alert('系统接受你的操作!,你展开左边树结构');");
		out.print("</script>");
	  }catch(Exception e){}
	 
	 }
  }  
  if (oper.equals("delete")){
    if (Para.equals("Loft")&&Build.equals(""))SQL="DELETE LoftBuildCode where SecNo='"+SecNo+"'";
	if (Para.equals("Build")&&Build.equals(""))SQL="DELETE LoftBuildCode where SecNo='"+SecNo+"' and Loft='"+Loft+"'";
	if (Para.equals("Room")&&!Build.equals(""))SQL="DELETE LoftBuildCode where SecNo='"+SecNo+"' and Loft='"+Loft+"' and Build='"+Build+"'";
 ;
    try{
	 String SQL1="select room_no from order_contract   where state<>3 and section='"+SecNo+"' and loft='"+Loft+"' ";
	  
	ResultSet rs= ViewBean1.executeQuery(SQL1);
	if (!rs.next()){
	    ViewBean.executeUpdate(SQL);
		SQL="DELETE LockRoom WHERE [Section]='"+SecNo+"' and loft='"+Loft+"'";
		
		 ViewBean.executeUpdate(SQL);
		   setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "楼栋资料" , 
                  "删除楼栋("+SecNo+Name+")"
                ) ;
		out.print("<script>");
		out.print("alert('系统已删除你选择的对象!,你展开左边树结构');");
		out.print("</script>");
		
	}else{
	 rs.close();
	 out.print("<script>");
		out.print("alert('不能删除你选择的对象!,因此栋有单元已出售');");
out.print("window.close()");
		out.print("</script>");
	
	}	
	  }catch(Exception e){out.print(e.getMessage());out.close();}
  }
 }else{
  if (Para.equals("Build")){
    SQL="update LoftBuildCode set Loft='"+Name+"' where SecNo='"+SecNo+"' and Loft='"+EditName+"'";
  }else if (Para.equals("Room")){
    SQL="update LoftBuildCode set Build='"+Name+"' where SecNo='"+SecNo+"' and Loft='"+Loft+"' and Build='"+EditName+"'";
  }

  try{
	  ViewBean.executeUpdate(SQL);
	  SQL="update roomno set region='"+Name+"' where SectionNo='"+SecNo+"' and region='"+EditName+"'";
	  ViewBean.executeUpdate(SQL);
	  SQL="update room set loft='"+Name+"' where seccode='"+SecNo+"' and loft='"+EditName+"'";
	  
	  ViewBean.executeUpdate(SQL);
	  SQL="update order_contract set loft='"+Name+"' where section='"+SecNo+"' and loft='"+EditName+"'";
	  ViewBean.executeUpdate(SQL);
	   SQL="update LockRoom set loft='"+Name+"' where Section='"+SecNo+"' and loft='"+EditName+"'";
	  ViewBean.executeUpdate(SQL);
	  out.print("<script>");
	  out.print("alert('系统已修改你选择的对象!,你展开左边树结构');");
	  out.print("</script>");
	  }catch(Exception e){out.print(e.getMessage());out.close();}
 
 } 
 %>
 <script>
 parent.TreeList.window.location.reload();

 window.location="AddLoft.jsp";
//opener.window.location.reload();
 </script>
<body>
    
       
</body>       
</html>       
