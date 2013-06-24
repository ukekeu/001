<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>签约客户一览表</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
  <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%
String menu= (String)session.getAttribute("menu");
 
if (menu==null)menu="1";
 if (menu.equals("1")){
 %>
<script>
this.resizeTo(screen.availWidth,screen.availHeight)
this.moveTo(0,0)
this.focus()
</script>
<%} %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
String CusName="";
String Condi="";
String Condi1="";
String CusAge="";
String year="";
String year1="";
String month="";
String day="";
String CusType="";
String BuyType="";
String CusVisitDate="";
String strWhere="";
String section="";
String custype="";
String cusche="";
String FindCondition="";//传递参数变量
String orderbytype=China.getParameter(request,"orderbytype");
String orderby=China.getParameter(request,"orderby");
String gradetype=China.getParameter(request,"gradetype");

String prin=request.getParameter("print");
String Find=request.getParameter("FindS");
String tmp=request.getParameter("pageno");

String FindCon=(String)request.getParameter("condtion");
if (Find!=null){
   
  //取出条件值

   CusName=request.getParameter("cusname");//客户姓名
   Condi=request.getParameter("condi");//条件1
   section=request.getParameter("section");//取出楼盘

   Condi1=request.getParameter("condi1");//条件2
   CusAge=request.getParameter("age");//客户年龄
   year=request.getParameter("SDate");//客户来访日期
   year1=request.getParameter("EDate2");//客户来访日期
 
   custype=request.getParameter("cusche");//客户状态

   if (section==null)section="";
   if (!section.equals(""))
   strWhere=" and Order_Contract.section ='"+section+"'" ;
   FindCondition=" Order_Contract.section='"+section+"'";
   FindCondition=FindCondition+"&Find="+Find;
   FindCondition=FindCondition+"&cusche="+custype;

   if (year!=null&&year1==null){
	   if (year.length()>0){
		 if (strWhere.equals("")){strWhere=" and customer.visit_date='"+year+"'";}
		 else {strWhere+=" and customer.visit_date='"+year+"'";}
		 FindCondition=FindCondition+"&year="+year;
		}
    }
   if (year1!=null&&year==null){
	   if (year1.length()>0){
	   	 if (strWhere.equals("")){strWhere=" and customer.visit_date='"+year1+"'";}
		 else {strWhere+=" and customer.visit_date='"+year1+"'";}
		 FindCondition=FindCondition+"&year1="+year1;
	     }
    }
 
   if (year1!=null&&year!=null){
	   if (year1.length()>0){
	   	 if (strWhere.equals("")){strWhere=" and customer.visit_date between '"+year+"' and '"+year1+"'";}
	     else strWhere+=" and customer.visit_date between '"+year+"' and '"+year1+"'";
		 FindCondition=FindCondition+"&year1="+year1+"&year="+year;
	     }
    }


   CusType=request.getParameter("custype");
   BuyType=request.getParameter("gmyt");

 if ((CusName!=null)&&(CusName.length()>0)){
   if (tmp==null){
   CusName= new String(CusName.getBytes("ISO8859_1"),"GBK");
   }
    if (strWhere.equals("")){ strWhere=" and  customer.Cus_Name like '%"+CusName+"%'";
	}else{ strWhere+=" and customer.Cus_Name like '%"+CusName+"%'";}
   FindCondition=FindCondition+"&cusname="+CusName;
   }

 if ((CusAge!=null)&&(CusAge.length()>0)){
   if (strWhere.equals("")){strWhere=" and customer.cus_age "+Condi+CusAge;}
   else{strWhere=strWhere+" and customer.cus_age "+Condi+CusAge;}
   FindCondition=FindCondition+"&age="+CusAge;
 }

 if (CusType!=null){
   if (CusType.length()>0){
	   if (tmp==null){
	     CusType= new String(CusType.getBytes("ISO8859_1"),"GBK");
	   }
       if (strWhere.equals("")){strWhere=" and customer.Cus_Type='"+CusType+"'";}
       else{strWhere=strWhere+" and customer.Cus_Type='"+CusType+"'";}
   FindCondition=FindCondition+"&custype="+CusType;
   }  
 }  

 if (BuyType!=null){
  if (BuyType.length()>0){
    if (tmp==null){
    BuyType= new String(BuyType.getBytes("ISO8859_1"),"GBK");
    }
    if (strWhere.equals("")){strWhere=" and customer.Purpose='"+BuyType+"'";}
    else{strWhere=strWhere+" and customer.Purpose='"+BuyType+"'";}
    FindCondition=FindCondition+"&gmyt="+BuyType;
   }  
 } 
}

