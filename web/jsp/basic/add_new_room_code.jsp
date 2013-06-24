<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>增加房间编码</title>
</head>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="add_new_room_code.js">
</script>
<%
String MAXROOM="";
String maxfloor="";
String building=getbyte1(request.getParameter("Build"));
String SecNo=getbyte1(request.getParameter("SecNo"));
String Loft=getbyte1(request.getParameter("Loft"));
String add=getbyte1(request.getParameter("add"));
String Finfo=""; 
String Scellname=getbyte1(request.getParameter("Scellname"));
String roomcode=getbyte1(request.getParameter("roomcode"));
String dyjgh=getbyte1(request.getParameter("dyjgh"));
if (!add.equals("")) {
Finfo=getbyte1(request.getParameter("Finfo"));  
String  BeginR= request.getParameter("BeginR");
  char BeR=BeginR.charAt(0);
  String intEndR="";
if(java.lang.Character.isDigit(BeR)){
	 intEndR=request.getParameter("BeginR");
	 if (java.lang.Integer.parseInt(intEndR)>9){
	   BeginR=Scellname+dyjgh+request.getParameter("BeginF")+intEndR;
	  }else{
	      BeginR=Scellname+dyjgh+request.getParameter("BeginF")+"0"+intEndR;
	  }
}
else{
	 intEndR=String.valueOf(Character.getNumericValue(BeR)-9);
      BeginR=Scellname+dyjgh+request.getParameter("BeginF")+BeginR;
}

 
  String SQL="";
  SQL="SELECT * FROM  ROOMNO WHERE SECTIONNO='"+SecNo+"' AND REGION='";
  SQL+=Loft+"' AND FLOOR="+request.getParameter("BeginF")+" AND room="+intEndR +" and cell='"+Scellname+"'";

SQL+=" AND building='"+building+"'";
   ResultSet rs=ViewBean.executeQuery(SQL);
  if (!rs.next()){
  SQL="INSERT INTO ROOMNO(SECTIONNO,REGION,BUILDING,FLOOR,";
  SQL+="ROOM,ROOMNO,FLOORTYPE,FLOORSHOW,floormess,cell) VALUES(";
  SQL+="'"+SecNo+"','"+Loft+"','"+building+"',"+request.getParameter("BeginF");
  SQL+=","+intEndR+",'"+BeginR+"',0,0,'"+Finfo+"','"+Scellname+"')";
  ViewBean.executeUpdate(SQL);
 }
 
 rs.close();
  %>
  <script>
  alert("已增加,请继续录入房间资料");
  opener.window.document.cus.submit();
  window.close();
  
  </script>
  <%

}
%>
<body >

   <p>&nbsp;</p>
  <p align="center"><b><font size="3" color="#000080">编码定义</font></b>
  <form method="POST" name="cus" action="" >

    <table border="0" width="100%"  align="center" cellspacing="0" bgcolor="#ffffff"  cellpadding="0" bordercolor="#ffffff" class="tablefill">
     <input type="hidden" name="roomcode" value=<%=getbyte2(request.getParameter("roomcode"))%>>

      <input type="hidden" name="intEndF" value="<%=request.getParameter("intEndF")%>">
	     <input type="hidden" name="Loft" value="<%=getbyte2(request.getParameter("Loft"))%>">
      <input type="hidden" name="Building" value=<%=getbyte2(request.getParameter("Build"))%>>
	  <input type="hidden" name="Build" value=<%=getbyte2(request.getParameter("Build"))%>>
   
	  <input type="hidden" name="SecNo" value=<%=request.getParameter("SecNo")%>>
      <input type="hidden" name="intEndR" value=<%=request.getParameter("intEndR")%>>
   
      <tr align="center" > 
        <td width="30%"   class=listtitle>&nbsp;<font color=white>楼&nbsp;层&nbsp;数</font></td>
        <td width="70%" class=roomright><input type=text name=BeginF onblur="toUpper(document.cus.BeginF);"  onkeydown="key(document.cus.EndF)" size="5" style="border-style: solid; border-width: 1" value="1" >&nbsp;附加字:<input type="text" name="Finfo"   size="7" style="border-style: solid; border-width: 1" >
          
         </td>
      </tr>
      <tr align="center" > 
        <td width="30%"   class=listtitle>&nbsp;<font color=white>房间序号</font></td>
        <td width="70%" class=roomright align="left"> 
&nbsp;&nbsp;<input type=text name=BeginR  onkeydown="key(document.cus.EndR)" size="5" style="border-style: solid; border-width: 1" value="1"　  Onblur="toUpper(document.cus.BeginR)">&nbsp;(数字或字母)
         
        </td>
      </tr>
	   <tr align="center" > 
        <td width="30%"   class=listtitle>&nbsp;<font color=white>单&nbsp;元&nbsp;号</font></td>
        <td width="70%" class=roomright> 
          &nbsp;<select name=Scellname>
		           <option value=""></option>
				    <option value="1">1单元</option>
					<option value="2">2单元</option>
					 <option value="3">3单元</option>
					 <option value="4">4单元</option>
					 <option value="5">5单元</option>
					 <option value="6">6单元</option>
					 <option value="7">7单元</option>
					 <option value="8">8单元</option>
					 <option value="9">9单元</option>
					 <option value="10">10单元</option>
					 <option value="11">11单元</option>
					  <option value="A">A单元</option>
					  <option value="B">B单元</option>
					  <option value="C">C单元</option>
					  <option value="D">D单元</option>
					  <option value="E">E单元</option>
					  <option value="F">F单元</option>
					  <option value="G">G单元</option>
					  <option value="H">H单元</option>
					    <option value="I">I单元</option>
						<option value="J">J单元</option>
				      <option value="K">K单元</option>
				 
		  		 
		  </select>
          <select name=dyjgh>
		           <option value="">无分隔</option>
				    <option value="-">-</option>
				  <option value="0">0</option>
				   <option value=" ">用空格分隔</option>
		  		 
		  </select>
        </td>
      </tr>
    </table>     
	<input type=hidden name=scell value="<%=request.getParameter("scell") %>">
	<p align="center"> 
            &nbsp;&nbsp; <input type=button name="add" value="提 交" onclick="SaveRoomCode('add_new_room_code.jsp?add=add');" >
           &nbsp;&nbsp;
            <input type=button name="add" value="退 出" onclick="window.close();">
          </P>
   
</form>     
    <script>
	function check(){
	   if (parseInt(document.cus.scell.value)>0&&document.cus.Scellname.value==""){
	    alert("请选择单元");
		document.cus.Scellname.focus();
		return false;
	   }
	    if (parseInt(document.cus.scell.value)==0&&document.cus.Scellname.value!=""){
	    alert("请不要选择单元");
		document.cus.Scellname.focus();
		return false;
	   }
	   document.cus.submit();
	}
	</script>
       
       
</body>       
</html>       
