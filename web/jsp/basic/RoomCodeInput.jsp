<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>�������</title>
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
      alert("ֻ�������ֱ��");
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
	    	alert("��������ʼ¥�㣡");
	        aForm.BeginF.focus();
	        return (false);
	    	}		
		if (aForm.EndF.value.length<1)
	    	{
	    	alert("���������¥�㣡");
	        aForm.EndF.focus();
	        return (false);
	    	}	
	   if (aForm.BeginR.value.length<1)
	    	{
	    	alert("��������ʼ���ţ�");
	        aForm.BeginR.focus();
	        return (false);
	    	}		
		if (aForm.EndR.value.length<1)
	    	{
	    	alert("������������ţ�");
	        aForm.EndR.focus();
	        return (false);
	    	}	
		if (parseInt(document.cus.BeginF.value)>parseInt(document.cus.EndF.value)){
		
		 alert("��ʼ¥�㲻�ܴ��ڽ���¥�㣡");
	        aForm.BeginF.focus();
	        return (false);
		
		}
	  var b=isNaN(aForm.BeginR.value);
	  var e=isNaN(aForm.EndR.value);
  	 if (b!=e){
	     alert("ע�⣺����ֻΪ���ֻ���ĸ������������")
		  return (false);
		}  
			  
      return (true);		
	}	 

