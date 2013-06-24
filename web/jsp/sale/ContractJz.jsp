<html>

 
<head>
<title>备案</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"QT022");


 %>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language="javascript" src="../public_js/public.js">
</script>
<%String section =China.getParameter(request,"Section");
 
	String cusname=China.getParameter(request,"cusname");
    String SecName=China.getParameter(request,"SecName");
	String SecNo=request.getParameter("SecNo");
 
	String  Loft=China.getParameter(request, "Loft") ;
	String Build=China.getParameter(request,"Build");
 
 
%>
<body  topmargin="1" >
<%
	%>
<form name=frm method=post action="ContractJz.jsp">
 <input type=hidden name="cusname" value="">
 <input type=hidden name="SecName" value="<%=SecName %>">
 <input type=hidden name=SecNo value="<%= SecNo %>" >
<input type=hidden name=Build value="<%= Build %>" >
<input type=hidden name=Loft value="<%= Loft %>" >
<%  String RoomS=China.getParameter(request,"Room");
  
	String checkedStr="";
	String checkedStr1="";
	String checkedStr2="";
	String jzstate="";
	String cedate ="";
	String cbdate ="";
	String jzstate1="";
	cbdate = China.getParameter(request, "cbdate" ) ;
	cedate = China.getParameter( request,"cedate" ) ;
	String jz=request.getParameter("jz");
	if (jz==null)jz="N1";
	jzstate1=jz;
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
<br>
 <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
<tr> <td width="100%"> <div align="center"><font size=3><b><%=SecName+Loft %>合同备案一览表</b></font></div></td><td width="38%">&nbsp;</td></tr> 
</table>
<br>
 <table width="94%" cellpadding="0" cellspacing="0" border="0"> 
<tr> <td >房号: 
        <input type=text size=5 name=Room value="<%=RoomS%>">
        签约日期: 从<input type=input name=cbdate size=10 readonly value="<%=cbdate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cbdate);return false;">到<input type=input name=cedate size=10 readonly value="<%=cedate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cedate);return false;">
        <input type=submit name=find value="查询"><br>
        <input type=radio name=jz value="Y" <%=checkedStr %> onclick="document.frm.submit();">已备案统计
        <input <%=checkedStr1 %> type=radio name=jz value="N" onclick="document.frm.submit();">已送案统计
        <input <%=checkedStr2 %> type=radio name=jz value="N1" onclick="document.frm.submit();">未送案统计</td>
		<td align="right">
		
		<%if (jzstate1.equals("N1")){ %>
		<input type=button name=sa value="送 案" onclick="check_sa();">
		<%}else if (jzstate1.equals("N")){ %>
		<input type=button name=sa value="出 案" onclick="check_ca();">
		<%} %>
		</td>
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
 
	if (!RoomS.equals(""))RoomS=" and s.room_no='"+RoomS+"'";
	
	if (!(SecNo.equals(""))){section=" and  s.section='" + SecNo + "'";}

    String strDate = "" ;
    
    if( !cbdate.equals("") ) {
        strDate = strDate + "and convert(char(10),s.visadate,120) >= '" + cbdate + "' " ;
    }
    if( !cedate.equals("") ) {
        strDate = strDate + "and convert(char(10),s.visadate,120) <= '" + cedate + "' " ;
    }
   String VisaDate="";
			aStr = "select s.checkstate, s.code,s.section,s2.name,building,s.loft,s.room_no ,c.signatory as cus_name,c.phone,";
			aStr+="s.contractno, convert(char(10),s.date,120)date,a.id,";
			aStr+="convert(char(10),a.senddate,120) senddate, a.state,convert(char(10),a.outdate,120) outdate,s.VisaDate from ";
			aStr+=" order_contract s,customer c,appraisal a, CRM_Project s2 ";
			aStr+="where s.state<>3 and not s.VisaDate is null and  s.section*=s2.serialno and c.serialno=s.Customer ";
			aStr+="and s.code*=a.contractno  ";
			if(!cusname.equals(""))
	          aStr +=" and c.signatory like '%" +cusname + "%'";
			aStr += section + buildStr+RoomS + strDate ;
                        if (!Loft.equals(""))aStr += " and s.loft='"+Loft+"'";
			aStr += startStr;
			aStr += " order by s.sectionname,s.loft,s.floors,s.room_no,s.date desc";
			
	%> 

  <table width="100%" border="0" cellpadding="1" cellspacing="1">
    <tr class=listtitle> 
	<td> 
