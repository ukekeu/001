
 
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>ʵ�����¼��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script src="js/mad.js"> </script>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />

<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"S007");


 %>
  <%
    String section = null;
	String building = null;
	String Floor="";
	String RoomNo="";
	String state="";
	String color="";
	String AreaStr="";
	String change2Str = "";
	ResultSet change2RS = null;
	String Loft="";
 

    String SectionS="";
    String SecName=China.getParameter(request,"SecName");
    SectionS=China.getParameter(request,"SecNo");
    Loft=China.getParameter(request,"Loft");	 
	building=China.getParameter(request,"Build");
	Floor= China.getParameter(request,"Floor");
	RoomNo=China.getParameter(request,"Room");
	state=China.getParameter(request,"state");					
	int hasRecord = 0;
   
%>

	 
<script>
     function Validate(aForm)
   {
      if (aForm.SecNo.value.length<1)
	    	{
	    	alert("��¥�̣�");
	        aForm.SecNo.fofrm();
	        return (false);
	    	}	
       if (aForm.build.value.length<1)
		{
	        alert("�����붰��!");
	        aForm.build.fofrm();
	        return false;
		}
	}	


	var secValue = "<%= section %>";
	var buildValue = "<%= building %>";
	var Floor="<%=Floor%>";
	var Loft1="<%=Loft %>";
	var RoomNo="<%=RoomNo%>";
	var state="<%=state%>";

	function loadSelect() {
		setSelectMad(document.frm.SecNo,secValue);
		document.frm.build.options[document.frm.build.length]=new Option(buildValue,buildValue);
        document.frm.Loft.options[document.frm.Loft.length]=new Option(Loft1,Loft1);

		document.frm.Floor.value = Floor;
		document.frm.Room.value = RoomNo;
		
	}	
	
	 
	function subs(p1,p2)
	{
	
	 var varst=p1;
	  var len=p2;
	  var lenstr="0";
	  if (varst.indexOf(".")>0){
	 
         for (var i=1;i<parseInt(len)-1;i++){
		  lenstr+="0";
		 }
		 if (parseInt(len)>1){lenstr="0."+lenstr+"1";}//�����1��С��λ��
		 else{lenstr="0."+"1";}
	     var vars=varst.substring(varst.indexOf(".")+parseInt(len)+1,varst.indexOf(".")+(parseInt(len)+2));//����ʱȡ�����
	     var xsucd=varst.substring(varst.indexOf(".")+1,varst.indexOf(".")+parseInt(len)+1);//��С��λ�󵽱���С��λ������
		 var xsuq=varst.substring(0,varst.indexOf("."));//��С��λǰ������
		 var xsucd1=xsucd;//����ת��
		 var xsulen=varst.substring(0,varst.indexOf(".")+parseInt(len)+1);//�����󳤶�
		 if (parseInt(vars)>4){
		     xsucd=String(parseInt(xsucd)+1);
			 if (xsucd.length>xsucd1.length){
			    xsuq=String(parseInt(xsuq)+1);
				varst=xsuq+"."+xsucd.substring(1,xsucd.length);
				}
              else{varst=xsuq+"."+xsucd;}
         }else{
		    varst=xsulen;
		 }
	 }	 
	 return varst;
	
	}
 
  
  function findSub(para){
    document.frm.action=para;
 
   document.frm.submit();


}
</script>
<body  oncontextmenu="return false"   topmargin="1"   bgcolor="#FFFFFF" text="#000000" >
   <form name=frm action="AreaMappingA.jsp" method="post">