%>

<%@ include file="../public_js/CheckSection.jsp"%>

<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/countpagenum.jsp"%>
<%
    String search_like=China.getParameter(request,"search_like").trim();
	String fields=China.getParameter(request,"fields").trim();
	String searchWhere="";
      if (!search_like.equals("")){
	 if (!fields.equals("VisaDate"))
	searchWhere="  and "+fields+" like '%"+search_like+"%' ";
	else
	searchWhere="  and "+fields+" = '"+search_like+"' ";
	}
	 strWhere+=searchWhere;

 
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
List room=new LinkedList();//存放业主买单元
List cus=new LinkedList();//存放业主
String orderSQL="SELECT LOFT+ROOM_NO ROOM  ,CUSTOMER FROM ORDER_CONTRACT where state=2 and section in("+SectionS+")"+strWhere;
   
 //排序方式
	if (!orderbytype.equals("")&&!orderby.equals("")){
	  if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by customer.visit_date desc";
	  if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by customer.visit_date asc";
	  if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by customer.cus_name desc";}
	  if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by customer.cus_name asc";
	} 
	 else if (!orderby.equals("")){
	  if ( orderby.equals("0")) orderby=" order by customer.cus_name desc";
	  if ( orderby.equals("1")) orderby=" order by customer.cus_name asc";
	
	}else if (!orderby.equals("")&&!orderbytype.equals("")){
	 if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by  customer.visit_date desc";
	 if (orderbytype.equals("1")&&orderby.equals("0")) orderby=" order by  customer.cus_name desc";
	 if ( orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by  customer.cus_name desc";
     if ( orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by       customer.visit_date desc";
	}else{
	orderby=" order by customer.visit_date desc";
	
	}
	

 //get session value
    //String seller=setpro.getId();
	String sql="";
	int totalnum=0;
    //读取查询条件
	
	String con=FindCon;
	if (FindCon!=null){
    	FindCon=" = "+FindCon;
    	}
    else{
	   FindCon="='0' ";
	 }  
	String condtion=FindCon;		
    String eof="false";
	String floors="";
	String yong_tu="";
	String PubPra=(String)session.getAttribute("Attribute");	
    String user=(String)session.getAttribute("loginname");	
	String job=(String)session.getAttribute("job");	
	 if (job.indexOf("销售员")>=0){
	   strWhere+=" and Order_Contract.seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }

ResultSet rs=null;
  
	//保存输入值的变量
    String no="";
    String name="";
    String sex="";
    String age="";
    String sale="";
    String date="";
    String tel="";
    String idcard="";
    String sell="";
	int i=0;
    String roomtype="";
    String area="";
    String tj="";
    String region="";
    String linkman="";
   String address="";
   String bbj="";
   String sj="";
     String post="";
	String attention="";
   String VisaDate="";
   String sectionName="";
   String ContractNo="";
   String loft="";
   String building="";
   String roomno="";
   String ID_Card="";
out.print("<p align=center class=FontColor><font size=3><b>签约客户一览表</b></p>");
%>
<script>
function full(){
setSelectMad(document.form1.section,'<%=section%>');
setSelectMad(document.form1.fields,'<%=fields%>');

 }

</script>

<body onload="full()" oncontextmenu="return false" >

<form name=form1 method="post" >
<input type=hidden name="SDate">
<input type=hidden name="EDate2">
<input type=hidden name="custype">
<input type=hidden name="gmyt">
<input type=hidden name="tel">
<input type=hidden name="age">
<input type=hidden name=cusname>
<input type=hidden name=FindS>
<input type=hidden name=Findsection>
<input type=hidden name=condi>

<% String sel=(String)request.getParameter("sel");
   String showGrade=getbyte1(request.getParameter("bir"));
   if(sel==null) sel="3";

   int colnum=0;
   int iiii=0;

     ResultSet rs3=null;
    %>
	  <input type=hidden name="bir" value="<%=showGrade %>">
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="360" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr> 
   <td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=3;document.form1.bir.value='4';findSub('visitcusview3.jsp');"> <font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>所有客户 
	</td>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=0;document.form1.bir.value='1';findSub('visitcusview3.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>生日提醒 
	</td>
	 
	 <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=1;document.form1.bir.value='2';findSub('visitcusview3.jsp');"> <font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>本月不过生日 
	</td>
	 <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=2;document.form1.bir.value='3';findSub('visitcusview3.jsp');"> <font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未登记生日 
	</td>
	</tr></table>
	<script>
function findSub(para){
   document.form1.action=para+"?Search=b&Find=b";
   document.form1.submit();


}
</script>
 <%
//权限审核
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"S005");
 %>
   <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA"><td >

   楼盘：<select name="section" onchange="document.form1.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
	
	  <%
	if (Cortrol==null)Cortrol="";
	String reportAddrs=(String)session.getAttribute("reportAddr");
	%>
	<script>
	function changesub(para){
			document.form1.Findsection.value=para;
			
			document.form1.Find.value="o";
			//document.form1.cusche.value=document.form1.stateValue.options[document.form1.stateValue.selectedIndex].value;
			document.form1.submit();
			
			}
	</script>
<%if (Cortrol.indexOf("E")>=0){ %>
	<input type=button name=sms value="短 信" onclick="sendmessage();" title="选择客户后,发送短信给客户">&nbsp;<input type=button name=fx value="分析"  onclick="gcfx();" title="图形方式显示客户构成情况，主要是统计多少新业主由老业主介绍">
<%} %>
    <%if (Cortrol.indexOf("F")>=0){ %><input type=button name=prin title="弹出窗口选择打印条件" value="打印客户档案" onclick="openwin('auto_select3.jsp?para=2',400,300);">&nbsp;<input type=button name=prin title="弹出窗口选择打印条件" value="客户台帐明细" onclick="openwin('auto_select3.jsp?para=3',400,300);">
    
   <%} %>
    
   <select name=fields onchange="ch(this.value);">
   <option value=cus_name>客户姓名</option>
    <option value=loft+building+room_no>购买单位</option>
	  <option value=yong_tu>用途</option>
    <option value=loft>栋号</option>
   <option value=phone>固定电话</option>
    <option value=customer.sj>手机号</option>
   <option value=address>联系地址</option>
   <option value=VisaDate>签约日期</option>
   <option value=ContractNo>合同号</option>
   
   <input type=text name=search_like size=30 title="模糊查询，可查询姓名、电话、地址，双击可弹出日期" ondblclick="fPopUpCalendarDlg(search_like);return false;" value="<%=search_like %>"><input type=button name=fin value="查 询"  onclick="document.form1.submit();" ><!--&nbsp;<input type=button name=outdata title="导出当前页数据" value="导出EXCEL" onclick="outexcel();">--></td>  </tr></table>
  
<input type=hidden name="Find">
<input type=hidden name="Findsection">
<input type=hidden name="cusname">
<input type=hidden name="condi">
<input type=hidden name="age">
<input type=hidden name="tel">
<input type=hidden name="condi1">
<input type=hidden name="SDate1">
<input type=hidden name="Date2">
<input type=hidden name="custype">
<input type=hidden name="gmyt">
<input type=hidden name="cusche">
<table width=100%><tr height="3"><td></td></tr></table>
<center>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" >
      <td    align="left"><input type="checkbox" name="choosall" onclick="chhoseData(this.checked);">序号</td>
  <td  align="center">客户姓名</td>
  <td  align="center">身份证号</td>
  <td  align="center">联系电话</td>
 
  <td  align="center">联系地址</td>
    <td  align="center">购买单位</td>
	 <td  align="center">认购面积</td>
 <td  align="center">总金额</td>
 <td  align="center">优惠金额</td>
 
	  <td  align="center">合同号</td>
  <td  align="center">签约日期</td>
    <td  align="center">用途</td>
  <td  align="center">销售员</td>

  </tr>
 
 <%	
  if (showGrade.equals("")||showGrade.equals("4"))showGrade=" ";
 else if (showGrade.equals("1"))showGrade=" and month(csdate)=month(getdate())";
 else if (showGrade.equals("2"))showGrade=" and month(csdate)<>month(getdate()) and not csdate  is null";
 else  if (showGrade.equals("3"))showGrade=" and csdate is null";
 
  strWhere+=showGrade ;
 sql="select Top "+pageSize+"   Order_Contract.ysumprice-Order_Contract.rmbprice yhhj,Order_Contract.jzarea,Order_Contract.rmbprice,customer.Code,customer.serialno,  customer.ID_Card, customer.cus_name,customer.cus_sex, customer.Phone,customer.sj,customer.Address,customer.Zip_Code ,customer.Address,customer.Zip_Code ,Order_Contract.seller,Order_Contract.floors,convert(char(24),customer.visit_date,111) as   visit_date,customer.bbj,customer.sj,Order_Contract.VisaDate,Order_Contract.sectionname,Order_Contract.section,Order_Contract.loft,Order_Contract.building,Order_Contract.room_no,Order_Contract.ContractNo,Order_Contract.yong_tu from customer,Order_Contract where  Order_Contract.customer=customer.serialno and  Order_Contract.Section in("+SectionS+") and  customer.Code not in (Select top "+prenum +" customer.code from customer,Order_Contract where  Order_Contract.customer=customer.serialno and Order_Contract.Section in("+SectionS+") and Order_Contract.state=2" +strWhere +orderby+")  and  Order_Contract.state=2 " + strWhere;
 sqlcount="SELECT count(customer.code) code from customer,Order_Contract where  Order_Contract.customer=customer.serialno and  Order_Contract.Section in("+SectionS+")  and  Order_Contract.state=2 "+strWhere;
 
  try{
 
int tr=0;
    rs=ViewBean.executeQuery(sql + orderby);
	
   while (rs.next()){
	 eof="true";
     i=i+1;
	 
        String jzarea=getbyte(rs.getString("jzarea"));
   String rmbprice=getbyte(rs.getString("rmbprice"));
   String yhje=FormatD.getFloat3(rs.getDouble("yhhj"),2);
     no=rs.getString("SerialNo").trim();
	ID_Card=getbyte(rs.getString("ID_Card"));
     name=getbyte(rs.getString("Cus_Name"));
     sex=getbyte(rs.getString("Cus_Sex"));
     tel=getbyte(rs.getString("Phone"));
	 sj=getbyte(rs.getString("sj"));
     address=getbyte(rs.getString("address"));
	 post=getbyte(rs.getString("Zip_Code"));
   
	 sell=getbyte(rs.getString("seller"));
	 floors=getbyte(rs.getString("floors"));
	 date=getbyte(rs.getString("visit_date"));
    VisaDate=rs.getDate("VisaDate").toString();
	 sectionName=getbyte(rs.getString("sectionname"));
	 section =getbyte(rs.getString("section"));
	 loft =getbyte(rs.getString("loft"));
	 building =getbyte(rs.getString("building"));
	 roomno =getbyte(rs.getString("room_no"));
	 ContractNo=getbyte(rs.getString("ContractNo"));
	 yong_tu=getbyte(rs.getString("yong_tu")); 
  %>
   <tr align="center" id=TR<%=i %>   trid=tr<%=tr %> align="center"   onmouseover="mout(this);"  onclick="savepara('<%=no%>'); changeclass1(this,'clickbg','');" ondblclick="openwin1('../sale/showCustomerContract.jsp?secname=<%=sectionName %>&secno=<%=section %>&roomno=<%=roomno %>&build=<%=building %>&loft=<%=loft %>&Floor=<%=floors %>&show=true',680,530,50,2);" title="双击可看合同资料"> 
	<td  align="center"><input type="checkbox" name="choos" value="<%=sj+"|"+name%>"><%=i %>　</td>
 <td  title="点击可以进行登记客户调查信息"  ><%if (Cortrol.indexOf("E")>=0){ %><a href="#" onclick="view('<%=no %>');"><%=name %></a><%}else{ %><%=name %>　&nbsp;<%} %></td>
	
	 
	<td  ><%=Repalce(ID_Card,"/") %>　&nbsp;</td>	
    <td  >
	<%String strt="";
	String strs="";
	 
	if (tel.indexOf("/")>0)strt="/";
 
	if (sj.indexOf("/")>0)strs="/";
	 %>
	<%out.print(Repalce(tel,strt));  
	  %>&nbsp;<br><%=sj%></td>
	 
    
    <td   title="<%=address %>"> <%
	 
	if (address.length()>14)address=address.substring(0,14)+"...";
	if (!post.trim().equals(""))address+="("+post+")" ;
	out.print(address);
	%>&nbsp;</td>
	 
	
	 <td  ><%=loft+building+roomno %>&nbsp;</td>
	   <td   ><%=jzarea %>&nbsp;</td>
		    <td  ><%=rmbprice %>&nbsp;</td>
			  <td  ><%=yhje %>&nbsp;</td>
			
	 <td  ><%=ContractNo %>&nbsp;</td>
    <td  align="center"><%=VisaDate %>&nbsp;</td>
	<td align="center"><%=yong_tu %></td>
	<td  align="center"><%=sell%>&nbsp;</td>
   </tr>

<%

  }
   
   
}catch(Exception s){out.println(s.getMessage());}
 
rs.close();
if (eof.equals("false")){
   out.print("没有找到客户记录"); 
  
   }

 

 %> 
  <%@ include file="../public_js/changepage.jsp"%>
</table>
</form>
</center>

<script>
 
   var cusno="";
    function Edit(){
    	
   	         if (cusno==""){alert("请选择客户(只需单击列表中某行一次)");}
		     else{ openwin("CusFeedBack.jsp?cusno="+cusno,560,560,100,5);}
	
	}

	function Dele(){
	 if (confirm("真的要删除选择的客户信息吗？")){
   	      if (cusno==""){alert("请选择客户(只需单击列表中某行一次)");}
		else{openwin("deletecusdata.jsp?del=cus&cusno="+cusno,10,10,10,10);}
	  }
	}	
	function view(cusno){
	  if (cusno==""){alert("请选择客户(只需单击列表中某行一次)");}
		   else{openwin("editcustomer.jsp?cusno="+cusno,560,560,100,5);}
	  }

    function savepara(para){
			  cusno=para;
			
			  }
  function show(dd,obj){
  var  tr=document.all.AutoNumber.rows;

  for( var i=0;i<tr.length;i++){
    if (tr[i].trid=="tr"+dd)  
	 tr[i].style.display=(tr[i].style.display=="none")?"block":"none";
   }
   
  var img1="jia.gif";
  var img2="jian.gif";
  
  s=obj.src;
  no=parseInt(obj.no);
  if(s.indexOf("jian.gif")>-1){
     obj.src=s.replace("jian.gif","jia.gif");
  }else{
     obj.src=s.replace("jia.gif","jian.gif");
  }
  }
  function addCus(){
  //if (document.form1.section.value==""){alert("请选择楼盘");return false;}
   openwin('customerin.jsp',560,560,100,5)
   }
  function FindCusState(){
	document.form1.Find.value="o";
    document.form1.Findsection.value=document.form1.section.value;
    document.form1.cusche.value=document.form1.stateValue.options[document.form1.stateValue.selectedIndex].value;
   document.form1.submit();
  
  }
    function ch(para){
   if (para=="VisaDate"){
  fPopUpCalendarDlg(document.form1.search_like);return false;

  }
  else
  document.form1.search_like.value="";
  }
  
  function outexcel(){
    if (document.form1.section.value==""){alert("请选择项目");return false;}
	  window.open("ExcelTovisitcusview3.jsp?section="+document.form1.section.value)
  
  }
  
var sendmess="";
var sendto="";
 
function chhoseData1(){
sendmess="";
sendto="";
if (document.form1.choos.length){
   for (var i=0;i<document.form1.choos.length;i++){
 	
	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].value;
		
	    if (sendmess=="")
		 sendmess=aa.substring(0,aa.indexOf("|"));
		else
		 sendmess+=","+aa.substring(0,aa.indexOf("|"));
	  
	    if (sendto=="")
		 sendto=aa.substring(aa.indexOf("|")+1);
		else
		 sendto+=","+aa.substring(aa.indexOf("|")+1);
	  
	  }
    }
}else if (document.form1.choos.checked){
	 var aa=document.form1.choos.value;
	 sendmess=aa.substring(0,aa.indexOf("|"));
	 sendto=aa.substring(aa.indexOf("|")+1);
	}
}
function chhoseData(dd){
 
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
	 
    }

}
function sendmessage()
{
chhoseData1();
 
 if (sendmess==""){alert("你选择的客户可能没有手机号");return false;}
openwin1("../../sendmessage/SendMessage.jsp?messtype=4&sendmess="+sendmess+"&sendto="+sendto,400,300,100,100);
}
  
   
 function gcfx(){

  if (document.form1.section.value==""){alert("请选择项目");return false;}
  else {
      openwin("customerRate.jsp?custype=2&section="+document.form1.section.value,300,250,100,100);
	  }
  }
  </script>

</body>
</html>
