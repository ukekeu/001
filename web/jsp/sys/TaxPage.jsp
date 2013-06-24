<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>计算费用公式设置-><%=getbyte1(request.getParameter("taxname")) %></title>
</head>
<%
String StrEditPara=China.getParameter(request,"para1");
String StrEditID=China.getParameter(request,"id");
String StrSQL="";
String StrTaxName="";
String StrMoney="",StrMoney1="";
String StrTermArea="";
String StrTermArea1="",StrTermArea2="",StrTermArea3="";
String StrState="";
String term="";
String term1="",term2="",term3="";
String type1="0";
String type="0";
String type3="0";
String custype="";
ResultSet TaxRs = null;
String choose="A";
if (!StrEditID.equals(""))
   {StrSQL="SELECT code,state, termvalue,termvalue1,termvalue2,termvalue3,money,money1,term,term1,term2,term3,type,type1,type3,choose  FROM TaxChages WHERE id="+StrEditID;
   TaxRs=ViewBean.executeQuery(StrSQL);
   if (TaxRs.next()){
      StrTaxName=getbyte(TaxRs.getString("code"));
	  StrState=TaxRs.getString("state");
	  StrMoney=FormatD.getFloat1(TaxRs.getFloat("money"),3);
	  StrTermArea=getbyte(TaxRs.getString("termvalue"));
	  StrTermArea1=getbyte(TaxRs.getString("termvalue1"));
	  term=getbyte(TaxRs.getString("term"));
	  term1=getbyte(TaxRs.getString("term1"));	  
	  StrTermArea2=getbyte(TaxRs.getString("termvalue2"));
	  StrTermArea3=getbyte(TaxRs.getString("termvalue3"));
	  term2=getbyte(TaxRs.getString("term2"));
	  term3=getbyte(TaxRs.getString("term3"));	
	  
	  custype=getbyte(TaxRs.getString("type"));	  
	  type1=getbyte(TaxRs.getString("type1"));	  
      type3=getbyte(TaxRs.getString("type3"));	  
      StrMoney1=FormatD.getFloat1(TaxRs.getFloat("money1"),3);
	  choose=getbyte(TaxRs.getString("choose"));	  
   }   
    TaxRs.close();
   }
   
   String sel=(String)request.getParameter("sel");
       if(sel==null) sel="3"; 
	   if (!choose.equals("A"))sel=choose;
  %>
<script>
function checktype1(para){
 
<%if (sel.equals("3")){ %>
 if (document.frm.R1[0].checked)
  {
   document.frm.checktype.value=para;
   document.frm.unitprice1.value="";
    document.frm.unitprice2.value="";
    document.frm.unitprice3.value="";
  // document.frm.term.value="";
  // document.frm.area.value="";
    document.frm.termmoney.focus();
  }else if (document.frm.R1[1].checked)
   {document.frm.checktype.value=para;
    document.frm.MONEY1.value="";
    document.frm.termmoney.value="";
   document.frm.termmoney3.value="";
    //document.frm.term.value="";
	//document.frm.area.value="";
	 document.frm.unitprice1.focus();
   }
<%}else  if (sel.equals("0")){ %> 
   if (document.frm.R1[0].checked)
   {
    document.frm.checktype.value=para;
    document.frm.MONEY4.value="";
    document.frm.MONEY2.focus();
   }
   
   
 else if (document.frm.R1[1].checked)
 {
    document.frm.checktype.value=para;
 
    document.frm.MONEY2.value="";
 
    document.frm.MONEY4.focus();
 }
 <%}else  if (sel.equals("1")){ %> 
  if (document.frm.R1[0].checked)
 {
    document.frm.checktype.value=para;
    document.frm.area9.value="";
    document.frm.MONEY8.value="";
    document.frm.MONEY6.value="";
	document.frm.area7.value="";
    document.frm.MONEY3.value="";
	document.frm.area1.value="";
	document.frm.area8.value="";
	document.frm.area6.value="";
    document.frm.area.focus();
 } 
else if (document.frm.R1[1].checked)
 {   document.frm.checktype.value=para;
    document.frm.area9.value="";
    document.frm.MONEY8.value="";
    document.frm.MONEY6.value="";
	document.frm.area7.value="";
    document.frm.MONEY3.value="";
	document.frm.area1.value="";
	document.frm.area8.value="";
	document.frm.area.value="";
    document.frm.area6.focus();
 }
 else if (document.frm.R1[2].checked)
 {   document.frm.checktype.value=para;
    document.frm.area9.value="";
    document.frm.MONEY8.value="";
    document.frm.MONEY6.value="";
	document.frm.area7.value="";
    document.frm.MONEY3.value="";
	document.frm.area1.value="";
	document.frm.area6.value="";
	document.frm.area.value="";
    document.frm.area8.focus();
 }
  else if (document.frm.R1[3].checked)
 {
 document.frm.checktype.value=para;
      document.frm.area9.value="";
    document.frm.MONEY8.value="";
    document.frm.MONEY6.value="";
	document.frm.area7.value="";
    document.frm.MONEY3.value="";
	document.frm.area1.value="";
	document.frm.area6.value="";
	document.frm.area8.value="";
	document.frm.area.value="";
    
 }
 <%}else  if (sel.equals("2")){ %> 
    document.frm.checktype.value=para;
     document.frm.termmoney1.focus();
 
 <%} %>
}
function key1(){ 
      if (event.keyCode==13){
        loca();
    }
	}
