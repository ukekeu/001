<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>�޸�����</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../js/mad.js"> </script>
<script  src="../public_js/calendar.script"></script>
<script  src="../public_js/Popup.js"></script>     
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>



<script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("�����붰��");
			return false;
		}	
	}
	


</script>
<script language="javascript" src="../public_js/public.js">

</script>


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
<form method="post">  <p align="center"><b><font size="3" color="#000080">���Ǽ�(����)</font></b></p>

  <%
  		String advertiseId = request.getParameter("AdvertiseId") ;
		String getStr = "select * from advertise where id = " + advertiseId ;
		ResultSet getRs = aBean.executeQuery(getStr) ;
		String title="",type = "", name = "", spec = "", phase = "", beginDate = "",
				finishDate = "", target = "", attach = "", picture = "",
				ch = "", assist = "",time = "",region="",  zx = "", chDate = "",format="",location="" ;
		int unitPrice = 0, times = 0, totalPrice = 0 ;		
		if (getRs.next()) {
		    region=getbyte(getRs.getString("region").trim()) ;
			type = getbyte(getRs.getString("type").trim()) ;
			name = getbyte(getRs.getString("name").trim()) ;
			format = getbyte(getRs.getString("format").trim()) ;
			time = getbyte(getRs.getString("time")) ;
			location = getbyte(getRs.getString("location").trim()) ;
	
			times = getRs.getInt("times") ;
			totalPrice = getRs.getInt("totalPrice") ;
			beginDate = getRs.getString("beginDate") ;
			finishDate = getRs.getString("finishDate") ;
			target = getbyte(getRs.getString("target").trim()) ;
			attach = getbyte(getRs.getString("attach").trim()) ;
			picture = getbyte(getRs.getString("picture").trim()) ;
			ch = getbyte(getRs.getString("ch").trim()) ;
			assist = getbyte(getRs.getString("assist").trim()) ;
			zx = getbyte(getRs.getString("zx").trim()) ;
			chDate = getRs.getString("chDate") ;
			title= getbyte(getRs.getString("title")).trim() ;
			try {
				beginDate = beginDate.substring(0, 10) ;
			} catch (Exception e) {
				beginDate = "" ;
			}
			try {
				finishDate = finishDate.substring(0, 10) ;
			} catch (Exception e) {
				finishDate = "" ;
			}
		}
  %>
  <script>
	 function loadForm() {
		setSelectMad(document.forms[0].Type, "<%= type %>") ;	
		setSelectMad(document.forms[0].region, "<%= region %>") ;	
			
	}
</script>	
  <body onload="loadForm();">
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      <TD WIDTH="17%"> 
        <DIV ALIGN="CENTER">���</DIV>
      </TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <select name="Type">
            <option value="����">����</option>
            <option value="��ֽ">��ֽ</option>
            <option value="�㲥">�㲥</option>
            <option value="����">����</option>
          </select>
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB"> 
        <DIV ALIGN="CENTER">ý������</DIV>
      </TD>
      <%
	  	Timestamp ts = new Timestamp(System.currentTimeMillis()) ;
		String currentDate = ts.toString().substring(0, 10) ;
	  %>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="Name" size="15" value="<%= name %>"  >
        </div>
      </TD>
    </TR>
    <tr bgcolor="#CFE6EB"> 
      <TD WIDTH="17%"> 
        <div align="center">����</div>
      </TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"  colspan="3"> 
        <input type="text" name="title" size="47"  value="<%=title %>" >
      </TD>
      
    </TR>
    <tr bgcolor="#CFE6EB"> 
      <TD WIDTH="17%"> 
        <div align="center">���</div>
      </TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <input type="text" name="Spec" size="15" value="<%= spec %>"  >
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB"> 
        <div align="center">ʱ��</div>
      </TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <input type="text" name="Time" size="10" value="<%= time %>" >
      </TD>
    </TR>
   
   <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB"> 
        <DIV ALIGN="CENTER">����</DIV>
      </TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="format" size="15" value="<%= format %>"  >
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB"> 
        <DIV ALIGN="CENTER">��λ</DIV>
      </TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="location" size="10" value="<%= location %>"  >
        </div>
      </TD>
    </TR>
    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB">Ƶ��</TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="Times" size="10" value="<%= times %>" >
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB">�ܼ�</TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="TotalPrice" size="10" value="<%= totalPrice %>"  >
        </div>
      </TD>
    </TR>
    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB">ִ������</TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="BeginDate" size="10" onFocus=blur() value="<%= beginDate %>" >
          <input type=button name=Popu2 value=".." onClick="fPopUpCalendarDlg(BeginDate); " >
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB">��������</TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="FinishDate" size="10" onFocus=blur() value="<%= finishDate %>" >
          <input type=button name=Popu3 value=".." onClick="fPopUpCalendarDlg(FinishDate); " >
        </div>
      </TD>
    </TR>
    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB">Ŀ��</TD>
      <TD colspan="3" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <textarea name="Target" cols="40"><%= target %></textarea>
        </div>
        <div align="left"></div>
      </TD>
    </TR>
	<!--
    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB">��������</TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="Attach" size="10" value="<%= attach %>"  >
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB">���ͼƬ</TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="Picture" size="10" value="<%= picture %>"  >
        </div>
      </TD>
    </TR>-->
<!--    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB"> �߻���λ</TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="Ch" size="15" value="<%= ch %>"  >
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB">Э����λ</TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="Assist" size="15" value="<%= assist %>" >
        </div>
      </TD>
    </TR>-->
    <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB">�߻���λ</TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2" colspan="3" > 
        <div align="left"> 
          <input type="text" name="Zx" size="40" value="<%= zx %>"  >
        </div>
      </TD>
      
    </TR>
	 <tr align="center" > 
      <TD WIDTH="17%" bgcolor="#CFE6EB">����</TD>
      <TD WIDTH="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          &nbsp;<select name="region" >
			<%
 String StrSql="select type,codename from CODE  where type='K'";
   ResultSet codeRS=null;
    codeRS=aBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
    String codename=getbyte(codeRS.getString("codename"));
    out.print("<option value="+codename+">"+codename+"</option>");
	 i++;
   }
   codeRS.close();
 
 %>
		  </select>
        </div>
      </TD>
      <TD WIDTH="22%" bgcolor="#CFE6EB">�߻�����</TD>
      <TD WIDTH="34%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="ChDate" size="10" onFocus=blur() value="<%= chDate %>" >
          <input type=button name=Popu4 value=".." onClick="fPopUpCalendarDlg(ChDate); " >
        </div>
      </TD>
    </TR>
  </TABLE>
  

  <table width="50%" border="0" align="center">
    <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <div align="center">
        
		  <input type="button" name="Submit3" value="�� ��" onclick="return ModifyDo()">
      </div>
    </td>
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="�� ��" onclick="window.close()">
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
		
		function ModifyDo() {
			//alert("add") ;
			form2 = document.forms[0] ;
			  
			if (form2.Name.value == "")
				{alert("���ý�岻��Ϊ��");
					return false ;
					}
			if (form2.Times.value != "")
				if (!isInteger(form2.Times, "Ƶ��ֻ��������"))
					return false ;
			 
			if (form2.TotalPrice.value != "")
				if (!isInteger(form2.TotalPrice, "�ܼ�ֻ��������"))
					return false ;		
			document.forms[0].action = "AdvertiseUpdate.jsp?Operation=Modify&AdvertiseId=<%= advertiseId %>&x=" + Math.random() ;
			document.forms[0].submit() ;
		}
  </script>
</p>
</BODY>
</HTML>
