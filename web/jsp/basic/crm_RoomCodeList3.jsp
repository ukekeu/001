<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<head>
	<title> ����б�</title>
	<META http-equiv="Page-Enter" content="revealTrans(Transition=23,Duration=300.000)">
</head>
<body topmargin="1" oncontextmenu="return false"   >
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
 <jsp:useBean id="df1" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/asiic.jsp"%> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="room.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<form name=cus method="post" action="crm_RoomCodeList3.jsp">
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">

<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('crm_RoomCodeList1.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��Դ����</font> 
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=2;findSub('crm_RoomCodeList3.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('Room_list.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��Դ��ͼ</font></a>
	</td>
	</tr></table>
	<script>
function findSub(para){
   document.cus.action=para+"?Search=b&Find=b";
   document.cus.submit();


}
</script>
<div align="center">
  <p><font color="#0000CC"><b><font size="3" class=FontColor> 
   <%if (!SecName.equals(Loft)){out.print(SecName);} %>  <%=Loft %>  <%=strBuilding%>���������</font></b></font></p>

    <input type=hidden name=SecNo value="<%=SecNo %>">
    <input type=hidden name=Loft value="<%=Loft %>">
    <input type=hidden name=SecName value="<%=SecName %>">
    <input type=hidden name=Build value="<%=strBuilding %>">
	<input type=hidden name="Search">
	<input type=hidden name="Find">
	
    <input type=hidden name=choose>
  <table width="85%" border="0" align="center" CELLSPACING=0 CELLPADDING=0 >	<tr><td nowrap=5>  <%if (!lock.equals("")){ %>
   <INPUT TYPE=button NAME=loke VALUE="�˶��н��ú�(<%=lock %>)������ɻָ�" onclick="openwin1('listLoke.jsp?SecNo=<%=strSection%>&Loft=<%=Loft%>',200,150,100,100);">
   <%} %></td><td align="right">&nbsp;<%
 //Ȩ��ȷ��
  String Cortrol=checke_qx(InsertBean,(String)session.getAttribute("loginid"),"B005");
  if (Cortrol==null)Cortrol="";
  if (Cortrol.indexOf("A")>=0){ %>
	<input type=button name=addroom value="���ӱ���" onclick="openwin1('add_new_room_code1.jsp?Loft=<%=Loft%>&SecNo=<%=strSection%>&Build=<%=strBuilding %>&intEndF=<%=intEndF%>&intEndR=<%=intEndR%>&roomcode='+document.cus.checkroom.value,300,250,100,100);"><%} %></td></tr>
  </table>
  <%@ include file="check_room_code.jsp"%>
<%out.print(sqlU); %>
		<script>
       if (confirm("�˶���û�н��з����Ų������Ƿ����ڽ��У�")){
        window.location="RoomCodeInput.jsp?<%=locaPara %>";
       }
</script>
		 <%}else{%>
		 <%
 String rg1="#00CCFF";
 String qy1="#E5C862";
 String yl1="#8DE4A6";
 String cz1="#AACC6F"; 
 String ld1="#FF00FF"; 
 String ws1="#DDE8E8";
if (!strSection.equals("")){
String SQL="select  *  from SaleStateColor WHERE secno='"+strSection+"'";

ResultSet rsColor=InsertBean.executeQuery(SQL);	
if (rsColor.next()){
   rg1=rsColor.getString("RG");
   qy1=rsColor.getString("QY");
   ld1=rsColor.getString("ld");   
   cz1=rsColor.getString("CZ");
   yl1=rsColor.getString("YL");   
   ws1=rsColor.getString("ws");  
}

rsColor.close();
}
 String room_type ="";
 int colts=20;
	 String ss="select room_type,ts from LoftBuildCode where SECNO='"+strSection+"' and loft='"+Loft+"'";
     ResultSet ssr=InsertBean1.executeQuery(ss);
   if (ssr.next()){
    room_type=ssr.getString("room_type");
	colts=ssr.getInt("ts");
   }
if (rg1.equals("")){%>
<script>
        alert("��û������Ϊ���ر�����״̬ɫ��,����ϵͳ����������");
       
</script>
<%} %> 
 
 <table width="80%" border="0" CELLSPACING=1 CELLPADDING=3>
    <tr><td bgcolor='<%=ws1 %>' align="center">δ��</td>
	<td bgcolor='<%=rg1 %>'  align="center">�Ϲ�</td>
	<td bgcolor='<%=qy1 %>'  align="center">ǩԼ</td>
	<td bgcolor='<%=yl1 %>'  align="center"> Ԥ�� </td>
	
	<td bgcolor="<%=ld1 %>"  align="center">�ٶ�</td>
	 
 
	<td   align="center"> &nbsp;</td>

	</tr>
	 
	 
  
	</table>
		 
<%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
  <table width="98%" border="0" CELLSPACING=1 CELLPADDING=3 >
  <%  if (room_type.indexOf("��")<0&&room_type.indexOf("��")<0&&intEndR<=colts){%>
    <tr>
		
      <td width="1%" align="center" class=listtitle><font color="#FFFFFF"<b><%if (!Rinfo.equals("")) {out.print(Rinfo+"��Ԫ");}%>¥��\����</b></font></td>
		<%
		char BeF=RoomNoUp.charAt(0);
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);
		for(int j=intBeginR;j<=intEndR;j++){
		
	        String NO="";
		    NO=AsiicZH(j,BeR);//����asiicת������
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
			 if (upp.indexOf(LockRoomS)>=0){
		 	 if (!Lock.contains(String.valueOf(j))){
			%>
		     <td align="center" class=listtitle width="1%"><font color="#ffffff"><%=NO%></font> </td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" class=listtitle width="1%%"><font color="#ffffff"><%=NO%></font></td>
			 <%} %>	
			<%}else if (!Lock.contains(String.valueOf(j))){
			 
			 %>
			 <td align="center" class=listtitle width="1%%"><font color="#ffffff"><%=NO%></font> </td>
			 
			 <%}
			 
			 }%>
			 
	</tr>
	<%
	}
    List list1=new LinkedList();//��ŷ������
	List list2=new LinkedList();//��ŷ���״̬
	List list3=new LinkedList();//�������FLoor
    List list4=new LinkedList();//��ŷ���
	List list5=new LinkedList();//��ŷ���
	List list6=new LinkedList();//�������״̬
	List list7=new LinkedList();//���¥�㸽����
	List list8=new LinkedList();//�����ʾ¥�����
	String floorshow="";
	String floormess="";//¥�㸽����
	 String showfloors="";//��ʾ¥��
	String  sqlR="select r1.RoomNo,r1.state,r1.Floor,r1.room,r2.salestate,r1.floormess,r1.ShowFloors from RoomNo r1,room r2 where  r1.SectionNo=r2.seccode and  r1.region=r2.loft  and  r1.roomno=r2.room_code  and  r1.floor=r2.floor and  r1.room=r2.room and  r1.SectionNo=";
			sqlR=sqlR+"'"+strSection+"' and r1.Building='";
			sqlR=sqlR+strBuilding+"'  and  r2.cell='"+Rinfo+"' and  r1.Region='"+Loft+"'  order by r1.Floor,r1.room";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlR);
 
		   int aryi=0;
		    String Rinfo1=Rinfo;
           if (!Rinfo1.equals(""))Rinfo1=Rinfo1+"-";
		   while (rsArr.next()){
		     list5.add(getbyte(rsArr.getString("RoomNo")));
			 checRoom=(String)list5.get(aryi); 
			 list2.add(rsArr.getString("state"));
			 String FloorS=rsArr.getString("Floor");
			 String RoomS=rsArr.getString("Room");
			 list6.add(rsArr.getString("salestate"));
			
			 list7.add(getbyte(rsArr.getString("floormess")));
			   list8.add(getbyte(rsArr.getString("ShowFloors")));
			 list3.add(FloorS);
			 list4.add(RoomS);
			
			//   if (FloorS.indexOf("-")>=0||FloorS.equals("0"))FloorS="";
			 if (Integer.parseInt(RoomS)>=10){   
			 list1.add(Rinfo1+FloorS+RoomS);
			}else{
			  list1.add(Rinfo1+FloorS+"0"+RoomS);
			 
			  }
		    aryi+=1;
			
		   } 
	      rsArr.close();
		int arrlen=0;
		  int hs=0;
		 out.print("<tr>");
	 for(int i=intBeginF;i<=intEndF;i++){
	hs=0;
	 String ro=String.valueOf(i);
	if (hs==0)out.print("<tr>");
	  if (room_type.indexOf("��")<0&&room_type.indexOf("��")<0){
	%><td align="center" class=FloorC width="1%"><font color="#ffffff"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></font></td>
		<%  }else{ %> 
		<div style='display:none' id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div>
		
 
     	<%}
		 
		for(int j=intBeginR;j<=intEndR;j++){
		 if (hs==colts){hs=0;out.print("</tr><tr>"); 
	     if (room_type.indexOf("��")<0&&room_type.indexOf("��")<0){//��������ʾ¥��
	%><td align="center" class=FloorC width="1%"><font color="#ffffff"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></font></td>
		<%  }else{ %> 
		<div style='display:none' id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div>
		
 
     	<%}
	 }
		 Rinfo1=Rinfo;
       if (!Rinfo1.equals(""))Rinfo1=Rinfo1+"-";
       	String RoomNo="";
		String no="";
		String salestate="";
		   if (j>=10)
		    RoomNo=Rinfo1+ro+String.valueOf(j);
		   else
		    RoomNo=Rinfo1+ro+"0"+String.valueOf(j);

		arrlen+=1;
     
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   RoomNo=(String)list5.get(index);
		   salestate=(String)list6.get(index);
		   floormess=(String)list7.get(index);
		   
		     showfloors=(String)list8.get(index);
		 }else{state="";}  
		
	   if (!Lock.contains(String.valueOf(j))){
	     hs++;
		if (state.equals("0"))
		
		{%>
		<td align="center" 1% class=roomright><a href="#" title="���������뷿������" onclick="javascript:openwin1('crm_RoomInput.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&salestate=<%=salestate %>&floormess=<%=floormess %>',501,500,150,10);" ><%=RoomNo%></a> </td>
		<%
		}else if (state.equals("1")){
		String bg="";
		 if (salestate.equals("1")){ bg="bgcolor='"+ws1+"'";}
		 if (salestate.equals("2")){ bg="bgcolor='"+rg1+"'"; }
		 if (salestate.equals("3")){ bg="bgcolor='"+qy1+"'";}
		 if (salestate.equals("4")){ bg="bgcolor='"+yl1+"'";}
		 if (salestate.equals("5")){ bg="bgcolor='"+ld1+"'";}
		out.print("<td align='center'  "+bg+">");
		 
		%>
		 
		<a href="#" onclick="javascript:openwin1('crm_RoomEdit.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&currNo=<%=j %>&salestate=<%=salestate %>&floormess=<%=floormess %>',510,500,150,10);" title="������,�����ɲ鿴��������"><%=RoomNo%></a> </td>
		<%}else if (state.equals("")){out.print("<td align='center' class=roomright>&nbsp;</td>");}
    	}
		}
		
		%>
		  <script>//w1<%=Rinfo+String.valueOf(java.lang.Math.abs(i)) %>.innerHTML="<%if (!floormess.equals("")&&!showfloors.equals("")) out.print(String.valueOf(i)+floormess);else if (!floormess.equals("")&&showfloors.equals(""))  out.print(floormess);else  out.print(i);%>";</script>
	
	</tr>
	<% }%>
	 
 
	<%
	//��ʾ����¥��
	for(int i=mxinF;i<=-1;i++){
    %>
	<tr>
		<td align="center" 1% class=FloorC><font color="#ffffff"><div id="A<%=String.valueOf(java.lang.Math.abs(i)) %>w1"><%=i%></div</font></td>
		<%for(int j=intBeginR;j<=intEndR;j++){
      
		String RoomNo="";
		String  salestate="";
           if (j>=10)
		   RoomNo=Rinfo1+String.valueOf(j);
		   else
		    RoomNo=Rinfo1+ "0"+String.valueOf(j);
			 
		 if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   RoomNo=(String)list5.get(index);
		   salestate=(String)list6.get(index);
	       floormess=(String)list7.get(index);
		    showfloors=(String)list8.get(index);
		 }else{state="";}  
       if (!Lock.contains(String.valueOf(j))){
		if (state.equals("0"))
		{%>
		<td align="center" 1% class=roomright><a href="#" onclick="javascript:openwin1('crm_RoomInput.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&salestate=<%=salestate %>&floormess=<%=floormess %>',510,500,150,10);" ><%=RoomNo %></a> </td>
		<%
		}else 	if (state.equals("1")){
		String bg="";
		 if (salestate.equals("1")){ bg="bgcolor='"+ws1+"'";}
		 if (salestate.equals("2")){ bg="bgcolor='"+rg1+"'"; }
		 if (salestate.equals("3")){ bg="bgcolor='"+qy1+"'";}
		 if (salestate.equals("4")){ bg="bgcolor='"+yl1+"'";}
		 if (salestate.equals("5")){ bg="bgcolor='"+ld1+"'";}
	
		%>
        <td  align="center" 1% <%=bg %>><a href="#" onclick="javascript:openwin1('crm_RoomEdit.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&salestate=<%=salestate %>&floormess=<%=floormess %>',510,500,150,10);" title="������"><%=RoomNo %></a> </td> 
		<%
		}else {out.print("<td align='center' class=roomright></td>");}
		}
	  }%>
	    <script>A<%=String.valueOf(java.lang.Math.abs(i))%>w1.innerHTML="<% if (!floormess.equals("")&&!showfloors.equals("")) out.print(String.valueOf(i)+floormess);else if (!floormess.equals("")&&showfloors.equals(""))  out.print(floormess);else  out.print(i);%>";</script>
	
	</tr>
	<% }%>
  </table>
    <%}} %> 
   
