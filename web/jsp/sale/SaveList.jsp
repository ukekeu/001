<%@ page contentType="text/html;charset=GBK" %>
<html>
<%@ include file="../public_js/checktime.jsp"%>
<head>
     <OBJECT id=closes type="application/x-oleobject" classid="clsid:adb880a6-d8ff-11cf-9377-00aa003b7a11">
     <param name="Command" value="Close">
</object> 
</head>
<title>操作成功</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/news.css" rel=stylesheet>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="saveSellerBean" scope="page" class="ConnDatabase.SDatabase" />
  <%
  	 String modiStr = "";
	 String id=request.getParameter("id");
	 String de=China.getParameter(request,"de");//是否为具体日期
 	 String mo=China.getParameter(request,"mo");//是否为具体金额
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
     String djcheck=China.getParameter(request,"djcheck");//判断是否包括定金(1表示包括定金)
	 
	 String paytype=China.getParameter(request,"paytype");//判断是定金还是楼款(0表示定金)
	 if (paytype.equals(""))paytype="0";
	 String dateTj=China.getParameter(request,"dateTj");//判断是认购日期后还签约后付款日期(0表示认购日期起)
	 if (djcheck.equals(""))djcheck="0";
	 if (month.equals(""))month="0";
     String scale1="0";
	 String state1="1";//判断是否是按楼款%比付款还是固定金额(0表示百分付款)
	 String state2="1";//判断是否是按固定日期付款还是变动日期付款(0表示变动日期)
	 if (mo.equals("1")){scale1=scale;scale="0";state1="0";}//如果以百分付款
	 
     String paydate1="0";
	 String paydate =China.getParameter(request,"Date1");
	
 	 //如果按变动日期付款
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
		  		<script>alert("当前付款方式是多次付款!要注意调整好每次的付款比例");</script>
		  <%}
	}	
	if (para.equals("insert")) {
	    modiStr="select * from PayDetail where  payCode="+paycode+" and num="+paynum;
	

		ResultSet rs=saveSellerBean.executeQuery(modiStr);
		 
		if (rs.next())
		{
		   out.print("<script>");	
			out.print("alert('此期数("+payname+paynum+"期)已经输入，确认重新输入');");	
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
			out.print("alert('添加成功,继续输入');");	
			//out.print("opener.window.location.reload();");	
		   	out.print("window.close();");	
			
	    	out.print("</script>");	

		
		 payname= new String(payname.getBytes("ISO8859_1"),"GBK");
		}	
		else if (para.equals("modi")) 
			{
			out.print("<script>");	
			out.print("alert('更改成功');");	
            out.print("opener.window.location.reload();;");	
			out.print("window.close();");	
	    	out.print("</script>");	
		
			 }
		else if (para.equals("dele"))
			{out.println("删除成功");
			out.print("<script>");	
			out.print("alert('删除成功');");	
            out.print("window.location='PaymentList.jsp';");	
			//out.print("window.location.reload();");	
			out.print("</script>");	
			}
		else
			out.println("不明操作");				
	}catch(Exception ee) {
		out.println("操作失败，请重试或联系系统管理员");
		out.println(modiStr);
	}
	
		
  %>
  


</body>
</html>
