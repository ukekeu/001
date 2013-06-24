<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>退订/退房处理</title>
<%@ page import="java.sql.*,common.*" %>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase" />

</head>
<%/*
 此文件功能：
 1.记录已退房/挞订房间资料
 2.记录从退房或挞订客户的没收的money
 3.把退的房或挞订的房的状态改为未售
 3.删除认购或合同资料
*/ %>
<%@ include file="../public_js/logrecord.jsp" %>
 <%
 
  String code=China.getParameter(request,"Code");
  String rgno=China.getParameter(request,"rgno");
  String sumprice=China.getParameter(request,"sumprice");
  String jzarea=China.getParameter(request,"jzarea");
  String money=China.getParameter(request,"money");
  String cusno=China.getParameter(request,"cusno");

  String para=China.getParameter(request,"para");
  String secname=China.getParameter(request,"secname");
  String secno=China.getParameter(request,"secno");
  String loft=China.getParameter(request,"loft");
  String build=China.getParameter(request,"build");
  String room=China.getParameter(request,"roomno");
  String canceldate=China.getParameter(request,"canceldate");
  String comm=China.getParameter(request,"comm");
  String person=China.getParameter(request,"person");
  String checker=China.getParameter(request,"checker");
  String context=China.getParameter(request,"context");
  String dis=China.getParameter(request,"dis");
  String sql="";
  
  String sql1="";
  String sql2="";
  String sql3="";
  String sql4="";
  String sql5="";
  String sql6="";
  String sql8="";
  String sql9="";
  String sql10="";
    if (para.equals("tf")){
  //退房处理
   //挞订处理
    sql1="insert into TFRecord(secno,customer,section,loft,building,Room,jzarea,sumprice,tf_date,";
    sql1+="person,checker,context,subscription) values('"+secno+"','"+cusno+"','"+secname+"','"+loft+"','";
    sql1+=build+"','"+room+"',"+jzarea+","+sumprice+",'"+canceldate+"','"+person+"','";
    sql1+=checker+"','"+context+"',"+money+")";
    sql4="update Order_Contract set state='3',td_date='"+canceldate+"'  where code="+code;
    sql8="update room set SaleState=1,ssstate=0 ";
	  if (dis.equals("1"))
	  sql8+=" ,dis=1,tddate='"+canceldate+"' ";
	   sql8+=" where seccode+loft+room_code+ltrim(floor) =(select section+loft+room_no+ltrim(floors) from Order_Contract where code="+code+")";
  
    sql6="update ContractNo set state='3'  where ContractNo =(select ContractNo from Order_Contract where code="+code+")";
    sql9="update order_contract_log set state1='1'  where order_contract ="+code;
    sql10="insert into MessageHF(order_contract,type) values("+code+",0)";
	setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "退订" , 
                  "增加"+secname+loft+build+room
                ) ;
     
  }

  try{
 
	 InsertBean.executeUpdate(sql1);
 	 InsertBean.executeUpdate(sql8);
 	 InsertBean.executeUpdate(sql4); 
	 InsertBean.executeUpdate(sql6);
     InsertBean.executeUpdate(sql9);
	 InsertBean.executeUpdate(sql10);
	 sql6="update contract_disc set bt=1  where order_no =(select section+loft+room_no from Order_Contract where code="+code+")";
     InsertBean.executeUpdate(sql6);
	 
  }catch(Exception s)	{out.print(s.getMessage());out.close();}
 %>

 <body>
 <script>
      alert("系统已接受退定");
         opener.window.document.frm.submit();
               window.close();
</script>
</body>

</html>
