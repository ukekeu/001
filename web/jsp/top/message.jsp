
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*,java.util.Date" %> 
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "Bean2" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id="relatime" scope="page" class="relaDateInfo.relaDateInfo"/>
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>个人办公-->邮件信息</title>
 <LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="javascript">
function op(e)
{
	window.open(''+e,null,'width=433,height=460,toolbar=no,scrollbars=no');
}
 
</script>
</head> 
<script language="javascript" src="../public_js/public.js"></script>
    <script language="javascript" src="icq/js/myxwindow.js"></script>
 <script>
 function MM_Open(url)
{ //v2.0
	wicq=openIT(url,115,301,null,null,'mywin',1,true,true,false);
}
function openIT(u,W,H,X,Y,n,b,x,m,r) 
{
	var cU  ='icq/img/close_up.gif'; 
	var cO  ='icq/img/close_ovr.gif';
	var cL  ='icq/img/clock.gif';
	var mU  ='icq/img/min_up.gif';
	var mO  ='icq/img/min_ovr.gif';
	var xU  ='icq/img/max_up.gif' ;
	var xO  ='icq/img/max_ovr.gif' ;
	var rU  ='icq/img/res_up.gif' ;
	var rO  ='icq/img/res_ovr.gif' ;
	var tH  ='<img src="icq/img/title1.gif" width="117" height="20" border="0">' ;
	//tH='<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td background="../images/wicq/l2.gif" align="center" valign="bottom"><font color="#000000">小秘书</font></td></tr></table>'
	var tW  ='及时通讯' ;
	var wB  ='#7BBA63' ;
	var wBs ='#7BBA63' ;
	var wBG ='#008040' ;
	var wBGs='#008040' ;
	var wNS ='toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0' //Netscape专用Html变量
	var fSO ='scrolling=no noresize' //主框架专用Html变量
	var brd =b; 
	var max =false; 
	var min =false; 
	var res =false; 
	var tsz =19; 
	return chromeless(u,n,W,H,X,Y,cU,cO,cL,mU,mO,xU,xO,rU,rO,tH,tW,wB,wBs,wBG,wBGs,wNS,fSO,brd,max,min,res,tsz);
}
//
//-->
// 
</script>


 

