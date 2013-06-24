<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>快速查找</title>
</head>
<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
<script language="javascript" src="../public_js/public.js">
</script>
 	<script>
   function fuu(){
     setSelectMad(document.form1.SecN,'<%=request.getParameter("SecN") %>');
setSelectMad(document.form1.roomtype,'<%=getbyte1(request.getParameter("roomtype")) %>');
setSelectMad(document.form1.dec,'<%=getbyte1(request.getParameter("dec")) %>');
setSelectMad(document.form1.floors,'<%=getbyte1(request.getParameter("floors")) %>');


  }
  </script> 
 <body onload="fuu();">
 
 
<form method="POST" name="form1" action="searcher.jsp"  >
<input type=hidden name=SecNo>
<input type=hidden name=Loft>
<input type=hidden name=SecName>
<input type=hidden name=Building>
<input type=hidden name=choose>
<input type=hidden name=Floor>
<input type=hidden name=RoomType>
<input type=hidden name=UnitPrice>
<input type=hidden name=area>
<input type=hidden name=RoomCode>
<input type=hidden name=condi value="ok">
 
<%@ include file="../public_js/CheckSection.jsp"%>
<%
 String StrSql="select type,codename from CODE  where type in ('A','D') order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[500];
   String CodeType[]=new String[500];
   codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
     CodeType[i]=getbyte(codeRS.getString("type"));
     CodeName[i]=getbyte(codeRS.getString("codename"));
	 i++;
   }
   codeRS.close();
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
	  ResultSet rs2=ViewBean.executeQuery(sql);
	  String sec="";
	  String no="";
  %> 
  <table> <tr> <td> 
    &nbsp;楼&nbsp;&nbsp;盘 
 &nbsp;<select name="SecN" style="width:117" onchange="document.form1.submit();" > 
     <option>请选择楼盘名称<option>
