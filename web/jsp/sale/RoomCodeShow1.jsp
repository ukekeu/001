<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

 <%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginname" ) ,
                  "����״��" , 
                  "���"
                ) ;
%>

<html>
<head>
	<title>�������б�</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js">
</script>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%
String strMessage=China.getParameter(request,"mess");
String SecName=request.getParameter("SecName");
String Region=China.getParameter(request,"Region");
String condi=China.getParameter(request,"condi");

String RegionStr="";
  if (Region.indexOf("*")>0){
	    RegionStr=Region.substring(Region.indexOf("*")+1);
	   Region=Region.substring(0,Region.indexOf("*"));
		}
String state="";
String fontColor="";
String strYN=request.getParameter("yn");
String strSection="";


String Loft="";
String strBuilding="";
if (condi.equals(""))
  {
  SecName=request.getParameter("SecName");
  strSection=request.getParameter("SecNo");
  Loft=request.getParameter("Loft");		
  strBuilding=request.getParameter("Build");
  }
else
  {
  SecName=China.getParameter(request,"SecName");
  strSection=China.getParameter(request,"Section");
  Loft=China.getParameter(request,"Loft");	
  strBuilding=China.getParameter(request,"Build");
}
if (strBuilding==null) strBuilding="";
//----------�õ�����ͻ������������֤�ţ���ϵ�绰

String ref_phone=request.getParameter("ref_phone");
String ref_cusname=request.getParameter("ref_cusname");
String ref_id_card=request.getParameter("ref_id_card");
String ref_money = request.getParameter( "ref_money" ) ;
String ref_id= request.getParameter( "ref_id" ) ;

//---------------�õ� ¥�̺� , �ں� , ���� , 
strSection = request.getParameter("SecNop");
Loft = request.getParameter("Loftp");		
strBuilding = request.getParameter("Buildp");

if( strSection == null ) {
    strSection = "" ;
}
if( Loft == null ) {
    Loft = "" ;
}
if( strBuilding == null ) {
    strBuilding = "" ;
}

String sq_panmin = "select Name FROM crm_project where SerialNo = '" + strSection + "' " ;
ResultSet rs_panmin = ViewBean.executeQuery( sq_panmin ) ;
String panMing= "" ;
if( rs_panmin.next() ) {
    panMing = getbyte( rs_panmin.getString( 1 ) ) ;
}
rs_panmin.close();

String FindStr="";	
if( Loft == null ) {
	Loft = "" ;
}
if (!Loft.equals("")) FindStr=" and loft='"+Loft+"'";
if (!strBuilding.equals("")) FindStr+=" and building='"+strBuilding+"'";

String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
sql1+=" loft='"+Loft+"' and build='"+strBuilding+"'";
ResultSet rsLock=null;

String LockRoomS="";
try{
  rsLock=InsertBean.executeQuery(sql1);
  while (rsLock.next()){
    LockRoomS=rsLock.getString("LockRoom");
  }
  rsLock.close();
}catch(Exception s)  {}

String  sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR from";
		sql=sql+" roomstateview where seccode='"+strSection+"'";
		sql=sql+FindStr+" and SaleState in (1,2,3,4,5,6)";
		
 ResultSet rs=InsertBean.executeQuery(sql);
 int intBeginF=0;
 int intEndF=0;
 int intBeginR=0;
 int intEndR=0;
if (rs.next()){
  intBeginF=rs.getInt("BeginF");
  intEndF=rs.getInt("EndF");
  intBeginR=rs.getInt("BeginR");
  intEndR=rs.getInt("EndR");

}
rs.close();

