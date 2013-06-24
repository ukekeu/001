 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>合同违约处理条款11</title>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
  <%@ include file="../public_js/qx_checke.jsp"%>

<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

</head>
<script>
function printReport(urlValue){
  openwin(urlValue,700,300,50,100);

}</script>
<body topmargin="1">
<%  String SecName=China.getParameter(request,"SecName");
    String SecNo=China.getParameter(request,"SecNo");
	String Loft= China.getParameter(request, "Loft") ;
	String Build=China.getParameter(request,"Build"); 
    String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";
%>
<form name=frm method="post" action="contract_wycl.jsp">
<input type=hidden name=SecNo value="<%=SecNo%>">
<input type=hidden name=SecName value="<%=SecName%>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=Build value="<%=Build %>">
<input type=hidden name=cusname value="">
<input type=hidden name=secname value="">

<table width="650" border="0" cellspacing="0" cellpadding="0" class="L2">
     
<tr>
    <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('jy_list.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>交易一览</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('ContractNoM.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同号管理</font></a>
	</td>
	
	  <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=5;findSub('contract_check.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同审核</font></a>
	</td>
	 <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('ContractJz.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>备案管理</font></a>
	</td>
	<!-- <td class="<%if(sel.equals("9")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=9;findSub('contract_yj.jsp');"><font color='<%if(sel.equals("9")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>移交管理</font></a>
	</td>
	-->
	<td class="<%if(sel.equals("6")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=6;findSub('rh_view.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>入户管理</font></a>
	</td>
	
  <!--
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('contract_view.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已审核合同</font></a>
	</td>
	-->
	
	
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('paymoneyProcess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>付款进度</font></a>
	</td>
	 
	 
	<td class="<%if(sel.equals("8")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=8;findSub('contract_wycl.jsp');"><font color='<%if(sel.equals("8")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>违约处理</font></a>
	</td>
   </tr>
<input type=hidden name=sel value="<%=sel%>">
 </table>
<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
<%
String price=getbyte1(request.getParameter("price"));
 if (price.equals(""))price="600";
  String chooseyt= getbyte1(request.getParameter("yongt"));
String yong_tu=getbyte1(request.getParameter("yong_tu"));
String ok=getbyte1(request.getParameter("ok"));
 String a1=getbyte1(request.getParameter("a1"));
 String a2=getbyte1(request.getParameter("a2"));
 String a3=getbyte1(request.getParameter("a3"));
 String a4=getbyte1(request.getParameter("a4"));
 String a5=getbyte1(request.getParameter("a5"));
 String a6=getbyte1(request.getParameter("a6"));
 String a7=getbyte1(request.getParameter("a7"));
 String a8=getbyte1(request.getParameter("a8"));
 String a9=getbyte1(request.getParameter("a9"));
 String a10=getbyte1(request.getParameter("a10")); 
 String a11=getbyte1(request.getParameter("a11"));
 String a12=getbyte1(request.getParameter("a12"));
 String a13=getbyte1(request.getParameter("a13"));
 String a14=getbyte1(request.getParameter("a14"));
 String a15=getbyte1(request.getParameter("a15"));
 String bak1=getbyte1(request.getParameter("bak1"));
 String bak2=getbyte1(request.getParameter("bak2"));
 String bak3=getbyte1(request.getParameter("bak3"));
 String bak4=getbyte1(request.getParameter("bak4"));
 String bak5=getbyte1(request.getParameter("bak5"));
 String bak6=getbyte1(request.getParameter("bak6")); 
 String bak7=getbyte1(request.getParameter("bak7")); 
 String bak8=getbyte1(request.getParameter("bak8")); 
 String bak9=getbyte1(request.getParameter("bak9"));  
 String bak10=getbyte1(request.getParameter("bak10")); 
 String bak11=getbyte1(request.getParameter("bak11")); 
 String bak12=getbyte1(request.getParameter("bak12")); 
 String bak13=getbyte1(request.getParameter("bak13")); 
 String bak14=getbyte1(request.getParameter("bak14")); 
  String bak15=getbyte1(request.getParameter("bak15")); 
 String bak16=getbyte1(request.getParameter("bak16")); 
 String bak17=getbyte1(request.getParameter("bak17")); 
  String bak18=getbyte1(request.getParameter("bak18")); 
 String bak19=getbyte1(request.getParameter("bak19")); 
 String bak20=getbyte1(request.getParameter("bak20")); 
 String bak21=getbyte1(request.getParameter("bak21")); 
 String choose1=getbyte1(request.getParameter("choose1")); 
 String choose2=getbyte1(request.getParameter("choose2")); 
 String choose3=getbyte1(request.getParameter("choose3")); 
  String choose4=getbyte1(request.getParameter("choose4")); 
 
 if (!ok.equals("")){
   String sql="SELECT * FROM contractWYTK WHERE sectionno='"+SecNo+"'  and yong_tu='"+yong_tu+"'";
   
   ResultSet rs=aBean.executeQuery(sql);
 
   if (rs.next()){
    sql="update  contractWYTK set price="+price+", a1='"+a1+"',a2='"+a2+"',a3='"+a3+"',a4='"+a4+"'";
	sql+=",a5='"+a5+"',a6='"+a6+"',a7='"+a7+"',a8='"+a8+"',a9='"+a9+"',a10='"+a10+"'";
	sql+=",a11='"+a11+"',a12='"+a12+"',a13='"+a13+"',a14='"+a14+"',a15='"+a15+"'";
	sql+=",bak1='"+bak1+"',bak2='"+bak2+"',bak3='"+bak3+"',bak4='"+bak4+"',bak5='";
	sql+=bak5+"',bak6='"+bak6+"',bak7='"+bak7+"',choose3="+choose3+",choose2="+choose2+",choose1="+choose1;
	sql+=",choose4="+choose4+",bak8='"+bak8+"',bak9='"+bak9+"' ";
	sql+=",bak10='"+bak10+"',bak11='"+bak11+"',bak12='"+bak12+"',bak13='"+bak13+"',";
	sql+="bak14='"+bak14+"',bak15='"+bak15+"',bak16='"+bak16+"', ";
	sql+="bak17='"+bak17+"',bak18='"+bak18+"',bak19='"+bak19+"' ,bak20='"+bak20+"',bak21='"+bak21+"' ";
	sql+=" where sectionno='"+SecNo+"' and yong_tu='"+yong_tu+"'";
    
   
   }else{
    sql="insert into contractWYTK(yong_tu,sectionno,price,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14 ";
    sql+=",a15,bak1,bak2,bak3,bak4,bak5,bak6,bak7,choose3,choose2,choose1,choose4,bak8,bak9,";
	sql+="bak10,bak11,bak12,bak13,bak14,bak15,bak16,bak17,bak18,bak19,bak20,bak21) values('"+yong_tu+"','"+SecNo+"',"+price+",'"+a1+"','"+a2+"','"+a3+"','"+a4+"','"+a5+"'";
	sql+=",'"+a6+"','"+a7+"','"+a8+"','"+a9+"','"+a10+"','"+a11+"','"+a12+"','"+a13+"'";
	sql+=",'"+a14+"','"+a15+"','"+bak1+"','"+bak2+"','"+bak3+"','"+bak4+"','"+bak5+"','"+bak6+"','"+bak7+"',";
	sql+=choose3+","+choose2+","+choose1+","+choose4+",'"+bak8+"','"+bak9+"','"+bak10+"','"+bak11;
	sql+="','"+bak12+"','"+bak13+"','"+bak14+"','"+bak15+"','"+bak16+"','"+bak17+"','"+bak18+"','"+bak19+"','"+bak20+"','"+bak21+"')";
	}
 
	
	 aBean.executeUpdate(sql);

	 
 }
 if (chooseyt.equals(""))chooseyt="住宅";  
 String SQL="SELECT * FROM contractWYTK WHERE sectionno='"+SecNo+"' and yong_tu='"+chooseyt+"'";
 
 ResultSet rs=aBean.executeQuery(SQL);

 if (rs.next()){
   price=getbyte(rs.getString("price"));
 if (price.equals(""))price="600";
   a1=getbyte(rs.getString("a1"));
   a2=getbyte(rs.getString("a2"));
   a3=getbyte(rs.getString("a3"));
   a4=getbyte(rs.getString("a4"));
   a5=getbyte(rs.getString("a5"));
   a6=getbyte(rs.getString("a6"));
   a7=getbyte(rs.getString("a7"));
   a8=getbyte(rs.getString("a8"));
   a9=getbyte(rs.getString("a9"));
   a10=getbyte(rs.getString("a10"));
   a11=getbyte(rs.getString("a11"));
   a12=getbyte(rs.getString("a12"));
   a13=getbyte(rs.getString("a13"));
   a14=getbyte(rs.getString("a14"));
   a15=getbyte(rs.getString("a15"));
   bak1=getbyte(rs.getString("bak1"));
   
   bak2=getbyte(rs.getString("bak2"));
   bak3=getbyte(rs.getString("bak3"));
   bak4=getbyte(rs.getString("bak4"));
   bak5=getbyte(rs.getString("bak5"));
   bak6=getbyte(rs.getString("bak6"));

   bak7=getbyte(rs.getString("bak7"));
   bak8=getbyte(rs.getString("bak8"));
   bak9=getbyte(rs.getString("bak9"));
   bak10=getbyte(rs.getString("bak10"));
   bak11=getbyte(rs.getString("bak11"));
   bak12=getbyte(rs.getString("bak12"));
   bak13=getbyte(rs.getString("bak13"));
   bak14=getbyte(rs.getString("bak14"));
   
    bak15=getbyte(rs.getString("bak15"));
   bak16=getbyte(rs.getString("bak16"));
   bak17=getbyte(rs.getString("bak17"));
   bak18=getbyte(rs.getString("bak18"));
   bak19=getbyte(rs.getString("bak19"));
   bak20=getbyte(rs.getString("bak20"));
   bak21=getbyte(rs.getString("bak21"));
   choose1=getbyte(rs.getString("choose1"));
   choose2=getbyte(rs.getString("choose2"));
   choose3=getbyte(rs.getString("choose3"));
   choose4=getbyte(rs.getString("choose4")); 
 }else{
     a1="X";
   a2="X";
   a3="X";
   a4="X";
   a5="X";
   a6="X";
   a7="X";
   a8="X";
   a9="X";
   a10="X";
   a11="X";
   a12="X";
   a13="X";
   a14="X";
   a15="X";
   bak1="X";
   
   bak2="X";
   bak3="X";
   bak4="X";
   bak5="X";
   bak6="X";

   bak7="X";
   bak8="X";
   bak9="X";
   bak10="X";
   bak11="X";
   bak12="X";
   bak13="X";
   bak14="X";
   
   bak15="X";
   bak16="X";
   bak17="X";
   bak18="X";
   bak19="X";
   bak20="X";
   bak21="X";
   choose1="X";
   choose2="X";
   choose3="X";
   choose4="X"; 
   
 
 
 }
rs.close();


 String ch1a="", ch1b="";
 String ch2a="", ch2b="";
 String ch3a="", ch3b="";
  String ch4a="", ch4b="",ch4c="";

 if (choose3.equals("1")){ch3a="checked";ch3b="";}
 else {ch3a="";ch3b="checked";}
 if (choose2.equals("1")){ch2a="checked";ch2b="";}
 else {ch2a="";ch2b="checked";}
 if (choose1.equals("1")){ch1a="checked";ch1b="";}
 else {ch1a="";ch1b="checked";}
  if (choose4.equals("1")){ch4a="checked";ch4b="";ch4c="";}
 else if (choose4.equals("2")){ch4a="";ch4b="checked";ch4c="";}
 else {ch4a="";ch4b="";ch4c="checked";}
 if (bak1.equals(""))bak1="X";
 if (bak2.equals(""))bak2="X";
 if (bak3.equals(""))bak3="X";
 if (bak4.equals(""))bak4="X";
 if (bak5.equals(""))bak5="X";
 if (bak6.equals(""))bak6="X";
 if (bak7.equals(""))bak7="X";
 if (bak8.equals(""))bak8="X";
 if (bak9.equals(""))bak9="X";
 if (bak10.equals(""))bak10="X"; 
  if (bak11.equals(""))bak11="X";
 if (bak12.equals(""))bak12="X";
 if (bak13.equals(""))bak13="X";
 if (bak14.equals(""))bak14="X";
 if (bak15.equals(""))bak15="X";
 if (bak16.equals(""))bak16="X";
 if (bak17.equals(""))bak17="X";
 if (bak18.equals(""))bak18="X";
 if (bak19.equals(""))bak19="X";
   if (bak20.equals(""))bak20="X";
 if (bak21.equals(""))bak21="X";  
 %>
 选择用途：<select name="yongt" onchange="document.frm.submit();">
<option value=""></option>
  <%
 String yu="select type,codename,bak from CODE where child=0  and type='YT' order by type";
 
  
    rs=aBean.executeQuery(yu);
   int i=0;
   while (rs.next()){
    %><option value="<%=getbyte(rs.getString("codename")) %>"><%=getbyte(rs.getString("codename")) %></option>
	<%
	 i++;
   }
   rs.close();
 %>	
</select >
<table width="100%" cellspacing cellpadding>
 <tr>
    <td width="100%" height="40"><b>补充协议庭院/露台结算单价:<input type=text size=5 name=price value="<%=price %>">元/M<sup>2</sup></b></td>
  </tr>
  <tr>
    <td width="100%" height="40"><b>买方违约责任</b></td>
  </tr>
 <tr>
    <td width="100%" height="40">&nbsp;&nbsp;&nbsp;&nbsp;<input name="choose1" type="radio" value=1 <%=ch1a %>>1、逾期在<input type=text name=a1 size=5 value="<%=a1 %>">日之内，自本合同规定的应付款期限之第二天起到实际全额支付应付款之日止，买方人按日向出卖方支付</td>
  </tr>
     <tr>
    <td width="100%" height="40">逾期应付款万分之<input type=text size=5  name=a2 value="<%=a2 %>">的违约金，合同继续履行。</td>
  </tr>
   <tr>
    <td width="100%" height="40">&nbsp;&nbsp;&nbsp;&nbsp;<input name="choose1" type="radio" value=2 <%=ch1b %>>2、逾期超过<input type=text name=a3 size=5 value="<%=a3 %>">日后，出卖方有权解除合同。出卖人解除合同的，买方人按累计应付款的<input type=text name=a4 size=5 value="<%=a4 %>">%向出卖人技术违约</td>
  </tr>
     <tr>
    <td width="100%" height="40">金。买方愿意继续履行合同的，经出卖方同意，合同继续履行，自本合同规定的应付款期限之第二天起到实际全额支付应款之</td>
  </tr>
   <tr>
    <td width="100%" height="40"> 日止,买方人按日向出卖方支付逾期应付款万分之<input type=text name=a5 size=5 value="<%=a5 %>">的违约金。</td>
  </tr>
    <tr>
    <td width="100%" height="40">备注:<textarea cols="80" rows="3" name=bak1 ><%=bak1 %></textarea></td>
  </tr>
 <tr>
    <td width="100%" height="40"><b>出卖方违约责任</b></td>
  </tr>
   <tr>
    <td width="100%" height="40">&nbsp;&nbsp;&nbsp;&nbsp;<input name="choose2" type="radio" value=1 <%=ch2a %>>1、逾期不超过<input type=text name=a6 size=5 value="<%=a6 %>">日，...按日买方支付已交房款万分之<input type=text name=a7 size=5 value="<%=a7 %>">的违约金。</td>
  </tr>
  <tr>
    <td width="100%" height="40">&nbsp;&nbsp;&nbsp;&nbsp;<input name="choose2" type="radio" value=1 <%=ch2b %>>2、逾期超过<input type=text name=a8 size=5 value="<%=a8 %>">日后，...自卖方解除合同通知达到之日起<input type=text name=a9 size=5 value="<%=a9 %>">内退还全部已付房款，并按累计已付款的<input type=text name=a10 size=5 value="<%=a10 %>">%</td>
  </tr>
   <tr>
    <td width="100%" height="40">向买方支付违约金，如果买方愿意继续履行合同...出卖人按日向买方支付已付房款万分之<input type=text name=a11 size=5 value="<%=a11 %>">的违约金。</td>
  </tr>
   <tr>
    <td width="100%" height="40">备注:<textarea cols="80" rows="3" name=bak2 ><%=bak2 %></textarea></td>
  </tr>
   <tr>
    <td width="100%" height="40"><b>交接备注</b></td>
  </tr>
    <tr>
    <td width="100%" height="40">备注:<input type=text name=bak5 size=70 value="<%=bak5 %>"  maxlength="40"><br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name=bak20 size=70 value="<%=bak20 %>"  maxlength="40"><br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name=bak21 size=70 value="<%=bak21 %>"  maxlength="40">
	</td>
  </tr>
   <tr>
    <td width="100%" height="40"><b>第十二条</b></td>
  </tr>
   <tr>
    <td width="100%" height="40">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name=bak6 size=70 value="<%=bak6 %>"  maxlength="40"></td>
  </tr>
   <tr>
    <td width="100%" height="40"><b>装饰违约责任</b></td>
  </tr>
   <tr>
    <td width="100%" height="40"><input name="choose4" type="radio" value=1 <%=ch4a %>>1、出卖人赔偿双倍的装饰、设备差价。</td>
  </tr>
   <tr>
    <td width="100%" height="40"><input name="choose4" type="radio" value=2 <%=ch4b %>>2、<textarea cols="80" rows="3" name=bak8 ><%=bak8 %></textarea></td>
  </tr>
   <tr>
    <td width="100%" height="40"><input name="choose4" type="radio" value=3 <%=ch4c%>>3、<textarea cols="80" rows="3" name=bak9 ><%=bak9 %></textarea></td>
  </tr>
   <tr>
    <td width="100%" height="40"><b>产权登记的约定</b></td>
  </tr>
   <tr>
    <td width="100%" height="40">&nbsp;&nbsp;&nbsp;&nbsp;出卖人应当在商品房交付使用后<input type=text name=a12 size=5 value="<%=a12 %>">日内.....</td>
  </tr>
     <tr>
    <td width="100%" height="40">&nbsp;&nbsp;&nbsp;&nbsp;<input name="choose3" type="radio" value=1 <%=ch3a %>>1、买方人退房，出卖方在买方提出退房要求之日起<input type=text name=a13 size=5 value="<%=a13 %>">日内.....,并按已付房款的<input type=text name=a14 size=5 value="<%=a14 %>">%赔偿买方的损失；</td>
  </tr>
    <tr>
    <td width="100%" height="40">&nbsp;&nbsp;&nbsp;&nbsp;<input name="choose3" type="radio" value=2 <%=ch3b %> >2、买方人不退房，出卖方按已付款房款的<input type=text name=a15 size=5 value="<%=a15 %>">向买方支付违约金；</td>
  </tr>
   <tr>
    <td width="100%" height="40">备注:<textarea cols="80" rows="3" name=bak3 ><%=bak3 %></textarea></td>
  </tr>
 <tr>
    <td width="100%" height="40"><b>第六条　付款方式约定</b></td>
  </tr>
    <tr>
    <td width="100%" height="40">备注:<input type=text name=bak10 size=70 value="<%=bak10 %>"  maxlength="40"><br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name=bak15 size=70 value="<%=bak15 %>"  maxlength="40"><br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name=bak16 size=70 value="<%=bak16 %>"  maxlength="40">
	</td>
  </tr>
   <tr>
    <td width="100%" height="40"><b>第八条　交付期限</b></td>
  </tr>
    <tr>
    <td width="100%" height="40">备注:<input type=text name=bak17 size=70 value="<%=bak17 %>"  maxlength="40"><br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name=bak18 size=70 value="<%=bak18 %>"  maxlength="40"><br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name=bak19 size=70 value="<%=bak19 %>"  maxlength="40">
	</td>
  </tr>
  <tr>
    <td width="100%" height="40"><b>第十六条　保修责任</b></td>
  </tr>
    <tr>
    <td width="100%" height="40">备注:<textarea cols="80" rows="3" name=bak4 ><%=bak4 %></textarea></td>
  </tr>
   <tr>
    <td width="100%" height="40"><b>第十七条　约定</b></td>
  </tr>
   <tr>
    <td width="100%" height="40">1、<textarea cols="80" rows="3" name=bak11 ><%=bak11 %></textarea></td>
  </tr>
    <tr>
    <td width="100%" height="40">2、<textarea cols="80" rows="3" name=bak12 ><%=bak12 %></textarea></td>
  </tr>
    <tr>
    <td width="100%" height="40">3、<textarea cols="80" rows="3" name=bak13 ><%=bak13 %></textarea></td>
  </tr>
    <tr>
    <td width="100%" height="40">4、<textarea cols="80" rows="3" name=bak14 ><%=bak14 %></textarea></td>
  </tr>
    <tr>
    <td width="100%" height="40"><b>第十八条备注</b></td>
  </tr>
   <tr>
    <td width="100%" height="40">备注:<textarea cols="80" rows="3" name=bak7 ><%=bak7 %></textarea></td>
  </tr>
</table> 
 <%if (yong_tu.equals(""))yong_tu=chooseyt; %>
  所属用途：<input type=text name=yong_tu size=30 readonly value="<%=chooseyt %>"><input type=button name=yt value='..' onclick="openwin('../basic/yong_tulist.jsp',200,250,100,100);">
注意:如果没有内容请用"X"表示。
<input type=button name=aa value="提 交" onclick="save();">
<input type=hidden name=choose value="3">
<input type=hidden name=url value=1>
<input type=hidden name=rgorsale>
<input type=hidden name=ok>
<SCRIPT>
 function save(){
 document.frm.ok.value="ok";
 document.frm.submit();
 
 }
setSelectMad(document.frm.yongt,'<%=chooseyt %>');
</script>
 </form>
</body> 
 
</html> 