<% 
 
 String CountSql="select count(*) as num,sum(area) as area,sum(sumprice) as sumprice,sum(sumprice)/sum(area) avg  from room  where seccode='"+strSection+"' and  Loft='"+Loft+"' ";
 String sumnum="";
 String sumarea="";
 String sumprice="";
 String avg="";
 ResultSet rs2=InsertBean.executeQuery(CountSql);

if (rs2.next()){sumnum=rs2.getString("num");sumarea=df1.getFloat1(rs2.getFloat("area"),2);sumprice=df1.getFloat2(rs2.getDouble("sumprice"),2);avg=df1.getFloat1(rs2.getFloat("avg"),2);}
rs2.close();
%>
</table>
 
<table BORDER=0 width="98%" CELLSPACING=1 CELLPADDING=0 bordercolor="#FFFFFF" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 

 <td>���ۺϼƣ�</td>
<td>��������<%=sumnum %></td><td>���������<%=sumarea %></td><td>���۽�<%=sumprice %></td><td>���۾��ۣ�<%=avg %></td>
</tr>

 
<%  CountSql="select count(*) as num,sum(area) as area,sum(sumprice) as sumprice,sum(sumprice)/sum(area) avg from room  where seccode='"+strSection+"' and salestate=1 and  Loft='"+Loft+"'";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs2=InsertBean.executeQuery(CountSql);

