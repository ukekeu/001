<html>
<head>
<title>�˷�һ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
<script language=javascript src="js/mad.js"> </script>

<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

  <%@ page contentType="text/html;charset=GBK" %>
   <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />

  <%@ include file="../public_js/getByteOut.jsp"%>
 
<%
    String doWhat = getbyte1( request.getParameter( "doWhat" ) ) ;
    String fanghou = getbyte1( request.getParameter( "fanghou" ) ) ;
    String kehuxingming = getbyte1( request.getParameter( "kehuxingming" ) ) ;
    String time1 = getbyte1( request.getParameter( "time1" ) ) ;
    String time2 = getbyte1( request.getParameter( "time2" ) ) ;
    String xiaoshouren = getbyte1( request.getParameter( "xiaoshouren" ) ) ;
    String findStr = "" ;
    if( doWhat.equals( "find" ) ) {
      // findStr = findStr + " and TFRecord.section like '%' " ;
	   findStr = findStr + "" ;
       if( ! fanghou.equals( "" ) ) {
            findStr = findStr + " and a.room_no = '" + fanghou.trim() + "' " ;
       }
       if( ! kehuxingming.equals( "" ) ) {
            findStr = findStr + " and TFRecord.person like '%" + kehuxingming + "%' " ;
       }
       if( ! time1.equals( "" ) ) {
            findStr = findStr + " and convert(char(10),a.td_date,120) >= '" + time1 + "' " ;
       }
       if( ! time2.equals( "" ) ) {
            findStr = findStr + " and convert(char(10),a.td_date,120)  <= '" + time2+ "' " ;
       }
       if( ! xiaoshouren.equals( "" ) ) {
            findStr = findStr + " and TFRecord.checker like '%" + xiaoshouren + "%' " ;
       }
    }

%>
   
<body  topmargin="1"  oncontextmenu="return false">
<form name="frm" method="post" action="tf_list1.jsp"> 
  <input type=hidden name=cusname value="">
 <input type=hidden name=secname value="">
 <%
	
	int hasRecord = 0;
	int id;
	String  SecNo=China.getParameter(request,"SecNo");
    String  SecName=China.getParameter(request,"SecName");
	 
	String  Loft=China.getParameter(request,"Loft");	

	//if(!Loft.equals(""))
     //	 findStr +=   "and TFRecord.Loft='"+Loft+"'";
	String  Build=China.getParameter(request,"Build");
	String section;
	String building;
	String Room_code;
	String CancelDate;
    String Note="";
	String person="";
	String checker="";
	String seller="";
	String subscription="";
	

%>  
   


<%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	 
 
	  %> 
  <table width="280" border="0" cellspacing="0" cellpadding="0" class="L2">   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('RoomCodeShow.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�����ͻ�</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('RoomCodeShowT.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>һ���˷��˿�</font></a>
	</td>
	 <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('tf_list1.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>����˷��˿�</font></a>
	</td>
	</tr></table>
<input type=hidden name=sel value="<%=sel%>">
  <input type=hidden name=SecNo value="<%=getbyte1(request.getParameter("SecNo"))  %>">
   <input type=hidden name=Loft value="<%=Loft %>">
<script>
function findSub(para){
	   document.frm.action=para;
	 
	   document.frm.submit();
	}
</script>
	  <p align="center" class=FontColor><font size=3><b> <%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft+Build %>�˶�����ϸ</font></b></p>
<table  width="100%">
 <tr >
   <td>
    <input type=hidden name="doWhat" value="find" >
    ����:<input type=text name=fanghou size=5 value="<%//= fanghou %>" >
     �˶�����: ��<input type=input name=time1 size=10 readonly value="<%//= time1%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">��<input type=input name=time2 size=10 readonly value="<%//= time2%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;"> 
    
    <input type=button value="��ѯ" onclick="doSearch()" >
  </td>
 </tr>
</table>


<table width="100%" border="0" CELLPADDING="1" CELLSPACING="1"> 
<tr class=listtitle align="center">
  <td >���</td>
 <td> �������</td>
 <td> �ͻ����� </td>
 <td> ������� </td>
  <td> �ܽ�� </td>
   <td> �Ϲ����� </td>
    <td>����Ա</td>
 <td> �˶����� </td>

 </tr> 
<%
	String changeStr = " select a.code,a.customer,a.sectionname+a.loft room,a.loft,a.room_no,a.jzarea,a.yong_tu,a.jzarea,a.rmbprice,a.date,a.td_date,b.cus_name,a.seller from order_contract a ,customer b where a.state=3 and a.customer=b.serialno and a.section+a.loft+a.room_no in (select section+loft+room_no from order_contract where section+loft='"+SecNo+Loft+"' and state=3 "+findStr +" group by section+loft+room_no HAVING count(*)>1) and a.section+a.loft='"+SecNo+Loft+"'"
	                
                      + " order by a.section,a.loft,a.room_no";
			 
    float jzarea=0;
	String secno="";
	String customer="";
	String cusname="";
	String order_code="";
   String sumprice="";

       ResultSet changeRS1 = null;
	try{
	changeRS1 = changeListBean.executeQuery(changeStr);	
	hasRecord = 0;
	int i=0;
	while (changeRS1.next()) {
		hasRecord = 1;
		 i++;
		 
		  

 %> <b>
 <tr id=TR<%=i %>  align="center"  class='listcontent' onclick="changeclass1(this,'clickbg','listcontent');"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');" title="˫�����������˿�Ǽ�"   ondblclick="openwin1('yingshi_t.jsp?contractno=<%=changeRS1.getString("code") %>&cusno=<%=changeRS1.getString("customer") %>&loft=<%=changeRS1.getString("room")  %>&ldroomcode=0&checkQX=',650,570,50,50);" >
   <td    ><%=i %></td>
 <td ><%=changeRS1.getString("room_no")%></td>
<td><%= changeRS1.getString("cus_name")%></td>
<td><%= changeRS1.getString("jzarea") %></td>
<td><%= changeRS1.getString("rmbprice") %></td>
<td><%= changeRS1.getString("date").substring(0,10) %></td> 

<td><%= changeRS1.getString("seller") %></td>
<td><%= changeRS1.getString("td_date").substring(0,10)%></td>
</tr>
</b> 
<%
  	}
	changeRS1.close();
	}catch(Exception e){out.print(e);}
  %>

</form>

<script lang=javascript>
    function doSearch()
    {/*
        var doWhat = document.forms[ 0 ].doWhat.value ;
        var fanghou = document.forms[ 0 ].fanghou.value ;
        var kehuxingming = document.forms[ 0 ].kehuxingming.value ;
        var time1 = document.forms[ 0 ].time1.value ;
        var time2 = document.forms[ 0 ].time2.value ;
        var xiaoshouren = document.forms[ 0 ].xiaoshouren.value ;

        var url2 = "?doWhat=" + doWhat
        url2 = url2 + "&fanghou=" + fanghou
        url2 = url2 + "&kehuxingming=" + kehuxingming
        url2 = url2 + "&time1=" + time1
        url2 = url2 + "&time2=" + time2
        url2 = url2 + "&xiaoshouren=" + xiaoshouren
         url2 = url2 + "&Loft=<%=Loft %>&SecNo=<%=SecNo %>" 
        var url = document.location.href
        if( url.indexOf( "?doWhat=" ) != -1 ) {
            url = url.substring( 0 , url.indexOf( "&doWhat=" ) )
        }
        document.location.href = url + url2
		*/
		document.frm.submit();
    }
</script>

</body>
</html>