%> 
<script>
function submitC(){
  document.frm.action="RoomCodeShow.jsp";
  document.frm.submit();


}
function getseldocs1() {
     var x=0;
	 var seldocs = new Array();
     var seldocs1 = new Array();
	 var temp=document.frm.elements.length;

     for (i=0;i<document.frm.elements.length;i++) {
	   if ((document.frm.elements[i].type=="checkbox")&&(document.frm.elements[i].checked)&&(document.frm.elements[i].name=="yl"))
		 {
       		seldocs[x]="'"+document.frm.elements[i].value+"'";
			seldocs1[x]=document.frm.elements[i].value;
			x++;
   		 }
	  }	
     var returnvalue="";
	  if (seldocs!="")
	   returnvalue=seldocs+"/"+seldocs1;
   return returnvalue
}
function ylroom(){
    var rooms=getseldocs1();
    if (rooms==""){alert("��ѡ��Ԥ���ķ��䣡");return false;}
    var url="add_yl_rooms.jsp?rooms="+rooms+"&loft=<%=Loft %>&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
    var newWin = window.open(url,"roomfrm","height=250,width=410,left=150,top=50,resizable=yes,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no");
    newWin.focus() ;
}
</script >	
<body oncontextmenu="return false"  onload="setSelectMad(document.frm.condi,'<%= condi %>');">
<!--
<div id="ebusiness" style="position:absolute; left:380px; top:60px; width:125px; height:50px; z-index:1; visibility: hidden"> 
 <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" onMouseOver="MM_showHideLayers('ebusiness','','show');" onMouseOut="MM_showHideLayers('ebusiness','','hide')">
                <tr bgcolor="#617EBB"> 
                  <td class="a9px"><font color="#FFFFFF">˵��:</font></td>
                </tr>
                <tr bgcolor="#617EBB"> 
                  <td class="a9px"><font color="#FFFFFF">&nbsp;&nbsp;
				 1.������ǵ�����۵ķ��䣬���Կ����˷����Ӧ�����ۺ�ͬ������Ľ��ȡ��ͻ������ϼ��������ϸ����
				 <br>&nbsp;&nbsp;
				 2.������ǵ�����Ϲ��ķ��䣬���Կ����˷����Ӧ���Ϲ������ϡ�����Ľ��ȡ��ͻ������ϼ��������ϸ����
				 <br>&nbsp;&nbsp;
				 3.������ǵ��δ�Ϲ��ķ��䣬���Կ����˷����Ӧ�ķ������ϸ���ϼ������Ϲ��Ǽ�.
                 <br>&nbsp;&nbsp;
				 4.�������"����"�ɼ�����ѯ������¥�̻򶰵ĵ�����״��.
				  </font></td>
                </tr>         
                <tr bgcolor="#617EBB"> 
                  <td class="a9px"><font color="#FFFFFF"></font></td>
                </tr>         
                    
</table>	
</div>
-->
<div align="center">

<p CLASS=FontColor><b><font size="3" >�� �� ��</font></b></p>
<form name=frm method="post" action="">
<input type=hidden name=Section_h value="<%=strSection%>">
<input type=hidden name=SecName_h value="<%=SecName%>">
<input type=hidden name=Loft_h value="<%=Loft %>">
<input type=hidden name=Build_h value="<%=strBuilding %>">
<table width="90%" border="0">
 <tr bgcolor="#EAEAEA" >
  <td>
					  <%
      String sqpan="select SerialNo,Name from Section ";
					   ResultSet rs2=ViewBean.executeQuery(sqpan);
	                    String sec="";
	                    String nopan=""; %>
ѡ��¥��:&nbsp;<select name="SecNo"  OnChange="FindArry();" style="width=100;">
					      <option>&nbsp;</option>
						  <%while (rs2.next()){
	                          nopan=rs2.getString("SerialNo");
	                          sec=getbyte(rs2.getString("Name"));
     	                      out.print("<option value='"+nopan+"'>"+sec+"</option>");
	                         }
	                        rs2.close();
	                        
                              %> 
							</select>
