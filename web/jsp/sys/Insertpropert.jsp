<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>新增客户资料</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%
    String  sql="";
	String ch="";
    String deleid=request.getParameter("deleid");

	if (deleid!=null){
	   sql="delete UserTable where UserId='"+deleid+"'";
	   InsertBean.executeUpdate(sql);
	
	 response.sendRedirect("userview.jsp");
	 
	}
	int userid=java.lang.Integer.parseInt(request.getParameter("id"));
    String  sub=request.getParameter("submit");
	
	        sub= new String(sub.getBytes("ISO8859_1"),"GBK");
    String  name=request.getParameter("name");
 	        if (name!=null){
			name= new String(name.getBytes("ISO8859_1"),"GBK");
			}
    String  id=request.getParameter("ID");
	        if (id!=null){
			id= new String(id.getBytes("ISO8859_1"),"GBK");
			}
	String  pass=request.getParameter("pass");
	        if (pass!=null){
			pass= new String(pass.getBytes("ISO8859_1"),"GBK");
			}
    String  type=request.getParameter("type");
	String  scale=request.getParameter("scale");
    String  cus=request.getParameter("cus");
	String  rg=request.getParameter("rg");
	String  sale=request.getParameter("sale");
	String  sec=request.getParameter("sec");
	String  cw=request.getParameter("cw");
	String  cwedit = request.getParameter("cwedit");
	String  serv=request.getParameter("serv");
       String  disc=request.getParameter("disc");


String bedit= request.getParameter("bedit");
    String binput= request.getParameter("binput");
	String cedit= request.getParameter("cedit");
    String cinput= request.getParameter("cinput");
	String sedit= request.getParameter("sedit");
    String sinput= request.getParameter("sinput");
	String fedit= request.getParameter("fedit");
    String finput= request.getParameter("finput");
	String sfedit= request.getParameter("sfedit");
    String sfinput= request.getParameter("sfinput");
    String today=request.getParameter("today");
	String userStr = "";

	 if (today==null)
		today = "0";
     if (scale==null)
	    scale = "0";

     if (disc==null)
		disc = "0";
   if (bedit==null)
		bedit = "0";
   if (binput==null)
		binput = "0";		
    if (cedit==null)
		cedit = "0";
   if (cinput==null)
		cinput = "0";		
   if (sedit==null)
		sedit = "0";
   if (sinput==null)
		sinput = "0";		
   if (fedit==null)
		fedit = "0";
   if (finput==null)
		finput = "0";					
    if (sfedit==null)
		sfedit = "0";
   if (sfinput==null)
		sfinput = "0";
	if (cus==null){
	  cus="0";
	  }
    if (rg==null){
	  rg="0";
	  }
    if (sale==null){
	  sale="0";
	  }
 	if (sec==null){
	   sec="0";
	  }
    if (cw==null){
	  cw="0";
	  }
    if (cwedit==null){
	  cwedit="0";
	  }

    if (serv==null){
	  serv="0";
	  }
	if ((scale==null)){
	  scale="0";
	  }
	if (sub.equals("确认")){
    	sql="insert into UserTable (UserId,UserPas,name,Type, scale,disc,cus, rgs,"; 
        sql=sql+" sale,service,sec, cw,cwedit)";
	    sql=sql+" values('"+id+"','"+pass+"','"+name+"',"+type+","+scale+","+disc+","+cus;
    	sql=sql+","+rg+","+sale+","+serv+","+sec+","+cw+ "," + cwedit + ")"; 
		ch="1";
     }else if (sub.equals("确认修改")){
	    sql="update UserTable set Type="+type+",scale="+scale+",cus="+cus+",disc="+disc+",name='"+name+"'";
		sql=sql+",rgs="+rg+",sale="+sale+",service="+serv+",sec="+sec+",cw="+cw+ ",cwedit=" + cwedit ;
              sql=sql+",b_edit="+bedit+",b_input="+binput+",c_edit="+cedit+",c_input="+cinput+",s_edit="+sedit+",s_input="+sinput+",f_edit="+fedit+",f_input="+finput+",sf_edit="+sfedit+",sf_input="+sfinput+",today="+today+"   where id="+userid;
	    ch="2";
	 }
    InsertBean.executeUpdate(sql);

	if (ch.equals("1")){
  %>
    <script language=javascript>
      if  (confirm("是否继续设置权限？[N]:返回已分配的列表")){
        window.location="uerset.jsp";
     	}
	 else{
	   window.location="SellerList.jsp";
    	}
  </script>
  <%}else{ %>
     系统已接受修改<a href="SellerList.jsp">返回</a>
  <%} %>
</body>
</html>
