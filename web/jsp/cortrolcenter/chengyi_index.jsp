<%@ page language="java" import="java.sql.*,java.util.*,common.*" contentType="text/html;charset=GBK"%>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="f2Bean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%@ include file="../public_js/CheckSection.jsp"%>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "诚意一览" , 
                  "浏览"
                ) ;
				

String REFID=request.getParameter("REF_ID");
 String chstate=getbyte1(request.getParameter("chstate"));
String  sql1="";
 if (chstate.equals(""))chstate="0";
  sql1="update tb_chengyi set state="+chstate+",shixiao_riqi=null where code="+REFID;
 
f2Bean.executeUpdate(sql1);

//失诚意记录失效
  sql1="update tb_chengyi set state=0 where shixiao_riqi<getdate() and state=1";
  f2Bean.executeUpdate(sql1);
String orderbytype=China.getParameter(request,"orderbytype");
String orderby=China.getParameter(request,"orderby");

//排序方式
	if (!orderbytype.equals("")&&!orderby.equals("")){
	  if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by dengji_riqi desc";
	  if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by dengji_riqi asc";
	  if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by cus_name desc";}
	  if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by cus_name asc";
	}else{
	orderby=" order by dengji_riqi desc";
	
	}

%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Content-Language" content="zh-cn">
<title>::: 诚意一览 :::</title>
<%!
public int topNum( int a , int b )
{
    int c = a / b ;
    if ( a % b != 0 ) {
        c ++ ;
    }
    return c ;
}

public String formatDateTime( java.sql.Timestamp dt , int flag ) throws Exception {
    java.text.SimpleDateFormat f = new java.text.SimpleDateFormat( "yyyy-MM-dd" ) ;
    return f.format( dt ) ;
}
%>	
<%String findStr = "" ;
String checkedStr2="";
String checkedStr1="";
String state="";
String stateStr="";
state= getbyte( request.getParameter( "stateshow" ) ) ;
if (state.equals(""))state="1";

if (checkedStr1.equals(""))
stateStr="1";
else
stateStr=checkedStr1;
if (checkedStr1.equals("0")){checkedStr2="checked";checkedStr1="";}
else { checkedStr1="checked";checkedStr2="";} %>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="javascript">

function change(nn,imgobj) {
if (document.images){
eval('document.images.'+nn+'.src="'+imgobj+'"');

}
}
</script>
<script>
function full(){
 setSelectMad(document.form1.orderbytype,'<%=orderbytype %>');
 setSelectMad(document.form1.orderby,'<%=China.getParameter(request,"orderby") %>');
setSelectMad(document.form1.stateshow,'<%=state%>');

setSelectMad(document.form1.section,'<%=request.getParameter("section") %>');
}

</script>
<body onload="full()">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<body topmargin="0" leftmargin="0">
<br>
<p align=center> <b><font size="3">诚意客户一览表</font></b> </p>

<form name="form1" method="post">

<input type=hidden name="do" value="find" >
<input type=hidden name="cusName" >
<input type=hidden name="cusPhone" >
<input type=hidden name="dengyi1" >
<input type=hidden name="dengyi2" >
<input type=hidden name="dengjiren" >
<%@ include file="../public_js/countpagenum.jsp"%>

<%


	


boolean doFind = false ;
if( request.getParameter( "do" ) != null &&  request.getParameter( "do" ).equals( "find" ) ) {
    doFind = true ;
}

