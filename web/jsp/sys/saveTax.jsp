<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

<HTML>
<HEAD>
<TITLE>保存计算标准</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />


<%  String SID=China.getParameter(request,"id");
    if (!(SID.equals(""))){
	   aBean.executeUpdate("delete taxchages where id="+SID);
	  %>
	    <script>
	     alert("操作成功");
         opener.window.location.reload();
	close();
	</script>
	  <%
	 
	}
	String MONEY="";
	String area="";
	String date="";
	String type="";
	String ID = China.getParameter(request,"editid");
	String code = China.getParameter(request,"code");
	String check = China.getParameter(request,"checktype");
	String custype= China.getParameter(request,"type");
	String types[]= request.getParameterValues("type1");
	String type3s[]= request.getParameterValues("type3");
	String type4s[]= request.getParameterValues("type4");
	String sel= China.getParameter(request,"sel");
	String type3="0";
	
	String type4="0";
	if (type3s!=null)
	  type3=type3s[0];
	if (type4s!=null)
	  type4=type4s[0];
	String type1="0";
	if (types!=null)
	 type1=types[0];
	if (custype.equals(""))custype="0";
	String term= "";
	String termmoney="";
	String term3= "";
	String termmoney3="";
    String A1="0",A2="",A3="0",A4="",A5="0";
   if (check.equals("1"))
	  MONEY =  China.getParameter(request,"MONEY1");
	  term=  China.getParameter(request,"term1");
	  termmoney=China.getParameter(request,"termmoney");
	  term3=  China.getParameter(request,"term3");
	  termmoney3=China.getParameter(request,"termmoney3");
	if (check.equals("2"))
	
     MONEY =  China.getParameter(request,"MONEY2");
	if (check.equals("3"))
	{ MONEY =  China.getParameter(request,"MONEY3");
	  termmoney= China.getParameter(request,"area");
	  term=China.getParameter(request,"term");
	  termmoney3= China.getParameter(request,"area1");
	  term3=China.getParameter(request,"term4");
	}
	
	if (check.equals("4"))
	{ MONEY =  China.getParameter(request,"MONEY6");
	  termmoney= China.getParameter(request,"area6");
	  term=China.getParameter(request,"term6");
	  termmoney3= China.getParameter(request,"area7");
	  term3=China.getParameter(request,"term7");
	}
	
	 
	if (check.equals("5"))
	{ MONEY =  China.getParameter(request,"MONEY8");//计算标准
	  termmoney= China.getParameter(request,"area8");
	  term=China.getParameter(request,"term8");//起始条件
	  termmoney3= China.getParameter(request,"area9");
	  term3=China.getParameter(request,"term9");//结束条件
	}
	
	if (check.equals("6"))
     MONEY =  China.getParameter(request,"MONEY4");
	if (check.equals("7")){
      MONEY =  China.getParameter(request,"MONEY5");
	  term=China.getParameter(request,"term2");
	  termmoney=China.getParameter(request,"termmoney1");
	   term3=China.getParameter(request,"term5");
	  termmoney3=China.getParameter(request,"termmoney5");
	 }
    if (check.equals("8")){
      MONEY =  China.getParameter(request,"unitprice3");
	  term=China.getParameter(request,"unit1");
	  termmoney=China.getParameter(request,"unitprice1");
	   term3=China.getParameter(request,"unit2");
	  termmoney3=China.getParameter(request,"unitprice2");
	 
	 }
	   if (check.equals("9")){
      MONEY =  China.getParameter(request,"Earea");
	  term=China.getParameter(request,"A1");
	  termmoney=China.getParameter(request,"Aarea");
	  term3=China.getParameter(request,"B1");
	  termmoney3=China.getParameter(request,"Barea");
	 
	 
	  A1 =  China.getParameter(request,"Farea");
	  A2=China.getParameter(request,"C1");
	  A3=China.getParameter(request,"Carea");
	  A4=China.getParameter(request,"D1");
	  A5=China.getParameter(request,"Darea");
	 }
	 date=China.getParameter(request,"date");
	 type=China.getParameter(request,"choosedate");
	 if (MONEY.equals(""))MONEY="0";
	  if (area.equals(""))area="0";
	   if (termmoney.equals(""))termmoney="0";
	     if (termmoney3.equals(""))termmoney3="0";
		  if (term3.equals(""))term3="0";
		   if (term.equals(""))term="0";
	String StrSql="";		
	
    if (ID.equals("")){
		StrSql = "insert into taxchages(code,money,state,termvalue,term,termvalue1,term1,type,type1,type3,term2,term3,termvalue2,termvalue3,Money1,choose)";
		StrSql += " values(";
		StrSql += code+","+ MONEY+","+check + "," + termmoney + ",'"+term+"',"+termmoney3+",'"+term3+"',"+custype+","+type1+","+type3+",'"+A2+"','"+A4+"',"+A3+","+A5+","+A1+","+sel+")";
 
        setlog( setlogBean,( String )session.getAttribute( "loginid" ) ,
                          "费用公式" , 
                          "新增"
                        ) ;

	}else{
	    StrSql="update taxchages set "; 	
		StrSql+=" choose="+sel+",money="+MONEY+",state='"+check+"',termvalue="+termmoney+",term='"+term+"',termvalue1="+termmoney3+",term1='"+term3+"',termvalue2="+A3+",term2='"+A2+"',termvalue3="+A5+",term3='"+A4+"',Money1="+A1+",type="+custype+",type1="+type1;
		StrSql+=",type3="+type3+" where id="+ID;
	 
         setlog( setlogBean,( String )session.getAttribute( "loginid" ) ,
                  "费用公式" , 
                  "修改"
                ) ;

	}
	try {
	//   out.print(StrSql);
  aBean.executeUpdate(StrSql);
    %>
	<script>
	alert("操作成功");
	opener.window.location.reload();
	   window.close();
	
	</script>
	<%
	}catch(Exception ee) {
		out.print("用户添加失败，可能ID号相同了，请重新输入或联系系统管理员");
              out.print(ee.getMessage()+StrSql);   
	} 
	
	//if (serv.equals(""))
	//	out.print("null");
	
%>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