<input type=hidden name=SecNo value="<%=SectionS %>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=SecName value="<%=SecName %>">
<input type=hidden name=Build value="<%=building %>">
<input type=hidden name=choose>
  <input type=hidden name=OK>
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>

  <input type=hidden name="sel" value="<%=sel %>">
 <table width="360" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('AreaMappingA.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>ʵ��Ǽ�</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=2;findSub('AreaMappingAS.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���ٵǼ�</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('AreaMapPingB.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('HistroyPriceList.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>ʵ�����</font></a>
	</td>
	</tr></table>
  <p align=center><font size=3 class=FontColor><b><%=SecName+Loft %>������¼��</b></font></p>
 <form name="frm" method=post action="UpdateRoomPrice.jsp?Section=<%=section%>&Building=<%=building%>">
<input type=hidden name="Section" value="<%= SectionS %>" >
	
<!--��浥λ: <input type=text size=15 name=mappingunit onkeydown="key(document.frm.mappingdate)"> &nbsp;�������:<input type=text size=8 name=mappingdate onkeydown="key(document.frm.percent)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(mappingdate);return false;" title="��ѡ������">-->
<br>&nbsp;������ȣ���<input type=text size=3 name=percent value=0.6 onkeydown="key(document.frm.MappingArea1)">%&nbsp;��Ժ/¶̨�����ȣ���<input type=text size=3 name=percent1 value=0.5 onkeydown="key(document.frm.MappingArea1)">%&nbsp;<input type=checkbox name=jstype value=1 checked>��������
&nbsp;<input type=button name=addroom value="���������" onclick="openwin1('ExcelToRoom.jsp?SecNo=<%=SectionS %>&Loft=<%=Loft%>',300,250,100,100);">

<table width="120%" border="0" cellpadding="1" cellspacing="1">
  <tr align="center"  class=listtitle> 
     <td  > 
      <font color=white>����</font>
    </td>
	<td  > 
    <font color=white>Ԥ�۽���<br>���M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>Ԥ�۽�������<br>���M<sup>2</sup></font>
    </td>
	 
    <td  > 
    <font color=white>��潨��<br>���(M<sup>2</sup>)</font>
    </td>
	<td  > 
    <font color=white>�������<br>���(M<sup>2</sup>)</font>
    </td>
	 <td  > 
    <font color=white>ʵ����̨<br>���M<sup>2</sup></font>
    </td>
    <td  > 
    <font color=white>ʵ��¶̨<br>���M<sup>2</sup><br><input type=text size=2 name=ltp value=0></font>
    </td>
	 <td  > 
    <font color=white>ʵ��ͥԺ<br>���M<sup>2</sup><br><input type=text size=2 name=typ value=0></font>
    </td>
	 <td  > 
    <font color=white>ʵ�ⲻ��<br>�����M<sup>2</sup><br><input type=text size=2 name=bxg value=0></font>
    </td>
	 <td  > 
    <font color=white>ʵ�����<br>���M<sup>2</sup><br><input type=text size=2 name=dt value=0></font>
    </td>
	 <td  > 
    <font color=white>ʵ�ⰲȫ��<br>���M<sup>2</sup><br><input type=text size=2 name=aqw value=0></font>
    </td>
	<td  > 
    <font color=white>ʵ���̯<br>�������M<sup>2</sup></font>
    </td>
	<td  > 
    <font color=white>ʵ���̯<br>�õ����M<sup>2</sup></font>
    </td>
  </tr>

      <%
		int floor=0;	
		String code="";
		String room="";
		String SaleArea="";
		int salestate=0;
		String  unitprice="";
		String usedarea="";
		String af_unitprice="";
		String af_sumprice="";
		String contractno="",yang_tai_area="";
		String Sql="",yang_tai_zhao_yarea="";
		String customer="",lu_tai_area="",tyarea="";
	%> 
  <%	
	
	String strDisabled="";
	String strWhere="";
	int i=0;
	if (!Floor.equals("")){
	    strWhere=" and Floor="+Floor;
	}
	if (!RoomNo.equals("")){
	   if (!strWhere.equals("")){strWhere=strWhere+" and Room_code like'%"+RoomNo+"%'";}
	   else{strWhere=" and Room_code like'%"+RoomNo+"%'";}
	}
	if (!state.equals("")){

	   if (!strWhere.equals("")){strWhere=strWhere+" and SaleState="+state;}
	   else{strWhere=" and SaleState="+state;}
   }
	change2Str = "SELECT   dbo.Room.Code," +" dbo.Room.seccode, dbo.Room.Loft, ";
   change2Str+="   dbo.Room.building, dbo.Room.Room_code,dbo.Room.room, dbo.Room.area," ;
   change2Str+=" dbo.Room.Floor,Room.usedarea,lu_tai_area,ty_area,yang_tai_zhao_yarea,yang_tai_area  ";
   change2Str+="FROM dbo.room  where not (seccode+loft+room_code) in (select Section+loft+room from MapArea where section='"+SectionS+"' )  and dbo.room.[maap_state]=0 and dbo.room.[seccode] ='"+SectionS+"' and " +" dbo.room.loft='"+Loft+"' and upper(" +"dbo.room.building)='"+building+"' ORDER BY dbo.Room.Floor, dbo.Room.room, dbo.Room.Room_code" ;//+ building.toUpperCase() + "'";
 
		change2RS = changePriceListBean.executeQuery(change2Str);
try{
    String vv="";
		while (change2RS.next()) {
		i=i+1;
			hasRecord = 1;
			code = getbyte(change2RS.getString("Code"));
			if (!vv.equals("")&&vv.equals(code))continue;
			else vv=code;
			//unitprice=  getbyte(change2RS.getString("unitprice"));
			//if (unitprice.equals(""))unitprice="0";
			Loft = getbyte(change2RS.getString("loft"));
			 
			building = getbyte(change2RS.getString("building"));
			room = getbyte(change2RS.getString("room_code"));
		    SaleArea = getbyte(change2RS.getString("area"));
			if (SaleArea.equals(""))SaleArea="0";
			String floors= getbyte(change2RS.getString("Floor"));
			usedarea = getbyte(change2RS.getString("usedarea"));
			lu_tai_area = getbyte(change2RS.getString("lu_tai_area"));
			tyarea = getbyte(change2RS.getString("ty_area"));
			yang_tai_zhao_yarea = getbyte(change2RS.getString("yang_tai_zhao_yarea"));
			yang_tai_area = getbyte(change2RS.getString("yang_tai_area"));
			
	  %>
  
  <tr align="center"  class=listcontent> 
 
  <input type=hidden name="Loft2<%=i%>" value="<%= Loft %>" >
  <input type=hidden name="Building<%=i%>" value="<%= building %>" >
    <input type=hidden name="area<%=i%>" value="<%= SaleArea %>" >
  <input type=hidden name="usedarea<%=i%>" value="<%= usedarea %>" >
  <input type=hidden name="lutai<%=i%>" value="<%= lu_tai_area %>" >
    <input type=hidden name="tyarea<%=i%>" value="<%= tyarea %>" >
  <input type=hidden name="yangtaiz<%=i%>" value="<%= yang_tai_zhao_yarea %>" >
  <input type=hidden name="yangtai<%=i%>" value="<%= yang_tai_area %>" >
 <input type=hidden name="Room<%=i%>" value="<%= room %>" >
	<input type=hidden name="OK" >
	    <input type=hidden name="floors<%=i%>" value="<%= floors %>" >
	
   <td > <%=room.trim() %></td> 
   <td ><%=SaleArea %></td> 
   
   <td ><%=usedarea%></td> 
   
  <!-- <td > <%=yang_tai_zhao_yarea %></td> 
    <td><%=yang_tai_area %></td>-->
   <td > <input type=text name="MappingArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingArea<%=i%>);" onkeydown="key(document.frm.MappingUserArea<%=i %>)" ></td>
   <td > <input type=text name="MappingUserArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingyArea<%=i %>)" ></td>
   <td > <input type=text name="MappingyArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappinglArea<%=i %>)" ></td>
 
   <td > <input type=text name="MappinglArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingArea<%=i%>);" onkeydown="key(document.frm.MappingtArea<%=i %>)" ></td>
   <td > <input type=text name="MappingtArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingArea<%=i%>);" onkeydown="key(document.frm.MappingytArea<%=i %>)" ></td>
   <td > <input type=text name="MappingytArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingdArea<%=i %>)" ></td>
   
    <td ><input type=text name="MappingdArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingytArea<%=i %>)" ></td>
  
      <td > <input type=text name="MappingywArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingyftjdArea<%=i %>)" ></td>
  <td > <input type=text name="MappingyftjdArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingyftydArea<%=i %>)" ></td>
  <td > <input type=text name="MappingyftydArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingArea<%=i+1 %>)" ></td>
 
    <input type=hidden name="customer<%=i %>" value="<%=customer %>">
  </tr>
  
  <%
   }
   }catch(Exception s){out.print(s.getMessage());}
 
  // change2RS.close();
   %>
  <input type=hidden name="state" value="2"> 
<input type=hidden name=MaxRoomNo value="<%=i%>">
</table>

  <table width="100%" border="0">
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
	</table>
    <%if (i>0){ %>
	<p align=center>
	<%if (Cortrol.indexOf("A")>=0){ %>
        <input type="button" name="Button" value="��   ��" onclick="InsertMap()"><%} %>
  <!-- <img  src="../picture/button_tj.gif" onclick="InsertMap();">-->      
</p>
<%}else{ %>
     <input type="button" name="Button" value="û��ѯ�����۳��ķ���">

<%} %>
</form>
 
</center>

</body>
<script>
	function InsertMap() {
	 if (confirm("ȷ��������ȷ��")){
	  /*  if (document.frm.mappingunit.value==""){
		  alert("��¼���浥λ");
		  document.frm.mappingunit.focus();
		  return false;
		}
		if (document.frm.mappingdate.value==""){
		  alert("��������");
		  document.frm.mappingdate.focus();
		  return false;
		}*/
		document.forms[0].action = "MapAreaUpdate.jsp?Operation=Insert&x=" + Math.random() ;
		document.forms[0].submit() ;
		}
	}
</script>
</html>
