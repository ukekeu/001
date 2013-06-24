 
 <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%!
public String formatDateTime( java.sql.Timestamp dt ) throws Exception {
    if( dt == null ) {
        return "" ;
    }
    java.text.SimpleDateFormat f = new java.text.SimpleDateFormat( "yyyy-MM-dd" ) ;
    return f.format( dt ) ;
}
%>

 <%//String Cortrol=(String)session.getAttribute("popedomStr"); 
String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"F014");

 %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>代付管理</title>


<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language="javascript" src="../public_js/public.js">
</script>
<script language="javascript" src="../public_js/basal.js">
</script>
</head>

<%
String contractno = request.getParameter( "contractno" ) ;
String cusno = request.getParameter( "cusno" ) ;
String loft= request.getParameter( "loft" ) ;
String ysID=request.getParameter( "ysID" ) ;
if (ysID!=null){
   aBean.executeUpdate("delete GatheringRecord where id="+ysID ) ;
}

String check_roomno=getbyte1(request.getParameter( "roomno" )) ;
//代收审核
String d_checkstat[]=request.getParameterValues("d_checkstat");
if (d_checkstat!=null){
String ids="";
for (int aa=0;aa<d_checkstat.length;aa++){
   
      if (ids.equals(""))ids=d_checkstat[aa];
	  else ids+=","+d_checkstat[aa];
}
aBean.executeUpdate("update FactGatheringTaxRecord set out_check =1,out_check_date=getdate(),out_checkperson='"+(String)session.getAttribute("loginname") +"',checkdate=getdate() ,checkstate =1 where code in ("+ids +")") ;
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "代付审核" , 
                  "审核"+check_roomno
                ) ;	
}


//放款审核
String fkcheckcancel[]=request.getParameterValues("fkcheckcancel");
if (fkcheckcancel!=null){
String ids="";
for (int aa=0;aa<fkcheckcancel.length;aa++){
   
      if (ids.equals(""))ids=fkcheckcancel[aa];
	  else ids+=","+fkcheckcancel[aa];
}
aBean.executeUpdate("update FactAjCharges  set checkperson='"+(String)session.getAttribute("loginname") +"',checkdate=getdate() ,checkstate =1 where code in ("+ids +")") ;
}

  String curry="";
	String rate="0"; 
 String Payment="";
 double SalePrice=0,sjprice=0;
 double AjPrice=0;
 String customer="";
 String roomno="";
 double ysSumMoney=0;
 String room="";
 String strloft="";
 String build="";
 String secname="";
 String secno="";
 String floors="";
 int zs_first_money=0;
 String section="";
String lu_tai_area="";
String lu_tai_mapp_area="";
String lu_tai_area_price=""; 
String gaizhang_area=""; 
String gaizhang_unitprice=""; 
String yang_tai_area=""; 
String yang_tai_mapp_area=""; 
String yang_tai_price="",roomprice=""; 
String pi="",rg_date="";
String pih="",ajbk="";

%>
<form name=f1 method="post">
	<p align=center>
  <b><font size="3" color="#000080">税费代收一览</font></b>
 </p>
 <input type=button name=ds value="审 核" onclick="checkFact();">&nbsp;<input type=button name=outm value="代 付" onclick="outtax();">
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> <td>收取日期</td> 
	  <td>票据编号</td> 
	  <td>代收人</td>
	   <td>代付日期(金额)</td>
	  <td>代付人</td>
	    <td>代付选择</td>
	   <td>审核</td>
    </tr>
	
  
    <%
 
	
	//设定查询

  String sql="select * from factGatheringTaxRecord where taxname_type=1 and  contractno ='"+contractno+"'";//order by room_no desc";
//设置查询结果的存放变量
 int i=0;
 String sq="";
 int ID=0;
