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
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
 <%  
 
  SecNo=getbyte1(request.getParameter("SecNo"));
    FindWhere="  and section='"+SecNo+"'";
 
   String tmp=request.getParameter("pageno");
   String choose = China.getParameter(request,"choose");//1表示认购,2表示已签约	
    
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
		setSelectMad(frm.SecNo,"<%= SecNo %>");
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
   
   String nnn=China.getParameter(request, "nn") ;
	if (!nnn.equals("")){
	    int max=Integer.parseInt(nnn) ;
	    for (int ii = 0; ii <max; ii++) {//依次入户资料
	       String rhzno = China.getParameter(request, "rhzno" + ii) ;
		   String rhz_gx = China.getParameter(request, "rhz_gx" + ii) ;
		   String rhz_person = China.getParameter(request, "rhz_person" + ii) ;
		   String rhz_date = China.getParameter(request, "rhz_date" + ii) ;
		   String order=China.getParameter(request, "ordercode" + ii) ;
	       if (!rhzno.equals("")){
		     String SQLMODI="UPDATE ORDER_CONTRACT SET rhzno='"+rhzno+"'";
		            SQLMODI+=",rhz_gx='"+rhz_gx+"', rhz_person='"+rhz_person+"'";
					SQLMODI+=",rhz_date='"+rhz_date+"' WHERE CODE="+order;
		           try{
				    ViewBean.executeUpdate(SQLMODI); 
					}catch(Exception s){out.print(s);}
		   }
	   }
	}
 
	 
%> 
 
 
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
    String doWhat = getbyte1( request.getParameter( "doWhat" ) ) ;
    String fanghou = getbyte1( request.getParameter( "fanghou" ) ) ;
    String kehuxingming = getbyte1( request.getParameter( "kehuxingming" ) ) ;
    String time1 = getbyte1( request.getParameter( "time1" ) ) ;
    String time2 = getbyte1( request.getParameter( "time2" ) ) ;
    String xiaoshouren = getbyte1( request.getParameter( "xiaoshouren" ) ) ;    
    String youhui = getbyte1( request.getParameter( "youhui" ) ) ;
	String rgno= getbyte1( request.getParameter( "rgno" ) ) ;
    String htno= getbyte1( request.getParameter( "htno" ) ) ;
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
		sql="select Top "+pageSize+"  floors,section,code,signatory,ID_Card,ContractNo,loft,building,";
		sql+="Room_no,payment1,sj,phone,rhzno,rhz_gx,rhz_person,rhz_date from PrintReportContract where rh=1 and Code not in (Select top "+prenum +" code from PrintReportContract where   rh=1 and state= 2 "+find+stdate+FindWhere +findStr +orderStr+")  and   state= 2 "+find+stdate+FindWhere +findStr +orderStr;
		sqlcount="select count(*) as num from PrintReportContract where   rh=1 and state= 2   " +find+stdate+FindWhere + findStr ;
	 
%>
<body topmargin="1">
<form action="rh_view.jsp" method="post" name="frm">
<input type=hidden name=SecNo value="<%=getbyte1(request.getParameter("SecNo")) %>">
<input type=hidden name=SecName value="<%=strSecName %>">
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
<input type=hidden name=fx value="<%=strRoomType %>">
<input type=hidden name=RoomNo value="<%=strRoomNo %>">
<input type=hidden name=Date1 value="<%=stdate %>">
<input type=hidden name=Date2 value="<%=endate %>">
<input type=hidden name=choose value="<%=choose %>">
<input type=hidden name=param  value=<%=request.getParameter("param") %>>



<table width="650" border="0" cellspacing="0" cellpadding="0" class="L2">
     
