
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
<title>U客营销管理系统-->协同办公</title>
<LINK href="yellow.css" rel=stylesheet type=text/css>
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

  <table width="100%"  border="0"  cellspacing cellpadding>
    <tr> 
        
      
      <td width="2%" bgcolor="#FFFFFF">　</td>
      <td width="61%" bgcolor="#FFFFFF" valign="top"> 
        <table width="100%" cellspacing cellpadding>
          <tr>
            <td width="100%" height="10"></td>
          </tr>
         
          <tr> 
            <td width="100%"> 
              <table width="100%" cellspacing cellpadding> 
                <tr> 
                  <td width="100%" height="19">
                    <table width="100%" cellspacing cellpadding height="19">
                     <tr> 
                        <td width="20%" background="../images/head_dd1.gif" background-repeat: no-repeat; background-position: left top"> 
                          &nbsp;&nbsp;<img src="../images/mail1.gif" width="18" height="15" vspace="2" align="absmiddle">&nbsp;我的邮件</td>
                        <td width="79%"> 
						
                          <table width="100%" height="15" cellspacing cellpadding>
                            <tr> 
                              <td width="100%" height="15" valign="top" background="../images/head_dd1.gif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onClick="window.open('../edit/sendmessage.jsp','','menubar=no,scrollbars=yes,resizable=yes,width=770,height=542,left=200,top=100');">我要发邮件</a></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td> 
                </tr> 
                <tr> 
                  <td width="100%" height="5"></td> 
                </tr> 
                  
                <tr bgcolor="#ECF2F2" valign="top"> 
                  <td width="100%" height="90"> 
				  <table border="0" width="100%">
     <%String sql="Select  top 5  a.subject,a.id,a.shmail,a.date,a.fuserid ,a.annex,a.filename,b.leave from imail_message as a,oa_mail_state as b where b.state<>0 and b.leave<2  and b.name='"+(String)session.getAttribute("loginid")+"' and a.id=b.main_id order by b.leave,a.date desc";
	 ResultSet rs=Bean.executeQuery(sql);
	 	try{
	  while (rs.next()){ %>
	
	 <tr align="center"> 
                        
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
						
						
						</td>  <td width="100"> 
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
      </table>
    </td> 
        </tr> 
              </table> 
            </td> 
          </tr> <!---->
         
                <tr> 
                  <td width="100%" height="5" background="../images/head_dd1.gif">　</td>
                </tr>
				<tr><td><table  width="214"  align="left" border="0">
				 <%    ResultSet typeRS=null;
	 int newnum=0;
		     ggSQL="select    type from knowledge_type   where typestate=1  ";
		   typeRS=Bean2.executeQuery(ggSQL);
		   while (typeRS.next()){ 
		   newnum++;
		   if (newnum==1)out.print("<tr>");
		   String newtype=typeRS.getString("type");
		   %>
   		
    <td  valign="top" width="214"  height="100"  background="../images/r_bg.gif">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td  valign="middle" background="../images/r_top2.gif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><%=newtype %></b></td>
      </tr>
      <tr>
        <td height="50" valign="top">
			<table width="100%" background="../images/r_bg.gif"  border="0"  height="50" align="center" cellpadding="0" cellspacing="0">
	          <tr>
	            <td height="50" valign="top" align="center"> 
			 		<table width="200" border="0" class="L2" cellspacing="0" cellpadding="0" >
					    <%
	 ggSQL= "Select top 6 * from news where enddate>=getdate() and type='"+newtype+"' order by newsdate desc";
	 rs=Bean.executeQuery(ggSQL);
	 int iii=0;
	 while (rs.next()){
	  String  id=rs.getString("id");
	  String  newstitle=rs.getString("newstitle");
	  iii++;
		 %>		  
		 <tr>
            <td  valign="top" ><a href="#" onclick="window.open('../../imail/seenews.jsp?id=<%=id%>',null,'width=600,height=560,left=200,top=100,toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes');" title="<%=newstitle%>">&nbsp;<%if (newstitle.trim().length()>11){out.print(newstitle.trim().substring(0,11)+"...");} else{ out.print(newstitle.trim());} %>【<%=rs.getString("reads") %>】</A></a></td>
          </tr>
		   <%	 
	 }rs.close(); 
	for (int aa=iii;aa<=5;aa++){
	out.print("<tr><td>&nbsp;</td></tr>");
	}
		    %>   
		             </table>
				  </td>
	          </tr>
	        </table>
		</td>
      </tr>
      <tr>
        <td valign="top"><img src="../images/r_down.gif" width="214" height="13"></td>
      </tr>
	  
	 
	 
	 </TD></TR></TABLE>
	
		
		</td>
		 <%
     if (newnum==3){out.print("</tr>");newnum=0;}
  
   }typeRS.close(); %>
		
		 
		</table></td></tr> 
		 
		 
        <tr> 
            <td width="100%"> 
                <table width="100%" cellspacing cellpadding>
                  <tr> 
                    <td width="100%" height="10" valign="bottom"></td>
                  </tr>
                 <tr> 
                    <td width="100%" height="22"><table width="100%" cellspacing cellpadding height="19"> 
                      <tr> 
                        <td width="25%" ><table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="280" height="10"    background="../images/head_dd1.gif">　<img src="../images/91.gif" width="15" height="30" vspace="2" align="absmiddle">&nbsp;&nbsp;热门话题&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="#"  onClick="window.open('../edit/qu.jsp','','menubar=no,scrollbars=yes,resizable=yes,width=770,height=542,left=200,top=100');">我要发言</a></td>
          <td align="right" valign="top"  height="10" background="../images/head_dd1.gif">　</td>
</tr>
</table></td> 
                        <td width="79%"  valign="top"> 
                          <table width="100%" height="15" cellspacing cellpadding>
                            <tr> 
                              <td width="100%" height="30"  valign="top" background="../images/head_dd1.gif" >　</td> 
                            </tr> 
                          </table> 
                        </td> 
                      </tr> 
                    </table></td>
                  </tr>
                  <tr> 
                    <td width="100%" height="5"></td>
                  </tr>
                
                 <%sql="select top 10 id,subject,face,writerid,forumid,date,redate,redu from community_forum where parent=0";
		         sql+=" union select id,subject,face,writerid,forumid,date,redate,redu from community_forum where parent=0";
		         sql+="order by redate desc"; 
			 
				 rs=Bean.executeQuery(sql);
	 
					try{
					  while (rs.next()){
					  String   face=rs.getString("face");
					  String   subject=rs.getString("subject");
					  String   redate=getbyte(rs.getString("redate"));
					  if (!redate.equals(""))redate=redate.substring(0,redate.indexOf("."));
					  String   date=rs.getString("date");
					   String   writerid=rs.getString("writerid");
					   String redu=rs.getString("redu");
					   %>
                  <tr bgcolor="#ECF2F2"> 
                    <td colspan="2"> <img src="../../bbs/images/face<%=face%>.gif"><a href="#" <a href="#" onClick="window.open('see.jsp?forumid=1&id=<%=rs.getString("id")%>','','left=40,top=20,height=490,width=680,resizable=yes,scrollbars=yes');return false;" title="贴子主题:<%=rs.getString("subject")%>">
                     <%=rs.getString("subject")%>
					
				     [<%=writerid %>
                      <%if (redate.equals("")){ %>
					  &nbsp;<font color=red>New!</font>
					  <%} %>]
                     <%if (!redate.equals("")){ %>
                   (最新回复: <%=redu %> 时间：<%=redate %>)
				   <%} %>
                  </a></td>
                  </tr>
                  <%}rs.close();
				   }catch(Exception s){} %>
                 
                        <tr><TD colspan="3" align="right"> <a href="#" onClick="window.open('../../imail/bbs_list.jsp','','menubar=no,scrollbars=yes,resizable=yes,width=690,height=542,left=200,top=100');"  >更多</a></TD></tr>
                 
        </table> 
        </td> 
        </tr> 
        </table> 
      </td> 
      <td width="2%" bgcolor="#FFFFFF"></td>
      <td width="16%" bgcolor="#FFFFFF" valign="top"> 
        <div align="center">
          <center>
          <table width="100%" cellspacing cellpadding border="0">
            <tr>
              <td width="100%" height="10"></td>
            </tr>
            <tr>
              <td width="100%" align="right" valign="top">
                    
<table width="214" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="200" valign="top" background="../images/r_bg.gif">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top"><img src="../images/r_top1.gif" width="214" height="26"></td>
      </tr>
      <tr>
        <td height="50" valign="top">
		<table width="90%"  border="0"  height="50" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100" valign="top"> 
			 <MARQUEE id="PLACARD" direction="up" width="100%" Height="50" scrollDelay="50" trueSpeed="true" scrollAmount="1" onmouseover="scrollAmount=0" onmouseout="scrollAmount=1"> 
		<table width="187" border="0" class="L2" cellspacing="0" cellpadding="0">
    <%
	ggSQL="Select * from gonggao where state=0 and DateDiff(d,getdate(),tdate)>0   order by date desc";
	 
	rs=Bean.executeQuery(ggSQL);
	 while (rs.next()){
		 
%>                     <tr> 
                        <td height="10%">&nbsp;<img src="../images/i_tubiao_24.gif" width="13" height="13">&nbsp;</td>
                        <td  width="99%" class="unnamed1"> <a href="#" onclick="window.open('../../imail/seeplacard.jsp?id=<%=rs.getString("id")%>','','menubar=no,resizable=yes,scrollbars=yes,width=465,height=450,left=200,top=100');"><%=rs.getString("subject")%></a></td>
                      </tr>
                               
                                <%
		 
	 }rs.close(); %>
                              
	</table></MARQUEE> </td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td valign="top"><img src="../images/r_down.gif" width="214" height="13"></td>
      </tr>
     
	
	     
	<tr> 
	<td bgcolor="#ECF2F2" align="left"  width="11%"  background="../images/head_dd1.gif">  <img src="../images/phone.gif" width="23" height="16" vspace="2" align="absmiddle">&nbsp;今日提醒
	</td>
</tr>
 
	 <%  ggSQL="SELECT   c.name+'-'+b.loft+'-'+b.payment,c.serialno,b.paymenttype   FROM  checkData a,试算价目表 b,crm_project c  where c.serialno=b.sectionno and a.payemnt=b.payment ";
	    ggSQL+="and a.type=1 and a.state=0 and b.checkstate=2 and  a.person='"+(String)session.getAttribute("loginid") +"' group by c.name+'-'+b.loft+'-'+b.payment,c.serialno ,b.paymenttype";
	 rs=Bean.executeQuery(ggSQL);
 
	 try{
	  while (rs.next()){ 
	  String payment=getbyte(rs.getString(1));
	  String loft=payment.substring(payment.indexOf('-')+1,payment.lastIndexOf('-'));
	  int paymenttype=rs.getInt("paymenttype");
	     
		 	 
	  %>
	<tr> 
	<td  align="center"  width="11%">&nbsp;<%=payment.substring(payment.lastIndexOf('-')+1)%> <a href="#" onclick="openwin('../plot/PriceListView.jsp?SecName=<%=payment.substring(1,payment.indexOf('-'))  %>&SecNo=<%=getbyte(rs.getString(2))  %>&Loft=<%=loft  %>&Build=&payment=<%=payment.substring(payment.lastIndexOf('-')+1)   %>');">预览</a>
	<a href="#" onclick="openwin('<%if (paymenttype==0){ %>../plot/print_Price.jsp<%}else{ %>../plot/print_Price_xy.jsp<%} %>?SecNo=<%=getbyte(rs.getString(2)) %>&Loft=<%=loft %>&Build=&payment=<%=payment.substring(payment.lastIndexOf('-')+1)  %>')">启用</a>
		
	</td>
	</tr>
<%
   }rs.close();
   
   ggSQL="select c.sectionname+c.loft+c.room_no room,b.disc_type,b.code,b.order_no from check_data a,contract_disc b,order_contract c  where c.state<>3 and  b.state=0 and  b.disc_type<>'正常折扣' and b.checker='"+(String)session.getAttribute("loginid")+"' and a.id=b.code and b.order_no=c.section+c.loft+c.room_no";
    rs=Bean.executeQuery(ggSQL);
   while (rs.next()){ 
	  String payment=getbyte(rs.getString(1));
	  String disc_type=getbyte(rs.getString(2));
	  String code=getbyte(rs.getString(3));
	  String order_no=getbyte(rs.getString(4)); 	 
	  %>
	<tr> 
	<td  align="center"  width="11%">&nbsp;<%=payment%>&nbsp; <a href="#" onclick="openwin('../sale/CheckDisc.jsp?SecName=<%=order_no %>',600,500,100,100);"><%=disc_type %></a>
	 	
	</td>
	</tr>
   <% }rs.close();
 }catch(Exception s){out.print(s);} %>
	
 
	 
	 
	 




             </table> 
           </td> 
        </tr> 
	 
	 
	  <tr>
        <td valign="top"><img src="../images/head_dd1.gif" width="214" height="13"></td>
      </tr>
	
 <tr>
        <td valign="top" background="../images/dbsy.gif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;我的日程&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="window.open('plan.jsp','','menubar=no,scrollbars=yes,resizable=yes,width=600,height=442,left=200,top=100');">添加</a></td>
      </tr>
      <tr>
        <td  valign="top"   align="center">		 
	 <table      cellpadding="0" cellspacing="0" bgcolor="C4C6C7">
              <tr valign="top"><table  border="0" width="90%"  border="0">
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
                <td  class=lefttd height="25" width="90%"> 
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
       &nbsp;&nbsp;<a href="AddVisitors.asp" ><img src="images/add.gif" width="27" height="9" border="0"></a> 
               </table></td> </tr>
              <tr>
                <td valign="top" width="100%" align="center">
				<table width="90%"  border="0">
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
		   txt=(String)list2.get(index);  out.print( "background='../images/color.gif'");%> title=""  onclick="window.open('showplan.jsp?id=<%=String.valueOf(yy)+"-"+String.valueOf(mm)+"-"+String.valueOf(mowDate.getDate())%>',null,'width=600,height=400,left=200,top=100,toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes');"  <%} %> height="20"<%if ((mowDate.getMonth()+1==mm)&&(mowDate.getDay()+1==i)){%> style="cursor:hand" onMouseOver="style.backgroundColor='#99ccff';style.color='#F3F3F3'" onMouseOut="style.backgroundColor='#F3F3F3';style.color='#000000'"    <%}%> bgcolor="#F3F3F3"> 
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

%> </tr>
          <%
	}

%> 
        </table></td>
      </tr>
     
    <script>
	  function OpenWindowsface(strURL)
{
	var newwin;
	retval = window.showModalDialog(strURL,"_blank","dialogWidth500px; dialogHeight:480px; dialogLeft:200px; dialogTop:160px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	
	 return false;
 
}

	  </script>


  </table>
      </center>
        </div>
      </td>
    </tr>
  </table>
</div>
</form>
　</body></html>