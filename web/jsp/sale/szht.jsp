<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">

    <script LANGUAGE="VBScript">
<!--
	Dim CRLF
	CRLF = Chr(10) & Chr(13)
	Function ValidateNumber(ByVal TheNumber,ByVal FieldName)
		If Trim(TheNumber) = "" Then
			ValidateNumber = True
			Exit Function
		End If

		If Not IsNumeric(TheNumber) Then
			x = MsgBox(FieldName&"����������Ч������",16,"�������")	
			ValidateNumber = False
		Else

			ValidateNumber = True
		End If
	End Function

	Function ValidateDate(Byval strInput,ByVal FieldName)
		If Trim(strInput) = "" Then
			ValidateDate = True
			Exit Function
		End If

	    Dim nPosition, nPositionNext
		Dim strYear, strMonth, strDay
		strMsg = FieldName & "���������ѭ ��-��-�յ�ģʽ" & CRLF
		strMsg = strMsg & "���µ����붼��ϵͳ�ܹ�ʶ���" & CRLF
		strMsg = strMsg & "1997-12-22 ��ʾ1997��12��22��" & CRLF
		strMsg = strMsg & "1998 ��ʾ1998��1��1��" & CRLF
		strMsg = strMsg & "1999-12 ��ʾ1999��12��1��"

		strInput = Trim(strInput)
		nPosition = InStr(1, strInput, "-")
    
		If nPosition = 0 Then
			If Not IsNumeric(strInput) Then
				x = MsgBox(strMsg,16,"�����������")
				ValidateDate = False
				Exit Function
			End If
			If CLng(strInput) > 2010 Or CLng(strInput) < 1980 Then
				x = MsgBox(strMsg,16,"���������Ч")
				ValidateDate = False
				Exit Function
			End If
			ValidateDate = True
			Exit Function
		End If
    
		strYear = Left(strInput, nPosition - 1)
    
		If Not IsNumeric(strYear) Then
				x = MsgBox(strMsg,16,"�����������")
				ValidateDate = False
				Exit Function
		End If
    
		If CLng(strYear) > 2010 Or CLng(strYear) < 1980 Then
				x = MsgBox(strMsg,16,"���������Ч")
				ValidateDate = False
				Exit Function
		End If
    
		nPositionNext = InStr(nPosition + 1, strInput, "-")
    
		If nPositionNext = 0 Then
			strMonth = Right(strInput, Len(strInput) - nPosition)
			If Not IsNumeric(strMonth) Then
				x = MsgBox(strMsg,16,"�����������")
				ValidateDate = False
				Exit Function
			End If
			If CLng(strMonth) > 12 Or CLng(strMonth) < 0 Then
				x = MsgBox(strMsg,16,"�·��������")
				ValidateDate = False
				Exit Function
			End If
			ValidateDate = True
			Exit Function
		End If
    
		strMonth = Mid(strInput, nPosition + 1, nPositionNext - nPosition - 1)
		If Not IsNumeric(strMonth) Then
			x = MsgBox(strMsg,16,"�����������")
			ValidateDate = False
			Exit Function
		End If
		If CLng(strMonth) > 12 Or CLng(strMonth) < 0 Then
			x = Msgbox(strMsg,16,"�·��������")
			ValidateDate = False
			Exit Function
		End If
    
		strDay = Right(strInput, Len(strInput) - nPositionNext)
		If Not IsNumeric(strDay) Then
			x = MsgBox(strMsg,16,"�����������")
			ValidateDate = False
			Exit Function
		End If
		If CLng(strDay) > 31 Or CLng(strDay) < 0 Then
			x = MsgBox(strMsg,16,"�����������")
			ValidateDate = False
			Exit Function
		End If
    
		ValidateDate = True
	End Function

	Function GetNum(ByVal TheNumber)
		If Trim(TheNumber) = "" Then
			GetNum = 0
		Else
			GetNum = CLng(TheNumber)
		End If
	End Function

	Sub CusMsg(ByVal msg)
		msg = msg&CRLF&"����֤����������"
		x = MsgBox(msg,16,"������֤����")
	End Sub

	Sub ncontractpriceeach_onchange
		x = ValidateNumber(Document.insertform.ncontractpriceeach.value,"��λ�ۿ�")
	End Sub

	Sub ncontractprice_onchange
		x = ValidateNumber(Document.insertform.ncontractprice.value,"��ͬ�ۿ�")
	End Sub
	
	Sub npayedyear_onchange
		x = ValidateNumber(Document.insertform.npayedyear.value,"��������")
	End Sub
	
	Sub npayedprice_onchange
		x = ValidateNumber(Document.insertform.npayedprice.value,"�Ѹ��ۿ�")
	End Sub
	
	Sub ncompensation_onchange
		x = ValidateNumber(Document.insertform.ncompensation.value,"ΥԼ�����")
	End Sub

	Sub ncontractarea_onchange
		x = ValidateNumber(Document.insertform.ncontractarea.value,"��ͬ���")
	End Sub
	
	Sub dmoveindate_onchange
		x = ValidateDate(Document.insertform.dmoveindate.value,"��ס����")
	End Sub

	Sub dsigndate_onchange
		x = ValidateDate(Document.insertform.dsigndate.value,"��ס����")
	End Sub
	
	Function insertform_OnSubmit

		if Trim(Document.insertform.ncontractarea.Value) = "" Then
			x = MsgBox ("��ͬ����������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"���������ͬ���")
			insertform_OnSubmit = False
			Exit Function
		End If

		if Trim(Document.insertform.ncontractpriceeach.Value) = "" Then
			x = MsgBox ("��λ�ۿ��������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"�������뵥λ�ۿ�")
			insertform_OnSubmit = False
			Exit Function
		End If

		if Trim(Document.insertform.ncontractprice.Value) = "" Then
			x = MsgBox ("��ͬ�ۿ��������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"���������ͬ�ۿ�")
			insertform_OnSubmit = False
			Exit Function
		End If

		if Trim(Document.insertform.dmoveindate.Value) = "" Then
			x = MsgBox ("��ס�����������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"����������ס����")
			insertform_OnSubmit = False
			Exit Function
		End If
	
		if Trim(Document.insertform.dsigndate.Value) = "" Then
			x = MsgBox ("ǩ�������������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"��������ǩ������")
			insertform_OnSubmit = False
			Exit Function
		End If

		if Trim(Document.insertform.ncompensation.Value) = "" Then
			x = MsgBox ("ΥԼ������������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"��������ΥԼ�����")
			insertform_OnSubmit = False
			Exit Function
		End If

		if Trim(Document.insertform.tmoneywatcher.Value) = "" Then
			x = MsgBox ("�ۿ��ܻ�������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"��������ۿ��ܻ���")
			insertform_OnSubmit = False
			Exit Function
		End If
		if Trim(Document.insertform.tmoneywatcher_name.Value) = "" Then
			x = MsgBox ("�ۿ����˻�����Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"��������ۿ����˻�")
			insertform_OnSubmit = False
			Exit Function
		End If
		if Trim(Document.insertform.tmoneywatcher_id.Value) = "" Then
			x = MsgBox ("�ۿ����˺��������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"��������ۿ����˺�")
			insertform_OnSubmit = False
			Exit Function
		End If
		if Trim(Document.insertform.tprojectwatcher.Value) = "" Then
			x = MsgBox ("���̼�ܻ����������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"�������빤�̼�ܻ���")
			insertform_OnSubmit = False
			Exit Function
		End If
		if Trim(Document.insertform.thousewatcher.Value) = "" Then
			x = MsgBox ("��ҵ����˾�������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"����������ҵ����˾")
			insertform_OnSubmit = False
			Exit Function
		End If
		if Trim(Document.insertform.nhousewatcher_price.Value) = "" Then
			x = MsgBox ("��ҵ������������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"����������ҵ�����")
			insertform_OnSubmit = False
			Exit Function
		End If
		
		if Trim(Document.insertform.tbuyer1.Value) = "" and Trim(Document.insertform.tlegal_person1.Value) = ""  Then
			x = MsgBox ("�򷽣��������Ϊ�գ���ͬ��ӡʱ��Ҫ��",16,"���������򷽣�")
			insertform_OnSubmit = False
			Exit Function
		End If


		x = ValidateNumber(Document.insertform.ncontractarea.value,"��ͬ���")
		if x = False Then
			insertform_OnSubmit = False
			Exit Function
		End if

		x = ValidateNumber(Document.insertform.ncontractpriceeach.value,"��λ�ۿ�")
		if x = False Then
			insertform_OnSubmit = False
			Exit Function
		End if

		x = ValidateNumber(Document.insertform.ncontractprice.value,"��ͬ�ۿ�")
		if x = False Then
			insertform_OnSubmit = False
			Exit Function
		End if

		x = ValidateNumber(Document.insertform.npayedyear.value,"��������")
		if x = False Then
			insertform_OnSubmit = False
			Exit Function
		End if

		x = ValidateNumber(Document.insertform.npayedprice.value,"�Ѹ��ۿ�")
		if x = False Then
			insertform_OnSubmit = False
			Exit Function
		End if

		x = ValidateNumber(Document.insertform.ncompensation.value,"ΥԼ��ٷֱ�")
		if x = False Then
			insertform_OnSubmit = False
			Exit Function
		End if

		x = ValidateDate(Document.insertform.dmoveindate.value,"��ס����")
		if x = False Then
			insertform_OnSubmit = False
			Exit Function
		End if
		
		x = ValidateDate(Document.insertform.dsigndate.value,"ǩԼ����")
		if x = False Then
			insertform_OnSubmit = False
			Exit Function
		End if

		insertform_OnSubmit = True
	End Function	

-->
    </script>	
    <style TYPE="text/css">
<!--
body,table{font-size:9pt;font-family:����;line-height:13pt;}
A:link { text-decoration:none; color:#0000cc }
A:visited { text-decoration:none; color:#0000cc }
A:active { text-decoration:none; color:#ff0000 }
A:hover { text-decoration:underline font-weight:none; color:#ff0000 (font-weight: bold)}
.unnamed1 {  font-family: "����"; font-size: 9pt}
-->
</style>
<title>��ͬ������</title>
</head>

<body leftmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<p align="center"><strong><font size="4">��ͬ¼�봰�ڣ���Ԫ�������M2��</font></strong></p>
<%//try{
	 
	 String  code=request.getParameter("code");
	 //��ȡҵ������
	 String SQL="SELECT getdate() as currdate,DATEDIFF(DD,o.VISADATE ,o.JLDATE) CD,c.cus_name,c.phone+' '+c.sj phone,c.id_card,c.zip_code,c.address,";
	 SQL+="o.section,o.loft,o.room_no,o.xiaoshoutype,o.floors,o.jzarea,o.area,dateadd(dd,30,visadate) ajdate,o.yong_tu,";
	 SQL+="o.jzarea-o.area ft,o.roomtype ,o.salerprice,o.currency,o.count_type,o.httype,o.rmbprice,o.rmbprice-o.ajmoney firstMoney,(o.rmbprice-o.ajmoney)*1.0/o.rmbprice*100 firstbl,o.rmbprice/o.area tnunitprice,o.rmbprice/o.jzarea unitprice,o.payment1,o.JLdate,o.ajyear,o.ajmoney,o.ajmoney*100.0/o.rmbprice ajb,o.visadate,DATEDIFF(dd,o.visadate,o.jldate) num,datediff(dd,dateadd(dd,30,visadate),o.jldate) num1 from order_contract o,customer c where c.serialno=o.customer and o.code="+code;
	 ResultSet rs=InsertBean.executeQuery(SQL);
	 String cus_name="",id_card="",zip_code="",phone="",address="",Type="",currency="";
	 String section="",loft="",room_no="",floors="",tnunitprice="",ajdate="";
	  String jzarea="",tnarea="",ft="",uppercaseMoney="",unitprice="",firstMoney="",firstbl="";
	 boolean xiaoshoutype=false;
	 int count_type=0;
	 int xcnum=0,ysnum=0,cd=0;
	 String yroomno="",salerprice="0",httype="",currdate="";
	 String payment1="",JLdate="",ajb="",ajmoney="",ajyear="",visadate="",roomtype="";
	 if (rs.next()){
	    currdate=rs.getDate("currdate").toString();
	    cd=rs.getInt("cd") ;
	    cus_name=rs.getString("cus_name");
		phone=rs.getString("phone");
		id_card=rs.getString("id_card");
		zip_code=rs.getString("zip_code");
		address=rs.getString("address");
		section=rs.getString("section");
		loft=rs.getString("loft");
		 if (loft.indexOf("-")>=0)loft=loft.substring(0,loft.indexOf("-"));
 		
		room_no=rs.getString("room_no");
		yroomno=room_no;
		if (room_no.indexOf("-")>=0)room_no=room_no.substring(room_no.indexOf("-")+1);
		xiaoshoutype =rs.getBoolean("xiaoshoutype");
		floors=rs.getString("floors");
		if (floors.equals("0"))floors="����";
		else if (Integer.parseInt(floors)<0){floors="����"+floors.substring(floors.indexOf("-")+1)+"��";}
		jzarea=FormtD.getFloat1(rs.getFloat("jzarea"),2);
		tnarea=FormtD.getFloat1(rs.getFloat("area"),2);
		Type=rs.getString("yong_tu");
		ajdate=rs.getDate("ajdate").toString();
		ft=FormtD.getFloat1(rs.getFloat("ft"),2);
		count_type=rs.getInt("count_type");
		 httype=getbyte(rs.getString("httype")); 
		roomtype=rs.getString("roomtype");
		 salerprice=rs.getString("salerprice");
		currency=rs.getString("currency");
		uppercaseMoney=rs.getString("rmbprice");
		firstMoney=rs.getString("firstMoney");
		firstbl=FormtD.getFloat(rs.getFloat("firstbl"),2);
		tnunitprice=FormtD.getFloat1(rs.getFloat("tnunitprice"),2);
		unitprice=FormtD.getFloat1(rs.getFloat("unitprice"),2);
		payment1=rs.getString("payment1");
		JLdate=rs.getString("JLdate");
		ajyear=rs.getString("ajyear");
		ajmoney=rs.getString("ajmoney");
		ajb=FormtD.getFloat(rs.getFloat("ajb"),2);
		if (!JLdate.equals(""))JLdate=JLdate.substring(0,10);
		visadate=rs.getDate("visadate").toString();
		xcnum=rs.getInt("num");
		ysnum=rs.getInt("num1");
	 }
	 rs.close();
	%> <%// jys,
    SQL="select   ManageFee,Region,developcom,tdsyqcrpzno,gytzno,NAME,AreaNo,qddkfs,tudishiyong_no,GroundArea,Type,useyear,cq_sd,cq_ed";
	SQL+=" ,guihua_no,shigong_no,yushou_no,jiegou,chenggao,wuyei_com ";
		SQL+=" ,fr,frdh,dlr,dlrzh,dlrdz,dlryb,yyzzh,zzzsh ,fryb,frdz,zc_addr";
	SQL+=" from crm_project where serialno='"+section+"'";
 
    rs=InsertBean.executeQuery(SQL);
	String name="",GroundArea="",qddkfs="",tudishiyong_no="",Region="";
	String useyear="",cq_sd="",cq_ed="",guihua_no="",shigong_no="";
	String yushou_no="",AreaNo="",jiegou="",chenggao="",wuyei_com="";
	String gytzno="",tdsyqcrpzno="",fryb="",frdz="";
String jiaolouDate="";
String fr="X";
String	phone2="X";
String dlr="X";
String	phone1="X";
String	dlrdz="X";
String	zipcode="X";
String	yyzzh="X";
String	zzzsh="X"; 
int jlday=0;
String yang_tai_area="",jys=""; 
String developcom="",zcadd="",strManageFee="0";
	if (rs.next()){
	  // jys=getbyte(rs.getString("jys"));
	  Region=getbyte(rs.getString("Region"));
	  if (jys.equals("")){
	  Region="��ͷ��"+Region+"���ط���������";
	  }else{Region=jys;}
	  developcom =getbyte(rs.getString("developcom"));
	  tdsyqcrpzno=getbyte(rs.getString("tdsyqcrpzno"));
	  gytzno=getbyte(rs.getString("gytzno"));
	  name=rs.getString("NAME");
	 
	  qddkfs=getbyte(rs.getString("qddkfs"));
	  tudishiyong_no=getbyte(rs.getString("tudishiyong_no"));
	  GroundArea=FormtD.getFloat1(rs.getFloat("GroundArea"),2);
	 
	  	strManageFee=FormtD.getFloat1(rs.getFloat("ManageFee"),2);
	  guihua_no=getbyte(rs.getString("guihua_no"));
	  shigong_no=getbyte(rs.getString("shigong_no"));
	  yushou_no=getbyte(rs.getString("yushou_no"));
	  jiegou=getbyte(rs.getString("jiegou"));
	  chenggao=getbyte(rs.getString("chenggao"));
	  wuyei_com=getbyte(rs.getString("wuyei_com"));
	  fr=getbyte(rs.getString("fr"));
	phone2=getbyte(rs.getString("frdh"));
	dlr=getbyte(rs.getString("dlr"));
	phone1=getbyte(rs.getString("dlrzh"));
	dlrdz=getbyte(rs.getString("dlrdz"));
	zipcode=getbyte(rs.getString("dlryb"));
	yyzzh=getbyte(rs.getString("yyzzh"));
	zzzsh=getbyte(rs.getString("zzzsh")); 
	fryb=getbyte(rs.getString("fryb")); 
	frdz=getbyte(rs.getString("frdz")); 
	zcadd=getbyte(rs.getString("zc_addr")); 
	}
	rs.close();
	//if (gytzno.equals(""))gytzno="X";
	//if (tdsyqcrpzno.equals(""))tdsyqcrpzno="X";
	SQL="select Serve_Date,useryear, s_year,e_year,cg,counttype,yang_tai_area from room where seccode='"+section+"' and loft='"+loft+"'and room_code='"+yroomno+"'";
     int counttype=0;
	  rs=InsertBean.executeQuery(SQL);
	  if (rs.next()){
	  
	   useyear=rs.getString("useryear");
	  cq_sd=getbyte(rs.getString("s_year"));
	  cq_ed=getbyte(rs.getString("e_year"));
	  chenggao=getbyte(rs.getString("cg"));
	  counttype=rs.getInt("counttype");
	  float aaaa=rs.getFloat("yang_tai_area");
	  if (aaaa>0)
	   yang_tai_area =FormtD.getFloat(aaaa,2);
	   else
	   yang_tai_area="X";
	  }
	 
	  rs.close();
	   SQL="SELECT sum(factmoney*currrate) jk FROM factGatheringRecord WHERE contractno="+code;
      String y_fk="0";
	  rs=InsertBean.executeQuery(SQL);
	  if (rs.next()){
	   y_fk=FormtD.getFloat1(rs.getFloat("jk"),2);
	  }
	  rs.close();
	  String ysxkz="";//¥���е�Ԥ�����֤
	 SQL="SELECT  case when jiaolouDate  is not null then DATEDIFF(DD,jiaolouDate ,'"+visadate+"')  else -1 end  aa,zzzh,sgxkz,ghxkz,zdmj,tdsyqcrh,fzdbr,gytdsyz,yyzzh,FZS,ysxkz,cq_addr FROM LoftBuildCode WHERE SecNo='"+section+"' and Loft='"+loft+"'"; 
	  rs=InsertBean.executeQuery(SQL);
	  if (rs.next()){
	    jlday=rs.getInt("aa");
	    String fzs=getbyte(rs.getString("fzs"));
		String yyy=getbyte(rs.getString("yyzzh"));
		String gytdsyz1=getbyte(rs.getString("gytdsyz"));
		String fzdbr=getbyte(rs.getString("fzdbr"));
		String tdsyqcrh=getbyte(rs.getString("tdsyqcrh"));
		String zdmj=getbyte(rs.getString("zdmj"));
		String ghxkz=getbyte(rs.getString("ghxkz"));
		String sgxkz=getbyte(rs.getString("sgxkz"));
		ysxkz=getbyte(rs.getString("ysxkz"));
		String zzzh=getbyte(rs.getString("zzzh"));
		 AreaNo=getbyte(rs.getString("cq_addr"));
		
		if (!fzs.equals(""))
		developcom=fzs;
		if (!yyy.equals(""))
		yyzzh=yyy;
		if (!fzdbr.equals(""))
		fr=fzdbr;
		if (!tdsyqcrh.equals(""))
		tdsyqcrpzno=tdsyqcrh;
		if (!gytdsyz1.equals(""))
		gytzno=gytdsyz1;
		if (!zdmj.equals(""))
		GroundArea=zdmj;
		if (!ghxkz.equals(""))
		guihua_no=ghxkz;
		if (!sgxkz.equals(""))
		shigong_no=sgxkz;
		if (!zzzh.equals(""))
		zzzsh=zzzh;
		
	  }
	  rs.close();
	  if (!ysxkz.equals(""))yushou_no=ysxkz;//���¥���д���Ԥ�����֤������¥������Ϊ׼
	  if (yyzzh.indexOf("/")>=0)yyzzh=yyzzh.substring(0,yyzzh.indexOf("/"))+"<br>"+yyzzh.substring(yyzzh.indexOf("/")+1);
 
 
  String a1="",a2="",a3="";

 if (!cq_sd.equals("")){ 
 a1=cq_sd.substring(0,4);
  a2=cq_sd.substring(5,7);
  a3=cq_sd.substring(8,10);
}

String ydxz="";
if (Type.indexOf("����")>=0||Type.indexOf("��λ")>=0||Type.indexOf("����")>=0||Type.indexOf("סլ")>=0)
 ydxz="סլ�õ�";
else
  ydxz="�ۺ��õ�"; %>

<form method="POST" action="contractoperate.asp?hid=17642&strcontractid=��(��)��Ԥ����(2005)04600��&projecttype=Ԥ��&zone=����&bid=302&bname=302(���Ĵ���)&presellid=53" name="insertform">
  <div align="center"><center><table border="1" width="519" bgcolor="#CBC9F1" height="132" bordercolor="#7979FF" bordercolordark="#FFFFFF" bordercolorlight="#7979FF" cellspacing="0" cellpadding="0">
    <tr>
      <td width="247" height="23"><span style="font-size: 9pt">&nbsp; ��Ŀ���ƣ�<%=name %></span></td>  
      <td width="266" height="23"><span style="font-size: 9pt">&nbsp; ¥�����ƣ�<%=loft %></span></td>  
    </tr> 
    <tr> 
      <td width="247" height="23"><span style="font-size: 9pt">&nbsp;  
        ��&nbsp;&nbsp;&nbsp; �ţ�<%=room_no %></span></td> 
      <td width="266" height="23"><span style="font-size: 9pt">&nbsp; </span><span style="font-size: 9pt">�������ͣ�<%=roomtype %></span></td>  
    </tr> 
    <tr>  
      
    
      <td width="50%" height="23"><span style="font-size: 9pt"> &nbsp;��ͬ�� &nbsp;����(��)��Ԥ����(2005)04600��</span></td>
    
      
      <td width="266" height="23"><span style="font-size: 9pt">&nbsp; ��ͬ���ͣ�<% if (xcnum<0){out.print("�ַ�");}else{out.print("Ԥ��");} %></span></td>   
    </tr>  
    <tr>  
      <td width="513" height="1" colspan="2">��</td>  
    </tr>  
    <tr>  
    
      <td width="247" height="23"><span style="font-size: 9pt">&nbsp; ��ͬ�����<input type="text" name="ncontractarea" size="20" value="<%=jzarea %>"></span></td>   
    
      <td width="266" height="23"><span style="font-size: 9pt">&nbsp; �������ͣ�<select name="tmoneytype" size="1">
      
		<option <%if  (currency.equals("��")){out.print("selected");} %> value="�����">�����</option>
      
        <option <%if  (currency.equals("HK")){out.print("selected");} %> value="�۱�">�۱�</option>
      
        <option <%if  (currency.equals("USD")){out.print("selected");} %> value="��Ԫ">��Ԫ</option>
      
      </select></span></td>   
    </tr>  
    <tr>  
    
      <td width="247" height="23"><span style="font-size: 9pt">&nbsp; 
        ���㷽ʽ��<select name="tcontractchoice" size="1">
      
        	<option  <%if (count_type==1){out.print("selected");} %> value="�������" selected>�������</option>
	      
        <option <%if (count_type==0){out.print("selected");} %> value="�������" >�������</option>
      
        <option <%if (count_type==2){out.print("selected");} %> value="���׼���" >���׼���</option>
      
      
        </select></span></td>   
    
      <td width="266" height="23"><span style="font-size: 9pt">&nbsp;&nbsp;�ٲ÷�ʽ��<select size="1" name="tresolvechoice">
      
		  <option value="һ">�����ٲ�ίԱ��</option>	
      
		  <option value="��">���ʾ�ó�ٲ�ίԱ��</option>
	  
          <option Selected value="��">��Ժ����</option>
      
      
       </select></span></td>   
        
    </tr>  

    <tr>  
      <td width="247" height="23"><span style="font-size: 9pt">&nbsp; ��λ�ۿ<input type="text" name="ncontractpriceeach" size="20" value="<%=unitprice %>"></span></td>   
      <td width="266" height="23"><span style="font-size: 9pt">&nbsp; ��ͬ�ۿ<input type="text" name="ncontractprice" size="20" value="<%=salerprice %>"></span></td>   
    </tr>  
    <tr>  
    <td width="247" height="24"><span style="font-size: 9pt">&nbsp; ���ʽ��<select name="tpayedstyle" size="1">   
      
        <option value="����">����</option>
      
        <option <%if (payment1.indexOf("һ����")>=0) {out.print("selected");}%> value="һ����">һ����</option>
      
		<option <%if (payment1.indexOf("����")>=0) {out.print("selected");}%>  value="����">����</option>
      
      </select></span></td>  
      <td width="266" height="24"><span style="font-size: 9pt">&nbsp; �������ޣ�<input type="text" name="npayedyear" size="20" value="<%=ajyear %>"></span></td>   
    </tr>  
    <tr>  
      <td width="247" height="24"><span style="font-size: 9pt">&nbsp; �Ѹ��ۿ<input type="text" name="npayedprice" size="20" value="<%=y_fk %>"></span></td>   
      <td width="266" height="24"><span style="font-size: 9pt">&nbsp; ���۶���<select name="tsaleto" size="1">   
      
        <option <%if (httype.equals("0")){out.print("selected");} %>   value="����">����</option>
      
        <option  <%if (httype.equals("1")){out.print("selected");} %>  value="����">����</option>
      
      </select></span></td>  
    </tr>  
    <tr>  
      <td width="266" height="24"><span style="font-size: 9pt">&nbsp; ��ס���ڣ�<input type="text" name="dmoveindate" size="20" value="<%=JLdate %>"></span></td>   
      <td width="266" height="24"><span style="font-size: 9pt">&nbsp; ¼�����ڣ�<input type="text" name="dsigndate" size="20" 
      	readonly style='background-color:#c0c0c0'  value="<%=currdate %>"></span></td>   
    </tr>  

    <tr>   
      <td width="532" height="24" colspan="2"> 
        <table border="1" width="100%" bordercolorlight="#7979FF" bordercolordark="#FFFFFF" cellspacing="0" cellpadding="0" height="105">
          <tr>
            <td width="18%" height="25">&nbsp; �ۿ��ܻ���</td>
            <td width="85%" colspan="5" height="25">&nbsp;</td>
          </tr>
          <tr>
            <td width="18%" height="24">&nbsp; ��������</td>
            <td width="20%" height="24"><input type="text" name="tmoneywatcher" size="15" value=""></td>
            <td width="13%" height="24">&nbsp;�ʻ�����</td>
            <td width="19%" height="24"><input type="text" name="tmoneywatcher_name" size="12" value=""></td>
            <td width="7%" height="24">&nbsp;�ʺ�</td> 
  </center> 
          <td width="19%" height="24">
            <p align="left"><input type="text" name="tmoneywatcher_id" size="12" value=""></td>
        </tr>
        <center>
        <tr>
          <td width="18%" height="24">&nbsp; ���̼�ܻ���</td>
          <td width="85%" colspan="5" height="24"><input type="text" name="tprojectwatcher" size="33" value=""></td>
        </tr>
        <tr>
          <td width="18%" height="24">&nbsp; ��ҵ����˾</td>
          <td width="85%" colspan="5" height="24"><input type="text" name="thousewatcher" size="33" value="<%=wuyei_com %>">�����<input type="text" name="nhousewatcher_price" size="7" value="<%=strManageFee %>">Ԫ/ƽ����</td>
        </tr>
        </table>
      </td>   
    </tr>  

    <tr>  
      <td width="515" height="13" colspan="2"><div align="center"><p align="left">  
        
      &nbsp;&nbsp;<span style="font-size: 9pt">�򷽸�������50%��������Ҫ����֧��Ƿ�ּۿ�ٷ�֮<input type="text" name="ncompensation" size="4" value="3"></span><span style="font-size: 9pt">��ΥԼ��</span>  
          </div>  
      </td>  
    </tr>  
    <tr>  
      <td width="515" height="12" colspan="2"><div align="center"><p>  
        
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
          </div>  
      </td>  
    </tr>  
  </table>  
  </center></div>  
           
<div align="center">         
    <table border="1" cellpadding="0" cellspacing="0" width="519" height="231" bordercolor="#7979FF" bordercolordark="#FFFFFF" bordercolorlight="#7979FF">  
      <tr>  
        <td width="149" height="18" bgcolor="#CBC9F1" class="unnamed1">  
          <p align="left"><b>��(1)��</b></p> 
        </td> 
        <td width="177" height="18" bgcolor="#CBC9F1" align="center">  
          <p align="left"> <input type="text" name="tbuyer1" size="23" value="<%=cus_name %>" > </td> 
        <td width="52" height="18" bgcolor="#CBC9F1" align="center">  
          <p align="left">&nbsp; ������</p> 
 </td>
        <td width="140" height="18" bgcolor="#CBC9F1" align="center"> 
          <p align="left"><input type="text" name="tbuyer_contry1" size="18" value="�й�"> </p>
 </td>
      </tr>
      <tr> 
        <td width="149" height="24" bgcolor="#CBC9F1" class="unnamed1">     
          &nbsp; �ݶ </td>    
        <td width="170" height="24" bgcolor="#CBC9F1" align="left"> <input type="text" name="tbuyer_share1" size="3" value="50">%</td>   
        <td width="62" height="24" bgcolor="#CBC9F1" align="left" class="unnamed1">    
          &nbsp; �绰�� </td>     
        <td width="138" height="24" bgcolor="#CBC9F1" align="left"> <input   type="text" name="tbuyer_telephone1" size="18" value="<%=phone %>"> </td>    
      </tr>    
      <tr>     
        <td width="149" height="13" bgcolor="#CBC9F1" class="unnamed1">     
          &nbsp; ���֤/���պ��룺 </td>   
        <td width="171" height="13" bgcolor="#CBC9F1" align="left"> <input   type="text" name="tbuyer_id1" size="23" value="<%=id_card %>"> </td>   
        <td width="62" height="13" bgcolor="#CBC9F1" align="left"> 
          <p align="left">֤�����ͣ� </td>   
        <td width="137" height="13" bgcolor="#CBC9F1" align="left"> <select size="1" name="tbuyer_idtype1">
	    
            <option value="���֤" selected>���֤</option>
        
            <option value="����">����</option>
        
            <option value="����">����</option>
            
          </select> </td>   
      </tr>   
      <tr>    
        <td width="139" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ��ַ��    
        </td>   
        <td width="374" height="11" bgcolor="#CBC9F1" class="unnamed1" colspan="3"> <input type="text" name="tbuyer_address1" size="52" value="<%=address %>">     
        </td>   
      </tr>   

      <tr>    
        <td width="510" height="1" bgcolor="#CBC9F1" class="unnamed1" colspan="4"> ��    
        </td>   
      </tr>   
      <tr>    
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ��˾��������ƣ� </td>    
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input   type="text" name="tcompany1" size="52" value=""> </td>   
      </tr>  
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ��ַ�� </td>    
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="tcompany_address1" size="52" value=""> </td>   
      </tr>
      <tr>   
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ���������ˣ� </td>    
        <td width="176" height="11" bgcolor="#CBC9F1" align="left"> <input   type="text" name="tlegal_person1" size="23" value=""> </td>   
        <td width="53" height="11" bgcolor="#CBC9F1" align="left" class="unnamed1">    
          &nbsp; �绰�� </td>   
        <td width="141" height="11" bgcolor="#CBC9F1" align="left"> <input   type="text" name="tlegal_telephone1" size="18" value=""> </td>  
      </tr>  
      <tr>   
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ���֤/���պ��룺 </td>    
        <td width="370" height="11" bgcolor="#CBC9F1" align="left" colspan="3"> <input   type="text" name="tlegal_id1" size="52" value=""> </td>   
      </tr>  
      <tr>   
        <td width="519" height="11" bgcolor="#CBC9F1" class="unnamed1" colspan="4"> �� </td>    
      </tr>  
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ί�д����ˣ� </td>     
        <td width="176" height="1" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson1" size="23" value=""> </td>    
        <td width="53" height="1" bgcolor="#CBC9F1" align="left" class="unnamed1">     
          &nbsp; ������ </td>    
        <td width="141" height="1" bgcolor="#CBC9F1" align="left"> <input type="text" name="treplaceperson_contry1" size="18" value=""> </td>   
      </tr>
      <tr>
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ���֤/���պ��룺 </td>     
        <td width="176" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson_id1" size="23" value=""> </td>    
        <td width="53" height="11" bgcolor="#CBC9F1" align="left" class="unnamed1">     
          &nbsp; �绰�� </td>    
        <td width="141" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson_telephone1" size="18" value=""> </td>   
      </tr>
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ��ַ�� </td>    
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="treplaceperson_address1" size="52" value=""> </td>    
      </tr>
      <tr>
        <td width="149" height="18" bgcolor="#CBC9F1" class="unnamed1"> 
          <p align="left"><b>��(2)��</b></p>
        </td>
        <td width="177" height="18" bgcolor="#CBC9F1" align="center"> 
          <p align="left"> <input    type="text" name="tbuyer2" size="23" value="<%=cus_name %>"> </td>
        <td width="52" height="18" bgcolor="#CBC9F1" align="center"> 
          <p align="left">&nbsp; ������</p>  
 </td> 
        <td width="140" height="18" bgcolor="#CBC9F1" align="center">  
          <p align="left"><input type="text" name="tbuyer_contry2" size="18" value="�й�"> </p>
 </td>
      </tr>
      <tr> 
        <td width="149" height="24" bgcolor="#CBC9F1" class="unnamed1">     
          &nbsp; �ݶ </td>    
        <td width="170" height="24" bgcolor="#CBC9F1" align="left"> <input type="text" name="tbuyer_share2" size="3" value="50">%</td>   
        <td width="62" height="24" bgcolor="#CBC9F1" align="left" class="unnamed1">    
          &nbsp; �绰�� </td>     
        <td width="138" height="24" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tbuyer_telephone2" size="18" value="<%=phone %>"> </td>    
      </tr>    
      <tr>     
        <td width="149" height="13" bgcolor="#CBC9F1" class="unnamed1">     
          &nbsp; ���֤/���պ��룺 </td>   
        <td width="171" height="13" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tbuyer_id2" size="23" value="<%=id_card %>"> </td>   
        <td width="62" height="13" bgcolor="#CBC9F1" align="left"> 
          <p align="left">֤�����ͣ� </td>   
        <td width="137" height="13" bgcolor="#CBC9F1" align="left"> <select size="1" name="tbuyer_idtype2">
	    
            <option value="���֤" selected>���֤</option>
        
            <option value="����">����</option>
        
            <option value="����">����</option>
            
          </select> </td>   
      </tr>   
      <tr>    
        <td width="139" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ��ַ��    
        </td>   
        <td width="374" height="11" bgcolor="#CBC9F1" class="unnamed1" colspan="3"> <input type="text" name="tbuyer_address2" size="52" value="<%=address %>">     
        </td>   
      </tr>   
      <tr>
        <td width="510" height="15" bgcolor="#CBC9F1" class="unnamed1" colspan="4"> ��    
        </td>   
      </tr>
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ��˾��������ƣ� </td>    
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input    type="text" name="tcompany2" size="52" value=""> </td>   
      </tr>
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;   
          ��ַ�� </td>    
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="tcompany_address2" size="52" value=""> </td>    
      </tr> 
      <tr> 
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ���������ˣ� </td>    
        <td width="176" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tlegal_person2" size="23" value=""> </td>   
        <td width="53" height="11" bgcolor="#CBC9F1" align="left" class="unnamed1">    
          &nbsp; �绰�� </td>   
        <td width="141" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tlegal_telephone2" size="18" value=""> </td>  
      </tr>
      <tr>
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ���֤/���պ��룺 </td>    
        <td width="370" height="11" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="tlegal_id2" size="52" value=""> </td>   
      </tr>
      <tr>
        <td width="519" height="11" bgcolor="#CBC9F1" class="unnamed1" colspan="4"> �� </td>    
      </tr>
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ί�д����ˣ� </td>      
        <td width="176" height="1" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson2" size="23" value=""> </td>     
        <td width="53" height="1" bgcolor="#CBC9F1" align="left" class="unnamed1">      
          &nbsp; ������ </td>     
        <td width="141" height="1" bgcolor="#CBC9F1" align="left"> <input type="text" name="treplaceperson_contry2" size="18" value=""> </td>    
      </tr> 
      <tr> 
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ���֤/���պ��룺 </td>      
        <td width="176" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson_id2" size="23" value=""> </td>     
        <td width="53" height="11" bgcolor="#CBC9F1" align="left" class="unnamed1">      
          &nbsp; �绰�� </td>     
        <td width="141" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson_telephone2" size="18" value=""> </td>    
      </tr> 
      <tr> 
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ��ַ�� </td>     
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="treplaceperson_address2" size="52" value=""> </td>     
      </tr> 
      <tr> 
        <td width="149" height="18" bgcolor="#CBC9F1" class="unnamed1">  
          <p align="left"><b>��(3)��</b></p> 
        </td> 
        <td width="177" height="18" bgcolor="#CBC9F1" align="center">  
          <p align="left"> <input    type="text" name="tbuyer3" size="23" value=""> </td> 
        <td width="52" height="18" bgcolor="#CBC9F1" align="center">  
          <p align="left">&nbsp; ������</p>  
 </td> 
        <td width="140" height="18" bgcolor="#CBC9F1" align="center">  
          <p align="left"><input type="text" name="tbuyer_contry3" size="18" value=""> </p>
 </td>
      </tr>
      <tr> 
        <td width="149" height="24" bgcolor="#CBC9F1" class="unnamed1">     
          &nbsp; �ݶ </td>    
        <td width="170" height="24" bgcolor="#CBC9F1" align="left"> <input type="text" name="tbuyer_share3" size="3" value="">%</td>   
        <td width="62" height="24" bgcolor="#CBC9F1" align="left" class="unnamed1">    
          &nbsp; �绰�� </td>     
        <td width="138" height="24" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tbuyer_telephone3" size="18" value=""> </td>    
      </tr>    
      <tr>     
        <td width="149" height="13" bgcolor="#CBC9F1" class="unnamed1">     
          &nbsp; ���֤/���պ��룺 </td>   
        <td width="171" height="13" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tbuyer_id3" size="23" value=""> </td>   
        <td width="62" height="13" bgcolor="#CBC9F1" align="left"> 
          <p align="left">֤�����ͣ� </td>   
        <td width="137" height="13" bgcolor="#CBC9F1" align="left"> <select size="1" name="tbuyer_idtype3">
	    
            <option value="���֤" selected>���֤</option>
        
            <option value="����">����</option>
        
            <option value="����">����</option>
            
          </select> </td>   
      </tr>   
      <tr>    
        <td width="139" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ��ַ��    
        </td>   
        <td width="374" height="11" bgcolor="#CBC9F1" class="unnamed1" colspan="3"> <input type="text" name="tbuyer_address3" size="52" value="">     
        </td>   
      </tr>   
      <tr>
        <td width="510" height="15" bgcolor="#CBC9F1" class="unnamed1" colspan="4"> ��    
        </td>   
      </tr>
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ��˾��������ƣ� </td>    
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input    type="text" name="tcompany3" size="52" value=""> </td>   
      </tr>
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;   
          ��ַ�� </td>    
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="tcompany_address3" size="52" value=""> </td>    
      </tr> 
      <tr> 
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ���������ˣ� </td>    
        <td width="176" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tlegal_person3" size="23" value=""> </td>   
        <td width="53" height="11" bgcolor="#CBC9F1" align="left" class="unnamed1">    
          &nbsp; �绰�� </td>   
        <td width="141" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tlegal_telephone3" size="18" value=""> </td>  
      </tr>
      <tr>
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ���֤/���պ��룺 </td>    
        <td width="370" height="11" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="tlegal_id3" size="52" value=""> </td>   
      </tr>
      <tr>
        <td width="519" height="11" bgcolor="#CBC9F1" class="unnamed1" colspan="4"> �� </td>    
      </tr>
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ί�д����ˣ� </td>      
        <td width="176" height="1" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson3" size="23" value=""> </td>     
        <td width="53" height="1" bgcolor="#CBC9F1" align="left" class="unnamed1">      
          &nbsp; ������ </td>     
        <td width="141" height="1" bgcolor="#CBC9F1" align="left"> <input type="text" name="treplaceperson_contry3" size="18" value=""> </td>    
      </tr> 
      <tr> 
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ���֤/���պ��룺 </td>      
        <td width="176" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson_id3" size="23" value=""> </td>     
        <td width="53" height="11" bgcolor="#CBC9F1" align="left" class="unnamed1">      
          &nbsp; �绰�� </td>     
        <td width="141" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson_telephone3" size="18" value=""> </td>    
      </tr> 
      <tr> 
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ��ַ�� </td>      
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="treplaceperson_address3" size="52" value=""> </td>     
      </tr> 
      
      <tr> 
        <td width="149" height="18" bgcolor="#CBC9F1" class="unnamed1">  
          <p align="left"><b>��(4)��</b></p> 
        </td> 
        <td width="177" height="18" bgcolor="#CBC9F1" align="center">  
          <p align="left"> <input    type="text" name="tbuyer4" size="23" value=""> </td> 
        <td width="52" height="18" bgcolor="#CBC9F1" align="center">  
          <p align="left">&nbsp; ������</p>  
 </td> 
        <td width="140" height="18" bgcolor="#CBC9F1" align="center">  
          <p align="left"><input type="text" name="tbuyer_contry4" size="18" value=""> </p>
 </td>
      </tr>
      <tr> 
        <td width="149" height="24" bgcolor="#CBC9F1" class="unnamed1">     
          &nbsp; �ݶ </td>    
        <td width="170" height="24" bgcolor="#CBC9F1" align="left"> <input type="text" name="tbuyer_share4" size="3" value="">%</td>   
        <td width="62" height="24" bgcolor="#CBC9F1" align="left" class="unnamed1">    
          &nbsp; �绰�� </td>     
        <td width="138" height="24" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tbuyer_telephone4" size="18" value=""> </td>    
      </tr>    
      <tr>     
        <td width="149" height="13" bgcolor="#CBC9F1" class="unnamed1">     
          &nbsp; ���֤/���պ��룺 </td>   
        <td width="171" height="13" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tbuyer_id4" size="23" value=""> </td>   
        <td width="62" height="13" bgcolor="#CBC9F1" align="left"> 
          <p align="left">֤�����ͣ� </td>   
        <td width="137" height="13" bgcolor="#CBC9F1" align="left"> <select size="1" name="tbuyer_idtype4">
	    
            <option value="���֤" selected>���֤</option>
        
            <option value="����">����</option>
        
            <option value="����">����</option>
            
          </select> </td>   
      </tr>   
      <tr>    
        <td width="139" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ��ַ��    
        </td>   
        <td width="374" height="11" bgcolor="#CBC9F1" class="unnamed1" colspan="3"> <input type="text" name="tbuyer_address4" size="52" value="">     
        </td>   
      </tr>   
      <tr>
        <td width="510" height="15" bgcolor="#CBC9F1" class="unnamed1" colspan="4"> ��    
        </td>   
      </tr>
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ��˾��������ƣ� </td>    
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input    type="text" name="tcompany4" size="52" value=""> </td>   
      </tr>
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;   
          ��ַ�� </td>    
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="tcompany_address4" size="52" value=""> </td>    
      </tr> 
      <tr> 
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ���������ˣ� </td>    
        <td width="176" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tlegal_person4" size="23" value=""> </td>   
        <td width="53" height="11" bgcolor="#CBC9F1" align="left" class="unnamed1">    
          &nbsp; �绰�� </td>   
        <td width="141" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="tlegal_telephone4" size="18" value=""> </td>  
      </tr>
      <tr>
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp;  
          ���֤/���պ��룺 </td>    
        <td width="370" height="11" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="tlegal_id4" size="52" value=""> </td>   
      </tr>
      <tr>
        <td width="519" height="11" bgcolor="#CBC9F1" class="unnamed1" colspan="4"> �� </td>    
      </tr>
      <tr>
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ί�д����ˣ� </td>      
        <td width="176" height="1" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson4" size="23" value=""> </td>     
        <td width="53" height="1" bgcolor="#CBC9F1" align="left" class="unnamed1">      
          &nbsp; ������ </td>     
        <td width="141" height="1" bgcolor="#CBC9F1" align="left"> <input type="text" name="treplaceperson_contry4" size="18" value=""> </td>    
      </tr> 
      <tr> 
        <td width="149" height="11" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ���֤/���պ��룺 </td>      
        <td width="176" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson_id4" size="23" value=""> </td>     
        <td width="53" height="11" bgcolor="#CBC9F1" align="left" class="unnamed1">      
          &nbsp; �绰�� </td>     
        <td width="141" height="11" bgcolor="#CBC9F1" align="left"> <input    type="text" name="treplaceperson_telephone4" size="18" value=""> </td>    
      </tr> 
      <tr> 
        <td width="149" height="1" bgcolor="#CBC9F1" class="unnamed1"> &nbsp; ��ַ�� </td>      
        <td width="370" height="1" bgcolor="#CBC9F1" align="left" colspan="3"> <input type="text" name="treplaceperson_address4" size="52" value=""> </td>     
      </tr> 
      
      <tr>     
        <td width="519" height="6" bgcolor="#CBC9F1" class="unnamed1" colspan="4">     
          <p align="center">��ǰ�׷�״̬��<img src=./images/1.0.gif title='Ԥ��'><img src=./images/3.gif title='��ǩ��ͬ'><img src=./images/4.gif title='�ѱ���'>&nbsp;״̬ͼ��˵��<a href='help.htm'>�ɴ���</a><br>
          <a href="housesearch.asp?bid=302&bname=302(���Ĵ���)&presellid=53&index="><img src="../images/cancel.gif" width="63" height="21" alt="cancel.gif (409 bytes)" border="0"></a>  
          </p> 
        </td>   
      </tr>   
    </table>       
</div>       
           
</form>  
           
</body>  
</html>  
  