<tr>
    <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('jy_list.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>交易一览</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('ContractNoM.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同号管理</font></a>
	</td>
	
	  <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=5;findSub('contract_check.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同审核</font></a>
	</td>
	 <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('ContractJz.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>备案管理</font></a>
	</td>
	<!-- <td class="<%if(sel.equals("9")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=9;findSub('contract_yj.jsp');"><font color='<%if(sel.equals("9")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>移交管理</font></a>
	</td>
	-->
	<td class="<%if(sel.equals("6")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=6;findSub('rh_view.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>入户管理</font></a>
	</td>
	
  <!--
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('contract_view.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已审核合同</font></a>
	</td>
	-->
	
	
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('paymoneyProcess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>付款进度</font></a>
	</td>
	 
	 
	<td class="<%if(sel.equals("8")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=8;findSub('contract_wycl.jsp');"><font color='<%if(sel.equals("8")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>违约处理</font></a>
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
<p align=center class=FontColor><font size=3><b><%if (!strSecName.equals(strLoft)){out.print(strSecName);} %><%=strLoft %> </b></font></p>
<table  width="100%">
 <tr  ">
   <td>
     <input type=hidden name="doWhat" value="find" >
	<%if(!strLoft.equals("")){ %>
    房号:<input type=text name=fanghou size=5 value="<%//= fanghou %>" >
	<%} else{%>
	<input type=hidden name=fanghou size=5 value="" >
	<%} %>
    客户姓名:<input type=text name=kehuxingming size=10 value="<%//= kehuxingming%>" >
    时间段: 从<input type=input name=time1 size=10 readonly value="<%//= time1%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">到<input type=input name=time2 size=10 readonly value="<%//= time2%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;"><br>
    销售员:<input type=text name=xiaoshouren size=10 value="<%//= xiaoshouren %>" >
 
   合同编号:<input type=text name=htno size=10>
  

    <input type=button value="查询" onclick="document.forms[0].submit();" >
	 排序:<select name="orderbytype"  onchange="javascript:document.forms[0].submit();">
    
	 <option value=1>按房间代码</option>
     <option value=0>按认购日期</option>
	 </select>
	 <select name="orderby" onchange="javascript:document.forms[0].submit();">
     
	 <option value=1>升序</option>
     <option value=0>降序</option>
	 </select><input type="button" name="Button" value="打印预览" onclick="openwin1('print_rh.jsp?SecNo=<%=getbyte1(request.getParameter("SecNo")) %>&Loft=<%=strLoft %>&SecName=<%=strSecName %>',300,300,10,10);">
  </td>
 </tr>
</table>

<script>
    setSelectMad(document.forms[0].orderbytype,'<%=orderbytype %>');
    setSelectMad(document.forms[0].orderby,'<%=orderby%>');

</script>
 
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
<td  align="right">序号</td>
<td  align="center">客户姓名</td>
<td  align="center">证件号码</td>
<td  align="center">房间代码</td>
<td  align="center">合同编号</td>
<td w align="center">付款方式</td>
<td  align="center">联系电话</td>
<td w align="center">入户证明书编码</td>

<td w align="center">领取入户<br>证明书签章</td>

<td w align="center">领取日期</td>

<td w align="center">代理人关系</td>
</tr>
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
	    secno=rs.getString("section");
	    floors=rs.getString("Floors");
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
	  if (!rhz_date.equals(""))rhz_date=rhz_date.substring(0,10);
	 
  %>
 <tr id=TR<%=i %> align="center" class=listcontent onmouseover="mout(this) ;" Onclick="savepara('<%=SerialNo%>','<%=secno%>','<%=building%>','<%=Room_no%>','<%=cusno%>','<%=section %>','<%=Customer %>','<%=date%>','<%=payment%>','<%=ysumprice%>','<%=seller%>','<%=subscription %>');changeclass1(this,'clickbg','listcontent');"  > 
<td   align="center"><%=i %></td>
<td   align="left">&nbsp;<a href="#" onclick="openwin1('showContract.jsp?secno=<%=secno %>&roomno=<%=Room_no %>&build=&loft=<%=loft %>&Floor=<%=floors %>','',600,500,10,10)"><%out.print(Repalce(Customer,"/"));%></a>　</td>
<td  align="left">&nbsp; <%=Repalce(ID_Card,"/")%></td>
<td  align="left">&nbsp; <%=loft+Room_no%></td>
<td  align="left">&nbsp; <%=ContractNo%></td>
<td  align="left">&nbsp; <%=payment%></td>

<td  align="left"><%=Repalce(phone.trim(),"/").trim()+Repalce(sj.trim(),"/").trim() %>&nbsp;</td>
 <%//if (rhzno.equals("")){ %>
  <TD  height="16"> 
      <DIV ALIGN="left"><input type=text  value="<%=rhzno%>" name=rhzno<%=i %> class="unnamed1"  size=15   onkeydown=" key(document.frm.rhz_person<%=i %>);"></DIV>
    </TD>
 <TD  height="16"> 
      <DIV ALIGN="left"><input type=text value="<%=rhz_person%>" name=rhz_person<%=i %> class="unnamed1"  size=10   onkeydown=" key(document.frm.rhz_date<%=i %>);"></DIV>
    </TD>
	 <TD  height="16"> 
      <DIV ALIGN="left"><input type=text value="<%=rhz_date%>" name=rhz_date<%=i %> class="unnamed1"  size=10   onkeydown=" key(document.frm.rhz_gx<%=i %>);"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(rhz_date<%=i %>);return false;"></DIV>
    </TD>
	 <TD  height="16"> 
      <DIV ALIGN="left"><input type=text value="<%=rhz_gx%>" name=rhz_gx<%=i %> class="unnamed1"  size=10   onkeydown=" key(document.frm.rhzno<%=i+1 %>);"></DIV>
    </TD>
 <%//}else{ %>
 
   
 
 <%//} %>	
   <input type=hidden name=ordercode<%=i %> value="<%=code %>">

</tr> 
 <%
 }
rs.close();
  out.print("</table>");

}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
 
 %> </table>
 <input type=hidden name=nn value="<%=i %>">
   <%@ include file="../public_js/changepage2.jsp"%>
   <%   String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT022");
   
   %>
   <%if (Cortrol.indexOf("A")>=0){%>
  <input type=button name=modis value="更新登记"  onclick="modi();" >
  <%} %>
 <script language="javascript">
  function modi(){
		   if (confirm("确认登记的数据吗？"))
		  　document.frm.submit();
	     	
		}
   function Delconfirm(rgsno,section,build,room,cusno){
      if  (confirm("是否确认删除当前资料？")){
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
	 if (confirm("真的要修改当前的认购书吗？")){
	  if (rgsno==""){alert("请选择你认购书");}
		else{
         window.location="rgedit.jsp?rgsno="+rgsno+"&secno="+secno+"&build="+build+"&room="+room+"&cusno="+cusno;
    	}
	 }	
	}	
	function HF(){
	if (confirm("真的要对当前的认购书进行换房吗？")){
   	  if (rgsno==""){alert("请选择你认购书");}
		else{
	    window.location="ChangeRoomConfirm.jsp?orderno="+rgsno+"&secno="+secno+"&build="+build+"&room="+room+"&cusno="+cusno+"&name="+secname+"&cusname="+cusname+"&paracon=sale"+"&date="+datestr;
	  }
	 } 
	}
	function QY(){
	    if (rgsno==""){alert("请选择你认购书");}
		else{
	 	 window.location="Insale.jsp?rgno="+rgsno+"&secno="+secno+"&build="+build+"&room="+room+"&cusno="+cusno+"&secname="+secname+"&cusname="+cusname+"&pay="+pay+"&ysumprice="+ysumprice;
        }
	}
	function TD(){
	if (confirm("真的要挞订当前的认购书吗？")){
	  if (rgsno==""){alert("请选择你认购书");}
		else{
	 	window.location="CancelDetail.jsp?CancelPara="+rgsno+"*"+cusno+"*"+secname+"*"+build+"*"+room+"*"+datestr+"*"+seller+"*"+secno+"*"+subscription;
		}
   }
	}
	function OutPrint(){
	 	openwin1("OutPrintPage.jsp?choose=<%=choose %>&SecNo=<%=SecNo%>&Loft=<%=strLoft %>&Build=<%=strBuild %>",350,258,150,150);
	}
	function DelInfo(){
	if (confirm("真的要删除当前的选中资料吗？")){
   	  if (rgsno==""){alert("请选择");}
		else{
	    openwin1("deleteordercontract.jsp?orderno="+rgsno,10,10,10,10);
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
