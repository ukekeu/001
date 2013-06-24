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
<%@ page language="java" import="java.sql.*, common.*" %> 
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
		String  Loft = getbyte(TaxRs.getString("Loft"));
		float modulus=0;
		String sqls="select modulus from ModulesSet2 where section='"+section+"' and Loft='"+Loft+"'";
        Rs = ViewBean2.executeQuery(sqls);
		if(Rs.next()){
		  modulus=Rs.getFloat("modulus");
		}

  if(iLost==1)str+="<tr align=left>";
  str+="<td><input type='hidden' name=room size='3' value="+Loft+">"+Loft+"<input type='text' name=see size='3' value="+modulus+">&nbsp;&nbsp;</td>"; 
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
<%String section=request.getParameter("SecNo");
  String SecName=request.getParameter("SecName");%>
<body >
 <form method="POST" name="frm" action="">
 <input type="hidden" name="section" value="<%=section%>">
 <%@ include file="../public_js/CheckSection.jsp"%>
 <center>
 <font class=FontColor size=3><b>楼栋系数</b></font>
   <table width=90%><tr height="16" bgcolor="#EAEAEA">
   <td align="center">
    物业名称：<%=SecName%>
    <input type="button" name="adds" value="添加" onclick="getsel()">
   </td></tr>
 </table>
   <table border="0" width="90%" CELLSPACING=1 CELLPADDING=3 ALIGN=center>
 <%out.print(ShowTax1("select id,Loft from LoftBuildCode where SecNo='"+section+"'",section)); %>

 
</table>

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
		
		 document.frm.action="SetElementUpdate2.jsp";
		 document.frm.submit();
		}	
}
</script>
  </form>
</body>

</html>
