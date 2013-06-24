<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/yonghuhuodong.jsp" %>


<html>
<head>
	<title>新栽型户资料</title>
	<LINK href="../class/news.css" rel=stylesheet>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%
  try{
 
    String sj = China.getParameter(request, "sj" ) ;
     String age = China.getParameter(request, "age" ) ;
   
 
	 String  name=China.getParameter(request,"name");
	 String  sex=China.getParameter(request,"sex");
 
   String ahs[]	= request.getParameterValues("ah");
   String tcs[]	= request.getParameterValues("tc");
   String ah="";
   String tc="";
   for (int i=0;i<ahs.length;i++){
     if (ah.equals("")) ah=getbyte1(ahs[i]);
	 else  ah+=","+getbyte1(ahs[i]);
   }
	 for (int i=0;i<tcs.length;i++){
     if (tc.equals("")) tc=getbyte1(tcs[i]);
	 else  tc+=","+getbyte1(tcs[i]);
   } 	
	String job=China.getParameter(request,"job");
 
	String wh=China.getParameter(request,"wh");
 
    String sr=China.getParameter(request,"sr");
    String  tj=China.getParameter(request,"tj");
    String  ho_tel=China.getParameter(request,"ho_tel");
    String  idcard=China.getParameter(request,"cardid");
 
	String  addr=China.getParameter(request,"ho_addr");
 
	String  yb=China.getParameter(request,"pos");
    String company=China.getParameter(request,"company");
	String personnum=China.getParameter(request,"personnum");
    String mail=China.getParameter(request,"mail");	 
    String con_no=China.getParameter(request,"con_no");	
    String wyaddr=China.getParameter(request,"wyaddr");	
    String fax=China.getParameter(request,"fax");	
    String of_tel=China.getParameter(request,"of_tel");	
	String jl=China.getParameter(request,"jl");	
	String zy=China.getParameter(request,"zy");	
	String marriage=China.getParameter(request,"marriage");	
	String yy=China.getParameter(request,"yy");	
	String mm=China.getParameter(request,"mm");	
	String dd=China.getParameter(request,"dd");	
	String pos=China.getParameter(request,"pos");	
	String  sql="";
    String OK="FALSE";
	 
    	sql="insert into VIPCUSTOMER(age,Cus_Name, Sex, cs_date, sfzh, hy, of_tel,"; 
        sql=sql+"ho_tel, sj, fax,company,wenhua,ah,mail,tc,jl,Job,sr,ho_ren,ho_addr,con_no,wy_addr,zipcode)";
		sql=sql+" values('"+age+"','"+name+"','"+sex+"','"+yy+"-"+mm+"-"+dd+"','"+idcard+"'";
		sql=sql+",'"+marriage+"','"+of_tel+"','"+ho_tel+"','"+sj+"','"+fax+"','"+company+"','";
		 
        sql=sql+wh+"','"+ah+"','"+mail+"','"+tc+"','"+jl+"','"+zy+"'";
		sql=sql+",'"+sr+"','"+personnum+"','"+addr+"','"+con_no+"','"+wyaddr+"','"+pos + "')";
    try
    	  {
	         
                   InsertBean.executeUpdate(sql);
		%>
			<script>
			    alert("已保存会员资料");
				opener.window.location.reload();
				window.close();
				 
			</script>
		 <%}
	   catch(SQLException ex)	
	    {
	      out.print("System Error<br>");
           out.println(sql);
	      out.print(ex.getMessage());
	      out.close();
	    }
	
        setYongHuHuoDong( setYongHuHuoDongBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "客户一览" , 
                          "增加"
                        ) ;
  
 
}catch(Exception s){out.print("dd");}%>
</body>
</html>

