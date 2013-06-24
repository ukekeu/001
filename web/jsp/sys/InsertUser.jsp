<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%!
	public String getParameter(javax.servlet.http.HttpServletRequest request,String para)
								throws Exception  {
		String temp = "";
		temp = request.getParameter(para);
		if (temp == null)
			temp = "";
		temp = new String(temp.getBytes("ISO8859_1"),"GBK");
		return temp;	
	}
%>
<%
	String name = getParameter(request,"name");
	String id = getParameter(request,"ID");
	String password = getParameter(request,"pass");
	String type = getParameter(request,"type");
	String scale = getParameter(request,"scale");
	String cus = getParameter(request,"cus");
	String rg = getParameter(request,"rg");
	String sale = getParameter(request,"sale");
	String sec = getParameter(request,"sec");
	String cw = getParameter(request,"cw");
	String serv = getParameter(request,"serv");
	String cw1= getParameter(request,"cw1");
	String disc= getParameter(request,"disc");
    String bedit= getParameter(request,"bedit");
    String binput= getParameter(request,"binput");
	String cedit= getParameter(request,"cedit");
    String cinput= getParameter(request,"cinput");
	String sedit= getParameter(request,"sedit");
    String sinput= getParameter(request,"sinput");
	String fedit= getParameter(request,"fedit");
    String finput= getParameter(request,"finput");
	String sfedit= getParameter(request,"sfedit");
    String sfinput= getParameter(request,"sfinput");
    String today= getParameter(request,"today");
	String userStr = "";
	 if (today.equals(""))
		today = "0";
     if (scale.equals(""))
	    scale = "0";
     if (disc.equals(""))
		disc = "0";
   if (bedit.equals(""))
		bedit = "0";
   if (binput.equals(""))
		binput = "0";		
    if (cedit.equals(""))
		cedit = "0";
   if (cinput.equals(""))
		cinput = "0";		
   if (sedit.equals(""))
		sedit = "0";
   if (sinput.equals(""))
		sinput = "0";		
   if (fedit.equals(""))
		fedit = "0";
   if (finput.equals(""))
		finput = "0";					
    if (sfedit.equals(""))
		sfedit = "0";
   if (sfinput.equals(""))
		sfinput = "0";			
	if (cus.equals(""))
		cus = "0";
	if (rg.equals(""))
		rg = "0";	
	if (sale.equals(""))
		sale = "0";
	if (sec.equals(""))
		sec = "0";
	if (cw.equals(""))
		cw = "0";
	if (serv.equals(""))
		serv = "0";				
	if (cw1.equals(""))
		cw1 = "0";			
	userStr = "insert into usertable(userid,userpas,name,type,";
	userStr += "scale,sec,cus,rgs,sale,cw,service,cwedit,disc,state,b_edit,b_input,c_edit,c_input,s_edit,s_input,f_edit,f_input,sf_edit,sf_input,today) values('";
	userStr += id + "','" + password + "','" + name + "','";
	userStr += type + "','" + scale + "'," + sec +  "," + cus + ",";
	userStr += rg + "," + sale + "," + cw + "," + serv +","+cw1+","+disc+ ",1"+","+bedit+","+binput+","+cedit+","+cinput+","+sedit+","+sinput+","+fedit+","+finput+","+sfedit+","+sfinput+","+today+")";
	//out.print(userStr); 
	try {
		aBean.executeUpdate(userStr);
          
		out.print("用户添加成功");
	}catch(Exception ee) {
		out.print("用户添加失败，可能ID号相同了，请重新输入或联系系统管理员");
              out.print(ee.getMessage());   
	} 
	
	//if (serv.equals(""))
	//	out.print("null");
	
%>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">

<a href="userset.jsp">返回</a>
</BODY>
</HTML>
