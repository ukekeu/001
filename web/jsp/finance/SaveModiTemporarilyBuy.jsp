<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "修改临订" , 
                  "修改"
                ) ;
%>

<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<%!
	public String getParameter(javax.servlet.http.HttpServletRequest request,String para)
								throws Exception  {
		String temp = "";
		temp = request.getParameter(para);
		if (temp == null)
			temp = "";
		temp = new String(temp.getBytes("ISO8859_1"),"GBK");
		return temp;	
	}
%>
<%  String SecNo=getParameter(request,"SecNo");
String SecName=getParameter(request,"SecName");
   /* String jzarea=getParameter(request,"jzarea");
    String SecNa=getParameter(request,"SecNa");
	String Loft = getParameter(request,"Loft");
	String Build = getParameter(request,"Build");
	String RoomNo = getParameter(request,"RoomNo");
	*/
	String factDate=getParameter(request,"factDate");
	String factdj=getParameter(request,"factdj");
	String change=getParameter(request,"change");
String ldcurry=getParameter(request,"curry");
	String ldbillnum=getParameter(request,"billnum");
	String ldrate=getParameter(request,"rate");
	String LDID= getParameter(request,"LDID");
	String cardid = getParameter(request,"cardid");
	String saleprice = getParameter(request,"saleprice");
	String Date1 = getParameter(request,"Date1");
    String Date2 = getParameter(request,"Date2");
	String code = getParameter(request,"code");
	String codeold = getParameter(request,"codeold");
	String CUSNAME = getParameter(request,"cusname");
	String CUSNAME1 = getParameter(request,"cusname1");//客户姓名
	String TEL = getParameter(request,"tel");
        String billnum=getParameter(request,"billnum");
	String SJ = getParameter(request,"sj");
	String BBJ = getParameter(request,"bbj");
	String Subscription = getParameter(request,"dj");
	String StrSql="";		
	String StrSql1="";		
	String user=getParameter(request,"seller");
	String PayType=getParameter(request,"PayType");
	String context=getParameter(request,"context");
	String tk=getParameter(request,"tk");
	String tkDate1=getParameter(request,"tkDate1");
	String tk1=getParameter(request,"tk1");
	String tkDate2=getParameter(request,"tkDate2");
  String curryDX="";
  
	if (ldcurry.equals("RMB"))curryDX="人民币";
	if (ldcurry.equals("HKD"))curryDX="港币";
	if (ldcurry.equals("USD"))curryDX="美元";
	StrSql = "update SL_TemporarilyBuy set ";
 
 
	StrSql +=" fact_dj="+factdj+",Receiver='"+user+"'";
	StrSql +=",fact_date='"+factDate+"',remark='"+context+"'";
	 StrSql+=",curr='"+ldcurry+"',rate="+ldrate;
		    StrSql+=",tk="+tk+",tk1="+tk1;
	 if (!tkDate1.equals(""))		
		 StrSql+=",tk_date='"+tkDate1+"'";
	else StrSql+=",tk_date=null";	 
	 if (!tkDate2.equals(""))		
		 StrSql+=",tk_date1='"+tkDate2+"'";
	else 	 
	StrSql+=",tk_date1=null";
	 
	StrSql +=" ,PayType='"+ PayType +"',bill_num='"+billnum+"'  where id="+LDID;
	try {
	 
	 aBean.executeUpdate(StrSql);
	 
    }catch(Exception ee) {
		out.print(ee+"用户添加失败，可能ID号相同了，请重新输入或联系系统管理员");
        out.close();
	} 
	
 
	 
%>
<script>
alert("系统已接受修改");
opener.document.forms[0].submit();
window.close();
</script>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
