<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>��ʧ�ͻ���ϸ��</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%
String menu= (String)session.getAttribute("menu");
 
if (menu==null)menu="1";
 if (menu.equals("1")){
 %>
<script>
this.resizeTo(screen.availWidth,screen.availHeight)
this.moveTo(0,0)
this.focus()
</script>
<%} %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
String CusName="";
String Condi="";
String Condi1="";
String CusAge="";
String year="";
String year1="";
String month="";
String day="";
String CusType="";
String BuyType="";
String CusVisitDate="";
String strWhere="";
String section="";
String custype="";
String cusche="";
String FindCondition="";//���ݲ�������
 
String order=getbyte1(request.getParameter("order"));
String orderby=getbyte1(request.getParameter("orderby"));
if (orderby.equals(""))orderby="desc";
 
if (!order.equals(""))order=" order by "+order+" "+orderby;
else order=" order by visit_date "+  " "+orderby;
String prin=request.getParameter("print");
String Find=request.getParameter("FindS");
String tmp=request.getParameter("pageno");

String FindCon=(String)request.getParameter("condtion");
if (Find!=null){
   
  //ȡ������ֵ

   CusName=request.getParameter("cusname");//�ͻ�����
   Condi=request.getParameter("condi");//����1
   section=request.getParameter("section");//ȡ��¥��

   Condi1=request.getParameter("condi1");//����2
   CusAge=request.getParameter("age");//�ͻ�����
   year=request.getParameter("SDate");//�ͻ���������
   year1=request.getParameter("EDate2");//�ͻ���������
 
   custype=request.getParameter("cusche");//�ͻ�״̬

   if (section==null)section="";
   if (!section.equals(""))
   strWhere=" and customer.section ='"+section+"'" ;
   FindCondition="customer.section='"+section+"'";
   FindCondition=FindCondition+"&Find="+Find;
   FindCondition=FindCondition+"&cusche="+custype;
 
   if (year!=null&&year1==null){
	   if (year.length()>0){
		 if (strWhere.equals("")){strWhere=" and customer.visit_date='"+year+"'";}
		 else {strWhere+=" and customer.visit_date='"+year+"'";}
		 FindCondition=FindCondition+"&year="+year;
		}
    }
   if (year1!=null&&year==null){
	   if (year1.length()>0){
	   	 if (strWhere.equals("")){strWhere=" and customer.visit_date='"+year1+"'";}
		 else {strWhere+=" and customer.visit_date='"+year1+"'";}
		 FindCondition=FindCondition+"&year1="+year1;
	     }
    }
 
   if (year1!=null&&year!=null){
	   if (year1.length()>0){
	   	 if (strWhere.equals("")){strWhere=" and customer.visit_date between '"+year+"' and '"+year1+"'";}
	     else strWhere+=" and customer.visit_date between '"+year+"' and '"+year1+"'";
		 FindCondition=FindCondition+"&year1="+year1+"&year="+year;
	     }
    }


   CusType=request.getParameter("custype");
   BuyType=request.getParameter("gmyt");

 if ((CusName!=null)&&(CusName.length()>0)){
   if (tmp==null){
   CusName= new String(CusName.getBytes("ISO8859_1"),"GBK");
   }
    if (strWhere.equals("")){ strWhere=" and  customer.Cus_Name like '%"+CusName+"%'";
	}else{ strWhere+=" and customer.Cus_Name like '%"+CusName+"%'";}
   FindCondition=FindCondition+"&cusname="+CusName;
   }

 if ((CusAge!=null)&&(CusAge.length()>0)){
   if (strWhere.equals("")){strWhere=" and customer.cus_age "+Condi+CusAge;}
   else{strWhere=strWhere+" and customer.cus_age "+Condi+CusAge;}
   FindCondition=FindCondition+"&age="+CusAge;
 }

 if (CusType!=null){
   if (CusType.length()>0){
	   if (tmp==null){
	     CusType= new String(CusType.getBytes("ISO8859_1"),"GBK");
	   }
       if (strWhere.equals("")){strWhere=" and customer.Cus_Type='"+CusType+"'";}
       else{strWhere=strWhere+" and customer.Cus_Type='"+CusType+"'";}
   FindCondition=FindCondition+"&custype="+CusType;
   }  
 }  

 if (BuyType!=null){
  if (BuyType.length()>0){
    if (tmp==null){
    BuyType= new String(BuyType.getBytes("ISO8859_1"),"GBK");
    }
    if (strWhere.equals("")){strWhere=" and customer.Purpose='"+BuyType+"'";}
    else{strWhere=strWhere+" and customer.Purpose='"+BuyType+"'";}
    FindCondition=FindCondition+"&gmyt="+BuyType;
   }  
 }
 
}

%>

<%@ include file="../public_js/CheckSection.jsp"%>

