<%@ page contentType="text/html;charset=GBK" %>
<html>
<%@ include file="../public_js/checktime.jsp"%>
<head>
     <OBJECT id=closes type="application/x-oleobject" classid="clsid:adb880a6-d8ff-11cf-9377-00aa003b7a11">
     <param name="Command" value="Close">
</object> 
</head>
<title>�����ɹ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/news.css" rel=stylesheet>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="saveSellerBean" scope="page" class="ConnDatabase.SDatabase" />
  <%
  	 String modiStr = "";
	 String id=request.getParameter("id");
	 String de=China.getParameter(request,"de");//�Ƿ�Ϊ��������
 	 String mo=China.getParameter(request,"mo");//�Ƿ�Ϊ������
 	 String para=China.getParameter(request,"para");
	 String paycode =China.getParameter(request,"paycode");
	 String paynum = China.getParameter(request,"paynum");
	 String scale = China.getParameter(request,"money");
	 String scale2 = China.getParameter(request,"money1");

	 if (scale.equals("")||scale.equals("0"))scale=scale2;
	 String section=request.getParameter("section");
	 String month = China.getParameter(request,"month");
	 String day = China.getParameter(request,"day");
	 String payname=request.getParameter("payname");
     String djcheck=China.getParameter(request,"djcheck");//�ж��Ƿ��������(1��ʾ��������)
	 
	 String paytype=China.getParameter(request,"paytype");//�ж��Ƕ�����¥��(0��ʾ����)
	 if (paytype.equals(""))paytype="0";
	 String dateTj=China.getParameter(request,"dateTj");//�ж����Ϲ����ں�ǩԼ�󸶿�����(0��ʾ�Ϲ�������)
	 if (djcheck.equals(""))djcheck="0";
	 if (month.equals(""))month="0";
     String scale1="0";
	 String state1="1";//�ж��Ƿ��ǰ�¥��%�ȸ���ǹ̶����(0��ʾ�ٷָ���)
	 String state2="1";//�ж��Ƿ��ǰ��̶����ڸ���Ǳ䶯���ڸ���(0��ʾ�䶯����)
	 if (mo.equals("1")){scale1=scale;scale="0";state1="0";}//����԰ٷָ���
	 
     String paydate1="0";
	 String paydate =China.getParameter(request,"Date1");
	
 	 //������䶯���ڸ���
	 if (de.equals("0")){paydate1=String.valueOf(Integer.parseInt(month)*30+Integer.parseInt(day));state2="0";}
	 String note=China.getParameter(request,"note");

	 if (para.equals("modi"))  {
	
	 	modiStr = "update PayDetail set num=" +paynum+",money="+scale+",state3="+djcheck;
		modiStr = modiStr + ",PayDate=" + paydate1 + ",scale=" ;
		modiStr = modiStr + scale1 + ",note='" + note + "',state1="+state1+",state2="+state2+",Date='"+paydate+"'";
		modiStr = modiStr +" where id="+ id;
		String modiStr1="select max(num) as num from PayDetail  where paycode="+paycode;
		  String paysql="update payment set PrePay="+scale +" where id="+paycode;
                saveSellerBean.executeUpdate(paysql);  
               
               ResultSet rsnum=saveSellerBean.executeQuery(modiStr1);
		int num=0;
              
		if (rsnum.next()){num=rsnum.getInt("num");}
		rsnum.close();
		 
		  if (num>2){%>
		  		<script>alert("��ǰ���ʽ�Ƕ�θ���!Ҫע�������ÿ�εĸ������");</script>
		  <%}
	}	
	if (para.equals("insert")) {
	    modiStr="select * from PayDetail where  payCode="+paycode+" and num="+paynum;
	

		ResultSet rs=saveSellerBean.executeQuery(modiStr);
		 
		if (rs.next())
		{
		   out.print("<script>");	
			out.print("alert('������("+payname+paynum+"��)�Ѿ����룬ȷ����������');");	
            out.print("window.close();");	
		   	out.print("</script>");	

		 rs.close();
		 return ;
		}
		rs.close();
		if (Integer.parseInt(paynum)>1)paynum="1";
		modiStr = "insert into PayDetail(PayCode,num,PayDate,scale,note,state1,state2,Date,money,state3,state4,state5) ";
		modiStr = modiStr + "values(" + paycode + "," + paynum + "," ;
		modiStr = modiStr + paydate1 + "," +scale1 + ",'" +note + "','"+state1+"','"+state2+"','"+paydate+"',"+scale+","+djcheck+","+paytype+","+dateTj+")";
	}
	
	if (para.equals("dele")) {
		
		modiStr = "delete PayDetail where id=" + id;
		
	}	
	
	try {
		saveSellerBean.executeUpdate(modiStr);
		if (para.equals("insert")) 
		{
		    out.print("<script>");	
			out.print("alert('��ӳɹ�,��������');");	
			//out.print("opener.window.location.reload();");	
		   	out.print("window.close();");	
			
	    	out.print("</script>");	

		
		 payname= new String(payname.getBytes("ISO8859_1"),"GBK");
		}	
		else if (para.equals("modi")) 
			{
			out.print("<script>");	
			out.print("alert('���ĳɹ�');");	
            out.print("opener.window.location.reload();;");	
			out.print("window.close();");	
	    	out.print("</script>");	
		
			 }
		else if (para.equals("dele"))
			{out.println("ɾ���ɹ�");
			out.print("<script>");	
			out.print("alert('ɾ���ɹ�');");	
            out.print("window.location='PaymentList.jsp';");	
			//out.print("window.location.reload();");	
			out.print("</script>");	
			}
		else
			out.println("��������");				
	}catch(Exception ee) {
		out.println("����ʧ�ܣ������Ի���ϵϵͳ����Ա");
		out.println(modiStr);
	}
	
		
  %>
  


</body>
</html>
