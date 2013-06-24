<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import = "java.sql.*" %>
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
<%@ include file="../public_js/qx_checke.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<title>常用备注</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

 <%
  String section2 = getbyte1(request.getParameter("SecNo"));
  String strSecName =getbyte1( request.getParameter("SecName"));
  String strLoft = getbyte1(request.getParameter("Loft"));
  String strBuild = getbyte1(request.getParameter("Build"));
  String sel=(String)request.getParameter("sel");
  String chooseyt= getbyte1(request.getParameter("yongt"));
  if(sel==null) sel="1";	
 
 //更新数据
  String wq=getbyte1(request.getParameter("wq"));
  String nq=getbyte1(request.getParameter("nq"));
  String dp=getbyte1(request.getParameter("dp"));
  String dm=getbyte1(request.getParameter("dm"));
  String mc=getbyte1(request.getParameter("mc"));
  String cf=getbyte1(request.getParameter("cf"));
  String wc=getbyte1(request.getParameter("wc"));
  String dt=getbyte1(request.getParameter("dt"));
  String other=getbyte1(request.getParameter("other"));
  String yt=getbyte1(request.getParameter("yt"));
  String yong_tu=getbyte1(request.getParameter("yong_tu"));
  
  String xy=getbyte1(request.getParameter("xy"));
  
  String ft=getbyte1(request.getParameter("ft"));
  
  
  String a1=getbyte1(request.getParameter("a1"));
  String a2=getbyte1(request.getParameter("a2"));
  String a3=getbyte1(request.getParameter("a3"));
  String a4=getbyte1(request.getParameter("a4"));
  String a5=getbyte1(request.getParameter("a5"));
  String a6=getbyte1(request.getParameter("a6"));
  String a7=getbyte1(request.getParameter("a7"));
  String a8=getbyte1(request.getParameter("a8"));
  
  String fk=getbyte1(request.getParameter("fk"));
  String ddd=getbyte1(request.getParameter("ddd"));
  if (!ddd.equals("")){
    String SQL="SELECT * FROM loft_zhuangxiu WHERE TYPE="+sel+" AND SECNO='"+section2+"' AND LOFT='"+strLoft+"' and yong_tu='"+yong_tu+"'";
    
	try{ 
   	ResultSet rs=Bean.executeQuery(SQL);
	if (rs.next()){
	 if (sel.equals("1")){
	  SQL="update loft_zhuangxiu set waiqiang='"+wq+"',nieqing='"+nq+"',dingpeng='"+dp;
	  SQL+="',dimian='"+dm+"',mengchuang='"+mc+"',chufang='"+cf+"',wc='"+wc+"',";
	  SQL+="yangtai='"+yt+"',dianti='"+dt+"',other='"+other+"',yong_tu='"+yong_tu+"'  WHERE SECNO='"+section2+"' AND LOFT='"+strLoft+"' and yong_tu='"+yong_tu+"'";
	  }else  if (sel.equals("2")){
	    SQL="update loft_zhuangxiu set  buchongxieyi='"+xy+"' WHERE SECNO='"+section2+"' AND LOFT='"+strLoft+"' and yong_tu='"+yong_tu+"'";
	  
	  
	  }else  if (sel.equals("3")){
	    SQL="update loft_zhuangxiu set fentanshoming='"+ft+"'";
	  
	  SQL+="  WHERE SECNO='"+section2+"' AND LOFT='"+strLoft+"' and yong_tu='"+yong_tu+"'";
	
	 }else  if (sel.equals("4")){
	    SQL="update loft_zhuangxiu set gonggongsheshi1='"+a1+"',gonggongsheshi2='"+a2+"',";
	  SQL+="gonggongsheshi3='"+a3+"',gonggongsheshi4='"+a4+"',gonggongsheshi5='"+a5+"',";
	  SQL+=" gonggongsheshi6='"+a6+"',gonggongsheshi7='"+a7+"',gonggongsheshi8='"+a8+"'";
	  SQL+=",paybak='"+fk+"' WHERE SECNO='"+section2+"' AND LOFT='"+strLoft+"' and yong_tu='"+yong_tu+"'";
	  
	  
	}else  if (sel.equals("5")){
	    SQL="update loft_zhuangxiu set  paybak='"+fk+"' WHERE SECNO='"+section2+"' AND LOFT='"+strLoft+"' and yong_tu='"+yong_tu+"'";
	  
	  
	  }
	
	}else{
	  SQL="insert into loft_zhuangxiu(SECNO,LOFT,waiqiang,nieqing,dingpeng,dimian,mengchuang";
	  SQL+=",chufang,wc,yangtai,dianti,other,fentanshoming,buchongxieyi,gonggongsheshi1";
	  SQL+=",gonggongsheshi2,gonggongsheshi3,gonggongsheshi4,gonggongsheshi5";
	  SQL+=",gonggongsheshi6,gonggongsheshi7,gonggongsheshi8,paybak,yong_tu,TYPE) VALUES(";
	  SQL+="'"+section2+"','"+strLoft+"','"+wq+"','"+nq+"','"+dp+"','"+dm+"','"+mc+"','"+cf+"','"+wc+"',";
	  SQL+="'"+yt+"','"+dt+"','"+other+"','"+ft+"'";
	  SQL+=",'"+xy+"','"+a1+"','"+a2+"',";
	  SQL+="'"+a3+"','"+a4+"','"+a5+"',";
	  SQL+=" '"+a6+"','"+a7+"','"+a8+"','"+fk+"','"+yong_tu+"',"+sel+")";
	
	}
  Bean1.executeUpdate(SQL);
  
  
  }catch(Exception s){out.print("执行出错"+s+SQL);}
  }else{
  
    String SQL="SELECT * FROM loft_zhuangxiu WHERE SECNO='"+section2+"' AND LOFT='"+strLoft+"' and yong_tu='"+chooseyt+"' and type="+sel;
    try{ 
   	ResultSet rs=Bean.executeQuery(SQL);
	if (rs.next()){
        wq=getbyte(rs.getString("waiqiang"));
	    nq=getbyte(rs.getString("nieqing"));
	    dp=getbyte(rs.getString("dingpeng"));
	    dm=getbyte(rs.getString("dimian"));
	    mc=getbyte(rs.getString("mengchuang"));
	    cf=getbyte(rs.getString("chufang"));
	    wc=getbyte(rs.getString("wc"));
	    dt=getbyte(rs.getString("dianti"));
	    other=getbyte(rs.getString("other"));
	    yt=getbyte(rs.getString("yangtai"));
	  
	  
	    xy=getbyte(rs.getString("buchongxieyi"));
	  
	    ft=getbyte(rs.getString("fentanshoming"));
	  
	  
	    a1=getbyte(rs.getString("gonggongsheshi1"));
	    a2=getbyte(rs.getString("gonggongsheshi2"));
	    a3=getbyte(rs.getString("gonggongsheshi3"));
	    a4=getbyte(rs.getString("gonggongsheshi4"));
	    a5=getbyte(rs.getString("gonggongsheshi5"));
	    a6=getbyte(rs.getString("gonggongsheshi6"));
	    a7=getbyte(rs.getString("gonggongsheshi7"));
	    a8=getbyte(rs.getString("gonggongsheshi8"));
		fk=getbyte(rs.getString("paybak"));
      }else{
	    wq="X";
	    nq="X";
	    dp="X";
	    dm="X";
	    mc="X";
	    cf="X";
	    wc="X";
	    dt="X";
	    other="X";
	    yt="X";
	  
	  
	    xy="X";
	  
	    ft="X";
	  
	  
	    a1="X";
	    a2="X";
	    a3="X";
	    a4="X";
	    a5="X";
	    a6="X";
	    a7="X";
	    a8="X";
		fk="X";
	  
	  }
	  
	   rs.close();
	 }catch(Exception s){out.print("执行出错"+s+SQL);}
    
  
  }
 
  %>
  <script language="javascript" src="../public_js/public.js">
