<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>房间编码</title>
</head>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript>
 function Validate(aForm)
   {
  
      
		if (aForm.BeginF.value.length<1)
	    	{
	    	alert("请输入起始楼层！");
	        aForm.BeginF.focus();
	        return (false);
	    	}		
		
	   if (aForm.BeginR.value.length<1)
	    	{
	    	alert("请输入起始房号！");
	        aForm.BeginF.focus();
	        return (false);
	    	}		
	  	  
      return (true);		
	}	
function check(aa,para){
   var a1=aa.value;
   if (para=="A"){
    if (parseInt(a1)>parseInt(document.cus.intEndF.value))
	{
	  alert("楼层数不能超过"+document.cus.intEndF.value);
	  document.cus.BeginF.value="";
	}
	}else{
	 
	  if (parseInt(a1)>parseInt(document.cus.intEndR.value))
	{
	  alert("房号数不能超过"+document.cus.intEndR.value);
	  document.cus.BeginR.value="";
	}
	
	}
  }  
function toUpper(aa){
    var a=aa.value;
	if (a!=""){
	var upp="ABCDEFGHIJKO";
    aa.value=a.toUpperCase();

	 if (aa.name=="EndR"){
	 if (isNaN(a)&&(upp.indexOf(document.cus.BeginR.value)<0||upp.indexOf(document.cus.EndR.value)<0)){
	    alert("如果是以字母来编码，只能在A--O");
	    aa.focus();
		aa.select();
	    return false;
	 }
	 }
	  
	
	} 
	
  }
   function SaveRoomCode(){
    if (Validate(document.cus))
	{document.cus.action="add_new_room_code.jsp?add=add";
	 document.cus.submit();
     }
   }
</script>
<%
String MAXROOM="";
String maxfloor="";
String building=getbyte1(request.getParameter("Build"));
String StrSecNo=getbyte1(request.getParameter("SecNo"));
String Loft=getbyte1(request.getParameter("Loft"));
String add=getbyte1(request.getParameter("add"));
String roomcode=getbyte1(request.getParameter("roomcode"));
String Scellname=getbyte1(request.getParameter("Scellname"));
String dyjgh=getbyte1(request.getParameter("dyjgh"));
if (!add.equals("")) {
  
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
  alert("已增加");
  opener.document.cus.submit();
 /window.close();
  
  </script>
  <%

}
%>
<body >

   <p>&nbsp;</p>
  <p align="center"><b><font size="3" color="#000080">编码定义</font></b>
  <form method="POST" name="cus" action="" >

    <table border="0" width="60%"  align="center" cellspacing="0" bgcolor="#ffffff"  cellpadding="0" bordercolor="#ffffff" class="tablefill">
      <input type="hidden" name="roomcode" value=<%=getbyte2(request.getParameter("roomcode"))%>>

      <input type="hidden" name="intEndF" value="<%=request.getParameter("intEndF")%>">
	     <input type="hidden" name="Loft" value="<%=getbyte2(request.getParameter("Loft"))%>">
      <input type="hidden" name="Building" value=<%=getbyte2(request.getParameter("Build"))%>>
	  <input type="hidden" name="Build" value=<%=getbyte2(request.getParameter("Build"))%>>
   
	  <input type="hidden" name="SecNo" value=<%=request.getParameter("SecNo")%>>
      <input type="hidden" name="intEndR" value=<%=request.getParameter("intEndR")%>>
   
      <tr align="center" > 
        <td width="16%"   class=listtitle>&nbsp;<font color=white>楼&nbsp;层&nbsp;数</font></td>
        <td width="20%" class=roomright> 
          &nbsp;<input type=text name=BeginF onblur="toUpper(document.cus.BeginF);"  onkeydown="key(document.cus.EndF)" size="5" style="border-style: solid; border-width: 1" value="1" >
          
         </td>
      </tr>
      <tr align="center" > 
        <td width="16%"   class=listtitle>&nbsp;<font color=white>编&nbsp;&nbsp;&nbsp;&nbsp;号</font></td>
        <td width="20%" class=roomright> 
          &nbsp;<input type=text name=BeginR  onkeydown="key(document.cus.EndR)" size="5" style="border-style: solid; border-width: 1" value="1"　  Onblur="toUpper(document.cus.BeginR)">&nbsp;单元号:<select name=Scellname>
		           <option value=" "></option>
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
				 
		  		 
		  </select>分隔符号  <select name=dyjgh>
		           <option value="">无分隔</option>
				    <option value="-">-</option>
				  <option value="0">0</option>
				   <option value=" ">用空格分隔</option>
		  		 
		  </select>
         
        </td>
      </tr>
	   
    </table>     
	<p align="center"> 
            &nbsp;&nbsp; <input type=button name="add" value="提 交" onclick="SaveRoomCode();" >
           &nbsp;&nbsp;
            <input type=button name="add" value="退 出" onclick="window.close();">
          </P>
   
</form>     
    
       
       
</body>       
</html>       
