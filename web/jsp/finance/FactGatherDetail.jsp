<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>实收款情况明细表核对表</title>
</head> 
<script language="javascript" src="../public_js/basal.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>

<%
String fCusName = getbyte1( request.getParameter( "fCusName" ) ) ;
String Search=request.getParameter("Search");
String para_D=request.getParameter("D");
String para_qs=request.getParameter("para2");
String para_cusno="";
String sqlpara="";
String checkedStr="";
String checkedStr1="";
String checkedStr2="";

String cbdate="";
String cedate="";
cedate = China.getParameter(request, "cedate" ) ;
cbdate = China.getParameter(request,"cbdate" ) ;

int i=0;
String shouldMoney=request.getParameter("shouldMoney");

String shouldDate=request.getParameter("shouldDate");
if (shouldDate==null)shouldDate="";
if (para_qs!=null){
    String para_qs1=para_qs.substring(0,para_qs.indexOf("*"));
    para_cusno=para_qs.substring(para_qs.indexOf("*")+1);
	if (para_D.equals("M")){
      sqlpara="update GatheringRecord set shouldMoney="+shouldMoney+" where cusno='"+para_cusno+"' and shouldQS='"+para_qs1+"'";
	}else{
      sqlpara="update GatheringRecord set shouldDate='"+shouldDate+"' where cusno='"+para_cusno+"' and shouldQS='"+para_qs1+"'";
	}  
	
 try{ 
   ViewBean.executeUpdate(sqlpara);
   }catch(Exception es){out.print("可能你输入的数据不对");}
}
String SectionNameS="";
String SectionNa="";
String chooseyn="";
chooseyn=request.getParameter("chooseyn");
if (chooseyn==null)chooseyn="";
if (chooseyn.equals("Y")){chooseyn="Y";checkedStr="checked";checkedStr1="";checkedStr2="";}
else if (chooseyn.equals("N")){checkedStr1="checked";checkedStr="";checkedStr2="";}
else {checkedStr2="checked";checkedStr="";checkedStr1="";}
if (chooseyn.equals("Y"))chooseyn=" and not gather_date is null";
else if (chooseyn.equals("N")) chooseyn="  and gather_date is null";
else  chooseyn="";
SectionNameS=request.getParameter("SecNo");
String StrWhere="";
if (!SectionNameS.equals(""))
 	StrWhere="   secno='"+SectionNameS+"'";
	
String BuildingS="";
BuildingS=request.getParameter("Build");
if(BuildingS==null)	BuildingS="";
if (Search!=null)
BuildingS=new String(BuildingS.getBytes("ISO8859_1"),"GBK");

String Loft="";
Loft=request.getParameter("Loft");
if (Search!=null)
Loft=new String(Loft.getBytes("ISO8859_1"),"GBK");
else
  Loft=getbyte2(Loft);
if (!Loft.equals(""))
  StrWhere+=" and loft='"+Loft+"'";
String RoomS="";
RoomS=getbyte1(request.getParameter("Room"));
if(RoomS==null){
	RoomS="";
}
if (!RoomS.equals(""))
  StrWhere+=" and abs(convert(int,Room))="+RoomS;
  
String BeginYearS="";
BeginYearS=request.getParameter("BeginYear");
if (BeginYearS==null)BeginYearS="";
String BeginMonthS="";
BeginMonthS=request.getParameter("BeginMonth");
if (BeginMonthS==null)BeginMonthS="";
String BeginDayS="";
BeginDayS=request.getParameter("BeginDay");
if (BeginDayS==null)BeginDayS="";
%>


<script language="JavaScript">
 function LoadF(){
 setSelectMad(document.cus.BeginYear,'<%= BeginYearS %>');
 setSelectMad(document.cus.BeginMonth,'<%= BeginMonthS %>');
 setSelectMad(document.cus.BeginDay,'<%= BeginDayS %>');
  
 }
 	
	function checkyh(){
	 
	 
	 if (getseldocs2()==""){alert("请选择核实的项");return false;}
	   if (confirm("确认通过核实？"))
	   openwin("cq_check.jsp?codes="+getseldocs2(),500,200,100,100);
	 
	 }
   	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=cus.elements.length;
     for (i=0;i<cus.elements.length;i++) {
       if ((cus.elements[i].type=="checkbox")&&(cus.elements[i].checked))
		 { 
		    seldocs[x]=cus.elements[i].value ;
			x++;
   		 }
	  }	

   return seldocs ;
}
</script>
<body oncontextmenu="return false">

 
 <div id=titl align=center><b><font size="3" color="#000080">
