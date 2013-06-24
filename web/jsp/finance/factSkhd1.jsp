<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>收款核对</title>
</head> 
<script language="javascript" src="../public_js/basal.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>

<%
 
String SecNo=getbyte2(request.getParameter("SecNo"));
String Loft=getbyte2(request.getParameter("Loft"));
String Build=getbyte2(request.getParameter("Build"));
String Date1=China.getParameter(request, "Date1" ) ;
String Date2=China.getParameter(request,"Date2" ) ;
  String showall=getbyte(request.getParameter("showall"));
  String skType=getbyte(request.getParameter("skType"));
 if (!showall.equals("1")&&!Loft.equals(""))showall="0";
 else showall="1";
%>
 
<script language="JavaScript">
 	function checkyh(){
	 if (getseldocs2()==""){alert("请选择核实的项");return false;}
 
	   if (confirm("确认通过核实？"))
	   openwin("sk_check1.jsp?codes="+getseldocs2(),500,200,100,100);
	 
	 }
   	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].checked)&&frm.elements[i].name=='aa')
		 { 
		    seldocs[x]=frm.elements[i].value ;
			x++;
   		 }
	  }	

   return seldocs ;
}
</script>
<body topmargin="1"  onload="setSelectMad(document.frm.showall,'<%=showall%>');setSelectMad(document.frm.skType,'<%=skType%>');">
 <form method="POST" name="frm" action="factSkhd1.jsp">
  <%
 String sel=(String)request.getParameter("sel");
 if(sel==null) sel="1";	  
  
 %> <table width="370" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('RoomCodeShowC.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>收款审核</font></a>
	</td>
	  <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=2;findSub1(document.frm.skType.value);"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>批量核对</font></a>
	</td>
 	 
	  <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('RoomCodeShowTC.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>一次退房款</font></a>
	</td> 
	  <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=5;findSub('tf_list.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>多次退房款</font></a>
	</td> 
   </tr>
<input type=hidden name=sel value="<%=sel%>">
 </table>
 <script>
   var taxcodes="";
   
    function choosetax(){  
	 var dd="";  
	 taxcodes="";
	  if (document.frm.aa.length){
	     for (var a=0;a<document.frm.aa.length;a++){
		 
		 if (document.frm.aa[a].checked){
		  if (taxcodes=="")taxcodes=document.frm.taxcode[a].value;
		  else taxcodes+=","+document.frm.taxcode[a].value;
		  }
		}
 
	   }else  if (document.frm.aa.checked) taxcodes=document.frm.taxcode.value;
	  
	   return taxcodes;
	 }
	function findSub(para){
	   document.frm.action=para+"?SecNo=<%=SecNo %>&Loft=<%=Loft %>&Build=<%=Build %>";
	 
	   document.frm.submit();
	}
	function findSub2(){
	   document.frm.action="factSkhd1.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&Build=<%=Build %>";
	 
	   document.frm.submit();
	}
	function findSub1(para){
	   if (para==0)
	   document.frm.action="factSkhd.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&Build=<%=Build %>";
	  else
	  document.frm.action="factSkhd1.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&Build=<%=Build %>";
	   document.frm.submit();
	}
	 function chooseCheckbox(para) {//indexstring
     var x=0;
	// var seldocs = new Array();
	var aa="";
	if (frm.elements.length){
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].name=="aa"))
		 {
       		frm.elements[i].checked=para;
			
   		 }
	  }	
	  }
 
}
	 function yingshi( contractno , cusno ) {
    openwin("yingshi.jsp?contractno=" + contractno + "&cusno=" + cusno ,690,450,50,50);
  } 
 </script>
 <br>
  <div id=titl align=center><b><font size="3" color="#000080">
  实收款待核实明细表
 
 </font></b></div>
  <table border="0" width="110%">
    <tr bgcolor="#EAEAEA">

    <td>
       收款日期:从<input type=text name=Date1 size=10 readonly ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">到<input type=text name=Date2 size=10 readonly  ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date2);return false;">
        <input type=button name=find value="查询" onclick="findSub('factSkhd.jsp');"><select name=showall onchange="findSub('factSkhd.jsp');"><option value=0>当前楼栋收款记录</option><option value=1>所有楼栋收款记录</option></select>   
		&nbsp;	&nbsp;	&nbsp;	&nbsp; <select name=skType onchange="findSub1(this.value);"><option value=0>房款</option><option value=1>配套费/税费</option></select>  <input type=button name=check value="核 实" onclick="checkyh();">   
		<input type=hidden name=Input value="">
      </td>

   

  </tr>
  
