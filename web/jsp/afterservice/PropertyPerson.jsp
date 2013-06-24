<HTML>
<%@ include file="../public_js/checktime.jsp"%>

 
<head>
<title>产权共有人情况</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
</head>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<script language=javascript src="../public_js/basal.js"> </script>

  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
  <%@ include file="../public_js/qx_checke.jsp"%>
  
  
 

<body>
<% 
    String code=request.getParameter("code");
    String htno=request.getParameter("htno");
    String num=request.getParameter("num");
    String fr=getbyte1(request.getParameter("fr"));
    String dlr=getbyte1(request.getParameter("dlr"));
    String sfz=getbyte1(request.getParameter("sfz"));
    String bak=getbyte1(request.getParameter("bak"));
    String jz=getbyte1(request.getParameter("jz"));
	String ft=getbyte1(request.getParameter("ft"));
	String ey=getbyte1(request.getParameter("ey"));
	String sy=getbyte1(request.getParameter("sy"));
	String syx=getbyte1(request.getParameter("syx"));	
	String qsxz=getbyte1(request.getParameter("qsxz"));	
	String htn=getbyte1(request.getParameter("htn"));	
	
	if (!fr.equals("")){
	  aBean.executeUpdate("delete cq_qy where htno="+code); 
	             String SQL="insert into cq_qy(htno,fr,dlr,sfzh,qs) values(";
			        SQL+=""+code+",'"+fr+"','"+dlr+"','"+sfz+"','"+bak+"')";
		          
				    aBean.executeUpdate(SQL); 
	
	}
	
	if (!jz.equals("")||!ft.equals("")||!sy.equals("")){
	aBean.executeUpdate("delete cq_dj where htno="+code); 
	             String SQL="insert into cq_dj(htno,ftyd_area,jzzd_area,s_year,e_year,yong_tu,qsxz,syx,htn) values(";
			        SQL+=""+code+","+jz+","+ft+",'"+sy+"','"+ey+"','','"+qsxz+"','"+syx+"','"+htn+"')";
		        
				    aBean.executeUpdate(SQL); 
	 
	}
	if (num!=null){
      aBean.executeUpdate("DELETE cq_gyrqk WHERE htno="+code); 
	   aBean.executeUpdate("DELETE cq_zjqk WHERE htno="+code); 
	  for (int ii = 1; ii <9; ii++) {//依次增加合同号
	       String name = China.getParameter(request, "name" + ii) ;
		   String sex = China.getParameter(request, "sex" + ii) ;
		   String age = China.getParameter(request, "age" + ii) ;
		   String jg = China.getParameter(request, "jg" + ii) ;
		   String id = China.getParameter(request, "id" + ii) ;
		   String gx = China.getParameter(request, "gx" + ii) ;
		   String fe = China.getParameter(request, "fe" + ii) ;
		   String ad = China.getParameter(request, "ad" + ii) ;
		 
		   if (!name.equals("")){
		     String SQL="insert into cq_gyrqk(htno,cusname,sex,age,jg,id,gx,num,address,fr,dlr,sfzn,qs) values(";
			        SQL+=""+code+",'"+name+"','"+sex+"','"+age+"','"+jg+"','"+id+"','"+gx+"','"+fe+"','"+ad+"'";
					SQL+=",'"+fr+"','"+dlr+"','"+sfz+"','"+bak+"')";
		           try{
				    aBean.executeUpdate(SQL); 
					  fr="";
					  dlr="";
					  sfz="";
					  bak="";
					}catch(Exception s){out.print(s);}
		   }
		 
	   }
	   
	   
	     for (int ii = 1; ii <6; ii++) {//依次增加合同号
	       String a = China.getParameter(request, "a" + ii) ;
		   String b = China.getParameter(request, "b" + ii) ;
		   String c = China.getParameter(request, "c" + ii) ;
		   String d = China.getParameter(request, "d" + ii) ;
 
		 
		   if (!a.equals("")){
		     String SQL="insert into cq_zjqk(htno,zj_name,zj_no,zj_num,zj_bak) values(";
			        SQL+=""+code+",'"+a+"','"+b+"',"+c+",'"+d+"')";
		           try{
				    aBean.executeUpdate(SQL); 
					}catch(Exception s){out.print(s);}
		   }
	   }
	   
	   %>
	   <script>alert("已保存产权共有人情况及提交证件记录");opener.window.location.reload();//window.close();</script>
	   <%
	}
	
 
