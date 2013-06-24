<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>打印收据</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>
 
<%@ include file="../public_js/getByteOut.jsp"%>
<%!
  public String rep(String F){
	 String N=F;
	  
	    if (F.equals("壹"))N="1";
		else if (F.equals("贰"))N="2";	
		else if (F.equals("叁"))N="3";		
		else if (F.equals("肆"))N="4";	
	    else if (F.equals("伍"))N="5";		
		else if (F.equals("陆"))N="6";	
		else if (F.equals("柒"))N="7";	
		else if (F.equals("捌"))N="8";	
	    else if (F.equals("玖"))N="9";
		else if (F.equals("零"))N="0";
		else if (F.equals("零"))N="0";
				 
	return N;
	}		
  public String Repalce2(String str,String str1) throws Exception  {
      String disnum=str.trim();
	  String discnum="";
	  int num=0;
	  int num1=0;
	  String arry[]=new String[15];
	  boolean sss=false;
	  for (int n=0;n<disnum.length();n++)//
	  {
	     if (disnum.substring(n,n+1).equals(str1)){
		 sss=true;
		 arry[num]=disnum.substring(num1,n).trim()+"    ";
		 num1=n+1;
		 num++;
		 if (!disnum.substring(n+1).equals(str1))
		 {arry[num]=disnum.substring(n+1).trim();}
		}
	  }
	  disnum="";
	  for (int n1=0;n1<=num;n1++)
	  {
	    if (arry[n1]!=null){
		if (disnum.equals(""))disnum=arry[n1];
		else disnum+=arry[n1];
		}
	  }
	  if (!sss)disnum=str.trim();
	  
   return disnum;
  } 
   %>
