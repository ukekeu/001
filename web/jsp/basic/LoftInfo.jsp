<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import = "java.sql.*" %>
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
<%@ include file="../public_js/qx_checke.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<title>楼栋信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body bgcolor="#FFFFFF" text="#000000"  topmargin="1>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js">

</script>
 <%
 String Cortrol= checke_qx(Bean,(String)session.getAttribute("loginid"),"B006");
  String section2 = getbyte1(request.getParameter("SecNo"));
  String strSecName =getbyte1( request.getParameter("SecName"));
  String strLoft = getbyte1(request.getParameter("Loft"));
  String strBuild = getbyte1(request.getParameter("Build"));
  String room_type= getbyte1(request.getParameter("room_type"));
  String cq_addr= getbyte1(request.getParameter("cq_addr"));
  String SQL="";
  //更新数据
  String dh=getbyte1(request.getParameter("dh"));
  String th=getbyte1(request.getParameter("th"));
  String jg=getbyte1(request.getParameter("jg"));
  String floors=getbyte1(request.getParameter("floors"));

  String date=getbyte1(request.getParameter("date"));
  String date1=getbyte1(request.getParameter("date1"));
  String jldate=getbyte1(request.getParameter("jldate"));
  String jj=getbyte1(request.getParameter("jj"));

  String jz=getbyte1(request.getParameter("jz"));

  String ts=getbyte1(request.getParameter("ts"));
  String roomtype =getbyte1(request.getParameter("roomtype"));
  String ddd=getbyte1(request.getParameter("ddd"));
  String p1=getbyte1(request.getParameter("p1"));
  String p2=getbyte1(request.getParameter("p2"));
  String p3=getbyte1(request.getParameter("p3"));
  String p4=getbyte1(request.getParameter("p4"));
  String p5=getbyte1(request.getParameter("p5"));  
  String sy1=getbyte1(request.getParameter("sy1"));  
  String ey1=getbyte1(request.getParameter("ey1")); 
  String sy=getbyte1(request.getParameter("sy"));  
  String ey=getbyte1(request.getParameter("ey"));   
  String fzs=getbyte1(request.getParameter("fzs"));  
  String ysxkz =getbyte1(request.getParameter("ysxkz"));  
  String fwxz =getbyte1(request.getParameter("fwxz"));  
  String tdxz =getbyte1(request.getParameter("tdxz"));  
  String gytdsyz=getbyte1(request.getParameter("gytdsyz"));  
  String yyzzh=getbyte1(request.getParameter("yyzzh"));  
  String zzzh=getbyte1(request.getParameter("zzzh"));  
  String fzdbr=getbyte1(request.getParameter("fzdbr"));  
  String tdsyqcrh=getbyte1(request.getParameter("tdsyqcrh"));  
  String zdmj=getbyte1(request.getParameter("zdmj"));  
  String ghxkz=getbyte1(request.getParameter("ghxkz"));  
  String sgxkz=getbyte1(request.getParameter("sgxkz"));  
  String htwh=getbyte1(request.getParameter("htwh"));  
  String kf_date=getbyte1(request.getParameter("kf_date"));  
  String kp_date=getbyte1(request.getParameter("kp_date"));  
  
  if (!ddd.equals("")){
    try{ 
       SQL="update LoftBuildCode set room_type='"+room_type+"', roomtype="+roomtype+",JieGou='"+jg+"',floors="+floors+",TuHao='"+th+"',tdxz='"+tdxz+"',fwxz='"+fwxz+"'";
	   SQL+=",p1='"+p1+"',p2='"+p2+"',p3='"+p3+"',p4='"+p4+"',p5='"+p5+"',ysxkz='"+ysxkz+"'";
	   SQL+=",sgxkz='"+sgxkz+"',ghxkz='"+ghxkz+"',zdmj='"+zdmj+"',tdsyqcrh='"+tdsyqcrh+"',fzdbr='"+fzdbr+"',zzzh='"+zzzh+"'";
	  SQL+=",yyzzh='"+yyzzh+"',htwh='"+htwh+"'";
	  
	
	    
	   if (!kp_date.equals(""))
	     SQL+=",kp_date='"+kp_date+"'";
		else
		    SQL+=",kp_date=null";
	  
	  if (!kf_date.equals(""))
	     SQL+=",kf_date='"+kf_date+"'";
		else
		    SQL+=",kf_date=null";
			
	    if (!date.equals(""))
	     SQL+=",JianChenDate='"+date+"'";
		else
		    SQL+=",JianChenDate=null";
	    SQL+=",DiHao='"+dh+"',JianZhuJiDi_area="+jj+",JianZhuSum_area="+jz;
	    if (!date1.equals(""))
	     SQL+=",jiaolouDate='"+date1+"'";
		else
		   SQL+=",jiaolouDate=null";
		if (!jldate.equals(""))
	     SQL+=",jldate='"+jldate+"'";
		else
		   SQL+=",jldate=null";
		if (!sy1.equals(""))
	     SQL+=",s_year1='"+sy1+"'";
		else 
		 SQL+=",s_year1=null";
		 if (!ey1.equals(""))
	     SQL+=",e_year1='"+ey1+"'";
		else
		 SQL+=",e_year1=null";
		 if (!sy.equals(""))
	     SQL+=",S_year='"+sy+"'";
		else
		 SQL+=",S_year=null";
		 if (!ey.equals(""))
	      SQL+=",e_year='"+ey+"'";
		else
		  SQL+=",e_year=null";
		if (!fzs.equals(""))  
		  SQL+=",fzs='"+fzs+"'";
	    SQL+=",ZongNum="+ts+",cq_addr='"+cq_addr+"',gytdsyz='"+gytdsyz+"'  WHERE SECNO='"+section2+"' AND LOFT='"+strLoft+"'";
	  Bean1.executeUpdate(SQL);
	    
	   if (!sy.equals("")&&!ey.equals(""))
	   { SQL="update room set Room_Type='"+room_type+"',s_year='"+sy+"',e_year='"+ey+"',useryear=datediff(yy,'"+sy+"',DATEADD(day, 1, '"+ey+"'))";
	    if (!jldate.equals(""))
		 SQL+=",Serve_Date='"+jldate+"'";
		 SQL+="where loft='"+strLoft+"' and seccode='"+section2+"' and yong_tu in('复式住宅','住宅','车位','车库','别墅')" ;
	     Bean1.executeUpdate(SQL);
	   }
	   if (!sy1.equals("")&&!ey1.equals(""))
	   { SQL="update room set Room_Type='"+room_type+"',s_year='"+sy1+"',e_year='"+ey1+"',useryear=  datediff(yy,'"+sy1+"',DATEADD(day, 1, '"+ey1+"'))";
	     if (!jldate.equals(""))
		 SQL+=",Serve_Date='"+jldate+"'";
		 SQL+=" where loft='"+strLoft+"' and seccode='"+section2+"' and not yong_tu in('复式住宅','住宅','车位','车库','别墅')" ;
	     Bean1.executeUpdate(SQL);
		
	   }
	   if (!jldate.equals("")){
	   
	     SQL="update room set Room_Type='"+room_type+"',Serve_Date='"+jldate+"'";
		 SQL+=" where loft='"+strLoft+"' and seccode='"+section2+"' " ;
	     Bean1.executeUpdate(SQL);
		  SQL="update order_contract set JLDATE='"+jldate+"'";
		 SQL+=" where loft='"+strLoft+"' and section='"+section2+"' " ;
	     Bean1.executeUpdate(SQL);
		
	   }
    }catch(Exception s){out.print("执行出错"+s+SQL);}
  }else{
  
      SQL="SELECT * FROM LoftBuildCode WHERE SECNO='"+section2+"' AND LOFT='"+strLoft+"'";
    try{ 
   	ResultSet rs=Bean.executeQuery(SQL);
	if (rs.next()){
	    jg=getbyte(rs.getString("JieGou"));
		
	    floors=getbyte(rs.getString("floors"));
        dh=getbyte(rs.getString("DiHao"));
	    th=getbyte(rs.getString("tuHao"));
	    kf_date=getbyte(rs.getString("kf_date"));
		if (!kf_date.equals(""))kf_date=kf_date.substring(0,10);
		kp_date=getbyte(rs.getString("kp_date"));
		if (!kp_date.equals(""))kp_date=kp_date.substring(0,10);
	    date=getbyte(rs.getString("JianChenDate"));
	    jj=getbyte(rs.getString("JianZhuJiDi_area"));
	    jz=getbyte(rs.getString("JianZhuSum_area"));
	    ts=getbyte(rs.getString("ZongNum"));
	    date1=getbyte(rs.getString("jiaolouDate"));
		p1=getbyte(rs.getString("p1"));
		p2=getbyte(rs.getString("p2"));
		p3=getbyte(rs.getString("p3"));
		p4=getbyte(rs.getString("p4"));
		p5=getbyte(rs.getString("p5"));
		ysxkz=getbyte(rs.getString("ysxkz"));
	    if (!date1.equals(""))date1=date1.substring(0,10);
		if (!date.equals(""))date=date.substring(0,10);
		cq_addr=getbyte(rs.getString("cq_addr"));
		sy1=getbyte(rs.getString("s_year1"));
		if (!sy1.equals(""))sy1=sy1.substring(0,10);
		ey1=getbyte(rs.getString("e_year1"));
		sy=getbyte(rs.getString("s_year"));
		ey=getbyte(rs.getString("e_year"));
		fzs=getbyte(rs.getString("fzs"));
		fwxz=getbyte(rs.getString("fwxz"));
		tdxz=getbyte(rs.getString("tdxz"));
		jldate=getbyte(rs.getString("jldate"));
		gytdsyz=getbyte(rs.getString("gytdsyz"));
		zdmj=getbyte(rs.getString("zdmj"));
		sgxkz=getbyte(rs.getString("sgxkz"));
		ghxkz=getbyte(rs.getString("ghxkz"));
		fzdbr=getbyte(rs.getString("fzdbr"));
		zzzh=getbyte(rs.getString("zzzh"));
		yyzzh=getbyte(rs.getString("yyzzh"));
		htwh=getbyte(rs.getString("htwh"));
		if (!jldate.equals(""))jldate=jldate.substring(0,10);
		if (!sy.equals(""))sy=sy.substring(0,10);
		if (!ey.equals(""))ey=ey.substring(0,10);
		if (!ey1.equals(""))ey1=ey1.substring(0,10);
		roomtype=getbyte(rs.getString("roomtype"));
		room_type=getbyte(rs.getString("room_type"));
	
      } rs.close();
	 }catch(Exception s){out.print("执行出错"+s+SQL);}
    
  
  }
   if (ts.equals(""))ts="0";
   if (jz.equals(""))jz="0";
   if (jj.equals(""))jj="0";
    if (p5.equals(""))p5="0";
   if (floors.equals(""))floors="0";
  %>
 
 
