<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%
String tid = request.getParameter("zhuradio");

ResultSet rs = aBean.executeQuery( "select mailtoobj from cortrolman where id =" + tid);
String mailtoobjs = "0";
if( rs.next() ) {
	mailtoobjs = rs.getString(1);
}
if (mailtoobjs.equals(""))mailtoobjs = "0";
rs.close();

%>


<html>
<head>
    <LINK href="../class/news.css" rel=stylesheet>
	<title>
	  �ʼ����ն�������
	</title>
	
<script lang=javascript>
function zy_add_a()
{
	var rightHaveSe = false;
	 
    for (var i22 = 0; i22 < document.forms[0].s2.length; i22++) {
    	 document.forms[0].s2[i22].selected=true ;
		 
	}
	 
	   document.forms[0].action_flag.value="add";
 
	document.f1.action="mailobjadd_i_a.jsp?tid=" + <%= tid%>;
	document.f1.submit();
}

function cancle()
{
	document.location.href="zhuyuang.jsp";
}

function goRight()
{	
	if( document.forms[0].s1.length == 0 ) {
		alert("��߿�ѡ��Ա�Ѿ�ȫ����ѡ��!");
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
		alert("������߿�ѡ��Ա��ѡ��һ����Ա!");
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
						alert( tempop.text + " �Ѿ�ѡ����!" );
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

function goLeft()
{
	if( document.forms[0].s2.length == 0 ) {
		alert("�ұ���ѡ���Ա�Ѿ�ȫ������!");
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
		alert("�����ұ���ѡ���Ա��ѡ��һ����Ա!");
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
						alert( tempop.text + " �Ѿ���������!" );
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
<form name=f1 method=post>
<input type="Hidden" name="action_flag" value="">
 

 <table border=0 width=100% cellpadding=1 cellspacing=1 class=roomright>
   <tr>
    <td align=right>
	  ���³�Ա�ɹ�ѡ��:
    </td>	
	<td>
	 &nbsp;
	</td>
    <td>
	  ���³�Ա�ѱ�ѡ��:	
	</td>
   </tr>
   
   <tr>
    <td align=right valign=middle >
	<%
	String sql = "select id ,name from cortrolman"
				 + " where "
				 + " id not in"
				 + " ("+mailtoobjs+")" ;
	ResultSet rss = aBean.executeQuery(sql);
 
	%>
	 <select name=s1 multiple style="width:160;height=200" >
	 <%
	 while( rss.next() ) {
	 %>
	 	<option value=<%= rss.getInt("id") %> >
		 <%= getbyte(rss.getString("name"))%>
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
	    <input type=button name=b1 value="ѡ�� >>" onclick="goRight();" >
	   </td>	   
	  </tr>
	  <tr>
	   <td>
	    <input type=button name=b1 value="<< ����" onclick="goLeft();">
	   </td>
	  </tr>
	 </table>
	</td>
	
	<td align=left valign=middle>
	 <select name=s2 multiple  style="width:160;height=200" >
	 <%
	sql = "select id ,name from cortrolman"
				 + " where "
				 + " id  in"
				 + " ( "+mailtoobjs+")" ;
	 rss = aBean.executeQuery(sql);
	%>
	<%
	 while( rss.next() ) {
	 %>
	 	<option value=<%= rss.getInt(1) %> >
		 <%= getbyte(rss.getString(2))%>
		</option>
	 <%
	 }
	 rss.close();
	 %>
	 </select>	
	</td>
   </tr>  
 </table>
 
 <p align=center>
     <input type=button value="�� ��"  onclick="zy_add_a()">
     <input type=button value="�� ��" onclick="window.close()">
 <p>
 
 
</form>
</body>
</html>