<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/countpagenum.jsp"%>
<%
   String search_like=China.getParameter(request,"search_like").trim();
	String fields=China.getParameter(request,"fields").trim();
	String searchWhere="";
 
    if (!search_like.equals("")){
	 if (!fields.equals("visit_date"))
	searchWhere="  and "+fields+" like '%"+search_like+"%' ";
	else
	searchWhere="  and "+fields+" = '"+search_like+"' ";
	}
	 strWhere+=searchWhere;
  String lffs="";
 
if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
 
	String sql="";
	int totalnum=0;
    //��ȡ��ѯ����
	
	String con=FindCon;
	if (FindCon!=null){
    	FindCon=" = "+FindCon;
    	}
    else{
	   FindCon="='0' ";
	 }  
	String condtion=FindCon;		
    String eof="false";
	
	String PubPra=(String)session.getAttribute("Attribute");	
    String user=(String)session.getAttribute("loginname");	
	String job=(String)session.getAttribute("job");	
	 if (job.indexOf("����Ա")>=0){
	    strWhere+=" and seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }
	//out.print(strWhere);
  
	//��������ֵ�ı���
    String no="";
    String name="";
    String sex="";
    String age="";
    String sale="";
    String date="";
    String tel="";
    String idcard="";
    String sell="";
	int i=0;
    String roomtype="";
    String area="";
    String tj="";
    String region="";
    String linkman="";
    String address="";
    String bbj="";
    String sj="";
    String post="";
	String attention="";
    String menusel=China.getParameter(request,"menusel");
    if(menusel.equals("")) menusel="0";
 %>
<script>
function full(){
 setSelectMad(document.form1.section,'<%=request.getParameter("section") %>');
  setSelectMad(document.form1.order,'<%=request.getParameter("order") %>');

 setSelectMad(document.form1.fields,'<%=request.getParameter("fields") %>');
}
function findSub(para){
   document.form1.action=para+"?Search=b&Find=b";
   document.form1.submit();


}
</script> 
<body onload="full()" topmargin="0" oncontextmenu="return false" >
<form name=form1 method="post" >
<input type=hidden name="SDate">
<input type=hidden name="EDate2">
<input type=hidden name="custype">
<input type=hidden name="gmyt">
<input type=hidden name="tel">
<input type=hidden name="age">
<input type=hidden name=cusname>
<input type=hidden name=FindS>
<input type=hidden name=Findsection>
<input type=hidden name=condi>
  <input type=hidden name="menusel" value="<%=menusel %>">
<table width="320" border="0" cellspacing="0" cellpadding="0" class="L2"  >
   <tr> 
    <td  class="<%if(menusel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=3;findSub('visitcusview_alert.jsp');""><font color='<%if(menusel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��������</a>
	</td>
     <td  class="<%if(menusel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=0;findSub('visitcusview.jsp');""><font color='<%if(menusel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�����ͻ�</a>
	</td>
	  <td  class="<%if(menusel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=2;findSub('visitcusview9.jsp');""><font color='<%if(menusel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>����ͻ�</a>
	</td>
   <td class="<%if(menusel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#"onclick="document.form1.menusel.value=1;findSub('visitcusview8.jsp');""><font color='<%if(menusel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��ʧ�ͻ�</a>
	</td> 
	</tr>
</table>
<p align=center class=FontColor><font size=3><b>��ʧ�ͻ���Ϣһ����</b></p>
 
 <%
//Ȩ�����
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"C002");
 %>
 
 
   <table width=100% border="0"><tr height="16" ><td align="left">¥�̣�<select name="section" onchange="changesub(this.value);"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
	 &nbsp;&nbsp;<select name="order" onchange="changesub(this.value);"><option value="cus_name">��������������</option><option value="visit_date">��������������</option></select>
	  
	
	 <br>
	 <%
	if (Cortrol==null)Cortrol="";
	%>
    <input type=button name="setcode" value="������ʧԭ��ѡ��" onclick="openwin('SetCodeValue.jsp?type=0',300,400,100,100);"><%   if (Cortrol.indexOf("F")>=0){ %><input type=button name=count title="��ʧԭ�����" value="�� ��" onclick="if (document.form1.section.value==''){alert('��ѡ��¥��');}else{openwin('LsCustomerFX.jsp?SecNo='+document.form1.section.options[document.form1.section.selectedIndex].value,550,380,200,50);}"> <input type=button name=prin title="��ӡ/����" value="�� ӡ" onclick="openwin('auto_select4.jsp?para=1&choose=1',400,300);"><%} %>
    <%   if (Cortrol.indexOf("D")>=0){ %><input type=button name=del value="ɾ ��" onclick="Dele();" title="ɾ��ʱ���뵥��ɾ���Ŀͻ���Ϣ"><%} %> <input type=button name=sms value="�� ��"   title="��ѡ�����ʧ�ͻ�תΪ����ͻ�"  onclick="JH();">
    <select name=fields onchange="ch(this.value);">
   <option value=cus_name>�ͻ�����</option>
   <option value=phone>��ϵ�绰</option>
 
     <option value=sj>�ֻ���</option>
   <option value=address>��ϵ��ַ</option>
   <option value=visit_date>��������</option>
   <input type=text name=search_like size=20 title="ģ����ѯ���ɲ�ѯ�������绰����ַ��˫���ɵ�������" ondblclick="fPopUpCalendarDlg(search_like);return false;" value="<%=search_like %>"><input type=button name=fin value="�� ѯ"  onclick="document.form1.submit();" ></td>  </tr></table>
   
