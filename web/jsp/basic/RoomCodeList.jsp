<%@ page contentType="text/html;charset=GBK" %>
<html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<head>
	<title>新增房间编号</title>
</head>

<body>
<%@ page language="java" import="java.sql.*,java.lang.*,common.*,java.util.*"%>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/asiic.jsp"%> 
<%
String strjgh=China.getParameter(request,"dyjgh");
 
String strSecName=China.getParameter(request,"SecName");
String LockRoomS=China.getParameter(request,"Lock");
String strSection=China.getParameter(request,"Section");
String Rinfo=China.getParameter(request,"Rinfo");
String Ecellname=China.getParameter(request,"Ecellname");
String Scellname=China.getParameter(request,"Scellname");
String cellname="";
String cw=China.getParameter(request,"cw");
String cd=China.getParameter(request,"cd");
String floorlen=China.getParameter(request,"floorlen");
String strBuilding=China.getParameter(request,"Building");
String strRegion=China.getParameter(request,"Region");	
String yes=China.getParameter(request,"yes");	
String Finfo=China.getParameter(request,"Finfo");	//楼层附加字
String showfloors=China.getParameter(request,"showfloors");	
String floorshowtype=China.getParameter(request,"floorshowtype");	
String bmfs=China.getParameter(request,"bmfs");	
String cellqz=China.getParameter(request,"cellqz");	
List Lock=new LinkedList();//存放禁用号
StringTokenizer st22;
  st22 = new StringTokenizer(LockRoomS,",") ;
 int count24 = st22.countTokens() ;
  while (st22.hasMoreElements()) {
	Lock.add((String)st22.nextElement());
  

 }
				

int intBeginF=0;//java.lang.Integer.parseInt(request.getParameter("BeginF"));
int intEndF=0;//java.lang.Integer.parseInt(request.getParameter("EndF"));
int intEndR;
int intBeginR;

String BeginF=request.getParameter("BeginF");
String EndF=request.getParameter("EndF");

char BeF=BeginF.charAt(0);
char EnF=EndF.charAt(0);
//如果楼层是用字母编号，而转换成数字
 
//if(java.lang.Character.isDigit(BeF)){
if (Upp.indexOf(BeginF)<0){
	 intBeginF=java.lang.Integer.parseInt(BeginF);
	 intEndF=java.lang.Integer.parseInt(EndF);
}
else{
	 intBeginF=Character.getNumericValue(BeF)-9;
	 intEndF=Character.getNumericValue(EnF)-9;
}

String BeginR=request.getParameter("BeginR");

char BeR=BeginR.charAt(0);
int scell=0,ecell=0;
char  CellN1=Scellname.charAt(0);
char  CellN2=Ecellname.charAt(0);

if (!Scellname.equals("")&&!Ecellname.equals("")){
   CellN1=Scellname.charAt(0);
   CellN2=Ecellname.charAt(0);

if(java.lang.Character.isDigit(CellN1)){
	 scell=java.lang.Integer.parseInt(request.getParameter("Scellname"));
	 ecell=java.lang.Integer.parseInt(request.getParameter("Ecellname"));
}
else{
     scell=Character.getNumericValue(CellN1)-9;
	 ecell=Character.getNumericValue(CellN2)-9;
}
 
}
if(java.lang.Character.isDigit(BeR)){
	 intBeginR=java.lang.Integer.parseInt(request.getParameter("BeginR"));
}
else{
	 intBeginR=Character.getNumericValue(BeR)-9;
}
String EndR=request.getParameter("EndR");
char EdR=EndR.charAt(0);
if(java.lang.Character.isDigit(EdR)){
	 intEndR=java.lang.Integer.parseInt(request.getParameter("EndR"));
}
else{
	 intEndR=Character.getNumericValue(EdR)-9;

}

 String room_type ="";
 int colts=20;
	 String ss="select type,ts from CRM_Project where serialno='"+strSection+"'";
   ResultSet ssr=InsertBean.executeQuery(ss);
   if (ssr.next()){
    room_type=ssr.getString("type");
	colts=ssr.getInt("ts");
   }
   ssr.close();