%>
<body >
 <%
 String frxm="",dlrxm="",sfzh="",qs="";
 String SQL="SELECT fr,dlr,sfzH,qs FROM cq_qy WHERE fr<>'' and htno="+code;
		ResultSet  rs=aBean.executeQuery(SQL);
 if (rs.next())		  {
   frxm=getbyte(rs.getString("fr"));
   dlrxm=getbyte(rs.getString("dlr"));
   sfzh=getbyte(rs.getString("sfzH"));
   qs=getbyte(rs.getString("qs"));	
 }
	
 SQL="SELECT     ftyd_area,jzzd_area,s_year,e_year,yong_tu,qsxz,syx,htn  FROM cq_dj WHERE htno="+code;
  rs=aBean.executeQuery(SQL);
 if (rs.next())	  {
   jz=getbyte(rs.getString("jzzd_area"));
   if (jz.equals(""))jz="0";
   ft=getbyte(rs.getString("ftyd_area"));
   if (ft.equals(""))ft="0";
   sy=getbyte(rs.getString("s_year"));
   ey=getbyte(rs.getString("e_year"));	
   qsxz=getbyte(rs.getString("qsxz"));	
   syx=getbyte(rs.getString("syx"));	
   htn=getbyte(rs.getString("htn"));	
 } 
	rs.close();		
	if (jz.equals(""))jz="0"; 
	 if (ft.equals(""))ft="0";      
  %>
