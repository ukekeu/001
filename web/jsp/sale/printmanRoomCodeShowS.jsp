<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

 
 <%@ include file="../public_js/qx_checke.jsp"%>
 
<html>
<head>
	<title>���ر�--�������Ҽ���ѡ���ӡ��F5ˢ��ֱ�Ӵ�ӡ</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js">
</script>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean2" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%
 

String strMessage=China.getParameter(request,"mess");
String SecName=request.getParameter("SecName");
String Region=China.getParameter(request,"Region");
String condi=China.getParameter(request,"condi");
 
String RegionStr="";
   
String state="";
String fontColor="";
String strYN=request.getParameter("yn");
String strSection="";


String Loft="";
String strBuilding="";
 

%> 
<SCRIPT language=javascript>

function changebuild(obj){
   var objvalue=obj;
   var html="";
   var i=0;
   var arr=new Array();
   <%String sqlx= "select SerialNo,Name from CRM_Project " ;
 ResultSet Rsx = InsertBean1.executeQuery(sqlx) ;
 while (Rsx.next()) {
String tmpid = Rsx.getString("SerialNo") ;%>
    if(objvalue=="<%=tmpid%>"){
html="";
i=0;
<%  int j=1;
    int x=0;
	String sqlUser = "select  loft from Sectiontree where  SerialNo='"+tmpid+"' group by loft";
	//out.print(sqlUser);
ResultSet userRs = InsertBean2.executeQuery(sqlUser) ;
while (userRs.next()) {
String housename = userRs.getString("loft") ;
if (housename == null)
  housename = "" ;
  housename = getbyte(housename) ;
%>
arr[i]="<option value='<%=housename%>' <%if (getbyte1(request.getParameter("Loft")).equals(housename)){out.print("selected");} %>><%=housename%></option>";
++i;
    <%}userRs.close();%>
html="<select name='Loft' style='width=100;' onchange='frm.submit();'><option value=''></option>"+arr.join();
html=html+"</select>";
document.all("sub").innerHTML=html;

}
  <%}Rsx.close();%>
}
 
