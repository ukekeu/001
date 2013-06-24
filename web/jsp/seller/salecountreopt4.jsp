<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import="java.sql.*,common.*,java.lang.*,java.util.*" %>
<%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="FormatD" scope="session" class="FormatData.FormatData"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<jsp:useBean id="FormtD1" scope="page" class="test.BarChartDemo"/>  
<html>
 <link rel=stylesheet href="../class/mad.css" >
 <LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<head>
	<title>销售员业绩统计</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%	String dates=China.getParameter(request,"Date1");
	String dates1=China.getParameter(request,"Date2"); %>
<script>

function init(){
  var applet1=document.all.applet1;
  if(applet1){
	  var xtitle="";
	  var ytitle="面积(平方米)";
	   var pre="100";
	  var ylen=200*pre/100;	   
	  var xbetween=80*pre/100;
      var width=(5+1)*xbetween*6;
	  var height=40+ylen+80;
	  applet1.width=width;
	  applet1.height=height;
	  var xdate=frm.xdate.value;
	  var ydate=frm.ydate.value;
	   var ydate1=frm.ydate1.value;
	  var ydate2=frm.ydate2.value;
applet1.setParameter(xtitle,ytitle,xdate,ydate,ydate1,ydate2,ylen,xbetween);
	  applet1.repaint();
  }
 }
function checkSecNo(){
if (document.cus.Date1.value=="")
{
 
  alert("请选择起始日期");
  return false;
 }
 if (document.cus.Date2.value=="")
{
 
  alert("请选择结束日期");
  return false;
 }
 if (document.cus.SecNo.value==""){
 
  alert("请选择楼盘");
  return false;
 }
document.cus.submit();
}
</script>
<body topmargin="0">
 
   <form name=cus>
  
   
   
    <% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="1";	
 
    %>
   <table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=1;document.cus.action='../sale/seller.jsp';document.cus.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>业绩明细表</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.cus.sel.value=2;document.cus.action='../seller/salecountreopt4.jsp';document.cus.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>业绩统计图表</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.cus.sel.value=3;document.cus.action='../finance/yjjsb.jsp';document.cus.submit();"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>佣金结算</font></a>
	</td>
   </tr>
 <input type=hidden name=sel value="<%=sel%>">
</table>
     <p align="center"><b><font size="3" class=FontColor>销售员业绩统计表</font></b>
  </p>
<DIV align=center id="printdiv">
	    <table width="100%" cellspacing="1" cellpadding>
                    <tr>
                      <td width="50%" bgcolor="#EAEAEA" align="center">开始日期：
					<input title="请选择认购日期" size="10" name="Date1"><input title="请选择开始日期" onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale">
                   
                    结束日期：
					 <input  title="请选择认购日期" size="10" name="Date2"><input title="请选择开始日期" onclick="fPopUpCalendarDlg(Date2);return false;" type="button" value=".." name="cale"></b></font>
                    
                    选择楼盘:&nbsp;
					  <%@ include file="../public_js/CheckSection.jsp"%>
					  <%
      String sql1="select SerialNo,Name from CRM_Project "+FindWhere;
					   ResultSet rs2=bBean.executeQuery(sql1);
	                    String sec="";
	                    String no=""; %>
<select name="SecNo"  style="width=100;">
					      <option value=""></option>
						  <%while (rs2.next()){
	                          no=rs2.getString("SerialNo");
	                          sec=getbyte(rs2.getString("Name"));
     	                      out.print("<option value='"+no+"-"+sec+"'>"+sec+"</option>");
	                         }
	                        rs2.close();
	                        String Sql = "" ;
                              %> 
							</select> <input type=button name=submit1 value="统 计" onclick="checkSecNo();"> &nbsp;<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
							</td>
					</tr>
					
				</table> 
				</div>
				
<% 

 java.util.Date curDate=new java.util.Date();
	int CurYear=curDate.getYear()+1900;
	int CurMonth=curDate.getMonth()+1;
	int CurDay=curDate.getDate();

	String SecNo1=China.getParameter(request,"SecNo");
	if (SecNo1.equals("")){out.print("<br><br>请选择统计条件");return;}
	
	String secnames="";
	if (SecNo1.indexOf("-")>=0){
	secnames=SecNo1.substring(SecNo1.indexOf("-")+1,SecNo1.length());
	SecNo1=SecNo1.substring(0,SecNo1.indexOf("-"));
	}
	
	String Loft=China.getParameter(request,"Loft");
	String WhereSQL="";
	if(!SecNo1.equals(""))
	  WhereSQL +=" and section='"+SecNo1+"' ";
	String WhereSQL1=WhereSQL+" and substring(convert(char(24),date,120),1,10)>='"+dates+"' and  substring(convert(char(24),date,120),1,10)<='"+dates1+"'";
	String WhereSQL2=WhereSQL+" and substring(convert(char(24),visadate,120),1,10)>='"+dates+"' and  substring(convert(char(24),visadate,120),1,10)<='"+dates1+"'";
	String sdate="";
	String edate="";
	String whereDate="";	
  
   %> 
 <br>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr align="center">
    <td colspan="10"><font size="4"><b><%=secnames %>销售员成交面积情况表</b></font></td>
  </tr>
