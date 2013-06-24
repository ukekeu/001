<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<title>　</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<style type="text/css">
<!--
.unnamed1 {  font-size: 9pt}
-->
</style>
<link rel="stylesheet" href="../class/news.css">

</head>
<script language="JavaScript" src='../public_js/basal.js'></script>

<%@ page language="java" import="java.util.Date" %>
<jsp:useBean id="relatime" scope="page" class="relaDateInfo.relaDateInfo"/><!--relaDateInfo-->
<%
  Date currDate1=new Date();

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
   Date	mowDate=new Date(yy-1900,mm-1,1);

%>
<script>
function submitform(){
  document.form2.submit();
  }
function Dat(para){
   if (parent.DaID=="1"){
   parent.document.cus.Date1.value=para;
   }else  if (parent.DaID=="2"){
   parent.document.cus.Date2.value=para;
   }else  if (parent.DaID=="3"){
   parent.document.cus.Date3.value=para;
   }else  if (parent.DaID=="4"){
   parent.document.cus.Date4.value=para;
   }else  if (parent.DaID=="5"){
   parent.document.cus.Date5.value=para;
   }else  if (parent.DaID=="6"){
   parent.document.cus.Date6.value=para;
   }
   
   parent.sh1="false";
 } 
</script>
<body  BGCOLOR="#EBEBEB" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" scroll="no">

<form method="post" action="s_yeardate.jsp" name="form2">
<table width="100%" border="1" cellspacing="1" cellpadding="3" bordercolorlight="#FFFFFF" bordercolordark="#000000" class="L2" bgcolor="#D6D3CE">

 <jsp:include page="table.htm" flush="true"/>
 
    <tr> 
      <td  class=lefttd height="25"> 
        <select name="yy" onChange="submitform();" class="input4">
          <%for (int i=year1-5;i<=year1+20;i++){%> 
          <option<%if (i==yy){%> selected<%}%>><%=i%></option>
          <%}%> 
        </select>年</td>
      <td  class=lefttd height="25"> 
          <select name="mm" onChange="submitform();" class="input4">
            <%for (int i=1;i<=12;i++){%> 
            <option<%if (i==mm){%> selected<%}%>><%=i%></option>
            <%}%> 
          </select>月<input type=button name=clo value="x" onclick="parent.closeD();" title="关闭日历">
      </td>
    </tr>
    <tr valign="top"> 
      <td colspan="2"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="unnamed1">
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
  
    <%while (mowDate.getMonth()+1==mm){%> 
      <tr><%for (int i=1;i<=7;i++){
	       String ym=String.valueOf(mm);
		   String yd=String.valueOf(mowDate.getDate());
		   if (ym.length()==1){ym="0"+ym;}
		   if (yd.length()==1){yd="0"+yd;}
		   %>  
         <td  height="20"<%if ((mowDate.getMonth()+1==mm)&&(mowDate.getDay()+1==i)){%> style="cursor:hand" onMouseOver="style.backgroundColor='#99ccff';style.color='#F3F3F3'" onMouseOut="style.backgroundColor='#F3F3F3';style.color='#000000'"  onClick="Dat('<%=String.valueOf(yy)+"/"+ym+"/"+yd%>');parent.closeD();" <%}%> bgcolor="#F3F3F3"> 
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

	</td></tr>
  </table>
</form>	

</body>
</html>