function submitC(){
  document.frm.action="RoomCodeShowS.jsp";
  document.frm.submit();


}
function getseldocs1() {
     var x=0;
	 var seldocs = new Array();
     var seldocs1 = new Array();
	 var temp=document.frm.elements.length;
 
     for (i=0;i<document.frm.yl.length;i++) {
	 if (document.frm.yl[i].checked)
		 {
       		seldocs[x]="'"+document.frm.yl[i].value+"'";
			seldocs1[x]=document.frm.yl[i].value;
			x++;
   		 }
	  }	
     var returnvalue="";
	  if (seldocs!="")
	   returnvalue=seldocs;//+"/"+seldocs1
   return returnvalue
}
function ylroom(){
    var rooms=getseldocs1();
    if (rooms==""){alert("��ѡ��Ԥ���ķ��䣡");return false;}
    var url="add_yl_rooms.jsp?rooms="+rooms+"&loft=<%=Loft %>&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
    var newWin = window.open(url,"roomfrm","height=350,width=510,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
    newWin.focus() ;
}
function choose(para){

  for (i=0;i<document.frm.elements.length;i++) {
 
 if((document.frm.elements[i].type=="checkbox")&&(document.frm.elements[i].value==para)&&(document.frm.elements[i].name=="yl"))
   document.frm.elements[i].checked=true;
   else document.frm.elements[i].checked=false;
}
}

</script >	 
<body topmargin="1" onload="document.all.WebBrowser.ExecWB(7,1);" >
   <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>


 
<form name=frm method="post" action="manRoomCodeShowS.jsp"  >
 
  <div align=left id=report1> 
 
 
<%@ include file="../public_js/CheckSection.jsp"%>
<%   strSection=getbyte1(request.getParameter("section_select"));
int aaa=0;
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql="select SerialNo,Name from CRM_Project where SerialNo ='"+strSection+"'";
	  ResultSet rs2=InsertBean2.executeQuery(sql);
	
	  String sec="";
	  String no="";
  %> 
<%
     if (rs2.next()){
	    no=rs2.getString("SerialNo");
        sec=getbyte(rs2.getString("Name"));
	    if (strSection.equals(no))SecName=sec;
	  }
	    rs2.close();
     %>  
 
 
<table border="0"  width="100%"><tr>
<%

String manSQL="select Loft FROM sectiontree where SerialNo='"+strSection+"'";
  Loft=getbyte1(request.getParameter("Loft"));
if (!Loft.equals(""))manSQL+=" and Loft='"+Loft+"' ";

manSQL+="group by Loft";
 
ResultSet manRS=null;
 manRS=InsertBean2.executeQuery(manSQL);
 
 while (manRS.next()){
 aaa++;
 out.print("<td valign='top'>");
   Loft=getbyte(manRS.getString("Loft"));
String FindStr="";	
if (!Loft.equals("")) FindStr=" and loft='"+Loft+"'";
if (!strBuilding.equals("")) FindStr+=" and building='"+strBuilding+"'";

String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
sql1+=" loft='"+Loft+"' and build='"+strBuilding+"'";
ResultSet rsLock=null;
String lock="";
String LockRoomS="";
List Lock=new LinkedList();//��Ž��ú�
try{
  rsLock=InsertBean.executeQuery(sql1);
  
  while (rsLock.next()){
    String aaaa=rsLock.getString("LockRoom");
	if (lock.equals(""))lock=aaaa;
	else lock+=","+aaaa;
	   
	char lokeA=aaaa.charAt(0);
	if(!java.lang.Character.isDigit(lokeA)){
	  aaaa=String.valueOf(Character.getNumericValue(lokeA)-9);
	}
	 Lock.add(aaaa);
    if (LockRoomS.equals(""))
     LockRoomS=aaaa;
	else
	 LockRoomS+=","+aaaa;
     
 
  }
  rsLock.close();
}catch(Exception s)  {}
 
        sql="select floor from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"' and floor=0";
ResultSet rs=InsertBean.executeQuery(sql);
int FF=1;
if (rs.next())FF=rs.getInt("floor");rs.close();
        sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR,max(cell) as Ecell ,min(cell) as Scell from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"'";
       rs=InsertBean.executeQuery(sql);
 int intBeginF=0;
 int intEndF=0;
 int intBeginR=0;
 int intEndR=0;
int mxinF=0;
String Ecellname="";
String Scellname="";
String Rinfo="";
if (rs.next()){
  intBeginF=rs.getInt("BeginF");
  //mxinF=intBeginF;
   //if (intBeginF<0)intBeginF=FF;
  intEndF=rs.getInt("EndF");
  intBeginR=rs.getInt("BeginR");
  intEndR=rs.getInt("EndR");
   Ecellname=getbyte(rs.getString("Ecell"));
  Scellname=getbyte(rs.getString("Scell"));
  if (Scellname.equals("")&&Ecellname.equals("")){ Ecellname=" ";Scellname=" ";}
}
rs.close();

 int scell=0,ecell=0;
char  CellN1=Scellname.charAt(0);
char  CellN2=Ecellname.charAt(0);

if (!Scellname.equals("")&&!Ecellname.equals("")){
   CellN1=Scellname.charAt(0);
   CellN2=Ecellname.charAt(0);

if(java.lang.Character.isDigit(CellN1)){
	 scell=java.lang.Integer.parseInt(Scellname);
	 ecell=java.lang.Integer.parseInt(Ecellname);
}
else{
     scell=Character.getNumericValue(CellN1)-9;
	 ecell=Character.getNumericValue(CellN2)-9;
}
 
}
if (scell<0)scell=0;
if (ecell<0)ecell=0;
String fsfc="";
  rs=InsertBean.executeQuery("select roomtype from LoftBuildCode where SecNo='"+strSection+"' and Loft='"+Loft+"' and roomtype=1");
 if (rs.next()){
   fsfc="1";
 }
  rs.close(); 
 %>
 

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
if (rg1.equals("")){%>
<script>
        alert("��û������Ϊ���ر�����״̬ɫ��,����ϵͳ����������");
       
</script>
<%} %> 
 <%
//Ȩ�����
String Cortrol=checke_qx(InsertBean,(String)session.getAttribute("loginid"),"QT12");
    if (Cortrol==null)Cortrol="";
	
 String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	  
 %>

<p CLASS=FontColor align="center"><b><font size="3" ><%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft+strBuilding %>���ر�</b></p>
 <table width="98%" align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr><td bgcolor='<%=ws1 %>' align="center">δ��</td>
	<td bgcolor='<%=rg1 %>'  align="center">�Ϲ�<img src='../images/mypw.gif' border='0' ></td>
	<td bgcolor='<%=qy1 %>'  align="center">ǩԼ<img src='../images/maIcon.gif' border='0' ></td>
	<td bgcolor='<%=yl1 %>'  align="center">Ԥ��<img src='../images/day2.gif' border='0' ></td>
	<td bgcolor="<%=ld1 %>"  align="center">�ٶ�<img src='../images/face39.gif' border='0' ></td>
	 
	<td   align="center">&nbsp;
	 </td>

	</tr>
	 <tr><td bgcolor='<%=ws1 %>' align="center"><div id=w<%=aaa %>></div></td>
	<td bgcolor='<%=rg1 %>'  align="center"><div id=r<%=aaa %>></div></td>
	<td bgcolor='<%=qy1 %>'  align="center"><div id=s<%=aaa %>></div></td>
	<td bgcolor='<%=yl1 %>'  align="center"><div id=y<%=aaa %>></div></td>
	<td bgcolor="<%=ld1 %>"  align="center"><div id=l<%=aaa %>></div></td>
	<!--<td bgcolor='<%=cz1 %>'  align="center"><div id=re></div></td>-->
   <td   align="center"><div id=sum<%=aaa %>> </div>
	</td>
	
	</tr>
	 <tr><td bgcolor='<%=ws1 %>' align="center"><div id=w1<%=aaa %>></div></td>
	<td bgcolor='<%=rg1 %>'  align="center"><div id=r1<%=aaa %>></div></td>
	<td bgcolor='<%=qy1 %>'  align="center"><div id=s1<%=aaa %>></div></td>
	<td bgcolor='<%=yl1 %>'  align="center"><div id=y1<%=aaa %>></div></td>
	<td bgcolor="<%=ld1 %>"  align="center"><div id=l1<%=aaa %>></div></td>
	<!--<td bgcolor='<%=cz1 %>'  align="center"> <div id=re1></div>-->
	</td>
   <td   align="center"> &nbsp;
	</td>
	</tr>
	</table>

  <%// try{   
       int nosalenum=0;
	   int rgnum=0;
	   int salenum=0;
	   int rentnum=0;
	   int yl=0;
	   int ld=0;
  
        String BuildPa=request.getParameter("Build");
        if (BuildPa==null)BuildPa="";
		String locaPara="Loft="+request.getParameter("Loft")+"&Build="+BuildPa+"&SecNo="+request.getParameter("SecNo")+"&SecName="+request.getParameter("SecName");
		String upp="ABCDEFGHIJKLOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 Room_code from Room where seccode=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and loft='"+Loft+"'  ";
		ResultSet rsU=InsertBean1.executeQuery(sqlU);
        if (rsU.next())RoomNoUp=rsU.getString("Room_code");
		rsU.close();
 
        if (RoomNoUp.equals("")){
		%>
		<script>
       // alert("�˶���û�н��з�������¼�����");
        //window.location="../basic/RoomCodeShow1.jsp?<%=locaPara %>&notbg=y";
       //}
</script>
		 <%}else{
		  

%> 
<script>
  function px(para){
    if (para=="asc")document.frm.action="RoomCodeShowS.jsp";
	else document.frm.action="RoomCodeShowDS.jsp";
     document.frm.submit();
  
  }
	
	</script>
 <table width="100%" align="center" border="0" CELLSPACING=1 CELLPADDING=3>
   <tr valign="top"> 
 <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
 
		 
	<%
    List list1=new LinkedList();//�����λ����
	List list2=new LinkedList();//�����λ״̬
	List list3=new LinkedList();//�������FLoor
    List list4=new LinkedList();//��ŷ���
    List list5=new LinkedList();//��Ž������
    List list6=new LinkedList();//��ŵ�ǰ��Ԫcode
    List list7=new LinkedList();//��ŷ���
	List list8=new LinkedList();//���¥�㸽����
	List list9=new LinkedList();//���¥�㸽����
	List list10=new LinkedList();//����Ƿ��˹�����������
	List list11=new LinkedList();//����Ƿ�������
	List list12=new LinkedList();//��������ܼ�
	String floorshow="",showfloors="";
	String floortype="";
	String floormess="";
	String l6="";
    String l5="";
    String StrUpper="ABCDEFGHIJKLOPQRST"; 
	String sqlArr="select   a.dis, a.tddate,a.Room_code,a.saleState,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+FindStr+" and  a.cell='"+Rinfo+"' and a.floortype=0   order by a.Floor";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
 
		   int aryi=0;
		   while (rsArr.next()){
		    list7.add(rsArr.getString("Room_code"));
			list2.add(rsArr.getString("SaleState"));
			String FloorS=rsArr.getString("Floor");
			String RoomS=rsArr.getString("Room");
			floorshow=rsArr.getString("floorshow");
			floortype=rsArr.getString("floortype");
			list3.add(FloorS);
			list4.add(RoomS);
			if (Integer.parseInt(RoomS)>=10)
			 list1.add(Rinfo+FloorS+RoomS);
			else
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			
			list5.add(rsArr.getString("area"));
			list6.add(rsArr.getString("code"));
			list8.add(getbyte(rsArr.getString("floormess")));
			list9.add(getbyte(rsArr.getString("showfloors")));
			list10.add(rsArr.getString("dis"));
			list11.add(getbyte(rsArr.getString("tddate")));
			list12.add(getbyte(rsArr.getString("sumprice")));
		   } 
	      rsArr.close();
		int arrlen=0;
	 %>
	 <td align="center" valign="top"><%if (!Rinfo.equals("")) {out.print(Rinfo+"��Ԫ");}%>
	 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	   <tr>
	    <td   align="center">&nbsp;</td>

		 		<%
		char BeF=RoomNoUp.charAt(0);
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
 
        char BeR=RoomNoUp.charAt(0);
		for(int j=intBeginR;j<=intEndR;j++){
	        String NO="";
		   NO=AsiicZH(j,BeR);//����asiicת������
		 
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
			 if (upp.indexOf(LockRoomS)>=0){
			  
		  
			
			 if (LockRoomS.indexOf(String.valueOf(j))<0){
			%>
		     <td align="center" ><%=NO%><!--<input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this);">--></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){//LockRoomS.indexOf(String.valueOf(j))<0
			 %>
			 <td align="center" ><%=NO%></td>
			 <%} %>	
			 <%}
			 else{
			 
			 %>
			 <td align="center" ><%=NO%><!--<input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this);">--></td>
			 
			 <%}
			 
			 }%>
			 
		 	</tr>
	 <tr>
		
	<%
	 
	
	for(int i=intBeginF;i<=intEndF;i++){
	  
	%><td align="center"   width="50"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></td>
		
 
     	<%
		float IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		if (!Lock.contains(String.valueOf(j))){
		  no="";
		String RoomNo="";
		no="";
		String dis="0",tddate="";
	    if (j>=10)
		    RoomNo=Rinfo+String.valueOf(i)+String.valueOf(j);
		else
		    RoomNo=Rinfo+String.valueOf(i)+"0"+String.valueOf(j);
		arrlen+=1;
		
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		 
		    RoomNo=(String)list7.get(index);
			floormess=(String)list8.get(index);
			 	showfloors=(String)list9.get(index); 
		   if(!state.equals("1")){
                      try{
                        l6=(String)list6.get(index);
                        l5=(String)list5.get(index);
                       String  l7=(String)list12.get(index);
                      if (l6.equals("")||l6==null)l6="0";
                      if (l5.equals("")||l5==null)l5="0";   
					  if (l7.equals("")||l7==null)l7="0";      
                      IntAvgSumPrice+=Float.parseFloat(l7);
		             FatAreaSum+=Float.parseFloat(l5);
                      }catch(Exception s){}
		   }
		 }else{state="";}  
		 String bg="";
		 if(i==3 && j==4){
	   	 }
		 if (state.equals("1")){ bg="BGCOLOR='"+ws1+"'";}
		 if (state.equals("2")){ bg="bgcolor='"+rg1+"'"; }
		 if (state.equals("3")){ bg="bgcolor='"+qy1+"'";}
		 if (state.equals("4")){ bg="bgcolor='"+yl1+"'";}
		 if (state.equals("5")){ bg="bgcolor='"+ld1+"'";}
		// if (state.equals("6")){ bg="bgcolor='"+ws1+"'";}
		 if (state.equals("7")){ bg="bgcolor='"+cz1+"'";rentnum++;}
		  no=RoomNo;
		  
		     if (condi.equals("wen")){
		    bg="bgcolor='#c0c0c0'";
            if (state.equals("3")){ RoomNo="����"+no;}
            else if (state.equals("2")){ RoomNo="���Ϲ�"+no;}
            else if (state.equals("4")){ RoomNo="��Ԥ��"+no;}
          //  else if (state.equals("6")){ RoomNo="�Ѽ�֤"+no;}
			else if (state.equals("1")){ RoomNo="δ��"+no;}
			else if (state.equals("5")){ RoomNo="�ٶ�"+no;} 
			else if (state.equals("7")){ RoomNo="����"+no;} 
		 }else if (condi.equals("pic")){
		    bg="bgcolor='#c0c0c0'";
		    if (state.equals("2")){ RoomNo="<img src='../images/mypw.gif' border='0' title='���Ϲ����ţ�"+no+"'>";}
			else if (state.equals("3")){ RoomNo="<img src='../images/maIcon.gif' border='0' title='���۷��ţ�"+no+"' >";}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo="<img src='../images/day2.gif' border='0' title='���ٶ����ţ�"+no+"'>";}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo="<img src='../images/face39.gif' border='0' title='��Ԥ�����ţ�"+no+"'>";}
			else if (state.equals("6")){ RoomNo=no;}
			else if (state.equals("7")){ RoomNo=no;}
		 }else{
		    if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("3")){ RoomNo=no;}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo=no;}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo=no;}
			else if (state.equals("6")){ RoomNo=no;}
		 }
		  
		  
		if (!tddate.equals(""))tddate=tddate.substring(0,10);
		%>
	 <td align="center"  <%=bg %> <%if (dis.equals("1")){ %>title="��������:<%=tddate %>"<%} %>>
	<%if (fsfc.equals("")){ %>
	 <% if (state.equals("1")&&dis.equals("0")){nosalenum++; %>
	<%  if (Cortrol.indexOf("A")>=0){  %><a href="#<%=RoomNo %>" onclick="opennewwin('roomdata.jsp','?secname=<%=SecName %>&secno=<%=strSection%>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=1',720,530,120,5)"><%} %><%=RoomNo%><%  if (Cortrol.indexOf("A")>=0){  %></a><%} %>
	  <% }else if (state.equals("1")&&dis.equals("1")){  %>
	   <a href="#"> <%=RoomNo%>[����] </a>
	  <%}else if (state.equals("3")){ salenum++;%>
       <%=RoomNo%> 
	 <%}else if (state.equals("2")){rgnum++;%>
	   <a href="#<%=RoomNo %>" title="���δ��ӡ�Ϲ���,���޸��Ϲ���" onclick="opennewwin('modiorder.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=false',720,500,100,10)"><%=RoomNo%></a> 
	
	
	  
	 <%}else if (state.equals("4")){yl++;%>
	  <%=RoomNo%> 
	 <%}else if (state.equals("6")){ %>
	  <a href="#<%=RoomNo %>" onclick="opennewwin('ContractList.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=false',480,500,150,10)"><%=RoomNo%></a> 
	  <%}else if (state.equals("5")){ ld++;%>
	  <a href="#<%=RoomNo %>" onclick="opennewwin('roomdata1.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',720,530,120,5)"><%=RoomNo%></a>
	 <%} else if (state.equals("7") ){%>
	 <a href="#<%=RoomNo %>" onclick="opennewwin('show_rent_contract.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',720,530,120,5)"> <%=RoomNo%></a>
	 <%}else{ %>&nbsp;<%} %>
	 <%}else if (state.equals("1")&&!dis.equals("1")){ %>
	  <%=RoomNo%> 
	
	 <%}else  if (state.equals("2")){%>
	  <a href="#<%=RoomNo%>" onclick="opennewwin('ContractInput2.jsp','?roomcode=<%=l6 %>&secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=true',750,530,120,2);"><%=RoomNo%></a> 
	
	 <%} %>  
	 </td> 
		<%}%>
	
		<%}