</table>

<table width="95%" border="0" cellspacing="0" cellpadding="0">
 
   <tr><td><%="从"+dates+"到"+dates1 %></td>
    <td align=right class="font8">制表日期：<%=CurYear+"年"+CurMonth+"月"+CurDay+"日"%></td>
  </tr> 
 </table>
 
	<%
	int num=0;
	List list1=new LinkedList();//存放销售员
	String sql="select * from seller where section_no='"+SecNo1+"'" ;
  ResultSet rs=aBean.executeQuery(sql);
  while(rs.next()){
     String codename=getbyte(rs.getString("seller"));
     list1.add(codename);
	 num++;
	 
  }
  rs.close();	
 
	
	  float area=0;
	  float totalarea=0;
	List list2=new LinkedList();//实际销售员及销售面积
 
	 
	
	
	 %>
	 
	<%
	 String ydatestr1="";//计划完成
	 String ydatestr2="";//实计完成(认购)
 	 String ydatestr3="";//实计完成(签约)
	 String xdatestr="";//所有年月
	 
	
	  ResultSet rss=null;
	  float sumarea=0;
	   bBean.executeUpdate("delete  sellersalecheck where section='"+SecNo1+"'");
	 
	  for (int j=0;j<num;j++){
	  bBean.executeUpdate("insert into sellersalecheck(section,seller) values('"+SecNo1+"','"+(String)list1.get(j)+"')");
	  
	   String sqls="select sum(jzarea) as area from order_contract where state=1 and section='"+SecNo1+"'   and convert(char(10),date,120)>='"+dates+"' and convert(char(10),date,120)<='"+dates1+"'  and seller like '%"+(String)list1.get(j)+"%'";
//and  substring(convert(char(24),date,120),1,10)<='"+dates1+"'
	   rss=bBean.executeQuery(sqls);
	 while(rss.next()){
	     float aa=rss.getFloat("area");
		 aBean.executeUpdate("update sellersalecheck set yg="+String.valueOf(aa) +" where section='"+SecNo1+"' and  seller='"+(String)list1.get(j)+"'");
		 
		  area+=aa;
		sumarea+=aa;
	 }
	 	
	 if (!ydatestr3.equals(""))
	 ydatestr3+=","+String.valueOf(area);
	 else
	 ydatestr3=String.valueOf(area);
	  
	 rss.close();
	 
		
	}
	%>
		  

	<%
	
	  area=0;
	//area=area/200;
	for (int j=0;j<num;j++){
	
	   String sqls="select sum(jzarea) as area from order_contract where state=2 and section='"+SecNo1+"' and convert(char(10),date,120)>='"+dates+"' and convert(char(10),date,120)<='"+dates1+"'   and seller like '%"+(String)list1.get(j)+"%'";
  
	   rss=bBean.executeQuery(sqls);
	 while(rss.next()){
	     float aa=rss.getFloat("area");
		  aBean.executeUpdate("update sellersalecheck set qy="+String.valueOf(aa) +" where section='"+SecNo1+"' and  seller='"+(String)list1.get(j)+"'");
		 
	    area+=aa;
		sumarea+=aa;
	 }
	 	
	 if (!ydatestr2.equals(""))
	 ydatestr2+=","+String.valueOf(area);
	 else
	 ydatestr2=String.valueOf(area);
	 rss.close();
	  
		
	}
%>
	 
	 
    <%
	
	for (int j=0;j<num;j++){
	 if (!xdatestr.equals(""))
	    xdatestr+=","+(String)list1.get(j);
	  else
	    xdatestr=(String)list1.get(j)	;
	   String sqls="select sum(perarea) as area from salervalue where seller='"+(String)list1.get(j)+"'";
	   rss=bBean.executeQuery(sqls);
	   area=0;
	 while(rss.next()){
	    area=rss.getFloat("area");
	  
		 } rss.close();
		  if (!ydatestr1.equals(""))
	 ydatestr1+=","+String.valueOf(area);
	 else
	 ydatestr1=String.valueOf(area);
	}
	
	
	String SQL="select seller,sum(yg),sum(qy) from sellersalecheck where   section='"+SecNo1+"' group by seller";
	Calendar calendar = Calendar.getInstance();
  String filename = String.valueOf(calendar.getTimeInMillis());	
	 %>
	
	 
   <%String pic1=FormtD1.main1("D:/zlcrm/crmv9/jsp/picture/yjfx"+filename+".jpg"," ","面积","销售人员业绩对比分析",SQL,2,"认购","签约","","");
  %>
 
 <table width="100%" border="0"><tr><td align="center">
    <%if (!pic1.equals("")){%>
	<img src="../picture/<%=pic1%>">
	<%}%>
  
 
  </td></tr></table>
  
</body>
</html>
