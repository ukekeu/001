<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>��ӡ�վ�</title>
</head>
 
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>
 
<%@ include file="../public_js/getByteOut.jsp"%>
<%!
 public String rep(String F){
	 String N=F;
	  
	    if (F.equals("Ҽ"))N="1";
		else if (F.equals("��"))N="2";	
		else if (F.equals("��"))N="3";		
		else if (F.equals("��"))N="4";	
	    else if (F.equals("��"))N="5";		
		else if (F.equals("½"))N="6";	
		else if (F.equals("��"))N="7";	
		else if (F.equals("��"))N="8";	
	    else if (F.equals("��"))N="9";
		else if (F.equals("��"))N="0";
		 
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
<%
 String   htno=getbyte1(request.getParameter("htno"));
String pr=getbyte1(request.getParameter("pr"));
  String zy=getbyte1(request.getParameter("zy"));
  String pr3=getbyte1(request.getParameter("pr2"));
  String handler=getbyte1(request.getParameter("handler"));

  if (!pr.equals("")){
 
         String cusName=getbyte1(request.getParameter( "customer" )) ;
        aBean.executeUpdate("update printsksj set context='"+zy+"',checker='"+handler+"' where customer='"+cusName+"'");
       if (!pr3.equals("")){
	     ResultSet rs=null;
	    rs=aBean.executeQuery("select *,year(sj_date) yy,month(sj_date) mm ,day(sj_date) dd from printsksj  where customer='"+cusName+"'");
	  
String tmpDoc = "printword.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/crm/jsp/finance/"+tmpDoc;
 if (rs.next()){
	 String p15=rs.getString("money1");
	String p10=rs.getString("r1");
	String p9=rs.getString("r0");
	String p8=rs.getString("r9");
	String p7=rs.getString("r8");
	String p6=rs.getString("r7");
	String p5=rs.getString("r6");
	String p4=rs.getString("r5");
	String p3=rs.getString("r4");
	String p2=rs.getString("r3");
	String p1=rs.getString("r2");
	
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
String yy=getbyte(rs.getString("yy"));

String txt=getbyte(rs.getString("txt"));
if (!yy.equals(""))yy=yy.substring(2,4);
else yy=" ";
 
 
if (!txt.equals(""))txt=txt.substring(txt.indexOf(":")+1);
else txt=" ";

sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"p1\" value=\""+yy+"\"/>");
sb.append("<bookmark name=\"p2\" value=\""+getbyte(rs.getString("mm"))+"\"/>");
sb.append("<bookmark name=\"p3\" value=\""+getbyte(rs.getString("dd"))+"\"/>");
sb.append("<bookmark name=\"p5\" value=\""+rs.getString("customer")+"\"/>");
sb.append("<bookmark name=\"p7\" value=\""+rep(p1)+"\"/>");
sb.append("<bookmark name=\"p4\" value=\""+txt+"\"/>");
sb.append("<bookmark name=\"p8\" value=\""+rep(p2)+"\"/>");
sb.append("<bookmark name=\"p9\" value=\""+rep(p3)+"\"/>");
sb.append("<bookmark name=\"p10\" value=\""+rep(p4)+"\"/>");
sb.append("<bookmark name=\"p11\" value=\""+rep(p5)+"\"/>");
sb.append("<bookmark name=\"p12\" value=\""+rep(p6)+"\"/>");
sb.append("<bookmark name=\"p13\" value=\""+rep(p7)+"\"/>");
sb.append("<bookmark name=\"p14\" value=\""+rep(p8)+"\"/>");
sb.append("<bookmark name=\"p15\" value=\""+p15+"\"/>");
sb.append("<bookmark name=\"p17\" value=\""+getbyte(rs.getString("payment"))+"\"/>");
sb.append("<bookmark name=\"p16\" value=\""+htno+"\"/>");
sb.append("<bookmark name=\"p19\" value=\""+rep(p10)+" \"/>");
sb.append("<bookmark name=\"p20\" value=\""+rep(p9)+" \"/>");
sb.append("<bookmark name=\"p6\" value=\""+rs.getString("context")+"\"/>");
sb.append("</document>");
out.println(sb.toString());
	   %>
	   <OBJECT ID="BookmarkRplr" CLASSID="CLSID:D5D79C43-201A-4064-93A5-8FA6F768DF9E"
CODEBASE="liwbr32.CAB#version=1,1,0,3"></OBJECT>

 
<div id="renderMessage">��������...</div>
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
<input type="submit" value="����������ݲ��ɹ����߳�ʱ��ͣ�٣������µ�������ť����..." onclick="execute();">
 <%rs.close();
 }}else{ %>
	<script>
	 
   window.location="<%=session.getAttribute("reportAddr")%>printSJ1.rpt";
</script>
 
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

  String ldSQL="SELECT F.contactno,C.signatory ,F.shouldMoney factmoney,F.rate CurrRate,F.curry CurrName"
         +" FROM GatheringRecord  F,customer C  "
		 +"WHERE C.serialno=F.cusno and F.contactno ='"+contractno+" ' and id="+rowID;
 
  ResultSet rs=null;
  String cusName="";
  String ldcurry="";
  String SKmoney="";
  String ldbillnum="";
  String ldrate="1";
  String ldperson="";
  String PayType="";
  String BillType="";
  String context="";
 
 try{
     rs=aBean.executeQuery(ldSQL);
	 
   if (rs.next()){
     cusName=getbyte(rs.getString("signatory"));
	 
	 SKmoney=rs.getString("factmoney");
	 ldrate=rs.getString("CurrRate");
	 ldcurry=getbyte(rs.getString("CurrName"));
 
	 
   }
    String curryDX="";
	 if (ldcurry.equals("��"))curryDX="�����";
	 if (ldcurry.equals("HKD"))curryDX="�۱�";
	 if (ldcurry.equals("USD"))curryDX="��Ԫ";
   rs.close();
   
   if (No.equals("0"))context="����";
   //else if (No.equals("1"))context="���ڿ�";
   else context="Ԥ�չ�����";
   
ResultSet execRs=null;
String upperMoney="";
execRs=aBean.executeQuery("exec dbo.L2U "+SKmoney+",1 ");//��д���ת���洢����
if (execRs.next())
upperMoney=getbyte(execRs.getString("dd"));
execRs.close();
 if (upperMoney.substring(0,1).equals("Ԫ"))
 upperMoney="��"+upperMoney;
String p1="",p2="",p3="",p4="",p5="",p6="",p7="",p8="",p9="",p10="";

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
   }	
  }   	  
   rs=aBean.executeQuery("select ContractNo from Order_Contract where code="+contractno);
   if (rs.next()){
     htno=rs.getString("ContractNo");
   }
   rs.close();
	String sjcontext="insert into printsksj(customer,payment,context,money1"
	  +",money2,rate,curr,txt,checker,r1,r2,r3,r4,r5,r6,r7,r8,r9,r0) values('"+cusName+"','"+PayType+"','"+context+"("+loft+")"
	  +"','"+upperMoney+"',"+SKmoney+","+ldrate+",'"+ldcurry+"',"
	  +"'"+BillType+"��:"+ldbillnum+"','"+(String)session.getAttribute("loginname")+"'"
	  +",'"+p1+"','"+p2+"','"+p3+"','"+p4+"','"+p5+"','"+p6+"','"+p7+"','"+p8+"','"+p9+"','"+p10+"')";
	  
   aBean.executeUpdate("delete printsksj where customer='"+cusName+"'");
   //out.print(sjcontext);
   aBean.executeUpdate(sjcontext);
  }catch(Exception s){out.print(s);}
  
 %>

<script>
//  window.location="<%=session.getAttribute("reportAddr")%>printSJ1.rpt";
</script>

<body>
<form name=frm method="post">
<input type=hidden name="customer" value="<%=cusName %>">
 <input type=hidden name="htno" value="<%=htno %>">
<center>
Ʊ��ժҪ:<input type=text name=zy size=50 value="<%=context+"("+loft+")" %>">
<br><br>
<br><br>
�����֡���:<input type=text name=handler size=50 value="<%=(String)session.getAttribute("loginname") %>">
<br><br>
<input type=hidden name="pr" value="ok">
<input type=hidden name="pr2" value="">

<input type=button name=pr1 value="��ӡ(Word)" onclick="document.frm.pr2.value='123';document.frm.submit();">
</center>
</form>
<%} %>

</html>

 