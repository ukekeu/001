<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>

<HTML>
<HEAD>
<TITLE>���޼�¼</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function checkedDate(){
if (document.cus.cusname.value==""){
    alert("��ѡ��ͻ�������ͻ�����");
    return false;
  }
  if (document.cus.Date2.value==""){
    alert("��ѡ��ǩ������");
    return false;
  }
 if (document.cus.Date1.value==""){
    alert("��ѡ����Ч����");
    return false;
  }
  if (document.cus.Date3.value==""){
    alert("��ѡ��ʧЧ����");
    return false;
  }
  if (document.cus.zj.value=="") {
     alert("�����Ϊ��");
	  return false;
   }
   
 
   return true;

}
 function remo(){
  document.cus.seller.options[document.cus.seller.selectedIndex]=null;
 for (var j=0;j<document.cus.seller.length;j++){
	 if (document.cus.seller.options[j].text!="")
	 document.cus.seller.options[j].selected=true;
	}
}
function FindOption(){
openwin2("FindCustomer.jsp?section="+document.cus.SecNo.value+"&FindCus="+document.cus.cusname1.value,400,380,300,100);  
 }
</script>

</HEAD>
<%

//���ɱ�����������

String RateSql="select * from currrate";
ResultSet RateRs=null;

try{
  RateRs=ViewBean.executeQuery(RateSql);

  out.print("<script>");
  out.print("var RateName=new Array();");
  out.print("var RateValue=new Array();");
  int iii=0;

   while (RateRs.next()){
     out.print("RateName["+String.valueOf(iii)+"]="+"\""+getbyte(RateRs.getString("CurrName"))+"\""+";");
     out.print("RateValue["+String.valueOf(iii)+"]="+"\""+RateRs.getString("CurrRate")+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
RateRs.close();
out.print("</script>");


          String Floor="";
		  String area="";
		  String fx="";
		  String cx="";
		  String jg="";
          String zx="";
          String state="";
		  String usearea="";
		  String apportionarea="";
		  String date="";
		  String fl="";
		  String unitprice="";
          String sumprice="";	
		  String picpath="";
	      String TNunitprice="";
     	  String name="";
		  String StrLoft="";
		  String StrBuilding="";
		  String StrSecNo="";
		  String StrRoom_code="";
	
		java.text.SimpleDateFormat date1 =null;
        date1=new java.text.SimpleDateFormat("yyyy-MM-dd");
        String TodayDate=date1.format(new java.util.Date()).toString();
        int curyear=Integer.parseInt(TodayDate.substring(0,4));
        int curmonth=Integer.parseInt(TodayDate.substring(5,7));
        int curday=Integer.parseInt(TodayDate.substring(8,10));
		String code="";
        String secno=China.getParameter(request,"secno") ;
		String roomno=China.getParameter(request,"roomno") ;
		String loft=China.getParameter(request,"loft");
		String sql="select R.*,S.Name from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.seccode+R.loft+R.room_code='"+secno+loft+roomno+"'";
		 
		java.text.DecimalFormat df = new java.text.DecimalFormat(" #########.####"); 
        java.text.DecimalFormat df1 = new java.text.DecimalFormat(" #########.##"); 
        java.text.DecimalFormat df2 = new java.text.DecimalFormat(" #########"); 
		ResultSet rs=ViewBean.executeQuery(sql);
	
		if (rs.next()){
		  code=rs.getString("Code");
		  StrSecNo=rs.getString("seccode");
		  StrLoft=getbyte(rs.getString("Loft"));
		  StrBuilding=getbyte(rs.getString("building"));
		  StrRoom_code=getbyte(rs.getString("Room_code"));
		  Floor=rs.getString("Floor");
		  area=df.format(rs.getFloat("Area"));
		  fx=getbyte(rs.getString("Room_Type"));
		  cx=getbyte(rs.getString("Direction"));
		  jg=getbyte(rs.getString("Scene"));
		  zx=getbyte(rs.getString("Fitment"));
          state=getbyte(rs.getString("salestate"));
		  usearea=df.format(rs.getFloat("UsedArea"));
		  apportionarea=df.format(rs.getFloat("ApportionArea"));
		  date=getbyte(rs.getString("Serve_Date"));
		  java.text.SimpleDateFormat Fdate =null;
  		  Fdate=new java.text.SimpleDateFormat("yyyy-MM-dd");
  		  if (!date.equals(""))
		  date=Fdate.format(Fdate.parse(date));
		  fl=getbyte(rs.getString("roomtype"));
		  unitprice=df1.format(rs.getFloat("Unitprice"));
          sumprice=df2.format(rs.getFloat("Sumprice"));
		  picpath=rs.getString("Map");
		  TNunitprice=df1.format(rs.getFloat("TNunitprice"));
	  	  name=getbyte(rs.getString("Name"));
     }
	 rs.close();
	
	 
	
	 
 %>
<BODY >
<script language="javascript" src="../public_js/public.js"></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 <form name="cus" method="POST" action="modi_save.jsp" ENCTYPE="multipart/form-data" >
<input type="hidden" name="action" > 
 <p align="center"><font size=3 class=FontColor><b>������Ϣ</b></font></p>
 <center>
 
 <script>
 
  function checkrg(){
 window.location="order.jsp?secname=<%=name %>&secno=<%=StrSecNo %>&roomno=<%=roomno%>&build=<%=StrBuilding%>&loft=<%=loft %>&Floor=<%=Floor %>&jldate=<%=date %>";
 
 }
  function checkqy(){
  //  if (confirm("ȷ���Ϲ���ȷ�Ϻ�ϵͳ�����������ݣ������˲������Ϲ���"))
	 window.location="orderok.jsp?secname=<%=name %>&secno=<%=StrSecNo %>&roomno=<%=roomno%>&build=<%=StrBuilding%>&loft=<%=loft %>&Floor=<%=Floor %>&jldate=<%=date %>"; 

 }
 </script>
<input type=radio name=choose onclick="checkrg();">�Ϲ�
 <input type=radio name=qy onclick="checkqy();">ֱ��ǩԼ
 
  
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center bordercolor="#000000" class="tablefill">
  <input type=hidden name=code value="<%=code %>">
  <tr>
    <td  class=roomleft>&nbsp;¥�����ƣ�</td>  
    <td  class=roomright  >&nbsp<%=name %><input type=hidden name=SecNa  readonly size=10  value=<%=name %>></td>
	<input type=hidden name=SecNo value="<%=StrSecNo%>">
         <input type=hidden name=SecName  value="<%=name %>">
		  
		 
	<input type=hidden name=Build readonly size=10 value="<%=StrBuilding %>">
	<input type=hidden name=RoomNo readonly size=15 value="<%=StrRoom_code%>">
	<input type=hidden name=Loft readonly size=15 value="<%=StrLoft%>">
	<input type=hidden name=jzarea readonly size=15 value=<%=area%>>
	<input type=hidden name=tnarea readonly size=15 value=<%=usearea%>>
    <td  class=roomleft>&nbsp;����</td>  
    <td  class=roomright  >&nbsp;<%=StrLoft+StrBuilding+StrRoom_code %></td>
  </tr>

  <tr>
    <td  class=roomleft>&nbsp;���������</td>
    <td  class=roomright  >&nbsp;<%=area%></td>
 
    <td  class=roomleft>&nbsp;���������</td>  
    <td  class=roomright  >&nbsp;<%=usearea%></td>
  </tr>
  <tr>
    <td  class=roomleft>&nbsp;�������ۣ�</td>
    <td  class=roomright  >&nbsp;<%=unitprice%></td>
 
    <td  class=roomleft>&nbsp;���ڵ��ۣ�</td>  
    <td  class=roomright  >&nbsp;<%=TNunitprice  %></td>
  </tr>
  <tr>
    <td  class=roomleft>&nbsp;�ܼۣ�</td>
    <td  class=roomright  >&nbsp;<%=sumprice %></td>
 
    <td  class=roomleft>&nbsp;��¥���ڣ�</td>  
    <td  class=roomright  >&nbsp;<%=date %></td>
  </tr>
   <% sql="select * from zl_info where sectionno+loft+roomno='"+secno+loft+roomno+"'";
    rs=ViewBean.executeQuery(sql);
	 if (rs.next()){
	  %>
	  <input type=hidden name=ht_code readonly size=10 value="<%=rs.getString("code")  %>">
  <tr>
    <td  class=roomleft>&nbsp;��ͬ�ţ�</td>
    <td  class=roomright  >&nbsp;<input type=text name=hth  size=20 value="<%=rs.getString("htn") %>"></td>
 
     <td  class=roomleft>&nbsp;����ǩ�����ڣ�</td>
    <td  class=roomright  >&nbsp;<input type=text name=Date2  size=10 value="<%=rs.getString("qd_date") %>"><input type=button name=Popu value=".." onClick="fPopUpCalendarDlg(Date2);return false"></td>
  
 
  </tr>
   <tr>
     <td  class=roomleft>&nbsp;��Ч���ڣ�</td>
    <td  class=roomright  >&nbsp;<input type=text name=Date1  size=10 value="<%=rs.getString("startdate") %>"><input type=button name=Popu value=".." onClick="fPopUpCalendarDlg(Date1);return false"></td>
 
    <td  class=roomleft>&nbsp;�������ڣ�</td>  
    <td  class=roomright  >&nbsp;<input type=text name=Date3  size=10 value="<%=rs.getString("enddate") %>"><input type=button name=Popu value=".." onClick="fPopUpCalendarDlg(Date3);return false"></td>
 
    
    </tr>
	
  <tr>
  <td  class=roomleft>&nbsp;�⻧���ƣ�</td>
	 
    <td  class=roomright >&nbsp;<input type=text name=cusname  size=25  value="<%=rs.getString("cusname") %>"onKeyDown="key(document.cus.cardid)"> </td>
 
   <td  class=roomleft>&nbsp;֤���ţ�</td>  
    <td  class=roomright  >&nbsp;<input type=text name=carid  size=25  value="<%=rs.getString("zjn") %>" onKeyDown="key(document.cus.phone)"></td>
     </tr>
<tr> 
<tr>
   <td  class=roomleft>&nbsp;��ϵ�ˣ�</td>  
    <td  class=roomright  >&nbsp;<input type=text name=linkman  value="<%=rs.getString("linkman") %>" size=25 onKeyDown="key(document.cus.phone)"></td>
     <td  class=roomleft>&nbsp;��ϵ�绰��</td>
    <td  class=roomright  >&nbsp;<input type=text name=phone   value="<%=rs.getString("phone") %>" size=25 onKeyDown="key(document.cus.bbj)"></td>
     </tr>
<tr> 
 <td  class=roomleft>&nbsp;������</td>
      <td  class=roomright   >&nbsp;<input type=text name="glf" value="<%=rs.getString("glf") %>"   size=20 onKeyDown="key(document.cus.save)">Ԫ/��
  </td>
 <td  class=roomleft>&nbsp;���</td>
      <td  class=roomright   >&nbsp;<input type=text name="zj" value="<%=rs.getString("zj") %>"  size=20 onKeyDown="key(document.cus.save)">Ԫ/��
  </td>
</tr>	
<tr> 
 <td  class=roomleft>&nbsp;Ѻ��</td>
      <td  class=roomright   >&nbsp;<input type=text name="yj"  value="<%=rs.getString("yj") %>" size=20 onKeyDown="key(document.cus.save)">Ԫ
  </td>
 <td  class=roomleft>&nbsp;��Ӫ��ʽ</td>
      <td  class=roomright   >&nbsp;<select name="jytype"><option value=��Ӫ>��Ӫ</option><option value=��Ӫ>��Ӫ</option></select>
  </td>
</tr>	  
<tr> 
   <td  class=roomleft>&nbsp;��Ӫҵ̬</td>
      <td  class=roomright   >&nbsp;<select name="yttype"><option value=0>��Ӫ</option><option value=1>��Ӫ</option></select>
  </td>
  <td  class=roomleft>&nbsp;��ӪƷ��</td>
      <td  class=roomright   >&nbsp;<input type=text name="product"  value="<%=rs.getString("product") %>" size=25 onKeyDown="key(document.cus.save)">
  </td>
</tr>	
<%String record_url1=rs.getString("fileurl1"); 
String record_url2=rs.getString("fileurl2"); 
%>
<tr> 
   <td  class=roomleft>&nbsp;����1</td>
      <td  class=roomright   >&nbsp;<input type="file" name="Map1" size="10" ><%if (!record_url1.equals("") && record_url1!=null){%> 
		 <a href="#" onclick="openwin1('<%=record_url1%>',1,1,1,1);"><img src="../images/i_sign.gif" border=0></a><%} %>
  </td>
  <td  class=roomleft>&nbsp;����2</td>
      <td  class=roomright   >&nbsp;<input type="file" name="Map2" size="10" ><%if (!record_url2.equals("") && record_url2!=null){%> 
		 <a href="#" onclick="openwin1('<%=record_url2%>',1,1,1,1);"><img src="../images/i_sign.gif" border=0></a><%} %>
  </td>
</tr>	
<tr> 
   <td  class=roomleft>&nbsp;��ע</td>
  
      <td  class=roomright   colspan="3" >&nbsp;<textarea name="context" cols="78" rows="4"><%=rs.getString("bak") %></textarea>
  </td>
</tr>	 
 </table>
  <P align="center">
  <input type=button name=save value="�� ��" onclick="loca1()">
  <input type=button name=cancel value="�� ��" onclick="window.close();">
  </p>
  <input type=hidden name=del value="ɾ��" onclick="delSeller(RSID);">
</center>
<%} rs.close(); %> 
</form>
<script>
function loca1(){
 if (checkedDate()){
    document.cus.save.disabled=true;
    document.cus.submit();
 }
 }
</script>
 
</BODY></HTML>