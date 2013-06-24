<%@ page contentType="text/html;charset=GBK" import="java.sql.*,java.util.*"%>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="iBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="cBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>保存诚意登记</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script Language="JavaScript" src="../public_js/basal.js"></script>
</head>

<body>

<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "诚意管理" , 
                  "增加"
                ) ;
%>

<%
 String bbj = request.getParameter( "bbj" ) ;
    String sj = request.getParameter( "sj" ) ;
  String cyj=getbyte1( request.getParameter("cyj"));
     String section=getbyte1( request.getParameter("section"));
	 String sectionname=section.substring(section.indexOf("-")+1);
	 section=section.substring(0,section.indexOf("-"));
     String submit1=getbyte1( request.getParameter("SaveCus"));
     int age=0;
     String demand=getbyte1( request.getParameter("demand"));
	 String attention=getbyte1( request.getParameter("attention"));
	 String csdate=getbyte1( request.getParameter("csdate"));
	String vipno=getbyte1( request.getParameter("vipno"));
  
   String yxlxs=""; 
  String yxlcs=""; 
     String yxfxs=""; 
   
   String cusno=getbyte1( request.getParameter("cusno"));
   String  gmyt=getbyte1( request.getParameter("gmyt"));

	String job=getbyte1( request.getParameter("job"));
    String ContactPerson  =getbyte1( request.getParameter("ContactPerson"));
    String personnum=getbyte1( request.getParameter("personnum"));
    if (personnum.equals(""))personnum="0";
	String wh=getbyte1( request.getParameter("wh"));
	String region=getbyte1( request.getParameter("Region"));
    String jtsr=getbyte( request.getParameter("jtsr"));
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
if (in3.equals(""))in3="0";
String in4 = getbyte1( request.getParameter( "in4" ) ) ; 
String in5 = getbyte1( request.getParameter( "in5" ) ) ; 
String in6 = getbyte1( request.getParameter( "in6" ) ) ; 
String in7 = getbyte1( request.getParameter( "in7" ) ) ; 
String in8 = getbyte1( request.getParameter( "in8" ) ) ; 
String in9 = getbyte1( request.getParameter( "in9" ) ) ; //意向户型
 
 String in10=""; 

String in12 = getbyte1( request.getParameter( "in12" ) ) ; //意向付款
String in13 = getbyte1( request.getParameter( "in13" ) ) ; //登记日期
String in14 = getbyte1( request.getParameter( "in14" ) ) ; //失效日期


String in15 = getbyte1( request.getParameter( "in15" ) ) ; //诚意金额
String in16 = getbyte1( request.getParameter( "in16" ) ) ; //收据号码
String in17 = getbyte1( request.getParameter( "in17" ) ) ; //意向单位
String in17a = getbyte1( request.getParameter( "in17a" ) ) ; //意向单位
String in19 = getbyte1( request.getParameter( "in19" ) ) ; //备注
String in20 = getbyte1( request.getParameter( "in20" ) ) ; //交款方式
String bak = getbyte1( request.getParameter( "bak" ) ) ; //交款方式
boolean isHaveThisCus = false ;
String cusSerial = request.getParameter( "cusSerial" ) ;
String cus="";
if(!cusSerial.equals(""))
{cus=cusSerial.substring(0,cusSerial.indexOf("-"));
}

if( (! cus.equals(section))) {
    isHaveThisCus = true ;
}
  
 
//生成诚意用户的唯一标识
String nextSeria ="";


//插入诚意单位表 tb_chengyi_danwei
String sectionName = "" ;
String loft = "" ;
String building = "" ;
String rooms = "" ;
String room = "" ;
 
   
	//下面是计算某楼盘来访客户的最大编号
	 String sql="";
	 sql="select max(code)+1 code from customer ";//计算客户最大ID
        ResultSet cusRs=fBean.executeQuery(sql);  
         String cus_code="1";
        if (cusRs.next()){
            cus_code=cusRs.getString("code");
		}
	    cusRs.close();
		cusSerial=section+"-"+cus_code;
 


	 
//插入打印收据数据
    String sjcontext="";

	String PayType=in20;
	String cyrate=request.getParameter("rate");
	String curry=getbyte1(request.getParameter("curry"));
	
	ResultSet execRs=null;
	String upperMoney="";
	execRs=fBean.executeQuery("exec dbo.L2U "+in15+",0 ");//大写金额转换存储过程
	if (execRs.next())
	upperMoney=getbyte(execRs.getString("dd"));
	execRs.close();
 
		
	//if (BillType.equals("0"))BillType="收据";
	//if (BillType.equals("1"))BillType="发票";
	String context="诚意金";
	    sjcontext="insert into printsksj(customer,payment,context,money1"
		+",money2,rate,txt) values('"+in1+"','"+payment+"','"+context
		+"','"+upperMoney+"',"+in15+","+cyrate+",'"+in16+"')";
	
     iBean.executeUpdate("delete printsksj");

	  iBean.executeUpdate(sjcontext);
	