</script>
 <body>
 
<form name="frm" method="post"> 
<input type=hidden name=sel value="<%=sel%>">
<input type=hidden name=ddd  >
 
 <input type=hidden name=SecNo value="<%=section2 %>">
<input type=hidden name=SecName value="<%=strSecName %>">
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
<% if (strLoft.equals("")){out.println("请选择楼栋");out.close();}
 %>
     
   <table width="510" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;document.frm.action='BakList.jsp';document.frm.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>装饰标准</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;document.frm.action='BakList.jsp';document.frm.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>补充协议</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;document.frm.action='BakList.jsp';document.frm.submit();"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>分摊说明</font></a>
	</td>
	<td class="<%if(sel.equals("4")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=4;document.frm.action='BakList.jsp';document.frm.submit();"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>公共设施</font></a>
	</td>
	<td class="<%if(sel.equals("5")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=5;document.frm.action='BakList.jsp';document.frm.submit();"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>付款备注</font></a>
	</td>
	<td class="<%if(sel.equals("6")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=6;document.frm.action='copyBak.jsp';document.frm.submit();"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>复制备注</font></a>
	</td>
   </tr>

 
</table>
<br>
选择用途：<select name="yongt" onchange="document.frm.submit();">
<option value=""></option>
  <%
 String StrSql="select type,codename,bak from CODE where child=0  and type='YT' order by type";
   ResultSet codeRS=null;
  
    codeRS=Bean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
    %><option value="<%=getbyte(codeRS.getString("codename")) %>"><%=getbyte(codeRS.getString("codename")) %></option>
	<%
	 i++;
   }
   codeRS.close();
 %>	
