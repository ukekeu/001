<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>�����ٶ�</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
  <%@ page import="java.sql.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/Repalce.jsp"%>
 
<%  String SecNo=getbyte2(request.getParameter("SecNo"));
   String SecName=getbyte2(request.getParameter("SecName"));
    String jzarea=getbyte2(request.getParameter("jzarea"));
    String SecNa=getbyte2(request.getParameter("SecNa"));
	String Loft = getbyte2(request.getParameter("Loft"));
	String Build = getbyte2(request.getParameter("Build"));
	String RoomNo = getbyte2(request.getParameter("RoomNo"));
	Loft=Loft+RoomNo;
	String code = getbyte2(request.getParameter("code"));
	String cardid = getbyte2(request.getParameter("carid"));
	String saleprice = getbyte2(request.getParameter("saleprice"));
	String Date1 = getbyte2(request.getParameter("Date1"));
    String Date2 = getbyte2(request.getParameter("Date2"));
	String CUSNAME = getbyte2(request.getParameter("cusname"));
	String CUSNAME1 = getbyte2(request.getParameter("cusname1"));//�ͻ�����
	String TEL = getbyte2(request.getParameter("tel"));
	String SJ = getbyte2(request.getParameter("sj"));
	String BBJ = getbyte2(request.getParameter("bbj"));
	String Subscription = getbyte2(request.getParameter("dj"));
	String StrSql="";		
	String StrSql1="";		
	 String context=getbyte2(request.getParameter("context"));
	
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
	
	
	String ldcurry=getbyte2(request.getParameter("curry"));
	String ldbillnum=getbyte2(request.getParameter("billnum"));
	String ldrate=getbyte2(request.getParameter("rate"));
	String ldperson=getbyte2(request.getParameter("person"));
	String PayType=getbyte2(request.getParameter("PayType"));
	String BillType=getbyte2(request.getParameter("BillType"));
	String pay=getbyte2(request.getParameter("pay"));
	 if (ldrate.equals(""))ldrate="1";
	pay=pay.substring(0,pay.indexOf("-"));
	String disc=getbyte2(request.getParameter("disc"));
	  context=getbyte2(request.getParameter("context"));
	 String   sql="";	String curryDX=""; 
   	if (ldcurry.equals(""))ldcurry="RMB";
	if (ldcurry.equals("RMB"))curryDX="�����";
	else if (ldcurry.equals("HKD"))curryDX="�۱�";
	else if (ldcurry.equals("USD"))curryDX="��Ԫ";
    if (CUSNAME.equals(""))
	{
	 //����˿ͻ�û���ڿͻ������е�¼�������Ӵ˿ͻ�
		     //���㵱ǰ�ͻ��ı��
   	     sql="select max(code)+1 code from customer ";//����ͻ����ID
        ResultSet cusRs=aBean.executeQuery(sql);  
         String cus_code="";
        if (cusRs.next()){
            cus_code=cusRs.getString("code");
		}
	    cusRs.close();
		CUSNAME=SecNo+"-"+cus_code;
		sql="insert into customer(Section,SerialNo,Cus_Name,signatory,Phone, ";
		sql+="visit_date, seller,sj,bbj,ID_CARD,ftsale,state)";
		sql+=" values('"+SecNo+"','"+CUSNAME+"','"+CUSNAME1+"','"+CUSNAME1+"','"+TEL+"'";
       sql+=",'"+Date2+"','"+user+"','"+SJ+"','"+BBJ+"','"+cardid+"',8,2)";
	 try{
			aBean.executeUpdate(sql);
	    }catch(Exception ee) {out.print(ee.getMessage());} 
	}else{
	   sql="update customer set Cus_Name='"+CUSNAME1+"',signatory='"+CUSNAME1+"'"
	   +",Phone='"+TEL+"',sj='"+SJ+"',bbj='"+BBJ+"',ID_CARD='"+cardid+"'"
	   +", seller='"+user+"',ftsale=8 where SerialNo='"+CUSNAME+"'";
	   try{
			  aBean.executeUpdate(sql);
		}catch(Exception ee) {out.print(sql+ee.getMessage());}
	}
	 
	StrSql = "insert into SL_TemporarilyBuy(RoomCode,StartDate,";
	 
	StrSql +="EndDate,";
	StrSql +="Subscription,Receiver,CusName,Tel,SJ,BBJ,cardid,saleprice";
	StrSql +=",remark,payment,disc)";
	StrSql += " values("+code+",'"+Date2;
	 
	StrSql +="',dateadd(day,"+Date1+",'"+Date2+"')";
	StrSql +=",'"+Subscription+"','";
	StrSql += user+"','"+CUSNAME+"','"+TEL+"','"+SJ+"','"+BBJ+"','";
	StrSql +=cardid+"',"+saleprice+",'"+context+"','"+pay+"','"+disc+"')";
	
	String sjcontext="";
	String payment=PayType;

	 
	try {
		 aBean.executeUpdate(StrSql);
	
    }catch(Exception ee) {
		out.print(StrSql+ee);
        out.close();
	} 
	  
	String addr=(String)session.getAttribute("reportAddr");
%>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�ٶ��Ǽ�" , 
                  "����,����ţ�"+SecName+Loft+Build
                ) ;
%>
<script>
 
 
opener.document.frm.submit();
if (confirm("ϵͳ�ѽ��ܿͻ����ٶ�,�Ƿ��ӡ�ٶ�Э�飿"))
 window.location='PrintCusLs.jsp?code=<%=code %>'
else
  window.close(); 
</script>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
