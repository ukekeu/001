<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>复制付款方案</title>
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
	  	 if (document.cus.section.value==""){alert("请选择源项目");return false;}
		var aa="";
		for (var j=0;j<document.cus.tosection.length;j++){
	       if (document.cus.tosection[j].selected)
		   aa="aa";
		    
	    }
		 if (aa==""){alert("请选择目标项目");return false;}
		return true;
	 }
	  
		function SavePayment(){
        if (submitValidate())
			{
		     
			 document.cus.submit();

			}

		}
</script> 
   <%
 		
		String aad =getbyte1(request.getParameter("aad"));
		String sql="";
        if (!aad.equals("")){
		    String  section=getbyte1(request.getParameter("section"));
		    String  [] tosections=request.getParameterValues("tosection");
			String cr=getbyte1(request.getParameter("cr"));
            String tosection="";
			ResultSet rs1=null;	
			
            if (tosections!=null){
	            for (int a=0;a<tosections.length;a++){
				    tosection=getbyte1(tosections[a]);
					String sss=tosection.substring(0,tosection.indexOf("|"));
					String bbb=tosection.substring(tosection.indexOf("|")+1);
					 sql="select loft+'|'+(case when build is null then '' else build end) as ll from LoftBuildCode where secno+Loft='"+sss+bbb+"' and secno+loft+(case when build is null then '' else build end)<> '"+section+"' group by loft+'|'+(case when build is null then '' else build end) ";
				  ResultSet rs3=paymentDetailBean.executeQuery(sql);	
				  
					String a1="",a2="";
					 while (rs3.next()){
					   String a3=getbyte(rs3.getString("ll"));
					   a1=a3.substring(0,a3.indexOf("|"));
					  a2=a3.substring(a3.indexOf("|")+1);
				    sql="insert into roomno select '"+sss+"','"+a1+"','"+a2+"',Floor,";
					if (!cr.equals("")) 
					  sql+="Room,RoomNo,1,send,type,FloorType,FloorShow,floormess,showfloors,cell";
					else 
					  sql+="Room,RoomNo,0,send,type,FloorType,FloorShow,floormess,showfloors,cell ";
					sql+=" from roomno where  SectionNo+Region='"+section+"'";
					//复制编码
					 
				//	out.print(sql+"<br>");
				   paymentDetailBean1.executeUpdate(sql); 
					sql="insert into LoftBuildCode(secno,Loft,Build,state,JieGou,floors,JianChenDate,DiHao,TuHao,JianZhuJiDi_area,JianZhuSum_area,ZongNum,jiaolouDate)  select '"+sss+"','"+a1+"','"+a2+"',state";
					sql+=",JieGou,floors,JianChenDate,DiHao,TuHao,JianZhuJiDi_area,";
					sql+="JianZhuSum_area,ZongNum,jiaolouDate from LoftBuildCode where  secno='"+sss+"' and  SecNo+loft+(case when build is null then '' else build end)<>'"+section+"'";
					//复制楼栋 
			 paymentDetailBean1.executeUpdate(sql);
					
					if (!cr.equals("")){
					   sql="insert into room(seccode,Loft,Building,Room_code,room,Floor,useryear,Area,Y_Area,gl_area,Room_Type,Direction,Scene,Fitment,salestate,UsedArea,Y_UsedArea,Serve_Date,Roomtype,yong_tu,Unitprice,Y_Unitprice,Sumprice,Y_Sumprice,room_price,Map,BasePrice,TNunitprice,Y_TNunitprice,out,loke,lokedate,saleloke,salelokedate,send,type,floortype,floorshow,floormess,maap_state,maap_userarea,maap_area,maap_date,lu_tai_area,lu_tai_mapp_area,lu_tai_area_price,c_lt_price,yang_tai_area,yang_tai_mapp_area,yang_tai_price,yang_tai_zhao_yarea,yang_tai_zhao_price,yang_tai_zhao_sarea,ftjd_area,ftyd_area,ty_area,ty_y_area,ty_area_price,c_ty_price,dt_area,dt_y_area,dt_area_price,s_year,e_year,yxz_area,yxz_area_price,cg,wd_area,wd_area_price,wd_y_area,counttype,cell)  select '"+sss+"','"+a1+"','"+a2+"',Room_code,room,Floor,useryear,Area,Y_Area,gl_area,Room_Type,";
					   sql+="Direction,Scene,Fitment,1,UsedArea,Y_UsedArea,Serve_Date,Roomtype,yong_tu,Unitprice,Y_Unitprice,Sumprice,";
					   sql+="Y_Sumprice,room_price,Map,BasePrice,TNunitprice,Y_TNunitprice,out,loke,lokedate,saleloke,salelokedate,send,type,floortype,floorshow,floormess,maap_state,maap_userarea,maap_area,maap_date,";
                       sql+="lu_tai_area,lu_tai_mapp_area,lu_tai_area_price,c_lt_price,yang_tai_area,yang_tai_mapp_area,yang_tai_price,yang_tai_zhao_yarea,yang_tai_zhao_price,";
                       sql+="yang_tai_zhao_sarea,ftjd_area,ftyd_area,ty_area,ty_y_area,ty_area_price,c_ty_price,dt_area,dt_y_area,dt_area_price,s_year,e_year,yxz_area,yxz_area_price,cg,wd_area,wd_area_price,wd_y_area,counttype,cell";
                      
					   sql+=" from room where  seccode+loft='"+section+"'";
				      //复制房间资料
 
					    paymentDetailBean1.executeUpdate(sql);
                    
		
					}
					
					 }
					 rs3.close();
				   out.print("复制成功!");
				  
		            
               }
			   %>
			   <script>
			   alert("已复制完成");window.close();
			   </script>
			   <%
           }
		}

   		 
  %> 
