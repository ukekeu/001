<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
    <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
   <%@ include file="../public_js/getByteOut.jsp"%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 10">
<meta name=Originator content="Microsoft Word 10">
<link rel=File-List href="分类.files/filelist.xml">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>分类</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Image</o:Author>
  <o:Template>Normal</o:Template>
  <o:LastAuthor>Image</o:LastAuthor>
  <o:Revision>4</o:Revision>
  <o:TotalTime>44</o:TotalTime>
  <o:Created>2005-02-28T06:27:00Z</o:Created>
  <o:LastSaved>2005-02-28T06:50:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>38</o:Words>
  <o:Characters>223</o:Characters>
  <o:Company>2ndSpAcE</o:Company>
  <o:Lines>1</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>260</o:CharactersWithSpaces>
  <o:Version>10.2625</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:PunctuationKerning/>
  <w:DrawingGridVerticalSpacing>7.8 磅</w:DrawingGridVerticalSpacing>
  <w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery>
  <w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery>
  <w:Compatibility>
   <w:SpaceForUL/>
   <w:BalanceSingleByteDoubleByteWidth/>
   <w:DoNotLeaveBackslashAlone/>
   <w:ULTrailSpace/>
   <w:DoNotExpandShiftReturn/>
   <w:AdjustLineHeightInTable/>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseFELayout/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->

<!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:普通表格;
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>
<%
String timetype=request.getParameter("timetype");
String SecNo=getbyte1(request.getParameter("SecNo"));
String Loft=getbyte1(request.getParameter("Loft"));
String month=request.getParameter("month");
String whereSQL1="",whereSQL2="",whereSQL3="";
String whereSQL4="",whereSQL5="",whereSQL6="";
String whereSQL7="",whereSQL8="",whereSQL9="";
String whereSQL10="",whereSQL11="",whereSQL12="";

String SecNa=SecNo.substring(SecNo.indexOf("-")+1);
SecNo=SecNo.substring(0,SecNo.indexOf("-"));
if (timetype.equals("0")){
   whereSQL1=" and section='"+SecNo+"' and year(date)=year(getdate()) and month(date)="+month;
   whereSQL2=" and section='"+SecNo+"' and year(date)=year(dateadd(mm,-1,getdate())) and month(date)="+month+"-1";
   whereSQL3=" and section='"+SecNo+"' and year(date)=year(dateadd(mm,1,getdate())) and month(date)="+month+"+1";
  
  
   whereSQL4=" and year(gather_date)=year(getdate()) and month(gather_date)="+month;
   whereSQL5=" and  year(gather_date)=year(dateadd(mm,-1,getdate())) and month(gather_date)="+month+"-1";
   whereSQL6=" and  year(gather_date)=year(dateadd(mm,1,getdate())) and month(gather_date)="+month+"+1";
   whereSQL7=" and year(factdate)=year(getdate()) and month(factdate)="+month;
   whereSQL8=" and  year(factdate)=year(dateadd(mm,-1,getdate())) and month(factdate)="+month+"-1";
   whereSQL9=" and  year(factdate)=year(dateadd(mm,1,getdate())) and month(factdate)="+month+"+1";
   whereSQL10=" and  year(shouldDate)=year(dateadd(mm,1,getdate())) and month(shouldDate)="+month+"+1";

   
   
}

if (!Loft.equals("")){
  whereSQL1=" and loft ='"+Loft +"' and section='"+SecNo+"' and year(date)=year(getdate()) and month(date)="+month;
   whereSQL2=" and loft ='"+Loft +"'  and section='"+SecNo+"' and year(date)=year(dateadd(mm,-1,getdate())) and month(date)="+month+"-1";
   whereSQL3=" and loft ='"+Loft +"'  and section='"+SecNo+"' and year(date)=year(dateadd(mm,1,getdate())) and month(date)="+month+"+1";
  

}
 %>
<body lang=ZH-CN style='tab-interval:21.0pt;text-justify-trim:punctuation'>

