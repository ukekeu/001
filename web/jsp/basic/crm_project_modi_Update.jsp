<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>保存修改资料</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <jsp:useBean id="getByte" scope="page" class="getBytes.getBytes"/>
 <%@ include file="../public_js/Repalce.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
 <%
    try{
        String ID1=request.getParameter("ID");
        String strSerialNo =  getbyte1(request.getParameter("SecNo"));
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
        String sql="";
       sql="'"+strSecName+"','"+strSecArea+"','"+StrSecNo+"',"+fArea+","+fUseArea+",";
	   sql+=fCubageRate+","+fGreenRate+",'"+strSetDate+"',"; 
       sql=sql+"'"+strOpenDate+"','"+strOfferDate+"','"+strFactDate+"',"; 
	   sql+=""+intFamilyCount+","+fRealRate+",";
	   sql+=fManageFee+",'"+strdevelopcom+"','"+strinvestcom+"','"+strcomnote+"','"+strIntro+"','";//'"+struseyear+"',0,
	   sql+=strRegion+"',"+StrSaleArea+",'"+strFdDate+"','"+strJgDate+"',"; 
	   sql+="'"+strType+"','"+strFitment+"','"+strDH+"','"+strLS+"','"+company+"',";
	   sql+="'"+wggs+"',"; 
	   sql+="'"+strDH+"','"+ysxkzh+"','"+sgxkh+"','"+ghh+"','"+qddkfs+"','"+tdqyxz+"','"+tdqsly+"','"+strgytzno+"','"+strtdsyqcrpzno+"'";
	   sql+=",'"+fr+"','"+phone+"','"+dlr+"','"+phone1+"','"+dlrdz+"','"+zipcode+"','"+yyzzh+"','"+zzzsh+"','"+frdz+"','"+fryb+"','"+zcadd+"','"+jg+"',"+ID1;
try{  
   
   InsertBean.executeUpdate("exec modi_project "+sql);
    InsertBean.executeUpdate("update room set  serve_date ='"+strOfferDate+"' where seccode='"+StrSecNo+"'");
  
   
     setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "楼盘资料" , 
                  "修改("+strSecName+")"
                ) ;
 }
catch(Exception se){
 out.print("系统出错，原因如下：<br>");
 out.print(se.getMessage());
 out.close();
 
}
  }catch(Exception s){out.print("系统出现异常错误，错误原因："+s);}

%>
<script>
alert("系统已接受你修改的楼盘资料");
opener.window.location.reload();
close();
</script>
</body>

</html>
