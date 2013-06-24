<%@ page contentType="text/html;charset=GBK" import="java.sql.*,java.util.*"%>
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="iBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="cBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "诚意一览" , 
                  "修改"
                ) ;
%>

<%
 String bbj = request.getParameter( "bbj" ) ;
    String sj = request.getParameter( "sj" ) ;
  
     String section=getbyte1( request.getParameter("section"));
     String submit1=getbyte1( request.getParameter("SaveCus"));
     int age=0;
     String demand=getbyte1( request.getParameter("demand"));
	 String attention=getbyte1( request.getParameter("attention"));
	 
	
   String cusno=getbyte1( request.getParameter("cusno"));
   String  gmyt=getbyte1( request.getParameter("gmyt"));

	String job=getbyte1( request.getParameter("job"));
    String ContactPerson  =getbyte1( request.getParameter("ContactPerson"));
    String personnum=getbyte1( request.getParameter("personnum"));
    if (personnum.equals(""))personnum="0";
	String wh=getbyte1( request.getParameter("wh"));
	String region=getbyte1( request.getParameter("Region"));
    String jtsr=getbyte1( request.getParameter("jtsr"));
	String tk=getbyte1( request.getParameter("tk"));
	String tk_date=getbyte1( request.getParameter("tkDate1"));
		String tk1=getbyte1( request.getParameter("tk1"));
	String tk_date1=getbyte1( request.getParameter("tkDate2"));
   String  date="";

   if (submit1.equals("insert")){
       date=request.getParameter("Date1"); 
	}
	else
	{
	   date=getbyte1( request.getParameter("Date1"));
	}
    String  tj=getbyte1( request.getParameter("tj"));
    String  tel=getbyte1( request.getParameter("tel"));
    String  idcard=getbyte1( request.getParameter("cardid"));
    if (idcard.equals(""))idcard="0";
	String  custype=getbyte1( request.getParameter("custype"));
    String  seller=getbyte1( request.getParameter("seller"));
	String  addr=getbyte1( request.getParameter("addr"));
    String  contactPerson=getbyte1( request.getParameter("ContactPerson"));
	String  yb=getbyte1( request.getParameter("pos"));
    String company=getbyte1( request.getParameter("company"));
	String visitnum=getbyte1( request.getParameter("num"));
     if (visitnum.equals(""))visitnum="";
	String chishu=getbyte1( request.getParameter("chishu"));
	if (chishu.equals(""))chishu="0";
	String curry=getbyte1( request.getParameter("curry"));
	String rate=getbyte1( request.getParameter("rate"));
	String homejg=getbyte1( request.getParameter("homejg"));
	String nexus=getbyte1( request.getParameter("tfnexus"));
    String nowjuarea=getbyte1( request.getParameter("nowjuarea"));
	String visittj=getbyte1( request.getParameter("cometj"));
    String visitname=getbyte1( request.getParameter("visitname"));
	String	 signatory=getbyte1( request.getParameter("signatory"));	
    String mail=getbyte1( request.getParameter("mail"));	 
    String payment=getbyte1( request.getParameter("payment"));	
String in1 = getbyte1( request.getParameter( "in1" ) ) ; 
String in2 = getbyte1( request.getParameter( "in2" ) ) ; 
String in3 = getbyte1( request.getParameter( "in3" ) ) ; 
String in4 = getbyte1( request.getParameter( "in4" ) ) ; 
String in5 = getbyte1( request.getParameter( "in5" ) ) ; 
String in6 = getbyte1( request.getParameter( "in6" ) ) ; 
String in7 = getbyte1( request.getParameter( "in7" ) ) ; 
String in8 = getbyte1( request.getParameter( "in8" ) ) ; 
String in9 = getbyte1( request.getParameter( "in9" ) ) ; //意向户型
String in10 = getbyte1( request.getParameter( "in10" ) ) ; //意向面积
 
   String in17a=getbyte1( request.getParameter( "in17a" ) ) ; 
  

if( in10.equals( "" ) ) {
    in10 = "0" ;
}

String in12 = getbyte1( request.getParameter( "in12" ) ) ; //意向付款
String in13 = getbyte1( request.getParameter( "in13" ) ) ; //登记日期
String in14 = getbyte1( request.getParameter( "in14" ) ) ; //失效日期


String in15 = getbyte1( request.getParameter( "in15" ) ) ; //诚意金额
String in16 = getbyte1( request.getParameter( "in16" ) ) ; //收据号码
String in17 = getbyte1( request.getParameter( "in17" ) ) ; //意向单位
String in19 = getbyte1( request.getParameter( "in19" ) ) ; //备注
String in20 = getbyte1( request.getParameter( "in20" ) ) ; //交款方式
String skDate2= getbyte1( request.getParameter( "skDate2" ) ) ; //交款方式
String sjh= getbyte1( request.getParameter( "sjh" ) ) ; //交款方式
boolean isHaveThisCus = false ;
String cusSerial = request.getParameter( "cusSerial" ) ;
String cus="";
 
//生成诚意用户的唯一标识
String nextSeria ="";


//插入诚意单位表 tb_chengyi_danwei
String sectionName = "" ;
String loft = "" ;
String building = "" ;
String rooms = "" ;
String room = "" ;
 
    
 
        
if (tk.equals(""))tk="0";   
if (tk1.equals(""))tk1="0";   
//插入诚意登记表 tb_chengyi
String sq2 = " update tb_chengyi  set  sjh ='" + sjh+"',tk =" + tk+",tk1="+tk1+",sk_date='"+skDate2+"',jinger="+in15+",sendmoney='"+in20+"',curry='"+curry+"'" ;
			 if (!tk_date.equals(""))
			 sq2+=" , tk_date='" + tk_date + "' ";
			else
			 sq2+=" , tk_date=null ";
			 if (!tk_date1.equals(""))
			sq2+=" , tk_date1='" + tk_date1 + "' ";
			else
			 sq2+=" , tk_date1=null ";
			sq2+=" where code="+cusSerial;
		fBean.executeUpdate(sq2);	

 
%>

<script lang=javascript>
alert("系统已保存数据");
 opener.window.document.form1.submit() ;
window.location="printcy.jsp?REF_ID=<%=cusSerial %>";
</script>