<input type=hidden name=sel>
<%
                  String Sql = "" ;
			      Sql="select  SectionNo,Region,Building from roomno group by SectionNo,Region,Building";
                 ResultSet Rs=ViewBean.executeQuery(Sql);
                 out.print("<script>");
                 out.print("var SecionCus=new Array();");
                 out.print("var Lost=new Array();");
                 out.print("var Build=new Array();");
                 int i1=0;
                 while (Rs.next()){
                 out.print("SecionCus["+String.valueOf(i1)+"]="+"\""+Rs.getString("SectionNo")+"\""+";");
                 out.print("Lost["+String.valueOf(i1)+"]="+"\""+getbyte(Rs.getString("Region"))+"\""+";");
                 out.print("Build["+String.valueOf(i1)+"]="+"\""+getbyte(Rs.getString("Building"))+"\""+";");
            	 i1++;
                }	 
            %> 
 function FindArry(){
 var i=1;
 var lost="";
    cleasele();
    document.frm.Loft.options[i]=new Option("","");
    for (var j=0;j<SecionCus.length;j++){
	 var secno=document.frm.SecNo.options[document.frm.SecNo.selectedIndex].value;
	 if (secno.indexOf("*")>=0)
	 secno=secno.substring(0,secno.indexOf("*"));
	 if (secno==SecionCus[j]){
	    document.frm.sel.value=secno;
		//alert(document.frm.Loft.options[0]);
		if (lost!=Lost[j]){
		document.frm.Loft.options[i]=new Option(Lost[j],Lost[j]);
	    lost=Lost[j];
		i++;
		}
	} 
	
	}
   }
   function FindArry1(){
   var i=1;
   
    for (var j=0;j<SecionCus.length;j++){
	
	 secno=document.frm.sel.value;
	 if (secno==SecionCus[j]&&Build[j]!=""){
	    document.frm.build.options[i]=new Option(Build[j],Build[j]);
		i++;
	}else{document.frm.build.options[i]=new Option("","");

	} 
	
	}
	if (i==1)showRoom();

   }
   function cleasele(){
    document.frm.Loft.length=0;
    document.frm.build.length=0;
   }	
   </script>
ѡ���ں�: <select name="Loft" OnChange="FindArry1();" style="width:100"></select>
ѡ�񶰺�: <select name="build" style="width:100;" OnChange="showRoom()"></select>
  </td>
 </tr>
</table>
 <table width="80%" border="0">
    <tr><td bgcolor='#DDE8E8' align="center">δ��</td>
	<td bgcolor='#00CCFF'  align="center">�Ϲ�</td>
	<td bgcolor='#E5C862'  align="center">����</td>
	<td bgcolor='#8DE4A6'  align="center"><a href="#" onclick="ylroom();return false;" >Ԥ��</a></td>
	<td bgcolor="#FF00FF"  align="center">�ٶ�</td>
	<td bgcolor='#AACC6F'  align="center">
	<select name=condi onchange="submitC();">
	<option value="color">��ɫ��</option>
	<option value="wen">������</option>
	<option value="pic">��ͼ��</option>
	
	</select></td>

	</tr></table>
