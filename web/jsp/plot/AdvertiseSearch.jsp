<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<link rel="stylesheet" href="../class/news.css" >
<script language=javascript src="../sale/js/mad.js"> </script>
<script  src="../public_js/calendar.script"></script>
<script  src="../public_js/Popup.js"></script>     
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>
<%
	/*
      	String 	id2 = setpro.getId();
      	boolean service = setpro.getService();
      	if (id2 == null || id2.equals("")) {
      		out.print("�����µ�¼");
      		return ;
      	}
      	if (!service) {
      		out.print("��û��Ȩ��");
      		return ;
      	}
	*/	
  %>

<%
	String section = (String) session.getAttribute("Aj-Section") ;
	String building = (String) session.getAttribute("Aj-Building") ;
	String loft = (String) session.getAttribute("Aj-Loft") ;		
	String secNameS = (String) session.getAttribute("Aj-SectionName") ;
	
%><script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("�����붰��");
			return false;
		}	
	}
	
function loadForm() {
	
	
		// setSelectMad(document.aform.Section,'<%=section%>');
		// document.aform.Building.value ='<%=building%>';
	}

</script>
<script language="javascript" src="../public_js/public.js">

</script>

<body onload="loadForm();">
<%
	//String saleStr = "select id,name,secno,building,room,cus_name,cus_no,htno,saleprice,ajbk,ajcs,ajmoney,ajyear from ajlistv2 ";
	 //      saleStr += " where  secno='" + section + "' and building like '%" + building  + "%' and section is null";
	//  out.print(saleStr);
		
%>
<%!
	public String getFloat(float temp,int lens) {
		java.text.DecimalFormat df = null;
		if (lens == 4)
			df = new java.text.DecimalFormat("###.#####");
		if (lens == 2)
			df = new java.text.DecimalFormat("###,###,###.##");
		if (lens == 1)
			df = new java.text.DecimalFormat("###,###,###");	
		return df.format(temp).toString();
	}

%>
<form method="post"> 
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR> 
    <TD COLSPAN="2"> 
        <DIV ALIGN="CENTER">����ѯ</DIV>
    </TD>
  </TR>
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
</TABLE>
  <%
  		
		
  %>
 
  
  <table BORDER=0 width="80%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      <td width="17%"> 
        <div align="CENTER">���</div>
      </td>
      <td width="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <select name="Type">
            <option value="����">����</option>
            <option value="��ֽ">��ֽ</option>
            <option value="�㲥">�㲥</option>
            <option value="����">����</option>
          </select>
        </div>
      </td>
      <td width="22%" bgcolor="#CFE6EB"> 
        <div align="CENTER">ý������</div>
      </td>
      <%
	  	Timestamp ts = new Timestamp(System.currentTimeMillis()) ;
		String currentDate = ts.toString().substring(0, 10) ;
	  %>
      <td width="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="Name" size="15"  >
        </div>
      </td>
    </tr>
    <tr bgcolor="#CFE6EB"> 
      <td width="17%"> 
        <div align="center">���</div>
      </td>
      <td width="27%" bgcolor="#e2e2e2"> 
        <input type="text" name="Spec" size="15"  >
      </td>
      <td width="17%" align="center"> 
        <div align="CENTER">���۽׶�</div>
      </td>
      <td width="27%" bgcolor="#e2e2e2" align="center"> 
        <div align="left"> 
          <input type="text" name="Phase" size="15"  >
        </div>
      </td>
    </TR>
    <tr align="center" > 
      <td width="17%" bgcolor="#CFE6EB">��ʼ����</td>
      <td width="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="BeginDate" size="10" onFocus=blur() >
          <input type=button name=Popu2 value=".." onClick="fPopUpCalendarDlg(BeginDate); " >
        </div>
      </td>
      <td width="22%" bgcolor="#CFE6EB">��������</td>
      <td width="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="FinishDate" size="10" onFocus=blur() >
          <input type=button name=Popu3 value=".." onClick="fPopUpCalendarDlg(FinishDate); " >
        </div>
      </td>
    </tr>
  </TABLE>
  

  <table width="50%" border="0" align="center">
    <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <div align="center">
        
		  <input type="button" name="Submit3" value="��ѯ" onclick="SearchFlow()">
      </div>
    </td>
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="����" onclick="history.back()">
      </div>
    </td>
  </tr>
</table>
</form>
<p> 
  <script>
  	// set color and save value ;	
		var itemNo = "" ;   // roomNo
		var isOut = 0 ;   //rent or sale out
		var lastObject ;
		
		function ChangeTrColor(element2, isOut2, idNo, inColor, outColor) {
			isOut = parseInt(isOut2) ;
			if (itemNo == "") 
				element2.bgColor = inColor ;
			else {
					
				lastObject.bgColor = outColor ;
				element2.bgColor = inColor ;
			}	
			itemNo = idNo ;
			lastObject = element2 ;
			
		}	
		
		top2 = (screen.availHeight - 500) / 2 ;
		left2 = (screen.width - 620) / 2  ;
		height2 = 480 ;
		width2 = 620 ;
		
		
		
		function SearchFlow() {
			document.forms[0].action = "Advertise2002S.jsp?x=" + Math.random() ;
			document.forms[0].submit() ;
		}
  </script>
</p>
</BODY>
</HTML>