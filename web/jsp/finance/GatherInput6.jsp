 
<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%


  String CusNo=request.getParameter("CusNo");
  String contractno=request.getParameter("contractno");
  String period=request.getParameter("period");
  String Money=request.getParameter("Money");
  String Date1=request.getParameter("Date1");
  String eDate=request.getParameter("eDate");
  String curry=request.getParameter("curry");
  String rate=request.getParameter("rate");
  String ysSumMoney=request.getParameter("ysSumMoney");
 String Payment="";
 
  if (Money!=null){
     Payment=request.getParameter("Payment");
    String SQL="";
	
	  SQL="select salerprice+lu_tai_area*lu_tai_area_price+gaizhang_area*gaizhang_unitprice+ ty_area*ty_area_price-ajmoney-"+String.valueOf(Float.parseFloat(ysSumMoney)+Float.parseFloat(Money))+" as  ca_money from order_contract where  salerprice+lu_tai_area*lu_tai_area_price+gaizhang_area*gaizhang_unitprice+ ty_area*ty_area_price-ajmoney>="+String.valueOf(Float.parseFloat(ysSumMoney)+Float.parseFloat(Money)) +" AND  code="+contractno;

	ResultSet rs=ViewBean.executeQuery(SQL);
	if (rs.next()){
	      String ca_money=rs.getString("ca_money");
		  rs.close();
	       SQL="INSERT INTO GatheringRecord(cusno,ContactNo,shouldQS,shouldDate,shouldMoney,curry,rate)"
	       +" values('"+CusNo+"','"+contractno+"',"+period+",'"+Date1+"',"+Money+",'"+curry+"',"+rate+")";
         int a=ViewBean.executeUpdate(SQL);
         out.print("<script>");
 
       out.print("alert('系统已保存,系统检测到应收还差："+ca_money+"');");
	  
		 
		 out.print("opener.window.location.reload();");
	     out.print("window.close();");
         out.print("</script>");
  }else{
         out.print("<script>");
         out.print("alert('各期累计款大于了应交款,重新输入本期的付款金额');");
	        out.print("</script>");
  
  }
  rs.close();
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
		if (aForm.period.value.length<1)
	    	{
	    	alert("请输入收款期数！");
	        aForm.period.focus();
	        return (false);
	    	}
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("请输入日期！");
	        aForm.Date1.focus();
	        return (false);
	    	}
		 if (aForm.Date1.value<=aForm.eDate.value)
		 	{
	    	alert("当前期数的付款日期不能小于前一次的付款日期");
	        aForm.Date1.focus();
	        return (false);
	    	}		
		if(isNaN(aForm.Money.value)){
			alert("实收金额必须是数字！");
	        aForm.Money.focus();
	        return (false);
		}
       if (parseInt(aForm.Money.value)<=0){
	     alert("付款金额必须在于0");
		  aForm.Money.focus();
	        return (false);
	   
	   }
  		
	    return (true);
   }
      
</SCRIPT>


<body bgcolor="#EBEBEB">
<form method="POST" name="cus1" action="">
<input type=hidden name=contractno value="<%=contractno %>">
<input type=hidden name=CusNo value="<%=CusNo %>" >
<input type=hidden name=eDate value="<%=eDate %>" >
<input type=hidden name=ysSumMoney value="<%=ysSumMoney %>">
<input type=hidden name=Payment value="<%=request.getParameter("Payment") %>">
	<p align="center"><b><font size="3" color="#000080">应收款登记</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
     
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;应收期数</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type="text" name="period" value="<%=period %>" size="20"  readonly value="" >
        </td>
      </tr>
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;应收日期</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value=""  onkeydown="key(document.cus1.Money)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;应收金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="Money"  size="20" onblur="check(document.cus1.Money);">
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
