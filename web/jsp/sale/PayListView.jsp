<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
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
 String  ykc="0";
%>
<%count= request.getParameter("count");
  String Cortrol= request.getParameter("Cortrol");
 SaleSumPrice= request.getParameter("SaleSumPrice");
  ykc= request.getParameter("ykc");
 if (ykc==null)ykc="0";

 if (SaleSumPrice==null)SaleSumPrice="1";
 if(SaleSumPrice.equals(""))SaleSumPrice="1";
 
 %>
<body>
<div align="center">
  <table  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF"> 
  <tr  bgcolor="#DFDFDF" > 
   
    <td  > 
      <div align="center">��������</div>
    </td>
    <td  > 
      <div align="center">��������</div>
    </td>
    <td  > 
      <div align="center">������</div>
    </td>
    <%if (count==null){ %>
    <td  > 
      <div align="center">����</div>
    </td>
	<%} %>
  </tr>
  <%@ page import = "java.sql.*" %>
  <jsp:useBean id = "paymentListBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <%! String code="";
      String payname="";
	  String paynum="";
  %>
   <%code=request.getParameter("code");
    payname=getbyte1(request.getParameter("payname"));
	paynum=request.getParameter("paynum");
	
   %>

	<%!
	 public String ShowPay(String sqlstr,JspWriter out,String Cortrol) throws Exception  {
	  String paymentStr = sqlstr;
	  String  str="";
	  boolean state1=false;
      boolean state2=false;
      boolean state3=false;
      boolean state4=false;
	  boolean state5=false;
	  int jjj=0;
	    String aa="������";
  // if (payname.indexOf("��")>=0)aa="���ڿ�";
	 ConnDatabase.SDatabase paymentListBean1=new ConnDatabase.SDatabase();
	 ResultSet paymentRS = paymentListBean1.executeQuery(paymentStr);
		 FormatData.FormatData formatD1=new FormatData.FormatData();
		while (paymentRS.next()) {
		int  id = paymentRS.getInt("ID");
		int  num = paymentRS.getInt("num");
	    String  paymentdate = paymentRS.getString("PayDate");
		float scale=paymentRS.getFloat("scale");
		state1=paymentRS.getBoolean("state1");
		state2=paymentRS.getBoolean("state2");
		state3=paymentRS.getBoolean("state3");
		state4=paymentRS.getBoolean("state4");
        state5=paymentRS.getBoolean("state5");
  String qs="";
  if (num==0)qs="����";
  else if (num==1)qs="���ڿ�";
  else if (num==2)qs="����2";
  else if (num==3)qs="����3";
  else if (num==4)qs="����4";
   else if (num==5)qs="����5";
    else if (num==6)qs="����6";
	 else if (num==7)qs="����7";
  str+="<tr  align='center' >";//onmouseout='mOut(this,'#e6f9ff');' onmouseover='mOvr(this,'#EAECEC');'
  str+="<td  >"+qs+"</td>";
  if (state2)//���̶����ڸ���
  str+="<td align=left>&nbsp;"+paymentdate+"��ǰ����</td>";
  else{//���䶯���ڸ���
    if (state5) //��ǩԼ����
	 str+="<td align=left>&nbsp;ǩԼ��"+paymentdate+"���ڸ���</td>";
	else //���Ϲ�����
	 str+="<td align=left >&nbsp;�Ϲ���"+paymentdate+"���ڸ���</td>";
   }
 
    if (state1){//����ǹ̶����
      if (state4){//¥��
	    if (state3)
		 str+="<td align=left  >&nbsp;"+aa+"(��������)"+scale+"</td>";
		else 
		str+="<td align=left  >&nbsp;"+aa+""+scale+"</td>";
	  }else{//����
        str+="<td align=left  >&nbsp;����"+scale+"</td>";
	  } 
    }else{
	  if (state3){
	   if (SaleSumPrice.equals("1"))
         str+="<td align=left  >&nbsp;"+aa+"(��������)��"+scale+"%</td>";
	   else
	     str+="<td align=left>&nbsp;"+aa+"(��������)��"+scale+"%("+formatD1.getFloat3(Double.parseDouble(SaleSumPrice)*scale/100,0)+"Ԫ)</td>";
	  }else{
        if (SaleSumPrice.equals("1"))
	     str+="<td align=left  >&nbsp;"+aa+"��"+scale+"%</td>";
		else
		 str+="<td align=left  >&nbsp;"+aa+"��"+scale+"%("+String.valueOf(Float.parseFloat(SaleSumPrice)*scale)+"Ԫ)</td>";
      } 
	}
  if (count==null)	{
  str+="<td  >&nbsp;";
   if (Cortrol==null){Cortrol="";}
  if (Cortrol.indexOf("E")>=0){ 
  str+="<a href='#' onclick=openwin('EditPayList.jsp?id="+String.valueOf(id)+"&payname="+payname+"&code="+code+"',480,300,100,100)>����</a>";
  }
  //str+="<a href='javascript:delPayment("+ String.valueOf(id)+")'>ɾ��</a>";
 // str+="<a href='#' onclick=openwin('PayList.jsp?id="+String.valueOf(id)+"&payname="+payname+"&paycode="+code+"&paynum="+paynum+"',480,300,100,100)>����</a>"; 
  str+="</td>";
  }
  str+="</tr> ";

 }
 
 paymentRS.close();
 return str;
}
%>
<%

//��������ָ�����ڰ�����������������,��Ϊ����
out.println(ShowPay("select id,num,paydate ,money as scale,state1,state2,state3,state4,state5  from PayDetail where payCode ="+code+" and  state1='1' and state2='0' and state3=0 order by num,PayDate",out,Cortrol));

//��������ָ�����ڰ�ָ�����ڼ����������
out.println(ShowPay("select id,num,convert(char(24),date,111) as paydate,money as scale,state1,state2,state3,state4,state5  from PayDetail where payCode ="+code+" and state1='1' and state2='1' order by num,PayDate",out,Cortrol));

//���������ٱȼ��㣬���ڰ�������������������
out.println(ShowPay("select id,num,PayDate ,scale,state1,state2,state3,state4,state5 from PayDetail where PayCode ="+code+" and state1='0' and state2='0' order by num,PayDate",out,Cortrol));

//���������ٱȼ��㣬���ڰ�ָ�����ڼ����������
out.println(ShowPay("select id,num,convert(char(24),date,111) as paydate, scale,state1,state2,state3,state4,state5  from PayDetail where payCode ="+code+" and  state1='0' and state2='1' order by num,PayDate",out,Cortrol));

//��������ָ�����ڰ�����������������,��Ϊ¥��
out.println(ShowPay("select id,num,paydate ,money as scale,state1,state2,state3,state4,state5  from PayDetail where payCode ="+code+" and  state1='1' and state2='0' and state3=1 order by num,PayDate",out,Cortrol));


  %>
   <tr><td colspan="4" align="right"><a href="#" onclick="openwin('PayList.jsp?paycode=<%=code %>&prePay=<%=request.getParameter("prePay") %>&payname=<%=payname  %>&paynum=<%=paynum %>&section=<%=request.getParameter("seccoe") %>',480,300,100,100);">���</a>&nbsp;&nbsp;</td>
   
   </tr> 
  </table>
 
</div>

</body>
</html>
