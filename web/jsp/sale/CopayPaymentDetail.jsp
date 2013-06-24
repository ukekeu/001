<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>复制付款方案</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel=stylesheet href="../class/mad.css" >
<link rel=stylesheet href="../class/news.css" >
</head>
<script src="js/mad.js"> </script>
<script>
	function deletePayment() {
	  	document.cus.payment_oper.value = "dele";
		
		return false;
	  }
	function fulldate(){
	 var dateValue=new Date();
	 var year="";
	 var month="";
	 var day="";
	 if (dateValue.getMonth()+1>=10)month=dateValue.getMonth()+1;
	 else month="0"+(dateValue.getMonth()+1);
	 if (dateValue.getDate()+1>=10)day=dateValue.getDate();
	 else day="0"+(dateValue.getDate());
	 
	   document.cus.Date1.value=dateValue.getYear()+"-"+month+"-"+day;
	}  
</script>




<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<%@ page import="java.sql.*;" %>   
<jsp:useBean id="paymentDetailBean" scope="page" class="ConnDatabase.SDatabase" /> 
<jsp:useBean id="paymentDetailBean1" scope="page" class="ConnDatabase.SDatabase" /> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
 <script>	  
	  function submitValidate() {
	  	 if (document.cus.section.value==""){alert("请选择源项目");return false;}
		var aa="";
		for (var j=0;j<document.cus.tosection.length;j++){
	       if (document.cus.tosection[j].selected)
		   aa="aa";
		    
	    }
		 if (aa==""){alert("请选择目标项目");return false;}
		return true;
	 }
	 
</script> 
   <%
 		
		String aad =getbyte1(request.getParameter("aad"));
		String sql="";
        if (!aad.equals("")){
		    String  section=getbyte1(request.getParameter("section"));
		    String  [] tosections=request.getParameterValues("tosection");
            String tosection="";
		 
			ResultSet rs2=null;
			ResultSet rs1=null;
            if (tosections!=null){
	            for (int a=0;a<tosections.length;a++){
				    tosection=getbyte1(tosections[a]);
					
					sql="select id from payment where seccoe='"+section+"'";
					rs1=paymentDetailBean.executeQuery(sql);
					while (rs1.next()){
					 int  id=rs1.getInt("id");
				 
				    sql="insert into PayMent select '"+tosection+"',payname,num,ExDate,";
					sql+="EnDate,Discont,PrePay,qdate,ajdate,send,gddate,type,youhui,bak,0";
					sql+=" from payment where  id="+id;
				   
					
				    paymentDetailBean1.executeUpdate(sql);
					 sql="select  max(id) id from payment where seccoe='"+tosection+"'";
					rs2=paymentDetailBean1.executeQuery(sql);
					int payid=0;
					if (rs2.next())payid=rs2.getInt("id");
					rs2.close();
					sql="insert into PayDetail select "+String.valueOf(payid)+",num,PayDate";
					sql+=",scale,Note,state1,state2,Date,money,state3,state4,state5,send from";
					sql+=" PayDetail where PayCode in (select id from payment where id="+id+")";
					   paymentDetailBean1.executeUpdate(sql);
					 
				    out.print("复制成功!");
				  }
				  rs1.close();
		            
               } 
			   %>
			   <script>
			   alert("已复制完成");opener.document.form1.submit();window.close();
			   </script>
			   <%
           }
		}
   		 
  %> <Script>
  		 
		function SavePayment(){
        if (submitValidate())
			{
		     
			 document.cus.submit();

			}

		}
	 
  </script>
  <body>
<p align=center class=FontColor><font size=3 ><b>复制付款方案</b></font></p>
<center>
<form name="cus" method="post" action="" > 
 <input type=hidden name=aad value="dd">
 <table width="100%"  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
 <tr> <td width="35%" class=roomleft>&nbsp;&nbsp;源项目名称：</td><td width="65%" class=roomright>&nbsp;<select name="section" > 
   <option></option>
   
<%  

	  if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+") and   SerialNo in (SELECT  seccoe FROM PayMent group by seccoe ) ";

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
 
        sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+") and not SerialNo in (SELECT  seccoe FROM PayMent group by seccoe ) ";

	    rs2=paymentDetailBean.executeQuery(sql1);	
	 
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  rs2.close();
	
     %> </select></td></tr> 
	
	</table>
	<p align=center>
<INPUT TYPE="button" NAME="Submit2" VALUE="提  交" ONCLICK="SavePayment()">&nbsp;<!--<INPUT TYPE="button" NAME="Submit2" VALUE="明  细" ONCLICK="javascript:detail()">-->&nbsp;<INPUT TYPE="button" NAME="Submit3" VALUE="退  出" onclick="window.close();"></form>
</center>
 
</body>
</html>