if( doFind ) {

    
    String cusName = getbyte( request.getParameter( "cusName" ) ) ;
    String cusPhone = getbyte( request.getParameter( "cusPhone" ) ) ;
    String dengyi1 = getbyte( request.getParameter( "dengyi1" ) ) ;
    String dengyi2 = getbyte( request.getParameter( "dengyi2" ) ) ;
    String dengjiren = getbyte( request.getParameter( "dengjiren" ) ) ;
  //  findStr = " and serialNo like '%' " ;
	
    if( ! cusName.equals( "" ) ) {
        findStr = findStr + "and Cus_Name like '%" + cusName + "%' " ;
    }
    if( ! cusPhone.equals( "" ) ) {
        findStr = findStr + "and Phone like '" + cusPhone + "%' " ;
    }
    if( ! dengyi1.equals( "" ) ) {
        findStr = findStr + "and dengji_riqi >= '" + dengyi1 + " 00:00:00" + "' " ;
    }
    if( ! dengyi2.equals( "" ) ) {
        findStr = findStr + "and dengji_riqi <= '" + dengyi2 + " 23:59:59" + "' " ;
    }
    if( ! dengjiren.equals( "" ) ) {
        findStr = findStr + "and dengjiren like '%" + dengjiren + "%' " ;
    }
	if (!getbyte1(request.getParameter("section")).equals(""))
	findStr = findStr + "and section ='" + getbyte1(request.getParameter("section")) + "' " ;
}

String sql = "" ;
 
boolean allSecNo = true ;
if( allSecNo ) {
    sql =  "select Top "+pageSize+" * from View_Chenyi where aserialNo not in (Select top "+prenum +" aserialNo from  View_Chenyi  where  state="+state+" "+ findStr + orderby+") and state="+state+ findStr +" and section in ("+SectionS+")"+ orderby;
		
    sqlcount = "select count(*) from View_Chenyi where state=" + state
        + findStr+" and section in ("+SectionS+")";
}else{
}

%>

  <table width="95%" align="center" cellpadding=0 cellspacing=0>
    <tr>
  <td>
 <table width=99% border="0" align=center cellspacing=0 cellpadding=0>
  <tr bgcolor="#EAEAEA">
   
   <td>楼盘：<select name="section" onchange="document.form1.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql8="select SerialNo,Name FROM crm_project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean.executeQuery(sql8);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>排序:<select name="orderbytype"  onchange=" document.form1.submit();">
     <option value=0>按诚意日期</option>
	 <option value=1>按客户名称</option>
	 </select>
	 <select name="orderby" onchange="document.form1.submit();">
     <option value=0>降序</option>
	 <option value=1>升序</option>
	 </select>
	 <select name="stateshow" onchange="document.form1.submit();">
     <option value=1>有效</option>
	 <option value=0>失效</option>
	 </select>
	 </td>
    <%@ include file="../public_js/qx_checke.jsp"%>
	 <%