<body topmargin="0" leftmargin="0" oncontextmenu="return false" >

    <form name=manfrm>
    
     
             
				  <table border="0" width="100%">
				  <tr><td colspan="3"><a href="#" onClick="window.open('../edit/sendmessage.jsp','','menubar=no,scrollbars=yes,resizable=yes,width=770,height=542,left=200,top=100');">我要发邮件</a></td></tr>
                  <tr  bgcolor="#d6d3ce" align="center"><td>主题</td><td>发件人</td><td>发出时间</td></tr>
	   
	 
	 <%String sql="Select  top 5  a.subject,a.id,a.shmail,a.date,a.fuserid ,a.annex,a.filename,b.leave from imail_message as a,oa_mail_state as b where b.state<>0 and b.leave<2  and b.name='"+(String)session.getAttribute("loginid")+"' and a.id=b.main_id order by b.leave,a.date desc";
	 ResultSet rs=Bean.executeQuery(sql);
	 	try{
	  while (rs.next()){ %>
	
	 <tr align="center" bgcolor="#F3F3F3"> 
                        
                        <td width="300" align="left" height="25"><%if (rs.getInt("shmail")==1){%>
							<div align="center" title="本邮件已经被发件人澈回！"><font color="#999999">本邮件已被发件人撤回</font></div>
						<%}else{%>
						<a href="#" onClick="window.open('../../imail/rev.jsp?id=<%=rs.getInt("id")%>','','menubar=no,scrollbars=yes,resizable=yes,width=690,height=542,left=200,top=100');" title="邮件主题:<%=rs.getString("subject")%>">
						<%if (rs.getInt("leave")==0){%><font color="#FF0000"><%=rs.getString("subject")%></font>
						<%} else{ %>
						<%=rs.getString("subject")%></a>
						<%}} %>
						 
						<%
						String filename=rs.getString("filename");
						if (!filename.equals("")){ 
						   if (filename.indexOf(".gif")>=0||filename.indexOf(".txt")>=0) { 
			 %>
			     <a href="../../imail/<%=filename %>"  target="_blank" ><img src="../images/i_sign.gif" border=0></a>
	
			 <%
			 }else{
						  %> 
						<a href="#" onclick="openwin('../../imail/downFile.jsp?fileurel=imail/<%=rs.getString("filename") %>',10,10,10,10);"><img src="../images/i_sign.gif" border=0></a>
						
						<%} 
						
						}%>
						
						
						</td>  <td width="100" bgcolor="#F3F3F3"> 
                        <%
						   ResultSet rs1=Bean1.executeQuery( "Select name from CortrolMan where serialno='"+rs.getString("fuserid")+"'");
						 
						if (rs1.next()){ %>
                      <div align="center"><%if (rs.getInt("leave")==0){%>
                                <font color="#FF0000"><%=rs1.getString("name")%></font>
                                <% }else{ %><%=rs1.getString("name")%>
                                <%  } %></div>
                        <%}
						rs1.close();
						%></td>
                        <td width="180"><%if (rs.getInt("leave")==0 ){%>
                                <font color="#FF0000"><%=rs.getString("date")%></font>
                                <% }else{ %><%=rs.getString("date").substring(0,16)%>
								<%} %>
                              </td>
                      </tr>
	 <% }rs.close();
	 }catch(Exception s){}
	 String ggSQL="";
	 %>
       <tr><TD colspan="3" align="right"> <a href="#" onClick="window.open('../../imail/mail_list.jsp','','menubar=no,scrollbars=yes,resizable=yes,width=690,height=542,left=200,top=100');"  >更多</a></TD></tr>
    
      <tr>
        <td  valign="top"  colspan="3  align="center">		 
	      
			     <table  border="0" width="100%" cellspacing="0"  border="0"  align="center">
				   <tr bgcolor="#d6d3ce"> 
			  <%  Date currDate1=new Date();
				  int year1=currDate1.getYear()+1900;
				  int yy=0;
				  int month=currDate1.getMonth()+1;
				  int mm=0;
				  int day=currDate1.getDate();
				  int crD=1;
                  String tdate= String.valueOf(currDate1.getMonth())+"/"+String.valueOf(currDate1.getDate())+"/"+String.valueOf(currDate1.getYear()+1900);
				  String strYear=request.getParameter("yy");
				  String strMonth=request.getParameter("mm");
				  if (strYear==null||strYear.length()<=0){
						yy=year1;
						mm=month;
				  }else{
						yy=java.lang.Integer.parseInt(strYear);
						mm=java.lang.Integer.parseInt(strMonth);
     			  }
				  Date	mowDate=new Date(yy-1900,mm-1,1);%>
                <td   height="25" width="90%"> 
			        <select name="yy" onChange="document.manfrm.submit();" class="input4">
			          <%for (int i=year1-5;i<=year1+20;i++){%> 
			          <option <%if (i==yy){%> selected<%}%>><%=i%></option>
			          <%}%> 
			        </select>年&nbsp;&nbsp;&nbsp;
			     
			          <select name="mm" onChange="document.manfrm.submit();" class="input4">
			            <%for (int i=1;i<=12;i++){%> 
			            <option <%if (i==mm){%> selected<%}%>><%=i%></option>
			            <%}%> 
			          </select>月
			       &nbsp;&nbsp;  </td>
				  <td> <a href="#" onclick="window.open('../manager/mplan.jsp','','menubar=no,scrollbars=yes,resizable=yes,width=600,height=250,left=200,top=100');">添加计划</a>
                   </td>
				 </tr> 
			   </table>
			   </td> 
			  </tr>
              <tr>
                <td valign="top" colspan="3" width="100%" align="center">
				<table width="100%"  border="0">
				 <tr bgcolor="#d6d3ce"> 
		            <td height="15"> 
		              <div align="center"><font color="#FF0000">日</font></div>
		            </td>
		            <td height="15"> 
		              <div align="center">一</div>
		            </td>
		            <td height="15"> 
		              <div align="center">二</div>
		            </td>
		            <td height="15"> 
		              <div align="center">三</div>
		            </td>
		            <td height="15"> 
		              <div align="center">四</div>
		            </td>
		            <td height="15"> 
		              <div align="center">五</div>
		            </td>
		            <td height="15"> 
		              <div align="center"><font color="#FF0000">六</font></div>
		            </td>
                
				 </tr>
		  <%
		    List list1=new LinkedList();//存放房间编码
	        List list2=new LinkedList();//存放房间状态
			ggSQL="select context,name,code,month(getdate()) curm,day(sdate) as nn,day(edate) as nnn ,month(edate) as nnnn,month(sdate) as nnnnn from dayplan where ((year(sdate)="+yy+" and month(sdate)>="+mm+") or (year(edate)="+yy+" and month(edate)>="+mm+")) and userid='"+(String)session.getAttribute("loginid")+"' order by sdate ";
	        rs=Bean.executeQuery(ggSQL);
		    while (rs.next()){
			  int nn=rs.getInt("nn");
			  int nnn=rs.getInt("nnn");
			  for(int aaa=nn;aaa<=nnn;aaa++)
			  {
			     list1.add(String.valueOf(yy)+"-"+String.valueOf(mm)+"-"+String.valueOf(aaa));
			     list2.add(rs.getString("context"));
			   }
			 }
			 rs.close();
		    String txt="";
        %>
				 
      <%while (mowDate.getMonth()+1==mm){%> 
      <tr><%for (int i=1;i<=7;i++){
	       String ym=String.valueOf(mm);
		   String yd=String.valueOf(mowDate.getDate());
		   if (ym.length()==1){ym="0"+ym;}
		   if (yd.length()==1){yd="0"+yd;}
		   %>  
         <td <%if (list1.contains(String.valueOf(yy)+"-"+String.valueOf(mm)+"-"+String.valueOf(mowDate.getDate()))&&(mowDate.getMonth()+1==mm)&&(mowDate.getDay()+1==i)){  int index=list1.indexOf(String.valueOf(yy)+"-"+String.valueOf(mm)+"-"+String.valueOf(mowDate.getDate()));
		   txt=(String)list2.get(index);  out.print( "background='../images/color.gif'");%> title=""  onclick="window.open('../manager/showplan.jsp?id=<%=String.valueOf(yy)+"-"+String.valueOf(mm)+"-"+String.valueOf(mowDate.getDate())%>',null,'width=600,height=400,left=200,top=100,toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes');"  <%} %> height="20"<%if ((mowDate.getMonth()+1==mm)&&(mowDate.getDay()+1==i)){%> style="cursor:hand" onMouseOver="style.backgroundColor='#99ccff';style.color='#F3F3F3'" onMouseOut="style.backgroundColor='#F3F3F3';style.color='#000000'"    <%}%> bgcolor="#F3F3F3"> 
           <div align="center">
			 <%if ((mowDate.getMonth()+1==mm)&&(mowDate.getDay()+1==i)){%>
			    <b>
			     <%if (mowDate.getDate()+1==currDate1.getDate()+1){%>
			       <font color=red title="" >
			       <%=mowDate.getDate()%></font><%}
			     else{%><font  title="">
			       <%=mowDate.getDate()%></font>
			     <%}%></b>
			   <%}%>
			  </div>
            </td>
            <%
		if (mowDate.getDay()+1==i){
		    crD=crD+1;
			String dd=relatime.relaDay(86400*1000,crD,yy-1900,mm-1);
		    mowDate=new Date(Integer.parseInt(dd.substring(0,4))-1900,Integer.parseInt(dd.substring(5,7))-1,Integer.parseInt(dd.substring(8,10))-1);
	     }
      }

    %> 
     </tr>
      <%}%> 
	 
        </table> 
     
    <script>
	  function OpenWindowsface(strURL)
{
	var newwin;
	retval = window.showModalDialog(strURL,"_blank","dialogWidth500px; dialogHeight:480px; dialogLeft:200px; dialogTop:160px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	
	 return false;
 
}

	  </script>

 
</form>
　</body></html>