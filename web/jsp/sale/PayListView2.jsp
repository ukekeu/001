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
		if ( confirm("ȷʵ��ɾ��������¼?"))
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
  // if (payname.indexOf("��")>=0)aa="���ڿ�";
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
		if (num==1)qs="���ڿ�:";
		if (num==2)qs="���ڿ�:";
		if (num==3)qs="���ڿ�:";
		if (num==4)qs="���ڿ�:";
		if (num==5)qs="���ڿ�:";
		if (num==6)qs="���ڿ�:";
		
  str+="<tr  align='center' >";//onmouseout='mOut(this,'#e6f9ff');' onmouseover='mOvr(this,'#EAECEC');'

    if (state1){//����ǹ̶����
      if (state4){//¥��
	    if (state3)
		 str+="<td align=left width='49%'><input type=text name=a1 class=unnamed1 value="+qs+""+aa+""+scale+"(��������)></td>";
		else 
		str+="<td align=left width='49%'> <input type=text name=gw class=unnamed1 value="+qs+""+aa+""+scale+"></td>";
	  }else{//����
        str+="<td align=left width='49%'><input type=text name=gw class=unnamed1 value="+qs+"����"+scale+"></td>";
	  } 
    }else{
	  if (state3)
	   if (SaleSumPrice.equals("1"))
         str+="<td align=left width='49%'>"+qs+"<input type=text name=gw class=unnamed1 value="+aa+"&nbsp;&nbsp;&nbsp;&nbsp;(��������)></td>";
	   else
	     str+="<td align=left width='49%' >"+qs+"<input type=text name=gw class=unnamed1  value="+aa+""+format.getFloat(Float.parseFloat(SaleSumPrice)*scale/100+Float.parseFloat(ykc),2)+"(��������)>Ԫ</td>";
	  else
        if (SaleSumPrice.equals("1"))
	     str+="<td align=left width='49%'>"+qs+"<input type=text name=gw class=unnamed1  value="+aa+"></td>";
		else
		 str+="<td align=left width='49%'>"+qs+"<input type=text name=gw class=unnamed1  value="+aa+""+format.getFloat(Float.parseFloat(SaleSumPrice)*scale/100,2)+">Ԫ</td>";
    } 
  //str+="<td>"+qs+"</td>";
  if (state2)//���̶����ڸ���
  str+="<td align=left >&nbsp;����ʱ��:<input type=text name=gw class=unnamed1  value="+paymentdate+"&nbsp;&nbsp;&nbsp;>��ǰ����</td>";
  else{//���䶯���ڸ���
    if (state5) //��ǩԼ����
	 str+="<td align=left >&nbsp;����ʱ��:<input type=text name=gw class=unnamed1 value="+paymentdate+">���ڸ���</td>";
	else //���Ϲ�����
	 str+="<td align=left >&nbsp;����ʱ��:<input type=text name=gw class=unnamed1  value=�Ϲ���&nbsp;&nbsp;&nbsp;"+paymentdate+">���ڸ���</td>";
   }
 
  if (count==null)	{
  str+="<td class=chtitle>&nbsp;";
  str+="<a href='#' onclick=openwin('EditPayList.jsp?id="+String.valueOf(id)+"&payname="+payname+"&code="+code+"',480,300,100,100)>����</a>";
  //str+="<a href='javascript:delPayment("+ String.valueOf(id)+")'>ɾ��</a>";
 // str+="<a href='#' onclick=openwin('PayList.jsp?id="+String.valueOf(id)+"&payname="+payname+"&paycode="+code+"&paynum="+paynum+"',480,300,100,100)>����</a>"; 
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

//��������ָ�����ڰ�����������������,��Ϊ����
out.println(ShowPay("select id,num,paydate ,money as scale,state1,state2,state3,state4,state5  from PayDetail where num>0 and payCode ="+code+" and  state1='1' and state2='0' and state3=0 order by num"));

//��������ָ�����ڰ�ָ�����ڼ����������
out.println(ShowPay("select id,num,convert(char(24),date,111) as paydate,money as scale,state1,state2,state3,state4,state5  from PayDetail where num>0 and payCode ="+code+" and state1='1' and state2='1' order by num"));

//���������ٱȼ��㣬���ڰ�������������������
out.println(ShowPay("select id,num,PayDate ,scale,state1,state2,state3,state4,state5 from PayDetail where num>0 and PayCode ="+code+" and state1='0' and state2='0' order by num"));

//���������ٱȼ��㣬���ڰ�ָ�����ڼ����������
//out.println(ShowPay("select id,num,convert(char(24),date,111) as paydate, scale,state1,state2,state3,state4,state5  from PayDetail where payCode ="+code+" and  state1='0' and state2='1' order by num"));

//��������ָ�����ڰ�����������������,��Ϊ¥��
out.println(ShowPay("select id,num,paydate ,money as scale,state1,state2,state3,state4,state5  from PayDetail where num>0 and payCode ="+code+" and  state1='1' and state2='0' and state3=1 order by num"));


  %>
  </table>
</center>
</body>
</html>
