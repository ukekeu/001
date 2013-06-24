<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<title></title>
</head>

<%@ page language="java" import="java.sql.*,java.lang.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>

<%@ include file="../public_js/CodeSele.jsp"%>
<%
  String para=request.getParameter("SecNo");
  String ParaSecname=para;
if (request.getParameter("pageno")==null){
   if(ParaSecname!=null){
   ParaSecname=new String(ParaSecname.getBytes("ISO8859_1"),"GBK");
   }
}
String rgpara=request.getParameter("rgpara");

String Search=request.getParameter("Search");

 %>

<body >
<script language="javascript" src="../public_js/public.js"></script>

<script>
function check(aForm){
   if (aForm.SecNo.value<1)
		{
	        alert("请选择查询条件！");
	        aForm.SecNo.focus();
	        return false;
		}
	    return (true);
}		
</script>		
 <p align="center"><b><font size="3" color="#000080">未售房间资料一览表</font></b></td>
<form method="get" name="cus" action="RoomChooseView.jsp?SecNo=<%=para %>" onsubmit="return check(this);" >
<input type=hidden name=param  value=<%=request.getParameter("param") %>>
  <table width=100%><tr height="16" bgcolor="#EAEAEA"><td align="right">	   
   	   <img src="../picture/button_xq.gif" onclick="view();">
	   <img src="../images/button_linding.gif"  onClick="LDROOM();">
	   <img src="../images/button_ajss.gif" onClick="AJ();">
	    <img src="../images/button_xfjj.gif"  onClick="ChooseRoom();">
</td></tr></table>		
   	  <!-- <input type=button name=CH value="收费标准" onclick="Changes();">
	   <img src="../images/button_fkjh.gif"  onclick="Plan();">-->
		
 <table width=100%><tr height="3"><td></td></tr></table>    
    <input type=hidden name=rgpara value=<%=request.getParameter("rgpara") %>>
  <%
String tmp=request.getParameter("pageno");
String SecNo="";
String Build="";
String RoomNo="";
String Floor="";
String state="";
String MessTitle="";
String SearchWhere="";
String no="";
String na="";		
String picturepath=""; 
String SecName="";
String Loft="";
String RoomType="";
String Area="";
String UnitPrice="";
  if (Search==null)Search="";
  if (!Search.equals("")){
    Build=request.getParameter("Building");
    if (Build==null) Build="";
	Loft=request.getParameter("Loft");
	if (Loft==null) Loft="";
    if (para.indexOf("*")>=0){
	SecName=para.substring(para.indexOf("*")+1); 
	para=para.substring(0,para.indexOf("*"));
    }
    if (tmp==null){
	 Build=new String(Build.getBytes("ISO8859_1"),"GBK");
	 Loft=new String(Loft.getBytes("ISO8859_1"),"GBK");
     Search=new String(Search.getBytes("ISO8859_1"),"GBK");
     SecName=new String(SecName.getBytes("ISO8859_1"),"GBK");
	 para=new String(para.getBytes("ISO8859_1"),"GBK");
	
	}
       
   if (!para.equals("")){
     if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and seccode ='"+para+"'";
		 }  
		else {
		   SearchWhere=" and seccode ='"+para+"'";
		   }
		 }  
     if (!Loft.equals("")){
       
        if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and Loft ='"+Loft+"'";
		 }  
		else {
		   SearchWhere=" and Loft ='"+Loft+"'";
		   }
		 }   
   if (!Build.equals("")){
       
        if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and Building ='"+Build+"'";
		 }  
		else {
		   SearchWhere=" and Building ='"+Build+"'";
		   }
		 }  
   RoomNo=request.getParameter("RoomCode");
   if (!RoomNo.equals("")){
      if (!SearchWhere.equals("")){
           SearchWhere=SearchWhere+" and Room_Code like '%"+RoomNo+"%'";}
      else{
	      SearchWhere="and Room_Code like '%"+RoomNo+"%'";}
	
	}  		   
   Floor=request.getParameter("Floor");
   if (Floor==null)Floor="";
   if (!Floor.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and Floor ="+Floor;}
	  else{
	      SearchWhere="and Floor ="+Floor;}
  }	 
   Area=request.getParameter("area");
   if (Area==null)Area="";
   if (!Area.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and Area "+request.getParameter("tj1")+Area;}
	  else{
	      SearchWhere="and Area "+request.getParameter("tj1")+Area;}
  }	 
  
   RoomType=China.getParameter(request,"RoomType");

   if (!RoomType.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and RoomType='"+RoomType+"'";}
	  else{
	      SearchWhere="and  RoomType='"+RoomType+"'";}
  }	 
   
   UnitPrice=request.getParameter("UnitPrice");
   if (UnitPrice==null)UnitPrice="";
   if (!UnitPrice.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and UnitPrice "+request.getParameter("tj")+UnitPrice;}
	  else{
	      SearchWhere="and UnitPrice "+request.getParameter("tj")+UnitPrice;}
  }	 
}else{
  String SectionS=(String)session.getAttribute("Section");	

  String defaultNo=(String)session.getAttribute("defaultNo");	
  if (defaultNo==null)defaultNo="";
  if (!defaultNo.equals(""))SectionS="'"+defaultNo+"'";
  SearchWhere=" and seccode in("+SectionS+")";
  

}
%>

     
  <table border="0" width="100%" cellspacing=1 cellpadding=1>
     <tr class=listtitle>
      <td  align="center" height="23"  ><font color=white>序号</font></td>
      <td  align="center" height="23"  ><font color=white>房间号</font></td>
	  <td  align="center" height="23"  ><font color=white>建筑面积</font></td>
      <td  align="center" height="23"  ><font color=white>套内面积</font></td>
      <td  align="center" height="23"  ><font color=white>户型</font></td>
      <td  align="center" height="23"  ><font color=white>装修状况</font></td>
      <td  align="center" height="23"  ><font color=white>总售价</font></td>
      <td  align="center" height="23"  ><font color=white>朝向</font></td>
      <td  align="center" height="23"  ><font color=white>状态</font></td>
    
	    </tr>
  
