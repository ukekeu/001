<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/logrecord.jsp" %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%

  String ysID=request.getParameter("ysID");
  String shouldmoney=request.getParameter("shouldmoney");
  String period=request.getParameter("period");
  String Money=request.getParameter("Money");
  String Date1=request.getParameter("Date1");
  String ysDate=request.getParameter("ysDate");
  String jkstate=request.getParameter("jkstate");
  String jkst=request.getParameter("jkst");
    String room   =getbyte1(request.getParameter("room"));
   String qianKuan=request.getParameter("qianKuan");
String factmoney=FormtD.getFloat3(Double.parseDouble(shouldmoney)-Double.parseDouble(qianKuan),2);
 
  if (factmoney==null)factmoney="0";
  String factmoney1=request.getParameter("factmoney1");
  if (Money!=null){
    String SQL="update GatheringRecord set shouldDate='"+Date1+"'"
	      +",shouldMoney="+Money +",state="+jkst+",yijiao="+factmoney1+" where id="+ysID;
     int a=ViewBean.executeUpdate(SQL);
	
	  SQL="select salerprice-ajmoney- ";
	  SQL+="(select case when sum(shouldMoney) is null then 0 else sum(shouldMoney)  end   ";
	  SQL+=" from GatheringRecord where contactno=(select contactno from GatheringRecord  where id="+ysID+"))";
	  SQL+=" as ca_money    from order_contract where  salerprice-ajmoney>=";
	  SQL+="(select case when sum(shouldMoney) is null then 0 else sum(shouldMoney)  end ";
	  SQL+=" from GatheringRecord where contactno=(select contactno from GatheringRecord  where id="+ysID+")) and code=(select contactno from GatheringRecord  where id="+ysID+")";
    
	 ResultSet rs=ViewBean.executeQuery(SQL);
	  float ca_money=0;
	 if (rs.next()) 
	    ca_money=rs.getFloat("ca_money");
		rs.close();
		setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�޸�Ӧ�տ�" , 
                  "�޸�"+room
                ) ;	
      out.print("<script>");
     if (ca_money>0)
	  out.print("alert('ϵͳ�ѱ���,Ӧ�տ��"+ca_money+"');");
	  out.print("opener.document.forms[0].submit();");
	  out.print("window.close();");
      out.print("</script>");
  
  }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>�޸�Ӧ�տ�</title>

</head>

<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<SCRIPT language=javascript>
function steven(){
    if ( Validate(document.cus1) ){
        document.cus1.submit();
    }
}
function Validate(aForm)
   {
		 
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("���������ڣ�");
	        aForm.Date1.focus();
	        return (false);
	    	}
		
		if(isNaN(aForm.Money.value)){
			alert("ʵ�ս����������֣�");
	        aForm.Money.focus();
	        return (false);
		}

  		
	    return (true);
   }
      
</SCRIPT>


<body bgcolor="#EBEBEB" >

<form method="POST" name="cus1" action="">
<input type=hidden name=ysID value="<%=ysID %>" >
<input type=hidden name=jkstate value="<%=jkstate %>" >
 <input type=hidden name=room value=<%=getbyte2(request.getParameter("room")) %>>
	<p align="center"><b><font size="3" color="#000080">Ӧ�տ�Ǽ�</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
          <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;Ӧ������</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=ysDate %>"  onkeydown="key(document.cus1.Money)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;Ӧ�ս��</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="Money" value="<%=shouldmoney %>" size="12" onblur="check(document.cus1.Money);">
        </td>
      </tr>
	   
	 
          &nbsp;<input type=hidden name=jkst value="<%=jkstate %>">
		     
	 
	
    </table> 
	<br>
	 <div align="center"> 
            <input type="button" value="�ᡡ��" name="Save" onclick="steven();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="ȡ  ��" name="button" onclick="window.close();">
          </div> 
</form>     
 
   
       
       
</body>       
</html>       
