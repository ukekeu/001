<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*,java.util.Date" %> 
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
 
<jsp:useBean id="relatime" scope="page" class="relaDateInfo.relaDateInfo"/>
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title></title>
</head>

<body  topmargin="0" leftmargin="0"   marginheight="100%"  >
<form name=manfrm> 
<table border="1" width="95%" align="center">
  <tr>
    <td width="65%">我的邮件
      <table border="1" width="100%">
        <tr align="center">
          <td width="35%">邮件主题</td>
          <td width="15%">发 件 人</td>
          <td width="25%">发件日期</td>
         
        </tr>
		 <%String sql="Select DISTINCT(a.subject),a.id,a.shmail,a.date,a.fuserid ,a.annex,a.filename,b.leave from imail_message as a,oa_mail_state as b where b.state<>0 and b.leave<2  and b.name='"+(String)session.getAttribute("loginid")+"' and a.id=b.main_id order by b.leave,a.date desc";

	 ResultSet rs=Bean.executeQuery(sql);
	 while (rs.next()){ %>
	  <tr align="center"> 
                        
                        <td width="180" height="25"><%if (rs.getInt("shmail")==1){%>
							<div align="center" title="本邮件已经被发件人澈回！"><font color="#999999">本邮件已被发件人撤回</font></div>
						<%}else{%>
						<a href="#" onClick="window.open('../../imail/rev.jsp?id=<%=rs.getInt("id")%>','','menubar=no,scrollbars=yes,resizable=yes,width=570,height=542,left=200,top=100');" title="邮件主题:<%=rs.getString("subject")%>">
						<%if (rs.getInt("leave")==0){%><font color="#FF0000"><%=rs.getString("subject")%></font>
						<%} else{ %>
						<%=rs.getString("subject")%><% %></a>
						<%}} %>
						</td>
                        <%
						   ResultSet rs1=Bean1.executeQuery( "Select id,name from manage_user where id="+rs.getString("fuserid"));
						 
						if (rs1.next()){ %>
                        <td width="100"> <div align="center"><%if (rs.getInt("leave")==0){%>
                                <font color="#FF0000"><%=rs1.getString("name")%></font>
                                <% }else{ %><%=rs1.getString("name")%>
                                <%  } %></div></td>
                        <%}
						rs1.close();
						%>
                        <td width="180"><%if (rs.getInt("leave")==0 ){%>
                                <font color="#FF0000"><%=rs.getString("date")%></font>
                                <% }else{ %><%=rs.getString("date")%>
								<%} %>
                              </td>
                      </tr>
	 <% }rs.close(); %>
       
      </table>
    </td>
    <td width="30%">
	　通知
	
	<%
	String ggSQL="Select * from gonggao where state=0 and DateDiff(d,getdate(),tdate)>0   order by date desc";
	%> <MARQUEE id="PLACARD" direction="up" width="100%" Height="200" scrollDelay="50" trueSpeed="true" scrollAmount="1" onmouseover="scrollAmount=0" onmouseout="scrollAmount=1"> 
		<table width="99%" border="0" class="L2" cellspacing="0" cellpadding="0">
    <%
	rs=Bean.executeQuery(ggSQL);
	 while (rs.next()){
		 
	%>
                                <tr> 
                                  <td height="10%">&nbsp;<img src="i_tubiao_24.gif" width="13" height="13">&nbsp;</td>
                                  <td  width="99%" class="unnamed1"> <a href="#" onclick="window.open('../../imail/seeplacard.jsp?id=<%=rs.getString("id")%>','','menubar=no,resizable=yes,scrollbars=yes,width=465,height=450,left=200,top=100');"><%=rs.getString("subject")%></a></td>
                                </tr>
                                <br>
                                <%
		 
	 }rs.close(); %>
	 
                      
	</table>
	                       
</MARQUEE>   


<table width="214" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="200" valign="top" background="pic/r_bg.gif">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top"><img src="pic/r_top1.gif" width="214" height="26"></td>
      </tr>
      <tr>
        <td height="101" valign="top">
		<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="101" valign="top">  <MARQUEE id="PLACARD" direction="up" width="100%" Height="100" scrollDelay="50" trueSpeed="true" scrollAmount="1" onmouseover="scrollAmount=0" onmouseout="scrollAmount=1"> 
		<table width="187" class="L2" cellspacing="0" cellpadding="0">
    
                                <tr> 
                                  <td height="41">&nbsp;
								  <img src="images/i_tubiao_24.gif" width="13" height="12">&nbsp;</td>
                                  <td width="460" class="unnamed1" height="41"><a href="#" onclick="window.open('seeplacard.asp?id=223','','resizable=yes,menubar=no,scrollbars=no,width=445,height=450,left=200,top=100');">公司于2005年7月28日举行股东大会(2005-7-6 )【2】</a><br>
								  </td>
                                </tr>
	
                              
	</table>
	                         

