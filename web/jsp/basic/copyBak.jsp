<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>���Ƴ��ñ�עs</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel=stylesheet href="../class/mad.css" >
<link rel=stylesheet href="../class/news.css" >
</head>

<%@ page import="java.sql.*;" %>   
<jsp:useBean id="paymentDetailBean" scope="page" class="ConnDatabase.SDatabase" /> 
<jsp:useBean id="paymentDetailBean1" scope="page" class="ConnDatabase.SDatabase" /> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
 <script>	  
	  function submitValidate() {
	  	 if (document.frm.section.value==""){alert("��ѡ��Դ��Ŀ");return false;}
		var aa="";
		for (var j=0;j<document.frm.tosection.length;j++){
	       if (document.frm.tosection[j].selected)
		   aa="aa";
		    
	    }
		 if (aa==""){alert("��ѡ��Ŀ����Ŀ");return false;}
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
 		
		String aad =getbyte1(request.getParameter("aad"));
		  String section = getbyte1(request.getParameter("SecNo"));
		 String strLoft = getbyte1(request.getParameter("Loft"));
		String sql="";
        if (!aad.equals("")){
	       String Csection=getbyte1(request.getParameter("section"));
		    String  [] tosections=request.getParameterValues("tosection");
			String cr=getbyte1(request.getParameter("cr"));
            String tosection="";
			ResultSet rs1=null;	

            if (tosections!=null){
	            for (int a=0;a<tosections.length;a++){
				    tosection=getbyte1(tosections[a]);
				  
				  strLoft=tosection.substring(section.length());
					 String SQL="insert into loft_zhuangxiu select '"+section+"','"+strLoft+"',";
					 SQL+="waiqiang,nieqing,dingpeng,dimian,mengchuang";
	                 SQL+=",chufang,wc,yangtai,dianti,other,fentanshoming,buchongxieyi,gonggongsheshi1";
	                 SQL+=",gonggongsheshi2,gonggongsheshi3,gonggongsheshi4,gonggongsheshi5";
	                 SQL+=",gonggongsheshi6,gonggongsheshi7,gonggongsheshi8,paybak,yong_tu,TYPE";
					 SQL+=" FROM loft_zhuangxiu WHERE secno+loft='"+Csection+"'";
					// out.print(SQL);
					 paymentDetailBean.executeUpdate(SQL);
				   }
			 
	 		   %>
			   <script>
			   alert("�Ѹ������");
			   window.history.back(1);
		 
			   </script>
			   <%
           }
		}
   		 
  %> 
  <body>
  
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
   <form name=frm action="copyBak.jsp">
 
 <input type=hidden name=SecNo value="<%=section %>">
 
<input type=hidden name=Loft value="<%=strLoft %>">
 
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="510" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;document.frm.action='BakList.jsp';document.frm.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>װ�α�׼</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;document.frm.action='BakList.jsp';document.frm.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>����Э��</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;document.frm.action='BakList.jsp';document.frm.submit();"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��̯˵��</font></a>
	</td>
	<td class="<%if(sel.equals("4")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=4;document.frm.action='BakList.jsp';document.frm.submit();"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>������ʩ</font></a>
	</td>
	<td class="<%if(sel.equals("5")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=5;document.frm.action='BakList.jsp';document.frm.submit();"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���ע</font></a>
	</td>
	<td class="<%if(sel.equals("6")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=6;document.frm.action='copyBak.jsp';document.frm.submit();"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���Ʊ�ע</font></a>
	</td>
   </tr></table>
	 
<p align=center class=FontColor><font size=3 ><b>���Ʒ������</b></font></p>
<center>
 <%
      String sql1="select s.SerialNo+r.loft SerialNo ,s.Name+r.loft  name from CRM_Project s,loft_zhuangxiu r where r.SecNo=s.serialno and s.serialno='"+request.getParameter("SecNo")+"' group by s.SerialNo+r.loft   ,s.Name+r.loft order by s.SerialNo+r.loft";
 
 %>
 <input type=hidden name=aad value="dd">
 <table width="100%"  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
 <tr> <td width="35%" class=roomleft>&nbsp;&nbsp;Դ��Ŀ���ƣ�</td><td width="65%" class=roomright>&nbsp;<select name="section" > 
   <option></option>
   
<%  
 
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
<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;Ŀ����Ŀ���ƣ�</td><td width="65%" class=roomright>&nbsp;<select name="tosection" multiple size=10> 
   
<%  
 
        sql1="select s.SerialNo+r.loft SerialNo ,s.Name+r.loft  name from CRM_Project s,LoftBuildCode r where not  r.SecNo+r.loft in (select secno+loft from loft_zhuangxiu) and r.SecNo=s.serialno and  s.serialno='"+request.getParameter("SecNo")+"' group by s.SerialNo+r.loft   ,s.Name+r.loft order by s.SerialNo+r.loft ";

	    rs2=paymentDetailBean.executeQuery(sql1);	
	 
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  rs2.close();
	
     %> </select></td></tr> 
	<!--<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;���Ʒ������ϣ�</td><td width="65%" class=roomright>&nbsp;<input type=checkbox name=cr value=1>(ѡ�б�ʾ���Ʊ����ͬʱ���Ʒ�������)</td></tr>
-->
	</table>
	<p align=center>
<INPUT TYPE="button" NAME="Submit2" VALUE="��  ��" ONCLICK="SavePayment()">&nbsp;<!--<INPUT TYPE="button" NAME="Submit2" VALUE="��  ϸ" ONCLICK="javascript:detail()">-->&nbsp;<INPUT TYPE="button" NAME="Submit3" VALUE="��  ��" onclick="window.close();"></form>
</center>
 
</body>
</html>