<script>
			function printall() {
			   	printdiv.innerText ="";
                 print(); 
			}
			function ordersubmit(){
			 if (document.form1.section.value!="")
			     changesub(document.form1.section.value);
			 document.form1.submit();	 
			}
			function changesub(para){
			document.form1.Findsection.value=para;
			
			document.form1.Find.value="o";
	 			document.form1.submit();
			
			}
</script>
<input type=hidden name="Find">
<input type=hidden name="Findsection">
<input type=hidden name="cusname">
<input type=hidden name="condi">
<input type=hidden name="age">
<input type=hidden name="tel">
<input type=hidden name="condi1">
<input type=hidden name="SDate1">
<input type=hidden name="Date2">
<input type=hidden name="custype">
<input type=hidden name="gmyt">
<input type=hidden name="cusche">
 


<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" >
      <td width="5%"  align="center">���</td>
  <td  align="center">�ͻ�����</td>
 
  <td  align="center">��ϵ�绰</td>
  <td  align="center">��ϵ��ַ</td>
 
  <td  align="center">��������</td>
  <td  align="center">����Ա</td>
  <td  align="center" width="20">&nbsp;</td>
  </tr>
��
 <%	
 
 sql="select Top "+pageSize+"     * from customer where  state=1 and    Code not in (Select top "+prenum +" code from customer where     state=1     " +strWhere +order+") " + strWhere;
 sqlcount="SELECT count(code) from customer  where  state=1 and       Section in("+SectionS+")  "+strWhere;
 ResultSet rs=null;
 rs=ViewBean.executeQuery(sql +order);
 if (orderby.trim().equals("desc"))orderby="asc";
	 else orderby="desc";
  try{
   int tr=0;
    while (rs.next()){
	 eof="true";
     i=i+1;
      no=rs.getString("SerialNo").trim();
      name=getbyte(rs.getString("Cus_Name"));
      sex=getbyte(rs.getString("Cus_Sex"));
      tel=getbyte(rs.getString("Phone"));
	  sj=getbyte(rs.getString("sj"));
      address=getbyte(rs.getString("address"));
	  post=getbyte(rs.getString("Zip_Code"));
      sell=getbyte(rs.getString("seller"));
	  date=getbyte(rs.getString("visit_date")); 
  %>
 
 <tr id=TR<%=i %>   trid=tr<%=tr %> align="center"   onmouseover="mout(this);"  onclick="savepara('<%=no%>');changeclass1(this,'clickbg','');" ondblclick="Edit('<%=no%>');" > 
 <td  align="left" width="5%"> <input type="checkbox" name="choos" cusno=<%= no%> value="<%=sj+"|"+name%>"><%=i %>��</td>
    <td  align="left"><a href="#" onclick="openwin('editcustomer.jsp?cusno=<%=no %>',560,560,100,5);" title="������Ե��������޸�����"><%=name %></a>��&nbsp;</td>
     <td  align="left">
	<%String strt="";
	String strs="";
	//if (tel.indexOf(" ")>0)strt=" ";
	if (tel.indexOf("/")>0)strt="/";
	//if (sj.indexOf(" ")>0)strs=" ";
	if (sj.indexOf("/")>0)strs="/";
	 %>
	<%out.print(tel);  
	  %> <%=sj%>&nbsp;</td>
	 
 
<td  align="left" title="<%=address %>"> <%
	 
	if (address.length()>14)address=address.substring(0,14)+"...";
	if (!post.trim().equals(""))address+="("+post+")" ;
	out.print(address);
	%>&nbsp;</td>
	  
    <td  align="center"><%=date.substring(0,10) %>&nbsp;</td>
	<td  align="center"><%=sell%>&nbsp;</td>
	<td  align="center" width="8%" title="ѡ��ͻ���ʧԭ��"><a href="#" onclick="openwin('SetCustomerCodeValue.jsp?customer=<%= no%>',300,300,100,100);">��ʧԭ��</a></td>
   </tr>
<%
  }
      
}catch(Exception s){out.println(s.getMessage());}
 
