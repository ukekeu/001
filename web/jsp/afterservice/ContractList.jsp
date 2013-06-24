<html>

 
<head>
<title>备案</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <%@ include file="../public_js/getByteOut.jsp"%>     
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"A002");


 %>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language="javascript" src="../public_js/public.js">
</script>
<%String section =China.getParameter(request,"Section");
 
	String building = China.getParameter(request,"Building");
	String cusname=China.getParameter(request,"cusname");
     String secname=China.getParameter(request,"secname");
	String display =China.getParameter(request,"Display");
    String SecNo=request.getParameter("SecNo");
	String Loft=request.getParameter("Loft");
        if (Loft==null)Loft="";
    if (!cusname.equals(""))
	   Loft= China.getParameter(request, "Loft") ;
	String Build=request.getParameter("Build");
	if (Build==null)Build=""; 
%>
<body bgcolor="#FFFFFF" text="#000000" >
<%
	%>
<form name=frm method=post action="ContractList.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&Build=<%=Build %>">
 <input type=hidden name="cusname" value="">
 <input type=hidden name="secname" value="">
 <input type=hidden name=SecNo value="<%= section %>" >
<input type=hidden name=Build value="<%= building %>" >
<input type=hidden name=Loft value="<%= Loft %>" >
<%  String RoomS=China.getParameter(request,"Room");
    if(Loft.equals("")){
	 
	  out.close();
	 }
	String checkedStr="";
	String checkedStr1="";
	String checkedStr2="";
	String jzstate="";
	String cedate ="";
	String cbdate ="";
	cbdate = China.getParameter(request, "cbdate" ) ;
	cedate = China.getParameter( request,"cedate" ) ;
	String jz=request.getParameter("jz");
	if (jz==null)jz="N1";
	if (jz.equals("Y")){jzstate="2";checkedStr="checked";checkedStr1="";checkedStr2="";}
	else if (jz.equals("N")){jzstate="1";checkedStr1="checked";checkedStr="";checkedStr2="";}
	else if (jz.equals("N1")){jzstate="";checkedStr2="checked";checkedStr="";checkedStr1="";}
	if (jz.equals("Y")){jz="  a.state=2 and s.section=s2.serialno and c.serialno=s.Customer and s.code=a.contractno ";
	}
	else  if (jz.equals("N")){ jz="  a.state=1 and s.section=s2.serialno and c.serialno=s.Customer and s.code=a.contractno ";
	}
	else  if (jz.equals("N1")){ jz=" a.state is null and  s.section*=s2.serialno and c.serialno=*s.Customer and s.code*=a.contractno ";}

 
 String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	  
 %> 

