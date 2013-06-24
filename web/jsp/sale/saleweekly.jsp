<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "广告管理" , 
                  "浏览"
                ) ;
%>

<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>

</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>


<%
	String section = China.getParameter(request, "Section") ;
	// out.print(section) ;
	if (!section.equals(""))
		session.setAttribute("Advertise-Section", section) ;
	
	section = (String) session.getAttribute("Advertise-Section") ;
	if (section == null)
		section = "" ;
	
%><script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("请输入栋号");
			return false;
		}	
	}
	


</script>
<script language="javascript" src="../public_js/public.js"></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<body onload="loadForm();">

 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<% 
String SectionS = setpopedom.getSectionlist(); //有权使用楼盘编码  

java.util.Hashtable hs = setpopedom.getDic() ;
String section2 = ( String ) hs.get( ( String )session.getAttribute( "m_menu" ) ) ; 
if (section2==null)out.close();//无权
java.util.StringTokenizer st = new java.util.StringTokenizer( section2 , "/" ) ;
String s_sec = "" ;

while( st.hasMoreTokens() ) {
    String tem = "'" + st.nextToken() + "'" ;
    s_sec = s_sec + tem + "," ;
}
s_sec = s_sec + "''";

SectionS = s_sec ;


// String SectionS=(String)session.getAttribute("Section");	//有权使用楼盘编码  //where SerialNo in ("+SectionS+")"+"
String defaultNo="";
String SecNo="";
String Date1 = China.getParameter(request, "Date1") ;
String Date2 = China.getParameter(request, "Date2") ;
try{
    defaultNo=(String)session.getAttribute("defaultNo");
}catch(Exception s){
}
if ( defaultNo == null ) {
    defaultNo="";//如何用户未设置默认楼盘，则显示用户选中或所有楼盘的楼栋
}
if (!defaultNo.equals(""))
{
    SectionS=defaultNo;
    SecNo=defaultNo;
}
String FindWhere="";
if ( !SecNo.equals("") ) { 
    FindWhere=" where SerialNo='"+SecNo+"'";
}else{
    FindWhere=" where SerialNo in("+SectionS+")";
}

%>

<form name="AdvList">
   <p align="center"><b><font size="3" color="#000080">销售周报列表</font></b></p>
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
  <TR > 
      <TD width="42%">
       
    </TD>
    </TR>
</TABLE>
	    <table width=100%><tr height="16" bgcolor="#EAEAEA"><td align="left">楼盘名称 <select name="Section">
<%
			String firstNo = "" ;
			
			String getStr = "select serialNo, name FROM crm_project where SerialNo in("+SectionS+")" ;
			ResultSet getRs = bBean.executeQuery(getStr) ;
			int i = 0 ;
			while (getRs.next()) {
				i++ ;
				String no = getRs.getString("serialNo") ;
				String name = getRs.getString("name") ;
				name = getbyte(name) ;
				if (i == 1)
					firstNo = no ;
				if (section.equals("")) {
					section = firstNo ;
					session.setAttribute("Advertise-Section", section) ;
				}		
		%>
			<option value="<%= no %>"><%= name %>
		<%
			}
			getRs.close() ;
		%>	
		<option value="All">
      </select>
	  总结日期<input size="10" name="Date1" value="<%=Date1 %>" readonly><input title="请选择开始日期" onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale">
	  到<input size="10" name="Date2" value="<%=Date2 %>" readonly><input title="请选择结束日期" onclick="fPopUpCalendarDlg(Date2);return false;" type="button" value=".." name="cale">
	  <input type="button" value="查  询" name="submit1" onclick="javascript:document.forms[0].submit();">
	  &nbsp;&nbsp;&nbsp;&nbsp;
	   <%String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"S006");
   if (Cortrol==null)Cortrol="";
   %>
    <%if (Cortrol.indexOf("A")>=0){ %>
	  <img src="../picture/icon_print.gif" href="#" onclick="Add();">
	<%} %>
	
		</td></tr></table>

