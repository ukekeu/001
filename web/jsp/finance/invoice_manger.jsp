<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "������ϸ��" , 
                  "���"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>�Ϲ��б�</title>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
 <% 
String SectionS = setpopedom.getSectionlist(); //��Ȩʹ��¥�̱���  

java.util.Hashtable hs = setpopedom.getDic() ;
String sections = ( String ) hs.get( ( String )session.getAttribute( "m_menu" ) ) ; 
if (sections==null)out.close();//��Ȩ
java.util.StringTokenizer st = new java.util.StringTokenizer( sections , "/" ) ;
String s_sec = "" ;

while( st.hasMoreTokens() ) {
    String tem = "'" + st.nextToken() + "'" ;
    s_sec = s_sec + tem + "," ;
}
s_sec = s_sec + "''";

SectionS = s_sec ;


// String SectionS=(String)session.getAttribute("Section");	//��Ȩʹ��¥�̱���  //where SerialNo in ("+SectionS+")"+"
String defaultNo="";
String SecNo="";
try{
    defaultNo=(String)session.getAttribute("defaultNo");
}catch(Exception s){
}
if ( defaultNo == null ) {
    defaultNo="";//����û�δ����Ĭ��¥�̣�����ʾ�û�ѡ�л�����¥�̵�¥��
}
if (!defaultNo.equals(""))
{
    SectionS=defaultNo;
    SecNo=defaultNo;
}
String FindWhere="";
if ( !SecNo.equals("") ) { 
    FindWhere="  and section='"+SecNo+"'";
}else{
    FindWhere="  and section in("+SectionS+")";
}

%>
<%!
public String toEmpty( String str ) {
    if( str == null ) {
        str = "" ;
    }
    return str ;
}
%>

<% 

 
   String tmp=request.getParameter("pageno");

   String section2 = request.getParameter("SecNo");
   String choose = China.getParameter(request,"choose");//1��ʾ�Ϲ�,2��ʾ��ǩԼ	
   if (choose.equals(""))choose="1";
	if (section2 == null){
		section2 = "";}
	else{
	if (tmp==null){section2= new String(section2.getBytes("ISO8859_1"),"GBK");}	
    }
  String strRoomType = request.getParameter("fx");
   if (strRoomType==null){strRoomType="";}
   else if (tmp==null){strRoomType= new String(strRoomType.getBytes("ISO8859_1"),"GBK");
   }
     String strSecName = request.getParameter("SecName");
   if (strSecName==null){strSecName="";}
   strSecName= new String(strSecName.getBytes("ISO8859_1"),"GBK");
   
    String strLoft = request.getParameter("Loft");
   if (strLoft==null){strLoft="";}
   strLoft= new String(strLoft.getBytes("ISO8859_1"),"GBK");
   
   String strBuild = request.getParameter("Build");
   if (strBuild==null){strBuild="";}
   strBuild= new String(strBuild.getBytes("ISO8859_1"),"GBK");
   
   String strRoomNo = request.getParameter("RoomNo");
   if (strRoomNo==null){strRoomNo="";}
   else if (tmp==null){strRoomNo= new String(strRoomNo.getBytes("ISO8859_1"),"GBK");
   }
    String pay= request.getParameter("pay");
   if (pay==null){pay="";}
   else if (tmp==null){pay= new String(pay.getBytes("ISO8859_1"),"GBK");
   }
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SectionName") ; 
  String Region = China.getParameter(request,"Region") ; 

%>
<script>
	function loadForm() {
		setSelectMad(frm.SecNo,"<%= section2 %>");
		setSelectMad(frm.Loft,"<%= strLoft %>");
		setSelectMad(frm.pay,"<%= pay %>");
		setSelectMad(frm.fx,"<%= strRoomType %>");
		setSelectMad(frm.build,"<%= strBuild %>");
		
		frm.RoomNo.value="<%= strRoomNo %>";
		document.frm.Date1.value = "<%= stdate %>" ;
		document.frm.Date2.value = "<%= endate %>" ;
	}
	function submitf(){
	 	var href= "frm.jsp?print=print&section=" + document.frm.section.value+"&pay="+document.frm.pay.value;
		window.location = href;
		}