//插入诚意登记表 tb_chengyi
//判断该用户是否存在
  String sq3="select * from  tb_chengyi where sectionname='"+sectionname+"' and  vipno='"+vipno+"'";
   
 ResultSet rs8=iBean.executeQuery( sq3 ) ;
 String dd="";
 if (rs8.next())dd="bof";
     rs8.close();

 if (!dd.equals("")){%>
  <script>alert("此VIP客户的资料已存在");window.history.back(1);</script>
 
 <% }else{
 String sq4="";

 try{
 	
String sq2 = " insert into tb_chengyi "
			+ " (sectionname,yscyj,vipno, serialNo , dengji_riqi ,";
			if (!in14.equals(""))
			sq2+=" shixiao_riqi ,";
			sq2+="  jinger , "
			+ " shaojuhaoma ,  dengjiren ,sendmoney,curry,rate,payment,context,yixiangmj,room,demand,yxfxs,yxlcs,yxlxs,yxdw1 )"
			+ " values ('"+sectionname+"',"+cyj+",'"+vipno+"',"
			+ " '" + cusSerial + "' , "
			+ " '" + in13 + "' , ";
			if (!in14.equals(""))
			sq2+= " '" + in14 + "' , ";
			
			sq2+=" " + in15 + " , "
			+ " '" + in16 + "' , "
			+ " '" + seller + "' , "
			+ " '" + in20 + "'"
			+ ",'"+curry+"',"+cyrate+",'"+in20+"','"+bak+"','"+in10+"','"+in17+"','"+in9+"'"
			+",'"+yxfxs+"','"+yxlcs+"','"+yxlxs+"','"+in17a+"')";
 
     iBean.executeUpdate( sq2 ) ;

     sq4="insert into customer(Section,SerialNo,Cus_Name, Cus_Sex, cus_age, Cus_Type, Purpose, Knowledge_From,Phone, ID_Card, Address,"; 
        sq4=sq4+"Zip_Code, visit_date, seller,company,visitnum,visittj,mail,attention,demand,Job,Wh,jtsr,personnum,region,contactperson,nexus,chishu,homejg,visitname,nowjuarea,payment,bbj,sj,yixianmianji ,room,csdate)";
		sq4=sq4+" values('"+section+"','"+cusSerial+"','"+in1+"','"+in2+"',"+in3+"";
	    sq4=sq4+",'"+custype+"','"+gmyt+"','"+tj+"','"+in5+"','"+in4+"','"+in7+"','"+in8+"','"+date+"','"+seller+"','";
        sq4=sq4+company+"','"+visitnum+"','"+visittj+"','"+mail+"','"+attention+"','"+in9+"'";
		sq4=sq4+",'"+job+"','"+wh+"','"+jtsr+"',"+personnum+",'"+region+"','"+contactPerson + "','"+nexus+"',"+chishu+",'"+homejg+"','"+visitname+"','"+nowjuarea+"','"+in12 + "' , '" + bbj + "' , '" + in6 + "','"+in10+"','"+in17+"','"+csdate+"')";
	  iBean.executeUpdate( sq4 ) ;
     
	 
	   
		   sql="select  CodeValue,code from CustomerDcValue";
		   cusRs=iBean.executeQuery(sql);
		   while (cusRs.next()){
		     String CodeValue=getbyte1(request.getParameter("codcename"+cusRs.getString("code")));
			 
			 if (!CodeValue.equals("")){
		        sql="insert into customer_xq(customer,xq_code) values("+cus_code+","+CodeValue+")";
				cBean.executeUpdate(sql);
				 
			 }	
		   }
		   cusRs.close();
  }catch(Exception s){out.print(sq4);}
String addr1=(String)session.getAttribute("reportAddr");
%>
<input type=button name="pr" value="打印收据">&nbsp;<input type=button name="pr" value="打印诚意认购书" onclick="openwin('vipregs.jsp?cus_no=<%= cusSerial%>')">&nbsp;
<script lang=javascript>
  // if (confirm("是否打印收款收据？"))
 //open("<%=addr1+"printsksj13.rpt"%>","a");
    opener.window.document.form1.submit() ;
   window.close();
</script>
<%} %>
</body>
</html>
