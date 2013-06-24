<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>权限..</title>
</head>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="aBean2" scope="page" class="ConnDatabase.SDatabase" />
 
 
   <%@ include file="../public_js/getByteOut.jsp"%>
<body oncontextmenu="return false" >
<%!
	public String getParameter(javax.servlet.http.HttpServletRequest request,String para)
								throws Exception  {
		String temp = "";
		temp = request.getParameter(para);
		if (temp == null)
			temp = "";
		temp = new String(temp.getBytes("iso-8859-1"));
		return temp;	
	}
%>
<script language="javascript" src="../public_js/public.js"></script>
<%
 
 String Stype="";
 String Scodeno="";
 String Scodename="";
 String StrSql="";
 String strZhu = "select tid , tname  from team";
 StrSql=" select * from CortrolMan where id not in (select mid from teaman ) and  dj=0 order by  SerialNo";
 ResultSet rs=null;
 ResultSet rsZhu = null;
int i=0;
int n=0;
 %>
<center>
<table border=0 width=80% align=center  cellspacing=1 cellpadding=1 >
   <tr class=listtitle>
    <td width=20% align=center>
	 <font color=white>
	  组名或者用户名
	 </font>
	</td>	
	<td width=40% align=center colspan="2">
	  <font color=white>
	  所属部门
	 </font>
	</td>
	<td width=20% align=center colspan="2">
	  <font color=white>
	  操作
	 </font>
	</td>
	
   </tr>
  <%try{
  rsZhu = aBean.executeQuery ( strZhu );
  int zb = 0;
  while( rsZhu.next() ) {
  	int zid = rsZhu.getInt(1);
  	String zname = rsZhu.getString(2);
	%>
	<tr class='listcontent'>
	 <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   <%= getbyte( zname )%>
	 </td>
	 <td>	  
	  <a href="javascript:hasZY<%= zb%>()">设置权限</a>&nbsp;&nbsp;
	  </td>	 
	 <td>
	  <a href="javascript:loupan<%= zb%>()">楼盘权限</a>
	  </td>
	 
	  <script lang=javascript>
	  	function hasZY<%= zb%>( ) {
		    window.open('priv_user.jsp?zid=<%= zid%>&zname=<%=getbyte(zname) %>','','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500');
		    //alert('priv_user.jsp?zid=<%= zid%>&zname=<%=getbyte(zname) %>','','resizable=yes,scrollbars=yes,500,500');
			//document.location.href = "modulelist.jsp?zid=" + "<%= zid%>"			
		}
		
	  	function canLook<%= zb%>( ) {
			document.location.href = "usermodulelist.jsp?zid=" + "<%= zid%>" + "&zname=" + "<%= getbyte( zname )%>" ;			
		}		
		
	  	function loupan<%= zb%>( ) {
		    window.open('loupan_i.jsp?zid=<%= zid%>&zname=<%=getbyte(zname) %>','','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500');
			//document.location.href = "loupan_i.jsp?zid=" + "<%= zid%>" + "&zname=" + "<%= getbyte( zname )%>" ;
		}
	  </script>	  
	 </td>	 

	</tr>
	<%
	zb ++ ;
  }
  rsZhu.close(); 
  %>
  
  <%    
    rs=aBean.executeQuery(StrSql);
    while (rs.next()){
        i++;
	    n++;     
        int id=rs.getInt("id");
        String SerialNo=rs.getString("SerialNo");
        String Name=getbyte(rs.getString("Name"));
        String tel=getbyte(rs.getString("tel"));
		String dept=getbyte(rs.getString("dept"));
		String company=getbyte(rs.getString("company"));
        String job=getbyte(rs.getString("job"));
  %>  
 <tr  class='listcontent' align=center id=TR<%= i %> Onclick="Butcolo(this,'#EAECEC','#ffffff');savepara('<%= id %>')"">
    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <%= Name %>
    </td>
	 <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <%= company+" "+dept+" "+job %>
    </td>
	<td align=center>
	 <a href="#" onclick="javascript:window.open('priv_user.jsp?zid=<%=SerialNo%>&zname=<%=Name %>','','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500');">
	  模块权限
	 </a>
	 </td>
	<td align=center>
	 	 <a href="#" onclick="javascript:window.open('CrmProject.jsp?zid=<%=SerialNo%>&zname=<%=Name %>','','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500');">
	 楼盘权限</a>
   </td>
    </tr>
 
  <%}
 }catch(Exception s){out.println(s.getMessage());out.print(StrSql);}
  
  rs.close(); %>
  
</table>

</center>
<script>
var RSID="";
function savepara(id){
    RSID=id;
}
function delSeller(id) {
    if( id == "" ) {
        alert( "请选中一位操作员!" ) ;
        return false ;
    }
    if ( confirm("确实想删除该条记录?")) {
    	window.location = "savecortrolman.jsp?id=" + id;
    }
}
	
</script>

</body>

</html>

