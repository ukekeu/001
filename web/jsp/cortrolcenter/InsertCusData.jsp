<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>


<html>
<head>
	<title>新栽型户资料</title>
	<LINK href="../class/news.css" rel=stylesheet>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%
  try{
    String bbj = China.getParameter(request, "bbj" ) ;
    String sj = China.getParameter(request, "sj" ) ;
  
     String section=China.getParameter(request,"section");
     String submit1=China.getParameter(request,"SaveCus");
     String age="";
     String demand=China.getParameter(request,"demand");
	 String attention=China.getParameter(request,"attention");
	 age=China.getParameter(request,"age");
	 String  name=China.getParameter(request,"name");
	 String  sex=China.getParameter(request,"sex");
	 String cusno=China.getParameter(request,"cusno");
    String  gmyt=China.getParameter(request,"gmyt");
    String fiment=China.getParameter(request,"fiment");
    String rh=China.getParameter(request,"rh");
    String ah=China.getParameter(request,"ah");	
    String car=China.getParameter(request,"car");	
    String hs=China.getParameter(request,"hs");	
    String zy=China.getParameter(request,"zy");		
	String cc=China.getParameter(request,"cc");		
	String hj=China.getParameter(request,"hj");			
	String  zj=China.getParameter(request,"zj");
	String agefw=China.getParameter(request,"agefw");		
    String  floor=China.getParameter(request,"floor");
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
	
    String  tj=China.getParameter(request,"tj");
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
    String payment=China.getParameter(request,"payment");	
	String yixiangmianji=China.getParameter(request,"yixiangmianji");	
	String  sql="";
    String OK="FALSE";
	if (submit1.equals("insert")){
	//下面是计算某楼盘来访客户的最大编号
	  sql="select max(serialno) as cusno from customer where section='"+section+"'";
	  ResultSet MaxCusNo=InsertBean.executeQuery(sql);
	  if (MaxCusNo.next()){
	   cusno=MaxCusNo.getString("cusno");
	  if (cusno!=null){
	   int abc=0;
	   String def="";
	   if (Integer.parseInt(cusno.substring(cusno.lastIndexOf("-")+1))>0){
	     abc=Integer.parseInt(cusno.substring(cusno.lastIndexOf("-")+1))+1;
		 if (abc<10){
		  def="000"+String.valueOf(abc);}
		 else if (abc>=10&&abc<100){
 		  def="00"+String.valueOf(abc);}
		 else if (abc>=100&&abc<1000){
 		  def="0"+String.valueOf(abc);} 
		 else if (abc>=1000&&abc<10000){
 		  def=String.valueOf(abc);} 
	     cusno=section+"-"+def;	   
	 }	}else{cusno=section+"-"+"0001";}	    
   }else{cusno=section+"-"+"0001";} 
	  
      sql="select * from customer where SerialNo='"+cusno+"'";
	  ResultSet rs=InsertBean.executeQuery(sql);
	  if (!rs.next()){
	 	//Insert date
    	sql="insert into customer(Section,SerialNo,Cus_Name, Cus_Sex, cus_age, visitstate,Cus_Type, Purpose, Knowledge_From,Phone, ID_Card, Address,"; 
        sql=sql+"Zip_Code, visit_date, seller,company,visitnum,visittj,mail,attention,demand,Job,Wh,jtsr,personnum,region,contactperson,signatory,nexus,chishu,homejg,visitname,nowjuarea,payment,bbj,sj,yixianmianji,floor,fiment,Likes,evection,in_chamber,Car,work,Chamberes_tabt,Age_range,hjsl,zj)";
		sql=sql+" values('"+section+"','"+cusno+"','"+name+"','"+sex+"','"+age+"','"+visitstate+"'";
	    sql=sql+",'"+custype+"','"+gmyt+"','"+tj+"','"+tel+"','"+idcard+"','"+addr+"','"+yb+"','"+date+"','"+seller+"','";
        sql=sql+company+"','"+visitnum+"','"+visittj+"','"+mail+"','"+attention+"','"+demand+"'";
		sql=sql+",'"+job+"','"+wh+"','"+jtsr+"',"+personnum+",'"+region+"','"+contactPerson + "','" +name+"'+space(3)"+",'"+nexus+"',"+chishu+",'"+homejg+"','"+visitname+"','"+nowjuarea+"','"+payment + "' , '" + bbj + "' , '" + sj + "','"+yixiangmianji+"','"+floor+"','"+fiment+"','"+ah+"','"+cc+"','"+rh+"','"+car+"','"+zy+"','"+hs+"','"+agefw+"','"+hj+"','"+zj+"')";
    try
    	  {
	         
                   InsertBean.executeUpdate(sql);
		%>
			<script>
			//if (confirm("系统已保存你输入的数据")){window.location="nmcus.jsp?serialno=<%=cusno%>&section=<%=section%>";}
		    //else{
			    <%if (request.getParameter("addnew")!=null){%>
				   //window.opener.document.cus.cusname.value="<%=cusno %>";
				   //window.opener.document.cus.cusname1.value="<%=name %>";
				   //window.opener.document.cus.carid.value="<%=idcard %>";
				   //window.opener.document.cus.tel.value="<%=tel %>";
                   //                window.opener.document.cus.Address.value="<%=addr %>";
                                        
				 <%}else{ %>
				opener.window.location.reload();
				
				<%} %>
				window.close();
				//if (confirm("登记客户购房需求")){window.location="saledemand.jsp?cusno=<%=cusno%>&section=<%=section%>&name=<%=name%>";}
				//else{close();}
			
			</script>
		 <%}
	   catch(SQLException ex)	
	    {
	      out.print("System Error<br>");
           out.println(sql);
	      out.print(ex.getMessage());
	      out.close();
	    }
	 }else{
	 out.print("客户编号："+cusno+"已经存在，<a href='Javascript:window.history.back(1)'>请重新编号</a>");
	 
	 }	
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "客户一览" , 
                          "增加"
                        ) ;
   }
   else if (submit1.equals("modi")){ 

        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "客户一览" , 
                          "修改"
                        ) ;

   cusno=China.getParameter(request,"cusno");
	//Edit date
	sql="update customer set section='"+section+"', Cus_Name='"+name+"'"+",Cus_Sex='"+sex+"'"+",cus_age='"+age+"',Cus_Type='"+custype+"'"+",Purpose='"+gmyt+"'"+",";
	sql=sql+"Knowledge_From='"+tj+"'"+",Phone='"+tel+"'"+",ID_Card='"+idcard+"',mail='"+mail+"',attention='"+attention+"',demand='"+demand+"'";
	sql=sql+",Address='"+addr+"'"+",Zip_Code='"+yb+"',signatory='"+name+"',payment='"+payment+"',nowjuarea='"+nowjuarea+"'";
	sql=sql+",company='"+company+"',visitnum='"+visitnum+"',visittj='"+visittj+"',visit_date='"+date+"',seller='"+seller+"',visitname='"+visitname+"'";
	sql=sql+",Job='"+job+"',Wh='"+wh+"',jtsr='"+jtsr+"',personnum="+personnum+",region='"+region+"',nexus='"+nexus+"',chishu="+chishu+",homejg='"+homejg+"',ContactPerson='"+ContactPerson
	    + "' , bbj = '" + bbj + "' ,zj='"+zj+"',sj = '" + sj + "',yixianmianji='"+yixiangmianji+"',floor='"+floor+"',fiment='"+fiment+"',visitstate="+visitstate + ",Likes='"+ah+"',evection='"+cc+"',in_chamber='"+rh+"',Car='"+car+"',work='"+zy+"',Chamberes_tabt='"+hs+"',Age_range='"+agefw+"',hjsl='"+hj+"'  where SerialNo='"+cusno+"'";
  
	try{
    	InsertBean.executeUpdate(sql);
	    out.print("系统已接受你的修改");
		OK="TRUE";
	%>
	 <script>
	    //opener.window.document.cus.carid.value="<%=idcard %>";
	    //opener.window.document.cus.tel.value="<%=tel %>";
	    //opener.window.document.cus.sj.value="<%=sj %>";
        //    opener.window.document.cus.Address.value="<%=addr %>";
	 </script>
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
 <%if (request.getParameter("edit")==null||request.getParameter("edit").trim().equals("null")){%>
opener.window.location.reload();
<%} %>
 close();
</script>

<%} 
}catch(Exception s){out.print("dd");}%>
</body>
</html>