<%

  String secno="";
  String sql="";
  //设置分页用的变量及分页条件计算
String FindCon=(String)request.getParameter("condtion");
	if (FindCon!=null){
    	FindCon=" = "+FindCon;
    	}
    else{
	   FindCon="<>'2' ";
	 }  
	String condtion=FindCon;	
	
    String start="";
	int startnum=0;
    int pageSize=10;
    int pageno;
    String eof="false";
	

   if(tmp==null ||tmp.length()==0){
       pageno=1;
	   }
   else{
      pageno=Integer.parseInt(tmp);
	  }
   if (request.getParameter("startnum")!=null){
   	    start=" >"+request.getParameter("startnum");
	}
   else{
	 start=" >0";
	}
    int previous=pageno-1;
    int next=pageno+1;

	
   		sql="select R.*,S.Name from Room R inner join Section S on S.SerialNo=R.seccode where R.SaleState in('1') and R.Code "+start+SearchWhere;

  int Code=0;  
  int salestate=0;
  String build="";
  String roomno="";
  String area="";
  String Stype="";
  String jg="";
  String fitment="";
  String countprice="";
  String sumprice="";
  float price=0;
  String cx="";
  String color="";
  String Unitprice="";
  String TnUnitprice="";
  String JzArears="";
  String loft="";   

  ResultSet rs=null;
  try{
  rs=ViewBean.executeQuery(sql);

   i=0;
  java.text.DecimalFormat df = new java.text.DecimalFormat("####.####"); 
  java.text.DecimalFormat df1 = new java.text.DecimalFormat("#########.##"); 
  java.text.DecimalFormat df2 = new java.text.DecimalFormat("###,###,###"); 
  java.text.DecimalFormat df3 = new java.text.DecimalFormat("########"); 
 

 while (rs.next()&& i<pageSize){
	 eof="true";
     i=i+1; 
	 if (i==pageSize){
       startnum=rs.getInt("code");
     }
	secno=rs.getString("seccode");
	loft=getbyte(rs.getString("loft"));
	build=getbyte(rs.getString("building"));
	roomno=rs.getString("Room_code");
	JzArears=df.format(rs.getFloat("Area"));
	
   
	cx=getbyte(rs.getString("Direction"));
	
	jg=getbyte(rs.getString("Scene"));
	fitment=getbyte(rs.getString("Fitment"));
	salestate=rs.getInt("SaleState");
    area=df.format(rs.getFloat("UsedArea"));
	Stype=getbyte(rs.getString("RoomType"));
     Unitprice=df1.format(rs.getFloat("Unitprice"));
     price=rs.getFloat("Sumprice");      
	 countprice=df2.format(price);
     sumprice=df3.format(price);
     picturepath=rs.getString("Map");
     TnUnitprice=df1.format(rs.getFloat("TNunitprice"));
	 
	 SecName=getbyte(rs.getString("Name"));
	
  %>
  <%switch (salestate)
    {
	  case 1:
	       color="blue";
		   MessTitle="导入认购登记数据";
		   break;
	  
	}
		

  %>
 
    <tr id=TR<%=i %> align="center"  class=listcontent   onmouseover="mout(this);"  onclick="savepara('<%=secno%>','<%=SecName%>','<%=roomno%>','<%=build%>','<%=Unitprice%>','<%=sumprice%>','<%=area %>','<%=Stype %>','<%=fitment%>','<%=JzArears%>','<%=TnUnitprice%>','<%=loft %>','<%=cx %>');changeclass1(this,'clickbg','listcontent');" > 
     
      <td  height="16"><%=i %></td>
      <td  height="16" align="left"><font color="<%=color%>"><%=loft+build+"."+roomno %></font></td>
      <td  height="16" align="right"><%=JzArears %></td>
      <td  height="16" align="right"><%=area %></td>
      <td  height="16"><%=Stype %></td>
   
      <td  height="16" align="left"><%= fitment.trim()%></td>
      <td  height="16" align="right"><%=countprice%></td>
      <td  height="16" align="left"><%=cx %></td>
      <td  height="16" align="left">
	  <%if (salestate==1)out.print("未售");
	   if (salestate==4)out.print("<font color='#8DE4A6'>预留</font>");
   	   if (salestate==5)out.print(" <font color='#FF00FF'>临订</font>");
	   %>
	  </td>
     
       </tr>
    <%
}
  if (eof.equals("false")){
  out.print("</table>");
  out.print("此页没有数据（已到未页）");
  out.print("<a href='javascript:window.history.back(1)'>返回</a>");
 }
else{
   out.print("<table  name='page' width='100%'><br>"  );
   out.print("<tr>");
  //翻页
 //计算总记录数及页数
  int sumnum=0;
  int pagecount=0;
   	sql="select count(*) as num  from Room  where SaleState='1' "+SearchWhere;

   try{
   	 ResultSet rs3=ViewBean.executeQuery(sql);
 	 if (rs3.next()){
	    sumnum=rs3.getInt("num");
	 }
	
	 rs3.close();
	 pagecount=sumnum/pageSize;
     if (pagecount==0){pagecount=pagecount+1;}
	 else if (sumnum%pageSize>0){pagecount=pagecount+1;}
	}
	catch(Exception ex){out.print(sql);}
  
  if(previous <= 0){
    out.print("<td width='15%'   class='L2'><p align=right>上一页&nbsp;&nbsp;&nbsp;");
	out.print("第"+String.valueOf(pageno)+"页/共"+String.valueOf(pagecount)+"页&nbsp;&nbsp;共"+String.valueOf(i)+"条&nbsp;&nbsp;");
    if (pageno<pagecount){
       out.print("<a href=\"RoomChooseView.jsp?SecNo="+ParaSecname+"&Search="+Search+"&Floor="+Floor+"&RoomCode="+RoomNo+"&Loft="+Loft+"&build="+Build+"&state="+state+"&startnum="+startnum+"&rgpara="+rgpara+"&condtion"+condtion+"&pageno=" + next + "\">下一页</a></td>");
    }else{out.print("下一页</td>");}
    }
  else{
  	 out.print("<td width='15%'  class='L2'><p align=right><a href="+"javascript:window.history.back(1)"+">上一页</a>&nbsp;&nbsp;&nbsp;");	out.print("第"+String.valueOf(pageno)+"页/共"+String.valueOf(pagecount)+"页&nbsp;&nbsp;共"+String.valueOf(i)+"条&nbsp;&nbsp;");
    if (pageno<pagecount){
	   out.print("<a href=\"RoomChooseView.jsp?SecNo="+ParaSecname+"&Search="+Search+"&Floor="+Floor+"&RoomCode="+RoomNo+"&Loft="+Loft+"&build="+Build+"&state="+state+"&startnum="+startnum+"&rgpara="+rgpara+"&condtion"+condtion+"&pageno=" + next + "\">下一页</a></td>");
  	 }else{out.print("下一页</td>");}
  }
 out.print("</tr>"); 
} 
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
%>
</table>				 
 <input type=hidden name="SecNo">
 <input type=hidden name="Loft">
 <input type=hidden name="Building">
 <input type=hidden name=RoomCode size="5">
 <input type=hidden name=Floor size="4" >
 <input type=hidden name=tj1>
 <input type=hidden  size="4" name=area >
 <input type=hidden name=tj>
 <input type=hidden size="6" name=UnitPrice>
 <input type=hidden name="RoomType">
 <input type="hidden" name="Search" value="查询">
<script>

	 	 

   var secno="";
   var secname="";
   var roomno="";
   var build="";
   var unitprice="";
   var sumprice="";
   var area="";
   var roomtype="";
   var fitment="";
   var jzarea="";
   var tnunitprice="";
   var loft="";
    var cx="";
	function view(){
	       if (secno==""){alert("请选择房间(只需单击列表中某行)");}
		   else{openwin("../basic/showroomdate.jsp?secno="+secno+"&roomno="+roomno+"&build="+build+"&show=true",400,450,100,10); }
	}
	
   function savepara(para1,para2,para3,para4,para5,para6,para7,para8,para9,para10,para11,para12,para13){
			  secno=para1;
			  secname=para2;
			  roomno=para3;
			  build=para4;
			  unitprice=para5;
			  sumprice=para6;
			  area=para7;
			  roomtype=para8;
			  fitment=para9;
			  jzarea=para10;
			  tnunitprice=para11;
			  loft=para12;
			  cx=para13;
			  }
			  

 function Changes(){
      if (secno==""){alert("请选择房间(只需单击列表中某行一次)");}
	    else{window.location="../sys/ChangesList.jsp?sumprice="+sumprice;}
	 } 
  function LDROOM(){
      if (secno==""){alert("请选择房间(只需单击列表中某行一次)");}
	    else{openwin("../sale/TemporarilyBuy1.jsp?secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&loft="+loft+"&jzarea="+jzarea,500,300,100,10);}
	 } 
 function AJ(){
      if (secno==""){alert("请选择房间(只需单击列表中某行一次)");}
	    else{openwin("../public_js/calculator1.jsp?secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&loft="+loft+"&sumprice="+sumprice+"&area="+area,500,400,100,10);}
	 } 	 
function Plan(){
      if (secno==""){alert("请选择房间(只需单击列表中某行一次)");}
	    else{window.location="../sale/BuyPlanBook.jsp?secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&loft="+loft+"&unitprice="+unitprice+"&sumprice="+sumprice+"&area="+area+"&roomtype="+roomtype+"&area="+area+"&jzarea="+jzarea+"&tnunitprice="+tnunitprice;}
	 } 
function ChooseRoom(){
      if (secno==""){alert("请选择房间(只需单击列表中某行一次)");}
	    else{openwin("../sale/ChooseRoomCount.jsp?secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&loft="+loft+"&unitprice="+unitprice+"&sumprice="+sumprice+"&area="+area+"&roomtype="+roomtype+"&area="+area+"&jzarea="+jzarea+"&tnunitprice="+tnunitprice+"&cx="+cx,450,300,200,100);}
	 } 	 
</script>
</form>

</body>
</html>