<table width="370" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('RoomCodeShowS.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同登记</font></a>
	</td>
	 <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('../afterservice/ContractList.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>鉴证管理</font></a>
	</td>
	<!--
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('contract_view.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未审核合同</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('contract_view.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已审核合同</font></a>
	</td>
	-->
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('contract_yh_view.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>优惠审核</font></a>
	</td>
	
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('paymoneyProcess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>付款进度</font></a>
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
 <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
<tr> <td width="35%">&nbsp;</td><td width="27%"> <div align="center"><font size=3><b>合同备案一览表</b></font></div></td><td width="38%">&nbsp;</td></tr> 
</table>
 <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
<tr> <td >房号: 
        <input type=text size=5 name=Room value="<%=RoomS%>">
        签订日期: 从<input type=input name=cbdate size=10 readonly value="<%=cbdate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cbdate);return false;">到<input type=input name=cedate size=10 readonly value="<%=cedate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cedate);return false;">
        <input type=submit name=find value="查询"><br>
        <input type=radio name=jz value="Y" <%=checkedStr %> onclick="document.frm.submit();">已备案统计
        <input <%=checkedStr1 %> type=radio name=jz value="N" onclick="document.frm.submit();">已送案统计
        <input <%=checkedStr2 %> type=radio name=jz value="N1" onclick="document.frm.submit();">未送案统计</td>
        </tr> 
</table>
<%
   	String startid = "";
	String startStr = "";
	String startidp = "";
	String startidn = "";
    String findWhere="";
	String buildStr = "";
	String buildDisp = "";
    String phone = "";

	if (!Build.equals(""))
		buildStr = " and s.building='" + Build + "' ";
	int columns = 0;
	//display = "0";
	//section = "a";
	//building = "a";

	if (display.equals("0"))
		columns = 4;
	if (display.equals("1"))
		columns = 6;
	if (display.equals("4"))
		columns = 8;	
	if (display.equals("all"))	
		columns = 9;
	String aStr = "";

	String sectionName2 ="";
	int id = 0;
	String room;
	String cus_name;
	String contractno;
	String senddate="";
	String SaleDate="";
	String outdate="";
	String loft="";;
	String state="";
	String secno="";
	boolean noNull = false;
	ResultSet aRS = null;

	//if (!(section.equals("") || display.equals(""))) {
	if (!RoomS.equals(""))RoomS=" and s.room_no='"+RoomS+"'";
	
	if (!(SecNo.equals(""))){section=" and  s.section='" + SecNo + "'";}

    String strDate = "" ;
    if( cbdate != null && ! cbdate.equals( "" ) ) {
        cbdate =  cbdate + " 00:00:00";
    }
    if( cbdate == null ) {
        cbdate = "" ;
    }
     
    if( cedate != null && !cedate.equals( "" ) ) {
        cedate = cedate + " 23:59:59";
    }
    if( cedate == null ) {
        cedate = "" ;
    }
    if( !cbdate.equals("") ) {
        strDate = strDate + "and date >= '" + cbdate + "' " ;
    }
    if( !cedate.equals("") ) {
        strDate = strDate + "and date < '" + cedate + "' " ;
    }
   String VisaDate="";
			aStr = "select s.code,s.section,s2.name,building,s.loft,s.room_no ,c.signatory as cus_name,c.phone,";
			aStr+="s.contractno, convert(char,s.date,111)date,a.id,";
			aStr+="convert(char,a.senddate,111) senddate, a.state,convert(char,a.outdate,111) outdate,s.VisaDate from ";
			aStr+=" order_contract s,customer c,appraisal a, section s2 ";
			aStr+="where  not s.VisaDate is null and  s.section*=s2.serialno and c.serialno=s.Customer ";
			aStr+="and s.code*=a.contractno  ";
			if(!cusname.equals(""))
	          aStr +=" and c.signatory like '%" +cusname + "%'";
			aStr += section + buildStr+RoomS + strDate ;
                        if (!Loft.equals(""))aStr += " and s.loft='"+Loft+"'";
			aStr += startStr;
			aStr += " order by s.sectionname,s.loft,s.floors,s.room_no,s.date desc";
	%> 

  <table width="110%" border="0" cellpadding="1" cellspacing="1">
    <tr class=listtitle> 
	<td> 
<div align="center"><font color=white>序号</font></div></td>
<td  > 
<div align="center"><font color=white>房间代码</font></div></td>
<td > 
<div align="center"><font color=white>客户姓名</font></div></td>
<td > 
<div align="center"><font color=white>联系电话</font></div></td>
<td > <div align="center"><font color=white>合同编号</font></div></td>
<td > 
<div align="center"><font color=white>签订日期</font></div></td>
<td > <div align="center"><font color=white>备案状态</font></div></td>
<td  > 
<div align="center"><font color=white>日&nbsp;期</font></div>
      </td>
	  </tr> <%	
  	//out.print(aStr);
	//out.close();
	String hasNextPage = "N";
	int pageSize = 30;
	int i = 0;
	String code="";
   
	try{
		aRS = aBean.executeQuery(aStr);

		while(aRS.next()) {
				i ++ ;
				code=getbyte(aRS.getString("code"));
				secno=getbyte(aRS.getString("section"));
				sectionName2 = getbyte(aRS.getString("name"));
				
				buildDisp = getbyte(aRS.getString("building"));
				loft= getbyte(aRS.getString("loft"));
				room = aRS.getString("room_no");
				cus_name = getbyte(aRS.getString("cus_name"));
				phone = getbyte(aRS.getString("phone"));
				contractno = getbyte(aRS.getString("contractno"));
				SaleDate=getbyte(aRS.getString("date"));
				id = aRS.getInt("id");
				senddate =getbyte(aRS.getString("senddate"));
                state= getbyte(aRS.getString("state"));
				outdate=getbyte(aRS.getString("outdate"));
                VisaDate=getbyte(aRS.getString("VisaDate"));
				 if (jzstate.equals(state)){
					
 %> <tr class=listcontent id=R<%=i %>  onclick="changeclass1(this,'clickbg','listcontent');" ondblclick="openwin('sendAList.jsp?code=<%=code%>',450,150,100,100);">
  <td> 
 <div align="center"><%= i %></div></td>
  <td> 
 <div align="left"><%=sectionName2+ loft+room %></div></td>
 <td> 
<div align="center"><%= cus_name %></div></td>
 <td > 
<div align="center"><%= phone %></div></td>
<td > <div align="center"><%= contractno %></div></td>
<td > 
<div align="center"><%= SaleDate %>&nbsp;</div>
</td>
<td> 
<div align="center">
 
<%if (state.equals("") && !VisaDate.equals("")&&(Cortrol.indexOf("A")>=0)) {%><a href="#" onclick="openwin('JzSendPage.jsp?contract=<%=code %>&secno=<%=secno %>&loft=<%=loft %>&build=<%=buildDisp %>&room=<%=room %>',400,300,150,150)">未送案</a><%} %>
<%if (state.equals("1")&&(Cortrol.indexOf("A")>=0)){%><a href="#" onclick="openwin('JzOutPage.jsp?contract=<%=code %>',400,200,150,150)">已送案</a><%} %>
<%if (state.equals("2")&&(Cortrol.indexOf("A")>=0)){%>已备案<%} %>
</div>
</td>
<td > 
<div align="center">
<%if (state.equals("1")){%><%=senddate %><%} %>
<%if (state.equals("2")){%><%=outdate %><%} %>
</div>
</td>
</tr> 
<%
    }  
	} //while
   
	}catch(Exception s){}
	startidn = String.valueOf(id);
	aRS.close();

%> 


</body>

</html>