<form name="frm" method="post" action="LoftInfo.jsp"> 

<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	    <a href="#" onclick="document.frm.sel.value=0;findSub('LoftInfo.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>楼栋资料</font> </a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('copyLoft.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>复制资料</font></a>
	</td>
	</tr></table>
	<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
<input type=hidden name=ddd  >
<input type=hidden name=SecNo value="<%=section2 %>">
<input type=hidden name=SecName value="<%=strSecName %>">
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
<% if (strLoft.equals("")){out.print("请选择楼栋");out.close();}
 %>
 　<CENTER>
 <P><FONT SIZE=4><b><%=strSecName+strLoft %>楼栋信息</b></FONT></P>
<table width="90%" border="0" cellpadding="1" cellspacing="1">
   <tr  > 
     <td > 
     房产性质：    </td > <td > <select name=roomtype><option value=0 <%if (roomtype.equals("0")){out.print("selected");} %>>非附属房产</option><option value=1 <%if (roomtype.equals("1")){out.print("selected");} %>>附属房产</option></select>
    </td>
	</tr>
	 <tr  > 
     <td > 
     房产类型：    </td > <td > <select name=room_type>
	 <%
//使用
 
 String StrSql="select type,codename from CODE  where type='c' order by type";
   ResultSet codeRS=null;
   out.print(room_type);
    codeRS=Bean1.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
    String codeName=getbyte(codeRS.getString("codename")) ;
   %>
    <option value="<%=codeName %>" <%if (room_type.equals(codeName)){out.print("selected");} %>><%=codeName%></option>
 	 
  <%}
   codeRS.close(); %>
	 
	 </select>
	  </td>
	</tr>
    <tr  > 
     <td > 
     地&nbsp;&nbsp;号：    </td > <td > <input type=text name=dh value="<%=dh %>" >
    </td>
	</tr>
	<tr>
     <td > 
    图&nbsp;&nbsp;号：</td > <td > <input type=text name=th value="<%=th %>" >
    </td>
    </tr>
	<tr>
     <td > 
    建筑结构：</td > <td > <input type=text name=jg value="<%=jg %>"  >
    </td>
    </tr>
	<tr>
     <td > 
     楼&nbsp;&nbsp;层：</td > <td > <input type=text name=floors value="<%=floors %>" >
    </td>
    </tr>
	<tr>
     <td > 
     开发日期：</td > <td > <input type=text name=kf_date value="<%=kf_date %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(kf_date);return false;">
    </td>
    </tr>
	<tr>
     <td > 
     开盘日期：</td > <td > <input type=text name=kp_date value="<%=kp_date %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(kp_date);return false;">
    </td>
    </tr>
	<tr>
     <td > 
     建成日期：</td > <td > <input type=text name=date value="<%=date %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date);return false;">
    </td>
    </tr>
	<tr>
     <td > 
    实际交楼日期：</td > <td > <input type=text name=date1 value="<%=date1 %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date1);return false;">
    </td>
    </tr>
	<tr>
     <td > 
    预计交楼日期：</td > <td > <input type=text name=jldate value="<%=jldate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jldate);return false;">
    </td>
    </tr>
	<tr>
     <td > 
     建基面积：</td > <td > <input type=text name=jj value="<%=jj %>">
    </td>
    </tr>
	<tr>
     <td > 
     建筑面积：</td > <td > <input type=text name=jz value="<%=jz %>">
    </td>
    </tr>
	 <td > 
     共有使用权面积：</td > <td > <input type=text name=p5 value="<%=p5 %>">
    </td>
    </tr>
	<tr>
     <td > 
     总套数：</td > <td > <input type=text name=ts value="<%=ts %>">
    </td>
    </tr>
	　
 <tr>
     <td > 
     土地四至：</td > <td > <input type=text size=10 name=p1 value="<%=p1 %>"><input type=text size=10 name=p2 value="<%=p2 %>"><input type=text size=10 name=p3 value="<%=p3 %>"><input type=text size=10 name=p4 value="<%=p4 %>">
    </td>
    </tr>
  <tr>
     <td > 
     产权地点</td > <td > <input type=text  name=cq_addr value="<%=cq_addr %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 
     发展商</td > <td > <input type=text  name=fzs value="<%=fzs %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 
     法定代表人</td > <td > <input type=text  name=fzdbr value="<%=fzdbr %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 预售许可证
     </td > <td > <input type=text  name=ysxkz value="<%=ysxkz %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 国有土地使用证号
     </td > <td > <input type=text  name=gytdsyz value="<%=gytdsyz %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 规划许可证号
     </td > <td > <input type=text  name=ghxkz value="<%=ghxkz %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 资质证书号
     </td > <td > <input type=text  name=zzzh value="<%=zzzh %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 营业执照注册号
     </td > <td > <input type=text  name=yyzzh value="<%=yyzzh %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 施工许可证号
     </td > <td > <input type=text  name=sgxkz value="<%=sgxkz %>" size=40> 
    </td>
    </tr>
	
	 <tr>
     <td > 土地使用权出让证号
     </td > <td > <input type=text  name=tdsyqcrh value="<%=tdsyqcrh %>" size=40> 
    </td>
    </tr>
	<tr>
     <td > 占地面积
     </td > <td > <input type=text  name=zdmj value="<%=zdmj %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 房屋所有权性质
     </td > <td > <input type=text  name=fwxz value="<%=fwxz %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 土地性质 
     </td > <td > <input type=text  name=tdxz value="<%=tdxz %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 合同(文号)
	      </td > <td > <input type=text  name=htwh value="<%=htwh %>" size=40> 
    </td>
    </tr>
	 <tr>
     <td > 
    综合用地年限 </td > <td >  <INPUT TYPE=TEXT NAME=sy1 value="<%=sy1 %>" onkeydown="key(document.cus.sd)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(sy1);return false;">到

		  <INPUT TYPE=TEXT NAME=ey1  value="<%=ey1 %>" onkeydown="key(document.cus.ed)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ey1);return false;">
        </td>
    </tr>
	 <tr>
     <td > 
     住宅用地年限</td > <td >  <INPUT TYPE=TEXT NAME=sy value="<%=sy %>" onkeydown="key(document.cus.sd)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(sy);return false;">到

		  <INPUT TYPE=TEXT NAME=ey  value="<%=ey %>" onkeydown="key(document.cus.ed)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ey);return false;">
    
    </td>
    </tr>
</table>
 　</CENTER>
 <p align="center">
 <%if  (Cortrol.indexOf("A")>=0||Cortrol.indexOf("D")>=0){ %>
 <input type=button name=tj value="提  交" onclick="document.frm.ddd.value='ok';document.frm.submit();"><%} %></p>
</p>
</body>
</html>
