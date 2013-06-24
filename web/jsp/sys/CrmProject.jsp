<%@ page import = "java.sql.*,java.util.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/CheckSection.jsp"%>
<%
String zid = getbyte1( request.getParameter("zid")) ;
String tname =getbyte1( request.getParameter( "zname" ) );

 String loginID=(String)session.getAttribute("loginid");
 
%>


<html>
<head>
    <LINK href="../class/news.css" rel=stylesheet>
	<title>
	  项目数据管理权限
	</title>
	
<script lang=javascript>
function lp_add_a()
{
	var rightHaveSe = false;
	for (var i22 = 0; i22 < document.forms[0].s2.length; i22++) {    	
			rightHaveSe = true;			
			break;		
	}	
	if( rightHaveSe ){
		
	for (var i22 = 0; i22 < document.forms[0].s2.length; i22++) {
    	 document.forms[0].s2[i22].selected=true ;
	}	}
	document.f1.action="CrmProject_ac.jsp?tid=<%= zid %>&tname=<%=tname %>" ;
	document.f1.submit();
}

function cancle()
{
	window.history.back(1);
}

function goRight()
{	
	if( document.forms[0].s1.length == 0 ) {
		alert("左边可选楼盘已经全部被选择!");
		return;	
	}
	
	var leftHaveSe = false;
	for (i0 = 0; i0 < document.forms[0].s1.length; i0++) {
    	if ( document.forms[0].s1[i0].selected ) {
			leftHaveSe = true;
			break;
		}
	}	
	if( !leftHaveSe ){
		alert("请在左边可选楼盘栏选择楼盘!");
		return;
	}
	
	if( document.forms[0].s2.length > 0 ) {
		for(var c2 = 0 ; c2 < document.forms[0].s2.length ; c2++ ) {		
			document.forms[0].s2.options[c2].selected = false;
		}
	}

	for (i = 0; i < document.forms[0].s1.length; i++) {
    	if ( document.forms[0].s1[i].selected ) {
			var x = document.forms[0].s1[i];
			var tempop = new Option();
			tempop.value = x.value;
			tempop.text = x.text;
			var s2len = document.forms[0].s2.length;
			var s2Have = false;
			if( s2len >= 0 ) {
				for(var lo2 = 0 ; lo2 < document.forms[0].s2.length ; lo2++ ) {
					if( document.forms[0].s2.options[lo2].value == tempop.value ) {
						alert( tempop.text + " 已经选择了!" );
						s2Have = true;
						break;						
					}
				}				
			}
			if( !s2Have ) {
				var lastIn = document.forms[0].s2.length;
				document.forms[0].s2.options[lastIn] = tempop;	
				document.forms[0].s2.options[lastIn].selected = true;
			}
		}
	}
	
	if( document.forms[0].s2.length > 0 ) {
		for(var j2 = 0 ; j2 < document.forms[0].s2.length ; j2++ ) {
			for( var j1 = 0 ; j1 < document.forms[0].s1.length ; j1++ ) {
				var s2val = document.forms[0].s2.options[j2].value;
				var s1val = document.forms[0].s1.options[j1].value;
				if( s2val == s1val ) {
					document.forms[0].s1.options[j1] = null;
					continue;
				}
			}
		}
	}		
}
function getseldocs() {
     var x=0;
	 var seldocs = new Array();
	 for (i=0;i<document.forms[0].s2.length;i++) {
       if (document.forms[0].s2[i].selected)
		 {  seldocs[x]=document.forms[0].s2[i].value;
			x++;
   		 }
	  }	
   return seldocs;
}
function goLeft()
{
	if( document.forms[0].s2.length == 0 ) {
		alert("右边已选择楼盘已经全部移走!");
		return;			
	}
	
	var rightHaveSe = false;
	for (var i22 = 0; i22 < document.forms[0].s2.length; i22++) {
    	if ( document.forms[0].s2[i22].selected ) {
			rightHaveSe = true;
			break;
		}
	}	
	if( !rightHaveSe ){
		alert("请在右边已选择栏选择楼盘!");
		return;
	}
	var ix=getseldocs();
	if( document.forms[0].s1.length > 0 ) {
		for(var c2 = 0 ; c2 < document.forms[0].s1.length ; c2++ ) {		
			document.forms[0].s1.options[c2].selected = false;
		}
	}

	for (i = 0; i < document.forms[0].s2.length; i++) {
    	if ( document.forms[0].s2[i].selected ) {
			var x = document.forms[0].s2[i];
			var tempop = new Option();
			tempop.value = x.value;
			tempop.text = x.text;
			var s2len = document.forms[0].s1.length;
			var s2Have = false;
					
			if( s2len >= 0 ) {
				for(var lo2 = 0 ; lo2 < document.forms[0].s1.length ; lo2++ ) {
					if( document.forms[0].s1.options[lo2].value == tempop.value ) {
						alert( tempop.text + " 已经被移走了!" );
						s2Have = true;
						break;						
					}
				}				
			}
			if( !s2Have ) {
				var lastIn = document.forms[0].s1.length;
				document.forms[0].s1.options[lastIn] = tempop;	
				document.forms[0].s1.options[lastIn].selected = true;
			}
		}
	}
	var seldocs = new Array();
	seldocs=getseldocs();
	if( document.forms[0].s1.length > 0 ) {
		for(var j2 = 0 ; j2 < document.forms[0].s2.length ; j2++ ) {
		   for( var j1 = 0 ; j1 < seldocs.length ; j1++ ) {
		    	//var s2val = document.forms[0].s1.options[j2].value;
				var s1val = document.forms[0].s2.options[j2].value;
				
				if( seldocs[j1] == s1val ) {
					document.forms[0].s2.options[j2] = null;
					continue;
				}
			}
		}
	}
}
</script>