%>
	 <script>A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1.innerHTML="<% if (!floormess.equals("")) out.print(String.valueOf(i)+floormess);else out.print(i);%>";</script>
	
	</tr>
	
	
	<%
	}
	for(int i=mxinF;i<=-1;i++){
	 %>
	<tr> 
     	<%
		float IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		if (!Lock.contains(String.valueOf(j))){
		  no="";
		String RoomNo="";
		no="";
	    if (j>=10)
		    RoomNo=Rinfo+String.valueOf(i)+String.valueOf(j);
		else
		    RoomNo=Rinfo+String.valueOf(i)+"0"+String.valueOf(j);
		arrlen+=1;
		
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		    RoomNo=(String)list7.get(index);
			floormess=(String)list8.get(index);
			showfloors=(String)list9.get(index); 
		   if(!state.equals("1")){
                      try{
                        l6=(String)list6.get(index);
                        l5=(String)list5.get(index);
                       String  l7=(String)list12.get(index);
                      if (l6.equals("")||l6==null)l6="0";
                      if (l5.equals("")||l5==null)l5="0";   
					  if (l7.equals("")||l7==null)l7="0";   
					   
                      IntAvgSumPrice+=Float.parseFloat(l7);  
		              FatAreaSum+=Float.parseFloat(l5);
                      }catch(Exception s){}
		   }
		 }else{state="";}  
		 String bg="";
		 if(i==3 && j==4){
	   	 }
		 if (state.equals("1")){ bg="BGCOLOR='#DDE8E8'";}
		 if (state.equals("2")){ bg="bgcolor='#00CCFF'"; }
		 if (state.equals("3")){ bg="bgcolor='#E5C862'";}
		 if (state.equals("4")){ bg="bgcolor='#8DE4A6'";}
		 if (state.equals("5")){ bg="bgcolor='#FF00FF'";}
		 if (state.equals("6")){ bg="bgcolor='#AACC6F'";}
		 if (state.equals("7")){ bg="bgcolor='#AACC6F'";rentnum++;}
		  no=RoomNo;
		   if (condi.equals("wen")){
		    bg="bgcolor='#c0c0c0'";
            if (state.equals("3")){ RoomNo="����"+no;}
            else if (state.equals("2")){ RoomNo="���Ϲ�"+no;}
            else if (state.equals("4")){ RoomNo="��Ԥ��"+no;}
          //  else if (state.equals("6")){ RoomNo="�Ѽ�֤"+no;}
			else if (state.equals("1")){ RoomNo="δ��"+no;}
			else if (state.equals("5")){ RoomNo="�ٶ�"+no;} 
			else if (state.equals("7")){ RoomNo="����"+no;} 
		 }else if (condi.equals("pic")){
		    bg="bgcolor='#c0c0c0'";
		    if (state.equals("2")){ RoomNo="<img src='../images/mypw.gif' border='0' title='���Ϲ����ţ�"+no+"'>";}
			else if (state.equals("3")){ RoomNo="<img src='../images/maIcon.gif' border='0' title='���۷��ţ�"+no+"' >";}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo="<img src='../images/day2.gif' border='0' title='���ٶ����ţ�"+no+"'>";}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo="<img src='../images/face39.gif' border='0' title='��Ԥ�����ţ�"+no+"'>";}
			else if (state.equals("6")){ RoomNo=no;}
			else if (state.equals("7")){ RoomNo=no;}
		 }else{
		    if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("3")){ RoomNo=no;}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo=no;}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo=no;}
			else if (state.equals("6")){ RoomNo=no;}
		 }
		  
		
		%>
	  <td align="center"  <%=bg %>>
	 <% if (state.equals("1")){nosalenum++; %>
	<%  if (Cortrol.indexOf("Y")>=0){  %> <input type=checkbox name=yl value="<%=RoomNo %>"><%} %><%  if (Cortrol.indexOf("A")>=0){  %><a href="#<%=RoomNo%>" onclick="opennewwin('roomdata.jsp','?secname=<%=SecName %>&secno=<%=strSection%>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=1',720,530,120,5)"><%} %><%=RoomNo%><%  if (Cortrol.indexOf("A")>=0){  %></a><%} %>
	 <%}else if (state.equals("2")){rgnum++; %>
       <a href="#<%=RoomNo%>" onclick="opennewwin('ContractInput.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=true',720,530,120,2)"><%=RoomNo%></a> 
	 <%}else if (state.equals("3")){salenum++;%>
	  <a href="#<%=RoomNo%>" onclick="opennewwin('ContractInput.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=true',720,530,120,2)"><%=RoomNo%></a> 
	 <%}else if (state.equals("4")){yl++;%>
	<%  if (Cortrol.indexOf("Y")>=0){  %>   <input type=checkbox name=yl value="<%=RoomNo %>"><a href="#<%=RoomNo%>" onclick="choose('<%=RoomNo%>');ylroom();"><%} %><%=RoomNo%><%  if (Cortrol.indexOf("Y")>=0){  %></a><%} %>
	 <%}else if (state.equals("6")){ %>
	  <a href="#<%=RoomNo%>" onclick="opennewwin('ContractList.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=false',480,500,150,10)"><%=RoomNo%></a> 
	  <%}else if (state.equals("5")){ ld++;%>
	  <a href="#<%=RoomNo%>" onclick="opennewwin('roomdata1.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',720,530,120,5)"><%=RoomNo%></a>
	 <%} else if (state.equals("7") ){%>
	 <a href="#<%=RoomNo%>" onclick="opennewwin('show_rent_contract.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',680,530,120,5)"> <%=RoomNo%></a>
	 <%}else{ %>&nbsp;<%} %>
	 </td>
	 
	 
	
		<%}%>
		
		
		<%}%>
	 
 </tr>
	
	
	 
	<%}
	out.print("</td></tr></table>");
	} %>
	
  <%} %>
</td></tr>
	  </table>
  
  <script>
  function opennewwin(url,para,wh,hg,lf,tp) {
   var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
  function printT(){
  pri.innerHTML="";
  print();
  
  }
  function opennewwin1(para,wh,hg,lf,tp) {
    
	
	var newwin=window.open("rgList.jsp?"+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10");
	
  }
  
  w<%=aaa %>.innerHTML = "<%=nosalenum %>";
  w1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(nosalenum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  r<%=aaa %>.innerHTML = "<%=rgnum %>";
  r1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(rgnum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  s<%=aaa %>.innerHTML = "<%=salenum %>";
  s1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(salenum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  y<%=aaa %>.innerHTML = "<%=yl %>";
  y1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(yl))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  l<%=aaa %>.innerHTML = "<%=ld %>";
 l1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(ld))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
 // re.innerHTML = "<%=rentnum %>";
  //re1.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(rentnum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";

  sum<%=aaa %>.innerHTML = "�ϼƣ�<%=ld+nosalenum+yl+salenum+rgnum+rentnum %>";
   
  </script>
  </td>
<%//}catch(Exception s){}%>
<%} %>
</tr></table>
 </div>
</form>  
 

</body>
</html>
