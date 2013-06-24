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
<%@ include file="../public_js/qx_checke.jsp"%>
 <script language="javascript" src="../public_js/public.js">
</script>

<script language=javascript>

function checkFloor(aa){
   var a1=aa.value;
   if (a1!=""){
   if (isNaN(a1)){
      alert("只能用数字表达");
	  aa.value=0;
	 // aa.focus();
	  return false;
	} 
	 return true; 
    }
  }  
 function Validate(aForm)
   {
  
      
		if (aForm.BeginF.value.length<1)
	    	{
	    	alert("请输入起始楼层！");
	        aForm.BeginF.focus();
	        return (false);
	    	}		
		if (aForm.EndF.value.length<1)
	    	{
	    	alert("请输入最高楼层！");
	        aForm.EndF.focus();
	        return (false);
	    	}	
	   if (aForm.BeginR.value.length<1)
	    	{
	    	alert("请输入起始房号！");
	        aForm.BeginR.focus();
	        return (false);
	    	}		
		if (aForm.EndR.value.length<1)
	    	{
	    	alert("请输入结束房号！");
	        aForm.EndR.focus();
	        return (false);
	    	}	
		if (parseInt(document.cus.BeginF.value)>parseInt(document.cus.EndF.value)){
		
		 alert("开始楼层不能大于结束楼层！");
	        aForm.BeginF.focus();
	        return (false);
		
		}
	  var b=isNaN(aForm.BeginR.value);
	  var e=isNaN(aForm.EndR.value);
  	 if (b!=e){
	     alert("注意：房号只为数字或字母，不能用两种")
		  return (false);
		}  
			  
      return (true);		
	}	 

function checks(aa){
   var a1=aa.value;
	if (document.cus.BeginF.value!=""){
	 if (parseInt(document.cus.BeginF.value)<=0){
	     if (document.cus.MAINFLOOR.value!=""&&(parseInt(document.cus.BeginF.value)>=parseInt(document.cus.MAINFLOOR.value))){
            alert("此楼层已定义过");	
	       // aa.focus();   
	       // return false;
	 	 }
		 }else{
		 
		  if (document.cus.MAINFLOOR.value!=""&&(parseInt(document.cus.BeginF.value)<=parseInt(document.cus.MAXFLOOR.value))){
     alert("此楼层已定义过");	
	// aa.focus();   
	 //return false;
		 }
		 }
	}
  }  
  function checke(aa){
   var a1=aa.value;
	if (document.cus.EndF.value!=""){
	  if (parseInt(document.cus.EndF.value)<=0){
	 if (document.cus.MAXFLOOR.value!=""&&(parseInt(document.cus.EndF.value)>=parseInt(document.cus.MAINFLOOR.value))){
     alert("此楼层已定义过");	
	// aa.focus();   
  
	// return false;
	
	}
	}else{
	 if (document.cus.MAXFLOOR.value!=""&&(parseInt(document.cus.EndF.value)<=parseInt(document.cus.MAINFLOOR.value))){
     alert("此楼层已定义过");	
	// aa.focus();   
 
	 //return false;
	}
 }
	 
	}
  }  	 
function toUpper(aa){
    var a=aa.value;
	if (a!=""){
	var upp="ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
    aa.value=a.toUpperCase();
	/*if (isNaN(a)&&upp.indexOf(a)<0){
	 alert("如果是以字母来编码，只能在A--O");
	 aa.focus();
	 return false;
	 }*/
	if (document.cus.BeginR.value!=""&&document.cus.EndR.value!=""){
	 if (isNaN(a)&&document.cus.BeginR.value>document.cus.EndR.value){
	    alert("请按字母先后顺序来编码");
	    aa.focus();
		aa.select();
	    return false;
	 
	 }
	 if (aa.name=="EndR"){
	 if (isNaN(a)&&(upp.indexOf(document.cus.BeginR.value)<0||upp.indexOf(document.cus.EndR.value)<0)){
	    alert("如果是以字母来编码，只能在A--Z");
	    aa.focus();
		aa.select();
	    return false;
	 }
	 }
	  
	
	} 
	}
  }
  function checkFv(para){
    if (parseInt(para)<=0)document.cus.cw.checked=true;
	else document.cus.cw.checked=false;
  }
  function checkRl(para){
    if (parseInt(para)>=100)document.cus.cd.value=3;
	else  if (parseInt(para)<100&&parseInt(para)>=10)document.cus.cd.value=2;
	else if (parseInt(para)<10)document.cus.cd.value=1;
  }