//权限审核
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),request.getParameter("param"));
    if (Cortrol==null)Cortrol="";
   if (Cortrol.indexOf("E")>=0){ %>
	<td><input type=button name=mail value="邮 件" disabled title="选择客户后,给客户发送邮件"><input type=button name=sms value="短 信" disabled title="选择客户后,发送短信给客户">
</td>
<%} 
    if (Cortrol.indexOf("A")>=0){ %> 
   <td>
   <input type=button name=add value="增 加" title="增加诚意客户诚意资料" onclick="addRef_i();">
   </td>
   <% }if (Cortrol.indexOf("E")>=0){ %>
   <td>
   <input type=button name=modi value="修 改" title="修改诚意客户诚意资料" onclick="refEdit_i();">
   </td>
  <%} if (Cortrol.indexOf("F")>=0){ %>
  <!--  <td >
    <a href="javascript:xiaoshou()">
    <img src="../picture/button_xs.gif" border=0>    
    </a>    
   </td>
   -->
   <td >
<input type=button name=modi value="查 询" title="查询诚意客户诚意资料" onclick="ref_cx();">
    
   </td>
    <%} if (Cortrol.indexOf("D")>=0){ %>

   <td>
   <input type=button name=modi value="删 除" title="删除诚意客户诚意资料" onclick="ref_de_a();">
    
   </td>
   <%} %>
  </tr>
 
 </table>  
  </td>
 </tr>

  <tr>  
    <td width="85%" valign="top">
    <table width="100%" cellspacing=1 cellpadding=0 >     
   
      <tr>
        <td width="100%" align="center" height="10" class="L3"></td>
      </tr>
      <tr>
        <td width="100%" align="left">
          <table width="100%" cellspacing cellpadding class="L2">
                <tr> 
                  <td width="94%"> <table width="100%" cellpadding class="L2" cellspacing="1">
                      <tr class=listtitle> 
                        <td height="25" align="center"><font color="#FFFFFF">序号</font></td>
                        <td align="center"><font color="#FFFFFF">客户姓名</font></td>
                        <td align="center"><font color="#FFFFFF">性别</font></td>
                        <td align="center"><font color="#FFFFFF">联系电话</font></td>
                        <td align="center"><font color="#FFFFFF">意向单位</font></td>
                        <td align="center"><font color="#FFFFFF">诚意金额</font></td>
                        <td align="center"><font color="#FFFFFF">登记日期</font></td>
                        <!--td bgcolor="#6E91D5" align="center"><font color="#FFFFFF">失效日期</font></td-->
                        <td align="center"><font color="#FFFFFF">销售员</font></td>
                        <td align="center"><font color="#FFFFFF">打印收据</font></td>
                        <td align="center"><font color="#FFFFFF">&nbsp;</font></td>
                      </tr>
                      <% //out.print(sq);
                            int i = 0 ; //当前记录行数
                            ResultSet rsB = fBean.executeQuery( sql ) ;
                              while( rsB.next() ) {
                              

                                String REF_ID = rsB.getString( "aserialNo" ) ;
								String REF_name = getbyte( rsB.getString( "Cus_Name" ) ) ;
                                String REF_TITLE = getbyte( rsB.getString( "Cus_Sex" ) ) ;
                                String REF_TYPE = getbyte( rsB.getString( "Phone" ) ) ;
                                int REF_SOURCE = rsB.getInt( "jinger" ) ;
                                Timestamp REF_DATE = rsB.getTimestamp( "dengji_riqi" ) ;
								Timestamp REF_DATE2 = rsB.getTimestamp( "shixiao_riqi" ) ;
                                String REF_IF_ACC = getbyte( rsB.getString( "dengjiren" ) );
                                String REF_IF_ID_CARD = getbyte( rsB.getString( "ID_CARD" ) );
								String REF_IF_SJ = getbyte( rsB.getString( "SJ" ) );
								if (REF_TYPE.equals(""))REF_TYPE=REF_IF_SJ;
                                String yixiang="";//getbyte( rsB.getString( "demand" ) );
								yixiang+=getbyte( rsB.getString( "room" ) );
                            %>
                      <tr id=TR<%= i %> align=center class="listcontent" onmouseover="changCur(this)" onclick="savepara('<%= REF_ID %>','<%=REF_name %>','<%=REF_IF_ID_CARD %>','<%=REF_TYPE %>','<%=REF_SOURCE %>');changeclass1(this,'clickbg','listcontent');" > 
                        <td ><input type="checkbox" value="<%=REF_ID%>"> <%= i+1 %></td>
                        <td  align="left"><%= Repalce(REF_name,"/") %></td>
                        <td ><%= REF_TITLE %></td>
                        <td align="left" ><%= Repalce(REF_TYPE,"/") %></td>
                        <td ><%= yixiang %></td>
                        <td ><%= REF_SOURCE %></td>
                        <td ><%= formatDateTime( REF_DATE , 1 ) %></td>
                        <!--td ><%//= formatDateTime( REF_DATE2 , 1 ) %></td-->
                        <td ><%= REF_IF_ACC %></td>
                        <td > <img src="../picture/icon_print.gif" alt='打印收据单' onclick="printSJ('<%= REF_ID %>','<%=REF_name %>')" onmouseover="javascript:this.style.cursor='hand'"></td>
                        <td > 
						<%if (Cortrol.indexOf("E")>=0){ %>
                          <%if (state.equals("1")){ %>
                          <a href="#" onclick="sh(<%=REF_ID%>,0)">失效</a> 
                          <%}else{ %>
                          <a href="#" onclick="sh(<%=REF_ID%>,1)">有效</a> 
                          <%}} %>
						  
                        </td>
                      </tr>
                      <%
                               
                                i ++ ;
                            }
                            %>
                      <tr> 
                        <td align="center" colspan="8" height="5"></td>
                      </tr>
                    </table></td>
                </tr>
              </table>
        </td>
      </tr>
    </table>
    </td>
  </tr>
