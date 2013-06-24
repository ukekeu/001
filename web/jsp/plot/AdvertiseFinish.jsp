<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>广告效意统计</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<link rel="stylesheet" href="../class/news.css" >
<script language=javascript src="../js/mad.js"> </script>
<script  src="../public_js/calendar.script"></script>
<script  src="../public_js/Popup.js"></script>     
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>


<script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("请输入栋号");
			return false;
		}	
	}
	
function loadForm() {
	
	
		
	}

</script>
<script language="javascript" src="../public_js/public.js">

</script>

<body onload="loadForm();">
<%
	//String saleStr = "select id,name,secno,building,room,cus_name,cus_no,htno,saleprice,ajbk,ajcs,ajmoney,ajyear from ajlistv2 ";
	 //      saleStr += " where  secno='" + section + "' and building like '%" + building  + "%' and section is null";
	//  out.print(saleStr);
		
%>
<%!
	public String getFloat(float temp,int lens) {
		java.text.DecimalFormat df = null;
		if (lens == 4)
			df = new java.text.DecimalFormat("###.#####");
		if (lens == 2)
			df = new java.text.DecimalFormat("###,###,###.##");
		if (lens == 1)
			df = new java.text.DecimalFormat("###,###,###");	
		return df.format(temp).toString();
	}

%>
<form method="post"> 
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR> 
    <TD COLSPAN="2"> 
        <DIV ALIGN="CENTER">广告完成记录</DIV>
    </TD>
  </TR>
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
</TABLE>
  <%
		String advertiseId = request.getParameter("AdvertiseId") ;
		String getStr = "select type,isFinish from advertise where id = " + advertiseId ;
	
		ResultSet getRs = aBean.executeQuery(getStr) ;
		String isFinish = "" ;
		String adverties = "" ;
		if (getRs.next()) {
		    adverties=getbyte(getRs.getString("type")) ;
			isFinish = getRs.getString("isFinish") ;
		}
		getRs.close() ;
		String sqlCus="select count(*) num  from customer  where  knowledge_from like '%"+adverties+"%'";
		String sqlCus1="select count(*) num ,sum(o.Jzarea) jzarea,sum(o.salerprice) saleprice from customer c,Order_Contract o where c.serialno=o.customer and c.knowledge_from like '%"+adverties+"%'";
        String cusNum="";
        String roomNum="";
		String saleArea="";
   	    String salePrice="";
	    try{
		   ResultSet CusRs1 = aBean.executeQuery(sqlCus) ;
		   if (CusRs1.next()){
		      cusNum=CusRs1.getString("num");
		   }
		   CusRs1.close();
		    ResultSet CusRs2 = aBean.executeQuery(sqlCus1) ;
		   if (CusRs2.next()){
		      roomNum=CusRs2.getString("num");
			  saleArea=CusRs2.getString("jzarea");
			  salePrice=CusRs2.getString("saleprice");
		   }
		   if (saleArea==null)saleArea="0";
  		   if (salePrice==null)salePrice="0";
		   CusRs2.close();
		 }catch(Exception s)  {out.print(s.getMessage());}
		if (isFinish != null) {
	%>
	<script>
 			window.location = "AdvertiseFinishModify.jsp?AdvertiseId=<%= advertiseId %>&x=" + Math.random() ;
	</script>		
  <%
  		}
  %>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      <TD WIDTH="17%"> 
        <div align="center">实际单价</div>
      </TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <input type="text" name="ActualUnit" size="10"  >
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB"> 
        <div align="center">实际次数</div>
      </TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <input type="text" name="ActualTimes" size="10" >
      </TD>
    </TR>
    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB"> 
        <DIV ALIGN="CENTER">实际总价</DIV>
      </TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="ActualTotal" size="10"  >
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB"> 
        <DIV ALIGN="CENTER">来电次数</DIV>
      </TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="ComeTimes" size="10"  >
        </div>
      </TD>
    </TR>
    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB">接待人次</TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="CusCount" size="10"  value="<%=cusNum %>">
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB">落定单元</TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="SaleCount" size="10"  value="<%=roomNum %>">
        </div>
      </TD>
    </TR>
    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB">落定面积</TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="SaleArea" size="10"  value="<%=saleArea %>">
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB">落定金额</TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="SaleMoney" size="10" value="<%=salePrice %>" >
        </div>
      </TD>
    </TR>
  </TABLE>
  

  <table width="50%" border="0" align="center">
    <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
   <%String Cortrol=(String)session.getAttribute("popedomStr"); 
   if (Cortrol==null)Cortrol="";
   %>
    <%if (Cortrol.indexOf("A")>=0){ %>
    <td>
      <div align="center">
        
		<input type="button" name="Submit3" value="添加" onclick="return AddDo()">
      </div>
    </td>
	<%} %>
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="返回" onclick="window.close()">
      </div>
    </td>
  </tr>
</table>
</form>
<p> 
  <script>
  	// set color and save value ;	
		var itemNo = "" ;   // roomNo
		var isOut = 0 ;   //rent or sale out
		var lastObject ;
		
		function ChangeTrColor(element2, isOut2, idNo, inColor, outColor) {
			isOut = parseInt(isOut2) ;
			if (itemNo == "") 
				element2.bgColor = inColor ;
			else {
					
				lastObject.bgColor = outColor ;
				element2.bgColor = inColor ;
			}	
			itemNo = idNo ;
			lastObject = element2 ;
			
		}	
		
		top2 = (screen.availHeight - 500) / 2 ;
		left2 = (screen.width - 620) / 2  ;
		height2 = 480 ;
		width2 = 620 ;
		
		function AddDo() {
			//alert("add") ;
			
			form2 = document.forms[0] ;
			if (form2.ActualUnit.value != "")
				if (!isNumeric(form2.ActualUnit, "实际单价只能是数字"))
					return false ;
			if (form2.ActualTimes.value != "")
				if (!isInteger(form2.ActualTimes, "实际次数只能是整数"))
					return false ;
					
			if (form2.ActualTotal.value != "")
				if (!isNumeric(form2.ActualTotal, "实际总价只能是数字"))
					return false ;
			if (form2.ComeTimes.value != "")
				if (!isInteger(form2.ComeTimes, "来电次数只能是整数"))
					return false ;		
			if (form2.CusCount.value != "")
				if (!isInteger(form2.CusCount, "接待人次只能是整数"))
					return false ;		
			if (form2.SaleCount.value != "")
				if (!isInteger(form2.SaleCount, "落定单元只能是整数"))
					return false ;		
			if (form2.SaleArea.value != "")
				if (!isNumeric(form2.SaleArea, "落定面积只能是数字"))
					return false ;
			if (form2.SaleMoney.value != "")
				if (!isNumeric(form2.SaleMoney, "落定金额只能是数字"))
					return false ;						
			document.forms[0].action = "AdvertiseUpdate.jsp?AdvertiseId=<%= advertiseId %>&Operation=Finish&x=" + Math.random() ;
			document.forms[0].submit() ;
		}
  </script>
</p>
</BODY>
</HTML>
