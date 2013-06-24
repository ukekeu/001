<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>竞争项目登记</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
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
	setSelectMad(document.forms[0].Section, "<%= request.getParameter("section") %>") ;
	
		
	}

</script>
<script language="javascript" src="../public_js/public.js">

</script>

<body onload="loadForm();">

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
    <TD COLSPAN="2"  align="center" class=FontColor> 
        <font size=3><b>竞争项目登记</b></font>
    </TD>
  </TR>
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
</TABLE>
  
 
  
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      <TD WIDTH="17%"> 
        <DIV ALIGN="CENTER">参考项目</DIV>
      </TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
        	<select name="Section" onchange="ChangeSection()">
    <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<% 
String SectionS = setpopedom.getSectionlist(); //有权使用楼盘编码搂盘 		 
			String firstNo = "" ;
			String getStr = "select serialNo, name from CRM_Project where SerialNo in("+SectionS+")" ;
			ResultSet getRs = aBean.executeQuery(getStr) ;
			int i = 0 ;
			while (getRs.next()) {
				i++ ;
				String no = getRs.getString("serialNo") ;
				String name = getRs.getString("name") ;
				name = getbyte(name) ;
			 	
		%>
			<option value="<%= no %>"><%= name %>
		<%
			}
			getRs.close() ;
		%>	
		<option value="All">
      </select>
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB"> 
        <DIV ALIGN="CENTER">竞争项目名称</DIV>
      </TD>
     <td>    <input type="text" name="project"   ><font color=red>*</font></td>
		 
      
    </TR>
    
    <tr bgcolor="#CFE6EB"> 
      <TD WIDTH="17%"> 
        <div align="center">竞争发展商</div>
      </TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <input type="text" name="company"  ><font color=red>*</font>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB"> 
        <div align="center">投资商</div>
      </TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
   <input type="text" name="company1"  >
      </TD>
    </TR>
   
    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB"> 
        <DIV ALIGN="CENTER">总销售面积</DIV>
      </TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="area"   >M<sup>2</sup><font color=red>*</font>
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB"> 
        <DIV ALIGN="CENTER">销售均价</DIV>
      </TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="avg" size="10"  >元/M<sup>2</sup><font color=red>*</font>
        </div>
      </TD>
    </TR>
    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB">备注</TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2" colspan="3"> 
        <div align="left"> 
         <textarea cols="50" rows="3" name=bak ></textarea>
        </div>
      </TD>
     <input type=hidden name=operation value="Insert">
    </TR>
    
 
  </TABLE>
  

  <table width="50%" border="0" align="center">
    <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <div align="center">
        
		<input type="button" name="Submit3" value="提 交" onclick="return AddDo()">
      </div>
    </td>
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="返 回" onclick="window.close()">
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
		 
		 					
			document.forms[0].action = "JzProjectUpdate.jsp?x=" + Math.random() ;
			document.forms[0].submit() ;
		}
  </script>
</p>
</BODY>
</HTML>