<%=SectionNa %>  实收款情况明细表
 
 </font></b></div>

  <form method="POST" name="cus" action="">
  <table border="0" width="110%">
    <tr bgcolor="#EAEAEA">

    <td>
 <input type=hidden  name=SecNo value="<%=SectionNameS %>">
 <input type=hidden name=Build value="<%=BuildingS %>">
 <input type=hidden name=Loft value="<%=Loft %>">
 <input type=hidden name=secname value="">
 <input type=hidden name=cusname value="">
 <%if(!Loft.equals("")){ %>
        房号:
        <input type=text size=4 name=Room value="<%=RoomS%>">
 <%}else{ %>
        <input type=hidden size=4 name=Room value="<%=RoomS%>">
 <%} %>
        客户姓名:
        <input type=text size=4 name=fCusName value="<%= fCusName%>">
        应收款日期:从<input type=input name=cbdate size=10 readonly value="<%=cbdate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cbdate);return false;">到<input type=input name=cedate size=10 readonly value="<%=cedate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cedate);return false;">
        <input type=submit name=find value="查询">   
		&nbsp;	&nbsp;	&nbsp;	&nbsp;  <input type=button name=check value="核 实" onclick="checkyh();">   
		<input type=hidden name=Input value="">
      </td>

   

  </tr>
  
</table>


    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    

    <tr class=listtitle>
  <td  > 
        <div align="center"><font color="#FFFFFF">序号</font></div>
      </td>
      <td  >
        <div align="center"><font color="#FFFFFF">房号</font></div>
      </td>	

      <td  > 
        <div align="center"><font color="#FFFFFF">客户姓名</font></div>
      </td>

      <td  > 
        <div align="center"><font color="#FFFFFF">联系电话</font></div>
      </td>

      <td  > 
        <div align="center"><font color="#FFFFFF">付款名称</font></div>
      </td>

      <td  > 
        <div align="center"><font color="#FFFFFF">首期款</font></div>
      </td>

      <td  > 
        <div align="center"><font color="#FFFFFF">按揭款(放款日期)</font></div>
      </td>
       <td  > 
        <div align="center"><font color="#FFFFFF">已收款</font></div>
      </td>
      <td  > 
        <div align="center"><font color="#FFFFFF">状态</font></div>
      </td>
    </tr>
    <%
String sql="";

//设置分页用的变量及分页条件计算
String FindCon=(String)request.getParameter("condtion");
	if (FindCon!=null){
    	FindCon=" = "+FindCon;
    	}
    else{
	   FindCon="<>'2' ";
	 }  
	String condtion=FindCon;	
	
    String start="";
	int startnum=0;
    int pageSize=10;
    int pageno;
    String eof="false";
	
   String tmp=request.getParameter("pageno");
   if(tmp==null ||tmp.length()==0){
       pageno=1;
	   }
   else{
      pageno=Integer.parseInt(tmp);
	  }
   if (request.getParameter("startnum")!=null){
   	    start=" <"+request.getParameter("startnum");
	}
   else{
	 start=" >0";
	}
    int previous=pageno-1;
    int next=pageno+1;
	
	//设定查询

     
    if( cbdate != null && ! cbdate.equals( "" ) ) {
        cbdate =  cbdate;
    }
    if( cbdate == null ) {
        cbdate = "" ;
    }

    if( cedate != null && !cedate.equals( "" ) ) {
        cedate = cedate ;
    }

    if( cedate == null ) {
        cedate = "" ;
    }

    if( !cbdate.equals("") ) {
        StrWhere = StrWhere + "and replace(shouldDate,'/','-')  >= '" + cbdate + "' " ;
    }
    if( !cedate.equals("") ) {
        StrWhere = StrWhere + "and replace(shouldDate,'/','-')  <= '" + cedate + "' " ;
    }

    if( !fCusName.equals("") ) {
        StrWhere = StrWhere + "and signatory like '%" + fCusName.trim() + "%' " ;
    }

	if (StrWhere.length()>0) {
   		sql="select *,convert(char(24),getdate(),111) today from View_YsList where "+StrWhere+chooseyn+" order by sectionname,loft,floors,room,shouldQS ";
	}else{
		sql="select *,convert(char(24),getdate(),111) today   from View_YsList where "+chooseyn+" order by sectionname,loft,floors,room,shouldQS ";
       
	}
 //实收款记录
 //实收记录数
 
  String sql1="select count(*) as num from view_factmoney where section='"
          +SectionNameS+"' and loft='"+Loft+"' and building='"+BuildingS+"'";

       ResultSet rs=ViewBean.executeQuery(sql1);
   int num=0;
    if ( rs.next() ) {
        try {
            num = rs.getInt("num");
        }catch( Exception exp ) {
            ;
        }
    }
    rs.close();

   String sql2="select * from view_factmoney where section='"
          +SectionNameS+"' and loft='"+Loft+"' and building='"+BuildingS+"'";
    if (!RoomS.equals(""))	sql2+=" and  room_no='"+RoomS+"' ";
	   sql2+="order by customer,period ";

	String arrPeriod[]=new String[num];
	String arrDate[]=new String[num];
	String arrMoney[]=new String[num];
	String arrChecker[]=new String[num];
	String arrBillnum[]=new String[num];
	String arrBillType[]=new String[num];
	String arrReceiver[]=new String[num];
	String arrCusNo[]=new String[num];
	String arrCusName[]=new String[num];
    String arrPhone[]=new String[num];
	String arrContractno[]=new String[num];
	rs=ViewBean.executeQuery(sql2);
		
	num=0;
	while (rs.next()){
	  arrCusNo[num]=rs.getString("customer");
	  arrPeriod[num]=rs.getString("period");
      arrDate[num]=rs.getString("Gather_date");
	  arrMoney[num]=rs.getString("factmoney");
	  arrBillnum[num]=rs.getString("Bill_num");
  	  arrBillType[num]=getbyte(rs.getString("BillType"));
  	  arrReceiver[num]=getbyte(rs.getString("Receiver"));
	  arrCusName[num]=getbyte(rs.getString("signatory"));
	  arrPhone[num]=rs.getString("Phone");
	  arrContractno[num]=rs.getString("contractno");
	  
	  num++;
	}
	rs.close();

