 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>�������</title>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*,common.*" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
  <%@ include file="../public_js/qx_checke.jsp"%>

<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

</head>
<script>
function printReport(urlValue){
  openwin(urlValue,700,300,50,100);

}</script>
<body>
<%  String SecName=China.getParameter(request,"SecName");
    String SecNo=China.getParameter(request,"SecNo");
	String Loft= China.getParameter(request, "Loft") ;
	String Build=China.getParameter(request,"Build"); 
    String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";
%>
<form name=frm method="post" action="ReportMange.jsp">
<input type=hidden name=SecNo value="<%=SecNo%>">
<input type=hidden name=SecName value="<%=SecName%>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=Build value="<%=Build %>">
<input type=hidden name=cusname value="">
<input type=hidden name=secname value="">

<table width="820" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('RoomCodeShowS.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��ͬ�Ǽ�</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('ContractNoM.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��ͬ�Ź���</font></a>
	</td>
	 <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('ContractJz.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��֤����</font></a>
	</td>
	 <td class="<%if(sel.equals("9")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=9;findSub('contract_yj.jsp');"><font color='<%if(sel.equals("9")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�ƽ�����</font></a>
	</td>
	<td class="<%if(sel.equals("6")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=6;findSub('rh_view.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�뻧����</font></a>
	</td>
	<!--
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('contract_view.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>δ��˺�ͬ</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('contract_view.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>����˺�ͬ</font></a>
	</td>
	-->
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('contract_yh_view.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�Ż����</font></a>
	</td>
	
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('paymoneyProcess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������</font></a>
	</td>
	<td class="<%if(sel.equals("7")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=7;findSub('contract_view.jsp');"><font color='<%if(sel.equals("7")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���Ȩ���</font></a>
	</td>
	<td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=5;findSub('ReportMange.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������</font></a>
	</td>
	<td class="<%if(sel.equals("8")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=8;findSub('contract_wycl.jsp');"><font color='<%if(sel.equals("8")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>ΥԼ����</font></a>
	</td>
   </tr>
<input type=hidden name=sel value="<%=sel%>">
 </table>
<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
<table width="100%" cellspacing cellpadding>
  <tr>
    <td width="100%" height="40"></td>
  </tr>
  <tr>
    <td width="100%" align="center" bordercolor="#678DC0">
      <table width="425" cellspacing cellpadding>
        <tr>
          <td width="52" valign="top"><img border="0" src="../images/bb-pic.gif" width="52" height="242"></td>
          <td width="373" valign="top">
            <table width="100%" cellspacing cellpadding style="border: 1 solid #FFFFFF">
              <tr>
                
              <td width="100%" height="25" align="center" class=listtitle><b><font color="#FFFFFF" size="3">��������</font></b></td>
              </tr>
              <tr>
                <td width="100%">
                  <table width="100%" cellspacing="1" cellpadding>
                    <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="#" onclick="openwin1('auto_select.jsp?PARA_SQL=viewSaleList&url=1&reporttype=sale&tablename=',700,300,20,10);" >������ϸ����</a></font></td><!--view_skprocess-->
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=saleview&url=4&reporttype=sale&tablename=')">���۷���ͳ��</a></font></td>
                    </tr>
                    <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font class="FontColor" size="2" color="#000080"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=yezhulist&url=2&reporttype=sale&tablename=')">ҵ�����ϱ�</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font class="FontColor" size="2" color="#000080"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=ajcustomerlist&url=5&reporttype=sale&tablename=')">���ҿͻ���ϸ��</a></font><!--<a href="javascript:printReport('auto_select.jsp?PARA_SQL=tairanAlAjWfkList&url=5&reporttype=sale&tablename=')">�Ѱ���δ�ſ�ͻ���ϸ��</a>-->
					  <input type="hidden" name="monthpic" value="1">
					  <!--<select name="monthpic">
                         
						  <option value="1" selected>ֱ��ͼ</option>
                          <option value="1">����ͼ</option>
                        </select>
						-->
						</td>
                    </tr>

                    <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=saleview&url=12&reporttype=sale&tablename=')">Ԥ�۷ֻ����ܱ�</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_print.jsp');">�ɽ������ϸ��</a><!--<a href="javascript:printReport('auto_select.jsp?PARA_SQL=tairanAlAjYfkList&url=7&reporttype=sale&tablename=')">�Ѱ����ѷſ�ͻ���ϸ��</a></font>--></td>
                    </tr>
                   <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=SaleCountPic_View&url=8&reporttype=sale&tablename=')">���������ͼ</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=ViewSectionData&url=9&reporttype=sale&tablename=')">¥�����ϱ�</a></font></td>
                    </tr>
                     <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select2.jsp?PARA_SQL=viewSaleList&url=11&reporttype=sale&tablename=')">���ۼ�</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><!--<a href="javascript:printReport('auto_select1.jsp?PARA_SQL=viewSaleList&url=11&reporttype=sale&tablename=')">���ۼ�2(�ֶ�)</a>-->
<a href="javascript:printReport('print_sale_s.jsp')">���ۻ��ܱ�</a>
</font></td>
                    </tr>   
					  <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select3.jsp')">����ͳ�Ʊ�</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=AjCountList&url=13&reporttype=sale&tablename=')">�������ͳ�Ʊ�</a></font></td>
                    </tr>   
					  <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect4.jsp?type=1')">�����ܱ�</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect8.jsp?type=2')">�����±�</a></font></td>
                    </tr>  
					 <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect4.jsp?type=3')">�ٶ���ϸ</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('printPrice.jsp?type=1');">��ӡ�۸��</a></font>  </td>
                    </tr>    
					 <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('print_payment_con.jsp?type=1')">���ʽ����</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('print_payment_con.jsp?type=2');">�˷����</a></font>  </td>
                    </tr>   
					<tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('print_today_rep.jsp')">�����ձ�</a></font></td>
                   <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect5.jsp?type=1')">���ܳɽ���ϸ��</a></font></td>
                   
                    </tr>    
					<tr >
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect5.jsp?type=2')">�ͻ������</a></font></td>
                   <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect5.jsp?type=3')">�ɽ��ͻ�����</a></font></td>
                   
                    </tr>    
					<tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect5.jsp?type=4')">������ϸ��1</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('sale_select.jsp?PARA_SQL=viewSaleList')">���������ѯ</a></font></td>
                    
                   
                    </tr>    
					<tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect5.jsp?type=6')">�Ż�������</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=viewSaleList&url=19&reporttype=sale&tablename=')">��ͬ�ǼǱ�</a></font></td>
                    
                   
                    </tr>   
					<tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=ViewSectionData&url=20&reporttype=sale&tablename=')">Ԥ�ۼ۸���ϸ��</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=ViewSectionData&url=22&reporttype=sale&tablename=')">ȫ����ϸ��</a></font></td>
                    
                   
                    </tr>  
					  <tr>                      
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font   class=FontColor> <a href="javascript:printReport('../finance/autoselect4.jsp?url=10')" >�ܼ۱仯��ϸ��</a></font></td>
                                            <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font   class=FontColor><a href="javascript:printReport('autoselect9.jsp?type=5')" > ��˰�걨��(�б�)</a></font></td>
                     </tr>
					  <tr>                      
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font   class=FontColor> <a href="javascript:printReport('auto_select.jsp?PARA_SQL=viewSaleList&url=21&reporttype=sale&tablename=');" >��˰�걨��(�״�)</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font   class=FontColor> <a href="javascript:printReport('autoselect5.jsp?type=7')" > �ƻ�������</a></font></td>
                     </tr>
                  </table>
                </td>
              </tr>
		 
  <tr> 
    <td width="100%">&nbsp;</td> 
  </tr>
 
</table> 
<input type=hidden name=choose value="3">
<input type=hidden name=url value=1>
<input type=hidden name=rgorsale>

 </form>
</body> 
 
</html> 
