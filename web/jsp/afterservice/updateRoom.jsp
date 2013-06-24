
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import = "java.sql.*,common.*,java.util.*" %>
<jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id="connBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>正在更改数据...</title>
</head>

<body>
<%
 String section=request.getParameter("section");
 String loft=request.getParameter("loft");
 String state=request.getParameter("state");
 String ok=request.getParameter("ok");
 String sql="";
 String sqls="select   mapArea,room,MapUserArea,saleprice from mapArea m where m.state="+state+" and  m.section = '" + section + "' and m.loft = '" + loft +"'";

		ResultSet aRs = ViewBean.executeQuery(sqls) ;
		while (aRs.next()){
			float app=aRs.getFloat("mapArea")-aRs.getFloat("MapUserArea");
 		  sql="update room set area="+aRs.getFloat("mapArea")+",usedarea="+aRs.getFloat("MapUserArea")+",ApportionArea="+app+",Sumprice=Unitprice*"+aRs.getFloat("mapArea")+" where seccode='" + section + "' and loft = '" + loft +"' and room_code='"+aRs.getString("room")+"'";
		  connBean.executeUpdate(sql) ;
          sql="update order_contract set mapp_sumprice=salerprice*rate  where section='" + section + "' and loft = '" + loft +"' and room_no='"+aRs.getString("room")+"' and state<>3";
		  connBean.executeUpdate(sql) ; //保留签定的总金额
		  sql="update order_contract set jzarea="+aRs.getFloat("mapArea")+",area="+aRs.getFloat("MapUserArea")+",salerprice=unitprice*"+aRs.getFloat("mapArea")+"  where section='" + section + "' and loft = '" + loft +"' and room_no='"+aRs.getString("room")+"' and state<>3";
		  connBean.executeUpdate(sql) ;//重新计算测绘后的核实总金额
		  	
		}

%>
<script>
  alert("成功操作");
  window.close();
</script>
</body>
</html>