//设置查询结果的存放变量
int ID=0;
String StrNo1="";//实收款合同号
String StrNo="";//应收款合同号
String CusNo="";
String ShouldQS="";
String ShouldDate="";
double ShouldMoney=0;
double ShouldMoney1=0;
String Period="";
String GatherDate="";
String FactMoney="";
String BillNum="";
String Receiver="";
String CusName="";
String phone="";
String Building="";
String Room="";
int yschange=0;
int sschange=0;
String loft="";
String checkmoney="";
String today="";
String state="";
java.text.DecimalFormat MoneyFormat = new java.text.DecimalFormat("###,###,###.##");
 
 rs=ViewBean.executeQuery(sql);
  
 i=0;
 
int allShouldQS = 0 ;
int intShouldQS = 0 ;
boolean isDiffRoom = true ;
String room1 = "" ;
int xuhao = 0 ;
String payment = "" ;
int AjMoney = 0 ;
double RMBPrice = 0 ;
double jiaokuanjing = 0 ;
String stateOld = "0" ;
String jiaoQing = "" ;
String contactno = "" ;
double yj_money=0;
double summoney=0;
String sj="";
 
  try{		
while ( rs.next() ) {


   eof="true";
     i=i+1;
  //按FIELDS顺序一GET　VALUE
    String code=rs.getString("code");
    CusNo=rs.getString("cusno");
    ShouldQS=rs.getString("shouldQS"); 
    ShouldDate=rs.getString("shouldDate");
    ShouldMoney=rs.getDouble("shouldMoney");
     ShouldMoney1=ShouldMoney;

  
   Building=getbyte(rs.getString("Building"));
   Room=rs.getString("Room");
 loft=getbyte(rs.getString("loft"));
   Room = loft+Building+Room;
   if( Room.equals( room1 ) ) {
        isDiffRoom = false ;
   }else {
        isDiffRoom = true ;
   }
  
   
   room1 = Room ;
   
 
   StrNo1=getbyte(rs.getString("ContactNo"));
   state=getbyte(rs.getString("state"));

   ID=rs.getInt("id");
   CusName=getbyte(rs.getString("signatory"));
   phone=getbyte(rs.getString("Phone"));
   today=rs.getString("today");

    payment = getbyte( rs.getString("payment1") );
    AjMoney = rs.getInt( "AjMoney" ) ;
	String fk_date=getbyte( rs.getString("FkDate") );
	if (!fk_date.equals(""))fk_date=fk_date.substring(0,10);
    RMBPrice = rs.getDouble( "RMBPrice" ) ;
	sj=getbyte(rs.getString( "sj" )) ;
	boolean ch=rs.getBoolean("cq_check");
    jiaokuanjing = RMBPrice - AjMoney ;
    if (phone.equals(""))phone=sj;

   if( isDiffRoom ) {
        xuhao ++ ;
        String sqQing = " select sum(shouldMoney) shouldMoney,sum(yijiao) as yijiao from GatheringRecord where"
                        + " cusno = '" + CusNo + "' "
                        + " and contactno = '" + StrNo1 + "' " ;
						
        ResultSet rsQing = fBean.executeQuery( sqQing ) ;
       
        String stateQing = "" ;
        int allJiao = 0 ;
        int yiJiao = 0 ;
        int meiJiao = 0 ;
        if( rsQing.next() ) {
            summoney= rsQing.getDouble( "shouldMoney" ) ;
            yj_money = rsQing.getDouble( "yijiao" ) ;
         
        }
        rsQing.close() ;
       if (state.equals("0"))
        jiaoQing = "未交" ;
       else if (state.equals("1"))  jiaoQing = "交款中" ;

       else if (state.equals("2")) jiaoQing = "已交" ;
        

 %> 

      <%if (summoney>yj_money)
			{today="bgColor='#6CB69F' title='未交完'"; allShouldQS = allShouldQS  + intShouldQS ; }
		else
			{today=" title='已交完'";}%> 
    <tr onmouseover="mout(this);"   class=listcontent id=TR<%=i%>  title="双击鼠标，弹出窗口进行收款登记" align="center"  ondblclick="yingshi('<%= StrNo1 %>','<%= CusNo %>');"  onclick="setpara('<%=CusNo%>','<%=ShouldQS%>','<%=ShouldMoney1%>','<%=StrNo1 %>');changeclass1(this,'clickbg','listcontent');document.cus.Input.disabled=false;">    

			
     <!-- <a href="javascript:detail('<%=i %>')" > -->
      <td> <%= xuhao %> </td>
	  <td <%=today %>>  <%= Room%>  </td>
      <td> <%= Repalce(CusName,"/") %> </td>
      <td> <%= Repalce(phone,"/") %> </td>

      <td> <%= payment%> </td>
      <td> <%= FormatD.getFloat2(jiaokuanjing,2)%> </td>
      <td> <%=FormatD.getFloat( Float.parseFloat(String.valueOf(AjMoney)),2)%>
	  <%if (!fk_date.equals(""))out.print("<br>("+fk_date+")"); %>
	   </td>
      <td  ><%=FormatD.getFloat2(yj_money,2)%></td>
	  <td><%if (summoney<=yj_money){out.print("已交完");
	      if (!ch)    out.println("<input type=checkbox name=dd value="+code+">");
		  else out.print("<br><font color=red>已核实</font>");
		 }
	          else if (summoney>yj_money&&yj_money>0)out.print("未交完");
		  else out.print("未交");
		  %>
   
	 </td>
    
    </tr>

	
    <%
      }
   }
  rs.close();
 }catch(Exception ex){  out.print(ex.getMessage());}
 if (eof.equals("false")){
  out.print("</table>");
  out.print("此页没有数据（已到未页）");
  out.print("<a href='javascript:window.history.back(1)'>返回</a>");
 }
 