</script>
 <script>
 	function changeSection() {
		document.frm.SectionName.value = document.frm.SecNo.options[document.frm.SecNo.selectedIndex].text;
	}
 </script>
<%@ include file="../public_js/countpagenum.jsp"%>
 <% 
   String sql=""; 
   String Cortrol=(String)session.getAttribute("popedomStr"); 
 %>


<%@ include file="../public_js/Repalce.jsp"%>
<%!
 	String user;
	String type;
	boolean rg;
  %> <%
 
   //get session value
    String seller=(String)session.getAttribute("username");
	int totalnum=0;
    String condtion="";		
    String eof="false";
	String sqlWhere="";
    String start="";
    String find="";
     if (!section2.equals("")){
        find=section2;
        find=" and section='"+find+"'";
	 }
	
	 if (!(strRoomType.equals("")))	{
	  if (!(find.equals(""))){
	   find=find+" and roomtype='"+strRoomType+"'";
	  }else{find=" and roomtype='"+strRoomType+"'";}
	} 
	if (!(strLoft.equals("")))	{
	  if (!(find.equals(""))){
	   find=find+" and Loft='"+strLoft+"'";
	  }else{find=" and Loft='"+strLoft+"'";}
	}   
	if (!(strBuild.equals("")))	{
	  if (!(find.equals(""))){
	   find=find+" and building='"+strBuild+"'";
	  }else{find=" and building='"+strBuild+"'";}
	} 
	
	if (!(strRoomNo.equals("")))	{
	  if (!(find.equals(""))){
	   find=find+" and room_no like '%"+strRoomNo+"%'";
	  }else{find=" and room_no like '%"+strRoomNo+"%'";}
	}   
	if (!(pay.equals("")))	{
	  if (!(find.equals(""))){
	   find=find+" and payment like '%"+pay+"%'";
	  }else{  find=" and payment like '%"+pay+"%'";}
	}
	if (!stdate.equals("")&&endate.equals(""))	
	    stdate=" and convert(char(24),date,111)='"+stdate+"'";
	
	if (stdate.equals("")&&!endate.equals(""))	
	    stdate=" and convert(char(24),date,111)='"+endate+"'";
	
	if (!stdate.equals("")&&!endate.equals(""))	
	    stdate=" and convert(char(24),date,111)>='"+stdate+"' and convert(char(24),date,111)<='"+endate+"'";
	   
	java.text.DecimalFormat df2 = new java.text.DecimalFormat("#######.####"); 
    java.text.DecimalFormat df1 = new java.text.DecimalFormat("###,###,###.####"); 
    String PubPra=(String)session.getAttribute("job");	
    String user=(String)session.getAttribute("loginid");	
   if (PubPra.indexOf("Ա")<0)PubPra="1";
    String doWhat = getbyte( request.getParameter( "doWhat" ) ) ;
    String fanghou = getbyte( request.getParameter( "fanghou" ) ) ;
    String kehuxingming = getbyte( request.getParameter( "kehuxingming" ) ) ;
    String time1 = getbyte( request.getParameter( "time1" ) ) ;
    String time2 = getbyte( request.getParameter( "time2" ) ) ;
    String xiaoshouren = getbyte( request.getParameter( "xiaoshouren" ) ) ;    
    String youhui = getbyte( request.getParameter( "youhui" ) ) ;
	String rgno= getbyte( request.getParameter( "rgno" ) ) ;
    String htno= getbyte( request.getParameter( "htno" ) ) ;
    String findStr = "" ;
	
	
    if( doWhat.equals( "find" ) ) {
    //   findStr = findStr + " and serialno like '%' " ;
       if( ! fanghou.equals( "" ) ) {
            findStr = findStr + " and room_no = '" + fanghou + "' " ;
       }
       if( ! kehuxingming.equals( "" ) ) {
            findStr = findStr + " and signatory like '%" + kehuxingming + "%' " ;
       }
       if( ! time1.equals( "" ) ) {
            findStr = findStr + " and date >= '" + time1 + " 00:00:00" + "' " ;
       }
       if( ! time2.equals( "" ) ) {
            findStr = findStr + " and date <= '" + time2 + " 23:59:59" + "' " ;
       }
       if( ! xiaoshouren.equals( "" ) ) {
            findStr = findStr + " and seller like '%" + xiaoshouren + "%' " ;
       }
       if( ! youhui.equals( "" ) ) {
            findStr = findStr + " and youhui like '%" + youhui + "%' " ;
       }
	   if( !rgno.equals( "" ) ) {
            findStr = findStr + " and serialno ='" + rgno + "'" ;
       }
	    if( !htno.equals( "" ) ) {
            findStr = findStr + " and ContractNo ='" + htno + "'" ;
       }
    }
    String orderbytype=request.getParameter("orderbytype");
	String orderby=request.getParameter("orderby");
	String orderStr="";
	if(orderbytype==null)orderbytype="1";
	if(orderby==null)orderby="1";
    if(orderbytype.equals("1")){
	   orderStr = " order by loft,floors,room_no";
	}else {orderStr = " order by date ";}
	if(orderby.equals("0")){
	   orderStr = orderStr + " desc ";}
	
	
  //if (PubPra.equals("1")){
 
		sql="select Top "+pageSize+"  * from PrintReportContract where Code not in (Select top "+prenum +" code from PrintReportContract where   state= '"+choose+"' "+find+stdate+FindWhere +findStr +orderStr+")  and   state= '"+choose+"' "+find+stdate+FindWhere +findStr +orderStr;
		sqlcount="select count(*) as num from PrintReportContract where  state= '"+choose+"'   " +find+stdate+FindWhere + findStr ;
		
	/*}	
	else{
        sql="select * from PrintReportContract where  state='"+choose+"' and seller='" + user + "'   "+find+FindWhere+stdate + findStr +orderStr;
		
   		//sqlWhere="select payment,count(*) as num,sum(salerprice) as salerprice,currency from Order_Contract where  section ='"+section2+"' and state= 1 and seller='" + user + "'  and  Code "+start+find+stdate+" group by payment,currency ";
		if (find!=""){find=find;}
		sqlcount="select count(*) as num from PrintReportContract where state= '"+choose+"' and seller='" + user + "' " +FindWhere+find+stdate + findStr ;
	
   }*/
   

   //out.close();
   // ResultSet rs1=ViewBean.executeQuery(sqlWhere);
