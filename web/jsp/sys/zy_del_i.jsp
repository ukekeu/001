<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>

<%
String tid = request.getParameter("zhuradio");
ResultSet rs = aBean.executeQuery( "select tname from team where tid =" + tid);
String tname = "";
if( rs.next() ) {
	tname = rs.getString(1);
}
rs.close();
%>


<html>
<head>
    <LINK href="../class/news.css" rel=stylesheet>
	<title>
	  组员删除
	</title>
	
<script lang=javascript>
function zy_del_a()
{
	var rightHaveSe = false;
	for (var i22 = 0; i22 < document.forms[0].s2.length; i22++) {
    	if ( document.forms[0].s2[i22].selected ) {
			rightHaveSe = true;
			break;
		}
	}	
	if( !rightHaveSe ){
		alert("已选择成员栏不能为空!");
		return;
	}

	document.f1.action="zy_del_a.jsp?tid=" + <%= tid%>;
	document.f1.submit();
}

function cancle()
{
	document.location.href="zhuyuang.jsp";
}

function goRight()
{	
	if( document.forms[0].s1.length == 0 ) {
		alert("左边可选成员已经全部被选择!");
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
		alert("请在左边可选成员栏选择一个成员!");
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
			if( document.forms[0].s2.length > 0 ) {
		    for(var c2 = 0 ; c2 < document.forms[0].s2.length ; c2++ ) {		
			document.forms[0].s2.options[c2].selected = true;
		}
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

function goLeft()
{
	if( document.forms[0].s2.length == 0 ) {
		alert("右边已选择成员已经全部移走!");
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
		alert("请在右边已选择成员栏选择一个成员!");
		return;
	}
	
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
	
	if( document.forms[0].s1.length > 0 ) {
		for(var j2 = 0 ; j2 < document.forms[0].s1.length ; j2++ ) {
			for( var j1 = 0 ; j1 < document.forms[0].s2.length ; j1++ ) {
				var s2val = document.forms[0].s1.options[j2].value;
				var s1val = document.forms[0].s2.options[j1].value;
				if( s2val == s1val ) {
					document.forms[0].s2.options[j1] = null;
					continue;
				}
			}
		}
	}
}
</script>

</head>
<body  oncontextmenu="return false">
 <p align=center class=FontColor>
  <font size=3>
   <b>
    "<%= getbyte( tname )%>" 组删除成员
   </b>
  </font>
 </p>

<form name=f1 method=post>
 <table border=0 width=100% align=center cellpadding=1 cellspacing=1 class=roomright>
      
   <tr>
    <td align=right>
	  如下成员可供选择:
    </td>	
	<td>
	 &nbsp;
	</td>
    <td>
	  如下成员已被选择:	
	</td>
   </tr>
   
   <tr>
    <td align=right valign=middle>
	<%	
	String sql = "select teaman.mid , cortrolman.serialno"
				 + " from teaman "
				 + " left join cortrolman "
				 + " on teaman.mid = cortrolman.id "
				 + " where tid = " + tid; 
	ResultSet rss = aBean.executeQuery(sql);
	%>
	 <select name=s1 multiple style="width:160;height=200" >
	 <%
	 while( rss.next() ) {
	 %>
	 	<option value=<%= rss.getInt(1) %> >
		 <%= rss.getString(2)%>
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
	
	<td align=left>
	 <select name=s2 multiple  style="width:160;height=200" >
	 </select>	
	</td>
   </tr>
 
 </table>
 
 <p align=center>
  <input type=button value="    删除    "  onclick="zy_del_a()">	
  <input type=button value="    取消    " onclick="cancle()">	
 </p>
 
</form>
</body>
</html>