<%
while (rs2.next()){
	   no=rs2.getString("SerialNo");
	   
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no+"'>"+sec+"</option>");
	  }
	    rs2.close();
     %> </select>&nbsp;&nbsp; 户&nbsp;&nbsp;型:
	 <select name="roomtype">
	 	 <option></option>
	 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %>
	 
	 </select>
	  &nbsp;&nbsp;
	 朝&nbsp;&nbsp;向:
	 <select name="dec">
	 <option></option>
	 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("D"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %>	 
	 </select>
	 &nbsp;&nbsp;
	 楼&nbsp;&nbsp;层:
	 <select name="floors">
	 <option></option>
	 <%
   for (int iii=1;iii<30;iii++){
		 
	       out.print("<option value="+String.valueOf(iii)+">"+String.valueOf(iii)+"层</option>");
		         }
  %>	 
	 </select>
 &nbsp;&nbsp;
	 </td></tr><tr><td>
	  <%
String no1=getbyte1(request.getParameter("SecN")); 
if (!no1.equals(""))no1=" where  seccode='"+no1+"'";
else no1=" where  seccode=' '";
sql="select loft,loft+right(room_code,1) roomno FROM room "+no1;
sql+="   group by loft,loft+right(room_code,1)";
	 rs2=ViewBean.executeQuery(sql);
	 String loftstr="";
	 while (rs2.next()){
	 String loft=getbyte(rs2.getString("loft"));
	 String roomno=getbyte(rs2.getString("roomno")) ;
	 if (!loftstr.equals("")&&!loftstr.equals(loft)){out.print("<br>");}
	 loftstr=loft;
	 %>
	 <%=roomno %><input name="chooseloft" type="checkbox"  value="<%=roomno%>">
	 <%
	 } rs2.close();
	  %>
	  </td></tr>	  
	 </table>
	  
	 <input type=submit name=find value="搜 索">
 	  <%
String roomtype=getbyte1(request.getParameter("roomtype"));
String dec=getbyte1(request.getParameter("dec"));
String tmp=request.getParameter("pageno");
String [] Lofts=request.getParameterValues("chooseloft");

  String LoftName="";
   if (Lofts!=null){
   for (int a=0;a<Lofts.length;a++){
       if (LoftName.equals(""))  LoftName="'"+getbyte1(Lofts[a])+"'";
	   else LoftName+=",'"+getbyte1(Lofts[a])+"'";
   }
   }
 i=0;
 if (!LoftName.equals(""))
    LoftName=" and loft+right(room_code,1) in ("+LoftName+")";
 SecNo=request.getParameter("SecN");
String floors=request.getParameter("floors");
String room=request.getParameter("roomno");
String Loft="";
String Build="";
String RoomNo="";
String Floor="";
String state="";
String MessTitle="";
String SearchWhere="";
 no="";
String na="";	
String SecName="";
String secpara="";
String JZAREA="";
String RoomType="";
String unitprice="";
String CX="";
try{
   if (!SecNo.equals("")){
     	secpara=SecNo;
		SearchWhere=" and seccode ='"+SecNo+"'";
	}  
   if (!dec.equals("")){
    
		SearchWhere+=" and Direction ='"+dec+"'";
	}  
 if (!roomtype.equals("")){
		SearchWhere+=" and RoomType ='"+roomtype+"'";
	}  
  
  if (!floors.equals("")){
		SearchWhere+=" and floor="+floors;
	}  	
}catch(Exception s){out.close();}
%> 
		   <p align=center ><font size=4 class=FontColor><b><%=SecName %>房间资料表</b></font></p>
   	<input type=button name=ss value="客户选房试算" onclick="chhoseData1();">&nbsp;&nbsp;如果有额外的优惠，请填写优惠折扣数：<input type=text name=yh size=10 value="98"> "0"表示没有额外的优惠.
   <table BORDER=0 width="140%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center >
  <tr  valign="top">
  <td> 
  
<%
  String secno="";
   sql="";
  String eof="";
  //设置分页用的变量及分页条件计算
String FindCon=(String)request.getParameter("condtion");

  sql="select  count(*) num  from Room where type=1   and  salestate=1 and seccode='"+SecNo+"'   "+SearchWhere+LoftName;
    ResultSet rs=null;
 int colnum=0;
  rs=ViewBean.executeQuery(sql);
  if (rs.next()){
  colnum=rs.getInt("num");
  }
  rs.close();
  if (colnum%2!=0)colnum=colnum/2+1;
  else colnum=colnum/2;
 
   sql="select   *  from Room where type=1   and  salestate=1 and seccode='"+SecNo+"'   "+SearchWhere+LoftName+" order by loft, floor,Room_code";
 
 
  int Code=0;  
  int salestate=0;
  String build="";
  String roomno="";
  String area="";
  String Stype="";
  String jg="";
  String fitment="";
  String countprice="";
  String JzUnitprice="";
  String TnUnitprice="";
  String loft="";
  String cx="";
  String color="";
  String area1="";
  double sumarea=0;
  double sumtnarea=0;
  
  String Floo="";
  String RoomNo1="";
 
  try{
  rs=ViewBean.executeQuery(sql);

   i=0;
   int j=0;
 while (rs.next()){
	 i++; 
	 j++;
	Code=rs.getInt("code");
	secno=rs.getString("seccode");
	loft=getbyte(rs.getString("Loft"));
	build=getbyte(rs.getString("building"));
	roomno=rs.getString("Room_code");
    RoomNo1  =rs.getString("Room");
    area=FormatD.getFloat(rs.getFloat("Area"),2);
	sumarea+=rs.getDouble("Area");
    Floo=rs.getString("Floor");
	cx=getbyte(rs.getString("Direction"));
	jg=getbyte(rs.getString("Scene"));
	fitment=getbyte(rs.getString("Fitment"));
	salestate=rs.getInt("SaleState");
    area1=FormatD.getFloat(rs.getFloat("UsedArea"),2);
	sumtnarea+=rs.getDouble("UsedArea");
	Stype=getbyte(rs.getString("RoomType"));
	JzUnitprice=rs.getString("Unitprice"); 
    countprice=rs.getString("Sumprice");
	TnUnitprice=rs.getString("TNunitprice");	
	if (i>colnum) {out.print("</table></td><td>");i=1; } 
	if (i==1){
  %>
  <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center >
  <tr class=listtitle>
      <td   align="center"   ><font color=white>序号</font></td>
      <td   align="center"   ><font color=white>房间代码</font></td>
      <td   align="center"   ><font color=white>建筑面积</font></td>
      <td   align="center"   ><font color=white>建筑单价</font></td>
      <td   align="center"   ><font color=white>套内面积</font></td>
   
      <td   align="center"   ><font color=white>户型</font></td>
 
      <td   align="center"   ><font color=white>总售价</font></td>
     
	   <td   align="center"   ><font color=white>试算</font></td>
       <td   align="center"   ><font color=white>试算</font></td>
   	    </tr>
    <%} %>		
    <tr id=TR<%=j %> title="双击可修改或查看资料" align="center" class='listcontent' onmouseover="mout(this);"  onclick="savepara('<%=Code %>','<%=secno%>','<%=build%>','<%=roomno%>','<%=loft %>','<%=Floo %>','<%=RoomNo %>','<%=RoomNo1 %>');changeclass1(this,'clickbg','listcontent');"  ondblclick="Edit();" > 
      <td    ><%=j %><input name="chooseroom" type="checkbox" value="<%=Code %>"></td>
      <td    ><font color="<%=color%>"><%=loft+build+roomno %></font></td>
      <td    ><%=area %></td>
      <td    ><%=JzUnitprice %></td>
      <td    ><%=area1 %></td>
    
      <td    ><%=Stype %></td>
     
      <td    ><%=countprice.trim() %></td>
     
	    <td   ><%=getbyte(rs.getString("readnum")) %></td>
      <td   ><a href="#" onclick="openwinzy('zy.jsp?code=<%=Code %>',450,350,100,100);" title="打印置业计划书">打印</a></td>
      </tr>
    <%if (i>colnum+1) {out.print("</table"); } 
}
  rs.close();
  out.print("</td></tr>");
}catch(Exception s)  {out.print(s.getMessage());out.close();}
 if (eof.equals("false")){
  out.print("</table>");
  out.print("此栋没有资料");
  out.print("<a href='javascript:window.history.back(1)'>返回</a>");
 
} 

%>
<tr class='listcontent' align="center"><td>合计：</td><td></td><td><%=FormatD.getFloat2(sumarea,2)%></td><td></td><td><%=FormatD.getFloat2(sumtnarea,2) %></td><td><td></td><td></td><td></td></td><td></td><td></td><td></td></tr>
</table>
</form> 
 <SCRIPT language=javascript >
function openwinzy(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
</SCRIPT>
  <script>
   var secid="";
   var secno="";
   var build="";
   var loft="";
   var room="";
   var Floo=""
   var EndR="";
   var sendmess="";
function chhoseData1(){
sendmess="";
   for (var i=0;i<document.form1.chooseroom.length;i++){
 	 
	  if (document.form1.chooseroom[i].checked){
	    var aa=document.form1.chooseroom[i].value;
		
	    if (sendmess!="")
		 
		 sendmess+=","+aa;
	    else
		   sendmess=aa;
	  
	  }
    }
	 if (sendmess==""){alert("请选择需要试算的单位");}
	 else { openwinzy("zy1.jsp?code="+sendmess+"&yh="+document.form1.yh.value,550,450,100,100);}

}
    function Edit(){
    	
   	         if (secid==""){alert("请选择房间(只需单击列表中某行一次)");}
		     else{openwin("../basic/showroomdate.jsp?loft="+loft+"&secno="+secno+"&roomno="+room+"&floor="+Floo+"&MaxFloor="+Floo+"&build="+build+"&BengR="+EndR+"&EndR="+EndR,400,450,100,100); }
	  }
	

	function Dele(){
	 if (confirm("真的要删除选择的房间信息吗？")){
   	      if (secid==""){alert("请选择房间(只需单击列表中某行一次)");}
		   else{openwin("RoomDelete.jsp?secno="+secno+"&roomno="+room+"&build="+build+"&code="+secid,400,350,100,100); }
	  }
	}
	function view(){
	       if (secid==""){alert("请选择房间(只需单击列表中某行一次)");}
		     else{openwin("RoomEdit.jsp?loft="+loft+"&seccode="+secno+"&Room_code="+room+"&Floor="+Floo+"&MaxFloor="+Floo+"&building="+build+"&BengR="+EndR+"&EndR="+EndR,400,450,100,100); }
	}
    function savepara(para,para1,para2,para3,para4,para5,para6,para7){
			  secid=para;
			  secno=para1;
			  build=para2;
			  room=para3;
			  loft=para4;
			  Floo=para5;
			  EndR=para7;		
			 
			  }
  
  </script>

</body>
</html>