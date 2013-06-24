<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>价目表</title>
</head>
<LINK href="../class/news.css" rel=stylesheet>
<LINK href="../class/mad.css" rel=stylesheet>
<script language="javascript" src="../public_js/public.js">

</script>
<script language="JavaScript" src='../public_js/basal.js'></script>
<%@ page language="java" import="java.sql.*,java.lang.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="getbyte" scope="page" class="getBytes.getBytes"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />

<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%

String strMessage=request.getParameter("mess");
String SecName=request.getParameter("SecName");
String state="";
String type="";
String fontColor="";
String  sql="";
 int intBeginF=0;
 int intEndF=0;
 int intBeginR=0;
 int intEndR=0;
String strRegionName="";
String strSecName="";
java.text.DecimalFormat df = new java.text.DecimalFormat(" ###,###.###"); 
if (strMessage==null){strMessage="";}
String whereFind=China.getParameter(request,"whereFind");

String strSection=getbyte1(request.getParameter("SecNo"));

strSecName=China.getParameter(request,"SecName");
String Floor="";//China.getParameter(request,"Floor");

String Loft=getbyte1(request.getParameter("Loft"));
String strBuilding=China.getParameter(request,"Building");
//strRegionName=Region.substring(Region.indexOf("*")+1);


String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
sql1+=" loft='"+Loft+"' and build='"+strBuilding+"'";
ResultSet rsLock=null;
String lock="";
String LockRoomS="";
List Lock=new LinkedList();//存放禁用号
try{
  rsLock=InsertBean.executeQuery(sql1);
  
  while (rsLock.next()){
    String aaa=rsLock.getString("LockRoom");
	if (lock.equals(""))lock=aaa;
	else lock+=","+aaa;
	   
	char lokeA=aaa.charAt(0);
	if(!java.lang.Character.isDigit(lokeA)){
	  aaa=String.valueOf(Character.getNumericValue(lokeA)-9);
	}
	 Lock.add(aaa);
    if (LockRoomS.equals(""))
     LockRoomS=aaa;
	else
	 LockRoomS+=","+aaa;
     
 
  }
  rsLock.close();
}catch(Exception s)  {out.print("err");}  

String FindStr="";

if (!Loft.equals("")) FindStr=" and loft='"+Loft+"'";

if (!strBuilding.equals("")) FindStr+=" and building='"+strBuilding+"'";
if (!Floor.equals("")) FindStr+=" and Floor='"+Floor+"'";
if (!whereFind.equals("")) FindStr+=" and "+whereFind;
 
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
%>
<body>


 


<script>
function submitC(){
  document.frm.action="RoomPriceShow.jsp";
  document.frm.submit();


}
function printReport(urlValue){
  openwin(urlValue,480,280,100,100);

}
function prin(){

		print();	

}
</script>	
<form method="POST" name="form1" action="">
  <input type=hidden name="whereFind">
  <input type=hidden name="SecNo" value="<%=strSection %>">
  <input type=hidden name="Loft" value="<%=Loft %>">
  <input type=hidden name="Building">
  <input type=hidden name="Floor">
    <input type=hidden name="SecName" value="<%=strSecName %>">
<p align=center class="FontColor"><font size=5><b><%if (!strSecName.equals(Loft)){out.print(strSecName);} %>房间价目表</b> </p>

 <table width="80%" border="0" CELLSPACING=1 CELLPADDING=3>
    <tr><td bgcolor='<%=ws1 %>' align="center">未售</td>
	<td bgcolor='<%=rg1 %>'  align="center">认购</td>
	<td bgcolor='<%=qy1 %>'  align="center">签约</td>
	<td bgcolor='<%=yl1 %>'  align="center"><a href="#" onclick="ylroom();return false;" >预留</a></td>
	<td bgcolor="<%=ld1 %>"  align="center">临定</td><td><div id="divprint" >
<input type=button name=dy value="打 印" onclick="prin();">
</div></td>
	</tr>
	</table><!--
