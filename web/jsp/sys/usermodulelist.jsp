<%@ page import="java.sql.*,java.util.*" %>

<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<title>Ȩ�޲鿴</title>
</head>  
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>
<body  oncontextmenu="return false">
<form name="f1" method="post" >

<%
 String UserId = (String)session.getAttribute( "loginid" );
 String SerialNo = request.getParameter( "SerialNo" ); 
 String zid = request.getParameter( "zid" ) ; 
 boolean isZhu = true ;
 if( zid == null ) {
    isZhu = false ;
 }   
 String id = "-1" ; 
 String zname = request.getParameter("zname") ;
 if( isZhu ) {
    id = zid ;
    
    //����ˢ��ҳ������Ĳ��� zid , zname 
    session.setAttribute( "zid" , zid );
    session.setAttribute( "zname" , zname );    
 }else{
    id = SerialNo ; 
    
    //����ˢ��ҳ������Ĳ��� SerialNo
    session.setAttribute( "SerialNo" , SerialNo );
 }
 
 //����ˢ��ҳ������Ĳ��� isZhu
 session.setAttribute( "isZhu" , new Boolean( isZhu ) );
%>

<p align=center class=FontColor>
 <font size=3>
  <b>
  <% if( isZhu ) {%>
    "<%= zname%>"����ӵ�е�Ȩ��
  <%}else{%>
    "<%= id %>"�û���ӵ�е�Ȩ��
  <%}%>
  </b>
 </font>
</p>

<table width=100% border="0">
  <tr height="16" bgcolor="#EAEAEA">
   <td align="left">    
    <a href="javascript:quanEdit()">
     <img src="../picture/button_xg.gif" border=0>
    </a>
    <a href="javascript:quan_de_a()">
    <img src="../picture/button_sc.gif" border=0>    
    </a>
   </td>
  </tr>
 </table>

<table border=0 width=100% align=center  cellspacing=1 cellpadding=1 >
   <tr class=listtitle>
    <td align=center>
     <font color=white>
	  ѡ��/ȡ��
	 </font>
	</td>
	   
    <td align=center>
     <font color=white>
	  ӵ�е���ģ������
	 </font>
	</td>
	
	
	
    <td align=center>
     <font color=white>
	  ӵ�е���ģ������( ʹ��Ȩ��)
	 </font>
	</td>	

    <td align=center>
     <font color=white>
	  ���������
	 </font>
	</td>	
	
    <td align=center>
     <font color=white>
	  �ɲ�����¥��
	 </font>
	</td>
	
   </tr>

<%
int u = 0;
String slq_a = "select b.mmodulename , a.Cortrol , a.state , a.section , a.ManModule "
               + " from ManModuleCortrol a "
               + " left outer join vw_module b "
               + " on a.ManModule = b.mmoduleno "
               + " where a.SellerId = '" + id + "'"
               + " order by a.ManModule" ;              