</table>
 <%@ include file="../public_js/changepage.jsp"%>
</form>
<script lang=javascript>
var winR = null ;
function addRef_i () 
{
    if( winR != null ){
        winR.close() ;
        winR = null ;
    }
    winR = window.open("chengyi.jsp","add_i","height=550,width=480,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
}
  
var ref_id = "" ;
var ref_cusno = "" ;
var ref_cusname = "" ;
var ref_id_card = "" ;
var ref_phone = "" ;
var ref_money="";
function savepara( id,cusname,id_card,phone,money,no ) {
    ref_id = id ;
	ref_phone=phone;
	ref_cusname=cusname;
	ref_id_card=id_card;
    ref_money=money;
	ref_cusno=no;
	
	
}

function changCur( src )  {
	if ( src.contains( event.toElement ) ) {
		src.style.cursor = 'hand' ; 
	}
}

var TRID = "" ;
function  changeclass1( src , clrOver , clrIn ) {
    if ( TRID=="" ) {
        TRID=src.id;
    } else {
        var temp = eval(""+TRID+"");
        temp.className=clrIn;
        TRID=src.id;
    }
    src.style.cursor = 'hand'; 
    src.className = clrOver; 
}

function refEdit_i()
{
    if( ref_id == "" ){
        alert( "请选择一条记录!" ) ;
        return ;
    }    
    if( winR != null ){
        winR.close() ;
        winR = null ;
    }
    winR = window.open("chengyi_edit.jsp?ref_id=" + ref_id ,"edit_i","height=550,width=480,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
}

function ref_de_a(){
   if( ref_id == "" ){
        alert( "请选择一条记录!" ) ;
        return ;
    }    
	if (parseInt(ref_money)>0){
	  if (confirm("已登记了诚意金，是否确认删除诚意记录？"))
	    winR = window.open("chengyi_delete.jsp?ref_id=" + ref_id ,"edit_i","height=10,width=10,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
   }else{
      if (confirm("是否确认删除诚意记录？"))
	    winR = window.open("chengyi_delete.jsp?ref_id=" + ref_id ,"edit_i","height=10,width=10,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
   }
}

function printSJ( cusno , cusname ) {
    var newwink = window.open("printsj.jsp?CusNo="+cusno+"&cusname=" + cusname , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
    newwink.focus();
}    
function ref_view() {
    if( ref_id == "" ){
        alert( "请选择一条记录!" ) ;
        return ;
    }    
    if( winR != null ){
        winR.close() ;
        winR = null ;
    }
    winR = window.open("chengyi_view.jsp?ref_id=" + ref_id ,"ref_view","height=360,width=410,left=150,top=50,resizable=yes,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no");    
}

function change_cur( obj ) 
{
    obj.style.cursor = 'hand' ;
}

function ref_cx()
{
    window.open("chengyi_find.jsp?ref_id=" + ref_id ,"ref_cx","height=360,width=410,left=150,top=50,resizable=yes,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no");
}

function xiaoshou()
{
    if( ref_id == "" ){
        alert( "请选择一条记录!" ) ;
        return ;
    }    
		
   //window.parent.location='../sale/';
    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + hei ;
    var posi = posi + ",width=" + wid ;
    var newwins=window.open( "chengyi_get_xiaoshou.jsp?ref_id=" + ref_id+"&ref_cusname="+ref_cusname+"&ref_id_card="+ref_id_card+"&ref_phone="+ref_phone+"&ref_money="+ref_money ,"NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwins.focus();
	
}
function sh(REF_ID,para){
if (confirm("确认吗？")){
 
document.form1.action="chengyi_index.jsp?REF_ID="+REF_ID+"&chstate="+para;
document.form1.submit();
}
}
</script>

</body>
</html>     

