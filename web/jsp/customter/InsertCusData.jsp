<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>


<html>
<head>
	<title>保存客户资料</title>
	<LINK href="../class/news.css" rel=stylesheet>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%
  try{
    String bbj = China.getParameter(request, "bbj" ) ;
    String sj = China.getParameter(request, "sj" ) ;
    String grade=China.getParameter(request, "grade" ) ;
     String section=China.getParameter(request,"section");
     String submit1=China.getParameter(request,"SaveCus");
     String age="";
	  
   String  [] tjs=request.getParameterValues("tj");
   String tj="";   
   if (tjs!=null){
   for (int a=0;a<tjs.length;a++){
       if (tj.equals(""))  tj=getbyte1(tjs[a]);
	   else tj+=","+getbyte1(tjs[a]);
    }
   }
   
	 age=China.getParameter(request,"age");
	 String  name=China.getParameter(request,"name");
	 String  sex=China.getParameter(request,"sex");
	 String cusno=China.getParameter(request,"cusno");
    String csdate=China.getParameter(request,"csdate");
    String rh=China.getParameter(request,"rh");
    String ah=China.getParameter(request,"ah");	
    String car=China.getParameter(request,"car");	
    String hs=China.getParameter(request,"hs");	
    String zy=China.getParameter(request,"zy");		
	String cc=China.getParameter(request,"cc");		
  
	String agefw=China.getParameter(request,"agefw");		
    String info_fk=China.getParameter(request,"info_fk");	
	String job=China.getParameter(request,"job");
	String visitstate=China.getParameter(request,"visitstate");
    String ContactPerson  =China.getParameter(request,"ContactPerson");
    String personnum=China.getParameter(request,"personnum");
    if (personnum.equals(""))personnum="0";
	String wh=China.getParameter(request,"wh");
	String region=China.getParameter(request,"Region");
    String jtsr=China.getParameter(request,"jtsr");
    String  date="";
   
 
      
	   date=China.getParameter(request,"Date1");
 
    String  tel=China.getParameter(request,"tel");
    String  idcard=China.getParameter(request,"cardid");
            if (!China.getParameter(request,"cardid2").equals(""))
			idcard+="/"+China.getParameter(request,"cardid2");
			if (!China.getParameter(request,"cardid3").equals(""))
			idcard+="/"+China.getParameter(request,"cardid3");
	String  custype=China.getParameter(request,"custype");
    String  seller=China.getParameter(request,"seller");
	String  addr=China.getParameter(request,"addr");
    String  contactPerson=China.getParameter(request,"ContactPerson");
	String  yb=China.getParameter(request,"pos");
    String company=China.getParameter(request,"company");
	String visitnum=China.getParameter(request,"num");
     if (visitnum.equals(""))visitnum="";
	String chishu=China.getParameter(request,"chishu");
	if (chishu.equals(""))chishu="0";
	String homejg=China.getParameter(request,"homejg");
	String nexus=China.getParameter(request,"tfnexus");
    String nowjuarea=China.getParameter(request,"nowjuarea");
	String visittj=China.getParameter(request,"cometj");
    String visitname=China.getParameter(request,"visitname");
	String	 signatory=China.getParameter(request,"signatory");	
    String mail=China.getParameter(request,"mail");	 
    String CusType=China.getParameter(request,"CusType");	//1表示是机会客户，0表示是线索客户 
 
	String  sql="";
    String OK="FALSE";
	if (submit1.equals("insert")){
	//下面是计算某楼盘来访客户的最大编号
	   sql="select max(code)+1 code from customer ";//计算客户最大ID
    ResultSet cusRs=InsertBean.executeQuery(sql);  
    String cus_code="";
     if (cusRs.next()){
            cus_code=cusRs.getString("code");
		}
	cusRs.close();
	cusno=section+"-"+cus_code;
	 	//Insert date
    	sql="insert into customer(Section,Cus_Name, Cus_Sex, cus_age, visitstate,Cus_Type,  Phone, ID_Card, Address,"; 
        sql=sql+"Zip_Code, visit_date, seller,company,mail,region,bbj,sj, Age_range,grade,bak,state)";
		sql=sql+" values('"+section+"','"+name+"','"+sex+"','"+age+"','"+visitstate+"'";
	    sql=sql+",'"+custype+"','"+tel+"','"+idcard+"','"+addr+"','"+yb+"','"+date+"','"+seller+"','";
        sql=sql+company+"','"+mail+"','"+region+"','" + bbj + "' , '" + sj + "','"+agefw+"','"+grade+"','"+info_fk+"',"+CusType+")";
	 		 try
    	  {
	       InsertBean.executeUpdate(sql);
		   sql=" update customer set serialno=ltrim(rtrim(section))+'-'+ltrim(rtrim(code)) where code=(select max(code) from customer)";
		   InsertBean.executeUpdate(sql);
		   sql="select  CodeValue,code from CustomerDcValue where dcCode in (select code from CustomerDc where sectionno='"+section+"')";
		   cusRs=InsertBean.executeQuery(sql);
		 
		   while (cusRs.next()){
		     String CodeValue=getbyte1(request.getParameter("codcename"+cusRs.getString("code")));
			   out.print(CodeValue);
			 if (!CodeValue.equals("")){
		        sql="insert into customer_xq(customer,xq_code) values("+cus_code+","+CodeValue+")";
				InsertBean1.executeUpdate(sql);
			 }	
		   }
		   cusRs.close();
		    
	sql="insert into tail_after(cusno,fc,seller,date) select top 1 serialno ,'"+info_fk+"',seller,visit_date from customer order by code desc"; 
	  InsertBean.executeUpdate(sql);
					
		%>
			<script>
			     <%if (request.getParameter("addnew")!=null){%>
				                             
				 <%}else{ %>
				opener.document.form1.submit();
				
				<%} %>
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
	
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "客户一览" , 
                          "增加"+name+"客户资料"
                        ) ;
   }
   else if (submit1.equals("modi")){ 

        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "客户一览" , 
                          "修改"+name+"客户资料"
                        ) ;

   cusno=China.getParameter(request,"cusno");
	//Edit date
	sql="update customer set visitstate='"+visitstate+"',grade='"+grade+"',section='"+section+"', signatory='"+name+"',Cus_Name='"+name+"'"+",Cus_Sex='"+sex+"'"+",cus_age='"+age+"',Cus_Type='"+custype+"',";
	sql=sql+"Knowledge_From='"+tj+"'"+",Phone='"+tel+"'"+",ID_Card='"+idcard+"',mail='"+mail+"'";
	sql=sql+",Address='"+addr+"'"+",Zip_Code='"+yb+"'";
	sql=sql+",company='"+company+"',visit_date='"+date+"',seller='"+seller+"'";
	sql=sql+",Job='"+job+"',region='"+region+"'";
	if (!csdate.equals(""))
	sql+=",csdate='"+csdate+"'";
	sql=sql+" , bbj = '" + bbj + "' ,sj = '" + sj + "',Age_range='"+agefw+"',bak='"+info_fk+"' where SerialNo='"+cusno+"'";
  
	try{
    	InsertBean.executeUpdate(sql);
		InsertBean.executeUpdate("delete customer_xq where customer="+cusno.substring(cusno.indexOf("-")+1));
		 
		 sql="select  CodeValue,code from CustomerDcValue where dcCode in (select code from CustomerDc where sectionno='"+section+"')";
		 
		   ResultSet   cusRs=InsertBean.executeQuery(sql);
		   while (cusRs.next()){
		     String  CodeValue=getbyte1(request.getParameter("codcename"+cusRs.getString("code")));
			 if (!CodeValue.equals("")){
		        sql="insert into customer_xq(customer,xq_code) values("+cusno.substring(cusno.indexOf("-")+1)+","+CodeValue+")";
				InsertBean1.executeUpdate(sql);
			 }	
		   }
		   cusRs.close();
	    out.print("系统已接受你的修改");
		OK="TRUE";
	%>
	  
	<%	
	 }
	 catch(SQLException ex)	
	    {
		 out.print(sql);
	      out.print("System Error<br>");
	      out.print(ex.getMessage());
	      out.close();
	    }
	}
 
if (OK.equals("TRUE")){
%>
<script>
alert("系统已修改资料");
 
opener.window.document.forms[0].submit() ;
 
 close();
</script>

<%} 
}catch(Exception s){out.print("dd");}%>
</body>
</html>

