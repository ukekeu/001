<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="vemBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>�����ӡ��������</title>
<script language="JavaScript" src='../public_js/basal.js'></script>


</head>
<%
String PARA_SQL=request.getParameter("PARA_SQL");

String url=request.getParameter("url");
String reporttype=request.getParameter("reporttype");
String tablename=request.getParameter("tablename");
String choose=request.getParameter("choose");
String out3=request.getParameter("out3");
String ifvalueC=getbyte(request.getParameter("ifvalueC"));
String ifvalueE=getbyte(request.getParameter("ifvalueE"));
 String SQLwhere="";
  %>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<SCRIPT language=javascript>
function changebuild(obj){
   var objvalue=obj.value;
   var html="";
   var i=0;
   var arr=new Array();
   <%String sqlx= "select SerialNo,Name from CRM_Project " ;
 ResultSet Rsx = ViewBean.executeQuery(sqlx) ;
 while (Rsx.next()) {
String tmpid = Rsx.getString("SerialNo") ;%>
    if(objvalue=="<%=tmpid%>"){
html="";
i=0;
<%  int j=1;
    int x=0;
	String sqlUser = "select loft from Sectiontree where  SerialNo='"+tmpid+"'";
ResultSet userRs = vemBean.executeQuery(sqlUser) ;
while (userRs.next()) {
String housename = userRs.getString("loft") ;
if (housename == null)
  housename = "" ;
  housename = getbyte(housename) ;
%>
arr[i]="<option value='<%=housename%>'><%=housename%></option>";
++i;
    <%}userRs.close();%>
html="<select name='Loft' style='width=100;'><option value=''></option>"+arr.join();
html=html+"</select>";
document.all("sub").innerHTML=html;

}
  <%}Rsx.close();%>
}
function checkdate(){
/*if (document.forms[0].Date1.value.length<1){
	    	alert("��ѡ��ʼ���ڣ�");
	        document.forms[0].Date1.focus();
	        return false;
	    }
if (document.forms[0].Date2.value.length<1){
	    	alert("��ѡ��������ڣ�");
	        document.forms[0].Date2.focus();
	        return false;
	    }
		*/
 if (document.forms[0].SecNo.value==""){
            alert("��ѡ��¥������");
            document.forms[0].SecNo.focus();
	        return false;  

 }
 if (document.forms[0].Loft.value==""){
            alert("��ѡ�񶰺�");
            document.forms[0].Loft.focus();
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
function fill(){
  if (document.forms[0].SecNo.options[document.forms[0].SecNo.selectedIndex].text!="") 
    document.forms[0].secname.value=document.forms[0].SecNo.options[document.forms[0].SecNo.selectedIndex].text;
  if (document.forms[0].Loft.options[document.forms[0].Loft.selectedIndex].text!="") 
    document.forms[0].loftname.value=document.forms[0].Loft.options[document.forms[0].Loft.selectedIndex].text;

}

 
//-->
</SCRIPT>

<body >
      <input type=hidden name=choose value="<%=choose%>">      

     <p align="center"><b><font size="3" color="#000080">��ѡ���ӡ����</font></b>
<br>
	   <form name=frm method="post" action="jz_charges.jsp"  target="_blank">
	    <table width="80%" cellspacing="1" cellpadding>
                 <!--   <tr>
                      <td width="50%" bgcolor="#EAEAEA" align="center"><font size="2" color="#000080">��ʼ���ڣ�</font></td>
					  <td width="50%" bgcolor="#EAEAEA" align="center"><input onkeydown="key(document.cus.VisaDate)" title="��ѡ���Ϲ�����" size="10" name="Date1"><input title="��ѡ��ʼ����" onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
                    <tr>
                      <td width="50%" bgcolor="#EAEAEA" align="center"><font size="2" color="#000080">�������ڣ�</font></td>
					  <td width="50%" bgcolor="#EAEAEA" align="center"><input onkeydown="key(document.cus.VisaDate)" title="��ѡ���Ϲ�����" size="10" name="Date2"><input title="��ѡ��ʼ����" onclick="fPopUpCalendarDlg(Date2);return false;" type="button" value=".." name="cale"></b></font></td>
                    </tr>
					-->
                    <tr>
                      <td width="50%" bgcolor="#EAEAEA"  align="center"><font size="2" color="#000080">ѡ��¥��:&nbsp;</font></td>
					  <td width="50%" bgcolor="#EAEAEA"  align="center">
					  <%@ include file="../public_js/CheckSection.jsp"%>
					  <%
      String sql="select SerialNo,Name from CRM_Project "+FindWhere;
					   ResultSet rs2=ViewBean.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="SecNo"  onclick="changebuild(this);fill();" style="width=100;">
					      <option value=""></option>
						  <%while (rs2.next()){
	                          no=rs2.getString("SerialNo");
	                          sec=getbyte(rs2.getString("Name"));
     	                      out.print("<option value='"+no+"'>"+sec+"</option>");
	                         }
	                        rs2.close();
	                        String Sql = "" ;
                              %> 
							</select>
					</tr>
					<tr>
                      <td width="50%" bgcolor="#EAEAEA" align="center"><font  size="2" color="#000080">ѡ�񶰺�:&nbsp;</font></td>
					  <td width="50%" bgcolor="#EAEAEA" align="center" id="sub">
					 <select name="Loft"  style="width=100;"  onblur="fill();">
					      <option value=""></option>
						 
							</select>
					</tr>
					<tr>
                      <td width="50%" bgcolor="#EAEAEA" align="center"><font  size="2" color="#000080">��ת����:&nbsp;</font></td>
					  <td width="50%" bgcolor="#EAEAEA" align="center" >
					 <select name="choose"  style="width=100;"  >
					      <option value="1">�ѽ�ת</option>
						  <option value="0">δ��ת</option>
							</select>
					</tr>
				</table>
				<input type=hidden name=secname>
   			    <input type=hidden name=loftname>
				 <input type=submit name=submit1 value="Ԥ ��/�� ӡ" onclick="fill();return checkdate(this);"> <input type=button name=winclose value="�� ��" onclick="window.close();" >
</form>     
       
       
       
</body>       
</html>       