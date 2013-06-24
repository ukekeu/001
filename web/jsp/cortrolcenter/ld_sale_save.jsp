<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "临订登记" , 
                  "增加"
                ) ;
%>

<HTML>
<HEAD>
<TITLE>保存临订</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
  <%@ page import="java.sql.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/Repalce.jsp"%>
 
<%  String SecNo=getbyte1(request.getParameter("SecNo"));
    String SecName=getbyte1(request.getParameter("SecName"));
    String jzarea=getbyte1(request.getParameter("jzarea"));
    String SecNa=getbyte1(request.getParameter("SecNa"));
	String Loft =getbyte1( request.getParameter("Loft"));
	String Build = getbyte1(request.getParameter("Build"));
	String RoomNo = getbyte1(request.getParameter("RoomNo"));
	Loft=Loft+RoomNo;
	String code = getbyte1(request.getParameter("code"));
	String cardid = getbyte1(request.getParameter("carid"));
	String saleprice = getbyte1(request.getParameter("saleprice"));
	String Date1 = getbyte1(request.getParameter("Date1"));
    String Date2 = getbyte1(request.getParameter("Date2"));
	String CUSNAME = getbyte1(request.getParameter("cusname"));
	String CUSNAME1 = getbyte1(request.getParameter("cusname1"));//客户姓名
	String TEL = getbyte1(request.getParameter("tel"));
	String SJ = getbyte1(request.getParameter("sj"));
	String BBJ = getbyte1(request.getParameter("bbj"));
	String Subscription = getbyte1(request.getParameter("dj"));
	String StrSql="";		
	String StrSql1="";		
	 String context=getbyte1(request.getParameter("context"));
	 
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
	
	 
	 String   sql="";
    if (CUSNAME.equals(""))
	{
	 //如果此客户没有在客户资料中登录，现增加此客户
		     //计算当前客户的编号
   	     sql="select max(code)+1 code from customer ";//计算客户最大ID
        ResultSet cusRs=aBean.executeQuery(sql);  
         String cus_code="";
        if (cusRs.next()){
            cus_code=cusRs.getString("code");
		}
	    cusRs.close();
		CUSNAME=SecNo+"-"+cus_code;
		sql="insert into customer(Section,SerialNo,Cus_Name,signatory,Phone, ";
		sql+="visit_date, seller,sj,bbj,ID_CARD,ftsale)";
		sql+=" values('"+SecNo+"','"+CUSNAME+"','"+CUSNAME1+"','"+CUSNAME1+"','"+TEL+"'";
       sql+=",'"+Date2+"','"+user+"','"+SJ+"','"+BBJ+"','"+cardid+"',8)";
			   try{
			      aBean.executeUpdate(sql);
			    }catch(Exception ee) {out.print(ee.getMessage()+"<br>"+sql);
    	   } 
	}else{
	   sql="update customer set Cus_Name='"+CUSNAME1+"',signatory='"+CUSNAME1+"'"
	   +",Phone='"+TEL+"',sj='"+SJ+"',bbj='"+BBJ+"',ID_CARD='"+cardid+"'"
	   +", seller='"+user+"',ftsale=8 where SerialNo='"+CUSNAME+"'";
	   try{
			  aBean.executeUpdate(sql);
		}catch(Exception ee) {out.print(sql+ee.getMessage());}
	}
	StrSql = "insert into kfreco(customer,secno,room_code,";
	if (!Date1.equals(""))
	StrSql +="reco_date,";
	StrSql +="context,seller) ";
	StrSql += " values('"+CUSNAME+"','"+SecNo+"','"+SecName+Loft;
	if (!Date1.equals(""))
	StrSql +="','"+Date1+"";
	StrSql +="','"+context+"','";
	StrSql += user+"')";
	 
	try {
	
	 
	 aBean.executeUpdate(StrSql);
	
    }catch(Exception ee) {
		out.print("错误原因"+ee.getMessage()+"<br>"+StrSql);
        out.close();
	} 
 
	 
%>
<script>
alert("系统已保存数据");
 
 close();
</script>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
