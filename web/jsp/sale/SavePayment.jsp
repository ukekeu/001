<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
<title>���渶���</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/news.css" rel=stylesheet>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="savepaymentBean" scope="page" class="ConnDatabase.SDatabase" />
  <%
  	 String modiStr = "";
	 String payment_oper = request.getParameter("payment_oper");
	 String id = request.getParameter("id");
	 String payName = China.getParameter(request,"PayName");
	  String section = China.getParameter(request,"section");
     String bank = China.getParameter(request,"bank");	
	 String cs = China.getParameter(request,"cs");	
     String datetype=China.getParameter(request,"datetype");	
	 String gddate=China.getParameter(request,"gddate");	
	 String year = China.getParameter(request,"year");	
	 if (payName.indexOf("��")>=0)	payName+="("+cs+"%)";
		 String paynum=request.getParameter("PayNum");
		 String exDate_year = request.getParameter("Date1");
		 String enDate_year = request.getParameter("Date2");
		 String discont = request.getParameter("Discont");
		 String prePay =request.getParameter("PrePay");
		 String Qdate =request.getParameter("Qdate");
     	 String AJdate =request.getParameter("AJdate");
		 String youhui =China.getParameter(request,"youhui");
		 if (youhui.equals(""))youhui="0";
		 String bak =China.getParameter(request,"bak");	
		 String exDate = exDate_year;//
		 String enDate = enDate_year ;//
	 //}
	
	 if (payment_oper.equals("modi"))  {

        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "�����" , 
                          "�޸�"
                        ) ;

	 	modiStr = "update payment set PayName='" + payName;
		modiStr = modiStr + "',ExDate='" + exDate + "',enDate='" ;
		modiStr = modiStr + enDate + "',Discont='" + discont+ "',PrePay=";
		modiStr=modiStr+prePay+",Qdate='"+Qdate+"',AJdate='"+AJdate+"'";
		modiStr=modiStr+",youhui="+youhui+",bak='"+bak+"'";
		if (datetype.equals("1"))modiStr+=",gddate='"+gddate+"'";
		else modiStr+=",gddate=null";
		modiStr = modiStr +  ",num="+paynum+" where id=" + id;
                String modiSQL="UPDATE  PayDetail SET MONEY="+prePay+" WHERE NUM=0 AND PAYCODE="+id;
                 savepaymentBean.executeUpdate(modiSQL);
	}	

	if (payment_oper.equals("insert")) {
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "����" , 
                          "�޸�"
                        ) ;

	    modiStr="select * from payment where PayName='"+payName+"'   and seccoe='"+section+"'";
	    ResultSet rs=savepaymentBean.executeQuery(modiStr);

		if(rs.next()){
		out.print("�˸�����Ѿ�����");
		%>
		<script>
		alert("�˸�����Ѿ�����");
		 window.history.back(1);
		
		</script>
		<%
		rs.close();
		out.close();
		} 
		rs.close();	
		modiStr = "insert into payment(seccoe,PayName,ExDate,EnDate,Discont,PrePay,num,youhui,bak,qdate,ajdate";
		if (datetype.equals("1"))modiStr+=",gddate)";
		else modiStr+=")";
		modiStr = modiStr + "values('" + section+"','"+payName + "','" + exDate + "','" ;
		modiStr = modiStr + enDate  + "','" + discont + "'," + prePay + ","+paynum+","+youhui+",'"+bak+"','";
		modiStr = modiStr + Qdate+"','"+AJdate+"'";
		if (datetype.equals("1"))modiStr+=",'"+gddate+"')";
		else modiStr+=")";
		
		
	}
	if (payment_oper.equals("dele")) {
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "�����" , 
                          "ɾ��"
                        ) ;
		modiStr = "delete payment where id=" + id;
	}	
 
	//out.println(modiStr);	out.close();
	savepaymentBean.executeUpdate(modiStr);
	if (payment_oper.equals("insert")) 
		{out.println("��Ӹ�����ɹ�");
		out.print("&nbsp;&nbsp;���������");
		modiStr="select * from payment where PayName='"+payName+"' and num="+paynum +" and seccoe='"+section+"'";;
	    ResultSet rs1=savepaymentBean.executeQuery(modiStr);
		int payid=0;
		if(rs1.next()){
		  payid=rs1.getInt("ID");
		}
		rs1.close();
		if (!cs.equals(""))cs=String.valueOf(100-Integer.parseInt(cs));
		    out.print("<script>");	
			out.print("alert('��������ϸ');");	
            out.print("window.location='PayList.jsp?paycode="+payid+"&payname="+payName+"&paynum="+paynum+"&cs="+cs+"&prePay="+prePay+"&section="+section+"';");	
	    	out.print("</script>");	
	
		}
	   else if (payment_oper.equals("modi")) 
		{out.println("���ĳɹ�");

			out.print("<script>");	
			out.print("alert('���ĳɹ�');");	
            out.print("opener.window.location.reload();");	
			out.print("close();");	
			out.print("</script>");	
        }
    else if (payment_oper.equals("dele"))
		{out.println("ɾ���ɹ�");
		  savepaymentBean.executeUpdate("delete PayDetail where paycode=" + id);
			out.print("<script>");	
			out.print("alert('ɾ���ɹ�');");	
            out.print("window.location='PaymentList.jsp?section="+section+"';");	
			out.print("</script>");	
		}
	else
		{out.println("��������");				
    	%>
		<script>
		alert("��������");
		 window.history.back(1);
		
		</script>
		<%
		}
  %>
  <script></script>
</body>
</html>
