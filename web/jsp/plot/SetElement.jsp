<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "费用设置" , 
                  "浏览"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>系数设定</title>

</head>
<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
   <%@ include file="../public_js/getByteOut.jsp"%>
<%!
	 public String ShowTax1(String sqlstr,String serialno) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  String state="";
      String section=serialno;
	  
	  int jjj=0;
	  int iLost=0;
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
	 ConnDatabase.SDatabase ViewBean2=new ConnDatabase.SDatabase();
	 ResultSet Rs = null;
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
	 FormatData.FormatData formatD1=new FormatData.FormatData();
		while (TaxRs.next()) {
		jjj++;
		iLost=jjj % 3;
		int id=TaxRs.getInt("id");
		String  TYPE = getbyte(TaxRs.getString("TYPE"));
	    String  TYPENAME = getbyte(TaxRs.getString("TYPENAME"));
		String  CODENO=TaxRs.getString("CODENO");
		String CODENAME=getbyte(TaxRs.getString("CODENAME"));
		float modulus=0;
		String sqls="select modulus from ModulesSet where type='"+TYPE+"' and CODENAME='"+CODENAME+"'";
        Rs = ViewBean2.executeQuery(sqls);
		if(Rs.next()){
		  modulus=Rs.getFloat("modulus");
		}

  if(iLost==1)str+="<tr align=left>";
  str+="<td><input type='hidden' name=room size='3' value="+CODENAME+">"+CODENAME+"<input type='text' name=see size='3' value="+modulus+">&nbsp;&nbsp;</td>"; 
  if(iLost==0)str+="</tr>";

}
 
 TaxRs.close();
 return str;
}
%>

<script language="javascript" src="../public_js/public.js">
</script>
<script>

function delTax(id) {
		if ( confirm("确实想删除该条记录?"))
			window.location = "saveTax.jsp?id=" + id;
	}
	
function editTax(id) {
			openwin("TaxPage.jsp?id=" + id+"&para1=edit",300,300,100,100);
	}
</script>
<%String section=request.getParameter("section");
  if(section==null)section="";%>
<body onload="setSelectMad(document.frm.section,'<%=section%>');">
 <form method="POST" name="frm" action="">
 <%@ include file="../public_js/CheckSection.jsp"%>
 <center>
 <font class=FontColor size=3><b>系数一览表</b></font>
   <table width=90%><tr height="16" bgcolor="#EAEAEA">
   <td align="center">
    代码：	<select name="section" onchange="document.frm.submit();" > 
   <option></option>
   
<%  
      String sql1="select distinct type,typename from code where type in('A','C','D','L','O','X')";	

	  ResultSet rs2=ViewBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("type");
	   sec=getbyte(rs2.getString("typename"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	   rs2.close();
	
     %> </select>
	<%if(!section.equals("")){%>
    <input type="button" name="adds" value="添加" onclick="getsel()"><%}%>
   </td></tr>
 </table>
 <%if(!section.equals("")){%>
   <table border="0" width="90%" CELLSPACING=1 CELLPADDING=3 ALIGN=center>
 <%out.print(ShowTax1("select * from code where type='"+section+"'",section)); %>

 
</table>
 <%}else{%>
  <table width=100%><tr height="3"><td></td></tr></table>  
<table border="0" width="90%" CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr  class=listtitle>
    <td width="30%"><font color=white> &nbsp; 代码</font></td>
    <td width="30%">
    &nbsp; <font color=white>代码值</font>
    
    </td>
	<td width="30%"><font color=white>系数</font></td>
  </tr>   
  <%String sql="SELECT DISTINCT B.TYPENAME, A.type, A.CODENAME, A.Modulus FROM ModulesSet A, Code B WHERE A.type = B.type ORDER BY A.type "; 		
	rs2=ViewBean.executeQuery(sql);	
	while(rs2.next()){
  %>
  <tr>
    <td  width="30%"><%=getbyte(rs2.getString("TYPENAME"))%></td>
    <td  width="30%"><%=getbyte(rs2.getString("CODENAME"))%>    
    </td>
	<td width="30%"><%=rs2.getFloat("Modulus")%></td>
  </tr>
  <%
	}
  %>
  </tr>

</table>
<%}%>
 </center>
<script>

function getsel() {
	var sNoAll="";
    var i=0;
    var j=0;
    for (i = 0; i < frm.elements.length; i++) {
	    if (frm.elements[i].type == "text" && (frm.elements[i].value=="0.0" || frm.elements[i].value=="" )) {
					
				j++ ;
			}	
		}
		if (j > 0) {
		  	alert("系数不能为空并且系数至少为1.0") ;
         //openwin("saveshui.jsp?sNoAll="+sNoAll+"&section=<%=section%>",300,300,100,100);
		} else {
		
		 document.frm.action="SetElementUpdate.jsp";
		 document.frm.submit();
		}	
}
</script>
  </form>
</body>

</html>
