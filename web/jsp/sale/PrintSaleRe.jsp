<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
	<title>打印销售报表</title>
</head>
<script>
self.resizeTo(screen.availWidth,screen.availHeight)
self.moveTo(0,0)
self.focus()
</script>

<body>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="UpdateRs" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="txt" scope="page" class="ConnDatabase.WriteToTxtBean"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<form name=rep>
 <%
   String PARA_SQL=China.getParameter(request,"PARA_SQL");//表名
   String constractno=China.getParameter(request,"url1");
   String if_name=China.getParameter(request,"if_name");
   String if_value=China.getParameter(request,"if_value");
 
   String reporttype=request.getParameter("reporttype1");//报表类别/sale:为销售报表,finace:为财务报表
   String tablename=request.getParameter("tablename1");//如果在VIEW中使用特殊function,则只能更新Table Name
   String ifvalue[]=request.getParameterValues("ifvalue");//读取条件值
   String reportState=China.getParameter(request,"reportState");
  
   String WhereSQL="";
   String WhereSQL1="";
   String SqlStr="";
   String TableNameStr=""; 

 for (int ii=0;ii<ifvalue.length;ii++){//转换值成为组合条件
   if (WhereSQL.equals(""))WhereSQL=getbyte1(ifvalue[ii]);
   else WhereSQL+="  "+getbyte1(ifvalue[ii]);
 }
 
  
  if (reportState.equals("1")){
  
  
   try{
   //保存文件主目录
	 String filepath=request.getRealPath(request.getServletPath());
	 String company=request.getParameter("company");
     String sep=System.getProperty("file.separator");
     String filesep="";
     if(sep.equals("\\"))
      filesep="\\"; //win平台
     else if(sep.equals("/"))
      filesep="/"; //unix平台
     int pos=filepath.lastIndexOf("\\");
     String savepath="";
     if(pos!=-1)
     savepath=filepath.substring(0,pos+1)+"condition"+constractno+".txt";
     String file=txt.WriteToTXT(if_value,if_name,savepath); 
     out.print("系统已自动生成了财务文件文件，文件位于"+savepath);
    // txt.WriteToTXT(if_value,if_name);
  
   }catch(Exception s){out.print("保留条件出错，原因："+s.getMessage());}
    }

TableNameStr=PARA_SQL;
  if (tablename==null)tablename="";
  if (!tablename.equals(""))TableNameStr=tablename;
  if(TableNameStr.equals("SaleCountPic_View"))TableNameStr="rgsview";
  WhereSQL1="update "+TableNameStr+" set out='0' ";// where section='"+secno+"'";
  SqlStr="update "+TableNameStr+"  set out='1'  where " +  WhereSQL;
  if (constractno.equals("17")){//更新送件日期
     SqlStr="update "+TableNameStr+"  set out='1',song_jian_date=getdate()  where " +  WhereSQL;
   } 
try{

  int a=InsertBean.executeUpdate(WhereSQL1);
  int b=InsertBean.executeUpdate(SqlStr);

}catch(Exception s){out.print(s.getMessage()+SqlStr);out.close();}
String reportAddrs=(String)session.getAttribute("reportAddr");

%>
<input type=hidden name=choose value=<%=constractno %>>

<script>