<br>
  <%    String BuildPa=request.getParameter("Build");        
        if (BuildPa==null)BuildPa="";
		String locaPara="Loft="+request.getParameter("Loft")+"&Build="+BuildPa+"&SecNo="+request.getParameter("SecNo")+"&SecName="+request.getParameter("SecName");
		String upp="ABCDEFGHIJKOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 Room_code from Room where seccode=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and loft='"+Loft+"'";
		ResultSet rsU=InsertBean1.executeQuery(sqlU);
        if (rsU.next())RoomNoUp=rsU.getString("Room_code");
		rsU.close();

       if (RoomNoUp.equals("")){

		%>
		
		 <%}else{%>
  <table width="90%" border="0" CELLSPACING=1 CELLPADDING=3>
   <tr class=roomright>
    <td colspan=6>
        ¥��:   <%= panMing %> �ں�:   <%= Loft %> ����: <%= strBuilding %> 
    </td>    
   </tr>
   <tr>
		<td width="100" bgcolor="#489A80" align="center"><font color="#FFFFFF"<b>¥��\����</b></font></td>
		<%
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);

		for(int j=intBeginR;j<=intEndR;j++){
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
        
			 if (upp.indexOf(LockRoomS)>=0){
			 
			   String NO="";
			   if(!java.lang.Character.isDigit(BeR)){
			       switch(j){
				    case 1:
				       NO="A";
					   break;	
			        case 2:
				       NO="B";
					   break;	
			        case 3:
				       NO="C";
					   break;	
			        case 4:
				       NO="D";
					   break;		
			        case 5:
				       NO="E";
					   break;	
			        case 6:
				       NO="F";
					   break;	
			        case 7:
				       NO="G";
					   break;	
			        case 8:
				       NO="H";
					   break;	
					 case 9:
				       NO="I";
					   break;			  		   	   		   
				  case 10:
				       NO="J";
					   break;			  		   	   		   	   	   
				  case 11:
				       NO="K";
					   break;		   
				  case 12:
				       NO="O";
					   break;	   		  		   	   		   
			      }
				 }else{NO=String.valueOf(j);}
			 if (LockRoomS.indexOf(NO)<0){
			%>
		     <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 <%}
			 }else if (LockRoomS.indexOf(String.valueOf(j))<0){
			 %>
			 <td align="center" class=listtitle><font color="#ffffff"><%=j%></font></td>
			 <%} %>	
			 <%}else{%>
			 <td align="center" class=listtitle><font color="#ffffff"><%=j%></font></td>
			 
			 <%}
			 
			 }%>
			  <td align="center" class=listtitle><font color="#ffffff">¥�����</font></td>	
	</tr>
	<%
    List list1=new LinkedList();//��ŷ������
	List list2=new LinkedList();//��ŷ���״̬
	List list3=new LinkedList();//�������FLoor
    List list4=new LinkedList();//��ŷ���
    List list5=new LinkedList();//��Ž������
    List list6=new LinkedList();//��ŵ�ǰ�ܼ�
	
    String StrUpper="ABCDEFGHIJKHOPQ"; 
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,area,Sumprice from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+FindStr+"  and SaleState in (1,2,3,4,5,6)  order by  Floor";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		
		   int aryi=0;
		   while (rsArr.next()){
		    
		    list1.add(getbyte(rsArr.getString("Room_code")));
			list2.add(getbyte(rsArr.getString("SaleState")));
			list3.add(getbyte(rsArr.getString("Floor")));
			list4.add(getbyte(rsArr.getString("Room")));
			list5.add(getbyte(rsArr.getString("area")));
			list6.add(getbyte(rsArr.getString("Sumprice")));
			//out.println(RoomArry[aryi]);
		   } 
	      rsArr.close();
		int arrlen=0;
	 %>
	<%for(int i=intBeginF;i<=intEndF;i++){
	
	%>
	<tr>
     <td align="center"  class=FloorC><font color="#ffffff"><%=i%></font></td>
		<%
		int IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		if (LockRoomS.indexOf(String.valueOf(j))<0){
		String no="";
		String RoomNo="";
		
		no="";
		if(!java.lang.Character.isDigit(BeR)){
		  try{ RoomNo=String.valueOf(i)+StrUpper.substring(j-1,j);}//��������������ĸ
		  catch(Exception s){out.close();}
		  }else{
		   if (j>=10)
		    RoomNo=String.valueOf(i)+String.valueOf(j);
		   else
		    RoomNo=String.valueOf(i)+"0"+String.valueOf(j);
		 }
		arrlen+=1;
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
                   String aa=(String)list6.get(index);
                   String aaa=(String)list5.get(index);
                   if (aa==null)  aa="";
                   if (aaa==null)  aaa="";
                   if (!aa.equals(""))
		   IntAvgSumPrice+=Float.parseFloat((String)list6.get(index));
                  if (!aaa.equals(""))
		   FatAreaSum+=Float.parseFloat((String)list5.get(index));
		 }else{state="";}  
		 String bg="";
		 if (state.equals("1")){ bg="BGCOLOR='#DDE8E8'";}
		 if (state.equals("2")){ bg="bgcolor='#00CCFF'"; }
		 if (state.equals("3")){ bg="bgcolor='#E5C862'";}
		 if (state.equals("4")){ bg="bgcolor='#8DE4A6'";}
		 if (state.equals("5")){ bg="bgcolor='#FF00FF'";}
		 if (state.equals("6")){ bg="bgcolor='#AACC6F'";}
		
		  no=RoomNo;
		 if (condi.equals("wen")){
            if (state.equals("3")){ RoomNo="����"+no;}
            else if (state.equals("2")){ RoomNo="���Ϲ�"+no;}
            else if (state.equals("4")){ RoomNo="��Ԥ��"+no;}
            else if (state.equals("6")){ RoomNo="�Ѽ�֤"+no;}
			else if (state.equals("1")){ RoomNo="δ��"+no;}
			else if (state.equals("5")){ RoomNo="�ٶ�"+no;} 
		 }else if (condi.equals("pic")){
		    if (state.equals("2")){ RoomNo="<img src='../picture/rg.gif' border='0' title='���Ϲ����ţ�"+no+"'>";}
			else if (state.equals("3")){ RoomNo="<img src='../picture/sale.gif' border='0' title='���۷��ţ�"+no+"' >";}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo=no;}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo=no;}
			else if (state.equals("6")){ RoomNo=no;}
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
	 <% if (state.equals("1")){ %>
	 <input type=checkbox name=yl value="<%=RoomNo %>"><a href="#" onclick="opennewwin('roomdata.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&ref_phone=<%=ref_phone %>&ref_id_card=<%=ref_id_card %>&ref_cusname=<%=ref_cusname %>&ref_money=<%=ref_money %>&ref_id=<%=ref_id %>&state=1',680,530,120,5)"><%=RoomNo%></a>
	 <%}else if (state.equals("2")){ %>
       <a href="#" onclick="opennewwin('ContractInput.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&show=true',680,530,120,2)"><%=RoomNo%></a> 
	 <%}else if (state.equals("3")){ %>
	  <a href="#" onclick="opennewwin('ContractInput.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&show=true',680,530,120,2)"><%=RoomNo%></a> 
	 <%}else if (state.equals("4")){%>
	   <input type=checkbox name=yl value="<%=RoomNo %>"><a href="#" onclick="opennewwin('roomdata.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&state=4',480,500,150,10)"><%=RoomNo%></a>
	 <%}else if (state.equals("6")){ %>
	  <a href="#" onclick="opennewwin('ContractList.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&show=false',480,500,150,10)"><%=RoomNo%></a> 
	  <%}else if (state.equals("5")){ %>
	  <a href="#" onclick="opennewwin('roomdata1.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&state=5',680,530,120,5)"><%=RoomNo%></a>
	 <%}else{ %>&nbsp;<%} %>
	 </td> 
		<%}%>
	
		<%}%>
	 <td><b><u><%=FormtD.getFloat(IntAvgSumPrice/FatAreaSum,2) %></u></b></td>	
	</tr>
	<% }
	}%>
	<%InsertBean.closeConn();
    InsertBean1.closeConn();
 
   %>
  </table>
  <script>
  function opennewwin(url,para,wh,hg,lf,tp) {
    var mess="�Ƿ��Ϲ���¼���ǲ鿴�������ϣ�(������Ϲ��뵥����ȷ�ϡ�)";
	 var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
  function opennewwin1(para,wh,hg,lf,tp) {
    
	
	var newwin=window.open("rgList.jsp?"+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10");
	
  }
   function showRoom()
    {
        var SecNo = document.forms[ 0 ].SecNo.options[ document.forms[ 0 ].SecNo.selectedIndex ].value ;
        var Loft = document.forms[ 0 ].Loft.options[ document.forms[ 0 ].Loft.selectedIndex ].value ;
        var Build = document.forms[ 0 ].build.options[ document.forms[ 0 ].build.selectedIndex ].value ;
     //alert(SecNo != "" && Loft != "");
		if(  SecNo != "" && Loft != ""
          )
          {
              document.frm.action="RoomCodeShow1.jsp?SecNop=" + SecNo + "&Loftp=" + Loft + "&Buildp=" + Build+"&ref_phone=<%=ref_phone %>&ref_id_card=<%=ref_id_card %>&ref_cusname=<%=ref_cusname %>&ref_money=<%=ref_money %>&ref_id=<%=ref_id %>" ;              
              document.frm.submit();
          }

    }
  </script>
</form>  
</div>
</body>
</html>
