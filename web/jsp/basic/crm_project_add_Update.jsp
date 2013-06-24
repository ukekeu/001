<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/logrecord.jsp" %>


<html>
<head>
	<title>保存新增楼盘资料</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.*,ConnDatabase.MailHandler" %>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="getByte" scope="page" class="getBytes.getBytes"/>
 <%@ include file="../public_js/Repalce.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
<%
 
          try{
        String strSerialNo="";
	    strSerialNo =  getbyte1(request.getParameter("SecNo"));
	    String StrSecNo=strSerialNo;
		String strSecName =  getbyte1(request.getParameter("SecName"));
	 	String strSecArea=  getbyte1(request.getParameter("SecArea"));
        String fArea= getbyte1(request.getParameter("Area")); 
        if (fArea.equals("")){fArea="0";}
		String fUseArea=  getbyte1(request.getParameter("UseArea")); 
        if (fUseArea.equals("")){fUseArea="0";}
        String fCubageRate=  getbyte1(request.getParameter("CubageRate")); 
        if (fCubageRate.equals("")){fCubageRate="0";}
	    String fGreenRate= getbyte1(request.getParameter("GreenRate")); 
       if (fGreenRate.equals("")){fGreenRate="0";}
	   String strSetDate=  getbyte1(request.getParameter("Date1")); 
       String strOpenDate= getbyte1(request.getParameter("Date2")); 
       String strOfferDate= getbyte1(request.getParameter("Date3")); 
       String strFactDate=getbyte1(request.getParameter("Date4")); 
       String strFdDate= getbyte1(request.getParameter("Date5")); 
       String strJgDate= getbyte1(request.getParameter("Date6")); 
       String  company= getbyte1(request.getParameter("company"));
       String strRegion= getbyte1(request.getParameter("region")); 
       String strDH=  getbyte1(request.getParameter("DH")); 
	   String strgytzno= getbyte1(request.getParameter("gytzno")); 
	   String strtdsyqcrpzno=  getbyte1(request.getParameter("tdsyqcrpzno")); 
       String strLS="";//LS[0];
	   String strdevelopcom=getbyte1(request.getParameter("developcom")); 
       String strinvestcom= getbyte1(request.getParameter("investcom")); 
 	   String struseyear=getbyte1(request.getParameter("useyear")); 
 	   String strcomnote=  getbyte1(request.getParameter("comnote")); 
       String StrSaleArea=  getbyte1(request.getParameter("SaleArea")); 
       if (StrSaleArea.equals(""))StrSaleArea="0";
	   String strType= getbyte1(request.getParameter("Type")); 
       String strFitment="";//Fitment[0];
       String intFamilyCount=  getbyte1(request.getParameter("FamilyCount")); 
       if (intFamilyCount.equals("")){intFamilyCount="0";}
       String fRealRate= getbyte1(request.getParameter("RealRate")); 
       if (fRealRate.equals("")){fRealRate="0";}
	   String fManageFee= getbyte1(request.getParameter("ManageFee")); 
       if (fManageFee.equals("")){fManageFee="0";}
	   String strIntro= getbyte1(request.getParameter("Intro")); 
       String sd=  getbyte1(request.getParameter("sd")); 
       String ed=  getbyte1(request.getParameter("ed")); 
  	   String jg=  getbyte1(request.getParameter("jg")); 
       String qddkfs=  getbyte1(request.getParameter("qddkfs")); 
       String wggs=  getbyte1(request.getParameter("wggs")); 
       String ysxkzh= getbyte1(request.getParameter("ysxkzh")); 
       String sgxkh= getbyte1(request.getParameter("sgxkh")); 
       String ghh=  getbyte1(request.getParameter("ghh")); 
       String cg=  getbyte1(request.getParameter("cg")); 
       String tdqyxz=  getbyte1(request.getParameter("tdqyxz")); 
       String tdqsly=  getbyte1(request.getParameter("tdqsly")); 
       String fr=  getbyte1(request.getParameter("fr")); 
       String phone=  getbyte1(request.getParameter("phone")); 
       String dlr=  getbyte1(request.getParameter("dlr")); 
       String phone1=  getbyte1(request.getParameter("phone1")); 
       String dlrdz=  getbyte1(request.getParameter("dlrdz")); 
       String zipcode=  getbyte1(request.getParameter("zipcode")); 
       String zzzsh=  getbyte1(request.getParameter("zzzsh")); 
 	   String yyzzh=  getbyte1(request.getParameter("yyzzh")); 
       String frdz=  getbyte1(request.getParameter("frdz")); 
       String fryb= getbyte1(request.getParameter("zipcode1")); 
       String zcadd= getbyte1(request.getParameter("zcadd")); 
       String AddT="FALSE";
       String sql="";
       String eof="true";
      sql="select * from CRM_Project where SerialNo='"+StrSecNo+"'";
	  ResultSet rs=InsertBean.executeQuery(sql);
	  if (rs.next()){eof="false";}
	  rs.close();
	  if (eof.equals("true")){
       sql="'"+strSecName+"','"+strSecArea+"','"+StrSecNo+"',"+fArea+","+fUseArea+",";
	   sql+=fCubageRate+","+fGreenRate+",'"+strSetDate+"',"; 
       sql=sql+"'"+strOpenDate+"','"+strOfferDate+"','"+strFactDate+"',"; 
	   sql+=""+intFamilyCount+","+fRealRate+",";
	   sql+=fManageFee+",'"+strdevelopcom+"','"+strinvestcom+"','"+strcomnote+"','"+strIntro+"','";//'"+struseyear+"',0,
	   sql+=strRegion+"',"+StrSaleArea+",'"+strFdDate+"','"+strJgDate+"',"; 
	   sql+="'"+strType+"','"+strFitment+"','"+strDH+"','"+strLS+"','"+company+"',";
	   sql+="'"+wggs+"',"; 
	   sql+="'"+strDH+"','"+ysxkzh+"','"+sgxkh+"','"+ghh+"','"+qddkfs+"','"+tdqyxz+"','"+tdqsly+"','"+strgytzno+"','"+strtdsyqcrpzno+"'";
	   sql+=",'"+fr+"','"+phone+"','"+dlr+"','"+phone1+"','"+dlrdz+"','"+zipcode+"','"+yyzzh+"','"+zzzsh+"','"+frdz+"','"+fryb+"','"+zcadd+"','"+jg+"'";
    try{
	 
	  InsertBean.executeUpdate("exec set_project "+sql);
	  sql="select companyaddr,companyfax,companytel from  company  where CompanyName='"+company+"'";
	   rs=InsertBean.executeQuery(sql);
	   if (rs.next()){
	    strdevelopcom="公司名称:"+strdevelopcom+",地址:"+rs.getString("companyaddr");
		strdevelopcom+=",电话:"+rs.getString("companytel")+",传真:"+rs.getString("companyfax");
	   }
	    InsertBean.sendtomaill("IP:"+request.getRemoteAddr()+" "+strdevelopcom+",楼盘位置:"+strSecArea+",楼盘名称:"+strSecName);
	  //更改使用楼盘数据的权限
	 
	  String sq="";
	  String userid=(String)session.getAttribute("loginid");
	   if (!setpopedom.getSectionlist().trim().equals(""))
	   InsertBean.executeUpdate("exec set_qx '/"+StrSecNo.trim()+"','"+userid+"'");
	   else
	   InsertBean.executeUpdate("exec set_qx '"+StrSecNo.trim()+"','"+userid+"'");
	   if (!setpopedom.getSectionlist().trim().equals(""))
	     sq=setpopedom.getSectionlist()+",'"+StrSecNo.trim()+"'";
	   else
	        sq="'"+StrSecNo.trim()+"'";	 
 	   setpopedom.setSectionlist(""+sq+"");
       
		 
	 	%>  
		 <%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "楼盘资料" , 
                  "新增("+strSecName+")"
                ) ;
%>
	  <script>
	
	  alert("系统已保存你录入的数据")
	  opener.window.document.cus.submit();
	   window.close();
	 </script>
   <% }
   catch(Exception se){
     out.print("系统出错，原因如下：<br>");
     out.print(se.getMessage());
     out.close();
  }
 } else{out.print("此楼盘编号已存在<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:window.history.back(1)'>返回</a>");} 
  }catch(Exception s){out.print("系统出现异常错误，错误原因："+s);}
%>	
 

</body>

</html>
