<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>折扣记录明细</title>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT12");
Cortrol+=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT021");

String code=getbyte2(request.getParameter("code"));
String deletecode=getbyte2(request.getParameter("deletecode"));
if (!deletecode.equals("")){
  ViewBean.executeUpdate("delete contract_disc where code="+deletecode);
   String SQL="SELECT * FROM  contract_disc  WHERE order_no='"+code+"' and disc_type<>'正常折扣' and state=1 order by code asc";
	ResultSet      rs1=ViewBean.executeQuery(SQL);
	 out.print(SQL);
	 %>
	  <script>
	   opener.charges();
        opener.yhview.innerHTML="";
		</script>
	 <%
	 String yy="";
	  while (rs1.next()){ 	
	    String disctype=rs1.getString("disc_type");
		
		String discobj=rs1.getString("discobj");
		String Disc=rs1.getString("Disc");
		if (Disc.equals(""))Disc="0";
		String youhui=rs1.getString("youhui");
	  	   if (disctype.equals("额外折扣"))yy+=" 按"+discobj+Disc+"折";
	     else yy+=" 按"+discobj+"优惠"+youhui+"元";
	  %>
	  <script>
	    var aaa="<%=Disc %>"; 
	  var dic_arr=aaa.split("*");
	     var disn=1;  
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
			// alert(isNaN(dic_arr[dd]));
			// if (isNaN(dic_arr[dd])){alert("折扣数据误");return false;}
			// if (parseFloat(dic_arr[dd])<=0){alert("折扣数据误");document.cus.disc.focus();return false;}
	   	   }
		 
       opener.discCount('<%=disctype %>',eval(aaa)/disn*100,'<%=discobj %>');
    
   </script>
	  <%
	  }
	 rs1.close();
	 %>
	 <script>
	   opener.document.cus.modijh.checked=true;
	   opener.document.cus.moditax.checked=true;
	   opener.yhview.innerHTML ="优惠:"+ " <%=yy %>";
     window.close();
		</script>
	 <%
   
}
String discPrice=getbyte2(request.getParameter("discPrice"));
String discUnit=getbyte2(request.getParameter("discUnit"));
String discold=getbyte2(request.getParameter("discold"));
if (discPrice.equals(""))discPrice="0";
String checkstate=getbyte2(request.getParameter("checkstate"));
if (checkstate.equals(""))checkstate="0";
String disctype=getbyte2(request.getParameter("disctype")); 
String discobj=getbyte2(request.getParameter("discobj")); 
String disc=getbyte2(request.getParameter("disc"));
String yh="0";
String countDisc=disc;

if (!disctype.equals("额外折扣")){yh=disc;disc="";}
String yy="";
String gxr=getbyte2(request.getParameter("gxr")); 
String bak=getbyte2(request.getParameter("bak"));
String disc_date=getbyte2(request.getParameter("disc_date")); 
String checker=getbyte2(request.getParameter("checker")); 
 String person=getbyte2(request.getParameter("person")); 
 if (!disctype.equals("")){
   if (disctype.equals("额外折扣"))yy+=" 按"+discobj+disc+"折";
	else yy+=" 按"+discobj+"优惠"+yh+"元";
    String SQL="Insert into contract_disc(order_no,discobj,discPrice,discUnit,disc_type,disc,youhui,disc_date,checker,disc_bak,gxr,person,state";
	if (checkstate.equals("1"))
	SQL+=",check_date";
	SQL+=") values(";
     SQL+="'"+code+"','"+discobj+"',"+discPrice+","+discUnit+",'"+disctype+"','"+disc+"',"+yh+",'"+disc_date+"','"+checker+"','"+bak+"','"+gxr+"','"+person+"',"+checkstate;
	 if (checkstate.equals("1"))
	 SQL+=",'"+disc_date+"'";
	SQL+=")";
	// ViewBean.executeUpdate(SQL);
   %>
   <script>
   opener.discCount('<%=disctype %>',<%=countDisc %>,'<%=discobj %>');
   //opener.SaveContract();
   
   opener.document.cus.discSQL.value=opener.document.cus.discSQL.value+"<%=SQL %>";
   var yh=opener.yhview.innerHTML;
   if (yh=="优惠")yh="优惠:";
   else yh+=" ";
      opener.yhview.innerHTML =yh+ " <%=yy %>";
	   opener.ykj_count();
    window.close();
   </script>
   <%
 
 }
