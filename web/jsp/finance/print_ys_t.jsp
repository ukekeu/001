<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>打印收据(退款)</title>
</head>
 
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>
 
<%@ include file="../public_js/getByteOut.jsp"%>
<%!
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
<%
 
 String pr=getbyte1(request.getParameter("pr"));
  String zy=getbyte1(request.getParameter("zy"));
    String pr3=getbyte1(request.getParameter("pr2"));
 String handler=getbyte1(request.getParameter("handler"));
   String cusName1=getbyte1(request.getParameter( "customer1" )) ;
    String cusName=getbyte1(request.getParameter( "customer" )) ;
  if (!pr.equals("")){
 
        aBean.executeUpdate("update printsksj set context='"+zy+"',checker='"+handler+"',customer='"+cusName+"'  where customer='"+cusName1+"'");
        if (!pr3.equals("")){
	   ResultSet rs=null;
	    rs=aBean.executeQuery("select *,year(sj_date) yy,month(sj_date) mm ,day(sj_date) dd from printsksj  where customer='"+cusName+"'");
	  
String tmpDoc = "printword.doc";
String url = "http://image:8080/crm/jsp/finance/"+tmpDoc;
 if (rs.next()){
	String p10=rs.getString("r0");
	String p9=rs.getString("r9");
	String p8=rs.getString("r8");
	String p7=rs.getString("r7");
	String p6=rs.getString("r6");
	String p5=rs.getString("r5");
	String p4=rs.getString("r4");
	String p3=rs.getString("r3");
	String p2=rs.getString("r2");
	String p1=rs.getString("r1");
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
StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"yy\" value=\""+rs.getString("yy")+"\"/>");
sb.append("<bookmark name=\"mm\" value=\""+rs.getString("mm")+"\"/>");
sb.append("<bookmark name=\"dd\" value=\""+rs.getString("dd")+"\"/>");
sb.append("<bookmark name=\"kh\" value=\""+rs.getString("customer")+"\"/>");
sb.append("<bookmark name=\"p10\" value=\""+p10+"\"/>");

sb.append("<bookmark name=\"p9\" value=\""+p9+"\"/>");
sb.append("<bookmark name=\"p8\" value=\""+p8+"\"/>");
sb.append("<bookmark name=\"p7\" value=\""+p7+"\"/>");
sb.append("<bookmark name=\"p6\" value=\""+p6+"\"/>");
sb.append("<bookmark name=\"p5\" value=\""+p5+"\"/>");
sb.append("<bookmark name=\"p4\" value=\""+p4+"\"/>");
sb.append("<bookmark name=\"p3\" value=\""+p3+"\"/>");
sb.append("<bookmark name=\"p2\" value=\""+p2+"\"/>");
sb.append("<bookmark name=\"p1\" value=\""+p1+"\"/>");
sb.append("<bookmark name=\"p11\" value=\""+rs.getString("money2")+"\"/>");
sb.append("<bookmark name=\"zy\" value=\""+rs.getString("context")+"\"/>");
sb.append("</document>");
out.println(sb.toString());
	   %>
	   <OBJECT ID="BookmarkRplr" CLASSID="CLSID:D5D79C43-201A-4064-93A5-8FA6F768DF9E"
CODEBASE="liwbr32.CAB#version=1,1,0,3"></OBJECT>

 
<div id="renderMessage">正在下载...</div>
<script event="onload" for="window">
	execute();
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
 } }else{ %>
	<script>
	 
   window.location="<%=session.getAttribute("reportAddr")%>printSJ1.rpt";
</script>
 
	   <%

 }


  }else{
 
  String ld=getbyte1(request.getParameter( "ld" )) ;
    String No=getbyte1(request.getParameter("no"));
  String CusNo=getbyte1(request.getParameter("CusNo"));
  String contractno=getbyte1(request.getParameter("contractno"));
  String rowID = getbyte1(request.getParameter( "rowID") ) ;
  String loft=getbyte1(request.getParameter( "loft" )) ;
    ResultSet rs=null;
  String SQL="SELECT fzs  FROM LoftBuildCode WHERE secno+loft='"+ld+"'";    
rs=aBean.executeQuery(SQL);
if (rs.next()){cusName=rs.getString("fzs");}
  rs.close();
 

  if (No==null){No="";}
  if (CusNo==null){CusNo="";}
String ldSQL="SELECT F.contactno,C.signatory ,F.shouldMoney factmoney,F.rate CurrRate,F.curry CurrName"
         +" FROM GatheringRecord  F,customer C  "
		 +"WHERE C.serialno=F.cusno and F.contactno ='"+contractno+"' and id="+rowID;
 


  String ldcurry="";
  String SKmoney="";
  String ldbillnum="";
  String ldrate="";
  String ldperson="";
  String PayType="";
  String BillType="";
  String context="";
  try{
     rs=aBean.executeQuery(ldSQL);
	 
   if (rs.next()){
   
	   
   //  cusName=getbyte(rs.getString("signatory"));
     cusName="";
	 
	 SKmoney=rs.getString("factmoney");
	 ldrate=getbyte(rs.getString("CurrRate"));
	 ldcurry=getbyte(rs.getString("CurrName"));
	 
   }
    String curryDX="";
	 if (ldcurry.equals("￥"))curryDX="人民币";
	 if (ldcurry.equals("HKD"))curryDX="港币";
	 if (ldcurry.equals("USD"))curryDX="美元";
   rs.close();
   
   if (No.equals("0"))context="定金";
   //else if (No.equals("1"))context="首期款";
   else context="房款";
   
   
  SKmoney=SKmoney.substring(SKmoney.indexOf("-")+1);
ResultSet execRs=null;
String upperMoney="";
execRs=aBean.executeQuery("exec dbo.L2U "+SKmoney+",1 ");//大写金额转换存储过程
if (execRs.next())
upperMoney=getbyte(execRs.getString("dd"));
execRs.close();
 
String p1="",p2="",p3="",p4="",p5="",p6="",p7="",p8="",p9="",p10="";

for (int i=0;i<upperMoney.length();i++){
  String rmb=upperMoney.substring(i,i+1);
  
   i++;
   if (upperMoney.length()==2)
   {
      if (i==1)p9=rmb;
	  p8="￥";
    }else if (upperMoney.length()==4){
	  if (i==1)p8=rmb;
      else if (i==3)p9=rmb;
	  p7="￥";
	}else if (upperMoney.length()==6){
	  if (i==1)p7=rmb;
      else if (i==3)p8=rmb;
	  else if (i==5)p9=rmb;
	   p6="￥";
	}else if (upperMoney.length()==8){
	  if (i==1)p6=rmb;
      else if (i==3)p7=rmb;
	  else if (i==5)p8=rmb;
	  else if (i==7)p9=rmb;
	   p5="￥";
	}else if (upperMoney.length()==10){
	  if (i==1)p5=rmb;
      else if (i==3)p6=rmb;
	  else if (i==5)p7=rmb;
	  else if (i==7)p8=rmb;
	  else if (i==9)p9=rmb;
	   p4="￥";
	}else if (upperMoney.length()==12){
	
	  if (i==1)p4=rmb;
      else if (i==3)p5=rmb;
	  else if (i==5)p6=rmb;
	  else if (i==7)p7=rmb;
	  else if (i==9)p8=rmb;
	   else if (i==11)p9=rmb;
	    p3="￥";
	}else if (upperMoney.length()==14){
	 
	  if (i==1)p3=rmb;
      else if (i==3)p4=rmb;
	  else if (i==5)p5=rmb;
	  else if (i==7)p6=rmb;
	  else if (i==9)p7=rmb;
	  else if (i==11)p8=rmb;
	  else if (i==13)p9=rmb;   
	   p2="￥";
	}else if (upperMoney.length()==16){
	  if (i==1)p2=rmb;
      else if (i==3)p3=rmb;
	  else if (i==5)p4=rmb;
	  else if (i==7)p5=rmb;
	  else if (i==9)p6=rmb;
	  else if (i==11)p7=rmb;
	  else if (i==13)p8=rmb;     
	  else if (i==15)p9=rmb;   
	   p1="￥";
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
	  p10="￥";
   }	
  }   	
    
 SQL="SELECT developcom  FROM crm_project WHERE SerialNo='"+request.getParameter("section")+"'";    
rs=aBean.executeQuery(SQL);
if (rs.next()){cusName=rs.getString("developcom");}
  rs.close();
 
	String sjcontext="insert into printsksj(customer,payment,context,money1"
	  +",money2,rate,curr,txt,checker,r1,r2,r3,r4,r5,r6,r7,r8,r9,r0,sj_date) values('"+cusName+"','"+PayType+"','"+context+"("+loft+")结算款"
	  +"','"+upperMoney+"',"+SKmoney.substring(SKmoney.indexOf("-")+1)+","+ldrate+",'"+ldcurry+"',"
	  +"'"+BillType+"号:"+ldbillnum+"','"+(String)session.getAttribute("loginname")+"'"
	   +",'"+p1+"','"+p2+"','"+p3+"','"+p4+"','"+p5+"','"+p6+"','"+p7+"','"+p8+"','"+p9+"','"+p10+"',getdate())";
  aBean.executeUpdate("delete printsksj where customer='"+cusName+"'");
   aBean.executeUpdate(sjcontext);
 
   aBean.executeUpdate(sjcontext);
  }catch(Exception s){ out.print(s);}
  
 %>

<script>
  //window.location="<%=session.getAttribute("reportAddr")%>printSJ.rpt";
</script>

<body>

<form name=frm method="post">
<input type=hidden name="customer1" value="<%=cusName %>">
<center>
票据摘要:<input type=text name=zy size=50 value="<%="收回"+loft+context %>">
<br><br>
<br><br>
经　手　人:<input type=text name=handler size=50 value="<%=(String)session.getAttribute("loginname") %>">
<br><br>
公司名称:<input type=text name=customer size=50 value="<%=cusName%>">
<br>
<input type=hidden name="pr2" value="">
<input type=hidden name="pr" value="ok">
<input type=button name=prp value="打 印" onclick="document.frm.submit();"><input type=button name=pr1 value="打印(Word)" onclick="document.frm.pr2.value='123';document.frm.submit();">
</center>
</form>

<%} %>
</body>
</html>

 