ResultSet rs_a = aBean.executeQuery( slq_a );
while( rs_a.next() ) {
    String mName = rs_a.getString( 1 ) ;
    String control = rs_a.getString( 2 ) ;
    String state = rs_a.getString( 3 ) ;
    String section = rs_a.getString( 4 ) ;
    String mainModule = rs_a.getString( 5 ) ;

    String quanXian = "" ;
    if( control.indexOf("A") != -1 || control.indexOf("a") != -1 ){
        quanXian = "�����" + "<br>" ;
    }
    if( control.indexOf("E") != -1 || control.indexOf("e") != -1 ){
        quanXian = quanXian + "�ɱ༭" + "<br>" ;
    }    
    if( control.indexOf("F") != -1 || control.indexOf("f") != -1 ){
        quanXian = quanXian + "�ɲ���" + "<br>" ;
    }    
    if( control.indexOf("D") != -1 || control.indexOf("d") != -1 ){
        quanXian = quanXian + "��ɾ��" + "<br>" ;
    }
    
    String slq_b = "select b.cmodulename,a.checked " 
               + " from PopedomConrtrol a left join vw_sub_module b "
               + " on a.ModuleNo = b.cmoduleno "
               + " where "
               + " a.SellerId = '" + id + "' and" 
               + " a.ManModuleNo = '" + mainModule + "'" ;
    ResultSet rs_b = aBean1.executeQuery( slq_b ) ;
    String subName = "" ;
    while( rs_b.next() ) {
        String temp = getbyte( rs_b.getString( 1 ) ) ;
    	String temp1 = getbyte( rs_b.getString( 2 ) ) ;
		String qx="";
		if (temp1.indexOf("A")>=0)qx="����";
		if (temp1.indexOf("D")>=0)qx+="/ɾ��";
		if (temp1.indexOf("E")>=0)qx+="/�޸�";
		if (temp1.indexOf("F")>=0)qx+="/�鿴";
		if (temp.equals(""))qx="";
		else
        subName = subName + temp +"&nbsp;&nbsp;&nbsp;("+qx+ ")<br>" ;
    }
    rs_b.close() ;
    
    String shuXin = "" ;
    if( state.equals( "0" ) ) {
        shuXin = "˽��";
    }else{
        shuXin = "����";
    }    

    String sectionName = "" ;
    StringTokenizer st = new StringTokenizer( section , "/" ) ;
    while( st.hasMoreTokens() ) {
        String tem = st.nextToken() ;
        ResultSet rs_c =  aBean1.executeQuery(
                          "select name FROM crm_project where serialno='" + tem + "'" ) ;
        if( rs_c.next() ) {
            String temName = getbyte( rs_c.getString( 1 ) ) ;
            sectionName = sectionName + temName + "<br>" ;
        }
        rs_c.close() ;
    }
%>
    <tr class='listcontent'>
     <td><input type=checkbox name=ic<%= u%> value=<%= mainModule %> ></td>
     <td><%= getbyte( mName ) %></td>
    
     <td><%= subName %></td>
     <td><%= shuXin %></td>
     <td><%= sectionName%></td>
    </tr>
<%
    u ++ ;
}
rs_a.close() ;
%>
</table>
<input type=hidden name=rows value="<%= u %>" >
<p align="center">
 <input type=button name=b1 value=" �˳� " onclick="javascript:window.history.back(1)">
</p>

</form>
<script lang=javascript>
var id = "<%= id%>"
var win = null ;

function quanEdit()
{	
    var selectedNum = 0 ;
    <% 
	for( int i=0 ; i < u ; i++ ) {
	%>						
		if( document.forms[0].ic<%= i%>.checked ) {
			selectedNum ++ ;    			  				
		}
	<%
	}
	%>
	if( selectedNum < 1 || selectedNum > 1 ) {
	    alert( "��ѡ��Ҫ�޸�Ȩ�޵�ģ��!" ) ;
	    return ;
	}

   <% 
	for( int i=0 ; i < u ; i++ ) {
	%>						
		if( document.forms[0].ic<%= i%>.checked ) {
            if( win == null ) {
                window.open("quan_edit_i.jsp?mm=" + document.forms[0].ic<%= i%>.value + "&id=" + "<%= id%>","quan","height=400,width=420,left=150,top=80,resizable=yes,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no");
            }
        }
	<%
	}
	%>
}

function quan_de_a()
{
    var hasSelect = false;
	<% 
	if( u > 0 ) {
		for( int i=0 ; i < u ; i++ ){
	%>		
				
		if( document.forms[0].ic<%= i%>.checked ) {
			hasSelect = true;
		}
		<%
		}
		%>
		if( hasSelect ) {
			if( confirm( "��ȷ��ȡ����ѡģ���Ȩ����?" ) ){				
				document.forms[0].action = "quan_de_a.jsp?id=" + "<%= id%>" ;
				document.forms[0].submit();				
			}else{
				return;
			}
		}else{
			alert( "��ѡ��һ��ģ��!" );
			return;
	}
	<%}else{%>	
		alert("û��ģ�����ѡ��!");
	<%}%>
}
</script>
</body>
</html>