String RoomNo="";
String CusNo="";
String CusName="";
String CusPhone="";
String TaxName="";
String Lofts="";
float TaxMoney=0;
String Order_Code="";
String Sectionname="";
String ajSection="";
 
  ResultSet rs=fBean.executeQuery(sql);
 String JKdate="";
 i=0;
 float sumtax=0;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   String id=rs.getString("code");
   String taxname=rs.getString("taxname");
   TaxMoney= rs.getFloat("money") ;
   sumtax+=TaxMoney;
   JKdate=rs.getDate("date").toString();
   String no=getbyte(rs.getString("no"));
    String handler=getbyte(rs.getString("handler"));
	int out_check=rs.getInt("out_check");
	String out_check_date=getbyte(rs.getString("out_check_date"));
	if (!out_check_date.equals(""))out_check_date=out_check_date.substring(0,10);
	String out_checkperson=getbyte(rs.getString("out_checkperson"));
	String out_date=getbyte(rs.getString("out_date"));
	String out_money=getbyte(rs.getString("out_money"));
	if (out_money.equals(""))out_money=String.valueOf(TaxMoney);
	 if (!out_date.equals(""))out_date=out_date.substring(0,10);
	 String out_person=getbyte(rs.getString("out_person"));
	 boolean taxtype=rs.getBoolean("TaxName_type");
	 
    %> 
    <tr class=listcontent id=TR<%=i%>  align="left" title="双击可登记代付" ondblClick="openwin1('TaxOut.jsp?id=<%=id %>&outtax=<%=out_money %>',300,300,100,100);"  onclick="changeclass1(this,'clickbg','listcontent');"><!--" -->
      <td  ><%=i%></td>
	   <td  ><%=taxname%></td>
	  <td  ><%=TaxMoney%></td>
	  <td  ><%=JKdate%></td>
      <td> <%=no %></td> 
	  <td> <%=handler %></td> 
	     <td> <%=out_date %> <%if (!out_date.equals("")){%>(<%=out_money %>)<%} %></td> 	
		  <td> <%=out_person %></td> 	
		   <td> 
		   <%if (out_date.equals("")){%>
		     <input type=checkbox name="out_checkstat"  out_m=<%=TaxMoney %>  value=<%=id %>>
		     <input type=hidden name="out_m<%=id %>" value=<%=TaxMoney %>>
		  <%} %>
		   </td>	
	    <td >
		  
		  <%if (!out_date.equals("")&&out_check==0){%>
		  <input type=checkbox name="d_checkstat" value=<%=id %>>
		  <%}else{ %><font color=red><%=out_check_date %><br><%=out_checkperson %></font>
		  <%}
		   %>&nbsp;
		  </td>    
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}
  rs.close();
%>
 <tr  align="left"  >
      <td  >合计：</td>
	   <td  >&nbsp;</td>
	  <td  ><%=sumtax%></td>
	  <td  >&nbsp;</td>
      <td> &nbsp;</td> 
	  <td> &nbsp;</td> 	
    </tr>
</table>
  
    <p align=center>
	 <input type=hidden name=roomno value="<%=secname+roomno %>" >
        <input type=button name=buttc value=" 关闭 " onclick="window.close()" >
		
    </p>
操作说明:
双击代收数据，可登记代付数据，如果需要批量登记代付数据，先选中需要代付的记录后点击“代付”。
 </form>

<script lang=javascript>

