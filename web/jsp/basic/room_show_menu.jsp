<%@ include file="../public_js/checktime.jsp"%>
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=0;findSub('crm_RoomCodeList1.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>录入资料</font> 
	</td>
	<td class="<%if(sel.equals("1")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.form1.sel.value=1;findSub('Room_list.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>查看资料</font></a>
	</td>
	 
	</tr></table>
	<script>
function findSub(para){
   document.form1.action=para+"?Search=b&Find=b";
   document.form1.submit();


}
</script>