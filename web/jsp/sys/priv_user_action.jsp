<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import="java.sql.*" %>
<%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="updateBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="viewBean" scope="page" class="ConnDatabase.SDatabase" />
<title>保存权限</title>
<%!
	public String getParameter(javax.servlet.http.HttpServletRequest request,String para)
								throws Exception  {
		String temp = "";
		temp = request.getParameter(para);
		if (temp == null)
			temp = "";
		temp = new String(temp.getBytes("iso-8859-1"));
		return temp;	
	}
%>
<%
	String sqlPriv = "";
	String sqlPri = "";
	String delPriv = "";
	String uptown =getParameter(request,"uptown");
	String zid=getParameter(request,"zid");
	String zname=getParameter(request,"zname"); 
	String ONLYREAD = getParameter(request,"OnlyRead");
	if(ONLYREAD==null){
		ONLYREAD = "";
	}
	String ONLYWRITE = getParameter(request,"OnlyWrite");
	if(ONLYWRITE==null){
		ONLYWRITE = "";
	}
	String OnlyYL= getParameter(request,"OnlyYL");
	if(OnlyYL==null){
		OnlyYL = "";
	}
	String ONLYDELETE = getParameter(request,"OnlyDelete");
	if(ONLYDELETE==null){
		ONLYDELETE = "";
	}
	String ONLYMODIFY = getParameter(request,"OnlyModify");
	if(ONLYMODIFY==null){
		ONLYMODIFY = "";
	}
	String OnlyDisc = getParameter(request,"OnlyDisc");
	if(OnlyDisc==null){
		OnlyDisc = "";
	}
	String OnlyCheck= getParameter(request,"OnlyCheck");
	if(OnlyCheck==null){
		OnlyCheck = "";
	}
	String OnlyF = getParameter(request,"OnlyF");
	if(OnlyF==null){
		OnlyF = "";
	}
    String checked="";
	checked=ONLYREAD+ONLYWRITE+ONLYDELETE+ONLYMODIFY+OnlyDisc+OnlyF+OnlyCheck+OnlyYL;
	String action_flag = getParameter(request,"action_flag");

	if(action_flag.equals("del")){
		String[] MODEL_NO = request.getParameterValues("active");
		for(int i=0;i<MODEL_NO.length;i++)
		{
		    if(MODEL_NO[i].indexOf("-")>0){
			sqlPriv="delete from ManModuleCortrol where SellerId='"+zid+"' and "+
			        "ManModule  in (select MModuleNo from ModuleCortrol where CModuleNo='"+MODEL_NO[i].substring(MODEL_NO[i].indexOf("-")+1,MODEL_NO[i].length())+"' and nexus='P') and section like '%"+uptown+"%'";
		    
			sqlPri="delete from PopedomConrtrol where SellerId='"+zid+"' and "+
			        "ManModuleNo='"+MODEL_NO[i].substring(0,MODEL_NO[i].indexOf("-"))+"' and ModuleNo='"+MODEL_NO[i].substring(MODEL_NO[i].indexOf("-")+1,MODEL_NO[i].length())+"'";
			}else{
			sqlPriv="delete from ManModuleCortrol where SellerId='"+zid+"' and "+
			        "ManModule ='"+MODEL_NO[i]+"' and section like '%"+uptown+"%'";
			sqlPri="delete from PopedomConrtrol where SellerId='"+zid+"' and "+
			        "ManModuleNo='"+MODEL_NO[i]+"'";
		    }
			//out.print(sqlPriv);
			//out.print("<br>"+sqlPri);
			//out.close();
			try{
				updateBean.executeUpdate(sqlPriv);
				updateBean.executeUpdate(sqlPri);
			}
			catch(Exception se){
				
			}
		}
		
		%> 
		<script language=javascript>
   			alert("权限取消成功！"); 
   			var topage="priv_user.jsp?uptown=<%=uptown%>&zid=<%=zid %>&zname=<%=zname %>&x="+Math.random();
			window.location =topage;
		</script>
	<%
	}	
	else{
		
		String[] MODEL_NO = request.getParameterValues("model_ename");
		for(int i=0;i<MODEL_NO.length;i++){
		if(MODEL_NO[i].indexOf("-")>0){
			sqlPriv="select sellerid from ManModuleCortrol where SellerId='"+zid+"'and ManModule='"+MODEL_NO[i].substring(0,MODEL_NO[i].indexOf("-"))+"'";   
			ResultSet temprs=viewBean.executeQuery(sqlPriv);
			if(!temprs.next())
			  {updateBean.executeUpdate("insert into ManModuleCortrol (SellerId,ManModule,cortrol,section) values ('"+zid+"' , "+
			        "'"+MODEL_NO[i].substring(0,MODEL_NO[i].indexOf("-"))+"','"+checked+"','"+uptown+"') ");
			  }temprs.close();
			sqlPriv="select sellerid from PopedomConrtrol where SellerId='"+zid+"'and ManModuleNo='"+MODEL_NO[i].substring(0,MODEL_NO[i].indexOf("-"))+"' and ModuleNo='"+MODEL_NO[i].substring(MODEL_NO[i].indexOf("-")+1,MODEL_NO[i].length())+"'";   
			 temprs=viewBean.executeQuery(sqlPriv);
			if(!temprs.next())
			  {sqlPri="insert into  PopedomConrtrol (SellerId,ManModuleNo,ModuleNo,checked) values('"+zid+"' , "+
			        "'"+MODEL_NO[i].substring(0,MODEL_NO[i].indexOf("-"))+"' ,'"+MODEL_NO[i].substring(MODEL_NO[i].indexOf("-")+1,MODEL_NO[i].length())+"','"+checked+"')";
			   updateBean.executeUpdate(sqlPri);
			  }temprs.close();
			}else{
			sqlPriv="select sellerid from ManModuleCortrol where SellerId='"+zid+"'and ManModule='"+MODEL_NO[i]+"'";   
			ResultSet temprs=viewBean.executeQuery(sqlPriv);
			if(!temprs.next()){
			   sqlPriv="insert into ManModuleCortrol (SellerId,ManModule,cortrol,section) values ('"+zid+"' , "+
			        "'"+MODEL_NO[i]+"','"+checked+"','"+uptown+"') ";
		       updateBean.executeUpdate(sqlPriv);
		       }temprs.close();
		    }
		}
	    
		%> 
		<script language=javascript>
		    alert("授权成功！"); 
   			var topage="priv_user.jsp?uptown=<%=uptown%>&zid=<%=zid %>&zname=<%=zname %>&x="+Math.random();
			window.location =topage;
		</script>
 <%} %>