%>
<body onload="setSelectMad(document.frm.orderby,'<%=orderby %>');setSelectMad(document.frm.orderbytype,'<%=orderbytype %>');" >
<form action="rgsview.jsp" method="post" name="frm">
<input type=hidden name=SecNo value="<%=section2 %>">
<input type=hidden name=SecName value="<%=strSecName %>">
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
<input type=hidden name=fx value="<%=strRoomType %>">
<input type=hidden name=RoomNo value="<%=strRoomNo %>">
<input type=hidden name=Date1 value="<%=stdate %>">
<input type=hidden name=Date2 value="<%=endate %>">
<input type=hidden name=choose value="<%=choose %>">
<input type=hidden name=param  value=<%=request.getParameter("param") %>>
<p align=center class=FontColor><font size=3><b><%if (!strSecName.equals(strLoft)){out.print(strSecName);} %><%=strLoft %>������ϸ </b></font></p>

<%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	   %>
<table width="610" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('rgsview.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�Ϲ���ϸ</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('rgsview.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>ǩԼ��ϸ</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/RoomView3.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�ٶ���ϸ</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/RoomView2.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>Ԥ����ϸ</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;document.frm.submit();"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�˷���ϸ</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/ChangeList.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>������ϸ</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/RoomView1.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>δ����ϸ</font></a>
	</td>
   </tr>
<input type=hidden name=sel value="<%=sel%>">
 </table>
<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
<table bgcolor="#EAEAEA" width="160%">
 <tr bgcolor="#EAEAEA">
   <td>
     <input type=hidden name="doWhat" value="find" >
	<%if(!strLoft.equals("")){ %>
    ����:<input type=text name=fanghou size=5 value="<%//= fanghou %>" >
	<%} else{%>
	<input type=hidden name=fanghou size=5 value="" >
	<%} %>
    �ͻ�����:<input type=text name=kehuxingming size=10 value="<%//= kehuxingming%>" >
    ʱ���: ��<input type=input name=time1 size=10 readonly value="<%//= time1%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">��<input type=input name=time2 size=10 readonly value="<%//= time2%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;"><br>
    ����Ա:<input type=text name=xiaoshouren size=10 value="<%//= xiaoshouren %>" >
<%if (choose.equals("1")){%>
    �Ϲ����:<input type=text name=rgno size=10>
<%}else %>	
   ��ͬ���:<input type=text name=htno size=10>
     <%/*
	    String StrSql="select type,codename from CODE where type='S' order by type";
     ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   out.print("<option></option>");
		   while (codeRS.next()){
			 out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
*/				%>

    <input type=button value="��ѯ" onclick="doSearch()" >
	 ����:<select name="orderbytype"  onchange="javascript:document.forms[0].submit();">
    
	 <option value=1>���������</option>
     <option value=0>���Ϲ�����</option>
	 </select>
	 <select name="orderby" onchange="javascript:document.forms[0].submit();">
     
	 <option value=1>����</option>
     <option value=0>����</option>
	 </select>
  </td>
 </tr>
</table>

<script>
    setSelectMad(document.forms[0].orderbytype,'<%=orderbytype %>');
    setSelectMad(document.forms[0].orderby,'<%=orderby%>');

</script>
<table BORDER=0 width="160%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
<td  align="right">���</td>
<td  align="center">

<%if (choose.equals("1")){%>
�Ϲ����
<%}else{ %>
��ͬ���
<%} %>
</td>

<td  align="center">�ͻ�����</td>
<td  align="center">��ϵ�绰</td>
<td  align="center">�������</td>
<td  align="center">����</td>
<td align="center">���</td>
<!--<td  align="center">�������</td>-->
<td  align="center">�ɽ��ܼ�</td>
<!--<td  align="center">�ۿ�</td>-->
<td w align="center">���ʽ</td>

<td  align="center">�Ϲ�����</td>
<td w align="center">�����Ż�</td>
 <td  align="center">��  ע</td>
	<%
	ResultSet rs=null;
	try{
		
	rs=ViewBean.executeQuery(sql);
	 
	//��������ֵ�ı���
    String SerialNo="";
	String ContractNo="";
    String section="";
    String building="";
    String Room_no="";
    String area="";
    String area1="";
    String Customer="";
    String payment="";
    String buildtype="";
    String roomtype="";
	String salerprice;
    String ysumprice="";
	String date="";
	String cusno="";
	String secno="";
	String currency="";
	String sale=request.getParameter("sale");
	String subscription="";
	String disc="";
	String phone="";
	String Note="";
	String loft="";
    String shouYouHui = "" ;
	String youhuidisc="";
	String youhuibak="";
	int i=0;
	//out.print("size" + rs.getFetchSize());
   while (rs.next()&& i<pageSize){
	 eof="true";
     i=i+1;
   //��FIELDS˳��һGET��VALUE
     if (i==pageSize){
       startnum=rs.getInt("Code");
	  } 
	  
     SerialNo=rs.getString("SerialNo");
     Customer=getbyte(rs.getString("signatory"));
	  
     secno=getbyte(rs.getString("section"));
	 loft=getbyte(rs.getString("loft"));
     building=getbyte(rs.getString("building"));
	 
     Room_no=rs.getString("Room_no");

	 area=df2.format(rs.getFloat("area"));
	 area1=df2.format(rs.getFloat("jzarea"));
	 payment=getbyte(rs.getString("payment"));
	 if (payment.indexOf("��")>0)payment=payment.substring(0,payment.indexOf("��")+1);
	 buildtype=getbyte(rs.getString("buildtype"));
	 roomtype=getbyte(rs.getString("roomtype")); 
     ysumprice=df1.format(rs.getFloat("ysumprice"));
	 salerprice=df1.format(rs.getFloat("salerprice"));
	 seller=getbyte(rs.getString("Seller"));

     //Fomrat date 
	 date=rs.getString("date");
	 String rgdate=date.substring(0,date.indexOf(" "));
     java.text.SimpleDateFormat needdate =null;
     needdate=new java.text.SimpleDateFormat("yyyy-mm-dd");
	 date=needdate.format(needdate.parse(date));
	 cusno=rs.getString("cusno");
	 section=getbyte(rs.getString("Name"));  
	 subscription=rs.getString("subscription");
	 currency=getbyte(rs.getString("currency"));
	 disc=getbyte(rs.getString("disc"));	
	 Note=getbyte(rs.getString("Note")); 
	 phone=getbyte(rs.getString("Phone"));
     ContractNo=getbyte(rs.getString("ContractNo"));

     shouYouHui=getbyte(rs.getString("youhui"));
	 strSecName=getbyte(rs.getString("sectionname"));
	 youhuidisc=getbyte(rs.getString("ewdisc"));
	  youhuibak=getbyte(rs.getString("youhuibeizhu"));
	 
  %>
 <tr id=TR<%=i %> align="center" class=listcontent onmouseover="mout(this) ;" Onclick="savepara('<%=SerialNo%>','<%=secno%>','<%=building%>','<%=Room_no%>','<%=cusno%>','<%=section %>','<%=Customer %>','<%=date%>','<%=payment%>','<%=ysumprice%>','<%=seller%>','<%=subscription %>');changeclass1(this,'clickbg','listcontent');"  > 
<td   align="center"><%=i %></td>
<td  align="left">&nbsp;

<%if (choose.equals("1")){
out.print(SerialNo.trim());
}else{
out.print(ContractNo.trim());
} %>
</td>
<td   align="left">&nbsp;<a href="#" onclick="openwin('showContract.jsp?secno=<%=secno %>&roomno=<%=Room_no %>&build=&loft=<%=loft %>','')"><%out.print(Repalce(Customer,"/"));%></a>��</td>
<td  align="left">&nbsp;<%=Repalce(phone.trim(),"/").trim() %>&nbsp;</td>

<td   align="center">&nbsp;<%if (!strSecName.equals(loft)){out.print(strSecName);} %><%=loft+building+Room_no %>��</td>
<td  align="left">&nbsp;<%=roomtype%>��</td>
<td    align="right">&nbsp;<%=area1 %>��</td>
<!--<td align="center"><%//=area %>��</td>-->
<td   align="right">&nbsp;<%if (!PubPra.equals("1")){out.print(currency); out.print(salerprice );}%></td>
<!--<td  align="right">&nbsp;<%=disc %></td>-->
<td  align="left">&nbsp;<a href="#" onclick="openwin('ShowPayView1.jsp?cusno=<%=cusno %>',400,300,200,50)"><%=payment %></a></td>
<td  align="left"&nbsp;><%=date %>��</td>
<td  align="left"&nbsp;><%=youhuidisc%>��</td>

<td  align="left"&nbsp;><%=youhuibak %>��</td>

 

</tr> 
 <%
 }
rs.close();
  out.print("</table>");

}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
 
 %> </table>
   <%@ include file="../public_js/changepage1.jsp"%>
 
 <script language="javascript">
  
   function Delconfirm(rgsno,section,build,room,cusno){
      if  (confirm("�Ƿ�ȷ��ɾ����ǰ���ϣ�")){
         window.location="delete.jsp?rgsno="+rgsno+"&section="+section+"&build="+build+"&room="+room+"&cusno="+cusno;
    	}
    }	
	var rgsno="";
	var secno="";
	var build="";
	var room="";
	var cusno="";
	var pay="";
	var roomtype="";
	var buildtype="";
	var secname="";
	var cusname="";
	var datestr="";
	var ysumprice="";
	var seller="";
	var subscription="";
	function EditInfo(){
	 if (confirm("���Ҫ�޸ĵ�ǰ���Ϲ�����")){
	  if (rgsno==""){alert("��ѡ�����Ϲ���");}
		else{
         window.location="rgedit.jsp?rgsno="+rgsno+"&secno="+secno+"&build="+build+"&room="+room+"&cusno="+cusno;
    	}
	 }	
	}	
	function HF(){
	if (confirm("���Ҫ�Ե�ǰ���Ϲ�����л�����")){
   	  if (rgsno==""){alert("��ѡ�����Ϲ���");}
		else{
	    window.location="ChangeRoomConfirm.jsp?orderno="+rgsno+"&secno="+secno+"&build="+build+"&room="+room+"&cusno="+cusno+"&name="+secname+"&cusname="+cusname+"&paracon=sale"+"&date="+datestr;
	  }
	 } 
	}
	function QY(){
	    if (rgsno==""){alert("��ѡ�����Ϲ���");}
		else{
	 	 window.location="Insale.jsp?rgno="+rgsno+"&secno="+secno+"&build="+build+"&room="+room+"&cusno="+cusno+"&secname="+secname+"&cusname="+cusname+"&pay="+pay+"&ysumprice="+ysumprice;
        }
	}
	function TD(){
	if (confirm("���Ҫ̢����ǰ���Ϲ�����")){
	  if (rgsno==""){alert("��ѡ�����Ϲ���");}
		else{
	 	window.location="CancelDetail.jsp?CancelPara="+rgsno+"*"+cusno+"*"+secname+"*"+build+"*"+room+"*"+datestr+"*"+seller+"*"+secno+"*"+subscription;
		}
   }
	}
	function OutPrint(){
	 	openwin("OutPrintPage.jsp?choose=<%=choose %>&SecNo=<%=section2%>&Loft=<%=strLoft %>&Build=<%=strBuild %>",350,258,150,150);
	}
	function DelInfo(){
	if (confirm("���Ҫɾ����ǰ��ѡ��������")){
   	  if (rgsno==""){alert("��ѡ��");}
		else{
	    openwin("deleteordercontract.jsp?orderno="+rgsno,10,10,10,10);
	  }
	 } 
	}
	function GoPage(pageNo) {
		document.forms[0].pageno.value = pageNo ;
		document.forms[0].submit() ;
	}
	function savepara(ro,so,bu,rom,co,sname,cname,dstr,pa,ys,sel,subs){

	  rgsno=ro;
	  secno=so;
	  build=bu;
	  room=rom;
	  cusno=co;
	  secname=sname;
	  cusname=cname;
	  datestr=dstr;
	  pay=pa;
	  ysumprice=ys;
	  seller=sel;
	  subscription=subs
	}
   	
    function doSearch()
    {
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
        
        var url = document.location.href
        if( url.indexOf( "?doWhat=" ) != -1 ) {
            url = url.substring( 0 , url.indexOf( "?doWhat=" ) )
        }
        //document.location.href = url + url2
        document.forms[ 0 ].action = "rgsview.jsp"
        document.forms[ 0 ].submit() ;
    }
</script> 
 
</body>
 
</html>