<%if (reporttype.equals("sale")){ %>
if (document.rep.choose.value=="1") window.location="<%=reportAddrs%>saleListRpt.rpt";//SaleDayReport.rpt tairanSaleSKProcessRep.rpt
if (document.rep.choose.value=="4") window.location="<%=reportAddrs%>tairansalelist.rpt";//SaleContractReport.rpt
if (document.rep.choose.value=="2") window.location="sale_list1.jsp";
if (document.rep.choose.value=="5") window.location="<%=reportAddrs%>AjCustomerList.rpt";//tairanAjWfkList.rpt
if (document.rep.choose.value=="6") window.location="<%=reportAddrs%>tairenArrearSumRep.rpt";
if (document.rep.choose.value=="7") window.location="<%=reportAddrs%>tairanAjyfkList.rpt";
if (document.rep.choose.value=="8") window.location="<%=reportAddrs%>MonthSalePic.rpt";
if (document.rep.choose.value=="9") window.location="sale_list1.jsp";
if (document.rep.choose.value=="11") window.location="salecountreopt.jsp?paraWhere=<%=WhereSQL %>";
if (document.rep.choose.value=="12") window.location="<%=reportAddrs%>bareport.rpt";
if (document.rep.choose.value=="13") window.location="<%=reportAddrs%>ajCountList1.rpt";
if (document.rep.choose.value=="17") window.location="<%=reportAddrs%>rep_songjian.rpt";
if (document.rep.choose.value=="18") window.location="<%=reportAddrs%>rep_cqzlist.rpt";
if (document.rep.choose.value=="19") window.location="<%=reportAddrs%>rep_hetongdj.rpt";
if (document.rep.choose.value=="20") window.location="<%=reportAddrs%>rep_yushou_price.rpt";
if (document.rep.choose.value=="21") window.location="<%=reportAddrs%>rep_q_tax_taoda.rpt";
if (document.rep.choose.value=="22") window.location="sale_list1.jsp";
if (document.rep.choose.value=="10") {
   if (confirm("是否只打印客户类型为个人购房的？")){
      <%if (WhereSQL.indexOf("揭")>0){ %>
	   window.location="<%=session.getAttribute("reportAddr")%>order_xz21.rpt";
	   <%}else{ %>
	    window.location="<%=session.getAttribute("reportAddr")%>order_xz11.rpt";
	   
	   <%} %>
   }else{
       <%if (WhereSQL.indexOf("揭")>0){ %>
       window.location="<%=session.getAttribute("reportAddr")%>order_xz22.rpt";
        <%}else{ %>
		window.location="<%=session.getAttribute("reportAddr")%>order_xz12.rpt";
		 <%} %>
   }



}

<% }else if ( reporttype.equals("finace") ) { %>
if (document.rep.choose.value=="1") window.location="<%=reportAddrs%>ArrearMxRep.rpt";
if (document.rep.choose.value=="2") window.location="<%=reportAddrs%>ArrearSumRep.rpt";
if (document.rep.choose.value=="3") window.location="<%=reportAddrs%>TaxDSSumChargesRep.rpt";
if (document.rep.choose.value=="11") window.location="<%=reportAddrs%>SaleSKProcessRep.rpt";
if (document.rep.choose.value=="5") window.location="<%=reportAddrs%>TaxDSChargesRep.rpt";
if (document.rep.choose.value=="4") window.location="<%=reportAddrs%>TaxYJChargesRep.rpt";
if (document.rep.choose.value=="6") window.location="<%=reportAddrs%>AjMoneyProcessRep.rpt";
if (document.rep.choose.value=="7") window.location="<%=reportAddrs%>YJRepSum.rpt";
if (document.rep.choose.value=="8") window.location="<%=reportAddrs%>YJSKPicRep.rpt";
if (document.rep.choose.value=="9") window.location="<%=reportAddrs%>AjMonthpayMoneyRep.rpt";
if (document.rep.choose.value=="12") window.location="<%=reportAddrs%>SaleSkSumReprot.rpt";
if (document.rep.choose.value=="13") window.location="<%=reportAddrs%>FactMoneyAndShouldMoney.rpt";
if (document.rep.choose.value=="14") window.location="<%=reportAddrs%>YJSKPicRep.rpt";
if (document.rep.choose.value=="15") window.location="<%=reportAddrs%>FKZMS.rpt";
if (document.rep.choose.value=="16") window.location="<%=reportAddrs%>aj_mxlist.rpt";
<% } %>
</script>

</form>
</body>
</html>