<div class=Section1 style='layout-grid:15.6pt'>

 
<p align="center"><b><%=SecNa+Loft %><%if (timetype.equals("0")){out.print("月");}  %>销售情况对比分析表 </b></p>

 金额单位:万元  面积单位:平方米   本月:<%=month %>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  >
  <td width=10% colspan=2 valign=top style='width:48.35pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:30.65pt'>
  <p class=MsoNormal><span style='font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>分类</span></p>
  </td>
  <td width=30% colspan=4 valign=top style='width:221.65pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:30.65pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>上季度/上月</span></p>
  </td>
  <td width=40% colspan=6 valign=top style='width:292.05pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:30.65pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>本季度/本月</span></p>
  </td>
  <td width=10% valign=top style='width:80.75pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:30.65pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>下季度/下月</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:22.5pt'>
  <td width=64 colspan=2 valign=top style='width:48.35pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:22.5pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=152 colspan=2 valign=top style='width:113.65pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>销售情况</span><span lang=EN-US><o:p></o:p></span></p>
  </td>
  <td width=144 colspan=2 valign=top style='width:108.0pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>收款情况</span></p>
  </td>
  <td width=156 colspan=2 valign=top style='width:117.0pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>销售情况</span><span lang=EN-US><o:p></o:p></span></p>
  </td>
  <td width=136 colspan=2 valign=top style='width:102.2pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>收款情况</span><span lang=EN-US><o:p></o:p></span></p>
  </td>
  <td width=97 colspan=2 valign=top style='width:72.85pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.5pt'>
  <p class=MsoNormal align=center style='text-align:center;text-indent:5.25pt;
  mso-char-indent-count:.5'><span style='font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>比上季度</span></p>
  </td>
  <td width=80 rowspan=2 valign=top style='width:80.75pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.5pt'>
  <p class=MsoNormal align=center style='text-align:center;text-indent:10.5pt;
  mso-char-indent-count:1.0'><span style='font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>预计收款情况</span><span
  lang=EN-US><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:6.75pt'>
  <td width=64 colspan=2 valign=top style='width:48.35pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width=80 valign=top style='width:59.65pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>面积</span></p>
  </td>
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>金额</span></p>
  </td>
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>首期款</span></p>
  </td>
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>按揭款</span></p>
  </td>
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>面积</span><span lang=EN-US><o:p></o:p></span></p>
  </td>
  <td width=84 valign=top style='width:63.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>金额</span><span lang=EN-US><o:p></o:p></span></p>
  </td>
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>首期款</span><span lang=EN-US><o:p></o:p></span></p>
  </td>
  <td width=64 valign=top style='width:48.2pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>按揭款</span><span lang=EN-US><o:p></o:p></span></p>
  </td>
  <td width=48 valign=top style='width:36.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>销售额</span></p>
  </td>
  <td width=49 valign=top style='width:36.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:6.75pt'>
  <p class=MsoNormal align=center style='text-align:center;text-indent:5.25pt;
  mso-char-indent-count:.5'><span style='font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>回款</span></p>
  </td>
 </tr>
 
 <%
 String SQL="";
 SQL="SELECT YONG_TU,COUNT(*) NUM FROM ORDER_CONTRACT WHERE STATE<>3 and YONG_TU<>'' and section='"+SecNo+"' GROUP BY YONG_TU ";
 
  ResultSet rs=null;
  ResultSet rs1=null;
  rs=ViewBean.executeQuery(SQL);
  int num=0;
  while (rs.next()) {num+=1;}
  rs.close();
  SQL="SELECT YONG_TU,COUNT(*) NUM FROM ORDER_CONTRACT WHERE STATE<>3 and YONG_TU<>''  and section='"+SecNo+"' GROUP BY YONG_TU ";
 rs=ViewBean.executeQuery(SQL);
 String nn="";
 while (rs.next()) {

%>
 
 <tr style='mso-yfti-irow:3;height:15.0pt'>
 <% if (nn.equals("")){ %>
  <td width=42 rowspan="<%=num %>"  valign="middle" >  用途</td>
  <%}
  
  nn="ok"; 
  
  String YONG_TU=rs.getString("YONG_TU");
  %>
 
  <td width=22 valign=top > <%=YONG_TU %> </td>
  <% SQL="SELECT sum(jzarea) jzarea,sum(room_sumprice)/10000 sumprice   FROM ORDER_CONTRACT WHERE STATE<>3 and YONG_TU='"+YONG_TU+"'"+whereSQL2  ;
 
  rs1=ViewBean1.executeQuery(SQL);
  double jzarea=0,sumprice=0;
  if (rs1.next()){jzarea=rs1.getDouble("jzarea");sumprice=rs1.getDouble("sumprice");}
  rs1.close();
 
 %> 
  <td width=80 valign=top > &nbsp;<%=FormatD.getFloat2(jzarea,2) %> 
  </td>
  <td width=72 valign=top  >&nbsp;<%=FormatD.getFloat2(sumprice,2) %> 
  </td>
   <% SQL="select sum(factmoney*CurrRate)/10000 rmbprice from FactGatheringRecord  where    contractno in (select  code from  order_contract where state<>3   and  YONG_TU='"+YONG_TU+"' and section='"+SecNo+"')"+whereSQL5;
 
  rs1=ViewBean1.executeQuery(SQL);
  double sqk=0;
  int ajk=0;
  if (rs1.next()){sqk=rs1.getDouble("rmbprice");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=sqk %></o:p></span></p>
  </td>
    <% SQL="select sum(factmonye)/10000 as factmonye from FactAjCharges where  contractno  in (select  code from  order_contract where state<>3   and  YONG_TU='"+YONG_TU+"' and section='"+SecNo+"')"+whereSQL8;
 
  rs1=ViewBean1.executeQuery(SQL);
  
  if (rs1.next()){ajk=rs1.getInt("factmonye");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=ajk %></o:p></span></p>
  </td>
 <% SQL="SELECT sum(jzarea) jzarea,sum(room_sumprice)/10000 sumprice   FROM ORDER_CONTRACT WHERE STATE<>3 and YONG_TU='"+YONG_TU+"'"+whereSQL1;
  
  rs1=ViewBean1.executeQuery(SQL);
     double jzarea1=0;double sumprice1=0;
  if (rs1.next()){jzarea1=rs1.getDouble("jzarea");sumprice1=rs1.getDouble("sumprice");}
  rs1.close();
 
 %> 
  <td width=80 valign=top > &nbsp;<%=FormatD.getFloat2(jzarea1,2) %> 
  </td>
  <td width=72 valign=top  >&nbsp;<%=FormatD.getFloat2(sumprice1,2) %> 
  </td>
   <% SQL="select sum(factmoney*CurrRate)/10000 rmbprice from FactGatheringRecord  where    contractno in (select  code from  order_contract where state<>3   and  YONG_TU='"+YONG_TU+"' and section='"+SecNo+"')"+whereSQL4;
 
  rs1=ViewBean1.executeQuery(SQL);
    double sqk1=0;
	int ajk1=0;
  if (rs1.next()){sqk1=rs1.getDouble("rmbprice");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(sqk1,2) %></o:p></span></p>
  </td>
    <% SQL="select sum(factmonye)/10000 as factmonye from FactAjCharges where  contractno  in (select  code from  order_contract where state<>3   and  YONG_TU='"+YONG_TU+"' and section='"+SecNo+"')"+whereSQL8;
 
  rs1=ViewBean1.executeQuery(SQL);
  
  if (rs1.next()){ajk1=rs1.getInt("factmonye");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(ajk1,2) %></o:p></span></p>
  </td>
  <td width=48 valign=top style='width:36.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(sumprice1-sumprice,2) %></o:p></span></p>
  </td>
  <td width=49 valign=top style='width:36.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2((ajk1+sqk1)-(ajk+sqk),2) %></o:p></span></p>
  </td>
  <% SQL="select sum(shouldmoney*Rate)/10000 rmbprice from GatheringRecord  where    contactno in (select  code from  order_contract where state<>3   and  YONG_TU='"+YONG_TU+"' and section='"+SecNo+"')"+whereSQL10;
 
  rs1=ViewBean1.executeQuery(SQL);
  sqk1=0;
 
  if (rs1.next()){sqk1=rs1.getDouble("rmbprice");}
  rs1.close();
 
 %> 
  <td width=30 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(sqk1,2) %></o:p></span></p>
  </td>
 </tr>
 <%}
 rs.close(); %>
  
  
  
 <%
  
 SQL="SELECT payment1,COUNT(*) NUM FROM ORDER_CONTRACT WHERE STATE<>3 and payment1<>'' and section='"+SecNo+"' GROUP BY payment1 ";
  
  rs=ViewBean.executeQuery(SQL);
    num=0;
  while (rs.next()) {num+=1;}
  rs.close();
  SQL="SELECT payment1,COUNT(*) NUM FROM ORDER_CONTRACT WHERE STATE<>3 and payment1<>''  and section='"+SecNo+"' GROUP BY payment1 ";
 rs=ViewBean.executeQuery(SQL);
   nn="";
 while (rs.next()) {

%>
 
 <tr style='mso-yfti-irow:3;height:15.0pt'>
 <% if (nn.equals("")){ %>
  <td width=42 rowspan="<%=num %>"  valign="middle" >  付款方式</td>
  <%}
  
  nn="ok"; 
  
  String payment1=rs.getString("payment1");
  %>
 
  <td width=22 valign=top > <%=payment1 %> </td>
  <% SQL="SELECT sum(jzarea) jzarea,sum(room_sumprice)/10000 sumprice   FROM ORDER_CONTRACT WHERE STATE<>3 and payment1='"+payment1+"'"+whereSQL2  ;
 
  rs1=ViewBean1.executeQuery(SQL);
  double jzarea=0,sumprice=0;
  if (rs1.next()){jzarea=rs1.getDouble("jzarea");sumprice=rs1.getDouble("sumprice");}
  rs1.close();
 
 %> 
  <td width=80 valign=top > &nbsp;<%=FormatD.getFloat2(jzarea,2) %> 
  </td>
  <td width=72 valign=top  >&nbsp;<%=FormatD.getFloat2(sumprice,2) %> 
  </td>
   <% SQL="select sum(factmoney*CurrRate)/10000 rmbprice from FactGatheringRecord  where    contractno in (select  code from  order_contract where state<>3   and  payment1='"+payment1+"' and section='"+SecNo+"')"+whereSQL5;
 
  rs1=ViewBean1.executeQuery(SQL);
  double sqk=0;
  int ajk=0;
  if (rs1.next()){sqk=rs1.getDouble("rmbprice");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=sqk %></o:p></span></p>
  </td>
    <% SQL="select sum(factmonye)/10000 as factmonye from FactAjCharges where  contractno  in (select  code from  order_contract where state<>3   and  payment1='"+payment1+"' and section='"+SecNo+"')"+whereSQL8;
 
  rs1=ViewBean1.executeQuery(SQL);
  
  if (rs1.next()){ajk=rs1.getInt("factmonye");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=ajk %></o:p></span></p>
  </td>
 <% SQL="SELECT sum(jzarea) jzarea,sum(room_sumprice)/10000 sumprice   FROM ORDER_CONTRACT WHERE STATE<>3 and payment1='"+payment1+"'"+whereSQL1;
  
  rs1=ViewBean1.executeQuery(SQL);
     double jzarea1=0;double sumprice1=0;
  if (rs1.next()){jzarea1=rs1.getDouble("jzarea");sumprice1=rs1.getDouble("sumprice");}
  rs1.close();
 
 %> 
  <td width=80 valign=top > &nbsp;<%=FormatD.getFloat2(jzarea1,2) %> 
  </td>
  <td width=72 valign=top  >&nbsp;<%=FormatD.getFloat2(sumprice1,2) %> 
  </td>
   <% SQL="select sum(factmoney*CurrRate)/10000 rmbprice from FactGatheringRecord  where    contractno in (select  code from  order_contract where state<>3   and  payment1='"+payment1+"' and section='"+SecNo+"')"+whereSQL4;
 
  rs1=ViewBean1.executeQuery(SQL);
    double sqk1=0;
	int ajk1=0;
  if (rs1.next()){sqk1=rs1.getDouble("rmbprice");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(sqk1,2) %></o:p></span></p>
  </td>
    <% SQL="select sum(factmonye)/10000 as factmonye from FactAjCharges where  contractno  in (select  code from  order_contract where state<>3   and  payment1='"+payment1+"' and section='"+SecNo+"')"+whereSQL8;
 
  rs1=ViewBean1.executeQuery(SQL);
  
  if (rs1.next()){ajk1=rs1.getInt("factmonye");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(ajk1,2) %></o:p></span></p>
  </td>
  <td width=48 valign=top style='width:36.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(sumprice1-sumprice,2) %></o:p></span></p>
  </td>
  <td width=49 valign=top style='width:36.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2((ajk1+sqk1)-(ajk+sqk),2) %></o:p></span></p>
  </td>
  <% SQL="select sum(shouldmoney*Rate)/10000 rmbprice from GatheringRecord  where    contactno in (select  code from  order_contract where state<>3   and  payment1='"+payment1+"' and section='"+SecNo+"')"+whereSQL10;
 
  rs1=ViewBean1.executeQuery(SQL);
  sqk1=0;
 
  if (rs1.next()){sqk1=rs1.getDouble("rmbprice");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(sqk1,2) %></o:p></span></p>
  </td>
 </tr>
 <%}
 rs.close(); %>
  
  
  
 <%
  
 SQL="SELECT loft,COUNT(*) NUM FROM ORDER_CONTRACT WHERE STATE<>3 and loft<>'' and section='"+SecNo+"' GROUP BY loft ";
  
  rs=ViewBean.executeQuery(SQL);
    num=0;
  while (rs.next()) {num+=1;}
  rs.close();
  SQL="SELECT loft,COUNT(*) NUM FROM ORDER_CONTRACT WHERE STATE<>3 and loft<>''  and section='"+SecNo+"' GROUP BY loft ";
 rs=ViewBean.executeQuery(SQL);
   nn="";
 while (rs.next()) {

%>
 
 <tr style='mso-yfti-irow:3;height:15.0pt'>
 <% if (nn.equals("")){ %>
  <td width=42 rowspan="<%=num %>"  valign="middle" >  楼栋</td>
  <%}
  
  nn="ok"; 
  
  String loft=rs.getString("loft");
  %>
 
  <td width=22 valign=top > <%=loft %> </td>
  <% SQL="SELECT sum(jzarea) jzarea,sum(room_sumprice)/10000 sumprice   FROM ORDER_CONTRACT WHERE STATE<>3 and loft='"+loft+"'"+whereSQL2  ;
 
  rs1=ViewBean1.executeQuery(SQL);
  double jzarea=0,sumprice=0;
  if (rs1.next()){jzarea=rs1.getDouble("jzarea");sumprice=rs1.getDouble("sumprice");}
  rs1.close();
 
 %> 
  <td width=80 valign=top > &nbsp;<%=FormatD.getFloat2(jzarea,2) %> 
  </td>
  <td width=72 valign=top  >&nbsp;<%=FormatD.getFloat2(sumprice,2) %> 
  </td>
   <% SQL="select sum(factmoney*CurrRate)/10000 rmbprice from FactGatheringRecord  where    contractno in (select  code from  order_contract where state<>3   and  loft='"+loft+"' and section='"+SecNo+"')"+whereSQL5;
 
  rs1=ViewBean1.executeQuery(SQL);
  double sqk=0;
  int ajk=0;
  if (rs1.next()){sqk=rs1.getDouble("rmbprice");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=sqk %></o:p></span></p>
  </td>
    <% SQL="select sum(factmonye)/10000 as factmonye from FactAjCharges where  contractno  in (select  code from  order_contract where state<>3   and  loft='"+loft+"' and section='"+SecNo+"')"+whereSQL8;
 
  rs1=ViewBean1.executeQuery(SQL);
  
  if (rs1.next()){ajk=rs1.getInt("factmonye");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=ajk %></o:p></span></p>
  </td>
 <% SQL="SELECT sum(jzarea) jzarea,sum(room_sumprice)/10000 sumprice   FROM ORDER_CONTRACT WHERE STATE<>3 and loft='"+loft+"'"+whereSQL1;
  
  rs1=ViewBean1.executeQuery(SQL);
     double jzarea1=0;double sumprice1=0;
  if (rs1.next()){jzarea1=rs1.getDouble("jzarea");sumprice1=rs1.getDouble("sumprice");}
  rs1.close();
 
 %> 
  <td width=80 valign=top > &nbsp;<%=FormatD.getFloat2(jzarea1,2) %> 
  </td>
  <td width=72 valign=top  >&nbsp;<%=FormatD.getFloat2(sumprice1,2) %> 
  </td>
   <% SQL="select sum(factmoney*CurrRate)/10000 rmbprice from FactGatheringRecord  where    contractno in (select  code from  order_contract where state<>3   and  loft='"+loft+"' and section='"+SecNo+"')"+whereSQL4;
 
  rs1=ViewBean1.executeQuery(SQL);
    double sqk1=0;
	int ajk1=0;
  if (rs1.next()){sqk1=rs1.getDouble("rmbprice");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(sqk1,2) %></o:p></span></p>
  </td>
    <% SQL="select sum(factmonye)/10000 as factmonye from FactAjCharges where  contractno  in (select  code from  order_contract where state<>3   and  loft='"+loft+"' and section='"+SecNo+"')"+whereSQL8;
 
  rs1=ViewBean1.executeQuery(SQL);
  
  if (rs1.next()){ajk1=rs1.getInt("factmonye");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(ajk1,2) %></o:p></span></p>
  </td>
  <td width=48 valign=top style='width:36.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(sumprice1-sumprice,2) %></o:p></span></p>
  </td>
  <td width=49 valign=top style='width:36.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2((ajk1+sqk1)-(ajk+sqk),2) %></o:p></span></p>
  </td>
  <% SQL="select sum(shouldmoney*Rate)/10000 rmbprice from GatheringRecord  where    contactno in (select  code from  order_contract where state<>3   and  loft='"+loft+"' and section='"+SecNo+"')"+whereSQL10;
 
  rs1=ViewBean1.executeQuery(SQL);
  sqk1=0;
 
  if (rs1.next()){sqk1=rs1.getDouble("rmbprice");}
  rs1.close();
 
 %> 
  <td width=72 valign=top style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;<%=FormatD.getFloat2(sqk1,2) %></o:p></span></p>
  </td>
 </tr>
 <%}
 rs.close(); %>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>
