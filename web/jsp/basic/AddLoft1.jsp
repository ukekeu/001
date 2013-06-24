<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>请输入楼栋名序号范围</title>
<%  String loft1=China.getParameter(request,"Loft1");
    String SecNo=China.getParameter(request,"SecNo");
    String loft2=China.getParameter(request,"Loft2"); 
	String hz=China.getParameter(request,"hz"); 
    String SQL="";
	String Eof="false";
  	 
	if (!loft1.equals("")){
	 try{
	   ResultSet rsLoft=null;
	   for (int aa=java.lang.Integer.parseInt(loft1);aa<=java.lang.Integer.parseInt(loft2);aa++){
 
	   SQL="select * from LoftBuildCode where SecNo='"+SecNo+"' and Loft='"+String.valueOf(aa)+hz+"'";
	    rsLoft=ViewBean.executeQuery(SQL);
        if (rsLoft.next()){
         Eof="true";
        }
	    String Losts="";
		if (aa<10&&java.lang.Integer.parseInt(loft2)>9) Losts=" "+String.valueOf(aa);
		else Losts=String.valueOf(aa);
        rsLoft.close();
	    if (Eof.equals("false")){
          SQL="insert into LoftBuildCode(SecNo,Loft) values('"+SecNo+"','"+Losts+hz+"')";
  
	      
	      ViewBean.executeUpdate(SQL);
		  setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "楼栋资料" , 
                  "增加楼栋("+SecNo+Losts+hz+")"
                ) ;
		}
		 }	
		 out.print("<script>");
		out.print("alert('系统接受你的操作!,请刷新');");
		out.print("opener.parent.TreeList.window.location.reload();");
	    out.print("window.close();");
		out.print("</script>");
	    
	 }catch(Exception e){out.print(e);}
	}
   
   %>

</head>
<script language="javascript" src="../public_js/public.js">
</script>
<SCRIPT language=javascript>
     function Validate(aForm)
   {

		if (aForm.Loft2.value.length<1)
	    	{
	    	alert("请开始楼栋序号！");
	        aForm.Loft1.focus();
	        return (false);
	    	}	
		if (aForm.Loft2.value.length<1)
	    	{
	    	alert("请结束楼栋序号！");
	        aForm.Loft2.focus();
	        return (false);
	    	}	
		if (aForm.hz.value.length<1)
	    	{
	    	alert("请填写楼栋后缀！");
	        aForm.hz.focus();
	        return (false);
	    	}		
		return (true);
   }   
   function toUpper(aa){
    var a=aa.value;
    aa.value=a.toUpperCase();
  }
   function setfocus()
   {
   		cus.Loft.focus();
   }

</SCRIPT> 
 
<body class=listcontent topmargin="0" >
<form method="POST" name="cus" action="AddLoft1.jsp" onsubmit="return Validate(this);">
 <input type="hidden" name="SecNo" value="<%=request.getParameter("SecNo") %>">
 
 <table class=parent id=KB3Parent border="0" width="100%"  align="center" height="70">
    
	 <tr><td>&nbsp;楼栋范围：</td><td><input type=text size=10 name=Loft1 onblur="checkNaN(this);">到<input type=text size=10 name=Loft2 onblur="checkNaN(this);"></td></tr>
    <tr><td>&nbsp;楼栋后缀：</td><td><input type=text size=10 name=hz >(如：栋、座...，不能用"-","#")</td></tr>

     <tr> 
        <td  align="center" height="2" colspan="2"> 
             <input type="submit" value="提交" name="submit1" onclick="document.cus.submit();document.cus.submit1.disabled=true;">&nbsp;
             <input type="button" value="退出" name="cl" onclick="window.close();">

        </td>
		</tr>
		<tr><td  colspan="2">批量添加楼栋时，楼栋序号必须是数字表示</td></tr>
    </table>     
     
</form>  
 
   
</body>       
</html>       
