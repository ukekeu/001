<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�������" , 
                  "ɾ��"
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
 
<title>�������</title>
</head>

<%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body oncontextmenu="return false" >
<script language="JavaScript" src='../public_js/public.js'></script>

 
<%
try{
//Delete �ͻ�����
String sql="";
  sql="delete customer";
  InsertBean.executeUpdate(sql);
//Delete�������
  sql="delete RoomNo";
  InsertBean.executeUpdate(sql);
//Delete ��������
  sql="delete Room";
  InsertBean.executeUpdate(sql);
  //Delete ����������
   sql="delete MapArea ";
   InsertBean.executeUpdate(sql);
    //Delete ��ͬ����
  sql="delete Order_Contract ";
    InsertBean.executeUpdate(sql);
   //Delete ¥������
  sql="delete section";
      InsertBean.executeUpdate(sql);
 //delete ��������
  sql="delete tb_chengyi";
  InsertBean.executeUpdate(sql);
   //DeleteӦ�տ�
  sql="delete GatheringRecord ";
  InsertBean.executeUpdate(sql);
    //Delete ʵ�տ�
  sql="delete FactGatheringRecord ";
 InsertBean.executeUpdate(sql);
   //Delete �ſ�
  sqlFactAjCharges="delete FactAjCharges  ";
 InsertBean.executeUpdate(sql);
    //Delete˰��
  sqlGatheringTaxRecord="delete GatheringTaxRecord ";
 InsertBean.executeUpdate(sql);
//ɾ�����ۼ�¼
sql="delete RoomPriceBackup ";
 InsertBean.executeUpdate(sql);
   
catch(Exception se){
	//Roll back
	InsertBean.rollback();
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage()+tb_chengyi_danwei);
	out.close(); 
}
%>
</body>
<script>
alert("�����ϵͳ����");
window.close();
</script>
</html>
