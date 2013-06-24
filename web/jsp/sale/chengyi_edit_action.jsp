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
                  "修改诚意数据" , 
                  "修改"
                ) ;
%>

<%
 String bbj = request.getParameter( "bbj" ) ;
    String sj = request.getParameter( "sj" ) ;
  
     String section=getbyte1( request.getParameter("section"));
	  String sectionname=section.substring(section.indexOf("-")+1);
	 section=section.substring(0,section.indexOf("-"));
	
     String submit1=getbyte1( request.getParameter("SaveCus"));
     int age=0;
     String demand=getbyte1( request.getParameter("demand"));
	 String attention=getbyte1( request.getParameter("attention"));
	 String cyj=getbyte1( request.getParameter("cyj"));
	String vipno=getbyte1( request.getParameter("vipno"));
   String cusno=getbyte1( request.getParameter("cusno"));
   String  gmyt=getbyte1( request.getParameter("gmyt"));

	String job=getbyte1( request.getParameter("job"));
    String ContactPerson  =getbyte1( request.getParameter("ContactPerson"));
    String personnum=getbyte1( request.getParameter("personnum"));
    if (personnum.equals(""))personnum="0";
	String wh=getbyte1( request.getParameter("wh"));
	String region=getbyte1( request.getParameter("Region"));
    String jtsr=getbyte1( request.getParameter("jtsr"));
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
  String bak= getbyte1( request.getParameter( "bak" ) ) ; //备注
  
   String yxlxs="0";
    String in10="0"; 
   
    
  String yxlcs="0"; 
     String yxfxs="0"; 

if( in10.equals( "" ) ) {
    in10 = "0" ;
}

String in12 = getbyte1( request.getParameter( "in12" ) ) ; //意向付款
String in13 = getbyte1( request.getParameter( "in13" ) ) ; //登记日期
String in14 = getbyte1( request.getParameter( "in14" ) ) ; //失效日期


String in15 = getbyte1( request.getParameter( "in15" ) ) ; //诚意金额
String in16 = getbyte1( request.getParameter( "in16" ) ) ; //收据号码
String in17 = getbyte1( request.getParameter( "in17" ) ) ; //意向单位
    String in17a=getbyte1( request.getParameter( "in17a" ) ) ; //意向单位
String in19 = getbyte1( request.getParameter( "in19" ) ) ; //备注
String in20 = getbyte1( request.getParameter( "in20" ) ) ; //交款方式
String outstate= getbyte1( request.getParameter( "outstate" ) ) ; //是否失效

if (outstate.equals(""))outstate="1";
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
 
    
 
        
  try{

//插入诚意登记表 tb_chengyi
String sq2 = " update tb_chengyi "
			+ " set yscyj="+cyj+", dengji_riqi ='" + in13 + "',vipno='"+vipno+"',yixiangmj='"+in10+"'";
			if (!in14.equals(""))
			sq2+=" , shixiao_riqi='" + in14 + "' ";
		 sq2+=" , context='" + bak + "' ";
		 sq2+=" , send=" + outstate + " ";
		 
			sq2+=", shaojuhaoma='" + in16 + "'  ,  dengjiren='" + seller + "'  ,sendmoney='" + in20 + "' ";
			sq2+=",yxfxs='"+yxfxs+"',yxlcs='"+yxlcs+"',yxlxs='"+yxlxs+"',room='"+in17+"',yxdw1='"+in17a+"',sectionname='"+sectionname+"'";
			sq2+="   where code="+cusSerial;
	
iBean.executeUpdate( sq2 ) ;

    String sq4="update customer set  section='"+section+"',Cus_Name='"+in1+"'"+",Cus_Sex='"+in2+"'"+",cus_age='"+in3+"',Cus_Type='"+custype+"'"+",Purpose='"+gmyt+"'"+",";
	sq4=sq4+"Knowledge_From='"+tj+"'"+",Phone='"+in5+"'"+",ID_Card='"+in4+"',mail='"+mail+"',attention='"+attention+"',demand='"+in9+"'";
	sq4=sq4+",Address='"+in7+"'"+",Zip_Code='"+in8+"',payment='"+in12+"',nowjuarea='"+nowjuarea+"'";
	sq4=sq4+",company='"+company+"',visitnum='"+visitnum+"',visittj='"+visittj+"',visit_date='"+date+"',seller='"+seller+"',visitname='"+visitname+"'";
	sq4=sq4+",Job='"+job+"',Wh='"+wh+"',jtsr='"+jtsr+"',personnum="+personnum+",region='"+region+"',nexus='"+nexus+"',chishu="+chishu+",homejg='"+homejg+"',ContactPerson='"+ContactPerson
	    + "' , bbj = '" + bbj + "' , sj = '" + in6 + "',yixianmianji='"+in10+"' " + "  where SERIALNO='"+request.getParameter("cusno")+"'";
  
	
    iBean.executeUpdate( sq4 ) ;    
  String cusno1=request.getParameter("cusno");
  iBean.executeUpdate("delete customer_xq where customer="+cusno1.substring(cusno1.indexOf("-")+1));
  sq4="select  CodeValue,code from CustomerDcValue";
	ResultSet  	   cusRs=iBean.executeQuery(sq4);
		   while (cusRs.next()){
		     String CodeValue=getbyte1(request.getParameter("codcename"+cusRs.getString("code")));
			 if (!CodeValue.equals("")){
		        sq4="insert into customer_xq(customer,xq_code) values("+cusno.substring(cusno.indexOf("-")+1)+","+CodeValue+")";
				cBean.executeUpdate(sq4);
			 }	
		   }
		   cusRs.close();
}catch(Exception s){out.print(s);}

%>

<script lang=javascript>
   opener.window.document.form1.submit() ;
  window.close();
</script>	