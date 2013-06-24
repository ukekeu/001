<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*,common.*" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "预留登记" , 
                  "新增"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>保存预留</title>

<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="cBean" scope="page" class="ConnDatabase.SDatabase" />

</head>

<%
String Mess="系统已接受预留";
String secno=China.getParameter(request,"secno");
String loft=China.getParameter(request,"loft");
String build=China.getParameter(request,"build");
String rooms=China.getParameter(request,"rooms");
//String rooms1=rooms.substring(rooms.indexOf("/")+1);
//rooms=rooms.substring(0,rooms.indexOf("/"));
String person=China.getParameter(request,"person");
String checker=China.getParameter(request,"checker");
String yl=request.getParameter("yl");
String youxiao = request.getParameter( "youxiao" ) ;
String shixiao = request.getParameter( "shixiao" ) ;
 //*****客户资料
   String cusno="";
   String cusname=China.getParameter(request,"cusname");
   String Cus_Name=China.getParameter(request,"cusname1");
   String Phone=China.getParameter(request,"tel");
   String bbj=China.getParameter(request,"bbj");
   String sj=China.getParameter(request,"sj");
   String ID_Card=China.getParameter(request,"carid");
   String Address=China.getParameter(request,"Address");
   String Zip_Code=China.getParameter(request,"post");

String sql="";
String sql1="";
java.util.StringTokenizer to = new java.util.StringTokenizer( rooms , ",") ;

if ( yl==null ) yl="";
if (yl.equals("1"))
	Mess="已取消预留";


sql="UPDATE room set SaleState='"+yl+"' ";
sql+="WHERE seccode='"+secno+"' and loft='"+loft+"' and building='";
sql+=build+"' and room_code in ("+rooms+")";

out.print(yl);
out.close();
String sql2="";
if(!yl.equals("1") ) {

if (cusname.equals("")){//如果此客户没有在客户资料中登录，现增加此客户
		     //计算当前客户的编号
		     sql2="select max(code) +1 as cusno from customer where section='"+secno+"'";
	         ResultSet MaxCusNo=InsertBean.executeQuery(sql2);
             if (MaxCusNo.next()){
	           cusno=MaxCusNo.getString("cusno");
	          }
			  MaxCusNo.close();
			  
		
		  sql1="insert into customer(Section,SerialNo,Cus_Name,signatory,Phone, ";
		  sql1+="ID_Card, Address,Zip_Code,visit_date, seller,bbj,sj,state)";
		  sql1+=" values('"+secno+"','"+cusno+"','"+Cus_Name+"','"+Cus_Name+"','"+Phone+"','";
		  sql1+=ID_Card+"','"+Address+"','"+Zip_Code+"',convert(char(24),getdate(),111),'"+person+"','"+bbj+"','"+sj+"',2)";
		  }
		  
		  if (!cusname.equals("")){//以合同资料更新原客户资料
		   sql1="update customer set Cus_Name='"+Cus_Name+"',";
		   sql1+="signatory='"+Cus_Name+"',Phone='"+Phone+"',ID_Card='"+ID_Card+"',";
		   sql1+="Address='"+Address+"',Zip_Code='"+Zip_Code+"',bbj='"+bbj+"',sj='"+sj+"' where SerialNo='"+cusname+"'";
		  cusno=cusname;
		  }
}
try{ 
	InsertBean.executeUpdate(sql);
	if (!sql1.equals(""))
	InsertBean.executeUpdate(sql1);
}catch(Exception s){    
	out.print(s);
	out.close();
}

String sqtest = "" ;
try{
while( to.hasMoreTokens() ) {
	String temp = to.nextToken() ;
	
	if( yl.equals("1") ) {
		//删除预留
		sql1 = " delete from YLroom where RoomS=" + temp + " and section = '" + secno
			  + "' and loft= '" + loft + "' and building = '" + build + "' "  ;
	    InsertBean.executeUpdate(sql1);
	}else{
		//插入预留
		sql1="insert into YLroom(RoomS,person,section,loft,building,checker,youxiao,customer ) values(";
		sql1 += ""+temp+",'"+person+"','"+secno+"','"+loft+"','"+build+"','"+checker
		   + "' , '" + youxiao + "','"+cusno+"')";
		 
			InsertBean.executeUpdate(sql1);
		 
	}
	
}
}catch(Exception s){ out.print(s+sql1);
out.close();}


%>

<body>
<script>
	alert("<%=Mess %>");
		opener.window.document.frm.submit();
	window.close();
</script>
</body>
</html>
