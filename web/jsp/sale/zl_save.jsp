<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>保存租赁登记</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
  <%@ page import="java.sql.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
  <%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/Repalce.jsp"%>
 
<%  
	 // Variables
	int count=0;        
	// Initialization
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setTotalMaxFileSize(209715200);
	// Upload	
	mySmartUpload.upload();
 
String strPicture1="";
String strPicture2="";
 
com.jspsmart.upload.File myFile1 = mySmartUpload.getFiles().getFile(0);
	 if (!myFile1.isMissing()) 
     {       String ext= myFile1.getFileExt(); //取得后缀名
 
	  Calendar calendar = Calendar.getInstance();
	  String filename = String.valueOf(calendar.getTimeInMillis());
 
     strPicture1=request.getRealPath("/")+"jsp/picture/" +filename+"."+ext;
	myFile1.saveAs(strPicture1,mySmartUpload.SAVE_PHYSICAL);
	  
	strPicture1="../picture/"+"_."+ext;
    
     }
com.jspsmart.upload.File myFile2 = mySmartUpload.getFiles().getFile(1);
	 if (!myFile2.isMissing()) 
     {       String ext= myFile2.getFileExt(); //取得后缀名
 
	  Calendar calendar = Calendar.getInstance();
	  String filename1 = String.valueOf(calendar.getTimeInMillis());
 
     strPicture2=request.getRealPath("/")+"jsp/picture/" +filename1+"_."+ext;
	myFile2.saveAs(strPicture2,mySmartUpload.SAVE_PHYSICAL);
	  
	  strPicture2="../picture/"+"_."+ext;
    
     }
java.util.Enumeration e = mySmartUpload.getRequest().getParameterNames();
	String []SecNos=mySmartUpload.getRequest().getParameterValues("SecNo"); 
	String SecNo=SecNos[0];
	String []SecNames=mySmartUpload.getRequest().getParameterValues("SecName");
    String SecName=SecNames[0];
	String []jzareas=mySmartUpload.getRequest().getParameterValues("jzarea");
    String jzarea=jzareas[0];
	String []SecNas=mySmartUpload.getRequest().getParameterValues("SecNa");
    String SecNa=SecNas[0];
	String []Lofts=mySmartUpload.getRequest().getParameterValues("Loft");
    String Loft=Lofts[0];
    String []Builds=mySmartUpload.getRequest().getParameterValues("Build");
    String Build=Builds[0];
	String []RoomNos=mySmartUpload.getRequest().getParameterValues("RoomNo");
    String RoomNo=RoomNos[0];
	String []codes=mySmartUpload.getRequest().getParameterValues("code");
    String code=codes[0];
	String []cardids=mySmartUpload.getRequest().getParameterValues("carid");
    String cardid=cardids[0];
	String []zjs=mySmartUpload.getRequest().getParameterValues("zj");
    String zj=zjs[0];
	String []Date1s=mySmartUpload.getRequest().getParameterValues("Date1");
    String Date1=Date1s[0];
	String []Date2s=mySmartUpload.getRequest().getParameterValues("Date2");
    String Date2=Date2s[0];
	String []Date3s=mySmartUpload.getRequest().getParameterValues("Date3");
    String Date3=Date3s[0];
	String []CUSNAMEs=mySmartUpload.getRequest().getParameterValues("cusname");
    String CUSNAME=CUSNAMEs[0];
	String []phones=mySmartUpload.getRequest().getParameterValues("phone");
    String phone=phones[0];
	String []contexts=mySmartUpload.getRequest().getParameterValues("context");
    String context=contexts[0];
 
	String []hths=mySmartUpload.getRequest().getParameterValues("hth");
    String hth=hths[0];
	String []linkmans=mySmartUpload.getRequest().getParameterValues("linkman");
    String linkman=linkmans[0]; 
	String []yjs=mySmartUpload.getRequest().getParameterValues("yj");
    String yj=yjs[0]; 
	 
	 
	String []yttypes=mySmartUpload.getRequest().getParameterValues("yttype");
    String yttype=yttypes[0]; 
	
	String []products=mySmartUpload.getRequest().getParameterValues("product");
    String product=products[0]; 
	
	String []jytypes=mySmartUpload.getRequest().getParameterValues("jytype");
    String jytype=jytypes[0]; 
	
	
	 String   sql="";	 
    
     
		sql="insert into zl_info(sectionno,loft,roomno,cusname,Phone,linkman,bak, ";
		sql+="qd_date, startdate,enddate,zjn,zj,yj,htn,fileurl1,fileurl2,product)";
		sql+=" values('"+SecNo+"','"+Loft+"','"+RoomNo+"','"+CUSNAME+"','"+phone+"','"+linkman+"','"+context+"'";
       sql+=",'"+Date2+"','"+Date1+"','"+Date3+"','"+cardid+"','"+zj+"',"+yj+",'"+hth+"','"+strPicture1+"','"+strPicture2+"','"+product+"')";
	 try{
	 
			aBean.executeUpdate(sql);
			sql="update room set salestate=7 where seccode+loft+room_code='"+SecNo+Loft+RoomNo+"'";
			aBean.executeUpdate(sql);
	    }catch(Exception ee) {out.print(ee.getMessage());} 
	 
	  
	 
%>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "租赁登记" , 
                  "增加,房间号："+SecName+Loft+Build
                ) ;
%>
<script>
 
 
opener.document.frm.submit();
  window.close(); 
</script>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