<form name=frm method=post action="PropertyPerson.jsp">
  <input type=hidden name="htno" value="<%=htno %>">
 <input type=hidden name="code" value="<%=code %>">
 <!--
 <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  >
		<tr  class=TXTColor align="center"> 
			<td  >法定代表人</td>
			<td  >代理人姓名</td>
			<td  >身份证号</td>
			 
	    </tr>
		<tr   align="center"> 
			<td  ><input type=text name="fr" value="<%=frxm %>" ></td>
			<td  > <input type=text name="dlr"  value="<%=dlrxm %>" ></td>
			<td  ><input type=text name="sfz" value="<%=sfzh %>"  ></td>
			 
	    </tr>
		<tr   align="center"> 
			<td  colspan="3" > 产权来源情况:<textarea name=bak cols="80" rows="2"><%=qs %></textarea></td>
			 
	    </tr>
		</table>
		 <P align="center"><b><font size=4>土地情况　</font></b><p>
		 

 <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  >
		<tr  class=TXTColor align="center"> 
			<td  >建筑占地面积</td>
			<td  >分摊用地面积</td>
			<td  >使用开始期限</td>
			<td  >使用结束期限</td>
			 <td  >房屋所有权性质</td>
			<td  >土地权属性质</td> 
				<td  > 文(合同号)</td>
	    </tr>
		<tr   align="center"> 
			<td  ><input type=text name="jz" size=10 value="<%=jz %>"> </td>
			<td  ><input type=text name="ft" size=10  value="<%=ft %>"> </td>
			<td  ><input type=text name="sy" size=10  value=<%=sy %>> <input type=button name=cale value=".." onclick="fPopUpCalendarDlg(sy);return false;"></td>
			<td  ><input type=text name="ey" size=10  value=<%=ey %> > <input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ey);return false;"></td>
			<!--<td  ><input type=text name="syx" size=10 value="<%=syx %>"> </td>
			<td  ><input type=text name="qsxz" size=10  value="<%=qsxz %>"> </td> 
			<td  ><input type=text name="htn" size=10  value="<%=htn %>"> </td>
	    </tr>
	</table>
	-->
	 <P align="center"><b><font size=4>房地共有人情况</font></b><p>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  >
		<tr  class=TXTColor align="center"> 
			<td  >序号</td>
			<td  >姓名</td>
			<td  >性别</td>
			<td  >出生年月</td>
			<td  >籍贯</td>
			<td  >证件号</td>
			<td  >与申请人关系</td>
			<td  >占有份额</td>
			<td  >联系地址</td>
	    </tr>
		<%  SQL="SELECT * FROM cq_gyrqk WHERE htno="+code;
		     rs=aBean.executeQuery(SQL);
		int num1=1;
		 while (rs.next()){
		
		
		 %>
		<tr  align="center"> 
			<td  ><%=num1 %></td>
			<td  ><%=rs.getString("cusname") %></td>
			<td  ><%=rs.getString("sex") %></td>
			<td  ><%=rs.getString("age") %></td>
			<td  ><%=rs.getString("jg") %></td>
			<td  ><%=rs.getString("id") %></td>
			<td  ><%=rs.getString("gx") %></td>
			<td  ><%=rs.getString("num") %></td>
			<td  ><%=rs.getString("address") %></td>
	    </tr>
		<%num1++;}
		rs.close(); %>
	
		<%
		int jj=0;
		for (int i=1 ;i<9;i++){ %>
	   <tr  class=listcontent align="center">
			<td ><%=i %></td>
			<td  ><input type=text name=name<%=i %>   size=10   onkeydown=" key(document.frm.sex<%=i %>);"></td>
			<td  ><input type=text name=sex<%=i %>   size=10  onkeydown=" key(document.frm.age<%=i %>);"></td>
			<td  ><input type=text name=age<%=i %>  size=10   onkeydown=" key(document.frm.jg<%=i %>);"></td>
			<td  ><input type=text name=jg<%=i %>    size=10 onkeydown=" key(document.frm.id<%=i %>);"></td>
			<td  ><input type=text name=id<%=i %>   size=10  onkeydown=" key(document.frm.gx<%=i %>);"></td>
			<td  ><input type=text name=gx<%=i %>   size=10  onkeydown=" key(document.frm.fe<%=i %>);"></td>
			<td  ><input type=text name=fe<%=i %>   size=10  onkeydown=" key(document.frm.ad<%=i %>);"></td>
			<td  ><input type=text name=ad<%=i %>   size=10  onkeydown=" key(document.frm.name<%=i+1 %>);"></td>
    </tr>
		<%jj=i;} %>
	</table>
	<!-- 
	 <P align="center"><b><font size=4>提交证件记录</font></b><p>
	  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  >
		<tr  class=TXTColor align="center"> 
			<td  >序号</td>
			<td  >证件名称</td>
			<td  >证件号</td>
			<td  >件数</td>
			<td  >备注</td>
			 
	    </tr>
		<% 
		SQL="select  * from cq_zjqk where htno="+code;
		
		rs=aBean.executeQuery(SQL);
		  num1=1;
		 while (rs.next()){ %>
		
			<tr    align="center"> 
			<td  ><%=num1 %></td>
			<td  ><%=rs.getString("zj_name") %></td>
			<td  ><%=rs.getString("zj_no") %></td>
			<td  ><%=rs.getString("zj_num") %></td>
			<td  ><%=rs.getString("zj_bak") %></td>
			 
	    </tr>
		<%num1++;}
		rs.close();
		 %>
		
		 <%
		 String fpn="";
		 String sql="select invoice_no from F_invoice where  order_contract="+code;
		     rs=aBean.executeQuery(sql);
		  if (rs.next()){fpn=rs.getString("invoice_no");
		  
		  }
		  rs.close();
		 
		  %>
	   <tr  class=listcontent align="center">
			<td >1</td>
			<td  ><input type=text name=a1   value="购房合同" onkeydown=" key(document.frm.b1);"></td>
			<td  ><input type=text name=b1   value="<%=htno %>"  onkeydown=" key(document.frm.c1);"></td>
			<td  ><input type=text name=c1   value="<%="1" %>"  onkeydown=" key(document.frm.d1);"></td>
			<td  ><input type=text name=d1     onkeydown=" key(document.frm.a2);"></td>
		 </tr>
		  <tr  class=listcontent align="center">
			<td >2</td>
			<td  ><input type=text name=a2   value="发票" onkeydown=" key(document.frm.b2);"></td>
			<td  ><input type=text name=b2   value="<%=fpn %>"  onkeydown=" key(document.frm.c2);"></td>
			<td  ><input type=text name=c2   value="<%="1" %>"  onkeydown=" key(document.frm.d2);"></td>
			<td  ><input type=text name=d2     onkeydown=" key(document.frm.a3);"></td>
		 </tr>
		   <tr  class=listcontent align="center">
			<td >3</td>
			<td  ><input type=text name=a3   value="契税" onkeydown=" key(document.frm.b3);"></td>
			<td  ><input type=text name=b3   value=""  onkeydown=" key(document.frm.c3);"></td>
			<td  ><input type=text name=c3   value="<%="1" %>"  onkeydown=" key(document.frm.d3);"></td>
			<td  ><input type=text name=d3     onkeydown=" key(document.frm.a4);"></td>
		 </tr>
		   <tr  class=listcontent align="center">
			<td >4</td>
			<td  ><input type=text name=a4    onkeydown=" key(document.frm.b4);"></td>
			<td  ><input type=text name=b4    onkeydown=" key(document.frm.c4);"></td>
			<td  ><input type=text name=c4     onkeydown=" key(document.frm.d4);"></td>
			<td  ><input type=text name=d4     ></td>
		 </tr>
	</table>
	-->
	<input type=hidden name=num1 value="6">
		<input type=hidden name=num value="8">
	<p align="center"><input type=button name=tj value="提 交" onclick="document.frm.submit();">	&nbsp;<input type=button name=cl value="退 出" onclick="if (confirm('确认吗?'))window.close();">	
    </p>
  </body>
</html>