if (rs2.next()){sumnum=rs2.getString("num");sumarea=df1.getFloat1(rs2.getFloat("area"),2);sumprice=df1.getFloat2(rs2.getDouble("sumprice"),2);avg=df1.getFloat1(rs2.getFloat("avg"),2);}
rs2.close();
%>
 
    <tr class=listtitle align="center" > 

 <td>δ�ۺϼƣ�</td>
<td>δ��������<%=sumnum %></td><td>δ�������<%=sumarea %></td><td>δ�۽�<%=sumprice %></td><td>δ�۾��ۣ�<%=avg %></td>
</tr>  

<%  CountSql="select count(*) as num,sum(jzarea) as area,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) avg from order_contract  where section='"+strSection+"' and state<>3 and  Loft='"+Loft+"'";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs2=InsertBean.executeQuery(CountSql);

if (rs2.next()){sumnum=rs2.getString("num");sumarea=df1.getFloat1(rs2.getFloat("area"),2);sumprice=df1.getFloat2(rs2.getDouble("sumprice"),2);avg=df1.getFloat1(rs2.getFloat("avg"),2);}
rs2.close();
%>
  <tr class=listtitle align="center" > 

 <td>���ۺϼƣ�</td>
<td>����������<%=sumnum %></td><td>���������<%=sumarea %></td><td>���۽�<%=sumprice %></td><td>���۾��ۣ�<%=avg %></td>
</tr>
</table>
 <input type=hidden name=checkroom value="<%=checRoom %>">
</form>  
<script language="javascript" src="cancel_room_code.js"></script>
 <%InsertBean.closeConn();
  InsertBean1.closeConn();
 
  %>
</div>
</form>
</body>
</html>
