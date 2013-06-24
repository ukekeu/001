<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "清空数据" , 
                  "删除"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>清空数据</title>
</head>

<%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body oncontextmenu="return false" >
<script language="JavaScript" src='../public_js/public.js'></script>

 
<%
try{
//Delete 客户资料
String sql="";
  sql="delete customer";
  InsertBean.executeUpdate(sql);
//Delete房间代码
  sql="delete RoomNo";
  InsertBean.executeUpdate(sql);
//Delete 房间资料
  sql="delete Room";
  InsertBean.executeUpdate(sql);
  //Delete 面积测绘资料
   sql="delete MapArea ";
   InsertBean.executeUpdate(sql);
    //Delete 合同资料
  sql="delete Order_Contract ";
    InsertBean.executeUpdate(sql);
   //Delete 楼盘资料
  sql="delete section";
      InsertBean.executeUpdate(sql);
 //delete 诚意资料
  sql="delete tb_chengyi";
  InsertBean.executeUpdate(sql);
   //Delete应收款
  sql="delete GatheringRecord ";
  InsertBean.executeUpdate(sql);
    //Delete 实收款
  sql="delete FactGatheringRecord ";
 InsertBean.executeUpdate(sql);
   //Delete 放款
  sqlFactAjCharges="delete FactAjCharges  ";
 InsertBean.executeUpdate(sql);
    //Delete税费
  sqlGatheringTaxRecord="delete GatheringTaxRecord ";
 InsertBean.executeUpdate(sql);
//删除调价记录
sql="delete RoomPriceBackup ";
 InsertBean.executeUpdate(sql);
   
catch(Exception se){
	//Roll back
	InsertBean.rollback();
	out.print("系统出错，出错如下：");
	out.print(se.getMessage()+tb_chengyi_danwei);
	out.close(); 
}
%>
</body>
<script>
alert("已清空系统数据");
window.close();
</script>
</html>
