<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

 <%@ include file="../public_js/getByteOut.jsp"%>
<HTML>
<HEAD>
<TITLE>保存修改</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
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
<%  String SecNo=getbyte2(request.getParameter("SecNo"));
	String SecName=getbyte2(request.getParameter("SecName"));
    
	String change=getbyte2(request.getParameter("change"));
	String ldcurry=getbyte2(request.getParameter("curry"));
	String ldbillnum=getbyte2(request.getParameter("billnum"));
	String ldrate=getbyte2(request.getParameter("rate"));
	if (ldrate.equals(""))ldrate="1";
	String LDID= getbyte2(request.getParameter("LDID"));
	String cardid = getbyte2(request.getParameter("cardid"));
	String saleprice = getbyte2(request.getParameter("saleprice"));
	String Date1 = getbyte2(request.getParameter("Date1"));
    String Date2 = getbyte2(request.getParameter("Date2"));
	String code = getbyte2(request.getParameter("code"));
	String codeold = getbyte2(request.getParameter("codeold"));
	String CUSNAME = getbyte2(request.getParameter("cusname"));
	String CUSNAME1 = getbyte2(request.getParameter("cusname1"));//客户姓名
		String pay=getbyte2(request.getParameter("pay"));
	 if (ldrate.equals(""))ldrate="1";
	pay=pay.substring(0,pay.indexOf("-"));
	String disc=getbyte2(request.getParameter("disc"));
	String TEL = getbyte2(request.getParameter("tel"));
        String billnum=getbyte2(request.getParameter("billnum"));
	String SJ = getbyte2(request.getParameter("sj"));
	String BBJ = getbyte2(request.getParameter("bbj"));
	String Subscription = getbyte2(request.getParameter("dj"));
	String StrSql="";		
	String StrSql1="";		
	 
	
	 String  [] sells=request.getParameterValues("seller");
   String sell1="";
   String sell2="";
   if (sells!=null){
   if (sells.length==1){
     sell1=sells[0].trim();
	 }else if (sells.length>1){
	  sell1=sells[0].trim();
     sell2=sells[1].trim();
     }
 }
   String user="";
          if (!sell1.equals("")&&!sell2.equals("")){
	 	  sell1=new String(sell1.getBytes("ISO8859_1"),"GBK");
		  sell2=new String(sell2.getBytes("ISO8859_1"),"GBK");
		   user=sell1.trim()+"/"+sell2.trim();
		  }else{
		  sell1=new String(sell1.getBytes("ISO8859_1"),"GBK");
		  sell2="";
		   user=sell1;
		  }
	String PayType=getbyte2(request.getParameter("PayType"));
	String context=getbyte2(request.getParameter("context"));
	String tk=getbyte2(request.getParameter("tk"));
	if (tk.equals(""))tk="0";
	String tkDate1=getbyte2(request.getParameter("tkDate1"));
	String tk1=getbyte2(request.getParameter("tk1"));
		if (tk1.equals(""))tk1="0";
	String tkDate2=getbyte2(request.getParameter("tkDate2"));
	String cus_name_no=getbyte2(request.getParameter("cus_name_no"));
  String curryDX="";
  if(!change.equals(""))
	{
	 String changesql="update room set salestate=1 where code="+codeold;
	 String changesql2="update room set salestate=5 where code="+code;
	 aBean.executeUpdate(changesql);
	 aBean.executeUpdate(changesql2);
	}
	if (ldcurry.equals(""))ldcurry="RMB";
	if (ldcurry.equals("RMB"))curryDX="人民币";
	else if (ldcurry.equals("HKD"))curryDX="港币";
	else if (ldcurry.equals("USD"))curryDX="美元";
	StrSql = "update SL_TemporarilyBuy set  RoomCode="+code+",StartDate='"+Date2+"'";
	
	if (!Date1.equals(""))
	StrSql +=",EndDate='"+Date1+"'";
	StrSql +=",Subscription="+Subscription+",Receiver='"+user+"'";
	StrSql +=",Tel='"+TEL+"',BBJ='"+BBJ+"',remark='"+context+"'";
	StrSql +=",SJ='"+SJ+"',cardid='"+cardid+"',saleprice="+saleprice;
        StrSql+=",curr='"+ldcurry+"',rate="+ldrate;
		    StrSql+=",tk="+tk+",tk1="+tk1;
	 if (!tkDate1.equals(""))		
		 StrSql+=",tk_date='"+tkDate1+"'";
	 if (!tkDate2.equals(""))		
		 StrSql+=",tk_date1='"+tkDate2+"'";
	else 	 
	StrSql+=",tk_date=null";
	StrSql +=" ,PayType='"+ PayType +"',bill_num='"+billnum+"',payment='"+pay+"',disc='"+disc+"'  where id="+LDID;
	try {
	 aBean.executeUpdate(StrSql);
	 StrSql="update customer set signatory='"+CUSNAME1+"',cus_name='"+CUSNAME1+"',phone='"+TEL+"',sj='"+SJ+"',ID_CARD='"+cardid+"' where serialno='"+cus_name_no+"'";
	  aBean.executeUpdate(StrSql);	
    }catch(Exception ee) {
		out.print("用户添加失败，可能ID号相同了，请重新输入或联系系统管理员");
        out.close();
	} 
String Loft=getbyte2(request.getParameter("Loft"));		 
String RoomNo=getbyte2(request.getParameter("RoomNo"));	
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "修改临订" , 
                  "修改,房号:"+SecName+Loft+RoomNo
                ) ;
%>
<script>
alert("系统已接受修改");
<%  if(!change.equals("")){ %>
opener.document.frm.submit();
<%} %>
window.close();
</script>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
