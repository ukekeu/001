<%@ page contentType="text/html;charset=GBK" %>
<html>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>退房登记</title>
</head>

<body onload="document.frm.canceldate.focus();">
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<SCRIPT language=javascript >
function openwin(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
</SCRIPT>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<%
  String sql="";
  int id=0;
  String Payname="";
  String code=request.getParameter("code");
  String cusno=request.getParameter("cusno");
  String secno=getbyte2(request.getParameter("secno"));
  String build=getbyte2(request.getParameter("build"));
  String roomno=getbyte2(request.getParameter("roomno"));
  String show=request.getParameter("show");
  String loft=getbyte2(request.getParameter("loft"));
  String state=request.getParameter("state");
  String saleprice="";
  String rgdate="";
  String payment="";
  String subscription="";
  String contractno=request.getParameter("contractno");
  //合同资料
    sql="select customer,section,room_no,loft,date,payment1,salerprice,subscription from order_contract where code="+code;
	 try{
      ResultSet rsorder=ViewBean.executeQuery(sql);
	  if (rsorder.next()){
	    cusno=rsorder.getString("customer");
		secno=rsorder.getString("section");
		loft=rsorder.getString("loft");
		roomno=rsorder.getString("room_no");
	    rgdate=rsorder.getString("date");
		payment=getbyte(rsorder.getString("payment1"));
	    saleprice=rsorder.getString("salerprice");
		subscription=rsorder.getString("subscription");
	  }
      rsorder.close();
	 }catch(Exception m){}
  //此退房客户已交款 
   String AlreadyMoney="";
   sql="select sum(factmoney) as money from FactGatheringRecord where cusno='"+cusno+"' and contractno='"+code+"'";
   try{
      ResultSet rsMoney=ViewBean.executeQuery(sql);
      if (rsMoney.next())AlreadyMoney=rsMoney.getString("money");
	  rsMoney.close();
	  if (AlreadyMoney==null) AlreadyMoney="0";
   }catch(Exception m){}
  //房间资料
		sql="select R.*,S.sectionname name,S.rmbprice from Room R ,order_contract S where S.section=R.seccode and R.loft=S.loft and R.room_code=S.room_no and R.seccode='"+secno+"' and R.Loft='"+loft+"' and "+" R.building='"+build+"' and "+"R.Room_code='"+roomno+"'";
		java.text.DecimalFormat df = new java.text.DecimalFormat(" #########.####"); 
        java.text.DecimalFormat df1 = new java.text.DecimalFormat(" #########.##"); 
        java.text.DecimalFormat df2 = new java.text.DecimalFormat(" #########"); 
		ResultSet rs=ViewBean.executeQuery(sql);
 
		if (rs.next()){
		  int Code=rs.getInt("Code");
				
		  String Floor=rs.getString("Floor");
		  String area=df.format(rs.getFloat("Area"));
		  String fl=getbyte(rs.getString("Room_Type"));
		  String cx=getbyte(rs.getString("Direction"));
		  String jg=getbyte(rs.getString("Scene"));
		  String zx=getbyte(rs.getString("Fitment"));
		  String usearea=df.format(rs.getFloat("UsedArea"));
		  String apportionarea=df.format(rs.getFloat("ApportionArea"));
		  String date=getbyte(rs.getString("Serve_Date"));
		  java.text.SimpleDateFormat Fdate =null;
  		  Fdate=new java.text.SimpleDateFormat("yyyy-MM-dd");
		  if (!date.equals(""))
  		  date=Fdate.format(Fdate.parse(date));
		  String fx=getbyte(rs.getString("roomtype"));
		  String unitprice=df1.format(rs.getFloat("Unitprice"));
          String sumprice=df2.format(rs.getFloat("rmbprice"));
	
		  String picpath=rs.getString("Map");
		   String TNunitprice=df1.format(rs.getFloat("TNunitprice"));
		  String name=getbyte(rs.getString("Name"));
		  
 %>

<form name=frm method="post" action="rgdj.jsp?para=aa" >
  <input type="hidden" name="Code" value="<%=code%>">
  <input type="hidden" name="secno" value="<%=secno%>">
  <input type="hidden" name="Floor" value="<%=Floor%>">
   <input type="hidden" name="cusno" value="<%=cusno%>">
   <input type="hidden" name="contractno" value="<%=contractno%>">
   
<div align="center">
<p><font color="#0000CC"><b><font size="3" class=FontColor>退房登记</font></b></font></p></div>

<input type=hidden name=secname value="<%=name %>">
<input type=hidden name="loft"  value="<%=loft %>">
<input type=hidden name="build"  value="<%=build %>">
<input type=hidden name="roomno"  value="<%=roomno %>">
<input type=hidden name="Floor"  value="<%=Floor %>" >
<input type=hidden name=roomtype  value="<%=fx %>">
<input type=hidden name="jzarea"  value="<%=area.trim()  %>" >
<input type=hidden name=Direction  value="<%=cx%>" >
<input type=hidden name=area value="<%=usearea.trim()  %>" >
<input type=hidden name=fitment  value="<%=zx %>" >
<input type=hidden name=Apportion  value="<%=apportionarea.trim() %>">
<input type=hidden name=Scene  value="<%=jg %>">
<input type=hidden name=RoomType  value="<%=fl %>" >
<input type=hidden name=date  value="<%=date %>" >
<input type=hidden name=unitprice  value="<%=unitprice.trim()  %>">
<input type=hidden name="tnunitprice"  value="<%=TNunitprice.trim()  %>" >
<input type=hidden name="sumprice"  value="<%=saleprice.trim()  %>"  >
<table border="0" width="100%"CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#fffff" class="tablefill" >
  <tr>
      <td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;间&nbsp;&nbsp;号</td>
    <td width="25%" class=listcontent > &nbsp;<%=loft +build+roomno%></td>
 
    <td width="25%" class=roomleft>&nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;层</td>
    <td width="25%" class=listcontent > &nbsp;<%=Floor %>　</td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;户&nbsp;&nbsp;&nbsp;&nbsp;型</td>
    <td width="25%" class=listcontent >  &nbsp;<%=fx %>　</td>
     <td width="25%" class=roomleft>&nbsp;建筑面积</td>
    <td width="25%" class=listcontent >&nbsp;<%=area.trim()  %>　</td>
  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;朝&nbsp;&nbsp;&nbsp;&nbsp;向</td>
    <td width="25%" class=listcontent > &nbsp;<%=cx%>　</td>
   
	 <td width="25%" class=roomleft>&nbsp;套内面积</td>
    <td width="25%" class=listcontent >&nbsp;<%=usearea.trim()  %></td>


  </tr>
  <tr>
    <td width="25%" class=roomleft>&nbsp;装修标准</td>
    <td width="25%" class=listcontent >&nbsp;<%=zx %></td>
       <td width="25%" class=roomleft>&nbsp;分摊面积</td>
    <td width="25%" class=listcontent > &nbsp;<%=apportionarea.trim() %></td>

   
     </tr>
  <tr>
   	<td width="25%" class=roomleft>&nbsp;景&nbsp;&nbsp;&nbsp;&nbsp;观</td>
    <td width="25%" class=listcontent > &nbsp;<%=jg %></td>

	<td width="25%" class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;类</td>
    <td width="25%" class=listcontent >&nbsp;<%=fl %></td>

  </tr>
  <tr>
      <td width="25%" class=roomleft>&nbsp;交楼日期</td>
    <td width="25%" class=listcontent >&nbsp;<%=date %></td>
       <td width="25%" class=roomleft>&nbsp;付款方式</td>
    <td width="25%" class=listcontent > &nbsp;<%=payment.trim()  %></td>

   </tr>
  <TR>
    <td width="25%" class=roomleft>&nbsp;销售总价</td>
    <td width="25%" class=listcontent > &nbsp;<%=saleprice.trim()  %></td>
      <td width="25%" class=roomleft>&nbsp;认购日期</td>
    <td width="25%" class=listcontent >&nbsp;<%=rgdate.substring(0,10)  %></td>

  </tr>
  </table>
  <table border="0" width="100%"CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#fffff" class="tablefill" >
    
	<tr><td width="25%" class=roomleft>&nbsp;客户已交款&nbsp;</td><td width="25%"><input type=text size=15 name=alMoney onkeydown="key(document.frm.kkMoney)" value=<%=AlreadyMoney %>></td>
	<td width="25%" class=roomleft>&nbsp;退定金&nbsp;</td><td><input type=text size=15 name=kkMoney onkeydown="key(document.frm.canceldate)" value=<%=subscription %>></td></tr>
	<tr>
    <td width="25%" class=roomleft>&nbsp;收款处理&nbsp;</td><td><input type=text size=15 name=comm onkeydown="key(document.frm.person)"></td>
	<td width="25%" class=roomleft>&nbsp;退房/挞定日期&nbsp;</td><td width="25%"><input type=text size=15 name=canceldate  readonly onkeydown="key(document.frm.comm)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(canceldate);return false;" title="请选择认购日期"><font color=red>*</font></td>
	</tr>
     <tr><td  width="25%"class=roomleft >&nbsp;退房/挞定原因&nbsp;</td><td width="75%" colspan=3> <input type=text size=50 name=context></td></tr>
	<tr><td width="25%" class=roomleft>&nbsp;经&nbsp;办&nbsp;人&nbsp;</td><td width="25%"><input type=text size=15 name=person value="<%=(String)session.getAttribute("loginname") %>" onkeydown="key(document.frm.checker)"></td>
    <td width="25%" class=roomleft>&nbsp;审&nbsp;批&nbsp;人&nbsp;</td><td width="25%"><input type=text size=15 name=checker onkeydown="key(document.frm.context)"><font color=red>*</font></td></tr>
	
	<tr><td width="25%" class=roomleft>&nbsp;锁定30天不再认购&nbsp;</td><td width="25%"><input name="dis"  value=1 type="checkbox"></td>
     
  </table>
  <p align="center"> 
  <input type="button" name="subsave" value=" 提 交 " onclick="SaveCancel();">
  <input type="button" name="subsave" value=" 退 出 " onclick="window.close();">
          </P>
<%}

rs.close(); %>
</form>
<SCRIPT language=javascript>
   function Validate(aForm)
   {
   
   
      if (aForm.canceldate.value.length<1)
	    	{
	    	alert("请输入退房日期！");
	        aForm.canceldate.focus();
	        return (false);
	    	}	
		
			 if (aForm.person.value.length<1)
	    	{
	    	alert("请输入经办人！");
	        aForm.person.focus();
	        return (false);
	    	}			
        if (aForm.checker.value=="")
		{
	        alert("请输入审批人)");
	        aForm.person.focus();
	        return false;
		}
		
	  return (true);
	}
	function SaveCancel(){
      if (Validate(document.frm)){
	   var money=parseFloat(document.frm.alMoney.value)-parseFloat(document.frm.kkMoney.value)
       document.frm.action="SaveCancelRoom.jsp?para=tf&money="+document.frm.kkMoney.value;
	   document.frm.submit(); 
     }
    }	
   </script>		
</body>

</html>
