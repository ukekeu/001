<%@ page contentType="text/html;charset=GBK" %>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>�ͻ���ϸ��</title>
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
else order=" order by cus_name "+  " "+orderby;
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
    String search_like=China.getParameter(request,"search_like");
	String fields=China.getParameter(request,"fields");
	String searchWhere="";
   String searchWhere1="";
    if (!search_like.equals("")){
 
	searchWhere="  where "+fields+" = '"+search_like+"' ";
	searchWhere1="  and "+fields+" = '"+search_like+"' ";
	}
	 List list1=new LinkedList();//��ź�ͬCODE
	 List list2=new LinkedList();//��Ž����˹������ҵ
     String sqlArr="select   code,memberno  from order_contract where membert=1";
		    
		   ResultSet rsArr=ViewBean.executeQuery(sqlArr);
 
		   while (rsArr.next()){
		    list1.add(rsArr.getString("code"));
			list2.add(rsArr.getString("memberno"));
			}
			rsArr.close(); 
	 
	String sql="";
 
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
     String con_no="";
	String attention="";

out.print("<p align=center class=FontColor><font size=3><b>��Ա��Ϣһ����</b></font></p>");
%>
 

<body >

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
<% String sel=(String)request.getParameter("sel");
   String showGrade=getbyte1(request.getParameter("bir"));
   if(sel==null) sel="0";
   int colnum=0;
   int iiii=0;
   
     ResultSet rs3=null;
    %>
	  <input type=hidden name="bir">
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr> 
    <td class="<%if(sel.equals("0")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=0;document.form1.bir.value='1';findSub('visitcusview.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��������</font> 
	</td>
	 
	 <td class="<%if(sel.equals("1")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=1;document.form1.bir.value='2';findSub('visitcusview.jsp');"> <font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���²�������</font> 
	</td>
	 <td class="<%if(sel.equals("2")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=2;document.form1.bir.value='3';findSub('visitcusview.jsp');"> <font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>δ�Ǽ�����</font> 
	</td>
	</tr></table>
	<script>
function findSub(para){
   document.form1.action=para+"?Search=b&Find=b";
   document.form1.submit();


}
</script>
 <%
//Ȩ�����
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"C002");
 %>
 
	 <%
	if (Cortrol==null)Cortrol="";
	%>
     <%if (Cortrol.indexOf("A")>=0){ %><input type=button name=add value="�� ��" onclick="addCus();"><input type=button name=add value="����" onclick="addCus1();"><%} if (Cortrol.indexOf("E")>=0){ %><input type=button name=modi value="�� ��" onclick="view();" title="�޸�ʱ���뵥���޸ĵĿͻ���Ϣ"><%}  if (Cortrol.indexOf("D")>=0){ %><input type=button name=del value="ɾ ��" onclick="Dele();" title="ɾ��ʱ���뵥��ɾ���Ŀͻ���Ϣ"><%}  if (Cortrol.indexOf("F")>=0){ %> <!--<input type=button name=pro value="�ͻ���ϸ��" title="��ӡ" onclick="if (cusno==''){alert('��ѡ��ͻ�');}else{openwin('CusFeedBack.jsp?para='+cusno,500,400,100,100);}">--><%}if (Cortrol.indexOf("F")>=0){ %><%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
    
   <%} %><select name=fields onchange="ch(this.value);">
   <option value=cus_name>�ͻ�����</option>
   <option value=of_tel>�칫�绰</option>
   <option value=ho_tel>��ͥ�绰</option>
   <option value=sj>�ֻ�</option>
   <option value=fax>����</option>
   <option value=wenhua>ѧ��</option>
      <option value=ah>����</option>
	  <option value=tc>�س�</option>
	
	  <option value=hy>����</option>  
	  <option value=job>ְҵ</option>  
	    <option value=con_no>��ͬ��</option>  
	  <option value=wy_addr>��ҵ��ַ</option>  
	  </select>
   <input type=text name=search_like size=20 title="ģ����ѯ���ɲ�ѯ�������绰����ַ��˫���ɵ�������" ondblclick="fPopUpCalendarDlg(search_like);return false;" value="<%=search_like %>"><input type=button name=fin value="�� ѯ"  onclick="document.form1.submit();" ></td>  </tr></table>
     <input type=button name=sendmess value="���Ͷ���" onclick="sendmessage();">
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
 

<table BORDER=0 width="100%"  id=AutoNumber  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr  class=listtitle>
      <td height="25"  align="center"><font color=white><input type=checkbox name=ch onclick="chhoseData(this.checked);">���</font></td>

	 <td  align="center"><font color=white>�Ƿ���ܿͻ�</font></td>	 
  <td  align="center"><font color=white>��Ա����</font></td>
   <td  align="center"><font color=white>�Ա�</font></td>
  <td  align="center"><font color=white>�칫�绰</font></td>
  <td  align="center"><font color=white>�ֻ���</font></td>
 
  <td  align="center"><font color=white>��ͬ��</font></td>
  <td  align="center"><font color=white>��ҵ��ַ</font></td>

  </tr>
