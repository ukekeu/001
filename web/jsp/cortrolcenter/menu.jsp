  <%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<HTML><HEAD>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=NO-CACHE http-equiv=PRAGMA>
<LINK href="../class/news.css" rel=stylesheet type=text/css>
<META content="Microsoft FrontPage 4.0" name=GENERATOR>
<base target="main">
</HEAD>
<script>
  function ChooseForm(){
    var choose=document.frm.choose.checked;//[0]
    if (choose)
	   parent.main.document.frm.action="RoomPriceShow.jsp";//RoomChooseView.jsp";
	else
	   parent.main.document.frm.action="RoomPriceShow.jsp";

	   parent.main.document.frm.submit();	
   }
	 function ChooseFind(){
	
	   if (document.frm.Section.options[document.frm.Section.selectedIndex].value!="")
		{
				
		parent.main.document.frm.SecNo.value=document.frm.Section.options[document.frm.Section.selectedIndex].value;
		 var secname=document.frm.Section.options[document.frm.Section.selectedIndex].value;
		 parent.main.document.frm.SecName.value=secname.substring(secname.indexOf("*")+1);;
		}
	   if (document.frm.Loft.length>0){
		if (document.frm.Loft.options[document.frm.Loft.selectedIndex].value!="")
	 	parent.main.document.frm.Loft.value=document.frm.Loft.options[document.frm.Loft.selectedIndex].value;
	   }
       if (document.frm.Building.length>0){
		if (document.frm.Building.options[document.frm.Building.selectedIndex].value!="")
		parent.main.document.frm.Building.value=document.frm.Building.options[document.frm.Building.selectedIndex].value;
	   }
	
	  //if (document.frm.choose.checked){//[0]
	
	   /* if (document.frm.RoomCode.value!="")
		parent.main.document.frm.RoomCode.value=document.frm.RoomCode.value;
		if (document.frm.Floor.value!="")
		parent.main.document.frm.Floor.value=document.frm.Floor.value;
	    if (document.frm.area.value!=""&&document.frm.tj1.options[document.frm.tj1.selectedIndex].value!="")
		{
		parent.main.document.frm.tj1.value=document.frm.tj1.options[document.frm.tj1.selectedIndex].value;
		parent.main.document.frm.area.value=document.frm.area.value
		}
		 if (document.frm.UnitPrice.value!=""&&document.frm.tj.options[document.frm.tj.selectedIndex].value!="")
		{
		parent.main.document.frm.tj.value=document.frm.tj.options[document.frm.tj.selectedIndex].value;
		parent.main.document.frm.UnitPrice.value=document.frm.UnitPrice.value
		}
		
		if (document.frm.RoomType.options[document.frm.RoomType.selectedIndex].text!="")
		parent.main.document.frm.RoomType.value=document.frm.RoomType.options[document.frm.RoomType.selectedIndex].text;
	  	*/
	    parent.main.document.frm.action="RoomPriceShow.jsp";//RoomChooseView.jsp";
		  
	//}else{
	  if (parent.main.document.frm.Loft.value==""){
	     alert("请选择区号");
	     return (false);
	  }
	/*  if (parent.main.document.frm.Building.value==""){
	     alert("请选择栋号");
	     return (false);
	  }*/
	//   if (document.frm.Floor.value!="")
	  //  parent.main.document.frm.Floor.value=document.frm.Floor.value;
		
	    parent.main.document.frm.action="RoomPriceShow.jsp";
	//}
       
 		parent.main.document.frm.submit();
   }
 function FindCheck(para){
    // if (document.frm.choose[1].checked){
	    document.frm.RoomCode.disabled=para;
		document.frm.tj1.disabled=para;
		document.frm.tj.disabled=para;
		document.frm.area.disabled=para;
		document.frm.RoomType.disabled=para;
	    document.frm.UnitPrice.disabled=para;
		
 
 }	 
</script>
<BODY leftMargin=0 bgcolor="#6E91D5" topMargin=0 >
<%@ page language="java" import="java.sql.*,java.lang.*,,java.util.*" %>

<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/CodeSele.jsp"%>
<form name=frm>
<%String param="P"; %>
<%@ include file="../public_js/CheckPopedom.jsp"%>
<TABLE    width=100% align=center border=0 cellPadding=0 cellSpacing=0   align="top" > 
<tr><td>&nbsp;</td></tr>
<tr align="center"><td ><font size=3  color="white"><b><input type=radio name=choose checked onclick=" FindCheck(false)">查询条件</b></font></td></tr>
<tr><td>&nbsp;</td></tr>
<!--<tr align="center"><td>

 &nbsp;<font color=white>列表<input type=radio name=choose title="选中查询调价记录" onclick="FindCheck(true)">状态表</font>
