<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>复制房间编码或资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet href="../class/mad.css" >
<link rel=stylesheet href="../class/news.css" >
</head>

<%@ page import="java.sql.*;" %>   
<jsp:useBean id="paymentDetailBean" scope="page" class="ConnDatabase.SDatabase" /> 
<jsp:useBean id="paymentDetailBean1" scope="page" class="ConnDatabase.SDatabase" /> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>

 <script>	  
	  function submitValidate() {
	  	 if (document.frm.section.value==""){alert("请选择源项目");return false;}
		var aa="";
		for (var j=0;j<document.frm.tosection.length;j++){
	       if (document.frm.tosection[j].selected)
		   aa="aa";
		    
	    }
		 if (aa==""){alert("请选择目标项目");return false;}
		return true;
	 }
	  
		function SavePayment(){
        if (submitValidate())
			{
		     
			 document.frm.submit();

			}

		}
</script> 
   <%
 		 String Cortrol= checke_qx(paymentDetailBean,(String)session.getAttribute("loginid"),"B006");
		String aad =getbyte1(request.getParameter("aad"));
		String sql="";
        if (!aad.equals("")){
		    String  section=getbyte1(request.getParameter("SecNo"));
			 String  Loft=getbyte1(request.getParameter("Loft"));
			 section+=Loft;
		    String  [] tosections=request.getParameterValues("tosection");
			String cr=getbyte1(request.getParameter("cr"));
            String tosection="";
			ResultSet rs1=null;	

            if (tosections!=null){
	            for (int a=0;a<tosections.length;a++){
				    tosection=getbyte1(tosections[a]);
				  String  SQL="SELECT * FROM LoftBuildCode WHERE SECNO+LOFT='"+section+"'";
				    ResultSet rsc=paymentDetailBean.executeQuery(SQL);	
				   if (rsc.next()){
				   
				    SQL="update LoftBuildCode set JieGou='"+rsc.getString("JieGou")+"'";
					SQL+=",floors="+rsc.getString("floors");
					
					String JianChenDate=getbyte(rsc.getString("JianChenDate"));
					if (!JianChenDate.equals(""))
					SQL+=",JianChenDate='"+JianChenDate+"'";
					String kp_date=getbyte(rsc.getString("kp_date"));
					if (!kp_date.equals(""))
						SQL+=",kp_date='"+kp_date+"'";
					String kf_date=getbyte(rsc.getString("kf_date"));
					if (!kf_date.equals(""))
						SQL+=",kf_date='"+kf_date+"'"; 
					SQL+=",DiHao='"+rsc.getString("DiHao")+"'";
					SQL+=",TuHao='"+rsc.getString("TuHao")+"'";
				    SQL+=",JianZhuJiDi_area="+rsc.getString("JianZhuJiDi_area");
					SQL+=",JianZhuSum_area="+rsc.getString("JianZhuSum_area");
				    SQL+=",ZongNum="+rsc.getString("ZongNum");
					String jiaolouDate=getbyte(rsc.getString("jiaolouDate"));
					if (!jiaolouDate.equals(""))
					SQL+=",jiaolouDate='"+jiaolouDate+"'";
					
					SQL+=",p1='"+rsc.getString("p1")+"'";
					SQL+=",p2='"+rsc.getString("p2")+"'";
					SQL+=",p3='"+rsc.getString("p3")+"'";
					SQL+=",p4='"+rsc.getString("p4")+"'";
					SQL+=",p5='"+rsc.getString("p5")+"'";
					SQL+=",gytdsyz='"+rsc.getString("gytdsyz")+"'";
					SQL+=",yyzzh='"+rsc.getString("yyzzh")+"'";
					SQL+=",zzzh='"+rsc.getString("zzzh")+"'";
					SQL+=",fzdbr='"+rsc.getString("fzdbr")+"'";
					SQL+=",tdsyqcrh='"+rsc.getString("tdsyqcrh")+"'";
					SQL+=",ysxkz='"+rsc.getString("ysxkz")+"'";
					SQL+=",htwh='"+rsc.getString("htwh")+"'";
					SQL+=",zdmj='"+rsc.getString("zdmj")+"'";
					SQL+=",ghxkz='"+rsc.getString("ghxkz")+"'";
					SQL+=",sgxkz='"+rsc.getString("sgxkz")+"'";
					SQL+=",cq_addr='"+getbyte(rsc.getString("cq_addr"))+"'";
					String e_year=getbyte(rsc.getString("e_year"));
					if (!e_year.equals(""))
					SQL+=",e_year='"+e_year+"'";
					String s_year=getbyte(rsc.getString("s_year"));
					if (!s_year.equals(""))
					SQL+=",s_year='"+s_year+"'";
					String e_year1=getbyte(rsc.getString("e_year1"));
					if (!e_year1.equals(""))
					SQL+=",e_year1='"+e_year1+"'";
					String s_year1=getbyte(rsc.getString("s_year1"));
					if (!s_year1.equals(""))
					SQL+=",s_year1='"+s_year1+"'";
					SQL+=",fzs='"+getbyte(rsc.getString("fzs"))+"'";
					String jldate=getbyte(rsc.getString("jldate"));
					if (!jldate.equals(""))
					SQL+=",jldate='"+jldate+"'";
					SQL+="  WHERE SECNO+LOFT='"+tosection+"'";		
					 
					paymentDetailBean.executeUpdate(SQL);
				   }
				   rsc.close();
				   out.print("复制成功!");
				  
		            
               }
			   %>
			   <script>
			   alert("已复制完成,请点击楼栋名称查看");
			  window.location="LoftInfo.jsp";
			   </script>
			   <%
           }
		}
   		 
  %> 
  <body>
  
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
   <form name=frm action="copyLoft.jsp">
 