</select >
<% if (sel.equals("1")){ %>
<table width="99%" border="0" cellpadding="1" cellspacing="1">
  <tr  > 
     <td > 
     外&nbsp;&nbsp;墙：<textarea cols="90" rows="2" name="wq"><%=wq %></textarea>
    </td>
	</tr>
	<tr>
     <td > 
    内&nbsp;&nbsp;墙：<textarea cols="90" rows="2" name="nq"><%=nq %></textarea>
    </td>
    </tr>
	<tr>
     <td > 
     顶&nbsp;&nbsp;棚：<textarea cols="90" rows="2" name="dp"><%=dp %></textarea>
    </td>
    </tr>
	<tr>
     <td > 
     地&nbsp;&nbsp;面：<textarea cols="90" rows="2" name="dm"><%=dm %></textarea>
    </td>
    </tr>
	<tr>
     <td > 
     门&nbsp;&nbsp;窗：<textarea cols="90" rows="2" name="mc"><%=mc %></textarea>
    </td>
    </tr>
	<tr>
     <td > 
     厨&nbsp;&nbsp;房：<textarea cols="90" rows="2" name="cf"><%=cf %></textarea>
    </td>
    </tr>
	<tr>
     <td > 
     卫生间：<textarea cols="90" rows="2" name="wc"><%=wc %></textarea>
    </td>
    </tr>
	<tr>
     <td > 
     阳&nbsp;&nbsp;台：<textarea cols="90" rows="2" name="yt"><%=yt %></textarea>
    </td>
    </tr>
	<tr>
     <td > 
     电&nbsp;&nbsp;梯：<textarea cols="90" rows="2" name="dt"><%=dt %></textarea>
    </td>
    </tr>
	<tr>
     <td > 
    其&nbsp;&nbsp;它：<textarea cols="90" rows="2" name="other"><%=other %></textarea>
    </td>
    </tr>
 <tr>
     <td > 
       </td>
    </tr>
  
</table>
 <%}else if (sel.equals("2")){ %>
 
 <table width="99%" border="0" cellpadding="1" cellspacing="1">
  <tr  > 
     <td > 
     内&nbsp;&nbsp;容：<textarea cols="90" rows="5" name="xy"><%=xy %></textarea>
    </td>
	</tr>
 </table>
  <%}else if (sel.equals("3")){ %>
   <table width="99%" border="0" cellpadding="1" cellspacing="1">
  <tr  > 
     <td > 
     分摊说明：<textarea cols="90" rows="5" name="ft"><%=ft %></textarea>
    </td>
	</tr>
 </table>
<%}else if (sel.equals("4")){ %>
   <table width="99%" border="0" cellpadding="1" cellspacing="1">
  <tr  > 
     <td > 
	 基础设施、公共配套设施建筑按以下日期达到使用条件：
     1、<textarea cols="90" rows="2" name="a1"><%=a1 %></textarea>
	 2、<textarea cols="90" rows="2" name="a2"><%=a2 %></textarea>
     3、<textarea cols="90" rows="2" name="a3"><%=a3 %></textarea>
	 4、<textarea cols="90" rows="2" name="a4"><%=a4 %></textarea>
	 5、<textarea cols="90" rows="2" name="a5"><%=a5 %></textarea>
	</td>
	</tr>
	  <tr  > 
     <td > 
	 如果不能按上述条件，同意以下方式处理：
     1、<textarea cols="90" rows="2" name="a6"><%=a6 %></textarea>
	 2、<textarea cols="90" rows="2" name="a7"><%=a7 %></textarea>
     3、<textarea cols="90" rows="2" name="a8"><%=a8 %></textarea>
	
	</td>
	</tr>
 </table>
 <%}else if (sel.equals("5")){ %>
 <table width="99%" border="0" cellpadding="1" cellspacing="1">
  <tr  > 
     <td > 
     付款备注：<textarea cols="90" rows="5" name="fk"><%=fk %></textarea>
    </td>
	</tr>
 </table> <%} %>
 <%if (yong_tu.equals(""))yong_tu=chooseyt; %>
  所属用途：<input type=text name=yong_tu size=30 readonly value="<%=chooseyt %>"><input type=button name=yt value='..' onclick="openwin('crm_yong_tulist.jsp',200,250,100,100);">
注意:如果没有内容请用"X"表示。
 <p align="center"><input type=button name=tj value="提  交" onclick="document.frm.ddd.value='ok';document.frm.submit();"></p>
</p>
<SCRIPT>
 setSelectMad(document.frm.yongt,'<%=chooseyt %>');
</script>
</body>
</html>