</head>
<body oncontextmenu="return false" >
<form name=f1 method=post>

 <p align=center class=FontColor>
  <font size=3>
   <b>
    "<%= tname %>" 组/用户楼盘快速赋权
   </b>
  </font>
 </p>

 <table border=0 width=100% cellpadding=1 cellspacing=1 class=roomright>
   <tr>
    <td align=right>
	  如下楼盘可供选择:
    </td>	
	<td>
	 &nbsp;
	</td>
    <td>
	  如下楼盘已被选择:	
	</td>
   </tr>
  
   <tr>
    <td align=right valign=middle >
	<%
	String sql = "";
	 if (loginID.equals("admin"))
	  sql="select serialno , name from CRM_Project " ;
	 else
	  sql="select serialno , name from CRM_Project  "+FindWhere;
	ResultSet rss = aBean.executeQuery(sql);
 %>
	 <select name=s1 multiple style="width:160;height=200" >
	 <%
	 while( rss.next() ) {
	 %>
	 	<option value=<%= rss.getString(1) %> >
		 <%= getbyte( rss.getString(2) )%>
		</option>
	 <%
	 }
	 rss.close();
	 %>
	 </select>
	</td>
	
	<td align=center valign=middle>
	 <table>
	  <tr>
	   <td>
	    <input type=button name=b1 value="选择 >>" onclick="goRight();" >
	   </td>	   
	  </tr>
	  <tr>
	   <td>
	    <input type=button name=b1 value="<< 移走" onclick="goLeft();">
	   </td>
	  </tr>
	 </table>
	</td>
	
	<td align=left valign=middle>
	 <select name=s2 multiple  style="width:160;height=200" >
	 <%String sectemp="";
	 String sqls="select section from ManModuleCortrol where sellerid='"+zid+"'";
	 ResultSet rst = aBean.executeQuery(sqls);
	 if(rst.next()){
	   sectemp=rst.getString("section"); 
	 }
     StringTokenizer st = new StringTokenizer(sectemp,"/");
     int countTok = st.countTokens() ;
     String[] tmpArray=new String[countTok];
     int k=0;
     for (k=0;k<countTok;k++){
        tmpArray[k] = (String)st.nextElement();
     
	sql = "select serialno , name from CRM_Project where serialno = '"+tmpArray[k]+"'" ;
	rss = aBean.executeQuery(sql);
	%>
	 <%
	 if( rss.next() ) {
	 %>
	 	<option value=<%= rss.getString(1) %> >
		 <%= getbyte( rss.getString(2) )%>
		</option>
	 <%}
	 }
	 rss.close();
	 %>
	 </select>	
	</td>
   </tr>  
 </table>
 
 <p align=center>
     <input type=button value="确 定"  onclick="lp_add_a()">
     <input type=button value="退 出" onclick="window.close()">
 <p>
 
 
</form>
</body>
</html>
