<%@ page language="java" import="java.sql.*,java.util.*,common.*" contentType="text/html;charset=GBK"%>

<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="f2Bean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
 
<%@ include file="../public_js/CheckSection.jsp"%>
<%
 

String REFID=request.getParameter("REF_ID");
 String chstate=getbyte1(request.getParameter("chstate"));
String  sql1="";
 if (chstate.equals(""))chstate="0";
  sql1="update tb_chengyi set state="+chstate+",shixiao_riqi=null where code="+REFID;
 
f2Bean.executeUpdate(sql1);

//ʧ�����¼ʧЧ
  sql1="update tb_chengyi set state=0 where shixiao_riqi<getdate() and state=1";
  f2Bean.executeUpdate(sql1);
String orderbytype=China.getParameter(request,"orderbytype");
String orderby=China.getParameter(request,"orderby");

//����ʽ
	if (!orderbytype.equals("")&&!orderby.equals("")){
	  if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by dengji_riqi desc";
	  if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by dengji_riqi asc";
	  if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by cus_name desc";}
	  if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by cus_name asc";
	}else{
	orderby=" order by  aserialNo desc,dengji_riqi desc";
	
	}

%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Content-Language" content="zh-cn">
<title>VIP�ͻ�һ��</title>
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
 
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<body topmargin="0" leftmargin="0" oncontextmenu="return false" onload="full();" >
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
String choos =    getbyte( request.getParameter( "choos1" ) ) ;
if (choos.equals(""))choos="0";
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
  String job=(String)session.getAttribute("job");	
	 if (job.indexOf("����Ա")>=0){
	    findStr+=" and dengjiren like '%"+(String)session.getAttribute("loginname")+"%'";
	 }
String sql = "" ;
 
boolean allSecNo = true ;
 
    sql =  "select Top "+pageSize+" * from View_Chenyi where aserialNo not in (Select top "+prenum +" aserialNo from  View_Chenyi  where  zto="+state+" "+ findStr + orderby+") and zto="+state+ findStr +" and section in ("+SectionS+")"+ orderby;
	 
    sqlcount = "select count(*) from View_Chenyi where zto=" + state
        + findStr+" and section in ("+SectionS+")";
 
 String  sel="2";
%>
  <input type=hidden name="sel" value="<%=sel %>">
  <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
 <tr> 
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=1;findSub('vip_customer_alert.jsp');"> <font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������� 
	</td>
   <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=2;findSub('visitcusview7.jsp');"> <font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>����ͻ� 
	</td>
	</tr>
</table>
<p align=center> <b><font size="3">����ͻ�һ��</b> </p>
  <table width="100%" align="center" cellpadding=0 cellspacing=0>
    <tr>
  <td>
 <table width=100% border="0" align=center cellspacing=0 cellpadding=0>
  <tr bgcolor="#EAEAEA">
   
   <td>¥�̣�<select name="section" onchange="document.form1.submit();"> 
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
	
     %> </select>����:<select name="orderbytype"  onchange=" document.form1.submit();">
     <option value=0>����������</option>
	 <option value=1>���ͻ�����</option>
	 </select>
	 <select name="orderby" onchange="document.form1.submit();">
     <option value=0>����</option>
	 <option value=1>����</option>
	 </select>
	 <select name="stateshow" onchange="document.form1.submit();">
     <option value=1>���Ϲ�</option>
	 <option value=0>δ�Ϲ�</option>
	 </select>
	 </td>
    <%@ include file="../public_js/qx_checke.jsp"%>
	 <%
//Ȩ�����
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT11");
    if (Cortrol==null)Cortrol="";
	 
    %>
	<td><input name="choos1" type="radio" value=2 <%if (choos.equals("2"))out.print("checked"); %> onclick="zh();">ȫ��&nbsp;<input name="choos1" type="radio" value=1 <%if (choos.equals("1"))out.print("checked"); %> onclick="zh();">���ճ����<input name="choos1" type="radio" value=0 <%if (choos.equals("0"))out.print("checked"); %> onclick="zh();">δ�ճ����
</td>

  </tr>
 <tr>
  <td>
 
  
   <%if (Cortrol.indexOf("E")>=0){ %>
  
   <input type=button name=modi value="�� ��" title="�޸ĳ���ͻ���������" onclick="refEdit_i();">
   
  <%} if (Cortrol.indexOf("F")>=0){ %>
 
  
<input type=button name=modi value="�� ѯ" title="��ѯ����ͻ���������" onclick="ref_cx();">
<input type=button name=modi value="EXCEL" title="����֮ǰ��ѡ����Ŀ����" onclick="outexcel();">
<input type=button name=modi value="����" onclick="fx();">
  
    <%}   %>

 
   <input type=button name=sms value="�� ��"   title="ѡ��ͻ���,���Ͷ��Ÿ��ͻ�"  onclick="sendmessage();">
   
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
                  <td width="100%"> 
				  <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" >
                        <td height="25" align="center"><input type=checkbox name=ch onclick="chhoseData(this.checked);">���</td>
                          <td align="center">VIP��</td>
					    <td align="center">�ͻ�����</td>
                        <td align="center">�Ա�</td>
                        <td align="center">��ϵ�绰</td>
                        <td align="center">����λ</td>
                        <td align="center">������</td>
                        <td align="center">�Ǽ�����</td>
                
                        <td align="center">����Ա</td>
               
                        <td align="center">&nbsp;״̬</td>
						  <td  align="center">����</td>
                      </tr>
                      <%  //out.print(sql);
                            int i = 0 ; //��ǰ��¼����
                            ResultSet rsB = fBean.executeQuery( sql ) ;
                              while( rsB.next() ) {
                               String code= getbyte( rsB.getString( "code" )) ;
                                String VIPNO =  getbyte( rsB.getString( "VIPNO" )) ;
                                String REF_ID = rsB.getString( "SerialNo" ) ;
								String REF_name = getbyte( rsB.getString( "Cus_Name" ) ) ;
                                String REF_TITLE = getbyte( rsB.getString( "Cus_Sex" ) ) ;
                                String REF_TYPE = getbyte( rsB.getString( "Phone" ) ) ;
                                int REF_SOURCE = rsB.getInt( "yscyj" ) ;
                                Timestamp REF_DATE = rsB.getTimestamp( "dengji_riqi" ) ;
								Timestamp REF_DATE2 = rsB.getTimestamp( "shixiao_riqi" ) ;
                                String REF_IF_ACC = getbyte( rsB.getString( "dengjiren" ) );
                                String REF_IF_ID_CARD = getbyte( rsB.getString( "ID_CARD" ) );
								String REF_IF_SJ = getbyte( rsB.getString( "SJ" ) );
								if (REF_TYPE.equals(""))REF_TYPE=REF_IF_SJ;
								else REF_TYPE+=" "+REF_IF_SJ;
							    boolean gzState=rsB.getBoolean("gzState");
                                String yixiang="  "+getbyte( rsB.getString( "yxdw1" ) );
								yixiang+=" "+getbyte( rsB.getString( "room" ) );
								String zto=getbyte( rsB.getString( "zto" ) );
								String new_name=getbyte( rsB.getString( "new_name" ) );
								String new_room=getbyte( rsB.getString( "new_room" ) );
								String new_room_date=getbyte( rsB.getString( "new_room_date" ) );
								if (!new_room_date.equals(""))new_room_date=new_room_date.substring(0,10);
								String sectionname=getbyte( rsB.getString( "sectionname" ));
								String cusno=getbyte( rsB.getString( "SerialNo" ));
                            %>
                      <tr id=TR<%= i %> title="˫�����������޸Ŀͻ�����" align=center   onmouseover="changCur(this)" onclick="savepara('<%= REF_ID %>','<%=REF_name %>','<%=REF_IF_ID_CARD %>','<%=REF_TYPE %>','<%=REF_SOURCE %>','<%=cusno %>');changeclass1(this,'clickbg','');" ondblclick="window.open('editcustomer.jsp?cusno=<%=cusno %>','edit_i','height=550,width=510,left=150,top=10,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no');"> 
                        <td  align="left"><input type="checkbox" name=choos  cusno=<%= REF_ID%>  value="<%=REF_IF_SJ+"|"+REF_name%>" > <%= i+1 %></td>
                        <td ><%= VIPNO %></td>
					    <td  align="left"><a href="#" onclick="window.open('editcustomer.jsp?cusno=<%=REF_ID %>','edit_i','height=550,width=580,left=150,top=10,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no');"><%= Repalce(REF_name,"/") %></a><%if (zto.equals("1")){out.print("("+ new_name+" "+new_room+" "+new_room_date+")");} %></td>
                        <td ><%= REF_TITLE %>&nbsp;</td>
                        <td align="left" ><%= Repalce(REF_TYPE,"/") %>&nbsp;</td>
                        <td ><%= sectionname+yixiang %></td>
                        <td ><%= REF_SOURCE %></td>
                        <td ><%= formatDateTime( REF_DATE , 1 ) %></td>
                     
                        <td ><%= REF_IF_ACC %>&nbsp;</td>
                          <td > 
					  
						    <%if (zto.equals("1")){out.print("�ѹ���");}
							  else{out.print("δ����");}
							
							
							 %>
						 
                        </td>
						  <td  align="center"><a href="#"  onclick="savepara('<%=cusno%>');Edit('<%=cusno%>');"><%if (gzState){ %><font color=red>��¼</font><%}else{ %>��¼<%} %></a> </td>

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
  var cusno="";
    function Edit(para){
    	
   	         if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		     else{ openwin("CusFeedBack_sale.jsp?cusno="+para,560,560,100,5);}
	
	}

function findSub(para){
   document.form1.action=para+"?Search=b&Find=b";
   document.form1.submit();


}
 
var winR = null ;
function addRef_i () 
{
   if (document.form1.section.value==""){alert("��ѡ����Ŀ");return false;}
	 
  
   
    if( winR != null ){
        winR.close() ;
        winR = null ;
    }
    winR = window.open("chengyi.jsp?section="+document.form1.section.value,"add_i","height=550,width=480,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
}
  function fx(){
    if (document.form1.section.value==""){alert("��ѡ����Ŀ");return false;}
	
  openwin('../customter/cusYFindcount.jsp?section='+document.form1.section.value,750,250,100,100)
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
	cusno=no;
	
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
function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
	 
    }

}
function refEdit_i()
{
    if( ref_id == "" ){
        alert( "��ѡ��һ����¼!" ) ;
        return ;
    }    
 
 openwin("editcustomer.jsp?cusno="+ref_cusno,560,560,100,5);
	  
	  }

function ref_de_a(){
   if( ref_id == "" ){
        alert( "��ѡ��һ����¼!" ) ;
        return ;
    }    
	if (parseInt(ref_money)>0){
	  if (confirm("�ѵǼ��˳�����Ƿ�ȷ��ɾ�������¼��"))
	    winR = window.open("../sale/chengyi_delete.jsp?ref_id=" + ref_id ,"edit_i","height=10,width=10,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
   }else{
      if (confirm("�Ƿ�ȷ��ɾ�������¼��"))
	    winR = window.open("../sale/chengyi_delete.jsp?ref_id=" + ref_id ,"edit_i","height=10,width=10,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
   }
}

function printSJ( cusno , cusname ) {
    var newwink = window.open("printsj.jsp?CusNo="+cusno+"&cusname=" + cusname , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
    newwink.focus();
}    
function ref_view() {
    if( ref_id == "" ){
        alert( "��ѡ��һ����¼!" ) ;
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
        alert( "��ѡ��һ����¼!" ) ;
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
if (confirm("ȷ����")){
 
document.form1.action="chengyi_index.jsp?REF_ID="+REF_ID+"&chstate="+para;
document.form1.submit();
}
}
  function outexcel(){
    if (document.form1.section.value==""){alert("��ѡ����Ŀ");return false;}
	  window.open("../sale/chengyi_excel.jsp?section="+document.form1.section.value+"&stateshow="+document.form1.stateshow.value)
  
  }
  function view(){
	  if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		   else{openwin("editcustomer.jsp?cusno="+cusno,560,560,100,5);}
	  }

  function zh(){
  document.form1.action="visitcusview7.jsp";
document.form1.submit();

  }
var sendmess="";
var sendto="";
  
function chhoseData1(){
sendmess="";
sendto="";
if (document.form1.choos.length){
   for (var i=0;i<document.form1.choos.length;i++){
 	
	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].value;
		 
	    if (sendmess=="")
		 sendmess=aa.substring(0,aa.indexOf("|"));
		else
		 sendmess+=","+aa.substring(0,aa.indexOf("|"));
	  
	    if (sendto=="")
		 sendto=aa.substring(aa.indexOf("|")+1);
		else
		 sendto+=","+aa.substring(aa.indexOf("|")+1);
	
	  }
	   
    }
	}else if (document.form1.choos.checked){
	 var aa=document.form1.choos.value;
	 sendmess=aa.substring(0,aa.indexOf("|"));
	 sendto=aa.substring(aa.indexOf("|")+1);
	}
}
function sendmessage()
{
chhoseData1();
 
 if (sendmess==""){alert("��ѡ��Ŀͻ�����û�������ֻ��ţ�������ѡ��ͻ�");return false;}
openwin1("../../sendmessage/SendMessage.jsp?messtype=3&sendmess="+sendmess+"&sendto="+sendto,400,300,100,100);
}
  
</script>

</body>
</html>     

