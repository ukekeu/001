<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
 
   String code=getbyte1(request.getParameter("code"));
   String FactMoney=getbyte1(request.getParameter("FactMoney"));
   String TaxName_type="";
   String taxname=getbyte1(request.getParameter("taxname"));
  
   String Date=getbyte1(request.getParameter("Date"));
   String handler=getbyte1(request.getParameter("handler"));
  if (!FactMoney.equals("")){
    TaxName_type=taxname.substring(taxname.indexOf("-")+1);
   taxname=taxname.substring(0,taxname.indexOf("-"));
  String  SQL="insert into  factGatheringTaxRecord(contractno,TaxName";
  SQL+=",money,DATE,NO,handler,TaxName_type) select "+code+",'"+taxname+"'";
  SQL+=","+FactMoney+",'"+Date+"','','"+handler+"',"+TaxName_type;

     ViewBean.executeUpdate(SQL); 
	 SQL="UPDATE GatheringTaxRecord SET  factmoney=factmoney+"+FactMoney+ " WHERE TaxName='"+taxname+"' AND ContactNo="+code;
     ViewBean.executeUpdate(SQL); 
  %>
  <script>
  alert("���޸�");
  opener.window.location.reload();
  window.close();
  </script>
  <%} %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>����</title>

</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language="javascript" src="../public_js/public.js">
</script>
  


<body   bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="">
<input type=hidden name=code value=<%=code %>>
 
	<p align="center"><b><font size="3" color="#000080">�����Ǽ�</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;��������</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<select name=taxname>
		  <%
		  String sql="select taxname,TaxName_type from factGatheringTaxRecord where contractno ='"+code+"' group by taxname,TaxName_type";//order by room_no desc";
            ResultSet  rs=ViewBean.executeQuery(sql);
	      
			 while (rs.next()){
			   taxname=rs.getString("taxname");
			   TaxName_type=rs.getString("TaxName_type");
			 out.println("<option value='"+taxname+"-"+TaxName_type+"'>"+taxname+"</option>");
			 }
			 rs.close();
			 %>
	
		  
		  </select>
			  </td>
      </tr>
      
     
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;���ý��</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney" size=12 value="0" size="20" style="border-style: solid; border-width: 1" onblur="check(this);">
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��������</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<INPUT TYPE="text"  NAME=Date size=10  title="��ѡ��ǩԼ����"   onkeydown="key(document.cus.kkrate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date);" title="��ѡ���Ϲ�����">
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;������</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<INPUT TYPE="text"  NAME=handler size=10   value="<%= (String)session.getAttribute("loginname")  %>">
        </td>
      </tr>
	  
    </table> 
	 <div align="center"> 

             <input type=hidden name=cusno>
            <input type="button" value="�ᡡ��" name="modi"  onclick="checkdata();" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="��  ��" name="button" onclick="window.close();">
          </div> 
</form>     
 
   
       <script>
	   function checkdata(){
	    if (document.cus1.taxname.value==""){alert("��ѡ�񲹽��ķ�������");return false;}
		if (parseFloat(document.cus1.FactMoney.value<=0)){alert("��¼�벹���ķ��ý��");return false;}
		if (confirm("ȷ���㲹���ķ�����"))
		 document.cus1.submit();
	   
	   }
	   </script>
       
</body>       
</html>       