function checkFact(){
  if (confirm("确认你的审核吗？"))
  document.forms[0].submit();
  
}
function checkfk(){
  if (confirm("确认你的审核吗？"))
  document.forms[0].submit();
  
}
function checkCancel(){
  if (confirm("确认你的核销吗？"))
  document.forms[0].submit();
  
} 
function Edit( cusno , contractno , no , rowID,curry1,rate1,money1) {

    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 400 ;
    var posi = posi + ",width=" + 350 ;

    var newwink = window.open("FactGatherDataD.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&oldcurry="+curry1+"&oldrate="+rate1+"&oldmoney="+money1+"&ht_rate=<%=rate %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
  
    newwink.focus();
}    
function printSJ( cusno , contractno , no , rowID ) {
    var newwink = window.open("printsj.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=roomno %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
    newwink.focus();
}    
function zhiNaJing() {
    if( checkValue() ) {
        document.forms[ 0 ].action = "yingshi.jsp?contractno="+ "<%= contractno%>" + "&cusno=" + "<%= cusno%>"
        document.forms[ 0 ].submit() ;
    }
}

function checkValue() {
    if( ! document.forms[ 0 ].zhiType[ 0 ].checked && ! document.forms[ 0 ].zhiType[ 1 ].checked ) {
        alert( "请选择滞纳金的类型!" ) ;
        return false ;
    }
    
    if( isNaN( document.forms[ 0 ].bili.value ) ) {
        alert( "请输入数值!" ) ;
        return false ;
    }

    if( isNaN( document.forms[ 0 ].jinger.value ) ) {
        alert( "请输入数值!" ) ;
        return false ;
    }
    return true ;
}


 

function guangbi() {    
    opener.window.location.reload() ;
    close() ;
}

var period = "" ;
var qianKuan = "" ;
var shouldmoney = "" ;
var ysDate="";
var ysID="";
var jkstate="";
var o_tax;
function setpara(periodpass ,qianPass , shouldPass,ysid,ysdate,jk) {
    period = periodpass ;
    qianKuan = qianPass ;
    shouldmoney = shouldPass ;
	ysID=ysid;
	ysDate=ysdate;
	jkstate=jk;
	
}
function printzms(){
  open("print.jsp?contractno=<%=contractno %>","prntwin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no")
}
function deleteFact(aa,aa1,aa2,aa3,aa4){
   if (confirm("确认删除实收登记吗？删除后不能恢复")) openwin("deleteFactGathering.jsp?id="+aa+"&FactCurry="+aa1+"&FactCurryRate="+aa2+"&rate="+aa3+"&deletemoney="+aa4+"&contractno=<%=contractno %>&cusno=<%=cusno %>","aa",10,10,10,10)

}
function dengji() {

  
    var spa = 300 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 250 ;
    var posi = posi + ",width=" +450 ;

    var newwink2 = window.open("F_fp_Input.jsp?contractno=<%=contractno%>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   

}
function fpmodi() {

  
    var spa = 300 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 250 ;
    var posi = posi + ",width=" +450 ;

    var newwink2 = window.open("F_fp_modi.jsp?contractno=<%=contractno%>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   

}

function fpzf() {

  if (confirm("确认作废?")){
    var spa = 300 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 250 ;
    var posi = posi + ",width=" +450 ;

    var newwink2 = window.open("F_fp_zf.jsp?contractno=<%=contractno%>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   }

}

function fpff() {

  if (confirm("确认作废?")){
    var spa = 300 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 250 ;
    var posi = posi + ",width=" +450 ;

    var newwink2 = window.open("F_fp_ff.jsp?contractno=<%=contractno%>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   }

}

function xiangqing() {
	
    var spa = 400 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa/3 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=400"  ;
    var posi = posi + ",width=550";
    var newwin1=window.open("../customter/editcustomer.jsp?edit=editcus&cusno=<%=cusno%>","NewsW1","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
 
}
function contractlist(){
  openwin2('../sale/showContract.jsp?secname=<%=secname %>&secno=<%=secno %>&roomno=<%=room%>&build=<%=build%>&loft=<%=strloft %>&Floor=<%=floors %>&show=true',680,530,120,2);

}
 
function getseldocs2() {
     var x=0;
	 o_tax=0;
	 var seldocs = new Array();
	 var temp=f1.elements.length;
     for (i=0;i<f1.elements.length;i++) {
       if ((f1.elements[i].type=="checkbox")&&(f1.elements[i].checked)&&(f1.elements[i].name=="out_checkstat"))
		 { 
		    seldocs[x]=f1.elements[i].value ;
			  var id=f1.elements[i].value;
			  var dd=eval("document.forms[ 0 ].out_m"+id);
		    
			 o_tax+=parseFloat(dd.value);
			x++;
   		 }
	  }	

   return seldocs ;
}
function outtax(){
if (getseldocs2()==""){alert("请选择代付");return false;}
 
 openwin2("TaxOut.jsp?id="+getseldocs2()+"&outtax="+o_tax,400,300,100,100);

}
</script>

</body>
</html>

