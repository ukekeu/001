<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>折扣记录明细--审批</title>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 <jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
 
</head>
 

<body  >
 <%String orderno=getbyte2(request.getParameter("SecName")); 
 String discorderno=getbyte2(request.getParameter("orderno")); 
 if (!discorderno.equals("")){
       String SQL="UPDATE contract_disc SET STATE=1,check_date=getdate() where order_no='"+discorderno+"'";
       ViewBean.executeUpdate(SQL);
   %>
   <script>
   opener.window.location="../manager/myplan.jsp";
   window.close();
   </script>
   <%
 
 }
  double jzarea=0;
  String discSQL="SELECT b.cus_name,a.sectionname+a.loft+a.room_no room,convert(char(10),a.date,120) rgdate,a.seller,a.gxr,c.disc_bak,a.jzarea,a.rmbprice,a.unitprice FROM  order_contract a,customer b,contract_disc c  WHERE  c.disc_type<>'正常折扣'  and  c.order_no=a.section+a.loft+a.room_no and a.customer=b.serialno and a.section+a.loft+a.room_no='"+orderno+"'  ";
	    
		   ResultSet      rs=ViewBean.executeQuery(discSQL);
		   
 %>
<form method="POST" name="cus" action=""  >
  <input type=hidden name=orderno value="<%=orderno %>">
<p align=center><font size=3 class=FontColor><B>登记折扣记录</b></font></p> 
<%if (rs.next()){ %>
<table width="100%" border="0" cellspacing="1"   cellpadding="1" >
            
      <tr> 
        <td width="20%"  class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;客户名称</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
         &nbsp; <%=rs.getString("cus_name") %>
        </td>
     
	 	 
      
        <td  width="20%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;购买单位</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<%=rs.getString("room") %> 
        </td>
      </tr>
	   <tr> 
        <td width="20%"  class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;成交单价</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
         &nbsp; <%=rs.getString("unitprice") %>
        </td>
     
	 	 
      
        <td  width="20%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;成交总价</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<%=rs.getString("rmbprice") %> 
        </td>
      </tr>
	  <tr> 
        <td  width="20%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;购买日期</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<%=rs.getString("rgdate") %> 
        </td>
      
        <td  width="20%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;销售员</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<%=rs.getString("seller") %> 
        </td>
      </tr>
      
      <tr align="left" > 
	   <td  width="20%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;关系人</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<%=rs.getString("gxr") %> 
        </td>
        <td  width="20%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;备 注</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<%=rs.getString("disc_bak") %>
        </td>
      <%jzarea=rs.getDouble("jzarea"); %>
       
      </tr>
	  
    
  </table>
  <%}
  rs.close(); %>
		    <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	  <tr bgcolor="#c0c0c0" align="center"><td>折扣类型</td><td>日期</td><td>计算方法</td><td>优惠</td><td>折扣</td><td>计算对象</td><td>折前总价</td><td>折前单价</td></tr>
	 
	  <%
	     discSQL="SELECT * FROM  contract_disc  WHERE  order_no='"+orderno+"' and disc_type<>'正常折扣' order by code asc";
	    
		          rs=ViewBean.executeQuery(discSQL);
				 int aaa12=0;
			 
			  while (rs.next()){ 		aaa12++;	
			    String disc_type=rs.getString("disc_type");   
				String disc=rs.getString("disc");
	  %>
	   <tr id=A<%=aaa12 %> align="center"  onmouseover="mout(this) ;changeclass1(this,'clickbg','#ffffff');" title="折扣备注:<%=rs.getString("disc_bak") %>"><td><%if (rs.getInt("state")==0||rs.getInt("state")==2){out.print("额外");}else{out.print("正常折扣");} %></td><td><%=rs.getDate("disc_date").toString() %></td>
	   <td><%=disc_type%></td>
	   <td><%=rs.getString("youhui") %></td><td><%=disc %></td><td><%=rs.getString("discObj") %></td>
	   <td><%=rs.getString("discPrice") %></td><td><%=rs.getString("discUnit") %></td><td><%
	    String obj=rs.getString("discObj") ;
	
	   //jzarea %></td> 
	    <td><%if (rs.getInt("state")==1) {%> 已审核<%} %></td>
	   
		 </tr>
	   <%}rs.close(); %>
	  </table>
   <p  align="center"><input type=submit name=ok value="同意额外折扣/优惠"></p>
</form>     
       
       
       
</body>       
</html>       
