<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>
<script  src="../public_js/calendar.script"></script>
<script  src="../public_js/Popup.js"></script>     
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>
<%
	/*
      	String 	id2 = setpro.getId();
      	boolean service = setpro.getService();
      	if (id2 == null || id2.equals("")) {
      		out.print("请重新登录");
      		return ;
      	}
      	if (!service) {
      		out.print("你没有权限");
      		return ;
      	}
	*/	
  %>

<%
	String section = (String) session.getAttribute("Aj-Section") ;
	String building = (String) session.getAttribute("Aj-Building") ;
	String loft = (String) session.getAttribute("Aj-Loft") ;		
	String secNameS = (String) session.getAttribute("Aj-SectionName") ;
	
%><script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("请输入栋号");
			return false;
		}	
	}
	
function loadForm() {
	
	
		// setSelectMad(document.aform.Section,'<%=section%>');
		// document.aform.Building.value ='<%=building%>';
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
<p    align="center"  class=FontColor><b><font size="3">统计条件</font></b></p>
  <%
  		
		
  %>
 
  
  <table BORDER=0 width="50%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      <td width="17%" align="center" class=roomleft> 
        <div align="CENTER">销售阶段</div>
      </td>
      <td width="27%" class=roomright align="center"> 
        <div align="left"> 
          <input type="text" name="Phase" size="15"  >
        </div>
      </td>
      <%
	  	Timestamp ts = new Timestamp(System.currentTimeMillis()) ;
		String currentDate = ts.toString().substring(0, 10) ;
	  %>
    </tr>
	 <tr align="center" > 
      <td width="17%" class=roomleft>开始日期</td>
      <td width="27%" class=roomright> 
        <div align="left"> 
          <input type="text" name="BeginDate" size="10" onFocus=blur() >
          <input type=button name=Popu2 value=".." onClick="fPopUpCalendarDlg(BeginDate); " >
        </div>
      </td>
	  </tr><tr align="center">
      <td width="17%" class=roomleft>结束日期</td>
      <td width="27%" class=roomright> 
        <div align="left"> 
          <input type="text" name="FinishDate" size="10" onFocus=blur() >
          <input type=button name=Popu3 value=".." onClick="fPopUpCalendarDlg(FinishDate); " >
        </div>
      </td>
    </tr>
  </TABLE>
  

  <table width="50%" border="0" align="center">
    <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <div align="center">
        
		  <input type="button" name="Submit3" value="查 询" onclick="SearchFlow()">
      </div>
    </td>
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="返 回" onclick="history.back()">
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
		
		
		
		function SearchFlow() {
			document.forms[0].action = "AdvertiseTj2002S.jsp?x=" + Math.random() ;
			document.forms[0].submit() ;
		}
  </script>
</p>
</BODY>
</HTML>
