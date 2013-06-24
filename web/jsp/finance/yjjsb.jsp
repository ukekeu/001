 <%@ page contentType="text/html;charset=GBK" %><!--页显示中文编码-->
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>佣金结算表</title>
</head>
<script language="javascript" src="../public_js/public.js"></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 
<%@ include file="../public_js/getByteOut.jsp"%>
<%
String CusName="";
String Condi="";
String Condi1="";
String CusAge="";
String year="";
String year1="";
String month="";
String day="";
String CusType="";
String BuyType="";
String CusVisitDate="";
String strWhere="";
String section="";
String custype="";
String cusche="";
String FindCondition="";//传递参数变量
String orderbytype=China.getParameter(request,"orderbytype");
String orderby=China.getParameter(request,"orderby");
String gradetype=China.getParameter(request,"gradetype");
String Date1=China.getParameter(request,"Date1");
String Date2=China.getParameter(request,"Date2");
String Loft=China.getParameter(request,"Loft");
String SecNo1=getbyte(request.getParameter("SectionNo"));
String datetype=request.getParameter("datetype");
String payment1=China.getParameter(request,"payment");
String okjs=China.getParameter(request,"okjschecked");
if (okjs.equals(""))okjs="0";
 
String SQLWHERE="";
String sel=(String)request.getParameter("sel");
   if(sel==null) sel="1";	
%>
<body topmargin="0"  onload="setSelectMad(document.cus.SectionNo,'<%=SecNo1 %>');">

<form name=cus method="post"  >
   <table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=1;document.cus.action='../sale/seller.jsp';document.cus.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>业绩明细表</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.cus.sel.value=2;document.cus.action='../seller/salecountreopt4.jsp';document.cus.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>业绩统计图表</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.cus.sel.value=3;document.cus.action='../finance/yjjsb.jsp';document.cus.submit();"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>佣金结算</font></a>
	</td>
   </tr>

</table>
 <input type=hidden name=okjschecked value="<%=okjs%>">
 <input type=hidden name=sel value="<%=sel%>">
  <%@ include file="../public_js/CheckSection.jsp"%>
					  <%
      String sql="select SerialNo,Name from CRM_Project "+FindWhere;
					   ResultSet rs2=ViewBean.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="SectionNo"  onclick="" style="width=108;" onchange="document.cus.submit();">
					      <option  >请选择楼盘名称</option>
						  <%while (rs2.next()){
	                          no=rs2.getString("SerialNo");
	                          sec=getbyte(rs2.getString("Name"));
     	                      out.print("<option  value='"+no+"'>"+sec+"</option>");
	                         }
	                        rs2.close();
	                        
                              %> 
							</select>
							
 <p align=center class=FontColor><font size=3><b><%if (okjs.equals("0")) {%>待<%}else{ %>已<%} %>结算佣金统计表</b></font></p></div>
