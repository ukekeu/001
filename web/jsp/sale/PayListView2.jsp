<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
<script src="js/mad.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script>

	function delPayment(id) {
		if ( confirm("确实想删除该条记录?"))
			window.location = "SaveList.jsp?para=dele"+"&id=" + id;
	}
   function add(){
     window.location='PayList.jsp?payname=<%=request.getParameter("payname")%>&paycode=<%=request.getParameter("code")%>'
   }	
</script>
</head> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%!String count="";
  String SaleSumPrice="";
  String ykc="0";
%>
<%count= request.getParameter("count");

 SaleSumPrice= request.getParameter("SaleSumPrice");
 
 if (SaleSumPrice==null)SaleSumPrice="1";
  ykc= request.getParameter("ykc");
 if (ykc==null)ykc="0";

 if(SaleSumPrice.equals(""))SaleSumPrice="1";
 %>
<body>
<center>
<table width="98%" border="0" cellpadding="1" cellspacing="1">
 
  <%@ page import = "java.sql.*" %>
  <jsp:useBean id = "paymentListBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <%! String code="";
      String payname="";
	  String paynum="";
  %>
   <%code=request.getParameter("code");
    payname=request.getParameter("payname");
	paynum=request.getParameter("paynum");
	

	 
   %>
	<%!
	 public String ShowPay(String sqlstr) throws Exception  {
	  String paymentStr = sqlstr;
	  String  str="";
	  boolean state1=false;
      boolean state2=false;
      boolean state3=false;
      boolean state4=false;
	  boolean state5=false;
	  int jjj=0;
	    String aa="";
  // if (payname.indexOf("揭")>=0)aa="首期款";
	 ConnDatabase.SDatabase paymentListBean1=new ConnDatabase.SDatabase();
	 FormatData.FormatData format=new FormatData.FormatData();
	 ResultSet paymentRS = paymentListBean1.executeQuery(paymentStr);
		
		while (paymentRS.next()) {
		int  id = paymentRS.getInt("ID");
		int  num = paymentRS.getInt("num");
		String qs="";
	    String  paymentdate = paymentRS.getString("PayDate");
		float scale=paymentRS.getFloat("scale");
		state1=paymentRS.getBoolean("state1");
		state2=paymentRS.getBoolean("state2");
		state3=paymentRS.getBoolean("state3");
		state4=paymentRS.getBoolean("state4");
        state5=paymentRS.getBoolean("state5");
		if (num==1)qs="首期款:";
		if (num==2)qs="二期款:";
		if (num==3)qs="三期款:";
		if (num==4)qs="四期款:";
		if (num==5)qs="五期款:";
		if (num==6)qs="六期款:";
		
  str+="<tr  align='center' >";//onmouseout='mOut(this,'#e6f9ff');' onmouseover='mOvr(this,'#EAECEC');'

    if (state1){//如果是固定金额
      if (state4){//楼款
	    if (state3)
		 str+="<td align=left width='49%'><input type=text name=a1 class=unnamed1 value="+qs+""+aa+""+scale+"(包括定金)></td>";
		else 
		str+="<td align=left width='49%'> <input type=text name=gw class=unnamed1 value="+qs+""+aa+""+scale+"></td>";
	  }else{//定金
        str+="<td align=left width='49%'><input type=text name=gw class=unnamed1 value="+qs+"定金"+scale+"></td>";
	  } 
    }else{
	  if (state3)
	   if (SaleSumPrice.equals("1"))
         str+="<td align=left width='49%'>"+qs+"<input type=text name=gw class=unnamed1 value="+aa+"&nbsp;&nbsp;&nbsp;&nbsp;(包括定金)></td>";
	   else
	     str+="<td align=left width='49%' >"+qs+"<input type=text name=gw class=unnamed1  value="+aa+""+format.getFloat(Float.parseFloat(SaleSumPrice)*scale/100+Float.parseFloat(ykc),2)+"(包括定金)>元</td>";
	  else
        if (SaleSumPrice.equals("1"))
	     str+="<td align=left width='49%'>"+qs+"<input type=text name=gw class=unnamed1  value="+aa+"></td>";
		else
		 str+="<td align=left width='49%'>"+qs+"<input type=text name=gw class=unnamed1  value="+aa+""+format.getFloat(Float.parseFloat(SaleSumPrice)*scale/100,2)+">元</td>";
    } 
  //str+="<td>"+qs+"</td>";
  if (state2)//按固定日期付款
  str+="<td align=left >&nbsp;付款时间:<input type=text name=gw class=unnamed1  value="+paymentdate+"&nbsp;&nbsp;&nbsp;>以前付清</td>";
  else{//按变动日期付款
    if (state5) //按签约日期
	 str+="<td align=left >&nbsp;付款时间:<input type=text name=gw class=unnamed1 value="+paymentdate+">天内付清</td>";
	else //按认购日期
	 str+="<td align=left >&nbsp;付款时间:<input type=text name=gw class=unnamed1  value=认购后&nbsp;&nbsp;&nbsp;"+paymentdate+">天内付清</td>";
   }
 
  if (count==null)	{
  str+="<td class=chtitle>&nbsp;";
  str+="<a href='#' onclick=openwin('EditPayList.jsp?id="+String.valueOf(id)+"&payname="+payname+"&code="+code+"',480,300,100,100)>更改</a>";
  //str+="<a href='javascript:delPayment("+ String.valueOf(id)+")'>删除</a>";
 // str+="<a href='#' onclick=openwin('PayList.jsp?id="+String.valueOf(id)+"&payname="+payname+"&paycode="+code+"&paynum="+paynum+"',480,300,100,100)>增加</a>"; 
  str+="</td>";
  }
  str+="</tr>";
    str+="<tr><td>&nbsp;</td><td>&nbsp;</td></tr>";
 }
 
 paymentRS.close();
 return str;
}
%>
<%

//输出付款金额按指金额，日期按相对天数计算的期数,且为定金
out.println(ShowPay("select id,num,paydate ,money as scale,state1,state2,state3,state4,state5  from PayDetail where num>0 and payCode ="+code+" and  state1='1' and state2='0' and state3=0 order by num"));

//输出付款金额按指金额，日期按指定日期计算的期数。
out.println(ShowPay("select id,num,convert(char(24),date,111) as paydate,money as scale,state1,state2,state3,state4,state5  from PayDetail where num>0 and payCode ="+code+" and state1='1' and state2='1' order by num"));

//输出付款金额按百比计算，日期按相对天数计算的期数。
out.println(ShowPay("select id,num,PayDate ,scale,state1,state2,state3,state4,state5 from PayDetail where num>0 and PayCode ="+code+" and state1='0' and state2='0' order by num"));

//输出付款金额按百比计算，日期按指定日期计算的期数。
//out.println(ShowPay("select id,num,convert(char(24),date,111) as paydate, scale,state1,state2,state3,state4,state5  from PayDetail where payCode ="+code+" and  state1='0' and state2='1' order by num"));

//输出付款金额按指金额，日期按相对天数计算的期数,且为楼款
out.println(ShowPay("select id,num,paydate ,money as scale,state1,state2,state3,state4,state5  from PayDetail where num>0 and payCode ="+code+" and  state1='1' and state2='0' and state3=1 order by num"));


  %>
  </table>
</center>
</body>
</html>