%> 
<div align="center">
  <p><font color="#0000CC"><b><font size="3" color="#000000"><%=strSecName %> <%=strRegion %>房间号码表</font></b></font></p>
<form method="POST" name="cus" action="RoomCodeInsert.jsp">
  <input type="hidden" name="Section" value="<%=strSection%>">
  <input type="hidden" name="SecName" value="<%=strSecName %>">
  <input type="hidden" name="Building" value="<%=strBuilding%>">
  <input type="hidden" name="Region" value="<%=strRegion%>">
  <input type="hidden" name="BeginF" value="<%=BeginF%>">
  <input type="hidden" name="EndF" value="<%=EndF%>">
  <input type="hidden" name="BeginR" value="<%=intBeginR%>">
  <input type="hidden" name="EndR" value="<%=intEndR%>">
  <input type="hidden" name="Lock" value="<%=LockRoomS%>">
  <input type="hidden" name="R_type" value="<%=BeginR %>">
  <input type="hidden" name="Finfo" value="<%=Finfo %>">
  <input type="hidden" name="Rinfo" value="<%=Rinfo %>">
  <input type="hidden" name="Ecellname" value="<%=Ecellname %>">
  <input type="hidden" name="dyjgh" value="<%=strjgh %>">
  <input type="hidden" name="bmfs" value="<%=bmfs %>">
  <input type="hidden" name="cellqz" value="<%=cellqz %>">
  
  <input type="hidden" name="Scellname" value="<%=Scellname %>">
  <table width="75%" border="0">
    <tr>
     
	 <td >禁用房号：<%=LockRoomS %></td></tr>
	</table>