<input type=button name=find value="查 找" onclick="printReport('../sale/auto_select6.jsp?PARA_SQL1=RoomDataChoose&PARA_SQL=ViewSectionData&url=9&loft=<%=Loft %>&secna=<%=strSecName %>');">-->

<div align="center">

<%


	    String roomno1="";
	    sql="select right(Room_Code,1) as Room_Code from room where seccode='"+strSection+"'"+FindStr;

		ResultSet rs2=null;
		 
		try{
		rs2=InsertBean1.executeQuery(sql);
	
	    }catch(Exception s )  {out.print(sql);out.close();}

		if (rs2.next()){
		
		   roomno1=rs2.getString("Room_Code");
		   }else{
		   out.print( "请选择楼栋号");
		   out.close();
		   
		   }
		   rs2.close();
  		
   
        sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR from";
		sql=sql+" roomstateview where seccode='"+strSection+"'";
		sql=sql+FindStr+" and SaleState in (1,2,3,4)";
		
        ResultSet rs=null;
		try{	
		rs=InsertBean.executeQuery(sql);
        }catch(Exception s )  {out.print(sql);out.close();}
		
        if (rs.next()){
           intBeginF=rs.getInt("BeginF");
           intEndF=rs.getInt("EndF");
           intBeginR=rs.getInt("BeginR");
           intEndR=rs.getInt("EndR");
         }
          rs.close();
		 sql="select count(*) nn,room";
		sql=sql+" from";
		sql=sql+" roomstateview where seccode='"+strSection+"'";
		sql=sql+FindStr+" and SaleState in (1,2,3,4) group by room";
		
    
		try{	
		rs=InsertBean.executeQuery(sql);
        }catch(Exception s )  {out.print(sql);out.close();}
		
		int sumnum=0;
        while (rs.next()){
          sumnum++;
         }
          rs.close();
		