��
 <%	
 ResultSet rs=null;
  try{

 if (showGrade.equals("")||showGrade.equals("1"))showGrade=" and month(cs_date)=month(getdate())";
 else if (showGrade.equals("2"))showGrade=" and month(cs_date)<>month(getdate()) and not cs_date  is null";
 else  if (showGrade.equals("3"))showGrade=" and cs_date is null";
  
  strWhere+=showGrade ;
 sql="select Top "+pageSize+"   * from VIPCUSTOMER where    Code not in (Select top "+prenum +" code from VIPCUSTOMER where code>0 "+searchWhere+showGrade+"  ) "+searchWhere+showGrade ;
 
 sqlcount="SELECT count(code) from VIPCUSTOMER where code>0  "+searchWhere+showGrade;
 
    rs=ViewBean.executeQuery(sql +order);
 if (orderby.trim().equals("desc"))orderby="asc";
	 else orderby="desc";
int tr=0;

	
   while (rs.next()){  
     i=i+1;
 
     String code=getbyte(rs.getString("code"));
     name=getbyte(rs.getString("Cus_Name"));
     sex=getbyte(rs.getString("Sex"));
     tel=getbyte(rs.getString("of_tel"));
	 sj=getbyte(rs.getString("sj"));
     address=getbyte(rs.getString("wy_addr"));
	 con_no=getbyte(rs.getString("con_no"));
    

  %>
 
 <tr id=TR<%=i %>   trid=tr<%=tr %> align="center" class=listcontent  onmouseover="mout(this);"  onclick="savepara('<%=code%>');changeclass1(this,'clickbg','listcontent');" ondblclick="Edit('<%=code%>');" title="˫���鿴��Ա��ϸ����"> 
<td   ><input type=checkbox name=choos value="<%=sj %>|<%=address%>"><%=i%></td> 
  <%  
  String conno="";
  if (list2.contains(address)){
		  int index=list2.indexOf(address);
		  conno=(String)list1.get(index); 
		}  
	 %>
	   <td  align="left"><%if (conno.equals("")){out.print("��");}else{%><a href='#' onclick="openwin('../sale/crm_member_list.jsp?addressno=<%=address %>',850,500,100,100);"><font color=red>��</font></a><%} %>��&nbsp;</td>
       <td  align="left"><%=name  %>��&nbsp;</td>
	   <td  align="left"><%=sex  %>��&nbsp;</td>
       <td  align="left"><%=tel %> </td>
	   <td  align="left"><%=sj %> </td>
	 
 

	  
    <td  align="center"><%=con_no %>&nbsp;</td>
	 <td  align="left" title="<%=address %>"> <%
	 
	if (address.length()>14)address=address.substring(1,14)+"...";
	 
	out.print(address);
	%>&nbsp;</td>
   </tr>

<%

  }
   
   
}catch(Exception s){out.println(s.getMessage());}
 
rs.close();
 

 %> 
 </div>
</div>
  <%@ include file="../public_js/changepage.jsp"%>

</form>
</center>

<script>
 
   var cusno="";
 

	function Dele(){
	 if (confirm("���Ҫɾ��ѡ��Ŀͻ���Ϣ��")){
 
   	      if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		else{openwin("deletecusdata.jsp?del=cus&cusno="+cusno,10,10,10,10);}
	  }
	}
	
	function Edit(para){
	  if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		   else{openwin("editcustomer.jsp?cusno="+para,560,560,100,5);}
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
  //if (document.form1.section.value==""){alert("��ѡ��¥��");return false;}
   openwin('customerin.jsp',560,560,100,5)
   }
     function addCus1(){
  //if (document.form1.section.value==""){alert("��ѡ��¥��");return false;}
   openwin('visitcusview3.jsp',560,560,100,5)
   }
   
  function FindCusState(){
	document.form1.Find.value="o";
    document.form1.Findsection.value=document.form1.section.value;
    //document.form1.cusche.value=document.form1.stateValue.options[document.form1.stateValue.selectedIndex].value;
   document.form1.submit();
  
  }
  function ch(para){
   if (para=="visit_date"){
  fPopUpCalendarDlg(document.form1.search_like);return false;

  }
  else
  document.form1.search_like.value="";
  }
  </script>

<script>
function findSub(para){
   document.form1.action=para;
   document.form1.submit();


}

function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
    }

}
var sendmess="";
var sendto="";
function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
	 
    }

}
function chhoseData1(){
sendmess="";
sendto="";
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

}
function sendmessage()
{
chhoseData1();
 
 if (sendmess==""){alert("��ѡ��ͻ�");return false;}
openwin1("../../sendmessage/SendMessage.jsp?messtype=4&sendmess="+sendmess+"&sendto="+sendto,400,300,100,100);
}
  </script>
</body>
</html>