%>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
 

<SCRIPT language=javascript>
 
  function Validate(aForm)
   {
     // check(document.cus.disc);
      if (  document.cus.disc_date.value==""){alert("审核日期不能为空");return false;}
	  if (  document.cus.gxr.value==""){alert("关系人不能为空");document.cus.gxr.focus();return false;}
	 
	  if (  document.cus.checker.value==""){alert("审核人不能为空");document.cus.checker.focus();return false;}
	  if (  document.cus.bak.value==""){alert("备注不能为空");document.cus.bak.focus();return false;}
	  if (parseFloat(document.cus.disc.value)<=0) {alert("请录入优惠金额或折扣");document.cus.disc.focus();return false;}
        var dic_arr=document.cus.disc.value.split("*");
	  document.cus.discold.value=document.cus.disc.value;
	
	   var disn=1;
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
			 if (isNaN(dic_arr[dd])){alert("折扣数据误");document.cus.disc.focus();return false;}
			 if (parseFloat(dic_arr[dd])<=0){alert("折扣数据误");document.cus.disc.focus();return false;}
	   	   }
	  if (eval(document.cus.disc.value)/disn*100>=100&&(document.cus.disctype.value=="额外折扣")) {alert("请录入正确折扣，折扣数不能大于100");document.cus.disc.focus();return false;}
       if (eval(document.cus.disc.value)/disn*100<90&&(document.cus.disctype.value=="额外折扣")) {if (!confirm("你的额外折扣为："+document.cus.disc.value+"可能有误，请确认"))return false;}
    document.cus.disc.value=eval(document.cus.disc.value)/disn*100;
	 
	   return true;
   }
  
</SCRIPT> 

<body onload="cus.disc.focus();" oncontextmenu="return false"  >
 
<form method="POST" name="cus" action=""  >
 <input type=hidden name=code value="<%=code %>">
 <input type=hidden name=discPrice value="<%=discPrice %>">
  <input type=hidden name=discUnit value="<%=discUnit %>">
    <input type=hidden name=discold value="0">
<p align=center><font size=3 class=FontColor><B>登记折扣记录</b></font></p>
<table width="100%" border="0" cellspacing="1"   cellpadding="1" >
            
      <tr> 
        <td width="30%"  class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;计算方法</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
         &nbsp;<select name="disctype"><option value="额外折扣">额外折扣</option><option value="额外优惠">额外优惠</option></select>
        </td>
     
	 	 
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;折扣/优惠对象</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<select name="discobj"><option value="总价">总价</option><option value="建筑单价">建筑单价</option></select>
        </td>
      </tr>
	  <tr> 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;折扣/优惠数</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=disc size="15" value=0  onkeydown="key(document.cus.disc_date)"  > 
        </td>
      
        <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;日期</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<input type=text name=disc_date size="12"  onkeydown="key(document.cus.gxr);"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(disc_date);return false;">
        </td>
      </tr>
      
      <tr align="left" > 
	   <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;关系人</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<input type=text  name=gxr size="15"  onkeydown="key(document.cus.checker);" value="公司" > 
        </td>

        <td  width="30%" class=roomright align="left"  colspan="2"  height="14">  &nbsp;<input type=checkbox name=checkstate value=1 checked>已审核通过&nbsp;&nbsp;&nbsp;审核人
          &nbsp;<select size="1" name="checker" onkeydown="key(document.cus.person);"  style="width:117" >
   <option value=""></option>