<div align="center"><font color=white>序号<input type=checkbox name=sh onclick="chooseCheckbox(this.checked);" ></font></div></td>
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
    if (section.equals("")){out.print("<font color=red>请选择左边楼栋</font>");out.close();}
	String hasNextPage = "N";
	int pageSize = 30;
	int i = 0;
	String code="";
   
	try{
	
		aRS = aBean.executeQuery(aStr);
	
		while(aRS.next()) {
				
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
			     boolean checkstate=aRS.getBoolean("checkstate"); 
				
				 if (jzstate.equals(state)){
				 
					i ++ ;
 %> <tr class=listcontent id=R<%=i %>  onclick="changeclass1(this,'clickbg','listcontent');" ondblclick="openwin1('sendAList.jsp?code=<%=code%>',450,150,100,100);">
  <td> 
 <div align="center"><%= i %>
 
 <%if (state.equals("")||state.equals("1")){ if (checkstate){%><input name="aa" value="<%=code %>" type="checkbox"><%}else{out.print("未审核");}} %>
 </div></td>
  <td> 
 <div align="left"><%=  loft+buildDisp+room %></div></td>
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
 
<%if (state.equals("") && !VisaDate.equals("")&&(Cortrol.indexOf("A")>=0)) {%><a href="#" onclick="">未送案</a><%} %>
<%if (state.equals("1")&&(Cortrol.indexOf("A")>=0)){%><a href="#" onclick="openwin1('../afterservice/JzOutPage.jsp?contract=<%=code %>',400,200,150,150)">已送案</a><%} %>
<%if (state.equals("2")&&(Cortrol.indexOf("A")>=0)){%>已备案<%} %>
</div>
</td>
<td > 
<div align="center">
<%if (state.equals("1")){%><%=senddate %><%} %>
<%if (state.equals("2")){%><%=outdate %><%} %>
</div>
</td>
 
<td bgcolor="#FFFFFF"><%if (!state.equals("")&&(Cortrol.indexOf("A")>=0)){%><a href="#" onclick="if (confirm('确认撤回吗?'))openwin1('CancelJz.jsp?contract=<%=code %>',400,200,150,150)">撤回</a><%} %></td>
</tr> 
<%
    }  
	} //while
  
	}catch(Exception s){out.print(s);}
	startidn = String.valueOf(id);
	aRS.close();

%> 
 
<script>
  function chooseCheckbox(para) {//indexstring
     var x=0;
	// var seldocs = new Array();
	var aa="";
	if (frm.elements.length){
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].name=="aa"))
		 {
       		frm.elements[i].checked=para;
			
   		 }
	  }	
	  }
 
}
	 function check_sa(){
	 
	 
	 if (getseldocs2()==""){alert("请选择可以鉴证的合同");return false;}
	 
	 
	 
	   if (confirm("确认送案吗？"))
	  openwin1("../afterservice/JzSendPage.jsp?contract="+getseldocs2(),400,300,150,150)
	 
	 }
	 
	 function check_ca(){
	 
	 
	 if (getseldocs2()==""){alert("请选择已鉴证合同");return false;}
	 
	 
	 
	   if (confirm("确认出案登记吗？"))
	  openwin1("../afterservice/JzOutPage.jsp?contract="+getseldocs2(),400,300,150,150)
	 
	 }
   	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
         if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].checked)&&frm.elements[i].name=="aa")
		 { 
		    seldocs[x]=frm.elements[i].value ;
			x++;
   		 }
	  }	

   return seldocs ;
}

</script>

</body>

</html>