<body topmargin="1"    >
  
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
   <form name=cus action="copyRoomCode.jsp">
     <input type="hidden" name="SecNo" value=<%=getbyte2(request.getParameter("SecNo"))%>>
	  <input type="hidden" name="Loft" value="<%=getbyte2(request.getParameter("Loft"))%>">
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	   <a href="#" onclick="document.cus.sel.value=0;findSub('RoomCodeInput.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>房源定义</font> </a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('copyRoomCode.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>编码复制</font></a>
	</td>
	 
	</tr></table>
	<script>
function findSub(para){
   document.cus.action=para+"?Loft=<%=getbyte2(request.getParameter("Loft"))%>&SecNo=<%=getbyte2(request.getParameter("SecNo"))%>";
   document.cus.submit();


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
      String sql1="select s.SerialNo+r.region SerialNo ,s.Name+r.region  name from CRM_Project s,roomno r where r.SectionNo=s.serialno group by s.SerialNo+r.region   ,s.Name+r.region order by s.SerialNo+r.region";

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
		 <%   sql1="select a.secno,a.Loft,b.name from LoftBuildCode a,CRM_Project b where b.SerialNo=a.secno and  a.secno  in("+SectionS+")  and a.secno+a.loft not in (select seccode+loft from room where seccode  in("+SectionS+")) ";
 
 %>
<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;目标项目名称：</td><td width="65%" class=roomright>&nbsp;<select name="tosection" multiple size=10> 
   
<%  
 
     
	    rs2=paymentDetailBean.executeQuery(sql1);	
	 
      while (rs2.next()){
	   no1=rs2.getString("Loft");
	   String section=rs2.getString("secno");
	   sec=getbyte(rs2.getString("name"));
	   
     	out.print("<option value='"+section+"|"+no1+"'>"+sec+no1+"</option>");
	  }
	  rs2.close();
	
     %> </select></td></tr> 
	<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;复制房间资料：</td><td width="65%" class=roomright>&nbsp;<input type=checkbox name=cr value=1>(选中表示复制编码的同时复制房间资料)</td></tr>

	</table>
	<p align=center>
<INPUT TYPE="button" NAME="Submit2" VALUE="提  交" ONCLICK="SavePayment()">&nbsp;<!--<INPUT TYPE="button" NAME="Submit2" VALUE="明  细" ONCLICK="javascript:detail()">-->&nbsp;<INPUT TYPE="button" NAME="Submit3" VALUE="退  出" onclick="window.close();"></form>
</center>
 
</body>
</html>
