<%@ page language="java" import="java.sql.*,java.util.*,common.*" contentType="text/html;charset=GBK"%>
 <%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="f2Bean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
 
<%
 
String date1=getbyte1(request.getParameter("Date1"));
String date2=getbyte1(request.getParameter("Date2"));
String SecNo=getbyte1(request.getParameter("SecNo"));
 
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
	  if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by dengji_riqi asc";
	  if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by cus_name desc";}
	  if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by cus_name asc";
	}else{
	orderby=" order by dengji_riqi desc";
	
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
 
<body  >
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<body topmargin="0" leftmargin="0">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

  <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align=center> <b><font size="3">诚意金一览表 </b> </p>

<form name="form1" method="post">
 
<%@ include file="../public_js/countpagenum.jsp"%>

<%


	


boolean doFind = false ;
if( request.getParameter( "do" ) != null &&  request.getParameter( "do" ).equals( "find" ) ) {
    doFind = true ;
}

if( doFind ) {

    
    String cusName = getbyte( request.getParameter( "cusName" ) ) ;
    String cusPhone = getbyte( request.getParameter( "cusPhone" ) ) ;
    String dengyi1 = getbyte( request.getParameter( "dengyi1" ) ) ;
    String dengyi2 = getbyte( request.getParameter( "dengyi2" ) ) ;
    String dengjiren = getbyte( request.getParameter( "dengjiren" ) ) ;
  //  findStr = " and serialNo like '%' " ;
	
    if( ! cusName.equals( "" ) ) {
        findStr = findStr + "and Cus_Name like '%" + cusName + "%' " ;
    }
    if( ! cusPhone.equals( "" ) ) {
        findStr = findStr + "and Phone like '" + cusPhone + "%' " ;
    }
    if( ! dengyi1.equals( "" ) ) {
        findStr = findStr + "and dengji_riqi >= '" + dengyi1 + " 00:00:00" + "' " ;
    }
    if( ! dengyi2.equals( "" ) ) {
        findStr = findStr + "and dengji_riqi <= '" + dengyi2 + " 23:59:59" + "' " ;
    }
    if( ! dengjiren.equals( "" ) ) {
        findStr = findStr + "and dengjiren like '%" + dengjiren + "%' " ;
    }
	if (!getbyte1(request.getParameter("section")).equals(""))
	findStr = findStr + "and section ='" + getbyte1(request.getParameter("section")) + "' " ;
}

String sql = "" ;
 String datestr="";
String ztstr="";
String datetype=getbyte1( request.getParameter( "datetype" ) ) ;

 String zt= "0" ;
 if (zt.equals("0")||zt.equals("1"))ztstr=" jinger-tk-tk1<>0 and zto="+zt;
 else ztstr="tk>0";
String sectionwhere="";
 if (!SecNo.equals(""))sectionwhere=" and Section='"+SecNo.substring(0,SecNo.indexOf("-"))+"'";
if (!datetype.equals("3")){
if (!date1.equals("")&&!date2.equals(""))datestr=" and convert(varchar(10),dengji_riqi,120)>='"+date1+"' and convert(varchar(10),dengji_riqi,120)<='"+date2+"'";
 }else{
if (!date1.equals("")&&!date2.equals(""))datestr=" and (convert(varchar(10),tk_date,120)>='"+date1+"' and convert(varchar(10),tk_date,120)<='"+date2+"' or convert(varchar(10),tk_date1,120)>='"+date1+"' and convert(varchar(10),tk_date1,120)<='"+date2+"')";

}
    sql =  "select   * from View_Chenyi where "+ztstr+datestr+sectionwhere  ;
 
//out.println(sql);
%>
 	  
 
                  <table width="90%"  align="center" cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
                      <tr > <td> 
                 
				  项目名称：<%=SecNo.substring(SecNo.indexOf("-")+1) %>
				 </td><td align="right">时间段:<%=date1 %>到<%=date2 %></td></tr></table>
				 <br>
				  <table width="90%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
                      <tr > 
                        <td height="25" align="center"> 序号 </td>
 <td align="center"> VIP号 </td>
                        <td align="center"> 客户姓名 </td>
                        <td align="center"> 身份证号 </td>
                        <td align="center"> 联系电话 </td>
                        <td align="center"> 意向单位/备注 </td>
                        <td align="center"> 诚意金额 </td>
                        <td align="center"> 退款金额 </td>
                       <td align="center"> 诚意日期 </td>
                        <td align="center"> 销售员 </td>
                        <td align="center"> &nbsp;状态 </td>
                      </tr>
                      <%// out.print(sql);
                            int i = 0 ; //当前记录行数
							double summ=0,sumtk=0;
                            ResultSet rsB = fBean.executeQuery( sql ) ;
                              while( rsB.next() ) {
                              
				String vip = getbyte( rsB.getString( "vipno" ) );
                                String REF_ID = rsB.getString( "aserialNo" ) ;
								String REF_name = getbyte( rsB.getString( "Cus_Name" ) ) ;
                                String REF_TITLE = getbyte( rsB.getString( "ID_Card" ) ) ;
                                String REF_TYPE = getbyte( rsB.getString( "Phone" ) ) ;
                                int REF_SOURCE = rsB.getInt( "jinger" ) ;
								summ+=REF_SOURCE;
                                Timestamp REF_DATE = rsB.getTimestamp( "dengji_riqi" ) ;
								Timestamp REF_DATE2 = rsB.getTimestamp( "shixiao_riqi" ) ;
                                String REF_IF_ACC = getbyte( rsB.getString( "dengjiren" ) );
                                String REF_IF_ID_CARD = getbyte( rsB.getString( "ID_CARD" ) );
								String REF_IF_SJ = getbyte( rsB.getString( "SJ" ) );
								if (REF_TYPE.equals(""))REF_TYPE=REF_IF_SJ;
                                String yixiang=getbyte( rsB.getString( "context" ) );
								yixiang+=getbyte( rsB.getString( "room" ) );
								String zto=getbyte( rsB.getString( "zto" ) );
								String new_name=getbyte( rsB.getString( "new_name" ) );
								String new_room=getbyte( rsB.getString( "new_room" ) );
								String new_room_date=getbyte( rsB.getString( "new_room_date" ) );
								if (!new_room_date.equals(""))new_room_date=new_room_date.substring(0,10);
								float tk=rsB.getFloat( "tk" );
								float tk1=rsB.getFloat( "tk1" );
								sumtk+=tk+tk1;
String tk_date=getbyte( rsB.getString( "tk_date" ) );
if (!tk_date.equals(""))tk_date=tk_date.substring(0,10)	;
                            %>
                      <tr id=TR<%= i %>> 
                        <td > <%= i+1 %></td>
 <td > <%= vip %></td>
                        <td  align="left"><%=  REF_name  %><%if (zto.equals("1")){out.print("("+ new_name+" "+new_room+" "+new_room_date+")");} %></td>
                        <td ><%= REF_TITLE %>&nbsp;</td>
                        <td align="left" >&nbsp;<%=  REF_TYPE  %></td>
                        <td ><%= yixiang %>&nbsp;</td>
                        <td ><%= REF_SOURCE %></td>
						 <td ><%= tk+tk1 %></td>
                        <td ><%= formatDateTime( REF_DATE , 1 ) %>&nbsp;</td>
                          <td ><%= REF_IF_ACC %>&nbsp;</td>
                        <td > <%
							if (tk==0){
							if (zto.equals("1")){out.print("已购房");}
							  else{out.print("未购房");}
							}else{out.print("已退"+tk_date);}
							
							 %>
						 
                        </td>
                      </tr>
					  
                      <%
                               
                                i ++ ;
                            }
                            %>
                      <tr> 
                        <td align="center"  height="5">合计:</td><td colspan="5">&nbsp;</td><td><%=summ %></td>
						<td><%=sumtk %></td><td colspan="3">&nbsp;</td>
                      </tr>
                    </table>
               
 <%@ include file="../public_js/changepage.jsp"%>
</form>
 
</div>

<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 
  
  </script>
</body>
</html>     

