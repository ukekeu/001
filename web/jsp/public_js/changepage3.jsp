<%@ page contentType="text/html;charset=GBK" %>
<%
	  int sum=0;
	  
	  ResultSet rscount=ViewBean.executeQuery(sqlcount);
	  if(rscount.next()){
	   sum=rscount.getInt(1);
	  }rscount.close();
	  
	  if(sum==0){
	   pagecount=0;
	  }else{
	     pagecount=sum/pageSize;
	     if (sum%pageSize>0){
	      pagecount=pagecount+1;
	     }
	  }%>
    <%if(pagecount>0){%>
	 <table align="center" bgColor="#efefef" border="0" cellPadding="0" cellSpacing="0" style="BORDER-BOTTOM: 1px ridge; BORDER-LEFT: 1px ridge; BORDER-RIGHT: 1px ridge; BORDER-TOP: 1px ridge" width="100%">
					<tbody>
					  <tr>
					    <td><span style="WIDTH: 30px"></span> <img height="9" src="../images/indicator2.gif" width="9"> ����<span id="RecordCount"><%=sum %></span>����¼&nbsp;ÿҳ��ʾ<input type="text" size=2 name="pagesize" value="<%=pageSize%>" class="textinput">��</td>
					    <td align="right"><%if(previous>0){%><a href="javascript:goto(<%=previous%>);"><img src="../images/arrow_left.gif" id="imgLeft" align="absmiddle" style="cursor:hand"   width="8" height="8" border="0"></a><%}else{%><img src="../images/arrow_left.gif" id="imgLeft" align="absmiddle" style="cursor:hand"  width="8" height="8"><%}%> �� <label id="PageNo"><%=pageno%></label> &nbsp;ҳ ��<span id="PageCount" title="sfsf" value="sadf" text="sdf"><font color="red"><%=pagecount%></font></span>ҳ 
					    ������ <input size="2" name="pageno"  value="<%=pageno%>" id="PageNo1" maxlength="3" onkeypress="if(event.keyCode == 13)ListPageControl.GotoPage(this.value);"> ҳ&nbsp;  <a onclick="goto(document.all.pageno.value);" style="cursor:hand">GO</a>
					 <%if(pageno<pagecount){%><a href="javascript:goto(<%=next%>);"><img src="../images/arrow_right.gif" id="imgRight" align="absmiddle" style="cursor:hand"   width="8" height="8" border="0"><%}else{%><img src="../images/arrow_right.gif" id="imgLeft" align="absmiddle" style="cursor:hand"  width="8" height="8"><%}%> 
						</td>
					  </tr>
					</tbody>
	 </table>
	 
   
   <script language="JavaScript">
    function goto(pageno){
	  pagesize=document.all.pagesize.value;
	  if(isNaN(pagesize) || pagesize==""){
	   tmpsize=10;
	  }else{
	   tmpsize=parseInt(pagesize);
	  }
	
	  if(tmpsize>100){tmpsize=100;}
	  document.all.pagesize.value=tmpsize;
	  pagecount=parseInt(<%=sum%>/tmpsize);
	  if(<%=sum%>%tmpsize>0){
	   pagecount=pagecount+1;
	  }
	  if(isNaN(pageno)){
	    alert("����������");
	    document.all.pageno.value="";
	    document.all.pageno.focus();
	  }else{
	   tmp=parseInt(pageno);
	   if(tmp<0 || tmp>pagecount){
	     alert("�����ҳ��������");
		 document.all.pageno.value="";
		 document.all.pageno.focus();
	   }else{
	   document.all.pageno.value=pageno;
	   document.cus.submit();
	   }
	  }
	}
	function gotolast(){
	   pagesize=document.all.pagesize.value;
	  if(isNaN(pagesize) || pagesize==""){
	   tmpsize=10;
	  }else{
	   tmpsize=parseInt(pagesize);
	  }
	  if(tmpsize>100){tmpsize=100;}
	  document.all.pagesize.value=tmpsize;
	  pagesize=document.all.pagesize.value;
	  pageno=parseInt(<%=sum%>/pagesize);
	  if(<%=sum%>%pagesize>0){
	    pageno=pageno+1;
	  }

	  document.all.pageno.value=pageno;
	  	 
	  document.cus.submit();
	}
   </script>
    <%}%>
</form>
</body>

</html>