<script>
	function loadForm() {
		setSelectMad(document.forms[0].Section, "<%= section %>") ;
	}
</script>
  <%
  		String sListName = "AdvertiseList" ;
		String sectionStr = "" ;
		String secname="";
		int id=0;
		if (!section.equals("") && !section.equals("All"))
			sectionStr = " and section = '" + section + "' " ;
		
		String sConditionStr = " from saleweekly " + 
							" where  section in("+SectionS+") " +
								sectionStr ;
		if(!Date1.equals(""))
		  sConditionStr+=" and date1>='"+Date1+"'";
		if(!Date2.equals(""))
		  sConditionStr+=" and date2<='"+Date2+"'";
		String sAmisStr = "select *  " + sConditionStr ;
				
		// out.print(sAmisStr) ;
        ResultSet rs = aBean.executeQuery(sAmisStr);
  %>
   
  <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=TXTColor>
      <TD WIDTH="7%"> 
        <DIV ALIGN="CENTER">楼盘名称</DIV>
      </TD>
      <TD WIDTH="15%"> 
        <DIV ALIGN="CENTER">总结日期</DIV>
      </TD>
      <TD WIDTH="18%"> 
        <DIV ALIGN="CENTER">代理公司</DIV>
      </TD>
      <TD WIDTH="11%"> 
        <DIV ALIGN="CENTER">项目经理</DIV>
      </TD>
      
    </TR>
	  <%String secno="";
	while (rs.next()) {	
		i++;
		id = rs.getInt("id") ;
		secno=rs.getString("section") ;
		String sqlsecno=" select name FROM crm_project where  serialno='"+secno+"'";
	    ResultSet secrs = bBean.executeQuery(sqlsecno);
	    if (secrs.next()){
	      secname=getbyte(secrs.getString("name"));
	    }
		
   %>
    <tr  id=TR<%=id %>  align="center" BGCOLOR="<%= id %>"  class='listcontent' onmouseover="mout(this);" onclick="changeclass1(this,'clickbg','listcontent');"   > 
      <TD WIDTH="7%"> 
        <DIV ALIGN="CENTER"><a href="#" onclick="javascript:window.open('salecountreopt3.jsp?id=<%=id %>','', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=50,left=50,width=600,height=800');"><%= secname %></DIV>
      </TD>
      <TD WIDTH="15%"> 
        <DIV ALIGN="CENTER">&nbsp;<%if(!rs.getString("date1").equals("")){out.print(rs.getString("date1").substring(0,10));} %>----<%if(!rs.getString("date2").equals("")){out.print(rs.getString("date2").substring(0,10));} %></DIV>
      </TD>
      <TD WIDTH="18%"> 
        <DIV ALIGN="CENTER"><%if(getbyte(rs.getString("agentcom")).equals("")){ %><a href="#" onclick="javascript:window.open('salecountreopt2.jsp?id=<%=id %>','', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=50,left=50,width=600,height=800');">发表建议</a> <%}else{ %><%= getbyte(rs.getString("agentcom")) %><%} %></DIV>
      </TD>
      <TD WIDTH="11%"> 
        <DIV ALIGN="CENTER"><%if(!getbyte(rs.getString("agentcom")).equals("")){ %><%if(getbyte(rs.getString("projectman")).equals("")){ %><a href="#" onclick="javascript:window.open('salecountreopt2.jsp?id=<%=id %>','', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=50,left=50,width=600,height=800');">发表建议</a> <%}else{ %><%= getbyte(rs.getString("projectman")) %><%}} %></DIV>
      </TD>
    
    </TR>
    <%
   	}
		
   %>
  </TABLE>
  </form>
  <script>
  
		
		function Add() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 500 ;
			width2 = 600 ;
			window.open("select1.jsp?&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
  </script>
</BODY>
</HTML>