<% String htno="";
String pr=getbyte1(request.getParameter("pr"));
  String zy=getbyte1(request.getParameter("zy"));
    String pr3=getbyte1(request.getParameter("pr2"));
	  htno=getbyte1(request.getParameter("htno"));
	
  String handler=getbyte1(request.getParameter("handler"));
  if (!pr.equals("")){
        String contractno=getbyte1(request.getParameter( "contractno" )) ;
        String cusName=getbyte1(request.getParameter( "customer" )) ;
		 
		
        aBean.executeUpdate("update printsksj set context='"+zy+"',checker='"+handler+"' where customer='"+cusName+"'");
        if (!pr3.equals("")){
	    ResultSet rs=null;
		String customer="",phone="",jzarea="",room="",c_payment="";
		 

String   sqlld="select a.*,b.cus_name,c.area jzarea,c.room_code room,a.tel+' '+a.sj phone from  SL_TemporarilyBuy a,customer b,room c where a.roomcode=c.code and b.serialno=a.cusname and  a.roomcode="+htno;
rs=aBean.executeQuery(sqlld);
		 if (rs.next()){
		  customer= rs.getString("cus_name");
		  phone= rs.getString("phone");
		  jzarea= rs.getString("jzarea");
		  room= rs.getString("room");
		  c_payment= rs.getString("payment");
		 }
		 rs.close();
	    rs=aBean.executeQuery("select *,year(sj_date) yy,month(sj_date) mm ,day(sj_date) dd,txt from printsksj  where customer='"+cusName+"'");
	   String loft=getbyte1(request.getParameter("loft"));
String tmpDoc = "sksj.doc";

String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/zlcrm/jsp/finance/"+tmpDoc;
 if (rs.next()){
    String p15=rs.getString("money2");
	String p10=rs.getString("r0");
 
	String p9=rs.getString("r1");
	 String p8="";//rs.getString("r9");
	 String p7="";//rs.getString("r8");
	String p6=rs.getString("r2");
	String p5=rs.getString("r3");
	String p4=rs.getString("r4");
	String p3=rs.getString("r5");
	String p2=rs.getString("r6");
	String p1=rs.getString("r7");
	 
if (p10.equals(""))p10=" ";
if (p9.equals(""))p9=" ";
if (p8.equals(""))p8=" ";
if (p7.equals(""))p7=" ";
if (p6.equals(""))p6=" ";
if (p5.equals(""))p5=" ";
if (p4.equals(""))p4=" ";
if (p3.equals(""))p3=" ";
if (p2.equals(""))p2=" ";
if (p1.equals(""))p1=" ";
if (htno.equals(""))htno=" ";
StringBuffer sb = new StringBuffer();
String yy=rs.getString("yy");

String txt=getbyte(rs.getString("txt"));
String zdr=getbyte(rs.getString("checker"));
String payment=getbyte(rs.getString("payment"));

String curr=getbyte(rs.getString("curr"));
String payment1=" ",payment2=" ",payment3=" ",payment4=" ";
String rmbprice=" ",hkprice=" ";
out.println(curr);
if (curr.equals("RMB")){
   rmbprice=p15;
   if (payment.indexOf("现")>=0)payment2="√";
   else payment1="√";
}else{
    hkprice=p15;
 if (payment.indexOf("现")>=0)payment3="√";
   else payment4="√";
}
yy=yy;//.substring(2,4);
if (!txt.equals(""))txt=txt.substring(txt.indexOf(":")+1);
else txt=" ";
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"a1\" value=\""+yy+"\"/>");
sb.append("<bookmark name=\"a2\" value=\""+rs.getString("mm")+"\"/>");
sb.append("<bookmark name=\"a3\" value=\""+rs.getString("dd")+"\"/>");
String b1=" ",b2=" ",b3=" ",b4=" ",b5=" ",b6=" ",b7="",b8="",b9="";
 StringTokenizer st22 = new StringTokenizer(customer,"/") ;
		int count22 = st22.countTokens() ;
		int ii=0;
		while (st22.hasMoreElements()) {
			if (ii==0)b1=(String)st22.nextElement();
			else if (ii==1)b2=(String)st22.nextElement();
			else if (ii==2)b3=(String)st22.nextElement();
			ii++;
			}
StringTokenizer st23 = new StringTokenizer(phone,"/") ;
		int count23 = st23.countTokens() ;
		  ii=0;
		while (st23.hasMoreElements()) {
			if (ii==0)b4=(String)st23.nextElement();
			else if (ii==1)b5=(String)st23.nextElement();
			else if (ii==2)b6=(String)st23.nextElement();
			ii++;
			}
if (c_payment.indexOf("一次")>=0){b7="√";b8=" ";b9=" ";}
else 	if (c_payment.indexOf("按")>=0){b8="√";b7=" ";b9=" ";;}
else 	if (c_payment.indexOf("一次")>=0){b9="√";;b8=" ";b7=" ";}
		
		
sb.append("<bookmark name=\"b1\" value=\""+b1+"\"/>");
sb.append("<bookmark name=\"b2\" value=\""+b2+"\"/>");
sb.append("<bookmark name=\"b3\" value=\""+b3+"\"/>");
sb.append("<bookmark name=\"b4\" value=\""+room+"\"/>");
sb.append("<bookmark name=\"b5\" value=\""+jzarea+"\"/>");
sb.append("<bookmark name=\"b6\" value=\""+b4+"\"/>");
sb.append("<bookmark name=\"b7\" value=\""+b5+"\"/>");

sb.append("<bookmark name=\"c1\" value=\""+b7+"\"/>");
sb.append("<bookmark name=\"c2\" value=\""+b8+"\"/>");
sb.append("<bookmark name=\"c3\" value=\""+b9+"\"/>");

sb.append("<bookmark name=\"d1\" value=\""+payment1+"\"/>");
sb.append("<bookmark name=\"d2\" value=\""+payment2+"\"/>");
sb.append("<bookmark name=\"d3\" value=\""+rmbprice+"\"/>");
sb.append("<bookmark name=\"d5\" value=\""+payment3+"\"/>");
sb.append("<bookmark name=\"d6\" value=\""+payment4+"\"/>");
sb.append("<bookmark name=\"d7\" value=\""+hkprice+"\"/>");
 
sb.append("<bookmark name=\"e1\" value=\""+p10+"\"/>");
sb.append("<bookmark name=\"e2\" value=\""+p9+"\"/>");
sb.append("<bookmark name=\"e3\" value=\""+p6+"\"/>");
sb.append("<bookmark name=\"e4\" value=\""+p5+"\"/>");
sb.append("<bookmark name=\"e5\" value=\""+p4+"\"/>");
sb.append("<bookmark name=\"e6\" value=\""+p3+"\"/>");
sb.append("<bookmark name=\"e7\" value=\""+p2+"\"/>");
sb.append("<bookmark name=\"e8\" value=\""+p1+"\"/>");

 sb.append("<bookmark name=\"no\" value=\""+txt+"\"/>");
 
sb.append("<bookmark name=\"e10\" value=\""+(String)session.getAttribute("loginname")+" \"/>");

sb.append("<bookmark name=\"e9\" value=\""+rs.getString("context")+"\"/>");
sb.append("</document>");
out.println(sb.toString());
	   %>
	   <OBJECT ID="BookmarkRplr" CLASSID="CLSID:D5D79C43-201A-4064-93A5-8FA6F768DF9E"
CODEBASE="liwbr32.CAB#version=1,1,0,3"></OBJECT>

 
<div id="renderMessage">正在下载...</div>
<script event="onload" for="window">
	execute();
	//window.close();
</script>
<script language="javascript">
function execute(){
    BookmarkRplr.XMLString='<%=sb.toString()%>';
	BookmarkRplr.execute();
	while (BookmarkRplr.Busy){
		document.all.renderMessage.innerHTML = BookmarkRplr.Message;
	}
	document.all.renderMessage.innerHTML = BookmarkRplr.Message;
	//location.href="?"
}

</script>
<input type="submit" value="如果下载数据不成功或者长时间停顿，请重新点击这个按钮尝试..." onclick="execute();">
 
	<%
	rs.close();
	}}else{ 
 
	%>
	 
 
	   <%

 }
 
  }else{

   String No=getbyte1(request.getParameter("no"));
  String CusNo=getbyte1(request.getParameter("CusNo"));
  String contractno=getbyte1(request.getParameter("contractno"));
  String rowID = getbyte1(request.getParameter( "rowID") ) ;
  String loft=getbyte1(request.getParameter( "loft" )) ;
 
  if (No==null){No="";}
  if (CusNo==null){CusNo="";}


  ResultSet rs=null;
  String cusName="";
  String ldcurry="";
  String SKmoney="";
  String ldbillnum="";
  String ldrate="";
  String ldperson="";
  String PayType="";
  String BillType="";
  String context="";
  String Gather_Date="";
  
String ldSQL="select SL_TemporarilyBuy.*,customer.signatory from  SL_TemporarilyBuy,customer where customer.serialno=SL_TemporarilyBuy.cusname and  roomcode="+rowID ;
 
  try{
     rs=aBean.executeQuery(ldSQL);
	
    
   if (rs.next()){
     Gather_Date=getbyte(rs.getString("fact_date"));
	 if (Gather_Date.equals(""))Gather_Date=Gather_Date.substring(0,10);
     cusName=getbyte(rs.getString("signatory"));
	 PayType=getbyte(rs.getString("PayType"));
	 if (PayType.equals("0"))PayType="现金";
     if (PayType.equals("1"))PayType="支票";
	 if (PayType.equals("2"))PayType="pos机";
	 if (PayType.equals("3"))PayType="收款单";
	 SKmoney=rs.getString("fact_dj");
	 ldrate=rs.getString("rate");
	 ldcurry=getbyte(rs.getString("curr"));
	 ldbillnum=getbyte(rs.getString("bill_num"));
	 BillType=getbyte(rs.getString("BillType"));
	 if (BillType.equals("0"))BillType="收据";
	 if (BillType.equals("1"))BillType="发票";
   }
    String curryDX="";
	 if (ldcurry.equals("RMB"))curryDX="人民币";
	 if (ldcurry.equals("HKD"))curryDX="港币";
	 if (ldcurry.equals("USD"))curryDX="美元";
   rs.close();
     context="预收临时定金"+No;
if (SKmoney.indexOf("-")>=0) SKmoney=SKmoney.substring(SKmoney.indexOf("-")+1);   
ResultSet execRs=null;
String upperMoney="";
execRs=aBean.executeQuery("exec dbo.L2U "+SKmoney+",1 ");//大写金额转换存储过程
if (execRs.next())
upperMoney=getbyte(execRs.getString("dd"));
execRs.close();
if (upperMoney.substring(0,1).equals("元"))
 upperMoney="零"+upperMoney;

 

String p0="",p1="",p2="",p3="",p4="",p5="",p6="",p7="",p8="",p9="",p10="";
 
for (int i=0;i<upperMoney.length();i++){
  String rmb=upperMoney.substring(i,i+1);

   i++;
   if (upperMoney.length()==2)
   {
      if (i==1)p9=rmb;
	  p8=ldcurry;
     }else if (upperMoney.length()==5){
	  if (i==2)p8=rmb;
      else if (i==4)p9=rmb;
	  p7=ldcurry;
	}else if (upperMoney.length()==6){
	  if (i==1)p7=rmb;
      else if (i==3)p8=rmb;
	  else if (i==5)p9=rmb;
	   p6=ldcurry;
	}else if (upperMoney.length()==8){
	  if (i==1)p6=rmb;
      else if (i==3)p7=rmb;
	  else if (i==5)p8=rmb;
	  else if (i==7)p9=rmb;
	   p5=ldcurry;
	}else if (upperMoney.length()==10){
	  if (i==1)p5=rmb;
      else if (i==3)p6=rmb;
	  else if (i==5)p7=rmb;
	  else if (i==7)p8=rmb;
	  else if (i==9)p9=rmb;
	   p4=ldcurry;
	}else if (upperMoney.length()==12){
	
	  if (i==1)p4=rmb;
      else if (i==3)p5=rmb;
	  else if (i==5)p6=rmb;
	  else if (i==7)p7=rmb;
	  else if (i==9)p8=rmb;
	   else if (i==11)p9=rmb;
	    p3=ldcurry;
	}else if (upperMoney.length()==14){
	
	  if (i==1)p3=rmb;
      else if (i==3)p4=rmb;
	  else if (i==5)p5=rmb;
	  else if (i==7)p6=rmb;
	  else if (i==9)p7=rmb;
	  else if (i==11)p8=rmb;
	  else if (i==13)p9=rmb;   
	   p2=ldcurry;
	}else if (upperMoney.length()==16){
	  if (i==1)p2=rmb;
      else if (i==3)p3=rmb;
	  else if (i==5)p4=rmb;
	  else if (i==7)p5=rmb;
	  else if (i==9)p6=rmb;
	  else if (i==11)p7=rmb;
	  else if (i==13)p8=rmb;     
	  else if (i==15)p9=rmb;   
	   p1=ldcurry;
   
   }else if (upperMoney.length()==18){
	  if (i==1)p1=rmb;
      else if (i==3)p2=rmb;
	  else if (i==5)p3=rmb;
	  else if (i==7)p4=rmb;
	  else if (i==9)p5=rmb;
	  else if (i==11)p6=rmb;
	  else if (i==13)p7=rmb;     
	  else if (i==15)p8=rmb;  
	  else if (i==17)p9=rmb;     
	  p10=ldcurry;
   }else if (upperMoney.length()==20){
	  if (i==1)p10=rmb;
      else if (i==3)p1=rmb;
	  else if (i==5)p2=rmb;
	  else if (i==7)p3=rmb;
	  else if (i==9)p4=rmb;
	  else if (i==11)p5=rmb;
	  else if (i==13)p6=rmb;     
	  else if (i==15)p7=rmb;  
	  else if (i==17)p8=rmb;    
	  else if (i==19)p9=rmb;
	 
	//  p10=ldcurry;
	   
   }	
  }   

	String sjcontext="insert into printsksj(customer,payment,context,money1"
	  +",money2,rate,curr,txt,checker,r1,r2,r3,r4,r5,r6,r7,r8,r9,r0,sj_date,out) values('"+cusName+"','"+PayType+"','"+context+"("+loft+")"
	  +"','"+upperMoney+"',"+SKmoney+","+ldrate+",'"+ldcurry+"',"
	  +"'"+BillType+"号:"+ldbillnum+"','"+(String)session.getAttribute("loginname")+"'"
	  +",'"+p1+"','"+p2+"','"+p3+"','"+p4+"','"+p5+"','"+p6+"','"+p7+"','"+p8+"','"+p9+"','"+p10+"','"+Gather_Date+"','"+htno+"')";
  
	
    aBean.executeUpdate("delete printsksj where convert(char(10),sj_date,120)<convert(char(10),getdate(),120)");  
  aBean.executeUpdate("delete printsksj where customer='"+cusName+"'");
 
   aBean.executeUpdate(sjcontext);
 }catch(Exception s){out.print(s);}
  
 %>



<body>

<form name=frm method="post">
<input type=hidden name="customer" value="<%=cusName %>">
 <input type=hidden name="htno" value="<%=rowID %>">
  <input type=hidden name="ldbillnum" value="<%=ldbillnum %>">

<center>
票据摘要:<input type=text name=zy size=50 value="<%=context+"("+loft+")" %>">
<br><br>
经　手　人:<input type=text name=handler size=50 value="<%=(String)session.getAttribute("loginname") %>">
<br><br>

<input type=hidden name="loft" value="<%=loft %>">
<input type=hidden name="pr" value="ok">
<input type=hidden name="pr2" value="">
<input type=hidden name="contractno" value="<%=contractno %>">
<input type=button name=pr1 value="打印(Word)" onclick="document.frm.pr2.value='123';document.frm.submit();">
</center>
<a href="../ocx/setup.exe">下载打印插件</a>
</form>
第一次打印前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>

<%} %>

</body>
</html>

 