rs.close();
if (eof.equals("false")){
   out.print("û���ҵ��ͻ���¼"); 
  
   }

 

 %> 
 
  <%@ include file="../public_js/changepage.jsp"%>

</form>
</center>

<script>
 
   var cusno="";
    function Edit(para){
    	
   	         if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		     else{ openwin("CusFeedBack.jsp?cusno="+para,560,560,100,5);}
	
	}

	function Dele(){
	 if (confirm("���Ҫɾ��ѡ��Ŀͻ���Ϣ��")){
	    chhoseData11();
		 
	    if (cusno==""&&choosecusno=="")
   	      {alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		else{
		
		
		openwin("deletecusdata.jsp?del=cus&cusno="+cusno+"&choosecusno="+choosecusno,10,10,10,10);}
	  }
	}
	
	function view(){
	  if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		   else{openwin("editcustomer.jsp?cusno="+cusno,560,560,100,5);}
	  }

    function savepara(para){
			  cusno=para;
			 
			  }
  function show(dd,obj){
  var  tr=document.all.AutoNumber.rows;

  for( var i=0;i<tr.length;i++){
    if (tr[i].trid=="tr"+dd)  
	 tr[i].style.display=(tr[i].style.display=="none")?"block":"none";
   }
   
  var img1="jia.gif";
  var img2="jian.gif";
  
  s=obj.src;
  no=parseInt(obj.no);
  if(s.indexOf("jian.gif")>-1){
     obj.src=s.replace("jian.gif","jia.gif");
  }else{
     obj.src=s.replace("jia.gif","jian.gif");
  }
  }
  function addCus(){
    if (document.form1.section.value==""){alert("��ѡ��¥�����ƣ���ȷ�����ӵĿͻ������ĸ�¥�̵������ʿͻ�");return false;}
     openwin('customerin.jsp?section='+document.form1.section.value,620,560,100,5)
   }
   function addCus1(){
    if (document.form1.section.value==""){alert("��ѡ��¥�����ƣ���ȷ�����ӵĿͻ������ĸ�¥�̵������ʿͻ�");return false;}
     openwin('ExcelToCus.jsp?section='+document.form1.section.value,360,260,200,205)
   }
    function addCus2(){
    if (document.form1.section.value==""){alert("��ѡ��¥�����ƣ���ȷ�����ӵĿͻ������ĸ�¥�̵������ʿͻ�");return false;}
    showx = screen.availWidth;  // + deltaX;
	showy = screen.availHeight; // + deltaY;
     	 retval = window.showModalDialog("customerTo.jsp?section="+document.form1.section.value,"","dialogWidth:"+showx+"; dialogHeight:"+showy+"; dialogLeft:150px; dialogTop:20px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	 }
   
  function FindCusState(){
	document.form1.Find.value="o";
    document.form1.Findsection.value=document.form1.section.value;
     document.form1.submit();
  
  }
  function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
	 
    }

}
  function ch(para){
   if (para=="visit_date"){
  fPopUpCalendarDlg(document.form1.search_like);return false;

  }
  else
  document.form1.search_like.value="";
  }
  
  
var sendmess="";
var sendto="";
var choosecusno=""; 
function chhoseData11(){
  choosecusno="";
  if (document.form1.choos.length){
   for (var i=0;i<document.form1.choos.length;i++){
 	
	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].cusno;
	 
	    if (choosecusno=="")
		 choosecusno="'"+aa+"'";
		else
		 choosecusno+=",'"+aa+"'";
	  }
	   
    }
	}else if (document.form1.choos.checked){
	  var aa=document.form1.choos[i].cusno;
	   choosecusno="'"+aa+"'";
	}
 
}
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

var choosecusno=""; 
function chhoseData11(){
  choosecusno="";
  if (document.form1.choos.length){
   for (var i=0;i<document.form1.choos.length;i++){
 	
	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].cusno;
	 
	    if (choosecusno=="")
		 choosecusno="'"+aa+"'";
		else
		 choosecusno+=",'"+aa+"'";
	  }
	   
    }
	}else if (document.form1.choos.checked){
	  var aa=document.form1.choos.cusno;
	   choosecusno="'"+aa+"'";
	}
 
}
function sendmessage()
{
chhoseData1();
 
 if (sendmess==""){alert("��ѡ��Ŀͻ�����û�������ֻ��ţ�������ѡ��ͻ�");return false;}
openwin1("../../sendmessage/SendMessage.jsp?messtype=3&sendmess="+sendmess+"&sendto="+sendto,400,300,100,100);
}
  function JH(){
 if (confirm("ȷ��ѡ��Ŀͻ�תΪ����ͻ���"))
 { chhoseData11();
  openwin("toJHCustomer.jsp?cusno="+choosecusno,10,10,10,10);
 
 }
}
  </script>

</body>
</html>