%> 
    
 
<table width="110%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

    <tr >
		<td width="5%" align="center"  >  单元  </td>
		<%
		String upp="ABCDEFGHIJKOPQRST";
		upp=upp.trim();
		String RoomNoUp=roomno1;
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);

		//int nn=0;
		for(int j=intBeginR;j<=intEndR;j++){
		 String NO="";
			     NO=AsiicZH(j,BeR);//调用asiic转换方法
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
        
			 if (upp.indexOf(LockRoomS)>=0){
			  
				 
			 if (LockRoomS.indexOf(NO)<0){
			%>
		     <td align="center" class=listtitle colspan="3"><font color="#ffffff"><%=NO%></font></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" class=listtitle colspan="3"><font color="#ffffff"><%=NO%></font></td>
			 <%} %>	
			 <%}else{%>
			 <td align="center" class=listtitle   colspan="3"><font color="#ffffff"><%=NO%></font></td>
			 
			 <%}
			 
			 }%> 
	
	</tr>
	<tr ><td align="center" width="5%"  >  朝向 </td>
	　<%
	    String Scene[]=new String[intEndR];
		String RoomType[]=new String[intEndR];
		String Area[]=new String[intEndR];
		String sumprice[]=new String[intEndR];
		String unitprice[]=new String[intEndR];
		//String sumprice[]=new String[intEndR];
	 int jj=0;
		for(int j=0;j<sumnum;j++){%>
		
		<%
                sql="select Direction,Scene,Room_Type from roomstateview where seccode=";
				sql=sql+"'"+strSection+"' and building='";
                sql=sql+strBuilding+"'";
				  sql=sql+" and room="+j;
				sql=sql+"  and SaleState in (1,2,3,4)"+FindStr;
		        ResultSet rsR1=InsertBean1.executeQuery(sql);

		
		        if (rsR1.next()){
		          out.print("<td align='center' colspan='3' >&nbsp;"+getbyte(rsR1.getString("Direction"))+"&nbsp;</td>"); 
			      Scene[jj]=getbyte(rsR1.getString("Scene"));
				  RoomType[jj]=getbyte(rsR1.getString("Room_Type"));
				 
				  jj++;
			   } else{  out.print("<td align='center'  colspan='3'>&nbsp;&nbsp;</td>"); }
	
		%>
		
		<%}%>
	
	</tr>
	<tr>
		<td width="5%" align="center"  >  景观 </td>
		<%
		for(int j=0;j<sumnum;j++){%>
		<td align="center" colspan="3" >
		<%if (Scene[j]==null){ out.print("");}else{out.print(Scene[j]);}%>&nbsp;
		</td>
		
		<%}%>
	</tr>
	<tr>
		<td width="5%" align="center"  >  户型  </td>
		<%
		for(int j=0;j<sumnum;j++){
		 %>
		<td align="center" colspan="3">
		<%if (RoomType[j]==null){ out.print("");}else{out.print(RoomType[j]);}%>&nbsp;
		</td>
		<%}%>
	</tr>
	<tr width="20%" >
	  <td align="center" width="5%"  > 楼层</td>
	  <%for(int j=0;j<sumnum;j++){%>
	    <td align="center"   > 建筑<br>面积</td>
        <td align="center"   >单价</td>
        <td align="center"   >总价(万)</td>
	 <%} %>
	</tr>
	<%
	float [] unitprice1Arry=new float[1000];
	int   [] sumprice1Arr=new int[1000];
	float [] areaArr=new float[1000];
	String []stateArr=new String[1000];
	String []typeArr=new String[1000];
	String []FloorArr=new String[1000];
	String  sqlArr="select   Room_code,Area,Floor,Sumprice,Unitprice,SaleState,type from room where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"' and loft='";
		   sqlArr=sqlArr+Loft+"'";
		   sqlArr=sqlArr+"  and SaleState in (1,2,3,4,6)    order by  Floor";

		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		   int aryi=0;
		   while (rsArr.next()){
		    areaArr[aryi]=rsArr.getFloat("Area");
			FloorArr[aryi]=rsArr.getString("Floor");
			sumprice1Arr[aryi]=rsArr.getInt("Sumprice");
			unitprice1Arry[aryi]=rsArr.getFloat("Unitprice");
			stateArr[aryi]=rsArr.getString("SaleState");
			typeArr[aryi]=rsArr.getString("type");
		    aryi+=1;
		   } 
	      rsArr.close();
		int arrlen=0;
		
	 %>
	<%for(int i=intBeginF;i<=intEndF;i++){%>
	<tr width="20%" >
     <td align="center" width="5%"  > <%=i%> </td>
	 <%for(int j=0;j<sumnum;j++){
		float Area1=0;
		int sumprice1=0;
		float unitprice1=0;
		//String state="";
		if (areaArr[arrlen]>0){
		
		  Area1=areaArr[arrlen];
		  sumprice1=sumprice1Arr[arrlen];
		  unitprice1=unitprice1Arry[arrlen];
		  state=stateArr[arrlen];
		  type=typeArr[arrlen];
		 try{
		  if (Integer.parseInt(FloorArr[arrlen])>i){ break;}
		  }catch(Exception s){out.print("error");}
		  
		 }//else if (stateArr[arrlen]!=null){ state=stateArr[arrlen];}
		arrlen+=1;
		%>
	 <%String bgcolor="";
	   if (state.equals("1"))bgcolor=ws1;
	   else  if (state.equals("2"))bgcolor=rg1;
	   else  if (state.equals("3"))bgcolor=qy1;
	   else  if (state.equals("4"))bgcolor=yl1;	   	   
	   %>
	    <td align="center"  bgcolor="<%=bgcolor %>" > <%=df.format(Area1) %></td>
        <td align="center"  bgcolor="<%=bgcolor %>" ><%=df.format(unitprice1) %></td>
        <td align="center"  bgcolor="<%=bgcolor %>"  ><%=sumprice1/10000 %></td>
	 <%//}else{ %> 
	 <%//}
	
 }%>
	</tr>
	<%}%>
  </table>
  </div>
  
</form>  

</body>
</html>