</script>
<script language="javascript" src="../public_js/public.js">
</script>
<%@ include file="../public_js/CheckSection.jsp"%>
<body >
 <form method="POST" name=frm action="">
 <input type=hidden name=code value="<%=request.getParameter("code") %>">
<p align="center">
	    <b>选择计算公式并设置计算条件</b>
 </p>
 
    <input type=hidden name="sel" value="<%=sel %>">
     <table width="360" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr> 
<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=3;document.frm.submit();"> <font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>按销售价格 
	</td>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;document.frm.submit();"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>按固定金额 
	</td>
	 
	 <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;document.frm.submit();"> <font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>按面积计算 
	</td>
	 <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=2;document.frm.submit();"> <font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>按贷款金额 
	</td>
	</tr></table>
	 
<table border="0" width="100%">
  <input type=hidden name="checktype" value=99>
  <%if (sel.equals("3")){ %>
  <tr BGCOLOR="f6f6f6">
 
    <td width="73%">
	<%if (!StrState.equals("1")){ %>
	<input type="radio"  name="R1"  value="1"  onclick="checktype1('1');">按售价百分比计算&nbsp;<input type="checkbox" name="type1"  value="1">不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1">是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1" >是否为单位费用
	<%}else if (StrState.equals("1")){ %>
	<input type="radio" checked name="R1"  value="1"  onclick="checktype1('1');">按售价百分比计算&nbsp;<input type="checkbox" name="type1"  value="1" <%if (type1.equals("1"))out.println("checked"); %>>不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1"  <%if (type3.equals("1"))out.println("checked"); %>>是否为外销费用&nbsp;&nbsp;<input type="checkbox" name="type"  value="1"  <%if (custype.equals("1"))out.println("checked"); %>>是否为单位费用
   <%} %>		
	</td>
  </tr>
  <tr >
  
    <td width="73%"   >
	售价<select size="1" name="term1">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	<%if (!StrEditID.equals("")&&StrState.equals("1")){ %> 
		
		<input type="text" name="termmoney" onblur="checkTax(this);" size="4" value="<%=StrTermArea %>">元</sup>
且
	<select size="1" name="term3">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	  <input type="text" name="termmoney3" onblur="checkTax(this);"  size="4" value="<%=StrTermArea1 %>">万元</sup>
	<input type="text" name="MONEY1" size="5" onblur="checkTax(this);"  value="<%=StrMoney %>" onkeydown="key1()"> ‰
<script> setSelectMad(document.frm.term1,'<%=term %>');</script>
<script> setSelectMad(document.frm.term3,'<%=term1 %>');</script>
	<%}else{%>
	<input type="text" name="termmoney" onblur="checkTax(this);"  size="4">万元</sup>
	且
	<select size="1" name="term3">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	  <input type="text" name="termmoney3" onblur="checkTax(this);"  size="4">万元</sup>
	收取<input type="text" name="MONEY1"  onblur="checkTax(this);" size="5"  onkeydown="key1()"> ‰
    <%} %>
	</td>
	
  </tr>
  <tr><td ><hr></td></tr>
   <tr>
  
    <td width="73%">
	<%if (!StrState.equals("8")){ %>
	<input type="radio"  name="R1"  value="8" onclick="checktype1('8');">按单价计算&nbsp;<input type="checkbox" name="type1"  value="1">不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1">是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1">是否为单位费用
	<%}else if (StrState.equals("8")){ %>
	<input type="radio" checked name="R1"  value="8"  onclick="checktype1('8');">按单价计算&nbsp;<input type="checkbox" name="type1"  value="1" <%if (type1.equals("1"))out.println("checked"); %>>不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1"  <%if (type3.equals("1"))out.println("checked"); %>>是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1" <%if (custype.equals("1"))out.println("checked"); %>>是否为单位费用
   <%} %>		
	</td>
  </tr>
  <tr>
 
    <td width="73%"   >
	单价<select size="1" name="unit1">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	<%if (!StrEditID.equals("")&&StrState.equals("8")){ %> 
	<script> setSelectMad(document.frm.term10,'<%=term %>');</script>
	  <input type="text" name="unitprice1" onblur="checkTax(this);"   size="4" value="<%=StrTermArea %>">M<sup>2</sup>
且 <select size="1" name="unit2">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	   <input type="text" name="unitprice2" onblur="checkTax(this);"  size="4" value="<%=StrTermArea1 %>">>M<sup>2</sup>，收总房款的
	<input type="text" name="unitprice3" onblur="checkTax(this);"  size="5" value="<%=StrMoney %>" onkeydown="key1()"> ‰
<script> setSelectMad(document.frm.unit1,'<%=term %>');</script>
<script> setSelectMad(document.frm.unit2,'<%=term1 %>');</script>
	<%}else{%>
	 <input type="text" name="unitprice1" onblur="checkTax(this);"  size="4">元/M<sup>2</sup>
	且 <select size="1" name="unit2">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	   <input type="text" name="unitprice2" onblur="checkTax(this);"  size="4">元/M<sup>2</sup> ，收总房款的
	<input type="text" name="unitprice3" onblur="checkTax(this);"  size="5"  onkeydown="key1()"> ‰ 
    <%} %>
	</td>
	
  </tr>
  <%}else  if (sel.equals("0")){ %>  
  <tr class='listcontent'>
    
    <td width="73%">
	<%if (!StrState.equals("2")){ %>
	<input type="radio" name="R1"  value="2"   onclick="checktype1('2');">按套计算&nbsp;&nbsp;<input type="checkbox" name="type3"  value="1">是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1" >是否为单位费用&nbsp;
	<%}else if (StrState.equals("2")){ %>
	 	<input type="radio" name="R1" checked  value="2"  onclick="checktype1('2');">按套计算&nbsp;<input type="checkbox" name="type3"  value="1"  <%if (type3.equals("1"))out.println("checked"); %>>是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1" <%if (custype.equals("1"))out.println("checked"); %>>是否为单位费用
	<%} %>
	</td>
  </tr>
  
  <tr>
 
    <td width="73%"   >
	<%if (!StrEditID.equals("")&&StrState.equals("2")){ %> 
	<input type="text" name="MONEY2"  onblur="checkTax(this);"size="17" value="<%=StrMoney %>" onkeydown="key1()">元
	<%}else{%><input type="text" onblur="checkTax(this);" name="MONEY2" size="17"  onkeydown="key1()">元
    <%} %>
	
	</td>
  </tr>
    <tr><td ><hr></td></tr>
   <tr class='listcontent'> 
    <td width="73%">
	<%if (!StrState.equals("6")){ %>
	<input type="radio" name="R1"  value="6"  onclick="checktype1('6');">按户数计算&nbsp;<input type="checkbox" name="type3"  value="1">是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1">是否为单位费用
	<%}else if (StrState.equals("6")){ %>
	 	<input type="radio" name="R1" checked   value="6"  onclick="checktype1('6');">按户数计算&nbsp;<input type="checkbox" name="type3"  value="1"  <%if (type3.equals("1"))out.println("checked"); %>>是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1"  <%if (custype.equals("1"))out.println("checked"); %>>是否为单位费用
	<%} %>
	</td>
  </tr>
  <tr >
 
    <td width="73%">
	<%if (!StrEditID.equals("")&&StrState.equals("6")){ %> 
	<input type="text" name="MONEY4"  onblur="checkTax(this);"value="<%=StrMoney %>" size="16"  onkeydown="key1()">元</td>
    <%}else{ %>
		<input type="text" name="MONEY4" onblur="checkTax(this);"  size="16"  onkeydown="key1()">元</td>
	<%} %>
  </tr>
    <%}else  if (sel.equals("1")){ %>  
  <tr BGCOLOR="f6f6f6">
 
    <td width="73%">
	<%if (!StrState.equals("3")){ %>
 
	<input type="radio" name="R1"  value="3"  onclick="checktype1('3');">按建筑面积计算&nbsp;<input type="checkbox" name="type1"  value="1">不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1">是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1">是否为单位费用
	<%}else if (StrState.equals("3")){ %>
	 	<input type="radio" name="R1" checked  value="3"   onclick="checktype1('3');">按建筑面积计算&nbsp;<input type="checkbox" name="type1"  value="1" <%if (type1.equals("1"))out.println("checked"); %>>不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1"  <%if (type3.equals("1"))out.println("checked"); %>>是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1"  <%if (custype.equals("1"))out.println("checked"); %>>是否为单位费用
	<%} %>
	</td>
  </tr>
  <tr>
 
    <td width="73%"   >
	面积<select size="1" name="term">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	  <%if (StrState.equals("3")){ %>
	 
	  <input type="text" name="area" onblur="checkTax(this);" size="4" value="<%=StrTermArea %>">M<sup>2</sup>
 且<select size="1" name="term4">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select> 
	  <input type="text" name="area1" onblur="checkTax(this);" size="4" value="<%=StrTermArea1 %>">M<sup>2</sup>,收房款的
<input type="text" name="MONEY3" onblur="checkTax(this);" size="4" value="<%=StrMoney %>"  onkeydown="key1()">‰
 <script>
  setSelectMad(document.frm.term,'<%=term %>');
 setSelectMad(document.frm.term4,'<%=term1 %>');
 </script>
	  <%}else{ %>
	  <input type="text" name="area" onblur="checkTax(this);" size="4">M<sup>2</sup>
	  且<select size="1" name="term4">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select> 
	  <input type="text" name="area1"  onblur="checkTax(this);" size="4">M<sup>2</sup>,收房款的
	  <input type="text" name="MONEY3" onblur="checkTax(this);" size="4" onkeydown="key1()"> ‰
	  <%} %>
	  </td>
	  
  </tr>
  
    <tr><td ><hr></td></tr>
   <tr class='listcontent'>
 
    <td width="73%">
	<%if (!StrState.equals("4")){ %>
 
	<input type="radio" name="R1"  value="4"  onclick="checktype1('4');">按建筑面积计算&nbsp;<input type="checkbox" name="type1"  value="1">不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1">是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1">是否为单位费用
	<%}else if (StrState.equals("4")){ %>
	 	<input type="radio" name="R1" checked  value="4" onclick="checktype1('4');">按建筑面积计算&nbsp;<input type="checkbox" name="type1"  value="1" <%if (type1.equals("1"))out.println("checked"); %>>不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1"  <%if (type3.equals("1"))out.println("checked"); %>>是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1"  <%if (custype.equals("1"))out.println("checked"); %>>是否为单位费用
	<%} %>
	</td>
  </tr>
  <tr>
 
    <td width="73%"   >
	面积<select size="1" name="term6">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	  <%if (StrState.equals("4")){ %>
	 
	  <input type="text" name="area6"  onblur="checkTax(this);" size="4" value="<%=StrTermArea %>">M<sup>2</sup>
 且<select size="1" name="term7">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select> 
	  <input type="text" name="area7" onblur="checkTax(this);" size="4" value="<%=StrTermArea1 %>">M<sup>2</sup>,收
<input type="text" name="MONEY6" size="4" onblur="checkTax(this);" value="<%=StrMoney %>"  onkeydown="key1()">元
 <script>
  setSelectMad(document.frm.term6,'<%=term %>');
 setSelectMad(document.frm.term7,'<%=term1 %>');
 </script>
	  <%}else{ %>
	  <input type="text" name="area6"  onblur="checkTax(this);" size="4">M<sup>2</sup>
	  且<select size="1" name="term7">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select> 
	  <input type="text" name="area7" onblur="checkTax(this);" size="4">M<sup>2</sup>,收 
	  <input type="text" name="MONEY6" onblur="checkTax(this);" size="4" onkeydown="key1()"> 元
	  <%} %>
	  </td>
	  
  </tr>
  
    <tr><td ><hr></td></tr>
  
   <tr BGCOLOR="f6f6f6">
 
    <td width="73%">
	<%if (!StrState.equals("5")){ %>
 
	<input type="radio" name="R1"  value="5"  onclick="checktype1('5');">按建筑面积计算&nbsp;<input type="checkbox" name="type1"  value="1">不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1">是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1">是否为单位费用
	<%}else if (StrState.equals("5")){ %>
	 	<input type="radio" name="R1" checked  value="5"  onclick="checktype1('5');">按建筑面积计算&nbsp;<input type="checkbox" name="type1"  value="1" <%if (type1.equals("1"))out.println("checked"); %>>不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1"  <%if (type3.equals("1"))out.println("checked"); %>>是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1"  <%if (custype.equals("1"))out.println("checked"); %>>是否为单位费用
	<%} %>
	</td>
  </tr>
  <tr>
 
    <td width="73%"   >
	面积<select size="1" name="term8">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	  <%if (StrState.equals("5")){ %>
	 
	  <input type="text" name="area8" onblur="checkTax(this);" size="4" value="<%=StrTermArea %>">M<sup>2</sup>
 且<select size="1" name="term9">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select> 
	  <input type="text" name="area9"  onblur="checkTax(this);" size="4" value="<%=StrTermArea1 %>">M<sup>2</sup>,收
<input type="text" name="MONEY8" onblur="checkTax(this);" size="4" value="<%=StrMoney %>"  onkeydown="key1()">元/M<sup>2</sup>
 <script>
  setSelectMad(document.frm.term8,'<%=term %>');
 setSelectMad(document.frm.term9,'<%=term1 %>');
 </script>
	  <%}else{ %>
	  <input type="text" name="area8"  onblur="checkTax(this);" size="4">M<sup>2</sup>
	  且<select size="1" name="term9">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select> 
	  <input type="text" name="area9" onblur="checkTax(this);" size="4">M<sup>2</sup>,收 
	  <input type="text" name="MONEY8" onblur="checkTax(this);" size="4" onkeydown="key1()"> 元/M<sup>2</sup>
	  <%} %>
	  </td>
	  
  </tr>
    <tr><td ><hr></td></tr>
  
  <tr>
 
    <td width="73%">
	<%if (!StrState.equals("9")){ %>
	<input type="radio" name="R1"  value="9"  onclick="checktype1('9');">1、套内建筑面积:
	<select size="1" name="A1">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select><input type="text" name="Aarea" onblur="checkTax(this);" size="4" value=120>M<sup>2</sup>
	且套内建筑面积单价<select size="1" name="B1">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select><input type="text" name="Barea"  onblur="checkTax(this);" size="4" value=3600>元/M<sup>2</sup><br>&nbsp;&nbsp;
2、建筑面积<select size="1" name="C1">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select><input type="text" name="Carea"  onblur="checkTax(this);" size="4" value=144>M<sup>2</sup>且建筑面积单价
	  <select size="1" name="D1">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select><input type="text" name="Darea"  onblur="checkTax(this);" size="4" value=3080>元/M<sup>2</sup>的按<input type="text" name="Earea" size="4"  onblur="checkTax(this);" value=1.5>%&nbsp;否则按<input type="text" name="Farea" size="4"  onblur="checkTax(this);" value=3.0>% 
	<%}else if (StrState.equals("9")){ %>
	 	 
		<input type="radio" name="R1" checked    value="9" onclick="checktype1('9');">1、套内建筑面积:
	<select size="1" name="A1">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	  <script> setSelectMad(document.frm.A1,'<%=term %>');</script>
	  <input type="text" name="Aarea" onblur="checkTax(this);" size="4" value=120 value="<%=StrTermArea %>">M<sup>2</sup>
	且套内建筑面积单价<select size="1" name="B1">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	  <script> setSelectMad(document.frm.B1,'<%=term1 %>');</script>
	  <input type="text" name="Barea" onblur="checkTax(this);" size="4" value=3600 value="<%=StrTermArea1 %>">元/M<sup>2</sup><br>&nbsp;&nbsp;
2、建筑面积<select size="1" name="C1">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	    <script> setSelectMad(document.frm.C1,'<%=term2 %>');</script>
	  <input type="text" name="Carea" size="4" onblur="checkTax(this);" value=144 value="<%=StrTermArea2 %>">M<sup>2</sup>且建筑面积单价
	  <select size="1" name="D1">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	      <script> setSelectMad(document.frm.D1,'<%=term3 %>');</script>
	  <input type="text" name="Darea" onblur="checkTax(this);" size="4" value=3080 value="<%=StrTermArea3 %>">元/M<sup>2</sup>的按<input type="text" name="Earea"  onblur="checkTax(this);" size="4" value=<%=StrMoney %>>%&nbsp;否则按<input type="text" name="Farea"  onblur="checkTax(this);" size="4" value=<%=StrMoney1 %>>% 
	
	<%} %>
	</td>
  </tr>
 
     <%}else  if (sel.equals("2")){ %> 
    <tr>
 
    <td width="73%" BGCOLOR="f6f6f6">
	<%if (!StrState.equals("7")){ %>
	<input type="radio"  name="R1" value=7 onclick="checktype1('2');">按按揭款百分比计算&nbsp;<input type="checkbox" name="type1"  value="1">不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1">是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1">是否为单位费用
	<%}else if (StrState.equals("7")){ %>
	<input type="radio" checked name="R1" value=7 onclick="checktype1('2');">按按揭款百分比计算&nbsp;<input type="checkbox" name="type1"  value="1" <%if (type1.equals("1"))out.println("checked"); %>>不足100元，按100计费&nbsp;<input type="checkbox" name="type3"  value="1"  <%if (type3.equals("1"))out.println("checked"); %>>是否为外销费用&nbsp;<input type="checkbox" name="type"  value="1" <%if (custype.equals("1"))out.println("checked"); %>>是否为单位费用
   <%} %>		
	</td>
  </tr>
  <tr>
 
    <td width="73%"   >
	按揭款<select size="1" name="term2">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	<%if (!StrEditID.equals("")&&StrState.equals("7")){ %> 
	<script> setSelectMad(document.frm.term2,'<%=term %>');</script>
	  <input type="text" name="termmoney1" onblur="checkTax(this);" size="4" value="<%=StrTermArea %>">元 
且 <select size="1" name="term5">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	   <input type="text" name="termmoney5" onblur="checkTax(this);" size="4" value="<%=StrTermArea1 %>">万元 
	<input type="text" name="MONEY5" onblur="checkTax(this);" size="5" value="<%=StrMoney %>" onkeydown="key1()"> ‰
<script> setSelectMad(document.frm.term2,'<%=term %>');</script>
<script> setSelectMad(document.frm.term5,'<%=term1 %>');</script>
	<%}else{%>
	 <input type="text" name="termmoney1" onblur="checkTax(this);" size="4">万元 
	且 <select size="1" name="term5">
        <option value=">">></option>
        <option value="<"><</option>
        <option value=">=">>=</option>
        <option value="<="><=</option>
      </select>
	   <input type="text" name="termmoney5" onblur="checkTax(this);"size="4">万元 
	<input type="text" name="MONEY5" size="5" onblur="checkTax(this);" onkeydown="key1()"> ‰ 
    <%} %>
	</td>
	
  </tr>
    
   
   <%} %>
