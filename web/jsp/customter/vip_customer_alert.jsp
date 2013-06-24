<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>诚意客户跟进提醒</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
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
 
String order=getbyte1(request.getParameter("order"));
String orderby=getbyte1(request.getParameter("orderby"));
 order=" order by a.date  " ;
 
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
   strWhere=" and b.section ='"+section+"'" ;
   FindCondition="b.section='"+section+"'";
   FindCondition=FindCondition+"&Find="+Find;
   FindCondition=FindCondition+"&cusche="+custype;
 
   if (year!=null&&year1==null){
	   if (year.length()>0){
		 if (strWhere.equals("")){strWhere=" and b.visit_date='"+year+"'";}
		 else {strWhere+=" and b.visit_date='"+year+"'";}
		 FindCondition=FindCondition+"&year="+year;
		}
    }
   if (year1!=null&&year==null){
	   if (year1.length()>0){
	   	 if (strWhere.equals("")){strWhere=" and b.visit_date='"+year1+"'";}
		 else {strWhere+=" and b.visit_date='"+year1+"'";}
		 FindCondition=FindCondition+"&year1="+year1;
	     }
    }
 
   if (year1!=null&&year!=null){
	   if (year1.length()>0){
	   	 if (strWhere.equals("")){strWhere=" and b.visit_date between '"+year+"' and '"+year1+"'";}
	     else strWhere+=" and b.visit_date between '"+year+"' and '"+year1+"'";
		 FindCondition=FindCondition+"&year1="+year1+"&year="+year;
	     }
    }


   CusType=request.getParameter("custype");
   BuyType=request.getParameter("gmyt");

 if ((CusName!=null)&&(CusName.length()>0)){
   if (tmp==null){
   CusName= new String(CusName.getBytes("ISO8859_1"),"GBK");
   }
    if (strWhere.equals("")){ strWhere=" and  b.Cus_Name like '%"+CusName+"%'";
	}else{ strWhere+=" and b.Cus_Name like '%"+CusName+"%'";}
   FindCondition=FindCondition+"&cusname="+CusName;
   }

 if ((CusAge!=null)&&(CusAge.length()>0)){
   if (strWhere.equals("")){strWhere=" and b.cus_age "+Condi+CusAge;}
   else{strWhere=strWhere+" and b.cus_age "+Condi+CusAge;}
   FindCondition=FindCondition+"&age="+CusAge;
 }

 if (CusType!=null){
   if (CusType.length()>0){
	   if (tmp==null){
	     CusType= new String(CusType.getBytes("ISO8859_1"),"GBK");
	   }
       if (strWhere.equals("")){strWhere=" and b.Cus_Type='"+CusType+"'";}
       else{strWhere=strWhere+" and b.Cus_Type='"+CusType+"'";}
   FindCondition=FindCondition+"&custype="+CusType;
   }  
 }  

 if (BuyType!=null){
  if (BuyType.length()>0){
    if (tmp==null){
    BuyType= new String(BuyType.getBytes("ISO8859_1"),"GBK");
    }
    if (strWhere.equals("")){strWhere=" and b.Purpose='"+BuyType+"'";}
    else{strWhere=strWhere+" and b.Purpose='"+BuyType+"'";}
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
     search_like=search_like.trim();
    if (!search_like.equals("")){
	 if (!fields.equals("visit_date"))
	searchWhere="  and "+fields+" like '%"+search_like+"%' ";
	else
	searchWhere="  and "+fields+" = '"+search_like+"' ";
	}
	 strWhere+=searchWhere;
  String lffs=China.getParameter(request,"lffs");
 if (lffs.equals("")||lffs.equals("0"))lffs="   and  b.visitstate=0";
 else lffs="   and  b.visitstate=1";
	
if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
 
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
	
	String PubPra=(String)session.getAttribute("Attribute");	
    String user=(String)session.getAttribute("loginname");	
	String job=(String)session.getAttribute("job");	
	 if (job.indexOf("销售员")>=0){
	    strWhere+=" and b.seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }
	//out.print(strWhere);
  
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
  
	String showGrade=getbyte1(request.getParameter("bir"));
	   String  sel="1";
 %>
<script>
function full(){
 setSelectMad(document.form1.section,'<%=request.getParameter("section") %>');
  setSelectMad(document.form1.order,'<%=request.getParameter("order") %>');

 setSelectMad(document.form1.fields,'<%=request.getParameter("fields") %>');
}
// oncontextmenu="return false" 
</script>

<body onload="full()"  leftmargin="0"  topmargin="0">
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
  <input type=hidden name="sel" value="<%=sel %>">
  <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
  <tr> 
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=1;findSub('vip_customer_alert.jsp');"> <font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>跟进提醒 
	</td>
   <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=2;findSub('visitcusview7.jsp');"> <font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>诚意一览 
	</td>
	</tr>
</table>
<p align=center class=FontColor><font size=3><b>待跟进客户一览表</b></p>
<%  
 
   int colnum=0;
   int iiii=0;
    
    %> 
	  <input type=hidden name="grade" >
  <input type=hidden name="sel" value="<%=sel %>">
  
	<script>
function findSub(para){
   document.form1.action=para+"?Search=b&Find=b";
   document.form1.submit();


}
</script>
 <%
//权限审核
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"C002");
 %>
 
 
   <table width=100% border="0"><tr height="16"  ><td align="left">楼盘：<select name="section" onchange="changesub(this.value);"> 
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
	 &nbsp;&nbsp;<select name="order" onchange="changesub(this.value);"><option value="visit_date">按来访日期排序</option><option value="cus_name">按来访姓名排序</option></select>
	  &nbsp;&nbsp;来访问方式:<select name="lffs" onchange="changesub(this.value);"><option value=0 <%if (China.getParameter(request,"lffs").equals("")||China.getParameter(request,"lffs").equals("0"))out.print("selected"); %>>来访</option><option value=1 <%if (China.getParameter(request,"lffs").equals("1"))out.print("selected"); %>>来电</option></select>
	 
	 <select name=fields onchange="ch(this.value);">
   <option value=cus_name>客户姓名</option>
   <option value=phone>固定电话</option>
     <option value=sj>手机号</option>
   <option value=address>联系地址</option>
   <option value=visit_date>来访日期</option>
   
   <input type=text name=search_like size=20 title="模糊查询，可查询姓名、电话、地址，双击可弹出日期" ondblclick="fPopUpCalendarDlg(search_like);return false;" value="<%=search_like %>"><input type=button name=fin value="查 询"  onclick="document.form1.submit();" ></td>  </tr></table>
   
<script>
			function printall() {
			   	printdiv.innerText ="";
                 print(); 
			}
			function ordersubmit(){
			 if (document.form1.section.value!="")
			     changesub(document.form1.section.value);
			 document.form1.submit();	 
			}
			function changesub(para){
			document.form1.Findsection.value=para;
			
			document.form1.Find.value="o";
	 			document.form1.submit();
			
			}
</script>
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
 


<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" >
  <td  width="6%"   align="left"><input type=checkbox name=ch onclick="chhoseData(this.checked);">序号</td>
   <td  align="center">来自区域</td>
    <td  align="center">VIP号</td>
  <td  align="center">客户姓名</td>
 
  <td  align="center">联系电话</td>
  <td  align="center">诚意日期</td>
  <td  align="center">失效日期</td>
 
  <td  align="center">销售员</td>
    <td  align="center">跟踪次数</td>
    <td  align="center">上次跟踪日期</td>
  
 <td  align="center">跟踪</td>

  </tr>
　
 <%	
  strWhere+=" and (b.state<>1)  "; 
  sql="select b.*,convert(char(10),a.date,120) gzdate,convert(char(10),c.dengji_riqi,120) rgdate, a.num,c.vipno,c.shixiao_riqi    from tail_after a,customer b,tb_chengyi c  where    b.serialno=c.serialno and  a.state=0 and a.cusno=b.serialno and cusno in (select cusno from      tail_after group by  cusno  ) and dateadd(dd,alert_day,a.date)<getdate() "+lffs +" and b.Section in("+SectionS+")   "+strWhere;
  
  ResultSet rs=null;

  rs=ViewBean.executeQuery(sql +order);
  try{
  int tr=0;
   while (rs.next()){
	 eof="true";
     i=i+1;
     region=getbyte(rs.getString("region"));
     boolean gzState=rs.getBoolean("gzState");
     no=rs.getString("SerialNo").trim();
	 String vip=getbyte(rs.getString("vipno"));
     name=getbyte(rs.getString("Cus_Name"));
     sex=getbyte(rs.getString("Cus_Sex"));
 
     tel=getbyte(rs.getString("Phone"));
	 sj=getbyte(rs.getString("sj"));
     address=getbyte(rs.getString("address"));
	 post=getbyte(rs.getString("Zip_Code"));
     
	 sell=getbyte(rs.getString("seller"));
	 date=getbyte(rs.getString("rgdate"));
	 if (!date.equals(""))date=date.substring(0,10);
	 String gz_date=getbyte(rs.getString("gzdate"));
	  String shixiao_riqi=getbyte(rs.getString("shixiao_riqi"));
	   if (!shixiao_riqi.equals(""))shixiao_riqi=shixiao_riqi.substring(0,10);
  %>
 
 <tr id=TR<%=i %>   trid=tr<%=tr %> align="center"    onmouseover="mout(this);"  onclick="savepara('<%=no%>');changeclass1(this,'clickbg','');" ondblclick="Edit('<%=no%>');" title="双击可显示登记跟踪情况或转为诚意客户"> 
 <td  width="5%" align="center"><input type="checkbox" name="choos" cusno=<%= no%> value="<%=sj+"|"+name%>"><%=i %>　</td>
 <td align="center"><%=region %>&nbsp;</td>
  <td align="center"><%=vip %>&nbsp;</td>
    <td  align="center"><a href="#" onclick="openwin('editcustomer.jsp?cusno=<%=no %>',560,560,100,5);" title="点击可以弹出窗口修改资料"><%=name %></a>　&nbsp;</td>
     <td  align="center">
	<%String strt="";
	String strs=""; 
	if (tel.indexOf("/")>0)strt="/"; 
	if (sj.indexOf("/")>0)strs="/";
	 %>
	 <%=tel%> <%=sj%>&nbsp;</td>	   
    <td  align="center"><%=date %>&nbsp;</td>
   <td  align="center"><%=shixiao_riqi %>&nbsp;</td>
 
	<td  align="center"><%=sell%>&nbsp;</td>
	<td  align="center"><%=getbyte(rs.getString("num")) %>&nbsp;</td>
	 <td  align="center"><%=gz_date %>&nbsp;</td>
	 <td  align="center"><a href="#"  onclick="savepara('<%=no%>');Edit('<%=no%>');"><%if (gzState){ %><font color=red>记录</font><%}else{ %>记录<%} %></a> </td>

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

</form>
</center>

<script>
 
   var cusno="";
    function Edit(para){
    	
   	         if (cusno==""){alert("请选择客户(只需单击列表中某行一次)");}
		     else{ openwin("CusFeedBack_sale.jsp?cusno="+para,560,560,100,5);}
	
	}

	function Dele(){
	 if (confirm("真的要删除选择的客户信息吗？")){
	    chhoseData11();
		 
	    if (cusno==""&&choosecusno=="")
   	      {alert("请选择客户(只需单击列表中某行一次)");}
		else{
		
		
		openwin("deletecusdata.jsp?del=cus&cusno="+cusno+"&choosecusno="+choosecusno,10,10,10,10);}
	  }
	}
	
	function view(){
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
    if (document.form1.section.value==""){alert("请选择楼盘名称，以确认增加的客户属于哪个楼盘的来访问客户");return false;}
     openwin('customerin.jsp?section='+document.form1.section.value,620,560,100,5)
   }
   function addCus1(){
    if (document.form1.section.value==""){alert("请选择楼盘名称，以确认增加的客户属于哪个楼盘的来访问客户");return false;}
     openwin('ExcelToCus.jsp?section='+document.form1.section.value,360,260,200,205)
   }
    function addCus2(){
    if (document.form1.section.value==""){alert("请选择楼盘名称，以确认增加的客户属于哪个楼盘的来访问客户");return false;}
    showx = screen.availWidth;  // + deltaX;
	showy = screen.availHeight; // + deltaY;
     	 retval = window.showModalDialog("customerTo.jsp?section="+document.form1.section.value,"","dialogWidth:"+showx+"; dialogHeight:"+showy+"; dialogLeft:150px; dialogTop:20px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	 }
   
  function FindCusState(){
	document.form1.Find.value="o";
    document.form1.Findsection.value=document.form1.section.value;
     document.form1.submit();
  
  }
  function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
	 
    }

}
  function ch(para){
   if (para=="visit_date"){
  fPopUpCalendarDlg(document.form1.search_like);return false;

  }
  else
  document.form1.search_like.value="";
  }
  
  
var sendmess="";
var sendto="";
var choosecusno=""; 
function chhoseData11(){
  choosecusno="";
  if (document.form1.choos.length){
   for (var i=0;i<document.form1.choos.length;i++){
 	
	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].cusno;
	 
	    if (choosecusno=="")
		 choosecusno="'"+aa+"'";
		else
		 choosecusno+=",'"+aa+"'";
	  }
	   
    }
	}else if (document.form1.choos.checked){
	  var aa=document.form1.choos.cusno;
	   choosecusno="'"+aa+"'";
	}
 
}
function ToLs(){
 if (confirm("确认选择的客户已不购房了吗？确认后，请回到流失客户中登记流失原因。"))
 { chhoseData11();
   openwin("toLSCustomer.jsp?cusno="+choosecusno,10,10,10,10);
 
 }
}
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
  function JH(){
 if (confirm("确认选择的客户转为机会客户吗？"))
 { chhoseData11();
  openwin("toJHCustomer.jsp?cusno="+choosecusno,10,10,10,10);
 
 }
}
function sendmessage()
{
chhoseData1();
 
 if (sendmess==""){alert("你选择的客户可能没有留下手机号，请重新选择客户");return false;}
openwin1("../../sendmessage/SendMessage.jsp?messtype=3&sendmess="+sendmess+"&sendto="+sendto,400,300,100,100);
}
  
  </script>

</body>
</html>
