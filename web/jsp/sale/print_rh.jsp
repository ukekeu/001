<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
<link rel=stylesheet href="../class/mad.css" >
<title>入户管理</title>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
<%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
 <% 
  
 String defaultNo="";
String SecNo=request.getParameter("SecNo");
 
String FindWhere="";
if ( !SecNo.equals("") ) { 
    FindWhere="  and section='"+SecNo+"'";
 
}
   String tmp=request.getParameter("pageno");

   String section2 = request.getParameter("SecNo");
 
   String choose = China.getParameter(request,"choose");//1表示认购,2表示已签约	
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
    
    String strLoft = request.getParameter("Loft");
   
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
  
   
    
 
	 
%> 
 


<%@ include file="../public_js/Repalce.jsp"%>
<%!
 	String user;
	String type;
	boolean rg;
  %> 
  <%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	   %>
  <%
 
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
   if (PubPra.indexOf("员")<0)PubPra="1"; 
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
	
	
 
 
		sql="select   code,signatory,ID_Card,ContractNo,loft,building,";
		sql+="Room_no,payment1,sj,phone,rhzno,rhz_gx,rhz_person,rhz_date,ajbk from PrintReportContract where rh=1    and   state= 2 "+find+stdate+FindWhere +findStr +orderStr;
		sqlcount="select count(*) as num from PrintReportContract where   rh=1 and state= '"+sel+"'   " +find+stdate+FindWhere + findStr ;
 
%>
<body >
<form action="rh_view.jsp" method="post" name="frm">
 <DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>

  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
    <input type="button" onclick="bringToExcel()" value="导出到Excel"> 
	 <div valign=top id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
 <center>
 <p align="center"><font size=4><b><%=strSecName %>入户证明书领取登记表</b></font></p>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr > 
<td  align="right">序号</td>
<td  align="center">客户姓名</td>
<td  align="center">证件号码</td>
<td  align="center">房间代码</td>
<td  align="center">合同编号</td>
<td w align="center">付款方式</td>
<td  align="center">按揭银行</td>
<td  align="center">联系电话</td>
<td w align="center">入户证明书编码</td>

<td w align="center">领取入户<br>证明书签章</td>

<td w align="center">领取日期</td>

<td w align="center">代理人关系</td>
	<%
	int i=0;
	ResultSet rs=null;
	try{
		
	rs=ViewBean.executeQuery(sql);
	 
	//保存输入值的变量
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
	String floors="";
    String shouYouHui = "" ;
	String youhuidisc="";
	String youhuibak="";
	String code="";
	String rhzno="";
	String rhz_gx="";
	String rhz_person="";
	String rhz_date="";
 

   while (rs.next()){
	 eof="true";
     i=i+1;
      code=rs.getString("Code");
	 
     Customer=getbyte(rs.getString("signatory"));
	 String ID_Card=getbyte(rs.getString("ID_Card"));
	 ContractNo=getbyte(rs.getString("ContractNo"));
	 
	 loft=getbyte(rs.getString("loft"));
     building=getbyte(rs.getString("building"));
     Room_no=rs.getString("Room_no");
     payment=getbyte(rs.getString("payment1"));
     String  sj=getbyte(rs.getString("sj"));
     phone=getbyte(rs.getString("phone"));
	 rhzno=getbyte(rs.getString("rhzno"));
     rhz_gx=getbyte(rs.getString("rhz_gx"));
     rhz_person=getbyte(rs.getString("rhz_person"));
	  rhz_date=getbyte(rs.getString("rhz_date"));
	  String ajbk=getbyte(rs.getString("ajbk"));
	  if (!rhz_date.equals(""))rhz_date=rhz_date.substring(0,10);
	 
  %>
 <tr id=TR<%=i %> align="center" > 
<td   align="center"><%=i %></td>
<td   align="left">&nbsp; <%out.print(Repalce(Customer,"/"));%> </td>
<td  align="left"><%=" "+Repalce(ID_Card,"/")+" "%></td>
<td  align="left">&nbsp; <%=loft+Room_no%></td>
<td  align="left">&nbsp; <%=ContractNo%></td>
<td  align="left">&nbsp; <%=payment%></td>
<td  align="left">&nbsp; <%=ajbk%></td>
<td  align="left"><%=Repalce(phone.trim(),"/").trim()+"<br>"+Repalce(sj.trim(),"/").trim() %>&nbsp;</td>
 
   <td  align="left">&nbsp; <%=rhzno%></td>
   <td  align="left">&nbsp; <%=rhz_person%></td>
   <td  align="left">&nbsp; <%=rhz_date%></td>
   <td  align="left">&nbsp; <%=rhz_gx%></td>
 
</tr> 
 <%
 }
rs.close();
  out.print("</table>");

}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
 
 %> </table>
 
 </div>
 
<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
  </center> 
 
</body>
 
</html>