<input type=hidden name=SecNo value="<%=getbyte1(request.getParameter("SecNo")) %>">
<input type=hidden name=SecName value="<%=getbyte1(request.getParameter("SecName")) %>">
<input type=hidden name=Loft value="<%=getbyte1(request.getParameter("Loft")) %>">
<input type=hidden name=Build value="<%=getbyte1(request.getParameter("Build")) %>">
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	      <a href="#" onclick="document.frm.sel.value=0;findSub('LoftInfo.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>楼栋资料</font> </a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('copyRoomCode.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>复制资料</font></a>
	</td>
	 
	</tr></table>
	<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
<p align=center class=FontColor><font size=3 ><b>复制房间编码</b></font></p>
<center>
 
 <input type=hidden name=aad value="dd">
 <table width="100%"  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
 <tr> <td width="35%" class=roomleft>&nbsp;&nbsp;源项目名称：</td><td width="65%" class=roomright>&nbsp;<select name="section" > 
   <option></option>
   
<%  

	  if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select s.SerialNo+r.region SerialNo ,s.Name+r.region  name from CRM_Project s,roomno r where r.SectionNo=s.serialno and s.serialno='"+request.getParameter("SecNo")+"' group by s.SerialNo+r.region   ,s.Name+r.region order by s.SerialNo+r.region";

	  ResultSet rs2=paymentDetailBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
      rs2.close();
	
     %> </select>

		 </td></tr> 
<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;目标项目名称：</td><td width="65%" class=roomright>&nbsp;<select name="tosection" multiple size=10> 
   
<%  
 
        sql1="select s.SerialNo+r.region SerialNo ,s.Name+r.region  name from CRM_Project s,roomno r where r.SectionNo=s.serialno and  s.serialno='"+request.getParameter("SecNo")+"' group by s.SerialNo+r.region   ,s.Name+r.region order by s.SerialNo+r.region ";

	    rs2=paymentDetailBean.executeQuery(sql1);	
	 
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  rs2.close();
	
     %> </select></td></tr> 
	<!--<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;复制房间资料：</td><td width="65%" class=roomright>&nbsp;<input type=checkbox name=cr value=1>(选中表示复制编码的同时复制房间资料)</td></tr>
-->
	</table>
	<p align=center>
	 <%if  (Cortrol.indexOf("A")>=0){ %>
<INPUT TYPE="button" NAME="Submit2" VALUE="确认复制" ONCLICK="SavePayment()">&nbsp;<!--<INPUT TYPE="button" NAME="Submit2" VALUE="明  细" ONCLICK="javascript:detail()">-->&nbsp;<%} %></form>
</center>
 </form>
</body>
</html>