function checks(aa){
   var a1=aa.value;
	if (document.cus.BeginF.value!=""){
	 if (parseInt(document.cus.BeginF.value)<=0){
	     if (document.cus.MAINFLOOR.value!=""&&(parseInt(document.cus.BeginF.value)>=parseInt(document.cus.MAINFLOOR.value))){
            alert("��¥���Ѷ����");	
	       // aa.focus();   
	       // return false;
	 	 }
		 }else{
		 
		  if (document.cus.MAINFLOOR.value!=""&&(parseInt(document.cus.BeginF.value)<=parseInt(document.cus.MAXFLOOR.value))){
     alert("��¥���Ѷ����");	
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
     alert("��¥���Ѷ����");	
	// aa.focus();   
  
	// return false;
	
	}
	}else{
	 if (document.cus.MAXFLOOR.value!=""&&(parseInt(document.cus.EndF.value)<=parseInt(document.cus.MAINFLOOR.value))){
     alert("��¥���Ѷ����");	
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
	 alert("���������ĸ�����룬ֻ����A--O");
	 aa.focus();
	 return false;
	 }*/
	if (document.cus.BeginR.value!=""&&document.cus.EndR.value!=""){
	 if (isNaN(a)&&document.cus.BeginR.value>document.cus.EndR.value){
	    alert("�밴��ĸ�Ⱥ�˳��������");
	    aa.focus();
		aa.select();
	    return false;
	 
	 }
	 if (aa.name=="EndR"){
	 if (isNaN(a)&&(upp.indexOf(document.cus.BeginR.value)<0||upp.indexOf(document.cus.EndR.value)<0)){
	    alert("���������ĸ�����룬ֻ����A--Z");
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
	  <a href="#" onclick="document.cus.sel.value=0;findSub('RoomCodeInput.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��Դ����</font> </a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('copyRoomCode.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��Դ����</font></a>
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
		  char FloNo=RoomNoUp.charAt(0);//�ж�¥���Ƿ�����ĸ���

		   RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
           char BeR=RoomNoUp.charAt(0);
		  
		  out.println("ϵͳ�Ѷ����¥�㣺"+minfloor+"��"+maxfloor);
		 
           if(!java.lang.Character.isDigit(BeR)){      
			 out.println("ϵͳ�Ѷ���ķ��ţ�"+upp.substring(minroom-1,minroom)+"��"+upp.substring(maxroom-1,maxroom));
		  }else{
             out.println("ϵͳ�Ѷ���ķ��ţ�"+minroom+"��"+maxroom);
		  }
		   
     }
   } 
       
   if (!cell.equals(""))
   out.print("��Ԫ��"+cell);
   }catch(Exception s){out.print("error"+s);out.close();}
   String Type="";
   String RoomNo="";
   String SQL="SELECT Type FROM CRM_Project WHERE SerialNo='"+getbyte2(request.getParameter("SecNo"))+"'";
      ResultSet rr=ViewBean.executeQuery(SQL);
	  if (rr.next()){
	    Type=getbyte(rr.getString("type"));
	  }
	  rr.close();
	  if (Type.indexOf("��λ")>=0)Type="��λ���";
	  if (Type.indexOf("סլ")>=0)Type="�������";
	  if (Type.indexOf("����")>=0)Type="���̱��";
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
   <INPUT TYPE=button NAME=loke VALUE="�˶��н��úţ�����ɻָ�" onclick="openwin('listLoke.jsp?SecNo=<%=request.getParameter("SecNo") %>&Loft=<%=getbyte2(request.getParameter("Loft"))%>&Build=<%=getbyte2(request.getParameter("Build"))%>',200,150,100,100);">
   <%} %>
   <p>&nbsp;</p>
  <p align="center"><b><font size="3" color="#000080">���붨��</font></b>

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
        <td width="16%"  align="center"  class=listtitle>&nbsp;<font color=white>��ʼ¥��</font></td>
        <td width="45%" class=roomright> 
          &nbsp;<input type=text name=BeginF   onblur="checkFloor(this);checks(this);checkFv(this.value);"    onkeydown="key(document.cus.EndF)" size="5" style="border-style: solid; border-width: 1"  >
          �� 
          <input type="text" name="EndF"     onblur="checkFloor(this);checke(this);checkFv(this.value);" size="5"    onkeydown="key(document.cus.BeginR)" style="border-style: solid; border-width: 1" >&nbsp;�� �� �֣�<input type="text" name="Finfo"   size="7" onkeydown="key(document.cus.BeginR)" style="border-style: solid; border-width: 1" >&nbsp;&nbsp;��ʾ¥����<input name="showfloors" value=1 checked type="checkbox">
          <select name=floorlen>
		           <option ></option>
				    <option value="1">��λ��</option>
				 
		  		 
		  </select></td>
      </tr>
      <tr align="left" > 
        <td width="16%"   align="center"  class=listtitle>&nbsp;<font color=white>��ʼ���</font></td>
        <td width="45%" class=roomright> 
          &nbsp;<input type=text name=BeginR   maxlength="5"    onkeydown="key(document.cus.EndR)" size="5" value="1"  style="border-style: solid; border-width: 1"  Onblur="toUpper(document.cus.BeginR);checkRl(this.value);">
          �� 
          <input type="text" name="EndR"    maxlength="5"   onkeydown="key(document.cus.Lock)"  size="5"   style="border-style: solid; border-width: 1" Onblur="toUpper(document.cus.EndR);checkRl(this.value);">&nbsp;
        (�磺1,2,3��A��B��C)<!--&nbsp;ǰ׺��<input type="text" name="roomqz"   size="7"   >&nbsp;�ָ�<select name=roomqzfgf>
		           <option value="">�޷ָ�</option>
				    <option value="-">-</option>
				  <option value="0">0</option>
				   <option value=" ">�ÿո�ָ�</option>
		  		 
		  </select>--></td>
      </tr>
	   <tr align="left" > 
        <td width="16%"  align="center"  class=listtitle>&nbsp;<font color=white>  ��ʼ��Ԫ:</font></td>
        <td width="45%" class=roomright> 
        &nbsp;<select name=cellqz>
		          <option value="">ѡ��ǰ׺</option>
		           <option value=""></option>
				    <option value="0">0</option>
					  		 
		  </select><select name=Scellname>
		           <option value=" "></option>
				    <option value="1">1��Ԫ</option>
				  <option value="A">A��Ԫ</option>
		  		 
		  </select>�� <select name=Ecellname>
		           <option value=" "></option>
				     <option value="2">2��Ԫ</option>
					 <option value="3">3��Ԫ</option>
					 <option value="4">4��Ԫ</option>
					 <option value="5">5��Ԫ</option>
					 <option value="6">6��Ԫ</option>
					 <option value="7">7��Ԫ</option>
					 <option value="8">8��Ԫ</option>
					 <option value="9">9��Ԫ</option>
					 <option value="10">10��Ԫ</option>
					 <option value="11">11��Ԫ</option>
					  <option value="B">B��Ԫ</option>
					  <option value="C">C��Ԫ</option>
					  <option value="D">D��Ԫ</option>
					  <option value="E">E��Ԫ</option>
					  <option value="F">F��Ԫ</option>
					  <option value="G">G��Ԫ</option>
					  <option value="H">H��Ԫ</option>
					    <option value="I">I��Ԫ</option>
						<option value="J">J��Ԫ</option>
				  <option value="K">K��Ԫ</option>
		  		
		  </select>�ָ�����  <select name=dyjgh>
		           <option value="">�޷ָ�</option>
				    <option value="-">-</option>
				  <option value="0">0</option>
				   <option value=" ">�ÿո�ָ�</option>
		  		 
		  </select> ������뷽ʽ  <select name=bmfs>
		           <option value="">¥�㷿+�����</option>
				    <option value="-">¥��+"-"+�������</option>
				  <option value="0">¥��+"0"+�������</option>
				   
		  		 
		  </select> </td>
      </tr>
	  <tr align="left" > 
        <td width="16%"  align="center" class=listtitle>&nbsp;<font color=white>���ñ��</font></td>
        <td width="45%" class=roomright > 
          &nbsp;<input type=text name=Lock size="15" onkeydown="key(document.cus.submit1)" style="border-style: solid; border-width: 1" ��  Onblur="toUpper(document.cus.Lock)">
        �Ƿ�˳����</font><input type=checkbox name=cw size="4" value="1">��ų���<input type=text name=cd size="4" value="2">
         
        </td>
      </tr>
	
   
    </table> 
	<p align="left"> ˵���� </p> 
	 <table border="0" width="99%">
	 <TR><TD>
	(1.)��ʼ�����ָ��ţ���1,2..��A,B...�����ú�֮����","�ֿ� ;</TD></TR>
	 <TR><TD>
	(2.)��������"¥��+���",��1¥2(B)�ŵķ�����Ϊ��102(1B); 
	</TD></TR>
	<TR><TD>
	(3.)����λ�����̱��һ����"˳����",����˳���ǰ����¥��ţ�
	</TD></TR>
	<TR><TD>
	(4.)����λ�����̱��λ��Ϊ1ʱ��ʾֱ����˳��ű��,��:���Ϊ1...9;
	</TD></TR>
	<TR><TD>
	(5.)����λ�����̱��λ��Ϊ2ʱ��ʾ�ڲ�����λ���ȵı�ż�"0",��:���Ϊ01...99,ϵͳ���Զ���˳���ǰ����"0"������λ;
	</TD></TR>
	<TR><TD>
	(6.)����λ�����̱��λ��Ϊ3ʱ��ʾ�ڲ�����λ���ȵı�ż�"00",��:���Ϊ001...101,ϵͳ���Զ���˳���ǰ����"00"������λ;
	</TD></TR>
	<TR><TD>
	(7.)��Ȼ¥����ΪС��1ʱ��ϵͳ�Զ�ʶ��Ϊ��λ�����̱��;
	</TD></TR>
	<TR><TD>
	(8.)��Ԫ�ָ�����ָ��Ԫ���뷿��ż�ķָ��ţ���10101(��1-101)��ʾ1��Ԫ101�ŷ�;
	</TD></TR>
	<TR><TD>
	(9.)�����¥�����˸����ֱ�ʾʱ��������ʾ¥������Ҳ���Բ���ʾ��ֱ����ʾ������;
	</TD></TR>
	</table> 
	<%
 //Ȩ��ȷ��
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B004");
 
   if (Cortrol==null)Cortrol="";
   
   %>
	<p align="center"> 
	<%if (Cortrol.indexOf("A")>=0){ %>
            &nbsp;&nbsp; <input type=button name="yl" value="Ԥ ��" onclick="SaveRoomCode();" >
<%} %>
           &nbsp;&nbsp; 
            <input type=Reset name=winc value="ȡ ��"  >
          </P>
   
</form>    
 
   <script>
   function SaveRoomCode(){
    if (Validate(document.cus))
	{
	if (document.cus.MAINFLOOR.value!=""){
	if (trim(document.cus.cell.value)==""&&trim(document.cus.Scellname.value)!=""){
	  alert("�벻Ҫѡ��Ԫ����ԭ���Ѷ���ı����в������е�Ԫ����");
	  return false;
	}
	if (trim(document.cus.cell.value)==""&&trim(document.cus.Ecellname.value)!=""){
	  alert("�벻Ҫѡ��Ԫ����ԭ���Ѷ���ı����в������е�Ԫ����");
	  return false;
	}
	if (trim(document.cus.cell.value)!=""&&trim(document.cus.Scellname.value)==""){
	  alert("��ѡ��Ԫ����ԭ���Ѷ���ı����а����е�Ԫ����");
	  return false;
	}
	if (trim(document.cus.cell.value)!=""&&trim(document.cus.Ecellname.value)==""){
	  alert("��ѡ��Ԫ����ԭ���Ѷ���ı����а����е�Ԫ����");
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