<table width=99%>
<tr height="3">
<td><input name="okjss" onclick="document.cus.okjschecked.value=0;document.cus.submit();" type="radio" <%if (okjs.equals("0")){out.print("checked");} %> value="0">待结算&nbsp;<input name="okjs" onclick="document.cus.okjschecked.value=1;document.cus.submit();" type="radio"  <%if (okjs.equals("1")){out.print("checked");} %> value="1">已结算</td>
<td align="right"><input type=button name="jsvalue"  onclick="checkyj();" value="<%if (okjs.equals("0")) {%>确认结算<%}else{ %>取消结算<%} %>"></td>
</tr></table>
<center>
<%
if (!SecNo1.equals("")) {
SQLWHERE=" a.code>0 ";
if (!payment1.equals(""))SQLWHERE+=" and a.payment1 like '%"+payment1+"%'";
if (!Loft.equals(""))SQLWHERE+=" and a.loft='"+Loft+"'";
 
 sql="select    b.cus_name, a.Code,b.serialno,b.cus_sex, ";
 sql+="b.Phone,b.sj,b.Address,b.Zip_Code ,b.sj,b.Address,";
 sql+="b.Zip_Code ,a.seller,a.floors,convert(char(10),";
 sql+="a.visadate,120) as   visadate,b.bbj,b.sj,convert(char(10),a.date,120) as Date,";
 sql+="a.jzarea,a.rmbprice,a.sectionname,a.section,";
 sql+="a.loft,a.room_no,a.yong_tu,b.Zip_Code, ";
  sql+="a.ContractNo,a.unitprice,a.payment1,convert(char(10),a.jldate,120) jldate,convert(char(10),a.cq_checkdate,120) jq_date from customer b,Order_Contract a ";
 sql+="where  "+SQLWHERE+" and a.customer=b.serialno and a.cq_check=1 and payment1 not like '%分期%' and a.yjffstate="+okjs+" and a.section ='"+SecNo1+"'";
 
  ResultSet rs=null;
	ResultSet rs1=null;
 
	//保存输入值的变量
    
	String yong_tu="";
    String name="";
    String sex="";
    String age="";
    String sale="";
    String jldate="";
    String tel="";
    String code="";
	String ContractNo="";
    String sell="";
	int i=0;
    String roomtype="";
    String area="";
    String tj="";
    String region="";
    String linkman="";
   String address="";
   String bbj="";
   String sj="";
   String post="";
   String attention="";
   String VisaDate="";
   String sectionName="";
   String ID_Card="";
   String loft="";
   String roomno="";
   String jzarea="0";
   String rmbprice="0";
   String unitprice="0";
   String Code="";
   String jq_date="";
    %>
<table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	<tr >
		<td   align="center">序号</td>
		<td  align="center">签约日期</td>
		<td  align="center">合同编号</td>
		<td  align="center">客户姓名</td>
		<td  align="center">房号</td>
		<td  align="center">建筑面积</td>
		<td  align="center">单价</td>
		<td  align="center">总价</td>
		<td  align="center">首到时间</td>
		<td  align="center">付款方式</td>
		<td  align="center">放款时间</td> 
		<td  align="center">销售员</td>
		<td  align="center">备注</td>
		<td  align="center">&nbsp;</td>
	</tr>
 
 <%	
    rs=ViewBean.executeQuery(sql );
	
   while (rs.next()){
 
     i=i+1;
	  
   //按FIELDS顺序一GET　VALUE
      code=getbyte(rs.getString("code"));
      name=getbyte(rs.getString("Cus_Name"));
     no=rs.getString("SerialNo").trim();
	
    
     sex=getbyte(rs.getString("Cus_Sex"));
     
     tel=getbyte(rs.getString("Phone"));
	 sj=getbyte(rs.getString("sj"));
     address=getbyte(rs.getString("address"));
	 Code=getbyte(rs.getString("code"));
    
	 sell=getbyte(rs.getString("seller"));
	 
 	jldate=getbyte(rs.getString("jlDate"));
	VisaDate=getbyte(rs.getString("VisaDate"));
	 if (!VisaDate.equals(""))VisaDate=VisaDate.substring(0,10);
	 sectionName=getbyte(rs.getString("sectionname"));
	 jzarea=getbyte(rs.getString("jzarea"));
	 rmbprice=getbyte(rs.getString("rmbprice"));
	 unitprice=getbyte(rs.getString("unitprice"));
	 ContractNo=getbyte(rs.getString("ContractNo"));
	 section =getbyte(rs.getString("section"));
	 payment1=getbyte(rs.getString("payment1"));
	 loft =getbyte(rs.getString("loft"));
	 roomno =getbyte(rs.getString("room_no"));
	 jq_date =getbyte(rs.getString("jq_date"));
	 String fk_date="";
	 String sf_date="";
	sql="select f.FactMonye money,factdate from FactAjCharges f";
	sql+=" where  contractno="+Code;
	
	
	rs1=ViewBean1.executeQuery(sql);//读取按按揭款
	if (rs1.next()){fk_date=rs1.getDate("factdate").toString();}
	rs1.close();
 
	
	
	
	
	sql="select  top 1 gather_date from factGatheringRecord f";
	sql+=" where f.Period in(1,2,3,4,8,12,13) ";
	sql+=" and contractno ="+Code+" order by gather_date "; 
	rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款时间
	
	if (rs1.next()){sf_date=rs1.getDate("gather_date").toString();}
	rs1.close();
 
  %>

   <tr id=TR<%=i %>    align="center"   > 
	<td  align="center"> <%=i %></td>
	
	   <td  align="center"><%=VisaDate %>&nbsp;</td>
		<td  align="left"><%=ContractNo %>&nbsp;</td>
	 
    <td  align="left"><%=name %>&nbsp;</td>
  <td  align="left"><%=loft+roomno %>&nbsp;</td>
	<td  align="right"><%=jzarea %>&nbsp;</td>
	<td   align="right"><%=unitprice %>&nbsp;</td>
	<td   align="right"><%=rmbprice %>&nbsp;</td>
	   <td  align="left"><%=sf_date %>&nbsp;</td>
   <td  align="left"><%=payment1 %>&nbsp;</td>
 
	      <td  align="center"><%=fk_date %>&nbsp;</td>
	 
 
	<td  align="center"><%=sell%>&nbsp;</td>
	<td  align="center">&nbsp;<%if (!jq_date.equals("")){out.print("核实付清："+jq_date);} %></td>
	<td  align="center"><input name="okyjchoose" type="checkbox" value=<%=code %>></td>
   </tr>
<%
  }
   
 
 
rs.close();
 
 sql="select    b.cus_name, a.Code,b.serialno,b.cus_sex, ";
 sql+="b.Phone,b.sj,b.Address,b.Zip_Code ,b.sj,b.Address,";
 sql+="b.Zip_Code ,a.seller,a.floors,convert(char(10),";
 sql+="a.visadate,120) as   visadate,b.bbj,b.sj,convert(char(10),a.date,120) as Date,";
 sql+="a.jzarea,a.rmbprice,a.sectionname,a.section,";
 sql+="a.loft,a.room_no,a.yong_tu,b.Zip_Code, ";
  sql+="a.ContractNo,a.unitprice,a.payment1,convert(char(10),a.jldate,120) jldate,convert(char(10),a.cq_checkdate,120) jq_date from customer b,Order_Contract a ";
 sql+="where  "+SQLWHERE+" and a.customer=b.serialno and a.cq_check=1 and payment1  like '%分期%' and a.yjffstate="+okjs+" and a.section ='"+SecNo1+"'";
 
 %> 
 
 <%	
    rs=ViewBean.executeQuery(sql );
	
   while (rs.next()){
 
     i=i+1;
	  
   //按FIELDS顺序一GET　VALUE
      code=getbyte(rs.getString("code"));
      name=getbyte(rs.getString("Cus_Name"));
     no=rs.getString("SerialNo").trim();
	
    
     sex=getbyte(rs.getString("Cus_Sex"));
     
     tel=getbyte(rs.getString("Phone"));
	 sj=getbyte(rs.getString("sj"));
     address=getbyte(rs.getString("address"));
	 Code=getbyte(rs.getString("code"));
    
	 sell=getbyte(rs.getString("seller"));
	 
 	jldate=getbyte(rs.getString("jlDate"));
	VisaDate=getbyte(rs.getString("VisaDate"));
	 if (!VisaDate.equals(""))VisaDate=VisaDate.substring(0,10);
	 sectionName=getbyte(rs.getString("sectionname"));
	 jzarea=getbyte(rs.getString("jzarea"));
	 rmbprice=getbyte(rs.getString("rmbprice"));
	 unitprice=getbyte(rs.getString("unitprice"));
	 ContractNo=getbyte(rs.getString("ContractNo"));
	 section =getbyte(rs.getString("section"));
	 payment1=getbyte(rs.getString("payment1"));
	 loft =getbyte(rs.getString("loft"));
	 roomno =getbyte(rs.getString("room_no"));
	 jq_date =getbyte(rs.getString("jq_date"));
	 String fk_date="";
	 String sf_date="";
	sql="select f.FactMonye money,factdate from FactAjCharges f";
	sql+=" where  contractno="+Code;
	
	
	rs1=ViewBean1.executeQuery(sql);//读取按按揭款
	if (rs1.next()){fk_date=rs1.getDate("factdate").toString();}
	rs1.close();
 
	
	
	
	
	sql="select  top 1 gather_date from factGatheringRecord f";
	sql+=" where f.Period in(1,2,3,4,8,12,13) ";
	sql+=" and contractno ="+Code+" order by gather_date "; 
	rs1=ViewBean1.executeQuery(sql);//读取实际收到首期款时间
	
	if (rs1.next()){sf_date=rs1.getDate("gather_date").toString();}
	rs1.close();
 
  %>

   <tr id=TR<%=i %>    align="center"   > 
	<td  align="center"> <%=i %></td>
	
	   <td  align="center"><%=VisaDate %>&nbsp;</td>
		<td  align="left"><%=ContractNo %>&nbsp;</td>
	 
    <td  align="left"><%=name %>&nbsp;</td>
  <td  align="left"><%=loft+roomno %>&nbsp;</td>
	<td  align="right"><%=jzarea %>&nbsp;</td>
	<td   align="right"><%=unitprice %>&nbsp;</td>
	<td   align="right"><%=rmbprice %>&nbsp;</td>
	   <td  align="left"><%=sf_date %>&nbsp;</td>
   <td  align="left"><%=payment1 %>&nbsp;</td>
 
	      <td  align="center"><%=fk_date %>&nbsp;</td>
	 
 
	<td  align="center"><%=sell%>&nbsp;</td>
	<td  align="center">&nbsp;<%if (!jq_date.equals("")){out.print("核实付清："+jq_date);} %></td>
	<td  align="center"><input name="okyjchoose" type="checkbox" value=<%=code %>></td>
   </tr>
<%
  }
   
 
 
rs.close();%>
</table>
<%} %>
	 </form>
<script>
 function checkyj(){
	 
	 
	 if (getseldocs2()==""){alert("请选择结算的单位");return false;}
	 
	 
	 
	 
	   <%if (okjs.equals("0")) {%>
	     if (confirm("确认结算佣金？"))
	   openwin1("yjCheck.jsp?code="+getseldocs2(),10,10,10,10);
	   <%}else{ %>
	     if (confirm("确认取消结算？"))
	    openwin1("cancelCheck.jsp?code="+getseldocs2(),10,10,10,10);
		<%} %>
	 
	 }
   	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
 
	
	 if (cus.okyjchoose.length){ 
     for (i=0;i<cus.okyjchoose.length;i++) {
       if ((cus.okyjchoose[i].type=="checkbox")&&(cus.okyjchoose[i].name=="okyjchoose")&&(cus.okyjchoose[i].checked))
		 { 
		    seldocs[x]=cus.okyjchoose[i].value ;
			x++;
   		 }
	  }	
	  }else  if (cus.okyjchoose.checked)
	  
	
		 { 
		    seldocs[0]=cus.okyjchoose.value ;
			 
   		 
	  }

   return seldocs ;
}

</script>
</body>
</html>