<% 
//String cellname="";
//out.print(java.lang.Character.isDigit(CellN1));out.close();
for(int j2=scell;j2<=ecell;j2++){%> 

<p align="center"><%if (scell>0){ %><%Rinfo=AsiicZH(j2,CellN1);out.print(Rinfo); %>单元<%} %></p> 
  <table width="85%" border="0" CELLSPACING=1 CELLPADDING=3>
   <%  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0&&intEndR<=colts){%>
    <tr>
		<td width="80" height="25" align="center" bgcolor="#999999"><font color="#ffffff"><b>楼层\房间</b></font></td>
<%

for(int j=intBeginR;j<=intEndR;j++){
       
    
            String NO="";
			NO=AsiicZH(j,BeR);//调用asiic转换方法
		    if (!Lock.contains(String.valueOf(NO))){
			  %>
			  		
        <td align="center" bgcolor="#999999"><font color="#ffffff"><%=NO%></font></td>
		 <%} 
		}%>
	</tr>
	<%}
	 int hs=0;
	 out.print("<tr>");
	 if (!Rinfo.equals(""))Rinfo=Rinfo+strjgh;
 
	for(int i=intBeginF;i<=intEndF;i++){
	hs=0;
	// if (i==0) continue;
	String ro="";
	String floorslenvalue="";
	if (floorlen.equals("1"))if (i<10)floorslenvalue="0";
	 
	String FNO="";
	FNO=AsiicF(i,BeginF);//调用asiic转换方法
 	 
	if (hs==0)out.print("<tr>");
	
	  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){%>
	 
		<td align="center" class=FloorC><font color="#ffffff"><%if (Finfo.equals(""))out.print(AsiicFloorType(FNO,floorshowtype)); else if (!Finfo.equals("")&&!showfloors.equals(""))  out.print(FNO+Finfo);else if (!Finfo.equals("")&&showfloors.equals(""))  out.print(Finfo);%> </font></td>
		<%
		}
		for(int j=intBeginR;j<=intEndR;j++){
		   if (hs==colts){hs=0;out.print("</tr><tr>"); }
	    
		  if (yes.equals(""))ro=String.valueOf(i);
          else  if (i>0&&!yes.equals(""))ro=String.valueOf(java.lang.Math.abs(i)-1);
          else  if (i<0&&!yes.equals(""))ro=String.valueOf(i);
		   if (!cw.equals("")){
		       ro="";
		       for (int bhcd=String.valueOf(j).length();bhcd<java.lang.Integer.parseInt(cd);bhcd++) 
			   ro=ro+"";
		   }		 
			if(java.lang.Character.isDigit(EdR)){
			  String  RoomNo="";
              if (Upp.indexOf(BeginF)<0){ 
			     if (cw.equals("")){
					 if (j>=10)
			           RoomNo=cellqz+Rinfo+floorslenvalue+String.valueOf(ro)+bmfs+String.valueOf(j);
			         else
			          RoomNo=cellqz+Rinfo+floorslenvalue+String.valueOf(ro)+bmfs+String.valueOf(j);
					  }
				 }			
				
				 if (!cw.equals("")){ 
				  RoomNo=cellqz+Rinfo+floorslenvalue+String.valueOf(ro)+String.valueOf(j);
				 }
			    String ii=String.valueOf(ro);
			  String RNf=RoomNo;
			    String aaaa=RNf;
			  if (RNf.indexOf("-")>=0)
			   aaaa=RNf.substring(0,RNf.indexOf("-"))+RNf.substring(RNf.indexOf("-")+1);
			   
		        if (!Lock.contains(String.valueOf(j))) {
				  hs++;
			%>
		<td align=left class=roomright><input type="text" name="RoomNo<%=aaaa%>"  size="5"   value="<%=RoomNo%>" onblur="checkRoonNo(this);"><%=RoomNo%><input type=checkbox name="Check<%=i%><%=j%>" value="CheckValue<%=RoomNo%>" checked onclick="clearRoomNo(this,'<%=aaaa %>');"></td>
		<%}
		}else{
			  String RoomN="";
			   String aaaa="";
			  String ii=String.valueOf(ro);
              RoomN=Rinfo+String.valueOf(ro)+AsiicZH(j,EdR);//调用asiic转换方?
		      if (!Lock.contains(RoomN.substring(ii.length()))){
			  String RNf=RoomN;
			  aaaa=RNf;
			  if (i<0){
				  RNf=RoomN.substring(2);
				// RoomN="地下"+(-i)+"层"+RoomN.substring(2);
				 }
				  if (RNf.indexOf("-")>=0)
			   aaaa=RNf.substring(0,RNf.indexOf("-"))+RNf.substring(RNf.indexOf("-")+1);
			  %>
		<td align=left class=roomright>  <input type="text" name="RoomNo<%=aaaa%>" size="5"   value="<%=RoomN%>"  onblur="checkRoonNo(this);"><%=RoomN%><input type=checkbox name="Check<%=i%><%=j%>" value="CheckValue<%=RoomN%>" checked onclick="clearRoomNo(this,'<%=aaaa %>');"></td>
			  <%
		  }
		  }
		}%>
	</tr>
	<%}%>
  </table>
  <%}//结束单元 %>
   <%InsertBean.closeConn();
 
  %>
 <input type=hidden name=yes value="<%=yes%>">
  <input type=hidden name=cw value="<%=cw%>">
    <input type=hidden name=cd value="<%=cd%>">
	 <input type=hidden name=floorlen value="<%=floorlen%>">
	
  <input type=hidden name=floorshowtype value="<%=floorshowtype%>">
  <p align="center"> 
            &nbsp;&nbsp;  <input type="SUBMIT" name="Submit" value="提 交">
           &nbsp;&nbsp;
		     <input type="BUTTON" name="Submit" value="返 回" onclick="window.history.back(1);">

          </P>
  <script>
  function checkRoonNo(para){
    if (para.value.indexOf("&")>=0||para.value.indexOf("#")>=0)
	{
	alert("在编码中不能包括英文状态下的&或#，但可以用中文输入法中的＃");
	para.focus();
	}
  
  }
  function clearRoomNo(th,pp){
    var CheckboxName=th.value;
	var str="CheckValue";
	var RoomN=CheckboxName.substring(parseInt(str.length));
	 
 	var room=eval("document.cus.RoomNo"+pp);
	// alert("document.cus.RoomNo"+RoomN+"R");
  	if (th.checked)
	   room.value=RoomN;
	else//如果用户取消此房号
      room.value="";
	  
return false;
  }

  </script>
</form>  
</div>
</body>
</html>