</td></tr>-->
<tr><td>&nbsp;</td></tr>
<%@ include file="../public_js/CheckSection.jsp"%>


<tr align="center"><td>
 &nbsp;<font color="white">楼&nbsp;盘</font><select name="Section" style="width : 80" OnChange="FindArry();">
           <option></option>
		  <%
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
  	 String na="";
	 String no="";
     String  sql="select SerialNo,Name FROM crm_project where SerialNo in("+SectionS+")";
     ResultSet rs=ViewBean.executeQuery(sql);
     while (rs.next()){
		no=rs.getString("SerialNo");
		na=getbyte(rs.getString("Name"));
	    %> 
            <option value=<%=no+"*"+na %>><%=na %></option>
            <%}%>
			

          </select>
	<%rs.close();
     sql="select  SectionNo,Region,Building from roomno group by SectionNo,Region,Building";
     ResultSet Rs=ViewBean.executeQuery(sql);
     out.print("<script>");
     out.print("var SecionCus=new Array();");
     out.print("var Loft=new Array();");
	  out.print("var Build=new Array();");
      i=0;
     while (Rs.next()){
	  out.print("SecionCus["+String.valueOf(i)+"]="+"\""+getbyte(Rs.getString("SectionNo"))+"\""+";");
      out.print("Loft["+String.valueOf(i)+"]="+"\""+getbyte(Rs.getString("Region"))+"\""+";");
	  out.print("Build["+String.valueOf(i)+"]="+"\""+getbyte(Rs.getString("Building"))+"\""+";");
	 i=i+1;
    }	 
 %> 
 function FindArry(){

 //if (document.frm.Section.options[document.frm.Section.selectedIndex].value!="") document.frm.Search.disabled=false;
 //else  document.frm.Search.disabled=true;
 var i=1;
 var loft="";
    cleasele();
    document.frm.Loft.options[i]=new Option("","");
    for (var j=0;j<SecionCus.length;j++){
	 var secno=document.frm.Section.options[document.frm.Section.selectedIndex].value;
	 secno=secno.substring(0,secno.indexOf("*"));
	 if (secno==SecionCus[j]){
	    document.frm.sel.value=secno;
		//alert(document.frm.Loft.options[0]);
		if (loft!=Loft[j]){
		document.frm.Loft.options[i]=new Option(Loft[j],Loft[j]);
	    loft=Loft[j];
		i++;
		}
	} 
	
	}
   }
   function FindArry1(){
   var i=1;
    var secno=document.frm.sel.value;
	var loft=document.frm.Loft.options[document.frm.Loft.selectedIndex].value;
	for (var j=0;j<SecionCus.length;j++){
	 if (secno==SecionCus[j]&&Loft[j]==loft){
	    document.frm.Building.options[i]=new Option(Build[j],Build[j]);
		i++;
	} 
	}
   }
   function cleasele(){
    document.frm.Loft.length=0;
    document.frm.Building.length=0;
   }	
   </script>

	   <input type=hidden name=sel>
       &nbsp;<font color="#FFFFFF">区&nbsp;号</font><select name="Loft" style="width : 80" OnChange="FindArry1();">
		
          </select>
        <br>&nbsp;<font color="#FFFFFF">栋&nbsp;号</font><select  style="width : 80" name="Building">
          </select>
      <br>	<!--
	&nbsp;<font color="#FFFFFF">楼&nbsp;层</font><input type=text name=Floor size="10" style="border-style: solid; border-width: 1">
	
	 <br>
	 &nbsp;<font color="#FFFFFF">房&nbsp;号</font><input type=text name=RoomCode size="10" style="border-style: solid; border-width: 1">
	<br>	
	&nbsp;<font color="#FFFFFF">面&nbsp;积</font><select name=tj1><option value="=">=</option><option  value=">=">>=</option><option  value="<"><</option></select><input type=text  size="4.5" name=area style="border-style: solid; border-width: 1">
	<br>&nbsp;<font color="#FFFFFF">单&nbsp;价</font><select name=tj><option value="=">=</option><option value=">=">>=</option><option value="<"><</option></select><input type=text size="4.5" name=UnitPrice style="border-style: solid; border-width: 1">
    <br>
	&nbsp;<font color="#FFFFFF">户&nbsp;型</font><select name="RoomType" style="width : 80">
		  <option></option>
  <%
 /*  for (int ii=0;ii<20;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }*/
  %>
	    <!--  </select>-->
		 
	     </td>
      </tr>	
	    <tr align="center"><td>&nbsp;</td></tr>
	  <tr align="center"><td><input type="button" name="Search" value="提 交"  onclick="ChooseFind();">&nbsp;<input type="button" name="Cancel" value="重 选">  </td></tr>
	  </TABLE>

  </form>

  </BODY>
  </HTML>
