<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/logrecord.jsp" %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
   String room=getbyte1(request.getParameter("room"));
  String ysID=getbyte2(request.getParameter("ysID"));
  String shouldmoney=getbyte2(request.getParameter("shouldmoney"));
  String period=getbyte2(request.getParameter("period"));
  String Money=getbyte2(request.getParameter("Money"));
  String Date1=request.getParameter("Date1");
  String ysDate=request.getParameter("ysDate");
  String jkstate=getbyte2(request.getParameter("jkstate"));
  String jkst=getbyte2(request.getParameter("jkst"));
   String qianKuan=request.getParameter("qianKuan");
  String factmoney=FormtD.getFloat3(Double.parseDouble(shouldmoney)-Double.parseDouble(qianKuan),2);
   
  if (factmoney.equals(""))factmoney="0";
  String factmoney1=getbyte2(request.getParameter("factmoney1"));
  if (!Money.equals("")){
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
                  "修改应收款" , 
                  "修改"+room
                ) ;	
      out.print("<script>");
	   if (ca_money>0)
      out.print("alert('系统已保存,应收款还差"+ca_money+"');");
	  out.print("opener.document.f1.submit();");
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
<title>收款登记</title>

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
	    	alert("请输入日期！");
	        aForm.Date1.focus();
	        return (false);
	    	}
		
		if(isNaN(aForm.Money.value)){
			alert("实收金额必须是数字！");
	        aForm.Money.focus();
	        return (false);
		}

  		
	    return (true);
   }
      
</SCRIPT>


<body bgcolor="#EBEBEB" onload="setSelectMad(document.cus1.jkst,'<%=jkstate %>');">

<form method="POST" name="cus1" action="">
<input type=hidden name=ysID value="<%=ysID %>" >
<input type=hidden name=jkstate value="<%=jkstate %>" >
<input type=hidden name=period value="<%=period %>" >
 
	<p align="center"><b><font size="3" color="#000080">应收款登记</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
          <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;应收日期</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=ysDate %>"  onkeydown="key(document.cus1.Money)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;应收金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="Money" value="<%=shouldmoney %>" size="12" onblur="check(document.cus1.Money);">
        </td>
      </tr>
	   <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;实交金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="factmoney1" value="<%=factmoney %>" size="12" onblur="check(document.cus1.Money);">
        </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;交款情况</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=jkst style="width : 98">
		     <option value=0>未交款</option>
			  <option value=1>交款中</option> 
			  <option value=2>交完款</option>
			  </select>
			 
        </td>
      </tr>
	
    </table> 
	<br>
	 <div align="center"> 
            <input type="button" value="提　交" name="Save" onclick="steven();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="取  消" name="button" onclick="window.close();">
          </div> 
</form>     
 
   
       
       
</body>       
</html>       