</table>
 <p align="center"> 
 <input type=button name=save value="提 交" onclick="loca();">
            &nbsp;
<input type=button name=close value="退 出" onclick="window.close();">

          </P>

<script>
function Validate(aForm)
{    
   var FT="";
   <% if (!sel.equals("2")){ %>
   for (var ii=0;ii<document.frm.R1.length;ii++){
     if (document.frm.R1[ii].checked){FT="A";document.frm.checktype.value=document.frm.R1[ii].value;}
   }
  <%}else{ %>
   if (document.frm.R1.checked){FT="A";document.frm.checktype.value=document.frm.R1.value;}
  <%} %>
 
  if (FT==""){alert("请选择计费方式");return false;}
	   /*
	   
	   if (document.frm.R1[0].checked)
     {
        if (document.frm.MONEY1.value==""){
           alert("请输入交的费用百分比");
           document.frm.MONEY1.focus();
           return (false);
        }
     }
   else if (document.frm.R1[1].checked)
   {
       if (document.frm.MONEY2.value==""){
          alert("请输入交的费用");
          document.frm.MONEY2.focus();
          return (false);
       }
   }
 else if (document.frm.R1[2].checked)
   {
   if (document.frm.MONEY3.value==""||document.frm.area.value==""||document.frm.term.value=="")
     { alert("请输入面积范围及应交的费用");
       document.frm.MONEY3.focus();
       return (false);
    }
 }
 else if (document.frm.R1[5].checked)
 {
 
  if (document.frm.MONEY4.value==""){
      alert("请输入每户交的费用");
      document.frm.MONEY4.focus();
      return (false);
   }
  }
  else if (document.frm.R1[6].checked)
 {
  if (document.frm.MONEY5.value==""){
      alert("请输入每户交的费用");
      document.frm.MONEY5.focus();
      return (false);
   }
  }
  */
  return (true);
 }

  function checkTax(aa){
   var a1=aa.value;
  
   if (isNaN(a1)){
      alert("只能用数字表达");
	  aa.value="";
	  aa.value=0;
	  aa.focus();
	  return false;
	} else{
	 if (parseFloat(a1)<0){
	     alert("只能用正数表达");
	       
	  	  return false;
	 }
	
	} 
	 return true; 
  } 
function loca(){
	  
	  if (Validate(document.frm)){
	    <%if (StrEditID.equals("")){ %>
	 	 document.frm.action="saveTax.jsp";
		 <%}else{ %>
		 document.frm.action="saveTax.jsp?editid=<%=StrEditID %>";
		 <%} %>
		 document.frm.submit();
      }		
}
</script>
     
</center>
  </form>
</body>

</html>
