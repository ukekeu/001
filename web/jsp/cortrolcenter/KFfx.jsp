<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="vemBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>�ͻ���������</title>
<script language="JavaScript" src='../public_js/basal.js'></script>


</head>
<% 
  %>
 
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<SCRIPT language=javascript> 
 
function checkdate(){
if (document.forms[0].Date1.value.length<1){
	    	alert("��ѡ��ʼ���ڣ�");
	        document.forms[0].Date1.focus();
	        return false;
	    }
if (document.forms[0].Date2.value.length<1){
	    	alert("��ѡ��������ڣ�");
	        document.forms[0].Date2.focus();
	        return false;
	    } 
}		
function fulldate(){
var dd= new Date();
var mm=dd.getMonth()+1;
if (mm<10)mm="0"+mm;
var da=dd.getDate()
if (da<10)da="0"+da;


 document.forms[0].Date2.value=dd.getYear()+"-"+mm+"-"+da;

}
 
</SCRIPT>

<body onload="fulldate();">
            

     <p align="center"><b><font size="3" color="#000080">ѡ���������</font></b>
<br>
	   <form name=frm method="post" action="KFfx.jsp" >
	   <input type=hidden name=secno value="<%=request.getParameter("secno")%>">
	    <table width="100%" cellspacing="1" cellpadding>
                    <tr>
                      <td width="50%" bgcolor="#EAEAEA" align="center"><font size="2" color="#000080">��ʼ���ڣ�</font></td>
					  <td width="50%" bgcolor="#EAEAEA" align="center"><input onkeydown="key(document.cus.VisaDate)" title="��ѡ���Ϲ�����" size="10" name="Date1"><input title="��ѡ��ʼ����" onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
                    <tr>
                      <td width="50%" bgcolor="#EAEAEA" align="center"><font size="2" color="#000080">�������ڣ�</font></td>
					  <td width="50%" bgcolor="#EAEAEA" align="center"><input onkeydown="key(document.cus.VisaDate)" title="��ѡ���Ϲ�����" size="10" name="Date2"><input title="��ѡ��ʼ����" onclick="fPopUpCalendarDlg(Date2);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
					 
				</table>
				 <input type=submit name=submit1 value="�� ��" onclick="return checkdate(this);"> <input type=button name=winclose value="�� ��" onclick="window.close();" >
 <p align="center"><b><font size="3" color="#000080"> �ͻ������������ </font></b></p>
 <table width="100%"  border="0" cellspacing="1" cellpadding="2">


<%  
    String SecNo=request.getParameter("secno");
    String Date1 = request.getParameter("Date1");
    String Date2 = request.getParameter("Date2");
	if (Date1!=null){
	String SQL="SELECT count(*) dd FROM KFRECO WHERE SECNO='"+SecNo+"' and reco_date between  '"+Date1+"' and '"+Date2+"'";
	float sumnum=0;
    ResultSet rs=ViewBean.executeQuery(SQL); 
	if (rs.next()){ sumnum=rs.getFloat("dd");}
	rs.close();
	%>
	  <tr><td height=16  width="40%">&nbsp;</td>
<td width="60%">&nbsp;<img src="../images/line.gif" height=16  width="<%=sumnum/sumnum*200%>"><%=sumnum %>��</td>
	

</tr> 
	<%
	SQL="SELECT room_code,count(*) dd FROM KFRECO WHERE SECNO='"+SecNo+"' and reco_date between  '"+Date1+"' and '"+Date2+"' group by room_code";
      rs=ViewBean.executeQuery(SQL); 
	while (rs.next()){ 
     float  dd=rs.getFloat("dd"); 
	  String room_code=rs.getString("room_code");
	  ResultSet rs1=vemBean.executeQuery("select count(*) num from order_contract where sectionname+loft+room_no='"+room_code+"'"); 
      int ddd=0;
	  if (rs1.next())ddd=rs1.getInt("num");
	  rs1.close();
	   rs1=vemBean.executeQuery("select context from KFRECO where room_code='"+room_code+"'"); 
      String reco="";
	  while (rs1.next()){reco+=rs1.getString("context")+"<br>&nbsp;";}
	  rs1.close();
	  
 %>
  <tr  bgcolor="#EAEAEA"><td height=16  width="40%">&nbsp;<%=room_code %>&nbsp;&nbsp;<%if (ddd>0){out.print("����");}else{out.print("δ��");} %>&nbsp;<br>&nbsp;������¼��<br>&nbsp;<%=reco %></td> 
<td width="60%">&nbsp;<img src="../images/line.gif" height=16  width="<%=dd/sumnum*200%>"><%=FormtD.getFloat2(dd*1.0/(sumnum)*100,2) %>%(<%=dd %>��)</td>
	

</tr>   
<%} 
}%>     
					 
				</table>
</form>     
       
       
       
</body>       
</html>       
