<%@ page language="java" import="java.sql.*,java.util.*,common.*" contentType="text/html;charset=GBK"%>

<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="f2Bean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<%
 

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
	  else if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by dengji_riqi asc";
	  else if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by cus_name desc";}
	  else if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by cus_name asc";
	  else if (orderbytype.equals("2")&&orderby.equals("1")) orderby=" order by VIPNO asc";
	  else if (orderbytype.equals("2")&&orderby.equals("0")) orderby=" order by VIPNO desc";
          else if (orderbytype.equals("3")&&orderby.equals("1")) orderby=" order by dengjiren asc";
	  else if (orderbytype.equals("3")&&orderby.equals("0")) orderby=" order by dengjiren desc";

	}else{
       orderby=" order by  VIPNO ,dengji_riqi ";
	
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
if (state.equals(""))state="0";

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

<input type=hidden name="vipno" >
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
String choos =    getbyte( request.getParameter( "choos" ) ) ;
if (choos.equals(""))choos="2";
if( doFind ) {

    
    String cusName = getbyte1( request.getParameter( "cusName" ) ) ;
    String cusPhone = getbyte1( request.getParameter( "cusPhone" ) ) ;
    String dengyi1 = getbyte1( request.getParameter( "dengyi1" ) ) ;
    String dengyi2 = getbyte1( request.getParameter( "dengyi2" ) ) ;
    String dengjiren = getbyte1( request.getParameter( "dengjiren" ) ) ;
	String vipno = getbyte1( request.getParameter( "vipno" ) ) ;
	
	
  //  findStr = " and serialNo like '%' " ;
	 if( ! vipno.equals( "" ) ) {
        findStr = findStr + " and vipno like '%" + vipno + "%' " ;
    }
    if( ! cusName.equals( "" ) ) {
        findStr = findStr + " and Cus_Name like '%" + cusName + "%' " ;
    }
    if( ! cusPhone.equals( "" ) ) {
        findStr = findStr + " and Phone like '" + cusPhone + "%' " ;
    }
    if( ! dengyi1.equals( "" ) ) {
        findStr = findStr + " and dengji_riqi >= '" + dengyi1 + " 00:00:00" + "' " ;
    }
    if( ! dengyi2.equals( "" ) ) {
        findStr = findStr + "and dengji_riqi <= '" + dengyi2 + " 23:59:59" + "' " ;
    }
  
	if (!getbyte1(request.getParameter("section")).equals(""))
	findStr = findStr + "and section ='" + getbyte1(request.getParameter("section")) + "' " ;
}
if (choos.equals("0"))findStr+=" and jinger=0 ";
else if (choos.equals("1")) findStr+=" and jinger>0 ";
  
String sql = "" ;
 
boolean allSecNo = true ;
  String job=(String)session.getAttribute("job");	
	 if (job.indexOf("销售员")>=0){
	    findStr+=" and dengjiren like '%"+(String)session.getAttribute("loginname")+"%'";
	 }
    sql =  "select Top "+pageSize+" * from View_Chenyi where aserialNo not in (Select top "+prenum +" aserialNo from  View_Chenyi  where  zto="+state+" "+ findStr + orderby+") and zto="+state+ findStr +" and section in ("+SectionS+")"+ orderby;
	 
    sqlcount = "select count(*) from View_Chenyi where zto=" + state
        + findStr+" and section in ("+SectionS+")";
 

%>

  <table width="100%" align="center" cellpadding=0 cellspacing=0>
    <tr>
  <td>
 <table width=100% border="0" align=center cellspacing=0 cellpadding=0>
  <tr bgcolor="#EAEAEA">
   
   <td>楼盘：<select name="section" onchange="document.form1.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql8="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

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
	   <option value=2>按VIP号</option>
<option value=3>按销售员</option>
     <option value=0>按诚意日期</option>
	 <option value=1>按客户名称</option>
	 </select>
	 <select name="orderby" onchange="document.form1.submit();">
    
	 <option value=1>升序</option>
	  <option value=0>降序</option>
	 </select>
	 <select name="stateshow" onchange="document.form1.submit();">
     <option value=1>已认购</option>
	 <option value=0>未认购</option>
	 </select>
	 </td>
    <%@ include file="../public_js/qx_checke.jsp"%>
	 <%
//权限审核
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT11");
    if (Cortrol==null)Cortrol="";
    %>
	<td><input name="choos" type="radio" value=2 <%if (choos.equals("2"))out.print("checked"); %> onclick="zh();">全部&nbsp;<input name="choos" type="radio" value=1 <%if (choos.equals("1"))out.print("checked"); %> onclick="zh();">已收诚意金<input name="choos" type="radio" onclick="zh();" value=0 <%if (choos.equals("0"))out.print("checked"); %>>未收诚意金
</td>

  </tr>
 <tr>
  <td>
 <% 
    if (Cortrol.indexOf("A")>=0){ %> 
  
   <input type=button name=add value="增 加" title="增加诚意客户诚意资料" onclick="addRef_i();">
  
   <% }if (Cortrol.indexOf("E")>=0){ %>
  
   <input type=button name=modi value="修 改" title="修改诚意客户诚意资料" onclick="refEdit_i();">
   
  <%} if (Cortrol.indexOf("F")>=0){ %>
 
  
<input type=button name=modi value="查 询" title="查询诚意客户诚意资料" onclick="ref_cx();">
<input type=button name=modi value="EXCEL" title="导入之前请选择项目名称" onclick="outexcel();">
<input type=button name=modi value="调查分析" onclick="fx();">
  <input type=button name=modi value="意向单位分析" onclick="fx1();">
  
    <%} if (Cortrol.indexOf("D")>=0){ %>

   
   <input type=button name=modi value="删 除" title="删除诚意客户诚意资料" onclick="ref_de_a();">
    
   
   <%} %>
   </td>
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
                  <td width="100%"> <table width="100%" cellpadding class="L2" cellspacing="1">
                      <tr class=listtitle> 
                        <td height="25" align="center"><font color="#FFFFFF">序号</font></td>
                          <td align="center"><font color="#FFFFFF">VIP号</font></td>
					    <td align="center"><font color="#FFFFFF">客户姓名</font></td>
                        <td align="center"><font color="#FFFFFF">性别</font></td>
                        <td align="center"><font color="#FFFFFF">联系电话</font></td>
                        <td align="center"><font color="#FFFFFF">意向单位</font></td>
                        <td align="center"><font color="#FFFFFF">诚意金额</font></td>
                        <td align="center"><font color="#FFFFFF">登记日期</font></td>
                        <!--td bgcolor="#6E91D5" align="center"><font color="#FFFFFF">失效日期</font></td-->
                        <td align="center"><font color="#FFFFFF">销售员</font></td>
                          <td align="center"><font color="#FFFFFF">备注</font></td>
                        <td align="center"><font color="#FFFFFF">&nbsp;状态</font></td>
						   <td align="center"><font color="#FFFFFF">打印</font></td> 
                      </tr>
                      <% //out.print(sql);
                            int i = 0 ; //当前记录行数
                            ResultSet rsB = fBean.executeQuery( sql ) ;
                              while( rsB.next() ) {
                              
                                String VIPNO =  getbyte( rsB.getString( "VIPNO" )) ;
                                String REF_ID = rsB.getString( "aserialNo" ) ;
								String REF_name = getbyte( rsB.getString( "Cus_Name" ) ) ;
                                String REF_TITLE = getbyte( rsB.getString( "Cus_Sex" ) ) ;
                                String REF_TYPE = getbyte( rsB.getString( "Phone" ) ) ;
                                int REF_SOURCE = rsB.getInt( "yscyj" ) ;
				String context = getbyte( rsB.getString("context") ) ;
                                Timestamp REF_DATE = rsB.getTimestamp( "dengji_riqi" ) ;
								Timestamp REF_DATE2 = rsB.getTimestamp( "shixiao_riqi" ) ;
                                String REF_IF_ACC = getbyte( rsB.getString( "dengjiren" ) );
                                String REF_IF_ID_CARD = getbyte( rsB.getString( "ID_CARD" ) );
								String REF_IF_SJ = getbyte( rsB.getString( "SJ" ) );
								if (REF_TYPE.equals(""))REF_TYPE=REF_IF_SJ;
                                String yixiang="  "+getbyte( rsB.getString( "yxdw1" ) );
								yixiang+=" "+getbyte( rsB.getString( "room" ) );
								String zto=getbyte( rsB.getString( "send" ) );
								String new_name=getbyte( rsB.getString( "new_name" ) );
								String new_room=getbyte( rsB.getString( "new_room" ) );
								String new_room_date=getbyte( rsB.getString( "new_room_date" ) );
								if (!new_room_date.equals(""))new_room_date=new_room_date.substring(0,10);
								String sectionname=getbyte( rsB.getString( "sectionname" ));
                            %>
                      <tr id=TR<%= i %> align=center class="listcontent" onmouseover="changCur(this)" onclick="savepara('<%= REF_ID %>','<%=REF_name %>','<%=REF_IF_ID_CARD %>','<%=REF_TYPE %>','<%=REF_SOURCE %>');changeclass1(this,'clickbg','listcontent');" ondblclick="window.open('chengyi_edit.jsp?ref_id=<%=REF_ID %>','edit_i','height=550,width=550,left=150,top=10,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no');"> 
                        <td ><input type="checkbox" value="<%=REF_ID%>"> <%= i+1 %></td>
                        <td ><%= VIPNO %></td>
					    <td  align="left"><a href="#" onclick="window.open('chengyi_edit.jsp?ref_id=<%=REF_ID %>','edit_i','height=550,width=550,left=150,top=10,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no');"><%= Repalce(REF_name,"/") %></a><%//if (zto.equals("1")){out.print("("+ new_name+" "+new_room+" "+new_room_date+")");} %></td>
                        <td ><%= REF_TITLE %></td>
                        <td align="left" ><%= Repalce(REF_TYPE,"/") %></td>
                        <td ><%= sectionname+yixiang %></td>
                        <td ><%= REF_SOURCE %></td>
                        <td ><%= formatDateTime( REF_DATE , 1 ) %></td>
                        <!--td ><%//= formatDateTime( REF_DATE2 , 1 ) %></td-->
                        <td ><%= REF_IF_ACC %></td>

  <td ><%= context%></td>

                          <td > 
					 <!--
						<%if (Cortrol.indexOf("E")>=0){ %>
                          <%if (state.equals("1")){ %>
                          <a href="#" onclick="sh(<%=REF_ID%>,0)">失效</a> 
                          <%}else{ %>
                          <a href="#" onclick="sh(<%=REF_ID%>,1)">有效</a> 
                          <%}} %>
						  -->
						    <%if (zto.equals("1")){out.print("有效");}
							  else{out.print("失效");}
							
							
							 %>
						 
                        </td>
						  <td > <img src="../images/icon_print.gif" alt='打印诚意' onclick="openwin('PrintCusVIP.jsp?code=<%=REF_ID %>');" onmouseover="javascript:this.style.cursor='hand'"></td>
                 
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
   if (document.form1.section.value==""){alert("请选择项目");return false;}
	 
  
   
    if( winR != null ){
        winR.close() ;
        winR = null ;
    }
    winR = window.open("chengyi.jsp?section="+document.form1.section.value,"add_i","height=550,width=550,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
}
 function fx(){
   if (document.form1.section.value==""){alert("请选择项目");return false;}
	
  openwin('../customter/cusYFindcount.jsp?section='+document.form1.section.value,650,350,100,100)
  } 
   function fx1(){
   if (document.form1.section.value==""){alert("请选择项目");return false;}
	
  openwin('xqCustomerFX.jsp?section='+document.form1.section.value,550,350,100,100)
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
    winR = window.open("chengyi_edit.jsp?ref_id=" + ref_id ,"edit_i","height=550,width=550,left=150,top=10,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
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
    openwin("chengyi_find.jsp?ref_id=" + ref_id ,360,410,100,100);
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
  function outexcel(){
    if (document.form1.section.value==""){alert("请选择项目");return false;}
	  window.open("chengyi_excel.jsp?section="+document.form1.section.value+"&stateshow="+document.form1.stateshow.value)
  
  }
  function zh(){
  document.form1.action="chengyi_index1.jsp";
document.form1.submit();

  }
</script>

</body>
</html>     