<%String sell="select  serialno,name from CortrolMan where job like '%经理%'";
  ResultSet rs2=ViewBean.executeQuery(sell);
  while (rs2.next()){
	   String Name=getbyte(rs2.getString("name"));
       out.print("<option value='"+getbyte(rs2.getString("serialno"))+"'>"+Name+"</option>") ;
	}
  rs2.close();
  %>
	  
</select>
        </td>
     
       
      </tr>
	     &nbsp;<input type="hidden" name="person" size="15" value="<%= (String )session.getAttribute( "loginname" )  %>" onkeydown="key(document.cus.bak)" > 
    
       <tr align="left" > 
       
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;备 注</td>
        <td  width="30%" class=roomright align="left"   height="14" colspan="3">
          &nbsp;<input type="text" name="bak" size="60" value="公司规定" onkeydown="key(document.cus.Apportion)" > 
        </td>
      </tr>
  </table>
     <p align="center">
			<input type="Button" name="saveRoom" value="提 交" onclick="loca();">
		 
           &nbsp;&nbsp;
		   <input type="Button" name="saveRoom1" value="退 出" onclick="window.close();"> &nbsp;&nbsp;
		  
          </P>
		    <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	  <tr bgcolor="#c0c0c0" align="center"><td>折扣方法</td><td>日期</td> <td>优惠</td><td>折扣</td><td>计算对象</td><td>折前总价</td><td>折前单价</td><td>关系人</td><td>审核人</td><td>操作</td></tr>
	 
	  <%
	   String discSQL="SELECT * FROM  contract_disc  WHERE  bt=0 and order_no='"+code+"'  order by code asc";
	      
		   ResultSet      rs=ViewBean.executeQuery(discSQL);
				 int aaa12=0;
			 
			  while (rs.next()){ 		aaa12++;	   String disc_type=rs.getString("disc_type") ;   
	  %>
	   <tr id=A<%=aaa12 %> align="center"  onmouseover="mout(this) ;changeclass1(this,'clickbg','#ffffff');" title="折扣备注:<%=rs.getString("disc_bak") %>"><td><%=rs.getString("disc_type")  %></td><td><%=rs.getDate("disc_date").toString() %></td>
	   
	   <td><%=rs.getString("youhui") %></td><td><%=rs.getString("disc") %>&nbsp;</td><td><%=rs.getString("discObj") %></td>
	   <td><%=rs.getString("discPrice") %></td><td><%=rs.getString("discUnit") %></td><td><%=rs.getString("gxr") %></td><td><%=rs.getString("checker") %></td>
	   <td><%if (rs.getInt("state")==0) {if (!disc_type.equals("正常折扣"))%><a href="modidisc.jsp?modi=<%=rs.getInt("code") %>">修改</a>&nbsp;<a href="#" onclick="if (confirm('确认删除吗？'))window.location='disc.jsp?discPrice=<%=discPrice %>&code=<%=code %>&deletecode=<%=rs.getInt("code") %>&discUnit=<%=discUnit %>';">删除</a><%}else{ %>已审核<%} %>
		<%if (Cortrol.indexOf("C")>=0&&!disc_type.equals("正常折扣")) {%> <a href="modidisc.jsp?modi=<%=rs.getInt("code") %>">修改</a>&nbsp;<a href="#" onclick="if (confirm('确认删除吗？'))window.location='disc.jsp?discPrice=<%=discPrice %>&code=<%=code %>&deletecode=<%=rs.getInt("code") %>&discUnit=<%=discUnit %>';">删除</a><%} %>
		
		</td>
		 </tr>
	   <%}rs.close(); %>
	  </table>
   <script>
		function loca(){
		  
		    if (confirm("确认当前输入的数据吗？")){
		  if (Validate(document.cus)){
		    document.cus.action="disc.jsp";
		    document.cus.submit();
          }		
		  }
		}
		</script>
</form>     
       
       
       
</body>       
</html>       
