<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<title></title>
</head>
<%@ page language="java" import="java.sql.*,java.lang.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/CodeSele.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%
  String para=request.getParameter("SecNo");
  String ParaSecname=para;
if (request.getParameter("pageno")==null){
   if(ParaSecname!=null){
   ParaSecname=new String(ParaSecname.getBytes("ISO8859_1"),"GBK");
   }
}
String rgpara=request.getParameter("rgpara");

 %>

<body  onload="setSelectMad(document.cus.SecNo,'<%=ParaSecname%>');setSelectMad(document.cus.tj1,'<%=request.getParameter("tj1")%>');setSelectMad(document.cus.tj,'<%=request.getParameter("tj")%>');">
<script language="javascript" src="../public_js/public.js">
</script>

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
<table border="0" width="104%">
           <tr>
			    <td width="104%"" valign="top" bgcolor="#96C7D1">
				&nbsp;楼盘&nbsp;<select name="SecNo" ONCHANGE="FindArry();">
                    <option value=""></option>
					<%
			   String SectionS=(String)session.getAttribute("Section");						
               String  Sql="select SerialNo,Name FROM crm_project where SerialNo in("+SectionS+")";
               ResultSet Rs1=ViewBean.executeQuery(Sql);
               while (Rs1.next()){
			       String sno=Rs1.getString("SerialNo");
			       String sna=getbyte(Rs1.getString("Name"));
	               %>
                   <option value=<%=sno+"*"+sna %>><%=sna %></option>
              <%}Rs1.close();%>
               </select>
        		<%@ include file="../public_js/selectSRB.jsp"%>	
					房间号&nbsp;<input type=text name=RoomCode size="5" style="border-style: solid; border-width: 1">
					楼层&nbsp;<input type=text name=Floor size="4" style="border-style: solid; border-width: 1">
					面积<select name=tj1><option value="=">=</option><option  value=">=">>=</option><option  value="<"><</option></select><input type=text  size="4" name=area style="border-style: solid; border-width: 1">
					<br>&nbsp;单价<select name=tj><option value="=">=</option><option value=">=">>=</option><option value="<"><</option></select><input type=text size="6" name=UnitPrice style="border-style: solid; border-width: 1">
					&nbsp;
					户型
	      <select name="RoomType">
		  <option></option>
		     <%
   for (int ii=0;ii<20;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
	      </select>
        <input type="submit" name="Search" value="查询">
		 <%String Cortrol=(String)session.getAttribute("popedomStr"); %>
	    <%if (Cortrol.indexOf("F")>=0){ %>
		<input type=button name=FindRg value='查看认购资料' onclick="window.location='rgsview.jsp?param=<%=request.getParameter("param") %>'">
		<%} %>
		
	   <%if (rgpara==null) rgpara="";
	   
	    if (rgpara.equals("ld")){
	   %>
	   <input type=button name=rgs value="临订" onclick="ld();">
	   <%}else{ %>
   	   <input type=button name=rgs value="认购" onclick="rg();">
	   <%} %>
      </td>
              </tr>
			 <tr></tr> 
  </table>
    <input type=hidden name=rgpara value=<%=request.getParameter("rgpara") %>>
  <%

String Search=request.getParameter("Search");
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
String Area="";
String UnitPrice="";
  if (Search!=null){
    Build=request.getParameter("build");
    if (Build==null) Build="";
	Loft=request.getParameter("Loft");
	if (Loft==null) Loft="";
    SecName=para.substring(para.indexOf("*")+1); 
	para=para.substring(0,para.indexOf("*"));
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
   UnitPrice=request.getParameter("UnitPrice");
   if (UnitPrice==null)UnitPrice="";
   if (!UnitPrice.equals("")){
      if (!SearchWhere.equals("")){
    	 SearchWhere=SearchWhere+" and UnitPrice "+request.getParameter("tj")+UnitPrice;}
	  else{
	      SearchWhere="and UnitPrice "+request.getParameter("tj")+UnitPrice;}
  }	 
}else{
out.close();
}

%>

   <script>
  document.cus.build.options[document.cus.build.length]=new Option('<%=Build %>','<%=Build %>');
  document.cus.Loft.options[document.cus.Loft.length]=new Option('<%=Loft %>','<%=Loft %>');
  document.cus.RoomCode.value="<%=RoomNo %>";
  document.cus.Floor.value="<%=Floor %>";
  document.cus.area.value="<%=Area %>";
  document.cus.UnitPrice.value="<%=UnitPrice %>";
  </script>
     
      
  <table border="0" width="100%" cellspacing=1 cellpadding=1>
    <tr> 
	  <td width="10%" align="center" height="23" bgcolor="#CFE6EB">座号</td>
      <td width="10%" align="center" height="23" bgcolor="#CFE6EB">栋号</td>
      <td width="6%" align="center" height="23" bgcolor="#CFE6EB">房间号</td>
	  <td width="10%" align="center" height="23" bgcolor="#CFE6EB">建筑面积</td>
      <td width="10%" align="center" height="23" bgcolor="#CFE6EB">套内面积</td>
      <td width="13%" align="center" height="23" bgcolor="#CFE6EB">户型</td>
      <td width="10%" align="center" height="23" bgcolor="#CFE6EB">装修状况</td>
      <td width="10%" align="center" height="23" bgcolor="#CFE6EB">总售价</td>
      <td width="8%" align="center" height="23" bgcolor="#CFE6EB">朝向</td>
      <td width="8%" align="center" height="23" bgcolor="#CFE6EB">状态</td>
    
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

	
   		sql="select R.*,S.Name from Room R inner join Section S on S.SerialNo=R.seccode where R.SaleState in('1','5','4') and R.Code "+start+SearchWhere;

  int Code=0;  
  int salestate=0;
  String build="";
  String roomno="";
  String area="";
  String RoomType="";
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
  ResultSet rs=ViewBean.executeQuery(sql);

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
	
   	Stype=getbyte(rs.getString("RoomType"));
	cx=getbyte(rs.getString("Direction"));
	jg=getbyte(rs.getString("Scene"));
	fitment=getbyte(rs.getString("Fitment"));
	salestate=rs.getInt("SaleState");
    area=df.format(rs.getFloat("UsedArea"));
	RoomType=getbyte(rs.getString("Roomtype"));
     Unitprice=df1.format(rs.getFloat("Unitprice"));
     price=rs.getFloat("Sumprice");      
	 countprice=df2.format(price);
      	sumprice=df3.format(price);
       picturepath=rs.getString("Map");
       TnUnitprice=df1.format(rs.getFloat("TNunitprice"));
	

	String name=rs.getString("Name");

  %>
  <%switch (salestate)
    {
	  case 1:
	       color="blue";
		   MessTitle="导入认购登记数据";
		   break;
	  
	}
		

  %>
 
    <tr id=TR<%=i %> align="center" BGCOLOR="#e6f9ff"  onmouseover="mout(this);"  onclick="savepara('<%=secno%>','<%=SecName%>','<%=roomno%>','<%=build%>','<%=Unitprice%>','<%=sumprice%>','<%=area %>','<%=RoomType%>','<%=fitment%>','<%=JzArears%>','<%=TnUnitprice%>','<%=loft %>','<%=Stype %>');Butcolo(this,'#EAECEC','#e6f9ff');" > 
     
	  <td width="10%"  height="16"><%=loft %></td>
      <td width="10%" align="center" height="23"><%=build %></td>
      <td width="10%"  height="16"><font color="<%=color%>"><%=roomno %></font></td>
      <td width="10%"  height="16"><%=JzArears %></td>
      <td width="10%"  height="16"><%=area %></td>
      <td width="11%"  height="16"><%=Stype %></td>
   
      <td width="9%"   height="16"><%= fitment.trim()%></td>
      <td width="10%"  height="16"><%=countprice%></td>
      <td width="4%"  height="16"><%=cx %></td>
      <td width="5%"  height="16">
	  <%if (salestate==1)out.print("未售");
	   if (salestate==4)out.print("预留");
   	   if (salestate==5)out.print("临订");
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

%>
</table>				  <hr size="1" color="#C0C0C0">
<script>

	 	 

   var secno="";
   var secname="";
   var roomno="";
   var build="";
   var unitprice="";
   var sumprice="";
   var area="";
   var roomtype="";
   var fl="";
   var fitment="";
   var jzarea="";
   var tnunitprice="";
   var loft="";
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
			  fl=para13;
			  }
			  
  function rg(){
  
	  if (secno==""){alert("请选择房间(只需单击列表中某行一次)");}
		   else{window.location="rgdj.jsp?para=in"+"&secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&unitprice="+unitprice+"&sumprice="+sumprice+"&area="+area+"&roomtype="+roomtype+"&fitment="+fitment+"&jzarea="+jzarea+"&tnunitprice="+tnunitprice+"&loft="+loft+"&fl="+fl;}
	  }
  function ld(){
      if (secno==""){alert("请选择房间(只需单击列表中某行一次)");}
	    else{window.location="TemporarilyBuy.jsp?secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&loft="+loft;}
	 } 
function Plan(){
      if (secno==""){alert("请选择房间(只需单击列表中某行一次)");}
	    else{window.location="BuyPlanBook.jsp?secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&loft="+loft+"&unitprice="+unitprice+"&sumprice="+sumprice+"&area="+area+"&roomtype="+roomtype+"&area="+area+"&jzarea="+jzarea+"&tnunitprice="+tnunitprice;}
	 } 
</script>
</form>
</body>
</html>