%> 
  </table>
</form>
 
 <script>
   var strpara1="";
    var strpara2=""
 var strpara3="";	
   function EditInto(){
		  if (confirm("真的要修改吗？")){
   	          if (strpara1==""){alert("请选择要修改的记录(只需单击列表中某行一次)");}
		       else{
                          var dd=prompt("请输入正确的应收款金额");
	
                       if (dd!=null&&dd!="")
						   window.location="FactGatherDetail.jsp?para2="+strpara2+"*"+strpara1+"&shouldMoney="+dd+"&D=M";
                      
                         }
			}
  		  }
	function EditD(){
		  if (confirm("真的要修改吗？")){
   	          if (strpara1==""){alert("请选择要修改的记录(只需单击列表中某行一次)");}
		       else{
                          var dd=prompt("请输入正确的应收款日期");
                           if (dd!=null&&dd!="")
						   window.location="FactGatherDetail.jsp?para2="+strpara2+"*"+strpara1+"&shouldDate="+dd+"&D=D";
                      
                         }
			}  
  		  }
  function CheckMoeny(frm,cusno,no){
    if (frm.checked){
	   if (confirm("确认记帐？记帐后数据不能再修改")){
	    openwin("CheckMoney.jsp?CusNo="+cusno+"&no="+no,20,10,10,10);
	   }
	 }
  }		  
  function Edit(cusno,no){
    openwin("FactGatherDataD.jsp?CusNo="+cusno+"&no="+no,300,300,100,100);	
  }		  

  function setpara(para1,para2,para3,para4){
    strpara1=para1;
    strpara2=para2;
    strpara3=para3;
	strpara4=para4;
	 
  }

  function yingshi( contractno , cusno ) {
    openwin("yingshi.jsp?contractno=" + contractno + "&cusno=" + cusno ,690,450,50,50);
  }    
</script>
</body>
</form>
</html>