</table>


    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    

    <tr class=listtitle>
  <td  > 
        <div align="center"><font color="#FFFFFF">序号</font></div>
      </td>
      <td  >
        <div align="center"><font color="#FFFFFF">房号</font></div>
      </td>	

      <td  > 
        <div align="center"><font color="#FFFFFF">客户姓名</font></div>
      </td>
 

      <td  > 
        <div align="center"><font color="#FFFFFF">付款名称</font></div>
      </td>

      <td  > 
        <div align="center"><font color="#FFFFFF">认购日期</font></div>
      </td>

      <td  > 
        <div align="center"><font color="#FFFFFF">收款日期</font></div>
      </td>
       <td  > 
        <div align="center"><font color="#FFFFFF">代收款项</font></div>
      </td>
	   <td  > 
        <div align="center"><font color="#FFFFFF">代收款</font></div>
      </td>
      <td  > 
        <div align="center"><font color="#FFFFFF"> <input type=checkbox name=sh onclick="chooseCheckbox(this.checked);"></font></div>
      </td>
    </tr>
 <%

 
String sql="select o.code,o.customer,c.cus_name,o.loft+o.room_no room,o.rmbprice,";
sql+="o.payment1,o.date,o.visadate,f.date Gather_Date,f.taxname,f.money,f.code taxcode,f.checkstate ";
sql+="from order_contract o,customer c,FactGatheringTaxRecord f where";

if (showall.equals("0")){
sql+=" o.customer=c.serialno and o.code=f.contractno and o.state<>3  ";

sql+=" and o.section='"+SecNo+"' ";
}else{
sql+=" o.customer=c.serialno and o.code=f.contractno and o.state<>3  ";
sql+=" and o.section='"+SecNo+"' ";
}
if (!Loft.equals(""))
sql+=" and  o.loft='"+Loft+"'";
if (!Date1.equals("")&&!Date2.equals(""))
sql+=" and convert(char(10),f.date,120)>='"+Date1+"' and convert(char(10),f.date,120)<='"+Date2+"'";
 sql+=" and f.checkstate=0 ";
sql+=" order by o.loft+o.room_no";
String aaa="",customer="";
 
    ResultSet rs=ViewBean.executeQuery(sql);
   int i=1;
   String code="";
   while (rs.next()){
   code=rs.getString("code");
   customer=rs.getString("customer");
  
 %>
   <tr   id=TR<%=i %> class=listcontent Onclick="changeclass1(this,'clickbg','listcontent');"  align="center" onmouseover="mout(this);"  ondblclick="yingshi('<%= code%>','<%= customer %>');">
   <td><%=i %></td>     <td><%=rs.getString("cus_name") %></td> 
   <td><%=rs.getString("room") %></td>
   <td><%=rs.getString("payment1") %></td> 
   <td><%=rs.getDate("date").toString() %></td> 
   
   <%   String Gather_Date="";
      Gather_Date =getbyte(rs.getString("Gather_Date"));
      if (!Gather_Date.equals(""))Gather_Date=Gather_Date.substring(0,10);
      double factmoney=0;

    ResultSet rs1=null;
	String factgcode="0";
    // if (!aaa.equals(code)){
    String SQL="";
factmoney+=rs.getDouble("money");
int checkstate=rs.getInt("checkstate");
     	 factgcode=rs.getString("taxcode");
 
  
 //  }
    %>
   
   <td><%=Gather_Date
    %></td> 
    <td><%=rs.getString("taxname") %></td> 
   <td><%=FormatD.getFloat2(factmoney,2) %></td> 
    
   <td>
 
   <%if (checkstate==0) {%>
   <input type=checkbox name=aa value=<%=factgcode %>  >
   <%}else{ %><font color=red>√</font><%}%> 
   </td> 
   
   
   </tr>
   <%i++;}rs.close(); %>
 
	
   
  </table>
</form>
  
 
</body>
</form>
</html>