</script>
 
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
   <body topmargin="1"     >
   <form name=cus action="RoomCodeInput.jsp">
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   <tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('RoomCodeInput.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>房源定义</font> </a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('copyRoomCode.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>房源复制</font></a>
	</td>
	 
	</tr></table>
	<script>
function findSub(para){
   document.cus.action=para;
   document.cus.submit();


}
</script>
<br>
<%
String minfloor="";
String MAXROOM="";
String maxfloor="";
String building=getbyte2(request.getParameter("Build"));
if (building==null) building="";
String Loft=getbyte2(request.getParameter("Loft"));
String upp="ABCDEFGHIJKLMNOPQRSTUVWXYZ  ";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 Roomno from Roomno where SECTIONNO=";
				sqlU=sqlU+"'"+getbyte2(request.getParameter("SecNo"))+"' and Building='";
				sqlU=sqlU+building+"' and REGION='"+Loft+"'";
		ResultSet rsU=ViewBean.executeQuery(sqlU);
		
        if (rsU.next())RoomNoUp=rsU.getString("Roomno");
		rsU.close();


String StrSQL="SELECT MIN(FLOOR) AS MINFLOOR,MAX(FLOOR) MAXFLOOR,";
       StrSQL+="MIN(room) AS minroom,MAX(room) MAXroom,max(cell) cell FROM ROOMNO";
	   StrSQL+=" WHERE SECTIONNO='";
       StrSQL+=getbyte2(request.getParameter("SecNo"))+"'";
	   StrSQL+=" AND REGION ='"+Loft+"'";
	   StrSQL+=" AND BUILDING ='"+building+"'";
	 
  ResultSet RoomNoRs=null;
 String cell="";
  try{
   RoomNoRs=ViewBean.executeQuery(StrSQL);

   if (RoomNoRs.next()){
	 
       minfloor=getbyte(RoomNoRs.getString("minfloor"));
	   maxfloor=getbyte(RoomNoRs.getString("maxfloor"));
	  int minroom=RoomNoRs.getInt("minroom");
	  int maxroom=RoomNoRs.getInt("maxroom");
	 MAXROOM=String.valueOf(maxroom);
	 cell=getbyte(RoomNoRs.getString("cell"));
	  if (!minfloor.equals("")&&!RoomNoUp.equals("")){
	  
		  String FloorNo=RoomNoUp.substring(0,1);
		  char FloNo=RoomNoUp.charAt(0);//判断楼层是否以字母编号

		   RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
           char BeR=RoomNoUp.charAt(0);
		  
		  out.println("系统已定义的楼层："+minfloor+"到"+maxfloor);
		 
           if(!java.lang.Character.isDigit(BeR)){      
			 out.println("系统已定义的房号："+upp.substring(minroom-1,minroom)+"到"+upp.substring(maxroom-1,maxroom));
		  }else{
             out.println("系统已定义的房号："+minroom+"到"+maxroom);
		  }
		   
     }
   } 
       
   if (!cell.equals(""))
   out.print("单元数"+cell);
   }catch(Exception s){out.print("error"+s);out.close();}
   String Type="";
   String RoomNo="";
   String SQL="SELECT Type FROM CRM_Project WHERE SerialNo='"+getbyte2(request.getParameter("SecNo"))+"'";
      ResultSet rr=ViewBean.executeQuery(SQL);
	  if (rr.next()){
	    Type=getbyte(rr.getString("type"));
	  }
	  rr.close();
	  if (Type.indexOf("车位")>=0)Type="车位编号";
	  if (Type.indexOf("住宅")>=0)Type="房间编码";
	  if (Type.indexOf("商铺")>=0)Type="商铺编号";
	   sqlU="select top 1 * from LockRoom where Section=";
				sqlU=sqlU+"'"+request.getParameter("SecNo")+"' and Build='";
				sqlU=sqlU+building+"' and Loft='"+Loft+"'"; 
				 rr=ViewBean.executeQuery(sqlU);
      String loke="";
				 if (rr.next()){
				    loke="11";
				 }
				 rr.close();
 %>

   <%if (!loke.equals("")){ %>
   <INPUT TYPE=button NAME=loke VALUE="此栋有禁用号，点击可恢复" onclick="openwin('listLoke.jsp?SecNo=<%=request.getParameter("SecNo") %>&Loft=<%=getbyte2(request.getParameter("Loft"))%>&Build=<%=getbyte2(request.getParameter("Build"))%>',200,150,100,100);">
   <%} %>
   <p>&nbsp;</p>
  <p align="center"><b><font size="3" color="#000080">编码定义</font></b>

  <form method="POST" name="cus" action="" >
<INPUT TYPE=HIDDEN NAME=MAXFLOOR VALUE="<%=maxfloor %>">
<INPUT TYPE=HIDDEN NAME=MAINFLOOR VALUE="<%=minfloor %>">
<INPUT TYPE=HIDDEN NAME=cell VALUE="<%=cell %>">

<INPUT TYPE=HIDDEN NAME=MAXROOM VALUE=<%=MAXROOM %>>
    <table border="0" width="90%"  align="center" cellspacing="0" bgcolor="#ffffff"  cellpadding="0" bordercolor="#ffffff" class="tablefill">
      <input type="hidden" name="Region" value="<%=getbyte2(request.getParameter("Loft"))%>">
	     
      <input type="hidden" name="Building" value=<%if (request.getParameter("Build")==null) out.print("");else out.print(getbyte2(request.getParameter("Build")));%>>
	  <input type="hidden" name="Build" value=<%if (request.getParameter("Build")==null) out.print("");else out.print(getbyte2(request.getParameter("Build")));%>>
      <input type="hidden" name="Section" value=<%=getbyte2(request.getParameter("SecNo"))%>>
	  <input type="hidden" name="SecNo" value=<%=getbyte2(request.getParameter("SecNo"))%>>
	  <input type="hidden" name="Loft" value="<%=getbyte2(request.getParameter("Loft"))%>">
      <input type="hidden" name="SecName" value=<%=getbyte2(request.getParameter("SecName"))%>>
       <input type="hidden" name="Find" value=<%=getbyte2(request.getParameter("SecName"))%>>
	    <input type="hidden" name="Search" value=<%=getbyte2(request.getParameter("SecName"))%>>
      <tr align="left" > 
        <td width="16%"  align="center"  class=listtitle>&nbsp;<font color=white>起始楼层</font></td>
        <td width="45%" class=roomright> 
          &nbsp;<input type=text name=BeginF   onblur="checkFloor(this);checks(this);checkFv(this.value);"    onkeydown="key(document.cus.EndF)" size="5" style="border-style: solid; border-width: 1"  >
          至 
          <input type="text" name="EndF"     onblur="checkFloor(this);checke(this);checkFv(this.value);" size="5"    onkeydown="key(document.cus.BeginR)" style="border-style: solid; border-width: 1" >&nbsp;附 加 字：<input type="text" name="Finfo"   size="7" onkeydown="key(document.cus.BeginR)" style="border-style: solid; border-width: 1" >&nbsp;&nbsp;显示楼层数<input name="showfloors" value=1 checked type="checkbox">
          <select name=floorlen>
		           <option ></option>
				    <option value="1">两位数</option>
				 
		  		 
		  </select></td>
      </tr>
      <tr align="left" > 
        <td width="16%"   align="center"  class=listtitle>&nbsp;<font color=white>起始编号</font></td>
        <td width="45%" class=roomright> 
          &nbsp;<input type=text name=BeginR   maxlength="5"    onkeydown="key(document.cus.EndR)" size="5" value="1"  style="border-style: solid; border-width: 1"  Onblur="toUpper(document.cus.BeginR);checkRl(this.value);">
          至 
          <input type="text" name="EndR"    maxlength="5"   onkeydown="key(document.cus.Lock)"  size="5"   style="border-style: solid; border-width: 1" Onblur="toUpper(document.cus.EndR);checkRl(this.value);">&nbsp;
        (如：1,2,3或A，B，C)<!--&nbsp;前缀：<input type="text" name="roomqz"   size="7"   >&nbsp;分隔<select name=roomqzfgf>
		           <option value="">无分隔</option>
				    <option value="-">-</option>
				  <option value="0">0</option>
				   <option value=" ">用空格分隔</option>
		  		 
		  </select>--></td>
      </tr>
	   <tr align="left" > 
        <td width="16%"  align="center"  class=listtitle>&nbsp;<font color=white>  起始单元:</font></td>
        <td width="45%" class=roomright> 
        &nbsp;<select name=cellqz>
		          <option value="">选择前缀</option>
		           <option value=""></option>
				    <option value="0">0</option>
					  		 
		  </select><select name=Scellname>
		           <option value=" "></option>
				    <option value="1">1单元</option>
				  <option value="A">A单元</option>
		  		 
		  </select>到 <select name=Ecellname>
		           <option value=" "></option>
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
		  		 
		  </select> 房间编码方式  <select name=bmfs>
		           <option value="">楼层房+间序号</option>
				    <option value="-">楼层+"-"+房间序号</option>
				  <option value="0">楼层+"0"+房间序号</option>
				   
		  		 
		  </select> </td>
      </tr>
	  <tr align="left" > 
        <td width="16%"  align="center" class=listtitle>&nbsp;<font color=white>禁用编号</font></td>
        <td width="45%" class=roomright > 
          &nbsp;<input type=text name=Lock size="15" onkeydown="key(document.cus.submit1)" style="border-style: solid; border-width: 1" 　  Onblur="toUpper(document.cus.Lock)">
        是否按顺序编号</font><input type=checkbox name=cw size="4" value="1">编号长度<input type=text name=cd size="4" value="2">
         
        </td>
      </tr>
	
   
    </table> 
	<p align="left"> 说明： </p> 
	 <table border="0" width="99%">
	 <TR><TD>
	(1.)起始编号是指序号，如1,2..或A,B...，禁用号之间用","分开 ;</TD></TR>
	 <TR><TD>
	(2.)房间编号是"楼层+编号",如1楼2(B)号的房间编号为：102(1B); 
	</TD></TR>
	<TR><TD>
	(3.)房车位及商铺编号一般用"顺序编号",即在顺序号前不带楼层号；
	</TD></TR>
	<TR><TD>
	(4.)房车位及商铺编号位数为1时表示直接用顺序号编号,例:编号为1...9;
	</TD></TR>
	<TR><TD>
	(5.)房车位及商铺编号位数为2时表示在不足两位长度的编号加"0",例:编号为01...99,系统会自动在顺序号前补加"0"保持两位;
	</TD></TR>
	<TR><TD>
	(6.)房车位及商铺编号位数为3时表示在不足两位长度的编号加"00",例:编号为001...101,系统会自动在顺序号前补加"00"保持两位;
	</TD></TR>
	<TR><TD>
	(7.)当然楼层数为小于1时，系统自动识别为车位或商铺编号;
	</TD></TR>
	<TR><TD>
	(8.)单元分隔符是指单元号与房间号间的分隔号，如10101(或1-101)表示1单元101号房;
	</TD></TR>
	<TR><TD>
	(9.)如果在楼层用了附加字表示时，可以显示楼层数，也可以不显示，直接显示附加字;
	</TD></TR>
	</table> 
	<%
 //权限确认
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B004");
 
   if (Cortrol==null)Cortrol="";
   
   %>
	<p align="center"> 
	<%if (Cortrol.indexOf("A")>=0){ %>
            &nbsp;&nbsp; <input type=button name="yl" value="预 览" onclick="SaveRoomCode();" >
<%} %>
           &nbsp;&nbsp; 
            <input type=Reset name=winc value="取 消"  >
          </P>
   
</form>    
 
   <script>
   function SaveRoomCode(){
    if (Validate(document.cus))
	{
	if (document.cus.MAINFLOOR.value!=""){
	if (trim(document.cus.cell.value)==""&&trim(document.cus.Scellname.value)!=""){
	  alert("请不要选择单元，因原来已定义的编码中不包括有单元定义");
	  return false;
	}
	if (trim(document.cus.cell.value)==""&&trim(document.cus.Ecellname.value)!=""){
	  alert("请不要选择单元，因原来已定义的编码中不包括有单元定义");
	  return false;
	}
	if (trim(document.cus.cell.value)!=""&&trim(document.cus.Scellname.value)==""){
	  alert("请选择单元，因原来已定义的编码中包括有单元定义");
	  return false;
	}
	if (trim(document.cus.cell.value)!=""&&trim(document.cus.Ecellname.value)==""){
	  alert("请选择单元，因原来已定义的编码中包括有单元定义");
	  return false;
	}
	}
	document.cus.action="RoomCodeList.jsp";
	 document.cus.submit();
     }
   }
   function cancel(){
    document.cus.EndR.value="";
	//document.cus.BeginR.value="";
	document.cus.EndF.value="";
	//document.cus.BeginF.value="";
	document.cus.Lock.value="";
	
   }
   </script>
       
    </body>       
</html>       