</MARQUEE> </td>
          </tr>
        </table>
</td>
	
	</td>
  </tr>
  <tr>
    <td width="65%">
	我的计划
	</td>
    <td width="30%">新闻<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
         <%ggSQL= "Select top 10 * from news where enddate>=getdate() and type=1  order by newsdate desc";
		 rs=Bean.executeQuery(ggSQL);
	 while (rs.next()){
	  String  id=rs.getString("id");
	  String  newstitle=rs.getString("newstitle");
		 %>
		  <tr>
            <td  valign="top"><a href="#" onclick="window.open('../../imail/seenews.jsp?id=<%=id%>',null,'width=600,height=560,left=200,top=100,toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes');" title="<%=newstitle%>">&nbsp;<%if (newstitle.length()>13){out.print(newstitle.substring(1,13));} else{ out.print(newstitle);} %>【<%=rs.getString("reads") %>】</A></a></td>
          </tr>
		   <%	 
	 }rs.close(); 
		    %> 
			
        </table></td>
  </tr>
  <tr>
    <td width="50%"   >
	<IFRAME   src="../../bbs/about.jsp" frameborder="0" scrolling="no" width="650" height="250"></IFRAME>
	  
</td>
<td align="center">我的日程
	 <table  height="100%"  border="1" cellpadding="0" cellspacing="0" bgcolor="C4C6C7">
              <tr valign="top">
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
                <td  class=lefttd height="25"> 
        <select name="yy" onChange="document.manfrm.submit();" class="input4">
          <%for (int i=year1-5;i<=year1+20;i++){%> 
          <option<%if (i==yy){%> selected<%}%>><%=i%></option>
          <%}%> 
        </select>年&nbsp;&nbsp;&nbsp;
     
          <select name="mm" onChange="document.manfrm.submit();" class="input4">
            <%for (int i=1;i<=12;i++){%> 
            <option<%if (i==mm){%> selected<%}%>><%=i%></option>
            <%}%> 
          </select>月
       &nbsp;&nbsp;<a href="AddVisitors.asp" ><img src="images/add.gif" width="27" height="9" border="0"></a></td>
              </tr>
              <tr>
                <td valign="top" width="100%">
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
		  ggSQL="select context,name,code,month(getdate()) curm,day(sdate) as nn,day(edate) as nnn ,month(edate) as nnnn,month(sdate) as nnnnn from dayplan where (year(sdate)="+yy+" and month(sdate)="+mm+") or (year(edate)="+yy+" and month(edate)="+mm+") and userid='"+(String)session.getAttribute("loginid")+"' order by sdate ";
 
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
   %>
				 
    <%while (mowDate.getMonth()+1==mm){%> 
      <tr><%for (int i=1;i<=7;i++){
	       String ym=String.valueOf(mm);
		   String yd=String.valueOf(mowDate.getDate());
		   if (ym.length()==1){ym="0"+ym;}
		   if (yd.length()==1){yd="0"+yd;}
		   %>  
         <td <%if (list1.contains(String.valueOf(yy)+"-"+String.valueOf(mm)+"-"+String.valueOf(mowDate.getDate()))&&(mowDate.getMonth()+1==mm)&&(mowDate.getDay()+1==i)){   out.print( "background='../../images/color.gif'");%> onclick="window.open('../../imail/seeday.jsp?id=<%=String.valueOf(yy)+"-"+String.valueOf(mm)+"-"+String.valueOf(mowDate.getDate())%>',null,'width=600,height=560,left=200,top=100,toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes');"  <%} %> height="20"<%if ((mowDate.getMonth()+1==mm)&&(mowDate.getDay()+1==i)){%> style="cursor:hand" onMouseOver="style.backgroundColor='#99ccff';style.color='#F3F3F3'" onMouseOut="style.backgroundColor='#F3F3F3';style.color='#000000'"    <%}%> bgcolor="#F3F3F3"> 
           <div align="center">
			 <%if ((mowDate.getMonth()+1==mm)&&(mowDate.getDay()+1==i)){%>
			    <b>
			     <%if (mowDate.getDate()+1==currDate1.getDate()+1){%>
			       <font color=red title="点击可查看当日日程" >
			       <%=mowDate.getDate()%></font><%}
			     else{%><font  title="点击可查看当日日程">
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
        </table>
		
	</td>
	</tr>
	</table></td>  
  </tr>
  <tr><td colspan="2">在线人员</td></td></tr>
</table>
 
 
</body>
</html>
 